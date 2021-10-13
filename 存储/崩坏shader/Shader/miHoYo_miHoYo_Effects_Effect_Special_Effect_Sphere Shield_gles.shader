//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Special/Effect/Sphere Shield" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_RingTex ("Ring Texture 1", 2D) = "black" { }
_RingColor ("Ring Color", Color) = (1,1,1,1)
_RingUScale ("Ring U Scale", Float) = 1
_RingVScale ("Ring V Scale", Float) = 1
_RingUFadeWidth ("Ring U Fade Width", Float) = 0
_RingCrossLightIntensity ("Ring Cross Light Intensity", Float) = 50
_RingCrossLightShininess ("Ring Cross Light Shininess", Float) = 2
_RingEulerAngles1 ("Ring Euler Angles 1", Vector) = (0,0,0,0)
_RingEulerAngles2 ("Ring Euler Angles 2", Vector) = (0,0,0,0)
_RingEulerAngles3 ("Ring Euler Angles 3", Vector) = (0,0,0,0)
_BloomFactor ("Bloom Factor", Float) = 1
_FresnelParams ("Fresnel", Vector) = (1,0,0,0)
_Culling ("Culling (0: Off, 1: Front, 2: Back)", Float) = 2
_CellShrink ("Cell Shrink", Float) = 0
_CellRimShininess ("Cell Rim Shininess", Float) = 8
_CellRimIntensity ("Cell Rim Intensity", Float) = 0.4
_HitPosition ("Hit Position (local space)", Vector) = (0,0,0,0)
_HitDistRange ("Hit Dist Range", Float) = 0
_HitDistSmoothRange ("Hit Dist Smooth Range", Float) = 0
_HitAnmStartTime ("Hit Animation Start Time", Float) = 0
_HitAnmEndTime ("Hit Animation End Time", Float) = 0
_BandPosition ("Band Position (rotate dir and angle)", Vector) = (1,1,0,1.57)
_BandWidth ("Band Width", Float) = 0
_BandIntensity ("Band Intensity", Float) = 0
_Params ("Params", Vector) = (0,0,0,0)
_Params2 ("Params2", Vector) = (0,0,0,0)
_Params3 ("Params3", Vector) = (0,0,0,0)
}
SubShader {
 LOD 200
 Tags { "OutlineType" = "None" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "None" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Front
  GpuProgramID 32066
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump float _RingUScale;
uniform mediump float _RingVScale;
uniform mediump float _RingUFadeWidth;
uniform mediump vec4 _RingEulerAngles1;
uniform mediump vec4 _RingEulerAngles2;
uniform mediump vec4 _RingEulerAngles3;
uniform mediump float _CellShrink;
uniform mediump vec4 _HitPosition;
uniform mediump float _HitDistRange;
uniform mediump float _HitDistSmoothRange;
uniform mediump float _HitAnmStartTime;
uniform mediump float _HitAnmEndTime;
uniform mediump vec4 _BandPosition;
uniform mediump float _BandWidth;
uniform mediump float _BandIntensity;
uniform mediump vec4 _Params2;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  highp vec4 tmpvar_2;
  tmpvar_2 = _glesVertex;
  mediump vec3 vertDir_3;
  mediump vec3 cellNormal_4;
  mediump float hitDist_5;
  mediump vec2 tmpvar_6;
  mediump vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  mediump vec4 tmpvar_9;
  mediump vec2 tmpvar_10;
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  tmpvar_10.y = 0.0;
  tmpvar_6 = tmpvar_1.xy;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_11[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_11[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11 * _glesVertex.xyz));
  tmpvar_7 = -(tmpvar_12);
  highp float tmpvar_13;
  tmpvar_13 = max (dot (fract(
    (sin((_glesNormal * vec3(12.9898, 78.233, 45.5432))) * 43758.55)
  ), vec3(1.0, 1.0, 1.0)), 0.5);
  tmpvar_9 = ((_glesColor * _Color) * tmpvar_13);
  mediump vec4 tmpvar_14;
  tmpvar_14 = normalize(_HitPosition);
  highp float tmpvar_15;
  highp vec3 x_16;
  x_16 = (_glesNormal - tmpvar_14.xyz);
  tmpvar_15 = sqrt(dot (x_16, x_16));
  hitDist_5 = tmpvar_15;
  mediump float tmpvar_17;
  tmpvar_17 = (_HitDistRange * _HitAnmStartTime);
  mediump float tmpvar_18;
  tmpvar_18 = clamp (((hitDist_5 - tmpvar_17) / (
    (tmpvar_17 + _HitDistSmoothRange)
   - tmpvar_17)), 0.0, 1.0);
  tmpvar_10.x = (((1.0 - 
    (tmpvar_18 * (tmpvar_18 * (3.0 - (2.0 * tmpvar_18))))
  ) * _Params2.z) * clamp ((1.0 - _HitAnmEndTime), 0.0, 1.0));
  tmpvar_9 = (tmpvar_9 + (_Color * tmpvar_10.x));
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(_glesNormal);
  cellNormal_4 = tmpvar_19;
  mediump vec3 tmpvar_20;
  tmpvar_20 = ((vec3(1.0, 0.0, 0.0) * _BandPosition.zxy) - (vec3(0.0, 0.0, 1.0) * _BandPosition.yzx));
  mediump float tmpvar_21;
  tmpvar_21 = dot (cellNormal_4, normalize((
    (_BandPosition.yzx * tmpvar_20.zxy)
   - 
    (_BandPosition.zxy * tmpvar_20.yzx)
  )));
  mediump float tmpvar_22;
  tmpvar_22 = clamp ((abs(
    cos(((1.570796 - (
      sign(tmpvar_21)
     * 
      (1.570796 - (sqrt((1.0 - 
        abs(tmpvar_21)
      )) * (1.570796 + (
        abs(tmpvar_21)
       * 
        (-0.2146018 + (abs(tmpvar_21) * (0.08656672 + (
          abs(tmpvar_21)
         * -0.03102955))))
      ))))
    )) - _BandPosition.w))
  ) / _BandWidth), 0.0, 1.0);
  tmpvar_10.y = ((1.0 - (tmpvar_22 * 
    (tmpvar_22 * (3.0 - (2.0 * tmpvar_22)))
  )) * _BandIntensity);
  tmpvar_9 = (tmpvar_9 + (_Color * tmpvar_10.y));
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize(_glesVertex.xyz);
  vertDir_3 = tmpvar_23;
  mediump vec3 vertDir_24;
  mediump vec3 ret_25;
  ret_25.xz = vec2(0.0, 0.0);
  mediump mat3 m_26;
  m_26 = mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
  mediump float tmpvar_27;
  tmpvar_27 = cos(_RingEulerAngles1.x);
  mediump float tmpvar_28;
  tmpvar_28 = sin(_RingEulerAngles1.x);
  mediump float tmpvar_29;
  tmpvar_29 = cos(_RingEulerAngles1.y);
  mediump float tmpvar_30;
  tmpvar_30 = sin(_RingEulerAngles1.y);
  mediump float tmpvar_31;
  tmpvar_31 = cos(_RingEulerAngles1.z);
  mediump float tmpvar_32;
  tmpvar_32 = sin(_RingEulerAngles1.z);
  mediump vec3 tmpvar_33;
  tmpvar_33.yz = vec2(0.0, 0.0);
  tmpvar_33.x = (tmpvar_27 * tmpvar_29);
  m_26[0] = tmpvar_33;
  mediump vec3 tmpvar_34;
  tmpvar_34.xz = m_26[0].xz;
  tmpvar_34.y = ((tmpvar_28 * tmpvar_32) - ((tmpvar_27 * tmpvar_30) * tmpvar_31));
  m_26[0] = tmpvar_34;
  mediump vec3 tmpvar_35;
  tmpvar_35.xy = m_26[0].xy;
  tmpvar_35.z = (((tmpvar_27 * tmpvar_30) * tmpvar_32) + (tmpvar_28 * tmpvar_31));
  m_26[0] = tmpvar_35;
  mediump vec3 tmpvar_36;
  tmpvar_36.yz = m_26[1].yz;
  tmpvar_36.x = tmpvar_30;
  m_26[1] = tmpvar_36;
  mediump vec3 tmpvar_37;
  tmpvar_37.xz = m_26[1].xz;
  tmpvar_37.y = (tmpvar_29 * tmpvar_31);
  m_26[1] = tmpvar_37;
  mediump vec3 tmpvar_38;
  tmpvar_38.xy = m_26[1].xy;
  tmpvar_38.z = (-(tmpvar_29) * tmpvar_32);
  m_26[1] = tmpvar_38;
  mediump vec3 tmpvar_39;
  tmpvar_39.yz = m_26[2].yz;
  tmpvar_39.x = (-(tmpvar_28) * tmpvar_29);
  m_26[2] = tmpvar_39;
  mediump vec3 tmpvar_40;
  tmpvar_40.xz = m_26[2].xz;
  tmpvar_40.y = (((tmpvar_28 * tmpvar_30) * tmpvar_31) + (tmpvar_27 * tmpvar_32));
  m_26[2] = tmpvar_40;
  mediump vec3 tmpvar_41;
  tmpvar_41.xy = m_26[2].xy;
  tmpvar_41.z = (((
    -(tmpvar_28)
   * tmpvar_30) * tmpvar_32) + (tmpvar_27 * tmpvar_31));
  m_26[2] = tmpvar_41;
  vertDir_24 = (m_26 * vertDir_3);
  ret_25.y = ((1.570796 - (
    sign(vertDir_24.z)
   * 
    (1.570796 - (sqrt((1.0 - 
      abs(vertDir_24.z)
    )) * (1.570796 + (
      abs(vertDir_24.z)
     * 
      (-0.2146018 + (abs(vertDir_24.z) * (0.08656672 + (
        abs(vertDir_24.z)
       * -0.03102955))))
    ))))
  )) * 0.31831);
  ret_25.y = (((ret_25.y - 0.5) * _RingVScale) + 0.5);
  ret_25.y = clamp (ret_25.y, 0.0, 1.0);
  mediump float tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = (min (abs(
    (vertDir_24.y / vertDir_24.x)
  ), 1.0) / max (abs(
    (vertDir_24.y / vertDir_24.x)
  ), 1.0));
  mediump float tmpvar_44;
  tmpvar_44 = (tmpvar_43 * tmpvar_43);
  tmpvar_44 = (((
    ((((
      ((((-0.01213232 * tmpvar_44) + 0.05368138) * tmpvar_44) - 0.1173503)
     * tmpvar_44) + 0.1938925) * tmpvar_44) - 0.3326756)
   * tmpvar_44) + 0.9999793) * tmpvar_43);
  tmpvar_44 = (tmpvar_44 + (float(
    (abs((vertDir_24.y / vertDir_24.x)) > 1.0)
  ) * (
    (tmpvar_44 * -2.0)
   + 1.570796)));
  tmpvar_42 = (tmpvar_44 * sign((vertDir_24.y / vertDir_24.x)));
  if ((abs(vertDir_24.x) > (1e-08 * abs(vertDir_24.y)))) {
    if ((vertDir_24.x < 0.0)) {
      if ((vertDir_24.y >= 0.0)) {
        tmpvar_42 += 3.141593;
      } else {
        tmpvar_42 = (tmpvar_42 - 3.141593);
      };
    };
  } else {
    tmpvar_42 = (sign(vertDir_24.y) * 1.570796);
  };
  ret_25.x = (tmpvar_42 * 0.15915);
  mediump float tmpvar_45;
  tmpvar_45 = clamp (((0.5 - 
    abs(ret_25.x)
  ) / _RingUFadeWidth), 0.0, 1.0);
  ret_25.z = (tmpvar_45 * (tmpvar_45 * (3.0 - 
    (2.0 * tmpvar_45)
  )));
  ret_25.x = (ret_25.x * _RingUScale);
  ret_25.x = (ret_25.x + _RingEulerAngles1.w);
  mediump vec3 vertDir_46;
  mediump vec3 ret_47;
  ret_47.xz = vec2(0.0, 0.0);
  mediump mat3 m_48;
  m_48 = mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
  mediump float tmpvar_49;
  tmpvar_49 = cos(_RingEulerAngles2.x);
  mediump float tmpvar_50;
  tmpvar_50 = sin(_RingEulerAngles2.x);
  mediump float tmpvar_51;
  tmpvar_51 = cos(_RingEulerAngles2.y);
  mediump float tmpvar_52;
  tmpvar_52 = sin(_RingEulerAngles2.y);
  mediump float tmpvar_53;
  tmpvar_53 = cos(_RingEulerAngles2.z);
  mediump float tmpvar_54;
  tmpvar_54 = sin(_RingEulerAngles2.z);
  mediump vec3 tmpvar_55;
  tmpvar_55.yz = vec2(0.0, 0.0);
  tmpvar_55.x = (tmpvar_49 * tmpvar_51);
  m_48[0] = tmpvar_55;
  mediump vec3 tmpvar_56;
  tmpvar_56.xz = m_48[0].xz;
  tmpvar_56.y = ((tmpvar_50 * tmpvar_54) - ((tmpvar_49 * tmpvar_52) * tmpvar_53));
  m_48[0] = tmpvar_56;
  mediump vec3 tmpvar_57;
  tmpvar_57.xy = m_48[0].xy;
  tmpvar_57.z = (((tmpvar_49 * tmpvar_52) * tmpvar_54) + (tmpvar_50 * tmpvar_53));
  m_48[0] = tmpvar_57;
  mediump vec3 tmpvar_58;
  tmpvar_58.yz = m_48[1].yz;
  tmpvar_58.x = tmpvar_52;
  m_48[1] = tmpvar_58;
  mediump vec3 tmpvar_59;
  tmpvar_59.xz = m_48[1].xz;
  tmpvar_59.y = (tmpvar_51 * tmpvar_53);
  m_48[1] = tmpvar_59;
  mediump vec3 tmpvar_60;
  tmpvar_60.xy = m_48[1].xy;
  tmpvar_60.z = (-(tmpvar_51) * tmpvar_54);
  m_48[1] = tmpvar_60;
  mediump vec3 tmpvar_61;
  tmpvar_61.yz = m_48[2].yz;
  tmpvar_61.x = (-(tmpvar_50) * tmpvar_51);
  m_48[2] = tmpvar_61;
  mediump vec3 tmpvar_62;
  tmpvar_62.xz = m_48[2].xz;
  tmpvar_62.y = (((tmpvar_50 * tmpvar_52) * tmpvar_53) + (tmpvar_49 * tmpvar_54));
  m_48[2] = tmpvar_62;
  mediump vec3 tmpvar_63;
  tmpvar_63.xy = m_48[2].xy;
  tmpvar_63.z = (((
    -(tmpvar_50)
   * tmpvar_52) * tmpvar_54) + (tmpvar_49 * tmpvar_53));
  m_48[2] = tmpvar_63;
  vertDir_46 = (m_48 * vertDir_3);
  ret_47.y = ((1.570796 - (
    sign(vertDir_46.z)
   * 
    (1.570796 - (sqrt((1.0 - 
      abs(vertDir_46.z)
    )) * (1.570796 + (
      abs(vertDir_46.z)
     * 
      (-0.2146018 + (abs(vertDir_46.z) * (0.08656672 + (
        abs(vertDir_46.z)
       * -0.03102955))))
    ))))
  )) * 0.31831);
  ret_47.y = (((ret_47.y - 0.5) * _RingVScale) + 0.5);
  ret_47.y = clamp (ret_47.y, 0.0, 1.0);
  mediump float tmpvar_64;
  mediump float tmpvar_65;
  tmpvar_65 = (min (abs(
    (vertDir_46.y / vertDir_46.x)
  ), 1.0) / max (abs(
    (vertDir_46.y / vertDir_46.x)
  ), 1.0));
  mediump float tmpvar_66;
  tmpvar_66 = (tmpvar_65 * tmpvar_65);
  tmpvar_66 = (((
    ((((
      ((((-0.01213232 * tmpvar_66) + 0.05368138) * tmpvar_66) - 0.1173503)
     * tmpvar_66) + 0.1938925) * tmpvar_66) - 0.3326756)
   * tmpvar_66) + 0.9999793) * tmpvar_65);
  tmpvar_66 = (tmpvar_66 + (float(
    (abs((vertDir_46.y / vertDir_46.x)) > 1.0)
  ) * (
    (tmpvar_66 * -2.0)
   + 1.570796)));
  tmpvar_64 = (tmpvar_66 * sign((vertDir_46.y / vertDir_46.x)));
  if ((abs(vertDir_46.x) > (1e-08 * abs(vertDir_46.y)))) {
    if ((vertDir_46.x < 0.0)) {
      if ((vertDir_46.y >= 0.0)) {
        tmpvar_64 += 3.141593;
      } else {
        tmpvar_64 = (tmpvar_64 - 3.141593);
      };
    };
  } else {
    tmpvar_64 = (sign(vertDir_46.y) * 1.570796);
  };
  ret_47.x = (tmpvar_64 * 0.15915);
  mediump float tmpvar_67;
  tmpvar_67 = clamp (((0.5 - 
    abs(ret_47.x)
  ) / _RingUFadeWidth), 0.0, 1.0);
  ret_47.z = (tmpvar_67 * (tmpvar_67 * (3.0 - 
    (2.0 * tmpvar_67)
  )));
  ret_47.x = (ret_47.x * _RingUScale);
  ret_47.x = (ret_47.x + _RingEulerAngles2.w);
  mediump vec3 vertDir_68;
  mediump vec3 ret_69;
  ret_69.xz = vec2(0.0, 0.0);
  mediump mat3 m_70;
  m_70 = mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
  mediump float tmpvar_71;
  tmpvar_71 = cos(_RingEulerAngles3.x);
  mediump float tmpvar_72;
  tmpvar_72 = sin(_RingEulerAngles3.x);
  mediump float tmpvar_73;
  tmpvar_73 = cos(_RingEulerAngles3.y);
  mediump float tmpvar_74;
  tmpvar_74 = sin(_RingEulerAngles3.y);
  mediump float tmpvar_75;
  tmpvar_75 = cos(_RingEulerAngles3.z);
  mediump float tmpvar_76;
  tmpvar_76 = sin(_RingEulerAngles3.z);
  mediump vec3 tmpvar_77;
  tmpvar_77.yz = vec2(0.0, 0.0);
  tmpvar_77.x = (tmpvar_71 * tmpvar_73);
  m_70[0] = tmpvar_77;
  mediump vec3 tmpvar_78;
  tmpvar_78.xz = m_70[0].xz;
  tmpvar_78.y = ((tmpvar_72 * tmpvar_76) - ((tmpvar_71 * tmpvar_74) * tmpvar_75));
  m_70[0] = tmpvar_78;
  mediump vec3 tmpvar_79;
  tmpvar_79.xy = m_70[0].xy;
  tmpvar_79.z = (((tmpvar_71 * tmpvar_74) * tmpvar_76) + (tmpvar_72 * tmpvar_75));
  m_70[0] = tmpvar_79;
  mediump vec3 tmpvar_80;
  tmpvar_80.yz = m_70[1].yz;
  tmpvar_80.x = tmpvar_74;
  m_70[1] = tmpvar_80;
  mediump vec3 tmpvar_81;
  tmpvar_81.xz = m_70[1].xz;
  tmpvar_81.y = (tmpvar_73 * tmpvar_75);
  m_70[1] = tmpvar_81;
  mediump vec3 tmpvar_82;
  tmpvar_82.xy = m_70[1].xy;
  tmpvar_82.z = (-(tmpvar_73) * tmpvar_76);
  m_70[1] = tmpvar_82;
  mediump vec3 tmpvar_83;
  tmpvar_83.yz = m_70[2].yz;
  tmpvar_83.x = (-(tmpvar_72) * tmpvar_73);
  m_70[2] = tmpvar_83;
  mediump vec3 tmpvar_84;
  tmpvar_84.xz = m_70[2].xz;
  tmpvar_84.y = (((tmpvar_72 * tmpvar_74) * tmpvar_75) + (tmpvar_71 * tmpvar_76));
  m_70[2] = tmpvar_84;
  mediump vec3 tmpvar_85;
  tmpvar_85.xy = m_70[2].xy;
  tmpvar_85.z = (((
    -(tmpvar_72)
   * tmpvar_74) * tmpvar_76) + (tmpvar_71 * tmpvar_75));
  m_70[2] = tmpvar_85;
  vertDir_68 = (m_70 * vertDir_3);
  ret_69.y = ((1.570796 - (
    sign(vertDir_68.z)
   * 
    (1.570796 - (sqrt((1.0 - 
      abs(vertDir_68.z)
    )) * (1.570796 + (
      abs(vertDir_68.z)
     * 
      (-0.2146018 + (abs(vertDir_68.z) * (0.08656672 + (
        abs(vertDir_68.z)
       * -0.03102955))))
    ))))
  )) * 0.31831);
  ret_69.y = (((ret_69.y - 0.5) * _RingVScale) + 0.5);
  ret_69.y = clamp (ret_69.y, 0.0, 1.0);
  mediump float tmpvar_86;
  mediump float tmpvar_87;
  tmpvar_87 = (min (abs(
    (vertDir_68.y / vertDir_68.x)
  ), 1.0) / max (abs(
    (vertDir_68.y / vertDir_68.x)
  ), 1.0));
  mediump float tmpvar_88;
  tmpvar_88 = (tmpvar_87 * tmpvar_87);
  tmpvar_88 = (((
    ((((
      ((((-0.01213232 * tmpvar_88) + 0.05368138) * tmpvar_88) - 0.1173503)
     * tmpvar_88) + 0.1938925) * tmpvar_88) - 0.3326756)
   * tmpvar_88) + 0.9999793) * tmpvar_87);
  tmpvar_88 = (tmpvar_88 + (float(
    (abs((vertDir_68.y / vertDir_68.x)) > 1.0)
  ) * (
    (tmpvar_88 * -2.0)
   + 1.570796)));
  tmpvar_86 = (tmpvar_88 * sign((vertDir_68.y / vertDir_68.x)));
  if ((abs(vertDir_68.x) > (1e-08 * abs(vertDir_68.y)))) {
    if ((vertDir_68.x < 0.0)) {
      if ((vertDir_68.y >= 0.0)) {
        tmpvar_86 += 3.141593;
      } else {
        tmpvar_86 = (tmpvar_86 - 3.141593);
      };
    };
  } else {
    tmpvar_86 = (sign(vertDir_68.y) * 1.570796);
  };
  ret_69.x = (tmpvar_86 * 0.15915);
  mediump float tmpvar_89;
  tmpvar_89 = clamp (((0.5 - 
    abs(ret_69.x)
  ) / _RingUFadeWidth), 0.0, 1.0);
  ret_69.z = (tmpvar_89 * (tmpvar_89 * (3.0 - 
    (2.0 * tmpvar_89)
  )));
  ret_69.x = (ret_69.x * _RingUScale);
  ret_69.x = (ret_69.x + _RingEulerAngles3.w);
  mediump float tmpvar_90;
  mediump float tmpvar_91;
  tmpvar_91 = (tmpvar_10.y * 0.004);
  tmpvar_90 = (tmpvar_91 * tmpvar_91);
  tmpvar_2.xyz = (_glesVertex.xyz + ((_glesNormal - _glesVertex.xyz) * (
    (_CellShrink * 0.01)
   + tmpvar_90)));
  highp vec4 tmpvar_92;
  tmpvar_92.w = 1.0;
  tmpvar_92.xyz = tmpvar_2.xyz;
  highp vec4 tmpvar_93;
  tmpvar_93 = (unity_ObjectToWorld * tmpvar_2);
  tmpvar_8 = (tmpvar_93.xyz / tmpvar_93.w);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_92));
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_COLOR0 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = ret_25;
  xlv_TEXCOORD5 = ret_47;
  xlv_TEXCOORD6 = ret_69;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _RingTex;
uniform mediump vec4 _RingColor;
uniform mediump float _RingCrossLightIntensity;
uniform mediump float _RingCrossLightShininess;
uniform mediump vec4 _FresnelParams;
uniform mediump float _CellRimShininess;
uniform mediump float _CellRimIntensity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  mediump float ringCrossIntensity_1;
  mediump vec2 texCol3_2;
  mediump vec2 texCol2_3;
  mediump vec2 texCol1_4;
  mediump float ringIntensity_5;
  mediump vec3 I_6;
  mediump float intensity_7;
  mediump vec4 color_8;
  color_8.w = 0.0;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  I_6 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_6, xlv_TEXCOORD1)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  intensity_7 = (xlv_COLOR0.w + tmpvar_10);
  intensity_7 = (intensity_7 + ((
    pow (xlv_TEXCOORD0.x, _CellRimShininess)
   * xlv_COLOR0.xyz) * (
    ((tmpvar_10 * _CellRimIntensity) + (xlv_TEXCOORD3.x * 0.01))
   + 
    (xlv_TEXCOORD3.y * 0.05)
  )).x);
  color_8.xyz = (intensity_7 * xlv_COLOR0.xyz);
  lowp vec2 tmpvar_11;
  tmpvar_11 = texture2D (_RingTex, xlv_TEXCOORD4.xy).xy;
  texCol1_4 = tmpvar_11;
  lowp vec2 tmpvar_12;
  tmpvar_12 = texture2D (_RingTex, xlv_TEXCOORD5.xy).xy;
  texCol2_3 = tmpvar_12;
  lowp vec2 tmpvar_13;
  tmpvar_13 = texture2D (_RingTex, xlv_TEXCOORD6.xy).xy;
  texCol3_2 = tmpvar_13;
  ringIntensity_5 = (texCol1_4.x * xlv_TEXCOORD4.z);
  ringIntensity_5 = (ringIntensity_5 + (texCol2_3.x * xlv_TEXCOORD5.z));
  ringIntensity_5 = (ringIntensity_5 + (texCol3_2.x * xlv_TEXCOORD6.z));
  mediump float tmpvar_14;
  tmpvar_14 = (texCol1_4.y * texCol2_3.y);
  mediump float tmpvar_15;
  tmpvar_15 = (texCol2_3.y * texCol3_2.y);
  mediump float tmpvar_16;
  tmpvar_16 = (texCol3_2.y * texCol1_4.y);
  ringCrossIntensity_1 = ((tmpvar_14 + tmpvar_15) - (tmpvar_14 * tmpvar_15));
  ringCrossIntensity_1 = ((ringCrossIntensity_1 + tmpvar_16) - (ringCrossIntensity_1 * tmpvar_16));
  ringIntensity_5 = (ringIntensity_5 + (pow (ringCrossIntensity_1, _RingCrossLightShininess) * _RingCrossLightIntensity));
  color_8.xyz = (color_8.xyz + (ringIntensity_5 * (_RingColor.xyz * _RingColor.w)));
  gl_FragData[0] = color_8;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump float _RingUScale;
uniform mediump float _RingVScale;
uniform mediump float _RingUFadeWidth;
uniform mediump vec4 _RingEulerAngles1;
uniform mediump vec4 _RingEulerAngles2;
uniform mediump vec4 _RingEulerAngles3;
uniform mediump float _CellShrink;
uniform mediump vec4 _HitPosition;
uniform mediump float _HitDistRange;
uniform mediump float _HitDistSmoothRange;
uniform mediump float _HitAnmStartTime;
uniform mediump float _HitAnmEndTime;
uniform mediump vec4 _BandPosition;
uniform mediump float _BandWidth;
uniform mediump float _BandIntensity;
uniform mediump vec4 _Params2;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  highp vec4 tmpvar_2;
  tmpvar_2 = _glesVertex;
  mediump vec3 vertDir_3;
  mediump vec3 cellNormal_4;
  mediump float hitDist_5;
  mediump vec2 tmpvar_6;
  mediump vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  mediump vec4 tmpvar_9;
  mediump vec2 tmpvar_10;
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  tmpvar_10.y = 0.0;
  tmpvar_6 = tmpvar_1.xy;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_11[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_11[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11 * _glesVertex.xyz));
  tmpvar_7 = -(tmpvar_12);
  highp float tmpvar_13;
  tmpvar_13 = max (dot (fract(
    (sin((_glesNormal * vec3(12.9898, 78.233, 45.5432))) * 43758.55)
  ), vec3(1.0, 1.0, 1.0)), 0.5);
  tmpvar_9 = ((_glesColor * _Color) * tmpvar_13);
  mediump vec4 tmpvar_14;
  tmpvar_14 = normalize(_HitPosition);
  highp float tmpvar_15;
  highp vec3 x_16;
  x_16 = (_glesNormal - tmpvar_14.xyz);
  tmpvar_15 = sqrt(dot (x_16, x_16));
  hitDist_5 = tmpvar_15;
  mediump float tmpvar_17;
  tmpvar_17 = (_HitDistRange * _HitAnmStartTime);
  mediump float tmpvar_18;
  tmpvar_18 = clamp (((hitDist_5 - tmpvar_17) / (
    (tmpvar_17 + _HitDistSmoothRange)
   - tmpvar_17)), 0.0, 1.0);
  tmpvar_10.x = (((1.0 - 
    (tmpvar_18 * (tmpvar_18 * (3.0 - (2.0 * tmpvar_18))))
  ) * _Params2.z) * clamp ((1.0 - _HitAnmEndTime), 0.0, 1.0));
  tmpvar_9 = (tmpvar_9 + (_Color * tmpvar_10.x));
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(_glesNormal);
  cellNormal_4 = tmpvar_19;
  mediump vec3 tmpvar_20;
  tmpvar_20 = ((vec3(1.0, 0.0, 0.0) * _BandPosition.zxy) - (vec3(0.0, 0.0, 1.0) * _BandPosition.yzx));
  mediump float tmpvar_21;
  tmpvar_21 = dot (cellNormal_4, normalize((
    (_BandPosition.yzx * tmpvar_20.zxy)
   - 
    (_BandPosition.zxy * tmpvar_20.yzx)
  )));
  mediump float tmpvar_22;
  tmpvar_22 = clamp ((abs(
    cos(((1.570796 - (
      sign(tmpvar_21)
     * 
      (1.570796 - (sqrt((1.0 - 
        abs(tmpvar_21)
      )) * (1.570796 + (
        abs(tmpvar_21)
       * 
        (-0.2146018 + (abs(tmpvar_21) * (0.08656672 + (
          abs(tmpvar_21)
         * -0.03102955))))
      ))))
    )) - _BandPosition.w))
  ) / _BandWidth), 0.0, 1.0);
  tmpvar_10.y = ((1.0 - (tmpvar_22 * 
    (tmpvar_22 * (3.0 - (2.0 * tmpvar_22)))
  )) * _BandIntensity);
  tmpvar_9 = (tmpvar_9 + (_Color * tmpvar_10.y));
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize(_glesVertex.xyz);
  vertDir_3 = tmpvar_23;
  mediump vec3 vertDir_24;
  mediump vec3 ret_25;
  ret_25.xz = vec2(0.0, 0.0);
  mediump mat3 m_26;
  m_26 = mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
  mediump float tmpvar_27;
  tmpvar_27 = cos(_RingEulerAngles1.x);
  mediump float tmpvar_28;
  tmpvar_28 = sin(_RingEulerAngles1.x);
  mediump float tmpvar_29;
  tmpvar_29 = cos(_RingEulerAngles1.y);
  mediump float tmpvar_30;
  tmpvar_30 = sin(_RingEulerAngles1.y);
  mediump float tmpvar_31;
  tmpvar_31 = cos(_RingEulerAngles1.z);
  mediump float tmpvar_32;
  tmpvar_32 = sin(_RingEulerAngles1.z);
  mediump vec3 tmpvar_33;
  tmpvar_33.yz = vec2(0.0, 0.0);
  tmpvar_33.x = (tmpvar_27 * tmpvar_29);
  m_26[0] = tmpvar_33;
  mediump vec3 tmpvar_34;
  tmpvar_34.xz = m_26[0].xz;
  tmpvar_34.y = ((tmpvar_28 * tmpvar_32) - ((tmpvar_27 * tmpvar_30) * tmpvar_31));
  m_26[0] = tmpvar_34;
  mediump vec3 tmpvar_35;
  tmpvar_35.xy = m_26[0].xy;
  tmpvar_35.z = (((tmpvar_27 * tmpvar_30) * tmpvar_32) + (tmpvar_28 * tmpvar_31));
  m_26[0] = tmpvar_35;
  mediump vec3 tmpvar_36;
  tmpvar_36.yz = m_26[1].yz;
  tmpvar_36.x = tmpvar_30;
  m_26[1] = tmpvar_36;
  mediump vec3 tmpvar_37;
  tmpvar_37.xz = m_26[1].xz;
  tmpvar_37.y = (tmpvar_29 * tmpvar_31);
  m_26[1] = tmpvar_37;
  mediump vec3 tmpvar_38;
  tmpvar_38.xy = m_26[1].xy;
  tmpvar_38.z = (-(tmpvar_29) * tmpvar_32);
  m_26[1] = tmpvar_38;
  mediump vec3 tmpvar_39;
  tmpvar_39.yz = m_26[2].yz;
  tmpvar_39.x = (-(tmpvar_28) * tmpvar_29);
  m_26[2] = tmpvar_39;
  mediump vec3 tmpvar_40;
  tmpvar_40.xz = m_26[2].xz;
  tmpvar_40.y = (((tmpvar_28 * tmpvar_30) * tmpvar_31) + (tmpvar_27 * tmpvar_32));
  m_26[2] = tmpvar_40;
  mediump vec3 tmpvar_41;
  tmpvar_41.xy = m_26[2].xy;
  tmpvar_41.z = (((
    -(tmpvar_28)
   * tmpvar_30) * tmpvar_32) + (tmpvar_27 * tmpvar_31));
  m_26[2] = tmpvar_41;
  vertDir_24 = (m_26 * vertDir_3);
  ret_25.y = ((1.570796 - (
    sign(vertDir_24.z)
   * 
    (1.570796 - (sqrt((1.0 - 
      abs(vertDir_24.z)
    )) * (1.570796 + (
      abs(vertDir_24.z)
     * 
      (-0.2146018 + (abs(vertDir_24.z) * (0.08656672 + (
        abs(vertDir_24.z)
       * -0.03102955))))
    ))))
  )) * 0.31831);
  ret_25.y = (((ret_25.y - 0.5) * _RingVScale) + 0.5);
  ret_25.y = clamp (ret_25.y, 0.0, 1.0);
  mediump float tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = (min (abs(
    (vertDir_24.y / vertDir_24.x)
  ), 1.0) / max (abs(
    (vertDir_24.y / vertDir_24.x)
  ), 1.0));
  mediump float tmpvar_44;
  tmpvar_44 = (tmpvar_43 * tmpvar_43);
  tmpvar_44 = (((
    ((((
      ((((-0.01213232 * tmpvar_44) + 0.05368138) * tmpvar_44) - 0.1173503)
     * tmpvar_44) + 0.1938925) * tmpvar_44) - 0.3326756)
   * tmpvar_44) + 0.9999793) * tmpvar_43);
  tmpvar_44 = (tmpvar_44 + (float(
    (abs((vertDir_24.y / vertDir_24.x)) > 1.0)
  ) * (
    (tmpvar_44 * -2.0)
   + 1.570796)));
  tmpvar_42 = (tmpvar_44 * sign((vertDir_24.y / vertDir_24.x)));
  if ((abs(vertDir_24.x) > (1e-08 * abs(vertDir_24.y)))) {
    if ((vertDir_24.x < 0.0)) {
      if ((vertDir_24.y >= 0.0)) {
        tmpvar_42 += 3.141593;
      } else {
        tmpvar_42 = (tmpvar_42 - 3.141593);
      };
    };
  } else {
    tmpvar_42 = (sign(vertDir_24.y) * 1.570796);
  };
  ret_25.x = (tmpvar_42 * 0.15915);
  mediump float tmpvar_45;
  tmpvar_45 = clamp (((0.5 - 
    abs(ret_25.x)
  ) / _RingUFadeWidth), 0.0, 1.0);
  ret_25.z = (tmpvar_45 * (tmpvar_45 * (3.0 - 
    (2.0 * tmpvar_45)
  )));
  ret_25.x = (ret_25.x * _RingUScale);
  ret_25.x = (ret_25.x + _RingEulerAngles1.w);
  mediump vec3 vertDir_46;
  mediump vec3 ret_47;
  ret_47.xz = vec2(0.0, 0.0);
  mediump mat3 m_48;
  m_48 = mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
  mediump float tmpvar_49;
  tmpvar_49 = cos(_RingEulerAngles2.x);
  mediump float tmpvar_50;
  tmpvar_50 = sin(_RingEulerAngles2.x);
  mediump float tmpvar_51;
  tmpvar_51 = cos(_RingEulerAngles2.y);
  mediump float tmpvar_52;
  tmpvar_52 = sin(_RingEulerAngles2.y);
  mediump float tmpvar_53;
  tmpvar_53 = cos(_RingEulerAngles2.z);
  mediump float tmpvar_54;
  tmpvar_54 = sin(_RingEulerAngles2.z);
  mediump vec3 tmpvar_55;
  tmpvar_55.yz = vec2(0.0, 0.0);
  tmpvar_55.x = (tmpvar_49 * tmpvar_51);
  m_48[0] = tmpvar_55;
  mediump vec3 tmpvar_56;
  tmpvar_56.xz = m_48[0].xz;
  tmpvar_56.y = ((tmpvar_50 * tmpvar_54) - ((tmpvar_49 * tmpvar_52) * tmpvar_53));
  m_48[0] = tmpvar_56;
  mediump vec3 tmpvar_57;
  tmpvar_57.xy = m_48[0].xy;
  tmpvar_57.z = (((tmpvar_49 * tmpvar_52) * tmpvar_54) + (tmpvar_50 * tmpvar_53));
  m_48[0] = tmpvar_57;
  mediump vec3 tmpvar_58;
  tmpvar_58.yz = m_48[1].yz;
  tmpvar_58.x = tmpvar_52;
  m_48[1] = tmpvar_58;
  mediump vec3 tmpvar_59;
  tmpvar_59.xz = m_48[1].xz;
  tmpvar_59.y = (tmpvar_51 * tmpvar_53);
  m_48[1] = tmpvar_59;
  mediump vec3 tmpvar_60;
  tmpvar_60.xy = m_48[1].xy;
  tmpvar_60.z = (-(tmpvar_51) * tmpvar_54);
  m_48[1] = tmpvar_60;
  mediump vec3 tmpvar_61;
  tmpvar_61.yz = m_48[2].yz;
  tmpvar_61.x = (-(tmpvar_50) * tmpvar_51);
  m_48[2] = tmpvar_61;
  mediump vec3 tmpvar_62;
  tmpvar_62.xz = m_48[2].xz;
  tmpvar_62.y = (((tmpvar_50 * tmpvar_52) * tmpvar_53) + (tmpvar_49 * tmpvar_54));
  m_48[2] = tmpvar_62;
  mediump vec3 tmpvar_63;
  tmpvar_63.xy = m_48[2].xy;
  tmpvar_63.z = (((
    -(tmpvar_50)
   * tmpvar_52) * tmpvar_54) + (tmpvar_49 * tmpvar_53));
  m_48[2] = tmpvar_63;
  vertDir_46 = (m_48 * vertDir_3);
  ret_47.y = ((1.570796 - (
    sign(vertDir_46.z)
   * 
    (1.570796 - (sqrt((1.0 - 
      abs(vertDir_46.z)
    )) * (1.570796 + (
      abs(vertDir_46.z)
     * 
      (-0.2146018 + (abs(vertDir_46.z) * (0.08656672 + (
        abs(vertDir_46.z)
       * -0.03102955))))
    ))))
  )) * 0.31831);
  ret_47.y = (((ret_47.y - 0.5) * _RingVScale) + 0.5);
  ret_47.y = clamp (ret_47.y, 0.0, 1.0);
  mediump float tmpvar_64;
  mediump float tmpvar_65;
  tmpvar_65 = (min (abs(
    (vertDir_46.y / vertDir_46.x)
  ), 1.0) / max (abs(
    (vertDir_46.y / vertDir_46.x)
  ), 1.0));
  mediump float tmpvar_66;
  tmpvar_66 = (tmpvar_65 * tmpvar_65);
  tmpvar_66 = (((
    ((((
      ((((-0.01213232 * tmpvar_66) + 0.05368138) * tmpvar_66) - 0.1173503)
     * tmpvar_66) + 0.1938925) * tmpvar_66) - 0.3326756)
   * tmpvar_66) + 0.9999793) * tmpvar_65);
  tmpvar_66 = (tmpvar_66 + (float(
    (abs((vertDir_46.y / vertDir_46.x)) > 1.0)
  ) * (
    (tmpvar_66 * -2.0)
   + 1.570796)));
  tmpvar_64 = (tmpvar_66 * sign((vertDir_46.y / vertDir_46.x)));
  if ((abs(vertDir_46.x) > (1e-08 * abs(vertDir_46.y)))) {
    if ((vertDir_46.x < 0.0)) {
      if ((vertDir_46.y >= 0.0)) {
        tmpvar_64 += 3.141593;
      } else {
        tmpvar_64 = (tmpvar_64 - 3.141593);
      };
    };
  } else {
    tmpvar_64 = (sign(vertDir_46.y) * 1.570796);
  };
  ret_47.x = (tmpvar_64 * 0.15915);
  mediump float tmpvar_67;
  tmpvar_67 = clamp (((0.5 - 
    abs(ret_47.x)
  ) / _RingUFadeWidth), 0.0, 1.0);
  ret_47.z = (tmpvar_67 * (tmpvar_67 * (3.0 - 
    (2.0 * tmpvar_67)
  )));
  ret_47.x = (ret_47.x * _RingUScale);
  ret_47.x = (ret_47.x + _RingEulerAngles2.w);
  mediump vec3 vertDir_68;
  mediump vec3 ret_69;
  ret_69.xz = vec2(0.0, 0.0);
  mediump mat3 m_70;
  m_70 = mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
  mediump float tmpvar_71;
  tmpvar_71 = cos(_RingEulerAngles3.x);
  mediump float tmpvar_72;
  tmpvar_72 = sin(_RingEulerAngles3.x);
  mediump float tmpvar_73;
  tmpvar_73 = cos(_RingEulerAngles3.y);
  mediump float tmpvar_74;
  tmpvar_74 = sin(_RingEulerAngles3.y);
  mediump float tmpvar_75;
  tmpvar_75 = cos(_RingEulerAngles3.z);
  mediump float tmpvar_76;
  tmpvar_76 = sin(_RingEulerAngles3.z);
  mediump vec3 tmpvar_77;
  tmpvar_77.yz = vec2(0.0, 0.0);
  tmpvar_77.x = (tmpvar_71 * tmpvar_73);
  m_70[0] = tmpvar_77;
  mediump vec3 tmpvar_78;
  tmpvar_78.xz = m_70[0].xz;
  tmpvar_78.y = ((tmpvar_72 * tmpvar_76) - ((tmpvar_71 * tmpvar_74) * tmpvar_75));
  m_70[0] = tmpvar_78;
  mediump vec3 tmpvar_79;
  tmpvar_79.xy = m_70[0].xy;
  tmpvar_79.z = (((tmpvar_71 * tmpvar_74) * tmpvar_76) + (tmpvar_72 * tmpvar_75));
  m_70[0] = tmpvar_79;
  mediump vec3 tmpvar_80;
  tmpvar_80.yz = m_70[1].yz;
  tmpvar_80.x = tmpvar_74;
  m_70[1] = tmpvar_80;
  mediump vec3 tmpvar_81;
  tmpvar_81.xz = m_70[1].xz;
  tmpvar_81.y = (tmpvar_73 * tmpvar_75);
  m_70[1] = tmpvar_81;
  mediump vec3 tmpvar_82;
  tmpvar_82.xy = m_70[1].xy;
  tmpvar_82.z = (-(tmpvar_73) * tmpvar_76);
  m_70[1] = tmpvar_82;
  mediump vec3 tmpvar_83;
  tmpvar_83.yz = m_70[2].yz;
  tmpvar_83.x = (-(tmpvar_72) * tmpvar_73);
  m_70[2] = tmpvar_83;
  mediump vec3 tmpvar_84;
  tmpvar_84.xz = m_70[2].xz;
  tmpvar_84.y = (((tmpvar_72 * tmpvar_74) * tmpvar_75) + (tmpvar_71 * tmpvar_76));
  m_70[2] = tmpvar_84;
  mediump vec3 tmpvar_85;
  tmpvar_85.xy = m_70[2].xy;
  tmpvar_85.z = (((
    -(tmpvar_72)
   * tmpvar_74) * tmpvar_76) + (tmpvar_71 * tmpvar_75));
  m_70[2] = tmpvar_85;
  vertDir_68 = (m_70 * vertDir_3);
  ret_69.y = ((1.570796 - (
    sign(vertDir_68.z)
   * 
    (1.570796 - (sqrt((1.0 - 
      abs(vertDir_68.z)
    )) * (1.570796 + (
      abs(vertDir_68.z)
     * 
      (-0.2146018 + (abs(vertDir_68.z) * (0.08656672 + (
        abs(vertDir_68.z)
       * -0.03102955))))
    ))))
  )) * 0.31831);
  ret_69.y = (((ret_69.y - 0.5) * _RingVScale) + 0.5);
  ret_69.y = clamp (ret_69.y, 0.0, 1.0);
  mediump float tmpvar_86;
  mediump float tmpvar_87;
  tmpvar_87 = (min (abs(
    (vertDir_68.y / vertDir_68.x)
  ), 1.0) / max (abs(
    (vertDir_68.y / vertDir_68.x)
  ), 1.0));
  mediump float tmpvar_88;
  tmpvar_88 = (tmpvar_87 * tmpvar_87);
  tmpvar_88 = (((
    ((((
      ((((-0.01213232 * tmpvar_88) + 0.05368138) * tmpvar_88) - 0.1173503)
     * tmpvar_88) + 0.1938925) * tmpvar_88) - 0.3326756)
   * tmpvar_88) + 0.9999793) * tmpvar_87);
  tmpvar_88 = (tmpvar_88 + (float(
    (abs((vertDir_68.y / vertDir_68.x)) > 1.0)
  ) * (
    (tmpvar_88 * -2.0)
   + 1.570796)));
  tmpvar_86 = (tmpvar_88 * sign((vertDir_68.y / vertDir_68.x)));
  if ((abs(vertDir_68.x) > (1e-08 * abs(vertDir_68.y)))) {
    if ((vertDir_68.x < 0.0)) {
      if ((vertDir_68.y >= 0.0)) {
        tmpvar_86 += 3.141593;
      } else {
        tmpvar_86 = (tmpvar_86 - 3.141593);
      };
    };
  } else {
    tmpvar_86 = (sign(vertDir_68.y) * 1.570796);
  };
  ret_69.x = (tmpvar_86 * 0.15915);
  mediump float tmpvar_89;
  tmpvar_89 = clamp (((0.5 - 
    abs(ret_69.x)
  ) / _RingUFadeWidth), 0.0, 1.0);
  ret_69.z = (tmpvar_89 * (tmpvar_89 * (3.0 - 
    (2.0 * tmpvar_89)
  )));
  ret_69.x = (ret_69.x * _RingUScale);
  ret_69.x = (ret_69.x + _RingEulerAngles3.w);
  mediump float tmpvar_90;
  mediump float tmpvar_91;
  tmpvar_91 = (tmpvar_10.y * 0.004);
  tmpvar_90 = (tmpvar_91 * tmpvar_91);
  tmpvar_2.xyz = (_glesVertex.xyz + ((_glesNormal - _glesVertex.xyz) * (
    (_CellShrink * 0.01)
   + tmpvar_90)));
  highp vec4 tmpvar_92;
  tmpvar_92.w = 1.0;
  tmpvar_92.xyz = tmpvar_2.xyz;
  highp vec4 tmpvar_93;
  tmpvar_93 = (unity_ObjectToWorld * tmpvar_2);
  tmpvar_8 = (tmpvar_93.xyz / tmpvar_93.w);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_92));
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_COLOR0 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = ret_25;
  xlv_TEXCOORD5 = ret_47;
  xlv_TEXCOORD6 = ret_69;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _RingTex;
uniform mediump vec4 _RingColor;
uniform mediump float _RingCrossLightIntensity;
uniform mediump float _RingCrossLightShininess;
uniform mediump vec4 _FresnelParams;
uniform mediump float _CellRimShininess;
uniform mediump float _CellRimIntensity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  mediump float ringCrossIntensity_1;
  mediump vec2 texCol3_2;
  mediump vec2 texCol2_3;
  mediump vec2 texCol1_4;
  mediump float ringIntensity_5;
  mediump vec3 I_6;
  mediump float intensity_7;
  mediump vec4 color_8;
  color_8.w = 0.0;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  I_6 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_6, xlv_TEXCOORD1)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  intensity_7 = (xlv_COLOR0.w + tmpvar_10);
  intensity_7 = (intensity_7 + ((
    pow (xlv_TEXCOORD0.x, _CellRimShininess)
   * xlv_COLOR0.xyz) * (
    ((tmpvar_10 * _CellRimIntensity) + (xlv_TEXCOORD3.x * 0.01))
   + 
    (xlv_TEXCOORD3.y * 0.05)
  )).x);
  color_8.xyz = (intensity_7 * xlv_COLOR0.xyz);
  lowp vec2 tmpvar_11;
  tmpvar_11 = texture2D (_RingTex, xlv_TEXCOORD4.xy).xy;
  texCol1_4 = tmpvar_11;
  lowp vec2 tmpvar_12;
  tmpvar_12 = texture2D (_RingTex, xlv_TEXCOORD5.xy).xy;
  texCol2_3 = tmpvar_12;
  lowp vec2 tmpvar_13;
  tmpvar_13 = texture2D (_RingTex, xlv_TEXCOORD6.xy).xy;
  texCol3_2 = tmpvar_13;
  ringIntensity_5 = (texCol1_4.x * xlv_TEXCOORD4.z);
  ringIntensity_5 = (ringIntensity_5 + (texCol2_3.x * xlv_TEXCOORD5.z));
  ringIntensity_5 = (ringIntensity_5 + (texCol3_2.x * xlv_TEXCOORD6.z));
  mediump float tmpvar_14;
  tmpvar_14 = (texCol1_4.y * texCol2_3.y);
  mediump float tmpvar_15;
  tmpvar_15 = (texCol2_3.y * texCol3_2.y);
  mediump float tmpvar_16;
  tmpvar_16 = (texCol3_2.y * texCol1_4.y);
  ringCrossIntensity_1 = ((tmpvar_14 + tmpvar_15) - (tmpvar_14 * tmpvar_15));
  ringCrossIntensity_1 = ((ringCrossIntensity_1 + tmpvar_16) - (ringCrossIntensity_1 * tmpvar_16));
  ringIntensity_5 = (ringIntensity_5 + (pow (ringCrossIntensity_1, _RingCrossLightShininess) * _RingCrossLightIntensity));
  color_8.xyz = (color_8.xyz + (ringIntensity_5 * (_RingColor.xyz * _RingColor.w)));
  gl_FragData[0] = color_8;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump float _RingUScale;
uniform mediump float _RingVScale;
uniform mediump float _RingUFadeWidth;
uniform mediump vec4 _RingEulerAngles1;
uniform mediump vec4 _RingEulerAngles2;
uniform mediump vec4 _RingEulerAngles3;
uniform mediump float _CellShrink;
uniform mediump vec4 _HitPosition;
uniform mediump float _HitDistRange;
uniform mediump float _HitDistSmoothRange;
uniform mediump float _HitAnmStartTime;
uniform mediump float _HitAnmEndTime;
uniform mediump vec4 _BandPosition;
uniform mediump float _BandWidth;
uniform mediump float _BandIntensity;
uniform mediump vec4 _Params2;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  highp vec4 tmpvar_2;
  tmpvar_2 = _glesVertex;
  mediump vec3 vertDir_3;
  mediump vec3 cellNormal_4;
  mediump float hitDist_5;
  mediump vec2 tmpvar_6;
  mediump vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  mediump vec4 tmpvar_9;
  mediump vec2 tmpvar_10;
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  tmpvar_10.y = 0.0;
  tmpvar_6 = tmpvar_1.xy;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_11[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_11[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11 * _glesVertex.xyz));
  tmpvar_7 = -(tmpvar_12);
  highp float tmpvar_13;
  tmpvar_13 = max (dot (fract(
    (sin((_glesNormal * vec3(12.9898, 78.233, 45.5432))) * 43758.55)
  ), vec3(1.0, 1.0, 1.0)), 0.5);
  tmpvar_9 = ((_glesColor * _Color) * tmpvar_13);
  mediump vec4 tmpvar_14;
  tmpvar_14 = normalize(_HitPosition);
  highp float tmpvar_15;
  highp vec3 x_16;
  x_16 = (_glesNormal - tmpvar_14.xyz);
  tmpvar_15 = sqrt(dot (x_16, x_16));
  hitDist_5 = tmpvar_15;
  mediump float tmpvar_17;
  tmpvar_17 = (_HitDistRange * _HitAnmStartTime);
  mediump float tmpvar_18;
  tmpvar_18 = clamp (((hitDist_5 - tmpvar_17) / (
    (tmpvar_17 + _HitDistSmoothRange)
   - tmpvar_17)), 0.0, 1.0);
  tmpvar_10.x = (((1.0 - 
    (tmpvar_18 * (tmpvar_18 * (3.0 - (2.0 * tmpvar_18))))
  ) * _Params2.z) * clamp ((1.0 - _HitAnmEndTime), 0.0, 1.0));
  tmpvar_9 = (tmpvar_9 + (_Color * tmpvar_10.x));
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(_glesNormal);
  cellNormal_4 = tmpvar_19;
  mediump vec3 tmpvar_20;
  tmpvar_20 = ((vec3(1.0, 0.0, 0.0) * _BandPosition.zxy) - (vec3(0.0, 0.0, 1.0) * _BandPosition.yzx));
  mediump float tmpvar_21;
  tmpvar_21 = dot (cellNormal_4, normalize((
    (_BandPosition.yzx * tmpvar_20.zxy)
   - 
    (_BandPosition.zxy * tmpvar_20.yzx)
  )));
  mediump float tmpvar_22;
  tmpvar_22 = clamp ((abs(
    cos(((1.570796 - (
      sign(tmpvar_21)
     * 
      (1.570796 - (sqrt((1.0 - 
        abs(tmpvar_21)
      )) * (1.570796 + (
        abs(tmpvar_21)
       * 
        (-0.2146018 + (abs(tmpvar_21) * (0.08656672 + (
          abs(tmpvar_21)
         * -0.03102955))))
      ))))
    )) - _BandPosition.w))
  ) / _BandWidth), 0.0, 1.0);
  tmpvar_10.y = ((1.0 - (tmpvar_22 * 
    (tmpvar_22 * (3.0 - (2.0 * tmpvar_22)))
  )) * _BandIntensity);
  tmpvar_9 = (tmpvar_9 + (_Color * tmpvar_10.y));
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize(_glesVertex.xyz);
  vertDir_3 = tmpvar_23;
  mediump vec3 vertDir_24;
  mediump vec3 ret_25;
  ret_25.xz = vec2(0.0, 0.0);
  mediump mat3 m_26;
  m_26 = mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
  mediump float tmpvar_27;
  tmpvar_27 = cos(_RingEulerAngles1.x);
  mediump float tmpvar_28;
  tmpvar_28 = sin(_RingEulerAngles1.x);
  mediump float tmpvar_29;
  tmpvar_29 = cos(_RingEulerAngles1.y);
  mediump float tmpvar_30;
  tmpvar_30 = sin(_RingEulerAngles1.y);
  mediump float tmpvar_31;
  tmpvar_31 = cos(_RingEulerAngles1.z);
  mediump float tmpvar_32;
  tmpvar_32 = sin(_RingEulerAngles1.z);
  mediump vec3 tmpvar_33;
  tmpvar_33.yz = vec2(0.0, 0.0);
  tmpvar_33.x = (tmpvar_27 * tmpvar_29);
  m_26[0] = tmpvar_33;
  mediump vec3 tmpvar_34;
  tmpvar_34.xz = m_26[0].xz;
  tmpvar_34.y = ((tmpvar_28 * tmpvar_32) - ((tmpvar_27 * tmpvar_30) * tmpvar_31));
  m_26[0] = tmpvar_34;
  mediump vec3 tmpvar_35;
  tmpvar_35.xy = m_26[0].xy;
  tmpvar_35.z = (((tmpvar_27 * tmpvar_30) * tmpvar_32) + (tmpvar_28 * tmpvar_31));
  m_26[0] = tmpvar_35;
  mediump vec3 tmpvar_36;
  tmpvar_36.yz = m_26[1].yz;
  tmpvar_36.x = tmpvar_30;
  m_26[1] = tmpvar_36;
  mediump vec3 tmpvar_37;
  tmpvar_37.xz = m_26[1].xz;
  tmpvar_37.y = (tmpvar_29 * tmpvar_31);
  m_26[1] = tmpvar_37;
  mediump vec3 tmpvar_38;
  tmpvar_38.xy = m_26[1].xy;
  tmpvar_38.z = (-(tmpvar_29) * tmpvar_32);
  m_26[1] = tmpvar_38;
  mediump vec3 tmpvar_39;
  tmpvar_39.yz = m_26[2].yz;
  tmpvar_39.x = (-(tmpvar_28) * tmpvar_29);
  m_26[2] = tmpvar_39;
  mediump vec3 tmpvar_40;
  tmpvar_40.xz = m_26[2].xz;
  tmpvar_40.y = (((tmpvar_28 * tmpvar_30) * tmpvar_31) + (tmpvar_27 * tmpvar_32));
  m_26[2] = tmpvar_40;
  mediump vec3 tmpvar_41;
  tmpvar_41.xy = m_26[2].xy;
  tmpvar_41.z = (((
    -(tmpvar_28)
   * tmpvar_30) * tmpvar_32) + (tmpvar_27 * tmpvar_31));
  m_26[2] = tmpvar_41;
  vertDir_24 = (m_26 * vertDir_3);
  ret_25.y = ((1.570796 - (
    sign(vertDir_24.z)
   * 
    (1.570796 - (sqrt((1.0 - 
      abs(vertDir_24.z)
    )) * (1.570796 + (
      abs(vertDir_24.z)
     * 
      (-0.2146018 + (abs(vertDir_24.z) * (0.08656672 + (
        abs(vertDir_24.z)
       * -0.03102955))))
    ))))
  )) * 0.31831);
  ret_25.y = (((ret_25.y - 0.5) * _RingVScale) + 0.5);
  ret_25.y = clamp (ret_25.y, 0.0, 1.0);
  mediump float tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = (min (abs(
    (vertDir_24.y / vertDir_24.x)
  ), 1.0) / max (abs(
    (vertDir_24.y / vertDir_24.x)
  ), 1.0));
  mediump float tmpvar_44;
  tmpvar_44 = (tmpvar_43 * tmpvar_43);
  tmpvar_44 = (((
    ((((
      ((((-0.01213232 * tmpvar_44) + 0.05368138) * tmpvar_44) - 0.1173503)
     * tmpvar_44) + 0.1938925) * tmpvar_44) - 0.3326756)
   * tmpvar_44) + 0.9999793) * tmpvar_43);
  tmpvar_44 = (tmpvar_44 + (float(
    (abs((vertDir_24.y / vertDir_24.x)) > 1.0)
  ) * (
    (tmpvar_44 * -2.0)
   + 1.570796)));
  tmpvar_42 = (tmpvar_44 * sign((vertDir_24.y / vertDir_24.x)));
  if ((abs(vertDir_24.x) > (1e-08 * abs(vertDir_24.y)))) {
    if ((vertDir_24.x < 0.0)) {
      if ((vertDir_24.y >= 0.0)) {
        tmpvar_42 += 3.141593;
      } else {
        tmpvar_42 = (tmpvar_42 - 3.141593);
      };
    };
  } else {
    tmpvar_42 = (sign(vertDir_24.y) * 1.570796);
  };
  ret_25.x = (tmpvar_42 * 0.15915);
  mediump float tmpvar_45;
  tmpvar_45 = clamp (((0.5 - 
    abs(ret_25.x)
  ) / _RingUFadeWidth), 0.0, 1.0);
  ret_25.z = (tmpvar_45 * (tmpvar_45 * (3.0 - 
    (2.0 * tmpvar_45)
  )));
  ret_25.x = (ret_25.x * _RingUScale);
  ret_25.x = (ret_25.x + _RingEulerAngles1.w);
  mediump vec3 vertDir_46;
  mediump vec3 ret_47;
  ret_47.xz = vec2(0.0, 0.0);
  mediump mat3 m_48;
  m_48 = mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
  mediump float tmpvar_49;
  tmpvar_49 = cos(_RingEulerAngles2.x);
  mediump float tmpvar_50;
  tmpvar_50 = sin(_RingEulerAngles2.x);
  mediump float tmpvar_51;
  tmpvar_51 = cos(_RingEulerAngles2.y);
  mediump float tmpvar_52;
  tmpvar_52 = sin(_RingEulerAngles2.y);
  mediump float tmpvar_53;
  tmpvar_53 = cos(_RingEulerAngles2.z);
  mediump float tmpvar_54;
  tmpvar_54 = sin(_RingEulerAngles2.z);
  mediump vec3 tmpvar_55;
  tmpvar_55.yz = vec2(0.0, 0.0);
  tmpvar_55.x = (tmpvar_49 * tmpvar_51);
  m_48[0] = tmpvar_55;
  mediump vec3 tmpvar_56;
  tmpvar_56.xz = m_48[0].xz;
  tmpvar_56.y = ((tmpvar_50 * tmpvar_54) - ((tmpvar_49 * tmpvar_52) * tmpvar_53));
  m_48[0] = tmpvar_56;
  mediump vec3 tmpvar_57;
  tmpvar_57.xy = m_48[0].xy;
  tmpvar_57.z = (((tmpvar_49 * tmpvar_52) * tmpvar_54) + (tmpvar_50 * tmpvar_53));
  m_48[0] = tmpvar_57;
  mediump vec3 tmpvar_58;
  tmpvar_58.yz = m_48[1].yz;
  tmpvar_58.x = tmpvar_52;
  m_48[1] = tmpvar_58;
  mediump vec3 tmpvar_59;
  tmpvar_59.xz = m_48[1].xz;
  tmpvar_59.y = (tmpvar_51 * tmpvar_53);
  m_48[1] = tmpvar_59;
  mediump vec3 tmpvar_60;
  tmpvar_60.xy = m_48[1].xy;
  tmpvar_60.z = (-(tmpvar_51) * tmpvar_54);
  m_48[1] = tmpvar_60;
  mediump vec3 tmpvar_61;
  tmpvar_61.yz = m_48[2].yz;
  tmpvar_61.x = (-(tmpvar_50) * tmpvar_51);
  m_48[2] = tmpvar_61;
  mediump vec3 tmpvar_62;
  tmpvar_62.xz = m_48[2].xz;
  tmpvar_62.y = (((tmpvar_50 * tmpvar_52) * tmpvar_53) + (tmpvar_49 * tmpvar_54));
  m_48[2] = tmpvar_62;
  mediump vec3 tmpvar_63;
  tmpvar_63.xy = m_48[2].xy;
  tmpvar_63.z = (((
    -(tmpvar_50)
   * tmpvar_52) * tmpvar_54) + (tmpvar_49 * tmpvar_53));
  m_48[2] = tmpvar_63;
  vertDir_46 = (m_48 * vertDir_3);
  ret_47.y = ((1.570796 - (
    sign(vertDir_46.z)
   * 
    (1.570796 - (sqrt((1.0 - 
      abs(vertDir_46.z)
    )) * (1.570796 + (
      abs(vertDir_46.z)
     * 
      (-0.2146018 + (abs(vertDir_46.z) * (0.08656672 + (
        abs(vertDir_46.z)
       * -0.03102955))))
    ))))
  )) * 0.31831);
  ret_47.y = (((ret_47.y - 0.5) * _RingVScale) + 0.5);
  ret_47.y = clamp (ret_47.y, 0.0, 1.0);
  mediump float tmpvar_64;
  mediump float tmpvar_65;
  tmpvar_65 = (min (abs(
    (vertDir_46.y / vertDir_46.x)
  ), 1.0) / max (abs(
    (vertDir_46.y / vertDir_46.x)
  ), 1.0));
  mediump float tmpvar_66;
  tmpvar_66 = (tmpvar_65 * tmpvar_65);
  tmpvar_66 = (((
    ((((
      ((((-0.01213232 * tmpvar_66) + 0.05368138) * tmpvar_66) - 0.1173503)
     * tmpvar_66) + 0.1938925) * tmpvar_66) - 0.3326756)
   * tmpvar_66) + 0.9999793) * tmpvar_65);
  tmpvar_66 = (tmpvar_66 + (float(
    (abs((vertDir_46.y / vertDir_46.x)) > 1.0)
  ) * (
    (tmpvar_66 * -2.0)
   + 1.570796)));
  tmpvar_64 = (tmpvar_66 * sign((vertDir_46.y / vertDir_46.x)));
  if ((abs(vertDir_46.x) > (1e-08 * abs(vertDir_46.y)))) {
    if ((vertDir_46.x < 0.0)) {
      if ((vertDir_46.y >= 0.0)) {
        tmpvar_64 += 3.141593;
      } else {
        tmpvar_64 = (tmpvar_64 - 3.141593);
      };
    };
  } else {
    tmpvar_64 = (sign(vertDir_46.y) * 1.570796);
  };
  ret_47.x = (tmpvar_64 * 0.15915);
  mediump float tmpvar_67;
  tmpvar_67 = clamp (((0.5 - 
    abs(ret_47.x)
  ) / _RingUFadeWidth), 0.0, 1.0);
  ret_47.z = (tmpvar_67 * (tmpvar_67 * (3.0 - 
    (2.0 * tmpvar_67)
  )));
  ret_47.x = (ret_47.x * _RingUScale);
  ret_47.x = (ret_47.x + _RingEulerAngles2.w);
  mediump vec3 vertDir_68;
  mediump vec3 ret_69;
  ret_69.xz = vec2(0.0, 0.0);
  mediump mat3 m_70;
  m_70 = mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
  mediump float tmpvar_71;
  tmpvar_71 = cos(_RingEulerAngles3.x);
  mediump float tmpvar_72;
  tmpvar_72 = sin(_RingEulerAngles3.x);
  mediump float tmpvar_73;
  tmpvar_73 = cos(_RingEulerAngles3.y);
  mediump float tmpvar_74;
  tmpvar_74 = sin(_RingEulerAngles3.y);
  mediump float tmpvar_75;
  tmpvar_75 = cos(_RingEulerAngles3.z);
  mediump float tmpvar_76;
  tmpvar_76 = sin(_RingEulerAngles3.z);
  mediump vec3 tmpvar_77;
  tmpvar_77.yz = vec2(0.0, 0.0);
  tmpvar_77.x = (tmpvar_71 * tmpvar_73);
  m_70[0] = tmpvar_77;
  mediump vec3 tmpvar_78;
  tmpvar_78.xz = m_70[0].xz;
  tmpvar_78.y = ((tmpvar_72 * tmpvar_76) - ((tmpvar_71 * tmpvar_74) * tmpvar_75));
  m_70[0] = tmpvar_78;
  mediump vec3 tmpvar_79;
  tmpvar_79.xy = m_70[0].xy;
  tmpvar_79.z = (((tmpvar_71 * tmpvar_74) * tmpvar_76) + (tmpvar_72 * tmpvar_75));
  m_70[0] = tmpvar_79;
  mediump vec3 tmpvar_80;
  tmpvar_80.yz = m_70[1].yz;
  tmpvar_80.x = tmpvar_74;
  m_70[1] = tmpvar_80;
  mediump vec3 tmpvar_81;
  tmpvar_81.xz = m_70[1].xz;
  tmpvar_81.y = (tmpvar_73 * tmpvar_75);
  m_70[1] = tmpvar_81;
  mediump vec3 tmpvar_82;
  tmpvar_82.xy = m_70[1].xy;
  tmpvar_82.z = (-(tmpvar_73) * tmpvar_76);
  m_70[1] = tmpvar_82;
  mediump vec3 tmpvar_83;
  tmpvar_83.yz = m_70[2].yz;
  tmpvar_83.x = (-(tmpvar_72) * tmpvar_73);
  m_70[2] = tmpvar_83;
  mediump vec3 tmpvar_84;
  tmpvar_84.xz = m_70[2].xz;
  tmpvar_84.y = (((tmpvar_72 * tmpvar_74) * tmpvar_75) + (tmpvar_71 * tmpvar_76));
  m_70[2] = tmpvar_84;
  mediump vec3 tmpvar_85;
  tmpvar_85.xy = m_70[2].xy;
  tmpvar_85.z = (((
    -(tmpvar_72)
   * tmpvar_74) * tmpvar_76) + (tmpvar_71 * tmpvar_75));
  m_70[2] = tmpvar_85;
  vertDir_68 = (m_70 * vertDir_3);
  ret_69.y = ((1.570796 - (
    sign(vertDir_68.z)
   * 
    (1.570796 - (sqrt((1.0 - 
      abs(vertDir_68.z)
    )) * (1.570796 + (
      abs(vertDir_68.z)
     * 
      (-0.2146018 + (abs(vertDir_68.z) * (0.08656672 + (
        abs(vertDir_68.z)
       * -0.03102955))))
    ))))
  )) * 0.31831);
  ret_69.y = (((ret_69.y - 0.5) * _RingVScale) + 0.5);
  ret_69.y = clamp (ret_69.y, 0.0, 1.0);
  mediump float tmpvar_86;
  mediump float tmpvar_87;
  tmpvar_87 = (min (abs(
    (vertDir_68.y / vertDir_68.x)
  ), 1.0) / max (abs(
    (vertDir_68.y / vertDir_68.x)
  ), 1.0));
  mediump float tmpvar_88;
  tmpvar_88 = (tmpvar_87 * tmpvar_87);
  tmpvar_88 = (((
    ((((
      ((((-0.01213232 * tmpvar_88) + 0.05368138) * tmpvar_88) - 0.1173503)
     * tmpvar_88) + 0.1938925) * tmpvar_88) - 0.3326756)
   * tmpvar_88) + 0.9999793) * tmpvar_87);
  tmpvar_88 = (tmpvar_88 + (float(
    (abs((vertDir_68.y / vertDir_68.x)) > 1.0)
  ) * (
    (tmpvar_88 * -2.0)
   + 1.570796)));
  tmpvar_86 = (tmpvar_88 * sign((vertDir_68.y / vertDir_68.x)));
  if ((abs(vertDir_68.x) > (1e-08 * abs(vertDir_68.y)))) {
    if ((vertDir_68.x < 0.0)) {
      if ((vertDir_68.y >= 0.0)) {
        tmpvar_86 += 3.141593;
      } else {
        tmpvar_86 = (tmpvar_86 - 3.141593);
      };
    };
  } else {
    tmpvar_86 = (sign(vertDir_68.y) * 1.570796);
  };
  ret_69.x = (tmpvar_86 * 0.15915);
  mediump float tmpvar_89;
  tmpvar_89 = clamp (((0.5 - 
    abs(ret_69.x)
  ) / _RingUFadeWidth), 0.0, 1.0);
  ret_69.z = (tmpvar_89 * (tmpvar_89 * (3.0 - 
    (2.0 * tmpvar_89)
  )));
  ret_69.x = (ret_69.x * _RingUScale);
  ret_69.x = (ret_69.x + _RingEulerAngles3.w);
  mediump float tmpvar_90;
  mediump float tmpvar_91;
  tmpvar_91 = (tmpvar_10.y * 0.004);
  tmpvar_90 = (tmpvar_91 * tmpvar_91);
  tmpvar_2.xyz = (_glesVertex.xyz + ((_glesNormal - _glesVertex.xyz) * (
    (_CellShrink * 0.01)
   + tmpvar_90)));
  highp vec4 tmpvar_92;
  tmpvar_92.w = 1.0;
  tmpvar_92.xyz = tmpvar_2.xyz;
  highp vec4 tmpvar_93;
  tmpvar_93 = (unity_ObjectToWorld * tmpvar_2);
  tmpvar_8 = (tmpvar_93.xyz / tmpvar_93.w);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_92));
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_COLOR0 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = ret_25;
  xlv_TEXCOORD5 = ret_47;
  xlv_TEXCOORD6 = ret_69;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _RingTex;
uniform mediump vec4 _RingColor;
uniform mediump float _RingCrossLightIntensity;
uniform mediump float _RingCrossLightShininess;
uniform mediump vec4 _FresnelParams;
uniform mediump float _CellRimShininess;
uniform mediump float _CellRimIntensity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  mediump float ringCrossIntensity_1;
  mediump vec2 texCol3_2;
  mediump vec2 texCol2_3;
  mediump vec2 texCol1_4;
  mediump float ringIntensity_5;
  mediump vec3 I_6;
  mediump float intensity_7;
  mediump vec4 color_8;
  color_8.w = 0.0;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  I_6 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_6, xlv_TEXCOORD1)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  intensity_7 = (xlv_COLOR0.w + tmpvar_10);
  intensity_7 = (intensity_7 + ((
    pow (xlv_TEXCOORD0.x, _CellRimShininess)
   * xlv_COLOR0.xyz) * (
    ((tmpvar_10 * _CellRimIntensity) + (xlv_TEXCOORD3.x * 0.01))
   + 
    (xlv_TEXCOORD3.y * 0.05)
  )).x);
  color_8.xyz = (intensity_7 * xlv_COLOR0.xyz);
  lowp vec2 tmpvar_11;
  tmpvar_11 = texture2D (_RingTex, xlv_TEXCOORD4.xy).xy;
  texCol1_4 = tmpvar_11;
  lowp vec2 tmpvar_12;
  tmpvar_12 = texture2D (_RingTex, xlv_TEXCOORD5.xy).xy;
  texCol2_3 = tmpvar_12;
  lowp vec2 tmpvar_13;
  tmpvar_13 = texture2D (_RingTex, xlv_TEXCOORD6.xy).xy;
  texCol3_2 = tmpvar_13;
  ringIntensity_5 = (texCol1_4.x * xlv_TEXCOORD4.z);
  ringIntensity_5 = (ringIntensity_5 + (texCol2_3.x * xlv_TEXCOORD5.z));
  ringIntensity_5 = (ringIntensity_5 + (texCol3_2.x * xlv_TEXCOORD6.z));
  mediump float tmpvar_14;
  tmpvar_14 = (texCol1_4.y * texCol2_3.y);
  mediump float tmpvar_15;
  tmpvar_15 = (texCol2_3.y * texCol3_2.y);
  mediump float tmpvar_16;
  tmpvar_16 = (texCol3_2.y * texCol1_4.y);
  ringCrossIntensity_1 = ((tmpvar_14 + tmpvar_15) - (tmpvar_14 * tmpvar_15));
  ringCrossIntensity_1 = ((ringCrossIntensity_1 + tmpvar_16) - (ringCrossIntensity_1 * tmpvar_16));
  ringIntensity_5 = (ringIntensity_5 + (pow (ringCrossIntensity_1, _RingCrossLightShininess) * _RingCrossLightIntensity));
  color_8.xyz = (color_8.xyz + (ringIntensity_5 * (_RingColor.xyz * _RingColor.w)));
  gl_FragData[0] = color_8;
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
  Tags { "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "None" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 130227
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump float _RingUScale;
uniform mediump float _RingVScale;
uniform mediump float _RingUFadeWidth;
uniform mediump vec4 _RingEulerAngles1;
uniform mediump vec4 _RingEulerAngles2;
uniform mediump vec4 _RingEulerAngles3;
uniform mediump float _CellShrink;
uniform mediump vec4 _HitPosition;
uniform mediump float _HitDistRange;
uniform mediump float _HitDistSmoothRange;
uniform mediump float _HitAnmStartTime;
uniform mediump float _HitAnmEndTime;
uniform mediump vec4 _BandPosition;
uniform mediump float _BandWidth;
uniform mediump float _BandIntensity;
uniform mediump vec4 _Params2;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  highp vec4 tmpvar_2;
  tmpvar_2 = _glesVertex;
  mediump vec3 vertDir_3;
  mediump vec3 cellNormal_4;
  mediump float hitDist_5;
  mediump vec2 tmpvar_6;
  mediump vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  mediump vec4 tmpvar_9;
  mediump vec2 tmpvar_10;
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  tmpvar_10.y = 0.0;
  tmpvar_6 = tmpvar_1.xy;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_11[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_11[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11 * _glesVertex.xyz));
  tmpvar_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = max (dot (fract(
    (sin((_glesNormal * vec3(12.9898, 78.233, 45.5432))) * 43758.55)
  ), vec3(1.0, 1.0, 1.0)), 0.5);
  tmpvar_9 = ((_glesColor * _Color) * tmpvar_13);
  mediump vec4 tmpvar_14;
  tmpvar_14 = normalize(_HitPosition);
  highp float tmpvar_15;
  highp vec3 x_16;
  x_16 = (_glesNormal - tmpvar_14.xyz);
  tmpvar_15 = sqrt(dot (x_16, x_16));
  hitDist_5 = tmpvar_15;
  mediump float tmpvar_17;
  tmpvar_17 = (_HitDistRange * _HitAnmStartTime);
  mediump float tmpvar_18;
  tmpvar_18 = clamp (((hitDist_5 - tmpvar_17) / (
    (tmpvar_17 + _HitDistSmoothRange)
   - tmpvar_17)), 0.0, 1.0);
  tmpvar_10.x = (((1.0 - 
    (tmpvar_18 * (tmpvar_18 * (3.0 - (2.0 * tmpvar_18))))
  ) * _Params2.z) * clamp ((1.0 - _HitAnmEndTime), 0.0, 1.0));
  tmpvar_9 = (tmpvar_9 + (_Color * tmpvar_10.x));
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(_glesNormal);
  cellNormal_4 = tmpvar_19;
  mediump vec3 tmpvar_20;
  tmpvar_20 = ((vec3(1.0, 0.0, 0.0) * _BandPosition.zxy) - (vec3(0.0, 0.0, 1.0) * _BandPosition.yzx));
  mediump float tmpvar_21;
  tmpvar_21 = dot (cellNormal_4, normalize((
    (_BandPosition.yzx * tmpvar_20.zxy)
   - 
    (_BandPosition.zxy * tmpvar_20.yzx)
  )));
  mediump float tmpvar_22;
  tmpvar_22 = clamp ((abs(
    cos(((1.570796 - (
      sign(tmpvar_21)
     * 
      (1.570796 - (sqrt((1.0 - 
        abs(tmpvar_21)
      )) * (1.570796 + (
        abs(tmpvar_21)
       * 
        (-0.2146018 + (abs(tmpvar_21) * (0.08656672 + (
          abs(tmpvar_21)
         * -0.03102955))))
      ))))
    )) - _BandPosition.w))
  ) / _BandWidth), 0.0, 1.0);
  tmpvar_10.y = ((1.0 - (tmpvar_22 * 
    (tmpvar_22 * (3.0 - (2.0 * tmpvar_22)))
  )) * _BandIntensity);
  tmpvar_9 = (tmpvar_9 + (_Color * tmpvar_10.y));
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize(_glesVertex.xyz);
  vertDir_3 = tmpvar_23;
  mediump vec3 vertDir_24;
  mediump vec3 ret_25;
  ret_25.xz = vec2(0.0, 0.0);
  mediump mat3 m_26;
  m_26 = mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
  mediump float tmpvar_27;
  tmpvar_27 = cos(_RingEulerAngles1.x);
  mediump float tmpvar_28;
  tmpvar_28 = sin(_RingEulerAngles1.x);
  mediump float tmpvar_29;
  tmpvar_29 = cos(_RingEulerAngles1.y);
  mediump float tmpvar_30;
  tmpvar_30 = sin(_RingEulerAngles1.y);
  mediump float tmpvar_31;
  tmpvar_31 = cos(_RingEulerAngles1.z);
  mediump float tmpvar_32;
  tmpvar_32 = sin(_RingEulerAngles1.z);
  mediump vec3 tmpvar_33;
  tmpvar_33.yz = vec2(0.0, 0.0);
  tmpvar_33.x = (tmpvar_27 * tmpvar_29);
  m_26[0] = tmpvar_33;
  mediump vec3 tmpvar_34;
  tmpvar_34.xz = m_26[0].xz;
  tmpvar_34.y = ((tmpvar_28 * tmpvar_32) - ((tmpvar_27 * tmpvar_30) * tmpvar_31));
  m_26[0] = tmpvar_34;
  mediump vec3 tmpvar_35;
  tmpvar_35.xy = m_26[0].xy;
  tmpvar_35.z = (((tmpvar_27 * tmpvar_30) * tmpvar_32) + (tmpvar_28 * tmpvar_31));
  m_26[0] = tmpvar_35;
  mediump vec3 tmpvar_36;
  tmpvar_36.yz = m_26[1].yz;
  tmpvar_36.x = tmpvar_30;
  m_26[1] = tmpvar_36;
  mediump vec3 tmpvar_37;
  tmpvar_37.xz = m_26[1].xz;
  tmpvar_37.y = (tmpvar_29 * tmpvar_31);
  m_26[1] = tmpvar_37;
  mediump vec3 tmpvar_38;
  tmpvar_38.xy = m_26[1].xy;
  tmpvar_38.z = (-(tmpvar_29) * tmpvar_32);
  m_26[1] = tmpvar_38;
  mediump vec3 tmpvar_39;
  tmpvar_39.yz = m_26[2].yz;
  tmpvar_39.x = (-(tmpvar_28) * tmpvar_29);
  m_26[2] = tmpvar_39;
  mediump vec3 tmpvar_40;
  tmpvar_40.xz = m_26[2].xz;
  tmpvar_40.y = (((tmpvar_28 * tmpvar_30) * tmpvar_31) + (tmpvar_27 * tmpvar_32));
  m_26[2] = tmpvar_40;
  mediump vec3 tmpvar_41;
  tmpvar_41.xy = m_26[2].xy;
  tmpvar_41.z = (((
    -(tmpvar_28)
   * tmpvar_30) * tmpvar_32) + (tmpvar_27 * tmpvar_31));
  m_26[2] = tmpvar_41;
  vertDir_24 = (m_26 * vertDir_3);
  ret_25.y = ((1.570796 - (
    sign(vertDir_24.z)
   * 
    (1.570796 - (sqrt((1.0 - 
      abs(vertDir_24.z)
    )) * (1.570796 + (
      abs(vertDir_24.z)
     * 
      (-0.2146018 + (abs(vertDir_24.z) * (0.08656672 + (
        abs(vertDir_24.z)
       * -0.03102955))))
    ))))
  )) * 0.31831);
  ret_25.y = (((ret_25.y - 0.5) * _RingVScale) + 0.5);
  ret_25.y = clamp (ret_25.y, 0.0, 1.0);
  mediump float tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = (min (abs(
    (vertDir_24.y / vertDir_24.x)
  ), 1.0) / max (abs(
    (vertDir_24.y / vertDir_24.x)
  ), 1.0));
  mediump float tmpvar_44;
  tmpvar_44 = (tmpvar_43 * tmpvar_43);
  tmpvar_44 = (((
    ((((
      ((((-0.01213232 * tmpvar_44) + 0.05368138) * tmpvar_44) - 0.1173503)
     * tmpvar_44) + 0.1938925) * tmpvar_44) - 0.3326756)
   * tmpvar_44) + 0.9999793) * tmpvar_43);
  tmpvar_44 = (tmpvar_44 + (float(
    (abs((vertDir_24.y / vertDir_24.x)) > 1.0)
  ) * (
    (tmpvar_44 * -2.0)
   + 1.570796)));
  tmpvar_42 = (tmpvar_44 * sign((vertDir_24.y / vertDir_24.x)));
  if ((abs(vertDir_24.x) > (1e-08 * abs(vertDir_24.y)))) {
    if ((vertDir_24.x < 0.0)) {
      if ((vertDir_24.y >= 0.0)) {
        tmpvar_42 += 3.141593;
      } else {
        tmpvar_42 = (tmpvar_42 - 3.141593);
      };
    };
  } else {
    tmpvar_42 = (sign(vertDir_24.y) * 1.570796);
  };
  ret_25.x = (tmpvar_42 * 0.15915);
  mediump float tmpvar_45;
  tmpvar_45 = clamp (((0.5 - 
    abs(ret_25.x)
  ) / _RingUFadeWidth), 0.0, 1.0);
  ret_25.z = (tmpvar_45 * (tmpvar_45 * (3.0 - 
    (2.0 * tmpvar_45)
  )));
  ret_25.x = (ret_25.x * _RingUScale);
  ret_25.x = (ret_25.x + _RingEulerAngles1.w);
  mediump vec3 vertDir_46;
  mediump vec3 ret_47;
  ret_47.xz = vec2(0.0, 0.0);
  mediump mat3 m_48;
  m_48 = mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
  mediump float tmpvar_49;
  tmpvar_49 = cos(_RingEulerAngles2.x);
  mediump float tmpvar_50;
  tmpvar_50 = sin(_RingEulerAngles2.x);
  mediump float tmpvar_51;
  tmpvar_51 = cos(_RingEulerAngles2.y);
  mediump float tmpvar_52;
  tmpvar_52 = sin(_RingEulerAngles2.y);
  mediump float tmpvar_53;
  tmpvar_53 = cos(_RingEulerAngles2.z);
  mediump float tmpvar_54;
  tmpvar_54 = sin(_RingEulerAngles2.z);
  mediump vec3 tmpvar_55;
  tmpvar_55.yz = vec2(0.0, 0.0);
  tmpvar_55.x = (tmpvar_49 * tmpvar_51);
  m_48[0] = tmpvar_55;
  mediump vec3 tmpvar_56;
  tmpvar_56.xz = m_48[0].xz;
  tmpvar_56.y = ((tmpvar_50 * tmpvar_54) - ((tmpvar_49 * tmpvar_52) * tmpvar_53));
  m_48[0] = tmpvar_56;
  mediump vec3 tmpvar_57;
  tmpvar_57.xy = m_48[0].xy;
  tmpvar_57.z = (((tmpvar_49 * tmpvar_52) * tmpvar_54) + (tmpvar_50 * tmpvar_53));
  m_48[0] = tmpvar_57;
  mediump vec3 tmpvar_58;
  tmpvar_58.yz = m_48[1].yz;
  tmpvar_58.x = tmpvar_52;
  m_48[1] = tmpvar_58;
  mediump vec3 tmpvar_59;
  tmpvar_59.xz = m_48[1].xz;
  tmpvar_59.y = (tmpvar_51 * tmpvar_53);
  m_48[1] = tmpvar_59;
  mediump vec3 tmpvar_60;
  tmpvar_60.xy = m_48[1].xy;
  tmpvar_60.z = (-(tmpvar_51) * tmpvar_54);
  m_48[1] = tmpvar_60;
  mediump vec3 tmpvar_61;
  tmpvar_61.yz = m_48[2].yz;
  tmpvar_61.x = (-(tmpvar_50) * tmpvar_51);
  m_48[2] = tmpvar_61;
  mediump vec3 tmpvar_62;
  tmpvar_62.xz = m_48[2].xz;
  tmpvar_62.y = (((tmpvar_50 * tmpvar_52) * tmpvar_53) + (tmpvar_49 * tmpvar_54));
  m_48[2] = tmpvar_62;
  mediump vec3 tmpvar_63;
  tmpvar_63.xy = m_48[2].xy;
  tmpvar_63.z = (((
    -(tmpvar_50)
   * tmpvar_52) * tmpvar_54) + (tmpvar_49 * tmpvar_53));
  m_48[2] = tmpvar_63;
  vertDir_46 = (m_48 * vertDir_3);
  ret_47.y = ((1.570796 - (
    sign(vertDir_46.z)
   * 
    (1.570796 - (sqrt((1.0 - 
      abs(vertDir_46.z)
    )) * (1.570796 + (
      abs(vertDir_46.z)
     * 
      (-0.2146018 + (abs(vertDir_46.z) * (0.08656672 + (
        abs(vertDir_46.z)
       * -0.03102955))))
    ))))
  )) * 0.31831);
  ret_47.y = (((ret_47.y - 0.5) * _RingVScale) + 0.5);
  ret_47.y = clamp (ret_47.y, 0.0, 1.0);
  mediump float tmpvar_64;
  mediump float tmpvar_65;
  tmpvar_65 = (min (abs(
    (vertDir_46.y / vertDir_46.x)
  ), 1.0) / max (abs(
    (vertDir_46.y / vertDir_46.x)
  ), 1.0));
  mediump float tmpvar_66;
  tmpvar_66 = (tmpvar_65 * tmpvar_65);
  tmpvar_66 = (((
    ((((
      ((((-0.01213232 * tmpvar_66) + 0.05368138) * tmpvar_66) - 0.1173503)
     * tmpvar_66) + 0.1938925) * tmpvar_66) - 0.3326756)
   * tmpvar_66) + 0.9999793) * tmpvar_65);
  tmpvar_66 = (tmpvar_66 + (float(
    (abs((vertDir_46.y / vertDir_46.x)) > 1.0)
  ) * (
    (tmpvar_66 * -2.0)
   + 1.570796)));
  tmpvar_64 = (tmpvar_66 * sign((vertDir_46.y / vertDir_46.x)));
  if ((abs(vertDir_46.x) > (1e-08 * abs(vertDir_46.y)))) {
    if ((vertDir_46.x < 0.0)) {
      if ((vertDir_46.y >= 0.0)) {
        tmpvar_64 += 3.141593;
      } else {
        tmpvar_64 = (tmpvar_64 - 3.141593);
      };
    };
  } else {
    tmpvar_64 = (sign(vertDir_46.y) * 1.570796);
  };
  ret_47.x = (tmpvar_64 * 0.15915);
  mediump float tmpvar_67;
  tmpvar_67 = clamp (((0.5 - 
    abs(ret_47.x)
  ) / _RingUFadeWidth), 0.0, 1.0);
  ret_47.z = (tmpvar_67 * (tmpvar_67 * (3.0 - 
    (2.0 * tmpvar_67)
  )));
  ret_47.x = (ret_47.x * _RingUScale);
  ret_47.x = (ret_47.x + _RingEulerAngles2.w);
  mediump vec3 vertDir_68;
  mediump vec3 ret_69;
  ret_69.xz = vec2(0.0, 0.0);
  mediump mat3 m_70;
  m_70 = mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
  mediump float tmpvar_71;
  tmpvar_71 = cos(_RingEulerAngles3.x);
  mediump float tmpvar_72;
  tmpvar_72 = sin(_RingEulerAngles3.x);
  mediump float tmpvar_73;
  tmpvar_73 = cos(_RingEulerAngles3.y);
  mediump float tmpvar_74;
  tmpvar_74 = sin(_RingEulerAngles3.y);
  mediump float tmpvar_75;
  tmpvar_75 = cos(_RingEulerAngles3.z);
  mediump float tmpvar_76;
  tmpvar_76 = sin(_RingEulerAngles3.z);
  mediump vec3 tmpvar_77;
  tmpvar_77.yz = vec2(0.0, 0.0);
  tmpvar_77.x = (tmpvar_71 * tmpvar_73);
  m_70[0] = tmpvar_77;
  mediump vec3 tmpvar_78;
  tmpvar_78.xz = m_70[0].xz;
  tmpvar_78.y = ((tmpvar_72 * tmpvar_76) - ((tmpvar_71 * tmpvar_74) * tmpvar_75));
  m_70[0] = tmpvar_78;
  mediump vec3 tmpvar_79;
  tmpvar_79.xy = m_70[0].xy;
  tmpvar_79.z = (((tmpvar_71 * tmpvar_74) * tmpvar_76) + (tmpvar_72 * tmpvar_75));
  m_70[0] = tmpvar_79;
  mediump vec3 tmpvar_80;
  tmpvar_80.yz = m_70[1].yz;
  tmpvar_80.x = tmpvar_74;
  m_70[1] = tmpvar_80;
  mediump vec3 tmpvar_81;
  tmpvar_81.xz = m_70[1].xz;
  tmpvar_81.y = (tmpvar_73 * tmpvar_75);
  m_70[1] = tmpvar_81;
  mediump vec3 tmpvar_82;
  tmpvar_82.xy = m_70[1].xy;
  tmpvar_82.z = (-(tmpvar_73) * tmpvar_76);
  m_70[1] = tmpvar_82;
  mediump vec3 tmpvar_83;
  tmpvar_83.yz = m_70[2].yz;
  tmpvar_83.x = (-(tmpvar_72) * tmpvar_73);
  m_70[2] = tmpvar_83;
  mediump vec3 tmpvar_84;
  tmpvar_84.xz = m_70[2].xz;
  tmpvar_84.y = (((tmpvar_72 * tmpvar_74) * tmpvar_75) + (tmpvar_71 * tmpvar_76));
  m_70[2] = tmpvar_84;
  mediump vec3 tmpvar_85;
  tmpvar_85.xy = m_70[2].xy;
  tmpvar_85.z = (((
    -(tmpvar_72)
   * tmpvar_74) * tmpvar_76) + (tmpvar_71 * tmpvar_75));
  m_70[2] = tmpvar_85;
  vertDir_68 = (m_70 * vertDir_3);
  ret_69.y = ((1.570796 - (
    sign(vertDir_68.z)
   * 
    (1.570796 - (sqrt((1.0 - 
      abs(vertDir_68.z)
    )) * (1.570796 + (
      abs(vertDir_68.z)
     * 
      (-0.2146018 + (abs(vertDir_68.z) * (0.08656672 + (
        abs(vertDir_68.z)
       * -0.03102955))))
    ))))
  )) * 0.31831);
  ret_69.y = (((ret_69.y - 0.5) * _RingVScale) + 0.5);
  ret_69.y = clamp (ret_69.y, 0.0, 1.0);
  mediump float tmpvar_86;
  mediump float tmpvar_87;
  tmpvar_87 = (min (abs(
    (vertDir_68.y / vertDir_68.x)
  ), 1.0) / max (abs(
    (vertDir_68.y / vertDir_68.x)
  ), 1.0));
  mediump float tmpvar_88;
  tmpvar_88 = (tmpvar_87 * tmpvar_87);
  tmpvar_88 = (((
    ((((
      ((((-0.01213232 * tmpvar_88) + 0.05368138) * tmpvar_88) - 0.1173503)
     * tmpvar_88) + 0.1938925) * tmpvar_88) - 0.3326756)
   * tmpvar_88) + 0.9999793) * tmpvar_87);
  tmpvar_88 = (tmpvar_88 + (float(
    (abs((vertDir_68.y / vertDir_68.x)) > 1.0)
  ) * (
    (tmpvar_88 * -2.0)
   + 1.570796)));
  tmpvar_86 = (tmpvar_88 * sign((vertDir_68.y / vertDir_68.x)));
  if ((abs(vertDir_68.x) > (1e-08 * abs(vertDir_68.y)))) {
    if ((vertDir_68.x < 0.0)) {
      if ((vertDir_68.y >= 0.0)) {
        tmpvar_86 += 3.141593;
      } else {
        tmpvar_86 = (tmpvar_86 - 3.141593);
      };
    };
  } else {
    tmpvar_86 = (sign(vertDir_68.y) * 1.570796);
  };
  ret_69.x = (tmpvar_86 * 0.15915);
  mediump float tmpvar_89;
  tmpvar_89 = clamp (((0.5 - 
    abs(ret_69.x)
  ) / _RingUFadeWidth), 0.0, 1.0);
  ret_69.z = (tmpvar_89 * (tmpvar_89 * (3.0 - 
    (2.0 * tmpvar_89)
  )));
  ret_69.x = (ret_69.x * _RingUScale);
  ret_69.x = (ret_69.x + _RingEulerAngles3.w);
  mediump float tmpvar_90;
  mediump float tmpvar_91;
  tmpvar_91 = (tmpvar_10.y * 0.004);
  tmpvar_90 = (tmpvar_91 * tmpvar_91);
  tmpvar_2.xyz = (_glesVertex.xyz + ((_glesNormal - _glesVertex.xyz) * (
    (_CellShrink * 0.01)
   + tmpvar_90)));
  highp vec4 tmpvar_92;
  tmpvar_92.w = 1.0;
  tmpvar_92.xyz = tmpvar_2.xyz;
  highp vec4 tmpvar_93;
  tmpvar_93 = (unity_ObjectToWorld * tmpvar_2);
  tmpvar_8 = (tmpvar_93.xyz / tmpvar_93.w);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_92));
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_COLOR0 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = ret_25;
  xlv_TEXCOORD5 = ret_47;
  xlv_TEXCOORD6 = ret_69;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _RingTex;
uniform mediump vec4 _RingColor;
uniform mediump float _RingCrossLightIntensity;
uniform mediump float _RingCrossLightShininess;
uniform mediump vec4 _FresnelParams;
uniform mediump float _CellRimShininess;
uniform mediump float _CellRimIntensity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  mediump float ringCrossIntensity_1;
  mediump vec2 texCol3_2;
  mediump vec2 texCol2_3;
  mediump vec2 texCol1_4;
  mediump float ringIntensity_5;
  mediump vec3 I_6;
  mediump float intensity_7;
  mediump vec4 color_8;
  color_8.w = 0.0;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  I_6 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_6, xlv_TEXCOORD1)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  intensity_7 = (xlv_COLOR0.w + tmpvar_10);
  intensity_7 = (intensity_7 + ((
    pow (xlv_TEXCOORD0.x, _CellRimShininess)
   * xlv_COLOR0.xyz) * (
    ((tmpvar_10 * _CellRimIntensity) + (xlv_TEXCOORD3.x * 0.01))
   + 
    (xlv_TEXCOORD3.y * 0.05)
  )).x);
  color_8.xyz = (intensity_7 * xlv_COLOR0.xyz);
  lowp vec2 tmpvar_11;
  tmpvar_11 = texture2D (_RingTex, xlv_TEXCOORD4.xy).xy;
  texCol1_4 = tmpvar_11;
  lowp vec2 tmpvar_12;
  tmpvar_12 = texture2D (_RingTex, xlv_TEXCOORD5.xy).xy;
  texCol2_3 = tmpvar_12;
  lowp vec2 tmpvar_13;
  tmpvar_13 = texture2D (_RingTex, xlv_TEXCOORD6.xy).xy;
  texCol3_2 = tmpvar_13;
  ringIntensity_5 = (texCol1_4.x * xlv_TEXCOORD4.z);
  ringIntensity_5 = (ringIntensity_5 + (texCol2_3.x * xlv_TEXCOORD5.z));
  ringIntensity_5 = (ringIntensity_5 + (texCol3_2.x * xlv_TEXCOORD6.z));
  mediump float tmpvar_14;
  tmpvar_14 = (texCol1_4.y * texCol2_3.y);
  mediump float tmpvar_15;
  tmpvar_15 = (texCol2_3.y * texCol3_2.y);
  mediump float tmpvar_16;
  tmpvar_16 = (texCol3_2.y * texCol1_4.y);
  ringCrossIntensity_1 = ((tmpvar_14 + tmpvar_15) - (tmpvar_14 * tmpvar_15));
  ringCrossIntensity_1 = ((ringCrossIntensity_1 + tmpvar_16) - (ringCrossIntensity_1 * tmpvar_16));
  ringIntensity_5 = (ringIntensity_5 + (pow (ringCrossIntensity_1, _RingCrossLightShininess) * _RingCrossLightIntensity));
  color_8.xyz = (color_8.xyz + (ringIntensity_5 * (_RingColor.xyz * _RingColor.w)));
  gl_FragData[0] = color_8;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump float _RingUScale;
uniform mediump float _RingVScale;
uniform mediump float _RingUFadeWidth;
uniform mediump vec4 _RingEulerAngles1;
uniform mediump vec4 _RingEulerAngles2;
uniform mediump vec4 _RingEulerAngles3;
uniform mediump float _CellShrink;
uniform mediump vec4 _HitPosition;
uniform mediump float _HitDistRange;
uniform mediump float _HitDistSmoothRange;
uniform mediump float _HitAnmStartTime;
uniform mediump float _HitAnmEndTime;
uniform mediump vec4 _BandPosition;
uniform mediump float _BandWidth;
uniform mediump float _BandIntensity;
uniform mediump vec4 _Params2;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  highp vec4 tmpvar_2;
  tmpvar_2 = _glesVertex;
  mediump vec3 vertDir_3;
  mediump vec3 cellNormal_4;
  mediump float hitDist_5;
  mediump vec2 tmpvar_6;
  mediump vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  mediump vec4 tmpvar_9;
  mediump vec2 tmpvar_10;
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  tmpvar_10.y = 0.0;
  tmpvar_6 = tmpvar_1.xy;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_11[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_11[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11 * _glesVertex.xyz));
  tmpvar_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = max (dot (fract(
    (sin((_glesNormal * vec3(12.9898, 78.233, 45.5432))) * 43758.55)
  ), vec3(1.0, 1.0, 1.0)), 0.5);
  tmpvar_9 = ((_glesColor * _Color) * tmpvar_13);
  mediump vec4 tmpvar_14;
  tmpvar_14 = normalize(_HitPosition);
  highp float tmpvar_15;
  highp vec3 x_16;
  x_16 = (_glesNormal - tmpvar_14.xyz);
  tmpvar_15 = sqrt(dot (x_16, x_16));
  hitDist_5 = tmpvar_15;
  mediump float tmpvar_17;
  tmpvar_17 = (_HitDistRange * _HitAnmStartTime);
  mediump float tmpvar_18;
  tmpvar_18 = clamp (((hitDist_5 - tmpvar_17) / (
    (tmpvar_17 + _HitDistSmoothRange)
   - tmpvar_17)), 0.0, 1.0);
  tmpvar_10.x = (((1.0 - 
    (tmpvar_18 * (tmpvar_18 * (3.0 - (2.0 * tmpvar_18))))
  ) * _Params2.z) * clamp ((1.0 - _HitAnmEndTime), 0.0, 1.0));
  tmpvar_9 = (tmpvar_9 + (_Color * tmpvar_10.x));
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(_glesNormal);
  cellNormal_4 = tmpvar_19;
  mediump vec3 tmpvar_20;
  tmpvar_20 = ((vec3(1.0, 0.0, 0.0) * _BandPosition.zxy) - (vec3(0.0, 0.0, 1.0) * _BandPosition.yzx));
  mediump float tmpvar_21;
  tmpvar_21 = dot (cellNormal_4, normalize((
    (_BandPosition.yzx * tmpvar_20.zxy)
   - 
    (_BandPosition.zxy * tmpvar_20.yzx)
  )));
  mediump float tmpvar_22;
  tmpvar_22 = clamp ((abs(
    cos(((1.570796 - (
      sign(tmpvar_21)
     * 
      (1.570796 - (sqrt((1.0 - 
        abs(tmpvar_21)
      )) * (1.570796 + (
        abs(tmpvar_21)
       * 
        (-0.2146018 + (abs(tmpvar_21) * (0.08656672 + (
          abs(tmpvar_21)
         * -0.03102955))))
      ))))
    )) - _BandPosition.w))
  ) / _BandWidth), 0.0, 1.0);
  tmpvar_10.y = ((1.0 - (tmpvar_22 * 
    (tmpvar_22 * (3.0 - (2.0 * tmpvar_22)))
  )) * _BandIntensity);
  tmpvar_9 = (tmpvar_9 + (_Color * tmpvar_10.y));
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize(_glesVertex.xyz);
  vertDir_3 = tmpvar_23;
  mediump vec3 vertDir_24;
  mediump vec3 ret_25;
  ret_25.xz = vec2(0.0, 0.0);
  mediump mat3 m_26;
  m_26 = mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
  mediump float tmpvar_27;
  tmpvar_27 = cos(_RingEulerAngles1.x);
  mediump float tmpvar_28;
  tmpvar_28 = sin(_RingEulerAngles1.x);
  mediump float tmpvar_29;
  tmpvar_29 = cos(_RingEulerAngles1.y);
  mediump float tmpvar_30;
  tmpvar_30 = sin(_RingEulerAngles1.y);
  mediump float tmpvar_31;
  tmpvar_31 = cos(_RingEulerAngles1.z);
  mediump float tmpvar_32;
  tmpvar_32 = sin(_RingEulerAngles1.z);
  mediump vec3 tmpvar_33;
  tmpvar_33.yz = vec2(0.0, 0.0);
  tmpvar_33.x = (tmpvar_27 * tmpvar_29);
  m_26[0] = tmpvar_33;
  mediump vec3 tmpvar_34;
  tmpvar_34.xz = m_26[0].xz;
  tmpvar_34.y = ((tmpvar_28 * tmpvar_32) - ((tmpvar_27 * tmpvar_30) * tmpvar_31));
  m_26[0] = tmpvar_34;
  mediump vec3 tmpvar_35;
  tmpvar_35.xy = m_26[0].xy;
  tmpvar_35.z = (((tmpvar_27 * tmpvar_30) * tmpvar_32) + (tmpvar_28 * tmpvar_31));
  m_26[0] = tmpvar_35;
  mediump vec3 tmpvar_36;
  tmpvar_36.yz = m_26[1].yz;
  tmpvar_36.x = tmpvar_30;
  m_26[1] = tmpvar_36;
  mediump vec3 tmpvar_37;
  tmpvar_37.xz = m_26[1].xz;
  tmpvar_37.y = (tmpvar_29 * tmpvar_31);
  m_26[1] = tmpvar_37;
  mediump vec3 tmpvar_38;
  tmpvar_38.xy = m_26[1].xy;
  tmpvar_38.z = (-(tmpvar_29) * tmpvar_32);
  m_26[1] = tmpvar_38;
  mediump vec3 tmpvar_39;
  tmpvar_39.yz = m_26[2].yz;
  tmpvar_39.x = (-(tmpvar_28) * tmpvar_29);
  m_26[2] = tmpvar_39;
  mediump vec3 tmpvar_40;
  tmpvar_40.xz = m_26[2].xz;
  tmpvar_40.y = (((tmpvar_28 * tmpvar_30) * tmpvar_31) + (tmpvar_27 * tmpvar_32));
  m_26[2] = tmpvar_40;
  mediump vec3 tmpvar_41;
  tmpvar_41.xy = m_26[2].xy;
  tmpvar_41.z = (((
    -(tmpvar_28)
   * tmpvar_30) * tmpvar_32) + (tmpvar_27 * tmpvar_31));
  m_26[2] = tmpvar_41;
  vertDir_24 = (m_26 * vertDir_3);
  ret_25.y = ((1.570796 - (
    sign(vertDir_24.z)
   * 
    (1.570796 - (sqrt((1.0 - 
      abs(vertDir_24.z)
    )) * (1.570796 + (
      abs(vertDir_24.z)
     * 
      (-0.2146018 + (abs(vertDir_24.z) * (0.08656672 + (
        abs(vertDir_24.z)
       * -0.03102955))))
    ))))
  )) * 0.31831);
  ret_25.y = (((ret_25.y - 0.5) * _RingVScale) + 0.5);
  ret_25.y = clamp (ret_25.y, 0.0, 1.0);
  mediump float tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = (min (abs(
    (vertDir_24.y / vertDir_24.x)
  ), 1.0) / max (abs(
    (vertDir_24.y / vertDir_24.x)
  ), 1.0));
  mediump float tmpvar_44;
  tmpvar_44 = (tmpvar_43 * tmpvar_43);
  tmpvar_44 = (((
    ((((
      ((((-0.01213232 * tmpvar_44) + 0.05368138) * tmpvar_44) - 0.1173503)
     * tmpvar_44) + 0.1938925) * tmpvar_44) - 0.3326756)
   * tmpvar_44) + 0.9999793) * tmpvar_43);
  tmpvar_44 = (tmpvar_44 + (float(
    (abs((vertDir_24.y / vertDir_24.x)) > 1.0)
  ) * (
    (tmpvar_44 * -2.0)
   + 1.570796)));
  tmpvar_42 = (tmpvar_44 * sign((vertDir_24.y / vertDir_24.x)));
  if ((abs(vertDir_24.x) > (1e-08 * abs(vertDir_24.y)))) {
    if ((vertDir_24.x < 0.0)) {
      if ((vertDir_24.y >= 0.0)) {
        tmpvar_42 += 3.141593;
      } else {
        tmpvar_42 = (tmpvar_42 - 3.141593);
      };
    };
  } else {
    tmpvar_42 = (sign(vertDir_24.y) * 1.570796);
  };
  ret_25.x = (tmpvar_42 * 0.15915);
  mediump float tmpvar_45;
  tmpvar_45 = clamp (((0.5 - 
    abs(ret_25.x)
  ) / _RingUFadeWidth), 0.0, 1.0);
  ret_25.z = (tmpvar_45 * (tmpvar_45 * (3.0 - 
    (2.0 * tmpvar_45)
  )));
  ret_25.x = (ret_25.x * _RingUScale);
  ret_25.x = (ret_25.x + _RingEulerAngles1.w);
  mediump vec3 vertDir_46;
  mediump vec3 ret_47;
  ret_47.xz = vec2(0.0, 0.0);
  mediump mat3 m_48;
  m_48 = mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
  mediump float tmpvar_49;
  tmpvar_49 = cos(_RingEulerAngles2.x);
  mediump float tmpvar_50;
  tmpvar_50 = sin(_RingEulerAngles2.x);
  mediump float tmpvar_51;
  tmpvar_51 = cos(_RingEulerAngles2.y);
  mediump float tmpvar_52;
  tmpvar_52 = sin(_RingEulerAngles2.y);
  mediump float tmpvar_53;
  tmpvar_53 = cos(_RingEulerAngles2.z);
  mediump float tmpvar_54;
  tmpvar_54 = sin(_RingEulerAngles2.z);
  mediump vec3 tmpvar_55;
  tmpvar_55.yz = vec2(0.0, 0.0);
  tmpvar_55.x = (tmpvar_49 * tmpvar_51);
  m_48[0] = tmpvar_55;
  mediump vec3 tmpvar_56;
  tmpvar_56.xz = m_48[0].xz;
  tmpvar_56.y = ((tmpvar_50 * tmpvar_54) - ((tmpvar_49 * tmpvar_52) * tmpvar_53));
  m_48[0] = tmpvar_56;
  mediump vec3 tmpvar_57;
  tmpvar_57.xy = m_48[0].xy;
  tmpvar_57.z = (((tmpvar_49 * tmpvar_52) * tmpvar_54) + (tmpvar_50 * tmpvar_53));
  m_48[0] = tmpvar_57;
  mediump vec3 tmpvar_58;
  tmpvar_58.yz = m_48[1].yz;
  tmpvar_58.x = tmpvar_52;
  m_48[1] = tmpvar_58;
  mediump vec3 tmpvar_59;
  tmpvar_59.xz = m_48[1].xz;
  tmpvar_59.y = (tmpvar_51 * tmpvar_53);
  m_48[1] = tmpvar_59;
  mediump vec3 tmpvar_60;
  tmpvar_60.xy = m_48[1].xy;
  tmpvar_60.z = (-(tmpvar_51) * tmpvar_54);
  m_48[1] = tmpvar_60;
  mediump vec3 tmpvar_61;
  tmpvar_61.yz = m_48[2].yz;
  tmpvar_61.x = (-(tmpvar_50) * tmpvar_51);
  m_48[2] = tmpvar_61;
  mediump vec3 tmpvar_62;
  tmpvar_62.xz = m_48[2].xz;
  tmpvar_62.y = (((tmpvar_50 * tmpvar_52) * tmpvar_53) + (tmpvar_49 * tmpvar_54));
  m_48[2] = tmpvar_62;
  mediump vec3 tmpvar_63;
  tmpvar_63.xy = m_48[2].xy;
  tmpvar_63.z = (((
    -(tmpvar_50)
   * tmpvar_52) * tmpvar_54) + (tmpvar_49 * tmpvar_53));
  m_48[2] = tmpvar_63;
  vertDir_46 = (m_48 * vertDir_3);
  ret_47.y = ((1.570796 - (
    sign(vertDir_46.z)
   * 
    (1.570796 - (sqrt((1.0 - 
      abs(vertDir_46.z)
    )) * (1.570796 + (
      abs(vertDir_46.z)
     * 
      (-0.2146018 + (abs(vertDir_46.z) * (0.08656672 + (
        abs(vertDir_46.z)
       * -0.03102955))))
    ))))
  )) * 0.31831);
  ret_47.y = (((ret_47.y - 0.5) * _RingVScale) + 0.5);
  ret_47.y = clamp (ret_47.y, 0.0, 1.0);
  mediump float tmpvar_64;
  mediump float tmpvar_65;
  tmpvar_65 = (min (abs(
    (vertDir_46.y / vertDir_46.x)
  ), 1.0) / max (abs(
    (vertDir_46.y / vertDir_46.x)
  ), 1.0));
  mediump float tmpvar_66;
  tmpvar_66 = (tmpvar_65 * tmpvar_65);
  tmpvar_66 = (((
    ((((
      ((((-0.01213232 * tmpvar_66) + 0.05368138) * tmpvar_66) - 0.1173503)
     * tmpvar_66) + 0.1938925) * tmpvar_66) - 0.3326756)
   * tmpvar_66) + 0.9999793) * tmpvar_65);
  tmpvar_66 = (tmpvar_66 + (float(
    (abs((vertDir_46.y / vertDir_46.x)) > 1.0)
  ) * (
    (tmpvar_66 * -2.0)
   + 1.570796)));
  tmpvar_64 = (tmpvar_66 * sign((vertDir_46.y / vertDir_46.x)));
  if ((abs(vertDir_46.x) > (1e-08 * abs(vertDir_46.y)))) {
    if ((vertDir_46.x < 0.0)) {
      if ((vertDir_46.y >= 0.0)) {
        tmpvar_64 += 3.141593;
      } else {
        tmpvar_64 = (tmpvar_64 - 3.141593);
      };
    };
  } else {
    tmpvar_64 = (sign(vertDir_46.y) * 1.570796);
  };
  ret_47.x = (tmpvar_64 * 0.15915);
  mediump float tmpvar_67;
  tmpvar_67 = clamp (((0.5 - 
    abs(ret_47.x)
  ) / _RingUFadeWidth), 0.0, 1.0);
  ret_47.z = (tmpvar_67 * (tmpvar_67 * (3.0 - 
    (2.0 * tmpvar_67)
  )));
  ret_47.x = (ret_47.x * _RingUScale);
  ret_47.x = (ret_47.x + _RingEulerAngles2.w);
  mediump vec3 vertDir_68;
  mediump vec3 ret_69;
  ret_69.xz = vec2(0.0, 0.0);
  mediump mat3 m_70;
  m_70 = mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
  mediump float tmpvar_71;
  tmpvar_71 = cos(_RingEulerAngles3.x);
  mediump float tmpvar_72;
  tmpvar_72 = sin(_RingEulerAngles3.x);
  mediump float tmpvar_73;
  tmpvar_73 = cos(_RingEulerAngles3.y);
  mediump float tmpvar_74;
  tmpvar_74 = sin(_RingEulerAngles3.y);
  mediump float tmpvar_75;
  tmpvar_75 = cos(_RingEulerAngles3.z);
  mediump float tmpvar_76;
  tmpvar_76 = sin(_RingEulerAngles3.z);
  mediump vec3 tmpvar_77;
  tmpvar_77.yz = vec2(0.0, 0.0);
  tmpvar_77.x = (tmpvar_71 * tmpvar_73);
  m_70[0] = tmpvar_77;
  mediump vec3 tmpvar_78;
  tmpvar_78.xz = m_70[0].xz;
  tmpvar_78.y = ((tmpvar_72 * tmpvar_76) - ((tmpvar_71 * tmpvar_74) * tmpvar_75));
  m_70[0] = tmpvar_78;
  mediump vec3 tmpvar_79;
  tmpvar_79.xy = m_70[0].xy;
  tmpvar_79.z = (((tmpvar_71 * tmpvar_74) * tmpvar_76) + (tmpvar_72 * tmpvar_75));
  m_70[0] = tmpvar_79;
  mediump vec3 tmpvar_80;
  tmpvar_80.yz = m_70[1].yz;
  tmpvar_80.x = tmpvar_74;
  m_70[1] = tmpvar_80;
  mediump vec3 tmpvar_81;
  tmpvar_81.xz = m_70[1].xz;
  tmpvar_81.y = (tmpvar_73 * tmpvar_75);
  m_70[1] = tmpvar_81;
  mediump vec3 tmpvar_82;
  tmpvar_82.xy = m_70[1].xy;
  tmpvar_82.z = (-(tmpvar_73) * tmpvar_76);
  m_70[1] = tmpvar_82;
  mediump vec3 tmpvar_83;
  tmpvar_83.yz = m_70[2].yz;
  tmpvar_83.x = (-(tmpvar_72) * tmpvar_73);
  m_70[2] = tmpvar_83;
  mediump vec3 tmpvar_84;
  tmpvar_84.xz = m_70[2].xz;
  tmpvar_84.y = (((tmpvar_72 * tmpvar_74) * tmpvar_75) + (tmpvar_71 * tmpvar_76));
  m_70[2] = tmpvar_84;
  mediump vec3 tmpvar_85;
  tmpvar_85.xy = m_70[2].xy;
  tmpvar_85.z = (((
    -(tmpvar_72)
   * tmpvar_74) * tmpvar_76) + (tmpvar_71 * tmpvar_75));
  m_70[2] = tmpvar_85;
  vertDir_68 = (m_70 * vertDir_3);
  ret_69.y = ((1.570796 - (
    sign(vertDir_68.z)
   * 
    (1.570796 - (sqrt((1.0 - 
      abs(vertDir_68.z)
    )) * (1.570796 + (
      abs(vertDir_68.z)
     * 
      (-0.2146018 + (abs(vertDir_68.z) * (0.08656672 + (
        abs(vertDir_68.z)
       * -0.03102955))))
    ))))
  )) * 0.31831);
  ret_69.y = (((ret_69.y - 0.5) * _RingVScale) + 0.5);
  ret_69.y = clamp (ret_69.y, 0.0, 1.0);
  mediump float tmpvar_86;
  mediump float tmpvar_87;
  tmpvar_87 = (min (abs(
    (vertDir_68.y / vertDir_68.x)
  ), 1.0) / max (abs(
    (vertDir_68.y / vertDir_68.x)
  ), 1.0));
  mediump float tmpvar_88;
  tmpvar_88 = (tmpvar_87 * tmpvar_87);
  tmpvar_88 = (((
    ((((
      ((((-0.01213232 * tmpvar_88) + 0.05368138) * tmpvar_88) - 0.1173503)
     * tmpvar_88) + 0.1938925) * tmpvar_88) - 0.3326756)
   * tmpvar_88) + 0.9999793) * tmpvar_87);
  tmpvar_88 = (tmpvar_88 + (float(
    (abs((vertDir_68.y / vertDir_68.x)) > 1.0)
  ) * (
    (tmpvar_88 * -2.0)
   + 1.570796)));
  tmpvar_86 = (tmpvar_88 * sign((vertDir_68.y / vertDir_68.x)));
  if ((abs(vertDir_68.x) > (1e-08 * abs(vertDir_68.y)))) {
    if ((vertDir_68.x < 0.0)) {
      if ((vertDir_68.y >= 0.0)) {
        tmpvar_86 += 3.141593;
      } else {
        tmpvar_86 = (tmpvar_86 - 3.141593);
      };
    };
  } else {
    tmpvar_86 = (sign(vertDir_68.y) * 1.570796);
  };
  ret_69.x = (tmpvar_86 * 0.15915);
  mediump float tmpvar_89;
  tmpvar_89 = clamp (((0.5 - 
    abs(ret_69.x)
  ) / _RingUFadeWidth), 0.0, 1.0);
  ret_69.z = (tmpvar_89 * (tmpvar_89 * (3.0 - 
    (2.0 * tmpvar_89)
  )));
  ret_69.x = (ret_69.x * _RingUScale);
  ret_69.x = (ret_69.x + _RingEulerAngles3.w);
  mediump float tmpvar_90;
  mediump float tmpvar_91;
  tmpvar_91 = (tmpvar_10.y * 0.004);
  tmpvar_90 = (tmpvar_91 * tmpvar_91);
  tmpvar_2.xyz = (_glesVertex.xyz + ((_glesNormal - _glesVertex.xyz) * (
    (_CellShrink * 0.01)
   + tmpvar_90)));
  highp vec4 tmpvar_92;
  tmpvar_92.w = 1.0;
  tmpvar_92.xyz = tmpvar_2.xyz;
  highp vec4 tmpvar_93;
  tmpvar_93 = (unity_ObjectToWorld * tmpvar_2);
  tmpvar_8 = (tmpvar_93.xyz / tmpvar_93.w);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_92));
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_COLOR0 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = ret_25;
  xlv_TEXCOORD5 = ret_47;
  xlv_TEXCOORD6 = ret_69;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _RingTex;
uniform mediump vec4 _RingColor;
uniform mediump float _RingCrossLightIntensity;
uniform mediump float _RingCrossLightShininess;
uniform mediump vec4 _FresnelParams;
uniform mediump float _CellRimShininess;
uniform mediump float _CellRimIntensity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  mediump float ringCrossIntensity_1;
  mediump vec2 texCol3_2;
  mediump vec2 texCol2_3;
  mediump vec2 texCol1_4;
  mediump float ringIntensity_5;
  mediump vec3 I_6;
  mediump float intensity_7;
  mediump vec4 color_8;
  color_8.w = 0.0;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  I_6 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_6, xlv_TEXCOORD1)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  intensity_7 = (xlv_COLOR0.w + tmpvar_10);
  intensity_7 = (intensity_7 + ((
    pow (xlv_TEXCOORD0.x, _CellRimShininess)
   * xlv_COLOR0.xyz) * (
    ((tmpvar_10 * _CellRimIntensity) + (xlv_TEXCOORD3.x * 0.01))
   + 
    (xlv_TEXCOORD3.y * 0.05)
  )).x);
  color_8.xyz = (intensity_7 * xlv_COLOR0.xyz);
  lowp vec2 tmpvar_11;
  tmpvar_11 = texture2D (_RingTex, xlv_TEXCOORD4.xy).xy;
  texCol1_4 = tmpvar_11;
  lowp vec2 tmpvar_12;
  tmpvar_12 = texture2D (_RingTex, xlv_TEXCOORD5.xy).xy;
  texCol2_3 = tmpvar_12;
  lowp vec2 tmpvar_13;
  tmpvar_13 = texture2D (_RingTex, xlv_TEXCOORD6.xy).xy;
  texCol3_2 = tmpvar_13;
  ringIntensity_5 = (texCol1_4.x * xlv_TEXCOORD4.z);
  ringIntensity_5 = (ringIntensity_5 + (texCol2_3.x * xlv_TEXCOORD5.z));
  ringIntensity_5 = (ringIntensity_5 + (texCol3_2.x * xlv_TEXCOORD6.z));
  mediump float tmpvar_14;
  tmpvar_14 = (texCol1_4.y * texCol2_3.y);
  mediump float tmpvar_15;
  tmpvar_15 = (texCol2_3.y * texCol3_2.y);
  mediump float tmpvar_16;
  tmpvar_16 = (texCol3_2.y * texCol1_4.y);
  ringCrossIntensity_1 = ((tmpvar_14 + tmpvar_15) - (tmpvar_14 * tmpvar_15));
  ringCrossIntensity_1 = ((ringCrossIntensity_1 + tmpvar_16) - (ringCrossIntensity_1 * tmpvar_16));
  ringIntensity_5 = (ringIntensity_5 + (pow (ringCrossIntensity_1, _RingCrossLightShininess) * _RingCrossLightIntensity));
  color_8.xyz = (color_8.xyz + (ringIntensity_5 * (_RingColor.xyz * _RingColor.w)));
  gl_FragData[0] = color_8;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump float _RingUScale;
uniform mediump float _RingVScale;
uniform mediump float _RingUFadeWidth;
uniform mediump vec4 _RingEulerAngles1;
uniform mediump vec4 _RingEulerAngles2;
uniform mediump vec4 _RingEulerAngles3;
uniform mediump float _CellShrink;
uniform mediump vec4 _HitPosition;
uniform mediump float _HitDistRange;
uniform mediump float _HitDistSmoothRange;
uniform mediump float _HitAnmStartTime;
uniform mediump float _HitAnmEndTime;
uniform mediump vec4 _BandPosition;
uniform mediump float _BandWidth;
uniform mediump float _BandIntensity;
uniform mediump vec4 _Params2;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  highp vec4 tmpvar_2;
  tmpvar_2 = _glesVertex;
  mediump vec3 vertDir_3;
  mediump vec3 cellNormal_4;
  mediump float hitDist_5;
  mediump vec2 tmpvar_6;
  mediump vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  mediump vec4 tmpvar_9;
  mediump vec2 tmpvar_10;
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  tmpvar_10.y = 0.0;
  tmpvar_6 = tmpvar_1.xy;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_11[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_11[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11 * _glesVertex.xyz));
  tmpvar_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = max (dot (fract(
    (sin((_glesNormal * vec3(12.9898, 78.233, 45.5432))) * 43758.55)
  ), vec3(1.0, 1.0, 1.0)), 0.5);
  tmpvar_9 = ((_glesColor * _Color) * tmpvar_13);
  mediump vec4 tmpvar_14;
  tmpvar_14 = normalize(_HitPosition);
  highp float tmpvar_15;
  highp vec3 x_16;
  x_16 = (_glesNormal - tmpvar_14.xyz);
  tmpvar_15 = sqrt(dot (x_16, x_16));
  hitDist_5 = tmpvar_15;
  mediump float tmpvar_17;
  tmpvar_17 = (_HitDistRange * _HitAnmStartTime);
  mediump float tmpvar_18;
  tmpvar_18 = clamp (((hitDist_5 - tmpvar_17) / (
    (tmpvar_17 + _HitDistSmoothRange)
   - tmpvar_17)), 0.0, 1.0);
  tmpvar_10.x = (((1.0 - 
    (tmpvar_18 * (tmpvar_18 * (3.0 - (2.0 * tmpvar_18))))
  ) * _Params2.z) * clamp ((1.0 - _HitAnmEndTime), 0.0, 1.0));
  tmpvar_9 = (tmpvar_9 + (_Color * tmpvar_10.x));
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(_glesNormal);
  cellNormal_4 = tmpvar_19;
  mediump vec3 tmpvar_20;
  tmpvar_20 = ((vec3(1.0, 0.0, 0.0) * _BandPosition.zxy) - (vec3(0.0, 0.0, 1.0) * _BandPosition.yzx));
  mediump float tmpvar_21;
  tmpvar_21 = dot (cellNormal_4, normalize((
    (_BandPosition.yzx * tmpvar_20.zxy)
   - 
    (_BandPosition.zxy * tmpvar_20.yzx)
  )));
  mediump float tmpvar_22;
  tmpvar_22 = clamp ((abs(
    cos(((1.570796 - (
      sign(tmpvar_21)
     * 
      (1.570796 - (sqrt((1.0 - 
        abs(tmpvar_21)
      )) * (1.570796 + (
        abs(tmpvar_21)
       * 
        (-0.2146018 + (abs(tmpvar_21) * (0.08656672 + (
          abs(tmpvar_21)
         * -0.03102955))))
      ))))
    )) - _BandPosition.w))
  ) / _BandWidth), 0.0, 1.0);
  tmpvar_10.y = ((1.0 - (tmpvar_22 * 
    (tmpvar_22 * (3.0 - (2.0 * tmpvar_22)))
  )) * _BandIntensity);
  tmpvar_9 = (tmpvar_9 + (_Color * tmpvar_10.y));
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize(_glesVertex.xyz);
  vertDir_3 = tmpvar_23;
  mediump vec3 vertDir_24;
  mediump vec3 ret_25;
  ret_25.xz = vec2(0.0, 0.0);
  mediump mat3 m_26;
  m_26 = mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
  mediump float tmpvar_27;
  tmpvar_27 = cos(_RingEulerAngles1.x);
  mediump float tmpvar_28;
  tmpvar_28 = sin(_RingEulerAngles1.x);
  mediump float tmpvar_29;
  tmpvar_29 = cos(_RingEulerAngles1.y);
  mediump float tmpvar_30;
  tmpvar_30 = sin(_RingEulerAngles1.y);
  mediump float tmpvar_31;
  tmpvar_31 = cos(_RingEulerAngles1.z);
  mediump float tmpvar_32;
  tmpvar_32 = sin(_RingEulerAngles1.z);
  mediump vec3 tmpvar_33;
  tmpvar_33.yz = vec2(0.0, 0.0);
  tmpvar_33.x = (tmpvar_27 * tmpvar_29);
  m_26[0] = tmpvar_33;
  mediump vec3 tmpvar_34;
  tmpvar_34.xz = m_26[0].xz;
  tmpvar_34.y = ((tmpvar_28 * tmpvar_32) - ((tmpvar_27 * tmpvar_30) * tmpvar_31));
  m_26[0] = tmpvar_34;
  mediump vec3 tmpvar_35;
  tmpvar_35.xy = m_26[0].xy;
  tmpvar_35.z = (((tmpvar_27 * tmpvar_30) * tmpvar_32) + (tmpvar_28 * tmpvar_31));
  m_26[0] = tmpvar_35;
  mediump vec3 tmpvar_36;
  tmpvar_36.yz = m_26[1].yz;
  tmpvar_36.x = tmpvar_30;
  m_26[1] = tmpvar_36;
  mediump vec3 tmpvar_37;
  tmpvar_37.xz = m_26[1].xz;
  tmpvar_37.y = (tmpvar_29 * tmpvar_31);
  m_26[1] = tmpvar_37;
  mediump vec3 tmpvar_38;
  tmpvar_38.xy = m_26[1].xy;
  tmpvar_38.z = (-(tmpvar_29) * tmpvar_32);
  m_26[1] = tmpvar_38;
  mediump vec3 tmpvar_39;
  tmpvar_39.yz = m_26[2].yz;
  tmpvar_39.x = (-(tmpvar_28) * tmpvar_29);
  m_26[2] = tmpvar_39;
  mediump vec3 tmpvar_40;
  tmpvar_40.xz = m_26[2].xz;
  tmpvar_40.y = (((tmpvar_28 * tmpvar_30) * tmpvar_31) + (tmpvar_27 * tmpvar_32));
  m_26[2] = tmpvar_40;
  mediump vec3 tmpvar_41;
  tmpvar_41.xy = m_26[2].xy;
  tmpvar_41.z = (((
    -(tmpvar_28)
   * tmpvar_30) * tmpvar_32) + (tmpvar_27 * tmpvar_31));
  m_26[2] = tmpvar_41;
  vertDir_24 = (m_26 * vertDir_3);
  ret_25.y = ((1.570796 - (
    sign(vertDir_24.z)
   * 
    (1.570796 - (sqrt((1.0 - 
      abs(vertDir_24.z)
    )) * (1.570796 + (
      abs(vertDir_24.z)
     * 
      (-0.2146018 + (abs(vertDir_24.z) * (0.08656672 + (
        abs(vertDir_24.z)
       * -0.03102955))))
    ))))
  )) * 0.31831);
  ret_25.y = (((ret_25.y - 0.5) * _RingVScale) + 0.5);
  ret_25.y = clamp (ret_25.y, 0.0, 1.0);
  mediump float tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = (min (abs(
    (vertDir_24.y / vertDir_24.x)
  ), 1.0) / max (abs(
    (vertDir_24.y / vertDir_24.x)
  ), 1.0));
  mediump float tmpvar_44;
  tmpvar_44 = (tmpvar_43 * tmpvar_43);
  tmpvar_44 = (((
    ((((
      ((((-0.01213232 * tmpvar_44) + 0.05368138) * tmpvar_44) - 0.1173503)
     * tmpvar_44) + 0.1938925) * tmpvar_44) - 0.3326756)
   * tmpvar_44) + 0.9999793) * tmpvar_43);
  tmpvar_44 = (tmpvar_44 + (float(
    (abs((vertDir_24.y / vertDir_24.x)) > 1.0)
  ) * (
    (tmpvar_44 * -2.0)
   + 1.570796)));
  tmpvar_42 = (tmpvar_44 * sign((vertDir_24.y / vertDir_24.x)));
  if ((abs(vertDir_24.x) > (1e-08 * abs(vertDir_24.y)))) {
    if ((vertDir_24.x < 0.0)) {
      if ((vertDir_24.y >= 0.0)) {
        tmpvar_42 += 3.141593;
      } else {
        tmpvar_42 = (tmpvar_42 - 3.141593);
      };
    };
  } else {
    tmpvar_42 = (sign(vertDir_24.y) * 1.570796);
  };
  ret_25.x = (tmpvar_42 * 0.15915);
  mediump float tmpvar_45;
  tmpvar_45 = clamp (((0.5 - 
    abs(ret_25.x)
  ) / _RingUFadeWidth), 0.0, 1.0);
  ret_25.z = (tmpvar_45 * (tmpvar_45 * (3.0 - 
    (2.0 * tmpvar_45)
  )));
  ret_25.x = (ret_25.x * _RingUScale);
  ret_25.x = (ret_25.x + _RingEulerAngles1.w);
  mediump vec3 vertDir_46;
  mediump vec3 ret_47;
  ret_47.xz = vec2(0.0, 0.0);
  mediump mat3 m_48;
  m_48 = mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
  mediump float tmpvar_49;
  tmpvar_49 = cos(_RingEulerAngles2.x);
  mediump float tmpvar_50;
  tmpvar_50 = sin(_RingEulerAngles2.x);
  mediump float tmpvar_51;
  tmpvar_51 = cos(_RingEulerAngles2.y);
  mediump float tmpvar_52;
  tmpvar_52 = sin(_RingEulerAngles2.y);
  mediump float tmpvar_53;
  tmpvar_53 = cos(_RingEulerAngles2.z);
  mediump float tmpvar_54;
  tmpvar_54 = sin(_RingEulerAngles2.z);
  mediump vec3 tmpvar_55;
  tmpvar_55.yz = vec2(0.0, 0.0);
  tmpvar_55.x = (tmpvar_49 * tmpvar_51);
  m_48[0] = tmpvar_55;
  mediump vec3 tmpvar_56;
  tmpvar_56.xz = m_48[0].xz;
  tmpvar_56.y = ((tmpvar_50 * tmpvar_54) - ((tmpvar_49 * tmpvar_52) * tmpvar_53));
  m_48[0] = tmpvar_56;
  mediump vec3 tmpvar_57;
  tmpvar_57.xy = m_48[0].xy;
  tmpvar_57.z = (((tmpvar_49 * tmpvar_52) * tmpvar_54) + (tmpvar_50 * tmpvar_53));
  m_48[0] = tmpvar_57;
  mediump vec3 tmpvar_58;
  tmpvar_58.yz = m_48[1].yz;
  tmpvar_58.x = tmpvar_52;
  m_48[1] = tmpvar_58;
  mediump vec3 tmpvar_59;
  tmpvar_59.xz = m_48[1].xz;
  tmpvar_59.y = (tmpvar_51 * tmpvar_53);
  m_48[1] = tmpvar_59;
  mediump vec3 tmpvar_60;
  tmpvar_60.xy = m_48[1].xy;
  tmpvar_60.z = (-(tmpvar_51) * tmpvar_54);
  m_48[1] = tmpvar_60;
  mediump vec3 tmpvar_61;
  tmpvar_61.yz = m_48[2].yz;
  tmpvar_61.x = (-(tmpvar_50) * tmpvar_51);
  m_48[2] = tmpvar_61;
  mediump vec3 tmpvar_62;
  tmpvar_62.xz = m_48[2].xz;
  tmpvar_62.y = (((tmpvar_50 * tmpvar_52) * tmpvar_53) + (tmpvar_49 * tmpvar_54));
  m_48[2] = tmpvar_62;
  mediump vec3 tmpvar_63;
  tmpvar_63.xy = m_48[2].xy;
  tmpvar_63.z = (((
    -(tmpvar_50)
   * tmpvar_52) * tmpvar_54) + (tmpvar_49 * tmpvar_53));
  m_48[2] = tmpvar_63;
  vertDir_46 = (m_48 * vertDir_3);
  ret_47.y = ((1.570796 - (
    sign(vertDir_46.z)
   * 
    (1.570796 - (sqrt((1.0 - 
      abs(vertDir_46.z)
    )) * (1.570796 + (
      abs(vertDir_46.z)
     * 
      (-0.2146018 + (abs(vertDir_46.z) * (0.08656672 + (
        abs(vertDir_46.z)
       * -0.03102955))))
    ))))
  )) * 0.31831);
  ret_47.y = (((ret_47.y - 0.5) * _RingVScale) + 0.5);
  ret_47.y = clamp (ret_47.y, 0.0, 1.0);
  mediump float tmpvar_64;
  mediump float tmpvar_65;
  tmpvar_65 = (min (abs(
    (vertDir_46.y / vertDir_46.x)
  ), 1.0) / max (abs(
    (vertDir_46.y / vertDir_46.x)
  ), 1.0));
  mediump float tmpvar_66;
  tmpvar_66 = (tmpvar_65 * tmpvar_65);
  tmpvar_66 = (((
    ((((
      ((((-0.01213232 * tmpvar_66) + 0.05368138) * tmpvar_66) - 0.1173503)
     * tmpvar_66) + 0.1938925) * tmpvar_66) - 0.3326756)
   * tmpvar_66) + 0.9999793) * tmpvar_65);
  tmpvar_66 = (tmpvar_66 + (float(
    (abs((vertDir_46.y / vertDir_46.x)) > 1.0)
  ) * (
    (tmpvar_66 * -2.0)
   + 1.570796)));
  tmpvar_64 = (tmpvar_66 * sign((vertDir_46.y / vertDir_46.x)));
  if ((abs(vertDir_46.x) > (1e-08 * abs(vertDir_46.y)))) {
    if ((vertDir_46.x < 0.0)) {
      if ((vertDir_46.y >= 0.0)) {
        tmpvar_64 += 3.141593;
      } else {
        tmpvar_64 = (tmpvar_64 - 3.141593);
      };
    };
  } else {
    tmpvar_64 = (sign(vertDir_46.y) * 1.570796);
  };
  ret_47.x = (tmpvar_64 * 0.15915);
  mediump float tmpvar_67;
  tmpvar_67 = clamp (((0.5 - 
    abs(ret_47.x)
  ) / _RingUFadeWidth), 0.0, 1.0);
  ret_47.z = (tmpvar_67 * (tmpvar_67 * (3.0 - 
    (2.0 * tmpvar_67)
  )));
  ret_47.x = (ret_47.x * _RingUScale);
  ret_47.x = (ret_47.x + _RingEulerAngles2.w);
  mediump vec3 vertDir_68;
  mediump vec3 ret_69;
  ret_69.xz = vec2(0.0, 0.0);
  mediump mat3 m_70;
  m_70 = mat3(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
  mediump float tmpvar_71;
  tmpvar_71 = cos(_RingEulerAngles3.x);
  mediump float tmpvar_72;
  tmpvar_72 = sin(_RingEulerAngles3.x);
  mediump float tmpvar_73;
  tmpvar_73 = cos(_RingEulerAngles3.y);
  mediump float tmpvar_74;
  tmpvar_74 = sin(_RingEulerAngles3.y);
  mediump float tmpvar_75;
  tmpvar_75 = cos(_RingEulerAngles3.z);
  mediump float tmpvar_76;
  tmpvar_76 = sin(_RingEulerAngles3.z);
  mediump vec3 tmpvar_77;
  tmpvar_77.yz = vec2(0.0, 0.0);
  tmpvar_77.x = (tmpvar_71 * tmpvar_73);
  m_70[0] = tmpvar_77;
  mediump vec3 tmpvar_78;
  tmpvar_78.xz = m_70[0].xz;
  tmpvar_78.y = ((tmpvar_72 * tmpvar_76) - ((tmpvar_71 * tmpvar_74) * tmpvar_75));
  m_70[0] = tmpvar_78;
  mediump vec3 tmpvar_79;
  tmpvar_79.xy = m_70[0].xy;
  tmpvar_79.z = (((tmpvar_71 * tmpvar_74) * tmpvar_76) + (tmpvar_72 * tmpvar_75));
  m_70[0] = tmpvar_79;
  mediump vec3 tmpvar_80;
  tmpvar_80.yz = m_70[1].yz;
  tmpvar_80.x = tmpvar_74;
  m_70[1] = tmpvar_80;
  mediump vec3 tmpvar_81;
  tmpvar_81.xz = m_70[1].xz;
  tmpvar_81.y = (tmpvar_73 * tmpvar_75);
  m_70[1] = tmpvar_81;
  mediump vec3 tmpvar_82;
  tmpvar_82.xy = m_70[1].xy;
  tmpvar_82.z = (-(tmpvar_73) * tmpvar_76);
  m_70[1] = tmpvar_82;
  mediump vec3 tmpvar_83;
  tmpvar_83.yz = m_70[2].yz;
  tmpvar_83.x = (-(tmpvar_72) * tmpvar_73);
  m_70[2] = tmpvar_83;
  mediump vec3 tmpvar_84;
  tmpvar_84.xz = m_70[2].xz;
  tmpvar_84.y = (((tmpvar_72 * tmpvar_74) * tmpvar_75) + (tmpvar_71 * tmpvar_76));
  m_70[2] = tmpvar_84;
  mediump vec3 tmpvar_85;
  tmpvar_85.xy = m_70[2].xy;
  tmpvar_85.z = (((
    -(tmpvar_72)
   * tmpvar_74) * tmpvar_76) + (tmpvar_71 * tmpvar_75));
  m_70[2] = tmpvar_85;
  vertDir_68 = (m_70 * vertDir_3);
  ret_69.y = ((1.570796 - (
    sign(vertDir_68.z)
   * 
    (1.570796 - (sqrt((1.0 - 
      abs(vertDir_68.z)
    )) * (1.570796 + (
      abs(vertDir_68.z)
     * 
      (-0.2146018 + (abs(vertDir_68.z) * (0.08656672 + (
        abs(vertDir_68.z)
       * -0.03102955))))
    ))))
  )) * 0.31831);
  ret_69.y = (((ret_69.y - 0.5) * _RingVScale) + 0.5);
  ret_69.y = clamp (ret_69.y, 0.0, 1.0);
  mediump float tmpvar_86;
  mediump float tmpvar_87;
  tmpvar_87 = (min (abs(
    (vertDir_68.y / vertDir_68.x)
  ), 1.0) / max (abs(
    (vertDir_68.y / vertDir_68.x)
  ), 1.0));
  mediump float tmpvar_88;
  tmpvar_88 = (tmpvar_87 * tmpvar_87);
  tmpvar_88 = (((
    ((((
      ((((-0.01213232 * tmpvar_88) + 0.05368138) * tmpvar_88) - 0.1173503)
     * tmpvar_88) + 0.1938925) * tmpvar_88) - 0.3326756)
   * tmpvar_88) + 0.9999793) * tmpvar_87);
  tmpvar_88 = (tmpvar_88 + (float(
    (abs((vertDir_68.y / vertDir_68.x)) > 1.0)
  ) * (
    (tmpvar_88 * -2.0)
   + 1.570796)));
  tmpvar_86 = (tmpvar_88 * sign((vertDir_68.y / vertDir_68.x)));
  if ((abs(vertDir_68.x) > (1e-08 * abs(vertDir_68.y)))) {
    if ((vertDir_68.x < 0.0)) {
      if ((vertDir_68.y >= 0.0)) {
        tmpvar_86 += 3.141593;
      } else {
        tmpvar_86 = (tmpvar_86 - 3.141593);
      };
    };
  } else {
    tmpvar_86 = (sign(vertDir_68.y) * 1.570796);
  };
  ret_69.x = (tmpvar_86 * 0.15915);
  mediump float tmpvar_89;
  tmpvar_89 = clamp (((0.5 - 
    abs(ret_69.x)
  ) / _RingUFadeWidth), 0.0, 1.0);
  ret_69.z = (tmpvar_89 * (tmpvar_89 * (3.0 - 
    (2.0 * tmpvar_89)
  )));
  ret_69.x = (ret_69.x * _RingUScale);
  ret_69.x = (ret_69.x + _RingEulerAngles3.w);
  mediump float tmpvar_90;
  mediump float tmpvar_91;
  tmpvar_91 = (tmpvar_10.y * 0.004);
  tmpvar_90 = (tmpvar_91 * tmpvar_91);
  tmpvar_2.xyz = (_glesVertex.xyz + ((_glesNormal - _glesVertex.xyz) * (
    (_CellShrink * 0.01)
   + tmpvar_90)));
  highp vec4 tmpvar_92;
  tmpvar_92.w = 1.0;
  tmpvar_92.xyz = tmpvar_2.xyz;
  highp vec4 tmpvar_93;
  tmpvar_93 = (unity_ObjectToWorld * tmpvar_2);
  tmpvar_8 = (tmpvar_93.xyz / tmpvar_93.w);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_92));
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_COLOR0 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = ret_25;
  xlv_TEXCOORD5 = ret_47;
  xlv_TEXCOORD6 = ret_69;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _RingTex;
uniform mediump vec4 _RingColor;
uniform mediump float _RingCrossLightIntensity;
uniform mediump float _RingCrossLightShininess;
uniform mediump vec4 _FresnelParams;
uniform mediump float _CellRimShininess;
uniform mediump float _CellRimIntensity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  mediump float ringCrossIntensity_1;
  mediump vec2 texCol3_2;
  mediump vec2 texCol2_3;
  mediump vec2 texCol1_4;
  mediump float ringIntensity_5;
  mediump vec3 I_6;
  mediump float intensity_7;
  mediump vec4 color_8;
  color_8.w = 0.0;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  I_6 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_6, xlv_TEXCOORD1)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  intensity_7 = (xlv_COLOR0.w + tmpvar_10);
  intensity_7 = (intensity_7 + ((
    pow (xlv_TEXCOORD0.x, _CellRimShininess)
   * xlv_COLOR0.xyz) * (
    ((tmpvar_10 * _CellRimIntensity) + (xlv_TEXCOORD3.x * 0.01))
   + 
    (xlv_TEXCOORD3.y * 0.05)
  )).x);
  color_8.xyz = (intensity_7 * xlv_COLOR0.xyz);
  lowp vec2 tmpvar_11;
  tmpvar_11 = texture2D (_RingTex, xlv_TEXCOORD4.xy).xy;
  texCol1_4 = tmpvar_11;
  lowp vec2 tmpvar_12;
  tmpvar_12 = texture2D (_RingTex, xlv_TEXCOORD5.xy).xy;
  texCol2_3 = tmpvar_12;
  lowp vec2 tmpvar_13;
  tmpvar_13 = texture2D (_RingTex, xlv_TEXCOORD6.xy).xy;
  texCol3_2 = tmpvar_13;
  ringIntensity_5 = (texCol1_4.x * xlv_TEXCOORD4.z);
  ringIntensity_5 = (ringIntensity_5 + (texCol2_3.x * xlv_TEXCOORD5.z));
  ringIntensity_5 = (ringIntensity_5 + (texCol3_2.x * xlv_TEXCOORD6.z));
  mediump float tmpvar_14;
  tmpvar_14 = (texCol1_4.y * texCol2_3.y);
  mediump float tmpvar_15;
  tmpvar_15 = (texCol2_3.y * texCol3_2.y);
  mediump float tmpvar_16;
  tmpvar_16 = (texCol3_2.y * texCol1_4.y);
  ringCrossIntensity_1 = ((tmpvar_14 + tmpvar_15) - (tmpvar_14 * tmpvar_15));
  ringCrossIntensity_1 = ((ringCrossIntensity_1 + tmpvar_16) - (ringCrossIntensity_1 * tmpvar_16));
  ringIntensity_5 = (ringIntensity_5 + (pow (ringCrossIntensity_1, _RingCrossLightShininess) * _RingCrossLightIntensity));
  color_8.xyz = (color_8.xyz + (ringIntensity_5 * (_RingColor.xyz * _RingColor.w)));
  gl_FragData[0] = color_8;
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
SubShader {
 LOD 200
 Tags { "OutlineType" = "None" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "None" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Front
  GpuProgramID 185914
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump float _CellShrink;
uniform mediump vec4 _HitPosition;
uniform mediump float _HitDistRange;
uniform mediump float _HitDistSmoothRange;
uniform mediump float _HitAnmStartTime;
uniform mediump float _HitAnmEndTime;
uniform mediump vec4 _BandPosition;
uniform mediump float _BandWidth;
uniform mediump float _BandIntensity;
uniform mediump vec4 _Params2;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  highp vec4 tmpvar_2;
  tmpvar_2.w = _glesVertex.w;
  mediump vec3 cellNormal_3;
  mediump float hitDist_4;
  mediump vec2 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  mediump vec2 tmpvar_8;
  tmpvar_8.y = 0.0;
  tmpvar_5 = tmpvar_1.xy;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_9 * _glesVertex.xyz));
  tmpvar_6 = -(tmpvar_10);
  highp float tmpvar_11;
  tmpvar_11 = max (dot (fract(
    (sin((_glesNormal * vec3(12.9898, 78.233, 45.5432))) * 43758.55)
  ), vec3(1.0, 1.0, 1.0)), 0.5);
  tmpvar_7 = ((_glesColor * _Color) * tmpvar_11);
  mediump vec4 tmpvar_12;
  tmpvar_12 = normalize(_HitPosition);
  highp float tmpvar_13;
  highp vec3 x_14;
  x_14 = (_glesNormal - tmpvar_12.xyz);
  tmpvar_13 = sqrt(dot (x_14, x_14));
  hitDist_4 = tmpvar_13;
  mediump float tmpvar_15;
  tmpvar_15 = (_HitDistRange * _HitAnmStartTime);
  mediump float tmpvar_16;
  tmpvar_16 = clamp (((hitDist_4 - tmpvar_15) / (
    (tmpvar_15 + _HitDistSmoothRange)
   - tmpvar_15)), 0.0, 1.0);
  tmpvar_8.x = (((1.0 - 
    (tmpvar_16 * (tmpvar_16 * (3.0 - (2.0 * tmpvar_16))))
  ) * _Params2.z) * clamp ((1.0 - _HitAnmEndTime), 0.0, 1.0));
  tmpvar_7 = (tmpvar_7 + (_Color * tmpvar_8.x));
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(_glesNormal);
  cellNormal_3 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = ((vec3(1.0, 0.0, 0.0) * _BandPosition.zxy) - (vec3(0.0, 0.0, 1.0) * _BandPosition.yzx));
  mediump float tmpvar_19;
  tmpvar_19 = dot (cellNormal_3, normalize((
    (_BandPosition.yzx * tmpvar_18.zxy)
   - 
    (_BandPosition.zxy * tmpvar_18.yzx)
  )));
  mediump float tmpvar_20;
  tmpvar_20 = clamp ((abs(
    cos(((1.570796 - (
      sign(tmpvar_19)
     * 
      (1.570796 - (sqrt((1.0 - 
        abs(tmpvar_19)
      )) * (1.570796 + (
        abs(tmpvar_19)
       * 
        (-0.2146018 + (abs(tmpvar_19) * (0.08656672 + (
          abs(tmpvar_19)
         * -0.03102955))))
      ))))
    )) - _BandPosition.w))
  ) / _BandWidth), 0.0, 1.0);
  tmpvar_8.y = ((1.0 - (tmpvar_20 * 
    (tmpvar_20 * (3.0 - (2.0 * tmpvar_20)))
  )) * _BandIntensity);
  tmpvar_7 = (tmpvar_7 + (_Color * tmpvar_8.y));
  mediump float tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = (tmpvar_8.y * 0.004);
  tmpvar_21 = (tmpvar_22 * tmpvar_22);
  tmpvar_2.xyz = (_glesVertex.xyz + ((_glesNormal - _glesVertex.xyz) * (
    (_CellShrink * 0.01)
   + tmpvar_21)));
  highp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = tmpvar_2.xyz;
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * tmpvar_2);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_23));
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (tmpvar_24.xyz / tmpvar_24.w);
  xlv_COLOR0 = tmpvar_7;
  xlv_TEXCOORD3 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _FresnelParams;
uniform mediump float _CellRimShininess;
uniform mediump float _CellRimIntensity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 I_1;
  mediump float intensity_2;
  mediump vec4 color_3;
  color_3.w = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  I_1 = tmpvar_4;
  mediump float tmpvar_5;
  tmpvar_5 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_1, xlv_TEXCOORD1)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  intensity_2 = (xlv_COLOR0.w + tmpvar_5);
  intensity_2 = (intensity_2 + ((
    pow (xlv_TEXCOORD0.x, _CellRimShininess)
   * xlv_COLOR0.xyz) * (
    ((tmpvar_5 * _CellRimIntensity) + (xlv_TEXCOORD3.x * 0.01))
   + 
    (xlv_TEXCOORD3.y * 0.05)
  )).x);
  color_3.xyz = (intensity_2 * xlv_COLOR0.xyz);
  gl_FragData[0] = color_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump float _CellShrink;
uniform mediump vec4 _HitPosition;
uniform mediump float _HitDistRange;
uniform mediump float _HitDistSmoothRange;
uniform mediump float _HitAnmStartTime;
uniform mediump float _HitAnmEndTime;
uniform mediump vec4 _BandPosition;
uniform mediump float _BandWidth;
uniform mediump float _BandIntensity;
uniform mediump vec4 _Params2;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  highp vec4 tmpvar_2;
  tmpvar_2.w = _glesVertex.w;
  mediump vec3 cellNormal_3;
  mediump float hitDist_4;
  mediump vec2 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  mediump vec2 tmpvar_8;
  tmpvar_8.y = 0.0;
  tmpvar_5 = tmpvar_1.xy;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_9 * _glesVertex.xyz));
  tmpvar_6 = -(tmpvar_10);
  highp float tmpvar_11;
  tmpvar_11 = max (dot (fract(
    (sin((_glesNormal * vec3(12.9898, 78.233, 45.5432))) * 43758.55)
  ), vec3(1.0, 1.0, 1.0)), 0.5);
  tmpvar_7 = ((_glesColor * _Color) * tmpvar_11);
  mediump vec4 tmpvar_12;
  tmpvar_12 = normalize(_HitPosition);
  highp float tmpvar_13;
  highp vec3 x_14;
  x_14 = (_glesNormal - tmpvar_12.xyz);
  tmpvar_13 = sqrt(dot (x_14, x_14));
  hitDist_4 = tmpvar_13;
  mediump float tmpvar_15;
  tmpvar_15 = (_HitDistRange * _HitAnmStartTime);
  mediump float tmpvar_16;
  tmpvar_16 = clamp (((hitDist_4 - tmpvar_15) / (
    (tmpvar_15 + _HitDistSmoothRange)
   - tmpvar_15)), 0.0, 1.0);
  tmpvar_8.x = (((1.0 - 
    (tmpvar_16 * (tmpvar_16 * (3.0 - (2.0 * tmpvar_16))))
  ) * _Params2.z) * clamp ((1.0 - _HitAnmEndTime), 0.0, 1.0));
  tmpvar_7 = (tmpvar_7 + (_Color * tmpvar_8.x));
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(_glesNormal);
  cellNormal_3 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = ((vec3(1.0, 0.0, 0.0) * _BandPosition.zxy) - (vec3(0.0, 0.0, 1.0) * _BandPosition.yzx));
  mediump float tmpvar_19;
  tmpvar_19 = dot (cellNormal_3, normalize((
    (_BandPosition.yzx * tmpvar_18.zxy)
   - 
    (_BandPosition.zxy * tmpvar_18.yzx)
  )));
  mediump float tmpvar_20;
  tmpvar_20 = clamp ((abs(
    cos(((1.570796 - (
      sign(tmpvar_19)
     * 
      (1.570796 - (sqrt((1.0 - 
        abs(tmpvar_19)
      )) * (1.570796 + (
        abs(tmpvar_19)
       * 
        (-0.2146018 + (abs(tmpvar_19) * (0.08656672 + (
          abs(tmpvar_19)
         * -0.03102955))))
      ))))
    )) - _BandPosition.w))
  ) / _BandWidth), 0.0, 1.0);
  tmpvar_8.y = ((1.0 - (tmpvar_20 * 
    (tmpvar_20 * (3.0 - (2.0 * tmpvar_20)))
  )) * _BandIntensity);
  tmpvar_7 = (tmpvar_7 + (_Color * tmpvar_8.y));
  mediump float tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = (tmpvar_8.y * 0.004);
  tmpvar_21 = (tmpvar_22 * tmpvar_22);
  tmpvar_2.xyz = (_glesVertex.xyz + ((_glesNormal - _glesVertex.xyz) * (
    (_CellShrink * 0.01)
   + tmpvar_21)));
  highp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = tmpvar_2.xyz;
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * tmpvar_2);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_23));
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (tmpvar_24.xyz / tmpvar_24.w);
  xlv_COLOR0 = tmpvar_7;
  xlv_TEXCOORD3 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _FresnelParams;
uniform mediump float _CellRimShininess;
uniform mediump float _CellRimIntensity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 I_1;
  mediump float intensity_2;
  mediump vec4 color_3;
  color_3.w = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  I_1 = tmpvar_4;
  mediump float tmpvar_5;
  tmpvar_5 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_1, xlv_TEXCOORD1)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  intensity_2 = (xlv_COLOR0.w + tmpvar_5);
  intensity_2 = (intensity_2 + ((
    pow (xlv_TEXCOORD0.x, _CellRimShininess)
   * xlv_COLOR0.xyz) * (
    ((tmpvar_5 * _CellRimIntensity) + (xlv_TEXCOORD3.x * 0.01))
   + 
    (xlv_TEXCOORD3.y * 0.05)
  )).x);
  color_3.xyz = (intensity_2 * xlv_COLOR0.xyz);
  gl_FragData[0] = color_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump float _CellShrink;
uniform mediump vec4 _HitPosition;
uniform mediump float _HitDistRange;
uniform mediump float _HitDistSmoothRange;
uniform mediump float _HitAnmStartTime;
uniform mediump float _HitAnmEndTime;
uniform mediump vec4 _BandPosition;
uniform mediump float _BandWidth;
uniform mediump float _BandIntensity;
uniform mediump vec4 _Params2;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  highp vec4 tmpvar_2;
  tmpvar_2.w = _glesVertex.w;
  mediump vec3 cellNormal_3;
  mediump float hitDist_4;
  mediump vec2 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  mediump vec2 tmpvar_8;
  tmpvar_8.y = 0.0;
  tmpvar_5 = tmpvar_1.xy;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_9 * _glesVertex.xyz));
  tmpvar_6 = -(tmpvar_10);
  highp float tmpvar_11;
  tmpvar_11 = max (dot (fract(
    (sin((_glesNormal * vec3(12.9898, 78.233, 45.5432))) * 43758.55)
  ), vec3(1.0, 1.0, 1.0)), 0.5);
  tmpvar_7 = ((_glesColor * _Color) * tmpvar_11);
  mediump vec4 tmpvar_12;
  tmpvar_12 = normalize(_HitPosition);
  highp float tmpvar_13;
  highp vec3 x_14;
  x_14 = (_glesNormal - tmpvar_12.xyz);
  tmpvar_13 = sqrt(dot (x_14, x_14));
  hitDist_4 = tmpvar_13;
  mediump float tmpvar_15;
  tmpvar_15 = (_HitDistRange * _HitAnmStartTime);
  mediump float tmpvar_16;
  tmpvar_16 = clamp (((hitDist_4 - tmpvar_15) / (
    (tmpvar_15 + _HitDistSmoothRange)
   - tmpvar_15)), 0.0, 1.0);
  tmpvar_8.x = (((1.0 - 
    (tmpvar_16 * (tmpvar_16 * (3.0 - (2.0 * tmpvar_16))))
  ) * _Params2.z) * clamp ((1.0 - _HitAnmEndTime), 0.0, 1.0));
  tmpvar_7 = (tmpvar_7 + (_Color * tmpvar_8.x));
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(_glesNormal);
  cellNormal_3 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = ((vec3(1.0, 0.0, 0.0) * _BandPosition.zxy) - (vec3(0.0, 0.0, 1.0) * _BandPosition.yzx));
  mediump float tmpvar_19;
  tmpvar_19 = dot (cellNormal_3, normalize((
    (_BandPosition.yzx * tmpvar_18.zxy)
   - 
    (_BandPosition.zxy * tmpvar_18.yzx)
  )));
  mediump float tmpvar_20;
  tmpvar_20 = clamp ((abs(
    cos(((1.570796 - (
      sign(tmpvar_19)
     * 
      (1.570796 - (sqrt((1.0 - 
        abs(tmpvar_19)
      )) * (1.570796 + (
        abs(tmpvar_19)
       * 
        (-0.2146018 + (abs(tmpvar_19) * (0.08656672 + (
          abs(tmpvar_19)
         * -0.03102955))))
      ))))
    )) - _BandPosition.w))
  ) / _BandWidth), 0.0, 1.0);
  tmpvar_8.y = ((1.0 - (tmpvar_20 * 
    (tmpvar_20 * (3.0 - (2.0 * tmpvar_20)))
  )) * _BandIntensity);
  tmpvar_7 = (tmpvar_7 + (_Color * tmpvar_8.y));
  mediump float tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = (tmpvar_8.y * 0.004);
  tmpvar_21 = (tmpvar_22 * tmpvar_22);
  tmpvar_2.xyz = (_glesVertex.xyz + ((_glesNormal - _glesVertex.xyz) * (
    (_CellShrink * 0.01)
   + tmpvar_21)));
  highp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = tmpvar_2.xyz;
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * tmpvar_2);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_23));
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (tmpvar_24.xyz / tmpvar_24.w);
  xlv_COLOR0 = tmpvar_7;
  xlv_TEXCOORD3 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _FresnelParams;
uniform mediump float _CellRimShininess;
uniform mediump float _CellRimIntensity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 I_1;
  mediump float intensity_2;
  mediump vec4 color_3;
  color_3.w = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  I_1 = tmpvar_4;
  mediump float tmpvar_5;
  tmpvar_5 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_1, xlv_TEXCOORD1)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  intensity_2 = (xlv_COLOR0.w + tmpvar_5);
  intensity_2 = (intensity_2 + ((
    pow (xlv_TEXCOORD0.x, _CellRimShininess)
   * xlv_COLOR0.xyz) * (
    ((tmpvar_5 * _CellRimIntensity) + (xlv_TEXCOORD3.x * 0.01))
   + 
    (xlv_TEXCOORD3.y * 0.05)
  )).x);
  color_3.xyz = (intensity_2 * xlv_COLOR0.xyz);
  gl_FragData[0] = color_3;
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
  Tags { "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "None" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 201121
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump float _CellShrink;
uniform mediump vec4 _HitPosition;
uniform mediump float _HitDistRange;
uniform mediump float _HitDistSmoothRange;
uniform mediump float _HitAnmStartTime;
uniform mediump float _HitAnmEndTime;
uniform mediump vec4 _BandPosition;
uniform mediump float _BandWidth;
uniform mediump float _BandIntensity;
uniform mediump vec4 _Params2;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  highp vec4 tmpvar_2;
  tmpvar_2.w = _glesVertex.w;
  mediump vec3 cellNormal_3;
  mediump float hitDist_4;
  mediump vec2 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  mediump vec2 tmpvar_8;
  tmpvar_8.y = 0.0;
  tmpvar_5 = tmpvar_1.xy;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_9 * _glesVertex.xyz));
  tmpvar_6 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = max (dot (fract(
    (sin((_glesNormal * vec3(12.9898, 78.233, 45.5432))) * 43758.55)
  ), vec3(1.0, 1.0, 1.0)), 0.5);
  tmpvar_7 = ((_glesColor * _Color) * tmpvar_11);
  mediump vec4 tmpvar_12;
  tmpvar_12 = normalize(_HitPosition);
  highp float tmpvar_13;
  highp vec3 x_14;
  x_14 = (_glesNormal - tmpvar_12.xyz);
  tmpvar_13 = sqrt(dot (x_14, x_14));
  hitDist_4 = tmpvar_13;
  mediump float tmpvar_15;
  tmpvar_15 = (_HitDistRange * _HitAnmStartTime);
  mediump float tmpvar_16;
  tmpvar_16 = clamp (((hitDist_4 - tmpvar_15) / (
    (tmpvar_15 + _HitDistSmoothRange)
   - tmpvar_15)), 0.0, 1.0);
  tmpvar_8.x = (((1.0 - 
    (tmpvar_16 * (tmpvar_16 * (3.0 - (2.0 * tmpvar_16))))
  ) * _Params2.z) * clamp ((1.0 - _HitAnmEndTime), 0.0, 1.0));
  tmpvar_7 = (tmpvar_7 + (_Color * tmpvar_8.x));
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(_glesNormal);
  cellNormal_3 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = ((vec3(1.0, 0.0, 0.0) * _BandPosition.zxy) - (vec3(0.0, 0.0, 1.0) * _BandPosition.yzx));
  mediump float tmpvar_19;
  tmpvar_19 = dot (cellNormal_3, normalize((
    (_BandPosition.yzx * tmpvar_18.zxy)
   - 
    (_BandPosition.zxy * tmpvar_18.yzx)
  )));
  mediump float tmpvar_20;
  tmpvar_20 = clamp ((abs(
    cos(((1.570796 - (
      sign(tmpvar_19)
     * 
      (1.570796 - (sqrt((1.0 - 
        abs(tmpvar_19)
      )) * (1.570796 + (
        abs(tmpvar_19)
       * 
        (-0.2146018 + (abs(tmpvar_19) * (0.08656672 + (
          abs(tmpvar_19)
         * -0.03102955))))
      ))))
    )) - _BandPosition.w))
  ) / _BandWidth), 0.0, 1.0);
  tmpvar_8.y = ((1.0 - (tmpvar_20 * 
    (tmpvar_20 * (3.0 - (2.0 * tmpvar_20)))
  )) * _BandIntensity);
  tmpvar_7 = (tmpvar_7 + (_Color * tmpvar_8.y));
  mediump float tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = (tmpvar_8.y * 0.004);
  tmpvar_21 = (tmpvar_22 * tmpvar_22);
  tmpvar_2.xyz = (_glesVertex.xyz + ((_glesNormal - _glesVertex.xyz) * (
    (_CellShrink * 0.01)
   + tmpvar_21)));
  highp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = tmpvar_2.xyz;
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * tmpvar_2);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_23));
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (tmpvar_24.xyz / tmpvar_24.w);
  xlv_COLOR0 = tmpvar_7;
  xlv_TEXCOORD3 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _FresnelParams;
uniform mediump float _CellRimShininess;
uniform mediump float _CellRimIntensity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 I_1;
  mediump float intensity_2;
  mediump vec4 color_3;
  color_3.w = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  I_1 = tmpvar_4;
  mediump float tmpvar_5;
  tmpvar_5 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_1, xlv_TEXCOORD1)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  intensity_2 = (xlv_COLOR0.w + tmpvar_5);
  intensity_2 = (intensity_2 + ((
    pow (xlv_TEXCOORD0.x, _CellRimShininess)
   * xlv_COLOR0.xyz) * (
    ((tmpvar_5 * _CellRimIntensity) + (xlv_TEXCOORD3.x * 0.01))
   + 
    (xlv_TEXCOORD3.y * 0.05)
  )).x);
  color_3.xyz = (intensity_2 * xlv_COLOR0.xyz);
  gl_FragData[0] = color_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump float _CellShrink;
uniform mediump vec4 _HitPosition;
uniform mediump float _HitDistRange;
uniform mediump float _HitDistSmoothRange;
uniform mediump float _HitAnmStartTime;
uniform mediump float _HitAnmEndTime;
uniform mediump vec4 _BandPosition;
uniform mediump float _BandWidth;
uniform mediump float _BandIntensity;
uniform mediump vec4 _Params2;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  highp vec4 tmpvar_2;
  tmpvar_2.w = _glesVertex.w;
  mediump vec3 cellNormal_3;
  mediump float hitDist_4;
  mediump vec2 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  mediump vec2 tmpvar_8;
  tmpvar_8.y = 0.0;
  tmpvar_5 = tmpvar_1.xy;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_9 * _glesVertex.xyz));
  tmpvar_6 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = max (dot (fract(
    (sin((_glesNormal * vec3(12.9898, 78.233, 45.5432))) * 43758.55)
  ), vec3(1.0, 1.0, 1.0)), 0.5);
  tmpvar_7 = ((_glesColor * _Color) * tmpvar_11);
  mediump vec4 tmpvar_12;
  tmpvar_12 = normalize(_HitPosition);
  highp float tmpvar_13;
  highp vec3 x_14;
  x_14 = (_glesNormal - tmpvar_12.xyz);
  tmpvar_13 = sqrt(dot (x_14, x_14));
  hitDist_4 = tmpvar_13;
  mediump float tmpvar_15;
  tmpvar_15 = (_HitDistRange * _HitAnmStartTime);
  mediump float tmpvar_16;
  tmpvar_16 = clamp (((hitDist_4 - tmpvar_15) / (
    (tmpvar_15 + _HitDistSmoothRange)
   - tmpvar_15)), 0.0, 1.0);
  tmpvar_8.x = (((1.0 - 
    (tmpvar_16 * (tmpvar_16 * (3.0 - (2.0 * tmpvar_16))))
  ) * _Params2.z) * clamp ((1.0 - _HitAnmEndTime), 0.0, 1.0));
  tmpvar_7 = (tmpvar_7 + (_Color * tmpvar_8.x));
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(_glesNormal);
  cellNormal_3 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = ((vec3(1.0, 0.0, 0.0) * _BandPosition.zxy) - (vec3(0.0, 0.0, 1.0) * _BandPosition.yzx));
  mediump float tmpvar_19;
  tmpvar_19 = dot (cellNormal_3, normalize((
    (_BandPosition.yzx * tmpvar_18.zxy)
   - 
    (_BandPosition.zxy * tmpvar_18.yzx)
  )));
  mediump float tmpvar_20;
  tmpvar_20 = clamp ((abs(
    cos(((1.570796 - (
      sign(tmpvar_19)
     * 
      (1.570796 - (sqrt((1.0 - 
        abs(tmpvar_19)
      )) * (1.570796 + (
        abs(tmpvar_19)
       * 
        (-0.2146018 + (abs(tmpvar_19) * (0.08656672 + (
          abs(tmpvar_19)
         * -0.03102955))))
      ))))
    )) - _BandPosition.w))
  ) / _BandWidth), 0.0, 1.0);
  tmpvar_8.y = ((1.0 - (tmpvar_20 * 
    (tmpvar_20 * (3.0 - (2.0 * tmpvar_20)))
  )) * _BandIntensity);
  tmpvar_7 = (tmpvar_7 + (_Color * tmpvar_8.y));
  mediump float tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = (tmpvar_8.y * 0.004);
  tmpvar_21 = (tmpvar_22 * tmpvar_22);
  tmpvar_2.xyz = (_glesVertex.xyz + ((_glesNormal - _glesVertex.xyz) * (
    (_CellShrink * 0.01)
   + tmpvar_21)));
  highp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = tmpvar_2.xyz;
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * tmpvar_2);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_23));
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (tmpvar_24.xyz / tmpvar_24.w);
  xlv_COLOR0 = tmpvar_7;
  xlv_TEXCOORD3 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _FresnelParams;
uniform mediump float _CellRimShininess;
uniform mediump float _CellRimIntensity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 I_1;
  mediump float intensity_2;
  mediump vec4 color_3;
  color_3.w = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  I_1 = tmpvar_4;
  mediump float tmpvar_5;
  tmpvar_5 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_1, xlv_TEXCOORD1)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  intensity_2 = (xlv_COLOR0.w + tmpvar_5);
  intensity_2 = (intensity_2 + ((
    pow (xlv_TEXCOORD0.x, _CellRimShininess)
   * xlv_COLOR0.xyz) * (
    ((tmpvar_5 * _CellRimIntensity) + (xlv_TEXCOORD3.x * 0.01))
   + 
    (xlv_TEXCOORD3.y * 0.05)
  )).x);
  color_3.xyz = (intensity_2 * xlv_COLOR0.xyz);
  gl_FragData[0] = color_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump float _CellShrink;
uniform mediump vec4 _HitPosition;
uniform mediump float _HitDistRange;
uniform mediump float _HitDistSmoothRange;
uniform mediump float _HitAnmStartTime;
uniform mediump float _HitAnmEndTime;
uniform mediump vec4 _BandPosition;
uniform mediump float _BandWidth;
uniform mediump float _BandIntensity;
uniform mediump vec4 _Params2;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  highp vec4 tmpvar_2;
  tmpvar_2.w = _glesVertex.w;
  mediump vec3 cellNormal_3;
  mediump float hitDist_4;
  mediump vec2 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  mediump vec2 tmpvar_8;
  tmpvar_8.y = 0.0;
  tmpvar_5 = tmpvar_1.xy;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_9 * _glesVertex.xyz));
  tmpvar_6 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = max (dot (fract(
    (sin((_glesNormal * vec3(12.9898, 78.233, 45.5432))) * 43758.55)
  ), vec3(1.0, 1.0, 1.0)), 0.5);
  tmpvar_7 = ((_glesColor * _Color) * tmpvar_11);
  mediump vec4 tmpvar_12;
  tmpvar_12 = normalize(_HitPosition);
  highp float tmpvar_13;
  highp vec3 x_14;
  x_14 = (_glesNormal - tmpvar_12.xyz);
  tmpvar_13 = sqrt(dot (x_14, x_14));
  hitDist_4 = tmpvar_13;
  mediump float tmpvar_15;
  tmpvar_15 = (_HitDistRange * _HitAnmStartTime);
  mediump float tmpvar_16;
  tmpvar_16 = clamp (((hitDist_4 - tmpvar_15) / (
    (tmpvar_15 + _HitDistSmoothRange)
   - tmpvar_15)), 0.0, 1.0);
  tmpvar_8.x = (((1.0 - 
    (tmpvar_16 * (tmpvar_16 * (3.0 - (2.0 * tmpvar_16))))
  ) * _Params2.z) * clamp ((1.0 - _HitAnmEndTime), 0.0, 1.0));
  tmpvar_7 = (tmpvar_7 + (_Color * tmpvar_8.x));
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(_glesNormal);
  cellNormal_3 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = ((vec3(1.0, 0.0, 0.0) * _BandPosition.zxy) - (vec3(0.0, 0.0, 1.0) * _BandPosition.yzx));
  mediump float tmpvar_19;
  tmpvar_19 = dot (cellNormal_3, normalize((
    (_BandPosition.yzx * tmpvar_18.zxy)
   - 
    (_BandPosition.zxy * tmpvar_18.yzx)
  )));
  mediump float tmpvar_20;
  tmpvar_20 = clamp ((abs(
    cos(((1.570796 - (
      sign(tmpvar_19)
     * 
      (1.570796 - (sqrt((1.0 - 
        abs(tmpvar_19)
      )) * (1.570796 + (
        abs(tmpvar_19)
       * 
        (-0.2146018 + (abs(tmpvar_19) * (0.08656672 + (
          abs(tmpvar_19)
         * -0.03102955))))
      ))))
    )) - _BandPosition.w))
  ) / _BandWidth), 0.0, 1.0);
  tmpvar_8.y = ((1.0 - (tmpvar_20 * 
    (tmpvar_20 * (3.0 - (2.0 * tmpvar_20)))
  )) * _BandIntensity);
  tmpvar_7 = (tmpvar_7 + (_Color * tmpvar_8.y));
  mediump float tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = (tmpvar_8.y * 0.004);
  tmpvar_21 = (tmpvar_22 * tmpvar_22);
  tmpvar_2.xyz = (_glesVertex.xyz + ((_glesNormal - _glesVertex.xyz) * (
    (_CellShrink * 0.01)
   + tmpvar_21)));
  highp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = tmpvar_2.xyz;
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * tmpvar_2);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_23));
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = (tmpvar_24.xyz / tmpvar_24.w);
  xlv_COLOR0 = tmpvar_7;
  xlv_TEXCOORD3 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _FresnelParams;
uniform mediump float _CellRimShininess;
uniform mediump float _CellRimIntensity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 I_1;
  mediump float intensity_2;
  mediump vec4 color_3;
  color_3.w = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  I_1 = tmpvar_4;
  mediump float tmpvar_5;
  tmpvar_5 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_1, xlv_TEXCOORD1)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  intensity_2 = (xlv_COLOR0.w + tmpvar_5);
  intensity_2 = (intensity_2 + ((
    pow (xlv_TEXCOORD0.x, _CellRimShininess)
   * xlv_COLOR0.xyz) * (
    ((tmpvar_5 * _CellRimIntensity) + (xlv_TEXCOORD3.x * 0.01))
   + 
    (xlv_TEXCOORD3.y * 0.05)
  )).x);
  color_3.xyz = (intensity_2 * xlv_COLOR0.xyz);
  gl_FragData[0] = color_3;
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
CustomEditor "MoleMole.PropShaderEditorBase"
}