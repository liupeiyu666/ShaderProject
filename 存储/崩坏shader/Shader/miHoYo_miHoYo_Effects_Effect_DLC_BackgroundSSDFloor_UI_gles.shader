//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_DLC/BackgroundSSDFloor_UI" {
Properties {
_MainTex ("Decal Texture", 2D) = "white" { }
_TintColor ("TintColor", Color) = (1,1,1,1)
_EmissionScaler ("Emission Scaler", Range(0, 50)) = 1
[Enum(RGB,0,R,1,G,2,B,3,A,4,WhiteColor,5)] _BaseTexColorChannelToggle ("BaseTexColorChannelToggle", Float) = 0
[Enum(R,0,G,1,B,2,A,3)] _BaseTexAlphaChannelToggle ("BaseTexAlphaChannelToggle", Float) = 3
_clip ("Clip", Vector) = (0,1,0,0)
_UIMainTex ("UIMainTex", 2D) = "white" { }
_UISlide ("UISlide", Range(-0.2, 1.2)) = 0.01
_UISoftEdge ("UISoftEdge", Float) = 0.2
_UIEdgeWidth ("UIEdgeWidth", Float) = 0
_UIEdgeColor ("UIEdgeColor", Color) = (0,0,0,0)
_UIEdgeColorIntensity ("UIEdgeColor", Float) = 1
}
SubShader {
 Tags { "QUEUE" = "Geometry+1" }
 Pass {
  Tags { "QUEUE" = "Geometry+1" }
  ZWrite Off
  GpuProgramID 12757
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
uniform mediump vec4 _clip;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD0;
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
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
}


#endif
#ifdef FRAGMENT
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
uniform mediump vec4 _TintColor;
uniform mediump float _EmissionScaler;
uniform highp float _UISlide;
uniform sampler2D _UIMainTex;
uniform highp vec4 _UIMainTex_ST;
uniform highp float _UIEdgeWidth;
uniform highp vec4 _UIEdgeColor;
uniform highp float _UIEdgeColorIntensity;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
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
  highp vec4 tex2DNode1_4;
  highp vec4 col_5;
  mediump float finalAlpha_6;
  mediump vec3 finalColor_7;
  mediump vec3 temp_cast_3_8;
  mediump vec3 temp_cast_2_9;
  mediump vec3 temp_cast_1_10;
  mediump vec3 temp_cast_0_11;
  mediump vec3 wnormal_12;
  highp vec4 tex_13;
  mediump vec2 uv_MainTex_14;
  highp vec4 encode_15;
  highp vec2 tmpvar_16;
  tmpvar_16 = (xlv_TEXCOORD1.xy / xlv_TEXCOORD1.w);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_CustomDepthNormalsTexture, tmpvar_16);
  encode_15 = tmpvar_17;
  highp vec3 n_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = ((encode_15.xyz * vec3(3.5554, 3.5554, 0.0)) + vec3(-1.7777, -1.7777, 1.0));
  highp float tmpvar_20;
  tmpvar_20 = (2.0 / dot (tmpvar_19, tmpvar_19));
  n_18.xy = (tmpvar_20 * tmpvar_19.xy);
  n_18.z = (tmpvar_20 - 1.0);
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = ((xlv_TEXCOORD2 * (_ProjectionParams.z / xlv_TEXCOORD2.z)) * (dot (encode_15.zw, vec2(1.0, 0.003921569)) * _DepthScaleValue));
  highp vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = (unity_CameraToWorld * tmpvar_21).xyz;
  highp vec3 tmpvar_23;
  tmpvar_23 = (unity_WorldToObject * tmpvar_22).xyz;
  highp vec3 x_24;
  x_24 = (vec3(0.5, 0.5, 0.5) - abs(tmpvar_23));
  bvec3 tmpvar_25;
  tmpvar_25 = lessThan (x_24, vec3(0.0, 0.0, 0.0));
  if (any(tmpvar_25)) {
    discard;
  };
  highp mat3 tmpvar_26;
  tmpvar_26[0] = tmpvar_1.xyz;
  tmpvar_26[1] = tmpvar_2.xyz;
  tmpvar_26[2] = tmpvar_3.xyz;
  highp vec2 tmpvar_27;
  tmpvar_27 = (tmpvar_23.xz + vec2(0.5, 0.5));
  highp vec2 tmpvar_28;
  tmpvar_28 = ((tmpvar_27 * _MainTex_ST.xy) + _MainTex_ST.zw);
  uv_MainTex_14 = tmpvar_28;
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, uv_MainTex_14);
  tex_13 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = ((normalize(
    (tmpvar_26 * normalize(n_18))
  ) * 2.0) - 1.0);
  wnormal_12 = tmpvar_30;
  mediump float x_31;
  x_31 = (dot (wnormal_12, xlv_TEXCOORD3) - 1.0);
  if ((x_31 < 0.0)) {
    discard;
  };
  highp vec3 tmpvar_32;
  tmpvar_32 = tex_13.xxx;
  temp_cast_0_11 = tmpvar_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = tex_13.yyy;
  temp_cast_1_10 = tmpvar_33;
  highp vec3 tmpvar_34;
  tmpvar_34 = tex_13.zzz;
  temp_cast_2_9 = tmpvar_34;
  highp vec3 tmpvar_35;
  tmpvar_35 = tex_13.www;
  temp_cast_3_8 = tmpvar_35;
  finalColor_7 = vec3(0.0, 0.0, 0.0);
  if ((_BaseTexColorChannelToggle == 0.0)) {
    finalColor_7 = tex_13.xyz;
  } else {
    if ((_BaseTexColorChannelToggle == 1.0)) {
      finalColor_7 = temp_cast_0_11;
    } else {
      if ((_BaseTexColorChannelToggle == 2.0)) {
        finalColor_7 = temp_cast_1_10;
      } else {
        if ((_BaseTexColorChannelToggle == 3.0)) {
          finalColor_7 = temp_cast_2_9;
        } else {
          if ((_BaseTexColorChannelToggle == 4.0)) {
            finalColor_7 = temp_cast_3_8;
          } else {
            if ((_BaseTexColorChannelToggle == 5.0)) {
              finalColor_7 = vec3(1.0, 1.0, 1.0);
            };
          };
        };
      };
    };
  };
  finalAlpha_6 = 0.0;
  if ((_BaseTexAlphaChannelToggle == 0.0)) {
    finalAlpha_6 = tex_13.x;
  } else {
    if ((_BaseTexAlphaChannelToggle == 1.0)) {
      finalAlpha_6 = tex_13.y;
    } else {
      if ((_BaseTexAlphaChannelToggle == 2.0)) {
        finalAlpha_6 = tex_13.z;
      } else {
        if ((_BaseTexAlphaChannelToggle == 3.0)) {
          finalAlpha_6 = tex_13.w;
        };
      };
    };
  };
  mediump vec4 tmpvar_36;
  tmpvar_36.xyz = ((finalColor_7 * _TintColor.xyz) * _EmissionScaler);
  tmpvar_36.w = (finalAlpha_6 * _TintColor.w);
  col_5 = tmpvar_36;
  highp vec2 tmpvar_37;
  tmpvar_37 = (((tmpvar_27 * _UIMainTex_ST.xy) + _UIMainTex_ST.zw) + vec2(-0.5, -0.5));
  highp float tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = (min (abs(
    (tmpvar_37.y / tmpvar_37.x)
  ), 1.0) / max (abs(
    (tmpvar_37.y / tmpvar_37.x)
  ), 1.0));
  highp float tmpvar_40;
  tmpvar_40 = (tmpvar_39 * tmpvar_39);
  tmpvar_40 = (((
    ((((
      ((((-0.01213232 * tmpvar_40) + 0.05368138) * tmpvar_40) - 0.1173503)
     * tmpvar_40) + 0.1938925) * tmpvar_40) - 0.3326756)
   * tmpvar_40) + 0.9999793) * tmpvar_39);
  tmpvar_40 = (tmpvar_40 + (float(
    (abs((tmpvar_37.y / tmpvar_37.x)) > 1.0)
  ) * (
    (tmpvar_40 * -2.0)
   + 1.570796)));
  tmpvar_38 = (tmpvar_40 * sign((tmpvar_37.y / tmpvar_37.x)));
  if ((abs(tmpvar_37.x) > (1e-08 * abs(tmpvar_37.y)))) {
    if ((tmpvar_37.x < 0.0)) {
      if ((tmpvar_37.y >= 0.0)) {
        tmpvar_38 += 3.141593;
      } else {
        tmpvar_38 = (tmpvar_38 - 3.141593);
      };
    };
  } else {
    tmpvar_38 = (sign(tmpvar_37.y) * 1.570796);
  };
  highp vec2 tmpvar_41;
  tmpvar_41 = vec2(((tmpvar_38 / 6.283185) + 0.5));
  lowp vec4 tmpvar_42;
  tmpvar_42 = texture2D (_UIMainTex, tmpvar_41);
  tex2DNode1_4 = tmpvar_42;
  highp float tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = clamp (((tex2DNode1_4.x - _UISlide) / (_UISlide - _UISlide)), 0.0, 1.0);
  tmpvar_43 = (tmpvar_44 * (tmpvar_44 * (3.0 - 
    (2.0 * tmpvar_44)
  )));
  highp float tmpvar_45;
  tmpvar_45 = (_UISlide + ((1.0 - _UIEdgeWidth) * 0.01));
  highp float tmpvar_46;
  tmpvar_46 = clamp (((tex2DNode1_4.x - tmpvar_45) / (tmpvar_45 - tmpvar_45)), 0.0, 1.0);
  highp float tmpvar_47;
  tmpvar_47 = ((tmpvar_46 * (tmpvar_46 * 
    (3.0 - (2.0 * tmpvar_46))
  )) - tmpvar_43);
  col_5.xyz = ((col_5.xyz * tmpvar_43) + (tmpvar_47 * _UIEdgeColor).xyz);
  col_5.w = (col_5.w * (tmpvar_43 + (
    (tmpvar_47 * _UIEdgeColor)
   * _UIEdgeColorIntensity)).x);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _clip;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD0;
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
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
}


#endif
#ifdef FRAGMENT
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
uniform mediump vec4 _TintColor;
uniform mediump float _EmissionScaler;
uniform highp float _UISlide;
uniform sampler2D _UIMainTex;
uniform highp vec4 _UIMainTex_ST;
uniform highp float _UIEdgeWidth;
uniform highp vec4 _UIEdgeColor;
uniform highp float _UIEdgeColorIntensity;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
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
  highp vec4 tex2DNode1_4;
  highp vec4 col_5;
  mediump float finalAlpha_6;
  mediump vec3 finalColor_7;
  mediump vec3 temp_cast_3_8;
  mediump vec3 temp_cast_2_9;
  mediump vec3 temp_cast_1_10;
  mediump vec3 temp_cast_0_11;
  mediump vec3 wnormal_12;
  highp vec4 tex_13;
  mediump vec2 uv_MainTex_14;
  highp vec4 encode_15;
  highp vec2 tmpvar_16;
  tmpvar_16 = (xlv_TEXCOORD1.xy / xlv_TEXCOORD1.w);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_CustomDepthNormalsTexture, tmpvar_16);
  encode_15 = tmpvar_17;
  highp vec3 n_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = ((encode_15.xyz * vec3(3.5554, 3.5554, 0.0)) + vec3(-1.7777, -1.7777, 1.0));
  highp float tmpvar_20;
  tmpvar_20 = (2.0 / dot (tmpvar_19, tmpvar_19));
  n_18.xy = (tmpvar_20 * tmpvar_19.xy);
  n_18.z = (tmpvar_20 - 1.0);
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = ((xlv_TEXCOORD2 * (_ProjectionParams.z / xlv_TEXCOORD2.z)) * (dot (encode_15.zw, vec2(1.0, 0.003921569)) * _DepthScaleValue));
  highp vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = (unity_CameraToWorld * tmpvar_21).xyz;
  highp vec3 tmpvar_23;
  tmpvar_23 = (unity_WorldToObject * tmpvar_22).xyz;
  highp vec3 x_24;
  x_24 = (vec3(0.5, 0.5, 0.5) - abs(tmpvar_23));
  bvec3 tmpvar_25;
  tmpvar_25 = lessThan (x_24, vec3(0.0, 0.0, 0.0));
  if (any(tmpvar_25)) {
    discard;
  };
  highp mat3 tmpvar_26;
  tmpvar_26[0] = tmpvar_1.xyz;
  tmpvar_26[1] = tmpvar_2.xyz;
  tmpvar_26[2] = tmpvar_3.xyz;
  highp vec2 tmpvar_27;
  tmpvar_27 = (tmpvar_23.xz + vec2(0.5, 0.5));
  highp vec2 tmpvar_28;
  tmpvar_28 = ((tmpvar_27 * _MainTex_ST.xy) + _MainTex_ST.zw);
  uv_MainTex_14 = tmpvar_28;
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, uv_MainTex_14);
  tex_13 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = ((normalize(
    (tmpvar_26 * normalize(n_18))
  ) * 2.0) - 1.0);
  wnormal_12 = tmpvar_30;
  mediump float x_31;
  x_31 = (dot (wnormal_12, xlv_TEXCOORD3) - 1.0);
  if ((x_31 < 0.0)) {
    discard;
  };
  highp vec3 tmpvar_32;
  tmpvar_32 = tex_13.xxx;
  temp_cast_0_11 = tmpvar_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = tex_13.yyy;
  temp_cast_1_10 = tmpvar_33;
  highp vec3 tmpvar_34;
  tmpvar_34 = tex_13.zzz;
  temp_cast_2_9 = tmpvar_34;
  highp vec3 tmpvar_35;
  tmpvar_35 = tex_13.www;
  temp_cast_3_8 = tmpvar_35;
  finalColor_7 = vec3(0.0, 0.0, 0.0);
  if ((_BaseTexColorChannelToggle == 0.0)) {
    finalColor_7 = tex_13.xyz;
  } else {
    if ((_BaseTexColorChannelToggle == 1.0)) {
      finalColor_7 = temp_cast_0_11;
    } else {
      if ((_BaseTexColorChannelToggle == 2.0)) {
        finalColor_7 = temp_cast_1_10;
      } else {
        if ((_BaseTexColorChannelToggle == 3.0)) {
          finalColor_7 = temp_cast_2_9;
        } else {
          if ((_BaseTexColorChannelToggle == 4.0)) {
            finalColor_7 = temp_cast_3_8;
          } else {
            if ((_BaseTexColorChannelToggle == 5.0)) {
              finalColor_7 = vec3(1.0, 1.0, 1.0);
            };
          };
        };
      };
    };
  };
  finalAlpha_6 = 0.0;
  if ((_BaseTexAlphaChannelToggle == 0.0)) {
    finalAlpha_6 = tex_13.x;
  } else {
    if ((_BaseTexAlphaChannelToggle == 1.0)) {
      finalAlpha_6 = tex_13.y;
    } else {
      if ((_BaseTexAlphaChannelToggle == 2.0)) {
        finalAlpha_6 = tex_13.z;
      } else {
        if ((_BaseTexAlphaChannelToggle == 3.0)) {
          finalAlpha_6 = tex_13.w;
        };
      };
    };
  };
  mediump vec4 tmpvar_36;
  tmpvar_36.xyz = ((finalColor_7 * _TintColor.xyz) * _EmissionScaler);
  tmpvar_36.w = (finalAlpha_6 * _TintColor.w);
  col_5 = tmpvar_36;
  highp vec2 tmpvar_37;
  tmpvar_37 = (((tmpvar_27 * _UIMainTex_ST.xy) + _UIMainTex_ST.zw) + vec2(-0.5, -0.5));
  highp float tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = (min (abs(
    (tmpvar_37.y / tmpvar_37.x)
  ), 1.0) / max (abs(
    (tmpvar_37.y / tmpvar_37.x)
  ), 1.0));
  highp float tmpvar_40;
  tmpvar_40 = (tmpvar_39 * tmpvar_39);
  tmpvar_40 = (((
    ((((
      ((((-0.01213232 * tmpvar_40) + 0.05368138) * tmpvar_40) - 0.1173503)
     * tmpvar_40) + 0.1938925) * tmpvar_40) - 0.3326756)
   * tmpvar_40) + 0.9999793) * tmpvar_39);
  tmpvar_40 = (tmpvar_40 + (float(
    (abs((tmpvar_37.y / tmpvar_37.x)) > 1.0)
  ) * (
    (tmpvar_40 * -2.0)
   + 1.570796)));
  tmpvar_38 = (tmpvar_40 * sign((tmpvar_37.y / tmpvar_37.x)));
  if ((abs(tmpvar_37.x) > (1e-08 * abs(tmpvar_37.y)))) {
    if ((tmpvar_37.x < 0.0)) {
      if ((tmpvar_37.y >= 0.0)) {
        tmpvar_38 += 3.141593;
      } else {
        tmpvar_38 = (tmpvar_38 - 3.141593);
      };
    };
  } else {
    tmpvar_38 = (sign(tmpvar_37.y) * 1.570796);
  };
  highp vec2 tmpvar_41;
  tmpvar_41 = vec2(((tmpvar_38 / 6.283185) + 0.5));
  lowp vec4 tmpvar_42;
  tmpvar_42 = texture2D (_UIMainTex, tmpvar_41);
  tex2DNode1_4 = tmpvar_42;
  highp float tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = clamp (((tex2DNode1_4.x - _UISlide) / (_UISlide - _UISlide)), 0.0, 1.0);
  tmpvar_43 = (tmpvar_44 * (tmpvar_44 * (3.0 - 
    (2.0 * tmpvar_44)
  )));
  highp float tmpvar_45;
  tmpvar_45 = (_UISlide + ((1.0 - _UIEdgeWidth) * 0.01));
  highp float tmpvar_46;
  tmpvar_46 = clamp (((tex2DNode1_4.x - tmpvar_45) / (tmpvar_45 - tmpvar_45)), 0.0, 1.0);
  highp float tmpvar_47;
  tmpvar_47 = ((tmpvar_46 * (tmpvar_46 * 
    (3.0 - (2.0 * tmpvar_46))
  )) - tmpvar_43);
  col_5.xyz = ((col_5.xyz * tmpvar_43) + (tmpvar_47 * _UIEdgeColor).xyz);
  col_5.w = (col_5.w * (tmpvar_43 + (
    (tmpvar_47 * _UIEdgeColor)
   * _UIEdgeColorIntensity)).x);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _clip;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD0;
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
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
}


#endif
#ifdef FRAGMENT
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
uniform mediump vec4 _TintColor;
uniform mediump float _EmissionScaler;
uniform highp float _UISlide;
uniform sampler2D _UIMainTex;
uniform highp vec4 _UIMainTex_ST;
uniform highp float _UIEdgeWidth;
uniform highp vec4 _UIEdgeColor;
uniform highp float _UIEdgeColorIntensity;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
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
  highp vec4 tex2DNode1_4;
  highp vec4 col_5;
  mediump float finalAlpha_6;
  mediump vec3 finalColor_7;
  mediump vec3 temp_cast_3_8;
  mediump vec3 temp_cast_2_9;
  mediump vec3 temp_cast_1_10;
  mediump vec3 temp_cast_0_11;
  mediump vec3 wnormal_12;
  highp vec4 tex_13;
  mediump vec2 uv_MainTex_14;
  highp vec4 encode_15;
  highp vec2 tmpvar_16;
  tmpvar_16 = (xlv_TEXCOORD1.xy / xlv_TEXCOORD1.w);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_CustomDepthNormalsTexture, tmpvar_16);
  encode_15 = tmpvar_17;
  highp vec3 n_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = ((encode_15.xyz * vec3(3.5554, 3.5554, 0.0)) + vec3(-1.7777, -1.7777, 1.0));
  highp float tmpvar_20;
  tmpvar_20 = (2.0 / dot (tmpvar_19, tmpvar_19));
  n_18.xy = (tmpvar_20 * tmpvar_19.xy);
  n_18.z = (tmpvar_20 - 1.0);
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = ((xlv_TEXCOORD2 * (_ProjectionParams.z / xlv_TEXCOORD2.z)) * (dot (encode_15.zw, vec2(1.0, 0.003921569)) * _DepthScaleValue));
  highp vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = (unity_CameraToWorld * tmpvar_21).xyz;
  highp vec3 tmpvar_23;
  tmpvar_23 = (unity_WorldToObject * tmpvar_22).xyz;
  highp vec3 x_24;
  x_24 = (vec3(0.5, 0.5, 0.5) - abs(tmpvar_23));
  bvec3 tmpvar_25;
  tmpvar_25 = lessThan (x_24, vec3(0.0, 0.0, 0.0));
  if (any(tmpvar_25)) {
    discard;
  };
  highp mat3 tmpvar_26;
  tmpvar_26[0] = tmpvar_1.xyz;
  tmpvar_26[1] = tmpvar_2.xyz;
  tmpvar_26[2] = tmpvar_3.xyz;
  highp vec2 tmpvar_27;
  tmpvar_27 = (tmpvar_23.xz + vec2(0.5, 0.5));
  highp vec2 tmpvar_28;
  tmpvar_28 = ((tmpvar_27 * _MainTex_ST.xy) + _MainTex_ST.zw);
  uv_MainTex_14 = tmpvar_28;
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, uv_MainTex_14);
  tex_13 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = ((normalize(
    (tmpvar_26 * normalize(n_18))
  ) * 2.0) - 1.0);
  wnormal_12 = tmpvar_30;
  mediump float x_31;
  x_31 = (dot (wnormal_12, xlv_TEXCOORD3) - 1.0);
  if ((x_31 < 0.0)) {
    discard;
  };
  highp vec3 tmpvar_32;
  tmpvar_32 = tex_13.xxx;
  temp_cast_0_11 = tmpvar_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = tex_13.yyy;
  temp_cast_1_10 = tmpvar_33;
  highp vec3 tmpvar_34;
  tmpvar_34 = tex_13.zzz;
  temp_cast_2_9 = tmpvar_34;
  highp vec3 tmpvar_35;
  tmpvar_35 = tex_13.www;
  temp_cast_3_8 = tmpvar_35;
  finalColor_7 = vec3(0.0, 0.0, 0.0);
  if ((_BaseTexColorChannelToggle == 0.0)) {
    finalColor_7 = tex_13.xyz;
  } else {
    if ((_BaseTexColorChannelToggle == 1.0)) {
      finalColor_7 = temp_cast_0_11;
    } else {
      if ((_BaseTexColorChannelToggle == 2.0)) {
        finalColor_7 = temp_cast_1_10;
      } else {
        if ((_BaseTexColorChannelToggle == 3.0)) {
          finalColor_7 = temp_cast_2_9;
        } else {
          if ((_BaseTexColorChannelToggle == 4.0)) {
            finalColor_7 = temp_cast_3_8;
          } else {
            if ((_BaseTexColorChannelToggle == 5.0)) {
              finalColor_7 = vec3(1.0, 1.0, 1.0);
            };
          };
        };
      };
    };
  };
  finalAlpha_6 = 0.0;
  if ((_BaseTexAlphaChannelToggle == 0.0)) {
    finalAlpha_6 = tex_13.x;
  } else {
    if ((_BaseTexAlphaChannelToggle == 1.0)) {
      finalAlpha_6 = tex_13.y;
    } else {
      if ((_BaseTexAlphaChannelToggle == 2.0)) {
        finalAlpha_6 = tex_13.z;
      } else {
        if ((_BaseTexAlphaChannelToggle == 3.0)) {
          finalAlpha_6 = tex_13.w;
        };
      };
    };
  };
  mediump vec4 tmpvar_36;
  tmpvar_36.xyz = ((finalColor_7 * _TintColor.xyz) * _EmissionScaler);
  tmpvar_36.w = (finalAlpha_6 * _TintColor.w);
  col_5 = tmpvar_36;
  highp vec2 tmpvar_37;
  tmpvar_37 = (((tmpvar_27 * _UIMainTex_ST.xy) + _UIMainTex_ST.zw) + vec2(-0.5, -0.5));
  highp float tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = (min (abs(
    (tmpvar_37.y / tmpvar_37.x)
  ), 1.0) / max (abs(
    (tmpvar_37.y / tmpvar_37.x)
  ), 1.0));
  highp float tmpvar_40;
  tmpvar_40 = (tmpvar_39 * tmpvar_39);
  tmpvar_40 = (((
    ((((
      ((((-0.01213232 * tmpvar_40) + 0.05368138) * tmpvar_40) - 0.1173503)
     * tmpvar_40) + 0.1938925) * tmpvar_40) - 0.3326756)
   * tmpvar_40) + 0.9999793) * tmpvar_39);
  tmpvar_40 = (tmpvar_40 + (float(
    (abs((tmpvar_37.y / tmpvar_37.x)) > 1.0)
  ) * (
    (tmpvar_40 * -2.0)
   + 1.570796)));
  tmpvar_38 = (tmpvar_40 * sign((tmpvar_37.y / tmpvar_37.x)));
  if ((abs(tmpvar_37.x) > (1e-08 * abs(tmpvar_37.y)))) {
    if ((tmpvar_37.x < 0.0)) {
      if ((tmpvar_37.y >= 0.0)) {
        tmpvar_38 += 3.141593;
      } else {
        tmpvar_38 = (tmpvar_38 - 3.141593);
      };
    };
  } else {
    tmpvar_38 = (sign(tmpvar_37.y) * 1.570796);
  };
  highp vec2 tmpvar_41;
  tmpvar_41 = vec2(((tmpvar_38 / 6.283185) + 0.5));
  lowp vec4 tmpvar_42;
  tmpvar_42 = texture2D (_UIMainTex, tmpvar_41);
  tex2DNode1_4 = tmpvar_42;
  highp float tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = clamp (((tex2DNode1_4.x - _UISlide) / (_UISlide - _UISlide)), 0.0, 1.0);
  tmpvar_43 = (tmpvar_44 * (tmpvar_44 * (3.0 - 
    (2.0 * tmpvar_44)
  )));
  highp float tmpvar_45;
  tmpvar_45 = (_UISlide + ((1.0 - _UIEdgeWidth) * 0.01));
  highp float tmpvar_46;
  tmpvar_46 = clamp (((tex2DNode1_4.x - tmpvar_45) / (tmpvar_45 - tmpvar_45)), 0.0, 1.0);
  highp float tmpvar_47;
  tmpvar_47 = ((tmpvar_46 * (tmpvar_46 * 
    (3.0 - (2.0 * tmpvar_46))
  )) - tmpvar_43);
  col_5.xyz = ((col_5.xyz * tmpvar_43) + (tmpvar_47 * _UIEdgeColor).xyz);
  col_5.w = (col_5.w * (tmpvar_43 + (
    (tmpvar_47 * _UIEdgeColor)
   * _UIEdgeColorIntensity)).x);
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