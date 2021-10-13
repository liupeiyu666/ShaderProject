//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Dynamic Sky/Cloud Layer" {
Properties {
[Header(Cloud Maps)] _CloudDensityMap ("Cloud Density Map", 2D) = "white" { }
_CloudNormalMap ("Cloud Normal Map", 2D) = "bump" { }
_CloudWispsTex ("Cloud Wisps Tex", 2D) = "white" { }
[Header(Cloud Curl)] _CloudCurlTex ("Cloud Curl Tex", 2D) = "white" { }
_CloudCurlTiling ("Cloud Curl Tiling", Range(0, 30)) = 10
_CloudCurlAmplitude ("Cloud Curl Amplitude", Range(0, 0.02)) = 0.01
_CloudCurlSpeed ("Cloud Curl Speed", Range(0, 50)) = 20
[Header(Cloud Lighting)] _CloudDarkShadingNormalYScale ("Cloud Dark Shading Normal Y Scale", Range(0, 10)) = 3
_CloudLightShadingNormalYScale ("Cloud Light Shading Normal Y Scale", Range(0, 10)) = 3
[Header(Debug)] [Toggle(SHOW_WEATHERMAP)] _ShowWeatherMap ("Show Weather Map", Float) = 1
}
SubShader {
 Tags { "QUEUE" = "Background" "RenderType" = "Transparent" }
 Pass {
  Tags { "QUEUE" = "Background" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 64051
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec3 _ES_LightDirection;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunHaloSize;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform highp vec2 _ES_CloudDirection;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudHeight;
uniform highp float _ES_CloudTiling;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudWispsElapsedTime;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec3 xlv_TEXCOORD9;
varying mediump vec3 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 worldBinormal_2;
  mediump vec3 worldTangent_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_7.zw = vec2(0.0, 0.0);
  highp vec4 clipPos_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  clipPos_9.xyw = tmpvar_10.xyw;
  clipPos_9.z = tmpvar_10.w;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10.xyww * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = clipPos_9.zw;
  mediump vec3 viewDir_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(((unity_ObjectToWorld * tmpvar_16).xyz - _ES_SkyCenterWorldPos));
  viewDir_15 = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = dot (_ES_SkyWorldUpDir, viewDir_15);
  mediump vec4 tmpvar_19;
  tmpvar_19.xyz = viewDir_15;
  tmpvar_19.w = ((sign(tmpvar_18) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_18))) * (1.570796 + (abs(tmpvar_18) * (-0.2146018 + 
      (abs(tmpvar_18) * (0.08656672 + (abs(tmpvar_18) * -0.03102955)))
    ))))
  )) * 0.6366198);
  highp vec2 tmpvar_20;
  tmpvar_20 = mix (_glesMultiTexCoord1.xy, _glesMultiTexCoord2.xy, vec2(_ES_CloudHeight));
  highp vec2 tmpvar_21;
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_20 - 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = _ES_CloudDirection.y;
  tmpvar_23.y = -(_ES_CloudDirection.x);
  highp vec2 tmpvar_24;
  tmpvar_24.x = dot (tmpvar_23, tmpvar_22);
  tmpvar_24.y = dot (_ES_CloudDirection, tmpvar_22);
  tmpvar_21 = (tmpvar_24 + 0.5);
  highp vec2 tmpvar_25;
  tmpvar_25 = (tmpvar_21 * _ES_CloudTiling);
  tmpvar_4.xy = ((tmpvar_25 * 1.2) + (_ES_CloudElapsedTime * vec2(0.6, 0.0)));
  tmpvar_4.zw = ((tmpvar_25 * 0.9) + (_ES_CloudElapsedTime * vec2(0.78, 0.0)));
  tmpvar_5.xy = ((tmpvar_25 * 0.7) + (_ES_CloudElapsedTime * vec2(0.28, 0.0035)));
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_glesNormal * tmpvar_26));
  highp vec3 lookAtVector_28;
  lookAtVector_28 = (viewDir_15 * vec3(1.0, -1.0, 1.0));
  highp vec3 tmpvar_29;
  tmpvar_29 = normalize(lookAtVector_28);
  lookAtVector_28 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = (((
    (1.570796 - (sign(tmpvar_29.y) * (1.570796 - (
      sqrt((1.0 - abs(tmpvar_29.y)))
     * 
      (1.570796 + (abs(tmpvar_29.y) * (-0.2146018 + (
        abs(tmpvar_29.y)
       * 
        (0.08656672 + (abs(tmpvar_29.y) * -0.03102955))
      ))))
    ))))
   * 57.29) / 360.0) * 6.283185);
  highp vec3 tmpvar_31;
  tmpvar_31 = ((vec3(1.0, 0.0, 0.0) * tmpvar_29.zxy) - (vec3(0.0, 0.0, 1.0) * tmpvar_29.yzx));
  highp vec3 tmpvar_32;
  tmpvar_32 = (dot (tmpvar_27, tmpvar_31) * tmpvar_31);
  highp vec3 tmpvar_33;
  tmpvar_33 = (tmpvar_27 - tmpvar_32);
  tmpvar_5.zw = (((
    (cos(tmpvar_30) * tmpvar_33)
   + 
    (sin(tmpvar_30) * ((tmpvar_31.yzx * tmpvar_33.zxy) - (tmpvar_31.zxy * tmpvar_33.yzx)))
  ) + tmpvar_32) + tmpvar_27).xz;
  tmpvar_6.xy = ((tmpvar_21 * _CloudCurlTiling) + ((vec2(1.2, 0.8) * _CloudCurlSpeed) * _ES_CloudElapsedTime));
  highp vec2 tmpvar_34;
  tmpvar_34.x = (_glesMultiTexCoord0.x + _ES_CloudWispsElapsedTime);
  tmpvar_34.y = _glesMultiTexCoord0.y;
  tmpvar_6.zw = tmpvar_34;
  tmpvar_7.xy = tmpvar_20;
  mediump float x_35;
  x_35 = (1.0 - (_ES_CloudCoverage * 0.7));
  mediump float tmpvar_36;
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_36 = (tmpvar_37 * (tmpvar_37 * (3.0 - 
    (2.0 * tmpvar_37)
  )));
  mediump float tmpvar_38;
  tmpvar_38 = dot (viewDir_15, _ES_SunDirection);
  tmpvar_8.x = _ES_CloudCoverage;
  tmpvar_8.y = (((x_35 * x_35) * x_35) - 0.15);
  tmpvar_8.z = tmpvar_36;
  tmpvar_8.w = ((tmpvar_38 * 0.5) + 0.5);
  highp vec3 viewDir_39;
  viewDir_39 = tmpvar_19.xyz;
  mediump float moonLunarCancel_40;
  mediump float tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (dot (_ES_MoonDirection, viewDir_39), 0.0, 1.0);
  tmpvar_41 = tmpvar_42;
  highp float tmpvar_43;
  mediump float tmpvar_44;
  tmpvar_44 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_43 = (1.0 - (tmpvar_44 * 2.0));
  moonLunarCancel_40 = tmpvar_43;
  mediump float tmpvar_45;
  tmpvar_45 = clamp (((
    ((tmpvar_41 * tmpvar_41) * ((tmpvar_41 * tmpvar_41) * tmpvar_41))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_46;
  viewDir_46 = tmpvar_19.xyz;
  mediump float vertical_47;
  mediump float tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp (((
    dot (_ES_SunDirection, viewDir_46)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_48 = tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = dot (viewDir_46, _ES_SkyWorldUpDir);
  vertical_47 = tmpvar_50;
  mediump float tmpvar_51;
  tmpvar_51 = max (((tmpvar_38 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_52;
  tmpvar_52 = ((tmpvar_51 * tmpvar_51) * tmpvar_51);
  highp mat3 tmpvar_53;
  tmpvar_53[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_53[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_53[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_54;
  tmpvar_54 = normalize((tmpvar_53 * _glesTANGENT.xyz));
  worldTangent_3 = tmpvar_54;
  highp vec3 tmpvar_55;
  tmpvar_55 = (((tmpvar_27.yzx * worldTangent_3.zxy) - (tmpvar_27.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  worldBinormal_2 = tmpvar_55;
  highp vec3 tmpvar_56;
  tmpvar_56 = worldTangent_3;
  highp vec3 tmpvar_57;
  tmpvar_57 = worldBinormal_2;
  mediump mat3 tmpvar_58;
  highp mat3 tmpvar_59;
  tmpvar_59[0].x = tmpvar_56.x;
  tmpvar_59[0].y = tmpvar_57.x;
  tmpvar_59[0].z = tmpvar_27.x;
  tmpvar_59[1].x = tmpvar_56.y;
  tmpvar_59[1].y = tmpvar_57.y;
  tmpvar_59[1].z = tmpvar_27.y;
  tmpvar_59[2].x = tmpvar_56.z;
  tmpvar_59[2].y = tmpvar_57.z;
  tmpvar_59[2].z = tmpvar_27.z;
  tmpvar_58 = tmpvar_59;
  gl_Position = clipPos_9;
  xlv_TEXCOORD0 = o_12;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_TEXCOORD7 = normalize((tmpvar_58 * _ES_LightDirection));
  xlv_TEXCOORD8 = (((
    ((((tmpvar_45 * 
      (tmpvar_45 * (3.0 - (2.0 * tmpvar_45)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_40) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_48, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_47))
    ) * vertical_47), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_36);
  xlv_TEXCOORD9 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_52));
  xlv_TEXCOORD10 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_52));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_CloudCoverage;
uniform mediump float _ES_CloudOpacity;
uniform mediump vec2 _ES_CloudSmoothness;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform mediump float _ES_CloudWispsCoverage;
uniform mediump float _ES_CloudWispsOpacity;
uniform sampler2D _ES_WeatherMap;
uniform sampler2D _CloudDensityMap;
uniform sampler2D _CloudNormalMap;
uniform sampler2D _CloudWispsTex;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
uniform mediump float _CloudDarkShadingNormalYScale;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec3 xlv_TEXCOORD9;
varying mediump vec3 xlv_TEXCOORD10;
void main ()
{
  mediump vec4 finalCol_1;
  mediump vec4 cloudWisps_2;
  mediump vec3 weather_3;
  mediump float tmpvar_4;
  tmpvar_4 = clamp ((xlv_TEXCOORD6.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_5;
  tmpvar_5 = clamp ((tmpvar_4 * (tmpvar_4 * 
    (3.0 - (2.0 * tmpvar_4))
  )), 0.0, 1.0);
  mediump float tmpvar_6;
  tmpvar_6 = xlv_TEXCOORD5.y;
  mediump float tmpvar_7;
  tmpvar_7 = clamp (((xlv_TEXCOORD5.w - _ES_SunRimLightRadius) / (1.0 - _ES_SunRimLightRadius)), 0.0, 1.0);
  mediump float tmpvar_8;
  tmpvar_8 = (((tmpvar_7 * 
    (tmpvar_7 * (3.0 - (2.0 * tmpvar_7)))
  ) * _ES_SunBrightness) * 0.05);
  lowp vec3 tmpvar_9;
  tmpvar_9 = texture2D (_ES_WeatherMap, xlv_TEXCOORD4.xy).xyz;
  weather_3 = tmpvar_9;
  mediump float filterBaseAlpha_10;
  mediump float filterHighlightArea_11;
  mediump float variationClouds_12;
  mediump vec3 cloudNormal_13;
  mediump vec3 shadowTex_14;
  mediump vec3 cloudTex1_15;
  mediump vec3 cloudTex0_16;
  highp vec3 curlNoise_17;
  lowp vec3 tmpvar_18;
  tmpvar_18 = texture2D (_CloudCurlTex, xlv_TEXCOORD3.xy).xyz;
  curlNoise_17 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = ((curlNoise_17.xy - 0.5) * mix ((_CloudCurlAmplitude * 0.2), _CloudCurlAmplitude, weather_3.y));
  highp vec2 P_20;
  P_20 = (xlv_TEXCOORD1.xy + tmpvar_19);
  lowp vec3 tmpvar_21;
  tmpvar_21 = texture2D (_CloudDensityMap, P_20).xyz;
  cloudTex0_16 = tmpvar_21;
  highp vec2 P_22;
  P_22 = (xlv_TEXCOORD1.zw + tmpvar_19);
  lowp vec3 tmpvar_23;
  tmpvar_23 = texture2D (_CloudDensityMap, P_22).xyz;
  cloudTex1_15 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = (0.03 - (cloudTex0_16.y * 0.01));
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD2.xy + (xlv_TEXCOORD2.zw * tmpvar_24)) + (tmpvar_19 * 0.5));
  lowp vec3 tmpvar_26;
  tmpvar_26 = texture2D (_CloudDensityMap, P_25).xyz;
  shadowTex_14 = tmpvar_26;
  highp vec2 P_27;
  P_27 = (xlv_TEXCOORD2.xy + tmpvar_19);
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_CloudNormalMap, P_27).xyz * 2.0) - 1.0);
  cloudNormal_13 = tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29.xz = vec2(1.0, 1.0);
  tmpvar_29.y = _CloudDarkShadingNormalYScale;
  mediump float tmpvar_30;
  tmpvar_30 = clamp (((
    dot (normalize((cloudNormal_13 * tmpvar_29)), xlv_TEXCOORD7)
   * 0.5) + 0.5), 0.0, 1.0);
  mediump float tmpvar_31;
  tmpvar_31 = clamp ((clamp (
    ((shadowTex_14.y * shadowTex_14.z) * 2.0)
  , 0.0, 1.0) + (shadowTex_14.x - 0.5)), 0.0, 1.0);
  mediump float tmpvar_32;
  tmpvar_32 = (((1.0 - tmpvar_5) * 0.2) + ((
    (cloudTex1_15.z * cloudTex0_16.z)
   + 
    ((cloudTex0_16.x - 0.5) * 0.15)
  ) * weather_3.x));
  highp float value_33;
  value_33 = (cloudTex1_15.x * cloudTex1_15.y);
  highp float tmpvar_34;
  tmpvar_34 = clamp ((value_33 / 0.5), 0.0, 1.0);
  variationClouds_12 = tmpvar_34;
  variationClouds_12 = (variationClouds_12 * variationClouds_12);
  highp float middleThreshold_35;
  middleThreshold_35 = tmpvar_6;
  highp float gradientWidth_36;
  gradientWidth_36 = (0.5 + (variationClouds_12 * 0.5));
  highp float value_37;
  value_37 = tmpvar_32;
  highp float tmpvar_38;
  tmpvar_38 = clamp (((value_37 - middleThreshold_35) / gradientWidth_36), 0.0, 1.0);
  filterHighlightArea_11 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = mix (_ES_CloudSmoothness.x, _ES_CloudSmoothness.y, weather_3.z);
  highp float middleThreshold_40;
  middleThreshold_40 = tmpvar_6;
  highp float gradientWidth_41;
  gradientWidth_41 = ((variationClouds_12 * tmpvar_39) + 0.05);
  highp float value_42;
  value_42 = tmpvar_32;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((value_42 - middleThreshold_40) / gradientWidth_41), 0.0, 1.0);
  filterBaseAlpha_10 = tmpvar_43;
  mediump float tmpvar_44;
  tmpvar_44 = clamp (((_ES_CloudCoverage - 0.5) / 0.2), 0.0, 1.0);
  mediump vec4 tmpvar_45;
  tmpvar_45.xyz = (((
    mix (xlv_TEXCOORD10, xlv_TEXCOORD9, vec3(((tmpvar_31 * tmpvar_31) * (1.0 - (tmpvar_30 * 
      (tmpvar_30 * (3.0 - (2.0 * tmpvar_30)))
    )))))
   + 
    ((((
      (clamp (pow (max (
        min (max (((0.5 - filterHighlightArea_11) * 2.0), 0.0), 1.0)
      , 0.0001), (tmpvar_8 * 30.0)), 0.0, 1.0) * (tmpvar_8 * tmpvar_8))
     * _ES_SunHaloColor) * 50.0) * variationClouds_12) * xlv_TEXCOORD5.z)
  ) + (
    ((variationClouds_12 * 0.5) * xlv_TEXCOORD9)
   * xlv_TEXCOORD5.x)) + (xlv_TEXCOORD8 * tmpvar_31));
  tmpvar_45.w = mix ((clamp (
    (filterBaseAlpha_10 * tmpvar_5)
  , 0.0, 1.0) * _ES_CloudOpacity), 1.0, (tmpvar_44 * (tmpvar_44 * 
    (3.0 - (2.0 * tmpvar_44))
  )));
  highp float wispyOpacity_46;
  lowp float tmpvar_47;
  tmpvar_47 = texture2D (_CloudWispsTex, xlv_TEXCOORD3.zw).w;
  wispyOpacity_46 = tmpvar_47;
  mediump float value_48;
  value_48 = wispyOpacity_46;
  mediump float low_49;
  low_49 = (1.0 - _ES_CloudWispsCoverage);
  mediump float tmpvar_50;
  tmpvar_50 = clamp (((value_48 - low_49) / (1.0 - low_49)), 0.0, 1.0);
  wispyOpacity_46 = (tmpvar_50 * _ES_CloudWispsOpacity);
  highp vec4 tmpvar_51;
  tmpvar_51.xyz = mix (xlv_TEXCOORD9, xlv_TEXCOORD10, vec3(wispyOpacity_46));
  tmpvar_51.w = wispyOpacity_46;
  cloudWisps_2 = tmpvar_51;
  finalCol_1.w = 0.0;
  finalCol_1.xyz = mix ((cloudWisps_2.xyz * cloudWisps_2.w), tmpvar_45.xyz, tmpvar_45.www);
  finalCol_1.xyz = (finalCol_1.xyz * ((xlv_TEXCOORD5.w * _ES_CloudSunBrightenIntensity) + 1.0));
  finalCol_1.w = tmpvar_45.w;
  gl_FragData[0] = finalCol_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec3 _ES_LightDirection;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunHaloSize;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform highp vec2 _ES_CloudDirection;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudHeight;
uniform highp float _ES_CloudTiling;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudWispsElapsedTime;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec3 xlv_TEXCOORD9;
varying mediump vec3 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 worldBinormal_2;
  mediump vec3 worldTangent_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_7.zw = vec2(0.0, 0.0);
  highp vec4 clipPos_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  clipPos_9.xyw = tmpvar_10.xyw;
  clipPos_9.z = tmpvar_10.w;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10.xyww * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = clipPos_9.zw;
  mediump vec3 viewDir_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(((unity_ObjectToWorld * tmpvar_16).xyz - _ES_SkyCenterWorldPos));
  viewDir_15 = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = dot (_ES_SkyWorldUpDir, viewDir_15);
  mediump vec4 tmpvar_19;
  tmpvar_19.xyz = viewDir_15;
  tmpvar_19.w = ((sign(tmpvar_18) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_18))) * (1.570796 + (abs(tmpvar_18) * (-0.2146018 + 
      (abs(tmpvar_18) * (0.08656672 + (abs(tmpvar_18) * -0.03102955)))
    ))))
  )) * 0.6366198);
  highp vec2 tmpvar_20;
  tmpvar_20 = mix (_glesMultiTexCoord1.xy, _glesMultiTexCoord2.xy, vec2(_ES_CloudHeight));
  highp vec2 tmpvar_21;
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_20 - 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = _ES_CloudDirection.y;
  tmpvar_23.y = -(_ES_CloudDirection.x);
  highp vec2 tmpvar_24;
  tmpvar_24.x = dot (tmpvar_23, tmpvar_22);
  tmpvar_24.y = dot (_ES_CloudDirection, tmpvar_22);
  tmpvar_21 = (tmpvar_24 + 0.5);
  highp vec2 tmpvar_25;
  tmpvar_25 = (tmpvar_21 * _ES_CloudTiling);
  tmpvar_4.xy = ((tmpvar_25 * 1.2) + (_ES_CloudElapsedTime * vec2(0.6, 0.0)));
  tmpvar_4.zw = ((tmpvar_25 * 0.9) + (_ES_CloudElapsedTime * vec2(0.78, 0.0)));
  tmpvar_5.xy = ((tmpvar_25 * 0.7) + (_ES_CloudElapsedTime * vec2(0.28, 0.0035)));
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_glesNormal * tmpvar_26));
  highp vec3 lookAtVector_28;
  lookAtVector_28 = (viewDir_15 * vec3(1.0, -1.0, 1.0));
  highp vec3 tmpvar_29;
  tmpvar_29 = normalize(lookAtVector_28);
  lookAtVector_28 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = (((
    (1.570796 - (sign(tmpvar_29.y) * (1.570796 - (
      sqrt((1.0 - abs(tmpvar_29.y)))
     * 
      (1.570796 + (abs(tmpvar_29.y) * (-0.2146018 + (
        abs(tmpvar_29.y)
       * 
        (0.08656672 + (abs(tmpvar_29.y) * -0.03102955))
      ))))
    ))))
   * 57.29) / 360.0) * 6.283185);
  highp vec3 tmpvar_31;
  tmpvar_31 = ((vec3(1.0, 0.0, 0.0) * tmpvar_29.zxy) - (vec3(0.0, 0.0, 1.0) * tmpvar_29.yzx));
  highp vec3 tmpvar_32;
  tmpvar_32 = (dot (tmpvar_27, tmpvar_31) * tmpvar_31);
  highp vec3 tmpvar_33;
  tmpvar_33 = (tmpvar_27 - tmpvar_32);
  tmpvar_5.zw = (((
    (cos(tmpvar_30) * tmpvar_33)
   + 
    (sin(tmpvar_30) * ((tmpvar_31.yzx * tmpvar_33.zxy) - (tmpvar_31.zxy * tmpvar_33.yzx)))
  ) + tmpvar_32) + tmpvar_27).xz;
  tmpvar_6.xy = ((tmpvar_21 * _CloudCurlTiling) + ((vec2(1.2, 0.8) * _CloudCurlSpeed) * _ES_CloudElapsedTime));
  highp vec2 tmpvar_34;
  tmpvar_34.x = (_glesMultiTexCoord0.x + _ES_CloudWispsElapsedTime);
  tmpvar_34.y = _glesMultiTexCoord0.y;
  tmpvar_6.zw = tmpvar_34;
  tmpvar_7.xy = tmpvar_20;
  mediump float x_35;
  x_35 = (1.0 - (_ES_CloudCoverage * 0.7));
  mediump float tmpvar_36;
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_36 = (tmpvar_37 * (tmpvar_37 * (3.0 - 
    (2.0 * tmpvar_37)
  )));
  mediump float tmpvar_38;
  tmpvar_38 = dot (viewDir_15, _ES_SunDirection);
  tmpvar_8.x = _ES_CloudCoverage;
  tmpvar_8.y = (((x_35 * x_35) * x_35) - 0.15);
  tmpvar_8.z = tmpvar_36;
  tmpvar_8.w = ((tmpvar_38 * 0.5) + 0.5);
  highp vec3 viewDir_39;
  viewDir_39 = tmpvar_19.xyz;
  mediump float moonLunarCancel_40;
  mediump float tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (dot (_ES_MoonDirection, viewDir_39), 0.0, 1.0);
  tmpvar_41 = tmpvar_42;
  highp float tmpvar_43;
  mediump float tmpvar_44;
  tmpvar_44 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_43 = (1.0 - (tmpvar_44 * 2.0));
  moonLunarCancel_40 = tmpvar_43;
  mediump float tmpvar_45;
  tmpvar_45 = clamp (((
    ((tmpvar_41 * tmpvar_41) * ((tmpvar_41 * tmpvar_41) * tmpvar_41))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_46;
  viewDir_46 = tmpvar_19.xyz;
  mediump float vertical_47;
  mediump float tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp (((
    dot (_ES_SunDirection, viewDir_46)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_48 = tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = dot (viewDir_46, _ES_SkyWorldUpDir);
  vertical_47 = tmpvar_50;
  mediump float tmpvar_51;
  tmpvar_51 = max (((tmpvar_38 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_52;
  tmpvar_52 = ((tmpvar_51 * tmpvar_51) * tmpvar_51);
  highp mat3 tmpvar_53;
  tmpvar_53[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_53[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_53[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_54;
  tmpvar_54 = normalize((tmpvar_53 * _glesTANGENT.xyz));
  worldTangent_3 = tmpvar_54;
  highp vec3 tmpvar_55;
  tmpvar_55 = (((tmpvar_27.yzx * worldTangent_3.zxy) - (tmpvar_27.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  worldBinormal_2 = tmpvar_55;
  highp vec3 tmpvar_56;
  tmpvar_56 = worldTangent_3;
  highp vec3 tmpvar_57;
  tmpvar_57 = worldBinormal_2;
  mediump mat3 tmpvar_58;
  highp mat3 tmpvar_59;
  tmpvar_59[0].x = tmpvar_56.x;
  tmpvar_59[0].y = tmpvar_57.x;
  tmpvar_59[0].z = tmpvar_27.x;
  tmpvar_59[1].x = tmpvar_56.y;
  tmpvar_59[1].y = tmpvar_57.y;
  tmpvar_59[1].z = tmpvar_27.y;
  tmpvar_59[2].x = tmpvar_56.z;
  tmpvar_59[2].y = tmpvar_57.z;
  tmpvar_59[2].z = tmpvar_27.z;
  tmpvar_58 = tmpvar_59;
  gl_Position = clipPos_9;
  xlv_TEXCOORD0 = o_12;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_TEXCOORD7 = normalize((tmpvar_58 * _ES_LightDirection));
  xlv_TEXCOORD8 = (((
    ((((tmpvar_45 * 
      (tmpvar_45 * (3.0 - (2.0 * tmpvar_45)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_40) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_48, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_47))
    ) * vertical_47), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_36);
  xlv_TEXCOORD9 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_52));
  xlv_TEXCOORD10 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_52));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_CloudCoverage;
uniform mediump float _ES_CloudOpacity;
uniform mediump vec2 _ES_CloudSmoothness;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform mediump float _ES_CloudWispsCoverage;
uniform mediump float _ES_CloudWispsOpacity;
uniform sampler2D _ES_WeatherMap;
uniform sampler2D _CloudDensityMap;
uniform sampler2D _CloudNormalMap;
uniform sampler2D _CloudWispsTex;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
uniform mediump float _CloudDarkShadingNormalYScale;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec3 xlv_TEXCOORD9;
varying mediump vec3 xlv_TEXCOORD10;
void main ()
{
  mediump vec4 finalCol_1;
  mediump vec4 cloudWisps_2;
  mediump vec3 weather_3;
  mediump float tmpvar_4;
  tmpvar_4 = clamp ((xlv_TEXCOORD6.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_5;
  tmpvar_5 = clamp ((tmpvar_4 * (tmpvar_4 * 
    (3.0 - (2.0 * tmpvar_4))
  )), 0.0, 1.0);
  mediump float tmpvar_6;
  tmpvar_6 = xlv_TEXCOORD5.y;
  mediump float tmpvar_7;
  tmpvar_7 = clamp (((xlv_TEXCOORD5.w - _ES_SunRimLightRadius) / (1.0 - _ES_SunRimLightRadius)), 0.0, 1.0);
  mediump float tmpvar_8;
  tmpvar_8 = (((tmpvar_7 * 
    (tmpvar_7 * (3.0 - (2.0 * tmpvar_7)))
  ) * _ES_SunBrightness) * 0.05);
  lowp vec3 tmpvar_9;
  tmpvar_9 = texture2D (_ES_WeatherMap, xlv_TEXCOORD4.xy).xyz;
  weather_3 = tmpvar_9;
  mediump float filterBaseAlpha_10;
  mediump float filterHighlightArea_11;
  mediump float variationClouds_12;
  mediump vec3 cloudNormal_13;
  mediump vec3 shadowTex_14;
  mediump vec3 cloudTex1_15;
  mediump vec3 cloudTex0_16;
  highp vec3 curlNoise_17;
  lowp vec3 tmpvar_18;
  tmpvar_18 = texture2D (_CloudCurlTex, xlv_TEXCOORD3.xy).xyz;
  curlNoise_17 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = ((curlNoise_17.xy - 0.5) * mix ((_CloudCurlAmplitude * 0.2), _CloudCurlAmplitude, weather_3.y));
  highp vec2 P_20;
  P_20 = (xlv_TEXCOORD1.xy + tmpvar_19);
  lowp vec3 tmpvar_21;
  tmpvar_21 = texture2D (_CloudDensityMap, P_20).xyz;
  cloudTex0_16 = tmpvar_21;
  highp vec2 P_22;
  P_22 = (xlv_TEXCOORD1.zw + tmpvar_19);
  lowp vec3 tmpvar_23;
  tmpvar_23 = texture2D (_CloudDensityMap, P_22).xyz;
  cloudTex1_15 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = (0.03 - (cloudTex0_16.y * 0.01));
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD2.xy + (xlv_TEXCOORD2.zw * tmpvar_24)) + (tmpvar_19 * 0.5));
  lowp vec3 tmpvar_26;
  tmpvar_26 = texture2D (_CloudDensityMap, P_25).xyz;
  shadowTex_14 = tmpvar_26;
  highp vec2 P_27;
  P_27 = (xlv_TEXCOORD2.xy + tmpvar_19);
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_CloudNormalMap, P_27).xyz * 2.0) - 1.0);
  cloudNormal_13 = tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29.xz = vec2(1.0, 1.0);
  tmpvar_29.y = _CloudDarkShadingNormalYScale;
  mediump float tmpvar_30;
  tmpvar_30 = clamp (((
    dot (normalize((cloudNormal_13 * tmpvar_29)), xlv_TEXCOORD7)
   * 0.5) + 0.5), 0.0, 1.0);
  mediump float tmpvar_31;
  tmpvar_31 = clamp ((clamp (
    ((shadowTex_14.y * shadowTex_14.z) * 2.0)
  , 0.0, 1.0) + (shadowTex_14.x - 0.5)), 0.0, 1.0);
  mediump float tmpvar_32;
  tmpvar_32 = (((1.0 - tmpvar_5) * 0.2) + ((
    (cloudTex1_15.z * cloudTex0_16.z)
   + 
    ((cloudTex0_16.x - 0.5) * 0.15)
  ) * weather_3.x));
  highp float value_33;
  value_33 = (cloudTex1_15.x * cloudTex1_15.y);
  highp float tmpvar_34;
  tmpvar_34 = clamp ((value_33 / 0.5), 0.0, 1.0);
  variationClouds_12 = tmpvar_34;
  variationClouds_12 = (variationClouds_12 * variationClouds_12);
  highp float middleThreshold_35;
  middleThreshold_35 = tmpvar_6;
  highp float gradientWidth_36;
  gradientWidth_36 = (0.5 + (variationClouds_12 * 0.5));
  highp float value_37;
  value_37 = tmpvar_32;
  highp float tmpvar_38;
  tmpvar_38 = clamp (((value_37 - middleThreshold_35) / gradientWidth_36), 0.0, 1.0);
  filterHighlightArea_11 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = mix (_ES_CloudSmoothness.x, _ES_CloudSmoothness.y, weather_3.z);
  highp float middleThreshold_40;
  middleThreshold_40 = tmpvar_6;
  highp float gradientWidth_41;
  gradientWidth_41 = ((variationClouds_12 * tmpvar_39) + 0.05);
  highp float value_42;
  value_42 = tmpvar_32;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((value_42 - middleThreshold_40) / gradientWidth_41), 0.0, 1.0);
  filterBaseAlpha_10 = tmpvar_43;
  mediump float tmpvar_44;
  tmpvar_44 = clamp (((_ES_CloudCoverage - 0.5) / 0.2), 0.0, 1.0);
  mediump vec4 tmpvar_45;
  tmpvar_45.xyz = (((
    mix (xlv_TEXCOORD10, xlv_TEXCOORD9, vec3(((tmpvar_31 * tmpvar_31) * (1.0 - (tmpvar_30 * 
      (tmpvar_30 * (3.0 - (2.0 * tmpvar_30)))
    )))))
   + 
    ((((
      (clamp (pow (max (
        min (max (((0.5 - filterHighlightArea_11) * 2.0), 0.0), 1.0)
      , 0.0001), (tmpvar_8 * 30.0)), 0.0, 1.0) * (tmpvar_8 * tmpvar_8))
     * _ES_SunHaloColor) * 50.0) * variationClouds_12) * xlv_TEXCOORD5.z)
  ) + (
    ((variationClouds_12 * 0.5) * xlv_TEXCOORD9)
   * xlv_TEXCOORD5.x)) + (xlv_TEXCOORD8 * tmpvar_31));
  tmpvar_45.w = mix ((clamp (
    (filterBaseAlpha_10 * tmpvar_5)
  , 0.0, 1.0) * _ES_CloudOpacity), 1.0, (tmpvar_44 * (tmpvar_44 * 
    (3.0 - (2.0 * tmpvar_44))
  )));
  highp float wispyOpacity_46;
  lowp float tmpvar_47;
  tmpvar_47 = texture2D (_CloudWispsTex, xlv_TEXCOORD3.zw).w;
  wispyOpacity_46 = tmpvar_47;
  mediump float value_48;
  value_48 = wispyOpacity_46;
  mediump float low_49;
  low_49 = (1.0 - _ES_CloudWispsCoverage);
  mediump float tmpvar_50;
  tmpvar_50 = clamp (((value_48 - low_49) / (1.0 - low_49)), 0.0, 1.0);
  wispyOpacity_46 = (tmpvar_50 * _ES_CloudWispsOpacity);
  highp vec4 tmpvar_51;
  tmpvar_51.xyz = mix (xlv_TEXCOORD9, xlv_TEXCOORD10, vec3(wispyOpacity_46));
  tmpvar_51.w = wispyOpacity_46;
  cloudWisps_2 = tmpvar_51;
  finalCol_1.w = 0.0;
  finalCol_1.xyz = mix ((cloudWisps_2.xyz * cloudWisps_2.w), tmpvar_45.xyz, tmpvar_45.www);
  finalCol_1.xyz = (finalCol_1.xyz * ((xlv_TEXCOORD5.w * _ES_CloudSunBrightenIntensity) + 1.0));
  finalCol_1.w = tmpvar_45.w;
  gl_FragData[0] = finalCol_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec3 _ES_LightDirection;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunHaloSize;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform highp vec2 _ES_CloudDirection;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudHeight;
uniform highp float _ES_CloudTiling;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudWispsElapsedTime;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec3 xlv_TEXCOORD9;
varying mediump vec3 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 worldBinormal_2;
  mediump vec3 worldTangent_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_7.zw = vec2(0.0, 0.0);
  highp vec4 clipPos_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  clipPos_9.xyw = tmpvar_10.xyw;
  clipPos_9.z = tmpvar_10.w;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10.xyww * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = clipPos_9.zw;
  mediump vec3 viewDir_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(((unity_ObjectToWorld * tmpvar_16).xyz - _ES_SkyCenterWorldPos));
  viewDir_15 = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = dot (_ES_SkyWorldUpDir, viewDir_15);
  mediump vec4 tmpvar_19;
  tmpvar_19.xyz = viewDir_15;
  tmpvar_19.w = ((sign(tmpvar_18) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_18))) * (1.570796 + (abs(tmpvar_18) * (-0.2146018 + 
      (abs(tmpvar_18) * (0.08656672 + (abs(tmpvar_18) * -0.03102955)))
    ))))
  )) * 0.6366198);
  highp vec2 tmpvar_20;
  tmpvar_20 = mix (_glesMultiTexCoord1.xy, _glesMultiTexCoord2.xy, vec2(_ES_CloudHeight));
  highp vec2 tmpvar_21;
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_20 - 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = _ES_CloudDirection.y;
  tmpvar_23.y = -(_ES_CloudDirection.x);
  highp vec2 tmpvar_24;
  tmpvar_24.x = dot (tmpvar_23, tmpvar_22);
  tmpvar_24.y = dot (_ES_CloudDirection, tmpvar_22);
  tmpvar_21 = (tmpvar_24 + 0.5);
  highp vec2 tmpvar_25;
  tmpvar_25 = (tmpvar_21 * _ES_CloudTiling);
  tmpvar_4.xy = ((tmpvar_25 * 1.2) + (_ES_CloudElapsedTime * vec2(0.6, 0.0)));
  tmpvar_4.zw = ((tmpvar_25 * 0.9) + (_ES_CloudElapsedTime * vec2(0.78, 0.0)));
  tmpvar_5.xy = ((tmpvar_25 * 0.7) + (_ES_CloudElapsedTime * vec2(0.28, 0.0035)));
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_glesNormal * tmpvar_26));
  highp vec3 lookAtVector_28;
  lookAtVector_28 = (viewDir_15 * vec3(1.0, -1.0, 1.0));
  highp vec3 tmpvar_29;
  tmpvar_29 = normalize(lookAtVector_28);
  lookAtVector_28 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = (((
    (1.570796 - (sign(tmpvar_29.y) * (1.570796 - (
      sqrt((1.0 - abs(tmpvar_29.y)))
     * 
      (1.570796 + (abs(tmpvar_29.y) * (-0.2146018 + (
        abs(tmpvar_29.y)
       * 
        (0.08656672 + (abs(tmpvar_29.y) * -0.03102955))
      ))))
    ))))
   * 57.29) / 360.0) * 6.283185);
  highp vec3 tmpvar_31;
  tmpvar_31 = ((vec3(1.0, 0.0, 0.0) * tmpvar_29.zxy) - (vec3(0.0, 0.0, 1.0) * tmpvar_29.yzx));
  highp vec3 tmpvar_32;
  tmpvar_32 = (dot (tmpvar_27, tmpvar_31) * tmpvar_31);
  highp vec3 tmpvar_33;
  tmpvar_33 = (tmpvar_27 - tmpvar_32);
  tmpvar_5.zw = (((
    (cos(tmpvar_30) * tmpvar_33)
   + 
    (sin(tmpvar_30) * ((tmpvar_31.yzx * tmpvar_33.zxy) - (tmpvar_31.zxy * tmpvar_33.yzx)))
  ) + tmpvar_32) + tmpvar_27).xz;
  tmpvar_6.xy = ((tmpvar_21 * _CloudCurlTiling) + ((vec2(1.2, 0.8) * _CloudCurlSpeed) * _ES_CloudElapsedTime));
  highp vec2 tmpvar_34;
  tmpvar_34.x = (_glesMultiTexCoord0.x + _ES_CloudWispsElapsedTime);
  tmpvar_34.y = _glesMultiTexCoord0.y;
  tmpvar_6.zw = tmpvar_34;
  tmpvar_7.xy = tmpvar_20;
  mediump float x_35;
  x_35 = (1.0 - (_ES_CloudCoverage * 0.7));
  mediump float tmpvar_36;
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_36 = (tmpvar_37 * (tmpvar_37 * (3.0 - 
    (2.0 * tmpvar_37)
  )));
  mediump float tmpvar_38;
  tmpvar_38 = dot (viewDir_15, _ES_SunDirection);
  tmpvar_8.x = _ES_CloudCoverage;
  tmpvar_8.y = (((x_35 * x_35) * x_35) - 0.15);
  tmpvar_8.z = tmpvar_36;
  tmpvar_8.w = ((tmpvar_38 * 0.5) + 0.5);
  highp vec3 viewDir_39;
  viewDir_39 = tmpvar_19.xyz;
  mediump float moonLunarCancel_40;
  mediump float tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (dot (_ES_MoonDirection, viewDir_39), 0.0, 1.0);
  tmpvar_41 = tmpvar_42;
  highp float tmpvar_43;
  mediump float tmpvar_44;
  tmpvar_44 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_43 = (1.0 - (tmpvar_44 * 2.0));
  moonLunarCancel_40 = tmpvar_43;
  mediump float tmpvar_45;
  tmpvar_45 = clamp (((
    ((tmpvar_41 * tmpvar_41) * ((tmpvar_41 * tmpvar_41) * tmpvar_41))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_46;
  viewDir_46 = tmpvar_19.xyz;
  mediump float vertical_47;
  mediump float tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp (((
    dot (_ES_SunDirection, viewDir_46)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_48 = tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = dot (viewDir_46, _ES_SkyWorldUpDir);
  vertical_47 = tmpvar_50;
  mediump float tmpvar_51;
  tmpvar_51 = max (((tmpvar_38 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_52;
  tmpvar_52 = ((tmpvar_51 * tmpvar_51) * tmpvar_51);
  highp mat3 tmpvar_53;
  tmpvar_53[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_53[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_53[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_54;
  tmpvar_54 = normalize((tmpvar_53 * _glesTANGENT.xyz));
  worldTangent_3 = tmpvar_54;
  highp vec3 tmpvar_55;
  tmpvar_55 = (((tmpvar_27.yzx * worldTangent_3.zxy) - (tmpvar_27.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  worldBinormal_2 = tmpvar_55;
  highp vec3 tmpvar_56;
  tmpvar_56 = worldTangent_3;
  highp vec3 tmpvar_57;
  tmpvar_57 = worldBinormal_2;
  mediump mat3 tmpvar_58;
  highp mat3 tmpvar_59;
  tmpvar_59[0].x = tmpvar_56.x;
  tmpvar_59[0].y = tmpvar_57.x;
  tmpvar_59[0].z = tmpvar_27.x;
  tmpvar_59[1].x = tmpvar_56.y;
  tmpvar_59[1].y = tmpvar_57.y;
  tmpvar_59[1].z = tmpvar_27.y;
  tmpvar_59[2].x = tmpvar_56.z;
  tmpvar_59[2].y = tmpvar_57.z;
  tmpvar_59[2].z = tmpvar_27.z;
  tmpvar_58 = tmpvar_59;
  gl_Position = clipPos_9;
  xlv_TEXCOORD0 = o_12;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_TEXCOORD7 = normalize((tmpvar_58 * _ES_LightDirection));
  xlv_TEXCOORD8 = (((
    ((((tmpvar_45 * 
      (tmpvar_45 * (3.0 - (2.0 * tmpvar_45)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_40) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_48, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_47))
    ) * vertical_47), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_36);
  xlv_TEXCOORD9 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_52));
  xlv_TEXCOORD10 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_52));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_CloudCoverage;
uniform mediump float _ES_CloudOpacity;
uniform mediump vec2 _ES_CloudSmoothness;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform mediump float _ES_CloudWispsCoverage;
uniform mediump float _ES_CloudWispsOpacity;
uniform sampler2D _ES_WeatherMap;
uniform sampler2D _CloudDensityMap;
uniform sampler2D _CloudNormalMap;
uniform sampler2D _CloudWispsTex;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
uniform mediump float _CloudDarkShadingNormalYScale;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec3 xlv_TEXCOORD9;
varying mediump vec3 xlv_TEXCOORD10;
void main ()
{
  mediump vec4 finalCol_1;
  mediump vec4 cloudWisps_2;
  mediump vec3 weather_3;
  mediump float tmpvar_4;
  tmpvar_4 = clamp ((xlv_TEXCOORD6.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_5;
  tmpvar_5 = clamp ((tmpvar_4 * (tmpvar_4 * 
    (3.0 - (2.0 * tmpvar_4))
  )), 0.0, 1.0);
  mediump float tmpvar_6;
  tmpvar_6 = xlv_TEXCOORD5.y;
  mediump float tmpvar_7;
  tmpvar_7 = clamp (((xlv_TEXCOORD5.w - _ES_SunRimLightRadius) / (1.0 - _ES_SunRimLightRadius)), 0.0, 1.0);
  mediump float tmpvar_8;
  tmpvar_8 = (((tmpvar_7 * 
    (tmpvar_7 * (3.0 - (2.0 * tmpvar_7)))
  ) * _ES_SunBrightness) * 0.05);
  lowp vec3 tmpvar_9;
  tmpvar_9 = texture2D (_ES_WeatherMap, xlv_TEXCOORD4.xy).xyz;
  weather_3 = tmpvar_9;
  mediump float filterBaseAlpha_10;
  mediump float filterHighlightArea_11;
  mediump float variationClouds_12;
  mediump vec3 cloudNormal_13;
  mediump vec3 shadowTex_14;
  mediump vec3 cloudTex1_15;
  mediump vec3 cloudTex0_16;
  highp vec3 curlNoise_17;
  lowp vec3 tmpvar_18;
  tmpvar_18 = texture2D (_CloudCurlTex, xlv_TEXCOORD3.xy).xyz;
  curlNoise_17 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = ((curlNoise_17.xy - 0.5) * mix ((_CloudCurlAmplitude * 0.2), _CloudCurlAmplitude, weather_3.y));
  highp vec2 P_20;
  P_20 = (xlv_TEXCOORD1.xy + tmpvar_19);
  lowp vec3 tmpvar_21;
  tmpvar_21 = texture2D (_CloudDensityMap, P_20).xyz;
  cloudTex0_16 = tmpvar_21;
  highp vec2 P_22;
  P_22 = (xlv_TEXCOORD1.zw + tmpvar_19);
  lowp vec3 tmpvar_23;
  tmpvar_23 = texture2D (_CloudDensityMap, P_22).xyz;
  cloudTex1_15 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = (0.03 - (cloudTex0_16.y * 0.01));
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD2.xy + (xlv_TEXCOORD2.zw * tmpvar_24)) + (tmpvar_19 * 0.5));
  lowp vec3 tmpvar_26;
  tmpvar_26 = texture2D (_CloudDensityMap, P_25).xyz;
  shadowTex_14 = tmpvar_26;
  highp vec2 P_27;
  P_27 = (xlv_TEXCOORD2.xy + tmpvar_19);
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_CloudNormalMap, P_27).xyz * 2.0) - 1.0);
  cloudNormal_13 = tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29.xz = vec2(1.0, 1.0);
  tmpvar_29.y = _CloudDarkShadingNormalYScale;
  mediump float tmpvar_30;
  tmpvar_30 = clamp (((
    dot (normalize((cloudNormal_13 * tmpvar_29)), xlv_TEXCOORD7)
   * 0.5) + 0.5), 0.0, 1.0);
  mediump float tmpvar_31;
  tmpvar_31 = clamp ((clamp (
    ((shadowTex_14.y * shadowTex_14.z) * 2.0)
  , 0.0, 1.0) + (shadowTex_14.x - 0.5)), 0.0, 1.0);
  mediump float tmpvar_32;
  tmpvar_32 = (((1.0 - tmpvar_5) * 0.2) + ((
    (cloudTex1_15.z * cloudTex0_16.z)
   + 
    ((cloudTex0_16.x - 0.5) * 0.15)
  ) * weather_3.x));
  highp float value_33;
  value_33 = (cloudTex1_15.x * cloudTex1_15.y);
  highp float tmpvar_34;
  tmpvar_34 = clamp ((value_33 / 0.5), 0.0, 1.0);
  variationClouds_12 = tmpvar_34;
  variationClouds_12 = (variationClouds_12 * variationClouds_12);
  highp float middleThreshold_35;
  middleThreshold_35 = tmpvar_6;
  highp float gradientWidth_36;
  gradientWidth_36 = (0.5 + (variationClouds_12 * 0.5));
  highp float value_37;
  value_37 = tmpvar_32;
  highp float tmpvar_38;
  tmpvar_38 = clamp (((value_37 - middleThreshold_35) / gradientWidth_36), 0.0, 1.0);
  filterHighlightArea_11 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = mix (_ES_CloudSmoothness.x, _ES_CloudSmoothness.y, weather_3.z);
  highp float middleThreshold_40;
  middleThreshold_40 = tmpvar_6;
  highp float gradientWidth_41;
  gradientWidth_41 = ((variationClouds_12 * tmpvar_39) + 0.05);
  highp float value_42;
  value_42 = tmpvar_32;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((value_42 - middleThreshold_40) / gradientWidth_41), 0.0, 1.0);
  filterBaseAlpha_10 = tmpvar_43;
  mediump float tmpvar_44;
  tmpvar_44 = clamp (((_ES_CloudCoverage - 0.5) / 0.2), 0.0, 1.0);
  mediump vec4 tmpvar_45;
  tmpvar_45.xyz = (((
    mix (xlv_TEXCOORD10, xlv_TEXCOORD9, vec3(((tmpvar_31 * tmpvar_31) * (1.0 - (tmpvar_30 * 
      (tmpvar_30 * (3.0 - (2.0 * tmpvar_30)))
    )))))
   + 
    ((((
      (clamp (pow (max (
        min (max (((0.5 - filterHighlightArea_11) * 2.0), 0.0), 1.0)
      , 0.0001), (tmpvar_8 * 30.0)), 0.0, 1.0) * (tmpvar_8 * tmpvar_8))
     * _ES_SunHaloColor) * 50.0) * variationClouds_12) * xlv_TEXCOORD5.z)
  ) + (
    ((variationClouds_12 * 0.5) * xlv_TEXCOORD9)
   * xlv_TEXCOORD5.x)) + (xlv_TEXCOORD8 * tmpvar_31));
  tmpvar_45.w = mix ((clamp (
    (filterBaseAlpha_10 * tmpvar_5)
  , 0.0, 1.0) * _ES_CloudOpacity), 1.0, (tmpvar_44 * (tmpvar_44 * 
    (3.0 - (2.0 * tmpvar_44))
  )));
  highp float wispyOpacity_46;
  lowp float tmpvar_47;
  tmpvar_47 = texture2D (_CloudWispsTex, xlv_TEXCOORD3.zw).w;
  wispyOpacity_46 = tmpvar_47;
  mediump float value_48;
  value_48 = wispyOpacity_46;
  mediump float low_49;
  low_49 = (1.0 - _ES_CloudWispsCoverage);
  mediump float tmpvar_50;
  tmpvar_50 = clamp (((value_48 - low_49) / (1.0 - low_49)), 0.0, 1.0);
  wispyOpacity_46 = (tmpvar_50 * _ES_CloudWispsOpacity);
  highp vec4 tmpvar_51;
  tmpvar_51.xyz = mix (xlv_TEXCOORD9, xlv_TEXCOORD10, vec3(wispyOpacity_46));
  tmpvar_51.w = wispyOpacity_46;
  cloudWisps_2 = tmpvar_51;
  finalCol_1.w = 0.0;
  finalCol_1.xyz = mix ((cloudWisps_2.xyz * cloudWisps_2.w), tmpvar_45.xyz, tmpvar_45.www);
  finalCol_1.xyz = (finalCol_1.xyz * ((xlv_TEXCOORD5.w * _ES_CloudSunBrightenIntensity) + 1.0));
  finalCol_1.w = tmpvar_45.w;
  gl_FragData[0] = finalCol_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec3 _ES_LightDirection;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunHaloSize;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform highp vec2 _ES_CloudDirection;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudHeight;
uniform highp float _ES_CloudTiling;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudWispsElapsedTime;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec3 xlv_TEXCOORD9;
varying mediump vec3 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 worldBinormal_2;
  mediump vec3 worldTangent_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_7.zw = vec2(0.0, 0.0);
  highp vec4 clipPos_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  clipPos_9.xyw = tmpvar_10.xyw;
  clipPos_9.z = tmpvar_10.w;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10.xyww * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = clipPos_9.zw;
  mediump vec3 viewDir_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(((unity_ObjectToWorld * tmpvar_16).xyz - _ES_SkyCenterWorldPos));
  viewDir_15 = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = dot (_ES_SkyWorldUpDir, viewDir_15);
  mediump vec4 tmpvar_19;
  tmpvar_19.xyz = viewDir_15;
  tmpvar_19.w = ((sign(tmpvar_18) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_18))) * (1.570796 + (abs(tmpvar_18) * (-0.2146018 + 
      (abs(tmpvar_18) * (0.08656672 + (abs(tmpvar_18) * -0.03102955)))
    ))))
  )) * 0.6366198);
  highp vec2 tmpvar_20;
  tmpvar_20 = mix (_glesMultiTexCoord1.xy, _glesMultiTexCoord2.xy, vec2(_ES_CloudHeight));
  highp vec2 tmpvar_21;
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_20 - 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = _ES_CloudDirection.y;
  tmpvar_23.y = -(_ES_CloudDirection.x);
  highp vec2 tmpvar_24;
  tmpvar_24.x = dot (tmpvar_23, tmpvar_22);
  tmpvar_24.y = dot (_ES_CloudDirection, tmpvar_22);
  tmpvar_21 = (tmpvar_24 + 0.5);
  highp vec2 tmpvar_25;
  tmpvar_25 = (tmpvar_21 * _ES_CloudTiling);
  tmpvar_4.xy = ((tmpvar_25 * 1.2) + (_ES_CloudElapsedTime * vec2(0.6, 0.0)));
  tmpvar_4.zw = ((tmpvar_25 * 0.9) + (_ES_CloudElapsedTime * vec2(0.78, 0.0)));
  tmpvar_5.xy = ((tmpvar_25 * 0.7) + (_ES_CloudElapsedTime * vec2(0.28, 0.0035)));
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_glesNormal * tmpvar_26));
  highp vec3 lookAtVector_28;
  lookAtVector_28 = (viewDir_15 * vec3(1.0, -1.0, 1.0));
  highp vec3 tmpvar_29;
  tmpvar_29 = normalize(lookAtVector_28);
  lookAtVector_28 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = (((
    (1.570796 - (sign(tmpvar_29.y) * (1.570796 - (
      sqrt((1.0 - abs(tmpvar_29.y)))
     * 
      (1.570796 + (abs(tmpvar_29.y) * (-0.2146018 + (
        abs(tmpvar_29.y)
       * 
        (0.08656672 + (abs(tmpvar_29.y) * -0.03102955))
      ))))
    ))))
   * 57.29) / 360.0) * 6.283185);
  highp vec3 tmpvar_31;
  tmpvar_31 = ((vec3(1.0, 0.0, 0.0) * tmpvar_29.zxy) - (vec3(0.0, 0.0, 1.0) * tmpvar_29.yzx));
  highp vec3 tmpvar_32;
  tmpvar_32 = (dot (tmpvar_27, tmpvar_31) * tmpvar_31);
  highp vec3 tmpvar_33;
  tmpvar_33 = (tmpvar_27 - tmpvar_32);
  tmpvar_5.zw = (((
    (cos(tmpvar_30) * tmpvar_33)
   + 
    (sin(tmpvar_30) * ((tmpvar_31.yzx * tmpvar_33.zxy) - (tmpvar_31.zxy * tmpvar_33.yzx)))
  ) + tmpvar_32) + tmpvar_27).xz;
  tmpvar_6.xy = ((tmpvar_21 * _CloudCurlTiling) + ((vec2(1.2, 0.8) * _CloudCurlSpeed) * _ES_CloudElapsedTime));
  highp vec2 tmpvar_34;
  tmpvar_34.x = (_glesMultiTexCoord0.x + _ES_CloudWispsElapsedTime);
  tmpvar_34.y = _glesMultiTexCoord0.y;
  tmpvar_6.zw = tmpvar_34;
  tmpvar_7.xy = tmpvar_20;
  mediump float x_35;
  x_35 = (1.0 - (_ES_CloudCoverage * 0.7));
  mediump float tmpvar_36;
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_36 = (tmpvar_37 * (tmpvar_37 * (3.0 - 
    (2.0 * tmpvar_37)
  )));
  mediump float tmpvar_38;
  tmpvar_38 = dot (viewDir_15, _ES_SunDirection);
  tmpvar_8.x = _ES_CloudCoverage;
  tmpvar_8.y = (((x_35 * x_35) * x_35) - 0.15);
  tmpvar_8.z = tmpvar_36;
  tmpvar_8.w = ((tmpvar_38 * 0.5) + 0.5);
  highp vec3 viewDir_39;
  viewDir_39 = tmpvar_19.xyz;
  mediump float moonLunarCancel_40;
  mediump float tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (dot (_ES_MoonDirection, viewDir_39), 0.0, 1.0);
  tmpvar_41 = tmpvar_42;
  highp float tmpvar_43;
  mediump float tmpvar_44;
  tmpvar_44 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_43 = (1.0 - (tmpvar_44 * 2.0));
  moonLunarCancel_40 = tmpvar_43;
  mediump float tmpvar_45;
  tmpvar_45 = clamp (((
    ((tmpvar_41 * tmpvar_41) * ((tmpvar_41 * tmpvar_41) * tmpvar_41))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_46;
  viewDir_46 = tmpvar_19.xyz;
  mediump float vertical_47;
  mediump float tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp (((
    dot (_ES_SunDirection, viewDir_46)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_48 = tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = dot (viewDir_46, _ES_SkyWorldUpDir);
  vertical_47 = tmpvar_50;
  mediump float tmpvar_51;
  tmpvar_51 = max (((tmpvar_38 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_52;
  tmpvar_52 = ((tmpvar_51 * tmpvar_51) * tmpvar_51);
  highp mat3 tmpvar_53;
  tmpvar_53[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_53[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_53[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_54;
  tmpvar_54 = normalize((tmpvar_53 * _glesTANGENT.xyz));
  worldTangent_3 = tmpvar_54;
  highp vec3 tmpvar_55;
  tmpvar_55 = (((tmpvar_27.yzx * worldTangent_3.zxy) - (tmpvar_27.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  worldBinormal_2 = tmpvar_55;
  highp vec3 tmpvar_56;
  tmpvar_56 = worldTangent_3;
  highp vec3 tmpvar_57;
  tmpvar_57 = worldBinormal_2;
  mediump mat3 tmpvar_58;
  highp mat3 tmpvar_59;
  tmpvar_59[0].x = tmpvar_56.x;
  tmpvar_59[0].y = tmpvar_57.x;
  tmpvar_59[0].z = tmpvar_27.x;
  tmpvar_59[1].x = tmpvar_56.y;
  tmpvar_59[1].y = tmpvar_57.y;
  tmpvar_59[1].z = tmpvar_27.y;
  tmpvar_59[2].x = tmpvar_56.z;
  tmpvar_59[2].y = tmpvar_57.z;
  tmpvar_59[2].z = tmpvar_27.z;
  tmpvar_58 = tmpvar_59;
  gl_Position = clipPos_9;
  xlv_TEXCOORD0 = o_12;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_TEXCOORD7 = normalize((tmpvar_58 * _ES_LightDirection));
  xlv_TEXCOORD8 = (((
    ((((tmpvar_45 * 
      (tmpvar_45 * (3.0 - (2.0 * tmpvar_45)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_40) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_48, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_47))
    ) * vertical_47), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_36);
  xlv_TEXCOORD9 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_52));
  xlv_TEXCOORD10 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_52));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_CloudCoverage;
uniform mediump float _ES_CloudOpacity;
uniform mediump vec2 _ES_CloudSmoothness;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform mediump float _ES_CloudWispsCoverage;
uniform mediump float _ES_CloudWispsOpacity;
uniform sampler2D _ES_WeatherMap;
uniform sampler2D _CloudDensityMap;
uniform sampler2D _CloudNormalMap;
uniform sampler2D _CloudWispsTex;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
uniform mediump float _CloudDarkShadingNormalYScale;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec3 xlv_TEXCOORD9;
varying mediump vec3 xlv_TEXCOORD10;
void main ()
{
  mediump vec4 finalCol_1;
  mediump vec4 cloudWisps_2;
  mediump vec3 weather_3;
  mediump float tmpvar_4;
  tmpvar_4 = clamp ((xlv_TEXCOORD6.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_5;
  tmpvar_5 = clamp ((tmpvar_4 * (tmpvar_4 * 
    (3.0 - (2.0 * tmpvar_4))
  )), 0.0, 1.0);
  mediump float tmpvar_6;
  tmpvar_6 = xlv_TEXCOORD5.y;
  mediump float tmpvar_7;
  tmpvar_7 = clamp (((xlv_TEXCOORD5.w - _ES_SunRimLightRadius) / (1.0 - _ES_SunRimLightRadius)), 0.0, 1.0);
  mediump float tmpvar_8;
  tmpvar_8 = (((tmpvar_7 * 
    (tmpvar_7 * (3.0 - (2.0 * tmpvar_7)))
  ) * _ES_SunBrightness) * 0.05);
  lowp vec3 tmpvar_9;
  tmpvar_9 = texture2D (_ES_WeatherMap, xlv_TEXCOORD4.xy).xyz;
  weather_3 = tmpvar_9;
  mediump float filterBaseAlpha_10;
  mediump float filterHighlightArea_11;
  mediump float variationClouds_12;
  mediump vec3 cloudNormal_13;
  mediump vec3 shadowTex_14;
  mediump vec3 cloudTex1_15;
  mediump vec3 cloudTex0_16;
  highp vec3 curlNoise_17;
  lowp vec3 tmpvar_18;
  tmpvar_18 = texture2D (_CloudCurlTex, xlv_TEXCOORD3.xy).xyz;
  curlNoise_17 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = ((curlNoise_17.xy - 0.5) * mix ((_CloudCurlAmplitude * 0.2), _CloudCurlAmplitude, weather_3.y));
  highp vec2 P_20;
  P_20 = (xlv_TEXCOORD1.xy + tmpvar_19);
  lowp vec3 tmpvar_21;
  tmpvar_21 = texture2D (_CloudDensityMap, P_20).xyz;
  cloudTex0_16 = tmpvar_21;
  highp vec2 P_22;
  P_22 = (xlv_TEXCOORD1.zw + tmpvar_19);
  lowp vec3 tmpvar_23;
  tmpvar_23 = texture2D (_CloudDensityMap, P_22).xyz;
  cloudTex1_15 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = (0.03 - (cloudTex0_16.y * 0.01));
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD2.xy + (xlv_TEXCOORD2.zw * tmpvar_24)) + (tmpvar_19 * 0.5));
  lowp vec3 tmpvar_26;
  tmpvar_26 = texture2D (_CloudDensityMap, P_25).xyz;
  shadowTex_14 = tmpvar_26;
  highp vec2 P_27;
  P_27 = (xlv_TEXCOORD2.xy + tmpvar_19);
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_CloudNormalMap, P_27).xyz * 2.0) - 1.0);
  cloudNormal_13 = tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29.xz = vec2(1.0, 1.0);
  tmpvar_29.y = _CloudDarkShadingNormalYScale;
  mediump float tmpvar_30;
  tmpvar_30 = clamp (((
    dot (normalize((cloudNormal_13 * tmpvar_29)), xlv_TEXCOORD7)
   * 0.5) + 0.5), 0.0, 1.0);
  mediump float tmpvar_31;
  tmpvar_31 = clamp ((clamp (
    ((shadowTex_14.y * shadowTex_14.z) * 2.0)
  , 0.0, 1.0) + (shadowTex_14.x - 0.5)), 0.0, 1.0);
  mediump float tmpvar_32;
  tmpvar_32 = (((1.0 - tmpvar_5) * 0.2) + ((
    (cloudTex1_15.z * cloudTex0_16.z)
   + 
    ((cloudTex0_16.x - 0.5) * 0.15)
  ) * weather_3.x));
  highp float value_33;
  value_33 = (cloudTex1_15.x * cloudTex1_15.y);
  highp float tmpvar_34;
  tmpvar_34 = clamp ((value_33 / 0.5), 0.0, 1.0);
  variationClouds_12 = tmpvar_34;
  variationClouds_12 = (variationClouds_12 * variationClouds_12);
  highp float middleThreshold_35;
  middleThreshold_35 = tmpvar_6;
  highp float gradientWidth_36;
  gradientWidth_36 = (0.5 + (variationClouds_12 * 0.5));
  highp float value_37;
  value_37 = tmpvar_32;
  highp float tmpvar_38;
  tmpvar_38 = clamp (((value_37 - middleThreshold_35) / gradientWidth_36), 0.0, 1.0);
  filterHighlightArea_11 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = mix (_ES_CloudSmoothness.x, _ES_CloudSmoothness.y, weather_3.z);
  highp float middleThreshold_40;
  middleThreshold_40 = tmpvar_6;
  highp float gradientWidth_41;
  gradientWidth_41 = ((variationClouds_12 * tmpvar_39) + 0.05);
  highp float value_42;
  value_42 = tmpvar_32;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((value_42 - middleThreshold_40) / gradientWidth_41), 0.0, 1.0);
  filterBaseAlpha_10 = tmpvar_43;
  mediump float tmpvar_44;
  tmpvar_44 = clamp (((_ES_CloudCoverage - 0.5) / 0.2), 0.0, 1.0);
  mediump vec4 tmpvar_45;
  tmpvar_45.xyz = (((
    mix (xlv_TEXCOORD10, xlv_TEXCOORD9, vec3(((tmpvar_31 * tmpvar_31) * (1.0 - (tmpvar_30 * 
      (tmpvar_30 * (3.0 - (2.0 * tmpvar_30)))
    )))))
   + 
    ((((
      (clamp (pow (max (
        min (max (((0.5 - filterHighlightArea_11) * 2.0), 0.0), 1.0)
      , 0.0001), (tmpvar_8 * 30.0)), 0.0, 1.0) * (tmpvar_8 * tmpvar_8))
     * _ES_SunHaloColor) * 50.0) * variationClouds_12) * xlv_TEXCOORD5.z)
  ) + (
    ((variationClouds_12 * 0.5) * xlv_TEXCOORD9)
   * xlv_TEXCOORD5.x)) + (xlv_TEXCOORD8 * tmpvar_31));
  tmpvar_45.w = mix ((clamp (
    (filterBaseAlpha_10 * tmpvar_5)
  , 0.0, 1.0) * _ES_CloudOpacity), 1.0, (tmpvar_44 * (tmpvar_44 * 
    (3.0 - (2.0 * tmpvar_44))
  )));
  highp float wispyOpacity_46;
  lowp float tmpvar_47;
  tmpvar_47 = texture2D (_CloudWispsTex, xlv_TEXCOORD3.zw).w;
  wispyOpacity_46 = tmpvar_47;
  mediump float value_48;
  value_48 = wispyOpacity_46;
  mediump float low_49;
  low_49 = (1.0 - _ES_CloudWispsCoverage);
  mediump float tmpvar_50;
  tmpvar_50 = clamp (((value_48 - low_49) / (1.0 - low_49)), 0.0, 1.0);
  wispyOpacity_46 = (tmpvar_50 * _ES_CloudWispsOpacity);
  highp vec4 tmpvar_51;
  tmpvar_51.xyz = mix (xlv_TEXCOORD9, xlv_TEXCOORD10, vec3(wispyOpacity_46));
  tmpvar_51.w = wispyOpacity_46;
  cloudWisps_2 = tmpvar_51;
  finalCol_1.w = 0.0;
  finalCol_1.xyz = mix ((cloudWisps_2.xyz * cloudWisps_2.w), tmpvar_45.xyz, tmpvar_45.www);
  finalCol_1.xyz = (finalCol_1.xyz * ((xlv_TEXCOORD5.w * _ES_CloudSunBrightenIntensity) + 1.0));
  finalCol_1.w = tmpvar_45.w;
  gl_FragData[0] = finalCol_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec3 _ES_LightDirection;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunHaloSize;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform highp vec2 _ES_CloudDirection;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudHeight;
uniform highp float _ES_CloudTiling;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudWispsElapsedTime;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec3 xlv_TEXCOORD9;
varying mediump vec3 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 worldBinormal_2;
  mediump vec3 worldTangent_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_7.zw = vec2(0.0, 0.0);
  highp vec4 clipPos_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  clipPos_9.xyw = tmpvar_10.xyw;
  clipPos_9.z = tmpvar_10.w;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10.xyww * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = clipPos_9.zw;
  mediump vec3 viewDir_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(((unity_ObjectToWorld * tmpvar_16).xyz - _ES_SkyCenterWorldPos));
  viewDir_15 = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = dot (_ES_SkyWorldUpDir, viewDir_15);
  mediump vec4 tmpvar_19;
  tmpvar_19.xyz = viewDir_15;
  tmpvar_19.w = ((sign(tmpvar_18) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_18))) * (1.570796 + (abs(tmpvar_18) * (-0.2146018 + 
      (abs(tmpvar_18) * (0.08656672 + (abs(tmpvar_18) * -0.03102955)))
    ))))
  )) * 0.6366198);
  highp vec2 tmpvar_20;
  tmpvar_20 = mix (_glesMultiTexCoord1.xy, _glesMultiTexCoord2.xy, vec2(_ES_CloudHeight));
  highp vec2 tmpvar_21;
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_20 - 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = _ES_CloudDirection.y;
  tmpvar_23.y = -(_ES_CloudDirection.x);
  highp vec2 tmpvar_24;
  tmpvar_24.x = dot (tmpvar_23, tmpvar_22);
  tmpvar_24.y = dot (_ES_CloudDirection, tmpvar_22);
  tmpvar_21 = (tmpvar_24 + 0.5);
  highp vec2 tmpvar_25;
  tmpvar_25 = (tmpvar_21 * _ES_CloudTiling);
  tmpvar_4.xy = ((tmpvar_25 * 1.2) + (_ES_CloudElapsedTime * vec2(0.6, 0.0)));
  tmpvar_4.zw = ((tmpvar_25 * 0.9) + (_ES_CloudElapsedTime * vec2(0.78, 0.0)));
  tmpvar_5.xy = ((tmpvar_25 * 0.7) + (_ES_CloudElapsedTime * vec2(0.28, 0.0035)));
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_glesNormal * tmpvar_26));
  highp vec3 lookAtVector_28;
  lookAtVector_28 = (viewDir_15 * vec3(1.0, -1.0, 1.0));
  highp vec3 tmpvar_29;
  tmpvar_29 = normalize(lookAtVector_28);
  lookAtVector_28 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = (((
    (1.570796 - (sign(tmpvar_29.y) * (1.570796 - (
      sqrt((1.0 - abs(tmpvar_29.y)))
     * 
      (1.570796 + (abs(tmpvar_29.y) * (-0.2146018 + (
        abs(tmpvar_29.y)
       * 
        (0.08656672 + (abs(tmpvar_29.y) * -0.03102955))
      ))))
    ))))
   * 57.29) / 360.0) * 6.283185);
  highp vec3 tmpvar_31;
  tmpvar_31 = ((vec3(1.0, 0.0, 0.0) * tmpvar_29.zxy) - (vec3(0.0, 0.0, 1.0) * tmpvar_29.yzx));
  highp vec3 tmpvar_32;
  tmpvar_32 = (dot (tmpvar_27, tmpvar_31) * tmpvar_31);
  highp vec3 tmpvar_33;
  tmpvar_33 = (tmpvar_27 - tmpvar_32);
  tmpvar_5.zw = (((
    (cos(tmpvar_30) * tmpvar_33)
   + 
    (sin(tmpvar_30) * ((tmpvar_31.yzx * tmpvar_33.zxy) - (tmpvar_31.zxy * tmpvar_33.yzx)))
  ) + tmpvar_32) + tmpvar_27).xz;
  tmpvar_6.xy = ((tmpvar_21 * _CloudCurlTiling) + ((vec2(1.2, 0.8) * _CloudCurlSpeed) * _ES_CloudElapsedTime));
  highp vec2 tmpvar_34;
  tmpvar_34.x = (_glesMultiTexCoord0.x + _ES_CloudWispsElapsedTime);
  tmpvar_34.y = _glesMultiTexCoord0.y;
  tmpvar_6.zw = tmpvar_34;
  tmpvar_7.xy = tmpvar_20;
  mediump float x_35;
  x_35 = (1.0 - (_ES_CloudCoverage * 0.7));
  mediump float tmpvar_36;
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_36 = (tmpvar_37 * (tmpvar_37 * (3.0 - 
    (2.0 * tmpvar_37)
  )));
  mediump float tmpvar_38;
  tmpvar_38 = dot (viewDir_15, _ES_SunDirection);
  tmpvar_8.x = _ES_CloudCoverage;
  tmpvar_8.y = (((x_35 * x_35) * x_35) - 0.15);
  tmpvar_8.z = tmpvar_36;
  tmpvar_8.w = ((tmpvar_38 * 0.5) + 0.5);
  highp vec3 viewDir_39;
  viewDir_39 = tmpvar_19.xyz;
  mediump float moonLunarCancel_40;
  mediump float tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (dot (_ES_MoonDirection, viewDir_39), 0.0, 1.0);
  tmpvar_41 = tmpvar_42;
  highp float tmpvar_43;
  mediump float tmpvar_44;
  tmpvar_44 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_43 = (1.0 - (tmpvar_44 * 2.0));
  moonLunarCancel_40 = tmpvar_43;
  mediump float tmpvar_45;
  tmpvar_45 = clamp (((
    ((tmpvar_41 * tmpvar_41) * ((tmpvar_41 * tmpvar_41) * tmpvar_41))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_46;
  viewDir_46 = tmpvar_19.xyz;
  mediump float vertical_47;
  mediump float tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp (((
    dot (_ES_SunDirection, viewDir_46)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_48 = tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = dot (viewDir_46, _ES_SkyWorldUpDir);
  vertical_47 = tmpvar_50;
  mediump float tmpvar_51;
  tmpvar_51 = max (((tmpvar_38 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_52;
  tmpvar_52 = ((tmpvar_51 * tmpvar_51) * tmpvar_51);
  highp mat3 tmpvar_53;
  tmpvar_53[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_53[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_53[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_54;
  tmpvar_54 = normalize((tmpvar_53 * _glesTANGENT.xyz));
  worldTangent_3 = tmpvar_54;
  highp vec3 tmpvar_55;
  tmpvar_55 = (((tmpvar_27.yzx * worldTangent_3.zxy) - (tmpvar_27.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  worldBinormal_2 = tmpvar_55;
  highp vec3 tmpvar_56;
  tmpvar_56 = worldTangent_3;
  highp vec3 tmpvar_57;
  tmpvar_57 = worldBinormal_2;
  mediump mat3 tmpvar_58;
  highp mat3 tmpvar_59;
  tmpvar_59[0].x = tmpvar_56.x;
  tmpvar_59[0].y = tmpvar_57.x;
  tmpvar_59[0].z = tmpvar_27.x;
  tmpvar_59[1].x = tmpvar_56.y;
  tmpvar_59[1].y = tmpvar_57.y;
  tmpvar_59[1].z = tmpvar_27.y;
  tmpvar_59[2].x = tmpvar_56.z;
  tmpvar_59[2].y = tmpvar_57.z;
  tmpvar_59[2].z = tmpvar_27.z;
  tmpvar_58 = tmpvar_59;
  gl_Position = clipPos_9;
  xlv_TEXCOORD0 = o_12;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_TEXCOORD7 = normalize((tmpvar_58 * _ES_LightDirection));
  xlv_TEXCOORD8 = (((
    ((((tmpvar_45 * 
      (tmpvar_45 * (3.0 - (2.0 * tmpvar_45)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_40) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_48, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_47))
    ) * vertical_47), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_36);
  xlv_TEXCOORD9 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_52));
  xlv_TEXCOORD10 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_52));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_CloudCoverage;
uniform mediump float _ES_CloudOpacity;
uniform mediump vec2 _ES_CloudSmoothness;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform mediump float _ES_CloudWispsCoverage;
uniform mediump float _ES_CloudWispsOpacity;
uniform sampler2D _ES_WeatherMap;
uniform sampler2D _CloudDensityMap;
uniform sampler2D _CloudNormalMap;
uniform sampler2D _CloudWispsTex;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
uniform mediump float _CloudDarkShadingNormalYScale;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec3 xlv_TEXCOORD9;
varying mediump vec3 xlv_TEXCOORD10;
void main ()
{
  mediump vec4 finalCol_1;
  mediump vec4 cloudWisps_2;
  mediump vec3 weather_3;
  mediump float tmpvar_4;
  tmpvar_4 = clamp ((xlv_TEXCOORD6.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_5;
  tmpvar_5 = clamp ((tmpvar_4 * (tmpvar_4 * 
    (3.0 - (2.0 * tmpvar_4))
  )), 0.0, 1.0);
  mediump float tmpvar_6;
  tmpvar_6 = xlv_TEXCOORD5.y;
  mediump float tmpvar_7;
  tmpvar_7 = clamp (((xlv_TEXCOORD5.w - _ES_SunRimLightRadius) / (1.0 - _ES_SunRimLightRadius)), 0.0, 1.0);
  mediump float tmpvar_8;
  tmpvar_8 = (((tmpvar_7 * 
    (tmpvar_7 * (3.0 - (2.0 * tmpvar_7)))
  ) * _ES_SunBrightness) * 0.05);
  lowp vec3 tmpvar_9;
  tmpvar_9 = texture2D (_ES_WeatherMap, xlv_TEXCOORD4.xy).xyz;
  weather_3 = tmpvar_9;
  mediump float filterBaseAlpha_10;
  mediump float filterHighlightArea_11;
  mediump float variationClouds_12;
  mediump vec3 cloudNormal_13;
  mediump vec3 shadowTex_14;
  mediump vec3 cloudTex1_15;
  mediump vec3 cloudTex0_16;
  highp vec3 curlNoise_17;
  lowp vec3 tmpvar_18;
  tmpvar_18 = texture2D (_CloudCurlTex, xlv_TEXCOORD3.xy).xyz;
  curlNoise_17 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = ((curlNoise_17.xy - 0.5) * mix ((_CloudCurlAmplitude * 0.2), _CloudCurlAmplitude, weather_3.y));
  highp vec2 P_20;
  P_20 = (xlv_TEXCOORD1.xy + tmpvar_19);
  lowp vec3 tmpvar_21;
  tmpvar_21 = texture2D (_CloudDensityMap, P_20).xyz;
  cloudTex0_16 = tmpvar_21;
  highp vec2 P_22;
  P_22 = (xlv_TEXCOORD1.zw + tmpvar_19);
  lowp vec3 tmpvar_23;
  tmpvar_23 = texture2D (_CloudDensityMap, P_22).xyz;
  cloudTex1_15 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = (0.03 - (cloudTex0_16.y * 0.01));
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD2.xy + (xlv_TEXCOORD2.zw * tmpvar_24)) + (tmpvar_19 * 0.5));
  lowp vec3 tmpvar_26;
  tmpvar_26 = texture2D (_CloudDensityMap, P_25).xyz;
  shadowTex_14 = tmpvar_26;
  highp vec2 P_27;
  P_27 = (xlv_TEXCOORD2.xy + tmpvar_19);
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_CloudNormalMap, P_27).xyz * 2.0) - 1.0);
  cloudNormal_13 = tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29.xz = vec2(1.0, 1.0);
  tmpvar_29.y = _CloudDarkShadingNormalYScale;
  mediump float tmpvar_30;
  tmpvar_30 = clamp (((
    dot (normalize((cloudNormal_13 * tmpvar_29)), xlv_TEXCOORD7)
   * 0.5) + 0.5), 0.0, 1.0);
  mediump float tmpvar_31;
  tmpvar_31 = clamp ((clamp (
    ((shadowTex_14.y * shadowTex_14.z) * 2.0)
  , 0.0, 1.0) + (shadowTex_14.x - 0.5)), 0.0, 1.0);
  mediump float tmpvar_32;
  tmpvar_32 = (((1.0 - tmpvar_5) * 0.2) + ((
    (cloudTex1_15.z * cloudTex0_16.z)
   + 
    ((cloudTex0_16.x - 0.5) * 0.15)
  ) * weather_3.x));
  highp float value_33;
  value_33 = (cloudTex1_15.x * cloudTex1_15.y);
  highp float tmpvar_34;
  tmpvar_34 = clamp ((value_33 / 0.5), 0.0, 1.0);
  variationClouds_12 = tmpvar_34;
  variationClouds_12 = (variationClouds_12 * variationClouds_12);
  highp float middleThreshold_35;
  middleThreshold_35 = tmpvar_6;
  highp float gradientWidth_36;
  gradientWidth_36 = (0.5 + (variationClouds_12 * 0.5));
  highp float value_37;
  value_37 = tmpvar_32;
  highp float tmpvar_38;
  tmpvar_38 = clamp (((value_37 - middleThreshold_35) / gradientWidth_36), 0.0, 1.0);
  filterHighlightArea_11 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = mix (_ES_CloudSmoothness.x, _ES_CloudSmoothness.y, weather_3.z);
  highp float middleThreshold_40;
  middleThreshold_40 = tmpvar_6;
  highp float gradientWidth_41;
  gradientWidth_41 = ((variationClouds_12 * tmpvar_39) + 0.05);
  highp float value_42;
  value_42 = tmpvar_32;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((value_42 - middleThreshold_40) / gradientWidth_41), 0.0, 1.0);
  filterBaseAlpha_10 = tmpvar_43;
  mediump float tmpvar_44;
  tmpvar_44 = clamp (((_ES_CloudCoverage - 0.5) / 0.2), 0.0, 1.0);
  mediump vec4 tmpvar_45;
  tmpvar_45.xyz = (((
    mix (xlv_TEXCOORD10, xlv_TEXCOORD9, vec3(((tmpvar_31 * tmpvar_31) * (1.0 - (tmpvar_30 * 
      (tmpvar_30 * (3.0 - (2.0 * tmpvar_30)))
    )))))
   + 
    ((((
      (clamp (pow (max (
        min (max (((0.5 - filterHighlightArea_11) * 2.0), 0.0), 1.0)
      , 0.0001), (tmpvar_8 * 30.0)), 0.0, 1.0) * (tmpvar_8 * tmpvar_8))
     * _ES_SunHaloColor) * 50.0) * variationClouds_12) * xlv_TEXCOORD5.z)
  ) + (
    ((variationClouds_12 * 0.5) * xlv_TEXCOORD9)
   * xlv_TEXCOORD5.x)) + (xlv_TEXCOORD8 * tmpvar_31));
  tmpvar_45.w = mix ((clamp (
    (filterBaseAlpha_10 * tmpvar_5)
  , 0.0, 1.0) * _ES_CloudOpacity), 1.0, (tmpvar_44 * (tmpvar_44 * 
    (3.0 - (2.0 * tmpvar_44))
  )));
  highp float wispyOpacity_46;
  lowp float tmpvar_47;
  tmpvar_47 = texture2D (_CloudWispsTex, xlv_TEXCOORD3.zw).w;
  wispyOpacity_46 = tmpvar_47;
  mediump float value_48;
  value_48 = wispyOpacity_46;
  mediump float low_49;
  low_49 = (1.0 - _ES_CloudWispsCoverage);
  mediump float tmpvar_50;
  tmpvar_50 = clamp (((value_48 - low_49) / (1.0 - low_49)), 0.0, 1.0);
  wispyOpacity_46 = (tmpvar_50 * _ES_CloudWispsOpacity);
  highp vec4 tmpvar_51;
  tmpvar_51.xyz = mix (xlv_TEXCOORD9, xlv_TEXCOORD10, vec3(wispyOpacity_46));
  tmpvar_51.w = wispyOpacity_46;
  cloudWisps_2 = tmpvar_51;
  finalCol_1.w = 0.0;
  finalCol_1.xyz = mix ((cloudWisps_2.xyz * cloudWisps_2.w), tmpvar_45.xyz, tmpvar_45.www);
  finalCol_1.xyz = (finalCol_1.xyz * ((xlv_TEXCOORD5.w * _ES_CloudSunBrightenIntensity) + 1.0));
  finalCol_1.w = tmpvar_45.w;
  gl_FragData[0] = finalCol_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec3 _ES_LightDirection;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunHaloSize;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform highp vec2 _ES_CloudDirection;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudHeight;
uniform highp float _ES_CloudTiling;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudWispsElapsedTime;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec3 xlv_TEXCOORD9;
varying mediump vec3 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 worldBinormal_2;
  mediump vec3 worldTangent_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_7.zw = vec2(0.0, 0.0);
  highp vec4 clipPos_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  clipPos_9.xyw = tmpvar_10.xyw;
  clipPos_9.z = tmpvar_10.w;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10.xyww * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = clipPos_9.zw;
  mediump vec3 viewDir_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(((unity_ObjectToWorld * tmpvar_16).xyz - _ES_SkyCenterWorldPos));
  viewDir_15 = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = dot (_ES_SkyWorldUpDir, viewDir_15);
  mediump vec4 tmpvar_19;
  tmpvar_19.xyz = viewDir_15;
  tmpvar_19.w = ((sign(tmpvar_18) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_18))) * (1.570796 + (abs(tmpvar_18) * (-0.2146018 + 
      (abs(tmpvar_18) * (0.08656672 + (abs(tmpvar_18) * -0.03102955)))
    ))))
  )) * 0.6366198);
  highp vec2 tmpvar_20;
  tmpvar_20 = mix (_glesMultiTexCoord1.xy, _glesMultiTexCoord2.xy, vec2(_ES_CloudHeight));
  highp vec2 tmpvar_21;
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_20 - 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = _ES_CloudDirection.y;
  tmpvar_23.y = -(_ES_CloudDirection.x);
  highp vec2 tmpvar_24;
  tmpvar_24.x = dot (tmpvar_23, tmpvar_22);
  tmpvar_24.y = dot (_ES_CloudDirection, tmpvar_22);
  tmpvar_21 = (tmpvar_24 + 0.5);
  highp vec2 tmpvar_25;
  tmpvar_25 = (tmpvar_21 * _ES_CloudTiling);
  tmpvar_4.xy = ((tmpvar_25 * 1.2) + (_ES_CloudElapsedTime * vec2(0.6, 0.0)));
  tmpvar_4.zw = ((tmpvar_25 * 0.9) + (_ES_CloudElapsedTime * vec2(0.78, 0.0)));
  tmpvar_5.xy = ((tmpvar_25 * 0.7) + (_ES_CloudElapsedTime * vec2(0.28, 0.0035)));
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_glesNormal * tmpvar_26));
  highp vec3 lookAtVector_28;
  lookAtVector_28 = (viewDir_15 * vec3(1.0, -1.0, 1.0));
  highp vec3 tmpvar_29;
  tmpvar_29 = normalize(lookAtVector_28);
  lookAtVector_28 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = (((
    (1.570796 - (sign(tmpvar_29.y) * (1.570796 - (
      sqrt((1.0 - abs(tmpvar_29.y)))
     * 
      (1.570796 + (abs(tmpvar_29.y) * (-0.2146018 + (
        abs(tmpvar_29.y)
       * 
        (0.08656672 + (abs(tmpvar_29.y) * -0.03102955))
      ))))
    ))))
   * 57.29) / 360.0) * 6.283185);
  highp vec3 tmpvar_31;
  tmpvar_31 = ((vec3(1.0, 0.0, 0.0) * tmpvar_29.zxy) - (vec3(0.0, 0.0, 1.0) * tmpvar_29.yzx));
  highp vec3 tmpvar_32;
  tmpvar_32 = (dot (tmpvar_27, tmpvar_31) * tmpvar_31);
  highp vec3 tmpvar_33;
  tmpvar_33 = (tmpvar_27 - tmpvar_32);
  tmpvar_5.zw = (((
    (cos(tmpvar_30) * tmpvar_33)
   + 
    (sin(tmpvar_30) * ((tmpvar_31.yzx * tmpvar_33.zxy) - (tmpvar_31.zxy * tmpvar_33.yzx)))
  ) + tmpvar_32) + tmpvar_27).xz;
  tmpvar_6.xy = ((tmpvar_21 * _CloudCurlTiling) + ((vec2(1.2, 0.8) * _CloudCurlSpeed) * _ES_CloudElapsedTime));
  highp vec2 tmpvar_34;
  tmpvar_34.x = (_glesMultiTexCoord0.x + _ES_CloudWispsElapsedTime);
  tmpvar_34.y = _glesMultiTexCoord0.y;
  tmpvar_6.zw = tmpvar_34;
  tmpvar_7.xy = tmpvar_20;
  mediump float x_35;
  x_35 = (1.0 - (_ES_CloudCoverage * 0.7));
  mediump float tmpvar_36;
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_36 = (tmpvar_37 * (tmpvar_37 * (3.0 - 
    (2.0 * tmpvar_37)
  )));
  mediump float tmpvar_38;
  tmpvar_38 = dot (viewDir_15, _ES_SunDirection);
  tmpvar_8.x = _ES_CloudCoverage;
  tmpvar_8.y = (((x_35 * x_35) * x_35) - 0.15);
  tmpvar_8.z = tmpvar_36;
  tmpvar_8.w = ((tmpvar_38 * 0.5) + 0.5);
  highp vec3 viewDir_39;
  viewDir_39 = tmpvar_19.xyz;
  mediump float moonLunarCancel_40;
  mediump float tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (dot (_ES_MoonDirection, viewDir_39), 0.0, 1.0);
  tmpvar_41 = tmpvar_42;
  highp float tmpvar_43;
  mediump float tmpvar_44;
  tmpvar_44 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_43 = (1.0 - (tmpvar_44 * 2.0));
  moonLunarCancel_40 = tmpvar_43;
  mediump float tmpvar_45;
  tmpvar_45 = clamp (((
    ((tmpvar_41 * tmpvar_41) * ((tmpvar_41 * tmpvar_41) * tmpvar_41))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_46;
  viewDir_46 = tmpvar_19.xyz;
  mediump float vertical_47;
  mediump float tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp (((
    dot (_ES_SunDirection, viewDir_46)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_48 = tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = dot (viewDir_46, _ES_SkyWorldUpDir);
  vertical_47 = tmpvar_50;
  mediump float tmpvar_51;
  tmpvar_51 = max (((tmpvar_38 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_52;
  tmpvar_52 = ((tmpvar_51 * tmpvar_51) * tmpvar_51);
  highp mat3 tmpvar_53;
  tmpvar_53[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_53[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_53[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_54;
  tmpvar_54 = normalize((tmpvar_53 * _glesTANGENT.xyz));
  worldTangent_3 = tmpvar_54;
  highp vec3 tmpvar_55;
  tmpvar_55 = (((tmpvar_27.yzx * worldTangent_3.zxy) - (tmpvar_27.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  worldBinormal_2 = tmpvar_55;
  highp vec3 tmpvar_56;
  tmpvar_56 = worldTangent_3;
  highp vec3 tmpvar_57;
  tmpvar_57 = worldBinormal_2;
  mediump mat3 tmpvar_58;
  highp mat3 tmpvar_59;
  tmpvar_59[0].x = tmpvar_56.x;
  tmpvar_59[0].y = tmpvar_57.x;
  tmpvar_59[0].z = tmpvar_27.x;
  tmpvar_59[1].x = tmpvar_56.y;
  tmpvar_59[1].y = tmpvar_57.y;
  tmpvar_59[1].z = tmpvar_27.y;
  tmpvar_59[2].x = tmpvar_56.z;
  tmpvar_59[2].y = tmpvar_57.z;
  tmpvar_59[2].z = tmpvar_27.z;
  tmpvar_58 = tmpvar_59;
  gl_Position = clipPos_9;
  xlv_TEXCOORD0 = o_12;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_TEXCOORD7 = normalize((tmpvar_58 * _ES_LightDirection));
  xlv_TEXCOORD8 = (((
    ((((tmpvar_45 * 
      (tmpvar_45 * (3.0 - (2.0 * tmpvar_45)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_40) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_48, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_47))
    ) * vertical_47), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_36);
  xlv_TEXCOORD9 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_52));
  xlv_TEXCOORD10 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_52));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_CloudCoverage;
uniform mediump float _ES_CloudOpacity;
uniform mediump vec2 _ES_CloudSmoothness;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform mediump float _ES_CloudWispsCoverage;
uniform mediump float _ES_CloudWispsOpacity;
uniform sampler2D _ES_WeatherMap;
uniform sampler2D _CloudDensityMap;
uniform sampler2D _CloudNormalMap;
uniform sampler2D _CloudWispsTex;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
uniform mediump float _CloudDarkShadingNormalYScale;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec3 xlv_TEXCOORD9;
varying mediump vec3 xlv_TEXCOORD10;
void main ()
{
  mediump vec4 finalCol_1;
  mediump vec4 cloudWisps_2;
  mediump vec3 weather_3;
  mediump float tmpvar_4;
  tmpvar_4 = clamp ((xlv_TEXCOORD6.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_5;
  tmpvar_5 = clamp ((tmpvar_4 * (tmpvar_4 * 
    (3.0 - (2.0 * tmpvar_4))
  )), 0.0, 1.0);
  mediump float tmpvar_6;
  tmpvar_6 = xlv_TEXCOORD5.y;
  mediump float tmpvar_7;
  tmpvar_7 = clamp (((xlv_TEXCOORD5.w - _ES_SunRimLightRadius) / (1.0 - _ES_SunRimLightRadius)), 0.0, 1.0);
  mediump float tmpvar_8;
  tmpvar_8 = (((tmpvar_7 * 
    (tmpvar_7 * (3.0 - (2.0 * tmpvar_7)))
  ) * _ES_SunBrightness) * 0.05);
  lowp vec3 tmpvar_9;
  tmpvar_9 = texture2D (_ES_WeatherMap, xlv_TEXCOORD4.xy).xyz;
  weather_3 = tmpvar_9;
  mediump float filterBaseAlpha_10;
  mediump float filterHighlightArea_11;
  mediump float variationClouds_12;
  mediump vec3 cloudNormal_13;
  mediump vec3 shadowTex_14;
  mediump vec3 cloudTex1_15;
  mediump vec3 cloudTex0_16;
  highp vec3 curlNoise_17;
  lowp vec3 tmpvar_18;
  tmpvar_18 = texture2D (_CloudCurlTex, xlv_TEXCOORD3.xy).xyz;
  curlNoise_17 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = ((curlNoise_17.xy - 0.5) * mix ((_CloudCurlAmplitude * 0.2), _CloudCurlAmplitude, weather_3.y));
  highp vec2 P_20;
  P_20 = (xlv_TEXCOORD1.xy + tmpvar_19);
  lowp vec3 tmpvar_21;
  tmpvar_21 = texture2D (_CloudDensityMap, P_20).xyz;
  cloudTex0_16 = tmpvar_21;
  highp vec2 P_22;
  P_22 = (xlv_TEXCOORD1.zw + tmpvar_19);
  lowp vec3 tmpvar_23;
  tmpvar_23 = texture2D (_CloudDensityMap, P_22).xyz;
  cloudTex1_15 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = (0.03 - (cloudTex0_16.y * 0.01));
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD2.xy + (xlv_TEXCOORD2.zw * tmpvar_24)) + (tmpvar_19 * 0.5));
  lowp vec3 tmpvar_26;
  tmpvar_26 = texture2D (_CloudDensityMap, P_25).xyz;
  shadowTex_14 = tmpvar_26;
  highp vec2 P_27;
  P_27 = (xlv_TEXCOORD2.xy + tmpvar_19);
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_CloudNormalMap, P_27).xyz * 2.0) - 1.0);
  cloudNormal_13 = tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29.xz = vec2(1.0, 1.0);
  tmpvar_29.y = _CloudDarkShadingNormalYScale;
  mediump float tmpvar_30;
  tmpvar_30 = clamp (((
    dot (normalize((cloudNormal_13 * tmpvar_29)), xlv_TEXCOORD7)
   * 0.5) + 0.5), 0.0, 1.0);
  mediump float tmpvar_31;
  tmpvar_31 = clamp ((clamp (
    ((shadowTex_14.y * shadowTex_14.z) * 2.0)
  , 0.0, 1.0) + (shadowTex_14.x - 0.5)), 0.0, 1.0);
  mediump float tmpvar_32;
  tmpvar_32 = (((1.0 - tmpvar_5) * 0.2) + ((
    (cloudTex1_15.z * cloudTex0_16.z)
   + 
    ((cloudTex0_16.x - 0.5) * 0.15)
  ) * weather_3.x));
  highp float value_33;
  value_33 = (cloudTex1_15.x * cloudTex1_15.y);
  highp float tmpvar_34;
  tmpvar_34 = clamp ((value_33 / 0.5), 0.0, 1.0);
  variationClouds_12 = tmpvar_34;
  variationClouds_12 = (variationClouds_12 * variationClouds_12);
  highp float middleThreshold_35;
  middleThreshold_35 = tmpvar_6;
  highp float gradientWidth_36;
  gradientWidth_36 = (0.5 + (variationClouds_12 * 0.5));
  highp float value_37;
  value_37 = tmpvar_32;
  highp float tmpvar_38;
  tmpvar_38 = clamp (((value_37 - middleThreshold_35) / gradientWidth_36), 0.0, 1.0);
  filterHighlightArea_11 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = mix (_ES_CloudSmoothness.x, _ES_CloudSmoothness.y, weather_3.z);
  highp float middleThreshold_40;
  middleThreshold_40 = tmpvar_6;
  highp float gradientWidth_41;
  gradientWidth_41 = ((variationClouds_12 * tmpvar_39) + 0.05);
  highp float value_42;
  value_42 = tmpvar_32;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((value_42 - middleThreshold_40) / gradientWidth_41), 0.0, 1.0);
  filterBaseAlpha_10 = tmpvar_43;
  mediump float tmpvar_44;
  tmpvar_44 = clamp (((_ES_CloudCoverage - 0.5) / 0.2), 0.0, 1.0);
  mediump vec4 tmpvar_45;
  tmpvar_45.xyz = (((
    mix (xlv_TEXCOORD10, xlv_TEXCOORD9, vec3(((tmpvar_31 * tmpvar_31) * (1.0 - (tmpvar_30 * 
      (tmpvar_30 * (3.0 - (2.0 * tmpvar_30)))
    )))))
   + 
    ((((
      (clamp (pow (max (
        min (max (((0.5 - filterHighlightArea_11) * 2.0), 0.0), 1.0)
      , 0.0001), (tmpvar_8 * 30.0)), 0.0, 1.0) * (tmpvar_8 * tmpvar_8))
     * _ES_SunHaloColor) * 50.0) * variationClouds_12) * xlv_TEXCOORD5.z)
  ) + (
    ((variationClouds_12 * 0.5) * xlv_TEXCOORD9)
   * xlv_TEXCOORD5.x)) + (xlv_TEXCOORD8 * tmpvar_31));
  tmpvar_45.w = mix ((clamp (
    (filterBaseAlpha_10 * tmpvar_5)
  , 0.0, 1.0) * _ES_CloudOpacity), 1.0, (tmpvar_44 * (tmpvar_44 * 
    (3.0 - (2.0 * tmpvar_44))
  )));
  highp float wispyOpacity_46;
  lowp float tmpvar_47;
  tmpvar_47 = texture2D (_CloudWispsTex, xlv_TEXCOORD3.zw).w;
  wispyOpacity_46 = tmpvar_47;
  mediump float value_48;
  value_48 = wispyOpacity_46;
  mediump float low_49;
  low_49 = (1.0 - _ES_CloudWispsCoverage);
  mediump float tmpvar_50;
  tmpvar_50 = clamp (((value_48 - low_49) / (1.0 - low_49)), 0.0, 1.0);
  wispyOpacity_46 = (tmpvar_50 * _ES_CloudWispsOpacity);
  highp vec4 tmpvar_51;
  tmpvar_51.xyz = mix (xlv_TEXCOORD9, xlv_TEXCOORD10, vec3(wispyOpacity_46));
  tmpvar_51.w = wispyOpacity_46;
  cloudWisps_2 = tmpvar_51;
  finalCol_1.w = 0.0;
  finalCol_1.xyz = mix ((cloudWisps_2.xyz * cloudWisps_2.w), tmpvar_45.xyz, tmpvar_45.www);
  finalCol_1.xyz = (finalCol_1.xyz * ((xlv_TEXCOORD5.w * _ES_CloudSunBrightenIntensity) + 1.0));
  finalCol_1.w = tmpvar_45.w;
  gl_FragData[0] = finalCol_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SHOW_WEATHERMAP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec3 _ES_LightDirection;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunHaloSize;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform highp vec2 _ES_CloudDirection;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudHeight;
uniform highp float _ES_CloudTiling;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudWispsElapsedTime;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec3 xlv_TEXCOORD9;
varying mediump vec3 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 worldBinormal_2;
  mediump vec3 worldTangent_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_7.zw = vec2(0.0, 0.0);
  highp vec4 clipPos_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  clipPos_9.xyw = tmpvar_10.xyw;
  clipPos_9.z = tmpvar_10.w;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10.xyww * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = clipPos_9.zw;
  mediump vec3 viewDir_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(((unity_ObjectToWorld * tmpvar_16).xyz - _ES_SkyCenterWorldPos));
  viewDir_15 = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = dot (_ES_SkyWorldUpDir, viewDir_15);
  mediump vec4 tmpvar_19;
  tmpvar_19.xyz = viewDir_15;
  tmpvar_19.w = ((sign(tmpvar_18) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_18))) * (1.570796 + (abs(tmpvar_18) * (-0.2146018 + 
      (abs(tmpvar_18) * (0.08656672 + (abs(tmpvar_18) * -0.03102955)))
    ))))
  )) * 0.6366198);
  highp vec2 tmpvar_20;
  tmpvar_20 = mix (_glesMultiTexCoord1.xy, _glesMultiTexCoord2.xy, vec2(_ES_CloudHeight));
  highp vec2 tmpvar_21;
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_20 - 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = _ES_CloudDirection.y;
  tmpvar_23.y = -(_ES_CloudDirection.x);
  highp vec2 tmpvar_24;
  tmpvar_24.x = dot (tmpvar_23, tmpvar_22);
  tmpvar_24.y = dot (_ES_CloudDirection, tmpvar_22);
  tmpvar_21 = (tmpvar_24 + 0.5);
  highp vec2 tmpvar_25;
  tmpvar_25 = (tmpvar_21 * _ES_CloudTiling);
  tmpvar_4.xy = ((tmpvar_25 * 1.2) + (_ES_CloudElapsedTime * vec2(0.6, 0.0)));
  tmpvar_4.zw = ((tmpvar_25 * 0.9) + (_ES_CloudElapsedTime * vec2(0.78, 0.0)));
  tmpvar_5.xy = ((tmpvar_25 * 0.7) + (_ES_CloudElapsedTime * vec2(0.28, 0.0035)));
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_glesNormal * tmpvar_26));
  highp vec3 lookAtVector_28;
  lookAtVector_28 = (viewDir_15 * vec3(1.0, -1.0, 1.0));
  highp vec3 tmpvar_29;
  tmpvar_29 = normalize(lookAtVector_28);
  lookAtVector_28 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = (((
    (1.570796 - (sign(tmpvar_29.y) * (1.570796 - (
      sqrt((1.0 - abs(tmpvar_29.y)))
     * 
      (1.570796 + (abs(tmpvar_29.y) * (-0.2146018 + (
        abs(tmpvar_29.y)
       * 
        (0.08656672 + (abs(tmpvar_29.y) * -0.03102955))
      ))))
    ))))
   * 57.29) / 360.0) * 6.283185);
  highp vec3 tmpvar_31;
  tmpvar_31 = ((vec3(1.0, 0.0, 0.0) * tmpvar_29.zxy) - (vec3(0.0, 0.0, 1.0) * tmpvar_29.yzx));
  highp vec3 tmpvar_32;
  tmpvar_32 = (dot (tmpvar_27, tmpvar_31) * tmpvar_31);
  highp vec3 tmpvar_33;
  tmpvar_33 = (tmpvar_27 - tmpvar_32);
  tmpvar_5.zw = (((
    (cos(tmpvar_30) * tmpvar_33)
   + 
    (sin(tmpvar_30) * ((tmpvar_31.yzx * tmpvar_33.zxy) - (tmpvar_31.zxy * tmpvar_33.yzx)))
  ) + tmpvar_32) + tmpvar_27).xz;
  tmpvar_6.xy = ((tmpvar_21 * _CloudCurlTiling) + ((vec2(1.2, 0.8) * _CloudCurlSpeed) * _ES_CloudElapsedTime));
  highp vec2 tmpvar_34;
  tmpvar_34.x = (_glesMultiTexCoord0.x + _ES_CloudWispsElapsedTime);
  tmpvar_34.y = _glesMultiTexCoord0.y;
  tmpvar_6.zw = tmpvar_34;
  tmpvar_7.xy = tmpvar_20;
  mediump float x_35;
  x_35 = (1.0 - (_ES_CloudCoverage * 0.7));
  mediump float tmpvar_36;
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_36 = (tmpvar_37 * (tmpvar_37 * (3.0 - 
    (2.0 * tmpvar_37)
  )));
  mediump float tmpvar_38;
  tmpvar_38 = dot (viewDir_15, _ES_SunDirection);
  tmpvar_8.x = _ES_CloudCoverage;
  tmpvar_8.y = (((x_35 * x_35) * x_35) - 0.15);
  tmpvar_8.z = tmpvar_36;
  tmpvar_8.w = ((tmpvar_38 * 0.5) + 0.5);
  highp vec3 viewDir_39;
  viewDir_39 = tmpvar_19.xyz;
  mediump float moonLunarCancel_40;
  mediump float tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (dot (_ES_MoonDirection, viewDir_39), 0.0, 1.0);
  tmpvar_41 = tmpvar_42;
  highp float tmpvar_43;
  mediump float tmpvar_44;
  tmpvar_44 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_43 = (1.0 - (tmpvar_44 * 2.0));
  moonLunarCancel_40 = tmpvar_43;
  mediump float tmpvar_45;
  tmpvar_45 = clamp (((
    ((tmpvar_41 * tmpvar_41) * ((tmpvar_41 * tmpvar_41) * tmpvar_41))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_46;
  viewDir_46 = tmpvar_19.xyz;
  mediump float vertical_47;
  mediump float tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp (((
    dot (_ES_SunDirection, viewDir_46)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_48 = tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = dot (viewDir_46, _ES_SkyWorldUpDir);
  vertical_47 = tmpvar_50;
  mediump float tmpvar_51;
  tmpvar_51 = max (((tmpvar_38 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_52;
  tmpvar_52 = ((tmpvar_51 * tmpvar_51) * tmpvar_51);
  highp mat3 tmpvar_53;
  tmpvar_53[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_53[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_53[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_54;
  tmpvar_54 = normalize((tmpvar_53 * _glesTANGENT.xyz));
  worldTangent_3 = tmpvar_54;
  highp vec3 tmpvar_55;
  tmpvar_55 = (((tmpvar_27.yzx * worldTangent_3.zxy) - (tmpvar_27.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  worldBinormal_2 = tmpvar_55;
  highp vec3 tmpvar_56;
  tmpvar_56 = worldTangent_3;
  highp vec3 tmpvar_57;
  tmpvar_57 = worldBinormal_2;
  mediump mat3 tmpvar_58;
  highp mat3 tmpvar_59;
  tmpvar_59[0].x = tmpvar_56.x;
  tmpvar_59[0].y = tmpvar_57.x;
  tmpvar_59[0].z = tmpvar_27.x;
  tmpvar_59[1].x = tmpvar_56.y;
  tmpvar_59[1].y = tmpvar_57.y;
  tmpvar_59[1].z = tmpvar_27.y;
  tmpvar_59[2].x = tmpvar_56.z;
  tmpvar_59[2].y = tmpvar_57.z;
  tmpvar_59[2].z = tmpvar_27.z;
  tmpvar_58 = tmpvar_59;
  gl_Position = clipPos_9;
  xlv_TEXCOORD0 = o_12;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_TEXCOORD7 = normalize((tmpvar_58 * _ES_LightDirection));
  xlv_TEXCOORD8 = (((
    ((((tmpvar_45 * 
      (tmpvar_45 * (3.0 - (2.0 * tmpvar_45)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_40) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_48, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_47))
    ) * vertical_47), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_36);
  xlv_TEXCOORD9 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_52));
  xlv_TEXCOORD10 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_52));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_CloudCoverage;
uniform mediump float _ES_CloudOpacity;
uniform mediump vec2 _ES_CloudSmoothness;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform mediump float _ES_CloudWispsCoverage;
uniform mediump float _ES_CloudWispsOpacity;
uniform sampler2D _ES_WeatherMap;
uniform sampler2D _CloudDensityMap;
uniform sampler2D _CloudNormalMap;
uniform sampler2D _CloudWispsTex;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
uniform mediump float _CloudDarkShadingNormalYScale;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec3 xlv_TEXCOORD9;
varying mediump vec3 xlv_TEXCOORD10;
void main ()
{
  mediump vec4 finalCol_1;
  mediump vec4 cloudWisps_2;
  mediump vec3 weather_3;
  mediump float tmpvar_4;
  tmpvar_4 = clamp ((xlv_TEXCOORD6.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_5;
  tmpvar_5 = clamp ((tmpvar_4 * (tmpvar_4 * 
    (3.0 - (2.0 * tmpvar_4))
  )), 0.0, 1.0);
  mediump float tmpvar_6;
  tmpvar_6 = xlv_TEXCOORD5.y;
  mediump float tmpvar_7;
  tmpvar_7 = clamp (((xlv_TEXCOORD5.w - _ES_SunRimLightRadius) / (1.0 - _ES_SunRimLightRadius)), 0.0, 1.0);
  mediump float tmpvar_8;
  tmpvar_8 = (((tmpvar_7 * 
    (tmpvar_7 * (3.0 - (2.0 * tmpvar_7)))
  ) * _ES_SunBrightness) * 0.05);
  lowp vec3 tmpvar_9;
  tmpvar_9 = texture2D (_ES_WeatherMap, xlv_TEXCOORD4.xy).xyz;
  weather_3 = tmpvar_9;
  mediump float filterBaseAlpha_10;
  mediump float filterHighlightArea_11;
  mediump float variationClouds_12;
  mediump vec3 cloudNormal_13;
  mediump vec3 shadowTex_14;
  mediump vec3 cloudTex1_15;
  mediump vec3 cloudTex0_16;
  highp vec3 curlNoise_17;
  lowp vec3 tmpvar_18;
  tmpvar_18 = texture2D (_CloudCurlTex, xlv_TEXCOORD3.xy).xyz;
  curlNoise_17 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = ((curlNoise_17.xy - 0.5) * mix ((_CloudCurlAmplitude * 0.2), _CloudCurlAmplitude, weather_3.y));
  highp vec2 P_20;
  P_20 = (xlv_TEXCOORD1.xy + tmpvar_19);
  lowp vec3 tmpvar_21;
  tmpvar_21 = texture2D (_CloudDensityMap, P_20).xyz;
  cloudTex0_16 = tmpvar_21;
  highp vec2 P_22;
  P_22 = (xlv_TEXCOORD1.zw + tmpvar_19);
  lowp vec3 tmpvar_23;
  tmpvar_23 = texture2D (_CloudDensityMap, P_22).xyz;
  cloudTex1_15 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = (0.03 - (cloudTex0_16.y * 0.01));
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD2.xy + (xlv_TEXCOORD2.zw * tmpvar_24)) + (tmpvar_19 * 0.5));
  lowp vec3 tmpvar_26;
  tmpvar_26 = texture2D (_CloudDensityMap, P_25).xyz;
  shadowTex_14 = tmpvar_26;
  highp vec2 P_27;
  P_27 = (xlv_TEXCOORD2.xy + tmpvar_19);
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_CloudNormalMap, P_27).xyz * 2.0) - 1.0);
  cloudNormal_13 = tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29.xz = vec2(1.0, 1.0);
  tmpvar_29.y = _CloudDarkShadingNormalYScale;
  mediump float tmpvar_30;
  tmpvar_30 = clamp (((
    dot (normalize((cloudNormal_13 * tmpvar_29)), xlv_TEXCOORD7)
   * 0.5) + 0.5), 0.0, 1.0);
  mediump float tmpvar_31;
  tmpvar_31 = clamp ((clamp (
    ((shadowTex_14.y * shadowTex_14.z) * 2.0)
  , 0.0, 1.0) + (shadowTex_14.x - 0.5)), 0.0, 1.0);
  mediump float tmpvar_32;
  tmpvar_32 = (((1.0 - tmpvar_5) * 0.2) + ((
    (cloudTex1_15.z * cloudTex0_16.z)
   + 
    ((cloudTex0_16.x - 0.5) * 0.15)
  ) * weather_3.x));
  highp float value_33;
  value_33 = (cloudTex1_15.x * cloudTex1_15.y);
  highp float tmpvar_34;
  tmpvar_34 = clamp ((value_33 / 0.5), 0.0, 1.0);
  variationClouds_12 = tmpvar_34;
  variationClouds_12 = (variationClouds_12 * variationClouds_12);
  highp float middleThreshold_35;
  middleThreshold_35 = tmpvar_6;
  highp float gradientWidth_36;
  gradientWidth_36 = (0.5 + (variationClouds_12 * 0.5));
  highp float value_37;
  value_37 = tmpvar_32;
  highp float tmpvar_38;
  tmpvar_38 = clamp (((value_37 - middleThreshold_35) / gradientWidth_36), 0.0, 1.0);
  filterHighlightArea_11 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = mix (_ES_CloudSmoothness.x, _ES_CloudSmoothness.y, weather_3.z);
  highp float middleThreshold_40;
  middleThreshold_40 = tmpvar_6;
  highp float gradientWidth_41;
  gradientWidth_41 = ((variationClouds_12 * tmpvar_39) + 0.05);
  highp float value_42;
  value_42 = tmpvar_32;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((value_42 - middleThreshold_40) / gradientWidth_41), 0.0, 1.0);
  filterBaseAlpha_10 = tmpvar_43;
  mediump float tmpvar_44;
  tmpvar_44 = clamp (((_ES_CloudCoverage - 0.5) / 0.2), 0.0, 1.0);
  mediump vec4 tmpvar_45;
  tmpvar_45.xyz = (((
    mix (xlv_TEXCOORD10, xlv_TEXCOORD9, vec3(((tmpvar_31 * tmpvar_31) * (1.0 - (tmpvar_30 * 
      (tmpvar_30 * (3.0 - (2.0 * tmpvar_30)))
    )))))
   + 
    ((((
      (clamp (pow (max (
        min (max (((0.5 - filterHighlightArea_11) * 2.0), 0.0), 1.0)
      , 0.0001), (tmpvar_8 * 30.0)), 0.0, 1.0) * (tmpvar_8 * tmpvar_8))
     * _ES_SunHaloColor) * 50.0) * variationClouds_12) * xlv_TEXCOORD5.z)
  ) + (
    ((variationClouds_12 * 0.5) * xlv_TEXCOORD9)
   * xlv_TEXCOORD5.x)) + (xlv_TEXCOORD8 * tmpvar_31));
  tmpvar_45.w = mix ((clamp (
    (filterBaseAlpha_10 * tmpvar_5)
  , 0.0, 1.0) * _ES_CloudOpacity), 1.0, (tmpvar_44 * (tmpvar_44 * 
    (3.0 - (2.0 * tmpvar_44))
  )));
  highp float wispyOpacity_46;
  lowp float tmpvar_47;
  tmpvar_47 = texture2D (_CloudWispsTex, xlv_TEXCOORD3.zw).w;
  wispyOpacity_46 = tmpvar_47;
  mediump float value_48;
  value_48 = wispyOpacity_46;
  mediump float low_49;
  low_49 = (1.0 - _ES_CloudWispsCoverage);
  mediump float tmpvar_50;
  tmpvar_50 = clamp (((value_48 - low_49) / (1.0 - low_49)), 0.0, 1.0);
  wispyOpacity_46 = (tmpvar_50 * _ES_CloudWispsOpacity);
  highp vec4 tmpvar_51;
  tmpvar_51.xyz = mix (xlv_TEXCOORD9, xlv_TEXCOORD10, vec3(wispyOpacity_46));
  tmpvar_51.w = wispyOpacity_46;
  cloudWisps_2 = tmpvar_51;
  finalCol_1.w = 0.0;
  finalCol_1.xyz = mix ((cloudWisps_2.xyz * cloudWisps_2.w), tmpvar_45.xyz, tmpvar_45.www);
  finalCol_1.xyz = (finalCol_1.xyz * ((xlv_TEXCOORD5.w * _ES_CloudSunBrightenIntensity) + 1.0));
  finalCol_1.w = tmpvar_45.w;
  gl_FragData[0] = finalCol_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SHOW_WEATHERMAP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec3 _ES_LightDirection;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunHaloSize;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform highp vec2 _ES_CloudDirection;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudHeight;
uniform highp float _ES_CloudTiling;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudWispsElapsedTime;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec3 xlv_TEXCOORD9;
varying mediump vec3 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 worldBinormal_2;
  mediump vec3 worldTangent_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_7.zw = vec2(0.0, 0.0);
  highp vec4 clipPos_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  clipPos_9.xyw = tmpvar_10.xyw;
  clipPos_9.z = tmpvar_10.w;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10.xyww * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = clipPos_9.zw;
  mediump vec3 viewDir_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(((unity_ObjectToWorld * tmpvar_16).xyz - _ES_SkyCenterWorldPos));
  viewDir_15 = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = dot (_ES_SkyWorldUpDir, viewDir_15);
  mediump vec4 tmpvar_19;
  tmpvar_19.xyz = viewDir_15;
  tmpvar_19.w = ((sign(tmpvar_18) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_18))) * (1.570796 + (abs(tmpvar_18) * (-0.2146018 + 
      (abs(tmpvar_18) * (0.08656672 + (abs(tmpvar_18) * -0.03102955)))
    ))))
  )) * 0.6366198);
  highp vec2 tmpvar_20;
  tmpvar_20 = mix (_glesMultiTexCoord1.xy, _glesMultiTexCoord2.xy, vec2(_ES_CloudHeight));
  highp vec2 tmpvar_21;
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_20 - 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = _ES_CloudDirection.y;
  tmpvar_23.y = -(_ES_CloudDirection.x);
  highp vec2 tmpvar_24;
  tmpvar_24.x = dot (tmpvar_23, tmpvar_22);
  tmpvar_24.y = dot (_ES_CloudDirection, tmpvar_22);
  tmpvar_21 = (tmpvar_24 + 0.5);
  highp vec2 tmpvar_25;
  tmpvar_25 = (tmpvar_21 * _ES_CloudTiling);
  tmpvar_4.xy = ((tmpvar_25 * 1.2) + (_ES_CloudElapsedTime * vec2(0.6, 0.0)));
  tmpvar_4.zw = ((tmpvar_25 * 0.9) + (_ES_CloudElapsedTime * vec2(0.78, 0.0)));
  tmpvar_5.xy = ((tmpvar_25 * 0.7) + (_ES_CloudElapsedTime * vec2(0.28, 0.0035)));
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_glesNormal * tmpvar_26));
  highp vec3 lookAtVector_28;
  lookAtVector_28 = (viewDir_15 * vec3(1.0, -1.0, 1.0));
  highp vec3 tmpvar_29;
  tmpvar_29 = normalize(lookAtVector_28);
  lookAtVector_28 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = (((
    (1.570796 - (sign(tmpvar_29.y) * (1.570796 - (
      sqrt((1.0 - abs(tmpvar_29.y)))
     * 
      (1.570796 + (abs(tmpvar_29.y) * (-0.2146018 + (
        abs(tmpvar_29.y)
       * 
        (0.08656672 + (abs(tmpvar_29.y) * -0.03102955))
      ))))
    ))))
   * 57.29) / 360.0) * 6.283185);
  highp vec3 tmpvar_31;
  tmpvar_31 = ((vec3(1.0, 0.0, 0.0) * tmpvar_29.zxy) - (vec3(0.0, 0.0, 1.0) * tmpvar_29.yzx));
  highp vec3 tmpvar_32;
  tmpvar_32 = (dot (tmpvar_27, tmpvar_31) * tmpvar_31);
  highp vec3 tmpvar_33;
  tmpvar_33 = (tmpvar_27 - tmpvar_32);
  tmpvar_5.zw = (((
    (cos(tmpvar_30) * tmpvar_33)
   + 
    (sin(tmpvar_30) * ((tmpvar_31.yzx * tmpvar_33.zxy) - (tmpvar_31.zxy * tmpvar_33.yzx)))
  ) + tmpvar_32) + tmpvar_27).xz;
  tmpvar_6.xy = ((tmpvar_21 * _CloudCurlTiling) + ((vec2(1.2, 0.8) * _CloudCurlSpeed) * _ES_CloudElapsedTime));
  highp vec2 tmpvar_34;
  tmpvar_34.x = (_glesMultiTexCoord0.x + _ES_CloudWispsElapsedTime);
  tmpvar_34.y = _glesMultiTexCoord0.y;
  tmpvar_6.zw = tmpvar_34;
  tmpvar_7.xy = tmpvar_20;
  mediump float x_35;
  x_35 = (1.0 - (_ES_CloudCoverage * 0.7));
  mediump float tmpvar_36;
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_36 = (tmpvar_37 * (tmpvar_37 * (3.0 - 
    (2.0 * tmpvar_37)
  )));
  mediump float tmpvar_38;
  tmpvar_38 = dot (viewDir_15, _ES_SunDirection);
  tmpvar_8.x = _ES_CloudCoverage;
  tmpvar_8.y = (((x_35 * x_35) * x_35) - 0.15);
  tmpvar_8.z = tmpvar_36;
  tmpvar_8.w = ((tmpvar_38 * 0.5) + 0.5);
  highp vec3 viewDir_39;
  viewDir_39 = tmpvar_19.xyz;
  mediump float moonLunarCancel_40;
  mediump float tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (dot (_ES_MoonDirection, viewDir_39), 0.0, 1.0);
  tmpvar_41 = tmpvar_42;
  highp float tmpvar_43;
  mediump float tmpvar_44;
  tmpvar_44 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_43 = (1.0 - (tmpvar_44 * 2.0));
  moonLunarCancel_40 = tmpvar_43;
  mediump float tmpvar_45;
  tmpvar_45 = clamp (((
    ((tmpvar_41 * tmpvar_41) * ((tmpvar_41 * tmpvar_41) * tmpvar_41))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_46;
  viewDir_46 = tmpvar_19.xyz;
  mediump float vertical_47;
  mediump float tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp (((
    dot (_ES_SunDirection, viewDir_46)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_48 = tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = dot (viewDir_46, _ES_SkyWorldUpDir);
  vertical_47 = tmpvar_50;
  mediump float tmpvar_51;
  tmpvar_51 = max (((tmpvar_38 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_52;
  tmpvar_52 = ((tmpvar_51 * tmpvar_51) * tmpvar_51);
  highp mat3 tmpvar_53;
  tmpvar_53[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_53[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_53[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_54;
  tmpvar_54 = normalize((tmpvar_53 * _glesTANGENT.xyz));
  worldTangent_3 = tmpvar_54;
  highp vec3 tmpvar_55;
  tmpvar_55 = (((tmpvar_27.yzx * worldTangent_3.zxy) - (tmpvar_27.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  worldBinormal_2 = tmpvar_55;
  highp vec3 tmpvar_56;
  tmpvar_56 = worldTangent_3;
  highp vec3 tmpvar_57;
  tmpvar_57 = worldBinormal_2;
  mediump mat3 tmpvar_58;
  highp mat3 tmpvar_59;
  tmpvar_59[0].x = tmpvar_56.x;
  tmpvar_59[0].y = tmpvar_57.x;
  tmpvar_59[0].z = tmpvar_27.x;
  tmpvar_59[1].x = tmpvar_56.y;
  tmpvar_59[1].y = tmpvar_57.y;
  tmpvar_59[1].z = tmpvar_27.y;
  tmpvar_59[2].x = tmpvar_56.z;
  tmpvar_59[2].y = tmpvar_57.z;
  tmpvar_59[2].z = tmpvar_27.z;
  tmpvar_58 = tmpvar_59;
  gl_Position = clipPos_9;
  xlv_TEXCOORD0 = o_12;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_TEXCOORD7 = normalize((tmpvar_58 * _ES_LightDirection));
  xlv_TEXCOORD8 = (((
    ((((tmpvar_45 * 
      (tmpvar_45 * (3.0 - (2.0 * tmpvar_45)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_40) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_48, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_47))
    ) * vertical_47), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_36);
  xlv_TEXCOORD9 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_52));
  xlv_TEXCOORD10 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_52));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_CloudCoverage;
uniform mediump float _ES_CloudOpacity;
uniform mediump vec2 _ES_CloudSmoothness;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform mediump float _ES_CloudWispsCoverage;
uniform mediump float _ES_CloudWispsOpacity;
uniform sampler2D _ES_WeatherMap;
uniform sampler2D _CloudDensityMap;
uniform sampler2D _CloudNormalMap;
uniform sampler2D _CloudWispsTex;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
uniform mediump float _CloudDarkShadingNormalYScale;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec3 xlv_TEXCOORD9;
varying mediump vec3 xlv_TEXCOORD10;
void main ()
{
  mediump vec4 finalCol_1;
  mediump vec4 cloudWisps_2;
  mediump vec3 weather_3;
  mediump float tmpvar_4;
  tmpvar_4 = clamp ((xlv_TEXCOORD6.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_5;
  tmpvar_5 = clamp ((tmpvar_4 * (tmpvar_4 * 
    (3.0 - (2.0 * tmpvar_4))
  )), 0.0, 1.0);
  mediump float tmpvar_6;
  tmpvar_6 = xlv_TEXCOORD5.y;
  mediump float tmpvar_7;
  tmpvar_7 = clamp (((xlv_TEXCOORD5.w - _ES_SunRimLightRadius) / (1.0 - _ES_SunRimLightRadius)), 0.0, 1.0);
  mediump float tmpvar_8;
  tmpvar_8 = (((tmpvar_7 * 
    (tmpvar_7 * (3.0 - (2.0 * tmpvar_7)))
  ) * _ES_SunBrightness) * 0.05);
  lowp vec3 tmpvar_9;
  tmpvar_9 = texture2D (_ES_WeatherMap, xlv_TEXCOORD4.xy).xyz;
  weather_3 = tmpvar_9;
  mediump float filterBaseAlpha_10;
  mediump float filterHighlightArea_11;
  mediump float variationClouds_12;
  mediump vec3 cloudNormal_13;
  mediump vec3 shadowTex_14;
  mediump vec3 cloudTex1_15;
  mediump vec3 cloudTex0_16;
  highp vec3 curlNoise_17;
  lowp vec3 tmpvar_18;
  tmpvar_18 = texture2D (_CloudCurlTex, xlv_TEXCOORD3.xy).xyz;
  curlNoise_17 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = ((curlNoise_17.xy - 0.5) * mix ((_CloudCurlAmplitude * 0.2), _CloudCurlAmplitude, weather_3.y));
  highp vec2 P_20;
  P_20 = (xlv_TEXCOORD1.xy + tmpvar_19);
  lowp vec3 tmpvar_21;
  tmpvar_21 = texture2D (_CloudDensityMap, P_20).xyz;
  cloudTex0_16 = tmpvar_21;
  highp vec2 P_22;
  P_22 = (xlv_TEXCOORD1.zw + tmpvar_19);
  lowp vec3 tmpvar_23;
  tmpvar_23 = texture2D (_CloudDensityMap, P_22).xyz;
  cloudTex1_15 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = (0.03 - (cloudTex0_16.y * 0.01));
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD2.xy + (xlv_TEXCOORD2.zw * tmpvar_24)) + (tmpvar_19 * 0.5));
  lowp vec3 tmpvar_26;
  tmpvar_26 = texture2D (_CloudDensityMap, P_25).xyz;
  shadowTex_14 = tmpvar_26;
  highp vec2 P_27;
  P_27 = (xlv_TEXCOORD2.xy + tmpvar_19);
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_CloudNormalMap, P_27).xyz * 2.0) - 1.0);
  cloudNormal_13 = tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29.xz = vec2(1.0, 1.0);
  tmpvar_29.y = _CloudDarkShadingNormalYScale;
  mediump float tmpvar_30;
  tmpvar_30 = clamp (((
    dot (normalize((cloudNormal_13 * tmpvar_29)), xlv_TEXCOORD7)
   * 0.5) + 0.5), 0.0, 1.0);
  mediump float tmpvar_31;
  tmpvar_31 = clamp ((clamp (
    ((shadowTex_14.y * shadowTex_14.z) * 2.0)
  , 0.0, 1.0) + (shadowTex_14.x - 0.5)), 0.0, 1.0);
  mediump float tmpvar_32;
  tmpvar_32 = (((1.0 - tmpvar_5) * 0.2) + ((
    (cloudTex1_15.z * cloudTex0_16.z)
   + 
    ((cloudTex0_16.x - 0.5) * 0.15)
  ) * weather_3.x));
  highp float value_33;
  value_33 = (cloudTex1_15.x * cloudTex1_15.y);
  highp float tmpvar_34;
  tmpvar_34 = clamp ((value_33 / 0.5), 0.0, 1.0);
  variationClouds_12 = tmpvar_34;
  variationClouds_12 = (variationClouds_12 * variationClouds_12);
  highp float middleThreshold_35;
  middleThreshold_35 = tmpvar_6;
  highp float gradientWidth_36;
  gradientWidth_36 = (0.5 + (variationClouds_12 * 0.5));
  highp float value_37;
  value_37 = tmpvar_32;
  highp float tmpvar_38;
  tmpvar_38 = clamp (((value_37 - middleThreshold_35) / gradientWidth_36), 0.0, 1.0);
  filterHighlightArea_11 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = mix (_ES_CloudSmoothness.x, _ES_CloudSmoothness.y, weather_3.z);
  highp float middleThreshold_40;
  middleThreshold_40 = tmpvar_6;
  highp float gradientWidth_41;
  gradientWidth_41 = ((variationClouds_12 * tmpvar_39) + 0.05);
  highp float value_42;
  value_42 = tmpvar_32;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((value_42 - middleThreshold_40) / gradientWidth_41), 0.0, 1.0);
  filterBaseAlpha_10 = tmpvar_43;
  mediump float tmpvar_44;
  tmpvar_44 = clamp (((_ES_CloudCoverage - 0.5) / 0.2), 0.0, 1.0);
  mediump vec4 tmpvar_45;
  tmpvar_45.xyz = (((
    mix (xlv_TEXCOORD10, xlv_TEXCOORD9, vec3(((tmpvar_31 * tmpvar_31) * (1.0 - (tmpvar_30 * 
      (tmpvar_30 * (3.0 - (2.0 * tmpvar_30)))
    )))))
   + 
    ((((
      (clamp (pow (max (
        min (max (((0.5 - filterHighlightArea_11) * 2.0), 0.0), 1.0)
      , 0.0001), (tmpvar_8 * 30.0)), 0.0, 1.0) * (tmpvar_8 * tmpvar_8))
     * _ES_SunHaloColor) * 50.0) * variationClouds_12) * xlv_TEXCOORD5.z)
  ) + (
    ((variationClouds_12 * 0.5) * xlv_TEXCOORD9)
   * xlv_TEXCOORD5.x)) + (xlv_TEXCOORD8 * tmpvar_31));
  tmpvar_45.w = mix ((clamp (
    (filterBaseAlpha_10 * tmpvar_5)
  , 0.0, 1.0) * _ES_CloudOpacity), 1.0, (tmpvar_44 * (tmpvar_44 * 
    (3.0 - (2.0 * tmpvar_44))
  )));
  highp float wispyOpacity_46;
  lowp float tmpvar_47;
  tmpvar_47 = texture2D (_CloudWispsTex, xlv_TEXCOORD3.zw).w;
  wispyOpacity_46 = tmpvar_47;
  mediump float value_48;
  value_48 = wispyOpacity_46;
  mediump float low_49;
  low_49 = (1.0 - _ES_CloudWispsCoverage);
  mediump float tmpvar_50;
  tmpvar_50 = clamp (((value_48 - low_49) / (1.0 - low_49)), 0.0, 1.0);
  wispyOpacity_46 = (tmpvar_50 * _ES_CloudWispsOpacity);
  highp vec4 tmpvar_51;
  tmpvar_51.xyz = mix (xlv_TEXCOORD9, xlv_TEXCOORD10, vec3(wispyOpacity_46));
  tmpvar_51.w = wispyOpacity_46;
  cloudWisps_2 = tmpvar_51;
  finalCol_1.w = 0.0;
  finalCol_1.xyz = mix ((cloudWisps_2.xyz * cloudWisps_2.w), tmpvar_45.xyz, tmpvar_45.www);
  finalCol_1.xyz = (finalCol_1.xyz * ((xlv_TEXCOORD5.w * _ES_CloudSunBrightenIntensity) + 1.0));
  finalCol_1.w = tmpvar_45.w;
  gl_FragData[0] = finalCol_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SHOW_WEATHERMAP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec3 _ES_LightDirection;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunHaloSize;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform highp vec2 _ES_CloudDirection;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudHeight;
uniform highp float _ES_CloudTiling;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudWispsElapsedTime;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec3 xlv_TEXCOORD9;
varying mediump vec3 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 worldBinormal_2;
  mediump vec3 worldTangent_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_7.zw = vec2(0.0, 0.0);
  highp vec4 clipPos_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  clipPos_9.xyw = tmpvar_10.xyw;
  clipPos_9.z = tmpvar_10.w;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10.xyww * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = clipPos_9.zw;
  mediump vec3 viewDir_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(((unity_ObjectToWorld * tmpvar_16).xyz - _ES_SkyCenterWorldPos));
  viewDir_15 = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = dot (_ES_SkyWorldUpDir, viewDir_15);
  mediump vec4 tmpvar_19;
  tmpvar_19.xyz = viewDir_15;
  tmpvar_19.w = ((sign(tmpvar_18) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_18))) * (1.570796 + (abs(tmpvar_18) * (-0.2146018 + 
      (abs(tmpvar_18) * (0.08656672 + (abs(tmpvar_18) * -0.03102955)))
    ))))
  )) * 0.6366198);
  highp vec2 tmpvar_20;
  tmpvar_20 = mix (_glesMultiTexCoord1.xy, _glesMultiTexCoord2.xy, vec2(_ES_CloudHeight));
  highp vec2 tmpvar_21;
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_20 - 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = _ES_CloudDirection.y;
  tmpvar_23.y = -(_ES_CloudDirection.x);
  highp vec2 tmpvar_24;
  tmpvar_24.x = dot (tmpvar_23, tmpvar_22);
  tmpvar_24.y = dot (_ES_CloudDirection, tmpvar_22);
  tmpvar_21 = (tmpvar_24 + 0.5);
  highp vec2 tmpvar_25;
  tmpvar_25 = (tmpvar_21 * _ES_CloudTiling);
  tmpvar_4.xy = ((tmpvar_25 * 1.2) + (_ES_CloudElapsedTime * vec2(0.6, 0.0)));
  tmpvar_4.zw = ((tmpvar_25 * 0.9) + (_ES_CloudElapsedTime * vec2(0.78, 0.0)));
  tmpvar_5.xy = ((tmpvar_25 * 0.7) + (_ES_CloudElapsedTime * vec2(0.28, 0.0035)));
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_glesNormal * tmpvar_26));
  highp vec3 lookAtVector_28;
  lookAtVector_28 = (viewDir_15 * vec3(1.0, -1.0, 1.0));
  highp vec3 tmpvar_29;
  tmpvar_29 = normalize(lookAtVector_28);
  lookAtVector_28 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = (((
    (1.570796 - (sign(tmpvar_29.y) * (1.570796 - (
      sqrt((1.0 - abs(tmpvar_29.y)))
     * 
      (1.570796 + (abs(tmpvar_29.y) * (-0.2146018 + (
        abs(tmpvar_29.y)
       * 
        (0.08656672 + (abs(tmpvar_29.y) * -0.03102955))
      ))))
    ))))
   * 57.29) / 360.0) * 6.283185);
  highp vec3 tmpvar_31;
  tmpvar_31 = ((vec3(1.0, 0.0, 0.0) * tmpvar_29.zxy) - (vec3(0.0, 0.0, 1.0) * tmpvar_29.yzx));
  highp vec3 tmpvar_32;
  tmpvar_32 = (dot (tmpvar_27, tmpvar_31) * tmpvar_31);
  highp vec3 tmpvar_33;
  tmpvar_33 = (tmpvar_27 - tmpvar_32);
  tmpvar_5.zw = (((
    (cos(tmpvar_30) * tmpvar_33)
   + 
    (sin(tmpvar_30) * ((tmpvar_31.yzx * tmpvar_33.zxy) - (tmpvar_31.zxy * tmpvar_33.yzx)))
  ) + tmpvar_32) + tmpvar_27).xz;
  tmpvar_6.xy = ((tmpvar_21 * _CloudCurlTiling) + ((vec2(1.2, 0.8) * _CloudCurlSpeed) * _ES_CloudElapsedTime));
  highp vec2 tmpvar_34;
  tmpvar_34.x = (_glesMultiTexCoord0.x + _ES_CloudWispsElapsedTime);
  tmpvar_34.y = _glesMultiTexCoord0.y;
  tmpvar_6.zw = tmpvar_34;
  tmpvar_7.xy = tmpvar_20;
  mediump float x_35;
  x_35 = (1.0 - (_ES_CloudCoverage * 0.7));
  mediump float tmpvar_36;
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_36 = (tmpvar_37 * (tmpvar_37 * (3.0 - 
    (2.0 * tmpvar_37)
  )));
  mediump float tmpvar_38;
  tmpvar_38 = dot (viewDir_15, _ES_SunDirection);
  tmpvar_8.x = _ES_CloudCoverage;
  tmpvar_8.y = (((x_35 * x_35) * x_35) - 0.15);
  tmpvar_8.z = tmpvar_36;
  tmpvar_8.w = ((tmpvar_38 * 0.5) + 0.5);
  highp vec3 viewDir_39;
  viewDir_39 = tmpvar_19.xyz;
  mediump float moonLunarCancel_40;
  mediump float tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (dot (_ES_MoonDirection, viewDir_39), 0.0, 1.0);
  tmpvar_41 = tmpvar_42;
  highp float tmpvar_43;
  mediump float tmpvar_44;
  tmpvar_44 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_43 = (1.0 - (tmpvar_44 * 2.0));
  moonLunarCancel_40 = tmpvar_43;
  mediump float tmpvar_45;
  tmpvar_45 = clamp (((
    ((tmpvar_41 * tmpvar_41) * ((tmpvar_41 * tmpvar_41) * tmpvar_41))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_46;
  viewDir_46 = tmpvar_19.xyz;
  mediump float vertical_47;
  mediump float tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp (((
    dot (_ES_SunDirection, viewDir_46)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_48 = tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = dot (viewDir_46, _ES_SkyWorldUpDir);
  vertical_47 = tmpvar_50;
  mediump float tmpvar_51;
  tmpvar_51 = max (((tmpvar_38 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_52;
  tmpvar_52 = ((tmpvar_51 * tmpvar_51) * tmpvar_51);
  highp mat3 tmpvar_53;
  tmpvar_53[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_53[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_53[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_54;
  tmpvar_54 = normalize((tmpvar_53 * _glesTANGENT.xyz));
  worldTangent_3 = tmpvar_54;
  highp vec3 tmpvar_55;
  tmpvar_55 = (((tmpvar_27.yzx * worldTangent_3.zxy) - (tmpvar_27.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  worldBinormal_2 = tmpvar_55;
  highp vec3 tmpvar_56;
  tmpvar_56 = worldTangent_3;
  highp vec3 tmpvar_57;
  tmpvar_57 = worldBinormal_2;
  mediump mat3 tmpvar_58;
  highp mat3 tmpvar_59;
  tmpvar_59[0].x = tmpvar_56.x;
  tmpvar_59[0].y = tmpvar_57.x;
  tmpvar_59[0].z = tmpvar_27.x;
  tmpvar_59[1].x = tmpvar_56.y;
  tmpvar_59[1].y = tmpvar_57.y;
  tmpvar_59[1].z = tmpvar_27.y;
  tmpvar_59[2].x = tmpvar_56.z;
  tmpvar_59[2].y = tmpvar_57.z;
  tmpvar_59[2].z = tmpvar_27.z;
  tmpvar_58 = tmpvar_59;
  gl_Position = clipPos_9;
  xlv_TEXCOORD0 = o_12;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_TEXCOORD7 = normalize((tmpvar_58 * _ES_LightDirection));
  xlv_TEXCOORD8 = (((
    ((((tmpvar_45 * 
      (tmpvar_45 * (3.0 - (2.0 * tmpvar_45)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_40) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_48, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_47))
    ) * vertical_47), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_36);
  xlv_TEXCOORD9 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_52));
  xlv_TEXCOORD10 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_52));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_CloudCoverage;
uniform mediump float _ES_CloudOpacity;
uniform mediump vec2 _ES_CloudSmoothness;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform mediump float _ES_CloudWispsCoverage;
uniform mediump float _ES_CloudWispsOpacity;
uniform sampler2D _ES_WeatherMap;
uniform sampler2D _CloudDensityMap;
uniform sampler2D _CloudNormalMap;
uniform sampler2D _CloudWispsTex;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
uniform mediump float _CloudDarkShadingNormalYScale;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec3 xlv_TEXCOORD9;
varying mediump vec3 xlv_TEXCOORD10;
void main ()
{
  mediump vec4 finalCol_1;
  mediump vec4 cloudWisps_2;
  mediump vec3 weather_3;
  mediump float tmpvar_4;
  tmpvar_4 = clamp ((xlv_TEXCOORD6.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_5;
  tmpvar_5 = clamp ((tmpvar_4 * (tmpvar_4 * 
    (3.0 - (2.0 * tmpvar_4))
  )), 0.0, 1.0);
  mediump float tmpvar_6;
  tmpvar_6 = xlv_TEXCOORD5.y;
  mediump float tmpvar_7;
  tmpvar_7 = clamp (((xlv_TEXCOORD5.w - _ES_SunRimLightRadius) / (1.0 - _ES_SunRimLightRadius)), 0.0, 1.0);
  mediump float tmpvar_8;
  tmpvar_8 = (((tmpvar_7 * 
    (tmpvar_7 * (3.0 - (2.0 * tmpvar_7)))
  ) * _ES_SunBrightness) * 0.05);
  lowp vec3 tmpvar_9;
  tmpvar_9 = texture2D (_ES_WeatherMap, xlv_TEXCOORD4.xy).xyz;
  weather_3 = tmpvar_9;
  mediump float filterBaseAlpha_10;
  mediump float filterHighlightArea_11;
  mediump float variationClouds_12;
  mediump vec3 cloudNormal_13;
  mediump vec3 shadowTex_14;
  mediump vec3 cloudTex1_15;
  mediump vec3 cloudTex0_16;
  highp vec3 curlNoise_17;
  lowp vec3 tmpvar_18;
  tmpvar_18 = texture2D (_CloudCurlTex, xlv_TEXCOORD3.xy).xyz;
  curlNoise_17 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = ((curlNoise_17.xy - 0.5) * mix ((_CloudCurlAmplitude * 0.2), _CloudCurlAmplitude, weather_3.y));
  highp vec2 P_20;
  P_20 = (xlv_TEXCOORD1.xy + tmpvar_19);
  lowp vec3 tmpvar_21;
  tmpvar_21 = texture2D (_CloudDensityMap, P_20).xyz;
  cloudTex0_16 = tmpvar_21;
  highp vec2 P_22;
  P_22 = (xlv_TEXCOORD1.zw + tmpvar_19);
  lowp vec3 tmpvar_23;
  tmpvar_23 = texture2D (_CloudDensityMap, P_22).xyz;
  cloudTex1_15 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = (0.03 - (cloudTex0_16.y * 0.01));
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD2.xy + (xlv_TEXCOORD2.zw * tmpvar_24)) + (tmpvar_19 * 0.5));
  lowp vec3 tmpvar_26;
  tmpvar_26 = texture2D (_CloudDensityMap, P_25).xyz;
  shadowTex_14 = tmpvar_26;
  highp vec2 P_27;
  P_27 = (xlv_TEXCOORD2.xy + tmpvar_19);
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_CloudNormalMap, P_27).xyz * 2.0) - 1.0);
  cloudNormal_13 = tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29.xz = vec2(1.0, 1.0);
  tmpvar_29.y = _CloudDarkShadingNormalYScale;
  mediump float tmpvar_30;
  tmpvar_30 = clamp (((
    dot (normalize((cloudNormal_13 * tmpvar_29)), xlv_TEXCOORD7)
   * 0.5) + 0.5), 0.0, 1.0);
  mediump float tmpvar_31;
  tmpvar_31 = clamp ((clamp (
    ((shadowTex_14.y * shadowTex_14.z) * 2.0)
  , 0.0, 1.0) + (shadowTex_14.x - 0.5)), 0.0, 1.0);
  mediump float tmpvar_32;
  tmpvar_32 = (((1.0 - tmpvar_5) * 0.2) + ((
    (cloudTex1_15.z * cloudTex0_16.z)
   + 
    ((cloudTex0_16.x - 0.5) * 0.15)
  ) * weather_3.x));
  highp float value_33;
  value_33 = (cloudTex1_15.x * cloudTex1_15.y);
  highp float tmpvar_34;
  tmpvar_34 = clamp ((value_33 / 0.5), 0.0, 1.0);
  variationClouds_12 = tmpvar_34;
  variationClouds_12 = (variationClouds_12 * variationClouds_12);
  highp float middleThreshold_35;
  middleThreshold_35 = tmpvar_6;
  highp float gradientWidth_36;
  gradientWidth_36 = (0.5 + (variationClouds_12 * 0.5));
  highp float value_37;
  value_37 = tmpvar_32;
  highp float tmpvar_38;
  tmpvar_38 = clamp (((value_37 - middleThreshold_35) / gradientWidth_36), 0.0, 1.0);
  filterHighlightArea_11 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = mix (_ES_CloudSmoothness.x, _ES_CloudSmoothness.y, weather_3.z);
  highp float middleThreshold_40;
  middleThreshold_40 = tmpvar_6;
  highp float gradientWidth_41;
  gradientWidth_41 = ((variationClouds_12 * tmpvar_39) + 0.05);
  highp float value_42;
  value_42 = tmpvar_32;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((value_42 - middleThreshold_40) / gradientWidth_41), 0.0, 1.0);
  filterBaseAlpha_10 = tmpvar_43;
  mediump float tmpvar_44;
  tmpvar_44 = clamp (((_ES_CloudCoverage - 0.5) / 0.2), 0.0, 1.0);
  mediump vec4 tmpvar_45;
  tmpvar_45.xyz = (((
    mix (xlv_TEXCOORD10, xlv_TEXCOORD9, vec3(((tmpvar_31 * tmpvar_31) * (1.0 - (tmpvar_30 * 
      (tmpvar_30 * (3.0 - (2.0 * tmpvar_30)))
    )))))
   + 
    ((((
      (clamp (pow (max (
        min (max (((0.5 - filterHighlightArea_11) * 2.0), 0.0), 1.0)
      , 0.0001), (tmpvar_8 * 30.0)), 0.0, 1.0) * (tmpvar_8 * tmpvar_8))
     * _ES_SunHaloColor) * 50.0) * variationClouds_12) * xlv_TEXCOORD5.z)
  ) + (
    ((variationClouds_12 * 0.5) * xlv_TEXCOORD9)
   * xlv_TEXCOORD5.x)) + (xlv_TEXCOORD8 * tmpvar_31));
  tmpvar_45.w = mix ((clamp (
    (filterBaseAlpha_10 * tmpvar_5)
  , 0.0, 1.0) * _ES_CloudOpacity), 1.0, (tmpvar_44 * (tmpvar_44 * 
    (3.0 - (2.0 * tmpvar_44))
  )));
  highp float wispyOpacity_46;
  lowp float tmpvar_47;
  tmpvar_47 = texture2D (_CloudWispsTex, xlv_TEXCOORD3.zw).w;
  wispyOpacity_46 = tmpvar_47;
  mediump float value_48;
  value_48 = wispyOpacity_46;
  mediump float low_49;
  low_49 = (1.0 - _ES_CloudWispsCoverage);
  mediump float tmpvar_50;
  tmpvar_50 = clamp (((value_48 - low_49) / (1.0 - low_49)), 0.0, 1.0);
  wispyOpacity_46 = (tmpvar_50 * _ES_CloudWispsOpacity);
  highp vec4 tmpvar_51;
  tmpvar_51.xyz = mix (xlv_TEXCOORD9, xlv_TEXCOORD10, vec3(wispyOpacity_46));
  tmpvar_51.w = wispyOpacity_46;
  cloudWisps_2 = tmpvar_51;
  finalCol_1.w = 0.0;
  finalCol_1.xyz = mix ((cloudWisps_2.xyz * cloudWisps_2.w), tmpvar_45.xyz, tmpvar_45.www);
  finalCol_1.xyz = (finalCol_1.xyz * ((xlv_TEXCOORD5.w * _ES_CloudSunBrightenIntensity) + 1.0));
  finalCol_1.w = tmpvar_45.w;
  gl_FragData[0] = finalCol_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "SHOW_WEATHERMAP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec3 _ES_LightDirection;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunHaloSize;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform highp vec2 _ES_CloudDirection;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudHeight;
uniform highp float _ES_CloudTiling;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudWispsElapsedTime;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec3 xlv_TEXCOORD9;
varying mediump vec3 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 worldBinormal_2;
  mediump vec3 worldTangent_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_7.zw = vec2(0.0, 0.0);
  highp vec4 clipPos_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  clipPos_9.xyw = tmpvar_10.xyw;
  clipPos_9.z = tmpvar_10.w;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10.xyww * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = clipPos_9.zw;
  mediump vec3 viewDir_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(((unity_ObjectToWorld * tmpvar_16).xyz - _ES_SkyCenterWorldPos));
  viewDir_15 = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = dot (_ES_SkyWorldUpDir, viewDir_15);
  mediump vec4 tmpvar_19;
  tmpvar_19.xyz = viewDir_15;
  tmpvar_19.w = ((sign(tmpvar_18) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_18))) * (1.570796 + (abs(tmpvar_18) * (-0.2146018 + 
      (abs(tmpvar_18) * (0.08656672 + (abs(tmpvar_18) * -0.03102955)))
    ))))
  )) * 0.6366198);
  highp vec2 tmpvar_20;
  tmpvar_20 = mix (_glesMultiTexCoord1.xy, _glesMultiTexCoord2.xy, vec2(_ES_CloudHeight));
  highp vec2 tmpvar_21;
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_20 - 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = _ES_CloudDirection.y;
  tmpvar_23.y = -(_ES_CloudDirection.x);
  highp vec2 tmpvar_24;
  tmpvar_24.x = dot (tmpvar_23, tmpvar_22);
  tmpvar_24.y = dot (_ES_CloudDirection, tmpvar_22);
  tmpvar_21 = (tmpvar_24 + 0.5);
  highp vec2 tmpvar_25;
  tmpvar_25 = (tmpvar_21 * _ES_CloudTiling);
  tmpvar_4.xy = ((tmpvar_25 * 1.2) + (_ES_CloudElapsedTime * vec2(0.6, 0.0)));
  tmpvar_4.zw = ((tmpvar_25 * 0.9) + (_ES_CloudElapsedTime * vec2(0.78, 0.0)));
  tmpvar_5.xy = ((tmpvar_25 * 0.7) + (_ES_CloudElapsedTime * vec2(0.28, 0.0035)));
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_glesNormal * tmpvar_26));
  highp vec3 lookAtVector_28;
  lookAtVector_28 = (viewDir_15 * vec3(1.0, -1.0, 1.0));
  highp vec3 tmpvar_29;
  tmpvar_29 = normalize(lookAtVector_28);
  lookAtVector_28 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = (((
    (1.570796 - (sign(tmpvar_29.y) * (1.570796 - (
      sqrt((1.0 - abs(tmpvar_29.y)))
     * 
      (1.570796 + (abs(tmpvar_29.y) * (-0.2146018 + (
        abs(tmpvar_29.y)
       * 
        (0.08656672 + (abs(tmpvar_29.y) * -0.03102955))
      ))))
    ))))
   * 57.29) / 360.0) * 6.283185);
  highp vec3 tmpvar_31;
  tmpvar_31 = ((vec3(1.0, 0.0, 0.0) * tmpvar_29.zxy) - (vec3(0.0, 0.0, 1.0) * tmpvar_29.yzx));
  highp vec3 tmpvar_32;
  tmpvar_32 = (dot (tmpvar_27, tmpvar_31) * tmpvar_31);
  highp vec3 tmpvar_33;
  tmpvar_33 = (tmpvar_27 - tmpvar_32);
  tmpvar_5.zw = (((
    (cos(tmpvar_30) * tmpvar_33)
   + 
    (sin(tmpvar_30) * ((tmpvar_31.yzx * tmpvar_33.zxy) - (tmpvar_31.zxy * tmpvar_33.yzx)))
  ) + tmpvar_32) + tmpvar_27).xz;
  tmpvar_6.xy = ((tmpvar_21 * _CloudCurlTiling) + ((vec2(1.2, 0.8) * _CloudCurlSpeed) * _ES_CloudElapsedTime));
  highp vec2 tmpvar_34;
  tmpvar_34.x = (_glesMultiTexCoord0.x + _ES_CloudWispsElapsedTime);
  tmpvar_34.y = _glesMultiTexCoord0.y;
  tmpvar_6.zw = tmpvar_34;
  tmpvar_7.xy = tmpvar_20;
  mediump float x_35;
  x_35 = (1.0 - (_ES_CloudCoverage * 0.7));
  mediump float tmpvar_36;
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_36 = (tmpvar_37 * (tmpvar_37 * (3.0 - 
    (2.0 * tmpvar_37)
  )));
  mediump float tmpvar_38;
  tmpvar_38 = dot (viewDir_15, _ES_SunDirection);
  tmpvar_8.x = _ES_CloudCoverage;
  tmpvar_8.y = (((x_35 * x_35) * x_35) - 0.15);
  tmpvar_8.z = tmpvar_36;
  tmpvar_8.w = ((tmpvar_38 * 0.5) + 0.5);
  highp vec3 viewDir_39;
  viewDir_39 = tmpvar_19.xyz;
  mediump float moonLunarCancel_40;
  mediump float tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (dot (_ES_MoonDirection, viewDir_39), 0.0, 1.0);
  tmpvar_41 = tmpvar_42;
  highp float tmpvar_43;
  mediump float tmpvar_44;
  tmpvar_44 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_43 = (1.0 - (tmpvar_44 * 2.0));
  moonLunarCancel_40 = tmpvar_43;
  mediump float tmpvar_45;
  tmpvar_45 = clamp (((
    ((tmpvar_41 * tmpvar_41) * ((tmpvar_41 * tmpvar_41) * tmpvar_41))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_46;
  viewDir_46 = tmpvar_19.xyz;
  mediump float vertical_47;
  mediump float tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp (((
    dot (_ES_SunDirection, viewDir_46)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_48 = tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = dot (viewDir_46, _ES_SkyWorldUpDir);
  vertical_47 = tmpvar_50;
  mediump float tmpvar_51;
  tmpvar_51 = max (((tmpvar_38 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_52;
  tmpvar_52 = ((tmpvar_51 * tmpvar_51) * tmpvar_51);
  highp mat3 tmpvar_53;
  tmpvar_53[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_53[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_53[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_54;
  tmpvar_54 = normalize((tmpvar_53 * _glesTANGENT.xyz));
  worldTangent_3 = tmpvar_54;
  highp vec3 tmpvar_55;
  tmpvar_55 = (((tmpvar_27.yzx * worldTangent_3.zxy) - (tmpvar_27.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  worldBinormal_2 = tmpvar_55;
  highp vec3 tmpvar_56;
  tmpvar_56 = worldTangent_3;
  highp vec3 tmpvar_57;
  tmpvar_57 = worldBinormal_2;
  mediump mat3 tmpvar_58;
  highp mat3 tmpvar_59;
  tmpvar_59[0].x = tmpvar_56.x;
  tmpvar_59[0].y = tmpvar_57.x;
  tmpvar_59[0].z = tmpvar_27.x;
  tmpvar_59[1].x = tmpvar_56.y;
  tmpvar_59[1].y = tmpvar_57.y;
  tmpvar_59[1].z = tmpvar_27.y;
  tmpvar_59[2].x = tmpvar_56.z;
  tmpvar_59[2].y = tmpvar_57.z;
  tmpvar_59[2].z = tmpvar_27.z;
  tmpvar_58 = tmpvar_59;
  gl_Position = clipPos_9;
  xlv_TEXCOORD0 = o_12;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_TEXCOORD7 = normalize((tmpvar_58 * _ES_LightDirection));
  xlv_TEXCOORD8 = (((
    ((((tmpvar_45 * 
      (tmpvar_45 * (3.0 - (2.0 * tmpvar_45)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_40) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_48, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_47))
    ) * vertical_47), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_36);
  xlv_TEXCOORD9 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_52));
  xlv_TEXCOORD10 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_52));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_CloudCoverage;
uniform mediump float _ES_CloudOpacity;
uniform mediump vec2 _ES_CloudSmoothness;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform mediump float _ES_CloudWispsCoverage;
uniform mediump float _ES_CloudWispsOpacity;
uniform sampler2D _ES_WeatherMap;
uniform sampler2D _CloudDensityMap;
uniform sampler2D _CloudNormalMap;
uniform sampler2D _CloudWispsTex;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
uniform mediump float _CloudDarkShadingNormalYScale;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec3 xlv_TEXCOORD9;
varying mediump vec3 xlv_TEXCOORD10;
void main ()
{
  mediump vec4 finalCol_1;
  mediump vec4 cloudWisps_2;
  mediump vec3 weather_3;
  mediump float tmpvar_4;
  tmpvar_4 = clamp ((xlv_TEXCOORD6.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_5;
  tmpvar_5 = clamp ((tmpvar_4 * (tmpvar_4 * 
    (3.0 - (2.0 * tmpvar_4))
  )), 0.0, 1.0);
  mediump float tmpvar_6;
  tmpvar_6 = xlv_TEXCOORD5.y;
  mediump float tmpvar_7;
  tmpvar_7 = clamp (((xlv_TEXCOORD5.w - _ES_SunRimLightRadius) / (1.0 - _ES_SunRimLightRadius)), 0.0, 1.0);
  mediump float tmpvar_8;
  tmpvar_8 = (((tmpvar_7 * 
    (tmpvar_7 * (3.0 - (2.0 * tmpvar_7)))
  ) * _ES_SunBrightness) * 0.05);
  lowp vec3 tmpvar_9;
  tmpvar_9 = texture2D (_ES_WeatherMap, xlv_TEXCOORD4.xy).xyz;
  weather_3 = tmpvar_9;
  mediump float filterBaseAlpha_10;
  mediump float filterHighlightArea_11;
  mediump float variationClouds_12;
  mediump vec3 cloudNormal_13;
  mediump vec3 shadowTex_14;
  mediump vec3 cloudTex1_15;
  mediump vec3 cloudTex0_16;
  highp vec3 curlNoise_17;
  lowp vec3 tmpvar_18;
  tmpvar_18 = texture2D (_CloudCurlTex, xlv_TEXCOORD3.xy).xyz;
  curlNoise_17 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = ((curlNoise_17.xy - 0.5) * mix ((_CloudCurlAmplitude * 0.2), _CloudCurlAmplitude, weather_3.y));
  highp vec2 P_20;
  P_20 = (xlv_TEXCOORD1.xy + tmpvar_19);
  lowp vec3 tmpvar_21;
  tmpvar_21 = texture2D (_CloudDensityMap, P_20).xyz;
  cloudTex0_16 = tmpvar_21;
  highp vec2 P_22;
  P_22 = (xlv_TEXCOORD1.zw + tmpvar_19);
  lowp vec3 tmpvar_23;
  tmpvar_23 = texture2D (_CloudDensityMap, P_22).xyz;
  cloudTex1_15 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = (0.03 - (cloudTex0_16.y * 0.01));
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD2.xy + (xlv_TEXCOORD2.zw * tmpvar_24)) + (tmpvar_19 * 0.5));
  lowp vec3 tmpvar_26;
  tmpvar_26 = texture2D (_CloudDensityMap, P_25).xyz;
  shadowTex_14 = tmpvar_26;
  highp vec2 P_27;
  P_27 = (xlv_TEXCOORD2.xy + tmpvar_19);
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_CloudNormalMap, P_27).xyz * 2.0) - 1.0);
  cloudNormal_13 = tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29.xz = vec2(1.0, 1.0);
  tmpvar_29.y = _CloudDarkShadingNormalYScale;
  mediump float tmpvar_30;
  tmpvar_30 = clamp (((
    dot (normalize((cloudNormal_13 * tmpvar_29)), xlv_TEXCOORD7)
   * 0.5) + 0.5), 0.0, 1.0);
  mediump float tmpvar_31;
  tmpvar_31 = clamp ((clamp (
    ((shadowTex_14.y * shadowTex_14.z) * 2.0)
  , 0.0, 1.0) + (shadowTex_14.x - 0.5)), 0.0, 1.0);
  mediump float tmpvar_32;
  tmpvar_32 = (((1.0 - tmpvar_5) * 0.2) + ((
    (cloudTex1_15.z * cloudTex0_16.z)
   + 
    ((cloudTex0_16.x - 0.5) * 0.15)
  ) * weather_3.x));
  highp float value_33;
  value_33 = (cloudTex1_15.x * cloudTex1_15.y);
  highp float tmpvar_34;
  tmpvar_34 = clamp ((value_33 / 0.5), 0.0, 1.0);
  variationClouds_12 = tmpvar_34;
  variationClouds_12 = (variationClouds_12 * variationClouds_12);
  highp float middleThreshold_35;
  middleThreshold_35 = tmpvar_6;
  highp float gradientWidth_36;
  gradientWidth_36 = (0.5 + (variationClouds_12 * 0.5));
  highp float value_37;
  value_37 = tmpvar_32;
  highp float tmpvar_38;
  tmpvar_38 = clamp (((value_37 - middleThreshold_35) / gradientWidth_36), 0.0, 1.0);
  filterHighlightArea_11 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = mix (_ES_CloudSmoothness.x, _ES_CloudSmoothness.y, weather_3.z);
  highp float middleThreshold_40;
  middleThreshold_40 = tmpvar_6;
  highp float gradientWidth_41;
  gradientWidth_41 = ((variationClouds_12 * tmpvar_39) + 0.05);
  highp float value_42;
  value_42 = tmpvar_32;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((value_42 - middleThreshold_40) / gradientWidth_41), 0.0, 1.0);
  filterBaseAlpha_10 = tmpvar_43;
  mediump float tmpvar_44;
  tmpvar_44 = clamp (((_ES_CloudCoverage - 0.5) / 0.2), 0.0, 1.0);
  mediump vec4 tmpvar_45;
  tmpvar_45.xyz = (((
    mix (xlv_TEXCOORD10, xlv_TEXCOORD9, vec3(((tmpvar_31 * tmpvar_31) * (1.0 - (tmpvar_30 * 
      (tmpvar_30 * (3.0 - (2.0 * tmpvar_30)))
    )))))
   + 
    ((((
      (clamp (pow (max (
        min (max (((0.5 - filterHighlightArea_11) * 2.0), 0.0), 1.0)
      , 0.0001), (tmpvar_8 * 30.0)), 0.0, 1.0) * (tmpvar_8 * tmpvar_8))
     * _ES_SunHaloColor) * 50.0) * variationClouds_12) * xlv_TEXCOORD5.z)
  ) + (
    ((variationClouds_12 * 0.5) * xlv_TEXCOORD9)
   * xlv_TEXCOORD5.x)) + (xlv_TEXCOORD8 * tmpvar_31));
  tmpvar_45.w = mix ((clamp (
    (filterBaseAlpha_10 * tmpvar_5)
  , 0.0, 1.0) * _ES_CloudOpacity), 1.0, (tmpvar_44 * (tmpvar_44 * 
    (3.0 - (2.0 * tmpvar_44))
  )));
  highp float wispyOpacity_46;
  lowp float tmpvar_47;
  tmpvar_47 = texture2D (_CloudWispsTex, xlv_TEXCOORD3.zw).w;
  wispyOpacity_46 = tmpvar_47;
  mediump float value_48;
  value_48 = wispyOpacity_46;
  mediump float low_49;
  low_49 = (1.0 - _ES_CloudWispsCoverage);
  mediump float tmpvar_50;
  tmpvar_50 = clamp (((value_48 - low_49) / (1.0 - low_49)), 0.0, 1.0);
  wispyOpacity_46 = (tmpvar_50 * _ES_CloudWispsOpacity);
  highp vec4 tmpvar_51;
  tmpvar_51.xyz = mix (xlv_TEXCOORD9, xlv_TEXCOORD10, vec3(wispyOpacity_46));
  tmpvar_51.w = wispyOpacity_46;
  cloudWisps_2 = tmpvar_51;
  finalCol_1.w = 0.0;
  finalCol_1.xyz = mix ((cloudWisps_2.xyz * cloudWisps_2.w), tmpvar_45.xyz, tmpvar_45.www);
  finalCol_1.xyz = (finalCol_1.xyz * ((xlv_TEXCOORD5.w * _ES_CloudSunBrightenIntensity) + 1.0));
  finalCol_1.w = tmpvar_45.w;
  gl_FragData[0] = finalCol_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "SHOW_WEATHERMAP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec3 _ES_LightDirection;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunHaloSize;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform highp vec2 _ES_CloudDirection;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudHeight;
uniform highp float _ES_CloudTiling;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudWispsElapsedTime;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec3 xlv_TEXCOORD9;
varying mediump vec3 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 worldBinormal_2;
  mediump vec3 worldTangent_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_7.zw = vec2(0.0, 0.0);
  highp vec4 clipPos_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  clipPos_9.xyw = tmpvar_10.xyw;
  clipPos_9.z = tmpvar_10.w;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10.xyww * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = clipPos_9.zw;
  mediump vec3 viewDir_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(((unity_ObjectToWorld * tmpvar_16).xyz - _ES_SkyCenterWorldPos));
  viewDir_15 = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = dot (_ES_SkyWorldUpDir, viewDir_15);
  mediump vec4 tmpvar_19;
  tmpvar_19.xyz = viewDir_15;
  tmpvar_19.w = ((sign(tmpvar_18) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_18))) * (1.570796 + (abs(tmpvar_18) * (-0.2146018 + 
      (abs(tmpvar_18) * (0.08656672 + (abs(tmpvar_18) * -0.03102955)))
    ))))
  )) * 0.6366198);
  highp vec2 tmpvar_20;
  tmpvar_20 = mix (_glesMultiTexCoord1.xy, _glesMultiTexCoord2.xy, vec2(_ES_CloudHeight));
  highp vec2 tmpvar_21;
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_20 - 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = _ES_CloudDirection.y;
  tmpvar_23.y = -(_ES_CloudDirection.x);
  highp vec2 tmpvar_24;
  tmpvar_24.x = dot (tmpvar_23, tmpvar_22);
  tmpvar_24.y = dot (_ES_CloudDirection, tmpvar_22);
  tmpvar_21 = (tmpvar_24 + 0.5);
  highp vec2 tmpvar_25;
  tmpvar_25 = (tmpvar_21 * _ES_CloudTiling);
  tmpvar_4.xy = ((tmpvar_25 * 1.2) + (_ES_CloudElapsedTime * vec2(0.6, 0.0)));
  tmpvar_4.zw = ((tmpvar_25 * 0.9) + (_ES_CloudElapsedTime * vec2(0.78, 0.0)));
  tmpvar_5.xy = ((tmpvar_25 * 0.7) + (_ES_CloudElapsedTime * vec2(0.28, 0.0035)));
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_glesNormal * tmpvar_26));
  highp vec3 lookAtVector_28;
  lookAtVector_28 = (viewDir_15 * vec3(1.0, -1.0, 1.0));
  highp vec3 tmpvar_29;
  tmpvar_29 = normalize(lookAtVector_28);
  lookAtVector_28 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = (((
    (1.570796 - (sign(tmpvar_29.y) * (1.570796 - (
      sqrt((1.0 - abs(tmpvar_29.y)))
     * 
      (1.570796 + (abs(tmpvar_29.y) * (-0.2146018 + (
        abs(tmpvar_29.y)
       * 
        (0.08656672 + (abs(tmpvar_29.y) * -0.03102955))
      ))))
    ))))
   * 57.29) / 360.0) * 6.283185);
  highp vec3 tmpvar_31;
  tmpvar_31 = ((vec3(1.0, 0.0, 0.0) * tmpvar_29.zxy) - (vec3(0.0, 0.0, 1.0) * tmpvar_29.yzx));
  highp vec3 tmpvar_32;
  tmpvar_32 = (dot (tmpvar_27, tmpvar_31) * tmpvar_31);
  highp vec3 tmpvar_33;
  tmpvar_33 = (tmpvar_27 - tmpvar_32);
  tmpvar_5.zw = (((
    (cos(tmpvar_30) * tmpvar_33)
   + 
    (sin(tmpvar_30) * ((tmpvar_31.yzx * tmpvar_33.zxy) - (tmpvar_31.zxy * tmpvar_33.yzx)))
  ) + tmpvar_32) + tmpvar_27).xz;
  tmpvar_6.xy = ((tmpvar_21 * _CloudCurlTiling) + ((vec2(1.2, 0.8) * _CloudCurlSpeed) * _ES_CloudElapsedTime));
  highp vec2 tmpvar_34;
  tmpvar_34.x = (_glesMultiTexCoord0.x + _ES_CloudWispsElapsedTime);
  tmpvar_34.y = _glesMultiTexCoord0.y;
  tmpvar_6.zw = tmpvar_34;
  tmpvar_7.xy = tmpvar_20;
  mediump float x_35;
  x_35 = (1.0 - (_ES_CloudCoverage * 0.7));
  mediump float tmpvar_36;
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_36 = (tmpvar_37 * (tmpvar_37 * (3.0 - 
    (2.0 * tmpvar_37)
  )));
  mediump float tmpvar_38;
  tmpvar_38 = dot (viewDir_15, _ES_SunDirection);
  tmpvar_8.x = _ES_CloudCoverage;
  tmpvar_8.y = (((x_35 * x_35) * x_35) - 0.15);
  tmpvar_8.z = tmpvar_36;
  tmpvar_8.w = ((tmpvar_38 * 0.5) + 0.5);
  highp vec3 viewDir_39;
  viewDir_39 = tmpvar_19.xyz;
  mediump float moonLunarCancel_40;
  mediump float tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (dot (_ES_MoonDirection, viewDir_39), 0.0, 1.0);
  tmpvar_41 = tmpvar_42;
  highp float tmpvar_43;
  mediump float tmpvar_44;
  tmpvar_44 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_43 = (1.0 - (tmpvar_44 * 2.0));
  moonLunarCancel_40 = tmpvar_43;
  mediump float tmpvar_45;
  tmpvar_45 = clamp (((
    ((tmpvar_41 * tmpvar_41) * ((tmpvar_41 * tmpvar_41) * tmpvar_41))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_46;
  viewDir_46 = tmpvar_19.xyz;
  mediump float vertical_47;
  mediump float tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp (((
    dot (_ES_SunDirection, viewDir_46)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_48 = tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = dot (viewDir_46, _ES_SkyWorldUpDir);
  vertical_47 = tmpvar_50;
  mediump float tmpvar_51;
  tmpvar_51 = max (((tmpvar_38 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_52;
  tmpvar_52 = ((tmpvar_51 * tmpvar_51) * tmpvar_51);
  highp mat3 tmpvar_53;
  tmpvar_53[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_53[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_53[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_54;
  tmpvar_54 = normalize((tmpvar_53 * _glesTANGENT.xyz));
  worldTangent_3 = tmpvar_54;
  highp vec3 tmpvar_55;
  tmpvar_55 = (((tmpvar_27.yzx * worldTangent_3.zxy) - (tmpvar_27.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  worldBinormal_2 = tmpvar_55;
  highp vec3 tmpvar_56;
  tmpvar_56 = worldTangent_3;
  highp vec3 tmpvar_57;
  tmpvar_57 = worldBinormal_2;
  mediump mat3 tmpvar_58;
  highp mat3 tmpvar_59;
  tmpvar_59[0].x = tmpvar_56.x;
  tmpvar_59[0].y = tmpvar_57.x;
  tmpvar_59[0].z = tmpvar_27.x;
  tmpvar_59[1].x = tmpvar_56.y;
  tmpvar_59[1].y = tmpvar_57.y;
  tmpvar_59[1].z = tmpvar_27.y;
  tmpvar_59[2].x = tmpvar_56.z;
  tmpvar_59[2].y = tmpvar_57.z;
  tmpvar_59[2].z = tmpvar_27.z;
  tmpvar_58 = tmpvar_59;
  gl_Position = clipPos_9;
  xlv_TEXCOORD0 = o_12;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_TEXCOORD7 = normalize((tmpvar_58 * _ES_LightDirection));
  xlv_TEXCOORD8 = (((
    ((((tmpvar_45 * 
      (tmpvar_45 * (3.0 - (2.0 * tmpvar_45)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_40) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_48, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_47))
    ) * vertical_47), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_36);
  xlv_TEXCOORD9 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_52));
  xlv_TEXCOORD10 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_52));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_CloudCoverage;
uniform mediump float _ES_CloudOpacity;
uniform mediump vec2 _ES_CloudSmoothness;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform mediump float _ES_CloudWispsCoverage;
uniform mediump float _ES_CloudWispsOpacity;
uniform sampler2D _ES_WeatherMap;
uniform sampler2D _CloudDensityMap;
uniform sampler2D _CloudNormalMap;
uniform sampler2D _CloudWispsTex;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
uniform mediump float _CloudDarkShadingNormalYScale;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec3 xlv_TEXCOORD9;
varying mediump vec3 xlv_TEXCOORD10;
void main ()
{
  mediump vec4 finalCol_1;
  mediump vec4 cloudWisps_2;
  mediump vec3 weather_3;
  mediump float tmpvar_4;
  tmpvar_4 = clamp ((xlv_TEXCOORD6.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_5;
  tmpvar_5 = clamp ((tmpvar_4 * (tmpvar_4 * 
    (3.0 - (2.0 * tmpvar_4))
  )), 0.0, 1.0);
  mediump float tmpvar_6;
  tmpvar_6 = xlv_TEXCOORD5.y;
  mediump float tmpvar_7;
  tmpvar_7 = clamp (((xlv_TEXCOORD5.w - _ES_SunRimLightRadius) / (1.0 - _ES_SunRimLightRadius)), 0.0, 1.0);
  mediump float tmpvar_8;
  tmpvar_8 = (((tmpvar_7 * 
    (tmpvar_7 * (3.0 - (2.0 * tmpvar_7)))
  ) * _ES_SunBrightness) * 0.05);
  lowp vec3 tmpvar_9;
  tmpvar_9 = texture2D (_ES_WeatherMap, xlv_TEXCOORD4.xy).xyz;
  weather_3 = tmpvar_9;
  mediump float filterBaseAlpha_10;
  mediump float filterHighlightArea_11;
  mediump float variationClouds_12;
  mediump vec3 cloudNormal_13;
  mediump vec3 shadowTex_14;
  mediump vec3 cloudTex1_15;
  mediump vec3 cloudTex0_16;
  highp vec3 curlNoise_17;
  lowp vec3 tmpvar_18;
  tmpvar_18 = texture2D (_CloudCurlTex, xlv_TEXCOORD3.xy).xyz;
  curlNoise_17 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = ((curlNoise_17.xy - 0.5) * mix ((_CloudCurlAmplitude * 0.2), _CloudCurlAmplitude, weather_3.y));
  highp vec2 P_20;
  P_20 = (xlv_TEXCOORD1.xy + tmpvar_19);
  lowp vec3 tmpvar_21;
  tmpvar_21 = texture2D (_CloudDensityMap, P_20).xyz;
  cloudTex0_16 = tmpvar_21;
  highp vec2 P_22;
  P_22 = (xlv_TEXCOORD1.zw + tmpvar_19);
  lowp vec3 tmpvar_23;
  tmpvar_23 = texture2D (_CloudDensityMap, P_22).xyz;
  cloudTex1_15 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = (0.03 - (cloudTex0_16.y * 0.01));
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD2.xy + (xlv_TEXCOORD2.zw * tmpvar_24)) + (tmpvar_19 * 0.5));
  lowp vec3 tmpvar_26;
  tmpvar_26 = texture2D (_CloudDensityMap, P_25).xyz;
  shadowTex_14 = tmpvar_26;
  highp vec2 P_27;
  P_27 = (xlv_TEXCOORD2.xy + tmpvar_19);
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_CloudNormalMap, P_27).xyz * 2.0) - 1.0);
  cloudNormal_13 = tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29.xz = vec2(1.0, 1.0);
  tmpvar_29.y = _CloudDarkShadingNormalYScale;
  mediump float tmpvar_30;
  tmpvar_30 = clamp (((
    dot (normalize((cloudNormal_13 * tmpvar_29)), xlv_TEXCOORD7)
   * 0.5) + 0.5), 0.0, 1.0);
  mediump float tmpvar_31;
  tmpvar_31 = clamp ((clamp (
    ((shadowTex_14.y * shadowTex_14.z) * 2.0)
  , 0.0, 1.0) + (shadowTex_14.x - 0.5)), 0.0, 1.0);
  mediump float tmpvar_32;
  tmpvar_32 = (((1.0 - tmpvar_5) * 0.2) + ((
    (cloudTex1_15.z * cloudTex0_16.z)
   + 
    ((cloudTex0_16.x - 0.5) * 0.15)
  ) * weather_3.x));
  highp float value_33;
  value_33 = (cloudTex1_15.x * cloudTex1_15.y);
  highp float tmpvar_34;
  tmpvar_34 = clamp ((value_33 / 0.5), 0.0, 1.0);
  variationClouds_12 = tmpvar_34;
  variationClouds_12 = (variationClouds_12 * variationClouds_12);
  highp float middleThreshold_35;
  middleThreshold_35 = tmpvar_6;
  highp float gradientWidth_36;
  gradientWidth_36 = (0.5 + (variationClouds_12 * 0.5));
  highp float value_37;
  value_37 = tmpvar_32;
  highp float tmpvar_38;
  tmpvar_38 = clamp (((value_37 - middleThreshold_35) / gradientWidth_36), 0.0, 1.0);
  filterHighlightArea_11 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = mix (_ES_CloudSmoothness.x, _ES_CloudSmoothness.y, weather_3.z);
  highp float middleThreshold_40;
  middleThreshold_40 = tmpvar_6;
  highp float gradientWidth_41;
  gradientWidth_41 = ((variationClouds_12 * tmpvar_39) + 0.05);
  highp float value_42;
  value_42 = tmpvar_32;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((value_42 - middleThreshold_40) / gradientWidth_41), 0.0, 1.0);
  filterBaseAlpha_10 = tmpvar_43;
  mediump float tmpvar_44;
  tmpvar_44 = clamp (((_ES_CloudCoverage - 0.5) / 0.2), 0.0, 1.0);
  mediump vec4 tmpvar_45;
  tmpvar_45.xyz = (((
    mix (xlv_TEXCOORD10, xlv_TEXCOORD9, vec3(((tmpvar_31 * tmpvar_31) * (1.0 - (tmpvar_30 * 
      (tmpvar_30 * (3.0 - (2.0 * tmpvar_30)))
    )))))
   + 
    ((((
      (clamp (pow (max (
        min (max (((0.5 - filterHighlightArea_11) * 2.0), 0.0), 1.0)
      , 0.0001), (tmpvar_8 * 30.0)), 0.0, 1.0) * (tmpvar_8 * tmpvar_8))
     * _ES_SunHaloColor) * 50.0) * variationClouds_12) * xlv_TEXCOORD5.z)
  ) + (
    ((variationClouds_12 * 0.5) * xlv_TEXCOORD9)
   * xlv_TEXCOORD5.x)) + (xlv_TEXCOORD8 * tmpvar_31));
  tmpvar_45.w = mix ((clamp (
    (filterBaseAlpha_10 * tmpvar_5)
  , 0.0, 1.0) * _ES_CloudOpacity), 1.0, (tmpvar_44 * (tmpvar_44 * 
    (3.0 - (2.0 * tmpvar_44))
  )));
  highp float wispyOpacity_46;
  lowp float tmpvar_47;
  tmpvar_47 = texture2D (_CloudWispsTex, xlv_TEXCOORD3.zw).w;
  wispyOpacity_46 = tmpvar_47;
  mediump float value_48;
  value_48 = wispyOpacity_46;
  mediump float low_49;
  low_49 = (1.0 - _ES_CloudWispsCoverage);
  mediump float tmpvar_50;
  tmpvar_50 = clamp (((value_48 - low_49) / (1.0 - low_49)), 0.0, 1.0);
  wispyOpacity_46 = (tmpvar_50 * _ES_CloudWispsOpacity);
  highp vec4 tmpvar_51;
  tmpvar_51.xyz = mix (xlv_TEXCOORD9, xlv_TEXCOORD10, vec3(wispyOpacity_46));
  tmpvar_51.w = wispyOpacity_46;
  cloudWisps_2 = tmpvar_51;
  finalCol_1.w = 0.0;
  finalCol_1.xyz = mix ((cloudWisps_2.xyz * cloudWisps_2.w), tmpvar_45.xyz, tmpvar_45.www);
  finalCol_1.xyz = (finalCol_1.xyz * ((xlv_TEXCOORD5.w * _ES_CloudSunBrightenIntensity) + 1.0));
  finalCol_1.w = tmpvar_45.w;
  gl_FragData[0] = finalCol_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "SHOW_WEATHERMAP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec3 _ES_LightDirection;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunHaloSize;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform highp vec2 _ES_CloudDirection;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudHeight;
uniform highp float _ES_CloudTiling;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudWispsElapsedTime;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec3 xlv_TEXCOORD9;
varying mediump vec3 xlv_TEXCOORD10;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 worldBinormal_2;
  mediump vec3 worldTangent_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_7.zw = vec2(0.0, 0.0);
  highp vec4 clipPos_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  clipPos_9.xyw = tmpvar_10.xyw;
  clipPos_9.z = tmpvar_10.w;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10.xyww * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = clipPos_9.zw;
  mediump vec3 viewDir_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(((unity_ObjectToWorld * tmpvar_16).xyz - _ES_SkyCenterWorldPos));
  viewDir_15 = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = dot (_ES_SkyWorldUpDir, viewDir_15);
  mediump vec4 tmpvar_19;
  tmpvar_19.xyz = viewDir_15;
  tmpvar_19.w = ((sign(tmpvar_18) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_18))) * (1.570796 + (abs(tmpvar_18) * (-0.2146018 + 
      (abs(tmpvar_18) * (0.08656672 + (abs(tmpvar_18) * -0.03102955)))
    ))))
  )) * 0.6366198);
  highp vec2 tmpvar_20;
  tmpvar_20 = mix (_glesMultiTexCoord1.xy, _glesMultiTexCoord2.xy, vec2(_ES_CloudHeight));
  highp vec2 tmpvar_21;
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_20 - 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = _ES_CloudDirection.y;
  tmpvar_23.y = -(_ES_CloudDirection.x);
  highp vec2 tmpvar_24;
  tmpvar_24.x = dot (tmpvar_23, tmpvar_22);
  tmpvar_24.y = dot (_ES_CloudDirection, tmpvar_22);
  tmpvar_21 = (tmpvar_24 + 0.5);
  highp vec2 tmpvar_25;
  tmpvar_25 = (tmpvar_21 * _ES_CloudTiling);
  tmpvar_4.xy = ((tmpvar_25 * 1.2) + (_ES_CloudElapsedTime * vec2(0.6, 0.0)));
  tmpvar_4.zw = ((tmpvar_25 * 0.9) + (_ES_CloudElapsedTime * vec2(0.78, 0.0)));
  tmpvar_5.xy = ((tmpvar_25 * 0.7) + (_ES_CloudElapsedTime * vec2(0.28, 0.0035)));
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_glesNormal * tmpvar_26));
  highp vec3 lookAtVector_28;
  lookAtVector_28 = (viewDir_15 * vec3(1.0, -1.0, 1.0));
  highp vec3 tmpvar_29;
  tmpvar_29 = normalize(lookAtVector_28);
  lookAtVector_28 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = (((
    (1.570796 - (sign(tmpvar_29.y) * (1.570796 - (
      sqrt((1.0 - abs(tmpvar_29.y)))
     * 
      (1.570796 + (abs(tmpvar_29.y) * (-0.2146018 + (
        abs(tmpvar_29.y)
       * 
        (0.08656672 + (abs(tmpvar_29.y) * -0.03102955))
      ))))
    ))))
   * 57.29) / 360.0) * 6.283185);
  highp vec3 tmpvar_31;
  tmpvar_31 = ((vec3(1.0, 0.0, 0.0) * tmpvar_29.zxy) - (vec3(0.0, 0.0, 1.0) * tmpvar_29.yzx));
  highp vec3 tmpvar_32;
  tmpvar_32 = (dot (tmpvar_27, tmpvar_31) * tmpvar_31);
  highp vec3 tmpvar_33;
  tmpvar_33 = (tmpvar_27 - tmpvar_32);
  tmpvar_5.zw = (((
    (cos(tmpvar_30) * tmpvar_33)
   + 
    (sin(tmpvar_30) * ((tmpvar_31.yzx * tmpvar_33.zxy) - (tmpvar_31.zxy * tmpvar_33.yzx)))
  ) + tmpvar_32) + tmpvar_27).xz;
  tmpvar_6.xy = ((tmpvar_21 * _CloudCurlTiling) + ((vec2(1.2, 0.8) * _CloudCurlSpeed) * _ES_CloudElapsedTime));
  highp vec2 tmpvar_34;
  tmpvar_34.x = (_glesMultiTexCoord0.x + _ES_CloudWispsElapsedTime);
  tmpvar_34.y = _glesMultiTexCoord0.y;
  tmpvar_6.zw = tmpvar_34;
  tmpvar_7.xy = tmpvar_20;
  mediump float x_35;
  x_35 = (1.0 - (_ES_CloudCoverage * 0.7));
  mediump float tmpvar_36;
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_36 = (tmpvar_37 * (tmpvar_37 * (3.0 - 
    (2.0 * tmpvar_37)
  )));
  mediump float tmpvar_38;
  tmpvar_38 = dot (viewDir_15, _ES_SunDirection);
  tmpvar_8.x = _ES_CloudCoverage;
  tmpvar_8.y = (((x_35 * x_35) * x_35) - 0.15);
  tmpvar_8.z = tmpvar_36;
  tmpvar_8.w = ((tmpvar_38 * 0.5) + 0.5);
  highp vec3 viewDir_39;
  viewDir_39 = tmpvar_19.xyz;
  mediump float moonLunarCancel_40;
  mediump float tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (dot (_ES_MoonDirection, viewDir_39), 0.0, 1.0);
  tmpvar_41 = tmpvar_42;
  highp float tmpvar_43;
  mediump float tmpvar_44;
  tmpvar_44 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_43 = (1.0 - (tmpvar_44 * 2.0));
  moonLunarCancel_40 = tmpvar_43;
  mediump float tmpvar_45;
  tmpvar_45 = clamp (((
    ((tmpvar_41 * tmpvar_41) * ((tmpvar_41 * tmpvar_41) * tmpvar_41))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_46;
  viewDir_46 = tmpvar_19.xyz;
  mediump float vertical_47;
  mediump float tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp (((
    dot (_ES_SunDirection, viewDir_46)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_48 = tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = dot (viewDir_46, _ES_SkyWorldUpDir);
  vertical_47 = tmpvar_50;
  mediump float tmpvar_51;
  tmpvar_51 = max (((tmpvar_38 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_52;
  tmpvar_52 = ((tmpvar_51 * tmpvar_51) * tmpvar_51);
  highp mat3 tmpvar_53;
  tmpvar_53[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_53[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_53[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_54;
  tmpvar_54 = normalize((tmpvar_53 * _glesTANGENT.xyz));
  worldTangent_3 = tmpvar_54;
  highp vec3 tmpvar_55;
  tmpvar_55 = (((tmpvar_27.yzx * worldTangent_3.zxy) - (tmpvar_27.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  worldBinormal_2 = tmpvar_55;
  highp vec3 tmpvar_56;
  tmpvar_56 = worldTangent_3;
  highp vec3 tmpvar_57;
  tmpvar_57 = worldBinormal_2;
  mediump mat3 tmpvar_58;
  highp mat3 tmpvar_59;
  tmpvar_59[0].x = tmpvar_56.x;
  tmpvar_59[0].y = tmpvar_57.x;
  tmpvar_59[0].z = tmpvar_27.x;
  tmpvar_59[1].x = tmpvar_56.y;
  tmpvar_59[1].y = tmpvar_57.y;
  tmpvar_59[1].z = tmpvar_27.y;
  tmpvar_59[2].x = tmpvar_56.z;
  tmpvar_59[2].y = tmpvar_57.z;
  tmpvar_59[2].z = tmpvar_27.z;
  tmpvar_58 = tmpvar_59;
  gl_Position = clipPos_9;
  xlv_TEXCOORD0 = o_12;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_TEXCOORD7 = normalize((tmpvar_58 * _ES_LightDirection));
  xlv_TEXCOORD8 = (((
    ((((tmpvar_45 * 
      (tmpvar_45 * (3.0 - (2.0 * tmpvar_45)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_40) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_48, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_47))
    ) * vertical_47), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_36);
  xlv_TEXCOORD9 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_52));
  xlv_TEXCOORD10 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_52));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_CloudCoverage;
uniform mediump float _ES_CloudOpacity;
uniform mediump vec2 _ES_CloudSmoothness;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform mediump float _ES_CloudWispsCoverage;
uniform mediump float _ES_CloudWispsOpacity;
uniform sampler2D _ES_WeatherMap;
uniform sampler2D _CloudDensityMap;
uniform sampler2D _CloudNormalMap;
uniform sampler2D _CloudWispsTex;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
uniform mediump float _CloudDarkShadingNormalYScale;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec3 xlv_TEXCOORD9;
varying mediump vec3 xlv_TEXCOORD10;
void main ()
{
  mediump vec4 finalCol_1;
  mediump vec4 cloudWisps_2;
  mediump vec3 weather_3;
  mediump float tmpvar_4;
  tmpvar_4 = clamp ((xlv_TEXCOORD6.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_5;
  tmpvar_5 = clamp ((tmpvar_4 * (tmpvar_4 * 
    (3.0 - (2.0 * tmpvar_4))
  )), 0.0, 1.0);
  mediump float tmpvar_6;
  tmpvar_6 = xlv_TEXCOORD5.y;
  mediump float tmpvar_7;
  tmpvar_7 = clamp (((xlv_TEXCOORD5.w - _ES_SunRimLightRadius) / (1.0 - _ES_SunRimLightRadius)), 0.0, 1.0);
  mediump float tmpvar_8;
  tmpvar_8 = (((tmpvar_7 * 
    (tmpvar_7 * (3.0 - (2.0 * tmpvar_7)))
  ) * _ES_SunBrightness) * 0.05);
  lowp vec3 tmpvar_9;
  tmpvar_9 = texture2D (_ES_WeatherMap, xlv_TEXCOORD4.xy).xyz;
  weather_3 = tmpvar_9;
  mediump float filterBaseAlpha_10;
  mediump float filterHighlightArea_11;
  mediump float variationClouds_12;
  mediump vec3 cloudNormal_13;
  mediump vec3 shadowTex_14;
  mediump vec3 cloudTex1_15;
  mediump vec3 cloudTex0_16;
  highp vec3 curlNoise_17;
  lowp vec3 tmpvar_18;
  tmpvar_18 = texture2D (_CloudCurlTex, xlv_TEXCOORD3.xy).xyz;
  curlNoise_17 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = ((curlNoise_17.xy - 0.5) * mix ((_CloudCurlAmplitude * 0.2), _CloudCurlAmplitude, weather_3.y));
  highp vec2 P_20;
  P_20 = (xlv_TEXCOORD1.xy + tmpvar_19);
  lowp vec3 tmpvar_21;
  tmpvar_21 = texture2D (_CloudDensityMap, P_20).xyz;
  cloudTex0_16 = tmpvar_21;
  highp vec2 P_22;
  P_22 = (xlv_TEXCOORD1.zw + tmpvar_19);
  lowp vec3 tmpvar_23;
  tmpvar_23 = texture2D (_CloudDensityMap, P_22).xyz;
  cloudTex1_15 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = (0.03 - (cloudTex0_16.y * 0.01));
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD2.xy + (xlv_TEXCOORD2.zw * tmpvar_24)) + (tmpvar_19 * 0.5));
  lowp vec3 tmpvar_26;
  tmpvar_26 = texture2D (_CloudDensityMap, P_25).xyz;
  shadowTex_14 = tmpvar_26;
  highp vec2 P_27;
  P_27 = (xlv_TEXCOORD2.xy + tmpvar_19);
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_CloudNormalMap, P_27).xyz * 2.0) - 1.0);
  cloudNormal_13 = tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29.xz = vec2(1.0, 1.0);
  tmpvar_29.y = _CloudDarkShadingNormalYScale;
  mediump float tmpvar_30;
  tmpvar_30 = clamp (((
    dot (normalize((cloudNormal_13 * tmpvar_29)), xlv_TEXCOORD7)
   * 0.5) + 0.5), 0.0, 1.0);
  mediump float tmpvar_31;
  tmpvar_31 = clamp ((clamp (
    ((shadowTex_14.y * shadowTex_14.z) * 2.0)
  , 0.0, 1.0) + (shadowTex_14.x - 0.5)), 0.0, 1.0);
  mediump float tmpvar_32;
  tmpvar_32 = (((1.0 - tmpvar_5) * 0.2) + ((
    (cloudTex1_15.z * cloudTex0_16.z)
   + 
    ((cloudTex0_16.x - 0.5) * 0.15)
  ) * weather_3.x));
  highp float value_33;
  value_33 = (cloudTex1_15.x * cloudTex1_15.y);
  highp float tmpvar_34;
  tmpvar_34 = clamp ((value_33 / 0.5), 0.0, 1.0);
  variationClouds_12 = tmpvar_34;
  variationClouds_12 = (variationClouds_12 * variationClouds_12);
  highp float middleThreshold_35;
  middleThreshold_35 = tmpvar_6;
  highp float gradientWidth_36;
  gradientWidth_36 = (0.5 + (variationClouds_12 * 0.5));
  highp float value_37;
  value_37 = tmpvar_32;
  highp float tmpvar_38;
  tmpvar_38 = clamp (((value_37 - middleThreshold_35) / gradientWidth_36), 0.0, 1.0);
  filterHighlightArea_11 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = mix (_ES_CloudSmoothness.x, _ES_CloudSmoothness.y, weather_3.z);
  highp float middleThreshold_40;
  middleThreshold_40 = tmpvar_6;
  highp float gradientWidth_41;
  gradientWidth_41 = ((variationClouds_12 * tmpvar_39) + 0.05);
  highp float value_42;
  value_42 = tmpvar_32;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((value_42 - middleThreshold_40) / gradientWidth_41), 0.0, 1.0);
  filterBaseAlpha_10 = tmpvar_43;
  mediump float tmpvar_44;
  tmpvar_44 = clamp (((_ES_CloudCoverage - 0.5) / 0.2), 0.0, 1.0);
  mediump vec4 tmpvar_45;
  tmpvar_45.xyz = (((
    mix (xlv_TEXCOORD10, xlv_TEXCOORD9, vec3(((tmpvar_31 * tmpvar_31) * (1.0 - (tmpvar_30 * 
      (tmpvar_30 * (3.0 - (2.0 * tmpvar_30)))
    )))))
   + 
    ((((
      (clamp (pow (max (
        min (max (((0.5 - filterHighlightArea_11) * 2.0), 0.0), 1.0)
      , 0.0001), (tmpvar_8 * 30.0)), 0.0, 1.0) * (tmpvar_8 * tmpvar_8))
     * _ES_SunHaloColor) * 50.0) * variationClouds_12) * xlv_TEXCOORD5.z)
  ) + (
    ((variationClouds_12 * 0.5) * xlv_TEXCOORD9)
   * xlv_TEXCOORD5.x)) + (xlv_TEXCOORD8 * tmpvar_31));
  tmpvar_45.w = mix ((clamp (
    (filterBaseAlpha_10 * tmpvar_5)
  , 0.0, 1.0) * _ES_CloudOpacity), 1.0, (tmpvar_44 * (tmpvar_44 * 
    (3.0 - (2.0 * tmpvar_44))
  )));
  highp float wispyOpacity_46;
  lowp float tmpvar_47;
  tmpvar_47 = texture2D (_CloudWispsTex, xlv_TEXCOORD3.zw).w;
  wispyOpacity_46 = tmpvar_47;
  mediump float value_48;
  value_48 = wispyOpacity_46;
  mediump float low_49;
  low_49 = (1.0 - _ES_CloudWispsCoverage);
  mediump float tmpvar_50;
  tmpvar_50 = clamp (((value_48 - low_49) / (1.0 - low_49)), 0.0, 1.0);
  wispyOpacity_46 = (tmpvar_50 * _ES_CloudWispsOpacity);
  highp vec4 tmpvar_51;
  tmpvar_51.xyz = mix (xlv_TEXCOORD9, xlv_TEXCOORD10, vec3(wispyOpacity_46));
  tmpvar_51.w = wispyOpacity_46;
  cloudWisps_2 = tmpvar_51;
  finalCol_1.w = 0.0;
  finalCol_1.xyz = mix ((cloudWisps_2.xyz * cloudWisps_2.w), tmpvar_45.xyz, tmpvar_45.www);
  finalCol_1.xyz = (finalCol_1.xyz * ((xlv_TEXCOORD5.w * _ES_CloudSunBrightenIntensity) + 1.0));
  finalCol_1.w = tmpvar_45.w;
  gl_FragData[0] = finalCol_1;
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
Keywords { "SHOW_WEATHERMAP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SHOW_WEATHERMAP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SHOW_WEATHERMAP" }
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
Keywords { "FOG_LERP" "SHOW_WEATHERMAP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "SHOW_WEATHERMAP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "SHOW_WEATHERMAP" }
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
Keywords { "FOG_HEIGHT" "SHOW_WEATHERMAP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "SHOW_WEATHERMAP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "SHOW_WEATHERMAP" }
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
Keywords { "FOG_HEIGHT" "FOG_LERP" "SHOW_WEATHERMAP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "SHOW_WEATHERMAP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "SHOW_WEATHERMAP" }
""
}
}
}
}
}