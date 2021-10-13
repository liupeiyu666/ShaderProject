//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_DLC/BackgroundSSDFloor_Fan" {
Properties {
_MainTex ("Decal Texture", 2D) = "white" { }
_TintColor ("TintColor", Color) = (1,1,1,1)
_EmissionScaler ("Emission Scaler", Range(0, 50)) = 1
[Enum(RGB,0,R,1,G,2,B,3,A,4,WhiteColor,5)] _BaseTexColorChannelToggle ("BaseTexColorChannelToggle", Float) = 0
[Enum(R,0,G,1,B,2,A,3)] _BaseTexAlphaChannelToggle ("BaseTexAlphaChannelToggle", Float) = 3
_MaskTexture ("MaskTexture", 2D) = "white" { }
[Enum(R,0,G,1,B,2,A,3)] _MaskTexChannelToggle ("MaskTexChannelToggle", Float) = 0
_DetailColor ("DetailColor", Color) = (0,0,0,0)
_DetailTex ("DetailTex", 2D) = "white" { }
[Enum(R,0,G,1,B,2,A,3)] _DetailTexColorChannelToggle ("DetailTexColorChannelToggle", Float) = 0
[Enum(R,0,G,1,B,2,A,3)] _DetailTexAlphaChannelToggle ("DetailTexAlpgaChannelToggle", Float) = 3
_DetailTex_Uspeed ("DetailTex_Uspeed", Float) = 0
_DetailTex_Vspeed ("DetailTex_Vspeed", Float) = 0
_clip ("Clip", Vector) = (0,1,0,0)
_FanAngle ("Fan Angle", Range(0.1, 6.28318)) = 1.57
_BorderAngle ("Border Triangle Angle", Range(0, 0.3)) = 0
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+3" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+3" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 53364
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp float _FanAngle;
uniform highp float _BorderAngle;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _clip;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float xsign_2;
  highp vec2 tmpvar_3;
  highp vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_3 = vec2(0.0, 0.0);
  tmpvar_4 = vec3(0.0, 0.0, 0.0);
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp float tmpvar_6;
  tmpvar_6 = abs(_glesVertex.x);
  highp float tmpvar_7;
  tmpvar_7 = (_glesVertex.x / tmpvar_6);
  xsign_2 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = sqrt(dot (_glesVertex.xz, _glesVertex.xz));
  highp float tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = (min (abs(
    (tmpvar_6 / _glesVertex.z)
  ), 1.0) / max (abs(
    (tmpvar_6 / _glesVertex.z)
  ), 1.0));
  highp float tmpvar_11;
  tmpvar_11 = (tmpvar_10 * tmpvar_10);
  tmpvar_11 = (((
    ((((
      ((((-0.01213232 * tmpvar_11) + 0.05368138) * tmpvar_11) - 0.1173503)
     * tmpvar_11) + 0.1938925) * tmpvar_11) - 0.3326756)
   * tmpvar_11) + 0.9999793) * tmpvar_10);
  tmpvar_11 = (tmpvar_11 + (float(
    (abs((tmpvar_6 / _glesVertex.z)) > 1.0)
  ) * (
    (tmpvar_11 * -2.0)
   + 1.570796)));
  tmpvar_9 = (tmpvar_11 * sign((tmpvar_6 / _glesVertex.z)));
  if ((abs(_glesVertex.z) > (1e-08 * abs(tmpvar_6)))) {
    if ((_glesVertex.z < 0.0)) {
      if ((tmpvar_6 >= 0.0)) {
        tmpvar_9 += 3.141593;
      } else {
        tmpvar_9 = (tmpvar_9 - 3.141593);
      };
    };
  } else {
    tmpvar_9 = (sign(tmpvar_6) * 1.570796);
  };
  highp float tmpvar_12;
  tmpvar_12 = (3.14159 - _BorderAngle);
  highp float tmpvar_13;
  tmpvar_13 = ((_FanAngle * 0.5) - _BorderAngle);
  highp float tmpvar_14;
  if ((tmpvar_9 < tmpvar_12)) {
    tmpvar_14 = ((tmpvar_13 * tmpvar_9) / tmpvar_12);
  } else {
    tmpvar_14 = ((tmpvar_13 + tmpvar_9) - tmpvar_12);
  };
  tmpvar_1.x = ((xsign_2 * sin(tmpvar_14)) * tmpvar_8);
  tmpvar_1.z = (cos(tmpvar_14) * tmpvar_8);
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_1.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_15.zw;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_1.xyz;
  tmpvar_4 = ((unity_MatrixV * (unity_ObjectToWorld * tmpvar_20)).xyz * vec3(-1.0, -1.0, 1.0));
  highp mat3 tmpvar_21;
  tmpvar_21[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_21[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_21[2] = unity_ObjectToWorld[2].xyz;
  tmpvar_5 = (tmpvar_21 * _clip.xyz);
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD4 = 0.0;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD1 = o_17;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraToWorld;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform mediump vec4 _TintColor;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform highp vec4 _MainTex_ST;
uniform mediump float _DepthScaleValue;
uniform sampler2D _CustomDepthNormalsTexture;
uniform mediump float _BaseTexColorChannelToggle;
uniform mediump float _BaseTexAlphaChannelToggle;
uniform mediump float _MaskTexChannelToggle;
uniform sampler2D _MaskTexture;
uniform highp vec4 _MaskTexture_ST;
uniform mediump vec4 _DetailColor;
uniform mediump float _DetailTexColorChannelToggle;
uniform mediump float _DetailTexAlphaChannelToggle;
uniform sampler2D _DetailTex;
uniform mediump float _DetailTex_Uspeed;
uniform highp vec4 _DetailTex_ST;
uniform mediump float _DetailTex_Vspeed;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_1.x = unity_MatrixMV[0].x;
  tmpvar_1.y = unity_MatrixMV[1].x;
  tmpvar_1.z = unity_MatrixMV[2].x;
  tmpvar_1.w = unity_MatrixMV[3].x;
  tmpvar_2.x = unity_MatrixMV[0].y;
  tmpvar_2.y = unity_MatrixMV[1].y;
  tmpvar_2.z = unity_MatrixMV[2].y;
  tmpvar_2.w = unity_MatrixMV[3].y;
  tmpvar_3.x = unity_MatrixMV[0].z;
  tmpvar_3.y = unity_MatrixMV[1].z;
  tmpvar_3.z = unity_MatrixMV[2].z;
  tmpvar_3.w = unity_MatrixMV[3].z;
  mediump vec4 tmpvar_4;
  highp vec4 col_5;
  mediump float detailAlphaValue_6;
  mediump float detailValue_7;
  mediump vec4 detailTex_8;
  mediump float detailVSpeed_9;
  mediump vec2 uv_DetailTex_10;
  mediump float detailUSpeed_11;
  mediump float maskValue_12;
  mediump vec4 Masktex_13;
  mediump vec2 uv_MaskTexture_14;
  mediump float finalAlpha_15;
  mediump vec3 finalColor_16;
  mediump vec3 temp_cast_3_17;
  mediump vec3 temp_cast_2_18;
  mediump vec3 temp_cast_1_19;
  mediump vec3 temp_cast_0_20;
  mediump vec3 wnormal_21;
  highp vec4 tex_22;
  mediump vec2 uv_MainTex_23;
  highp vec4 encode_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (xlv_TEXCOORD1.xy / xlv_TEXCOORD1.w);
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_CustomDepthNormalsTexture, tmpvar_25);
  encode_24 = tmpvar_26;
  highp vec3 n_27;
  highp vec3 tmpvar_28;
  tmpvar_28 = ((encode_24.xyz * vec3(3.5554, 3.5554, 0.0)) + vec3(-1.7777, -1.7777, 1.0));
  highp float tmpvar_29;
  tmpvar_29 = (2.0 / dot (tmpvar_28, tmpvar_28));
  n_27.xy = (tmpvar_29 * tmpvar_28.xy);
  n_27.z = (tmpvar_29 - 1.0);
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = ((xlv_TEXCOORD2 * (_ProjectionParams.z / xlv_TEXCOORD2.z)) * (dot (encode_24.zw, vec2(1.0, 0.003921569)) * _DepthScaleValue));
  highp vec4 tmpvar_31;
  tmpvar_31.w = 1.0;
  tmpvar_31.xyz = (unity_CameraToWorld * tmpvar_30).xyz;
  highp vec3 tmpvar_32;
  tmpvar_32 = (unity_WorldToObject * tmpvar_31).xyz;
  highp vec3 x_33;
  x_33 = (vec3(0.5, 0.5, 0.5) - abs(tmpvar_32));
  bvec3 tmpvar_34;
  tmpvar_34 = lessThan (x_33, vec3(0.0, 0.0, 0.0));
  if (any(tmpvar_34)) {
    discard;
  };
  highp mat3 tmpvar_35;
  tmpvar_35[0] = tmpvar_1.xyz;
  tmpvar_35[1] = tmpvar_2.xyz;
  tmpvar_35[2] = tmpvar_3.xyz;
  highp vec2 tmpvar_36;
  tmpvar_36 = (tmpvar_32.xz + vec2(0.5, 0.5));
  highp vec2 tmpvar_37;
  tmpvar_37 = ((tmpvar_36 * _MainTex_ST.xy) + _MainTex_ST.zw);
  uv_MainTex_23 = tmpvar_37;
  lowp vec4 tmpvar_38;
  tmpvar_38 = texture2D (_MainTex, uv_MainTex_23);
  tex_22 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = ((normalize(
    (tmpvar_35 * normalize(n_27))
  ) * 2.0) - 1.0);
  wnormal_21 = tmpvar_39;
  mediump float x_40;
  x_40 = (dot (wnormal_21, xlv_TEXCOORD3) - 1.0);
  if ((x_40 < 0.0)) {
    discard;
  };
  highp vec3 tmpvar_41;
  tmpvar_41 = tex_22.xxx;
  temp_cast_0_20 = tmpvar_41;
  highp vec3 tmpvar_42;
  tmpvar_42 = tex_22.yyy;
  temp_cast_1_19 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = tex_22.zzz;
  temp_cast_2_18 = tmpvar_43;
  highp vec3 tmpvar_44;
  tmpvar_44 = tex_22.www;
  temp_cast_3_17 = tmpvar_44;
  finalColor_16 = vec3(0.0, 0.0, 0.0);
  if ((_BaseTexColorChannelToggle == 0.0)) {
    finalColor_16 = tex_22.xyz;
  } else {
    if ((_BaseTexColorChannelToggle == 1.0)) {
      finalColor_16 = temp_cast_0_20;
    } else {
      if ((_BaseTexColorChannelToggle == 2.0)) {
        finalColor_16 = temp_cast_1_19;
      } else {
        if ((_BaseTexColorChannelToggle == 3.0)) {
          finalColor_16 = temp_cast_2_18;
        } else {
          if ((_BaseTexColorChannelToggle == 4.0)) {
            finalColor_16 = temp_cast_3_17;
          } else {
            if ((_BaseTexColorChannelToggle == 5.0)) {
              finalColor_16 = vec3(1.0, 1.0, 1.0);
            };
          };
        };
      };
    };
  };
  finalAlpha_15 = 0.0;
  if ((_BaseTexAlphaChannelToggle == 0.0)) {
    finalAlpha_15 = tex_22.x;
  } else {
    if ((_BaseTexAlphaChannelToggle == 1.0)) {
      finalAlpha_15 = tex_22.y;
    } else {
      if ((_BaseTexAlphaChannelToggle == 2.0)) {
        finalAlpha_15 = tex_22.z;
      } else {
        if ((_BaseTexAlphaChannelToggle == 3.0)) {
          finalAlpha_15 = tex_22.w;
        };
      };
    };
  };
  highp vec2 tmpvar_45;
  tmpvar_45 = ((tmpvar_36 * _MaskTexture_ST.xy) + _MaskTexture_ST.zw);
  uv_MaskTexture_14 = tmpvar_45;
  lowp vec4 tmpvar_46;
  tmpvar_46 = texture2D (_MaskTexture, uv_MaskTexture_14);
  Masktex_13 = tmpvar_46;
  maskValue_12 = 0.0;
  if ((_MaskTexChannelToggle == 0.0)) {
    maskValue_12 = Masktex_13.x;
  } else {
    if ((_MaskTexChannelToggle == 1.0)) {
      maskValue_12 = Masktex_13.y;
    } else {
      if ((_MaskTexChannelToggle == 2.0)) {
        maskValue_12 = Masktex_13.z;
      } else {
        if ((_MaskTexChannelToggle == 3.0)) {
          maskValue_12 = Masktex_13.w;
        };
      };
    };
  };
  highp float tmpvar_47;
  tmpvar_47 = (_Time.y * _DetailTex_Uspeed);
  detailUSpeed_11 = tmpvar_47;
  highp vec2 tmpvar_48;
  tmpvar_48 = ((tmpvar_36 * _DetailTex_ST.xy) + _DetailTex_ST.zw);
  uv_DetailTex_10 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = (_Time.y * _DetailTex_Vspeed);
  detailVSpeed_9 = tmpvar_49;
  mediump vec2 tmpvar_50;
  tmpvar_50.x = (detailUSpeed_11 + uv_DetailTex_10.x);
  tmpvar_50.y = (uv_DetailTex_10.y + detailVSpeed_9);
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2D (_DetailTex, tmpvar_50);
  detailTex_8 = tmpvar_51;
  detailValue_7 = 0.0;
  if ((_DetailTexColorChannelToggle == 0.0)) {
    detailValue_7 = detailTex_8.x;
  } else {
    if ((_DetailTexColorChannelToggle == 1.0)) {
      detailValue_7 = detailTex_8.y;
    } else {
      if ((_DetailTexColorChannelToggle == 2.0)) {
        detailValue_7 = detailTex_8.z;
      } else {
        if ((_DetailTexColorChannelToggle == 3.0)) {
          detailValue_7 = detailTex_8.w;
        };
      };
    };
  };
  detailAlphaValue_6 = 0.0;
  if ((_DetailTexAlphaChannelToggle == 0.0)) {
    detailAlphaValue_6 = detailTex_8.x;
  } else {
    if ((_DetailTexAlphaChannelToggle == 1.0)) {
      detailAlphaValue_6 = detailTex_8.y;
    } else {
      if ((_DetailTexAlphaChannelToggle == 2.0)) {
        detailAlphaValue_6 = detailTex_8.z;
      } else {
        if ((_DetailTexAlphaChannelToggle == 3.0)) {
          detailAlphaValue_6 = detailTex_8.w;
        };
      };
    };
  };
  mediump vec4 tmpvar_52;
  tmpvar_52.xyz = (((finalColor_16 * _TintColor.xyz) + (_DetailColor * detailValue_7).xyz) * _EmissionScaler);
  tmpvar_52.w = ((finalAlpha_15 * _TintColor.w) * (maskValue_12 * detailAlphaValue_6));
  col_5 = tmpvar_52;
  col_5.w = clamp (col_5.w, 0.0, 1.0);
  tmpvar_4 = col_5;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp float _FanAngle;
uniform highp float _BorderAngle;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _clip;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float xsign_2;
  highp vec2 tmpvar_3;
  highp vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_3 = vec2(0.0, 0.0);
  tmpvar_4 = vec3(0.0, 0.0, 0.0);
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp float tmpvar_6;
  tmpvar_6 = abs(_glesVertex.x);
  highp float tmpvar_7;
  tmpvar_7 = (_glesVertex.x / tmpvar_6);
  xsign_2 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = sqrt(dot (_glesVertex.xz, _glesVertex.xz));
  highp float tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = (min (abs(
    (tmpvar_6 / _glesVertex.z)
  ), 1.0) / max (abs(
    (tmpvar_6 / _glesVertex.z)
  ), 1.0));
  highp float tmpvar_11;
  tmpvar_11 = (tmpvar_10 * tmpvar_10);
  tmpvar_11 = (((
    ((((
      ((((-0.01213232 * tmpvar_11) + 0.05368138) * tmpvar_11) - 0.1173503)
     * tmpvar_11) + 0.1938925) * tmpvar_11) - 0.3326756)
   * tmpvar_11) + 0.9999793) * tmpvar_10);
  tmpvar_11 = (tmpvar_11 + (float(
    (abs((tmpvar_6 / _glesVertex.z)) > 1.0)
  ) * (
    (tmpvar_11 * -2.0)
   + 1.570796)));
  tmpvar_9 = (tmpvar_11 * sign((tmpvar_6 / _glesVertex.z)));
  if ((abs(_glesVertex.z) > (1e-08 * abs(tmpvar_6)))) {
    if ((_glesVertex.z < 0.0)) {
      if ((tmpvar_6 >= 0.0)) {
        tmpvar_9 += 3.141593;
      } else {
        tmpvar_9 = (tmpvar_9 - 3.141593);
      };
    };
  } else {
    tmpvar_9 = (sign(tmpvar_6) * 1.570796);
  };
  highp float tmpvar_12;
  tmpvar_12 = (3.14159 - _BorderAngle);
  highp float tmpvar_13;
  tmpvar_13 = ((_FanAngle * 0.5) - _BorderAngle);
  highp float tmpvar_14;
  if ((tmpvar_9 < tmpvar_12)) {
    tmpvar_14 = ((tmpvar_13 * tmpvar_9) / tmpvar_12);
  } else {
    tmpvar_14 = ((tmpvar_13 + tmpvar_9) - tmpvar_12);
  };
  tmpvar_1.x = ((xsign_2 * sin(tmpvar_14)) * tmpvar_8);
  tmpvar_1.z = (cos(tmpvar_14) * tmpvar_8);
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_1.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_15.zw;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_1.xyz;
  tmpvar_4 = ((unity_MatrixV * (unity_ObjectToWorld * tmpvar_20)).xyz * vec3(-1.0, -1.0, 1.0));
  highp mat3 tmpvar_21;
  tmpvar_21[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_21[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_21[2] = unity_ObjectToWorld[2].xyz;
  tmpvar_5 = (tmpvar_21 * _clip.xyz);
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD4 = 0.0;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD1 = o_17;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraToWorld;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform mediump vec4 _TintColor;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform highp vec4 _MainTex_ST;
uniform mediump float _DepthScaleValue;
uniform sampler2D _CustomDepthNormalsTexture;
uniform mediump float _BaseTexColorChannelToggle;
uniform mediump float _BaseTexAlphaChannelToggle;
uniform mediump float _MaskTexChannelToggle;
uniform sampler2D _MaskTexture;
uniform highp vec4 _MaskTexture_ST;
uniform mediump vec4 _DetailColor;
uniform mediump float _DetailTexColorChannelToggle;
uniform mediump float _DetailTexAlphaChannelToggle;
uniform sampler2D _DetailTex;
uniform mediump float _DetailTex_Uspeed;
uniform highp vec4 _DetailTex_ST;
uniform mediump float _DetailTex_Vspeed;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_1.x = unity_MatrixMV[0].x;
  tmpvar_1.y = unity_MatrixMV[1].x;
  tmpvar_1.z = unity_MatrixMV[2].x;
  tmpvar_1.w = unity_MatrixMV[3].x;
  tmpvar_2.x = unity_MatrixMV[0].y;
  tmpvar_2.y = unity_MatrixMV[1].y;
  tmpvar_2.z = unity_MatrixMV[2].y;
  tmpvar_2.w = unity_MatrixMV[3].y;
  tmpvar_3.x = unity_MatrixMV[0].z;
  tmpvar_3.y = unity_MatrixMV[1].z;
  tmpvar_3.z = unity_MatrixMV[2].z;
  tmpvar_3.w = unity_MatrixMV[3].z;
  mediump vec4 tmpvar_4;
  highp vec4 col_5;
  mediump float detailAlphaValue_6;
  mediump float detailValue_7;
  mediump vec4 detailTex_8;
  mediump float detailVSpeed_9;
  mediump vec2 uv_DetailTex_10;
  mediump float detailUSpeed_11;
  mediump float maskValue_12;
  mediump vec4 Masktex_13;
  mediump vec2 uv_MaskTexture_14;
  mediump float finalAlpha_15;
  mediump vec3 finalColor_16;
  mediump vec3 temp_cast_3_17;
  mediump vec3 temp_cast_2_18;
  mediump vec3 temp_cast_1_19;
  mediump vec3 temp_cast_0_20;
  mediump vec3 wnormal_21;
  highp vec4 tex_22;
  mediump vec2 uv_MainTex_23;
  highp vec4 encode_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (xlv_TEXCOORD1.xy / xlv_TEXCOORD1.w);
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_CustomDepthNormalsTexture, tmpvar_25);
  encode_24 = tmpvar_26;
  highp vec3 n_27;
  highp vec3 tmpvar_28;
  tmpvar_28 = ((encode_24.xyz * vec3(3.5554, 3.5554, 0.0)) + vec3(-1.7777, -1.7777, 1.0));
  highp float tmpvar_29;
  tmpvar_29 = (2.0 / dot (tmpvar_28, tmpvar_28));
  n_27.xy = (tmpvar_29 * tmpvar_28.xy);
  n_27.z = (tmpvar_29 - 1.0);
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = ((xlv_TEXCOORD2 * (_ProjectionParams.z / xlv_TEXCOORD2.z)) * (dot (encode_24.zw, vec2(1.0, 0.003921569)) * _DepthScaleValue));
  highp vec4 tmpvar_31;
  tmpvar_31.w = 1.0;
  tmpvar_31.xyz = (unity_CameraToWorld * tmpvar_30).xyz;
  highp vec3 tmpvar_32;
  tmpvar_32 = (unity_WorldToObject * tmpvar_31).xyz;
  highp vec3 x_33;
  x_33 = (vec3(0.5, 0.5, 0.5) - abs(tmpvar_32));
  bvec3 tmpvar_34;
  tmpvar_34 = lessThan (x_33, vec3(0.0, 0.0, 0.0));
  if (any(tmpvar_34)) {
    discard;
  };
  highp mat3 tmpvar_35;
  tmpvar_35[0] = tmpvar_1.xyz;
  tmpvar_35[1] = tmpvar_2.xyz;
  tmpvar_35[2] = tmpvar_3.xyz;
  highp vec2 tmpvar_36;
  tmpvar_36 = (tmpvar_32.xz + vec2(0.5, 0.5));
  highp vec2 tmpvar_37;
  tmpvar_37 = ((tmpvar_36 * _MainTex_ST.xy) + _MainTex_ST.zw);
  uv_MainTex_23 = tmpvar_37;
  lowp vec4 tmpvar_38;
  tmpvar_38 = texture2D (_MainTex, uv_MainTex_23);
  tex_22 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = ((normalize(
    (tmpvar_35 * normalize(n_27))
  ) * 2.0) - 1.0);
  wnormal_21 = tmpvar_39;
  mediump float x_40;
  x_40 = (dot (wnormal_21, xlv_TEXCOORD3) - 1.0);
  if ((x_40 < 0.0)) {
    discard;
  };
  highp vec3 tmpvar_41;
  tmpvar_41 = tex_22.xxx;
  temp_cast_0_20 = tmpvar_41;
  highp vec3 tmpvar_42;
  tmpvar_42 = tex_22.yyy;
  temp_cast_1_19 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = tex_22.zzz;
  temp_cast_2_18 = tmpvar_43;
  highp vec3 tmpvar_44;
  tmpvar_44 = tex_22.www;
  temp_cast_3_17 = tmpvar_44;
  finalColor_16 = vec3(0.0, 0.0, 0.0);
  if ((_BaseTexColorChannelToggle == 0.0)) {
    finalColor_16 = tex_22.xyz;
  } else {
    if ((_BaseTexColorChannelToggle == 1.0)) {
      finalColor_16 = temp_cast_0_20;
    } else {
      if ((_BaseTexColorChannelToggle == 2.0)) {
        finalColor_16 = temp_cast_1_19;
      } else {
        if ((_BaseTexColorChannelToggle == 3.0)) {
          finalColor_16 = temp_cast_2_18;
        } else {
          if ((_BaseTexColorChannelToggle == 4.0)) {
            finalColor_16 = temp_cast_3_17;
          } else {
            if ((_BaseTexColorChannelToggle == 5.0)) {
              finalColor_16 = vec3(1.0, 1.0, 1.0);
            };
          };
        };
      };
    };
  };
  finalAlpha_15 = 0.0;
  if ((_BaseTexAlphaChannelToggle == 0.0)) {
    finalAlpha_15 = tex_22.x;
  } else {
    if ((_BaseTexAlphaChannelToggle == 1.0)) {
      finalAlpha_15 = tex_22.y;
    } else {
      if ((_BaseTexAlphaChannelToggle == 2.0)) {
        finalAlpha_15 = tex_22.z;
      } else {
        if ((_BaseTexAlphaChannelToggle == 3.0)) {
          finalAlpha_15 = tex_22.w;
        };
      };
    };
  };
  highp vec2 tmpvar_45;
  tmpvar_45 = ((tmpvar_36 * _MaskTexture_ST.xy) + _MaskTexture_ST.zw);
  uv_MaskTexture_14 = tmpvar_45;
  lowp vec4 tmpvar_46;
  tmpvar_46 = texture2D (_MaskTexture, uv_MaskTexture_14);
  Masktex_13 = tmpvar_46;
  maskValue_12 = 0.0;
  if ((_MaskTexChannelToggle == 0.0)) {
    maskValue_12 = Masktex_13.x;
  } else {
    if ((_MaskTexChannelToggle == 1.0)) {
      maskValue_12 = Masktex_13.y;
    } else {
      if ((_MaskTexChannelToggle == 2.0)) {
        maskValue_12 = Masktex_13.z;
      } else {
        if ((_MaskTexChannelToggle == 3.0)) {
          maskValue_12 = Masktex_13.w;
        };
      };
    };
  };
  highp float tmpvar_47;
  tmpvar_47 = (_Time.y * _DetailTex_Uspeed);
  detailUSpeed_11 = tmpvar_47;
  highp vec2 tmpvar_48;
  tmpvar_48 = ((tmpvar_36 * _DetailTex_ST.xy) + _DetailTex_ST.zw);
  uv_DetailTex_10 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = (_Time.y * _DetailTex_Vspeed);
  detailVSpeed_9 = tmpvar_49;
  mediump vec2 tmpvar_50;
  tmpvar_50.x = (detailUSpeed_11 + uv_DetailTex_10.x);
  tmpvar_50.y = (uv_DetailTex_10.y + detailVSpeed_9);
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2D (_DetailTex, tmpvar_50);
  detailTex_8 = tmpvar_51;
  detailValue_7 = 0.0;
  if ((_DetailTexColorChannelToggle == 0.0)) {
    detailValue_7 = detailTex_8.x;
  } else {
    if ((_DetailTexColorChannelToggle == 1.0)) {
      detailValue_7 = detailTex_8.y;
    } else {
      if ((_DetailTexColorChannelToggle == 2.0)) {
        detailValue_7 = detailTex_8.z;
      } else {
        if ((_DetailTexColorChannelToggle == 3.0)) {
          detailValue_7 = detailTex_8.w;
        };
      };
    };
  };
  detailAlphaValue_6 = 0.0;
  if ((_DetailTexAlphaChannelToggle == 0.0)) {
    detailAlphaValue_6 = detailTex_8.x;
  } else {
    if ((_DetailTexAlphaChannelToggle == 1.0)) {
      detailAlphaValue_6 = detailTex_8.y;
    } else {
      if ((_DetailTexAlphaChannelToggle == 2.0)) {
        detailAlphaValue_6 = detailTex_8.z;
      } else {
        if ((_DetailTexAlphaChannelToggle == 3.0)) {
          detailAlphaValue_6 = detailTex_8.w;
        };
      };
    };
  };
  mediump vec4 tmpvar_52;
  tmpvar_52.xyz = (((finalColor_16 * _TintColor.xyz) + (_DetailColor * detailValue_7).xyz) * _EmissionScaler);
  tmpvar_52.w = ((finalAlpha_15 * _TintColor.w) * (maskValue_12 * detailAlphaValue_6));
  col_5 = tmpvar_52;
  col_5.w = clamp (col_5.w, 0.0, 1.0);
  tmpvar_4 = col_5;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp float _FanAngle;
uniform highp float _BorderAngle;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _clip;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float xsign_2;
  highp vec2 tmpvar_3;
  highp vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_3 = vec2(0.0, 0.0);
  tmpvar_4 = vec3(0.0, 0.0, 0.0);
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp float tmpvar_6;
  tmpvar_6 = abs(_glesVertex.x);
  highp float tmpvar_7;
  tmpvar_7 = (_glesVertex.x / tmpvar_6);
  xsign_2 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = sqrt(dot (_glesVertex.xz, _glesVertex.xz));
  highp float tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = (min (abs(
    (tmpvar_6 / _glesVertex.z)
  ), 1.0) / max (abs(
    (tmpvar_6 / _glesVertex.z)
  ), 1.0));
  highp float tmpvar_11;
  tmpvar_11 = (tmpvar_10 * tmpvar_10);
  tmpvar_11 = (((
    ((((
      ((((-0.01213232 * tmpvar_11) + 0.05368138) * tmpvar_11) - 0.1173503)
     * tmpvar_11) + 0.1938925) * tmpvar_11) - 0.3326756)
   * tmpvar_11) + 0.9999793) * tmpvar_10);
  tmpvar_11 = (tmpvar_11 + (float(
    (abs((tmpvar_6 / _glesVertex.z)) > 1.0)
  ) * (
    (tmpvar_11 * -2.0)
   + 1.570796)));
  tmpvar_9 = (tmpvar_11 * sign((tmpvar_6 / _glesVertex.z)));
  if ((abs(_glesVertex.z) > (1e-08 * abs(tmpvar_6)))) {
    if ((_glesVertex.z < 0.0)) {
      if ((tmpvar_6 >= 0.0)) {
        tmpvar_9 += 3.141593;
      } else {
        tmpvar_9 = (tmpvar_9 - 3.141593);
      };
    };
  } else {
    tmpvar_9 = (sign(tmpvar_6) * 1.570796);
  };
  highp float tmpvar_12;
  tmpvar_12 = (3.14159 - _BorderAngle);
  highp float tmpvar_13;
  tmpvar_13 = ((_FanAngle * 0.5) - _BorderAngle);
  highp float tmpvar_14;
  if ((tmpvar_9 < tmpvar_12)) {
    tmpvar_14 = ((tmpvar_13 * tmpvar_9) / tmpvar_12);
  } else {
    tmpvar_14 = ((tmpvar_13 + tmpvar_9) - tmpvar_12);
  };
  tmpvar_1.x = ((xsign_2 * sin(tmpvar_14)) * tmpvar_8);
  tmpvar_1.z = (cos(tmpvar_14) * tmpvar_8);
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_1.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_15.zw;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_1.xyz;
  tmpvar_4 = ((unity_MatrixV * (unity_ObjectToWorld * tmpvar_20)).xyz * vec3(-1.0, -1.0, 1.0));
  highp mat3 tmpvar_21;
  tmpvar_21[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_21[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_21[2] = unity_ObjectToWorld[2].xyz;
  tmpvar_5 = (tmpvar_21 * _clip.xyz);
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD4 = 0.0;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD1 = o_17;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraToWorld;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform mediump vec4 _TintColor;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform highp vec4 _MainTex_ST;
uniform mediump float _DepthScaleValue;
uniform sampler2D _CustomDepthNormalsTexture;
uniform mediump float _BaseTexColorChannelToggle;
uniform mediump float _BaseTexAlphaChannelToggle;
uniform mediump float _MaskTexChannelToggle;
uniform sampler2D _MaskTexture;
uniform highp vec4 _MaskTexture_ST;
uniform mediump vec4 _DetailColor;
uniform mediump float _DetailTexColorChannelToggle;
uniform mediump float _DetailTexAlphaChannelToggle;
uniform sampler2D _DetailTex;
uniform mediump float _DetailTex_Uspeed;
uniform highp vec4 _DetailTex_ST;
uniform mediump float _DetailTex_Vspeed;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_1.x = unity_MatrixMV[0].x;
  tmpvar_1.y = unity_MatrixMV[1].x;
  tmpvar_1.z = unity_MatrixMV[2].x;
  tmpvar_1.w = unity_MatrixMV[3].x;
  tmpvar_2.x = unity_MatrixMV[0].y;
  tmpvar_2.y = unity_MatrixMV[1].y;
  tmpvar_2.z = unity_MatrixMV[2].y;
  tmpvar_2.w = unity_MatrixMV[3].y;
  tmpvar_3.x = unity_MatrixMV[0].z;
  tmpvar_3.y = unity_MatrixMV[1].z;
  tmpvar_3.z = unity_MatrixMV[2].z;
  tmpvar_3.w = unity_MatrixMV[3].z;
  mediump vec4 tmpvar_4;
  highp vec4 col_5;
  mediump float detailAlphaValue_6;
  mediump float detailValue_7;
  mediump vec4 detailTex_8;
  mediump float detailVSpeed_9;
  mediump vec2 uv_DetailTex_10;
  mediump float detailUSpeed_11;
  mediump float maskValue_12;
  mediump vec4 Masktex_13;
  mediump vec2 uv_MaskTexture_14;
  mediump float finalAlpha_15;
  mediump vec3 finalColor_16;
  mediump vec3 temp_cast_3_17;
  mediump vec3 temp_cast_2_18;
  mediump vec3 temp_cast_1_19;
  mediump vec3 temp_cast_0_20;
  mediump vec3 wnormal_21;
  highp vec4 tex_22;
  mediump vec2 uv_MainTex_23;
  highp vec4 encode_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (xlv_TEXCOORD1.xy / xlv_TEXCOORD1.w);
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_CustomDepthNormalsTexture, tmpvar_25);
  encode_24 = tmpvar_26;
  highp vec3 n_27;
  highp vec3 tmpvar_28;
  tmpvar_28 = ((encode_24.xyz * vec3(3.5554, 3.5554, 0.0)) + vec3(-1.7777, -1.7777, 1.0));
  highp float tmpvar_29;
  tmpvar_29 = (2.0 / dot (tmpvar_28, tmpvar_28));
  n_27.xy = (tmpvar_29 * tmpvar_28.xy);
  n_27.z = (tmpvar_29 - 1.0);
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = ((xlv_TEXCOORD2 * (_ProjectionParams.z / xlv_TEXCOORD2.z)) * (dot (encode_24.zw, vec2(1.0, 0.003921569)) * _DepthScaleValue));
  highp vec4 tmpvar_31;
  tmpvar_31.w = 1.0;
  tmpvar_31.xyz = (unity_CameraToWorld * tmpvar_30).xyz;
  highp vec3 tmpvar_32;
  tmpvar_32 = (unity_WorldToObject * tmpvar_31).xyz;
  highp vec3 x_33;
  x_33 = (vec3(0.5, 0.5, 0.5) - abs(tmpvar_32));
  bvec3 tmpvar_34;
  tmpvar_34 = lessThan (x_33, vec3(0.0, 0.0, 0.0));
  if (any(tmpvar_34)) {
    discard;
  };
  highp mat3 tmpvar_35;
  tmpvar_35[0] = tmpvar_1.xyz;
  tmpvar_35[1] = tmpvar_2.xyz;
  tmpvar_35[2] = tmpvar_3.xyz;
  highp vec2 tmpvar_36;
  tmpvar_36 = (tmpvar_32.xz + vec2(0.5, 0.5));
  highp vec2 tmpvar_37;
  tmpvar_37 = ((tmpvar_36 * _MainTex_ST.xy) + _MainTex_ST.zw);
  uv_MainTex_23 = tmpvar_37;
  lowp vec4 tmpvar_38;
  tmpvar_38 = texture2D (_MainTex, uv_MainTex_23);
  tex_22 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = ((normalize(
    (tmpvar_35 * normalize(n_27))
  ) * 2.0) - 1.0);
  wnormal_21 = tmpvar_39;
  mediump float x_40;
  x_40 = (dot (wnormal_21, xlv_TEXCOORD3) - 1.0);
  if ((x_40 < 0.0)) {
    discard;
  };
  highp vec3 tmpvar_41;
  tmpvar_41 = tex_22.xxx;
  temp_cast_0_20 = tmpvar_41;
  highp vec3 tmpvar_42;
  tmpvar_42 = tex_22.yyy;
  temp_cast_1_19 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = tex_22.zzz;
  temp_cast_2_18 = tmpvar_43;
  highp vec3 tmpvar_44;
  tmpvar_44 = tex_22.www;
  temp_cast_3_17 = tmpvar_44;
  finalColor_16 = vec3(0.0, 0.0, 0.0);
  if ((_BaseTexColorChannelToggle == 0.0)) {
    finalColor_16 = tex_22.xyz;
  } else {
    if ((_BaseTexColorChannelToggle == 1.0)) {
      finalColor_16 = temp_cast_0_20;
    } else {
      if ((_BaseTexColorChannelToggle == 2.0)) {
        finalColor_16 = temp_cast_1_19;
      } else {
        if ((_BaseTexColorChannelToggle == 3.0)) {
          finalColor_16 = temp_cast_2_18;
        } else {
          if ((_BaseTexColorChannelToggle == 4.0)) {
            finalColor_16 = temp_cast_3_17;
          } else {
            if ((_BaseTexColorChannelToggle == 5.0)) {
              finalColor_16 = vec3(1.0, 1.0, 1.0);
            };
          };
        };
      };
    };
  };
  finalAlpha_15 = 0.0;
  if ((_BaseTexAlphaChannelToggle == 0.0)) {
    finalAlpha_15 = tex_22.x;
  } else {
    if ((_BaseTexAlphaChannelToggle == 1.0)) {
      finalAlpha_15 = tex_22.y;
    } else {
      if ((_BaseTexAlphaChannelToggle == 2.0)) {
        finalAlpha_15 = tex_22.z;
      } else {
        if ((_BaseTexAlphaChannelToggle == 3.0)) {
          finalAlpha_15 = tex_22.w;
        };
      };
    };
  };
  highp vec2 tmpvar_45;
  tmpvar_45 = ((tmpvar_36 * _MaskTexture_ST.xy) + _MaskTexture_ST.zw);
  uv_MaskTexture_14 = tmpvar_45;
  lowp vec4 tmpvar_46;
  tmpvar_46 = texture2D (_MaskTexture, uv_MaskTexture_14);
  Masktex_13 = tmpvar_46;
  maskValue_12 = 0.0;
  if ((_MaskTexChannelToggle == 0.0)) {
    maskValue_12 = Masktex_13.x;
  } else {
    if ((_MaskTexChannelToggle == 1.0)) {
      maskValue_12 = Masktex_13.y;
    } else {
      if ((_MaskTexChannelToggle == 2.0)) {
        maskValue_12 = Masktex_13.z;
      } else {
        if ((_MaskTexChannelToggle == 3.0)) {
          maskValue_12 = Masktex_13.w;
        };
      };
    };
  };
  highp float tmpvar_47;
  tmpvar_47 = (_Time.y * _DetailTex_Uspeed);
  detailUSpeed_11 = tmpvar_47;
  highp vec2 tmpvar_48;
  tmpvar_48 = ((tmpvar_36 * _DetailTex_ST.xy) + _DetailTex_ST.zw);
  uv_DetailTex_10 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = (_Time.y * _DetailTex_Vspeed);
  detailVSpeed_9 = tmpvar_49;
  mediump vec2 tmpvar_50;
  tmpvar_50.x = (detailUSpeed_11 + uv_DetailTex_10.x);
  tmpvar_50.y = (uv_DetailTex_10.y + detailVSpeed_9);
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2D (_DetailTex, tmpvar_50);
  detailTex_8 = tmpvar_51;
  detailValue_7 = 0.0;
  if ((_DetailTexColorChannelToggle == 0.0)) {
    detailValue_7 = detailTex_8.x;
  } else {
    if ((_DetailTexColorChannelToggle == 1.0)) {
      detailValue_7 = detailTex_8.y;
    } else {
      if ((_DetailTexColorChannelToggle == 2.0)) {
        detailValue_7 = detailTex_8.z;
      } else {
        if ((_DetailTexColorChannelToggle == 3.0)) {
          detailValue_7 = detailTex_8.w;
        };
      };
    };
  };
  detailAlphaValue_6 = 0.0;
  if ((_DetailTexAlphaChannelToggle == 0.0)) {
    detailAlphaValue_6 = detailTex_8.x;
  } else {
    if ((_DetailTexAlphaChannelToggle == 1.0)) {
      detailAlphaValue_6 = detailTex_8.y;
    } else {
      if ((_DetailTexAlphaChannelToggle == 2.0)) {
        detailAlphaValue_6 = detailTex_8.z;
      } else {
        if ((_DetailTexAlphaChannelToggle == 3.0)) {
          detailAlphaValue_6 = detailTex_8.w;
        };
      };
    };
  };
  mediump vec4 tmpvar_52;
  tmpvar_52.xyz = (((finalColor_16 * _TintColor.xyz) + (_DetailColor * detailValue_7).xyz) * _EmissionScaler);
  tmpvar_52.w = ((finalAlpha_15 * _TintColor.w) * (maskValue_12 * detailAlphaValue_6));
  col_5 = tmpvar_52;
  col_5.w = clamp (col_5.w, 0.0, 1.0);
  tmpvar_4 = col_5;
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
  Name "CONSTANT_MAX"
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+3" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 72136
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump float alpha_1;
  lowp float tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  alpha_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (alpha_1 - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_ORIG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump float alpha_1;
  lowp float tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  alpha_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (alpha_1 - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_ORIG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump float alpha_1;
  lowp float tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  alpha_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (alpha_1 - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump float alpha_1;
  lowp float tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  alpha_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (alpha_1 - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump float alpha_1;
  lowp float tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  alpha_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (alpha_1 - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump float alpha_1;
  lowp float tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  alpha_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (alpha_1 - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump float alpha_1;
  lowp float tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  alpha_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (alpha_1 - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump float alpha_1;
  lowp float tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  alpha_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (alpha_1 - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump float alpha_1;
  lowp float tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  alpha_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (alpha_1 - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump float alpha_1;
  lowp float tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  alpha_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (alpha_1 - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump float alpha_1;
  lowp float tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  alpha_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (alpha_1 - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump float alpha_1;
  lowp float tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  alpha_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (alpha_1 - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_ORIG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_ORIG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" }
""
}
}
}
}
Fallback "Diffuse"
CustomEditor "MoleMole.ShaderEditorBase"
}