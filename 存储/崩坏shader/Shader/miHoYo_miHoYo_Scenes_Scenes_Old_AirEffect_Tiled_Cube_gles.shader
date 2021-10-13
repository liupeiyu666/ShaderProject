//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/AirEffect_Tiled_Cube" {
Properties {
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Base (RGB) Trans (A)", 2D) = "white" { }
_EnvTex ("Environment Texture (RGB)", Cube) = "grey" { }
_Reflectivity ("Reflectivity", Range(0, 5)) = 1
_ReflectFresnel ("Reflect Fresnel (base, power, scale)", Vector) = (1,1,0,0)
[Header(Circle)] _CircleColorScaler ("Circle Color", Color) = (1,1,1,1)
_CircleColorTex ("Base (Circle Color) Trans", 2D) = "white" { }
_CircleRadius ("Circle Radius", Range(1, 100)) = 14
[Header(Lighting)] _LightDir ("LightDir (xyz)", Vector) = (1,-1,0,0)
_Ambient ("Ambient", Range(0, 1)) = 0.7
_Diffuse ("Diffuse", Range(0, 1)) = 0.5
_Specular ("Specular", Range(0, 1)) = 0.1
_Shininess ("Shininess", Range(0.1, 100)) = 20
[Header(Camera)] _CamDistRatio ("Camera Distance Ratio", Range(0, 1)) = 0.1
_CamHeightOffset ("Camera Height", Float) = 5
_CamRotate ("Camera Rotate", Range(-3.14159, 3.14159)) = 0
}
SubShader {
 LOD 200
 Tags { "DisableBatching" = "true" "RenderType" = "Opaque" }
 Pass {
  LOD 200
  Tags { "DisableBatching" = "true" "RenderType" = "Opaque" }
  GpuProgramID 481
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp float sint_1;
  highp float cost_2;
  highp vec3 adjCamPos_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec2 tmpvar_6;
  mediump vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  highp vec3 scale_12;
  highp vec4 v_13;
  v_13.x = unity_ObjectToWorld[0].x;
  v_13.y = unity_ObjectToWorld[1].x;
  v_13.z = unity_ObjectToWorld[2].x;
  v_13.w = unity_ObjectToWorld[3].x;
  scale_12.x = sqrt(dot (v_13.xyz, v_13.xyz));
  highp vec4 v_14;
  v_14.x = unity_ObjectToWorld[0].y;
  v_14.y = unity_ObjectToWorld[1].y;
  v_14.z = unity_ObjectToWorld[2].y;
  v_14.w = unity_ObjectToWorld[3].y;
  scale_12.y = sqrt(dot (v_14.xyz, v_14.xyz));
  highp vec4 v_15;
  v_15.x = unity_ObjectToWorld[0].z;
  v_15.y = unity_ObjectToWorld[1].z;
  v_15.z = unity_ObjectToWorld[2].z;
  v_15.w = unity_ObjectToWorld[3].z;
  scale_12.z = sqrt(dot (v_15.xyz, v_15.xyz));
  if ((tmpvar_11.y > 0.5)) {
    tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.zx);
    tmpvar_6 = vec2(0.0, 0.0);
  } else {
    if ((tmpvar_11.y < -0.5)) {
      tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.zx);
      tmpvar_6 = vec2(1.0, 0.0);
    } else {
      if ((tmpvar_11.x > 0.5)) {
        tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.zy);
        tmpvar_6 = vec2(1.0, 0.0);
      } else {
        if ((tmpvar_11.x < -0.5)) {
          tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.zy);
          tmpvar_6 = vec2(1.0, 0.0);
        } else {
          if ((tmpvar_11.z > 0.5)) {
            tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.xy);
            tmpvar_6 = vec2(1.0, 0.0);
          } else {
            if ((tmpvar_11.z < -0.5)) {
              tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.xy);
              tmpvar_6 = vec2(1.0, 0.0);
            };
          };
        };
      };
    };
  };
  tmpvar_5 = ((tmpvar_5 * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  adjCamPos_3.xz = (tmpvar_9.xz - ((tmpvar_9.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_3.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_28;
  tmpvar_28 = normalize((tmpvar_9 - adjCamPos_3));
  tmpvar_7 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = cos(_CamRotate);
  cost_2 = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = sin(_CamRotate);
  sint_1 = tmpvar_30;
  highp mat2 tmpvar_31;
  tmpvar_31[0].x = cost_2;
  tmpvar_31[0].y = -(sint_1);
  tmpvar_31[1].x = sint_1;
  tmpvar_31[1].y = cost_2;
  tmpvar_7.xz = (tmpvar_31 * tmpvar_7.xz);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_COLOR1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump vec4 _ReflectFresnel;
uniform highp vec4 _AvatarPosInWorldPos;
uniform highp vec4 _PrevAvatarPosInWorldPos;
uniform highp float _IsCurCircleBusy;
uniform highp float _IsPrevCircleBusy;
uniform highp float _CircleTime;
uniform highp float _PrevCircleTime;
uniform highp float _TimeIntervalRatio;
uniform sampler2D _CircleColorTex;
uniform highp vec4 _CircleColorTex_ST;
uniform highp float _CircleRadius;
uniform highp vec3 _LightDir;
uniform mediump float _Ambient;
uniform mediump float _Diffuse;
uniform mediump float _Specular;
uniform mediump float _Shininess;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  mediump float f_1;
  mediump vec4 prevCircleColor_2;
  mediump vec4 curCircleColor_3;
  mediump vec3 V_4;
  mediump vec3 L_5;
  mediump vec3 N_6;
  mediump vec4 col_7;
  mediump vec4 mainTexColor_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((fract(xlv_TEXCOORD0) + xlv_TEXCOORD1) * vec2(0.5, 1.0));
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, tmpvar_9);
  mainTexColor_8 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(xlv_TEXCOORD2);
  N_6 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = -(normalize(_LightDir));
  L_5 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_4 = tmpvar_13;
  col_7 = (mainTexColor_8 * (_Ambient + (
    max (dot (N_6, L_5), 0.0)
   * _Diffuse)));
  col_7 = (col_7 + (max (0.0, 
    pow (max (dot (N_6, normalize(
      (L_5 + V_4)
    )), 0.001), _Shininess)
  ) * _Specular));
  curCircleColor_3 = vec4(0.0, 0.0, 0.0, 0.0);
  if (bool(_IsCurCircleBusy)) {
    highp vec3 diffDir_14;
    mediump vec4 outColor_15;
    outColor_15 = vec4(0.0, 0.0, 0.0, 0.0);
    highp float tmpvar_16;
    tmpvar_16 = (_CircleTime * _TimeIntervalRatio);
    highp float tmpvar_17;
    tmpvar_17 = floor((sin(
      (1.570795 * tmpvar_16)
    ) * _CircleRadius));
    highp vec3 tmpvar_18;
    tmpvar_18 = (xlv_TEXCOORD3 - _AvatarPosInWorldPos.xyz);
    diffDir_14.xz = tmpvar_18.xz;
    diffDir_14.y = (tmpvar_18.y - 0.5);
    highp vec3 tmpvar_19;
    tmpvar_19 = floor((diffDir_14 + vec3(0.5, 0.5, 0.5)));
    highp float tmpvar_20;
    tmpvar_20 = sqrt(dot (tmpvar_19, tmpvar_19));
    highp float tmpvar_21;
    tmpvar_21 = abs((tmpvar_20 - tmpvar_17));
    if ((tmpvar_21 < 1.51)) {
      mediump vec4 circleColor_22;
      highp vec2 tmpvar_23;
      tmpvar_23 = ((vec2(tmpvar_16) * _CircleColorTex_ST.xy) + _CircleColorTex_ST.zw);
      lowp vec4 tmpvar_24;
      tmpvar_24 = texture2D (_CircleColorTex, tmpvar_23);
      circleColor_22 = tmpvar_24;
      highp float tmpvar_25;
      tmpvar_25 = abs((tmpvar_20 - tmpvar_17));
      outColor_15 = (((circleColor_22 * 
        (1.5 - tmpvar_25)
      ) * (1.0 - tmpvar_16)) * (1.0 - tmpvar_16));
    };
    curCircleColor_3 = outColor_15;
  };
  prevCircleColor_2 = vec4(0.0, 0.0, 0.0, 0.0);
  if (bool(_IsPrevCircleBusy)) {
    highp vec3 diffDir_26;
    mediump vec4 outColor_27;
    outColor_27 = vec4(0.0, 0.0, 0.0, 0.0);
    highp float tmpvar_28;
    tmpvar_28 = (_PrevCircleTime * _TimeIntervalRatio);
    highp float tmpvar_29;
    tmpvar_29 = floor((sin(
      (1.570795 * tmpvar_28)
    ) * _CircleRadius));
    highp vec3 tmpvar_30;
    tmpvar_30 = (xlv_TEXCOORD3 - _PrevAvatarPosInWorldPos.xyz);
    diffDir_26.xz = tmpvar_30.xz;
    diffDir_26.y = (tmpvar_30.y - 0.5);
    highp vec3 tmpvar_31;
    tmpvar_31 = floor((diffDir_26 + vec3(0.5, 0.5, 0.5)));
    highp float tmpvar_32;
    tmpvar_32 = sqrt(dot (tmpvar_31, tmpvar_31));
    highp float tmpvar_33;
    tmpvar_33 = abs((tmpvar_32 - tmpvar_29));
    if ((tmpvar_33 < 1.51)) {
      mediump vec4 circleColor_34;
      highp vec2 tmpvar_35;
      tmpvar_35 = ((vec2(tmpvar_28) * _CircleColorTex_ST.xy) + _CircleColorTex_ST.zw);
      lowp vec4 tmpvar_36;
      tmpvar_36 = texture2D (_CircleColorTex, tmpvar_35);
      circleColor_34 = tmpvar_36;
      highp float tmpvar_37;
      tmpvar_37 = abs((tmpvar_32 - tmpvar_29));
      outColor_27 = (((circleColor_34 * 
        (1.5 - tmpvar_37)
      ) * (1.0 - tmpvar_28)) * (1.0 - tmpvar_28));
    };
    prevCircleColor_2 = outColor_27;
  };
  col_7 = (col_7 + ((
    (curCircleColor_3 + prevCircleColor_2)
   - 
    (curCircleColor_3 * prevCircleColor_2)
  ) * mainTexColor_8.w));
  mediump vec3 tmpvar_38;
  tmpvar_38 = (V_4 - (2.0 * (
    dot (N_6, V_4)
   * N_6)));
  mediump float tmpvar_39;
  tmpvar_39 = abs(dot (N_6, V_4));
  highp float tmpvar_40;
  highp float cs_41;
  cs_41 = tmpvar_39;
  highp float power_42;
  power_42 = _ReflectFresnel.x;
  highp float scale_43;
  scale_43 = _ReflectFresnel.y;
  highp float bias_44;
  bias_44 = _ReflectFresnel.z;
  tmpvar_40 = (bias_44 + (pow (
    clamp ((1.0 - cs_41), 0.0, 1.0)
  , power_42) * scale_43));
  f_1 = tmpvar_40;
  lowp vec4 tmpvar_45;
  tmpvar_45 = textureCube (_EnvTex, tmpvar_38);
  col_7.xyz = (col_7.xyz + ((tmpvar_45.xyz * mainTexColor_8.w) * (f_1 * _Reflectivity)));
  col_7.xyz = mix (col_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_7.w = _BloomFactor;
  gl_FragData[0] = col_7;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp float sint_1;
  highp float cost_2;
  highp vec3 adjCamPos_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec2 tmpvar_6;
  mediump vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  highp vec3 scale_12;
  highp vec4 v_13;
  v_13.x = unity_ObjectToWorld[0].x;
  v_13.y = unity_ObjectToWorld[1].x;
  v_13.z = unity_ObjectToWorld[2].x;
  v_13.w = unity_ObjectToWorld[3].x;
  scale_12.x = sqrt(dot (v_13.xyz, v_13.xyz));
  highp vec4 v_14;
  v_14.x = unity_ObjectToWorld[0].y;
  v_14.y = unity_ObjectToWorld[1].y;
  v_14.z = unity_ObjectToWorld[2].y;
  v_14.w = unity_ObjectToWorld[3].y;
  scale_12.y = sqrt(dot (v_14.xyz, v_14.xyz));
  highp vec4 v_15;
  v_15.x = unity_ObjectToWorld[0].z;
  v_15.y = unity_ObjectToWorld[1].z;
  v_15.z = unity_ObjectToWorld[2].z;
  v_15.w = unity_ObjectToWorld[3].z;
  scale_12.z = sqrt(dot (v_15.xyz, v_15.xyz));
  if ((tmpvar_11.y > 0.5)) {
    tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.zx);
    tmpvar_6 = vec2(0.0, 0.0);
  } else {
    if ((tmpvar_11.y < -0.5)) {
      tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.zx);
      tmpvar_6 = vec2(1.0, 0.0);
    } else {
      if ((tmpvar_11.x > 0.5)) {
        tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.zy);
        tmpvar_6 = vec2(1.0, 0.0);
      } else {
        if ((tmpvar_11.x < -0.5)) {
          tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.zy);
          tmpvar_6 = vec2(1.0, 0.0);
        } else {
          if ((tmpvar_11.z > 0.5)) {
            tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.xy);
            tmpvar_6 = vec2(1.0, 0.0);
          } else {
            if ((tmpvar_11.z < -0.5)) {
              tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.xy);
              tmpvar_6 = vec2(1.0, 0.0);
            };
          };
        };
      };
    };
  };
  tmpvar_5 = ((tmpvar_5 * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  adjCamPos_3.xz = (tmpvar_9.xz - ((tmpvar_9.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_3.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_28;
  tmpvar_28 = normalize((tmpvar_9 - adjCamPos_3));
  tmpvar_7 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = cos(_CamRotate);
  cost_2 = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = sin(_CamRotate);
  sint_1 = tmpvar_30;
  highp mat2 tmpvar_31;
  tmpvar_31[0].x = cost_2;
  tmpvar_31[0].y = -(sint_1);
  tmpvar_31[1].x = sint_1;
  tmpvar_31[1].y = cost_2;
  tmpvar_7.xz = (tmpvar_31 * tmpvar_7.xz);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_COLOR1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump vec4 _ReflectFresnel;
uniform highp vec4 _AvatarPosInWorldPos;
uniform highp vec4 _PrevAvatarPosInWorldPos;
uniform highp float _IsCurCircleBusy;
uniform highp float _IsPrevCircleBusy;
uniform highp float _CircleTime;
uniform highp float _PrevCircleTime;
uniform highp float _TimeIntervalRatio;
uniform sampler2D _CircleColorTex;
uniform highp vec4 _CircleColorTex_ST;
uniform highp float _CircleRadius;
uniform highp vec3 _LightDir;
uniform mediump float _Ambient;
uniform mediump float _Diffuse;
uniform mediump float _Specular;
uniform mediump float _Shininess;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  mediump float f_1;
  mediump vec4 prevCircleColor_2;
  mediump vec4 curCircleColor_3;
  mediump vec3 V_4;
  mediump vec3 L_5;
  mediump vec3 N_6;
  mediump vec4 col_7;
  mediump vec4 mainTexColor_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((fract(xlv_TEXCOORD0) + xlv_TEXCOORD1) * vec2(0.5, 1.0));
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, tmpvar_9);
  mainTexColor_8 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(xlv_TEXCOORD2);
  N_6 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = -(normalize(_LightDir));
  L_5 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_4 = tmpvar_13;
  col_7 = (mainTexColor_8 * (_Ambient + (
    max (dot (N_6, L_5), 0.0)
   * _Diffuse)));
  col_7 = (col_7 + (max (0.0, 
    pow (max (dot (N_6, normalize(
      (L_5 + V_4)
    )), 0.001), _Shininess)
  ) * _Specular));
  curCircleColor_3 = vec4(0.0, 0.0, 0.0, 0.0);
  if (bool(_IsCurCircleBusy)) {
    highp vec3 diffDir_14;
    mediump vec4 outColor_15;
    outColor_15 = vec4(0.0, 0.0, 0.0, 0.0);
    highp float tmpvar_16;
    tmpvar_16 = (_CircleTime * _TimeIntervalRatio);
    highp float tmpvar_17;
    tmpvar_17 = floor((sin(
      (1.570795 * tmpvar_16)
    ) * _CircleRadius));
    highp vec3 tmpvar_18;
    tmpvar_18 = (xlv_TEXCOORD3 - _AvatarPosInWorldPos.xyz);
    diffDir_14.xz = tmpvar_18.xz;
    diffDir_14.y = (tmpvar_18.y - 0.5);
    highp vec3 tmpvar_19;
    tmpvar_19 = floor((diffDir_14 + vec3(0.5, 0.5, 0.5)));
    highp float tmpvar_20;
    tmpvar_20 = sqrt(dot (tmpvar_19, tmpvar_19));
    highp float tmpvar_21;
    tmpvar_21 = abs((tmpvar_20 - tmpvar_17));
    if ((tmpvar_21 < 1.51)) {
      mediump vec4 circleColor_22;
      highp vec2 tmpvar_23;
      tmpvar_23 = ((vec2(tmpvar_16) * _CircleColorTex_ST.xy) + _CircleColorTex_ST.zw);
      lowp vec4 tmpvar_24;
      tmpvar_24 = texture2D (_CircleColorTex, tmpvar_23);
      circleColor_22 = tmpvar_24;
      highp float tmpvar_25;
      tmpvar_25 = abs((tmpvar_20 - tmpvar_17));
      outColor_15 = (((circleColor_22 * 
        (1.5 - tmpvar_25)
      ) * (1.0 - tmpvar_16)) * (1.0 - tmpvar_16));
    };
    curCircleColor_3 = outColor_15;
  };
  prevCircleColor_2 = vec4(0.0, 0.0, 0.0, 0.0);
  if (bool(_IsPrevCircleBusy)) {
    highp vec3 diffDir_26;
    mediump vec4 outColor_27;
    outColor_27 = vec4(0.0, 0.0, 0.0, 0.0);
    highp float tmpvar_28;
    tmpvar_28 = (_PrevCircleTime * _TimeIntervalRatio);
    highp float tmpvar_29;
    tmpvar_29 = floor((sin(
      (1.570795 * tmpvar_28)
    ) * _CircleRadius));
    highp vec3 tmpvar_30;
    tmpvar_30 = (xlv_TEXCOORD3 - _PrevAvatarPosInWorldPos.xyz);
    diffDir_26.xz = tmpvar_30.xz;
    diffDir_26.y = (tmpvar_30.y - 0.5);
    highp vec3 tmpvar_31;
    tmpvar_31 = floor((diffDir_26 + vec3(0.5, 0.5, 0.5)));
    highp float tmpvar_32;
    tmpvar_32 = sqrt(dot (tmpvar_31, tmpvar_31));
    highp float tmpvar_33;
    tmpvar_33 = abs((tmpvar_32 - tmpvar_29));
    if ((tmpvar_33 < 1.51)) {
      mediump vec4 circleColor_34;
      highp vec2 tmpvar_35;
      tmpvar_35 = ((vec2(tmpvar_28) * _CircleColorTex_ST.xy) + _CircleColorTex_ST.zw);
      lowp vec4 tmpvar_36;
      tmpvar_36 = texture2D (_CircleColorTex, tmpvar_35);
      circleColor_34 = tmpvar_36;
      highp float tmpvar_37;
      tmpvar_37 = abs((tmpvar_32 - tmpvar_29));
      outColor_27 = (((circleColor_34 * 
        (1.5 - tmpvar_37)
      ) * (1.0 - tmpvar_28)) * (1.0 - tmpvar_28));
    };
    prevCircleColor_2 = outColor_27;
  };
  col_7 = (col_7 + ((
    (curCircleColor_3 + prevCircleColor_2)
   - 
    (curCircleColor_3 * prevCircleColor_2)
  ) * mainTexColor_8.w));
  mediump vec3 tmpvar_38;
  tmpvar_38 = (V_4 - (2.0 * (
    dot (N_6, V_4)
   * N_6)));
  mediump float tmpvar_39;
  tmpvar_39 = abs(dot (N_6, V_4));
  highp float tmpvar_40;
  highp float cs_41;
  cs_41 = tmpvar_39;
  highp float power_42;
  power_42 = _ReflectFresnel.x;
  highp float scale_43;
  scale_43 = _ReflectFresnel.y;
  highp float bias_44;
  bias_44 = _ReflectFresnel.z;
  tmpvar_40 = (bias_44 + (pow (
    clamp ((1.0 - cs_41), 0.0, 1.0)
  , power_42) * scale_43));
  f_1 = tmpvar_40;
  lowp vec4 tmpvar_45;
  tmpvar_45 = textureCube (_EnvTex, tmpvar_38);
  col_7.xyz = (col_7.xyz + ((tmpvar_45.xyz * mainTexColor_8.w) * (f_1 * _Reflectivity)));
  col_7.xyz = mix (col_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_7.w = _BloomFactor;
  gl_FragData[0] = col_7;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp float sint_1;
  highp float cost_2;
  highp vec3 adjCamPos_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec2 tmpvar_6;
  mediump vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  highp vec3 scale_12;
  highp vec4 v_13;
  v_13.x = unity_ObjectToWorld[0].x;
  v_13.y = unity_ObjectToWorld[1].x;
  v_13.z = unity_ObjectToWorld[2].x;
  v_13.w = unity_ObjectToWorld[3].x;
  scale_12.x = sqrt(dot (v_13.xyz, v_13.xyz));
  highp vec4 v_14;
  v_14.x = unity_ObjectToWorld[0].y;
  v_14.y = unity_ObjectToWorld[1].y;
  v_14.z = unity_ObjectToWorld[2].y;
  v_14.w = unity_ObjectToWorld[3].y;
  scale_12.y = sqrt(dot (v_14.xyz, v_14.xyz));
  highp vec4 v_15;
  v_15.x = unity_ObjectToWorld[0].z;
  v_15.y = unity_ObjectToWorld[1].z;
  v_15.z = unity_ObjectToWorld[2].z;
  v_15.w = unity_ObjectToWorld[3].z;
  scale_12.z = sqrt(dot (v_15.xyz, v_15.xyz));
  if ((tmpvar_11.y > 0.5)) {
    tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.zx);
    tmpvar_6 = vec2(0.0, 0.0);
  } else {
    if ((tmpvar_11.y < -0.5)) {
      tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.zx);
      tmpvar_6 = vec2(1.0, 0.0);
    } else {
      if ((tmpvar_11.x > 0.5)) {
        tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.zy);
        tmpvar_6 = vec2(1.0, 0.0);
      } else {
        if ((tmpvar_11.x < -0.5)) {
          tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.zy);
          tmpvar_6 = vec2(1.0, 0.0);
        } else {
          if ((tmpvar_11.z > 0.5)) {
            tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.xy);
            tmpvar_6 = vec2(1.0, 0.0);
          } else {
            if ((tmpvar_11.z < -0.5)) {
              tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.xy);
              tmpvar_6 = vec2(1.0, 0.0);
            };
          };
        };
      };
    };
  };
  tmpvar_5 = ((tmpvar_5 * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  adjCamPos_3.xz = (tmpvar_9.xz - ((tmpvar_9.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_3.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_28;
  tmpvar_28 = normalize((tmpvar_9 - adjCamPos_3));
  tmpvar_7 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = cos(_CamRotate);
  cost_2 = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = sin(_CamRotate);
  sint_1 = tmpvar_30;
  highp mat2 tmpvar_31;
  tmpvar_31[0].x = cost_2;
  tmpvar_31[0].y = -(sint_1);
  tmpvar_31[1].x = sint_1;
  tmpvar_31[1].y = cost_2;
  tmpvar_7.xz = (tmpvar_31 * tmpvar_7.xz);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_COLOR1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump vec4 _ReflectFresnel;
uniform highp vec4 _AvatarPosInWorldPos;
uniform highp vec4 _PrevAvatarPosInWorldPos;
uniform highp float _IsCurCircleBusy;
uniform highp float _IsPrevCircleBusy;
uniform highp float _CircleTime;
uniform highp float _PrevCircleTime;
uniform highp float _TimeIntervalRatio;
uniform sampler2D _CircleColorTex;
uniform highp vec4 _CircleColorTex_ST;
uniform highp float _CircleRadius;
uniform highp vec3 _LightDir;
uniform mediump float _Ambient;
uniform mediump float _Diffuse;
uniform mediump float _Specular;
uniform mediump float _Shininess;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  mediump float f_1;
  mediump vec4 prevCircleColor_2;
  mediump vec4 curCircleColor_3;
  mediump vec3 V_4;
  mediump vec3 L_5;
  mediump vec3 N_6;
  mediump vec4 col_7;
  mediump vec4 mainTexColor_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((fract(xlv_TEXCOORD0) + xlv_TEXCOORD1) * vec2(0.5, 1.0));
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, tmpvar_9);
  mainTexColor_8 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(xlv_TEXCOORD2);
  N_6 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = -(normalize(_LightDir));
  L_5 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_4 = tmpvar_13;
  col_7 = (mainTexColor_8 * (_Ambient + (
    max (dot (N_6, L_5), 0.0)
   * _Diffuse)));
  col_7 = (col_7 + (max (0.0, 
    pow (max (dot (N_6, normalize(
      (L_5 + V_4)
    )), 0.001), _Shininess)
  ) * _Specular));
  curCircleColor_3 = vec4(0.0, 0.0, 0.0, 0.0);
  if (bool(_IsCurCircleBusy)) {
    highp vec3 diffDir_14;
    mediump vec4 outColor_15;
    outColor_15 = vec4(0.0, 0.0, 0.0, 0.0);
    highp float tmpvar_16;
    tmpvar_16 = (_CircleTime * _TimeIntervalRatio);
    highp float tmpvar_17;
    tmpvar_17 = floor((sin(
      (1.570795 * tmpvar_16)
    ) * _CircleRadius));
    highp vec3 tmpvar_18;
    tmpvar_18 = (xlv_TEXCOORD3 - _AvatarPosInWorldPos.xyz);
    diffDir_14.xz = tmpvar_18.xz;
    diffDir_14.y = (tmpvar_18.y - 0.5);
    highp vec3 tmpvar_19;
    tmpvar_19 = floor((diffDir_14 + vec3(0.5, 0.5, 0.5)));
    highp float tmpvar_20;
    tmpvar_20 = sqrt(dot (tmpvar_19, tmpvar_19));
    highp float tmpvar_21;
    tmpvar_21 = abs((tmpvar_20 - tmpvar_17));
    if ((tmpvar_21 < 1.51)) {
      mediump vec4 circleColor_22;
      highp vec2 tmpvar_23;
      tmpvar_23 = ((vec2(tmpvar_16) * _CircleColorTex_ST.xy) + _CircleColorTex_ST.zw);
      lowp vec4 tmpvar_24;
      tmpvar_24 = texture2D (_CircleColorTex, tmpvar_23);
      circleColor_22 = tmpvar_24;
      highp float tmpvar_25;
      tmpvar_25 = abs((tmpvar_20 - tmpvar_17));
      outColor_15 = (((circleColor_22 * 
        (1.5 - tmpvar_25)
      ) * (1.0 - tmpvar_16)) * (1.0 - tmpvar_16));
    };
    curCircleColor_3 = outColor_15;
  };
  prevCircleColor_2 = vec4(0.0, 0.0, 0.0, 0.0);
  if (bool(_IsPrevCircleBusy)) {
    highp vec3 diffDir_26;
    mediump vec4 outColor_27;
    outColor_27 = vec4(0.0, 0.0, 0.0, 0.0);
    highp float tmpvar_28;
    tmpvar_28 = (_PrevCircleTime * _TimeIntervalRatio);
    highp float tmpvar_29;
    tmpvar_29 = floor((sin(
      (1.570795 * tmpvar_28)
    ) * _CircleRadius));
    highp vec3 tmpvar_30;
    tmpvar_30 = (xlv_TEXCOORD3 - _PrevAvatarPosInWorldPos.xyz);
    diffDir_26.xz = tmpvar_30.xz;
    diffDir_26.y = (tmpvar_30.y - 0.5);
    highp vec3 tmpvar_31;
    tmpvar_31 = floor((diffDir_26 + vec3(0.5, 0.5, 0.5)));
    highp float tmpvar_32;
    tmpvar_32 = sqrt(dot (tmpvar_31, tmpvar_31));
    highp float tmpvar_33;
    tmpvar_33 = abs((tmpvar_32 - tmpvar_29));
    if ((tmpvar_33 < 1.51)) {
      mediump vec4 circleColor_34;
      highp vec2 tmpvar_35;
      tmpvar_35 = ((vec2(tmpvar_28) * _CircleColorTex_ST.xy) + _CircleColorTex_ST.zw);
      lowp vec4 tmpvar_36;
      tmpvar_36 = texture2D (_CircleColorTex, tmpvar_35);
      circleColor_34 = tmpvar_36;
      highp float tmpvar_37;
      tmpvar_37 = abs((tmpvar_32 - tmpvar_29));
      outColor_27 = (((circleColor_34 * 
        (1.5 - tmpvar_37)
      ) * (1.0 - tmpvar_28)) * (1.0 - tmpvar_28));
    };
    prevCircleColor_2 = outColor_27;
  };
  col_7 = (col_7 + ((
    (curCircleColor_3 + prevCircleColor_2)
   - 
    (curCircleColor_3 * prevCircleColor_2)
  ) * mainTexColor_8.w));
  mediump vec3 tmpvar_38;
  tmpvar_38 = (V_4 - (2.0 * (
    dot (N_6, V_4)
   * N_6)));
  mediump float tmpvar_39;
  tmpvar_39 = abs(dot (N_6, V_4));
  highp float tmpvar_40;
  highp float cs_41;
  cs_41 = tmpvar_39;
  highp float power_42;
  power_42 = _ReflectFresnel.x;
  highp float scale_43;
  scale_43 = _ReflectFresnel.y;
  highp float bias_44;
  bias_44 = _ReflectFresnel.z;
  tmpvar_40 = (bias_44 + (pow (
    clamp ((1.0 - cs_41), 0.0, 1.0)
  , power_42) * scale_43));
  f_1 = tmpvar_40;
  lowp vec4 tmpvar_45;
  tmpvar_45 = textureCube (_EnvTex, tmpvar_38);
  col_7.xyz = (col_7.xyz + ((tmpvar_45.xyz * mainTexColor_8.w) * (f_1 * _Reflectivity)));
  col_7.xyz = mix (col_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_7.w = _BloomFactor;
  gl_FragData[0] = col_7;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp float sint_1;
  highp float cost_2;
  highp vec3 adjCamPos_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec2 tmpvar_6;
  mediump vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  highp vec3 scale_12;
  highp vec4 v_13;
  v_13.x = unity_ObjectToWorld[0].x;
  v_13.y = unity_ObjectToWorld[1].x;
  v_13.z = unity_ObjectToWorld[2].x;
  v_13.w = unity_ObjectToWorld[3].x;
  scale_12.x = sqrt(dot (v_13.xyz, v_13.xyz));
  highp vec4 v_14;
  v_14.x = unity_ObjectToWorld[0].y;
  v_14.y = unity_ObjectToWorld[1].y;
  v_14.z = unity_ObjectToWorld[2].y;
  v_14.w = unity_ObjectToWorld[3].y;
  scale_12.y = sqrt(dot (v_14.xyz, v_14.xyz));
  highp vec4 v_15;
  v_15.x = unity_ObjectToWorld[0].z;
  v_15.y = unity_ObjectToWorld[1].z;
  v_15.z = unity_ObjectToWorld[2].z;
  v_15.w = unity_ObjectToWorld[3].z;
  scale_12.z = sqrt(dot (v_15.xyz, v_15.xyz));
  if ((tmpvar_11.y > 0.5)) {
    tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.zx);
    tmpvar_6 = vec2(0.0, 0.0);
  } else {
    if ((tmpvar_11.y < -0.5)) {
      tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.zx);
      tmpvar_6 = vec2(1.0, 0.0);
    } else {
      if ((tmpvar_11.x > 0.5)) {
        tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.zy);
        tmpvar_6 = vec2(1.0, 0.0);
      } else {
        if ((tmpvar_11.x < -0.5)) {
          tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.zy);
          tmpvar_6 = vec2(1.0, 0.0);
        } else {
          if ((tmpvar_11.z > 0.5)) {
            tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.xy);
            tmpvar_6 = vec2(1.0, 0.0);
          } else {
            if ((tmpvar_11.z < -0.5)) {
              tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.xy);
              tmpvar_6 = vec2(1.0, 0.0);
            };
          };
        };
      };
    };
  };
  tmpvar_5 = ((tmpvar_5 * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  adjCamPos_3.xz = (tmpvar_9.xz - ((tmpvar_9.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_3.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_28;
  tmpvar_28 = normalize((tmpvar_9 - adjCamPos_3));
  tmpvar_7 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = cos(_CamRotate);
  cost_2 = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = sin(_CamRotate);
  sint_1 = tmpvar_30;
  highp mat2 tmpvar_31;
  tmpvar_31[0].x = cost_2;
  tmpvar_31[0].y = -(sint_1);
  tmpvar_31[1].x = sint_1;
  tmpvar_31[1].y = cost_2;
  tmpvar_7.xz = (tmpvar_31 * tmpvar_7.xz);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_COLOR1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump vec4 _ReflectFresnel;
uniform highp vec4 _AvatarPosInWorldPos;
uniform highp vec4 _PrevAvatarPosInWorldPos;
uniform highp float _IsCurCircleBusy;
uniform highp float _IsPrevCircleBusy;
uniform highp float _CircleTime;
uniform highp float _PrevCircleTime;
uniform highp float _TimeIntervalRatio;
uniform sampler2D _CircleColorTex;
uniform highp vec4 _CircleColorTex_ST;
uniform highp float _CircleRadius;
uniform highp vec3 _LightDir;
uniform mediump float _Ambient;
uniform mediump float _Diffuse;
uniform mediump float _Specular;
uniform mediump float _Shininess;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  mediump float f_1;
  mediump vec4 prevCircleColor_2;
  mediump vec4 curCircleColor_3;
  mediump vec3 V_4;
  mediump vec3 L_5;
  mediump vec3 N_6;
  mediump vec4 col_7;
  mediump vec4 mainTexColor_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((fract(xlv_TEXCOORD0) + xlv_TEXCOORD1) * vec2(0.5, 1.0));
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, tmpvar_9);
  mainTexColor_8 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(xlv_TEXCOORD2);
  N_6 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = -(normalize(_LightDir));
  L_5 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_4 = tmpvar_13;
  col_7 = (mainTexColor_8 * (_Ambient + (
    max (dot (N_6, L_5), 0.0)
   * _Diffuse)));
  col_7 = (col_7 + (max (0.0, 
    pow (max (dot (N_6, normalize(
      (L_5 + V_4)
    )), 0.001), _Shininess)
  ) * _Specular));
  curCircleColor_3 = vec4(0.0, 0.0, 0.0, 0.0);
  if (bool(_IsCurCircleBusy)) {
    highp vec3 diffDir_14;
    mediump vec4 outColor_15;
    outColor_15 = vec4(0.0, 0.0, 0.0, 0.0);
    highp float tmpvar_16;
    tmpvar_16 = (_CircleTime * _TimeIntervalRatio);
    highp float tmpvar_17;
    tmpvar_17 = floor((sin(
      (1.570795 * tmpvar_16)
    ) * _CircleRadius));
    highp vec3 tmpvar_18;
    tmpvar_18 = (xlv_TEXCOORD3 - _AvatarPosInWorldPos.xyz);
    diffDir_14.xz = tmpvar_18.xz;
    diffDir_14.y = (tmpvar_18.y - 0.5);
    highp vec3 tmpvar_19;
    tmpvar_19 = floor((diffDir_14 + vec3(0.5, 0.5, 0.5)));
    highp float tmpvar_20;
    tmpvar_20 = sqrt(dot (tmpvar_19, tmpvar_19));
    highp float tmpvar_21;
    tmpvar_21 = abs((tmpvar_20 - tmpvar_17));
    if ((tmpvar_21 < 1.51)) {
      mediump vec4 circleColor_22;
      highp vec2 tmpvar_23;
      tmpvar_23 = ((vec2(tmpvar_16) * _CircleColorTex_ST.xy) + _CircleColorTex_ST.zw);
      lowp vec4 tmpvar_24;
      tmpvar_24 = texture2D (_CircleColorTex, tmpvar_23);
      circleColor_22 = tmpvar_24;
      highp float tmpvar_25;
      tmpvar_25 = abs((tmpvar_20 - tmpvar_17));
      outColor_15 = (((circleColor_22 * 
        (1.5 - tmpvar_25)
      ) * (1.0 - tmpvar_16)) * (1.0 - tmpvar_16));
    };
    curCircleColor_3 = outColor_15;
  };
  prevCircleColor_2 = vec4(0.0, 0.0, 0.0, 0.0);
  if (bool(_IsPrevCircleBusy)) {
    highp vec3 diffDir_26;
    mediump vec4 outColor_27;
    outColor_27 = vec4(0.0, 0.0, 0.0, 0.0);
    highp float tmpvar_28;
    tmpvar_28 = (_PrevCircleTime * _TimeIntervalRatio);
    highp float tmpvar_29;
    tmpvar_29 = floor((sin(
      (1.570795 * tmpvar_28)
    ) * _CircleRadius));
    highp vec3 tmpvar_30;
    tmpvar_30 = (xlv_TEXCOORD3 - _PrevAvatarPosInWorldPos.xyz);
    diffDir_26.xz = tmpvar_30.xz;
    diffDir_26.y = (tmpvar_30.y - 0.5);
    highp vec3 tmpvar_31;
    tmpvar_31 = floor((diffDir_26 + vec3(0.5, 0.5, 0.5)));
    highp float tmpvar_32;
    tmpvar_32 = sqrt(dot (tmpvar_31, tmpvar_31));
    highp float tmpvar_33;
    tmpvar_33 = abs((tmpvar_32 - tmpvar_29));
    if ((tmpvar_33 < 1.51)) {
      mediump vec4 circleColor_34;
      highp vec2 tmpvar_35;
      tmpvar_35 = ((vec2(tmpvar_28) * _CircleColorTex_ST.xy) + _CircleColorTex_ST.zw);
      lowp vec4 tmpvar_36;
      tmpvar_36 = texture2D (_CircleColorTex, tmpvar_35);
      circleColor_34 = tmpvar_36;
      highp float tmpvar_37;
      tmpvar_37 = abs((tmpvar_32 - tmpvar_29));
      outColor_27 = (((circleColor_34 * 
        (1.5 - tmpvar_37)
      ) * (1.0 - tmpvar_28)) * (1.0 - tmpvar_28));
    };
    prevCircleColor_2 = outColor_27;
  };
  col_7 = (col_7 + ((
    (curCircleColor_3 + prevCircleColor_2)
   - 
    (curCircleColor_3 * prevCircleColor_2)
  ) * mainTexColor_8.w));
  mediump vec3 tmpvar_38;
  tmpvar_38 = (V_4 - (2.0 * (
    dot (N_6, V_4)
   * N_6)));
  mediump float tmpvar_39;
  tmpvar_39 = abs(dot (N_6, V_4));
  highp float tmpvar_40;
  highp float cs_41;
  cs_41 = tmpvar_39;
  highp float power_42;
  power_42 = _ReflectFresnel.x;
  highp float scale_43;
  scale_43 = _ReflectFresnel.y;
  highp float bias_44;
  bias_44 = _ReflectFresnel.z;
  tmpvar_40 = (bias_44 + (pow (
    clamp ((1.0 - cs_41), 0.0, 1.0)
  , power_42) * scale_43));
  f_1 = tmpvar_40;
  lowp vec4 tmpvar_45;
  tmpvar_45 = textureCube (_EnvTex, tmpvar_38);
  col_7.xyz = (col_7.xyz + ((tmpvar_45.xyz * mainTexColor_8.w) * (f_1 * _Reflectivity)));
  col_7.xyz = mix (col_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_7.w = _BloomFactor;
  gl_FragData[0] = col_7;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp float sint_1;
  highp float cost_2;
  highp vec3 adjCamPos_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec2 tmpvar_6;
  mediump vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  highp vec3 scale_12;
  highp vec4 v_13;
  v_13.x = unity_ObjectToWorld[0].x;
  v_13.y = unity_ObjectToWorld[1].x;
  v_13.z = unity_ObjectToWorld[2].x;
  v_13.w = unity_ObjectToWorld[3].x;
  scale_12.x = sqrt(dot (v_13.xyz, v_13.xyz));
  highp vec4 v_14;
  v_14.x = unity_ObjectToWorld[0].y;
  v_14.y = unity_ObjectToWorld[1].y;
  v_14.z = unity_ObjectToWorld[2].y;
  v_14.w = unity_ObjectToWorld[3].y;
  scale_12.y = sqrt(dot (v_14.xyz, v_14.xyz));
  highp vec4 v_15;
  v_15.x = unity_ObjectToWorld[0].z;
  v_15.y = unity_ObjectToWorld[1].z;
  v_15.z = unity_ObjectToWorld[2].z;
  v_15.w = unity_ObjectToWorld[3].z;
  scale_12.z = sqrt(dot (v_15.xyz, v_15.xyz));
  if ((tmpvar_11.y > 0.5)) {
    tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.zx);
    tmpvar_6 = vec2(0.0, 0.0);
  } else {
    if ((tmpvar_11.y < -0.5)) {
      tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.zx);
      tmpvar_6 = vec2(1.0, 0.0);
    } else {
      if ((tmpvar_11.x > 0.5)) {
        tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.zy);
        tmpvar_6 = vec2(1.0, 0.0);
      } else {
        if ((tmpvar_11.x < -0.5)) {
          tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.zy);
          tmpvar_6 = vec2(1.0, 0.0);
        } else {
          if ((tmpvar_11.z > 0.5)) {
            tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.xy);
            tmpvar_6 = vec2(1.0, 0.0);
          } else {
            if ((tmpvar_11.z < -0.5)) {
              tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.xy);
              tmpvar_6 = vec2(1.0, 0.0);
            };
          };
        };
      };
    };
  };
  tmpvar_5 = ((tmpvar_5 * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  adjCamPos_3.xz = (tmpvar_9.xz - ((tmpvar_9.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_3.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_28;
  tmpvar_28 = normalize((tmpvar_9 - adjCamPos_3));
  tmpvar_7 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = cos(_CamRotate);
  cost_2 = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = sin(_CamRotate);
  sint_1 = tmpvar_30;
  highp mat2 tmpvar_31;
  tmpvar_31[0].x = cost_2;
  tmpvar_31[0].y = -(sint_1);
  tmpvar_31[1].x = sint_1;
  tmpvar_31[1].y = cost_2;
  tmpvar_7.xz = (tmpvar_31 * tmpvar_7.xz);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_COLOR1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump vec4 _ReflectFresnel;
uniform highp vec4 _AvatarPosInWorldPos;
uniform highp vec4 _PrevAvatarPosInWorldPos;
uniform highp float _IsCurCircleBusy;
uniform highp float _IsPrevCircleBusy;
uniform highp float _CircleTime;
uniform highp float _PrevCircleTime;
uniform highp float _TimeIntervalRatio;
uniform sampler2D _CircleColorTex;
uniform highp vec4 _CircleColorTex_ST;
uniform highp float _CircleRadius;
uniform highp vec3 _LightDir;
uniform mediump float _Ambient;
uniform mediump float _Diffuse;
uniform mediump float _Specular;
uniform mediump float _Shininess;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  mediump float f_1;
  mediump vec4 prevCircleColor_2;
  mediump vec4 curCircleColor_3;
  mediump vec3 V_4;
  mediump vec3 L_5;
  mediump vec3 N_6;
  mediump vec4 col_7;
  mediump vec4 mainTexColor_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((fract(xlv_TEXCOORD0) + xlv_TEXCOORD1) * vec2(0.5, 1.0));
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, tmpvar_9);
  mainTexColor_8 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(xlv_TEXCOORD2);
  N_6 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = -(normalize(_LightDir));
  L_5 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_4 = tmpvar_13;
  col_7 = (mainTexColor_8 * (_Ambient + (
    max (dot (N_6, L_5), 0.0)
   * _Diffuse)));
  col_7 = (col_7 + (max (0.0, 
    pow (max (dot (N_6, normalize(
      (L_5 + V_4)
    )), 0.001), _Shininess)
  ) * _Specular));
  curCircleColor_3 = vec4(0.0, 0.0, 0.0, 0.0);
  if (bool(_IsCurCircleBusy)) {
    highp vec3 diffDir_14;
    mediump vec4 outColor_15;
    outColor_15 = vec4(0.0, 0.0, 0.0, 0.0);
    highp float tmpvar_16;
    tmpvar_16 = (_CircleTime * _TimeIntervalRatio);
    highp float tmpvar_17;
    tmpvar_17 = floor((sin(
      (1.570795 * tmpvar_16)
    ) * _CircleRadius));
    highp vec3 tmpvar_18;
    tmpvar_18 = (xlv_TEXCOORD3 - _AvatarPosInWorldPos.xyz);
    diffDir_14.xz = tmpvar_18.xz;
    diffDir_14.y = (tmpvar_18.y - 0.5);
    highp vec3 tmpvar_19;
    tmpvar_19 = floor((diffDir_14 + vec3(0.5, 0.5, 0.5)));
    highp float tmpvar_20;
    tmpvar_20 = sqrt(dot (tmpvar_19, tmpvar_19));
    highp float tmpvar_21;
    tmpvar_21 = abs((tmpvar_20 - tmpvar_17));
    if ((tmpvar_21 < 1.51)) {
      mediump vec4 circleColor_22;
      highp vec2 tmpvar_23;
      tmpvar_23 = ((vec2(tmpvar_16) * _CircleColorTex_ST.xy) + _CircleColorTex_ST.zw);
      lowp vec4 tmpvar_24;
      tmpvar_24 = texture2D (_CircleColorTex, tmpvar_23);
      circleColor_22 = tmpvar_24;
      highp float tmpvar_25;
      tmpvar_25 = abs((tmpvar_20 - tmpvar_17));
      outColor_15 = (((circleColor_22 * 
        (1.5 - tmpvar_25)
      ) * (1.0 - tmpvar_16)) * (1.0 - tmpvar_16));
    };
    curCircleColor_3 = outColor_15;
  };
  prevCircleColor_2 = vec4(0.0, 0.0, 0.0, 0.0);
  if (bool(_IsPrevCircleBusy)) {
    highp vec3 diffDir_26;
    mediump vec4 outColor_27;
    outColor_27 = vec4(0.0, 0.0, 0.0, 0.0);
    highp float tmpvar_28;
    tmpvar_28 = (_PrevCircleTime * _TimeIntervalRatio);
    highp float tmpvar_29;
    tmpvar_29 = floor((sin(
      (1.570795 * tmpvar_28)
    ) * _CircleRadius));
    highp vec3 tmpvar_30;
    tmpvar_30 = (xlv_TEXCOORD3 - _PrevAvatarPosInWorldPos.xyz);
    diffDir_26.xz = tmpvar_30.xz;
    diffDir_26.y = (tmpvar_30.y - 0.5);
    highp vec3 tmpvar_31;
    tmpvar_31 = floor((diffDir_26 + vec3(0.5, 0.5, 0.5)));
    highp float tmpvar_32;
    tmpvar_32 = sqrt(dot (tmpvar_31, tmpvar_31));
    highp float tmpvar_33;
    tmpvar_33 = abs((tmpvar_32 - tmpvar_29));
    if ((tmpvar_33 < 1.51)) {
      mediump vec4 circleColor_34;
      highp vec2 tmpvar_35;
      tmpvar_35 = ((vec2(tmpvar_28) * _CircleColorTex_ST.xy) + _CircleColorTex_ST.zw);
      lowp vec4 tmpvar_36;
      tmpvar_36 = texture2D (_CircleColorTex, tmpvar_35);
      circleColor_34 = tmpvar_36;
      highp float tmpvar_37;
      tmpvar_37 = abs((tmpvar_32 - tmpvar_29));
      outColor_27 = (((circleColor_34 * 
        (1.5 - tmpvar_37)
      ) * (1.0 - tmpvar_28)) * (1.0 - tmpvar_28));
    };
    prevCircleColor_2 = outColor_27;
  };
  col_7 = (col_7 + ((
    (curCircleColor_3 + prevCircleColor_2)
   - 
    (curCircleColor_3 * prevCircleColor_2)
  ) * mainTexColor_8.w));
  mediump vec3 tmpvar_38;
  tmpvar_38 = (V_4 - (2.0 * (
    dot (N_6, V_4)
   * N_6)));
  mediump float tmpvar_39;
  tmpvar_39 = abs(dot (N_6, V_4));
  highp float tmpvar_40;
  highp float cs_41;
  cs_41 = tmpvar_39;
  highp float power_42;
  power_42 = _ReflectFresnel.x;
  highp float scale_43;
  scale_43 = _ReflectFresnel.y;
  highp float bias_44;
  bias_44 = _ReflectFresnel.z;
  tmpvar_40 = (bias_44 + (pow (
    clamp ((1.0 - cs_41), 0.0, 1.0)
  , power_42) * scale_43));
  f_1 = tmpvar_40;
  lowp vec4 tmpvar_45;
  tmpvar_45 = textureCube (_EnvTex, tmpvar_38);
  col_7.xyz = (col_7.xyz + ((tmpvar_45.xyz * mainTexColor_8.w) * (f_1 * _Reflectivity)));
  col_7.xyz = mix (col_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_7.w = _BloomFactor;
  gl_FragData[0] = col_7;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp float sint_1;
  highp float cost_2;
  highp vec3 adjCamPos_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec2 tmpvar_6;
  mediump vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  highp vec3 scale_12;
  highp vec4 v_13;
  v_13.x = unity_ObjectToWorld[0].x;
  v_13.y = unity_ObjectToWorld[1].x;
  v_13.z = unity_ObjectToWorld[2].x;
  v_13.w = unity_ObjectToWorld[3].x;
  scale_12.x = sqrt(dot (v_13.xyz, v_13.xyz));
  highp vec4 v_14;
  v_14.x = unity_ObjectToWorld[0].y;
  v_14.y = unity_ObjectToWorld[1].y;
  v_14.z = unity_ObjectToWorld[2].y;
  v_14.w = unity_ObjectToWorld[3].y;
  scale_12.y = sqrt(dot (v_14.xyz, v_14.xyz));
  highp vec4 v_15;
  v_15.x = unity_ObjectToWorld[0].z;
  v_15.y = unity_ObjectToWorld[1].z;
  v_15.z = unity_ObjectToWorld[2].z;
  v_15.w = unity_ObjectToWorld[3].z;
  scale_12.z = sqrt(dot (v_15.xyz, v_15.xyz));
  if ((tmpvar_11.y > 0.5)) {
    tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.zx);
    tmpvar_6 = vec2(0.0, 0.0);
  } else {
    if ((tmpvar_11.y < -0.5)) {
      tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.zx);
      tmpvar_6 = vec2(1.0, 0.0);
    } else {
      if ((tmpvar_11.x > 0.5)) {
        tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.zy);
        tmpvar_6 = vec2(1.0, 0.0);
      } else {
        if ((tmpvar_11.x < -0.5)) {
          tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.zy);
          tmpvar_6 = vec2(1.0, 0.0);
        } else {
          if ((tmpvar_11.z > 0.5)) {
            tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.xy);
            tmpvar_6 = vec2(1.0, 0.0);
          } else {
            if ((tmpvar_11.z < -0.5)) {
              tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.xy);
              tmpvar_6 = vec2(1.0, 0.0);
            };
          };
        };
      };
    };
  };
  tmpvar_5 = ((tmpvar_5 * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  adjCamPos_3.xz = (tmpvar_9.xz - ((tmpvar_9.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_3.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_28;
  tmpvar_28 = normalize((tmpvar_9 - adjCamPos_3));
  tmpvar_7 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = cos(_CamRotate);
  cost_2 = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = sin(_CamRotate);
  sint_1 = tmpvar_30;
  highp mat2 tmpvar_31;
  tmpvar_31[0].x = cost_2;
  tmpvar_31[0].y = -(sint_1);
  tmpvar_31[1].x = sint_1;
  tmpvar_31[1].y = cost_2;
  tmpvar_7.xz = (tmpvar_31 * tmpvar_7.xz);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_COLOR1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump vec4 _ReflectFresnel;
uniform highp vec4 _AvatarPosInWorldPos;
uniform highp vec4 _PrevAvatarPosInWorldPos;
uniform highp float _IsCurCircleBusy;
uniform highp float _IsPrevCircleBusy;
uniform highp float _CircleTime;
uniform highp float _PrevCircleTime;
uniform highp float _TimeIntervalRatio;
uniform sampler2D _CircleColorTex;
uniform highp vec4 _CircleColorTex_ST;
uniform highp float _CircleRadius;
uniform highp vec3 _LightDir;
uniform mediump float _Ambient;
uniform mediump float _Diffuse;
uniform mediump float _Specular;
uniform mediump float _Shininess;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  mediump float f_1;
  mediump vec4 prevCircleColor_2;
  mediump vec4 curCircleColor_3;
  mediump vec3 V_4;
  mediump vec3 L_5;
  mediump vec3 N_6;
  mediump vec4 col_7;
  mediump vec4 mainTexColor_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((fract(xlv_TEXCOORD0) + xlv_TEXCOORD1) * vec2(0.5, 1.0));
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, tmpvar_9);
  mainTexColor_8 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(xlv_TEXCOORD2);
  N_6 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = -(normalize(_LightDir));
  L_5 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_4 = tmpvar_13;
  col_7 = (mainTexColor_8 * (_Ambient + (
    max (dot (N_6, L_5), 0.0)
   * _Diffuse)));
  col_7 = (col_7 + (max (0.0, 
    pow (max (dot (N_6, normalize(
      (L_5 + V_4)
    )), 0.001), _Shininess)
  ) * _Specular));
  curCircleColor_3 = vec4(0.0, 0.0, 0.0, 0.0);
  if (bool(_IsCurCircleBusy)) {
    highp vec3 diffDir_14;
    mediump vec4 outColor_15;
    outColor_15 = vec4(0.0, 0.0, 0.0, 0.0);
    highp float tmpvar_16;
    tmpvar_16 = (_CircleTime * _TimeIntervalRatio);
    highp float tmpvar_17;
    tmpvar_17 = floor((sin(
      (1.570795 * tmpvar_16)
    ) * _CircleRadius));
    highp vec3 tmpvar_18;
    tmpvar_18 = (xlv_TEXCOORD3 - _AvatarPosInWorldPos.xyz);
    diffDir_14.xz = tmpvar_18.xz;
    diffDir_14.y = (tmpvar_18.y - 0.5);
    highp vec3 tmpvar_19;
    tmpvar_19 = floor((diffDir_14 + vec3(0.5, 0.5, 0.5)));
    highp float tmpvar_20;
    tmpvar_20 = sqrt(dot (tmpvar_19, tmpvar_19));
    highp float tmpvar_21;
    tmpvar_21 = abs((tmpvar_20 - tmpvar_17));
    if ((tmpvar_21 < 1.51)) {
      mediump vec4 circleColor_22;
      highp vec2 tmpvar_23;
      tmpvar_23 = ((vec2(tmpvar_16) * _CircleColorTex_ST.xy) + _CircleColorTex_ST.zw);
      lowp vec4 tmpvar_24;
      tmpvar_24 = texture2D (_CircleColorTex, tmpvar_23);
      circleColor_22 = tmpvar_24;
      highp float tmpvar_25;
      tmpvar_25 = abs((tmpvar_20 - tmpvar_17));
      outColor_15 = (((circleColor_22 * 
        (1.5 - tmpvar_25)
      ) * (1.0 - tmpvar_16)) * (1.0 - tmpvar_16));
    };
    curCircleColor_3 = outColor_15;
  };
  prevCircleColor_2 = vec4(0.0, 0.0, 0.0, 0.0);
  if (bool(_IsPrevCircleBusy)) {
    highp vec3 diffDir_26;
    mediump vec4 outColor_27;
    outColor_27 = vec4(0.0, 0.0, 0.0, 0.0);
    highp float tmpvar_28;
    tmpvar_28 = (_PrevCircleTime * _TimeIntervalRatio);
    highp float tmpvar_29;
    tmpvar_29 = floor((sin(
      (1.570795 * tmpvar_28)
    ) * _CircleRadius));
    highp vec3 tmpvar_30;
    tmpvar_30 = (xlv_TEXCOORD3 - _PrevAvatarPosInWorldPos.xyz);
    diffDir_26.xz = tmpvar_30.xz;
    diffDir_26.y = (tmpvar_30.y - 0.5);
    highp vec3 tmpvar_31;
    tmpvar_31 = floor((diffDir_26 + vec3(0.5, 0.5, 0.5)));
    highp float tmpvar_32;
    tmpvar_32 = sqrt(dot (tmpvar_31, tmpvar_31));
    highp float tmpvar_33;
    tmpvar_33 = abs((tmpvar_32 - tmpvar_29));
    if ((tmpvar_33 < 1.51)) {
      mediump vec4 circleColor_34;
      highp vec2 tmpvar_35;
      tmpvar_35 = ((vec2(tmpvar_28) * _CircleColorTex_ST.xy) + _CircleColorTex_ST.zw);
      lowp vec4 tmpvar_36;
      tmpvar_36 = texture2D (_CircleColorTex, tmpvar_35);
      circleColor_34 = tmpvar_36;
      highp float tmpvar_37;
      tmpvar_37 = abs((tmpvar_32 - tmpvar_29));
      outColor_27 = (((circleColor_34 * 
        (1.5 - tmpvar_37)
      ) * (1.0 - tmpvar_28)) * (1.0 - tmpvar_28));
    };
    prevCircleColor_2 = outColor_27;
  };
  col_7 = (col_7 + ((
    (curCircleColor_3 + prevCircleColor_2)
   - 
    (curCircleColor_3 * prevCircleColor_2)
  ) * mainTexColor_8.w));
  mediump vec3 tmpvar_38;
  tmpvar_38 = (V_4 - (2.0 * (
    dot (N_6, V_4)
   * N_6)));
  mediump float tmpvar_39;
  tmpvar_39 = abs(dot (N_6, V_4));
  highp float tmpvar_40;
  highp float cs_41;
  cs_41 = tmpvar_39;
  highp float power_42;
  power_42 = _ReflectFresnel.x;
  highp float scale_43;
  scale_43 = _ReflectFresnel.y;
  highp float bias_44;
  bias_44 = _ReflectFresnel.z;
  tmpvar_40 = (bias_44 + (pow (
    clamp ((1.0 - cs_41), 0.0, 1.0)
  , power_42) * scale_43));
  f_1 = tmpvar_40;
  lowp vec4 tmpvar_45;
  tmpvar_45 = textureCube (_EnvTex, tmpvar_38);
  col_7.xyz = (col_7.xyz + ((tmpvar_45.xyz * mainTexColor_8.w) * (f_1 * _Reflectivity)));
  col_7.xyz = mix (col_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_7.w = _BloomFactor;
  gl_FragData[0] = col_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp float sint_1;
  highp float cost_2;
  highp vec3 adjCamPos_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec2 tmpvar_6;
  mediump vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  highp vec3 scale_12;
  highp vec4 v_13;
  v_13.x = unity_ObjectToWorld[0].x;
  v_13.y = unity_ObjectToWorld[1].x;
  v_13.z = unity_ObjectToWorld[2].x;
  v_13.w = unity_ObjectToWorld[3].x;
  scale_12.x = sqrt(dot (v_13.xyz, v_13.xyz));
  highp vec4 v_14;
  v_14.x = unity_ObjectToWorld[0].y;
  v_14.y = unity_ObjectToWorld[1].y;
  v_14.z = unity_ObjectToWorld[2].y;
  v_14.w = unity_ObjectToWorld[3].y;
  scale_12.y = sqrt(dot (v_14.xyz, v_14.xyz));
  highp vec4 v_15;
  v_15.x = unity_ObjectToWorld[0].z;
  v_15.y = unity_ObjectToWorld[1].z;
  v_15.z = unity_ObjectToWorld[2].z;
  v_15.w = unity_ObjectToWorld[3].z;
  scale_12.z = sqrt(dot (v_15.xyz, v_15.xyz));
  if ((tmpvar_11.y > 0.5)) {
    tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.zx);
    tmpvar_6 = vec2(0.0, 0.0);
  } else {
    if ((tmpvar_11.y < -0.5)) {
      tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.zx);
      tmpvar_6 = vec2(1.0, 0.0);
    } else {
      if ((tmpvar_11.x > 0.5)) {
        tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.zy);
        tmpvar_6 = vec2(1.0, 0.0);
      } else {
        if ((tmpvar_11.x < -0.5)) {
          tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.zy);
          tmpvar_6 = vec2(1.0, 0.0);
        } else {
          if ((tmpvar_11.z > 0.5)) {
            tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.xy);
            tmpvar_6 = vec2(1.0, 0.0);
          } else {
            if ((tmpvar_11.z < -0.5)) {
              tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.xy);
              tmpvar_6 = vec2(1.0, 0.0);
            };
          };
        };
      };
    };
  };
  tmpvar_5 = ((tmpvar_5 * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  adjCamPos_3.xz = (tmpvar_9.xz - ((tmpvar_9.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_3.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_28;
  tmpvar_28 = normalize((tmpvar_9 - adjCamPos_3));
  tmpvar_7 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = cos(_CamRotate);
  cost_2 = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = sin(_CamRotate);
  sint_1 = tmpvar_30;
  highp mat2 tmpvar_31;
  tmpvar_31[0].x = cost_2;
  tmpvar_31[0].y = -(sint_1);
  tmpvar_31[1].x = sint_1;
  tmpvar_31[1].y = cost_2;
  tmpvar_7.xz = (tmpvar_31 * tmpvar_7.xz);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_COLOR1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump vec4 _ReflectFresnel;
uniform highp vec4 _AvatarPosInWorldPos;
uniform highp vec4 _PrevAvatarPosInWorldPos;
uniform highp float _IsCurCircleBusy;
uniform highp float _IsPrevCircleBusy;
uniform highp float _CircleTime;
uniform highp float _PrevCircleTime;
uniform highp float _TimeIntervalRatio;
uniform sampler2D _CircleColorTex;
uniform highp vec4 _CircleColorTex_ST;
uniform highp float _CircleRadius;
uniform highp vec3 _LightDir;
uniform mediump float _Ambient;
uniform mediump float _Diffuse;
uniform mediump float _Specular;
uniform mediump float _Shininess;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  mediump float f_1;
  mediump vec4 prevCircleColor_2;
  mediump vec4 curCircleColor_3;
  mediump vec3 V_4;
  mediump vec3 L_5;
  mediump vec3 N_6;
  mediump vec4 col_7;
  mediump vec4 mainTexColor_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((fract(xlv_TEXCOORD0) + xlv_TEXCOORD1) * vec2(0.5, 1.0));
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, tmpvar_9);
  mainTexColor_8 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(xlv_TEXCOORD2);
  N_6 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = -(normalize(_LightDir));
  L_5 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_4 = tmpvar_13;
  col_7 = (mainTexColor_8 * (_Ambient + (
    max (dot (N_6, L_5), 0.0)
   * _Diffuse)));
  col_7 = (col_7 + (max (0.0, 
    pow (max (dot (N_6, normalize(
      (L_5 + V_4)
    )), 0.001), _Shininess)
  ) * _Specular));
  curCircleColor_3 = vec4(0.0, 0.0, 0.0, 0.0);
  if (bool(_IsCurCircleBusy)) {
    highp vec3 diffDir_14;
    mediump vec4 outColor_15;
    outColor_15 = vec4(0.0, 0.0, 0.0, 0.0);
    highp float tmpvar_16;
    tmpvar_16 = (_CircleTime * _TimeIntervalRatio);
    highp float tmpvar_17;
    tmpvar_17 = floor((sin(
      (1.570795 * tmpvar_16)
    ) * _CircleRadius));
    highp vec3 tmpvar_18;
    tmpvar_18 = (xlv_TEXCOORD3 - _AvatarPosInWorldPos.xyz);
    diffDir_14.xz = tmpvar_18.xz;
    diffDir_14.y = (tmpvar_18.y - 0.5);
    highp vec3 tmpvar_19;
    tmpvar_19 = floor((diffDir_14 + vec3(0.5, 0.5, 0.5)));
    highp float tmpvar_20;
    tmpvar_20 = sqrt(dot (tmpvar_19, tmpvar_19));
    highp float tmpvar_21;
    tmpvar_21 = abs((tmpvar_20 - tmpvar_17));
    if ((tmpvar_21 < 1.51)) {
      mediump vec4 circleColor_22;
      highp vec2 tmpvar_23;
      tmpvar_23 = ((vec2(tmpvar_16) * _CircleColorTex_ST.xy) + _CircleColorTex_ST.zw);
      lowp vec4 tmpvar_24;
      tmpvar_24 = texture2D (_CircleColorTex, tmpvar_23);
      circleColor_22 = tmpvar_24;
      highp float tmpvar_25;
      tmpvar_25 = abs((tmpvar_20 - tmpvar_17));
      outColor_15 = (((circleColor_22 * 
        (1.5 - tmpvar_25)
      ) * (1.0 - tmpvar_16)) * (1.0 - tmpvar_16));
    };
    curCircleColor_3 = outColor_15;
  };
  prevCircleColor_2 = vec4(0.0, 0.0, 0.0, 0.0);
  if (bool(_IsPrevCircleBusy)) {
    highp vec3 diffDir_26;
    mediump vec4 outColor_27;
    outColor_27 = vec4(0.0, 0.0, 0.0, 0.0);
    highp float tmpvar_28;
    tmpvar_28 = (_PrevCircleTime * _TimeIntervalRatio);
    highp float tmpvar_29;
    tmpvar_29 = floor((sin(
      (1.570795 * tmpvar_28)
    ) * _CircleRadius));
    highp vec3 tmpvar_30;
    tmpvar_30 = (xlv_TEXCOORD3 - _PrevAvatarPosInWorldPos.xyz);
    diffDir_26.xz = tmpvar_30.xz;
    diffDir_26.y = (tmpvar_30.y - 0.5);
    highp vec3 tmpvar_31;
    tmpvar_31 = floor((diffDir_26 + vec3(0.5, 0.5, 0.5)));
    highp float tmpvar_32;
    tmpvar_32 = sqrt(dot (tmpvar_31, tmpvar_31));
    highp float tmpvar_33;
    tmpvar_33 = abs((tmpvar_32 - tmpvar_29));
    if ((tmpvar_33 < 1.51)) {
      mediump vec4 circleColor_34;
      highp vec2 tmpvar_35;
      tmpvar_35 = ((vec2(tmpvar_28) * _CircleColorTex_ST.xy) + _CircleColorTex_ST.zw);
      lowp vec4 tmpvar_36;
      tmpvar_36 = texture2D (_CircleColorTex, tmpvar_35);
      circleColor_34 = tmpvar_36;
      highp float tmpvar_37;
      tmpvar_37 = abs((tmpvar_32 - tmpvar_29));
      outColor_27 = (((circleColor_34 * 
        (1.5 - tmpvar_37)
      ) * (1.0 - tmpvar_28)) * (1.0 - tmpvar_28));
    };
    prevCircleColor_2 = outColor_27;
  };
  col_7 = (col_7 + ((
    (curCircleColor_3 + prevCircleColor_2)
   - 
    (curCircleColor_3 * prevCircleColor_2)
  ) * mainTexColor_8.w));
  mediump vec3 tmpvar_38;
  tmpvar_38 = (V_4 - (2.0 * (
    dot (N_6, V_4)
   * N_6)));
  mediump float tmpvar_39;
  tmpvar_39 = abs(dot (N_6, V_4));
  highp float tmpvar_40;
  highp float cs_41;
  cs_41 = tmpvar_39;
  highp float power_42;
  power_42 = _ReflectFresnel.x;
  highp float scale_43;
  scale_43 = _ReflectFresnel.y;
  highp float bias_44;
  bias_44 = _ReflectFresnel.z;
  tmpvar_40 = (bias_44 + (pow (
    clamp ((1.0 - cs_41), 0.0, 1.0)
  , power_42) * scale_43));
  f_1 = tmpvar_40;
  lowp vec4 tmpvar_45;
  tmpvar_45 = textureCube (_EnvTex, tmpvar_38);
  col_7.xyz = (col_7.xyz + ((tmpvar_45.xyz * mainTexColor_8.w) * (f_1 * _Reflectivity)));
  col_7.xyz = mix (col_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_7.w = _BloomFactor;
  col_7.xyz = mix (col_7.xyz, vec3(dot (col_7.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = col_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp float sint_1;
  highp float cost_2;
  highp vec3 adjCamPos_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec2 tmpvar_6;
  mediump vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  highp vec3 scale_12;
  highp vec4 v_13;
  v_13.x = unity_ObjectToWorld[0].x;
  v_13.y = unity_ObjectToWorld[1].x;
  v_13.z = unity_ObjectToWorld[2].x;
  v_13.w = unity_ObjectToWorld[3].x;
  scale_12.x = sqrt(dot (v_13.xyz, v_13.xyz));
  highp vec4 v_14;
  v_14.x = unity_ObjectToWorld[0].y;
  v_14.y = unity_ObjectToWorld[1].y;
  v_14.z = unity_ObjectToWorld[2].y;
  v_14.w = unity_ObjectToWorld[3].y;
  scale_12.y = sqrt(dot (v_14.xyz, v_14.xyz));
  highp vec4 v_15;
  v_15.x = unity_ObjectToWorld[0].z;
  v_15.y = unity_ObjectToWorld[1].z;
  v_15.z = unity_ObjectToWorld[2].z;
  v_15.w = unity_ObjectToWorld[3].z;
  scale_12.z = sqrt(dot (v_15.xyz, v_15.xyz));
  if ((tmpvar_11.y > 0.5)) {
    tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.zx);
    tmpvar_6 = vec2(0.0, 0.0);
  } else {
    if ((tmpvar_11.y < -0.5)) {
      tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.zx);
      tmpvar_6 = vec2(1.0, 0.0);
    } else {
      if ((tmpvar_11.x > 0.5)) {
        tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.zy);
        tmpvar_6 = vec2(1.0, 0.0);
      } else {
        if ((tmpvar_11.x < -0.5)) {
          tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.zy);
          tmpvar_6 = vec2(1.0, 0.0);
        } else {
          if ((tmpvar_11.z > 0.5)) {
            tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.xy);
            tmpvar_6 = vec2(1.0, 0.0);
          } else {
            if ((tmpvar_11.z < -0.5)) {
              tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.xy);
              tmpvar_6 = vec2(1.0, 0.0);
            };
          };
        };
      };
    };
  };
  tmpvar_5 = ((tmpvar_5 * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  adjCamPos_3.xz = (tmpvar_9.xz - ((tmpvar_9.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_3.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_28;
  tmpvar_28 = normalize((tmpvar_9 - adjCamPos_3));
  tmpvar_7 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = cos(_CamRotate);
  cost_2 = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = sin(_CamRotate);
  sint_1 = tmpvar_30;
  highp mat2 tmpvar_31;
  tmpvar_31[0].x = cost_2;
  tmpvar_31[0].y = -(sint_1);
  tmpvar_31[1].x = sint_1;
  tmpvar_31[1].y = cost_2;
  tmpvar_7.xz = (tmpvar_31 * tmpvar_7.xz);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_COLOR1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump vec4 _ReflectFresnel;
uniform highp vec4 _AvatarPosInWorldPos;
uniform highp vec4 _PrevAvatarPosInWorldPos;
uniform highp float _IsCurCircleBusy;
uniform highp float _IsPrevCircleBusy;
uniform highp float _CircleTime;
uniform highp float _PrevCircleTime;
uniform highp float _TimeIntervalRatio;
uniform sampler2D _CircleColorTex;
uniform highp vec4 _CircleColorTex_ST;
uniform highp float _CircleRadius;
uniform highp vec3 _LightDir;
uniform mediump float _Ambient;
uniform mediump float _Diffuse;
uniform mediump float _Specular;
uniform mediump float _Shininess;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  mediump float f_1;
  mediump vec4 prevCircleColor_2;
  mediump vec4 curCircleColor_3;
  mediump vec3 V_4;
  mediump vec3 L_5;
  mediump vec3 N_6;
  mediump vec4 col_7;
  mediump vec4 mainTexColor_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((fract(xlv_TEXCOORD0) + xlv_TEXCOORD1) * vec2(0.5, 1.0));
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, tmpvar_9);
  mainTexColor_8 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(xlv_TEXCOORD2);
  N_6 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = -(normalize(_LightDir));
  L_5 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_4 = tmpvar_13;
  col_7 = (mainTexColor_8 * (_Ambient + (
    max (dot (N_6, L_5), 0.0)
   * _Diffuse)));
  col_7 = (col_7 + (max (0.0, 
    pow (max (dot (N_6, normalize(
      (L_5 + V_4)
    )), 0.001), _Shininess)
  ) * _Specular));
  curCircleColor_3 = vec4(0.0, 0.0, 0.0, 0.0);
  if (bool(_IsCurCircleBusy)) {
    highp vec3 diffDir_14;
    mediump vec4 outColor_15;
    outColor_15 = vec4(0.0, 0.0, 0.0, 0.0);
    highp float tmpvar_16;
    tmpvar_16 = (_CircleTime * _TimeIntervalRatio);
    highp float tmpvar_17;
    tmpvar_17 = floor((sin(
      (1.570795 * tmpvar_16)
    ) * _CircleRadius));
    highp vec3 tmpvar_18;
    tmpvar_18 = (xlv_TEXCOORD3 - _AvatarPosInWorldPos.xyz);
    diffDir_14.xz = tmpvar_18.xz;
    diffDir_14.y = (tmpvar_18.y - 0.5);
    highp vec3 tmpvar_19;
    tmpvar_19 = floor((diffDir_14 + vec3(0.5, 0.5, 0.5)));
    highp float tmpvar_20;
    tmpvar_20 = sqrt(dot (tmpvar_19, tmpvar_19));
    highp float tmpvar_21;
    tmpvar_21 = abs((tmpvar_20 - tmpvar_17));
    if ((tmpvar_21 < 1.51)) {
      mediump vec4 circleColor_22;
      highp vec2 tmpvar_23;
      tmpvar_23 = ((vec2(tmpvar_16) * _CircleColorTex_ST.xy) + _CircleColorTex_ST.zw);
      lowp vec4 tmpvar_24;
      tmpvar_24 = texture2D (_CircleColorTex, tmpvar_23);
      circleColor_22 = tmpvar_24;
      highp float tmpvar_25;
      tmpvar_25 = abs((tmpvar_20 - tmpvar_17));
      outColor_15 = (((circleColor_22 * 
        (1.5 - tmpvar_25)
      ) * (1.0 - tmpvar_16)) * (1.0 - tmpvar_16));
    };
    curCircleColor_3 = outColor_15;
  };
  prevCircleColor_2 = vec4(0.0, 0.0, 0.0, 0.0);
  if (bool(_IsPrevCircleBusy)) {
    highp vec3 diffDir_26;
    mediump vec4 outColor_27;
    outColor_27 = vec4(0.0, 0.0, 0.0, 0.0);
    highp float tmpvar_28;
    tmpvar_28 = (_PrevCircleTime * _TimeIntervalRatio);
    highp float tmpvar_29;
    tmpvar_29 = floor((sin(
      (1.570795 * tmpvar_28)
    ) * _CircleRadius));
    highp vec3 tmpvar_30;
    tmpvar_30 = (xlv_TEXCOORD3 - _PrevAvatarPosInWorldPos.xyz);
    diffDir_26.xz = tmpvar_30.xz;
    diffDir_26.y = (tmpvar_30.y - 0.5);
    highp vec3 tmpvar_31;
    tmpvar_31 = floor((diffDir_26 + vec3(0.5, 0.5, 0.5)));
    highp float tmpvar_32;
    tmpvar_32 = sqrt(dot (tmpvar_31, tmpvar_31));
    highp float tmpvar_33;
    tmpvar_33 = abs((tmpvar_32 - tmpvar_29));
    if ((tmpvar_33 < 1.51)) {
      mediump vec4 circleColor_34;
      highp vec2 tmpvar_35;
      tmpvar_35 = ((vec2(tmpvar_28) * _CircleColorTex_ST.xy) + _CircleColorTex_ST.zw);
      lowp vec4 tmpvar_36;
      tmpvar_36 = texture2D (_CircleColorTex, tmpvar_35);
      circleColor_34 = tmpvar_36;
      highp float tmpvar_37;
      tmpvar_37 = abs((tmpvar_32 - tmpvar_29));
      outColor_27 = (((circleColor_34 * 
        (1.5 - tmpvar_37)
      ) * (1.0 - tmpvar_28)) * (1.0 - tmpvar_28));
    };
    prevCircleColor_2 = outColor_27;
  };
  col_7 = (col_7 + ((
    (curCircleColor_3 + prevCircleColor_2)
   - 
    (curCircleColor_3 * prevCircleColor_2)
  ) * mainTexColor_8.w));
  mediump vec3 tmpvar_38;
  tmpvar_38 = (V_4 - (2.0 * (
    dot (N_6, V_4)
   * N_6)));
  mediump float tmpvar_39;
  tmpvar_39 = abs(dot (N_6, V_4));
  highp float tmpvar_40;
  highp float cs_41;
  cs_41 = tmpvar_39;
  highp float power_42;
  power_42 = _ReflectFresnel.x;
  highp float scale_43;
  scale_43 = _ReflectFresnel.y;
  highp float bias_44;
  bias_44 = _ReflectFresnel.z;
  tmpvar_40 = (bias_44 + (pow (
    clamp ((1.0 - cs_41), 0.0, 1.0)
  , power_42) * scale_43));
  f_1 = tmpvar_40;
  lowp vec4 tmpvar_45;
  tmpvar_45 = textureCube (_EnvTex, tmpvar_38);
  col_7.xyz = (col_7.xyz + ((tmpvar_45.xyz * mainTexColor_8.w) * (f_1 * _Reflectivity)));
  col_7.xyz = mix (col_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_7.w = _BloomFactor;
  col_7.xyz = mix (col_7.xyz, vec3(dot (col_7.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = col_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp float sint_1;
  highp float cost_2;
  highp vec3 adjCamPos_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec2 tmpvar_6;
  mediump vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  highp vec3 scale_12;
  highp vec4 v_13;
  v_13.x = unity_ObjectToWorld[0].x;
  v_13.y = unity_ObjectToWorld[1].x;
  v_13.z = unity_ObjectToWorld[2].x;
  v_13.w = unity_ObjectToWorld[3].x;
  scale_12.x = sqrt(dot (v_13.xyz, v_13.xyz));
  highp vec4 v_14;
  v_14.x = unity_ObjectToWorld[0].y;
  v_14.y = unity_ObjectToWorld[1].y;
  v_14.z = unity_ObjectToWorld[2].y;
  v_14.w = unity_ObjectToWorld[3].y;
  scale_12.y = sqrt(dot (v_14.xyz, v_14.xyz));
  highp vec4 v_15;
  v_15.x = unity_ObjectToWorld[0].z;
  v_15.y = unity_ObjectToWorld[1].z;
  v_15.z = unity_ObjectToWorld[2].z;
  v_15.w = unity_ObjectToWorld[3].z;
  scale_12.z = sqrt(dot (v_15.xyz, v_15.xyz));
  if ((tmpvar_11.y > 0.5)) {
    tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.zx);
    tmpvar_6 = vec2(0.0, 0.0);
  } else {
    if ((tmpvar_11.y < -0.5)) {
      tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.zx);
      tmpvar_6 = vec2(1.0, 0.0);
    } else {
      if ((tmpvar_11.x > 0.5)) {
        tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.zy);
        tmpvar_6 = vec2(1.0, 0.0);
      } else {
        if ((tmpvar_11.x < -0.5)) {
          tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.zy);
          tmpvar_6 = vec2(1.0, 0.0);
        } else {
          if ((tmpvar_11.z > 0.5)) {
            tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.xy);
            tmpvar_6 = vec2(1.0, 0.0);
          } else {
            if ((tmpvar_11.z < -0.5)) {
              tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.xy);
              tmpvar_6 = vec2(1.0, 0.0);
            };
          };
        };
      };
    };
  };
  tmpvar_5 = ((tmpvar_5 * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  adjCamPos_3.xz = (tmpvar_9.xz - ((tmpvar_9.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_3.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_28;
  tmpvar_28 = normalize((tmpvar_9 - adjCamPos_3));
  tmpvar_7 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = cos(_CamRotate);
  cost_2 = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = sin(_CamRotate);
  sint_1 = tmpvar_30;
  highp mat2 tmpvar_31;
  tmpvar_31[0].x = cost_2;
  tmpvar_31[0].y = -(sint_1);
  tmpvar_31[1].x = sint_1;
  tmpvar_31[1].y = cost_2;
  tmpvar_7.xz = (tmpvar_31 * tmpvar_7.xz);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_COLOR1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump vec4 _ReflectFresnel;
uniform highp vec4 _AvatarPosInWorldPos;
uniform highp vec4 _PrevAvatarPosInWorldPos;
uniform highp float _IsCurCircleBusy;
uniform highp float _IsPrevCircleBusy;
uniform highp float _CircleTime;
uniform highp float _PrevCircleTime;
uniform highp float _TimeIntervalRatio;
uniform sampler2D _CircleColorTex;
uniform highp vec4 _CircleColorTex_ST;
uniform highp float _CircleRadius;
uniform highp vec3 _LightDir;
uniform mediump float _Ambient;
uniform mediump float _Diffuse;
uniform mediump float _Specular;
uniform mediump float _Shininess;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  mediump float f_1;
  mediump vec4 prevCircleColor_2;
  mediump vec4 curCircleColor_3;
  mediump vec3 V_4;
  mediump vec3 L_5;
  mediump vec3 N_6;
  mediump vec4 col_7;
  mediump vec4 mainTexColor_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((fract(xlv_TEXCOORD0) + xlv_TEXCOORD1) * vec2(0.5, 1.0));
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, tmpvar_9);
  mainTexColor_8 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(xlv_TEXCOORD2);
  N_6 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = -(normalize(_LightDir));
  L_5 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_4 = tmpvar_13;
  col_7 = (mainTexColor_8 * (_Ambient + (
    max (dot (N_6, L_5), 0.0)
   * _Diffuse)));
  col_7 = (col_7 + (max (0.0, 
    pow (max (dot (N_6, normalize(
      (L_5 + V_4)
    )), 0.001), _Shininess)
  ) * _Specular));
  curCircleColor_3 = vec4(0.0, 0.0, 0.0, 0.0);
  if (bool(_IsCurCircleBusy)) {
    highp vec3 diffDir_14;
    mediump vec4 outColor_15;
    outColor_15 = vec4(0.0, 0.0, 0.0, 0.0);
    highp float tmpvar_16;
    tmpvar_16 = (_CircleTime * _TimeIntervalRatio);
    highp float tmpvar_17;
    tmpvar_17 = floor((sin(
      (1.570795 * tmpvar_16)
    ) * _CircleRadius));
    highp vec3 tmpvar_18;
    tmpvar_18 = (xlv_TEXCOORD3 - _AvatarPosInWorldPos.xyz);
    diffDir_14.xz = tmpvar_18.xz;
    diffDir_14.y = (tmpvar_18.y - 0.5);
    highp vec3 tmpvar_19;
    tmpvar_19 = floor((diffDir_14 + vec3(0.5, 0.5, 0.5)));
    highp float tmpvar_20;
    tmpvar_20 = sqrt(dot (tmpvar_19, tmpvar_19));
    highp float tmpvar_21;
    tmpvar_21 = abs((tmpvar_20 - tmpvar_17));
    if ((tmpvar_21 < 1.51)) {
      mediump vec4 circleColor_22;
      highp vec2 tmpvar_23;
      tmpvar_23 = ((vec2(tmpvar_16) * _CircleColorTex_ST.xy) + _CircleColorTex_ST.zw);
      lowp vec4 tmpvar_24;
      tmpvar_24 = texture2D (_CircleColorTex, tmpvar_23);
      circleColor_22 = tmpvar_24;
      highp float tmpvar_25;
      tmpvar_25 = abs((tmpvar_20 - tmpvar_17));
      outColor_15 = (((circleColor_22 * 
        (1.5 - tmpvar_25)
      ) * (1.0 - tmpvar_16)) * (1.0 - tmpvar_16));
    };
    curCircleColor_3 = outColor_15;
  };
  prevCircleColor_2 = vec4(0.0, 0.0, 0.0, 0.0);
  if (bool(_IsPrevCircleBusy)) {
    highp vec3 diffDir_26;
    mediump vec4 outColor_27;
    outColor_27 = vec4(0.0, 0.0, 0.0, 0.0);
    highp float tmpvar_28;
    tmpvar_28 = (_PrevCircleTime * _TimeIntervalRatio);
    highp float tmpvar_29;
    tmpvar_29 = floor((sin(
      (1.570795 * tmpvar_28)
    ) * _CircleRadius));
    highp vec3 tmpvar_30;
    tmpvar_30 = (xlv_TEXCOORD3 - _PrevAvatarPosInWorldPos.xyz);
    diffDir_26.xz = tmpvar_30.xz;
    diffDir_26.y = (tmpvar_30.y - 0.5);
    highp vec3 tmpvar_31;
    tmpvar_31 = floor((diffDir_26 + vec3(0.5, 0.5, 0.5)));
    highp float tmpvar_32;
    tmpvar_32 = sqrt(dot (tmpvar_31, tmpvar_31));
    highp float tmpvar_33;
    tmpvar_33 = abs((tmpvar_32 - tmpvar_29));
    if ((tmpvar_33 < 1.51)) {
      mediump vec4 circleColor_34;
      highp vec2 tmpvar_35;
      tmpvar_35 = ((vec2(tmpvar_28) * _CircleColorTex_ST.xy) + _CircleColorTex_ST.zw);
      lowp vec4 tmpvar_36;
      tmpvar_36 = texture2D (_CircleColorTex, tmpvar_35);
      circleColor_34 = tmpvar_36;
      highp float tmpvar_37;
      tmpvar_37 = abs((tmpvar_32 - tmpvar_29));
      outColor_27 = (((circleColor_34 * 
        (1.5 - tmpvar_37)
      ) * (1.0 - tmpvar_28)) * (1.0 - tmpvar_28));
    };
    prevCircleColor_2 = outColor_27;
  };
  col_7 = (col_7 + ((
    (curCircleColor_3 + prevCircleColor_2)
   - 
    (curCircleColor_3 * prevCircleColor_2)
  ) * mainTexColor_8.w));
  mediump vec3 tmpvar_38;
  tmpvar_38 = (V_4 - (2.0 * (
    dot (N_6, V_4)
   * N_6)));
  mediump float tmpvar_39;
  tmpvar_39 = abs(dot (N_6, V_4));
  highp float tmpvar_40;
  highp float cs_41;
  cs_41 = tmpvar_39;
  highp float power_42;
  power_42 = _ReflectFresnel.x;
  highp float scale_43;
  scale_43 = _ReflectFresnel.y;
  highp float bias_44;
  bias_44 = _ReflectFresnel.z;
  tmpvar_40 = (bias_44 + (pow (
    clamp ((1.0 - cs_41), 0.0, 1.0)
  , power_42) * scale_43));
  f_1 = tmpvar_40;
  lowp vec4 tmpvar_45;
  tmpvar_45 = textureCube (_EnvTex, tmpvar_38);
  col_7.xyz = (col_7.xyz + ((tmpvar_45.xyz * mainTexColor_8.w) * (f_1 * _Reflectivity)));
  col_7.xyz = mix (col_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_7.w = _BloomFactor;
  col_7.xyz = mix (col_7.xyz, vec3(dot (col_7.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = col_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp float sint_1;
  highp float cost_2;
  highp vec3 adjCamPos_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec2 tmpvar_6;
  mediump vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  highp vec3 scale_12;
  highp vec4 v_13;
  v_13.x = unity_ObjectToWorld[0].x;
  v_13.y = unity_ObjectToWorld[1].x;
  v_13.z = unity_ObjectToWorld[2].x;
  v_13.w = unity_ObjectToWorld[3].x;
  scale_12.x = sqrt(dot (v_13.xyz, v_13.xyz));
  highp vec4 v_14;
  v_14.x = unity_ObjectToWorld[0].y;
  v_14.y = unity_ObjectToWorld[1].y;
  v_14.z = unity_ObjectToWorld[2].y;
  v_14.w = unity_ObjectToWorld[3].y;
  scale_12.y = sqrt(dot (v_14.xyz, v_14.xyz));
  highp vec4 v_15;
  v_15.x = unity_ObjectToWorld[0].z;
  v_15.y = unity_ObjectToWorld[1].z;
  v_15.z = unity_ObjectToWorld[2].z;
  v_15.w = unity_ObjectToWorld[3].z;
  scale_12.z = sqrt(dot (v_15.xyz, v_15.xyz));
  if ((tmpvar_11.y > 0.5)) {
    tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.zx);
    tmpvar_6 = vec2(0.0, 0.0);
  } else {
    if ((tmpvar_11.y < -0.5)) {
      tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.zx);
      tmpvar_6 = vec2(1.0, 0.0);
    } else {
      if ((tmpvar_11.x > 0.5)) {
        tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.zy);
        tmpvar_6 = vec2(1.0, 0.0);
      } else {
        if ((tmpvar_11.x < -0.5)) {
          tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.zy);
          tmpvar_6 = vec2(1.0, 0.0);
        } else {
          if ((tmpvar_11.z > 0.5)) {
            tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.xy);
            tmpvar_6 = vec2(1.0, 0.0);
          } else {
            if ((tmpvar_11.z < -0.5)) {
              tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.xy);
              tmpvar_6 = vec2(1.0, 0.0);
            };
          };
        };
      };
    };
  };
  tmpvar_5 = ((tmpvar_5 * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  adjCamPos_3.xz = (tmpvar_9.xz - ((tmpvar_9.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_3.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_28;
  tmpvar_28 = normalize((tmpvar_9 - adjCamPos_3));
  tmpvar_7 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = cos(_CamRotate);
  cost_2 = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = sin(_CamRotate);
  sint_1 = tmpvar_30;
  highp mat2 tmpvar_31;
  tmpvar_31[0].x = cost_2;
  tmpvar_31[0].y = -(sint_1);
  tmpvar_31[1].x = sint_1;
  tmpvar_31[1].y = cost_2;
  tmpvar_7.xz = (tmpvar_31 * tmpvar_7.xz);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_COLOR1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump vec4 _ReflectFresnel;
uniform highp vec4 _AvatarPosInWorldPos;
uniform highp vec4 _PrevAvatarPosInWorldPos;
uniform highp float _IsCurCircleBusy;
uniform highp float _IsPrevCircleBusy;
uniform highp float _CircleTime;
uniform highp float _PrevCircleTime;
uniform highp float _TimeIntervalRatio;
uniform sampler2D _CircleColorTex;
uniform highp vec4 _CircleColorTex_ST;
uniform highp float _CircleRadius;
uniform highp vec3 _LightDir;
uniform mediump float _Ambient;
uniform mediump float _Diffuse;
uniform mediump float _Specular;
uniform mediump float _Shininess;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  mediump float f_1;
  mediump vec4 prevCircleColor_2;
  mediump vec4 curCircleColor_3;
  mediump vec3 V_4;
  mediump vec3 L_5;
  mediump vec3 N_6;
  mediump vec4 col_7;
  mediump vec4 mainTexColor_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((fract(xlv_TEXCOORD0) + xlv_TEXCOORD1) * vec2(0.5, 1.0));
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, tmpvar_9);
  mainTexColor_8 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(xlv_TEXCOORD2);
  N_6 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = -(normalize(_LightDir));
  L_5 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_4 = tmpvar_13;
  col_7 = (mainTexColor_8 * (_Ambient + (
    max (dot (N_6, L_5), 0.0)
   * _Diffuse)));
  col_7 = (col_7 + (max (0.0, 
    pow (max (dot (N_6, normalize(
      (L_5 + V_4)
    )), 0.001), _Shininess)
  ) * _Specular));
  curCircleColor_3 = vec4(0.0, 0.0, 0.0, 0.0);
  if (bool(_IsCurCircleBusy)) {
    highp vec3 diffDir_14;
    mediump vec4 outColor_15;
    outColor_15 = vec4(0.0, 0.0, 0.0, 0.0);
    highp float tmpvar_16;
    tmpvar_16 = (_CircleTime * _TimeIntervalRatio);
    highp float tmpvar_17;
    tmpvar_17 = floor((sin(
      (1.570795 * tmpvar_16)
    ) * _CircleRadius));
    highp vec3 tmpvar_18;
    tmpvar_18 = (xlv_TEXCOORD3 - _AvatarPosInWorldPos.xyz);
    diffDir_14.xz = tmpvar_18.xz;
    diffDir_14.y = (tmpvar_18.y - 0.5);
    highp vec3 tmpvar_19;
    tmpvar_19 = floor((diffDir_14 + vec3(0.5, 0.5, 0.5)));
    highp float tmpvar_20;
    tmpvar_20 = sqrt(dot (tmpvar_19, tmpvar_19));
    highp float tmpvar_21;
    tmpvar_21 = abs((tmpvar_20 - tmpvar_17));
    if ((tmpvar_21 < 1.51)) {
      mediump vec4 circleColor_22;
      highp vec2 tmpvar_23;
      tmpvar_23 = ((vec2(tmpvar_16) * _CircleColorTex_ST.xy) + _CircleColorTex_ST.zw);
      lowp vec4 tmpvar_24;
      tmpvar_24 = texture2D (_CircleColorTex, tmpvar_23);
      circleColor_22 = tmpvar_24;
      highp float tmpvar_25;
      tmpvar_25 = abs((tmpvar_20 - tmpvar_17));
      outColor_15 = (((circleColor_22 * 
        (1.5 - tmpvar_25)
      ) * (1.0 - tmpvar_16)) * (1.0 - tmpvar_16));
    };
    curCircleColor_3 = outColor_15;
  };
  prevCircleColor_2 = vec4(0.0, 0.0, 0.0, 0.0);
  if (bool(_IsPrevCircleBusy)) {
    highp vec3 diffDir_26;
    mediump vec4 outColor_27;
    outColor_27 = vec4(0.0, 0.0, 0.0, 0.0);
    highp float tmpvar_28;
    tmpvar_28 = (_PrevCircleTime * _TimeIntervalRatio);
    highp float tmpvar_29;
    tmpvar_29 = floor((sin(
      (1.570795 * tmpvar_28)
    ) * _CircleRadius));
    highp vec3 tmpvar_30;
    tmpvar_30 = (xlv_TEXCOORD3 - _PrevAvatarPosInWorldPos.xyz);
    diffDir_26.xz = tmpvar_30.xz;
    diffDir_26.y = (tmpvar_30.y - 0.5);
    highp vec3 tmpvar_31;
    tmpvar_31 = floor((diffDir_26 + vec3(0.5, 0.5, 0.5)));
    highp float tmpvar_32;
    tmpvar_32 = sqrt(dot (tmpvar_31, tmpvar_31));
    highp float tmpvar_33;
    tmpvar_33 = abs((tmpvar_32 - tmpvar_29));
    if ((tmpvar_33 < 1.51)) {
      mediump vec4 circleColor_34;
      highp vec2 tmpvar_35;
      tmpvar_35 = ((vec2(tmpvar_28) * _CircleColorTex_ST.xy) + _CircleColorTex_ST.zw);
      lowp vec4 tmpvar_36;
      tmpvar_36 = texture2D (_CircleColorTex, tmpvar_35);
      circleColor_34 = tmpvar_36;
      highp float tmpvar_37;
      tmpvar_37 = abs((tmpvar_32 - tmpvar_29));
      outColor_27 = (((circleColor_34 * 
        (1.5 - tmpvar_37)
      ) * (1.0 - tmpvar_28)) * (1.0 - tmpvar_28));
    };
    prevCircleColor_2 = outColor_27;
  };
  col_7 = (col_7 + ((
    (curCircleColor_3 + prevCircleColor_2)
   - 
    (curCircleColor_3 * prevCircleColor_2)
  ) * mainTexColor_8.w));
  mediump vec3 tmpvar_38;
  tmpvar_38 = (V_4 - (2.0 * (
    dot (N_6, V_4)
   * N_6)));
  mediump float tmpvar_39;
  tmpvar_39 = abs(dot (N_6, V_4));
  highp float tmpvar_40;
  highp float cs_41;
  cs_41 = tmpvar_39;
  highp float power_42;
  power_42 = _ReflectFresnel.x;
  highp float scale_43;
  scale_43 = _ReflectFresnel.y;
  highp float bias_44;
  bias_44 = _ReflectFresnel.z;
  tmpvar_40 = (bias_44 + (pow (
    clamp ((1.0 - cs_41), 0.0, 1.0)
  , power_42) * scale_43));
  f_1 = tmpvar_40;
  lowp vec4 tmpvar_45;
  tmpvar_45 = textureCube (_EnvTex, tmpvar_38);
  col_7.xyz = (col_7.xyz + ((tmpvar_45.xyz * mainTexColor_8.w) * (f_1 * _Reflectivity)));
  col_7.xyz = mix (col_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_7.w = _BloomFactor;
  col_7.xyz = mix (col_7.xyz, vec3(dot (col_7.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = col_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp float sint_1;
  highp float cost_2;
  highp vec3 adjCamPos_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec2 tmpvar_6;
  mediump vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  highp vec3 scale_12;
  highp vec4 v_13;
  v_13.x = unity_ObjectToWorld[0].x;
  v_13.y = unity_ObjectToWorld[1].x;
  v_13.z = unity_ObjectToWorld[2].x;
  v_13.w = unity_ObjectToWorld[3].x;
  scale_12.x = sqrt(dot (v_13.xyz, v_13.xyz));
  highp vec4 v_14;
  v_14.x = unity_ObjectToWorld[0].y;
  v_14.y = unity_ObjectToWorld[1].y;
  v_14.z = unity_ObjectToWorld[2].y;
  v_14.w = unity_ObjectToWorld[3].y;
  scale_12.y = sqrt(dot (v_14.xyz, v_14.xyz));
  highp vec4 v_15;
  v_15.x = unity_ObjectToWorld[0].z;
  v_15.y = unity_ObjectToWorld[1].z;
  v_15.z = unity_ObjectToWorld[2].z;
  v_15.w = unity_ObjectToWorld[3].z;
  scale_12.z = sqrt(dot (v_15.xyz, v_15.xyz));
  if ((tmpvar_11.y > 0.5)) {
    tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.zx);
    tmpvar_6 = vec2(0.0, 0.0);
  } else {
    if ((tmpvar_11.y < -0.5)) {
      tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.zx);
      tmpvar_6 = vec2(1.0, 0.0);
    } else {
      if ((tmpvar_11.x > 0.5)) {
        tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.zy);
        tmpvar_6 = vec2(1.0, 0.0);
      } else {
        if ((tmpvar_11.x < -0.5)) {
          tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.zy);
          tmpvar_6 = vec2(1.0, 0.0);
        } else {
          if ((tmpvar_11.z > 0.5)) {
            tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.xy);
            tmpvar_6 = vec2(1.0, 0.0);
          } else {
            if ((tmpvar_11.z < -0.5)) {
              tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.xy);
              tmpvar_6 = vec2(1.0, 0.0);
            };
          };
        };
      };
    };
  };
  tmpvar_5 = ((tmpvar_5 * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  adjCamPos_3.xz = (tmpvar_9.xz - ((tmpvar_9.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_3.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_28;
  tmpvar_28 = normalize((tmpvar_9 - adjCamPos_3));
  tmpvar_7 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = cos(_CamRotate);
  cost_2 = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = sin(_CamRotate);
  sint_1 = tmpvar_30;
  highp mat2 tmpvar_31;
  tmpvar_31[0].x = cost_2;
  tmpvar_31[0].y = -(sint_1);
  tmpvar_31[1].x = sint_1;
  tmpvar_31[1].y = cost_2;
  tmpvar_7.xz = (tmpvar_31 * tmpvar_7.xz);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_COLOR1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump vec4 _ReflectFresnel;
uniform highp vec4 _AvatarPosInWorldPos;
uniform highp vec4 _PrevAvatarPosInWorldPos;
uniform highp float _IsCurCircleBusy;
uniform highp float _IsPrevCircleBusy;
uniform highp float _CircleTime;
uniform highp float _PrevCircleTime;
uniform highp float _TimeIntervalRatio;
uniform sampler2D _CircleColorTex;
uniform highp vec4 _CircleColorTex_ST;
uniform highp float _CircleRadius;
uniform highp vec3 _LightDir;
uniform mediump float _Ambient;
uniform mediump float _Diffuse;
uniform mediump float _Specular;
uniform mediump float _Shininess;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  mediump float f_1;
  mediump vec4 prevCircleColor_2;
  mediump vec4 curCircleColor_3;
  mediump vec3 V_4;
  mediump vec3 L_5;
  mediump vec3 N_6;
  mediump vec4 col_7;
  mediump vec4 mainTexColor_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((fract(xlv_TEXCOORD0) + xlv_TEXCOORD1) * vec2(0.5, 1.0));
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, tmpvar_9);
  mainTexColor_8 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(xlv_TEXCOORD2);
  N_6 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = -(normalize(_LightDir));
  L_5 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_4 = tmpvar_13;
  col_7 = (mainTexColor_8 * (_Ambient + (
    max (dot (N_6, L_5), 0.0)
   * _Diffuse)));
  col_7 = (col_7 + (max (0.0, 
    pow (max (dot (N_6, normalize(
      (L_5 + V_4)
    )), 0.001), _Shininess)
  ) * _Specular));
  curCircleColor_3 = vec4(0.0, 0.0, 0.0, 0.0);
  if (bool(_IsCurCircleBusy)) {
    highp vec3 diffDir_14;
    mediump vec4 outColor_15;
    outColor_15 = vec4(0.0, 0.0, 0.0, 0.0);
    highp float tmpvar_16;
    tmpvar_16 = (_CircleTime * _TimeIntervalRatio);
    highp float tmpvar_17;
    tmpvar_17 = floor((sin(
      (1.570795 * tmpvar_16)
    ) * _CircleRadius));
    highp vec3 tmpvar_18;
    tmpvar_18 = (xlv_TEXCOORD3 - _AvatarPosInWorldPos.xyz);
    diffDir_14.xz = tmpvar_18.xz;
    diffDir_14.y = (tmpvar_18.y - 0.5);
    highp vec3 tmpvar_19;
    tmpvar_19 = floor((diffDir_14 + vec3(0.5, 0.5, 0.5)));
    highp float tmpvar_20;
    tmpvar_20 = sqrt(dot (tmpvar_19, tmpvar_19));
    highp float tmpvar_21;
    tmpvar_21 = abs((tmpvar_20 - tmpvar_17));
    if ((tmpvar_21 < 1.51)) {
      mediump vec4 circleColor_22;
      highp vec2 tmpvar_23;
      tmpvar_23 = ((vec2(tmpvar_16) * _CircleColorTex_ST.xy) + _CircleColorTex_ST.zw);
      lowp vec4 tmpvar_24;
      tmpvar_24 = texture2D (_CircleColorTex, tmpvar_23);
      circleColor_22 = tmpvar_24;
      highp float tmpvar_25;
      tmpvar_25 = abs((tmpvar_20 - tmpvar_17));
      outColor_15 = (((circleColor_22 * 
        (1.5 - tmpvar_25)
      ) * (1.0 - tmpvar_16)) * (1.0 - tmpvar_16));
    };
    curCircleColor_3 = outColor_15;
  };
  prevCircleColor_2 = vec4(0.0, 0.0, 0.0, 0.0);
  if (bool(_IsPrevCircleBusy)) {
    highp vec3 diffDir_26;
    mediump vec4 outColor_27;
    outColor_27 = vec4(0.0, 0.0, 0.0, 0.0);
    highp float tmpvar_28;
    tmpvar_28 = (_PrevCircleTime * _TimeIntervalRatio);
    highp float tmpvar_29;
    tmpvar_29 = floor((sin(
      (1.570795 * tmpvar_28)
    ) * _CircleRadius));
    highp vec3 tmpvar_30;
    tmpvar_30 = (xlv_TEXCOORD3 - _PrevAvatarPosInWorldPos.xyz);
    diffDir_26.xz = tmpvar_30.xz;
    diffDir_26.y = (tmpvar_30.y - 0.5);
    highp vec3 tmpvar_31;
    tmpvar_31 = floor((diffDir_26 + vec3(0.5, 0.5, 0.5)));
    highp float tmpvar_32;
    tmpvar_32 = sqrt(dot (tmpvar_31, tmpvar_31));
    highp float tmpvar_33;
    tmpvar_33 = abs((tmpvar_32 - tmpvar_29));
    if ((tmpvar_33 < 1.51)) {
      mediump vec4 circleColor_34;
      highp vec2 tmpvar_35;
      tmpvar_35 = ((vec2(tmpvar_28) * _CircleColorTex_ST.xy) + _CircleColorTex_ST.zw);
      lowp vec4 tmpvar_36;
      tmpvar_36 = texture2D (_CircleColorTex, tmpvar_35);
      circleColor_34 = tmpvar_36;
      highp float tmpvar_37;
      tmpvar_37 = abs((tmpvar_32 - tmpvar_29));
      outColor_27 = (((circleColor_34 * 
        (1.5 - tmpvar_37)
      ) * (1.0 - tmpvar_28)) * (1.0 - tmpvar_28));
    };
    prevCircleColor_2 = outColor_27;
  };
  col_7 = (col_7 + ((
    (curCircleColor_3 + prevCircleColor_2)
   - 
    (curCircleColor_3 * prevCircleColor_2)
  ) * mainTexColor_8.w));
  mediump vec3 tmpvar_38;
  tmpvar_38 = (V_4 - (2.0 * (
    dot (N_6, V_4)
   * N_6)));
  mediump float tmpvar_39;
  tmpvar_39 = abs(dot (N_6, V_4));
  highp float tmpvar_40;
  highp float cs_41;
  cs_41 = tmpvar_39;
  highp float power_42;
  power_42 = _ReflectFresnel.x;
  highp float scale_43;
  scale_43 = _ReflectFresnel.y;
  highp float bias_44;
  bias_44 = _ReflectFresnel.z;
  tmpvar_40 = (bias_44 + (pow (
    clamp ((1.0 - cs_41), 0.0, 1.0)
  , power_42) * scale_43));
  f_1 = tmpvar_40;
  lowp vec4 tmpvar_45;
  tmpvar_45 = textureCube (_EnvTex, tmpvar_38);
  col_7.xyz = (col_7.xyz + ((tmpvar_45.xyz * mainTexColor_8.w) * (f_1 * _Reflectivity)));
  col_7.xyz = mix (col_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_7.w = _BloomFactor;
  col_7.xyz = mix (col_7.xyz, vec3(dot (col_7.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = col_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp float sint_1;
  highp float cost_2;
  highp vec3 adjCamPos_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec2 tmpvar_6;
  mediump vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  highp vec3 scale_12;
  highp vec4 v_13;
  v_13.x = unity_ObjectToWorld[0].x;
  v_13.y = unity_ObjectToWorld[1].x;
  v_13.z = unity_ObjectToWorld[2].x;
  v_13.w = unity_ObjectToWorld[3].x;
  scale_12.x = sqrt(dot (v_13.xyz, v_13.xyz));
  highp vec4 v_14;
  v_14.x = unity_ObjectToWorld[0].y;
  v_14.y = unity_ObjectToWorld[1].y;
  v_14.z = unity_ObjectToWorld[2].y;
  v_14.w = unity_ObjectToWorld[3].y;
  scale_12.y = sqrt(dot (v_14.xyz, v_14.xyz));
  highp vec4 v_15;
  v_15.x = unity_ObjectToWorld[0].z;
  v_15.y = unity_ObjectToWorld[1].z;
  v_15.z = unity_ObjectToWorld[2].z;
  v_15.w = unity_ObjectToWorld[3].z;
  scale_12.z = sqrt(dot (v_15.xyz, v_15.xyz));
  if ((tmpvar_11.y > 0.5)) {
    tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.zx);
    tmpvar_6 = vec2(0.0, 0.0);
  } else {
    if ((tmpvar_11.y < -0.5)) {
      tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.zx);
      tmpvar_6 = vec2(1.0, 0.0);
    } else {
      if ((tmpvar_11.x > 0.5)) {
        tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.zy);
        tmpvar_6 = vec2(1.0, 0.0);
      } else {
        if ((tmpvar_11.x < -0.5)) {
          tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.zy);
          tmpvar_6 = vec2(1.0, 0.0);
        } else {
          if ((tmpvar_11.z > 0.5)) {
            tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.xy);
            tmpvar_6 = vec2(1.0, 0.0);
          } else {
            if ((tmpvar_11.z < -0.5)) {
              tmpvar_5 = (_glesMultiTexCoord0.xy * scale_12.xy);
              tmpvar_6 = vec2(1.0, 0.0);
            };
          };
        };
      };
    };
  };
  tmpvar_5 = ((tmpvar_5 * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  adjCamPos_3.xz = (tmpvar_9.xz - ((tmpvar_9.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_3.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_28;
  tmpvar_28 = normalize((tmpvar_9 - adjCamPos_3));
  tmpvar_7 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = cos(_CamRotate);
  cost_2 = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = sin(_CamRotate);
  sint_1 = tmpvar_30;
  highp mat2 tmpvar_31;
  tmpvar_31[0].x = cost_2;
  tmpvar_31[0].y = -(sint_1);
  tmpvar_31[1].x = sint_1;
  tmpvar_31[1].y = cost_2;
  tmpvar_7.xz = (tmpvar_31 * tmpvar_7.xz);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_COLOR1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump vec4 _ReflectFresnel;
uniform highp vec4 _AvatarPosInWorldPos;
uniform highp vec4 _PrevAvatarPosInWorldPos;
uniform highp float _IsCurCircleBusy;
uniform highp float _IsPrevCircleBusy;
uniform highp float _CircleTime;
uniform highp float _PrevCircleTime;
uniform highp float _TimeIntervalRatio;
uniform sampler2D _CircleColorTex;
uniform highp vec4 _CircleColorTex_ST;
uniform highp float _CircleRadius;
uniform highp vec3 _LightDir;
uniform mediump float _Ambient;
uniform mediump float _Diffuse;
uniform mediump float _Specular;
uniform mediump float _Shininess;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  mediump float f_1;
  mediump vec4 prevCircleColor_2;
  mediump vec4 curCircleColor_3;
  mediump vec3 V_4;
  mediump vec3 L_5;
  mediump vec3 N_6;
  mediump vec4 col_7;
  mediump vec4 mainTexColor_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((fract(xlv_TEXCOORD0) + xlv_TEXCOORD1) * vec2(0.5, 1.0));
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, tmpvar_9);
  mainTexColor_8 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(xlv_TEXCOORD2);
  N_6 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = -(normalize(_LightDir));
  L_5 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_4 = tmpvar_13;
  col_7 = (mainTexColor_8 * (_Ambient + (
    max (dot (N_6, L_5), 0.0)
   * _Diffuse)));
  col_7 = (col_7 + (max (0.0, 
    pow (max (dot (N_6, normalize(
      (L_5 + V_4)
    )), 0.001), _Shininess)
  ) * _Specular));
  curCircleColor_3 = vec4(0.0, 0.0, 0.0, 0.0);
  if (bool(_IsCurCircleBusy)) {
    highp vec3 diffDir_14;
    mediump vec4 outColor_15;
    outColor_15 = vec4(0.0, 0.0, 0.0, 0.0);
    highp float tmpvar_16;
    tmpvar_16 = (_CircleTime * _TimeIntervalRatio);
    highp float tmpvar_17;
    tmpvar_17 = floor((sin(
      (1.570795 * tmpvar_16)
    ) * _CircleRadius));
    highp vec3 tmpvar_18;
    tmpvar_18 = (xlv_TEXCOORD3 - _AvatarPosInWorldPos.xyz);
    diffDir_14.xz = tmpvar_18.xz;
    diffDir_14.y = (tmpvar_18.y - 0.5);
    highp vec3 tmpvar_19;
    tmpvar_19 = floor((diffDir_14 + vec3(0.5, 0.5, 0.5)));
    highp float tmpvar_20;
    tmpvar_20 = sqrt(dot (tmpvar_19, tmpvar_19));
    highp float tmpvar_21;
    tmpvar_21 = abs((tmpvar_20 - tmpvar_17));
    if ((tmpvar_21 < 1.51)) {
      mediump vec4 circleColor_22;
      highp vec2 tmpvar_23;
      tmpvar_23 = ((vec2(tmpvar_16) * _CircleColorTex_ST.xy) + _CircleColorTex_ST.zw);
      lowp vec4 tmpvar_24;
      tmpvar_24 = texture2D (_CircleColorTex, tmpvar_23);
      circleColor_22 = tmpvar_24;
      highp float tmpvar_25;
      tmpvar_25 = abs((tmpvar_20 - tmpvar_17));
      outColor_15 = (((circleColor_22 * 
        (1.5 - tmpvar_25)
      ) * (1.0 - tmpvar_16)) * (1.0 - tmpvar_16));
    };
    curCircleColor_3 = outColor_15;
  };
  prevCircleColor_2 = vec4(0.0, 0.0, 0.0, 0.0);
  if (bool(_IsPrevCircleBusy)) {
    highp vec3 diffDir_26;
    mediump vec4 outColor_27;
    outColor_27 = vec4(0.0, 0.0, 0.0, 0.0);
    highp float tmpvar_28;
    tmpvar_28 = (_PrevCircleTime * _TimeIntervalRatio);
    highp float tmpvar_29;
    tmpvar_29 = floor((sin(
      (1.570795 * tmpvar_28)
    ) * _CircleRadius));
    highp vec3 tmpvar_30;
    tmpvar_30 = (xlv_TEXCOORD3 - _PrevAvatarPosInWorldPos.xyz);
    diffDir_26.xz = tmpvar_30.xz;
    diffDir_26.y = (tmpvar_30.y - 0.5);
    highp vec3 tmpvar_31;
    tmpvar_31 = floor((diffDir_26 + vec3(0.5, 0.5, 0.5)));
    highp float tmpvar_32;
    tmpvar_32 = sqrt(dot (tmpvar_31, tmpvar_31));
    highp float tmpvar_33;
    tmpvar_33 = abs((tmpvar_32 - tmpvar_29));
    if ((tmpvar_33 < 1.51)) {
      mediump vec4 circleColor_34;
      highp vec2 tmpvar_35;
      tmpvar_35 = ((vec2(tmpvar_28) * _CircleColorTex_ST.xy) + _CircleColorTex_ST.zw);
      lowp vec4 tmpvar_36;
      tmpvar_36 = texture2D (_CircleColorTex, tmpvar_35);
      circleColor_34 = tmpvar_36;
      highp float tmpvar_37;
      tmpvar_37 = abs((tmpvar_32 - tmpvar_29));
      outColor_27 = (((circleColor_34 * 
        (1.5 - tmpvar_37)
      ) * (1.0 - tmpvar_28)) * (1.0 - tmpvar_28));
    };
    prevCircleColor_2 = outColor_27;
  };
  col_7 = (col_7 + ((
    (curCircleColor_3 + prevCircleColor_2)
   - 
    (curCircleColor_3 * prevCircleColor_2)
  ) * mainTexColor_8.w));
  mediump vec3 tmpvar_38;
  tmpvar_38 = (V_4 - (2.0 * (
    dot (N_6, V_4)
   * N_6)));
  mediump float tmpvar_39;
  tmpvar_39 = abs(dot (N_6, V_4));
  highp float tmpvar_40;
  highp float cs_41;
  cs_41 = tmpvar_39;
  highp float power_42;
  power_42 = _ReflectFresnel.x;
  highp float scale_43;
  scale_43 = _ReflectFresnel.y;
  highp float bias_44;
  bias_44 = _ReflectFresnel.z;
  tmpvar_40 = (bias_44 + (pow (
    clamp ((1.0 - cs_41), 0.0, 1.0)
  , power_42) * scale_43));
  f_1 = tmpvar_40;
  lowp vec4 tmpvar_45;
  tmpvar_45 = textureCube (_EnvTex, tmpvar_38);
  col_7.xyz = (col_7.xyz + ((tmpvar_45.xyz * mainTexColor_8.w) * (f_1 * _Reflectivity)));
  col_7.xyz = mix (col_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_7.w = _BloomFactor;
  col_7.xyz = mix (col_7.xyz, vec3(dot (col_7.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = col_7;
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