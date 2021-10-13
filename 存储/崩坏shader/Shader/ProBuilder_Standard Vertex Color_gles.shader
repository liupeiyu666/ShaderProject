//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "ProBuilder/Standard Vertex Color" {
Properties {
_MainTex ("Base Color", 2D) = "white" { }
_Color ("Color", Color) = (1,1,1,1)
_Caustics ("Caustics Texture (RGBA)", 2D) = "white" { }
_CausticsCoord ("Tiling(XY) Offset(ZW) - Overrides texture coords", Vector) = (0.5,0.5,0,0)
_CausticsSpeed ("Speed", Float) = 1
_CausticsBoost ("Boost", Range(0, 1)) = 0
_CausticsIntensity0 ("Intensity A", Range(0, 1)) = 1
_CausticsIntensity1 ("Intensity B", Range(0, 1)) = 0
_CausticsPosition0 ("Position A (World Y)", Float) = 2
_CausticsPosition1 ("Position B (World Y)", Float) = 4
}
SubShader {
 LOD 200
 Tags { "DrawDepth" = "FrontFace" "RenderType" = "Opaque" }
 Pass {
  Name "FORWARD"
  LOD 200
  Tags { "DrawDepth" = "FrontFace" "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
  GpuProgramID 59486
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD3 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD3 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD3 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD3 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD3 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD3 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD7 = (unity_WorldToShadow[0] * tmpvar_7);
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD7 = (unity_WorldToShadow[0] * tmpvar_7);
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD7 = (unity_WorldToShadow[0] * tmpvar_7);
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD7 = (unity_WorldToShadow[0] * tmpvar_7);
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD7 = (unity_WorldToShadow[0] * tmpvar_7);
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD7 = (unity_WorldToShadow[0] * tmpvar_7);
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD3 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD3 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD3 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD3 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD3 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD3 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD7 = (unity_WorldToShadow[0] * tmpvar_7);
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD7 = (unity_WorldToShadow[0] * tmpvar_7);
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD7 = (unity_WorldToShadow[0] * tmpvar_7);
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD7 = (unity_WorldToShadow[0] * tmpvar_7);
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD7 = (unity_WorldToShadow[0] * tmpvar_7);
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD7 = (unity_WorldToShadow[0] * tmpvar_7);
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD3 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD3 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD3 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD3 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD3 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD3 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD7 = (unity_WorldToShadow[0] * tmpvar_7);
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD7 = (unity_WorldToShadow[0] * tmpvar_7);
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD7 = (unity_WorldToShadow[0] * tmpvar_7);
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD7 = (unity_WorldToShadow[0] * tmpvar_7);
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD7 = (unity_WorldToShadow[0] * tmpvar_7);
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD7 = (unity_WorldToShadow[0] * tmpvar_7);
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "VERTEXLIGHT_ON" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD3 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "VERTEXLIGHT_ON" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD3 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "VERTEXLIGHT_ON" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD3 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD3 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD3 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD3 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "VERTEXLIGHT_ON" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD7 = (unity_WorldToShadow[0] * tmpvar_7);
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "VERTEXLIGHT_ON" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD7 = (unity_WorldToShadow[0] * tmpvar_7);
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "VERTEXLIGHT_ON" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD7 = (unity_WorldToShadow[0] * tmpvar_7);
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD7 = (unity_WorldToShadow[0] * tmpvar_7);
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD7 = (unity_WorldToShadow[0] * tmpvar_7);
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD7 = (unity_WorldToShadow[0] * tmpvar_7);
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD3 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD3 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD3 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD3 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD3 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD3 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD7 = (unity_WorldToShadow[0] * tmpvar_7);
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD7 = (unity_WorldToShadow[0] * tmpvar_7);
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD7 = (unity_WorldToShadow[0] * tmpvar_7);
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD7 = (unity_WorldToShadow[0] * tmpvar_7);
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD7 = (unity_WorldToShadow[0] * tmpvar_7);
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD7 = (unity_WorldToShadow[0] * tmpvar_7);
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD3 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD3 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD3 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD3 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD3 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD3 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD7 = (unity_WorldToShadow[0] * tmpvar_7);
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD7 = (unity_WorldToShadow[0] * tmpvar_7);
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD7 = (unity_WorldToShadow[0] * tmpvar_7);
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD7 = (unity_WorldToShadow[0] * tmpvar_7);
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD7 = (unity_WorldToShadow[0] * tmpvar_7);
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = _glesMultiTexCoord2.xy;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = _glesTANGENT.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((unity_ObjectToWorld * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD7 = (unity_WorldToShadow[0] * tmpvar_7);
  xlv_TEXCOORD10 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 finalRGBA_2;
  highp vec4 _MainTex_var_3;
  highp vec3 lightDirection_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(_WorldSpaceLightPos0.xyz);
  lightDirection_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = texture2D (_MainTex, P_7);
  _MainTex_var_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (((_MainTex_var_3.xyz * _Color.xyz) * clamp (
    dot (normalize(xlv_TEXCOORD4), lightDirection_4)
  , 0.0, 1.0)) + (glstate_lightmodel_ambient * 2.0).xyz);
  finalRGBA_2 = tmpvar_8;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "DIRLIGHTMAP_SEPARATE" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
}
}
}
Fallback "Standard"
}