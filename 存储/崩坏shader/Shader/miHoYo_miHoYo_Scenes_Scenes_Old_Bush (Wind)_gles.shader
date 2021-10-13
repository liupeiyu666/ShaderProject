//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/Bush (Wind)" {
Properties {
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Base (RGB) Trans (A)", 2D) = "white" { }
_Cutoff ("Alpha cutoff", Range(0, 1)) = 0.5
_ExpandQuad ("Expand Quad", Float) = 1
}
SubShader {
 LOD 100
 Tags { "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
 Pass {
  LOD 100
  Tags { "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
  GpuProgramID 25561
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _miHoYo_Wind;
uniform highp vec3 _miHoYo_WindParams2;
uniform highp vec4 _MainTex_ST;
uniform mediump float _ExpandQuad;
uniform highp vec4 _miHoYo_CameraRight;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesVertex;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_5;
    highp vec3 tmpvar_6;
    tmpvar_6 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_7;
    tmpvar_7 = max (0.0, (sqrt(
      dot (tmpvar_6, tmpvar_6)
    ) - _FogStartDistance));
    highp float tmpvar_8;
    tmpvar_8 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_7)
      ) * (_FogIntensity * tmpvar_7))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
    ), 0.0, 1.0)));
    fogColor_5.xyz = tmpvar_9;
    fogColor_5.w = tmpvar_8;
    tmpvar_4 = fogColor_5;
  } else {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    highp float tmpvar_14;
    tmpvar_14 = (_FogEndDistance - _FogStartDistance);
    tmpvar_13 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
    , 0.0, 1.0))));
    fogColor_10.xyz = tmpvar_15;
    fogColor_10.w = tmpvar_13;
    tmpvar_4 = fogColor_10;
  };
  tmpvar_1 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_1 = (tmpvar_1 / tmpvar_1.w);
  if ((_ExpandQuad > 0.0)) {
    highp vec4 vert_16;
    vert_16.w = tmpvar_1.w;
    vert_16.xyz = (tmpvar_1.xyz - (_miHoYo_CameraRight.xyz * _glesMultiTexCoord1.x));
    vert_16.y = (vert_16.y + _glesMultiTexCoord1.y);
    highp vec4 vert_17;
    vert_17.w = vert_16.w;
    highp vec4 tmpvar_18;
    tmpvar_18 = abs(((
      fract((((
        fract((((_miHoYo_Wind.w + 
          (dot (tmpvar_1.xyz, vec3(1.0, 1.0, 1.0)) * 0.3)
        ) * _miHoYo_WindParams2.y) * vec4(1.975, 0.793, 0.375, 0.193)))
       * 2.0) - 1.0) + 0.5))
     * 2.0) - 1.0));
    vert_17.xyz = (vert_16.xyz + ((
      (_miHoYo_WindParams2.x * dot (((
        (tmpvar_18 * tmpvar_18)
       * 
        (3.0 - (2.0 * tmpvar_18))
      ) - 0.5), vec4(1.0, 1.0, 1.0, 1.0)))
     * _miHoYo_CameraRight.xyz) * float(
      ((vert_16.y - tmpvar_1.y) > 0.0)
    )));
    tmpvar_1 = vert_17;
  };
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * tmpvar_1);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR0 = tmpvar_2.xyz;
  xlv_COLOR1 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz * xlv_COLOR0);
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = _BloomFactor;
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _miHoYo_Wind;
uniform highp vec3 _miHoYo_WindParams2;
uniform highp vec4 _MainTex_ST;
uniform mediump float _ExpandQuad;
uniform highp vec4 _miHoYo_CameraRight;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesVertex;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_5;
    highp vec3 tmpvar_6;
    tmpvar_6 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_7;
    tmpvar_7 = max (0.0, (sqrt(
      dot (tmpvar_6, tmpvar_6)
    ) - _FogStartDistance));
    highp float tmpvar_8;
    tmpvar_8 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_7)
      ) * (_FogIntensity * tmpvar_7))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
    ), 0.0, 1.0)));
    fogColor_5.xyz = tmpvar_9;
    fogColor_5.w = tmpvar_8;
    tmpvar_4 = fogColor_5;
  } else {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    highp float tmpvar_14;
    tmpvar_14 = (_FogEndDistance - _FogStartDistance);
    tmpvar_13 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
    , 0.0, 1.0))));
    fogColor_10.xyz = tmpvar_15;
    fogColor_10.w = tmpvar_13;
    tmpvar_4 = fogColor_10;
  };
  tmpvar_1 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_1 = (tmpvar_1 / tmpvar_1.w);
  if ((_ExpandQuad > 0.0)) {
    highp vec4 vert_16;
    vert_16.w = tmpvar_1.w;
    vert_16.xyz = (tmpvar_1.xyz - (_miHoYo_CameraRight.xyz * _glesMultiTexCoord1.x));
    vert_16.y = (vert_16.y + _glesMultiTexCoord1.y);
    highp vec4 vert_17;
    vert_17.w = vert_16.w;
    highp vec4 tmpvar_18;
    tmpvar_18 = abs(((
      fract((((
        fract((((_miHoYo_Wind.w + 
          (dot (tmpvar_1.xyz, vec3(1.0, 1.0, 1.0)) * 0.3)
        ) * _miHoYo_WindParams2.y) * vec4(1.975, 0.793, 0.375, 0.193)))
       * 2.0) - 1.0) + 0.5))
     * 2.0) - 1.0));
    vert_17.xyz = (vert_16.xyz + ((
      (_miHoYo_WindParams2.x * dot (((
        (tmpvar_18 * tmpvar_18)
       * 
        (3.0 - (2.0 * tmpvar_18))
      ) - 0.5), vec4(1.0, 1.0, 1.0, 1.0)))
     * _miHoYo_CameraRight.xyz) * float(
      ((vert_16.y - tmpvar_1.y) > 0.0)
    )));
    tmpvar_1 = vert_17;
  };
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * tmpvar_1);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR0 = tmpvar_2.xyz;
  xlv_COLOR1 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz * xlv_COLOR0);
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = _BloomFactor;
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _miHoYo_Wind;
uniform highp vec3 _miHoYo_WindParams2;
uniform highp vec4 _MainTex_ST;
uniform mediump float _ExpandQuad;
uniform highp vec4 _miHoYo_CameraRight;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesVertex;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_5;
    highp vec3 tmpvar_6;
    tmpvar_6 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_7;
    tmpvar_7 = max (0.0, (sqrt(
      dot (tmpvar_6, tmpvar_6)
    ) - _FogStartDistance));
    highp float tmpvar_8;
    tmpvar_8 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_7)
      ) * (_FogIntensity * tmpvar_7))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
    ), 0.0, 1.0)));
    fogColor_5.xyz = tmpvar_9;
    fogColor_5.w = tmpvar_8;
    tmpvar_4 = fogColor_5;
  } else {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    highp float tmpvar_14;
    tmpvar_14 = (_FogEndDistance - _FogStartDistance);
    tmpvar_13 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
    , 0.0, 1.0))));
    fogColor_10.xyz = tmpvar_15;
    fogColor_10.w = tmpvar_13;
    tmpvar_4 = fogColor_10;
  };
  tmpvar_1 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_1 = (tmpvar_1 / tmpvar_1.w);
  if ((_ExpandQuad > 0.0)) {
    highp vec4 vert_16;
    vert_16.w = tmpvar_1.w;
    vert_16.xyz = (tmpvar_1.xyz - (_miHoYo_CameraRight.xyz * _glesMultiTexCoord1.x));
    vert_16.y = (vert_16.y + _glesMultiTexCoord1.y);
    highp vec4 vert_17;
    vert_17.w = vert_16.w;
    highp vec4 tmpvar_18;
    tmpvar_18 = abs(((
      fract((((
        fract((((_miHoYo_Wind.w + 
          (dot (tmpvar_1.xyz, vec3(1.0, 1.0, 1.0)) * 0.3)
        ) * _miHoYo_WindParams2.y) * vec4(1.975, 0.793, 0.375, 0.193)))
       * 2.0) - 1.0) + 0.5))
     * 2.0) - 1.0));
    vert_17.xyz = (vert_16.xyz + ((
      (_miHoYo_WindParams2.x * dot (((
        (tmpvar_18 * tmpvar_18)
       * 
        (3.0 - (2.0 * tmpvar_18))
      ) - 0.5), vec4(1.0, 1.0, 1.0, 1.0)))
     * _miHoYo_CameraRight.xyz) * float(
      ((vert_16.y - tmpvar_1.y) > 0.0)
    )));
    tmpvar_1 = vert_17;
  };
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * tmpvar_1);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR0 = tmpvar_2.xyz;
  xlv_COLOR1 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz * xlv_COLOR0);
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = _BloomFactor;
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _miHoYo_Wind;
uniform highp vec3 _miHoYo_WindParams2;
uniform highp vec4 _MainTex_ST;
uniform mediump float _ExpandQuad;
uniform highp vec4 _miHoYo_CameraRight;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesVertex;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_5;
    highp vec3 tmpvar_6;
    tmpvar_6 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_7;
    tmpvar_7 = max (0.0, (sqrt(
      dot (tmpvar_6, tmpvar_6)
    ) - _FogStartDistance));
    highp float tmpvar_8;
    tmpvar_8 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_7)
      ) * (_FogIntensity * tmpvar_7))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
    ), 0.0, 1.0)));
    fogColor_5.xyz = tmpvar_9;
    fogColor_5.w = tmpvar_8;
    tmpvar_4 = fogColor_5;
  } else {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    highp float tmpvar_14;
    tmpvar_14 = (_FogEndDistance - _FogStartDistance);
    tmpvar_13 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
    , 0.0, 1.0))));
    fogColor_10.xyz = tmpvar_15;
    fogColor_10.w = tmpvar_13;
    tmpvar_4 = fogColor_10;
  };
  tmpvar_1 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_1 = (tmpvar_1 / tmpvar_1.w);
  if ((_ExpandQuad > 0.0)) {
    highp vec4 vert_16;
    vert_16.w = tmpvar_1.w;
    vert_16.xyz = (tmpvar_1.xyz - (_miHoYo_CameraRight.xyz * _glesMultiTexCoord1.x));
    vert_16.y = (vert_16.y + _glesMultiTexCoord1.y);
    highp vec4 vert_17;
    vert_17.w = vert_16.w;
    highp vec4 tmpvar_18;
    tmpvar_18 = abs(((
      fract((((
        fract((((_miHoYo_Wind.w + 
          (dot (tmpvar_1.xyz, vec3(1.0, 1.0, 1.0)) * 0.3)
        ) * _miHoYo_WindParams2.y) * vec4(1.975, 0.793, 0.375, 0.193)))
       * 2.0) - 1.0) + 0.5))
     * 2.0) - 1.0));
    vert_17.xyz = (vert_16.xyz + ((
      (_miHoYo_WindParams2.x * dot (((
        (tmpvar_18 * tmpvar_18)
       * 
        (3.0 - (2.0 * tmpvar_18))
      ) - 0.5), vec4(1.0, 1.0, 1.0, 1.0)))
     * _miHoYo_CameraRight.xyz) * float(
      ((vert_16.y - tmpvar_1.y) > 0.0)
    )));
    tmpvar_1 = vert_17;
  };
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * tmpvar_1);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR0 = tmpvar_2.xyz;
  xlv_COLOR1 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz * xlv_COLOR0);
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = _BloomFactor;
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _miHoYo_Wind;
uniform highp vec3 _miHoYo_WindParams2;
uniform highp vec4 _MainTex_ST;
uniform mediump float _ExpandQuad;
uniform highp vec4 _miHoYo_CameraRight;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesVertex;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_5;
    highp vec3 tmpvar_6;
    tmpvar_6 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_7;
    tmpvar_7 = max (0.0, (sqrt(
      dot (tmpvar_6, tmpvar_6)
    ) - _FogStartDistance));
    highp float tmpvar_8;
    tmpvar_8 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_7)
      ) * (_FogIntensity * tmpvar_7))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
    ), 0.0, 1.0)));
    fogColor_5.xyz = tmpvar_9;
    fogColor_5.w = tmpvar_8;
    tmpvar_4 = fogColor_5;
  } else {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    highp float tmpvar_14;
    tmpvar_14 = (_FogEndDistance - _FogStartDistance);
    tmpvar_13 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
    , 0.0, 1.0))));
    fogColor_10.xyz = tmpvar_15;
    fogColor_10.w = tmpvar_13;
    tmpvar_4 = fogColor_10;
  };
  tmpvar_1 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_1 = (tmpvar_1 / tmpvar_1.w);
  if ((_ExpandQuad > 0.0)) {
    highp vec4 vert_16;
    vert_16.w = tmpvar_1.w;
    vert_16.xyz = (tmpvar_1.xyz - (_miHoYo_CameraRight.xyz * _glesMultiTexCoord1.x));
    vert_16.y = (vert_16.y + _glesMultiTexCoord1.y);
    highp vec4 vert_17;
    vert_17.w = vert_16.w;
    highp vec4 tmpvar_18;
    tmpvar_18 = abs(((
      fract((((
        fract((((_miHoYo_Wind.w + 
          (dot (tmpvar_1.xyz, vec3(1.0, 1.0, 1.0)) * 0.3)
        ) * _miHoYo_WindParams2.y) * vec4(1.975, 0.793, 0.375, 0.193)))
       * 2.0) - 1.0) + 0.5))
     * 2.0) - 1.0));
    vert_17.xyz = (vert_16.xyz + ((
      (_miHoYo_WindParams2.x * dot (((
        (tmpvar_18 * tmpvar_18)
       * 
        (3.0 - (2.0 * tmpvar_18))
      ) - 0.5), vec4(1.0, 1.0, 1.0, 1.0)))
     * _miHoYo_CameraRight.xyz) * float(
      ((vert_16.y - tmpvar_1.y) > 0.0)
    )));
    tmpvar_1 = vert_17;
  };
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * tmpvar_1);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR0 = tmpvar_2.xyz;
  xlv_COLOR1 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz * xlv_COLOR0);
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = _BloomFactor;
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _miHoYo_Wind;
uniform highp vec3 _miHoYo_WindParams2;
uniform highp vec4 _MainTex_ST;
uniform mediump float _ExpandQuad;
uniform highp vec4 _miHoYo_CameraRight;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesVertex;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_5;
    highp vec3 tmpvar_6;
    tmpvar_6 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_7;
    tmpvar_7 = max (0.0, (sqrt(
      dot (tmpvar_6, tmpvar_6)
    ) - _FogStartDistance));
    highp float tmpvar_8;
    tmpvar_8 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_7)
      ) * (_FogIntensity * tmpvar_7))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
    ), 0.0, 1.0)));
    fogColor_5.xyz = tmpvar_9;
    fogColor_5.w = tmpvar_8;
    tmpvar_4 = fogColor_5;
  } else {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    highp float tmpvar_14;
    tmpvar_14 = (_FogEndDistance - _FogStartDistance);
    tmpvar_13 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
    , 0.0, 1.0))));
    fogColor_10.xyz = tmpvar_15;
    fogColor_10.w = tmpvar_13;
    tmpvar_4 = fogColor_10;
  };
  tmpvar_1 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_1 = (tmpvar_1 / tmpvar_1.w);
  if ((_ExpandQuad > 0.0)) {
    highp vec4 vert_16;
    vert_16.w = tmpvar_1.w;
    vert_16.xyz = (tmpvar_1.xyz - (_miHoYo_CameraRight.xyz * _glesMultiTexCoord1.x));
    vert_16.y = (vert_16.y + _glesMultiTexCoord1.y);
    highp vec4 vert_17;
    vert_17.w = vert_16.w;
    highp vec4 tmpvar_18;
    tmpvar_18 = abs(((
      fract((((
        fract((((_miHoYo_Wind.w + 
          (dot (tmpvar_1.xyz, vec3(1.0, 1.0, 1.0)) * 0.3)
        ) * _miHoYo_WindParams2.y) * vec4(1.975, 0.793, 0.375, 0.193)))
       * 2.0) - 1.0) + 0.5))
     * 2.0) - 1.0));
    vert_17.xyz = (vert_16.xyz + ((
      (_miHoYo_WindParams2.x * dot (((
        (tmpvar_18 * tmpvar_18)
       * 
        (3.0 - (2.0 * tmpvar_18))
      ) - 0.5), vec4(1.0, 1.0, 1.0, 1.0)))
     * _miHoYo_CameraRight.xyz) * float(
      ((vert_16.y - tmpvar_1.y) > 0.0)
    )));
    tmpvar_1 = vert_17;
  };
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * tmpvar_1);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR0 = tmpvar_2.xyz;
  xlv_COLOR1 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz * xlv_COLOR0);
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = _BloomFactor;
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _miHoYo_Wind;
uniform highp vec3 _miHoYo_WindParams2;
uniform highp vec4 _MainTex_ST;
uniform mediump float _ExpandQuad;
uniform highp vec4 _miHoYo_CameraRight;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesVertex;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_5;
    highp vec3 tmpvar_6;
    tmpvar_6 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_7;
    tmpvar_7 = max (0.0, (sqrt(
      dot (tmpvar_6, tmpvar_6)
    ) - _FogStartDistance));
    highp float tmpvar_8;
    tmpvar_8 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_7)
      ) * (_FogIntensity * tmpvar_7))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
    ), 0.0, 1.0)));
    fogColor_5.xyz = tmpvar_9;
    fogColor_5.w = tmpvar_8;
    tmpvar_4 = fogColor_5;
  } else {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    highp float tmpvar_14;
    tmpvar_14 = (_FogEndDistance - _FogStartDistance);
    tmpvar_13 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
    , 0.0, 1.0))));
    fogColor_10.xyz = tmpvar_15;
    fogColor_10.w = tmpvar_13;
    tmpvar_4 = fogColor_10;
  };
  tmpvar_1 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_1 = (tmpvar_1 / tmpvar_1.w);
  if ((_ExpandQuad > 0.0)) {
    highp vec4 vert_16;
    vert_16.w = tmpvar_1.w;
    vert_16.xyz = (tmpvar_1.xyz - (_miHoYo_CameraRight.xyz * _glesMultiTexCoord1.x));
    vert_16.y = (vert_16.y + _glesMultiTexCoord1.y);
    highp vec4 vert_17;
    vert_17.w = vert_16.w;
    highp vec4 tmpvar_18;
    tmpvar_18 = abs(((
      fract((((
        fract((((_miHoYo_Wind.w + 
          (dot (tmpvar_1.xyz, vec3(1.0, 1.0, 1.0)) * 0.3)
        ) * _miHoYo_WindParams2.y) * vec4(1.975, 0.793, 0.375, 0.193)))
       * 2.0) - 1.0) + 0.5))
     * 2.0) - 1.0));
    vert_17.xyz = (vert_16.xyz + ((
      (_miHoYo_WindParams2.x * dot (((
        (tmpvar_18 * tmpvar_18)
       * 
        (3.0 - (2.0 * tmpvar_18))
      ) - 0.5), vec4(1.0, 1.0, 1.0, 1.0)))
     * _miHoYo_CameraRight.xyz) * float(
      ((vert_16.y - tmpvar_1.y) > 0.0)
    )));
    tmpvar_1 = vert_17;
  };
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * tmpvar_1);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR0 = tmpvar_2.xyz;
  xlv_COLOR1 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz * xlv_COLOR0);
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = _BloomFactor;
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _miHoYo_Wind;
uniform highp vec3 _miHoYo_WindParams2;
uniform highp vec4 _MainTex_ST;
uniform mediump float _ExpandQuad;
uniform highp vec4 _miHoYo_CameraRight;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesVertex;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_5;
    highp vec3 tmpvar_6;
    tmpvar_6 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_7;
    tmpvar_7 = max (0.0, (sqrt(
      dot (tmpvar_6, tmpvar_6)
    ) - _FogStartDistance));
    highp float tmpvar_8;
    tmpvar_8 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_7)
      ) * (_FogIntensity * tmpvar_7))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
    ), 0.0, 1.0)));
    fogColor_5.xyz = tmpvar_9;
    fogColor_5.w = tmpvar_8;
    tmpvar_4 = fogColor_5;
  } else {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    highp float tmpvar_14;
    tmpvar_14 = (_FogEndDistance - _FogStartDistance);
    tmpvar_13 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
    , 0.0, 1.0))));
    fogColor_10.xyz = tmpvar_15;
    fogColor_10.w = tmpvar_13;
    tmpvar_4 = fogColor_10;
  };
  tmpvar_1 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_1 = (tmpvar_1 / tmpvar_1.w);
  if ((_ExpandQuad > 0.0)) {
    highp vec4 vert_16;
    vert_16.w = tmpvar_1.w;
    vert_16.xyz = (tmpvar_1.xyz - (_miHoYo_CameraRight.xyz * _glesMultiTexCoord1.x));
    vert_16.y = (vert_16.y + _glesMultiTexCoord1.y);
    highp vec4 vert_17;
    vert_17.w = vert_16.w;
    highp vec4 tmpvar_18;
    tmpvar_18 = abs(((
      fract((((
        fract((((_miHoYo_Wind.w + 
          (dot (tmpvar_1.xyz, vec3(1.0, 1.0, 1.0)) * 0.3)
        ) * _miHoYo_WindParams2.y) * vec4(1.975, 0.793, 0.375, 0.193)))
       * 2.0) - 1.0) + 0.5))
     * 2.0) - 1.0));
    vert_17.xyz = (vert_16.xyz + ((
      (_miHoYo_WindParams2.x * dot (((
        (tmpvar_18 * tmpvar_18)
       * 
        (3.0 - (2.0 * tmpvar_18))
      ) - 0.5), vec4(1.0, 1.0, 1.0, 1.0)))
     * _miHoYo_CameraRight.xyz) * float(
      ((vert_16.y - tmpvar_1.y) > 0.0)
    )));
    tmpvar_1 = vert_17;
  };
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * tmpvar_1);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR0 = tmpvar_2.xyz;
  xlv_COLOR1 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz * xlv_COLOR0);
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = _BloomFactor;
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _miHoYo_Wind;
uniform highp vec3 _miHoYo_WindParams2;
uniform highp vec4 _MainTex_ST;
uniform mediump float _ExpandQuad;
uniform highp vec4 _miHoYo_CameraRight;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesVertex;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_5;
    highp vec3 tmpvar_6;
    tmpvar_6 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_7;
    tmpvar_7 = max (0.0, (sqrt(
      dot (tmpvar_6, tmpvar_6)
    ) - _FogStartDistance));
    highp float tmpvar_8;
    tmpvar_8 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_7)
      ) * (_FogIntensity * tmpvar_7))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
    ), 0.0, 1.0)));
    fogColor_5.xyz = tmpvar_9;
    fogColor_5.w = tmpvar_8;
    tmpvar_4 = fogColor_5;
  } else {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    highp float tmpvar_14;
    tmpvar_14 = (_FogEndDistance - _FogStartDistance);
    tmpvar_13 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
    , 0.0, 1.0))));
    fogColor_10.xyz = tmpvar_15;
    fogColor_10.w = tmpvar_13;
    tmpvar_4 = fogColor_10;
  };
  tmpvar_1 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_1 = (tmpvar_1 / tmpvar_1.w);
  if ((_ExpandQuad > 0.0)) {
    highp vec4 vert_16;
    vert_16.w = tmpvar_1.w;
    vert_16.xyz = (tmpvar_1.xyz - (_miHoYo_CameraRight.xyz * _glesMultiTexCoord1.x));
    vert_16.y = (vert_16.y + _glesMultiTexCoord1.y);
    highp vec4 vert_17;
    vert_17.w = vert_16.w;
    highp vec4 tmpvar_18;
    tmpvar_18 = abs(((
      fract((((
        fract((((_miHoYo_Wind.w + 
          (dot (tmpvar_1.xyz, vec3(1.0, 1.0, 1.0)) * 0.3)
        ) * _miHoYo_WindParams2.y) * vec4(1.975, 0.793, 0.375, 0.193)))
       * 2.0) - 1.0) + 0.5))
     * 2.0) - 1.0));
    vert_17.xyz = (vert_16.xyz + ((
      (_miHoYo_WindParams2.x * dot (((
        (tmpvar_18 * tmpvar_18)
       * 
        (3.0 - (2.0 * tmpvar_18))
      ) - 0.5), vec4(1.0, 1.0, 1.0, 1.0)))
     * _miHoYo_CameraRight.xyz) * float(
      ((vert_16.y - tmpvar_1.y) > 0.0)
    )));
    tmpvar_1 = vert_17;
  };
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * tmpvar_1);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR0 = tmpvar_2.xyz;
  xlv_COLOR1 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz * xlv_COLOR0);
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = _BloomFactor;
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _miHoYo_Wind;
uniform highp vec3 _miHoYo_WindParams2;
uniform highp vec4 _MainTex_ST;
uniform mediump float _ExpandQuad;
uniform highp vec4 _miHoYo_CameraRight;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesVertex;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_5;
    highp vec3 tmpvar_6;
    tmpvar_6 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_7;
    tmpvar_7 = max (0.0, (sqrt(
      dot (tmpvar_6, tmpvar_6)
    ) - _FogStartDistance));
    highp float tmpvar_8;
    tmpvar_8 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_7)
      ) * (_FogIntensity * tmpvar_7))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
    ), 0.0, 1.0)));
    fogColor_5.xyz = tmpvar_9;
    fogColor_5.w = tmpvar_8;
    tmpvar_4 = fogColor_5;
  } else {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    highp float tmpvar_14;
    tmpvar_14 = (_FogEndDistance - _FogStartDistance);
    tmpvar_13 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
    , 0.0, 1.0))));
    fogColor_10.xyz = tmpvar_15;
    fogColor_10.w = tmpvar_13;
    tmpvar_4 = fogColor_10;
  };
  tmpvar_1 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_1 = (tmpvar_1 / tmpvar_1.w);
  if ((_ExpandQuad > 0.0)) {
    highp vec4 vert_16;
    vert_16.w = tmpvar_1.w;
    vert_16.xyz = (tmpvar_1.xyz - (_miHoYo_CameraRight.xyz * _glesMultiTexCoord1.x));
    vert_16.y = (vert_16.y + _glesMultiTexCoord1.y);
    highp vec4 vert_17;
    vert_17.w = vert_16.w;
    highp vec4 tmpvar_18;
    tmpvar_18 = abs(((
      fract((((
        fract((((_miHoYo_Wind.w + 
          (dot (tmpvar_1.xyz, vec3(1.0, 1.0, 1.0)) * 0.3)
        ) * _miHoYo_WindParams2.y) * vec4(1.975, 0.793, 0.375, 0.193)))
       * 2.0) - 1.0) + 0.5))
     * 2.0) - 1.0));
    vert_17.xyz = (vert_16.xyz + ((
      (_miHoYo_WindParams2.x * dot (((
        (tmpvar_18 * tmpvar_18)
       * 
        (3.0 - (2.0 * tmpvar_18))
      ) - 0.5), vec4(1.0, 1.0, 1.0, 1.0)))
     * _miHoYo_CameraRight.xyz) * float(
      ((vert_16.y - tmpvar_1.y) > 0.0)
    )));
    tmpvar_1 = vert_17;
  };
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * tmpvar_1);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR0 = tmpvar_2.xyz;
  xlv_COLOR1 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz * xlv_COLOR0);
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = _BloomFactor;
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _miHoYo_Wind;
uniform highp vec3 _miHoYo_WindParams2;
uniform highp vec4 _MainTex_ST;
uniform mediump float _ExpandQuad;
uniform highp vec4 _miHoYo_CameraRight;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesVertex;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_5;
    highp vec3 tmpvar_6;
    tmpvar_6 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_7;
    tmpvar_7 = max (0.0, (sqrt(
      dot (tmpvar_6, tmpvar_6)
    ) - _FogStartDistance));
    highp float tmpvar_8;
    tmpvar_8 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_7)
      ) * (_FogIntensity * tmpvar_7))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
    ), 0.0, 1.0)));
    fogColor_5.xyz = tmpvar_9;
    fogColor_5.w = tmpvar_8;
    tmpvar_4 = fogColor_5;
  } else {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    highp float tmpvar_14;
    tmpvar_14 = (_FogEndDistance - _FogStartDistance);
    tmpvar_13 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
    , 0.0, 1.0))));
    fogColor_10.xyz = tmpvar_15;
    fogColor_10.w = tmpvar_13;
    tmpvar_4 = fogColor_10;
  };
  tmpvar_1 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_1 = (tmpvar_1 / tmpvar_1.w);
  if ((_ExpandQuad > 0.0)) {
    highp vec4 vert_16;
    vert_16.w = tmpvar_1.w;
    vert_16.xyz = (tmpvar_1.xyz - (_miHoYo_CameraRight.xyz * _glesMultiTexCoord1.x));
    vert_16.y = (vert_16.y + _glesMultiTexCoord1.y);
    highp vec4 vert_17;
    vert_17.w = vert_16.w;
    highp vec4 tmpvar_18;
    tmpvar_18 = abs(((
      fract((((
        fract((((_miHoYo_Wind.w + 
          (dot (tmpvar_1.xyz, vec3(1.0, 1.0, 1.0)) * 0.3)
        ) * _miHoYo_WindParams2.y) * vec4(1.975, 0.793, 0.375, 0.193)))
       * 2.0) - 1.0) + 0.5))
     * 2.0) - 1.0));
    vert_17.xyz = (vert_16.xyz + ((
      (_miHoYo_WindParams2.x * dot (((
        (tmpvar_18 * tmpvar_18)
       * 
        (3.0 - (2.0 * tmpvar_18))
      ) - 0.5), vec4(1.0, 1.0, 1.0, 1.0)))
     * _miHoYo_CameraRight.xyz) * float(
      ((vert_16.y - tmpvar_1.y) > 0.0)
    )));
    tmpvar_1 = vert_17;
  };
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * tmpvar_1);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR0 = tmpvar_2.xyz;
  xlv_COLOR1 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz * xlv_COLOR0);
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = _BloomFactor;
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _miHoYo_Wind;
uniform highp vec3 _miHoYo_WindParams2;
uniform highp vec4 _MainTex_ST;
uniform mediump float _ExpandQuad;
uniform highp vec4 _miHoYo_CameraRight;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesVertex;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_5;
    highp vec3 tmpvar_6;
    tmpvar_6 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_7;
    tmpvar_7 = max (0.0, (sqrt(
      dot (tmpvar_6, tmpvar_6)
    ) - _FogStartDistance));
    highp float tmpvar_8;
    tmpvar_8 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_7)
      ) * (_FogIntensity * tmpvar_7))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
    ), 0.0, 1.0)));
    fogColor_5.xyz = tmpvar_9;
    fogColor_5.w = tmpvar_8;
    tmpvar_4 = fogColor_5;
  } else {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    highp float tmpvar_14;
    tmpvar_14 = (_FogEndDistance - _FogStartDistance);
    tmpvar_13 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
    , 0.0, 1.0))));
    fogColor_10.xyz = tmpvar_15;
    fogColor_10.w = tmpvar_13;
    tmpvar_4 = fogColor_10;
  };
  tmpvar_1 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_1 = (tmpvar_1 / tmpvar_1.w);
  if ((_ExpandQuad > 0.0)) {
    highp vec4 vert_16;
    vert_16.w = tmpvar_1.w;
    vert_16.xyz = (tmpvar_1.xyz - (_miHoYo_CameraRight.xyz * _glesMultiTexCoord1.x));
    vert_16.y = (vert_16.y + _glesMultiTexCoord1.y);
    highp vec4 vert_17;
    vert_17.w = vert_16.w;
    highp vec4 tmpvar_18;
    tmpvar_18 = abs(((
      fract((((
        fract((((_miHoYo_Wind.w + 
          (dot (tmpvar_1.xyz, vec3(1.0, 1.0, 1.0)) * 0.3)
        ) * _miHoYo_WindParams2.y) * vec4(1.975, 0.793, 0.375, 0.193)))
       * 2.0) - 1.0) + 0.5))
     * 2.0) - 1.0));
    vert_17.xyz = (vert_16.xyz + ((
      (_miHoYo_WindParams2.x * dot (((
        (tmpvar_18 * tmpvar_18)
       * 
        (3.0 - (2.0 * tmpvar_18))
      ) - 0.5), vec4(1.0, 1.0, 1.0, 1.0)))
     * _miHoYo_CameraRight.xyz) * float(
      ((vert_16.y - tmpvar_1.y) > 0.0)
    )));
    tmpvar_1 = vert_17;
  };
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * tmpvar_1);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR0 = tmpvar_2.xyz;
  xlv_COLOR1 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz * xlv_COLOR0);
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = _BloomFactor;
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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