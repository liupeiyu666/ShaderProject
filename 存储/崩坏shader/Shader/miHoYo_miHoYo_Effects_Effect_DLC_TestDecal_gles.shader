//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_DLC/TestDecal" {
Properties {
_MainTex ("Decal Texture", 2D) = "white" { }
_Color ("Color", Color) = (1,1,1,1)
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
}
SubShader {
 Tags { "QUEUE" = "Geometry+1" }
 Pass {
  Tags { "QUEUE" = "Geometry+1" }
  ZWrite Off
  GpuProgramID 31450
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
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
  gl_Position = tmpvar_2;
  xlv_TEXCOORD1 = o_4;
  xlv_TEXCOORD2 = ((unity_MatrixV * (unity_ObjectToWorld * tmpvar_7)).xyz * vec3(-1.0, -1.0, 1.0));
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
uniform sampler2D _MainTex;
uniform mediump vec4 _MainTex_ST;
uniform sampler2D _CustomDepthNormalsTexture;
uniform mediump float _DepthScaleValue;
uniform mediump float _BaseTexColorChannelToggle;
uniform mediump float _BaseTexAlphaChannelToggle;
uniform mediump vec4 _Color;
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
  highp vec4 col_4;
  mediump float detailAlphaValue_5;
  mediump float detailValue_6;
  mediump vec4 detailTex_7;
  mediump float detailVSpeed_8;
  mediump vec2 uv_DetailTex_9;
  mediump float detailUSpeed_10;
  mediump float maskValue_11;
  mediump vec4 Masktex_12;
  mediump vec2 uv_MaskTexture_13;
  mediump float finalAlpha_14;
  mediump vec3 finalColor_15;
  mediump vec3 temp_cast_3_16;
  mediump vec3 temp_cast_2_17;
  mediump vec3 temp_cast_1_18;
  mediump vec3 temp_cast_0_19;
  highp vec4 tex_20;
  mediump vec2 uv_MainTex_21;
  highp vec4 encode_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = (xlv_TEXCOORD1.xy / xlv_TEXCOORD1.w);
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_CustomDepthNormalsTexture, tmpvar_23);
  encode_22 = tmpvar_24;
  highp vec3 n_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = ((encode_22.xyz * vec3(3.5554, 3.5554, 0.0)) + vec3(-1.7777, -1.7777, 1.0));
  highp float tmpvar_27;
  tmpvar_27 = (2.0 / dot (tmpvar_26, tmpvar_26));
  n_25.xy = (tmpvar_27 * tmpvar_26.xy);
  n_25.z = (tmpvar_27 - 1.0);
  highp vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = ((xlv_TEXCOORD2 * (_ProjectionParams.z / xlv_TEXCOORD2.z)) * (dot (encode_22.zw, vec2(1.0, 0.003921569)) * _DepthScaleValue));
  highp vec4 tmpvar_29;
  tmpvar_29.w = 1.0;
  tmpvar_29.xyz = (unity_CameraToWorld * tmpvar_28).xyz;
  highp vec3 tmpvar_30;
  tmpvar_30 = (unity_WorldToObject * tmpvar_29).xyz;
  highp vec3 x_31;
  x_31 = (vec3(0.5, 0.5, 0.5) - abs(tmpvar_30));
  bvec3 tmpvar_32;
  tmpvar_32 = lessThan (x_31, vec3(0.0, 0.0, 0.0));
  if (any(tmpvar_32)) {
    discard;
  };
  highp mat3 tmpvar_33;
  tmpvar_33[0] = tmpvar_1.xyz;
  tmpvar_33[1] = tmpvar_2.xyz;
  tmpvar_33[2] = tmpvar_3.xyz;
  highp vec2 tmpvar_34;
  tmpvar_34.x = 0.0;
  tmpvar_34.y = (tmpvar_30.y + 0.5);
  highp vec2 tmpvar_35;
  tmpvar_35 = ((tmpvar_30.xz + vec2(0.5, 0.5)) + ((1.0 - 
    normalize((tmpvar_33 * normalize(n_25)))
  .y) * tmpvar_34));
  highp vec2 tmpvar_36;
  tmpvar_36 = ((tmpvar_35 * _MainTex_ST.xy) + _MainTex_ST.zw);
  uv_MainTex_21 = tmpvar_36;
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_MainTex, uv_MainTex_21);
  tex_20 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = tex_20.xxx;
  temp_cast_0_19 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = tex_20.yyy;
  temp_cast_1_18 = tmpvar_39;
  highp vec3 tmpvar_40;
  tmpvar_40 = tex_20.zzz;
  temp_cast_2_17 = tmpvar_40;
  highp vec3 tmpvar_41;
  tmpvar_41 = tex_20.www;
  temp_cast_3_16 = tmpvar_41;
  finalColor_15 = vec3(0.0, 0.0, 0.0);
  if ((_BaseTexColorChannelToggle == 0.0)) {
    finalColor_15 = tex_20.xyz;
  } else {
    if ((_BaseTexColorChannelToggle == 1.0)) {
      finalColor_15 = temp_cast_0_19;
    } else {
      if ((_BaseTexColorChannelToggle == 2.0)) {
        finalColor_15 = temp_cast_1_18;
      } else {
        if ((_BaseTexColorChannelToggle == 3.0)) {
          finalColor_15 = temp_cast_2_17;
        } else {
          if ((_BaseTexColorChannelToggle == 4.0)) {
            finalColor_15 = temp_cast_3_16;
          } else {
            if ((_BaseTexColorChannelToggle == 5.0)) {
              finalColor_15 = vec3(1.0, 1.0, 1.0);
            };
          };
        };
      };
    };
  };
  finalAlpha_14 = 0.0;
  if ((_BaseTexAlphaChannelToggle == 0.0)) {
    finalAlpha_14 = tex_20.x;
  } else {
    if ((_BaseTexAlphaChannelToggle == 1.0)) {
      finalAlpha_14 = tex_20.y;
    } else {
      if ((_BaseTexAlphaChannelToggle == 2.0)) {
        finalAlpha_14 = tex_20.z;
      } else {
        if ((_BaseTexAlphaChannelToggle == 3.0)) {
          finalAlpha_14 = tex_20.w;
        };
      };
    };
  };
  highp vec2 tmpvar_42;
  tmpvar_42 = ((tmpvar_35 * _MaskTexture_ST.xy) + _MaskTexture_ST.zw);
  uv_MaskTexture_13 = tmpvar_42;
  lowp vec4 tmpvar_43;
  tmpvar_43 = texture2D (_MaskTexture, uv_MaskTexture_13);
  Masktex_12 = tmpvar_43;
  maskValue_11 = 0.0;
  if ((_MaskTexChannelToggle == 0.0)) {
    maskValue_11 = Masktex_12.x;
  } else {
    if ((_MaskTexChannelToggle == 1.0)) {
      maskValue_11 = Masktex_12.y;
    } else {
      if ((_MaskTexChannelToggle == 2.0)) {
        maskValue_11 = Masktex_12.z;
      } else {
        if ((_MaskTexChannelToggle == 3.0)) {
          maskValue_11 = Masktex_12.w;
        };
      };
    };
  };
  highp float tmpvar_44;
  tmpvar_44 = (_Time.y * _DetailTex_Uspeed);
  detailUSpeed_10 = tmpvar_44;
  highp vec2 tmpvar_45;
  tmpvar_45 = ((tmpvar_35 * _DetailTex_ST.xy) + _DetailTex_ST.zw);
  uv_DetailTex_9 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = (_Time.y * _DetailTex_Vspeed);
  detailVSpeed_8 = tmpvar_46;
  mediump vec2 tmpvar_47;
  tmpvar_47.x = (detailUSpeed_10 + uv_DetailTex_9.x);
  tmpvar_47.y = (uv_DetailTex_9.y + detailVSpeed_8);
  lowp vec4 tmpvar_48;
  tmpvar_48 = texture2D (_DetailTex, tmpvar_47);
  detailTex_7 = tmpvar_48;
  detailValue_6 = 0.0;
  if ((_DetailTexColorChannelToggle == 0.0)) {
    detailValue_6 = detailTex_7.x;
  } else {
    if ((_DetailTexColorChannelToggle == 1.0)) {
      detailValue_6 = detailTex_7.y;
    } else {
      if ((_DetailTexColorChannelToggle == 2.0)) {
        detailValue_6 = detailTex_7.z;
      } else {
        if ((_DetailTexColorChannelToggle == 3.0)) {
          detailValue_6 = detailTex_7.w;
        };
      };
    };
  };
  detailAlphaValue_5 = 0.0;
  if ((_DetailTexAlphaChannelToggle == 0.0)) {
    detailAlphaValue_5 = detailTex_7.x;
  } else {
    if ((_DetailTexAlphaChannelToggle == 1.0)) {
      detailAlphaValue_5 = detailTex_7.y;
    } else {
      if ((_DetailTexAlphaChannelToggle == 2.0)) {
        detailAlphaValue_5 = detailTex_7.z;
      } else {
        if ((_DetailTexAlphaChannelToggle == 3.0)) {
          detailAlphaValue_5 = detailTex_7.w;
        };
      };
    };
  };
  mediump vec4 tmpvar_49;
  tmpvar_49.xyz = (((finalColor_15 * _Color.xyz) + (_DetailColor * detailValue_6).xyz) * _EmissionScaler);
  tmpvar_49.w = ((finalAlpha_14 * _Color.w) * (maskValue_11 * detailAlphaValue_5));
  col_4 = tmpvar_49;
  col_4.w = clamp (col_4.w, 0.0, 1.0);
  gl_FragData[0] = col_4;
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
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
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
  gl_Position = tmpvar_2;
  xlv_TEXCOORD1 = o_4;
  xlv_TEXCOORD2 = ((unity_MatrixV * (unity_ObjectToWorld * tmpvar_7)).xyz * vec3(-1.0, -1.0, 1.0));
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
uniform sampler2D _MainTex;
uniform mediump vec4 _MainTex_ST;
uniform sampler2D _CustomDepthNormalsTexture;
uniform mediump float _DepthScaleValue;
uniform mediump float _BaseTexColorChannelToggle;
uniform mediump float _BaseTexAlphaChannelToggle;
uniform mediump vec4 _Color;
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
  highp vec4 col_4;
  mediump float detailAlphaValue_5;
  mediump float detailValue_6;
  mediump vec4 detailTex_7;
  mediump float detailVSpeed_8;
  mediump vec2 uv_DetailTex_9;
  mediump float detailUSpeed_10;
  mediump float maskValue_11;
  mediump vec4 Masktex_12;
  mediump vec2 uv_MaskTexture_13;
  mediump float finalAlpha_14;
  mediump vec3 finalColor_15;
  mediump vec3 temp_cast_3_16;
  mediump vec3 temp_cast_2_17;
  mediump vec3 temp_cast_1_18;
  mediump vec3 temp_cast_0_19;
  highp vec4 tex_20;
  mediump vec2 uv_MainTex_21;
  highp vec4 encode_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = (xlv_TEXCOORD1.xy / xlv_TEXCOORD1.w);
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_CustomDepthNormalsTexture, tmpvar_23);
  encode_22 = tmpvar_24;
  highp vec3 n_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = ((encode_22.xyz * vec3(3.5554, 3.5554, 0.0)) + vec3(-1.7777, -1.7777, 1.0));
  highp float tmpvar_27;
  tmpvar_27 = (2.0 / dot (tmpvar_26, tmpvar_26));
  n_25.xy = (tmpvar_27 * tmpvar_26.xy);
  n_25.z = (tmpvar_27 - 1.0);
  highp vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = ((xlv_TEXCOORD2 * (_ProjectionParams.z / xlv_TEXCOORD2.z)) * (dot (encode_22.zw, vec2(1.0, 0.003921569)) * _DepthScaleValue));
  highp vec4 tmpvar_29;
  tmpvar_29.w = 1.0;
  tmpvar_29.xyz = (unity_CameraToWorld * tmpvar_28).xyz;
  highp vec3 tmpvar_30;
  tmpvar_30 = (unity_WorldToObject * tmpvar_29).xyz;
  highp vec3 x_31;
  x_31 = (vec3(0.5, 0.5, 0.5) - abs(tmpvar_30));
  bvec3 tmpvar_32;
  tmpvar_32 = lessThan (x_31, vec3(0.0, 0.0, 0.0));
  if (any(tmpvar_32)) {
    discard;
  };
  highp mat3 tmpvar_33;
  tmpvar_33[0] = tmpvar_1.xyz;
  tmpvar_33[1] = tmpvar_2.xyz;
  tmpvar_33[2] = tmpvar_3.xyz;
  highp vec2 tmpvar_34;
  tmpvar_34.x = 0.0;
  tmpvar_34.y = (tmpvar_30.y + 0.5);
  highp vec2 tmpvar_35;
  tmpvar_35 = ((tmpvar_30.xz + vec2(0.5, 0.5)) + ((1.0 - 
    normalize((tmpvar_33 * normalize(n_25)))
  .y) * tmpvar_34));
  highp vec2 tmpvar_36;
  tmpvar_36 = ((tmpvar_35 * _MainTex_ST.xy) + _MainTex_ST.zw);
  uv_MainTex_21 = tmpvar_36;
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_MainTex, uv_MainTex_21);
  tex_20 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = tex_20.xxx;
  temp_cast_0_19 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = tex_20.yyy;
  temp_cast_1_18 = tmpvar_39;
  highp vec3 tmpvar_40;
  tmpvar_40 = tex_20.zzz;
  temp_cast_2_17 = tmpvar_40;
  highp vec3 tmpvar_41;
  tmpvar_41 = tex_20.www;
  temp_cast_3_16 = tmpvar_41;
  finalColor_15 = vec3(0.0, 0.0, 0.0);
  if ((_BaseTexColorChannelToggle == 0.0)) {
    finalColor_15 = tex_20.xyz;
  } else {
    if ((_BaseTexColorChannelToggle == 1.0)) {
      finalColor_15 = temp_cast_0_19;
    } else {
      if ((_BaseTexColorChannelToggle == 2.0)) {
        finalColor_15 = temp_cast_1_18;
      } else {
        if ((_BaseTexColorChannelToggle == 3.0)) {
          finalColor_15 = temp_cast_2_17;
        } else {
          if ((_BaseTexColorChannelToggle == 4.0)) {
            finalColor_15 = temp_cast_3_16;
          } else {
            if ((_BaseTexColorChannelToggle == 5.0)) {
              finalColor_15 = vec3(1.0, 1.0, 1.0);
            };
          };
        };
      };
    };
  };
  finalAlpha_14 = 0.0;
  if ((_BaseTexAlphaChannelToggle == 0.0)) {
    finalAlpha_14 = tex_20.x;
  } else {
    if ((_BaseTexAlphaChannelToggle == 1.0)) {
      finalAlpha_14 = tex_20.y;
    } else {
      if ((_BaseTexAlphaChannelToggle == 2.0)) {
        finalAlpha_14 = tex_20.z;
      } else {
        if ((_BaseTexAlphaChannelToggle == 3.0)) {
          finalAlpha_14 = tex_20.w;
        };
      };
    };
  };
  highp vec2 tmpvar_42;
  tmpvar_42 = ((tmpvar_35 * _MaskTexture_ST.xy) + _MaskTexture_ST.zw);
  uv_MaskTexture_13 = tmpvar_42;
  lowp vec4 tmpvar_43;
  tmpvar_43 = texture2D (_MaskTexture, uv_MaskTexture_13);
  Masktex_12 = tmpvar_43;
  maskValue_11 = 0.0;
  if ((_MaskTexChannelToggle == 0.0)) {
    maskValue_11 = Masktex_12.x;
  } else {
    if ((_MaskTexChannelToggle == 1.0)) {
      maskValue_11 = Masktex_12.y;
    } else {
      if ((_MaskTexChannelToggle == 2.0)) {
        maskValue_11 = Masktex_12.z;
      } else {
        if ((_MaskTexChannelToggle == 3.0)) {
          maskValue_11 = Masktex_12.w;
        };
      };
    };
  };
  highp float tmpvar_44;
  tmpvar_44 = (_Time.y * _DetailTex_Uspeed);
  detailUSpeed_10 = tmpvar_44;
  highp vec2 tmpvar_45;
  tmpvar_45 = ((tmpvar_35 * _DetailTex_ST.xy) + _DetailTex_ST.zw);
  uv_DetailTex_9 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = (_Time.y * _DetailTex_Vspeed);
  detailVSpeed_8 = tmpvar_46;
  mediump vec2 tmpvar_47;
  tmpvar_47.x = (detailUSpeed_10 + uv_DetailTex_9.x);
  tmpvar_47.y = (uv_DetailTex_9.y + detailVSpeed_8);
  lowp vec4 tmpvar_48;
  tmpvar_48 = texture2D (_DetailTex, tmpvar_47);
  detailTex_7 = tmpvar_48;
  detailValue_6 = 0.0;
  if ((_DetailTexColorChannelToggle == 0.0)) {
    detailValue_6 = detailTex_7.x;
  } else {
    if ((_DetailTexColorChannelToggle == 1.0)) {
      detailValue_6 = detailTex_7.y;
    } else {
      if ((_DetailTexColorChannelToggle == 2.0)) {
        detailValue_6 = detailTex_7.z;
      } else {
        if ((_DetailTexColorChannelToggle == 3.0)) {
          detailValue_6 = detailTex_7.w;
        };
      };
    };
  };
  detailAlphaValue_5 = 0.0;
  if ((_DetailTexAlphaChannelToggle == 0.0)) {
    detailAlphaValue_5 = detailTex_7.x;
  } else {
    if ((_DetailTexAlphaChannelToggle == 1.0)) {
      detailAlphaValue_5 = detailTex_7.y;
    } else {
      if ((_DetailTexAlphaChannelToggle == 2.0)) {
        detailAlphaValue_5 = detailTex_7.z;
      } else {
        if ((_DetailTexAlphaChannelToggle == 3.0)) {
          detailAlphaValue_5 = detailTex_7.w;
        };
      };
    };
  };
  mediump vec4 tmpvar_49;
  tmpvar_49.xyz = (((finalColor_15 * _Color.xyz) + (_DetailColor * detailValue_6).xyz) * _EmissionScaler);
  tmpvar_49.w = ((finalAlpha_14 * _Color.w) * (maskValue_11 * detailAlphaValue_5));
  col_4 = tmpvar_49;
  col_4.w = clamp (col_4.w, 0.0, 1.0);
  gl_FragData[0] = col_4;
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
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
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
  gl_Position = tmpvar_2;
  xlv_TEXCOORD1 = o_4;
  xlv_TEXCOORD2 = ((unity_MatrixV * (unity_ObjectToWorld * tmpvar_7)).xyz * vec3(-1.0, -1.0, 1.0));
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
uniform sampler2D _MainTex;
uniform mediump vec4 _MainTex_ST;
uniform sampler2D _CustomDepthNormalsTexture;
uniform mediump float _DepthScaleValue;
uniform mediump float _BaseTexColorChannelToggle;
uniform mediump float _BaseTexAlphaChannelToggle;
uniform mediump vec4 _Color;
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
  highp vec4 col_4;
  mediump float detailAlphaValue_5;
  mediump float detailValue_6;
  mediump vec4 detailTex_7;
  mediump float detailVSpeed_8;
  mediump vec2 uv_DetailTex_9;
  mediump float detailUSpeed_10;
  mediump float maskValue_11;
  mediump vec4 Masktex_12;
  mediump vec2 uv_MaskTexture_13;
  mediump float finalAlpha_14;
  mediump vec3 finalColor_15;
  mediump vec3 temp_cast_3_16;
  mediump vec3 temp_cast_2_17;
  mediump vec3 temp_cast_1_18;
  mediump vec3 temp_cast_0_19;
  highp vec4 tex_20;
  mediump vec2 uv_MainTex_21;
  highp vec4 encode_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = (xlv_TEXCOORD1.xy / xlv_TEXCOORD1.w);
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_CustomDepthNormalsTexture, tmpvar_23);
  encode_22 = tmpvar_24;
  highp vec3 n_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = ((encode_22.xyz * vec3(3.5554, 3.5554, 0.0)) + vec3(-1.7777, -1.7777, 1.0));
  highp float tmpvar_27;
  tmpvar_27 = (2.0 / dot (tmpvar_26, tmpvar_26));
  n_25.xy = (tmpvar_27 * tmpvar_26.xy);
  n_25.z = (tmpvar_27 - 1.0);
  highp vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = ((xlv_TEXCOORD2 * (_ProjectionParams.z / xlv_TEXCOORD2.z)) * (dot (encode_22.zw, vec2(1.0, 0.003921569)) * _DepthScaleValue));
  highp vec4 tmpvar_29;
  tmpvar_29.w = 1.0;
  tmpvar_29.xyz = (unity_CameraToWorld * tmpvar_28).xyz;
  highp vec3 tmpvar_30;
  tmpvar_30 = (unity_WorldToObject * tmpvar_29).xyz;
  highp vec3 x_31;
  x_31 = (vec3(0.5, 0.5, 0.5) - abs(tmpvar_30));
  bvec3 tmpvar_32;
  tmpvar_32 = lessThan (x_31, vec3(0.0, 0.0, 0.0));
  if (any(tmpvar_32)) {
    discard;
  };
  highp mat3 tmpvar_33;
  tmpvar_33[0] = tmpvar_1.xyz;
  tmpvar_33[1] = tmpvar_2.xyz;
  tmpvar_33[2] = tmpvar_3.xyz;
  highp vec2 tmpvar_34;
  tmpvar_34.x = 0.0;
  tmpvar_34.y = (tmpvar_30.y + 0.5);
  highp vec2 tmpvar_35;
  tmpvar_35 = ((tmpvar_30.xz + vec2(0.5, 0.5)) + ((1.0 - 
    normalize((tmpvar_33 * normalize(n_25)))
  .y) * tmpvar_34));
  highp vec2 tmpvar_36;
  tmpvar_36 = ((tmpvar_35 * _MainTex_ST.xy) + _MainTex_ST.zw);
  uv_MainTex_21 = tmpvar_36;
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_MainTex, uv_MainTex_21);
  tex_20 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = tex_20.xxx;
  temp_cast_0_19 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = tex_20.yyy;
  temp_cast_1_18 = tmpvar_39;
  highp vec3 tmpvar_40;
  tmpvar_40 = tex_20.zzz;
  temp_cast_2_17 = tmpvar_40;
  highp vec3 tmpvar_41;
  tmpvar_41 = tex_20.www;
  temp_cast_3_16 = tmpvar_41;
  finalColor_15 = vec3(0.0, 0.0, 0.0);
  if ((_BaseTexColorChannelToggle == 0.0)) {
    finalColor_15 = tex_20.xyz;
  } else {
    if ((_BaseTexColorChannelToggle == 1.0)) {
      finalColor_15 = temp_cast_0_19;
    } else {
      if ((_BaseTexColorChannelToggle == 2.0)) {
        finalColor_15 = temp_cast_1_18;
      } else {
        if ((_BaseTexColorChannelToggle == 3.0)) {
          finalColor_15 = temp_cast_2_17;
        } else {
          if ((_BaseTexColorChannelToggle == 4.0)) {
            finalColor_15 = temp_cast_3_16;
          } else {
            if ((_BaseTexColorChannelToggle == 5.0)) {
              finalColor_15 = vec3(1.0, 1.0, 1.0);
            };
          };
        };
      };
    };
  };
  finalAlpha_14 = 0.0;
  if ((_BaseTexAlphaChannelToggle == 0.0)) {
    finalAlpha_14 = tex_20.x;
  } else {
    if ((_BaseTexAlphaChannelToggle == 1.0)) {
      finalAlpha_14 = tex_20.y;
    } else {
      if ((_BaseTexAlphaChannelToggle == 2.0)) {
        finalAlpha_14 = tex_20.z;
      } else {
        if ((_BaseTexAlphaChannelToggle == 3.0)) {
          finalAlpha_14 = tex_20.w;
        };
      };
    };
  };
  highp vec2 tmpvar_42;
  tmpvar_42 = ((tmpvar_35 * _MaskTexture_ST.xy) + _MaskTexture_ST.zw);
  uv_MaskTexture_13 = tmpvar_42;
  lowp vec4 tmpvar_43;
  tmpvar_43 = texture2D (_MaskTexture, uv_MaskTexture_13);
  Masktex_12 = tmpvar_43;
  maskValue_11 = 0.0;
  if ((_MaskTexChannelToggle == 0.0)) {
    maskValue_11 = Masktex_12.x;
  } else {
    if ((_MaskTexChannelToggle == 1.0)) {
      maskValue_11 = Masktex_12.y;
    } else {
      if ((_MaskTexChannelToggle == 2.0)) {
        maskValue_11 = Masktex_12.z;
      } else {
        if ((_MaskTexChannelToggle == 3.0)) {
          maskValue_11 = Masktex_12.w;
        };
      };
    };
  };
  highp float tmpvar_44;
  tmpvar_44 = (_Time.y * _DetailTex_Uspeed);
  detailUSpeed_10 = tmpvar_44;
  highp vec2 tmpvar_45;
  tmpvar_45 = ((tmpvar_35 * _DetailTex_ST.xy) + _DetailTex_ST.zw);
  uv_DetailTex_9 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = (_Time.y * _DetailTex_Vspeed);
  detailVSpeed_8 = tmpvar_46;
  mediump vec2 tmpvar_47;
  tmpvar_47.x = (detailUSpeed_10 + uv_DetailTex_9.x);
  tmpvar_47.y = (uv_DetailTex_9.y + detailVSpeed_8);
  lowp vec4 tmpvar_48;
  tmpvar_48 = texture2D (_DetailTex, tmpvar_47);
  detailTex_7 = tmpvar_48;
  detailValue_6 = 0.0;
  if ((_DetailTexColorChannelToggle == 0.0)) {
    detailValue_6 = detailTex_7.x;
  } else {
    if ((_DetailTexColorChannelToggle == 1.0)) {
      detailValue_6 = detailTex_7.y;
    } else {
      if ((_DetailTexColorChannelToggle == 2.0)) {
        detailValue_6 = detailTex_7.z;
      } else {
        if ((_DetailTexColorChannelToggle == 3.0)) {
          detailValue_6 = detailTex_7.w;
        };
      };
    };
  };
  detailAlphaValue_5 = 0.0;
  if ((_DetailTexAlphaChannelToggle == 0.0)) {
    detailAlphaValue_5 = detailTex_7.x;
  } else {
    if ((_DetailTexAlphaChannelToggle == 1.0)) {
      detailAlphaValue_5 = detailTex_7.y;
    } else {
      if ((_DetailTexAlphaChannelToggle == 2.0)) {
        detailAlphaValue_5 = detailTex_7.z;
      } else {
        if ((_DetailTexAlphaChannelToggle == 3.0)) {
          detailAlphaValue_5 = detailTex_7.w;
        };
      };
    };
  };
  mediump vec4 tmpvar_49;
  tmpvar_49.xyz = (((finalColor_15 * _Color.xyz) + (_DetailColor * detailValue_6).xyz) * _EmissionScaler);
  tmpvar_49.w = ((finalAlpha_14 * _Color.w) * (maskValue_11 * detailAlphaValue_5));
  col_4 = tmpvar_49;
  col_4.w = clamp (col_4.w, 0.0, 1.0);
  gl_FragData[0] = col_4;
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