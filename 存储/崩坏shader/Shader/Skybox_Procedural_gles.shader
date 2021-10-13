//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Skybox/Procedural" {
Properties {
[KeywordEnum(None, Simple, High Quality)] _SunDisk ("Sun", Float) = 2
_SunSize ("Sun Size", Range(0, 1)) = 0.04
_SunSizeConvergence ("Sun Size Convergence", Range(1, 10)) = 5
_AtmosphereThickness ("Atmosphere Thickness", Range(0, 5)) = 1
_SkyTint ("Sky Tint", Color) = (0.5,0.5,0.5,1)
_GroundColor ("Ground", Color) = (0.369,0.349,0.341,1)
_Exposure ("Exposure", Range(0, 8)) = 1.3
}
SubShader {
 Tags { "PreviewType" = "Skybox" "QUEUE" = "Background" "RenderType" = "Background" }
 Pass {
  Tags { "PreviewType" = "Skybox" "QUEUE" = "Background" "RenderType" = "Background" }
  ZWrite Off
  Cull Off
  GpuProgramID 20516
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "_SUNDISK_NONE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _Exposure;
uniform mediump vec3 _GroundColor;
uniform mediump vec3 _SkyTint;
uniform mediump float _AtmosphereThickness;
varying mediump float xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 cOut_1;
  mediump vec3 cIn_2;
  highp float far_3;
  highp float kKr4PI_4;
  highp float kKrESun_5;
  highp vec3 kSkyTintInGammaSpace_6;
  mediump float tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  kSkyTintInGammaSpace_6 = _SkyTint;
  highp vec3 tmpvar_12;
  tmpvar_12 = (1.0/(pow (mix (vec3(0.5, 0.42, 0.325), vec3(0.8, 0.72, 0.625), 
    (vec3(1.0, 1.0, 1.0) - kSkyTintInGammaSpace_6)
  ), vec3(4.0, 4.0, 4.0))));
  mediump float tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = pow (_AtmosphereThickness, 2.5);
  tmpvar_13 = (0.05 * tmpvar_14);
  kKrESun_5 = tmpvar_13;
  mediump float tmpvar_15;
  tmpvar_15 = (0.03141593 * tmpvar_14);
  kKr4PI_4 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_16[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_16[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesVertex.xyz));
  far_3 = 0.0;
  if ((tmpvar_17.y >= 0.0)) {
    highp vec3 frontColor_18;
    highp vec3 samplePoint_19;
    far_3 = (sqrt((
      (1.050625 + (tmpvar_17.y * tmpvar_17.y))
     - 1.0)) - tmpvar_17.y);
    highp float tmpvar_20;
    tmpvar_20 = (1.0 - (dot (tmpvar_17, vec3(0.0, 1.0001, 0.0)) / 1.0001));
    highp float tmpvar_21;
    tmpvar_21 = (exp((-0.00287 + 
      (tmpvar_20 * (0.459 + (tmpvar_20 * (3.83 + 
        (tmpvar_20 * (-6.8 + (tmpvar_20 * 5.25)))
      ))))
    )) * 0.2460318);
    highp float tmpvar_22;
    tmpvar_22 = (far_3 / 2.0);
    highp float tmpvar_23;
    tmpvar_23 = (tmpvar_22 * 40.00004);
    highp vec3 tmpvar_24;
    tmpvar_24 = (tmpvar_17 * tmpvar_22);
    highp vec3 tmpvar_25;
    tmpvar_25 = (vec3(0.0, 1.0001, 0.0) + (tmpvar_24 * 0.5));
    highp float tmpvar_26;
    tmpvar_26 = sqrt(dot (tmpvar_25, tmpvar_25));
    highp float tmpvar_27;
    tmpvar_27 = exp((160.0002 * (1.0 - tmpvar_26)));
    highp float tmpvar_28;
    tmpvar_28 = (1.0 - (dot (_WorldSpaceLightPos0.xyz, tmpvar_25) / tmpvar_26));
    highp float tmpvar_29;
    tmpvar_29 = (1.0 - (dot (tmpvar_17, tmpvar_25) / tmpvar_26));
    frontColor_18 = (exp((
      -(clamp ((tmpvar_21 + (tmpvar_27 * 
        ((0.25 * exp((-0.00287 + 
          (tmpvar_28 * (0.459 + (tmpvar_28 * (3.83 + 
            (tmpvar_28 * (-6.8 + (tmpvar_28 * 5.25)))
          ))))
        ))) - (0.25 * exp((-0.00287 + 
          (tmpvar_29 * (0.459 + (tmpvar_29 * (3.83 + 
            (tmpvar_29 * (-6.8 + (tmpvar_29 * 5.25)))
          ))))
        ))))
      )), 0.0, 50.0))
     * 
      ((tmpvar_12 * kKr4PI_4) + 0.01256637)
    )) * (tmpvar_27 * tmpvar_23));
    samplePoint_19 = (tmpvar_25 + tmpvar_24);
    highp float tmpvar_30;
    tmpvar_30 = sqrt(dot (samplePoint_19, samplePoint_19));
    highp float tmpvar_31;
    tmpvar_31 = exp((160.0002 * (1.0 - tmpvar_30)));
    highp float tmpvar_32;
    tmpvar_32 = (1.0 - (dot (_WorldSpaceLightPos0.xyz, samplePoint_19) / tmpvar_30));
    highp float tmpvar_33;
    tmpvar_33 = (1.0 - (dot (tmpvar_17, samplePoint_19) / tmpvar_30));
    frontColor_18 = (frontColor_18 + (exp(
      (-(clamp ((tmpvar_21 + 
        (tmpvar_31 * ((0.25 * exp(
          (-0.00287 + (tmpvar_32 * (0.459 + (tmpvar_32 * 
            (3.83 + (tmpvar_32 * (-6.8 + (tmpvar_32 * 5.25))))
          ))))
        )) - (0.25 * exp(
          (-0.00287 + (tmpvar_33 * (0.459 + (tmpvar_33 * 
            (3.83 + (tmpvar_33 * (-6.8 + (tmpvar_33 * 5.25))))
          ))))
        ))))
      ), 0.0, 50.0)) * ((tmpvar_12 * kKr4PI_4) + 0.01256637))
    ) * (tmpvar_31 * tmpvar_23)));
    samplePoint_19 = (samplePoint_19 + tmpvar_24);
    cIn_2 = (frontColor_18 * (tmpvar_12 * kKrESun_5));
    cOut_1 = (frontColor_18 * 0.02);
  } else {
    highp vec3 frontColor_1_34;
    far_3 = (-0.0001 / min (-0.001, tmpvar_17.y));
    highp vec3 tmpvar_35;
    tmpvar_35 = (vec3(0.0, 1.0001, 0.0) + (far_3 * tmpvar_17));
    highp float tmpvar_36;
    highp float tmpvar_37;
    tmpvar_37 = (1.0 - dot (-(tmpvar_17), tmpvar_35));
    tmpvar_36 = (0.25 * exp((-0.00287 + 
      (tmpvar_37 * (0.459 + (tmpvar_37 * (3.83 + 
        (tmpvar_37 * (-6.8 + (tmpvar_37 * 5.25)))
      ))))
    )));
    highp float tmpvar_38;
    tmpvar_38 = (1.0 - dot (_WorldSpaceLightPos0.xyz, tmpvar_35));
    highp float tmpvar_39;
    tmpvar_39 = (far_3 / 2.0);
    highp vec3 tmpvar_40;
    tmpvar_40 = (vec3(0.0, 1.0001, 0.0) + ((tmpvar_17 * tmpvar_39) * 0.5));
    highp float tmpvar_41;
    tmpvar_41 = exp((160.0002 * (1.0 - 
      sqrt(dot (tmpvar_40, tmpvar_40))
    )));
    highp vec3 tmpvar_42;
    tmpvar_42 = exp((-(
      clamp (((tmpvar_41 * (
        (0.25 * exp((-0.00287 + (tmpvar_38 * 
          (0.459 + (tmpvar_38 * (3.83 + (tmpvar_38 * 
            (-6.8 + (tmpvar_38 * 5.25))
          ))))
        ))))
       + tmpvar_36)) - (0.9996001 * tmpvar_36)), 0.0, 50.0)
    ) * (
      (tmpvar_12 * kKr4PI_4)
     + 0.01256637)));
    frontColor_1_34 = (tmpvar_42 * (tmpvar_41 * (tmpvar_39 * 40.00004)));
    cIn_2 = (frontColor_1_34 * ((tmpvar_12 * kKrESun_5) + 0.02));
    highp vec3 tmpvar_43;
    tmpvar_43 = clamp (tmpvar_42, vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0));
    cOut_1 = tmpvar_43;
  };
  tmpvar_7 = (-(tmpvar_17.y) / 0.02);
  tmpvar_8 = (_Exposure * (cIn_2 + (
    (_GroundColor * _GroundColor)
   * cOut_1)));
  mediump vec3 light_44;
  light_44 = _WorldSpaceLightPos0.xyz;
  mediump vec3 ray_45;
  ray_45 = -(tmpvar_17);
  mediump float tmpvar_46;
  tmpvar_46 = dot (light_44, ray_45);
  tmpvar_9 = (_Exposure * (cIn_2 * (0.75 + 
    (0.75 * (tmpvar_46 * tmpvar_46))
  )));
  mediump vec3 tmpvar_47;
  tmpvar_47 = sqrt(tmpvar_8);
  tmpvar_8 = tmpvar_47;
  mediump vec3 tmpvar_48;
  tmpvar_48 = sqrt(tmpvar_9);
  tmpvar_9 = tmpvar_48;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_47;
  xlv_TEXCOORD2 = tmpvar_48;
}


#endif
#ifdef FRAGMENT
varying mediump float xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = mix (xlv_TEXCOORD2, xlv_TEXCOORD1, vec3(clamp (xlv_TEXCOORD0, 0.0, 1.0)));
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_SUNDISK_NONE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _Exposure;
uniform mediump vec3 _GroundColor;
uniform mediump vec3 _SkyTint;
uniform mediump float _AtmosphereThickness;
varying mediump float xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 cOut_1;
  mediump vec3 cIn_2;
  highp float far_3;
  highp float kKr4PI_4;
  highp float kKrESun_5;
  highp vec3 kSkyTintInGammaSpace_6;
  mediump float tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  kSkyTintInGammaSpace_6 = _SkyTint;
  highp vec3 tmpvar_12;
  tmpvar_12 = (1.0/(pow (mix (vec3(0.5, 0.42, 0.325), vec3(0.8, 0.72, 0.625), 
    (vec3(1.0, 1.0, 1.0) - kSkyTintInGammaSpace_6)
  ), vec3(4.0, 4.0, 4.0))));
  mediump float tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = pow (_AtmosphereThickness, 2.5);
  tmpvar_13 = (0.05 * tmpvar_14);
  kKrESun_5 = tmpvar_13;
  mediump float tmpvar_15;
  tmpvar_15 = (0.03141593 * tmpvar_14);
  kKr4PI_4 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_16[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_16[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesVertex.xyz));
  far_3 = 0.0;
  if ((tmpvar_17.y >= 0.0)) {
    highp vec3 frontColor_18;
    highp vec3 samplePoint_19;
    far_3 = (sqrt((
      (1.050625 + (tmpvar_17.y * tmpvar_17.y))
     - 1.0)) - tmpvar_17.y);
    highp float tmpvar_20;
    tmpvar_20 = (1.0 - (dot (tmpvar_17, vec3(0.0, 1.0001, 0.0)) / 1.0001));
    highp float tmpvar_21;
    tmpvar_21 = (exp((-0.00287 + 
      (tmpvar_20 * (0.459 + (tmpvar_20 * (3.83 + 
        (tmpvar_20 * (-6.8 + (tmpvar_20 * 5.25)))
      ))))
    )) * 0.2460318);
    highp float tmpvar_22;
    tmpvar_22 = (far_3 / 2.0);
    highp float tmpvar_23;
    tmpvar_23 = (tmpvar_22 * 40.00004);
    highp vec3 tmpvar_24;
    tmpvar_24 = (tmpvar_17 * tmpvar_22);
    highp vec3 tmpvar_25;
    tmpvar_25 = (vec3(0.0, 1.0001, 0.0) + (tmpvar_24 * 0.5));
    highp float tmpvar_26;
    tmpvar_26 = sqrt(dot (tmpvar_25, tmpvar_25));
    highp float tmpvar_27;
    tmpvar_27 = exp((160.0002 * (1.0 - tmpvar_26)));
    highp float tmpvar_28;
    tmpvar_28 = (1.0 - (dot (_WorldSpaceLightPos0.xyz, tmpvar_25) / tmpvar_26));
    highp float tmpvar_29;
    tmpvar_29 = (1.0 - (dot (tmpvar_17, tmpvar_25) / tmpvar_26));
    frontColor_18 = (exp((
      -(clamp ((tmpvar_21 + (tmpvar_27 * 
        ((0.25 * exp((-0.00287 + 
          (tmpvar_28 * (0.459 + (tmpvar_28 * (3.83 + 
            (tmpvar_28 * (-6.8 + (tmpvar_28 * 5.25)))
          ))))
        ))) - (0.25 * exp((-0.00287 + 
          (tmpvar_29 * (0.459 + (tmpvar_29 * (3.83 + 
            (tmpvar_29 * (-6.8 + (tmpvar_29 * 5.25)))
          ))))
        ))))
      )), 0.0, 50.0))
     * 
      ((tmpvar_12 * kKr4PI_4) + 0.01256637)
    )) * (tmpvar_27 * tmpvar_23));
    samplePoint_19 = (tmpvar_25 + tmpvar_24);
    highp float tmpvar_30;
    tmpvar_30 = sqrt(dot (samplePoint_19, samplePoint_19));
    highp float tmpvar_31;
    tmpvar_31 = exp((160.0002 * (1.0 - tmpvar_30)));
    highp float tmpvar_32;
    tmpvar_32 = (1.0 - (dot (_WorldSpaceLightPos0.xyz, samplePoint_19) / tmpvar_30));
    highp float tmpvar_33;
    tmpvar_33 = (1.0 - (dot (tmpvar_17, samplePoint_19) / tmpvar_30));
    frontColor_18 = (frontColor_18 + (exp(
      (-(clamp ((tmpvar_21 + 
        (tmpvar_31 * ((0.25 * exp(
          (-0.00287 + (tmpvar_32 * (0.459 + (tmpvar_32 * 
            (3.83 + (tmpvar_32 * (-6.8 + (tmpvar_32 * 5.25))))
          ))))
        )) - (0.25 * exp(
          (-0.00287 + (tmpvar_33 * (0.459 + (tmpvar_33 * 
            (3.83 + (tmpvar_33 * (-6.8 + (tmpvar_33 * 5.25))))
          ))))
        ))))
      ), 0.0, 50.0)) * ((tmpvar_12 * kKr4PI_4) + 0.01256637))
    ) * (tmpvar_31 * tmpvar_23)));
    samplePoint_19 = (samplePoint_19 + tmpvar_24);
    cIn_2 = (frontColor_18 * (tmpvar_12 * kKrESun_5));
    cOut_1 = (frontColor_18 * 0.02);
  } else {
    highp vec3 frontColor_1_34;
    far_3 = (-0.0001 / min (-0.001, tmpvar_17.y));
    highp vec3 tmpvar_35;
    tmpvar_35 = (vec3(0.0, 1.0001, 0.0) + (far_3 * tmpvar_17));
    highp float tmpvar_36;
    highp float tmpvar_37;
    tmpvar_37 = (1.0 - dot (-(tmpvar_17), tmpvar_35));
    tmpvar_36 = (0.25 * exp((-0.00287 + 
      (tmpvar_37 * (0.459 + (tmpvar_37 * (3.83 + 
        (tmpvar_37 * (-6.8 + (tmpvar_37 * 5.25)))
      ))))
    )));
    highp float tmpvar_38;
    tmpvar_38 = (1.0 - dot (_WorldSpaceLightPos0.xyz, tmpvar_35));
    highp float tmpvar_39;
    tmpvar_39 = (far_3 / 2.0);
    highp vec3 tmpvar_40;
    tmpvar_40 = (vec3(0.0, 1.0001, 0.0) + ((tmpvar_17 * tmpvar_39) * 0.5));
    highp float tmpvar_41;
    tmpvar_41 = exp((160.0002 * (1.0 - 
      sqrt(dot (tmpvar_40, tmpvar_40))
    )));
    highp vec3 tmpvar_42;
    tmpvar_42 = exp((-(
      clamp (((tmpvar_41 * (
        (0.25 * exp((-0.00287 + (tmpvar_38 * 
          (0.459 + (tmpvar_38 * (3.83 + (tmpvar_38 * 
            (-6.8 + (tmpvar_38 * 5.25))
          ))))
        ))))
       + tmpvar_36)) - (0.9996001 * tmpvar_36)), 0.0, 50.0)
    ) * (
      (tmpvar_12 * kKr4PI_4)
     + 0.01256637)));
    frontColor_1_34 = (tmpvar_42 * (tmpvar_41 * (tmpvar_39 * 40.00004)));
    cIn_2 = (frontColor_1_34 * ((tmpvar_12 * kKrESun_5) + 0.02));
    highp vec3 tmpvar_43;
    tmpvar_43 = clamp (tmpvar_42, vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0));
    cOut_1 = tmpvar_43;
  };
  tmpvar_7 = (-(tmpvar_17.y) / 0.02);
  tmpvar_8 = (_Exposure * (cIn_2 + (
    (_GroundColor * _GroundColor)
   * cOut_1)));
  mediump vec3 light_44;
  light_44 = _WorldSpaceLightPos0.xyz;
  mediump vec3 ray_45;
  ray_45 = -(tmpvar_17);
  mediump float tmpvar_46;
  tmpvar_46 = dot (light_44, ray_45);
  tmpvar_9 = (_Exposure * (cIn_2 * (0.75 + 
    (0.75 * (tmpvar_46 * tmpvar_46))
  )));
  mediump vec3 tmpvar_47;
  tmpvar_47 = sqrt(tmpvar_8);
  tmpvar_8 = tmpvar_47;
  mediump vec3 tmpvar_48;
  tmpvar_48 = sqrt(tmpvar_9);
  tmpvar_9 = tmpvar_48;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_47;
  xlv_TEXCOORD2 = tmpvar_48;
}


#endif
#ifdef FRAGMENT
varying mediump float xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = mix (xlv_TEXCOORD2, xlv_TEXCOORD1, vec3(clamp (xlv_TEXCOORD0, 0.0, 1.0)));
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_SUNDISK_NONE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _Exposure;
uniform mediump vec3 _GroundColor;
uniform mediump vec3 _SkyTint;
uniform mediump float _AtmosphereThickness;
varying mediump float xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 cOut_1;
  mediump vec3 cIn_2;
  highp float far_3;
  highp float kKr4PI_4;
  highp float kKrESun_5;
  highp vec3 kSkyTintInGammaSpace_6;
  mediump float tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  kSkyTintInGammaSpace_6 = _SkyTint;
  highp vec3 tmpvar_12;
  tmpvar_12 = (1.0/(pow (mix (vec3(0.5, 0.42, 0.325), vec3(0.8, 0.72, 0.625), 
    (vec3(1.0, 1.0, 1.0) - kSkyTintInGammaSpace_6)
  ), vec3(4.0, 4.0, 4.0))));
  mediump float tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = pow (_AtmosphereThickness, 2.5);
  tmpvar_13 = (0.05 * tmpvar_14);
  kKrESun_5 = tmpvar_13;
  mediump float tmpvar_15;
  tmpvar_15 = (0.03141593 * tmpvar_14);
  kKr4PI_4 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_16[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_16[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesVertex.xyz));
  far_3 = 0.0;
  if ((tmpvar_17.y >= 0.0)) {
    highp vec3 frontColor_18;
    highp vec3 samplePoint_19;
    far_3 = (sqrt((
      (1.050625 + (tmpvar_17.y * tmpvar_17.y))
     - 1.0)) - tmpvar_17.y);
    highp float tmpvar_20;
    tmpvar_20 = (1.0 - (dot (tmpvar_17, vec3(0.0, 1.0001, 0.0)) / 1.0001));
    highp float tmpvar_21;
    tmpvar_21 = (exp((-0.00287 + 
      (tmpvar_20 * (0.459 + (tmpvar_20 * (3.83 + 
        (tmpvar_20 * (-6.8 + (tmpvar_20 * 5.25)))
      ))))
    )) * 0.2460318);
    highp float tmpvar_22;
    tmpvar_22 = (far_3 / 2.0);
    highp float tmpvar_23;
    tmpvar_23 = (tmpvar_22 * 40.00004);
    highp vec3 tmpvar_24;
    tmpvar_24 = (tmpvar_17 * tmpvar_22);
    highp vec3 tmpvar_25;
    tmpvar_25 = (vec3(0.0, 1.0001, 0.0) + (tmpvar_24 * 0.5));
    highp float tmpvar_26;
    tmpvar_26 = sqrt(dot (tmpvar_25, tmpvar_25));
    highp float tmpvar_27;
    tmpvar_27 = exp((160.0002 * (1.0 - tmpvar_26)));
    highp float tmpvar_28;
    tmpvar_28 = (1.0 - (dot (_WorldSpaceLightPos0.xyz, tmpvar_25) / tmpvar_26));
    highp float tmpvar_29;
    tmpvar_29 = (1.0 - (dot (tmpvar_17, tmpvar_25) / tmpvar_26));
    frontColor_18 = (exp((
      -(clamp ((tmpvar_21 + (tmpvar_27 * 
        ((0.25 * exp((-0.00287 + 
          (tmpvar_28 * (0.459 + (tmpvar_28 * (3.83 + 
            (tmpvar_28 * (-6.8 + (tmpvar_28 * 5.25)))
          ))))
        ))) - (0.25 * exp((-0.00287 + 
          (tmpvar_29 * (0.459 + (tmpvar_29 * (3.83 + 
            (tmpvar_29 * (-6.8 + (tmpvar_29 * 5.25)))
          ))))
        ))))
      )), 0.0, 50.0))
     * 
      ((tmpvar_12 * kKr4PI_4) + 0.01256637)
    )) * (tmpvar_27 * tmpvar_23));
    samplePoint_19 = (tmpvar_25 + tmpvar_24);
    highp float tmpvar_30;
    tmpvar_30 = sqrt(dot (samplePoint_19, samplePoint_19));
    highp float tmpvar_31;
    tmpvar_31 = exp((160.0002 * (1.0 - tmpvar_30)));
    highp float tmpvar_32;
    tmpvar_32 = (1.0 - (dot (_WorldSpaceLightPos0.xyz, samplePoint_19) / tmpvar_30));
    highp float tmpvar_33;
    tmpvar_33 = (1.0 - (dot (tmpvar_17, samplePoint_19) / tmpvar_30));
    frontColor_18 = (frontColor_18 + (exp(
      (-(clamp ((tmpvar_21 + 
        (tmpvar_31 * ((0.25 * exp(
          (-0.00287 + (tmpvar_32 * (0.459 + (tmpvar_32 * 
            (3.83 + (tmpvar_32 * (-6.8 + (tmpvar_32 * 5.25))))
          ))))
        )) - (0.25 * exp(
          (-0.00287 + (tmpvar_33 * (0.459 + (tmpvar_33 * 
            (3.83 + (tmpvar_33 * (-6.8 + (tmpvar_33 * 5.25))))
          ))))
        ))))
      ), 0.0, 50.0)) * ((tmpvar_12 * kKr4PI_4) + 0.01256637))
    ) * (tmpvar_31 * tmpvar_23)));
    samplePoint_19 = (samplePoint_19 + tmpvar_24);
    cIn_2 = (frontColor_18 * (tmpvar_12 * kKrESun_5));
    cOut_1 = (frontColor_18 * 0.02);
  } else {
    highp vec3 frontColor_1_34;
    far_3 = (-0.0001 / min (-0.001, tmpvar_17.y));
    highp vec3 tmpvar_35;
    tmpvar_35 = (vec3(0.0, 1.0001, 0.0) + (far_3 * tmpvar_17));
    highp float tmpvar_36;
    highp float tmpvar_37;
    tmpvar_37 = (1.0 - dot (-(tmpvar_17), tmpvar_35));
    tmpvar_36 = (0.25 * exp((-0.00287 + 
      (tmpvar_37 * (0.459 + (tmpvar_37 * (3.83 + 
        (tmpvar_37 * (-6.8 + (tmpvar_37 * 5.25)))
      ))))
    )));
    highp float tmpvar_38;
    tmpvar_38 = (1.0 - dot (_WorldSpaceLightPos0.xyz, tmpvar_35));
    highp float tmpvar_39;
    tmpvar_39 = (far_3 / 2.0);
    highp vec3 tmpvar_40;
    tmpvar_40 = (vec3(0.0, 1.0001, 0.0) + ((tmpvar_17 * tmpvar_39) * 0.5));
    highp float tmpvar_41;
    tmpvar_41 = exp((160.0002 * (1.0 - 
      sqrt(dot (tmpvar_40, tmpvar_40))
    )));
    highp vec3 tmpvar_42;
    tmpvar_42 = exp((-(
      clamp (((tmpvar_41 * (
        (0.25 * exp((-0.00287 + (tmpvar_38 * 
          (0.459 + (tmpvar_38 * (3.83 + (tmpvar_38 * 
            (-6.8 + (tmpvar_38 * 5.25))
          ))))
        ))))
       + tmpvar_36)) - (0.9996001 * tmpvar_36)), 0.0, 50.0)
    ) * (
      (tmpvar_12 * kKr4PI_4)
     + 0.01256637)));
    frontColor_1_34 = (tmpvar_42 * (tmpvar_41 * (tmpvar_39 * 40.00004)));
    cIn_2 = (frontColor_1_34 * ((tmpvar_12 * kKrESun_5) + 0.02));
    highp vec3 tmpvar_43;
    tmpvar_43 = clamp (tmpvar_42, vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0));
    cOut_1 = tmpvar_43;
  };
  tmpvar_7 = (-(tmpvar_17.y) / 0.02);
  tmpvar_8 = (_Exposure * (cIn_2 + (
    (_GroundColor * _GroundColor)
   * cOut_1)));
  mediump vec3 light_44;
  light_44 = _WorldSpaceLightPos0.xyz;
  mediump vec3 ray_45;
  ray_45 = -(tmpvar_17);
  mediump float tmpvar_46;
  tmpvar_46 = dot (light_44, ray_45);
  tmpvar_9 = (_Exposure * (cIn_2 * (0.75 + 
    (0.75 * (tmpvar_46 * tmpvar_46))
  )));
  mediump vec3 tmpvar_47;
  tmpvar_47 = sqrt(tmpvar_8);
  tmpvar_8 = tmpvar_47;
  mediump vec3 tmpvar_48;
  tmpvar_48 = sqrt(tmpvar_9);
  tmpvar_9 = tmpvar_48;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_47;
  xlv_TEXCOORD2 = tmpvar_48;
}


#endif
#ifdef FRAGMENT
varying mediump float xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = mix (xlv_TEXCOORD2, xlv_TEXCOORD1, vec3(clamp (xlv_TEXCOORD0, 0.0, 1.0)));
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_SUNDISK_SIMPLE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _LightColor0;
uniform mediump float _Exposure;
uniform mediump vec3 _GroundColor;
uniform mediump vec3 _SkyTint;
uniform mediump float _AtmosphereThickness;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump float lightColorIntensity_1;
  mediump vec3 cOut_2;
  mediump vec3 cIn_3;
  highp float far_4;
  highp float kKr4PI_5;
  highp float kKrESun_6;
  highp vec3 kSkyTintInGammaSpace_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  mediump vec3 tmpvar_10;
  mediump vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  kSkyTintInGammaSpace_7 = _SkyTint;
  highp vec3 tmpvar_14;
  tmpvar_14 = (1.0/(pow (mix (vec3(0.5, 0.42, 0.325), vec3(0.8, 0.72, 0.625), 
    (vec3(1.0, 1.0, 1.0) - kSkyTintInGammaSpace_7)
  ), vec3(4.0, 4.0, 4.0))));
  mediump float tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = pow (_AtmosphereThickness, 2.5);
  tmpvar_15 = (0.05 * tmpvar_16);
  kKrESun_6 = tmpvar_15;
  mediump float tmpvar_17;
  tmpvar_17 = (0.03141593 * tmpvar_16);
  kKr4PI_5 = tmpvar_17;
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_18[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_18[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((tmpvar_18 * _glesVertex.xyz));
  far_4 = 0.0;
  if ((tmpvar_19.y >= 0.0)) {
    highp vec3 frontColor_20;
    highp vec3 samplePoint_21;
    far_4 = (sqrt((
      (1.050625 + (tmpvar_19.y * tmpvar_19.y))
     - 1.0)) - tmpvar_19.y);
    highp float tmpvar_22;
    tmpvar_22 = (1.0 - (dot (tmpvar_19, vec3(0.0, 1.0001, 0.0)) / 1.0001));
    highp float tmpvar_23;
    tmpvar_23 = (exp((-0.00287 + 
      (tmpvar_22 * (0.459 + (tmpvar_22 * (3.83 + 
        (tmpvar_22 * (-6.8 + (tmpvar_22 * 5.25)))
      ))))
    )) * 0.2460318);
    highp float tmpvar_24;
    tmpvar_24 = (far_4 / 2.0);
    highp float tmpvar_25;
    tmpvar_25 = (tmpvar_24 * 40.00004);
    highp vec3 tmpvar_26;
    tmpvar_26 = (tmpvar_19 * tmpvar_24);
    highp vec3 tmpvar_27;
    tmpvar_27 = (vec3(0.0, 1.0001, 0.0) + (tmpvar_26 * 0.5));
    highp float tmpvar_28;
    tmpvar_28 = sqrt(dot (tmpvar_27, tmpvar_27));
    highp float tmpvar_29;
    tmpvar_29 = exp((160.0002 * (1.0 - tmpvar_28)));
    highp float tmpvar_30;
    tmpvar_30 = (1.0 - (dot (_WorldSpaceLightPos0.xyz, tmpvar_27) / tmpvar_28));
    highp float tmpvar_31;
    tmpvar_31 = (1.0 - (dot (tmpvar_19, tmpvar_27) / tmpvar_28));
    frontColor_20 = (exp((
      -(clamp ((tmpvar_23 + (tmpvar_29 * 
        ((0.25 * exp((-0.00287 + 
          (tmpvar_30 * (0.459 + (tmpvar_30 * (3.83 + 
            (tmpvar_30 * (-6.8 + (tmpvar_30 * 5.25)))
          ))))
        ))) - (0.25 * exp((-0.00287 + 
          (tmpvar_31 * (0.459 + (tmpvar_31 * (3.83 + 
            (tmpvar_31 * (-6.8 + (tmpvar_31 * 5.25)))
          ))))
        ))))
      )), 0.0, 50.0))
     * 
      ((tmpvar_14 * kKr4PI_5) + 0.01256637)
    )) * (tmpvar_29 * tmpvar_25));
    samplePoint_21 = (tmpvar_27 + tmpvar_26);
    highp float tmpvar_32;
    tmpvar_32 = sqrt(dot (samplePoint_21, samplePoint_21));
    highp float tmpvar_33;
    tmpvar_33 = exp((160.0002 * (1.0 - tmpvar_32)));
    highp float tmpvar_34;
    tmpvar_34 = (1.0 - (dot (_WorldSpaceLightPos0.xyz, samplePoint_21) / tmpvar_32));
    highp float tmpvar_35;
    tmpvar_35 = (1.0 - (dot (tmpvar_19, samplePoint_21) / tmpvar_32));
    frontColor_20 = (frontColor_20 + (exp(
      (-(clamp ((tmpvar_23 + 
        (tmpvar_33 * ((0.25 * exp(
          (-0.00287 + (tmpvar_34 * (0.459 + (tmpvar_34 * 
            (3.83 + (tmpvar_34 * (-6.8 + (tmpvar_34 * 5.25))))
          ))))
        )) - (0.25 * exp(
          (-0.00287 + (tmpvar_35 * (0.459 + (tmpvar_35 * 
            (3.83 + (tmpvar_35 * (-6.8 + (tmpvar_35 * 5.25))))
          ))))
        ))))
      ), 0.0, 50.0)) * ((tmpvar_14 * kKr4PI_5) + 0.01256637))
    ) * (tmpvar_33 * tmpvar_25)));
    samplePoint_21 = (samplePoint_21 + tmpvar_26);
    cIn_3 = (frontColor_20 * (tmpvar_14 * kKrESun_6));
    cOut_2 = (frontColor_20 * 0.02);
  } else {
    highp vec3 frontColor_1_36;
    far_4 = (-0.0001 / min (-0.001, tmpvar_19.y));
    highp vec3 tmpvar_37;
    tmpvar_37 = (vec3(0.0, 1.0001, 0.0) + (far_4 * tmpvar_19));
    highp float tmpvar_38;
    highp float tmpvar_39;
    tmpvar_39 = (1.0 - dot (-(tmpvar_19), tmpvar_37));
    tmpvar_38 = (0.25 * exp((-0.00287 + 
      (tmpvar_39 * (0.459 + (tmpvar_39 * (3.83 + 
        (tmpvar_39 * (-6.8 + (tmpvar_39 * 5.25)))
      ))))
    )));
    highp float tmpvar_40;
    tmpvar_40 = (1.0 - dot (_WorldSpaceLightPos0.xyz, tmpvar_37));
    highp float tmpvar_41;
    tmpvar_41 = (far_4 / 2.0);
    highp vec3 tmpvar_42;
    tmpvar_42 = (vec3(0.0, 1.0001, 0.0) + ((tmpvar_19 * tmpvar_41) * 0.5));
    highp float tmpvar_43;
    tmpvar_43 = exp((160.0002 * (1.0 - 
      sqrt(dot (tmpvar_42, tmpvar_42))
    )));
    highp vec3 tmpvar_44;
    tmpvar_44 = exp((-(
      clamp (((tmpvar_43 * (
        (0.25 * exp((-0.00287 + (tmpvar_40 * 
          (0.459 + (tmpvar_40 * (3.83 + (tmpvar_40 * 
            (-6.8 + (tmpvar_40 * 5.25))
          ))))
        ))))
       + tmpvar_38)) - (0.9996001 * tmpvar_38)), 0.0, 50.0)
    ) * (
      (tmpvar_14 * kKr4PI_5)
     + 0.01256637)));
    frontColor_1_36 = (tmpvar_44 * (tmpvar_43 * (tmpvar_41 * 40.00004)));
    cIn_3 = (frontColor_1_36 * ((tmpvar_14 * kKrESun_6) + 0.02));
    highp vec3 tmpvar_45;
    tmpvar_45 = clamp (tmpvar_44, vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0));
    cOut_2 = tmpvar_45;
  };
  tmpvar_8 = -(tmpvar_19);
  tmpvar_9 = (_Exposure * (cIn_3 + (
    (_GroundColor * _GroundColor)
   * cOut_2)));
  mediump vec3 light_46;
  light_46 = _WorldSpaceLightPos0.xyz;
  mediump vec3 ray_47;
  ray_47 = -(tmpvar_19);
  mediump float tmpvar_48;
  tmpvar_48 = dot (light_46, ray_47);
  tmpvar_10 = (_Exposure * (cIn_3 * (0.75 + 
    (0.75 * (tmpvar_48 * tmpvar_48))
  )));
  lowp float tmpvar_49;
  tmpvar_49 = clamp (sqrt(dot (_LightColor0.xyz, _LightColor0.xyz)), 0.25, 1.0);
  lightColorIntensity_1 = tmpvar_49;
  tmpvar_11 = (((27.0 * 
    clamp ((cOut_2 * 8000.0), 0.0, 1.0)
  ) * _LightColor0.xyz) / lightColorIntensity_1);
  mediump vec3 tmpvar_50;
  tmpvar_50 = sqrt(tmpvar_9);
  tmpvar_9 = tmpvar_50;
  mediump vec3 tmpvar_51;
  tmpvar_51 = sqrt(tmpvar_10);
  tmpvar_10 = tmpvar_51;
  mediump vec3 tmpvar_52;
  tmpvar_52 = sqrt(tmpvar_11);
  tmpvar_11 = tmpvar_52;
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_8;
  xlv_TEXCOORD1 = tmpvar_50;
  xlv_TEXCOORD2 = tmpvar_51;
  xlv_TEXCOORD3 = tmpvar_52;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _SunSize;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 col_1;
  mediump float tmpvar_2;
  tmpvar_2 = (xlv_TEXCOORD0.y / 0.02);
  mediump vec3 tmpvar_3;
  tmpvar_3 = mix (xlv_TEXCOORD2, xlv_TEXCOORD1, vec3(clamp (tmpvar_2, 0.0, 1.0)));
  col_1 = tmpvar_3;
  if ((tmpvar_2 < 0.0)) {
    mediump vec3 lightPos_4;
    lightPos_4 = _WorldSpaceLightPos0.xyz;
    mediump vec3 tmpvar_5;
    tmpvar_5 = (lightPos_4 - -(xlv_TEXCOORD0));
    mediump float tmpvar_6;
    tmpvar_6 = clamp ((sqrt(
      dot (tmpvar_5, tmpvar_5)
    ) / _SunSize), 0.0, 1.0);
    mediump float tmpvar_7;
    tmpvar_7 = (1.0 - (tmpvar_6 * (tmpvar_6 * 
      (3.0 - (2.0 * tmpvar_6))
    )));
    col_1 = (tmpvar_3 + (xlv_TEXCOORD3 * (tmpvar_7 * tmpvar_7)));
  };
  mediump vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = col_1;
  gl_FragData[0] = tmpvar_8;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_SUNDISK_SIMPLE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _LightColor0;
uniform mediump float _Exposure;
uniform mediump vec3 _GroundColor;
uniform mediump vec3 _SkyTint;
uniform mediump float _AtmosphereThickness;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump float lightColorIntensity_1;
  mediump vec3 cOut_2;
  mediump vec3 cIn_3;
  highp float far_4;
  highp float kKr4PI_5;
  highp float kKrESun_6;
  highp vec3 kSkyTintInGammaSpace_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  mediump vec3 tmpvar_10;
  mediump vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  kSkyTintInGammaSpace_7 = _SkyTint;
  highp vec3 tmpvar_14;
  tmpvar_14 = (1.0/(pow (mix (vec3(0.5, 0.42, 0.325), vec3(0.8, 0.72, 0.625), 
    (vec3(1.0, 1.0, 1.0) - kSkyTintInGammaSpace_7)
  ), vec3(4.0, 4.0, 4.0))));
  mediump float tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = pow (_AtmosphereThickness, 2.5);
  tmpvar_15 = (0.05 * tmpvar_16);
  kKrESun_6 = tmpvar_15;
  mediump float tmpvar_17;
  tmpvar_17 = (0.03141593 * tmpvar_16);
  kKr4PI_5 = tmpvar_17;
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_18[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_18[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((tmpvar_18 * _glesVertex.xyz));
  far_4 = 0.0;
  if ((tmpvar_19.y >= 0.0)) {
    highp vec3 frontColor_20;
    highp vec3 samplePoint_21;
    far_4 = (sqrt((
      (1.050625 + (tmpvar_19.y * tmpvar_19.y))
     - 1.0)) - tmpvar_19.y);
    highp float tmpvar_22;
    tmpvar_22 = (1.0 - (dot (tmpvar_19, vec3(0.0, 1.0001, 0.0)) / 1.0001));
    highp float tmpvar_23;
    tmpvar_23 = (exp((-0.00287 + 
      (tmpvar_22 * (0.459 + (tmpvar_22 * (3.83 + 
        (tmpvar_22 * (-6.8 + (tmpvar_22 * 5.25)))
      ))))
    )) * 0.2460318);
    highp float tmpvar_24;
    tmpvar_24 = (far_4 / 2.0);
    highp float tmpvar_25;
    tmpvar_25 = (tmpvar_24 * 40.00004);
    highp vec3 tmpvar_26;
    tmpvar_26 = (tmpvar_19 * tmpvar_24);
    highp vec3 tmpvar_27;
    tmpvar_27 = (vec3(0.0, 1.0001, 0.0) + (tmpvar_26 * 0.5));
    highp float tmpvar_28;
    tmpvar_28 = sqrt(dot (tmpvar_27, tmpvar_27));
    highp float tmpvar_29;
    tmpvar_29 = exp((160.0002 * (1.0 - tmpvar_28)));
    highp float tmpvar_30;
    tmpvar_30 = (1.0 - (dot (_WorldSpaceLightPos0.xyz, tmpvar_27) / tmpvar_28));
    highp float tmpvar_31;
    tmpvar_31 = (1.0 - (dot (tmpvar_19, tmpvar_27) / tmpvar_28));
    frontColor_20 = (exp((
      -(clamp ((tmpvar_23 + (tmpvar_29 * 
        ((0.25 * exp((-0.00287 + 
          (tmpvar_30 * (0.459 + (tmpvar_30 * (3.83 + 
            (tmpvar_30 * (-6.8 + (tmpvar_30 * 5.25)))
          ))))
        ))) - (0.25 * exp((-0.00287 + 
          (tmpvar_31 * (0.459 + (tmpvar_31 * (3.83 + 
            (tmpvar_31 * (-6.8 + (tmpvar_31 * 5.25)))
          ))))
        ))))
      )), 0.0, 50.0))
     * 
      ((tmpvar_14 * kKr4PI_5) + 0.01256637)
    )) * (tmpvar_29 * tmpvar_25));
    samplePoint_21 = (tmpvar_27 + tmpvar_26);
    highp float tmpvar_32;
    tmpvar_32 = sqrt(dot (samplePoint_21, samplePoint_21));
    highp float tmpvar_33;
    tmpvar_33 = exp((160.0002 * (1.0 - tmpvar_32)));
    highp float tmpvar_34;
    tmpvar_34 = (1.0 - (dot (_WorldSpaceLightPos0.xyz, samplePoint_21) / tmpvar_32));
    highp float tmpvar_35;
    tmpvar_35 = (1.0 - (dot (tmpvar_19, samplePoint_21) / tmpvar_32));
    frontColor_20 = (frontColor_20 + (exp(
      (-(clamp ((tmpvar_23 + 
        (tmpvar_33 * ((0.25 * exp(
          (-0.00287 + (tmpvar_34 * (0.459 + (tmpvar_34 * 
            (3.83 + (tmpvar_34 * (-6.8 + (tmpvar_34 * 5.25))))
          ))))
        )) - (0.25 * exp(
          (-0.00287 + (tmpvar_35 * (0.459 + (tmpvar_35 * 
            (3.83 + (tmpvar_35 * (-6.8 + (tmpvar_35 * 5.25))))
          ))))
        ))))
      ), 0.0, 50.0)) * ((tmpvar_14 * kKr4PI_5) + 0.01256637))
    ) * (tmpvar_33 * tmpvar_25)));
    samplePoint_21 = (samplePoint_21 + tmpvar_26);
    cIn_3 = (frontColor_20 * (tmpvar_14 * kKrESun_6));
    cOut_2 = (frontColor_20 * 0.02);
  } else {
    highp vec3 frontColor_1_36;
    far_4 = (-0.0001 / min (-0.001, tmpvar_19.y));
    highp vec3 tmpvar_37;
    tmpvar_37 = (vec3(0.0, 1.0001, 0.0) + (far_4 * tmpvar_19));
    highp float tmpvar_38;
    highp float tmpvar_39;
    tmpvar_39 = (1.0 - dot (-(tmpvar_19), tmpvar_37));
    tmpvar_38 = (0.25 * exp((-0.00287 + 
      (tmpvar_39 * (0.459 + (tmpvar_39 * (3.83 + 
        (tmpvar_39 * (-6.8 + (tmpvar_39 * 5.25)))
      ))))
    )));
    highp float tmpvar_40;
    tmpvar_40 = (1.0 - dot (_WorldSpaceLightPos0.xyz, tmpvar_37));
    highp float tmpvar_41;
    tmpvar_41 = (far_4 / 2.0);
    highp vec3 tmpvar_42;
    tmpvar_42 = (vec3(0.0, 1.0001, 0.0) + ((tmpvar_19 * tmpvar_41) * 0.5));
    highp float tmpvar_43;
    tmpvar_43 = exp((160.0002 * (1.0 - 
      sqrt(dot (tmpvar_42, tmpvar_42))
    )));
    highp vec3 tmpvar_44;
    tmpvar_44 = exp((-(
      clamp (((tmpvar_43 * (
        (0.25 * exp((-0.00287 + (tmpvar_40 * 
          (0.459 + (tmpvar_40 * (3.83 + (tmpvar_40 * 
            (-6.8 + (tmpvar_40 * 5.25))
          ))))
        ))))
       + tmpvar_38)) - (0.9996001 * tmpvar_38)), 0.0, 50.0)
    ) * (
      (tmpvar_14 * kKr4PI_5)
     + 0.01256637)));
    frontColor_1_36 = (tmpvar_44 * (tmpvar_43 * (tmpvar_41 * 40.00004)));
    cIn_3 = (frontColor_1_36 * ((tmpvar_14 * kKrESun_6) + 0.02));
    highp vec3 tmpvar_45;
    tmpvar_45 = clamp (tmpvar_44, vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0));
    cOut_2 = tmpvar_45;
  };
  tmpvar_8 = -(tmpvar_19);
  tmpvar_9 = (_Exposure * (cIn_3 + (
    (_GroundColor * _GroundColor)
   * cOut_2)));
  mediump vec3 light_46;
  light_46 = _WorldSpaceLightPos0.xyz;
  mediump vec3 ray_47;
  ray_47 = -(tmpvar_19);
  mediump float tmpvar_48;
  tmpvar_48 = dot (light_46, ray_47);
  tmpvar_10 = (_Exposure * (cIn_3 * (0.75 + 
    (0.75 * (tmpvar_48 * tmpvar_48))
  )));
  lowp float tmpvar_49;
  tmpvar_49 = clamp (sqrt(dot (_LightColor0.xyz, _LightColor0.xyz)), 0.25, 1.0);
  lightColorIntensity_1 = tmpvar_49;
  tmpvar_11 = (((27.0 * 
    clamp ((cOut_2 * 8000.0), 0.0, 1.0)
  ) * _LightColor0.xyz) / lightColorIntensity_1);
  mediump vec3 tmpvar_50;
  tmpvar_50 = sqrt(tmpvar_9);
  tmpvar_9 = tmpvar_50;
  mediump vec3 tmpvar_51;
  tmpvar_51 = sqrt(tmpvar_10);
  tmpvar_10 = tmpvar_51;
  mediump vec3 tmpvar_52;
  tmpvar_52 = sqrt(tmpvar_11);
  tmpvar_11 = tmpvar_52;
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_8;
  xlv_TEXCOORD1 = tmpvar_50;
  xlv_TEXCOORD2 = tmpvar_51;
  xlv_TEXCOORD3 = tmpvar_52;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _SunSize;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 col_1;
  mediump float tmpvar_2;
  tmpvar_2 = (xlv_TEXCOORD0.y / 0.02);
  mediump vec3 tmpvar_3;
  tmpvar_3 = mix (xlv_TEXCOORD2, xlv_TEXCOORD1, vec3(clamp (tmpvar_2, 0.0, 1.0)));
  col_1 = tmpvar_3;
  if ((tmpvar_2 < 0.0)) {
    mediump vec3 lightPos_4;
    lightPos_4 = _WorldSpaceLightPos0.xyz;
    mediump vec3 tmpvar_5;
    tmpvar_5 = (lightPos_4 - -(xlv_TEXCOORD0));
    mediump float tmpvar_6;
    tmpvar_6 = clamp ((sqrt(
      dot (tmpvar_5, tmpvar_5)
    ) / _SunSize), 0.0, 1.0);
    mediump float tmpvar_7;
    tmpvar_7 = (1.0 - (tmpvar_6 * (tmpvar_6 * 
      (3.0 - (2.0 * tmpvar_6))
    )));
    col_1 = (tmpvar_3 + (xlv_TEXCOORD3 * (tmpvar_7 * tmpvar_7)));
  };
  mediump vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = col_1;
  gl_FragData[0] = tmpvar_8;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_SUNDISK_SIMPLE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _LightColor0;
uniform mediump float _Exposure;
uniform mediump vec3 _GroundColor;
uniform mediump vec3 _SkyTint;
uniform mediump float _AtmosphereThickness;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump float lightColorIntensity_1;
  mediump vec3 cOut_2;
  mediump vec3 cIn_3;
  highp float far_4;
  highp float kKr4PI_5;
  highp float kKrESun_6;
  highp vec3 kSkyTintInGammaSpace_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  mediump vec3 tmpvar_10;
  mediump vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  kSkyTintInGammaSpace_7 = _SkyTint;
  highp vec3 tmpvar_14;
  tmpvar_14 = (1.0/(pow (mix (vec3(0.5, 0.42, 0.325), vec3(0.8, 0.72, 0.625), 
    (vec3(1.0, 1.0, 1.0) - kSkyTintInGammaSpace_7)
  ), vec3(4.0, 4.0, 4.0))));
  mediump float tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = pow (_AtmosphereThickness, 2.5);
  tmpvar_15 = (0.05 * tmpvar_16);
  kKrESun_6 = tmpvar_15;
  mediump float tmpvar_17;
  tmpvar_17 = (0.03141593 * tmpvar_16);
  kKr4PI_5 = tmpvar_17;
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_18[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_18[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((tmpvar_18 * _glesVertex.xyz));
  far_4 = 0.0;
  if ((tmpvar_19.y >= 0.0)) {
    highp vec3 frontColor_20;
    highp vec3 samplePoint_21;
    far_4 = (sqrt((
      (1.050625 + (tmpvar_19.y * tmpvar_19.y))
     - 1.0)) - tmpvar_19.y);
    highp float tmpvar_22;
    tmpvar_22 = (1.0 - (dot (tmpvar_19, vec3(0.0, 1.0001, 0.0)) / 1.0001));
    highp float tmpvar_23;
    tmpvar_23 = (exp((-0.00287 + 
      (tmpvar_22 * (0.459 + (tmpvar_22 * (3.83 + 
        (tmpvar_22 * (-6.8 + (tmpvar_22 * 5.25)))
      ))))
    )) * 0.2460318);
    highp float tmpvar_24;
    tmpvar_24 = (far_4 / 2.0);
    highp float tmpvar_25;
    tmpvar_25 = (tmpvar_24 * 40.00004);
    highp vec3 tmpvar_26;
    tmpvar_26 = (tmpvar_19 * tmpvar_24);
    highp vec3 tmpvar_27;
    tmpvar_27 = (vec3(0.0, 1.0001, 0.0) + (tmpvar_26 * 0.5));
    highp float tmpvar_28;
    tmpvar_28 = sqrt(dot (tmpvar_27, tmpvar_27));
    highp float tmpvar_29;
    tmpvar_29 = exp((160.0002 * (1.0 - tmpvar_28)));
    highp float tmpvar_30;
    tmpvar_30 = (1.0 - (dot (_WorldSpaceLightPos0.xyz, tmpvar_27) / tmpvar_28));
    highp float tmpvar_31;
    tmpvar_31 = (1.0 - (dot (tmpvar_19, tmpvar_27) / tmpvar_28));
    frontColor_20 = (exp((
      -(clamp ((tmpvar_23 + (tmpvar_29 * 
        ((0.25 * exp((-0.00287 + 
          (tmpvar_30 * (0.459 + (tmpvar_30 * (3.83 + 
            (tmpvar_30 * (-6.8 + (tmpvar_30 * 5.25)))
          ))))
        ))) - (0.25 * exp((-0.00287 + 
          (tmpvar_31 * (0.459 + (tmpvar_31 * (3.83 + 
            (tmpvar_31 * (-6.8 + (tmpvar_31 * 5.25)))
          ))))
        ))))
      )), 0.0, 50.0))
     * 
      ((tmpvar_14 * kKr4PI_5) + 0.01256637)
    )) * (tmpvar_29 * tmpvar_25));
    samplePoint_21 = (tmpvar_27 + tmpvar_26);
    highp float tmpvar_32;
    tmpvar_32 = sqrt(dot (samplePoint_21, samplePoint_21));
    highp float tmpvar_33;
    tmpvar_33 = exp((160.0002 * (1.0 - tmpvar_32)));
    highp float tmpvar_34;
    tmpvar_34 = (1.0 - (dot (_WorldSpaceLightPos0.xyz, samplePoint_21) / tmpvar_32));
    highp float tmpvar_35;
    tmpvar_35 = (1.0 - (dot (tmpvar_19, samplePoint_21) / tmpvar_32));
    frontColor_20 = (frontColor_20 + (exp(
      (-(clamp ((tmpvar_23 + 
        (tmpvar_33 * ((0.25 * exp(
          (-0.00287 + (tmpvar_34 * (0.459 + (tmpvar_34 * 
            (3.83 + (tmpvar_34 * (-6.8 + (tmpvar_34 * 5.25))))
          ))))
        )) - (0.25 * exp(
          (-0.00287 + (tmpvar_35 * (0.459 + (tmpvar_35 * 
            (3.83 + (tmpvar_35 * (-6.8 + (tmpvar_35 * 5.25))))
          ))))
        ))))
      ), 0.0, 50.0)) * ((tmpvar_14 * kKr4PI_5) + 0.01256637))
    ) * (tmpvar_33 * tmpvar_25)));
    samplePoint_21 = (samplePoint_21 + tmpvar_26);
    cIn_3 = (frontColor_20 * (tmpvar_14 * kKrESun_6));
    cOut_2 = (frontColor_20 * 0.02);
  } else {
    highp vec3 frontColor_1_36;
    far_4 = (-0.0001 / min (-0.001, tmpvar_19.y));
    highp vec3 tmpvar_37;
    tmpvar_37 = (vec3(0.0, 1.0001, 0.0) + (far_4 * tmpvar_19));
    highp float tmpvar_38;
    highp float tmpvar_39;
    tmpvar_39 = (1.0 - dot (-(tmpvar_19), tmpvar_37));
    tmpvar_38 = (0.25 * exp((-0.00287 + 
      (tmpvar_39 * (0.459 + (tmpvar_39 * (3.83 + 
        (tmpvar_39 * (-6.8 + (tmpvar_39 * 5.25)))
      ))))
    )));
    highp float tmpvar_40;
    tmpvar_40 = (1.0 - dot (_WorldSpaceLightPos0.xyz, tmpvar_37));
    highp float tmpvar_41;
    tmpvar_41 = (far_4 / 2.0);
    highp vec3 tmpvar_42;
    tmpvar_42 = (vec3(0.0, 1.0001, 0.0) + ((tmpvar_19 * tmpvar_41) * 0.5));
    highp float tmpvar_43;
    tmpvar_43 = exp((160.0002 * (1.0 - 
      sqrt(dot (tmpvar_42, tmpvar_42))
    )));
    highp vec3 tmpvar_44;
    tmpvar_44 = exp((-(
      clamp (((tmpvar_43 * (
        (0.25 * exp((-0.00287 + (tmpvar_40 * 
          (0.459 + (tmpvar_40 * (3.83 + (tmpvar_40 * 
            (-6.8 + (tmpvar_40 * 5.25))
          ))))
        ))))
       + tmpvar_38)) - (0.9996001 * tmpvar_38)), 0.0, 50.0)
    ) * (
      (tmpvar_14 * kKr4PI_5)
     + 0.01256637)));
    frontColor_1_36 = (tmpvar_44 * (tmpvar_43 * (tmpvar_41 * 40.00004)));
    cIn_3 = (frontColor_1_36 * ((tmpvar_14 * kKrESun_6) + 0.02));
    highp vec3 tmpvar_45;
    tmpvar_45 = clamp (tmpvar_44, vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0));
    cOut_2 = tmpvar_45;
  };
  tmpvar_8 = -(tmpvar_19);
  tmpvar_9 = (_Exposure * (cIn_3 + (
    (_GroundColor * _GroundColor)
   * cOut_2)));
  mediump vec3 light_46;
  light_46 = _WorldSpaceLightPos0.xyz;
  mediump vec3 ray_47;
  ray_47 = -(tmpvar_19);
  mediump float tmpvar_48;
  tmpvar_48 = dot (light_46, ray_47);
  tmpvar_10 = (_Exposure * (cIn_3 * (0.75 + 
    (0.75 * (tmpvar_48 * tmpvar_48))
  )));
  lowp float tmpvar_49;
  tmpvar_49 = clamp (sqrt(dot (_LightColor0.xyz, _LightColor0.xyz)), 0.25, 1.0);
  lightColorIntensity_1 = tmpvar_49;
  tmpvar_11 = (((27.0 * 
    clamp ((cOut_2 * 8000.0), 0.0, 1.0)
  ) * _LightColor0.xyz) / lightColorIntensity_1);
  mediump vec3 tmpvar_50;
  tmpvar_50 = sqrt(tmpvar_9);
  tmpvar_9 = tmpvar_50;
  mediump vec3 tmpvar_51;
  tmpvar_51 = sqrt(tmpvar_10);
  tmpvar_10 = tmpvar_51;
  mediump vec3 tmpvar_52;
  tmpvar_52 = sqrt(tmpvar_11);
  tmpvar_11 = tmpvar_52;
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_8;
  xlv_TEXCOORD1 = tmpvar_50;
  xlv_TEXCOORD2 = tmpvar_51;
  xlv_TEXCOORD3 = tmpvar_52;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _SunSize;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 col_1;
  mediump float tmpvar_2;
  tmpvar_2 = (xlv_TEXCOORD0.y / 0.02);
  mediump vec3 tmpvar_3;
  tmpvar_3 = mix (xlv_TEXCOORD2, xlv_TEXCOORD1, vec3(clamp (tmpvar_2, 0.0, 1.0)));
  col_1 = tmpvar_3;
  if ((tmpvar_2 < 0.0)) {
    mediump vec3 lightPos_4;
    lightPos_4 = _WorldSpaceLightPos0.xyz;
    mediump vec3 tmpvar_5;
    tmpvar_5 = (lightPos_4 - -(xlv_TEXCOORD0));
    mediump float tmpvar_6;
    tmpvar_6 = clamp ((sqrt(
      dot (tmpvar_5, tmpvar_5)
    ) / _SunSize), 0.0, 1.0);
    mediump float tmpvar_7;
    tmpvar_7 = (1.0 - (tmpvar_6 * (tmpvar_6 * 
      (3.0 - (2.0 * tmpvar_6))
    )));
    col_1 = (tmpvar_3 + (xlv_TEXCOORD3 * (tmpvar_7 * tmpvar_7)));
  };
  mediump vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = col_1;
  gl_FragData[0] = tmpvar_8;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_SUNDISK_HIGH_QUALITY" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _LightColor0;
uniform mediump float _Exposure;
uniform mediump vec3 _GroundColor;
uniform mediump vec3 _SkyTint;
uniform mediump float _AtmosphereThickness;
varying highp vec3 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump float lightColorIntensity_1;
  mediump vec3 cOut_2;
  mediump vec3 cIn_3;
  highp float far_4;
  highp float kKr4PI_5;
  highp float kKrESun_6;
  highp vec3 kSkyTintInGammaSpace_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  mediump vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesVertex.xyz;
  tmpvar_11 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  kSkyTintInGammaSpace_7 = _SkyTint;
  highp vec3 tmpvar_13;
  tmpvar_13 = (1.0/(pow (mix (vec3(0.5, 0.42, 0.325), vec3(0.8, 0.72, 0.625), 
    (vec3(1.0, 1.0, 1.0) - kSkyTintInGammaSpace_7)
  ), vec3(4.0, 4.0, 4.0))));
  mediump float tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = pow (_AtmosphereThickness, 2.5);
  tmpvar_14 = (0.05 * tmpvar_15);
  kKrESun_6 = tmpvar_14;
  mediump float tmpvar_16;
  tmpvar_16 = (0.03141593 * tmpvar_15);
  kKr4PI_5 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesVertex.xyz));
  far_4 = 0.0;
  if ((tmpvar_18.y >= 0.0)) {
    highp vec3 frontColor_19;
    highp vec3 samplePoint_20;
    far_4 = (sqrt((
      (1.050625 + (tmpvar_18.y * tmpvar_18.y))
     - 1.0)) - tmpvar_18.y);
    highp float tmpvar_21;
    tmpvar_21 = (1.0 - (dot (tmpvar_18, vec3(0.0, 1.0001, 0.0)) / 1.0001));
    highp float tmpvar_22;
    tmpvar_22 = (exp((-0.00287 + 
      (tmpvar_21 * (0.459 + (tmpvar_21 * (3.83 + 
        (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25)))
      ))))
    )) * 0.2460318);
    highp float tmpvar_23;
    tmpvar_23 = (far_4 / 2.0);
    highp float tmpvar_24;
    tmpvar_24 = (tmpvar_23 * 40.00004);
    highp vec3 tmpvar_25;
    tmpvar_25 = (tmpvar_18 * tmpvar_23);
    highp vec3 tmpvar_26;
    tmpvar_26 = (vec3(0.0, 1.0001, 0.0) + (tmpvar_25 * 0.5));
    highp float tmpvar_27;
    tmpvar_27 = sqrt(dot (tmpvar_26, tmpvar_26));
    highp float tmpvar_28;
    tmpvar_28 = exp((160.0002 * (1.0 - tmpvar_27)));
    highp float tmpvar_29;
    tmpvar_29 = (1.0 - (dot (_WorldSpaceLightPos0.xyz, tmpvar_26) / tmpvar_27));
    highp float tmpvar_30;
    tmpvar_30 = (1.0 - (dot (tmpvar_18, tmpvar_26) / tmpvar_27));
    frontColor_19 = (exp((
      -(clamp ((tmpvar_22 + (tmpvar_28 * 
        ((0.25 * exp((-0.00287 + 
          (tmpvar_29 * (0.459 + (tmpvar_29 * (3.83 + 
            (tmpvar_29 * (-6.8 + (tmpvar_29 * 5.25)))
          ))))
        ))) - (0.25 * exp((-0.00287 + 
          (tmpvar_30 * (0.459 + (tmpvar_30 * (3.83 + 
            (tmpvar_30 * (-6.8 + (tmpvar_30 * 5.25)))
          ))))
        ))))
      )), 0.0, 50.0))
     * 
      ((tmpvar_13 * kKr4PI_5) + 0.01256637)
    )) * (tmpvar_28 * tmpvar_24));
    samplePoint_20 = (tmpvar_26 + tmpvar_25);
    highp float tmpvar_31;
    tmpvar_31 = sqrt(dot (samplePoint_20, samplePoint_20));
    highp float tmpvar_32;
    tmpvar_32 = exp((160.0002 * (1.0 - tmpvar_31)));
    highp float tmpvar_33;
    tmpvar_33 = (1.0 - (dot (_WorldSpaceLightPos0.xyz, samplePoint_20) / tmpvar_31));
    highp float tmpvar_34;
    tmpvar_34 = (1.0 - (dot (tmpvar_18, samplePoint_20) / tmpvar_31));
    frontColor_19 = (frontColor_19 + (exp(
      (-(clamp ((tmpvar_22 + 
        (tmpvar_32 * ((0.25 * exp(
          (-0.00287 + (tmpvar_33 * (0.459 + (tmpvar_33 * 
            (3.83 + (tmpvar_33 * (-6.8 + (tmpvar_33 * 5.25))))
          ))))
        )) - (0.25 * exp(
          (-0.00287 + (tmpvar_34 * (0.459 + (tmpvar_34 * 
            (3.83 + (tmpvar_34 * (-6.8 + (tmpvar_34 * 5.25))))
          ))))
        ))))
      ), 0.0, 50.0)) * ((tmpvar_13 * kKr4PI_5) + 0.01256637))
    ) * (tmpvar_32 * tmpvar_24)));
    samplePoint_20 = (samplePoint_20 + tmpvar_25);
    cIn_3 = (frontColor_19 * (tmpvar_13 * kKrESun_6));
    cOut_2 = (frontColor_19 * 0.02);
  } else {
    highp vec3 frontColor_1_35;
    far_4 = (-0.0001 / min (-0.001, tmpvar_18.y));
    highp vec3 tmpvar_36;
    tmpvar_36 = (vec3(0.0, 1.0001, 0.0) + (far_4 * tmpvar_18));
    highp float tmpvar_37;
    highp float tmpvar_38;
    tmpvar_38 = (1.0 - dot (-(tmpvar_18), tmpvar_36));
    tmpvar_37 = (0.25 * exp((-0.00287 + 
      (tmpvar_38 * (0.459 + (tmpvar_38 * (3.83 + 
        (tmpvar_38 * (-6.8 + (tmpvar_38 * 5.25)))
      ))))
    )));
    highp float tmpvar_39;
    tmpvar_39 = (1.0 - dot (_WorldSpaceLightPos0.xyz, tmpvar_36));
    highp float tmpvar_40;
    tmpvar_40 = (far_4 / 2.0);
    highp vec3 tmpvar_41;
    tmpvar_41 = (vec3(0.0, 1.0001, 0.0) + ((tmpvar_18 * tmpvar_40) * 0.5));
    highp float tmpvar_42;
    tmpvar_42 = exp((160.0002 * (1.0 - 
      sqrt(dot (tmpvar_41, tmpvar_41))
    )));
    highp vec3 tmpvar_43;
    tmpvar_43 = exp((-(
      clamp (((tmpvar_42 * (
        (0.25 * exp((-0.00287 + (tmpvar_39 * 
          (0.459 + (tmpvar_39 * (3.83 + (tmpvar_39 * 
            (-6.8 + (tmpvar_39 * 5.25))
          ))))
        ))))
       + tmpvar_37)) - (0.9996001 * tmpvar_37)), 0.0, 50.0)
    ) * (
      (tmpvar_13 * kKr4PI_5)
     + 0.01256637)));
    frontColor_1_35 = (tmpvar_43 * (tmpvar_42 * (tmpvar_40 * 40.00004)));
    cIn_3 = (frontColor_1_35 * ((tmpvar_13 * kKrESun_6) + 0.02));
    highp vec3 tmpvar_44;
    tmpvar_44 = clamp (tmpvar_43, vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0));
    cOut_2 = tmpvar_44;
  };
  tmpvar_8 = (_Exposure * (cIn_3 + (
    (_GroundColor * _GroundColor)
   * cOut_2)));
  mediump vec3 light_45;
  light_45 = _WorldSpaceLightPos0.xyz;
  mediump vec3 ray_46;
  ray_46 = -(tmpvar_18);
  mediump float tmpvar_47;
  tmpvar_47 = dot (light_45, ray_46);
  tmpvar_9 = (_Exposure * (cIn_3 * (0.75 + 
    (0.75 * (tmpvar_47 * tmpvar_47))
  )));
  lowp float tmpvar_48;
  tmpvar_48 = clamp (sqrt(dot (_LightColor0.xyz, _LightColor0.xyz)), 0.25, 1.0);
  lightColorIntensity_1 = tmpvar_48;
  tmpvar_10 = (((15.0 * 
    clamp (cOut_2, 0.0, 1.0)
  ) * _LightColor0.xyz) / lightColorIntensity_1);
  mediump vec3 tmpvar_49;
  tmpvar_49 = sqrt(tmpvar_8);
  tmpvar_8 = tmpvar_49;
  mediump vec3 tmpvar_50;
  tmpvar_50 = sqrt(tmpvar_9);
  tmpvar_9 = tmpvar_50;
  mediump vec3 tmpvar_51;
  tmpvar_51 = sqrt(tmpvar_10);
  tmpvar_10 = tmpvar_51;
  gl_Position = tmpvar_11;
  xlv_TEXCOORD0 = -(_glesVertex).xyz;
  xlv_TEXCOORD1 = tmpvar_49;
  xlv_TEXCOORD2 = tmpvar_50;
  xlv_TEXCOORD3 = tmpvar_51;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform mediump float _SunSize;
uniform mediump float _SunSizeConvergence;
varying highp vec3 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 ray_1;
  mediump vec3 col_2;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_3[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_3[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((tmpvar_3 * xlv_TEXCOORD0));
  ray_1 = tmpvar_4;
  mediump float tmpvar_5;
  tmpvar_5 = (ray_1.y / 0.02);
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (xlv_TEXCOORD2, xlv_TEXCOORD1, vec3(clamp (tmpvar_5, 0.0, 1.0)));
  col_2 = tmpvar_6;
  if ((tmpvar_5 < 0.0)) {
    mediump vec3 lightPos_7;
    lightPos_7 = _WorldSpaceLightPos0.xyz;
    mediump float tmpvar_8;
    tmpvar_8 = pow (clamp (dot (lightPos_7, 
      -(ray_1)
    ), 0.0, 1.0), _SunSizeConvergence);
    mediump float temp_9;
    temp_9 = ((0.01001645 * (1.0 + 
      (tmpvar_8 * tmpvar_8)
    )) / max (pow (
      (1.9801 - (-1.98 * -(tmpvar_8)))
    , 
      (pow (_SunSize, 0.65) * 10.0)
    ), 0.0001));
    mediump float tmpvar_10;
    tmpvar_10 = pow (temp_9, 0.454545);
    temp_9 = tmpvar_10;
    col_2 = (tmpvar_6 + (xlv_TEXCOORD3 * tmpvar_10));
  };
  mediump vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = col_2;
  gl_FragData[0] = tmpvar_11;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_SUNDISK_HIGH_QUALITY" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _LightColor0;
uniform mediump float _Exposure;
uniform mediump vec3 _GroundColor;
uniform mediump vec3 _SkyTint;
uniform mediump float _AtmosphereThickness;
varying highp vec3 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump float lightColorIntensity_1;
  mediump vec3 cOut_2;
  mediump vec3 cIn_3;
  highp float far_4;
  highp float kKr4PI_5;
  highp float kKrESun_6;
  highp vec3 kSkyTintInGammaSpace_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  mediump vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesVertex.xyz;
  tmpvar_11 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  kSkyTintInGammaSpace_7 = _SkyTint;
  highp vec3 tmpvar_13;
  tmpvar_13 = (1.0/(pow (mix (vec3(0.5, 0.42, 0.325), vec3(0.8, 0.72, 0.625), 
    (vec3(1.0, 1.0, 1.0) - kSkyTintInGammaSpace_7)
  ), vec3(4.0, 4.0, 4.0))));
  mediump float tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = pow (_AtmosphereThickness, 2.5);
  tmpvar_14 = (0.05 * tmpvar_15);
  kKrESun_6 = tmpvar_14;
  mediump float tmpvar_16;
  tmpvar_16 = (0.03141593 * tmpvar_15);
  kKr4PI_5 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesVertex.xyz));
  far_4 = 0.0;
  if ((tmpvar_18.y >= 0.0)) {
    highp vec3 frontColor_19;
    highp vec3 samplePoint_20;
    far_4 = (sqrt((
      (1.050625 + (tmpvar_18.y * tmpvar_18.y))
     - 1.0)) - tmpvar_18.y);
    highp float tmpvar_21;
    tmpvar_21 = (1.0 - (dot (tmpvar_18, vec3(0.0, 1.0001, 0.0)) / 1.0001));
    highp float tmpvar_22;
    tmpvar_22 = (exp((-0.00287 + 
      (tmpvar_21 * (0.459 + (tmpvar_21 * (3.83 + 
        (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25)))
      ))))
    )) * 0.2460318);
    highp float tmpvar_23;
    tmpvar_23 = (far_4 / 2.0);
    highp float tmpvar_24;
    tmpvar_24 = (tmpvar_23 * 40.00004);
    highp vec3 tmpvar_25;
    tmpvar_25 = (tmpvar_18 * tmpvar_23);
    highp vec3 tmpvar_26;
    tmpvar_26 = (vec3(0.0, 1.0001, 0.0) + (tmpvar_25 * 0.5));
    highp float tmpvar_27;
    tmpvar_27 = sqrt(dot (tmpvar_26, tmpvar_26));
    highp float tmpvar_28;
    tmpvar_28 = exp((160.0002 * (1.0 - tmpvar_27)));
    highp float tmpvar_29;
    tmpvar_29 = (1.0 - (dot (_WorldSpaceLightPos0.xyz, tmpvar_26) / tmpvar_27));
    highp float tmpvar_30;
    tmpvar_30 = (1.0 - (dot (tmpvar_18, tmpvar_26) / tmpvar_27));
    frontColor_19 = (exp((
      -(clamp ((tmpvar_22 + (tmpvar_28 * 
        ((0.25 * exp((-0.00287 + 
          (tmpvar_29 * (0.459 + (tmpvar_29 * (3.83 + 
            (tmpvar_29 * (-6.8 + (tmpvar_29 * 5.25)))
          ))))
        ))) - (0.25 * exp((-0.00287 + 
          (tmpvar_30 * (0.459 + (tmpvar_30 * (3.83 + 
            (tmpvar_30 * (-6.8 + (tmpvar_30 * 5.25)))
          ))))
        ))))
      )), 0.0, 50.0))
     * 
      ((tmpvar_13 * kKr4PI_5) + 0.01256637)
    )) * (tmpvar_28 * tmpvar_24));
    samplePoint_20 = (tmpvar_26 + tmpvar_25);
    highp float tmpvar_31;
    tmpvar_31 = sqrt(dot (samplePoint_20, samplePoint_20));
    highp float tmpvar_32;
    tmpvar_32 = exp((160.0002 * (1.0 - tmpvar_31)));
    highp float tmpvar_33;
    tmpvar_33 = (1.0 - (dot (_WorldSpaceLightPos0.xyz, samplePoint_20) / tmpvar_31));
    highp float tmpvar_34;
    tmpvar_34 = (1.0 - (dot (tmpvar_18, samplePoint_20) / tmpvar_31));
    frontColor_19 = (frontColor_19 + (exp(
      (-(clamp ((tmpvar_22 + 
        (tmpvar_32 * ((0.25 * exp(
          (-0.00287 + (tmpvar_33 * (0.459 + (tmpvar_33 * 
            (3.83 + (tmpvar_33 * (-6.8 + (tmpvar_33 * 5.25))))
          ))))
        )) - (0.25 * exp(
          (-0.00287 + (tmpvar_34 * (0.459 + (tmpvar_34 * 
            (3.83 + (tmpvar_34 * (-6.8 + (tmpvar_34 * 5.25))))
          ))))
        ))))
      ), 0.0, 50.0)) * ((tmpvar_13 * kKr4PI_5) + 0.01256637))
    ) * (tmpvar_32 * tmpvar_24)));
    samplePoint_20 = (samplePoint_20 + tmpvar_25);
    cIn_3 = (frontColor_19 * (tmpvar_13 * kKrESun_6));
    cOut_2 = (frontColor_19 * 0.02);
  } else {
    highp vec3 frontColor_1_35;
    far_4 = (-0.0001 / min (-0.001, tmpvar_18.y));
    highp vec3 tmpvar_36;
    tmpvar_36 = (vec3(0.0, 1.0001, 0.0) + (far_4 * tmpvar_18));
    highp float tmpvar_37;
    highp float tmpvar_38;
    tmpvar_38 = (1.0 - dot (-(tmpvar_18), tmpvar_36));
    tmpvar_37 = (0.25 * exp((-0.00287 + 
      (tmpvar_38 * (0.459 + (tmpvar_38 * (3.83 + 
        (tmpvar_38 * (-6.8 + (tmpvar_38 * 5.25)))
      ))))
    )));
    highp float tmpvar_39;
    tmpvar_39 = (1.0 - dot (_WorldSpaceLightPos0.xyz, tmpvar_36));
    highp float tmpvar_40;
    tmpvar_40 = (far_4 / 2.0);
    highp vec3 tmpvar_41;
    tmpvar_41 = (vec3(0.0, 1.0001, 0.0) + ((tmpvar_18 * tmpvar_40) * 0.5));
    highp float tmpvar_42;
    tmpvar_42 = exp((160.0002 * (1.0 - 
      sqrt(dot (tmpvar_41, tmpvar_41))
    )));
    highp vec3 tmpvar_43;
    tmpvar_43 = exp((-(
      clamp (((tmpvar_42 * (
        (0.25 * exp((-0.00287 + (tmpvar_39 * 
          (0.459 + (tmpvar_39 * (3.83 + (tmpvar_39 * 
            (-6.8 + (tmpvar_39 * 5.25))
          ))))
        ))))
       + tmpvar_37)) - (0.9996001 * tmpvar_37)), 0.0, 50.0)
    ) * (
      (tmpvar_13 * kKr4PI_5)
     + 0.01256637)));
    frontColor_1_35 = (tmpvar_43 * (tmpvar_42 * (tmpvar_40 * 40.00004)));
    cIn_3 = (frontColor_1_35 * ((tmpvar_13 * kKrESun_6) + 0.02));
    highp vec3 tmpvar_44;
    tmpvar_44 = clamp (tmpvar_43, vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0));
    cOut_2 = tmpvar_44;
  };
  tmpvar_8 = (_Exposure * (cIn_3 + (
    (_GroundColor * _GroundColor)
   * cOut_2)));
  mediump vec3 light_45;
  light_45 = _WorldSpaceLightPos0.xyz;
  mediump vec3 ray_46;
  ray_46 = -(tmpvar_18);
  mediump float tmpvar_47;
  tmpvar_47 = dot (light_45, ray_46);
  tmpvar_9 = (_Exposure * (cIn_3 * (0.75 + 
    (0.75 * (tmpvar_47 * tmpvar_47))
  )));
  lowp float tmpvar_48;
  tmpvar_48 = clamp (sqrt(dot (_LightColor0.xyz, _LightColor0.xyz)), 0.25, 1.0);
  lightColorIntensity_1 = tmpvar_48;
  tmpvar_10 = (((15.0 * 
    clamp (cOut_2, 0.0, 1.0)
  ) * _LightColor0.xyz) / lightColorIntensity_1);
  mediump vec3 tmpvar_49;
  tmpvar_49 = sqrt(tmpvar_8);
  tmpvar_8 = tmpvar_49;
  mediump vec3 tmpvar_50;
  tmpvar_50 = sqrt(tmpvar_9);
  tmpvar_9 = tmpvar_50;
  mediump vec3 tmpvar_51;
  tmpvar_51 = sqrt(tmpvar_10);
  tmpvar_10 = tmpvar_51;
  gl_Position = tmpvar_11;
  xlv_TEXCOORD0 = -(_glesVertex).xyz;
  xlv_TEXCOORD1 = tmpvar_49;
  xlv_TEXCOORD2 = tmpvar_50;
  xlv_TEXCOORD3 = tmpvar_51;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform mediump float _SunSize;
uniform mediump float _SunSizeConvergence;
varying highp vec3 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 ray_1;
  mediump vec3 col_2;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_3[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_3[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((tmpvar_3 * xlv_TEXCOORD0));
  ray_1 = tmpvar_4;
  mediump float tmpvar_5;
  tmpvar_5 = (ray_1.y / 0.02);
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (xlv_TEXCOORD2, xlv_TEXCOORD1, vec3(clamp (tmpvar_5, 0.0, 1.0)));
  col_2 = tmpvar_6;
  if ((tmpvar_5 < 0.0)) {
    mediump vec3 lightPos_7;
    lightPos_7 = _WorldSpaceLightPos0.xyz;
    mediump float tmpvar_8;
    tmpvar_8 = pow (clamp (dot (lightPos_7, 
      -(ray_1)
    ), 0.0, 1.0), _SunSizeConvergence);
    mediump float temp_9;
    temp_9 = ((0.01001645 * (1.0 + 
      (tmpvar_8 * tmpvar_8)
    )) / max (pow (
      (1.9801 - (-1.98 * -(tmpvar_8)))
    , 
      (pow (_SunSize, 0.65) * 10.0)
    ), 0.0001));
    mediump float tmpvar_10;
    tmpvar_10 = pow (temp_9, 0.454545);
    temp_9 = tmpvar_10;
    col_2 = (tmpvar_6 + (xlv_TEXCOORD3 * tmpvar_10));
  };
  mediump vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = col_2;
  gl_FragData[0] = tmpvar_11;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_SUNDISK_HIGH_QUALITY" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _LightColor0;
uniform mediump float _Exposure;
uniform mediump vec3 _GroundColor;
uniform mediump vec3 _SkyTint;
uniform mediump float _AtmosphereThickness;
varying highp vec3 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump float lightColorIntensity_1;
  mediump vec3 cOut_2;
  mediump vec3 cIn_3;
  highp float far_4;
  highp float kKr4PI_5;
  highp float kKrESun_6;
  highp vec3 kSkyTintInGammaSpace_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  mediump vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesVertex.xyz;
  tmpvar_11 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  kSkyTintInGammaSpace_7 = _SkyTint;
  highp vec3 tmpvar_13;
  tmpvar_13 = (1.0/(pow (mix (vec3(0.5, 0.42, 0.325), vec3(0.8, 0.72, 0.625), 
    (vec3(1.0, 1.0, 1.0) - kSkyTintInGammaSpace_7)
  ), vec3(4.0, 4.0, 4.0))));
  mediump float tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = pow (_AtmosphereThickness, 2.5);
  tmpvar_14 = (0.05 * tmpvar_15);
  kKrESun_6 = tmpvar_14;
  mediump float tmpvar_16;
  tmpvar_16 = (0.03141593 * tmpvar_15);
  kKr4PI_5 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesVertex.xyz));
  far_4 = 0.0;
  if ((tmpvar_18.y >= 0.0)) {
    highp vec3 frontColor_19;
    highp vec3 samplePoint_20;
    far_4 = (sqrt((
      (1.050625 + (tmpvar_18.y * tmpvar_18.y))
     - 1.0)) - tmpvar_18.y);
    highp float tmpvar_21;
    tmpvar_21 = (1.0 - (dot (tmpvar_18, vec3(0.0, 1.0001, 0.0)) / 1.0001));
    highp float tmpvar_22;
    tmpvar_22 = (exp((-0.00287 + 
      (tmpvar_21 * (0.459 + (tmpvar_21 * (3.83 + 
        (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25)))
      ))))
    )) * 0.2460318);
    highp float tmpvar_23;
    tmpvar_23 = (far_4 / 2.0);
    highp float tmpvar_24;
    tmpvar_24 = (tmpvar_23 * 40.00004);
    highp vec3 tmpvar_25;
    tmpvar_25 = (tmpvar_18 * tmpvar_23);
    highp vec3 tmpvar_26;
    tmpvar_26 = (vec3(0.0, 1.0001, 0.0) + (tmpvar_25 * 0.5));
    highp float tmpvar_27;
    tmpvar_27 = sqrt(dot (tmpvar_26, tmpvar_26));
    highp float tmpvar_28;
    tmpvar_28 = exp((160.0002 * (1.0 - tmpvar_27)));
    highp float tmpvar_29;
    tmpvar_29 = (1.0 - (dot (_WorldSpaceLightPos0.xyz, tmpvar_26) / tmpvar_27));
    highp float tmpvar_30;
    tmpvar_30 = (1.0 - (dot (tmpvar_18, tmpvar_26) / tmpvar_27));
    frontColor_19 = (exp((
      -(clamp ((tmpvar_22 + (tmpvar_28 * 
        ((0.25 * exp((-0.00287 + 
          (tmpvar_29 * (0.459 + (tmpvar_29 * (3.83 + 
            (tmpvar_29 * (-6.8 + (tmpvar_29 * 5.25)))
          ))))
        ))) - (0.25 * exp((-0.00287 + 
          (tmpvar_30 * (0.459 + (tmpvar_30 * (3.83 + 
            (tmpvar_30 * (-6.8 + (tmpvar_30 * 5.25)))
          ))))
        ))))
      )), 0.0, 50.0))
     * 
      ((tmpvar_13 * kKr4PI_5) + 0.01256637)
    )) * (tmpvar_28 * tmpvar_24));
    samplePoint_20 = (tmpvar_26 + tmpvar_25);
    highp float tmpvar_31;
    tmpvar_31 = sqrt(dot (samplePoint_20, samplePoint_20));
    highp float tmpvar_32;
    tmpvar_32 = exp((160.0002 * (1.0 - tmpvar_31)));
    highp float tmpvar_33;
    tmpvar_33 = (1.0 - (dot (_WorldSpaceLightPos0.xyz, samplePoint_20) / tmpvar_31));
    highp float tmpvar_34;
    tmpvar_34 = (1.0 - (dot (tmpvar_18, samplePoint_20) / tmpvar_31));
    frontColor_19 = (frontColor_19 + (exp(
      (-(clamp ((tmpvar_22 + 
        (tmpvar_32 * ((0.25 * exp(
          (-0.00287 + (tmpvar_33 * (0.459 + (tmpvar_33 * 
            (3.83 + (tmpvar_33 * (-6.8 + (tmpvar_33 * 5.25))))
          ))))
        )) - (0.25 * exp(
          (-0.00287 + (tmpvar_34 * (0.459 + (tmpvar_34 * 
            (3.83 + (tmpvar_34 * (-6.8 + (tmpvar_34 * 5.25))))
          ))))
        ))))
      ), 0.0, 50.0)) * ((tmpvar_13 * kKr4PI_5) + 0.01256637))
    ) * (tmpvar_32 * tmpvar_24)));
    samplePoint_20 = (samplePoint_20 + tmpvar_25);
    cIn_3 = (frontColor_19 * (tmpvar_13 * kKrESun_6));
    cOut_2 = (frontColor_19 * 0.02);
  } else {
    highp vec3 frontColor_1_35;
    far_4 = (-0.0001 / min (-0.001, tmpvar_18.y));
    highp vec3 tmpvar_36;
    tmpvar_36 = (vec3(0.0, 1.0001, 0.0) + (far_4 * tmpvar_18));
    highp float tmpvar_37;
    highp float tmpvar_38;
    tmpvar_38 = (1.0 - dot (-(tmpvar_18), tmpvar_36));
    tmpvar_37 = (0.25 * exp((-0.00287 + 
      (tmpvar_38 * (0.459 + (tmpvar_38 * (3.83 + 
        (tmpvar_38 * (-6.8 + (tmpvar_38 * 5.25)))
      ))))
    )));
    highp float tmpvar_39;
    tmpvar_39 = (1.0 - dot (_WorldSpaceLightPos0.xyz, tmpvar_36));
    highp float tmpvar_40;
    tmpvar_40 = (far_4 / 2.0);
    highp vec3 tmpvar_41;
    tmpvar_41 = (vec3(0.0, 1.0001, 0.0) + ((tmpvar_18 * tmpvar_40) * 0.5));
    highp float tmpvar_42;
    tmpvar_42 = exp((160.0002 * (1.0 - 
      sqrt(dot (tmpvar_41, tmpvar_41))
    )));
    highp vec3 tmpvar_43;
    tmpvar_43 = exp((-(
      clamp (((tmpvar_42 * (
        (0.25 * exp((-0.00287 + (tmpvar_39 * 
          (0.459 + (tmpvar_39 * (3.83 + (tmpvar_39 * 
            (-6.8 + (tmpvar_39 * 5.25))
          ))))
        ))))
       + tmpvar_37)) - (0.9996001 * tmpvar_37)), 0.0, 50.0)
    ) * (
      (tmpvar_13 * kKr4PI_5)
     + 0.01256637)));
    frontColor_1_35 = (tmpvar_43 * (tmpvar_42 * (tmpvar_40 * 40.00004)));
    cIn_3 = (frontColor_1_35 * ((tmpvar_13 * kKrESun_6) + 0.02));
    highp vec3 tmpvar_44;
    tmpvar_44 = clamp (tmpvar_43, vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0));
    cOut_2 = tmpvar_44;
  };
  tmpvar_8 = (_Exposure * (cIn_3 + (
    (_GroundColor * _GroundColor)
   * cOut_2)));
  mediump vec3 light_45;
  light_45 = _WorldSpaceLightPos0.xyz;
  mediump vec3 ray_46;
  ray_46 = -(tmpvar_18);
  mediump float tmpvar_47;
  tmpvar_47 = dot (light_45, ray_46);
  tmpvar_9 = (_Exposure * (cIn_3 * (0.75 + 
    (0.75 * (tmpvar_47 * tmpvar_47))
  )));
  lowp float tmpvar_48;
  tmpvar_48 = clamp (sqrt(dot (_LightColor0.xyz, _LightColor0.xyz)), 0.25, 1.0);
  lightColorIntensity_1 = tmpvar_48;
  tmpvar_10 = (((15.0 * 
    clamp (cOut_2, 0.0, 1.0)
  ) * _LightColor0.xyz) / lightColorIntensity_1);
  mediump vec3 tmpvar_49;
  tmpvar_49 = sqrt(tmpvar_8);
  tmpvar_8 = tmpvar_49;
  mediump vec3 tmpvar_50;
  tmpvar_50 = sqrt(tmpvar_9);
  tmpvar_9 = tmpvar_50;
  mediump vec3 tmpvar_51;
  tmpvar_51 = sqrt(tmpvar_10);
  tmpvar_10 = tmpvar_51;
  gl_Position = tmpvar_11;
  xlv_TEXCOORD0 = -(_glesVertex).xyz;
  xlv_TEXCOORD1 = tmpvar_49;
  xlv_TEXCOORD2 = tmpvar_50;
  xlv_TEXCOORD3 = tmpvar_51;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform mediump float _SunSize;
uniform mediump float _SunSizeConvergence;
varying highp vec3 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 ray_1;
  mediump vec3 col_2;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_3[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_3[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((tmpvar_3 * xlv_TEXCOORD0));
  ray_1 = tmpvar_4;
  mediump float tmpvar_5;
  tmpvar_5 = (ray_1.y / 0.02);
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (xlv_TEXCOORD2, xlv_TEXCOORD1, vec3(clamp (tmpvar_5, 0.0, 1.0)));
  col_2 = tmpvar_6;
  if ((tmpvar_5 < 0.0)) {
    mediump vec3 lightPos_7;
    lightPos_7 = _WorldSpaceLightPos0.xyz;
    mediump float tmpvar_8;
    tmpvar_8 = pow (clamp (dot (lightPos_7, 
      -(ray_1)
    ), 0.0, 1.0), _SunSizeConvergence);
    mediump float temp_9;
    temp_9 = ((0.01001645 * (1.0 + 
      (tmpvar_8 * tmpvar_8)
    )) / max (pow (
      (1.9801 - (-1.98 * -(tmpvar_8)))
    , 
      (pow (_SunSize, 0.65) * 10.0)
    ), 0.0001));
    mediump float tmpvar_10;
    tmpvar_10 = pow (temp_9, 0.454545);
    temp_9 = tmpvar_10;
    col_2 = (tmpvar_6 + (xlv_TEXCOORD3 * tmpvar_10));
  };
  mediump vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = col_2;
  gl_FragData[0] = tmpvar_11;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "_SUNDISK_NONE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_SUNDISK_NONE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_SUNDISK_NONE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_SUNDISK_SIMPLE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_SUNDISK_SIMPLE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_SUNDISK_SIMPLE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_SUNDISK_HIGH_QUALITY" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_SUNDISK_HIGH_QUALITY" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_SUNDISK_HIGH_QUALITY" }
""
}
}
}
}
CustomEditor "SkyboxProceduralShaderGUI"
}