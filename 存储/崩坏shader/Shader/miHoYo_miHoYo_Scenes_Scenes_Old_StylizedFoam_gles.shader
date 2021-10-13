//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/StylizedFoam" {
Properties {
_BloomFactor ("Bloom Factor", Float) = 1
_MainColor ("Main Color", Color) = (1,1,1,1)
_Wavesspeed ("Waves speed", Range(0, 10)) = 0.75
_EmissionScaler ("Emission Scaler", Float) = 1
_NormalMap ("Normal Map", 2D) = "white" { }
_Distortion ("Distortion", Float) = 1
_BumpVelocity0 ("Bump Velocity 0", Vector) = (0,0,0,0)
_BumpScale0 ("Bump Scale 0", Float) = 1
_ClampYMin ("Clamp Y Min", Float) = 0
_ClampYMax ("Clamp Y Max", Float) = 1
_GradientPower ("Gradient Power", Float) = 5
[Toggle(INVERT_GRAD)] _InvertGrad ("Invert Grad", Float) = 0
_MainTex ("Shadermap", 2D) = "black" { }
_MaskTex ("MaskTex", 2D) = "white" { }
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 48431
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _MaskTex_ST;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  mediump vec4 tmpvar_5;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_6;
    highp vec3 tmpvar_7;
    tmpvar_7 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_8;
    tmpvar_8 = max (0.0, (sqrt(
      dot (tmpvar_7, tmpvar_7)
    ) - _FogStartDistance));
    highp float tmpvar_9;
    tmpvar_9 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_8)
      ) * (_FogIntensity * tmpvar_8))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_8)) * (_FogColorIntensity * tmpvar_8))
    ), 0.0, 1.0)));
    fogColor_6.xyz = tmpvar_10;
    fogColor_6.w = tmpvar_9;
    tmpvar_5 = fogColor_6;
  } else {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    highp float tmpvar_15;
    tmpvar_15 = (_FogEndDistance - _FogStartDistance);
    tmpvar_14 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
    , 0.0, 1.0))));
    fogColor_11.xyz = tmpvar_16;
    fogColor_11.w = tmpvar_14;
    tmpvar_5 = fogColor_11;
  };
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform mediump float _Wavesspeed;
uniform mediump float _EmissionScaler;
uniform mediump float _ClampYMin;
uniform mediump float _ClampYMax;
uniform mediump float _InvertGrad;
uniform mediump float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 finalRGBA_2;
  highp float grad_3;
  highp vec3 Color_4;
  highp vec4 rimV_Tex_5;
  mediump vec2 rimPanningV_6;
  highp vec4 rimU_Tex_7;
  mediump vec2 rimPanningU_8;
  if ((xlv_TEXCOORD0.y > _ClampYMax)) {
    discard;
  };
  if ((xlv_TEXCOORD0.y < _ClampYMin)) {
    discard;
  };
  highp float tmpvar_9;
  tmpvar_9 = (_Time.y * (_Wavesspeed * 0.1));
  highp vec2 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD2 + vec2(tmpvar_9));
  rimPanningU_8 = tmpvar_10;
  rimPanningU_8.y = (1.0 - rimPanningU_8.y);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, rimPanningU_8);
  rimU_Tex_7 = tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD2 + (tmpvar_9 * vec2(-0.5, 0.0)));
  rimPanningV_6 = tmpvar_12;
  rimPanningV_6.y = (1.0 - rimPanningV_6.y);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, rimPanningV_6);
  rimV_Tex_5 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = clamp ((1.0 - (rimU_Tex_7.y * rimV_Tex_5.x)), 0.0, 1.0);
  highp vec3 tmpvar_15;
  tmpvar_15.x = tmpvar_14;
  tmpvar_15.y = tmpvar_14;
  tmpvar_15.z = tmpvar_14;
  Color_4 = tmpvar_15;
  lowp float tmpvar_16;
  tmpvar_16 = texture2D (_MaskTex, xlv_TEXCOORD3).x;
  grad_3 = tmpvar_16;
  if ((_InvertGrad > 0.0)) {
    grad_3 = clamp ((1.0 - grad_3), 0.0, 1.0);
  };
  Color_4 = ((vec3(tmpvar_14) * _EmissionScaler) * grad_3);
  mediump vec3 srcColor_17;
  srcColor_17 = Color_4;
  mediump vec3 tmpvar_18;
  tmpvar_18 = (srcColor_17 * (vec3(1.0, 1.0, 1.0) - xlv_COLOR1.www));
  Color_4 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = Color_4;
  tmpvar_19.w = clamp ((_BloomFactor * grad_3), 0.0, 1.0);
  finalRGBA_2 = tmpvar_19;
  tmpvar_1 = finalRGBA_2;
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
uniform highp vec4 _Time;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _MaskTex_ST;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  mediump vec4 tmpvar_5;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_6;
    highp vec3 tmpvar_7;
    tmpvar_7 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_8;
    tmpvar_8 = max (0.0, (sqrt(
      dot (tmpvar_7, tmpvar_7)
    ) - _FogStartDistance));
    highp float tmpvar_9;
    tmpvar_9 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_8)
      ) * (_FogIntensity * tmpvar_8))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_8)) * (_FogColorIntensity * tmpvar_8))
    ), 0.0, 1.0)));
    fogColor_6.xyz = tmpvar_10;
    fogColor_6.w = tmpvar_9;
    tmpvar_5 = fogColor_6;
  } else {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    highp float tmpvar_15;
    tmpvar_15 = (_FogEndDistance - _FogStartDistance);
    tmpvar_14 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
    , 0.0, 1.0))));
    fogColor_11.xyz = tmpvar_16;
    fogColor_11.w = tmpvar_14;
    tmpvar_5 = fogColor_11;
  };
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform mediump float _Wavesspeed;
uniform mediump float _EmissionScaler;
uniform mediump float _ClampYMin;
uniform mediump float _ClampYMax;
uniform mediump float _InvertGrad;
uniform mediump float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 finalRGBA_2;
  highp float grad_3;
  highp vec3 Color_4;
  highp vec4 rimV_Tex_5;
  mediump vec2 rimPanningV_6;
  highp vec4 rimU_Tex_7;
  mediump vec2 rimPanningU_8;
  if ((xlv_TEXCOORD0.y > _ClampYMax)) {
    discard;
  };
  if ((xlv_TEXCOORD0.y < _ClampYMin)) {
    discard;
  };
  highp float tmpvar_9;
  tmpvar_9 = (_Time.y * (_Wavesspeed * 0.1));
  highp vec2 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD2 + vec2(tmpvar_9));
  rimPanningU_8 = tmpvar_10;
  rimPanningU_8.y = (1.0 - rimPanningU_8.y);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, rimPanningU_8);
  rimU_Tex_7 = tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD2 + (tmpvar_9 * vec2(-0.5, 0.0)));
  rimPanningV_6 = tmpvar_12;
  rimPanningV_6.y = (1.0 - rimPanningV_6.y);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, rimPanningV_6);
  rimV_Tex_5 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = clamp ((1.0 - (rimU_Tex_7.y * rimV_Tex_5.x)), 0.0, 1.0);
  highp vec3 tmpvar_15;
  tmpvar_15.x = tmpvar_14;
  tmpvar_15.y = tmpvar_14;
  tmpvar_15.z = tmpvar_14;
  Color_4 = tmpvar_15;
  lowp float tmpvar_16;
  tmpvar_16 = texture2D (_MaskTex, xlv_TEXCOORD3).x;
  grad_3 = tmpvar_16;
  if ((_InvertGrad > 0.0)) {
    grad_3 = clamp ((1.0 - grad_3), 0.0, 1.0);
  };
  Color_4 = ((vec3(tmpvar_14) * _EmissionScaler) * grad_3);
  mediump vec3 srcColor_17;
  srcColor_17 = Color_4;
  mediump vec3 tmpvar_18;
  tmpvar_18 = (srcColor_17 * (vec3(1.0, 1.0, 1.0) - xlv_COLOR1.www));
  Color_4 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = Color_4;
  tmpvar_19.w = clamp ((_BloomFactor * grad_3), 0.0, 1.0);
  finalRGBA_2 = tmpvar_19;
  tmpvar_1 = finalRGBA_2;
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
uniform highp vec4 _Time;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _MaskTex_ST;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  mediump vec4 tmpvar_5;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_6;
    highp vec3 tmpvar_7;
    tmpvar_7 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_8;
    tmpvar_8 = max (0.0, (sqrt(
      dot (tmpvar_7, tmpvar_7)
    ) - _FogStartDistance));
    highp float tmpvar_9;
    tmpvar_9 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_8)
      ) * (_FogIntensity * tmpvar_8))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_8)) * (_FogColorIntensity * tmpvar_8))
    ), 0.0, 1.0)));
    fogColor_6.xyz = tmpvar_10;
    fogColor_6.w = tmpvar_9;
    tmpvar_5 = fogColor_6;
  } else {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    highp float tmpvar_15;
    tmpvar_15 = (_FogEndDistance - _FogStartDistance);
    tmpvar_14 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
    , 0.0, 1.0))));
    fogColor_11.xyz = tmpvar_16;
    fogColor_11.w = tmpvar_14;
    tmpvar_5 = fogColor_11;
  };
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform mediump float _Wavesspeed;
uniform mediump float _EmissionScaler;
uniform mediump float _ClampYMin;
uniform mediump float _ClampYMax;
uniform mediump float _InvertGrad;
uniform mediump float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 finalRGBA_2;
  highp float grad_3;
  highp vec3 Color_4;
  highp vec4 rimV_Tex_5;
  mediump vec2 rimPanningV_6;
  highp vec4 rimU_Tex_7;
  mediump vec2 rimPanningU_8;
  if ((xlv_TEXCOORD0.y > _ClampYMax)) {
    discard;
  };
  if ((xlv_TEXCOORD0.y < _ClampYMin)) {
    discard;
  };
  highp float tmpvar_9;
  tmpvar_9 = (_Time.y * (_Wavesspeed * 0.1));
  highp vec2 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD2 + vec2(tmpvar_9));
  rimPanningU_8 = tmpvar_10;
  rimPanningU_8.y = (1.0 - rimPanningU_8.y);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, rimPanningU_8);
  rimU_Tex_7 = tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD2 + (tmpvar_9 * vec2(-0.5, 0.0)));
  rimPanningV_6 = tmpvar_12;
  rimPanningV_6.y = (1.0 - rimPanningV_6.y);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, rimPanningV_6);
  rimV_Tex_5 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = clamp ((1.0 - (rimU_Tex_7.y * rimV_Tex_5.x)), 0.0, 1.0);
  highp vec3 tmpvar_15;
  tmpvar_15.x = tmpvar_14;
  tmpvar_15.y = tmpvar_14;
  tmpvar_15.z = tmpvar_14;
  Color_4 = tmpvar_15;
  lowp float tmpvar_16;
  tmpvar_16 = texture2D (_MaskTex, xlv_TEXCOORD3).x;
  grad_3 = tmpvar_16;
  if ((_InvertGrad > 0.0)) {
    grad_3 = clamp ((1.0 - grad_3), 0.0, 1.0);
  };
  Color_4 = ((vec3(tmpvar_14) * _EmissionScaler) * grad_3);
  mediump vec3 srcColor_17;
  srcColor_17 = Color_4;
  mediump vec3 tmpvar_18;
  tmpvar_18 = (srcColor_17 * (vec3(1.0, 1.0, 1.0) - xlv_COLOR1.www));
  Color_4 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = Color_4;
  tmpvar_19.w = clamp ((_BloomFactor * grad_3), 0.0, 1.0);
  finalRGBA_2 = tmpvar_19;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
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
uniform highp vec4 _Time;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _MaskTex_ST;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  mediump vec4 tmpvar_5;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_6;
    highp vec3 tmpvar_7;
    tmpvar_7 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_8;
    tmpvar_8 = max (0.0, (sqrt(
      dot (tmpvar_7, tmpvar_7)
    ) - _FogStartDistance));
    highp float tmpvar_9;
    tmpvar_9 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_8)
      ) * (_FogIntensity * tmpvar_8))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_8)) * (_FogColorIntensity * tmpvar_8))
    ), 0.0, 1.0)));
    fogColor_6.xyz = tmpvar_10;
    fogColor_6.w = tmpvar_9;
    tmpvar_5 = fogColor_6;
  } else {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    highp float tmpvar_15;
    tmpvar_15 = (_FogEndDistance - _FogStartDistance);
    tmpvar_14 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
    , 0.0, 1.0))));
    fogColor_11.xyz = tmpvar_16;
    fogColor_11.w = tmpvar_14;
    tmpvar_5 = fogColor_11;
  };
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform mediump float _Wavesspeed;
uniform mediump float _EmissionScaler;
uniform mediump float _ClampYMin;
uniform mediump float _ClampYMax;
uniform mediump float _InvertGrad;
uniform mediump float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 finalRGBA_2;
  highp float grad_3;
  highp vec3 Color_4;
  highp vec4 rimV_Tex_5;
  mediump vec2 rimPanningV_6;
  highp vec4 rimU_Tex_7;
  mediump vec2 rimPanningU_8;
  if ((xlv_TEXCOORD0.y > _ClampYMax)) {
    discard;
  };
  if ((xlv_TEXCOORD0.y < _ClampYMin)) {
    discard;
  };
  highp float tmpvar_9;
  tmpvar_9 = (_Time.y * (_Wavesspeed * 0.1));
  highp vec2 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD2 + vec2(tmpvar_9));
  rimPanningU_8 = tmpvar_10;
  rimPanningU_8.y = (1.0 - rimPanningU_8.y);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, rimPanningU_8);
  rimU_Tex_7 = tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD2 + (tmpvar_9 * vec2(-0.5, 0.0)));
  rimPanningV_6 = tmpvar_12;
  rimPanningV_6.y = (1.0 - rimPanningV_6.y);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, rimPanningV_6);
  rimV_Tex_5 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = clamp ((1.0 - (rimU_Tex_7.y * rimV_Tex_5.x)), 0.0, 1.0);
  highp vec3 tmpvar_15;
  tmpvar_15.x = tmpvar_14;
  tmpvar_15.y = tmpvar_14;
  tmpvar_15.z = tmpvar_14;
  Color_4 = tmpvar_15;
  lowp float tmpvar_16;
  tmpvar_16 = texture2D (_MaskTex, xlv_TEXCOORD3).x;
  grad_3 = tmpvar_16;
  if ((_InvertGrad > 0.0)) {
    grad_3 = clamp ((1.0 - grad_3), 0.0, 1.0);
  };
  Color_4 = ((vec3(tmpvar_14) * _EmissionScaler) * grad_3);
  mediump vec3 srcColor_17;
  srcColor_17 = Color_4;
  mediump vec3 tmpvar_18;
  tmpvar_18 = (srcColor_17 * (vec3(1.0, 1.0, 1.0) - xlv_COLOR1.www));
  Color_4 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = Color_4;
  tmpvar_19.w = clamp ((_BloomFactor * grad_3), 0.0, 1.0);
  finalRGBA_2 = tmpvar_19;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
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
uniform highp vec4 _Time;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _MaskTex_ST;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  mediump vec4 tmpvar_5;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_6;
    highp vec3 tmpvar_7;
    tmpvar_7 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_8;
    tmpvar_8 = max (0.0, (sqrt(
      dot (tmpvar_7, tmpvar_7)
    ) - _FogStartDistance));
    highp float tmpvar_9;
    tmpvar_9 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_8)
      ) * (_FogIntensity * tmpvar_8))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_8)) * (_FogColorIntensity * tmpvar_8))
    ), 0.0, 1.0)));
    fogColor_6.xyz = tmpvar_10;
    fogColor_6.w = tmpvar_9;
    tmpvar_5 = fogColor_6;
  } else {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    highp float tmpvar_15;
    tmpvar_15 = (_FogEndDistance - _FogStartDistance);
    tmpvar_14 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
    , 0.0, 1.0))));
    fogColor_11.xyz = tmpvar_16;
    fogColor_11.w = tmpvar_14;
    tmpvar_5 = fogColor_11;
  };
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform mediump float _Wavesspeed;
uniform mediump float _EmissionScaler;
uniform mediump float _ClampYMin;
uniform mediump float _ClampYMax;
uniform mediump float _InvertGrad;
uniform mediump float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 finalRGBA_2;
  highp float grad_3;
  highp vec3 Color_4;
  highp vec4 rimV_Tex_5;
  mediump vec2 rimPanningV_6;
  highp vec4 rimU_Tex_7;
  mediump vec2 rimPanningU_8;
  if ((xlv_TEXCOORD0.y > _ClampYMax)) {
    discard;
  };
  if ((xlv_TEXCOORD0.y < _ClampYMin)) {
    discard;
  };
  highp float tmpvar_9;
  tmpvar_9 = (_Time.y * (_Wavesspeed * 0.1));
  highp vec2 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD2 + vec2(tmpvar_9));
  rimPanningU_8 = tmpvar_10;
  rimPanningU_8.y = (1.0 - rimPanningU_8.y);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, rimPanningU_8);
  rimU_Tex_7 = tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD2 + (tmpvar_9 * vec2(-0.5, 0.0)));
  rimPanningV_6 = tmpvar_12;
  rimPanningV_6.y = (1.0 - rimPanningV_6.y);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, rimPanningV_6);
  rimV_Tex_5 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = clamp ((1.0 - (rimU_Tex_7.y * rimV_Tex_5.x)), 0.0, 1.0);
  highp vec3 tmpvar_15;
  tmpvar_15.x = tmpvar_14;
  tmpvar_15.y = tmpvar_14;
  tmpvar_15.z = tmpvar_14;
  Color_4 = tmpvar_15;
  lowp float tmpvar_16;
  tmpvar_16 = texture2D (_MaskTex, xlv_TEXCOORD3).x;
  grad_3 = tmpvar_16;
  if ((_InvertGrad > 0.0)) {
    grad_3 = clamp ((1.0 - grad_3), 0.0, 1.0);
  };
  Color_4 = ((vec3(tmpvar_14) * _EmissionScaler) * grad_3);
  mediump vec3 srcColor_17;
  srcColor_17 = Color_4;
  mediump vec3 tmpvar_18;
  tmpvar_18 = (srcColor_17 * (vec3(1.0, 1.0, 1.0) - xlv_COLOR1.www));
  Color_4 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = Color_4;
  tmpvar_19.w = clamp ((_BloomFactor * grad_3), 0.0, 1.0);
  finalRGBA_2 = tmpvar_19;
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
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
uniform highp vec4 _Time;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _MaskTex_ST;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  mediump vec4 tmpvar_5;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_6;
    highp vec3 tmpvar_7;
    tmpvar_7 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_8;
    tmpvar_8 = max (0.0, (sqrt(
      dot (tmpvar_7, tmpvar_7)
    ) - _FogStartDistance));
    highp float tmpvar_9;
    tmpvar_9 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_8)
      ) * (_FogIntensity * tmpvar_8))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_8)) * (_FogColorIntensity * tmpvar_8))
    ), 0.0, 1.0)));
    fogColor_6.xyz = tmpvar_10;
    fogColor_6.w = tmpvar_9;
    tmpvar_5 = fogColor_6;
  } else {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    highp float tmpvar_15;
    tmpvar_15 = (_FogEndDistance - _FogStartDistance);
    tmpvar_14 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
    , 0.0, 1.0))));
    fogColor_11.xyz = tmpvar_16;
    fogColor_11.w = tmpvar_14;
    tmpvar_5 = fogColor_11;
  };
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform mediump float _Wavesspeed;
uniform mediump float _EmissionScaler;
uniform mediump float _ClampYMin;
uniform mediump float _ClampYMax;
uniform mediump float _InvertGrad;
uniform mediump float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 finalRGBA_2;
  highp float grad_3;
  highp vec3 Color_4;
  highp vec4 rimV_Tex_5;
  mediump vec2 rimPanningV_6;
  highp vec4 rimU_Tex_7;
  mediump vec2 rimPanningU_8;
  if ((xlv_TEXCOORD0.y > _ClampYMax)) {
    discard;
  };
  if ((xlv_TEXCOORD0.y < _ClampYMin)) {
    discard;
  };
  highp float tmpvar_9;
  tmpvar_9 = (_Time.y * (_Wavesspeed * 0.1));
  highp vec2 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD2 + vec2(tmpvar_9));
  rimPanningU_8 = tmpvar_10;
  rimPanningU_8.y = (1.0 - rimPanningU_8.y);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, rimPanningU_8);
  rimU_Tex_7 = tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD2 + (tmpvar_9 * vec2(-0.5, 0.0)));
  rimPanningV_6 = tmpvar_12;
  rimPanningV_6.y = (1.0 - rimPanningV_6.y);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, rimPanningV_6);
  rimV_Tex_5 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = clamp ((1.0 - (rimU_Tex_7.y * rimV_Tex_5.x)), 0.0, 1.0);
  highp vec3 tmpvar_15;
  tmpvar_15.x = tmpvar_14;
  tmpvar_15.y = tmpvar_14;
  tmpvar_15.z = tmpvar_14;
  Color_4 = tmpvar_15;
  lowp float tmpvar_16;
  tmpvar_16 = texture2D (_MaskTex, xlv_TEXCOORD3).x;
  grad_3 = tmpvar_16;
  if ((_InvertGrad > 0.0)) {
    grad_3 = clamp ((1.0 - grad_3), 0.0, 1.0);
  };
  Color_4 = ((vec3(tmpvar_14) * _EmissionScaler) * grad_3);
  mediump vec3 srcColor_17;
  srcColor_17 = Color_4;
  mediump vec3 tmpvar_18;
  tmpvar_18 = (srcColor_17 * (vec3(1.0, 1.0, 1.0) - xlv_COLOR1.www));
  Color_4 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = Color_4;
  tmpvar_19.w = clamp ((_BloomFactor * grad_3), 0.0, 1.0);
  finalRGBA_2 = tmpvar_19;
  tmpvar_1 = finalRGBA_2;
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
Fallback "Unlit/Transparent"
}