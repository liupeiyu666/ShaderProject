//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/AirEffect_LightMap_Reflect(Clip)" {
Properties {
_Color ("Color", Color) = (1,1,1,1)
_LightMapIntensity ("Light Map Intensity", Float) = 1
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Color Tex (RGB)", 2D) = "white" { }
_ReflectMaskTex ("Reflect Mask Tex(R)", 2D) = "white" { }
_ShadowTex ("LightMap (RGB)", 2D) = "grey" { }
_EnvTex ("Environment Texture (RGB)", Cube) = "grey" { }
_Reflectivity ("Reflectivity", Range(0, 5)) = 1
_CamDistRatio ("Camera Distance Ratio", Range(0, 1)) = 0.1
_CamHeightOffset ("Camera Height", Float) = 5
_CamRotate ("Camera Rotate", Range(-3.14159, 3.14159)) = 0
[Toggle(INT_PING_PONG)] _LigthMapIntPingPong ("Light Map Intensity Ping Pong", Float) = 0
_Magnitude ("Magnitude Of Ping Pong", Range(0, 5)) = 3
_MinValue ("Min Value Of Ping Pong", Range(0, 2)) = 0.5
_Speed ("Speed Of Ping Pong", Range(0, 3)) = 0.5
_ScaleTime ("Scale Time", Range(0, 1)) = 1
_UMin ("U Min", Float) = 0
_UMax ("U Max", Float) = 1
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "BASE"
  LOD 200
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 32642
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp float sint_2;
  highp float cost_3;
  highp vec3 adjCamPos_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_11.xz - ((tmpvar_11.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = cos(_CamRotate);
  cost_3 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin(_CamRotate);
  sint_2 = tmpvar_14;
  highp mat2 tmpvar_15;
  tmpvar_15[0].x = cost_3;
  tmpvar_15[0].y = -(sint_2);
  tmpvar_15[1].x = sint_2;
  tmpvar_15[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_15 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _Color;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _MainTex_ST;
uniform sampler2D _ShadowTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _ScaleTime;
uniform mediump float _UMin;
uniform mediump float _UMax;
uniform mediump float _LigthMapIntPingPong;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_1 = xlv_TEXCOORD0;
  tmpvar_2 = xlv_TEXCOORD1;
  tmpvar_3 = xlv_TEXCOORD2;
  tmpvar_4 = xlv_TEXCOORD3;
  tmpvar_5 = xlv_COLOR1;
  mediump vec4 tmpvar_6;
  bool tmpvar_7;
  tmpvar_7 = bool(0);
  mediump vec4 outColor_9;
  outColor_9 = vec4(0.0, 0.0, 0.0, 0.0);
  for (highp int i_8 = 0; i_8 < 20; i_8++) {
    highp float time_10;
    time_10 = _ScaleTime;
    highp float width_11;
    mediump float tmpvar_12;
    tmpvar_12 = (((_UMax - _UMin) / 2.0) / 20.0);
    width_11 = tmpvar_12;
    highp float tmpvar_13;
    tmpvar_13 = ((_UMin + (
      (float(i_8) * width_11)
     * 2.0)) + width_11);
    highp vec4 tmpvar_14;
    tmpvar_14.zw = vec2(0.0, 0.0);
    tmpvar_14.x = (tmpvar_13 - (width_11 * time_10));
    tmpvar_14.y = (tmpvar_13 + (width_11 * time_10));
    if ((((tmpvar_14.x + _MainTex_ST.z) <= tmpvar_1.x) && (tmpvar_1.x <= (tmpvar_14.y + _MainTex_ST.z)))) {
      mediump vec3 colorBlendLightMap_15;
      mediump vec4 tex_S_Color_16;
      mediump float reflectMask_17;
      mediump vec4 tex_C_Color_18;
      lowp vec4 tmpvar_19;
      tmpvar_19 = texture2D (_MainTex, tmpvar_1);
      tex_C_Color_18 = tmpvar_19;
      lowp float tmpvar_20;
      tmpvar_20 = texture2D (_ReflectMaskTex, tmpvar_1).x;
      reflectMask_17 = tmpvar_20;
      lowp vec4 tmpvar_21;
      tmpvar_21 = texture2D (_ShadowTex, tmpvar_2);
      tex_S_Color_16 = tmpvar_21;
      tex_C_Color_18.xyz = (tex_C_Color_18.xyz * _Color.xyz);
      mediump vec3 tmpvar_22;
      tmpvar_22 = (tmpvar_4 - (2.0 * (
        dot (tmpvar_3, tmpvar_4)
       * tmpvar_3)));
      lowp vec4 tmpvar_23;
      tmpvar_23 = textureCube (_EnvTex, tmpvar_22);
      tex_C_Color_18.xyz = (tex_C_Color_18.xyz + ((tmpvar_23.xyz * reflectMask_17) * _Reflectivity));
      mediump vec3 tmpvar_24;
      tmpvar_24 = (tex_C_Color_18.xyz * ((
        ((2.0 * tex_S_Color_16.xyz) * tex_S_Color_16.w)
       + 1.0) - tex_S_Color_16.w));
      colorBlendLightMap_15 = tmpvar_24;
      if ((_LigthMapIntPingPong > 0.0)) {
        highp float tmpvar_25;
        tmpvar_25 = abs((fract(
          (_Time.y * _Speed)
        ) - 0.5));
        colorBlendLightMap_15 = (tmpvar_24 * ((tmpvar_25 * _Magnitude) + _MinValue));
      } else {
        colorBlendLightMap_15 = (colorBlendLightMap_15 * _LightMapIntensity);
      };
      outColor_9.xyz = mix (colorBlendLightMap_15, tmpvar_5.xyz, tmpvar_5.www);
      outColor_9.w = _BloomFactor;
      tmpvar_6 = outColor_9;
      tmpvar_7 = bool(1);
      break;
    };
  };
  if (!(tmpvar_7)) {
    discard;
    tmpvar_6 = outColor_9;
    tmpvar_7 = bool(1);
  };
  gl_FragData[0] = tmpvar_6;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp float sint_2;
  highp float cost_3;
  highp vec3 adjCamPos_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_11.xz - ((tmpvar_11.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = cos(_CamRotate);
  cost_3 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin(_CamRotate);
  sint_2 = tmpvar_14;
  highp mat2 tmpvar_15;
  tmpvar_15[0].x = cost_3;
  tmpvar_15[0].y = -(sint_2);
  tmpvar_15[1].x = sint_2;
  tmpvar_15[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_15 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _Color;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _MainTex_ST;
uniform sampler2D _ShadowTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _ScaleTime;
uniform mediump float _UMin;
uniform mediump float _UMax;
uniform mediump float _LigthMapIntPingPong;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_1 = xlv_TEXCOORD0;
  tmpvar_2 = xlv_TEXCOORD1;
  tmpvar_3 = xlv_TEXCOORD2;
  tmpvar_4 = xlv_TEXCOORD3;
  tmpvar_5 = xlv_COLOR1;
  mediump vec4 tmpvar_6;
  bool tmpvar_7;
  tmpvar_7 = bool(0);
  mediump vec4 outColor_9;
  outColor_9 = vec4(0.0, 0.0, 0.0, 0.0);
  for (highp int i_8 = 0; i_8 < 20; i_8++) {
    highp float time_10;
    time_10 = _ScaleTime;
    highp float width_11;
    mediump float tmpvar_12;
    tmpvar_12 = (((_UMax - _UMin) / 2.0) / 20.0);
    width_11 = tmpvar_12;
    highp float tmpvar_13;
    tmpvar_13 = ((_UMin + (
      (float(i_8) * width_11)
     * 2.0)) + width_11);
    highp vec4 tmpvar_14;
    tmpvar_14.zw = vec2(0.0, 0.0);
    tmpvar_14.x = (tmpvar_13 - (width_11 * time_10));
    tmpvar_14.y = (tmpvar_13 + (width_11 * time_10));
    if ((((tmpvar_14.x + _MainTex_ST.z) <= tmpvar_1.x) && (tmpvar_1.x <= (tmpvar_14.y + _MainTex_ST.z)))) {
      mediump vec3 colorBlendLightMap_15;
      mediump vec4 tex_S_Color_16;
      mediump float reflectMask_17;
      mediump vec4 tex_C_Color_18;
      lowp vec4 tmpvar_19;
      tmpvar_19 = texture2D (_MainTex, tmpvar_1);
      tex_C_Color_18 = tmpvar_19;
      lowp float tmpvar_20;
      tmpvar_20 = texture2D (_ReflectMaskTex, tmpvar_1).x;
      reflectMask_17 = tmpvar_20;
      lowp vec4 tmpvar_21;
      tmpvar_21 = texture2D (_ShadowTex, tmpvar_2);
      tex_S_Color_16 = tmpvar_21;
      tex_C_Color_18.xyz = (tex_C_Color_18.xyz * _Color.xyz);
      mediump vec3 tmpvar_22;
      tmpvar_22 = (tmpvar_4 - (2.0 * (
        dot (tmpvar_3, tmpvar_4)
       * tmpvar_3)));
      lowp vec4 tmpvar_23;
      tmpvar_23 = textureCube (_EnvTex, tmpvar_22);
      tex_C_Color_18.xyz = (tex_C_Color_18.xyz + ((tmpvar_23.xyz * reflectMask_17) * _Reflectivity));
      mediump vec3 tmpvar_24;
      tmpvar_24 = (tex_C_Color_18.xyz * ((
        ((2.0 * tex_S_Color_16.xyz) * tex_S_Color_16.w)
       + 1.0) - tex_S_Color_16.w));
      colorBlendLightMap_15 = tmpvar_24;
      if ((_LigthMapIntPingPong > 0.0)) {
        highp float tmpvar_25;
        tmpvar_25 = abs((fract(
          (_Time.y * _Speed)
        ) - 0.5));
        colorBlendLightMap_15 = (tmpvar_24 * ((tmpvar_25 * _Magnitude) + _MinValue));
      } else {
        colorBlendLightMap_15 = (colorBlendLightMap_15 * _LightMapIntensity);
      };
      outColor_9.xyz = mix (colorBlendLightMap_15, tmpvar_5.xyz, tmpvar_5.www);
      outColor_9.w = _BloomFactor;
      tmpvar_6 = outColor_9;
      tmpvar_7 = bool(1);
      break;
    };
  };
  if (!(tmpvar_7)) {
    discard;
    tmpvar_6 = outColor_9;
    tmpvar_7 = bool(1);
  };
  gl_FragData[0] = tmpvar_6;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp float sint_2;
  highp float cost_3;
  highp vec3 adjCamPos_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_11.xz - ((tmpvar_11.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = cos(_CamRotate);
  cost_3 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin(_CamRotate);
  sint_2 = tmpvar_14;
  highp mat2 tmpvar_15;
  tmpvar_15[0].x = cost_3;
  tmpvar_15[0].y = -(sint_2);
  tmpvar_15[1].x = sint_2;
  tmpvar_15[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_15 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _Color;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _MainTex_ST;
uniform sampler2D _ShadowTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _ScaleTime;
uniform mediump float _UMin;
uniform mediump float _UMax;
uniform mediump float _LigthMapIntPingPong;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_1 = xlv_TEXCOORD0;
  tmpvar_2 = xlv_TEXCOORD1;
  tmpvar_3 = xlv_TEXCOORD2;
  tmpvar_4 = xlv_TEXCOORD3;
  tmpvar_5 = xlv_COLOR1;
  mediump vec4 tmpvar_6;
  bool tmpvar_7;
  tmpvar_7 = bool(0);
  mediump vec4 outColor_9;
  outColor_9 = vec4(0.0, 0.0, 0.0, 0.0);
  for (highp int i_8 = 0; i_8 < 20; i_8++) {
    highp float time_10;
    time_10 = _ScaleTime;
    highp float width_11;
    mediump float tmpvar_12;
    tmpvar_12 = (((_UMax - _UMin) / 2.0) / 20.0);
    width_11 = tmpvar_12;
    highp float tmpvar_13;
    tmpvar_13 = ((_UMin + (
      (float(i_8) * width_11)
     * 2.0)) + width_11);
    highp vec4 tmpvar_14;
    tmpvar_14.zw = vec2(0.0, 0.0);
    tmpvar_14.x = (tmpvar_13 - (width_11 * time_10));
    tmpvar_14.y = (tmpvar_13 + (width_11 * time_10));
    if ((((tmpvar_14.x + _MainTex_ST.z) <= tmpvar_1.x) && (tmpvar_1.x <= (tmpvar_14.y + _MainTex_ST.z)))) {
      mediump vec3 colorBlendLightMap_15;
      mediump vec4 tex_S_Color_16;
      mediump float reflectMask_17;
      mediump vec4 tex_C_Color_18;
      lowp vec4 tmpvar_19;
      tmpvar_19 = texture2D (_MainTex, tmpvar_1);
      tex_C_Color_18 = tmpvar_19;
      lowp float tmpvar_20;
      tmpvar_20 = texture2D (_ReflectMaskTex, tmpvar_1).x;
      reflectMask_17 = tmpvar_20;
      lowp vec4 tmpvar_21;
      tmpvar_21 = texture2D (_ShadowTex, tmpvar_2);
      tex_S_Color_16 = tmpvar_21;
      tex_C_Color_18.xyz = (tex_C_Color_18.xyz * _Color.xyz);
      mediump vec3 tmpvar_22;
      tmpvar_22 = (tmpvar_4 - (2.0 * (
        dot (tmpvar_3, tmpvar_4)
       * tmpvar_3)));
      lowp vec4 tmpvar_23;
      tmpvar_23 = textureCube (_EnvTex, tmpvar_22);
      tex_C_Color_18.xyz = (tex_C_Color_18.xyz + ((tmpvar_23.xyz * reflectMask_17) * _Reflectivity));
      mediump vec3 tmpvar_24;
      tmpvar_24 = (tex_C_Color_18.xyz * ((
        ((2.0 * tex_S_Color_16.xyz) * tex_S_Color_16.w)
       + 1.0) - tex_S_Color_16.w));
      colorBlendLightMap_15 = tmpvar_24;
      if ((_LigthMapIntPingPong > 0.0)) {
        highp float tmpvar_25;
        tmpvar_25 = abs((fract(
          (_Time.y * _Speed)
        ) - 0.5));
        colorBlendLightMap_15 = (tmpvar_24 * ((tmpvar_25 * _Magnitude) + _MinValue));
      } else {
        colorBlendLightMap_15 = (colorBlendLightMap_15 * _LightMapIntensity);
      };
      outColor_9.xyz = mix (colorBlendLightMap_15, tmpvar_5.xyz, tmpvar_5.www);
      outColor_9.w = _BloomFactor;
      tmpvar_6 = outColor_9;
      tmpvar_7 = bool(1);
      break;
    };
  };
  if (!(tmpvar_7)) {
    discard;
    tmpvar_6 = outColor_9;
    tmpvar_7 = bool(1);
  };
  gl_FragData[0] = tmpvar_6;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp float sint_2;
  highp float cost_3;
  highp vec3 adjCamPos_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_11.xz - ((tmpvar_11.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = cos(_CamRotate);
  cost_3 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin(_CamRotate);
  sint_2 = tmpvar_14;
  highp mat2 tmpvar_15;
  tmpvar_15[0].x = cost_3;
  tmpvar_15[0].y = -(sint_2);
  tmpvar_15[1].x = sint_2;
  tmpvar_15[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_15 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _Color;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _MainTex_ST;
uniform sampler2D _ShadowTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _ScaleTime;
uniform mediump float _UMin;
uniform mediump float _UMax;
uniform mediump float _LigthMapIntPingPong;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_1 = xlv_TEXCOORD0;
  tmpvar_2 = xlv_TEXCOORD1;
  tmpvar_3 = xlv_TEXCOORD2;
  tmpvar_4 = xlv_TEXCOORD3;
  tmpvar_5 = xlv_COLOR1;
  mediump vec4 tmpvar_6;
  bool tmpvar_7;
  tmpvar_7 = bool(0);
  mediump vec4 outColor_9;
  outColor_9 = vec4(0.0, 0.0, 0.0, 0.0);
  for (highp int i_8 = 0; i_8 < 20; i_8++) {
    highp float time_10;
    time_10 = _ScaleTime;
    highp float width_11;
    mediump float tmpvar_12;
    tmpvar_12 = (((_UMax - _UMin) / 2.0) / 20.0);
    width_11 = tmpvar_12;
    highp float tmpvar_13;
    tmpvar_13 = ((_UMin + (
      (float(i_8) * width_11)
     * 2.0)) + width_11);
    highp vec4 tmpvar_14;
    tmpvar_14.zw = vec2(0.0, 0.0);
    tmpvar_14.x = (tmpvar_13 - (width_11 * time_10));
    tmpvar_14.y = (tmpvar_13 + (width_11 * time_10));
    if ((((tmpvar_14.x + _MainTex_ST.z) <= tmpvar_1.x) && (tmpvar_1.x <= (tmpvar_14.y + _MainTex_ST.z)))) {
      mediump vec3 colorBlendLightMap_15;
      mediump vec4 tex_S_Color_16;
      mediump float reflectMask_17;
      mediump vec4 tex_C_Color_18;
      lowp vec4 tmpvar_19;
      tmpvar_19 = texture2D (_MainTex, tmpvar_1);
      tex_C_Color_18 = tmpvar_19;
      lowp float tmpvar_20;
      tmpvar_20 = texture2D (_ReflectMaskTex, tmpvar_1).x;
      reflectMask_17 = tmpvar_20;
      lowp vec4 tmpvar_21;
      tmpvar_21 = texture2D (_ShadowTex, tmpvar_2);
      tex_S_Color_16 = tmpvar_21;
      tex_C_Color_18.xyz = (tex_C_Color_18.xyz * _Color.xyz);
      mediump vec3 tmpvar_22;
      tmpvar_22 = (tmpvar_4 - (2.0 * (
        dot (tmpvar_3, tmpvar_4)
       * tmpvar_3)));
      lowp vec4 tmpvar_23;
      tmpvar_23 = textureCube (_EnvTex, tmpvar_22);
      tex_C_Color_18.xyz = (tex_C_Color_18.xyz + ((tmpvar_23.xyz * reflectMask_17) * _Reflectivity));
      mediump vec3 tmpvar_24;
      tmpvar_24 = (tex_C_Color_18.xyz * ((
        ((2.0 * tex_S_Color_16.xyz) * tex_S_Color_16.w)
       + 1.0) - tex_S_Color_16.w));
      colorBlendLightMap_15 = tmpvar_24;
      if ((_LigthMapIntPingPong > 0.0)) {
        highp float tmpvar_25;
        tmpvar_25 = abs((fract(
          (_Time.y * _Speed)
        ) - 0.5));
        colorBlendLightMap_15 = (tmpvar_24 * ((tmpvar_25 * _Magnitude) + _MinValue));
      } else {
        colorBlendLightMap_15 = (colorBlendLightMap_15 * _LightMapIntensity);
      };
      outColor_9.xyz = mix (colorBlendLightMap_15, tmpvar_5.xyz, tmpvar_5.www);
      outColor_9.w = _BloomFactor;
      tmpvar_6 = outColor_9;
      tmpvar_7 = bool(1);
      break;
    };
  };
  if (!(tmpvar_7)) {
    discard;
    tmpvar_6 = outColor_9;
    tmpvar_7 = bool(1);
  };
  gl_FragData[0] = tmpvar_6;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp float sint_2;
  highp float cost_3;
  highp vec3 adjCamPos_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_11.xz - ((tmpvar_11.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = cos(_CamRotate);
  cost_3 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin(_CamRotate);
  sint_2 = tmpvar_14;
  highp mat2 tmpvar_15;
  tmpvar_15[0].x = cost_3;
  tmpvar_15[0].y = -(sint_2);
  tmpvar_15[1].x = sint_2;
  tmpvar_15[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_15 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _Color;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _MainTex_ST;
uniform sampler2D _ShadowTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _ScaleTime;
uniform mediump float _UMin;
uniform mediump float _UMax;
uniform mediump float _LigthMapIntPingPong;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_1 = xlv_TEXCOORD0;
  tmpvar_2 = xlv_TEXCOORD1;
  tmpvar_3 = xlv_TEXCOORD2;
  tmpvar_4 = xlv_TEXCOORD3;
  tmpvar_5 = xlv_COLOR1;
  mediump vec4 tmpvar_6;
  bool tmpvar_7;
  tmpvar_7 = bool(0);
  mediump vec4 outColor_9;
  outColor_9 = vec4(0.0, 0.0, 0.0, 0.0);
  for (highp int i_8 = 0; i_8 < 20; i_8++) {
    highp float time_10;
    time_10 = _ScaleTime;
    highp float width_11;
    mediump float tmpvar_12;
    tmpvar_12 = (((_UMax - _UMin) / 2.0) / 20.0);
    width_11 = tmpvar_12;
    highp float tmpvar_13;
    tmpvar_13 = ((_UMin + (
      (float(i_8) * width_11)
     * 2.0)) + width_11);
    highp vec4 tmpvar_14;
    tmpvar_14.zw = vec2(0.0, 0.0);
    tmpvar_14.x = (tmpvar_13 - (width_11 * time_10));
    tmpvar_14.y = (tmpvar_13 + (width_11 * time_10));
    if ((((tmpvar_14.x + _MainTex_ST.z) <= tmpvar_1.x) && (tmpvar_1.x <= (tmpvar_14.y + _MainTex_ST.z)))) {
      mediump vec3 colorBlendLightMap_15;
      mediump vec4 tex_S_Color_16;
      mediump float reflectMask_17;
      mediump vec4 tex_C_Color_18;
      lowp vec4 tmpvar_19;
      tmpvar_19 = texture2D (_MainTex, tmpvar_1);
      tex_C_Color_18 = tmpvar_19;
      lowp float tmpvar_20;
      tmpvar_20 = texture2D (_ReflectMaskTex, tmpvar_1).x;
      reflectMask_17 = tmpvar_20;
      lowp vec4 tmpvar_21;
      tmpvar_21 = texture2D (_ShadowTex, tmpvar_2);
      tex_S_Color_16 = tmpvar_21;
      tex_C_Color_18.xyz = (tex_C_Color_18.xyz * _Color.xyz);
      mediump vec3 tmpvar_22;
      tmpvar_22 = (tmpvar_4 - (2.0 * (
        dot (tmpvar_3, tmpvar_4)
       * tmpvar_3)));
      lowp vec4 tmpvar_23;
      tmpvar_23 = textureCube (_EnvTex, tmpvar_22);
      tex_C_Color_18.xyz = (tex_C_Color_18.xyz + ((tmpvar_23.xyz * reflectMask_17) * _Reflectivity));
      mediump vec3 tmpvar_24;
      tmpvar_24 = (tex_C_Color_18.xyz * ((
        ((2.0 * tex_S_Color_16.xyz) * tex_S_Color_16.w)
       + 1.0) - tex_S_Color_16.w));
      colorBlendLightMap_15 = tmpvar_24;
      if ((_LigthMapIntPingPong > 0.0)) {
        highp float tmpvar_25;
        tmpvar_25 = abs((fract(
          (_Time.y * _Speed)
        ) - 0.5));
        colorBlendLightMap_15 = (tmpvar_24 * ((tmpvar_25 * _Magnitude) + _MinValue));
      } else {
        colorBlendLightMap_15 = (colorBlendLightMap_15 * _LightMapIntensity);
      };
      outColor_9.xyz = mix (colorBlendLightMap_15, tmpvar_5.xyz, tmpvar_5.www);
      outColor_9.w = _BloomFactor;
      tmpvar_6 = outColor_9;
      tmpvar_7 = bool(1);
      break;
    };
  };
  if (!(tmpvar_7)) {
    discard;
    tmpvar_6 = outColor_9;
    tmpvar_7 = bool(1);
  };
  gl_FragData[0] = tmpvar_6;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp float sint_2;
  highp float cost_3;
  highp vec3 adjCamPos_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_11.xz - ((tmpvar_11.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = cos(_CamRotate);
  cost_3 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin(_CamRotate);
  sint_2 = tmpvar_14;
  highp mat2 tmpvar_15;
  tmpvar_15[0].x = cost_3;
  tmpvar_15[0].y = -(sint_2);
  tmpvar_15[1].x = sint_2;
  tmpvar_15[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_15 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _Color;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _MainTex_ST;
uniform sampler2D _ShadowTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _ScaleTime;
uniform mediump float _UMin;
uniform mediump float _UMax;
uniform mediump float _LigthMapIntPingPong;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_1 = xlv_TEXCOORD0;
  tmpvar_2 = xlv_TEXCOORD1;
  tmpvar_3 = xlv_TEXCOORD2;
  tmpvar_4 = xlv_TEXCOORD3;
  tmpvar_5 = xlv_COLOR1;
  mediump vec4 tmpvar_6;
  bool tmpvar_7;
  tmpvar_7 = bool(0);
  mediump vec4 outColor_9;
  outColor_9 = vec4(0.0, 0.0, 0.0, 0.0);
  for (highp int i_8 = 0; i_8 < 20; i_8++) {
    highp float time_10;
    time_10 = _ScaleTime;
    highp float width_11;
    mediump float tmpvar_12;
    tmpvar_12 = (((_UMax - _UMin) / 2.0) / 20.0);
    width_11 = tmpvar_12;
    highp float tmpvar_13;
    tmpvar_13 = ((_UMin + (
      (float(i_8) * width_11)
     * 2.0)) + width_11);
    highp vec4 tmpvar_14;
    tmpvar_14.zw = vec2(0.0, 0.0);
    tmpvar_14.x = (tmpvar_13 - (width_11 * time_10));
    tmpvar_14.y = (tmpvar_13 + (width_11 * time_10));
    if ((((tmpvar_14.x + _MainTex_ST.z) <= tmpvar_1.x) && (tmpvar_1.x <= (tmpvar_14.y + _MainTex_ST.z)))) {
      mediump vec3 colorBlendLightMap_15;
      mediump vec4 tex_S_Color_16;
      mediump float reflectMask_17;
      mediump vec4 tex_C_Color_18;
      lowp vec4 tmpvar_19;
      tmpvar_19 = texture2D (_MainTex, tmpvar_1);
      tex_C_Color_18 = tmpvar_19;
      lowp float tmpvar_20;
      tmpvar_20 = texture2D (_ReflectMaskTex, tmpvar_1).x;
      reflectMask_17 = tmpvar_20;
      lowp vec4 tmpvar_21;
      tmpvar_21 = texture2D (_ShadowTex, tmpvar_2);
      tex_S_Color_16 = tmpvar_21;
      tex_C_Color_18.xyz = (tex_C_Color_18.xyz * _Color.xyz);
      mediump vec3 tmpvar_22;
      tmpvar_22 = (tmpvar_4 - (2.0 * (
        dot (tmpvar_3, tmpvar_4)
       * tmpvar_3)));
      lowp vec4 tmpvar_23;
      tmpvar_23 = textureCube (_EnvTex, tmpvar_22);
      tex_C_Color_18.xyz = (tex_C_Color_18.xyz + ((tmpvar_23.xyz * reflectMask_17) * _Reflectivity));
      mediump vec3 tmpvar_24;
      tmpvar_24 = (tex_C_Color_18.xyz * ((
        ((2.0 * tex_S_Color_16.xyz) * tex_S_Color_16.w)
       + 1.0) - tex_S_Color_16.w));
      colorBlendLightMap_15 = tmpvar_24;
      if ((_LigthMapIntPingPong > 0.0)) {
        highp float tmpvar_25;
        tmpvar_25 = abs((fract(
          (_Time.y * _Speed)
        ) - 0.5));
        colorBlendLightMap_15 = (tmpvar_24 * ((tmpvar_25 * _Magnitude) + _MinValue));
      } else {
        colorBlendLightMap_15 = (colorBlendLightMap_15 * _LightMapIntensity);
      };
      outColor_9.xyz = mix (colorBlendLightMap_15, tmpvar_5.xyz, tmpvar_5.www);
      outColor_9.w = _BloomFactor;
      tmpvar_6 = outColor_9;
      tmpvar_7 = bool(1);
      break;
    };
  };
  if (!(tmpvar_7)) {
    discard;
    tmpvar_6 = outColor_9;
    tmpvar_7 = bool(1);
  };
  gl_FragData[0] = tmpvar_6;
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
Fallback "Diffuse"
}