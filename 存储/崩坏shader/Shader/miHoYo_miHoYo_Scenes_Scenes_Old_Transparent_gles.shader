//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/Transparent" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_Emission ("Emmisive Color", Color) = (0,0,0,0)
_MainTex ("Base (RGB) Trans. (Alpha)", 2D) = "white" { }
_FogTune ("Fog Tune", Range(0, 1)) = 1
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Geometry" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "LIGHTMODE" = "Vertex" "QUEUE" = "Geometry" "RenderType" = "Transparent" }
  GpuProgramID 11769
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform mediump vec4 _Color;
uniform mediump vec4 _Emission;
uniform highp vec4 _MainTex_ST;
uniform mediump float _FogTune;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesVertex.xyz;
  mediump vec4 color_2;
  mediump vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  color_2.xyz = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  color_2.w = 1.0;
  tmpvar_3 = clamp (color_2, 0.0, 1.0);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_1;
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * tmpvar_7).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * tmpvar_7).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  gl_Position = tmpvar_5;
  xlv_COLOR1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tex_1;
  mediump vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_1 = tmpvar_3;
  col_2.xyz = (tex_1 * xlv_COLOR0).xyz;
  col_2.xyz = (col_2 * 2.0).xyz;
  col_2.w = (tex_1.w * _Color.w);
  col_2.xyz = mix (col_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_2.w = clamp (col_2.w, 0.0, 1.0);
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform mediump vec4 _Color;
uniform mediump vec4 _Emission;
uniform highp vec4 _MainTex_ST;
uniform mediump float _FogTune;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesVertex.xyz;
  mediump vec4 color_2;
  mediump vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  color_2.xyz = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  color_2.w = 1.0;
  tmpvar_3 = clamp (color_2, 0.0, 1.0);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_1;
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * tmpvar_7).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * tmpvar_7).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  gl_Position = tmpvar_5;
  xlv_COLOR1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tex_1;
  mediump vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_1 = tmpvar_3;
  col_2.xyz = (tex_1 * xlv_COLOR0).xyz;
  col_2.xyz = (col_2 * 2.0).xyz;
  col_2.w = (tex_1.w * _Color.w);
  col_2.xyz = mix (col_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_2.w = clamp (col_2.w, 0.0, 1.0);
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform mediump vec4 _Color;
uniform mediump vec4 _Emission;
uniform highp vec4 _MainTex_ST;
uniform mediump float _FogTune;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesVertex.xyz;
  mediump vec4 color_2;
  mediump vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  color_2.xyz = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  color_2.w = 1.0;
  tmpvar_3 = clamp (color_2, 0.0, 1.0);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_1;
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * tmpvar_7).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * tmpvar_7).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  gl_Position = tmpvar_5;
  xlv_COLOR1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tex_1;
  mediump vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_1 = tmpvar_3;
  col_2.xyz = (tex_1 * xlv_COLOR0).xyz;
  col_2.xyz = (col_2 * 2.0).xyz;
  col_2.w = (tex_1.w * _Color.w);
  col_2.xyz = mix (col_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_2.w = clamp (col_2.w, 0.0, 1.0);
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform mediump vec4 _Color;
uniform mediump vec4 _Emission;
uniform highp vec4 _MainTex_ST;
uniform mediump float _FogTune;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesVertex.xyz;
  mediump vec4 color_2;
  mediump vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  color_2.xyz = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  color_2.w = 1.0;
  tmpvar_3 = clamp (color_2, 0.0, 1.0);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_1;
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * tmpvar_7).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * tmpvar_7).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  gl_Position = tmpvar_5;
  xlv_COLOR1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tex_1;
  mediump vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_1 = tmpvar_3;
  col_2.xyz = (tex_1 * xlv_COLOR0).xyz;
  col_2.xyz = (col_2 * 2.0).xyz;
  col_2.w = (tex_1.w * _Color.w);
  col_2.xyz = mix (col_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_2.w = clamp (col_2.w, 0.0, 1.0);
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform mediump vec4 _Color;
uniform mediump vec4 _Emission;
uniform highp vec4 _MainTex_ST;
uniform mediump float _FogTune;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesVertex.xyz;
  mediump vec4 color_2;
  mediump vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  color_2.xyz = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  color_2.w = 1.0;
  tmpvar_3 = clamp (color_2, 0.0, 1.0);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_1;
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * tmpvar_7).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * tmpvar_7).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  gl_Position = tmpvar_5;
  xlv_COLOR1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tex_1;
  mediump vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_1 = tmpvar_3;
  col_2.xyz = (tex_1 * xlv_COLOR0).xyz;
  col_2.xyz = (col_2 * 2.0).xyz;
  col_2.w = (tex_1.w * _Color.w);
  col_2.xyz = mix (col_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_2.w = clamp (col_2.w, 0.0, 1.0);
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform mediump vec4 _Color;
uniform mediump vec4 _Emission;
uniform highp vec4 _MainTex_ST;
uniform mediump float _FogTune;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesVertex.xyz;
  mediump vec4 color_2;
  mediump vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  color_2.xyz = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  color_2.w = 1.0;
  tmpvar_3 = clamp (color_2, 0.0, 1.0);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_1;
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * tmpvar_7).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * tmpvar_7).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  gl_Position = tmpvar_5;
  xlv_COLOR1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tex_1;
  mediump vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_1 = tmpvar_3;
  col_2.xyz = (tex_1 * xlv_COLOR0).xyz;
  col_2.xyz = (col_2 * 2.0).xyz;
  col_2.w = (tex_1.w * _Color.w);
  col_2.xyz = mix (col_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_2.w = clamp (col_2.w, 0.0, 1.0);
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform mediump vec4 _Color;
uniform mediump vec4 _Emission;
uniform highp vec4 _MainTex_ST;
uniform mediump float _FogTune;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesVertex.xyz;
  mediump vec4 color_2;
  mediump vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  color_2.xyz = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  color_2.w = 1.0;
  tmpvar_3 = clamp (color_2, 0.0, 1.0);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_1;
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * tmpvar_7).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * tmpvar_7).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  gl_Position = tmpvar_5;
  xlv_COLOR1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform mediump float _LumiFactor;
uniform sampler2D _MainTex;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tex_1;
  mediump vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_1 = tmpvar_3;
  col_2.xyz = (tex_1 * xlv_COLOR0).xyz;
  col_2.xyz = (col_2 * 2.0).xyz;
  col_2.w = (tex_1.w * _Color.w);
  col_2.xyz = mix (col_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_2.xyz = mix (col_2.xyz, vec3(dot (col_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  col_2.w = clamp (col_2.w, 0.0, 1.0);
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform mediump vec4 _Color;
uniform mediump vec4 _Emission;
uniform highp vec4 _MainTex_ST;
uniform mediump float _FogTune;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesVertex.xyz;
  mediump vec4 color_2;
  mediump vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  color_2.xyz = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  color_2.w = 1.0;
  tmpvar_3 = clamp (color_2, 0.0, 1.0);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_1;
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * tmpvar_7).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * tmpvar_7).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  gl_Position = tmpvar_5;
  xlv_COLOR1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform mediump float _LumiFactor;
uniform sampler2D _MainTex;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tex_1;
  mediump vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_1 = tmpvar_3;
  col_2.xyz = (tex_1 * xlv_COLOR0).xyz;
  col_2.xyz = (col_2 * 2.0).xyz;
  col_2.w = (tex_1.w * _Color.w);
  col_2.xyz = mix (col_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_2.xyz = mix (col_2.xyz, vec3(dot (col_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  col_2.w = clamp (col_2.w, 0.0, 1.0);
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform mediump vec4 _Color;
uniform mediump vec4 _Emission;
uniform highp vec4 _MainTex_ST;
uniform mediump float _FogTune;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesVertex.xyz;
  mediump vec4 color_2;
  mediump vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  color_2.xyz = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  color_2.w = 1.0;
  tmpvar_3 = clamp (color_2, 0.0, 1.0);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_1;
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * tmpvar_7).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * tmpvar_7).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  gl_Position = tmpvar_5;
  xlv_COLOR1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform mediump float _LumiFactor;
uniform sampler2D _MainTex;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tex_1;
  mediump vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_1 = tmpvar_3;
  col_2.xyz = (tex_1 * xlv_COLOR0).xyz;
  col_2.xyz = (col_2 * 2.0).xyz;
  col_2.w = (tex_1.w * _Color.w);
  col_2.xyz = mix (col_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_2.xyz = mix (col_2.xyz, vec3(dot (col_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  col_2.w = clamp (col_2.w, 0.0, 1.0);
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform mediump vec4 _Color;
uniform mediump vec4 _Emission;
uniform highp vec4 _MainTex_ST;
uniform mediump float _FogTune;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesVertex.xyz;
  mediump vec4 color_2;
  mediump vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  color_2.xyz = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  color_2.w = 1.0;
  tmpvar_3 = clamp (color_2, 0.0, 1.0);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_1;
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * tmpvar_7).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * tmpvar_7).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  gl_Position = tmpvar_5;
  xlv_COLOR1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform mediump float _LumiFactor;
uniform sampler2D _MainTex;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tex_1;
  mediump vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_1 = tmpvar_3;
  col_2.xyz = (tex_1 * xlv_COLOR0).xyz;
  col_2.xyz = (col_2 * 2.0).xyz;
  col_2.w = (tex_1.w * _Color.w);
  col_2.xyz = mix (col_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_2.xyz = mix (col_2.xyz, vec3(dot (col_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  col_2.w = clamp (col_2.w, 0.0, 1.0);
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform mediump vec4 _Color;
uniform mediump vec4 _Emission;
uniform highp vec4 _MainTex_ST;
uniform mediump float _FogTune;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesVertex.xyz;
  mediump vec4 color_2;
  mediump vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  color_2.xyz = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  color_2.w = 1.0;
  tmpvar_3 = clamp (color_2, 0.0, 1.0);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_1;
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * tmpvar_7).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * tmpvar_7).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  gl_Position = tmpvar_5;
  xlv_COLOR1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform mediump float _LumiFactor;
uniform sampler2D _MainTex;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tex_1;
  mediump vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_1 = tmpvar_3;
  col_2.xyz = (tex_1 * xlv_COLOR0).xyz;
  col_2.xyz = (col_2 * 2.0).xyz;
  col_2.w = (tex_1.w * _Color.w);
  col_2.xyz = mix (col_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_2.xyz = mix (col_2.xyz, vec3(dot (col_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  col_2.w = clamp (col_2.w, 0.0, 1.0);
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform mediump vec4 _Color;
uniform mediump vec4 _Emission;
uniform highp vec4 _MainTex_ST;
uniform mediump float _FogTune;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesVertex.xyz;
  mediump vec4 color_2;
  mediump vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  color_2.xyz = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  color_2.w = 1.0;
  tmpvar_3 = clamp (color_2, 0.0, 1.0);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_1;
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * tmpvar_7).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * tmpvar_7).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  gl_Position = tmpvar_5;
  xlv_COLOR1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform mediump float _LumiFactor;
uniform sampler2D _MainTex;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tex_1;
  mediump vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_1 = tmpvar_3;
  col_2.xyz = (tex_1 * xlv_COLOR0).xyz;
  col_2.xyz = (col_2 * 2.0).xyz;
  col_2.w = (tex_1.w * _Color.w);
  col_2.xyz = mix (col_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_2.xyz = mix (col_2.xyz, vec3(dot (col_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  col_2.w = clamp (col_2.w, 0.0, 1.0);
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
Keywords { "LUMINANCE" "FOG_LERP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" }
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
Keywords { "LUMINANCE" "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
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
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
""
}
}
}
}
}