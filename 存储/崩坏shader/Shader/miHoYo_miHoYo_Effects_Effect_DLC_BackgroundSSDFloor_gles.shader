//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_DLC/BackgroundSSDFloor" {
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
}
SubShader {
 Tags { "QUEUE" = "Geometry+1" }
 Pass {
  Tags { "QUEUE" = "Geometry+1" }
  ZWrite Off
  GpuProgramID 23696
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _clip;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_8[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_8[2] = unity_ObjectToWorld[2].xyz;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD1 = o_4;
  xlv_TEXCOORD2 = ((unity_MatrixV * (unity_ObjectToWorld * tmpvar_7)).xyz * vec3(-1.0, -1.0, 1.0));
  xlv_TEXCOORD3 = (tmpvar_8 * _clip.xyz);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixInvV;
uniform sampler2D _MainTex;
uniform mediump vec4 _MainTex_ST;
uniform highp sampler2D _CustomDepthNormalsTexture;
uniform mediump float _DepthScaleValue;
uniform mediump float _BaseTexColorChannelToggle;
uniform mediump float _BaseTexAlphaChannelToggle;
uniform mediump vec4 _TintColor;
uniform mediump float _EmissionScaler;
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
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
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
  highp vec4 tex_21;
  mediump vec2 uv_MainTex_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_CustomDepthNormalsTexture, (xlv_TEXCOORD1.xy / xlv_TEXCOORD1.w));
  highp vec3 n_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = ((tmpvar_23.xyz * vec3(3.5554, 3.5554, 0.0)) + vec3(-1.7777, -1.7777, 1.0));
  highp float tmpvar_26;
  tmpvar_26 = (2.0 / dot (tmpvar_25, tmpvar_25));
  n_24.xy = (tmpvar_26 * tmpvar_25.xy);
  n_24.z = (tmpvar_26 - 1.0);
  highp vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = ((xlv_TEXCOORD2 * (_ProjectionParams.z / xlv_TEXCOORD2.z)) * (dot (tmpvar_23.zw, vec2(1.0, 0.003921569)) * _DepthScaleValue));
  highp vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = (unity_CameraToWorld * tmpvar_27).xyz;
  highp vec3 tmpvar_29;
  tmpvar_29 = (unity_WorldToObject * tmpvar_28).xyz;
  highp vec3 x_30;
  x_30 = (vec3(0.5, 0.5, 0.5) - abs(tmpvar_29));
  bvec3 tmpvar_31;
  tmpvar_31 = lessThan (x_30, vec3(0.0, 0.0, 0.0));
  if (any(tmpvar_31)) {
    discard;
  };
  highp mat3 tmpvar_32;
  tmpvar_32[0] = tmpvar_2.xyz;
  tmpvar_32[1] = tmpvar_3.xyz;
  tmpvar_32[2] = tmpvar_4.xyz;
  highp mat3 tmpvar_33;
  tmpvar_33[0] = unity_WorldToObject[0].xyz;
  tmpvar_33[1] = unity_WorldToObject[1].xyz;
  tmpvar_33[2] = unity_WorldToObject[2].xyz;
  highp vec2 tmpvar_34;
  tmpvar_34 = (tmpvar_29.xz + vec2(0.5, 0.5));
  highp vec2 tmpvar_35;
  tmpvar_35 = ((tmpvar_34 * _MainTex_ST.xy) + _MainTex_ST.zw);
  uv_MainTex_22 = tmpvar_35;
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_MainTex, uv_MainTex_22);
  tex_21 = tmpvar_36;
  highp float x_37;
  x_37 = (dot (normalize(
    normalize(((tmpvar_32 * normalize(n_24)) * tmpvar_33))
  ), xlv_TEXCOORD3) - 0.1);
  if ((x_37 < 0.0)) {
    discard;
  };
  highp vec3 tmpvar_38;
  tmpvar_38 = tex_21.xxx;
  temp_cast_0_20 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = tex_21.yyy;
  temp_cast_1_19 = tmpvar_39;
  highp vec3 tmpvar_40;
  tmpvar_40 = tex_21.zzz;
  temp_cast_2_18 = tmpvar_40;
  highp vec3 tmpvar_41;
  tmpvar_41 = tex_21.www;
  temp_cast_3_17 = tmpvar_41;
  finalColor_16 = vec3(0.0, 0.0, 0.0);
  if ((_BaseTexColorChannelToggle == 0.0)) {
    finalColor_16 = tex_21.xyz;
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
    finalAlpha_15 = tex_21.x;
  } else {
    if ((_BaseTexAlphaChannelToggle == 1.0)) {
      finalAlpha_15 = tex_21.y;
    } else {
      if ((_BaseTexAlphaChannelToggle == 2.0)) {
        finalAlpha_15 = tex_21.z;
      } else {
        if ((_BaseTexAlphaChannelToggle == 3.0)) {
          finalAlpha_15 = tex_21.w;
        };
      };
    };
  };
  highp vec2 tmpvar_42;
  tmpvar_42 = ((tmpvar_34 * _MaskTexture_ST.xy) + _MaskTexture_ST.zw);
  uv_MaskTexture_14 = tmpvar_42;
  lowp vec4 tmpvar_43;
  tmpvar_43 = texture2D (_MaskTexture, uv_MaskTexture_14);
  Masktex_13 = tmpvar_43;
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
  highp float tmpvar_44;
  tmpvar_44 = (_Time.y * _DetailTex_Uspeed);
  detailUSpeed_11 = tmpvar_44;
  highp vec2 tmpvar_45;
  tmpvar_45 = ((tmpvar_34 * _DetailTex_ST.xy) + _DetailTex_ST.zw);
  uv_DetailTex_10 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = (_Time.y * _DetailTex_Vspeed);
  detailVSpeed_9 = tmpvar_46;
  mediump vec2 tmpvar_47;
  tmpvar_47.x = (detailUSpeed_11 + uv_DetailTex_10.x);
  tmpvar_47.y = (uv_DetailTex_10.y + detailVSpeed_9);
  lowp vec4 tmpvar_48;
  tmpvar_48 = texture2D (_DetailTex, tmpvar_47);
  detailTex_8 = tmpvar_48;
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
  mediump vec4 tmpvar_49;
  tmpvar_49.xyz = (((finalColor_16 * _TintColor.xyz) + (_DetailColor * detailValue_7).xyz) * _EmissionScaler);
  tmpvar_49.w = ((finalAlpha_15 * _TintColor.w) * (maskValue_12 * detailAlphaValue_6));
  col_5 = tmpvar_49;
  col_5.w = clamp (col_5.w, 0.0, 1.0);
  gl_FragData[0] = col_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _clip;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_8[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_8[2] = unity_ObjectToWorld[2].xyz;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD1 = o_4;
  xlv_TEXCOORD2 = ((unity_MatrixV * (unity_ObjectToWorld * tmpvar_7)).xyz * vec3(-1.0, -1.0, 1.0));
  xlv_TEXCOORD3 = (tmpvar_8 * _clip.xyz);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixInvV;
uniform sampler2D _MainTex;
uniform mediump vec4 _MainTex_ST;
uniform highp sampler2D _CustomDepthNormalsTexture;
uniform mediump float _DepthScaleValue;
uniform mediump float _BaseTexColorChannelToggle;
uniform mediump float _BaseTexAlphaChannelToggle;
uniform mediump vec4 _TintColor;
uniform mediump float _EmissionScaler;
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
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
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
  highp vec4 tex_21;
  mediump vec2 uv_MainTex_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_CustomDepthNormalsTexture, (xlv_TEXCOORD1.xy / xlv_TEXCOORD1.w));
  highp vec3 n_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = ((tmpvar_23.xyz * vec3(3.5554, 3.5554, 0.0)) + vec3(-1.7777, -1.7777, 1.0));
  highp float tmpvar_26;
  tmpvar_26 = (2.0 / dot (tmpvar_25, tmpvar_25));
  n_24.xy = (tmpvar_26 * tmpvar_25.xy);
  n_24.z = (tmpvar_26 - 1.0);
  highp vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = ((xlv_TEXCOORD2 * (_ProjectionParams.z / xlv_TEXCOORD2.z)) * (dot (tmpvar_23.zw, vec2(1.0, 0.003921569)) * _DepthScaleValue));
  highp vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = (unity_CameraToWorld * tmpvar_27).xyz;
  highp vec3 tmpvar_29;
  tmpvar_29 = (unity_WorldToObject * tmpvar_28).xyz;
  highp vec3 x_30;
  x_30 = (vec3(0.5, 0.5, 0.5) - abs(tmpvar_29));
  bvec3 tmpvar_31;
  tmpvar_31 = lessThan (x_30, vec3(0.0, 0.0, 0.0));
  if (any(tmpvar_31)) {
    discard;
  };
  highp mat3 tmpvar_32;
  tmpvar_32[0] = tmpvar_2.xyz;
  tmpvar_32[1] = tmpvar_3.xyz;
  tmpvar_32[2] = tmpvar_4.xyz;
  highp mat3 tmpvar_33;
  tmpvar_33[0] = unity_WorldToObject[0].xyz;
  tmpvar_33[1] = unity_WorldToObject[1].xyz;
  tmpvar_33[2] = unity_WorldToObject[2].xyz;
  highp vec2 tmpvar_34;
  tmpvar_34 = (tmpvar_29.xz + vec2(0.5, 0.5));
  highp vec2 tmpvar_35;
  tmpvar_35 = ((tmpvar_34 * _MainTex_ST.xy) + _MainTex_ST.zw);
  uv_MainTex_22 = tmpvar_35;
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_MainTex, uv_MainTex_22);
  tex_21 = tmpvar_36;
  highp float x_37;
  x_37 = (dot (normalize(
    normalize(((tmpvar_32 * normalize(n_24)) * tmpvar_33))
  ), xlv_TEXCOORD3) - 0.1);
  if ((x_37 < 0.0)) {
    discard;
  };
  highp vec3 tmpvar_38;
  tmpvar_38 = tex_21.xxx;
  temp_cast_0_20 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = tex_21.yyy;
  temp_cast_1_19 = tmpvar_39;
  highp vec3 tmpvar_40;
  tmpvar_40 = tex_21.zzz;
  temp_cast_2_18 = tmpvar_40;
  highp vec3 tmpvar_41;
  tmpvar_41 = tex_21.www;
  temp_cast_3_17 = tmpvar_41;
  finalColor_16 = vec3(0.0, 0.0, 0.0);
  if ((_BaseTexColorChannelToggle == 0.0)) {
    finalColor_16 = tex_21.xyz;
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
    finalAlpha_15 = tex_21.x;
  } else {
    if ((_BaseTexAlphaChannelToggle == 1.0)) {
      finalAlpha_15 = tex_21.y;
    } else {
      if ((_BaseTexAlphaChannelToggle == 2.0)) {
        finalAlpha_15 = tex_21.z;
      } else {
        if ((_BaseTexAlphaChannelToggle == 3.0)) {
          finalAlpha_15 = tex_21.w;
        };
      };
    };
  };
  highp vec2 tmpvar_42;
  tmpvar_42 = ((tmpvar_34 * _MaskTexture_ST.xy) + _MaskTexture_ST.zw);
  uv_MaskTexture_14 = tmpvar_42;
  lowp vec4 tmpvar_43;
  tmpvar_43 = texture2D (_MaskTexture, uv_MaskTexture_14);
  Masktex_13 = tmpvar_43;
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
  highp float tmpvar_44;
  tmpvar_44 = (_Time.y * _DetailTex_Uspeed);
  detailUSpeed_11 = tmpvar_44;
  highp vec2 tmpvar_45;
  tmpvar_45 = ((tmpvar_34 * _DetailTex_ST.xy) + _DetailTex_ST.zw);
  uv_DetailTex_10 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = (_Time.y * _DetailTex_Vspeed);
  detailVSpeed_9 = tmpvar_46;
  mediump vec2 tmpvar_47;
  tmpvar_47.x = (detailUSpeed_11 + uv_DetailTex_10.x);
  tmpvar_47.y = (uv_DetailTex_10.y + detailVSpeed_9);
  lowp vec4 tmpvar_48;
  tmpvar_48 = texture2D (_DetailTex, tmpvar_47);
  detailTex_8 = tmpvar_48;
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
  mediump vec4 tmpvar_49;
  tmpvar_49.xyz = (((finalColor_16 * _TintColor.xyz) + (_DetailColor * detailValue_7).xyz) * _EmissionScaler);
  tmpvar_49.w = ((finalAlpha_15 * _TintColor.w) * (maskValue_12 * detailAlphaValue_6));
  col_5 = tmpvar_49;
  col_5.w = clamp (col_5.w, 0.0, 1.0);
  gl_FragData[0] = col_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _clip;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_8[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_8[2] = unity_ObjectToWorld[2].xyz;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD1 = o_4;
  xlv_TEXCOORD2 = ((unity_MatrixV * (unity_ObjectToWorld * tmpvar_7)).xyz * vec3(-1.0, -1.0, 1.0));
  xlv_TEXCOORD3 = (tmpvar_8 * _clip.xyz);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixInvV;
uniform sampler2D _MainTex;
uniform mediump vec4 _MainTex_ST;
uniform highp sampler2D _CustomDepthNormalsTexture;
uniform mediump float _DepthScaleValue;
uniform mediump float _BaseTexColorChannelToggle;
uniform mediump float _BaseTexAlphaChannelToggle;
uniform mediump vec4 _TintColor;
uniform mediump float _EmissionScaler;
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
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
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
  highp vec4 tex_21;
  mediump vec2 uv_MainTex_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_CustomDepthNormalsTexture, (xlv_TEXCOORD1.xy / xlv_TEXCOORD1.w));
  highp vec3 n_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = ((tmpvar_23.xyz * vec3(3.5554, 3.5554, 0.0)) + vec3(-1.7777, -1.7777, 1.0));
  highp float tmpvar_26;
  tmpvar_26 = (2.0 / dot (tmpvar_25, tmpvar_25));
  n_24.xy = (tmpvar_26 * tmpvar_25.xy);
  n_24.z = (tmpvar_26 - 1.0);
  highp vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = ((xlv_TEXCOORD2 * (_ProjectionParams.z / xlv_TEXCOORD2.z)) * (dot (tmpvar_23.zw, vec2(1.0, 0.003921569)) * _DepthScaleValue));
  highp vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = (unity_CameraToWorld * tmpvar_27).xyz;
  highp vec3 tmpvar_29;
  tmpvar_29 = (unity_WorldToObject * tmpvar_28).xyz;
  highp vec3 x_30;
  x_30 = (vec3(0.5, 0.5, 0.5) - abs(tmpvar_29));
  bvec3 tmpvar_31;
  tmpvar_31 = lessThan (x_30, vec3(0.0, 0.0, 0.0));
  if (any(tmpvar_31)) {
    discard;
  };
  highp mat3 tmpvar_32;
  tmpvar_32[0] = tmpvar_2.xyz;
  tmpvar_32[1] = tmpvar_3.xyz;
  tmpvar_32[2] = tmpvar_4.xyz;
  highp mat3 tmpvar_33;
  tmpvar_33[0] = unity_WorldToObject[0].xyz;
  tmpvar_33[1] = unity_WorldToObject[1].xyz;
  tmpvar_33[2] = unity_WorldToObject[2].xyz;
  highp vec2 tmpvar_34;
  tmpvar_34 = (tmpvar_29.xz + vec2(0.5, 0.5));
  highp vec2 tmpvar_35;
  tmpvar_35 = ((tmpvar_34 * _MainTex_ST.xy) + _MainTex_ST.zw);
  uv_MainTex_22 = tmpvar_35;
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_MainTex, uv_MainTex_22);
  tex_21 = tmpvar_36;
  highp float x_37;
  x_37 = (dot (normalize(
    normalize(((tmpvar_32 * normalize(n_24)) * tmpvar_33))
  ), xlv_TEXCOORD3) - 0.1);
  if ((x_37 < 0.0)) {
    discard;
  };
  highp vec3 tmpvar_38;
  tmpvar_38 = tex_21.xxx;
  temp_cast_0_20 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = tex_21.yyy;
  temp_cast_1_19 = tmpvar_39;
  highp vec3 tmpvar_40;
  tmpvar_40 = tex_21.zzz;
  temp_cast_2_18 = tmpvar_40;
  highp vec3 tmpvar_41;
  tmpvar_41 = tex_21.www;
  temp_cast_3_17 = tmpvar_41;
  finalColor_16 = vec3(0.0, 0.0, 0.0);
  if ((_BaseTexColorChannelToggle == 0.0)) {
    finalColor_16 = tex_21.xyz;
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
    finalAlpha_15 = tex_21.x;
  } else {
    if ((_BaseTexAlphaChannelToggle == 1.0)) {
      finalAlpha_15 = tex_21.y;
    } else {
      if ((_BaseTexAlphaChannelToggle == 2.0)) {
        finalAlpha_15 = tex_21.z;
      } else {
        if ((_BaseTexAlphaChannelToggle == 3.0)) {
          finalAlpha_15 = tex_21.w;
        };
      };
    };
  };
  highp vec2 tmpvar_42;
  tmpvar_42 = ((tmpvar_34 * _MaskTexture_ST.xy) + _MaskTexture_ST.zw);
  uv_MaskTexture_14 = tmpvar_42;
  lowp vec4 tmpvar_43;
  tmpvar_43 = texture2D (_MaskTexture, uv_MaskTexture_14);
  Masktex_13 = tmpvar_43;
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
  highp float tmpvar_44;
  tmpvar_44 = (_Time.y * _DetailTex_Uspeed);
  detailUSpeed_11 = tmpvar_44;
  highp vec2 tmpvar_45;
  tmpvar_45 = ((tmpvar_34 * _DetailTex_ST.xy) + _DetailTex_ST.zw);
  uv_DetailTex_10 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = (_Time.y * _DetailTex_Vspeed);
  detailVSpeed_9 = tmpvar_46;
  mediump vec2 tmpvar_47;
  tmpvar_47.x = (detailUSpeed_11 + uv_DetailTex_10.x);
  tmpvar_47.y = (uv_DetailTex_10.y + detailVSpeed_9);
  lowp vec4 tmpvar_48;
  tmpvar_48 = texture2D (_DetailTex, tmpvar_47);
  detailTex_8 = tmpvar_48;
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
  mediump vec4 tmpvar_49;
  tmpvar_49.xyz = (((finalColor_16 * _TintColor.xyz) + (_DetailColor * detailValue_7).xyz) * _EmissionScaler);
  tmpvar_49.w = ((finalAlpha_15 * _TintColor.w) * (maskValue_12 * detailAlphaValue_6));
  col_5 = tmpvar_49;
  col_5.w = clamp (col_5.w, 0.0, 1.0);
  gl_FragData[0] = col_5;
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
  Tags { "QUEUE" = "Geometry+1" }
  ZWrite Off
  GpuProgramID 77375
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = clamp (_glesColor, 0.0, 1.0);
  tmpvar_1 = tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR0;
void main ()
{
  gl_FragData[0] = xlv_COLOR0;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = clamp (_glesColor, 0.0, 1.0);
  tmpvar_1 = tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR0;
void main ()
{
  gl_FragData[0] = xlv_COLOR0;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = clamp (_glesColor, 0.0, 1.0);
  tmpvar_1 = tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR0;
void main ()
{
  gl_FragData[0] = xlv_COLOR0;
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