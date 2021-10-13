//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/miHoYo/DLC/Common/AddLight" {
Properties {
_MainTex ("Albedo |RGB(base color) A (alpha)", 2D) = "white" { }
_MainMaps_ST ("Main Maps ST", Vector) = (1,1,0,0)
}
SubShader {
 Tags { "PerformanceChecks" = "False" "RenderType" = "Opaque" }
 Pass {
  Name "ADDLIGHT"
  Tags { "LIGHTMODE" = "FORWARDADD" "PerformanceChecks" = "False" "RenderType" = "Opaque" }
  ZWrite Off
  GpuProgramID 51985
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "POINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_3));
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _MainTex;
uniform highp float _AdditiveLightPower;
uniform highp float _AdditiveLightIntensity;
uniform highp vec4 _LightColor0;
uniform highp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec4 tex_2;
  lowp float atten_3;
  highp vec3 lightCoord_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = xlv_TEXCOORD1.xyz;
  lightCoord_4 = (unity_WorldToLight * tmpvar_5).xyz;
  highp float tmpvar_6;
  tmpvar_6 = texture2D (_LightTexture0, vec2(dot (lightCoord_4, lightCoord_4))).w;
  atten_3 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_2 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  tmpvar_8.xyz = (((
    ((_LightColor0.xyz * atten_3) * pow (clamp (dot (xlv_TEXCOORD2, 
      normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1.xyz))
    ), 0.0, 1.0), _AdditiveLightPower))
   * _AdditiveLightIntensity) * tex_2.xyz) * _Color.w);
  tmpvar_1 = tmpvar_8;
  gl_FragData[0] = tmpvar_1;
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
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_3));
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _MainTex;
uniform highp float _AdditiveLightPower;
uniform highp float _AdditiveLightIntensity;
uniform highp vec4 _LightColor0;
uniform highp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec4 tex_2;
  lowp float atten_3;
  highp vec3 lightCoord_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = xlv_TEXCOORD1.xyz;
  lightCoord_4 = (unity_WorldToLight * tmpvar_5).xyz;
  highp float tmpvar_6;
  tmpvar_6 = texture2D (_LightTexture0, vec2(dot (lightCoord_4, lightCoord_4))).w;
  atten_3 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_2 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  tmpvar_8.xyz = (((
    ((_LightColor0.xyz * atten_3) * pow (clamp (dot (xlv_TEXCOORD2, 
      normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1.xyz))
    ), 0.0, 1.0), _AdditiveLightPower))
   * _AdditiveLightIntensity) * tex_2.xyz) * _Color.w);
  tmpvar_1 = tmpvar_8;
  gl_FragData[0] = tmpvar_1;
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
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_3));
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _MainTex;
uniform highp float _AdditiveLightPower;
uniform highp float _AdditiveLightIntensity;
uniform highp vec4 _LightColor0;
uniform highp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec4 tex_2;
  lowp float atten_3;
  highp vec3 lightCoord_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = xlv_TEXCOORD1.xyz;
  lightCoord_4 = (unity_WorldToLight * tmpvar_5).xyz;
  highp float tmpvar_6;
  tmpvar_6 = texture2D (_LightTexture0, vec2(dot (lightCoord_4, lightCoord_4))).w;
  atten_3 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_2 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  tmpvar_8.xyz = (((
    ((_LightColor0.xyz * atten_3) * pow (clamp (dot (xlv_TEXCOORD2, 
      normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1.xyz))
    ), 0.0, 1.0), _AdditiveLightPower))
   * _AdditiveLightIntensity) * tex_2.xyz) * _Color.w);
  tmpvar_1 = tmpvar_8;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_3));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform sampler2D _MainTex;
uniform highp float _AdditiveLightPower;
uniform highp float _AdditiveLightIntensity;
uniform highp vec4 _LightColor0;
uniform highp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec4 tex_2;
  highp vec3 lightDirection_3;
  lightDirection_3 = _WorldSpaceLightPos0.xyz;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = (((
    (_LightColor0.xyz * pow (clamp (dot (xlv_TEXCOORD2, lightDirection_3), 0.0, 1.0), _AdditiveLightPower))
   * _AdditiveLightIntensity) * tex_2.xyz) * _Color.w);
  tmpvar_1 = tmpvar_5;
  gl_FragData[0] = tmpvar_1;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_3));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform sampler2D _MainTex;
uniform highp float _AdditiveLightPower;
uniform highp float _AdditiveLightIntensity;
uniform highp vec4 _LightColor0;
uniform highp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec4 tex_2;
  highp vec3 lightDirection_3;
  lightDirection_3 = _WorldSpaceLightPos0.xyz;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = (((
    (_LightColor0.xyz * pow (clamp (dot (xlv_TEXCOORD2, lightDirection_3), 0.0, 1.0), _AdditiveLightPower))
   * _AdditiveLightIntensity) * tex_2.xyz) * _Color.w);
  tmpvar_1 = tmpvar_5;
  gl_FragData[0] = tmpvar_1;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_3));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform sampler2D _MainTex;
uniform highp float _AdditiveLightPower;
uniform highp float _AdditiveLightIntensity;
uniform highp vec4 _LightColor0;
uniform highp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec4 tex_2;
  highp vec3 lightDirection_3;
  lightDirection_3 = _WorldSpaceLightPos0.xyz;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = (((
    (_LightColor0.xyz * pow (clamp (dot (xlv_TEXCOORD2, lightDirection_3), 0.0, 1.0), _AdditiveLightPower))
   * _AdditiveLightIntensity) * tex_2.xyz) * _Color.w);
  tmpvar_1 = tmpvar_5;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SPOT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_3));
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform highp sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform highp float _AdditiveLightPower;
uniform highp float _AdditiveLightIntensity;
uniform highp vec4 _LightColor0;
uniform highp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec4 tex_2;
  lowp float atten_3;
  highp vec4 lightCoord_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = xlv_TEXCOORD1.xyz;
  lightCoord_4 = (unity_WorldToLight * tmpvar_5);
  lowp float tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_LightTexture0, ((lightCoord_4.xy / lightCoord_4.w) + 0.5));
  tmpvar_6 = tmpvar_7.w;
  lowp float tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_LightTextureB0, vec2(dot (lightCoord_4.xyz, lightCoord_4.xyz)));
  tmpvar_8 = tmpvar_9.w;
  highp float tmpvar_10;
  tmpvar_10 = ((float(
    (lightCoord_4.z > 0.0)
  ) * tmpvar_6) * tmpvar_8);
  atten_3 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_2 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = (((
    ((_LightColor0.xyz * atten_3) * pow (clamp (dot (xlv_TEXCOORD2, 
      normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1.xyz))
    ), 0.0, 1.0), _AdditiveLightPower))
   * _AdditiveLightIntensity) * tex_2.xyz) * _Color.w);
  tmpvar_1 = tmpvar_12;
  gl_FragData[0] = tmpvar_1;
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
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_3));
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform highp sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform highp float _AdditiveLightPower;
uniform highp float _AdditiveLightIntensity;
uniform highp vec4 _LightColor0;
uniform highp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec4 tex_2;
  lowp float atten_3;
  highp vec4 lightCoord_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = xlv_TEXCOORD1.xyz;
  lightCoord_4 = (unity_WorldToLight * tmpvar_5);
  lowp float tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_LightTexture0, ((lightCoord_4.xy / lightCoord_4.w) + 0.5));
  tmpvar_6 = tmpvar_7.w;
  lowp float tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_LightTextureB0, vec2(dot (lightCoord_4.xyz, lightCoord_4.xyz)));
  tmpvar_8 = tmpvar_9.w;
  highp float tmpvar_10;
  tmpvar_10 = ((float(
    (lightCoord_4.z > 0.0)
  ) * tmpvar_6) * tmpvar_8);
  atten_3 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_2 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = (((
    ((_LightColor0.xyz * atten_3) * pow (clamp (dot (xlv_TEXCOORD2, 
      normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1.xyz))
    ), 0.0, 1.0), _AdditiveLightPower))
   * _AdditiveLightIntensity) * tex_2.xyz) * _Color.w);
  tmpvar_1 = tmpvar_12;
  gl_FragData[0] = tmpvar_1;
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
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_3));
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform highp sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform highp float _AdditiveLightPower;
uniform highp float _AdditiveLightIntensity;
uniform highp vec4 _LightColor0;
uniform highp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec4 tex_2;
  lowp float atten_3;
  highp vec4 lightCoord_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = xlv_TEXCOORD1.xyz;
  lightCoord_4 = (unity_WorldToLight * tmpvar_5);
  lowp float tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_LightTexture0, ((lightCoord_4.xy / lightCoord_4.w) + 0.5));
  tmpvar_6 = tmpvar_7.w;
  lowp float tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_LightTextureB0, vec2(dot (lightCoord_4.xyz, lightCoord_4.xyz)));
  tmpvar_8 = tmpvar_9.w;
  highp float tmpvar_10;
  tmpvar_10 = ((float(
    (lightCoord_4.z > 0.0)
  ) * tmpvar_6) * tmpvar_8);
  atten_3 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_2 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = (((
    ((_LightColor0.xyz * atten_3) * pow (clamp (dot (xlv_TEXCOORD2, 
      normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1.xyz))
    ), 0.0, 1.0), _AdditiveLightPower))
   * _AdditiveLightIntensity) * tex_2.xyz) * _Color.w);
  tmpvar_1 = tmpvar_12;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "POINT_COOKIE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_3));
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp samplerCube _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform highp sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform highp float _AdditiveLightPower;
uniform highp float _AdditiveLightIntensity;
uniform highp vec4 _LightColor0;
uniform highp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec4 tex_2;
  lowp float atten_3;
  highp vec3 lightCoord_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = xlv_TEXCOORD1.xyz;
  lightCoord_4 = (unity_WorldToLight * tmpvar_5).xyz;
  highp float tmpvar_6;
  tmpvar_6 = (texture2D (_LightTextureB0, vec2(dot (lightCoord_4, lightCoord_4))).w * textureCube (_LightTexture0, lightCoord_4).w);
  atten_3 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_2 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  tmpvar_8.xyz = (((
    ((_LightColor0.xyz * atten_3) * pow (clamp (dot (xlv_TEXCOORD2, 
      normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1.xyz))
    ), 0.0, 1.0), _AdditiveLightPower))
   * _AdditiveLightIntensity) * tex_2.xyz) * _Color.w);
  tmpvar_1 = tmpvar_8;
  gl_FragData[0] = tmpvar_1;
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
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_3));
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp samplerCube _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform highp sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform highp float _AdditiveLightPower;
uniform highp float _AdditiveLightIntensity;
uniform highp vec4 _LightColor0;
uniform highp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec4 tex_2;
  lowp float atten_3;
  highp vec3 lightCoord_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = xlv_TEXCOORD1.xyz;
  lightCoord_4 = (unity_WorldToLight * tmpvar_5).xyz;
  highp float tmpvar_6;
  tmpvar_6 = (texture2D (_LightTextureB0, vec2(dot (lightCoord_4, lightCoord_4))).w * textureCube (_LightTexture0, lightCoord_4).w);
  atten_3 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_2 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  tmpvar_8.xyz = (((
    ((_LightColor0.xyz * atten_3) * pow (clamp (dot (xlv_TEXCOORD2, 
      normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1.xyz))
    ), 0.0, 1.0), _AdditiveLightPower))
   * _AdditiveLightIntensity) * tex_2.xyz) * _Color.w);
  tmpvar_1 = tmpvar_8;
  gl_FragData[0] = tmpvar_1;
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
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_3));
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp samplerCube _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform highp sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform highp float _AdditiveLightPower;
uniform highp float _AdditiveLightIntensity;
uniform highp vec4 _LightColor0;
uniform highp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec4 tex_2;
  lowp float atten_3;
  highp vec3 lightCoord_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = xlv_TEXCOORD1.xyz;
  lightCoord_4 = (unity_WorldToLight * tmpvar_5).xyz;
  highp float tmpvar_6;
  tmpvar_6 = (texture2D (_LightTextureB0, vec2(dot (lightCoord_4, lightCoord_4))).w * textureCube (_LightTexture0, lightCoord_4).w);
  atten_3 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_2 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  tmpvar_8.xyz = (((
    ((_LightColor0.xyz * atten_3) * pow (clamp (dot (xlv_TEXCOORD2, 
      normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1.xyz))
    ), 0.0, 1.0), _AdditiveLightPower))
   * _AdditiveLightIntensity) * tex_2.xyz) * _Color.w);
  tmpvar_1 = tmpvar_8;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL_COOKIE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_3));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _MainTex;
uniform highp float _AdditiveLightPower;
uniform highp float _AdditiveLightIntensity;
uniform highp vec4 _LightColor0;
uniform highp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec4 tex_2;
  lowp float atten_3;
  highp vec3 lightDirection_4;
  lightDirection_4 = _WorldSpaceLightPos0.xyz;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = xlv_TEXCOORD1.xyz;
  highp float tmpvar_6;
  tmpvar_6 = texture2D (_LightTexture0, (unity_WorldToLight * tmpvar_5).xy).w;
  atten_3 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_2 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  tmpvar_8.xyz = (((
    ((_LightColor0.xyz * atten_3) * pow (clamp (dot (xlv_TEXCOORD2, lightDirection_4), 0.0, 1.0), _AdditiveLightPower))
   * _AdditiveLightIntensity) * tex_2.xyz) * _Color.w);
  tmpvar_1 = tmpvar_8;
  gl_FragData[0] = tmpvar_1;
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
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_3));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _MainTex;
uniform highp float _AdditiveLightPower;
uniform highp float _AdditiveLightIntensity;
uniform highp vec4 _LightColor0;
uniform highp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec4 tex_2;
  lowp float atten_3;
  highp vec3 lightDirection_4;
  lightDirection_4 = _WorldSpaceLightPos0.xyz;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = xlv_TEXCOORD1.xyz;
  highp float tmpvar_6;
  tmpvar_6 = texture2D (_LightTexture0, (unity_WorldToLight * tmpvar_5).xy).w;
  atten_3 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_2 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  tmpvar_8.xyz = (((
    ((_LightColor0.xyz * atten_3) * pow (clamp (dot (xlv_TEXCOORD2, lightDirection_4), 0.0, 1.0), _AdditiveLightPower))
   * _AdditiveLightIntensity) * tex_2.xyz) * _Color.w);
  tmpvar_1 = tmpvar_8;
  gl_FragData[0] = tmpvar_1;
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
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_3));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _MainTex;
uniform highp float _AdditiveLightPower;
uniform highp float _AdditiveLightIntensity;
uniform highp vec4 _LightColor0;
uniform highp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec4 tex_2;
  lowp float atten_3;
  highp vec3 lightDirection_4;
  lightDirection_4 = _WorldSpaceLightPos0.xyz;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = xlv_TEXCOORD1.xyz;
  highp float tmpvar_6;
  tmpvar_6 = texture2D (_LightTexture0, (unity_WorldToLight * tmpvar_5).xy).w;
  atten_3 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_2 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  tmpvar_8.xyz = (((
    ((_LightColor0.xyz * atten_3) * pow (clamp (dot (xlv_TEXCOORD2, lightDirection_4), 0.0, 1.0), _AdditiveLightPower))
   * _AdditiveLightIntensity) * tex_2.xyz) * _Color.w);
  tmpvar_1 = tmpvar_8;
  gl_FragData[0] = tmpvar_1;
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
}
}