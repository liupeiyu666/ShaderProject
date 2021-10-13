//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Dynamic Sky/Cloud Particle" {
Properties {
[Header(Cloud Maps)] _SkyGradientTex ("Sky Gradient Tex", 2D) = "white" { }
_CloudParticleAtlas ("Cloud Particle Atlas", 2D) = "white" { }
[Header(Cloud Curl)] _CloudCurlTex ("Cloud Curl Tex", 2D) = "white" { }
_CloudCurlTiling ("Cloud Curl Tiling", Range(0, 30)) = 10
_CloudCurlAmplitude ("Cloud Curl Amplitude", Range(0, 0.02)) = 0.01
_CloudCurlSpeed ("Cloud Curl Speed", Range(0, 50)) = 20
[Header(Debug)] [Toggle(FIXED_SPRITE_ID)] _UseFixedSpriteId ("Fixed Sprite ID?", Float) = 0
_FixedSpriteId ("Sprite ID", Float) = 0
[Toggle(FIXED_EDGE_SMOOTHNESS)] _UseFixedEdgeSmoothness ("Fixed Edge Smoothness?", Float) = 0
_FixedEdgeSmoothness ("Fixed Edge Smoothness", Range(0, 1)) = 0.1
[Toggle(FIXED_RIMLIGHT_WIDTH)] _UseFixedRimLightWidth ("Fixed Rimlight Width?", Float) = 0
_FixedRimLightWidth ("Fixed Rimlight Width", Range(0, 1)) = 0.1
}
SubShader {
 Tags { "QUEUE" = "Background" "RenderType" = "Transparent" }
 Pass {
  Tags { "QUEUE" = "Background" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 2604
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec4 _ES_TopFrontColor;
uniform mediump vec4 _ES_TopBackColor;
uniform mediump vec4 _ES_BottomFrontColor;
uniform mediump vec4 _ES_BottomBackColor;
uniform mediump float _ES_SkyFrontAndBackBlendFactor;
uniform mediump float _ES_BottomColorHeight;
uniform mediump vec3 _ES_HorizonHaloColor;
uniform mediump float _ES_HorizonHaloIntensity;
uniform mediump float _ES_HorizonHaloHeight;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump float _ES_SunHaloSize;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudAgePercent;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform sampler2D _SkyGradientTex;
uniform highp vec2 _AtlasTiles;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  mediump float agePercent_3;
  highp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec4 clipPos_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  clipPos_7.xyw = tmpvar_8.xyw;
  clipPos_7.z = tmpvar_8.w;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8.xyww * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = clipPos_7.zw;
  highp int tmpvar_13;
  tmpvar_13 = int(floor((
    (_glesColor.y * ((_AtlasTiles.x * _AtlasTiles.y) - 1.0))
   + 0.5)));
  highp vec2 tmpvar_14;
  tmpvar_14.x = (float(mod (float(tmpvar_13), _AtlasTiles.x)));
  tmpvar_14.y = floor((float(tmpvar_13) / _AtlasTiles.x));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy + tmpvar_14) / _AtlasTiles);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _CloudCurlTiling) + ((_ES_CloudElapsedTime * vec2(1.2, 0.8)) * _CloudCurlSpeed));
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
  mediump float tmpvar_20;
  tmpvar_20 = dot (viewDir_15, _ES_SunDirection);
  mediump float tmpvar_21;
  tmpvar_21 = ((tmpvar_20 * 0.5) + 0.5);
  tmpvar_5.x = (tmpvar_21 * _ES_CloudSunBrightenIntensity);
  tmpvar_5.y = tmpvar_2.z;
  tmpvar_5.z = tmpvar_2.w;
  highp float tmpvar_22;
  tmpvar_22 = (_glesMultiTexCoord1.y / max (_glesMultiTexCoord1.x, 1e-05));
  agePercent_3 = tmpvar_22;
  agePercent_3 = (agePercent_3 * _ES_CloudAgePercent);
  highp float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = clamp ((agePercent_3 / _glesMultiTexCoord1.z), 0.0, 1.0);
  tmpvar_23 = (tmpvar_24 * (tmpvar_24 * (3.0 - 
    (2.0 * tmpvar_24)
  )));
  highp float tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = clamp (((agePercent_3 - _glesMultiTexCoord1.w) / (1.0 - _glesMultiTexCoord1.w)), 0.0, 1.0);
  tmpvar_25 = (tmpvar_26 * (tmpvar_26 * (3.0 - 
    (2.0 * tmpvar_26)
  )));
  tmpvar_5.w = (1.0 - (tmpvar_23 * (1.0 - tmpvar_25)));
  mediump vec3 atomosphere_27;
  mediump float tmpvar_28;
  tmpvar_28 = dot (_ES_SunDirection, viewDir_15);
  mediump float tmpvar_29;
  tmpvar_29 = max (((tmpvar_28 * _ES_SkyFrontAndBackBlendFactor) + (1.0 - _ES_SkyFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_30;
  tmpvar_30 = ((tmpvar_29 * tmpvar_29) * tmpvar_29);
  mediump vec4 tmpvar_31;
  tmpvar_31.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_31.x = (abs(tmpvar_19.w) / max (_ES_BottomColorHeight, 0.0001));
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DLod (_SkyGradientTex, tmpvar_31.xy, 0.0);
  mediump float tmpvar_33;
  tmpvar_33 = tmpvar_32.x;
  atomosphere_27 = mix (mix (_ES_TopBackColor, _ES_TopFrontColor, vec4(tmpvar_30)).xyz, mix (_ES_BottomBackColor, _ES_BottomFrontColor, vec4(tmpvar_30)).xyz, vec3(tmpvar_33));
  mediump vec4 tmpvar_34;
  tmpvar_34.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_34.x = (abs(tmpvar_19.w) / max (_ES_HorizonHaloHeight, 0.0001));
  lowp vec4 tmpvar_35;
  tmpvar_35 = texture2DLod (_SkyGradientTex, tmpvar_34.xy, 0.0);
  mediump float tmpvar_36;
  tmpvar_36 = tmpvar_35.y;
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    max (((tmpvar_28 * 0.5) + 0.5), 0.0)
   - 0.3) / 0.7), 0.0, 1.0);
  mediump float tmpvar_38;
  tmpvar_38 = clamp (((
    abs(_ES_SunDirection.y)
   - 0.2) / 0.3), 0.0, 1.0);
  atomosphere_27 = (atomosphere_27 + ((
    (_ES_HorizonHaloColor * _ES_HorizonHaloIntensity)
   * tmpvar_36) * mix (
    (tmpvar_37 * (tmpvar_37 * (3.0 - (2.0 * tmpvar_37))))
  , 1.0, 
    (tmpvar_38 * (tmpvar_38 * (3.0 - (2.0 * tmpvar_38))))
  )));
  highp vec3 viewDir_39;
  viewDir_39 = tmpvar_19.xyz;
  highp float haloInfluence_40;
  mediump float vertical_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((
    dot (_ES_SunDirection, viewDir_39)
   * 0.5) + 0.5), 0.0, 1.0);
  highp float tmpvar_43;
  tmpvar_43 = dot (viewDir_39, _ES_SkyWorldUpDir);
  vertical_41 = tmpvar_43;
  mediump float tmpvar_44;
  tmpvar_44 = abs(vertical_41);
  mediump float y_45;
  y_45 = (_ES_SunHaloSize * tmpvar_44);
  mediump float y_46;
  y_46 = ((_ES_SunHaloSize * 0.1) * tmpvar_44);
  haloInfluence_40 = (clamp (pow (tmpvar_42, y_45), 0.0, 1.0) + (clamp (
    pow (tmpvar_42, y_46)
  , 0.0, 1.0) * 0.12));
  mediump float y_47;
  y_47 = ((_ES_SunHaloSize * 0.01) * tmpvar_44);
  haloInfluence_40 = (haloInfluence_40 + (clamp (
    pow (tmpvar_42, y_47)
  , 0.0, 1.0) * 0.03));
  highp float tmpvar_48;
  tmpvar_48 = clamp (((
    max (((dot (_ES_SunDirection, viewDir_39) * 0.5) + 0.5), 0.0)
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 tmpvar_49;
  tmpvar_49 = (((haloInfluence_40 * _ES_SunHaloIntensity) * _ES_SunHaloColor) * (tmpvar_48 * (tmpvar_48 * 
    (3.0 - (2.0 * tmpvar_48))
  )));
  tmpvar_6 = (atomosphere_27 + tmpvar_49);
  mediump float tmpvar_50;
  mediump float tmpvar_51;
  tmpvar_51 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_50 = (tmpvar_51 * (tmpvar_51 * (3.0 - 
    (2.0 * tmpvar_51)
  )));
  highp vec3 viewDir_52;
  viewDir_52 = tmpvar_19.xyz;
  mediump float moonLunarCancel_53;
  mediump float tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = clamp (dot (_ES_MoonDirection, viewDir_52), 0.0, 1.0);
  tmpvar_54 = tmpvar_55;
  highp float tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_56 = (1.0 - (tmpvar_57 * 2.0));
  moonLunarCancel_53 = tmpvar_56;
  mediump float tmpvar_58;
  tmpvar_58 = clamp (((
    ((tmpvar_54 * tmpvar_54) * ((tmpvar_54 * tmpvar_54) * tmpvar_54))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_59;
  viewDir_59 = tmpvar_19.xyz;
  mediump float vertical_60;
  mediump float tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = clamp (((
    dot (_ES_SunDirection, viewDir_59)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_61 = tmpvar_62;
  highp float tmpvar_63;
  tmpvar_63 = dot (viewDir_59, _ES_SkyWorldUpDir);
  vertical_60 = tmpvar_63;
  mediump float tmpvar_64;
  mediump float tmpvar_65;
  tmpvar_65 = (1.0 - _ES_SunRimLightRadius);
  tmpvar_64 = clamp (((tmpvar_21 - _ES_SunRimLightRadius) / tmpvar_65), 0.0, 1.0);
  mediump float tmpvar_66;
  tmpvar_66 = (((tmpvar_64 * 
    (tmpvar_64 * (3.0 - (2.0 * tmpvar_64)))
  ) * _ES_SunBrightness) * 0.125);
  mediump float tmpvar_67;
  tmpvar_67 = clamp (((
    ((dot (viewDir_15, _ES_MoonDirection) * 0.5) + 0.5)
   - _ES_SunRimLightRadius) / tmpvar_65), 0.0, 1.0);
  mediump float tmpvar_68;
  tmpvar_68 = (((tmpvar_67 * 
    (tmpvar_67 * (3.0 - (2.0 * tmpvar_67)))
  ) * _ES_MoonBrightness) * 0.1);
  mediump float tmpvar_69;
  tmpvar_69 = max (((tmpvar_20 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_70;
  tmpvar_70 = ((tmpvar_69 * tmpvar_69) * tmpvar_69);
  gl_Position = clipPos_7;
  xlv_TEXCOORD0 = o_10;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_19;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = (((
    ((((tmpvar_58 * 
      (tmpvar_58 * (3.0 - (2.0 * tmpvar_58)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_53) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_61, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_60))
    ) * vertical_60), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_50);
  xlv_TEXCOORD6 = (((_ES_SunHaloColor * 
    (tmpvar_66 * tmpvar_66)
  ) + (_ES_MoonColor * 
    (tmpvar_68 * tmpvar_68)
  )) * tmpvar_50);
  xlv_TEXCOORD7 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_70));
  xlv_TEXCOORD8 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_70));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_CloudCoverage;
uniform sampler2D _CloudParticleAtlas;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 cloudCol_1;
  mediump vec4 texCol_2;
  highp vec3 curlNoise_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_CloudCurlTex, xlv_TEXCOORD1.zw).xyz;
  curlNoise_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD1.xy + ((
    (curlNoise_3.xy - 0.5)
   * curlNoise_3.z) * _CloudCurlAmplitude));
  tmpvar_5 = texture2D (_CloudParticleAtlas, P_6);
  texCol_2 = tmpvar_5;
  mediump float tmpvar_7;
  tmpvar_7 = max ((xlv_TEXCOORD3.w - xlv_TEXCOORD3.y), 0.0);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.y), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD2.w - -0.1) / 0.2), 0.0, 1.0);
  cloudCol_1.w = ((texCol_2.w * (tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  )) * (tmpvar_9 * (tmpvar_9 * 
    (3.0 - (2.0 * tmpvar_9))
  )));
  mediump float x_10;
  x_10 = (cloudCol_1.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.z), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  cloudCol_1.xyz = ((mix (xlv_TEXCOORD8, xlv_TEXCOORD7, texCol_2.xxx) + (xlv_TEXCOORD6 * 
    mix (texCol_2.y, ((1.0 - (tmpvar_11 * 
      (tmpvar_11 * (3.0 - (2.0 * tmpvar_11)))
    )) * 4.0), xlv_TEXCOORD3.w)
  )) + ((0.4 * xlv_TEXCOORD7) * _ES_CloudCoverage));
  cloudCol_1.xyz = (cloudCol_1.xyz + (xlv_TEXCOORD5 * texCol_2.x));
  cloudCol_1.xyz = (cloudCol_1.xyz * (xlv_TEXCOORD3.x + 1.0));
  mediump float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD2.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((_ES_CloudCoverage - 0.4) / 0.3), 0.0, 1.0);
  cloudCol_1.xyz = mix (xlv_TEXCOORD4, cloudCol_1.xyz, vec3(mix (clamp (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
  , 0.0, 1.0), 1.0, (tmpvar_13 * 
    (tmpvar_13 * (3.0 - (2.0 * tmpvar_13)))
  ))));
  cloudCol_1.w = clamp (cloudCol_1.w, 0.0, 1.0);
  gl_FragData[0] = cloudCol_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec4 _ES_TopFrontColor;
uniform mediump vec4 _ES_TopBackColor;
uniform mediump vec4 _ES_BottomFrontColor;
uniform mediump vec4 _ES_BottomBackColor;
uniform mediump float _ES_SkyFrontAndBackBlendFactor;
uniform mediump float _ES_BottomColorHeight;
uniform mediump vec3 _ES_HorizonHaloColor;
uniform mediump float _ES_HorizonHaloIntensity;
uniform mediump float _ES_HorizonHaloHeight;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump float _ES_SunHaloSize;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudAgePercent;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform sampler2D _SkyGradientTex;
uniform highp vec2 _AtlasTiles;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  mediump float agePercent_3;
  highp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec4 clipPos_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  clipPos_7.xyw = tmpvar_8.xyw;
  clipPos_7.z = tmpvar_8.w;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8.xyww * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = clipPos_7.zw;
  highp int tmpvar_13;
  tmpvar_13 = int(floor((
    (_glesColor.y * ((_AtlasTiles.x * _AtlasTiles.y) - 1.0))
   + 0.5)));
  highp vec2 tmpvar_14;
  tmpvar_14.x = (float(mod (float(tmpvar_13), _AtlasTiles.x)));
  tmpvar_14.y = floor((float(tmpvar_13) / _AtlasTiles.x));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy + tmpvar_14) / _AtlasTiles);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _CloudCurlTiling) + ((_ES_CloudElapsedTime * vec2(1.2, 0.8)) * _CloudCurlSpeed));
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
  mediump float tmpvar_20;
  tmpvar_20 = dot (viewDir_15, _ES_SunDirection);
  mediump float tmpvar_21;
  tmpvar_21 = ((tmpvar_20 * 0.5) + 0.5);
  tmpvar_5.x = (tmpvar_21 * _ES_CloudSunBrightenIntensity);
  tmpvar_5.y = tmpvar_2.z;
  tmpvar_5.z = tmpvar_2.w;
  highp float tmpvar_22;
  tmpvar_22 = (_glesMultiTexCoord1.y / max (_glesMultiTexCoord1.x, 1e-05));
  agePercent_3 = tmpvar_22;
  agePercent_3 = (agePercent_3 * _ES_CloudAgePercent);
  highp float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = clamp ((agePercent_3 / _glesMultiTexCoord1.z), 0.0, 1.0);
  tmpvar_23 = (tmpvar_24 * (tmpvar_24 * (3.0 - 
    (2.0 * tmpvar_24)
  )));
  highp float tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = clamp (((agePercent_3 - _glesMultiTexCoord1.w) / (1.0 - _glesMultiTexCoord1.w)), 0.0, 1.0);
  tmpvar_25 = (tmpvar_26 * (tmpvar_26 * (3.0 - 
    (2.0 * tmpvar_26)
  )));
  tmpvar_5.w = (1.0 - (tmpvar_23 * (1.0 - tmpvar_25)));
  mediump vec3 atomosphere_27;
  mediump float tmpvar_28;
  tmpvar_28 = dot (_ES_SunDirection, viewDir_15);
  mediump float tmpvar_29;
  tmpvar_29 = max (((tmpvar_28 * _ES_SkyFrontAndBackBlendFactor) + (1.0 - _ES_SkyFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_30;
  tmpvar_30 = ((tmpvar_29 * tmpvar_29) * tmpvar_29);
  mediump vec4 tmpvar_31;
  tmpvar_31.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_31.x = (abs(tmpvar_19.w) / max (_ES_BottomColorHeight, 0.0001));
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DLod (_SkyGradientTex, tmpvar_31.xy, 0.0);
  mediump float tmpvar_33;
  tmpvar_33 = tmpvar_32.x;
  atomosphere_27 = mix (mix (_ES_TopBackColor, _ES_TopFrontColor, vec4(tmpvar_30)).xyz, mix (_ES_BottomBackColor, _ES_BottomFrontColor, vec4(tmpvar_30)).xyz, vec3(tmpvar_33));
  mediump vec4 tmpvar_34;
  tmpvar_34.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_34.x = (abs(tmpvar_19.w) / max (_ES_HorizonHaloHeight, 0.0001));
  lowp vec4 tmpvar_35;
  tmpvar_35 = texture2DLod (_SkyGradientTex, tmpvar_34.xy, 0.0);
  mediump float tmpvar_36;
  tmpvar_36 = tmpvar_35.y;
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    max (((tmpvar_28 * 0.5) + 0.5), 0.0)
   - 0.3) / 0.7), 0.0, 1.0);
  mediump float tmpvar_38;
  tmpvar_38 = clamp (((
    abs(_ES_SunDirection.y)
   - 0.2) / 0.3), 0.0, 1.0);
  atomosphere_27 = (atomosphere_27 + ((
    (_ES_HorizonHaloColor * _ES_HorizonHaloIntensity)
   * tmpvar_36) * mix (
    (tmpvar_37 * (tmpvar_37 * (3.0 - (2.0 * tmpvar_37))))
  , 1.0, 
    (tmpvar_38 * (tmpvar_38 * (3.0 - (2.0 * tmpvar_38))))
  )));
  highp vec3 viewDir_39;
  viewDir_39 = tmpvar_19.xyz;
  highp float haloInfluence_40;
  mediump float vertical_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((
    dot (_ES_SunDirection, viewDir_39)
   * 0.5) + 0.5), 0.0, 1.0);
  highp float tmpvar_43;
  tmpvar_43 = dot (viewDir_39, _ES_SkyWorldUpDir);
  vertical_41 = tmpvar_43;
  mediump float tmpvar_44;
  tmpvar_44 = abs(vertical_41);
  mediump float y_45;
  y_45 = (_ES_SunHaloSize * tmpvar_44);
  mediump float y_46;
  y_46 = ((_ES_SunHaloSize * 0.1) * tmpvar_44);
  haloInfluence_40 = (clamp (pow (tmpvar_42, y_45), 0.0, 1.0) + (clamp (
    pow (tmpvar_42, y_46)
  , 0.0, 1.0) * 0.12));
  mediump float y_47;
  y_47 = ((_ES_SunHaloSize * 0.01) * tmpvar_44);
  haloInfluence_40 = (haloInfluence_40 + (clamp (
    pow (tmpvar_42, y_47)
  , 0.0, 1.0) * 0.03));
  highp float tmpvar_48;
  tmpvar_48 = clamp (((
    max (((dot (_ES_SunDirection, viewDir_39) * 0.5) + 0.5), 0.0)
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 tmpvar_49;
  tmpvar_49 = (((haloInfluence_40 * _ES_SunHaloIntensity) * _ES_SunHaloColor) * (tmpvar_48 * (tmpvar_48 * 
    (3.0 - (2.0 * tmpvar_48))
  )));
  tmpvar_6 = (atomosphere_27 + tmpvar_49);
  mediump float tmpvar_50;
  mediump float tmpvar_51;
  tmpvar_51 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_50 = (tmpvar_51 * (tmpvar_51 * (3.0 - 
    (2.0 * tmpvar_51)
  )));
  highp vec3 viewDir_52;
  viewDir_52 = tmpvar_19.xyz;
  mediump float moonLunarCancel_53;
  mediump float tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = clamp (dot (_ES_MoonDirection, viewDir_52), 0.0, 1.0);
  tmpvar_54 = tmpvar_55;
  highp float tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_56 = (1.0 - (tmpvar_57 * 2.0));
  moonLunarCancel_53 = tmpvar_56;
  mediump float tmpvar_58;
  tmpvar_58 = clamp (((
    ((tmpvar_54 * tmpvar_54) * ((tmpvar_54 * tmpvar_54) * tmpvar_54))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_59;
  viewDir_59 = tmpvar_19.xyz;
  mediump float vertical_60;
  mediump float tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = clamp (((
    dot (_ES_SunDirection, viewDir_59)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_61 = tmpvar_62;
  highp float tmpvar_63;
  tmpvar_63 = dot (viewDir_59, _ES_SkyWorldUpDir);
  vertical_60 = tmpvar_63;
  mediump float tmpvar_64;
  mediump float tmpvar_65;
  tmpvar_65 = (1.0 - _ES_SunRimLightRadius);
  tmpvar_64 = clamp (((tmpvar_21 - _ES_SunRimLightRadius) / tmpvar_65), 0.0, 1.0);
  mediump float tmpvar_66;
  tmpvar_66 = (((tmpvar_64 * 
    (tmpvar_64 * (3.0 - (2.0 * tmpvar_64)))
  ) * _ES_SunBrightness) * 0.125);
  mediump float tmpvar_67;
  tmpvar_67 = clamp (((
    ((dot (viewDir_15, _ES_MoonDirection) * 0.5) + 0.5)
   - _ES_SunRimLightRadius) / tmpvar_65), 0.0, 1.0);
  mediump float tmpvar_68;
  tmpvar_68 = (((tmpvar_67 * 
    (tmpvar_67 * (3.0 - (2.0 * tmpvar_67)))
  ) * _ES_MoonBrightness) * 0.1);
  mediump float tmpvar_69;
  tmpvar_69 = max (((tmpvar_20 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_70;
  tmpvar_70 = ((tmpvar_69 * tmpvar_69) * tmpvar_69);
  gl_Position = clipPos_7;
  xlv_TEXCOORD0 = o_10;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_19;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = (((
    ((((tmpvar_58 * 
      (tmpvar_58 * (3.0 - (2.0 * tmpvar_58)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_53) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_61, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_60))
    ) * vertical_60), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_50);
  xlv_TEXCOORD6 = (((_ES_SunHaloColor * 
    (tmpvar_66 * tmpvar_66)
  ) + (_ES_MoonColor * 
    (tmpvar_68 * tmpvar_68)
  )) * tmpvar_50);
  xlv_TEXCOORD7 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_70));
  xlv_TEXCOORD8 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_70));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_CloudCoverage;
uniform sampler2D _CloudParticleAtlas;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 cloudCol_1;
  mediump vec4 texCol_2;
  highp vec3 curlNoise_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_CloudCurlTex, xlv_TEXCOORD1.zw).xyz;
  curlNoise_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD1.xy + ((
    (curlNoise_3.xy - 0.5)
   * curlNoise_3.z) * _CloudCurlAmplitude));
  tmpvar_5 = texture2D (_CloudParticleAtlas, P_6);
  texCol_2 = tmpvar_5;
  mediump float tmpvar_7;
  tmpvar_7 = max ((xlv_TEXCOORD3.w - xlv_TEXCOORD3.y), 0.0);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.y), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD2.w - -0.1) / 0.2), 0.0, 1.0);
  cloudCol_1.w = ((texCol_2.w * (tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  )) * (tmpvar_9 * (tmpvar_9 * 
    (3.0 - (2.0 * tmpvar_9))
  )));
  mediump float x_10;
  x_10 = (cloudCol_1.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.z), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  cloudCol_1.xyz = ((mix (xlv_TEXCOORD8, xlv_TEXCOORD7, texCol_2.xxx) + (xlv_TEXCOORD6 * 
    mix (texCol_2.y, ((1.0 - (tmpvar_11 * 
      (tmpvar_11 * (3.0 - (2.0 * tmpvar_11)))
    )) * 4.0), xlv_TEXCOORD3.w)
  )) + ((0.4 * xlv_TEXCOORD7) * _ES_CloudCoverage));
  cloudCol_1.xyz = (cloudCol_1.xyz + (xlv_TEXCOORD5 * texCol_2.x));
  cloudCol_1.xyz = (cloudCol_1.xyz * (xlv_TEXCOORD3.x + 1.0));
  mediump float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD2.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((_ES_CloudCoverage - 0.4) / 0.3), 0.0, 1.0);
  cloudCol_1.xyz = mix (xlv_TEXCOORD4, cloudCol_1.xyz, vec3(mix (clamp (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
  , 0.0, 1.0), 1.0, (tmpvar_13 * 
    (tmpvar_13 * (3.0 - (2.0 * tmpvar_13)))
  ))));
  cloudCol_1.w = clamp (cloudCol_1.w, 0.0, 1.0);
  gl_FragData[0] = cloudCol_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec4 _ES_TopFrontColor;
uniform mediump vec4 _ES_TopBackColor;
uniform mediump vec4 _ES_BottomFrontColor;
uniform mediump vec4 _ES_BottomBackColor;
uniform mediump float _ES_SkyFrontAndBackBlendFactor;
uniform mediump float _ES_BottomColorHeight;
uniform mediump vec3 _ES_HorizonHaloColor;
uniform mediump float _ES_HorizonHaloIntensity;
uniform mediump float _ES_HorizonHaloHeight;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump float _ES_SunHaloSize;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudAgePercent;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform sampler2D _SkyGradientTex;
uniform highp vec2 _AtlasTiles;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  mediump float agePercent_3;
  highp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec4 clipPos_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  clipPos_7.xyw = tmpvar_8.xyw;
  clipPos_7.z = tmpvar_8.w;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8.xyww * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = clipPos_7.zw;
  highp int tmpvar_13;
  tmpvar_13 = int(floor((
    (_glesColor.y * ((_AtlasTiles.x * _AtlasTiles.y) - 1.0))
   + 0.5)));
  highp vec2 tmpvar_14;
  tmpvar_14.x = (float(mod (float(tmpvar_13), _AtlasTiles.x)));
  tmpvar_14.y = floor((float(tmpvar_13) / _AtlasTiles.x));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy + tmpvar_14) / _AtlasTiles);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _CloudCurlTiling) + ((_ES_CloudElapsedTime * vec2(1.2, 0.8)) * _CloudCurlSpeed));
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
  mediump float tmpvar_20;
  tmpvar_20 = dot (viewDir_15, _ES_SunDirection);
  mediump float tmpvar_21;
  tmpvar_21 = ((tmpvar_20 * 0.5) + 0.5);
  tmpvar_5.x = (tmpvar_21 * _ES_CloudSunBrightenIntensity);
  tmpvar_5.y = tmpvar_2.z;
  tmpvar_5.z = tmpvar_2.w;
  highp float tmpvar_22;
  tmpvar_22 = (_glesMultiTexCoord1.y / max (_glesMultiTexCoord1.x, 1e-05));
  agePercent_3 = tmpvar_22;
  agePercent_3 = (agePercent_3 * _ES_CloudAgePercent);
  highp float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = clamp ((agePercent_3 / _glesMultiTexCoord1.z), 0.0, 1.0);
  tmpvar_23 = (tmpvar_24 * (tmpvar_24 * (3.0 - 
    (2.0 * tmpvar_24)
  )));
  highp float tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = clamp (((agePercent_3 - _glesMultiTexCoord1.w) / (1.0 - _glesMultiTexCoord1.w)), 0.0, 1.0);
  tmpvar_25 = (tmpvar_26 * (tmpvar_26 * (3.0 - 
    (2.0 * tmpvar_26)
  )));
  tmpvar_5.w = (1.0 - (tmpvar_23 * (1.0 - tmpvar_25)));
  mediump vec3 atomosphere_27;
  mediump float tmpvar_28;
  tmpvar_28 = dot (_ES_SunDirection, viewDir_15);
  mediump float tmpvar_29;
  tmpvar_29 = max (((tmpvar_28 * _ES_SkyFrontAndBackBlendFactor) + (1.0 - _ES_SkyFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_30;
  tmpvar_30 = ((tmpvar_29 * tmpvar_29) * tmpvar_29);
  mediump vec4 tmpvar_31;
  tmpvar_31.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_31.x = (abs(tmpvar_19.w) / max (_ES_BottomColorHeight, 0.0001));
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DLod (_SkyGradientTex, tmpvar_31.xy, 0.0);
  mediump float tmpvar_33;
  tmpvar_33 = tmpvar_32.x;
  atomosphere_27 = mix (mix (_ES_TopBackColor, _ES_TopFrontColor, vec4(tmpvar_30)).xyz, mix (_ES_BottomBackColor, _ES_BottomFrontColor, vec4(tmpvar_30)).xyz, vec3(tmpvar_33));
  mediump vec4 tmpvar_34;
  tmpvar_34.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_34.x = (abs(tmpvar_19.w) / max (_ES_HorizonHaloHeight, 0.0001));
  lowp vec4 tmpvar_35;
  tmpvar_35 = texture2DLod (_SkyGradientTex, tmpvar_34.xy, 0.0);
  mediump float tmpvar_36;
  tmpvar_36 = tmpvar_35.y;
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    max (((tmpvar_28 * 0.5) + 0.5), 0.0)
   - 0.3) / 0.7), 0.0, 1.0);
  mediump float tmpvar_38;
  tmpvar_38 = clamp (((
    abs(_ES_SunDirection.y)
   - 0.2) / 0.3), 0.0, 1.0);
  atomosphere_27 = (atomosphere_27 + ((
    (_ES_HorizonHaloColor * _ES_HorizonHaloIntensity)
   * tmpvar_36) * mix (
    (tmpvar_37 * (tmpvar_37 * (3.0 - (2.0 * tmpvar_37))))
  , 1.0, 
    (tmpvar_38 * (tmpvar_38 * (3.0 - (2.0 * tmpvar_38))))
  )));
  highp vec3 viewDir_39;
  viewDir_39 = tmpvar_19.xyz;
  highp float haloInfluence_40;
  mediump float vertical_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((
    dot (_ES_SunDirection, viewDir_39)
   * 0.5) + 0.5), 0.0, 1.0);
  highp float tmpvar_43;
  tmpvar_43 = dot (viewDir_39, _ES_SkyWorldUpDir);
  vertical_41 = tmpvar_43;
  mediump float tmpvar_44;
  tmpvar_44 = abs(vertical_41);
  mediump float y_45;
  y_45 = (_ES_SunHaloSize * tmpvar_44);
  mediump float y_46;
  y_46 = ((_ES_SunHaloSize * 0.1) * tmpvar_44);
  haloInfluence_40 = (clamp (pow (tmpvar_42, y_45), 0.0, 1.0) + (clamp (
    pow (tmpvar_42, y_46)
  , 0.0, 1.0) * 0.12));
  mediump float y_47;
  y_47 = ((_ES_SunHaloSize * 0.01) * tmpvar_44);
  haloInfluence_40 = (haloInfluence_40 + (clamp (
    pow (tmpvar_42, y_47)
  , 0.0, 1.0) * 0.03));
  highp float tmpvar_48;
  tmpvar_48 = clamp (((
    max (((dot (_ES_SunDirection, viewDir_39) * 0.5) + 0.5), 0.0)
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 tmpvar_49;
  tmpvar_49 = (((haloInfluence_40 * _ES_SunHaloIntensity) * _ES_SunHaloColor) * (tmpvar_48 * (tmpvar_48 * 
    (3.0 - (2.0 * tmpvar_48))
  )));
  tmpvar_6 = (atomosphere_27 + tmpvar_49);
  mediump float tmpvar_50;
  mediump float tmpvar_51;
  tmpvar_51 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_50 = (tmpvar_51 * (tmpvar_51 * (3.0 - 
    (2.0 * tmpvar_51)
  )));
  highp vec3 viewDir_52;
  viewDir_52 = tmpvar_19.xyz;
  mediump float moonLunarCancel_53;
  mediump float tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = clamp (dot (_ES_MoonDirection, viewDir_52), 0.0, 1.0);
  tmpvar_54 = tmpvar_55;
  highp float tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_56 = (1.0 - (tmpvar_57 * 2.0));
  moonLunarCancel_53 = tmpvar_56;
  mediump float tmpvar_58;
  tmpvar_58 = clamp (((
    ((tmpvar_54 * tmpvar_54) * ((tmpvar_54 * tmpvar_54) * tmpvar_54))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_59;
  viewDir_59 = tmpvar_19.xyz;
  mediump float vertical_60;
  mediump float tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = clamp (((
    dot (_ES_SunDirection, viewDir_59)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_61 = tmpvar_62;
  highp float tmpvar_63;
  tmpvar_63 = dot (viewDir_59, _ES_SkyWorldUpDir);
  vertical_60 = tmpvar_63;
  mediump float tmpvar_64;
  mediump float tmpvar_65;
  tmpvar_65 = (1.0 - _ES_SunRimLightRadius);
  tmpvar_64 = clamp (((tmpvar_21 - _ES_SunRimLightRadius) / tmpvar_65), 0.0, 1.0);
  mediump float tmpvar_66;
  tmpvar_66 = (((tmpvar_64 * 
    (tmpvar_64 * (3.0 - (2.0 * tmpvar_64)))
  ) * _ES_SunBrightness) * 0.125);
  mediump float tmpvar_67;
  tmpvar_67 = clamp (((
    ((dot (viewDir_15, _ES_MoonDirection) * 0.5) + 0.5)
   - _ES_SunRimLightRadius) / tmpvar_65), 0.0, 1.0);
  mediump float tmpvar_68;
  tmpvar_68 = (((tmpvar_67 * 
    (tmpvar_67 * (3.0 - (2.0 * tmpvar_67)))
  ) * _ES_MoonBrightness) * 0.1);
  mediump float tmpvar_69;
  tmpvar_69 = max (((tmpvar_20 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_70;
  tmpvar_70 = ((tmpvar_69 * tmpvar_69) * tmpvar_69);
  gl_Position = clipPos_7;
  xlv_TEXCOORD0 = o_10;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_19;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = (((
    ((((tmpvar_58 * 
      (tmpvar_58 * (3.0 - (2.0 * tmpvar_58)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_53) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_61, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_60))
    ) * vertical_60), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_50);
  xlv_TEXCOORD6 = (((_ES_SunHaloColor * 
    (tmpvar_66 * tmpvar_66)
  ) + (_ES_MoonColor * 
    (tmpvar_68 * tmpvar_68)
  )) * tmpvar_50);
  xlv_TEXCOORD7 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_70));
  xlv_TEXCOORD8 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_70));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_CloudCoverage;
uniform sampler2D _CloudParticleAtlas;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 cloudCol_1;
  mediump vec4 texCol_2;
  highp vec3 curlNoise_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_CloudCurlTex, xlv_TEXCOORD1.zw).xyz;
  curlNoise_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD1.xy + ((
    (curlNoise_3.xy - 0.5)
   * curlNoise_3.z) * _CloudCurlAmplitude));
  tmpvar_5 = texture2D (_CloudParticleAtlas, P_6);
  texCol_2 = tmpvar_5;
  mediump float tmpvar_7;
  tmpvar_7 = max ((xlv_TEXCOORD3.w - xlv_TEXCOORD3.y), 0.0);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.y), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD2.w - -0.1) / 0.2), 0.0, 1.0);
  cloudCol_1.w = ((texCol_2.w * (tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  )) * (tmpvar_9 * (tmpvar_9 * 
    (3.0 - (2.0 * tmpvar_9))
  )));
  mediump float x_10;
  x_10 = (cloudCol_1.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.z), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  cloudCol_1.xyz = ((mix (xlv_TEXCOORD8, xlv_TEXCOORD7, texCol_2.xxx) + (xlv_TEXCOORD6 * 
    mix (texCol_2.y, ((1.0 - (tmpvar_11 * 
      (tmpvar_11 * (3.0 - (2.0 * tmpvar_11)))
    )) * 4.0), xlv_TEXCOORD3.w)
  )) + ((0.4 * xlv_TEXCOORD7) * _ES_CloudCoverage));
  cloudCol_1.xyz = (cloudCol_1.xyz + (xlv_TEXCOORD5 * texCol_2.x));
  cloudCol_1.xyz = (cloudCol_1.xyz * (xlv_TEXCOORD3.x + 1.0));
  mediump float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD2.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((_ES_CloudCoverage - 0.4) / 0.3), 0.0, 1.0);
  cloudCol_1.xyz = mix (xlv_TEXCOORD4, cloudCol_1.xyz, vec3(mix (clamp (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
  , 0.0, 1.0), 1.0, (tmpvar_13 * 
    (tmpvar_13 * (3.0 - (2.0 * tmpvar_13)))
  ))));
  cloudCol_1.w = clamp (cloudCol_1.w, 0.0, 1.0);
  gl_FragData[0] = cloudCol_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec4 _ES_TopFrontColor;
uniform mediump vec4 _ES_TopBackColor;
uniform mediump vec4 _ES_BottomFrontColor;
uniform mediump vec4 _ES_BottomBackColor;
uniform mediump float _ES_SkyFrontAndBackBlendFactor;
uniform mediump float _ES_BottomColorHeight;
uniform mediump vec3 _ES_HorizonHaloColor;
uniform mediump float _ES_HorizonHaloIntensity;
uniform mediump float _ES_HorizonHaloHeight;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump float _ES_SunHaloSize;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudAgePercent;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform sampler2D _SkyGradientTex;
uniform highp vec2 _AtlasTiles;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  mediump float agePercent_3;
  highp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec4 clipPos_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  clipPos_7.xyw = tmpvar_8.xyw;
  clipPos_7.z = tmpvar_8.w;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8.xyww * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = clipPos_7.zw;
  highp int tmpvar_13;
  tmpvar_13 = int(floor((
    (_glesColor.y * ((_AtlasTiles.x * _AtlasTiles.y) - 1.0))
   + 0.5)));
  highp vec2 tmpvar_14;
  tmpvar_14.x = (float(mod (float(tmpvar_13), _AtlasTiles.x)));
  tmpvar_14.y = floor((float(tmpvar_13) / _AtlasTiles.x));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy + tmpvar_14) / _AtlasTiles);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _CloudCurlTiling) + ((_ES_CloudElapsedTime * vec2(1.2, 0.8)) * _CloudCurlSpeed));
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
  mediump float tmpvar_20;
  tmpvar_20 = dot (viewDir_15, _ES_SunDirection);
  mediump float tmpvar_21;
  tmpvar_21 = ((tmpvar_20 * 0.5) + 0.5);
  tmpvar_5.x = (tmpvar_21 * _ES_CloudSunBrightenIntensity);
  tmpvar_5.y = tmpvar_2.z;
  tmpvar_5.z = tmpvar_2.w;
  highp float tmpvar_22;
  tmpvar_22 = (_glesMultiTexCoord1.y / max (_glesMultiTexCoord1.x, 1e-05));
  agePercent_3 = tmpvar_22;
  agePercent_3 = (agePercent_3 * _ES_CloudAgePercent);
  highp float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = clamp ((agePercent_3 / _glesMultiTexCoord1.z), 0.0, 1.0);
  tmpvar_23 = (tmpvar_24 * (tmpvar_24 * (3.0 - 
    (2.0 * tmpvar_24)
  )));
  highp float tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = clamp (((agePercent_3 - _glesMultiTexCoord1.w) / (1.0 - _glesMultiTexCoord1.w)), 0.0, 1.0);
  tmpvar_25 = (tmpvar_26 * (tmpvar_26 * (3.0 - 
    (2.0 * tmpvar_26)
  )));
  tmpvar_5.w = (1.0 - (tmpvar_23 * (1.0 - tmpvar_25)));
  mediump vec3 atomosphere_27;
  mediump float tmpvar_28;
  tmpvar_28 = dot (_ES_SunDirection, viewDir_15);
  mediump float tmpvar_29;
  tmpvar_29 = max (((tmpvar_28 * _ES_SkyFrontAndBackBlendFactor) + (1.0 - _ES_SkyFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_30;
  tmpvar_30 = ((tmpvar_29 * tmpvar_29) * tmpvar_29);
  mediump vec4 tmpvar_31;
  tmpvar_31.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_31.x = (abs(tmpvar_19.w) / max (_ES_BottomColorHeight, 0.0001));
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DLod (_SkyGradientTex, tmpvar_31.xy, 0.0);
  mediump float tmpvar_33;
  tmpvar_33 = tmpvar_32.x;
  atomosphere_27 = mix (mix (_ES_TopBackColor, _ES_TopFrontColor, vec4(tmpvar_30)).xyz, mix (_ES_BottomBackColor, _ES_BottomFrontColor, vec4(tmpvar_30)).xyz, vec3(tmpvar_33));
  mediump vec4 tmpvar_34;
  tmpvar_34.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_34.x = (abs(tmpvar_19.w) / max (_ES_HorizonHaloHeight, 0.0001));
  lowp vec4 tmpvar_35;
  tmpvar_35 = texture2DLod (_SkyGradientTex, tmpvar_34.xy, 0.0);
  mediump float tmpvar_36;
  tmpvar_36 = tmpvar_35.y;
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    max (((tmpvar_28 * 0.5) + 0.5), 0.0)
   - 0.3) / 0.7), 0.0, 1.0);
  mediump float tmpvar_38;
  tmpvar_38 = clamp (((
    abs(_ES_SunDirection.y)
   - 0.2) / 0.3), 0.0, 1.0);
  atomosphere_27 = (atomosphere_27 + ((
    (_ES_HorizonHaloColor * _ES_HorizonHaloIntensity)
   * tmpvar_36) * mix (
    (tmpvar_37 * (tmpvar_37 * (3.0 - (2.0 * tmpvar_37))))
  , 1.0, 
    (tmpvar_38 * (tmpvar_38 * (3.0 - (2.0 * tmpvar_38))))
  )));
  highp vec3 viewDir_39;
  viewDir_39 = tmpvar_19.xyz;
  highp float haloInfluence_40;
  mediump float vertical_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((
    dot (_ES_SunDirection, viewDir_39)
   * 0.5) + 0.5), 0.0, 1.0);
  highp float tmpvar_43;
  tmpvar_43 = dot (viewDir_39, _ES_SkyWorldUpDir);
  vertical_41 = tmpvar_43;
  mediump float tmpvar_44;
  tmpvar_44 = abs(vertical_41);
  mediump float y_45;
  y_45 = (_ES_SunHaloSize * tmpvar_44);
  mediump float y_46;
  y_46 = ((_ES_SunHaloSize * 0.1) * tmpvar_44);
  haloInfluence_40 = (clamp (pow (tmpvar_42, y_45), 0.0, 1.0) + (clamp (
    pow (tmpvar_42, y_46)
  , 0.0, 1.0) * 0.12));
  mediump float y_47;
  y_47 = ((_ES_SunHaloSize * 0.01) * tmpvar_44);
  haloInfluence_40 = (haloInfluence_40 + (clamp (
    pow (tmpvar_42, y_47)
  , 0.0, 1.0) * 0.03));
  highp float tmpvar_48;
  tmpvar_48 = clamp (((
    max (((dot (_ES_SunDirection, viewDir_39) * 0.5) + 0.5), 0.0)
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 tmpvar_49;
  tmpvar_49 = (((haloInfluence_40 * _ES_SunHaloIntensity) * _ES_SunHaloColor) * (tmpvar_48 * (tmpvar_48 * 
    (3.0 - (2.0 * tmpvar_48))
  )));
  tmpvar_6 = (atomosphere_27 + tmpvar_49);
  mediump float tmpvar_50;
  mediump float tmpvar_51;
  tmpvar_51 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_50 = (tmpvar_51 * (tmpvar_51 * (3.0 - 
    (2.0 * tmpvar_51)
  )));
  highp vec3 viewDir_52;
  viewDir_52 = tmpvar_19.xyz;
  mediump float moonLunarCancel_53;
  mediump float tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = clamp (dot (_ES_MoonDirection, viewDir_52), 0.0, 1.0);
  tmpvar_54 = tmpvar_55;
  highp float tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_56 = (1.0 - (tmpvar_57 * 2.0));
  moonLunarCancel_53 = tmpvar_56;
  mediump float tmpvar_58;
  tmpvar_58 = clamp (((
    ((tmpvar_54 * tmpvar_54) * ((tmpvar_54 * tmpvar_54) * tmpvar_54))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_59;
  viewDir_59 = tmpvar_19.xyz;
  mediump float vertical_60;
  mediump float tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = clamp (((
    dot (_ES_SunDirection, viewDir_59)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_61 = tmpvar_62;
  highp float tmpvar_63;
  tmpvar_63 = dot (viewDir_59, _ES_SkyWorldUpDir);
  vertical_60 = tmpvar_63;
  mediump float tmpvar_64;
  mediump float tmpvar_65;
  tmpvar_65 = (1.0 - _ES_SunRimLightRadius);
  tmpvar_64 = clamp (((tmpvar_21 - _ES_SunRimLightRadius) / tmpvar_65), 0.0, 1.0);
  mediump float tmpvar_66;
  tmpvar_66 = (((tmpvar_64 * 
    (tmpvar_64 * (3.0 - (2.0 * tmpvar_64)))
  ) * _ES_SunBrightness) * 0.125);
  mediump float tmpvar_67;
  tmpvar_67 = clamp (((
    ((dot (viewDir_15, _ES_MoonDirection) * 0.5) + 0.5)
   - _ES_SunRimLightRadius) / tmpvar_65), 0.0, 1.0);
  mediump float tmpvar_68;
  tmpvar_68 = (((tmpvar_67 * 
    (tmpvar_67 * (3.0 - (2.0 * tmpvar_67)))
  ) * _ES_MoonBrightness) * 0.1);
  mediump float tmpvar_69;
  tmpvar_69 = max (((tmpvar_20 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_70;
  tmpvar_70 = ((tmpvar_69 * tmpvar_69) * tmpvar_69);
  gl_Position = clipPos_7;
  xlv_TEXCOORD0 = o_10;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_19;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = (((
    ((((tmpvar_58 * 
      (tmpvar_58 * (3.0 - (2.0 * tmpvar_58)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_53) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_61, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_60))
    ) * vertical_60), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_50);
  xlv_TEXCOORD6 = (((_ES_SunHaloColor * 
    (tmpvar_66 * tmpvar_66)
  ) + (_ES_MoonColor * 
    (tmpvar_68 * tmpvar_68)
  )) * tmpvar_50);
  xlv_TEXCOORD7 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_70));
  xlv_TEXCOORD8 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_70));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_CloudCoverage;
uniform sampler2D _CloudParticleAtlas;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 cloudCol_1;
  mediump vec4 texCol_2;
  highp vec3 curlNoise_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_CloudCurlTex, xlv_TEXCOORD1.zw).xyz;
  curlNoise_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD1.xy + ((
    (curlNoise_3.xy - 0.5)
   * curlNoise_3.z) * _CloudCurlAmplitude));
  tmpvar_5 = texture2D (_CloudParticleAtlas, P_6);
  texCol_2 = tmpvar_5;
  mediump float tmpvar_7;
  tmpvar_7 = max ((xlv_TEXCOORD3.w - xlv_TEXCOORD3.y), 0.0);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.y), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD2.w - -0.1) / 0.2), 0.0, 1.0);
  cloudCol_1.w = ((texCol_2.w * (tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  )) * (tmpvar_9 * (tmpvar_9 * 
    (3.0 - (2.0 * tmpvar_9))
  )));
  mediump float x_10;
  x_10 = (cloudCol_1.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.z), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  cloudCol_1.xyz = ((mix (xlv_TEXCOORD8, xlv_TEXCOORD7, texCol_2.xxx) + (xlv_TEXCOORD6 * 
    mix (texCol_2.y, ((1.0 - (tmpvar_11 * 
      (tmpvar_11 * (3.0 - (2.0 * tmpvar_11)))
    )) * 4.0), xlv_TEXCOORD3.w)
  )) + ((0.4 * xlv_TEXCOORD7) * _ES_CloudCoverage));
  cloudCol_1.xyz = (cloudCol_1.xyz + (xlv_TEXCOORD5 * texCol_2.x));
  cloudCol_1.xyz = (cloudCol_1.xyz * (xlv_TEXCOORD3.x + 1.0));
  mediump float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD2.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((_ES_CloudCoverage - 0.4) / 0.3), 0.0, 1.0);
  cloudCol_1.xyz = mix (xlv_TEXCOORD4, cloudCol_1.xyz, vec3(mix (clamp (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
  , 0.0, 1.0), 1.0, (tmpvar_13 * 
    (tmpvar_13 * (3.0 - (2.0 * tmpvar_13)))
  ))));
  cloudCol_1.w = clamp (cloudCol_1.w, 0.0, 1.0);
  gl_FragData[0] = cloudCol_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec4 _ES_TopFrontColor;
uniform mediump vec4 _ES_TopBackColor;
uniform mediump vec4 _ES_BottomFrontColor;
uniform mediump vec4 _ES_BottomBackColor;
uniform mediump float _ES_SkyFrontAndBackBlendFactor;
uniform mediump float _ES_BottomColorHeight;
uniform mediump vec3 _ES_HorizonHaloColor;
uniform mediump float _ES_HorizonHaloIntensity;
uniform mediump float _ES_HorizonHaloHeight;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump float _ES_SunHaloSize;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudAgePercent;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform sampler2D _SkyGradientTex;
uniform highp vec2 _AtlasTiles;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  mediump float agePercent_3;
  highp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec4 clipPos_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  clipPos_7.xyw = tmpvar_8.xyw;
  clipPos_7.z = tmpvar_8.w;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8.xyww * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = clipPos_7.zw;
  highp int tmpvar_13;
  tmpvar_13 = int(floor((
    (_glesColor.y * ((_AtlasTiles.x * _AtlasTiles.y) - 1.0))
   + 0.5)));
  highp vec2 tmpvar_14;
  tmpvar_14.x = (float(mod (float(tmpvar_13), _AtlasTiles.x)));
  tmpvar_14.y = floor((float(tmpvar_13) / _AtlasTiles.x));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy + tmpvar_14) / _AtlasTiles);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _CloudCurlTiling) + ((_ES_CloudElapsedTime * vec2(1.2, 0.8)) * _CloudCurlSpeed));
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
  mediump float tmpvar_20;
  tmpvar_20 = dot (viewDir_15, _ES_SunDirection);
  mediump float tmpvar_21;
  tmpvar_21 = ((tmpvar_20 * 0.5) + 0.5);
  tmpvar_5.x = (tmpvar_21 * _ES_CloudSunBrightenIntensity);
  tmpvar_5.y = tmpvar_2.z;
  tmpvar_5.z = tmpvar_2.w;
  highp float tmpvar_22;
  tmpvar_22 = (_glesMultiTexCoord1.y / max (_glesMultiTexCoord1.x, 1e-05));
  agePercent_3 = tmpvar_22;
  agePercent_3 = (agePercent_3 * _ES_CloudAgePercent);
  highp float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = clamp ((agePercent_3 / _glesMultiTexCoord1.z), 0.0, 1.0);
  tmpvar_23 = (tmpvar_24 * (tmpvar_24 * (3.0 - 
    (2.0 * tmpvar_24)
  )));
  highp float tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = clamp (((agePercent_3 - _glesMultiTexCoord1.w) / (1.0 - _glesMultiTexCoord1.w)), 0.0, 1.0);
  tmpvar_25 = (tmpvar_26 * (tmpvar_26 * (3.0 - 
    (2.0 * tmpvar_26)
  )));
  tmpvar_5.w = (1.0 - (tmpvar_23 * (1.0 - tmpvar_25)));
  mediump vec3 atomosphere_27;
  mediump float tmpvar_28;
  tmpvar_28 = dot (_ES_SunDirection, viewDir_15);
  mediump float tmpvar_29;
  tmpvar_29 = max (((tmpvar_28 * _ES_SkyFrontAndBackBlendFactor) + (1.0 - _ES_SkyFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_30;
  tmpvar_30 = ((tmpvar_29 * tmpvar_29) * tmpvar_29);
  mediump vec4 tmpvar_31;
  tmpvar_31.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_31.x = (abs(tmpvar_19.w) / max (_ES_BottomColorHeight, 0.0001));
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DLod (_SkyGradientTex, tmpvar_31.xy, 0.0);
  mediump float tmpvar_33;
  tmpvar_33 = tmpvar_32.x;
  atomosphere_27 = mix (mix (_ES_TopBackColor, _ES_TopFrontColor, vec4(tmpvar_30)).xyz, mix (_ES_BottomBackColor, _ES_BottomFrontColor, vec4(tmpvar_30)).xyz, vec3(tmpvar_33));
  mediump vec4 tmpvar_34;
  tmpvar_34.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_34.x = (abs(tmpvar_19.w) / max (_ES_HorizonHaloHeight, 0.0001));
  lowp vec4 tmpvar_35;
  tmpvar_35 = texture2DLod (_SkyGradientTex, tmpvar_34.xy, 0.0);
  mediump float tmpvar_36;
  tmpvar_36 = tmpvar_35.y;
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    max (((tmpvar_28 * 0.5) + 0.5), 0.0)
   - 0.3) / 0.7), 0.0, 1.0);
  mediump float tmpvar_38;
  tmpvar_38 = clamp (((
    abs(_ES_SunDirection.y)
   - 0.2) / 0.3), 0.0, 1.0);
  atomosphere_27 = (atomosphere_27 + ((
    (_ES_HorizonHaloColor * _ES_HorizonHaloIntensity)
   * tmpvar_36) * mix (
    (tmpvar_37 * (tmpvar_37 * (3.0 - (2.0 * tmpvar_37))))
  , 1.0, 
    (tmpvar_38 * (tmpvar_38 * (3.0 - (2.0 * tmpvar_38))))
  )));
  highp vec3 viewDir_39;
  viewDir_39 = tmpvar_19.xyz;
  highp float haloInfluence_40;
  mediump float vertical_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((
    dot (_ES_SunDirection, viewDir_39)
   * 0.5) + 0.5), 0.0, 1.0);
  highp float tmpvar_43;
  tmpvar_43 = dot (viewDir_39, _ES_SkyWorldUpDir);
  vertical_41 = tmpvar_43;
  mediump float tmpvar_44;
  tmpvar_44 = abs(vertical_41);
  mediump float y_45;
  y_45 = (_ES_SunHaloSize * tmpvar_44);
  mediump float y_46;
  y_46 = ((_ES_SunHaloSize * 0.1) * tmpvar_44);
  haloInfluence_40 = (clamp (pow (tmpvar_42, y_45), 0.0, 1.0) + (clamp (
    pow (tmpvar_42, y_46)
  , 0.0, 1.0) * 0.12));
  mediump float y_47;
  y_47 = ((_ES_SunHaloSize * 0.01) * tmpvar_44);
  haloInfluence_40 = (haloInfluence_40 + (clamp (
    pow (tmpvar_42, y_47)
  , 0.0, 1.0) * 0.03));
  highp float tmpvar_48;
  tmpvar_48 = clamp (((
    max (((dot (_ES_SunDirection, viewDir_39) * 0.5) + 0.5), 0.0)
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 tmpvar_49;
  tmpvar_49 = (((haloInfluence_40 * _ES_SunHaloIntensity) * _ES_SunHaloColor) * (tmpvar_48 * (tmpvar_48 * 
    (3.0 - (2.0 * tmpvar_48))
  )));
  tmpvar_6 = (atomosphere_27 + tmpvar_49);
  mediump float tmpvar_50;
  mediump float tmpvar_51;
  tmpvar_51 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_50 = (tmpvar_51 * (tmpvar_51 * (3.0 - 
    (2.0 * tmpvar_51)
  )));
  highp vec3 viewDir_52;
  viewDir_52 = tmpvar_19.xyz;
  mediump float moonLunarCancel_53;
  mediump float tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = clamp (dot (_ES_MoonDirection, viewDir_52), 0.0, 1.0);
  tmpvar_54 = tmpvar_55;
  highp float tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_56 = (1.0 - (tmpvar_57 * 2.0));
  moonLunarCancel_53 = tmpvar_56;
  mediump float tmpvar_58;
  tmpvar_58 = clamp (((
    ((tmpvar_54 * tmpvar_54) * ((tmpvar_54 * tmpvar_54) * tmpvar_54))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_59;
  viewDir_59 = tmpvar_19.xyz;
  mediump float vertical_60;
  mediump float tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = clamp (((
    dot (_ES_SunDirection, viewDir_59)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_61 = tmpvar_62;
  highp float tmpvar_63;
  tmpvar_63 = dot (viewDir_59, _ES_SkyWorldUpDir);
  vertical_60 = tmpvar_63;
  mediump float tmpvar_64;
  mediump float tmpvar_65;
  tmpvar_65 = (1.0 - _ES_SunRimLightRadius);
  tmpvar_64 = clamp (((tmpvar_21 - _ES_SunRimLightRadius) / tmpvar_65), 0.0, 1.0);
  mediump float tmpvar_66;
  tmpvar_66 = (((tmpvar_64 * 
    (tmpvar_64 * (3.0 - (2.0 * tmpvar_64)))
  ) * _ES_SunBrightness) * 0.125);
  mediump float tmpvar_67;
  tmpvar_67 = clamp (((
    ((dot (viewDir_15, _ES_MoonDirection) * 0.5) + 0.5)
   - _ES_SunRimLightRadius) / tmpvar_65), 0.0, 1.0);
  mediump float tmpvar_68;
  tmpvar_68 = (((tmpvar_67 * 
    (tmpvar_67 * (3.0 - (2.0 * tmpvar_67)))
  ) * _ES_MoonBrightness) * 0.1);
  mediump float tmpvar_69;
  tmpvar_69 = max (((tmpvar_20 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_70;
  tmpvar_70 = ((tmpvar_69 * tmpvar_69) * tmpvar_69);
  gl_Position = clipPos_7;
  xlv_TEXCOORD0 = o_10;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_19;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = (((
    ((((tmpvar_58 * 
      (tmpvar_58 * (3.0 - (2.0 * tmpvar_58)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_53) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_61, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_60))
    ) * vertical_60), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_50);
  xlv_TEXCOORD6 = (((_ES_SunHaloColor * 
    (tmpvar_66 * tmpvar_66)
  ) + (_ES_MoonColor * 
    (tmpvar_68 * tmpvar_68)
  )) * tmpvar_50);
  xlv_TEXCOORD7 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_70));
  xlv_TEXCOORD8 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_70));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_CloudCoverage;
uniform sampler2D _CloudParticleAtlas;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 cloudCol_1;
  mediump vec4 texCol_2;
  highp vec3 curlNoise_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_CloudCurlTex, xlv_TEXCOORD1.zw).xyz;
  curlNoise_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD1.xy + ((
    (curlNoise_3.xy - 0.5)
   * curlNoise_3.z) * _CloudCurlAmplitude));
  tmpvar_5 = texture2D (_CloudParticleAtlas, P_6);
  texCol_2 = tmpvar_5;
  mediump float tmpvar_7;
  tmpvar_7 = max ((xlv_TEXCOORD3.w - xlv_TEXCOORD3.y), 0.0);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.y), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD2.w - -0.1) / 0.2), 0.0, 1.0);
  cloudCol_1.w = ((texCol_2.w * (tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  )) * (tmpvar_9 * (tmpvar_9 * 
    (3.0 - (2.0 * tmpvar_9))
  )));
  mediump float x_10;
  x_10 = (cloudCol_1.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.z), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  cloudCol_1.xyz = ((mix (xlv_TEXCOORD8, xlv_TEXCOORD7, texCol_2.xxx) + (xlv_TEXCOORD6 * 
    mix (texCol_2.y, ((1.0 - (tmpvar_11 * 
      (tmpvar_11 * (3.0 - (2.0 * tmpvar_11)))
    )) * 4.0), xlv_TEXCOORD3.w)
  )) + ((0.4 * xlv_TEXCOORD7) * _ES_CloudCoverage));
  cloudCol_1.xyz = (cloudCol_1.xyz + (xlv_TEXCOORD5 * texCol_2.x));
  cloudCol_1.xyz = (cloudCol_1.xyz * (xlv_TEXCOORD3.x + 1.0));
  mediump float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD2.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((_ES_CloudCoverage - 0.4) / 0.3), 0.0, 1.0);
  cloudCol_1.xyz = mix (xlv_TEXCOORD4, cloudCol_1.xyz, vec3(mix (clamp (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
  , 0.0, 1.0), 1.0, (tmpvar_13 * 
    (tmpvar_13 * (3.0 - (2.0 * tmpvar_13)))
  ))));
  cloudCol_1.w = clamp (cloudCol_1.w, 0.0, 1.0);
  gl_FragData[0] = cloudCol_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec4 _ES_TopFrontColor;
uniform mediump vec4 _ES_TopBackColor;
uniform mediump vec4 _ES_BottomFrontColor;
uniform mediump vec4 _ES_BottomBackColor;
uniform mediump float _ES_SkyFrontAndBackBlendFactor;
uniform mediump float _ES_BottomColorHeight;
uniform mediump vec3 _ES_HorizonHaloColor;
uniform mediump float _ES_HorizonHaloIntensity;
uniform mediump float _ES_HorizonHaloHeight;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump float _ES_SunHaloSize;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudAgePercent;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform sampler2D _SkyGradientTex;
uniform highp vec2 _AtlasTiles;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  mediump float agePercent_3;
  highp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec4 clipPos_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  clipPos_7.xyw = tmpvar_8.xyw;
  clipPos_7.z = tmpvar_8.w;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8.xyww * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = clipPos_7.zw;
  highp int tmpvar_13;
  tmpvar_13 = int(floor((
    (_glesColor.y * ((_AtlasTiles.x * _AtlasTiles.y) - 1.0))
   + 0.5)));
  highp vec2 tmpvar_14;
  tmpvar_14.x = (float(mod (float(tmpvar_13), _AtlasTiles.x)));
  tmpvar_14.y = floor((float(tmpvar_13) / _AtlasTiles.x));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy + tmpvar_14) / _AtlasTiles);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _CloudCurlTiling) + ((_ES_CloudElapsedTime * vec2(1.2, 0.8)) * _CloudCurlSpeed));
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
  mediump float tmpvar_20;
  tmpvar_20 = dot (viewDir_15, _ES_SunDirection);
  mediump float tmpvar_21;
  tmpvar_21 = ((tmpvar_20 * 0.5) + 0.5);
  tmpvar_5.x = (tmpvar_21 * _ES_CloudSunBrightenIntensity);
  tmpvar_5.y = tmpvar_2.z;
  tmpvar_5.z = tmpvar_2.w;
  highp float tmpvar_22;
  tmpvar_22 = (_glesMultiTexCoord1.y / max (_glesMultiTexCoord1.x, 1e-05));
  agePercent_3 = tmpvar_22;
  agePercent_3 = (agePercent_3 * _ES_CloudAgePercent);
  highp float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = clamp ((agePercent_3 / _glesMultiTexCoord1.z), 0.0, 1.0);
  tmpvar_23 = (tmpvar_24 * (tmpvar_24 * (3.0 - 
    (2.0 * tmpvar_24)
  )));
  highp float tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = clamp (((agePercent_3 - _glesMultiTexCoord1.w) / (1.0 - _glesMultiTexCoord1.w)), 0.0, 1.0);
  tmpvar_25 = (tmpvar_26 * (tmpvar_26 * (3.0 - 
    (2.0 * tmpvar_26)
  )));
  tmpvar_5.w = (1.0 - (tmpvar_23 * (1.0 - tmpvar_25)));
  mediump vec3 atomosphere_27;
  mediump float tmpvar_28;
  tmpvar_28 = dot (_ES_SunDirection, viewDir_15);
  mediump float tmpvar_29;
  tmpvar_29 = max (((tmpvar_28 * _ES_SkyFrontAndBackBlendFactor) + (1.0 - _ES_SkyFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_30;
  tmpvar_30 = ((tmpvar_29 * tmpvar_29) * tmpvar_29);
  mediump vec4 tmpvar_31;
  tmpvar_31.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_31.x = (abs(tmpvar_19.w) / max (_ES_BottomColorHeight, 0.0001));
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DLod (_SkyGradientTex, tmpvar_31.xy, 0.0);
  mediump float tmpvar_33;
  tmpvar_33 = tmpvar_32.x;
  atomosphere_27 = mix (mix (_ES_TopBackColor, _ES_TopFrontColor, vec4(tmpvar_30)).xyz, mix (_ES_BottomBackColor, _ES_BottomFrontColor, vec4(tmpvar_30)).xyz, vec3(tmpvar_33));
  mediump vec4 tmpvar_34;
  tmpvar_34.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_34.x = (abs(tmpvar_19.w) / max (_ES_HorizonHaloHeight, 0.0001));
  lowp vec4 tmpvar_35;
  tmpvar_35 = texture2DLod (_SkyGradientTex, tmpvar_34.xy, 0.0);
  mediump float tmpvar_36;
  tmpvar_36 = tmpvar_35.y;
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    max (((tmpvar_28 * 0.5) + 0.5), 0.0)
   - 0.3) / 0.7), 0.0, 1.0);
  mediump float tmpvar_38;
  tmpvar_38 = clamp (((
    abs(_ES_SunDirection.y)
   - 0.2) / 0.3), 0.0, 1.0);
  atomosphere_27 = (atomosphere_27 + ((
    (_ES_HorizonHaloColor * _ES_HorizonHaloIntensity)
   * tmpvar_36) * mix (
    (tmpvar_37 * (tmpvar_37 * (3.0 - (2.0 * tmpvar_37))))
  , 1.0, 
    (tmpvar_38 * (tmpvar_38 * (3.0 - (2.0 * tmpvar_38))))
  )));
  highp vec3 viewDir_39;
  viewDir_39 = tmpvar_19.xyz;
  highp float haloInfluence_40;
  mediump float vertical_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((
    dot (_ES_SunDirection, viewDir_39)
   * 0.5) + 0.5), 0.0, 1.0);
  highp float tmpvar_43;
  tmpvar_43 = dot (viewDir_39, _ES_SkyWorldUpDir);
  vertical_41 = tmpvar_43;
  mediump float tmpvar_44;
  tmpvar_44 = abs(vertical_41);
  mediump float y_45;
  y_45 = (_ES_SunHaloSize * tmpvar_44);
  mediump float y_46;
  y_46 = ((_ES_SunHaloSize * 0.1) * tmpvar_44);
  haloInfluence_40 = (clamp (pow (tmpvar_42, y_45), 0.0, 1.0) + (clamp (
    pow (tmpvar_42, y_46)
  , 0.0, 1.0) * 0.12));
  mediump float y_47;
  y_47 = ((_ES_SunHaloSize * 0.01) * tmpvar_44);
  haloInfluence_40 = (haloInfluence_40 + (clamp (
    pow (tmpvar_42, y_47)
  , 0.0, 1.0) * 0.03));
  highp float tmpvar_48;
  tmpvar_48 = clamp (((
    max (((dot (_ES_SunDirection, viewDir_39) * 0.5) + 0.5), 0.0)
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 tmpvar_49;
  tmpvar_49 = (((haloInfluence_40 * _ES_SunHaloIntensity) * _ES_SunHaloColor) * (tmpvar_48 * (tmpvar_48 * 
    (3.0 - (2.0 * tmpvar_48))
  )));
  tmpvar_6 = (atomosphere_27 + tmpvar_49);
  mediump float tmpvar_50;
  mediump float tmpvar_51;
  tmpvar_51 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_50 = (tmpvar_51 * (tmpvar_51 * (3.0 - 
    (2.0 * tmpvar_51)
  )));
  highp vec3 viewDir_52;
  viewDir_52 = tmpvar_19.xyz;
  mediump float moonLunarCancel_53;
  mediump float tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = clamp (dot (_ES_MoonDirection, viewDir_52), 0.0, 1.0);
  tmpvar_54 = tmpvar_55;
  highp float tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_56 = (1.0 - (tmpvar_57 * 2.0));
  moonLunarCancel_53 = tmpvar_56;
  mediump float tmpvar_58;
  tmpvar_58 = clamp (((
    ((tmpvar_54 * tmpvar_54) * ((tmpvar_54 * tmpvar_54) * tmpvar_54))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_59;
  viewDir_59 = tmpvar_19.xyz;
  mediump float vertical_60;
  mediump float tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = clamp (((
    dot (_ES_SunDirection, viewDir_59)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_61 = tmpvar_62;
  highp float tmpvar_63;
  tmpvar_63 = dot (viewDir_59, _ES_SkyWorldUpDir);
  vertical_60 = tmpvar_63;
  mediump float tmpvar_64;
  mediump float tmpvar_65;
  tmpvar_65 = (1.0 - _ES_SunRimLightRadius);
  tmpvar_64 = clamp (((tmpvar_21 - _ES_SunRimLightRadius) / tmpvar_65), 0.0, 1.0);
  mediump float tmpvar_66;
  tmpvar_66 = (((tmpvar_64 * 
    (tmpvar_64 * (3.0 - (2.0 * tmpvar_64)))
  ) * _ES_SunBrightness) * 0.125);
  mediump float tmpvar_67;
  tmpvar_67 = clamp (((
    ((dot (viewDir_15, _ES_MoonDirection) * 0.5) + 0.5)
   - _ES_SunRimLightRadius) / tmpvar_65), 0.0, 1.0);
  mediump float tmpvar_68;
  tmpvar_68 = (((tmpvar_67 * 
    (tmpvar_67 * (3.0 - (2.0 * tmpvar_67)))
  ) * _ES_MoonBrightness) * 0.1);
  mediump float tmpvar_69;
  tmpvar_69 = max (((tmpvar_20 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_70;
  tmpvar_70 = ((tmpvar_69 * tmpvar_69) * tmpvar_69);
  gl_Position = clipPos_7;
  xlv_TEXCOORD0 = o_10;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_19;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = (((
    ((((tmpvar_58 * 
      (tmpvar_58 * (3.0 - (2.0 * tmpvar_58)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_53) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_61, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_60))
    ) * vertical_60), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_50);
  xlv_TEXCOORD6 = (((_ES_SunHaloColor * 
    (tmpvar_66 * tmpvar_66)
  ) + (_ES_MoonColor * 
    (tmpvar_68 * tmpvar_68)
  )) * tmpvar_50);
  xlv_TEXCOORD7 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_70));
  xlv_TEXCOORD8 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_70));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_CloudCoverage;
uniform sampler2D _CloudParticleAtlas;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 cloudCol_1;
  mediump vec4 texCol_2;
  highp vec3 curlNoise_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_CloudCurlTex, xlv_TEXCOORD1.zw).xyz;
  curlNoise_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD1.xy + ((
    (curlNoise_3.xy - 0.5)
   * curlNoise_3.z) * _CloudCurlAmplitude));
  tmpvar_5 = texture2D (_CloudParticleAtlas, P_6);
  texCol_2 = tmpvar_5;
  mediump float tmpvar_7;
  tmpvar_7 = max ((xlv_TEXCOORD3.w - xlv_TEXCOORD3.y), 0.0);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.y), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD2.w - -0.1) / 0.2), 0.0, 1.0);
  cloudCol_1.w = ((texCol_2.w * (tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  )) * (tmpvar_9 * (tmpvar_9 * 
    (3.0 - (2.0 * tmpvar_9))
  )));
  mediump float x_10;
  x_10 = (cloudCol_1.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.z), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  cloudCol_1.xyz = ((mix (xlv_TEXCOORD8, xlv_TEXCOORD7, texCol_2.xxx) + (xlv_TEXCOORD6 * 
    mix (texCol_2.y, ((1.0 - (tmpvar_11 * 
      (tmpvar_11 * (3.0 - (2.0 * tmpvar_11)))
    )) * 4.0), xlv_TEXCOORD3.w)
  )) + ((0.4 * xlv_TEXCOORD7) * _ES_CloudCoverage));
  cloudCol_1.xyz = (cloudCol_1.xyz + (xlv_TEXCOORD5 * texCol_2.x));
  cloudCol_1.xyz = (cloudCol_1.xyz * (xlv_TEXCOORD3.x + 1.0));
  mediump float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD2.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((_ES_CloudCoverage - 0.4) / 0.3), 0.0, 1.0);
  cloudCol_1.xyz = mix (xlv_TEXCOORD4, cloudCol_1.xyz, vec3(mix (clamp (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
  , 0.0, 1.0), 1.0, (tmpvar_13 * 
    (tmpvar_13 * (3.0 - (2.0 * tmpvar_13)))
  ))));
  cloudCol_1.w = clamp (cloudCol_1.w, 0.0, 1.0);
  gl_FragData[0] = cloudCol_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FIXED_RIMLIGHT_WIDTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec4 _ES_TopFrontColor;
uniform mediump vec4 _ES_TopBackColor;
uniform mediump vec4 _ES_BottomFrontColor;
uniform mediump vec4 _ES_BottomBackColor;
uniform mediump float _ES_SkyFrontAndBackBlendFactor;
uniform mediump float _ES_BottomColorHeight;
uniform mediump vec3 _ES_HorizonHaloColor;
uniform mediump float _ES_HorizonHaloIntensity;
uniform mediump float _ES_HorizonHaloHeight;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump float _ES_SunHaloSize;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudAgePercent;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform sampler2D _SkyGradientTex;
uniform highp vec2 _AtlasTiles;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
uniform mediump float _FixedRimLightWidth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float agePercent_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 clipPos_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  clipPos_6.xyw = tmpvar_7.xyw;
  clipPos_6.z = tmpvar_7.w;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7.xyww * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = clipPos_6.zw;
  highp int tmpvar_12;
  tmpvar_12 = int(floor((
    (_glesColor.y * ((_AtlasTiles.x * _AtlasTiles.y) - 1.0))
   + 0.5)));
  highp vec2 tmpvar_13;
  tmpvar_13.x = (float(mod (float(tmpvar_12), _AtlasTiles.x)));
  tmpvar_13.y = floor((float(tmpvar_12) / _AtlasTiles.x));
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy + tmpvar_13) / _AtlasTiles);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _CloudCurlTiling) + ((_ES_CloudElapsedTime * vec2(1.2, 0.8)) * _CloudCurlSpeed));
  mediump vec3 viewDir_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(((unity_ObjectToWorld * tmpvar_15).xyz - _ES_SkyCenterWorldPos));
  viewDir_14 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (_ES_SkyWorldUpDir, viewDir_14);
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = viewDir_14;
  tmpvar_18.w = ((sign(tmpvar_17) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_17))) * (1.570796 + (abs(tmpvar_17) * (-0.2146018 + 
      (abs(tmpvar_17) * (0.08656672 + (abs(tmpvar_17) * -0.03102955)))
    ))))
  )) * 0.6366198);
  mediump float tmpvar_19;
  tmpvar_19 = dot (viewDir_14, _ES_SunDirection);
  mediump float tmpvar_20;
  tmpvar_20 = ((tmpvar_19 * 0.5) + 0.5);
  tmpvar_4.x = (tmpvar_20 * _ES_CloudSunBrightenIntensity);
  tmpvar_4.y = _glesColor.z;
  tmpvar_4.z = _FixedRimLightWidth;
  highp float tmpvar_21;
  tmpvar_21 = (_glesMultiTexCoord1.y / max (_glesMultiTexCoord1.x, 1e-05));
  agePercent_2 = tmpvar_21;
  agePercent_2 = (agePercent_2 * _ES_CloudAgePercent);
  highp float tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = clamp ((agePercent_2 / _glesMultiTexCoord1.z), 0.0, 1.0);
  tmpvar_22 = (tmpvar_23 * (tmpvar_23 * (3.0 - 
    (2.0 * tmpvar_23)
  )));
  highp float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((agePercent_2 - _glesMultiTexCoord1.w) / (1.0 - _glesMultiTexCoord1.w)), 0.0, 1.0);
  tmpvar_24 = (tmpvar_25 * (tmpvar_25 * (3.0 - 
    (2.0 * tmpvar_25)
  )));
  tmpvar_4.w = (1.0 - (tmpvar_22 * (1.0 - tmpvar_24)));
  mediump vec3 atomosphere_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (_ES_SunDirection, viewDir_14);
  mediump float tmpvar_28;
  tmpvar_28 = max (((tmpvar_27 * _ES_SkyFrontAndBackBlendFactor) + (1.0 - _ES_SkyFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_29;
  tmpvar_29 = ((tmpvar_28 * tmpvar_28) * tmpvar_28);
  mediump vec4 tmpvar_30;
  tmpvar_30.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_30.x = (abs(tmpvar_18.w) / max (_ES_BottomColorHeight, 0.0001));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DLod (_SkyGradientTex, tmpvar_30.xy, 0.0);
  mediump float tmpvar_32;
  tmpvar_32 = tmpvar_31.x;
  atomosphere_26 = mix (mix (_ES_TopBackColor, _ES_TopFrontColor, vec4(tmpvar_29)).xyz, mix (_ES_BottomBackColor, _ES_BottomFrontColor, vec4(tmpvar_29)).xyz, vec3(tmpvar_32));
  mediump vec4 tmpvar_33;
  tmpvar_33.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_33.x = (abs(tmpvar_18.w) / max (_ES_HorizonHaloHeight, 0.0001));
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DLod (_SkyGradientTex, tmpvar_33.xy, 0.0);
  mediump float tmpvar_35;
  tmpvar_35 = tmpvar_34.y;
  mediump float tmpvar_36;
  tmpvar_36 = clamp (((
    max (((tmpvar_27 * 0.5) + 0.5), 0.0)
   - 0.3) / 0.7), 0.0, 1.0);
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    abs(_ES_SunDirection.y)
   - 0.2) / 0.3), 0.0, 1.0);
  atomosphere_26 = (atomosphere_26 + ((
    (_ES_HorizonHaloColor * _ES_HorizonHaloIntensity)
   * tmpvar_35) * mix (
    (tmpvar_36 * (tmpvar_36 * (3.0 - (2.0 * tmpvar_36))))
  , 1.0, 
    (tmpvar_37 * (tmpvar_37 * (3.0 - (2.0 * tmpvar_37))))
  )));
  highp vec3 viewDir_38;
  viewDir_38 = tmpvar_18.xyz;
  highp float haloInfluence_39;
  mediump float vertical_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((
    dot (_ES_SunDirection, viewDir_38)
   * 0.5) + 0.5), 0.0, 1.0);
  highp float tmpvar_42;
  tmpvar_42 = dot (viewDir_38, _ES_SkyWorldUpDir);
  vertical_40 = tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = abs(vertical_40);
  mediump float y_44;
  y_44 = (_ES_SunHaloSize * tmpvar_43);
  mediump float y_45;
  y_45 = ((_ES_SunHaloSize * 0.1) * tmpvar_43);
  haloInfluence_39 = (clamp (pow (tmpvar_41, y_44), 0.0, 1.0) + (clamp (
    pow (tmpvar_41, y_45)
  , 0.0, 1.0) * 0.12));
  mediump float y_46;
  y_46 = ((_ES_SunHaloSize * 0.01) * tmpvar_43);
  haloInfluence_39 = (haloInfluence_39 + (clamp (
    pow (tmpvar_41, y_46)
  , 0.0, 1.0) * 0.03));
  highp float tmpvar_47;
  tmpvar_47 = clamp (((
    max (((dot (_ES_SunDirection, viewDir_38) * 0.5) + 0.5), 0.0)
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 tmpvar_48;
  tmpvar_48 = (((haloInfluence_39 * _ES_SunHaloIntensity) * _ES_SunHaloColor) * (tmpvar_47 * (tmpvar_47 * 
    (3.0 - (2.0 * tmpvar_47))
  )));
  tmpvar_5 = (atomosphere_26 + tmpvar_48);
  mediump float tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_49 = (tmpvar_50 * (tmpvar_50 * (3.0 - 
    (2.0 * tmpvar_50)
  )));
  highp vec3 viewDir_51;
  viewDir_51 = tmpvar_18.xyz;
  mediump float moonLunarCancel_52;
  mediump float tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (_ES_MoonDirection, viewDir_51), 0.0, 1.0);
  tmpvar_53 = tmpvar_54;
  highp float tmpvar_55;
  mediump float tmpvar_56;
  tmpvar_56 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_55 = (1.0 - (tmpvar_56 * 2.0));
  moonLunarCancel_52 = tmpvar_55;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((
    ((tmpvar_53 * tmpvar_53) * ((tmpvar_53 * tmpvar_53) * tmpvar_53))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_58;
  viewDir_58 = tmpvar_18.xyz;
  mediump float vertical_59;
  mediump float tmpvar_60;
  highp float tmpvar_61;
  tmpvar_61 = clamp (((
    dot (_ES_SunDirection, viewDir_58)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_60 = tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = dot (viewDir_58, _ES_SkyWorldUpDir);
  vertical_59 = tmpvar_62;
  mediump float tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = (1.0 - _ES_SunRimLightRadius);
  tmpvar_63 = clamp (((tmpvar_20 - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (((tmpvar_63 * 
    (tmpvar_63 * (3.0 - (2.0 * tmpvar_63)))
  ) * _ES_SunBrightness) * 0.125);
  mediump float tmpvar_66;
  tmpvar_66 = clamp (((
    ((dot (viewDir_14, _ES_MoonDirection) * 0.5) + 0.5)
   - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_67;
  tmpvar_67 = (((tmpvar_66 * 
    (tmpvar_66 * (3.0 - (2.0 * tmpvar_66)))
  ) * _ES_MoonBrightness) * 0.1);
  mediump float tmpvar_68;
  tmpvar_68 = max (((tmpvar_19 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_69;
  tmpvar_69 = ((tmpvar_68 * tmpvar_68) * tmpvar_68);
  gl_Position = clipPos_6;
  xlv_TEXCOORD0 = o_9;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = (((
    ((((tmpvar_57 * 
      (tmpvar_57 * (3.0 - (2.0 * tmpvar_57)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_52) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_60, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_59))
    ) * vertical_59), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_49);
  xlv_TEXCOORD6 = (((_ES_SunHaloColor * 
    (tmpvar_65 * tmpvar_65)
  ) + (_ES_MoonColor * 
    (tmpvar_67 * tmpvar_67)
  )) * tmpvar_49);
  xlv_TEXCOORD7 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_69));
  xlv_TEXCOORD8 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_69));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_CloudCoverage;
uniform sampler2D _CloudParticleAtlas;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 cloudCol_1;
  mediump vec4 texCol_2;
  highp vec3 curlNoise_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_CloudCurlTex, xlv_TEXCOORD1.zw).xyz;
  curlNoise_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD1.xy + ((
    (curlNoise_3.xy - 0.5)
   * curlNoise_3.z) * _CloudCurlAmplitude));
  tmpvar_5 = texture2D (_CloudParticleAtlas, P_6);
  texCol_2 = tmpvar_5;
  mediump float tmpvar_7;
  tmpvar_7 = max ((xlv_TEXCOORD3.w - xlv_TEXCOORD3.y), 0.0);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.y), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD2.w - -0.1) / 0.2), 0.0, 1.0);
  cloudCol_1.w = ((texCol_2.w * (tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  )) * (tmpvar_9 * (tmpvar_9 * 
    (3.0 - (2.0 * tmpvar_9))
  )));
  mediump float x_10;
  x_10 = (cloudCol_1.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.z), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  cloudCol_1.xyz = ((mix (xlv_TEXCOORD8, xlv_TEXCOORD7, texCol_2.xxx) + (xlv_TEXCOORD6 * 
    mix (texCol_2.y, ((1.0 - (tmpvar_11 * 
      (tmpvar_11 * (3.0 - (2.0 * tmpvar_11)))
    )) * 4.0), xlv_TEXCOORD3.w)
  )) + ((0.4 * xlv_TEXCOORD7) * _ES_CloudCoverage));
  cloudCol_1.xyz = (cloudCol_1.xyz + (xlv_TEXCOORD5 * texCol_2.x));
  cloudCol_1.xyz = (cloudCol_1.xyz * (xlv_TEXCOORD3.x + 1.0));
  mediump float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD2.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((_ES_CloudCoverage - 0.4) / 0.3), 0.0, 1.0);
  cloudCol_1.xyz = mix (xlv_TEXCOORD4, cloudCol_1.xyz, vec3(mix (clamp (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
  , 0.0, 1.0), 1.0, (tmpvar_13 * 
    (tmpvar_13 * (3.0 - (2.0 * tmpvar_13)))
  ))));
  cloudCol_1.w = clamp (cloudCol_1.w, 0.0, 1.0);
  gl_FragData[0] = cloudCol_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FIXED_RIMLIGHT_WIDTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec4 _ES_TopFrontColor;
uniform mediump vec4 _ES_TopBackColor;
uniform mediump vec4 _ES_BottomFrontColor;
uniform mediump vec4 _ES_BottomBackColor;
uniform mediump float _ES_SkyFrontAndBackBlendFactor;
uniform mediump float _ES_BottomColorHeight;
uniform mediump vec3 _ES_HorizonHaloColor;
uniform mediump float _ES_HorizonHaloIntensity;
uniform mediump float _ES_HorizonHaloHeight;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump float _ES_SunHaloSize;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudAgePercent;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform sampler2D _SkyGradientTex;
uniform highp vec2 _AtlasTiles;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
uniform mediump float _FixedRimLightWidth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float agePercent_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 clipPos_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  clipPos_6.xyw = tmpvar_7.xyw;
  clipPos_6.z = tmpvar_7.w;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7.xyww * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = clipPos_6.zw;
  highp int tmpvar_12;
  tmpvar_12 = int(floor((
    (_glesColor.y * ((_AtlasTiles.x * _AtlasTiles.y) - 1.0))
   + 0.5)));
  highp vec2 tmpvar_13;
  tmpvar_13.x = (float(mod (float(tmpvar_12), _AtlasTiles.x)));
  tmpvar_13.y = floor((float(tmpvar_12) / _AtlasTiles.x));
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy + tmpvar_13) / _AtlasTiles);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _CloudCurlTiling) + ((_ES_CloudElapsedTime * vec2(1.2, 0.8)) * _CloudCurlSpeed));
  mediump vec3 viewDir_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(((unity_ObjectToWorld * tmpvar_15).xyz - _ES_SkyCenterWorldPos));
  viewDir_14 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (_ES_SkyWorldUpDir, viewDir_14);
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = viewDir_14;
  tmpvar_18.w = ((sign(tmpvar_17) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_17))) * (1.570796 + (abs(tmpvar_17) * (-0.2146018 + 
      (abs(tmpvar_17) * (0.08656672 + (abs(tmpvar_17) * -0.03102955)))
    ))))
  )) * 0.6366198);
  mediump float tmpvar_19;
  tmpvar_19 = dot (viewDir_14, _ES_SunDirection);
  mediump float tmpvar_20;
  tmpvar_20 = ((tmpvar_19 * 0.5) + 0.5);
  tmpvar_4.x = (tmpvar_20 * _ES_CloudSunBrightenIntensity);
  tmpvar_4.y = _glesColor.z;
  tmpvar_4.z = _FixedRimLightWidth;
  highp float tmpvar_21;
  tmpvar_21 = (_glesMultiTexCoord1.y / max (_glesMultiTexCoord1.x, 1e-05));
  agePercent_2 = tmpvar_21;
  agePercent_2 = (agePercent_2 * _ES_CloudAgePercent);
  highp float tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = clamp ((agePercent_2 / _glesMultiTexCoord1.z), 0.0, 1.0);
  tmpvar_22 = (tmpvar_23 * (tmpvar_23 * (3.0 - 
    (2.0 * tmpvar_23)
  )));
  highp float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((agePercent_2 - _glesMultiTexCoord1.w) / (1.0 - _glesMultiTexCoord1.w)), 0.0, 1.0);
  tmpvar_24 = (tmpvar_25 * (tmpvar_25 * (3.0 - 
    (2.0 * tmpvar_25)
  )));
  tmpvar_4.w = (1.0 - (tmpvar_22 * (1.0 - tmpvar_24)));
  mediump vec3 atomosphere_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (_ES_SunDirection, viewDir_14);
  mediump float tmpvar_28;
  tmpvar_28 = max (((tmpvar_27 * _ES_SkyFrontAndBackBlendFactor) + (1.0 - _ES_SkyFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_29;
  tmpvar_29 = ((tmpvar_28 * tmpvar_28) * tmpvar_28);
  mediump vec4 tmpvar_30;
  tmpvar_30.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_30.x = (abs(tmpvar_18.w) / max (_ES_BottomColorHeight, 0.0001));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DLod (_SkyGradientTex, tmpvar_30.xy, 0.0);
  mediump float tmpvar_32;
  tmpvar_32 = tmpvar_31.x;
  atomosphere_26 = mix (mix (_ES_TopBackColor, _ES_TopFrontColor, vec4(tmpvar_29)).xyz, mix (_ES_BottomBackColor, _ES_BottomFrontColor, vec4(tmpvar_29)).xyz, vec3(tmpvar_32));
  mediump vec4 tmpvar_33;
  tmpvar_33.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_33.x = (abs(tmpvar_18.w) / max (_ES_HorizonHaloHeight, 0.0001));
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DLod (_SkyGradientTex, tmpvar_33.xy, 0.0);
  mediump float tmpvar_35;
  tmpvar_35 = tmpvar_34.y;
  mediump float tmpvar_36;
  tmpvar_36 = clamp (((
    max (((tmpvar_27 * 0.5) + 0.5), 0.0)
   - 0.3) / 0.7), 0.0, 1.0);
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    abs(_ES_SunDirection.y)
   - 0.2) / 0.3), 0.0, 1.0);
  atomosphere_26 = (atomosphere_26 + ((
    (_ES_HorizonHaloColor * _ES_HorizonHaloIntensity)
   * tmpvar_35) * mix (
    (tmpvar_36 * (tmpvar_36 * (3.0 - (2.0 * tmpvar_36))))
  , 1.0, 
    (tmpvar_37 * (tmpvar_37 * (3.0 - (2.0 * tmpvar_37))))
  )));
  highp vec3 viewDir_38;
  viewDir_38 = tmpvar_18.xyz;
  highp float haloInfluence_39;
  mediump float vertical_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((
    dot (_ES_SunDirection, viewDir_38)
   * 0.5) + 0.5), 0.0, 1.0);
  highp float tmpvar_42;
  tmpvar_42 = dot (viewDir_38, _ES_SkyWorldUpDir);
  vertical_40 = tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = abs(vertical_40);
  mediump float y_44;
  y_44 = (_ES_SunHaloSize * tmpvar_43);
  mediump float y_45;
  y_45 = ((_ES_SunHaloSize * 0.1) * tmpvar_43);
  haloInfluence_39 = (clamp (pow (tmpvar_41, y_44), 0.0, 1.0) + (clamp (
    pow (tmpvar_41, y_45)
  , 0.0, 1.0) * 0.12));
  mediump float y_46;
  y_46 = ((_ES_SunHaloSize * 0.01) * tmpvar_43);
  haloInfluence_39 = (haloInfluence_39 + (clamp (
    pow (tmpvar_41, y_46)
  , 0.0, 1.0) * 0.03));
  highp float tmpvar_47;
  tmpvar_47 = clamp (((
    max (((dot (_ES_SunDirection, viewDir_38) * 0.5) + 0.5), 0.0)
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 tmpvar_48;
  tmpvar_48 = (((haloInfluence_39 * _ES_SunHaloIntensity) * _ES_SunHaloColor) * (tmpvar_47 * (tmpvar_47 * 
    (3.0 - (2.0 * tmpvar_47))
  )));
  tmpvar_5 = (atomosphere_26 + tmpvar_48);
  mediump float tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_49 = (tmpvar_50 * (tmpvar_50 * (3.0 - 
    (2.0 * tmpvar_50)
  )));
  highp vec3 viewDir_51;
  viewDir_51 = tmpvar_18.xyz;
  mediump float moonLunarCancel_52;
  mediump float tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (_ES_MoonDirection, viewDir_51), 0.0, 1.0);
  tmpvar_53 = tmpvar_54;
  highp float tmpvar_55;
  mediump float tmpvar_56;
  tmpvar_56 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_55 = (1.0 - (tmpvar_56 * 2.0));
  moonLunarCancel_52 = tmpvar_55;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((
    ((tmpvar_53 * tmpvar_53) * ((tmpvar_53 * tmpvar_53) * tmpvar_53))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_58;
  viewDir_58 = tmpvar_18.xyz;
  mediump float vertical_59;
  mediump float tmpvar_60;
  highp float tmpvar_61;
  tmpvar_61 = clamp (((
    dot (_ES_SunDirection, viewDir_58)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_60 = tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = dot (viewDir_58, _ES_SkyWorldUpDir);
  vertical_59 = tmpvar_62;
  mediump float tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = (1.0 - _ES_SunRimLightRadius);
  tmpvar_63 = clamp (((tmpvar_20 - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (((tmpvar_63 * 
    (tmpvar_63 * (3.0 - (2.0 * tmpvar_63)))
  ) * _ES_SunBrightness) * 0.125);
  mediump float tmpvar_66;
  tmpvar_66 = clamp (((
    ((dot (viewDir_14, _ES_MoonDirection) * 0.5) + 0.5)
   - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_67;
  tmpvar_67 = (((tmpvar_66 * 
    (tmpvar_66 * (3.0 - (2.0 * tmpvar_66)))
  ) * _ES_MoonBrightness) * 0.1);
  mediump float tmpvar_68;
  tmpvar_68 = max (((tmpvar_19 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_69;
  tmpvar_69 = ((tmpvar_68 * tmpvar_68) * tmpvar_68);
  gl_Position = clipPos_6;
  xlv_TEXCOORD0 = o_9;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = (((
    ((((tmpvar_57 * 
      (tmpvar_57 * (3.0 - (2.0 * tmpvar_57)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_52) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_60, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_59))
    ) * vertical_59), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_49);
  xlv_TEXCOORD6 = (((_ES_SunHaloColor * 
    (tmpvar_65 * tmpvar_65)
  ) + (_ES_MoonColor * 
    (tmpvar_67 * tmpvar_67)
  )) * tmpvar_49);
  xlv_TEXCOORD7 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_69));
  xlv_TEXCOORD8 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_69));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_CloudCoverage;
uniform sampler2D _CloudParticleAtlas;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 cloudCol_1;
  mediump vec4 texCol_2;
  highp vec3 curlNoise_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_CloudCurlTex, xlv_TEXCOORD1.zw).xyz;
  curlNoise_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD1.xy + ((
    (curlNoise_3.xy - 0.5)
   * curlNoise_3.z) * _CloudCurlAmplitude));
  tmpvar_5 = texture2D (_CloudParticleAtlas, P_6);
  texCol_2 = tmpvar_5;
  mediump float tmpvar_7;
  tmpvar_7 = max ((xlv_TEXCOORD3.w - xlv_TEXCOORD3.y), 0.0);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.y), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD2.w - -0.1) / 0.2), 0.0, 1.0);
  cloudCol_1.w = ((texCol_2.w * (tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  )) * (tmpvar_9 * (tmpvar_9 * 
    (3.0 - (2.0 * tmpvar_9))
  )));
  mediump float x_10;
  x_10 = (cloudCol_1.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.z), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  cloudCol_1.xyz = ((mix (xlv_TEXCOORD8, xlv_TEXCOORD7, texCol_2.xxx) + (xlv_TEXCOORD6 * 
    mix (texCol_2.y, ((1.0 - (tmpvar_11 * 
      (tmpvar_11 * (3.0 - (2.0 * tmpvar_11)))
    )) * 4.0), xlv_TEXCOORD3.w)
  )) + ((0.4 * xlv_TEXCOORD7) * _ES_CloudCoverage));
  cloudCol_1.xyz = (cloudCol_1.xyz + (xlv_TEXCOORD5 * texCol_2.x));
  cloudCol_1.xyz = (cloudCol_1.xyz * (xlv_TEXCOORD3.x + 1.0));
  mediump float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD2.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((_ES_CloudCoverage - 0.4) / 0.3), 0.0, 1.0);
  cloudCol_1.xyz = mix (xlv_TEXCOORD4, cloudCol_1.xyz, vec3(mix (clamp (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
  , 0.0, 1.0), 1.0, (tmpvar_13 * 
    (tmpvar_13 * (3.0 - (2.0 * tmpvar_13)))
  ))));
  cloudCol_1.w = clamp (cloudCol_1.w, 0.0, 1.0);
  gl_FragData[0] = cloudCol_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FIXED_RIMLIGHT_WIDTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec4 _ES_TopFrontColor;
uniform mediump vec4 _ES_TopBackColor;
uniform mediump vec4 _ES_BottomFrontColor;
uniform mediump vec4 _ES_BottomBackColor;
uniform mediump float _ES_SkyFrontAndBackBlendFactor;
uniform mediump float _ES_BottomColorHeight;
uniform mediump vec3 _ES_HorizonHaloColor;
uniform mediump float _ES_HorizonHaloIntensity;
uniform mediump float _ES_HorizonHaloHeight;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump float _ES_SunHaloSize;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudAgePercent;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform sampler2D _SkyGradientTex;
uniform highp vec2 _AtlasTiles;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
uniform mediump float _FixedRimLightWidth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float agePercent_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 clipPos_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  clipPos_6.xyw = tmpvar_7.xyw;
  clipPos_6.z = tmpvar_7.w;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7.xyww * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = clipPos_6.zw;
  highp int tmpvar_12;
  tmpvar_12 = int(floor((
    (_glesColor.y * ((_AtlasTiles.x * _AtlasTiles.y) - 1.0))
   + 0.5)));
  highp vec2 tmpvar_13;
  tmpvar_13.x = (float(mod (float(tmpvar_12), _AtlasTiles.x)));
  tmpvar_13.y = floor((float(tmpvar_12) / _AtlasTiles.x));
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy + tmpvar_13) / _AtlasTiles);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _CloudCurlTiling) + ((_ES_CloudElapsedTime * vec2(1.2, 0.8)) * _CloudCurlSpeed));
  mediump vec3 viewDir_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(((unity_ObjectToWorld * tmpvar_15).xyz - _ES_SkyCenterWorldPos));
  viewDir_14 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (_ES_SkyWorldUpDir, viewDir_14);
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = viewDir_14;
  tmpvar_18.w = ((sign(tmpvar_17) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_17))) * (1.570796 + (abs(tmpvar_17) * (-0.2146018 + 
      (abs(tmpvar_17) * (0.08656672 + (abs(tmpvar_17) * -0.03102955)))
    ))))
  )) * 0.6366198);
  mediump float tmpvar_19;
  tmpvar_19 = dot (viewDir_14, _ES_SunDirection);
  mediump float tmpvar_20;
  tmpvar_20 = ((tmpvar_19 * 0.5) + 0.5);
  tmpvar_4.x = (tmpvar_20 * _ES_CloudSunBrightenIntensity);
  tmpvar_4.y = _glesColor.z;
  tmpvar_4.z = _FixedRimLightWidth;
  highp float tmpvar_21;
  tmpvar_21 = (_glesMultiTexCoord1.y / max (_glesMultiTexCoord1.x, 1e-05));
  agePercent_2 = tmpvar_21;
  agePercent_2 = (agePercent_2 * _ES_CloudAgePercent);
  highp float tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = clamp ((agePercent_2 / _glesMultiTexCoord1.z), 0.0, 1.0);
  tmpvar_22 = (tmpvar_23 * (tmpvar_23 * (3.0 - 
    (2.0 * tmpvar_23)
  )));
  highp float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((agePercent_2 - _glesMultiTexCoord1.w) / (1.0 - _glesMultiTexCoord1.w)), 0.0, 1.0);
  tmpvar_24 = (tmpvar_25 * (tmpvar_25 * (3.0 - 
    (2.0 * tmpvar_25)
  )));
  tmpvar_4.w = (1.0 - (tmpvar_22 * (1.0 - tmpvar_24)));
  mediump vec3 atomosphere_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (_ES_SunDirection, viewDir_14);
  mediump float tmpvar_28;
  tmpvar_28 = max (((tmpvar_27 * _ES_SkyFrontAndBackBlendFactor) + (1.0 - _ES_SkyFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_29;
  tmpvar_29 = ((tmpvar_28 * tmpvar_28) * tmpvar_28);
  mediump vec4 tmpvar_30;
  tmpvar_30.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_30.x = (abs(tmpvar_18.w) / max (_ES_BottomColorHeight, 0.0001));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DLod (_SkyGradientTex, tmpvar_30.xy, 0.0);
  mediump float tmpvar_32;
  tmpvar_32 = tmpvar_31.x;
  atomosphere_26 = mix (mix (_ES_TopBackColor, _ES_TopFrontColor, vec4(tmpvar_29)).xyz, mix (_ES_BottomBackColor, _ES_BottomFrontColor, vec4(tmpvar_29)).xyz, vec3(tmpvar_32));
  mediump vec4 tmpvar_33;
  tmpvar_33.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_33.x = (abs(tmpvar_18.w) / max (_ES_HorizonHaloHeight, 0.0001));
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DLod (_SkyGradientTex, tmpvar_33.xy, 0.0);
  mediump float tmpvar_35;
  tmpvar_35 = tmpvar_34.y;
  mediump float tmpvar_36;
  tmpvar_36 = clamp (((
    max (((tmpvar_27 * 0.5) + 0.5), 0.0)
   - 0.3) / 0.7), 0.0, 1.0);
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    abs(_ES_SunDirection.y)
   - 0.2) / 0.3), 0.0, 1.0);
  atomosphere_26 = (atomosphere_26 + ((
    (_ES_HorizonHaloColor * _ES_HorizonHaloIntensity)
   * tmpvar_35) * mix (
    (tmpvar_36 * (tmpvar_36 * (3.0 - (2.0 * tmpvar_36))))
  , 1.0, 
    (tmpvar_37 * (tmpvar_37 * (3.0 - (2.0 * tmpvar_37))))
  )));
  highp vec3 viewDir_38;
  viewDir_38 = tmpvar_18.xyz;
  highp float haloInfluence_39;
  mediump float vertical_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((
    dot (_ES_SunDirection, viewDir_38)
   * 0.5) + 0.5), 0.0, 1.0);
  highp float tmpvar_42;
  tmpvar_42 = dot (viewDir_38, _ES_SkyWorldUpDir);
  vertical_40 = tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = abs(vertical_40);
  mediump float y_44;
  y_44 = (_ES_SunHaloSize * tmpvar_43);
  mediump float y_45;
  y_45 = ((_ES_SunHaloSize * 0.1) * tmpvar_43);
  haloInfluence_39 = (clamp (pow (tmpvar_41, y_44), 0.0, 1.0) + (clamp (
    pow (tmpvar_41, y_45)
  , 0.0, 1.0) * 0.12));
  mediump float y_46;
  y_46 = ((_ES_SunHaloSize * 0.01) * tmpvar_43);
  haloInfluence_39 = (haloInfluence_39 + (clamp (
    pow (tmpvar_41, y_46)
  , 0.0, 1.0) * 0.03));
  highp float tmpvar_47;
  tmpvar_47 = clamp (((
    max (((dot (_ES_SunDirection, viewDir_38) * 0.5) + 0.5), 0.0)
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 tmpvar_48;
  tmpvar_48 = (((haloInfluence_39 * _ES_SunHaloIntensity) * _ES_SunHaloColor) * (tmpvar_47 * (tmpvar_47 * 
    (3.0 - (2.0 * tmpvar_47))
  )));
  tmpvar_5 = (atomosphere_26 + tmpvar_48);
  mediump float tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_49 = (tmpvar_50 * (tmpvar_50 * (3.0 - 
    (2.0 * tmpvar_50)
  )));
  highp vec3 viewDir_51;
  viewDir_51 = tmpvar_18.xyz;
  mediump float moonLunarCancel_52;
  mediump float tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (_ES_MoonDirection, viewDir_51), 0.0, 1.0);
  tmpvar_53 = tmpvar_54;
  highp float tmpvar_55;
  mediump float tmpvar_56;
  tmpvar_56 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_55 = (1.0 - (tmpvar_56 * 2.0));
  moonLunarCancel_52 = tmpvar_55;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((
    ((tmpvar_53 * tmpvar_53) * ((tmpvar_53 * tmpvar_53) * tmpvar_53))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_58;
  viewDir_58 = tmpvar_18.xyz;
  mediump float vertical_59;
  mediump float tmpvar_60;
  highp float tmpvar_61;
  tmpvar_61 = clamp (((
    dot (_ES_SunDirection, viewDir_58)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_60 = tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = dot (viewDir_58, _ES_SkyWorldUpDir);
  vertical_59 = tmpvar_62;
  mediump float tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = (1.0 - _ES_SunRimLightRadius);
  tmpvar_63 = clamp (((tmpvar_20 - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (((tmpvar_63 * 
    (tmpvar_63 * (3.0 - (2.0 * tmpvar_63)))
  ) * _ES_SunBrightness) * 0.125);
  mediump float tmpvar_66;
  tmpvar_66 = clamp (((
    ((dot (viewDir_14, _ES_MoonDirection) * 0.5) + 0.5)
   - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_67;
  tmpvar_67 = (((tmpvar_66 * 
    (tmpvar_66 * (3.0 - (2.0 * tmpvar_66)))
  ) * _ES_MoonBrightness) * 0.1);
  mediump float tmpvar_68;
  tmpvar_68 = max (((tmpvar_19 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_69;
  tmpvar_69 = ((tmpvar_68 * tmpvar_68) * tmpvar_68);
  gl_Position = clipPos_6;
  xlv_TEXCOORD0 = o_9;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = (((
    ((((tmpvar_57 * 
      (tmpvar_57 * (3.0 - (2.0 * tmpvar_57)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_52) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_60, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_59))
    ) * vertical_59), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_49);
  xlv_TEXCOORD6 = (((_ES_SunHaloColor * 
    (tmpvar_65 * tmpvar_65)
  ) + (_ES_MoonColor * 
    (tmpvar_67 * tmpvar_67)
  )) * tmpvar_49);
  xlv_TEXCOORD7 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_69));
  xlv_TEXCOORD8 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_69));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_CloudCoverage;
uniform sampler2D _CloudParticleAtlas;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 cloudCol_1;
  mediump vec4 texCol_2;
  highp vec3 curlNoise_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_CloudCurlTex, xlv_TEXCOORD1.zw).xyz;
  curlNoise_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD1.xy + ((
    (curlNoise_3.xy - 0.5)
   * curlNoise_3.z) * _CloudCurlAmplitude));
  tmpvar_5 = texture2D (_CloudParticleAtlas, P_6);
  texCol_2 = tmpvar_5;
  mediump float tmpvar_7;
  tmpvar_7 = max ((xlv_TEXCOORD3.w - xlv_TEXCOORD3.y), 0.0);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.y), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD2.w - -0.1) / 0.2), 0.0, 1.0);
  cloudCol_1.w = ((texCol_2.w * (tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  )) * (tmpvar_9 * (tmpvar_9 * 
    (3.0 - (2.0 * tmpvar_9))
  )));
  mediump float x_10;
  x_10 = (cloudCol_1.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.z), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  cloudCol_1.xyz = ((mix (xlv_TEXCOORD8, xlv_TEXCOORD7, texCol_2.xxx) + (xlv_TEXCOORD6 * 
    mix (texCol_2.y, ((1.0 - (tmpvar_11 * 
      (tmpvar_11 * (3.0 - (2.0 * tmpvar_11)))
    )) * 4.0), xlv_TEXCOORD3.w)
  )) + ((0.4 * xlv_TEXCOORD7) * _ES_CloudCoverage));
  cloudCol_1.xyz = (cloudCol_1.xyz + (xlv_TEXCOORD5 * texCol_2.x));
  cloudCol_1.xyz = (cloudCol_1.xyz * (xlv_TEXCOORD3.x + 1.0));
  mediump float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD2.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((_ES_CloudCoverage - 0.4) / 0.3), 0.0, 1.0);
  cloudCol_1.xyz = mix (xlv_TEXCOORD4, cloudCol_1.xyz, vec3(mix (clamp (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
  , 0.0, 1.0), 1.0, (tmpvar_13 * 
    (tmpvar_13 * (3.0 - (2.0 * tmpvar_13)))
  ))));
  cloudCol_1.w = clamp (cloudCol_1.w, 0.0, 1.0);
  gl_FragData[0] = cloudCol_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "FIXED_RIMLIGHT_WIDTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec4 _ES_TopFrontColor;
uniform mediump vec4 _ES_TopBackColor;
uniform mediump vec4 _ES_BottomFrontColor;
uniform mediump vec4 _ES_BottomBackColor;
uniform mediump float _ES_SkyFrontAndBackBlendFactor;
uniform mediump float _ES_BottomColorHeight;
uniform mediump vec3 _ES_HorizonHaloColor;
uniform mediump float _ES_HorizonHaloIntensity;
uniform mediump float _ES_HorizonHaloHeight;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump float _ES_SunHaloSize;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudAgePercent;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform sampler2D _SkyGradientTex;
uniform highp vec2 _AtlasTiles;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
uniform mediump float _FixedRimLightWidth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float agePercent_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 clipPos_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  clipPos_6.xyw = tmpvar_7.xyw;
  clipPos_6.z = tmpvar_7.w;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7.xyww * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = clipPos_6.zw;
  highp int tmpvar_12;
  tmpvar_12 = int(floor((
    (_glesColor.y * ((_AtlasTiles.x * _AtlasTiles.y) - 1.0))
   + 0.5)));
  highp vec2 tmpvar_13;
  tmpvar_13.x = (float(mod (float(tmpvar_12), _AtlasTiles.x)));
  tmpvar_13.y = floor((float(tmpvar_12) / _AtlasTiles.x));
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy + tmpvar_13) / _AtlasTiles);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _CloudCurlTiling) + ((_ES_CloudElapsedTime * vec2(1.2, 0.8)) * _CloudCurlSpeed));
  mediump vec3 viewDir_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(((unity_ObjectToWorld * tmpvar_15).xyz - _ES_SkyCenterWorldPos));
  viewDir_14 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (_ES_SkyWorldUpDir, viewDir_14);
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = viewDir_14;
  tmpvar_18.w = ((sign(tmpvar_17) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_17))) * (1.570796 + (abs(tmpvar_17) * (-0.2146018 + 
      (abs(tmpvar_17) * (0.08656672 + (abs(tmpvar_17) * -0.03102955)))
    ))))
  )) * 0.6366198);
  mediump float tmpvar_19;
  tmpvar_19 = dot (viewDir_14, _ES_SunDirection);
  mediump float tmpvar_20;
  tmpvar_20 = ((tmpvar_19 * 0.5) + 0.5);
  tmpvar_4.x = (tmpvar_20 * _ES_CloudSunBrightenIntensity);
  tmpvar_4.y = _glesColor.z;
  tmpvar_4.z = _FixedRimLightWidth;
  highp float tmpvar_21;
  tmpvar_21 = (_glesMultiTexCoord1.y / max (_glesMultiTexCoord1.x, 1e-05));
  agePercent_2 = tmpvar_21;
  agePercent_2 = (agePercent_2 * _ES_CloudAgePercent);
  highp float tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = clamp ((agePercent_2 / _glesMultiTexCoord1.z), 0.0, 1.0);
  tmpvar_22 = (tmpvar_23 * (tmpvar_23 * (3.0 - 
    (2.0 * tmpvar_23)
  )));
  highp float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((agePercent_2 - _glesMultiTexCoord1.w) / (1.0 - _glesMultiTexCoord1.w)), 0.0, 1.0);
  tmpvar_24 = (tmpvar_25 * (tmpvar_25 * (3.0 - 
    (2.0 * tmpvar_25)
  )));
  tmpvar_4.w = (1.0 - (tmpvar_22 * (1.0 - tmpvar_24)));
  mediump vec3 atomosphere_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (_ES_SunDirection, viewDir_14);
  mediump float tmpvar_28;
  tmpvar_28 = max (((tmpvar_27 * _ES_SkyFrontAndBackBlendFactor) + (1.0 - _ES_SkyFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_29;
  tmpvar_29 = ((tmpvar_28 * tmpvar_28) * tmpvar_28);
  mediump vec4 tmpvar_30;
  tmpvar_30.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_30.x = (abs(tmpvar_18.w) / max (_ES_BottomColorHeight, 0.0001));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DLod (_SkyGradientTex, tmpvar_30.xy, 0.0);
  mediump float tmpvar_32;
  tmpvar_32 = tmpvar_31.x;
  atomosphere_26 = mix (mix (_ES_TopBackColor, _ES_TopFrontColor, vec4(tmpvar_29)).xyz, mix (_ES_BottomBackColor, _ES_BottomFrontColor, vec4(tmpvar_29)).xyz, vec3(tmpvar_32));
  mediump vec4 tmpvar_33;
  tmpvar_33.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_33.x = (abs(tmpvar_18.w) / max (_ES_HorizonHaloHeight, 0.0001));
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DLod (_SkyGradientTex, tmpvar_33.xy, 0.0);
  mediump float tmpvar_35;
  tmpvar_35 = tmpvar_34.y;
  mediump float tmpvar_36;
  tmpvar_36 = clamp (((
    max (((tmpvar_27 * 0.5) + 0.5), 0.0)
   - 0.3) / 0.7), 0.0, 1.0);
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    abs(_ES_SunDirection.y)
   - 0.2) / 0.3), 0.0, 1.0);
  atomosphere_26 = (atomosphere_26 + ((
    (_ES_HorizonHaloColor * _ES_HorizonHaloIntensity)
   * tmpvar_35) * mix (
    (tmpvar_36 * (tmpvar_36 * (3.0 - (2.0 * tmpvar_36))))
  , 1.0, 
    (tmpvar_37 * (tmpvar_37 * (3.0 - (2.0 * tmpvar_37))))
  )));
  highp vec3 viewDir_38;
  viewDir_38 = tmpvar_18.xyz;
  highp float haloInfluence_39;
  mediump float vertical_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((
    dot (_ES_SunDirection, viewDir_38)
   * 0.5) + 0.5), 0.0, 1.0);
  highp float tmpvar_42;
  tmpvar_42 = dot (viewDir_38, _ES_SkyWorldUpDir);
  vertical_40 = tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = abs(vertical_40);
  mediump float y_44;
  y_44 = (_ES_SunHaloSize * tmpvar_43);
  mediump float y_45;
  y_45 = ((_ES_SunHaloSize * 0.1) * tmpvar_43);
  haloInfluence_39 = (clamp (pow (tmpvar_41, y_44), 0.0, 1.0) + (clamp (
    pow (tmpvar_41, y_45)
  , 0.0, 1.0) * 0.12));
  mediump float y_46;
  y_46 = ((_ES_SunHaloSize * 0.01) * tmpvar_43);
  haloInfluence_39 = (haloInfluence_39 + (clamp (
    pow (tmpvar_41, y_46)
  , 0.0, 1.0) * 0.03));
  highp float tmpvar_47;
  tmpvar_47 = clamp (((
    max (((dot (_ES_SunDirection, viewDir_38) * 0.5) + 0.5), 0.0)
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 tmpvar_48;
  tmpvar_48 = (((haloInfluence_39 * _ES_SunHaloIntensity) * _ES_SunHaloColor) * (tmpvar_47 * (tmpvar_47 * 
    (3.0 - (2.0 * tmpvar_47))
  )));
  tmpvar_5 = (atomosphere_26 + tmpvar_48);
  mediump float tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_49 = (tmpvar_50 * (tmpvar_50 * (3.0 - 
    (2.0 * tmpvar_50)
  )));
  highp vec3 viewDir_51;
  viewDir_51 = tmpvar_18.xyz;
  mediump float moonLunarCancel_52;
  mediump float tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (_ES_MoonDirection, viewDir_51), 0.0, 1.0);
  tmpvar_53 = tmpvar_54;
  highp float tmpvar_55;
  mediump float tmpvar_56;
  tmpvar_56 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_55 = (1.0 - (tmpvar_56 * 2.0));
  moonLunarCancel_52 = tmpvar_55;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((
    ((tmpvar_53 * tmpvar_53) * ((tmpvar_53 * tmpvar_53) * tmpvar_53))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_58;
  viewDir_58 = tmpvar_18.xyz;
  mediump float vertical_59;
  mediump float tmpvar_60;
  highp float tmpvar_61;
  tmpvar_61 = clamp (((
    dot (_ES_SunDirection, viewDir_58)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_60 = tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = dot (viewDir_58, _ES_SkyWorldUpDir);
  vertical_59 = tmpvar_62;
  mediump float tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = (1.0 - _ES_SunRimLightRadius);
  tmpvar_63 = clamp (((tmpvar_20 - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (((tmpvar_63 * 
    (tmpvar_63 * (3.0 - (2.0 * tmpvar_63)))
  ) * _ES_SunBrightness) * 0.125);
  mediump float tmpvar_66;
  tmpvar_66 = clamp (((
    ((dot (viewDir_14, _ES_MoonDirection) * 0.5) + 0.5)
   - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_67;
  tmpvar_67 = (((tmpvar_66 * 
    (tmpvar_66 * (3.0 - (2.0 * tmpvar_66)))
  ) * _ES_MoonBrightness) * 0.1);
  mediump float tmpvar_68;
  tmpvar_68 = max (((tmpvar_19 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_69;
  tmpvar_69 = ((tmpvar_68 * tmpvar_68) * tmpvar_68);
  gl_Position = clipPos_6;
  xlv_TEXCOORD0 = o_9;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = (((
    ((((tmpvar_57 * 
      (tmpvar_57 * (3.0 - (2.0 * tmpvar_57)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_52) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_60, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_59))
    ) * vertical_59), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_49);
  xlv_TEXCOORD6 = (((_ES_SunHaloColor * 
    (tmpvar_65 * tmpvar_65)
  ) + (_ES_MoonColor * 
    (tmpvar_67 * tmpvar_67)
  )) * tmpvar_49);
  xlv_TEXCOORD7 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_69));
  xlv_TEXCOORD8 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_69));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_CloudCoverage;
uniform sampler2D _CloudParticleAtlas;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 cloudCol_1;
  mediump vec4 texCol_2;
  highp vec3 curlNoise_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_CloudCurlTex, xlv_TEXCOORD1.zw).xyz;
  curlNoise_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD1.xy + ((
    (curlNoise_3.xy - 0.5)
   * curlNoise_3.z) * _CloudCurlAmplitude));
  tmpvar_5 = texture2D (_CloudParticleAtlas, P_6);
  texCol_2 = tmpvar_5;
  mediump float tmpvar_7;
  tmpvar_7 = max ((xlv_TEXCOORD3.w - xlv_TEXCOORD3.y), 0.0);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.y), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD2.w - -0.1) / 0.2), 0.0, 1.0);
  cloudCol_1.w = ((texCol_2.w * (tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  )) * (tmpvar_9 * (tmpvar_9 * 
    (3.0 - (2.0 * tmpvar_9))
  )));
  mediump float x_10;
  x_10 = (cloudCol_1.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.z), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  cloudCol_1.xyz = ((mix (xlv_TEXCOORD8, xlv_TEXCOORD7, texCol_2.xxx) + (xlv_TEXCOORD6 * 
    mix (texCol_2.y, ((1.0 - (tmpvar_11 * 
      (tmpvar_11 * (3.0 - (2.0 * tmpvar_11)))
    )) * 4.0), xlv_TEXCOORD3.w)
  )) + ((0.4 * xlv_TEXCOORD7) * _ES_CloudCoverage));
  cloudCol_1.xyz = (cloudCol_1.xyz + (xlv_TEXCOORD5 * texCol_2.x));
  cloudCol_1.xyz = (cloudCol_1.xyz * (xlv_TEXCOORD3.x + 1.0));
  mediump float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD2.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((_ES_CloudCoverage - 0.4) / 0.3), 0.0, 1.0);
  cloudCol_1.xyz = mix (xlv_TEXCOORD4, cloudCol_1.xyz, vec3(mix (clamp (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
  , 0.0, 1.0), 1.0, (tmpvar_13 * 
    (tmpvar_13 * (3.0 - (2.0 * tmpvar_13)))
  ))));
  cloudCol_1.w = clamp (cloudCol_1.w, 0.0, 1.0);
  gl_FragData[0] = cloudCol_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "FIXED_RIMLIGHT_WIDTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec4 _ES_TopFrontColor;
uniform mediump vec4 _ES_TopBackColor;
uniform mediump vec4 _ES_BottomFrontColor;
uniform mediump vec4 _ES_BottomBackColor;
uniform mediump float _ES_SkyFrontAndBackBlendFactor;
uniform mediump float _ES_BottomColorHeight;
uniform mediump vec3 _ES_HorizonHaloColor;
uniform mediump float _ES_HorizonHaloIntensity;
uniform mediump float _ES_HorizonHaloHeight;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump float _ES_SunHaloSize;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudAgePercent;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform sampler2D _SkyGradientTex;
uniform highp vec2 _AtlasTiles;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
uniform mediump float _FixedRimLightWidth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float agePercent_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 clipPos_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  clipPos_6.xyw = tmpvar_7.xyw;
  clipPos_6.z = tmpvar_7.w;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7.xyww * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = clipPos_6.zw;
  highp int tmpvar_12;
  tmpvar_12 = int(floor((
    (_glesColor.y * ((_AtlasTiles.x * _AtlasTiles.y) - 1.0))
   + 0.5)));
  highp vec2 tmpvar_13;
  tmpvar_13.x = (float(mod (float(tmpvar_12), _AtlasTiles.x)));
  tmpvar_13.y = floor((float(tmpvar_12) / _AtlasTiles.x));
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy + tmpvar_13) / _AtlasTiles);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _CloudCurlTiling) + ((_ES_CloudElapsedTime * vec2(1.2, 0.8)) * _CloudCurlSpeed));
  mediump vec3 viewDir_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(((unity_ObjectToWorld * tmpvar_15).xyz - _ES_SkyCenterWorldPos));
  viewDir_14 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (_ES_SkyWorldUpDir, viewDir_14);
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = viewDir_14;
  tmpvar_18.w = ((sign(tmpvar_17) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_17))) * (1.570796 + (abs(tmpvar_17) * (-0.2146018 + 
      (abs(tmpvar_17) * (0.08656672 + (abs(tmpvar_17) * -0.03102955)))
    ))))
  )) * 0.6366198);
  mediump float tmpvar_19;
  tmpvar_19 = dot (viewDir_14, _ES_SunDirection);
  mediump float tmpvar_20;
  tmpvar_20 = ((tmpvar_19 * 0.5) + 0.5);
  tmpvar_4.x = (tmpvar_20 * _ES_CloudSunBrightenIntensity);
  tmpvar_4.y = _glesColor.z;
  tmpvar_4.z = _FixedRimLightWidth;
  highp float tmpvar_21;
  tmpvar_21 = (_glesMultiTexCoord1.y / max (_glesMultiTexCoord1.x, 1e-05));
  agePercent_2 = tmpvar_21;
  agePercent_2 = (agePercent_2 * _ES_CloudAgePercent);
  highp float tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = clamp ((agePercent_2 / _glesMultiTexCoord1.z), 0.0, 1.0);
  tmpvar_22 = (tmpvar_23 * (tmpvar_23 * (3.0 - 
    (2.0 * tmpvar_23)
  )));
  highp float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((agePercent_2 - _glesMultiTexCoord1.w) / (1.0 - _glesMultiTexCoord1.w)), 0.0, 1.0);
  tmpvar_24 = (tmpvar_25 * (tmpvar_25 * (3.0 - 
    (2.0 * tmpvar_25)
  )));
  tmpvar_4.w = (1.0 - (tmpvar_22 * (1.0 - tmpvar_24)));
  mediump vec3 atomosphere_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (_ES_SunDirection, viewDir_14);
  mediump float tmpvar_28;
  tmpvar_28 = max (((tmpvar_27 * _ES_SkyFrontAndBackBlendFactor) + (1.0 - _ES_SkyFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_29;
  tmpvar_29 = ((tmpvar_28 * tmpvar_28) * tmpvar_28);
  mediump vec4 tmpvar_30;
  tmpvar_30.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_30.x = (abs(tmpvar_18.w) / max (_ES_BottomColorHeight, 0.0001));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DLod (_SkyGradientTex, tmpvar_30.xy, 0.0);
  mediump float tmpvar_32;
  tmpvar_32 = tmpvar_31.x;
  atomosphere_26 = mix (mix (_ES_TopBackColor, _ES_TopFrontColor, vec4(tmpvar_29)).xyz, mix (_ES_BottomBackColor, _ES_BottomFrontColor, vec4(tmpvar_29)).xyz, vec3(tmpvar_32));
  mediump vec4 tmpvar_33;
  tmpvar_33.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_33.x = (abs(tmpvar_18.w) / max (_ES_HorizonHaloHeight, 0.0001));
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DLod (_SkyGradientTex, tmpvar_33.xy, 0.0);
  mediump float tmpvar_35;
  tmpvar_35 = tmpvar_34.y;
  mediump float tmpvar_36;
  tmpvar_36 = clamp (((
    max (((tmpvar_27 * 0.5) + 0.5), 0.0)
   - 0.3) / 0.7), 0.0, 1.0);
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    abs(_ES_SunDirection.y)
   - 0.2) / 0.3), 0.0, 1.0);
  atomosphere_26 = (atomosphere_26 + ((
    (_ES_HorizonHaloColor * _ES_HorizonHaloIntensity)
   * tmpvar_35) * mix (
    (tmpvar_36 * (tmpvar_36 * (3.0 - (2.0 * tmpvar_36))))
  , 1.0, 
    (tmpvar_37 * (tmpvar_37 * (3.0 - (2.0 * tmpvar_37))))
  )));
  highp vec3 viewDir_38;
  viewDir_38 = tmpvar_18.xyz;
  highp float haloInfluence_39;
  mediump float vertical_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((
    dot (_ES_SunDirection, viewDir_38)
   * 0.5) + 0.5), 0.0, 1.0);
  highp float tmpvar_42;
  tmpvar_42 = dot (viewDir_38, _ES_SkyWorldUpDir);
  vertical_40 = tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = abs(vertical_40);
  mediump float y_44;
  y_44 = (_ES_SunHaloSize * tmpvar_43);
  mediump float y_45;
  y_45 = ((_ES_SunHaloSize * 0.1) * tmpvar_43);
  haloInfluence_39 = (clamp (pow (tmpvar_41, y_44), 0.0, 1.0) + (clamp (
    pow (tmpvar_41, y_45)
  , 0.0, 1.0) * 0.12));
  mediump float y_46;
  y_46 = ((_ES_SunHaloSize * 0.01) * tmpvar_43);
  haloInfluence_39 = (haloInfluence_39 + (clamp (
    pow (tmpvar_41, y_46)
  , 0.0, 1.0) * 0.03));
  highp float tmpvar_47;
  tmpvar_47 = clamp (((
    max (((dot (_ES_SunDirection, viewDir_38) * 0.5) + 0.5), 0.0)
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 tmpvar_48;
  tmpvar_48 = (((haloInfluence_39 * _ES_SunHaloIntensity) * _ES_SunHaloColor) * (tmpvar_47 * (tmpvar_47 * 
    (3.0 - (2.0 * tmpvar_47))
  )));
  tmpvar_5 = (atomosphere_26 + tmpvar_48);
  mediump float tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_49 = (tmpvar_50 * (tmpvar_50 * (3.0 - 
    (2.0 * tmpvar_50)
  )));
  highp vec3 viewDir_51;
  viewDir_51 = tmpvar_18.xyz;
  mediump float moonLunarCancel_52;
  mediump float tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (_ES_MoonDirection, viewDir_51), 0.0, 1.0);
  tmpvar_53 = tmpvar_54;
  highp float tmpvar_55;
  mediump float tmpvar_56;
  tmpvar_56 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_55 = (1.0 - (tmpvar_56 * 2.0));
  moonLunarCancel_52 = tmpvar_55;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((
    ((tmpvar_53 * tmpvar_53) * ((tmpvar_53 * tmpvar_53) * tmpvar_53))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_58;
  viewDir_58 = tmpvar_18.xyz;
  mediump float vertical_59;
  mediump float tmpvar_60;
  highp float tmpvar_61;
  tmpvar_61 = clamp (((
    dot (_ES_SunDirection, viewDir_58)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_60 = tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = dot (viewDir_58, _ES_SkyWorldUpDir);
  vertical_59 = tmpvar_62;
  mediump float tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = (1.0 - _ES_SunRimLightRadius);
  tmpvar_63 = clamp (((tmpvar_20 - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (((tmpvar_63 * 
    (tmpvar_63 * (3.0 - (2.0 * tmpvar_63)))
  ) * _ES_SunBrightness) * 0.125);
  mediump float tmpvar_66;
  tmpvar_66 = clamp (((
    ((dot (viewDir_14, _ES_MoonDirection) * 0.5) + 0.5)
   - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_67;
  tmpvar_67 = (((tmpvar_66 * 
    (tmpvar_66 * (3.0 - (2.0 * tmpvar_66)))
  ) * _ES_MoonBrightness) * 0.1);
  mediump float tmpvar_68;
  tmpvar_68 = max (((tmpvar_19 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_69;
  tmpvar_69 = ((tmpvar_68 * tmpvar_68) * tmpvar_68);
  gl_Position = clipPos_6;
  xlv_TEXCOORD0 = o_9;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = (((
    ((((tmpvar_57 * 
      (tmpvar_57 * (3.0 - (2.0 * tmpvar_57)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_52) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_60, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_59))
    ) * vertical_59), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_49);
  xlv_TEXCOORD6 = (((_ES_SunHaloColor * 
    (tmpvar_65 * tmpvar_65)
  ) + (_ES_MoonColor * 
    (tmpvar_67 * tmpvar_67)
  )) * tmpvar_49);
  xlv_TEXCOORD7 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_69));
  xlv_TEXCOORD8 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_69));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_CloudCoverage;
uniform sampler2D _CloudParticleAtlas;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 cloudCol_1;
  mediump vec4 texCol_2;
  highp vec3 curlNoise_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_CloudCurlTex, xlv_TEXCOORD1.zw).xyz;
  curlNoise_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD1.xy + ((
    (curlNoise_3.xy - 0.5)
   * curlNoise_3.z) * _CloudCurlAmplitude));
  tmpvar_5 = texture2D (_CloudParticleAtlas, P_6);
  texCol_2 = tmpvar_5;
  mediump float tmpvar_7;
  tmpvar_7 = max ((xlv_TEXCOORD3.w - xlv_TEXCOORD3.y), 0.0);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.y), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD2.w - -0.1) / 0.2), 0.0, 1.0);
  cloudCol_1.w = ((texCol_2.w * (tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  )) * (tmpvar_9 * (tmpvar_9 * 
    (3.0 - (2.0 * tmpvar_9))
  )));
  mediump float x_10;
  x_10 = (cloudCol_1.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.z), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  cloudCol_1.xyz = ((mix (xlv_TEXCOORD8, xlv_TEXCOORD7, texCol_2.xxx) + (xlv_TEXCOORD6 * 
    mix (texCol_2.y, ((1.0 - (tmpvar_11 * 
      (tmpvar_11 * (3.0 - (2.0 * tmpvar_11)))
    )) * 4.0), xlv_TEXCOORD3.w)
  )) + ((0.4 * xlv_TEXCOORD7) * _ES_CloudCoverage));
  cloudCol_1.xyz = (cloudCol_1.xyz + (xlv_TEXCOORD5 * texCol_2.x));
  cloudCol_1.xyz = (cloudCol_1.xyz * (xlv_TEXCOORD3.x + 1.0));
  mediump float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD2.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((_ES_CloudCoverage - 0.4) / 0.3), 0.0, 1.0);
  cloudCol_1.xyz = mix (xlv_TEXCOORD4, cloudCol_1.xyz, vec3(mix (clamp (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
  , 0.0, 1.0), 1.0, (tmpvar_13 * 
    (tmpvar_13 * (3.0 - (2.0 * tmpvar_13)))
  ))));
  cloudCol_1.w = clamp (cloudCol_1.w, 0.0, 1.0);
  gl_FragData[0] = cloudCol_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "FIXED_RIMLIGHT_WIDTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec4 _ES_TopFrontColor;
uniform mediump vec4 _ES_TopBackColor;
uniform mediump vec4 _ES_BottomFrontColor;
uniform mediump vec4 _ES_BottomBackColor;
uniform mediump float _ES_SkyFrontAndBackBlendFactor;
uniform mediump float _ES_BottomColorHeight;
uniform mediump vec3 _ES_HorizonHaloColor;
uniform mediump float _ES_HorizonHaloIntensity;
uniform mediump float _ES_HorizonHaloHeight;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump float _ES_SunHaloSize;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudAgePercent;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform sampler2D _SkyGradientTex;
uniform highp vec2 _AtlasTiles;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
uniform mediump float _FixedRimLightWidth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float agePercent_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 clipPos_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  clipPos_6.xyw = tmpvar_7.xyw;
  clipPos_6.z = tmpvar_7.w;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7.xyww * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = clipPos_6.zw;
  highp int tmpvar_12;
  tmpvar_12 = int(floor((
    (_glesColor.y * ((_AtlasTiles.x * _AtlasTiles.y) - 1.0))
   + 0.5)));
  highp vec2 tmpvar_13;
  tmpvar_13.x = (float(mod (float(tmpvar_12), _AtlasTiles.x)));
  tmpvar_13.y = floor((float(tmpvar_12) / _AtlasTiles.x));
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy + tmpvar_13) / _AtlasTiles);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _CloudCurlTiling) + ((_ES_CloudElapsedTime * vec2(1.2, 0.8)) * _CloudCurlSpeed));
  mediump vec3 viewDir_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(((unity_ObjectToWorld * tmpvar_15).xyz - _ES_SkyCenterWorldPos));
  viewDir_14 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (_ES_SkyWorldUpDir, viewDir_14);
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = viewDir_14;
  tmpvar_18.w = ((sign(tmpvar_17) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_17))) * (1.570796 + (abs(tmpvar_17) * (-0.2146018 + 
      (abs(tmpvar_17) * (0.08656672 + (abs(tmpvar_17) * -0.03102955)))
    ))))
  )) * 0.6366198);
  mediump float tmpvar_19;
  tmpvar_19 = dot (viewDir_14, _ES_SunDirection);
  mediump float tmpvar_20;
  tmpvar_20 = ((tmpvar_19 * 0.5) + 0.5);
  tmpvar_4.x = (tmpvar_20 * _ES_CloudSunBrightenIntensity);
  tmpvar_4.y = _glesColor.z;
  tmpvar_4.z = _FixedRimLightWidth;
  highp float tmpvar_21;
  tmpvar_21 = (_glesMultiTexCoord1.y / max (_glesMultiTexCoord1.x, 1e-05));
  agePercent_2 = tmpvar_21;
  agePercent_2 = (agePercent_2 * _ES_CloudAgePercent);
  highp float tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = clamp ((agePercent_2 / _glesMultiTexCoord1.z), 0.0, 1.0);
  tmpvar_22 = (tmpvar_23 * (tmpvar_23 * (3.0 - 
    (2.0 * tmpvar_23)
  )));
  highp float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((agePercent_2 - _glesMultiTexCoord1.w) / (1.0 - _glesMultiTexCoord1.w)), 0.0, 1.0);
  tmpvar_24 = (tmpvar_25 * (tmpvar_25 * (3.0 - 
    (2.0 * tmpvar_25)
  )));
  tmpvar_4.w = (1.0 - (tmpvar_22 * (1.0 - tmpvar_24)));
  mediump vec3 atomosphere_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (_ES_SunDirection, viewDir_14);
  mediump float tmpvar_28;
  tmpvar_28 = max (((tmpvar_27 * _ES_SkyFrontAndBackBlendFactor) + (1.0 - _ES_SkyFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_29;
  tmpvar_29 = ((tmpvar_28 * tmpvar_28) * tmpvar_28);
  mediump vec4 tmpvar_30;
  tmpvar_30.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_30.x = (abs(tmpvar_18.w) / max (_ES_BottomColorHeight, 0.0001));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DLod (_SkyGradientTex, tmpvar_30.xy, 0.0);
  mediump float tmpvar_32;
  tmpvar_32 = tmpvar_31.x;
  atomosphere_26 = mix (mix (_ES_TopBackColor, _ES_TopFrontColor, vec4(tmpvar_29)).xyz, mix (_ES_BottomBackColor, _ES_BottomFrontColor, vec4(tmpvar_29)).xyz, vec3(tmpvar_32));
  mediump vec4 tmpvar_33;
  tmpvar_33.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_33.x = (abs(tmpvar_18.w) / max (_ES_HorizonHaloHeight, 0.0001));
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DLod (_SkyGradientTex, tmpvar_33.xy, 0.0);
  mediump float tmpvar_35;
  tmpvar_35 = tmpvar_34.y;
  mediump float tmpvar_36;
  tmpvar_36 = clamp (((
    max (((tmpvar_27 * 0.5) + 0.5), 0.0)
   - 0.3) / 0.7), 0.0, 1.0);
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    abs(_ES_SunDirection.y)
   - 0.2) / 0.3), 0.0, 1.0);
  atomosphere_26 = (atomosphere_26 + ((
    (_ES_HorizonHaloColor * _ES_HorizonHaloIntensity)
   * tmpvar_35) * mix (
    (tmpvar_36 * (tmpvar_36 * (3.0 - (2.0 * tmpvar_36))))
  , 1.0, 
    (tmpvar_37 * (tmpvar_37 * (3.0 - (2.0 * tmpvar_37))))
  )));
  highp vec3 viewDir_38;
  viewDir_38 = tmpvar_18.xyz;
  highp float haloInfluence_39;
  mediump float vertical_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((
    dot (_ES_SunDirection, viewDir_38)
   * 0.5) + 0.5), 0.0, 1.0);
  highp float tmpvar_42;
  tmpvar_42 = dot (viewDir_38, _ES_SkyWorldUpDir);
  vertical_40 = tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = abs(vertical_40);
  mediump float y_44;
  y_44 = (_ES_SunHaloSize * tmpvar_43);
  mediump float y_45;
  y_45 = ((_ES_SunHaloSize * 0.1) * tmpvar_43);
  haloInfluence_39 = (clamp (pow (tmpvar_41, y_44), 0.0, 1.0) + (clamp (
    pow (tmpvar_41, y_45)
  , 0.0, 1.0) * 0.12));
  mediump float y_46;
  y_46 = ((_ES_SunHaloSize * 0.01) * tmpvar_43);
  haloInfluence_39 = (haloInfluence_39 + (clamp (
    pow (tmpvar_41, y_46)
  , 0.0, 1.0) * 0.03));
  highp float tmpvar_47;
  tmpvar_47 = clamp (((
    max (((dot (_ES_SunDirection, viewDir_38) * 0.5) + 0.5), 0.0)
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 tmpvar_48;
  tmpvar_48 = (((haloInfluence_39 * _ES_SunHaloIntensity) * _ES_SunHaloColor) * (tmpvar_47 * (tmpvar_47 * 
    (3.0 - (2.0 * tmpvar_47))
  )));
  tmpvar_5 = (atomosphere_26 + tmpvar_48);
  mediump float tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_49 = (tmpvar_50 * (tmpvar_50 * (3.0 - 
    (2.0 * tmpvar_50)
  )));
  highp vec3 viewDir_51;
  viewDir_51 = tmpvar_18.xyz;
  mediump float moonLunarCancel_52;
  mediump float tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (_ES_MoonDirection, viewDir_51), 0.0, 1.0);
  tmpvar_53 = tmpvar_54;
  highp float tmpvar_55;
  mediump float tmpvar_56;
  tmpvar_56 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_55 = (1.0 - (tmpvar_56 * 2.0));
  moonLunarCancel_52 = tmpvar_55;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((
    ((tmpvar_53 * tmpvar_53) * ((tmpvar_53 * tmpvar_53) * tmpvar_53))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_58;
  viewDir_58 = tmpvar_18.xyz;
  mediump float vertical_59;
  mediump float tmpvar_60;
  highp float tmpvar_61;
  tmpvar_61 = clamp (((
    dot (_ES_SunDirection, viewDir_58)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_60 = tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = dot (viewDir_58, _ES_SkyWorldUpDir);
  vertical_59 = tmpvar_62;
  mediump float tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = (1.0 - _ES_SunRimLightRadius);
  tmpvar_63 = clamp (((tmpvar_20 - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (((tmpvar_63 * 
    (tmpvar_63 * (3.0 - (2.0 * tmpvar_63)))
  ) * _ES_SunBrightness) * 0.125);
  mediump float tmpvar_66;
  tmpvar_66 = clamp (((
    ((dot (viewDir_14, _ES_MoonDirection) * 0.5) + 0.5)
   - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_67;
  tmpvar_67 = (((tmpvar_66 * 
    (tmpvar_66 * (3.0 - (2.0 * tmpvar_66)))
  ) * _ES_MoonBrightness) * 0.1);
  mediump float tmpvar_68;
  tmpvar_68 = max (((tmpvar_19 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_69;
  tmpvar_69 = ((tmpvar_68 * tmpvar_68) * tmpvar_68);
  gl_Position = clipPos_6;
  xlv_TEXCOORD0 = o_9;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = (((
    ((((tmpvar_57 * 
      (tmpvar_57 * (3.0 - (2.0 * tmpvar_57)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_52) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_60, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_59))
    ) * vertical_59), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_49);
  xlv_TEXCOORD6 = (((_ES_SunHaloColor * 
    (tmpvar_65 * tmpvar_65)
  ) + (_ES_MoonColor * 
    (tmpvar_67 * tmpvar_67)
  )) * tmpvar_49);
  xlv_TEXCOORD7 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_69));
  xlv_TEXCOORD8 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_69));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_CloudCoverage;
uniform sampler2D _CloudParticleAtlas;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 cloudCol_1;
  mediump vec4 texCol_2;
  highp vec3 curlNoise_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_CloudCurlTex, xlv_TEXCOORD1.zw).xyz;
  curlNoise_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD1.xy + ((
    (curlNoise_3.xy - 0.5)
   * curlNoise_3.z) * _CloudCurlAmplitude));
  tmpvar_5 = texture2D (_CloudParticleAtlas, P_6);
  texCol_2 = tmpvar_5;
  mediump float tmpvar_7;
  tmpvar_7 = max ((xlv_TEXCOORD3.w - xlv_TEXCOORD3.y), 0.0);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.y), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD2.w - -0.1) / 0.2), 0.0, 1.0);
  cloudCol_1.w = ((texCol_2.w * (tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  )) * (tmpvar_9 * (tmpvar_9 * 
    (3.0 - (2.0 * tmpvar_9))
  )));
  mediump float x_10;
  x_10 = (cloudCol_1.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.z), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  cloudCol_1.xyz = ((mix (xlv_TEXCOORD8, xlv_TEXCOORD7, texCol_2.xxx) + (xlv_TEXCOORD6 * 
    mix (texCol_2.y, ((1.0 - (tmpvar_11 * 
      (tmpvar_11 * (3.0 - (2.0 * tmpvar_11)))
    )) * 4.0), xlv_TEXCOORD3.w)
  )) + ((0.4 * xlv_TEXCOORD7) * _ES_CloudCoverage));
  cloudCol_1.xyz = (cloudCol_1.xyz + (xlv_TEXCOORD5 * texCol_2.x));
  cloudCol_1.xyz = (cloudCol_1.xyz * (xlv_TEXCOORD3.x + 1.0));
  mediump float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD2.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((_ES_CloudCoverage - 0.4) / 0.3), 0.0, 1.0);
  cloudCol_1.xyz = mix (xlv_TEXCOORD4, cloudCol_1.xyz, vec3(mix (clamp (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
  , 0.0, 1.0), 1.0, (tmpvar_13 * 
    (tmpvar_13 * (3.0 - (2.0 * tmpvar_13)))
  ))));
  cloudCol_1.w = clamp (cloudCol_1.w, 0.0, 1.0);
  gl_FragData[0] = cloudCol_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FIXED_EDGE_SMOOTHNESS" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec4 _ES_TopFrontColor;
uniform mediump vec4 _ES_TopBackColor;
uniform mediump vec4 _ES_BottomFrontColor;
uniform mediump vec4 _ES_BottomBackColor;
uniform mediump float _ES_SkyFrontAndBackBlendFactor;
uniform mediump float _ES_BottomColorHeight;
uniform mediump vec3 _ES_HorizonHaloColor;
uniform mediump float _ES_HorizonHaloIntensity;
uniform mediump float _ES_HorizonHaloHeight;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump float _ES_SunHaloSize;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudAgePercent;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform sampler2D _SkyGradientTex;
uniform highp vec2 _AtlasTiles;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
uniform mediump float _FixedEdgeSmoothness;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float agePercent_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 clipPos_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  clipPos_6.xyw = tmpvar_7.xyw;
  clipPos_6.z = tmpvar_7.w;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7.xyww * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = clipPos_6.zw;
  highp int tmpvar_12;
  tmpvar_12 = int(floor((
    (_glesColor.y * ((_AtlasTiles.x * _AtlasTiles.y) - 1.0))
   + 0.5)));
  highp vec2 tmpvar_13;
  tmpvar_13.x = (float(mod (float(tmpvar_12), _AtlasTiles.x)));
  tmpvar_13.y = floor((float(tmpvar_12) / _AtlasTiles.x));
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy + tmpvar_13) / _AtlasTiles);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _CloudCurlTiling) + ((_ES_CloudElapsedTime * vec2(1.2, 0.8)) * _CloudCurlSpeed));
  mediump vec3 viewDir_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(((unity_ObjectToWorld * tmpvar_15).xyz - _ES_SkyCenterWorldPos));
  viewDir_14 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (_ES_SkyWorldUpDir, viewDir_14);
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = viewDir_14;
  tmpvar_18.w = ((sign(tmpvar_17) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_17))) * (1.570796 + (abs(tmpvar_17) * (-0.2146018 + 
      (abs(tmpvar_17) * (0.08656672 + (abs(tmpvar_17) * -0.03102955)))
    ))))
  )) * 0.6366198);
  mediump float tmpvar_19;
  tmpvar_19 = dot (viewDir_14, _ES_SunDirection);
  mediump float tmpvar_20;
  tmpvar_20 = ((tmpvar_19 * 0.5) + 0.5);
  tmpvar_4.x = (tmpvar_20 * _ES_CloudSunBrightenIntensity);
  tmpvar_4.y = _FixedEdgeSmoothness;
  tmpvar_4.z = _glesColor.w;
  highp float tmpvar_21;
  tmpvar_21 = (_glesMultiTexCoord1.y / max (_glesMultiTexCoord1.x, 1e-05));
  agePercent_2 = tmpvar_21;
  agePercent_2 = (agePercent_2 * _ES_CloudAgePercent);
  highp float tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = clamp ((agePercent_2 / _glesMultiTexCoord1.z), 0.0, 1.0);
  tmpvar_22 = (tmpvar_23 * (tmpvar_23 * (3.0 - 
    (2.0 * tmpvar_23)
  )));
  highp float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((agePercent_2 - _glesMultiTexCoord1.w) / (1.0 - _glesMultiTexCoord1.w)), 0.0, 1.0);
  tmpvar_24 = (tmpvar_25 * (tmpvar_25 * (3.0 - 
    (2.0 * tmpvar_25)
  )));
  tmpvar_4.w = (1.0 - (tmpvar_22 * (1.0 - tmpvar_24)));
  mediump vec3 atomosphere_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (_ES_SunDirection, viewDir_14);
  mediump float tmpvar_28;
  tmpvar_28 = max (((tmpvar_27 * _ES_SkyFrontAndBackBlendFactor) + (1.0 - _ES_SkyFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_29;
  tmpvar_29 = ((tmpvar_28 * tmpvar_28) * tmpvar_28);
  mediump vec4 tmpvar_30;
  tmpvar_30.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_30.x = (abs(tmpvar_18.w) / max (_ES_BottomColorHeight, 0.0001));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DLod (_SkyGradientTex, tmpvar_30.xy, 0.0);
  mediump float tmpvar_32;
  tmpvar_32 = tmpvar_31.x;
  atomosphere_26 = mix (mix (_ES_TopBackColor, _ES_TopFrontColor, vec4(tmpvar_29)).xyz, mix (_ES_BottomBackColor, _ES_BottomFrontColor, vec4(tmpvar_29)).xyz, vec3(tmpvar_32));
  mediump vec4 tmpvar_33;
  tmpvar_33.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_33.x = (abs(tmpvar_18.w) / max (_ES_HorizonHaloHeight, 0.0001));
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DLod (_SkyGradientTex, tmpvar_33.xy, 0.0);
  mediump float tmpvar_35;
  tmpvar_35 = tmpvar_34.y;
  mediump float tmpvar_36;
  tmpvar_36 = clamp (((
    max (((tmpvar_27 * 0.5) + 0.5), 0.0)
   - 0.3) / 0.7), 0.0, 1.0);
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    abs(_ES_SunDirection.y)
   - 0.2) / 0.3), 0.0, 1.0);
  atomosphere_26 = (atomosphere_26 + ((
    (_ES_HorizonHaloColor * _ES_HorizonHaloIntensity)
   * tmpvar_35) * mix (
    (tmpvar_36 * (tmpvar_36 * (3.0 - (2.0 * tmpvar_36))))
  , 1.0, 
    (tmpvar_37 * (tmpvar_37 * (3.0 - (2.0 * tmpvar_37))))
  )));
  highp vec3 viewDir_38;
  viewDir_38 = tmpvar_18.xyz;
  highp float haloInfluence_39;
  mediump float vertical_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((
    dot (_ES_SunDirection, viewDir_38)
   * 0.5) + 0.5), 0.0, 1.0);
  highp float tmpvar_42;
  tmpvar_42 = dot (viewDir_38, _ES_SkyWorldUpDir);
  vertical_40 = tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = abs(vertical_40);
  mediump float y_44;
  y_44 = (_ES_SunHaloSize * tmpvar_43);
  mediump float y_45;
  y_45 = ((_ES_SunHaloSize * 0.1) * tmpvar_43);
  haloInfluence_39 = (clamp (pow (tmpvar_41, y_44), 0.0, 1.0) + (clamp (
    pow (tmpvar_41, y_45)
  , 0.0, 1.0) * 0.12));
  mediump float y_46;
  y_46 = ((_ES_SunHaloSize * 0.01) * tmpvar_43);
  haloInfluence_39 = (haloInfluence_39 + (clamp (
    pow (tmpvar_41, y_46)
  , 0.0, 1.0) * 0.03));
  highp float tmpvar_47;
  tmpvar_47 = clamp (((
    max (((dot (_ES_SunDirection, viewDir_38) * 0.5) + 0.5), 0.0)
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 tmpvar_48;
  tmpvar_48 = (((haloInfluence_39 * _ES_SunHaloIntensity) * _ES_SunHaloColor) * (tmpvar_47 * (tmpvar_47 * 
    (3.0 - (2.0 * tmpvar_47))
  )));
  tmpvar_5 = (atomosphere_26 + tmpvar_48);
  mediump float tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_49 = (tmpvar_50 * (tmpvar_50 * (3.0 - 
    (2.0 * tmpvar_50)
  )));
  highp vec3 viewDir_51;
  viewDir_51 = tmpvar_18.xyz;
  mediump float moonLunarCancel_52;
  mediump float tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (_ES_MoonDirection, viewDir_51), 0.0, 1.0);
  tmpvar_53 = tmpvar_54;
  highp float tmpvar_55;
  mediump float tmpvar_56;
  tmpvar_56 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_55 = (1.0 - (tmpvar_56 * 2.0));
  moonLunarCancel_52 = tmpvar_55;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((
    ((tmpvar_53 * tmpvar_53) * ((tmpvar_53 * tmpvar_53) * tmpvar_53))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_58;
  viewDir_58 = tmpvar_18.xyz;
  mediump float vertical_59;
  mediump float tmpvar_60;
  highp float tmpvar_61;
  tmpvar_61 = clamp (((
    dot (_ES_SunDirection, viewDir_58)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_60 = tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = dot (viewDir_58, _ES_SkyWorldUpDir);
  vertical_59 = tmpvar_62;
  mediump float tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = (1.0 - _ES_SunRimLightRadius);
  tmpvar_63 = clamp (((tmpvar_20 - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (((tmpvar_63 * 
    (tmpvar_63 * (3.0 - (2.0 * tmpvar_63)))
  ) * _ES_SunBrightness) * 0.125);
  mediump float tmpvar_66;
  tmpvar_66 = clamp (((
    ((dot (viewDir_14, _ES_MoonDirection) * 0.5) + 0.5)
   - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_67;
  tmpvar_67 = (((tmpvar_66 * 
    (tmpvar_66 * (3.0 - (2.0 * tmpvar_66)))
  ) * _ES_MoonBrightness) * 0.1);
  mediump float tmpvar_68;
  tmpvar_68 = max (((tmpvar_19 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_69;
  tmpvar_69 = ((tmpvar_68 * tmpvar_68) * tmpvar_68);
  gl_Position = clipPos_6;
  xlv_TEXCOORD0 = o_9;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = (((
    ((((tmpvar_57 * 
      (tmpvar_57 * (3.0 - (2.0 * tmpvar_57)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_52) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_60, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_59))
    ) * vertical_59), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_49);
  xlv_TEXCOORD6 = (((_ES_SunHaloColor * 
    (tmpvar_65 * tmpvar_65)
  ) + (_ES_MoonColor * 
    (tmpvar_67 * tmpvar_67)
  )) * tmpvar_49);
  xlv_TEXCOORD7 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_69));
  xlv_TEXCOORD8 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_69));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_CloudCoverage;
uniform sampler2D _CloudParticleAtlas;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 cloudCol_1;
  mediump vec4 texCol_2;
  highp vec3 curlNoise_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_CloudCurlTex, xlv_TEXCOORD1.zw).xyz;
  curlNoise_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD1.xy + ((
    (curlNoise_3.xy - 0.5)
   * curlNoise_3.z) * _CloudCurlAmplitude));
  tmpvar_5 = texture2D (_CloudParticleAtlas, P_6);
  texCol_2 = tmpvar_5;
  mediump float tmpvar_7;
  tmpvar_7 = max ((xlv_TEXCOORD3.w - xlv_TEXCOORD3.y), 0.0);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.y), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD2.w - -0.1) / 0.2), 0.0, 1.0);
  cloudCol_1.w = ((texCol_2.w * (tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  )) * (tmpvar_9 * (tmpvar_9 * 
    (3.0 - (2.0 * tmpvar_9))
  )));
  mediump float x_10;
  x_10 = (cloudCol_1.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.z), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  cloudCol_1.xyz = ((mix (xlv_TEXCOORD8, xlv_TEXCOORD7, texCol_2.xxx) + (xlv_TEXCOORD6 * 
    mix (texCol_2.y, ((1.0 - (tmpvar_11 * 
      (tmpvar_11 * (3.0 - (2.0 * tmpvar_11)))
    )) * 4.0), xlv_TEXCOORD3.w)
  )) + ((0.4 * xlv_TEXCOORD7) * _ES_CloudCoverage));
  cloudCol_1.xyz = (cloudCol_1.xyz + (xlv_TEXCOORD5 * texCol_2.x));
  cloudCol_1.xyz = (cloudCol_1.xyz * (xlv_TEXCOORD3.x + 1.0));
  mediump float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD2.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((_ES_CloudCoverage - 0.4) / 0.3), 0.0, 1.0);
  cloudCol_1.xyz = mix (xlv_TEXCOORD4, cloudCol_1.xyz, vec3(mix (clamp (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
  , 0.0, 1.0), 1.0, (tmpvar_13 * 
    (tmpvar_13 * (3.0 - (2.0 * tmpvar_13)))
  ))));
  cloudCol_1.w = clamp (cloudCol_1.w, 0.0, 1.0);
  gl_FragData[0] = cloudCol_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FIXED_EDGE_SMOOTHNESS" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec4 _ES_TopFrontColor;
uniform mediump vec4 _ES_TopBackColor;
uniform mediump vec4 _ES_BottomFrontColor;
uniform mediump vec4 _ES_BottomBackColor;
uniform mediump float _ES_SkyFrontAndBackBlendFactor;
uniform mediump float _ES_BottomColorHeight;
uniform mediump vec3 _ES_HorizonHaloColor;
uniform mediump float _ES_HorizonHaloIntensity;
uniform mediump float _ES_HorizonHaloHeight;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump float _ES_SunHaloSize;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudAgePercent;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform sampler2D _SkyGradientTex;
uniform highp vec2 _AtlasTiles;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
uniform mediump float _FixedEdgeSmoothness;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float agePercent_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 clipPos_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  clipPos_6.xyw = tmpvar_7.xyw;
  clipPos_6.z = tmpvar_7.w;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7.xyww * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = clipPos_6.zw;
  highp int tmpvar_12;
  tmpvar_12 = int(floor((
    (_glesColor.y * ((_AtlasTiles.x * _AtlasTiles.y) - 1.0))
   + 0.5)));
  highp vec2 tmpvar_13;
  tmpvar_13.x = (float(mod (float(tmpvar_12), _AtlasTiles.x)));
  tmpvar_13.y = floor((float(tmpvar_12) / _AtlasTiles.x));
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy + tmpvar_13) / _AtlasTiles);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _CloudCurlTiling) + ((_ES_CloudElapsedTime * vec2(1.2, 0.8)) * _CloudCurlSpeed));
  mediump vec3 viewDir_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(((unity_ObjectToWorld * tmpvar_15).xyz - _ES_SkyCenterWorldPos));
  viewDir_14 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (_ES_SkyWorldUpDir, viewDir_14);
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = viewDir_14;
  tmpvar_18.w = ((sign(tmpvar_17) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_17))) * (1.570796 + (abs(tmpvar_17) * (-0.2146018 + 
      (abs(tmpvar_17) * (0.08656672 + (abs(tmpvar_17) * -0.03102955)))
    ))))
  )) * 0.6366198);
  mediump float tmpvar_19;
  tmpvar_19 = dot (viewDir_14, _ES_SunDirection);
  mediump float tmpvar_20;
  tmpvar_20 = ((tmpvar_19 * 0.5) + 0.5);
  tmpvar_4.x = (tmpvar_20 * _ES_CloudSunBrightenIntensity);
  tmpvar_4.y = _FixedEdgeSmoothness;
  tmpvar_4.z = _glesColor.w;
  highp float tmpvar_21;
  tmpvar_21 = (_glesMultiTexCoord1.y / max (_glesMultiTexCoord1.x, 1e-05));
  agePercent_2 = tmpvar_21;
  agePercent_2 = (agePercent_2 * _ES_CloudAgePercent);
  highp float tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = clamp ((agePercent_2 / _glesMultiTexCoord1.z), 0.0, 1.0);
  tmpvar_22 = (tmpvar_23 * (tmpvar_23 * (3.0 - 
    (2.0 * tmpvar_23)
  )));
  highp float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((agePercent_2 - _glesMultiTexCoord1.w) / (1.0 - _glesMultiTexCoord1.w)), 0.0, 1.0);
  tmpvar_24 = (tmpvar_25 * (tmpvar_25 * (3.0 - 
    (2.0 * tmpvar_25)
  )));
  tmpvar_4.w = (1.0 - (tmpvar_22 * (1.0 - tmpvar_24)));
  mediump vec3 atomosphere_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (_ES_SunDirection, viewDir_14);
  mediump float tmpvar_28;
  tmpvar_28 = max (((tmpvar_27 * _ES_SkyFrontAndBackBlendFactor) + (1.0 - _ES_SkyFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_29;
  tmpvar_29 = ((tmpvar_28 * tmpvar_28) * tmpvar_28);
  mediump vec4 tmpvar_30;
  tmpvar_30.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_30.x = (abs(tmpvar_18.w) / max (_ES_BottomColorHeight, 0.0001));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DLod (_SkyGradientTex, tmpvar_30.xy, 0.0);
  mediump float tmpvar_32;
  tmpvar_32 = tmpvar_31.x;
  atomosphere_26 = mix (mix (_ES_TopBackColor, _ES_TopFrontColor, vec4(tmpvar_29)).xyz, mix (_ES_BottomBackColor, _ES_BottomFrontColor, vec4(tmpvar_29)).xyz, vec3(tmpvar_32));
  mediump vec4 tmpvar_33;
  tmpvar_33.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_33.x = (abs(tmpvar_18.w) / max (_ES_HorizonHaloHeight, 0.0001));
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DLod (_SkyGradientTex, tmpvar_33.xy, 0.0);
  mediump float tmpvar_35;
  tmpvar_35 = tmpvar_34.y;
  mediump float tmpvar_36;
  tmpvar_36 = clamp (((
    max (((tmpvar_27 * 0.5) + 0.5), 0.0)
   - 0.3) / 0.7), 0.0, 1.0);
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    abs(_ES_SunDirection.y)
   - 0.2) / 0.3), 0.0, 1.0);
  atomosphere_26 = (atomosphere_26 + ((
    (_ES_HorizonHaloColor * _ES_HorizonHaloIntensity)
   * tmpvar_35) * mix (
    (tmpvar_36 * (tmpvar_36 * (3.0 - (2.0 * tmpvar_36))))
  , 1.0, 
    (tmpvar_37 * (tmpvar_37 * (3.0 - (2.0 * tmpvar_37))))
  )));
  highp vec3 viewDir_38;
  viewDir_38 = tmpvar_18.xyz;
  highp float haloInfluence_39;
  mediump float vertical_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((
    dot (_ES_SunDirection, viewDir_38)
   * 0.5) + 0.5), 0.0, 1.0);
  highp float tmpvar_42;
  tmpvar_42 = dot (viewDir_38, _ES_SkyWorldUpDir);
  vertical_40 = tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = abs(vertical_40);
  mediump float y_44;
  y_44 = (_ES_SunHaloSize * tmpvar_43);
  mediump float y_45;
  y_45 = ((_ES_SunHaloSize * 0.1) * tmpvar_43);
  haloInfluence_39 = (clamp (pow (tmpvar_41, y_44), 0.0, 1.0) + (clamp (
    pow (tmpvar_41, y_45)
  , 0.0, 1.0) * 0.12));
  mediump float y_46;
  y_46 = ((_ES_SunHaloSize * 0.01) * tmpvar_43);
  haloInfluence_39 = (haloInfluence_39 + (clamp (
    pow (tmpvar_41, y_46)
  , 0.0, 1.0) * 0.03));
  highp float tmpvar_47;
  tmpvar_47 = clamp (((
    max (((dot (_ES_SunDirection, viewDir_38) * 0.5) + 0.5), 0.0)
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 tmpvar_48;
  tmpvar_48 = (((haloInfluence_39 * _ES_SunHaloIntensity) * _ES_SunHaloColor) * (tmpvar_47 * (tmpvar_47 * 
    (3.0 - (2.0 * tmpvar_47))
  )));
  tmpvar_5 = (atomosphere_26 + tmpvar_48);
  mediump float tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_49 = (tmpvar_50 * (tmpvar_50 * (3.0 - 
    (2.0 * tmpvar_50)
  )));
  highp vec3 viewDir_51;
  viewDir_51 = tmpvar_18.xyz;
  mediump float moonLunarCancel_52;
  mediump float tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (_ES_MoonDirection, viewDir_51), 0.0, 1.0);
  tmpvar_53 = tmpvar_54;
  highp float tmpvar_55;
  mediump float tmpvar_56;
  tmpvar_56 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_55 = (1.0 - (tmpvar_56 * 2.0));
  moonLunarCancel_52 = tmpvar_55;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((
    ((tmpvar_53 * tmpvar_53) * ((tmpvar_53 * tmpvar_53) * tmpvar_53))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_58;
  viewDir_58 = tmpvar_18.xyz;
  mediump float vertical_59;
  mediump float tmpvar_60;
  highp float tmpvar_61;
  tmpvar_61 = clamp (((
    dot (_ES_SunDirection, viewDir_58)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_60 = tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = dot (viewDir_58, _ES_SkyWorldUpDir);
  vertical_59 = tmpvar_62;
  mediump float tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = (1.0 - _ES_SunRimLightRadius);
  tmpvar_63 = clamp (((tmpvar_20 - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (((tmpvar_63 * 
    (tmpvar_63 * (3.0 - (2.0 * tmpvar_63)))
  ) * _ES_SunBrightness) * 0.125);
  mediump float tmpvar_66;
  tmpvar_66 = clamp (((
    ((dot (viewDir_14, _ES_MoonDirection) * 0.5) + 0.5)
   - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_67;
  tmpvar_67 = (((tmpvar_66 * 
    (tmpvar_66 * (3.0 - (2.0 * tmpvar_66)))
  ) * _ES_MoonBrightness) * 0.1);
  mediump float tmpvar_68;
  tmpvar_68 = max (((tmpvar_19 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_69;
  tmpvar_69 = ((tmpvar_68 * tmpvar_68) * tmpvar_68);
  gl_Position = clipPos_6;
  xlv_TEXCOORD0 = o_9;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = (((
    ((((tmpvar_57 * 
      (tmpvar_57 * (3.0 - (2.0 * tmpvar_57)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_52) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_60, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_59))
    ) * vertical_59), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_49);
  xlv_TEXCOORD6 = (((_ES_SunHaloColor * 
    (tmpvar_65 * tmpvar_65)
  ) + (_ES_MoonColor * 
    (tmpvar_67 * tmpvar_67)
  )) * tmpvar_49);
  xlv_TEXCOORD7 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_69));
  xlv_TEXCOORD8 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_69));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_CloudCoverage;
uniform sampler2D _CloudParticleAtlas;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 cloudCol_1;
  mediump vec4 texCol_2;
  highp vec3 curlNoise_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_CloudCurlTex, xlv_TEXCOORD1.zw).xyz;
  curlNoise_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD1.xy + ((
    (curlNoise_3.xy - 0.5)
   * curlNoise_3.z) * _CloudCurlAmplitude));
  tmpvar_5 = texture2D (_CloudParticleAtlas, P_6);
  texCol_2 = tmpvar_5;
  mediump float tmpvar_7;
  tmpvar_7 = max ((xlv_TEXCOORD3.w - xlv_TEXCOORD3.y), 0.0);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.y), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD2.w - -0.1) / 0.2), 0.0, 1.0);
  cloudCol_1.w = ((texCol_2.w * (tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  )) * (tmpvar_9 * (tmpvar_9 * 
    (3.0 - (2.0 * tmpvar_9))
  )));
  mediump float x_10;
  x_10 = (cloudCol_1.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.z), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  cloudCol_1.xyz = ((mix (xlv_TEXCOORD8, xlv_TEXCOORD7, texCol_2.xxx) + (xlv_TEXCOORD6 * 
    mix (texCol_2.y, ((1.0 - (tmpvar_11 * 
      (tmpvar_11 * (3.0 - (2.0 * tmpvar_11)))
    )) * 4.0), xlv_TEXCOORD3.w)
  )) + ((0.4 * xlv_TEXCOORD7) * _ES_CloudCoverage));
  cloudCol_1.xyz = (cloudCol_1.xyz + (xlv_TEXCOORD5 * texCol_2.x));
  cloudCol_1.xyz = (cloudCol_1.xyz * (xlv_TEXCOORD3.x + 1.0));
  mediump float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD2.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((_ES_CloudCoverage - 0.4) / 0.3), 0.0, 1.0);
  cloudCol_1.xyz = mix (xlv_TEXCOORD4, cloudCol_1.xyz, vec3(mix (clamp (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
  , 0.0, 1.0), 1.0, (tmpvar_13 * 
    (tmpvar_13 * (3.0 - (2.0 * tmpvar_13)))
  ))));
  cloudCol_1.w = clamp (cloudCol_1.w, 0.0, 1.0);
  gl_FragData[0] = cloudCol_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FIXED_EDGE_SMOOTHNESS" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec4 _ES_TopFrontColor;
uniform mediump vec4 _ES_TopBackColor;
uniform mediump vec4 _ES_BottomFrontColor;
uniform mediump vec4 _ES_BottomBackColor;
uniform mediump float _ES_SkyFrontAndBackBlendFactor;
uniform mediump float _ES_BottomColorHeight;
uniform mediump vec3 _ES_HorizonHaloColor;
uniform mediump float _ES_HorizonHaloIntensity;
uniform mediump float _ES_HorizonHaloHeight;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump float _ES_SunHaloSize;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudAgePercent;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform sampler2D _SkyGradientTex;
uniform highp vec2 _AtlasTiles;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
uniform mediump float _FixedEdgeSmoothness;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float agePercent_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 clipPos_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  clipPos_6.xyw = tmpvar_7.xyw;
  clipPos_6.z = tmpvar_7.w;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7.xyww * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = clipPos_6.zw;
  highp int tmpvar_12;
  tmpvar_12 = int(floor((
    (_glesColor.y * ((_AtlasTiles.x * _AtlasTiles.y) - 1.0))
   + 0.5)));
  highp vec2 tmpvar_13;
  tmpvar_13.x = (float(mod (float(tmpvar_12), _AtlasTiles.x)));
  tmpvar_13.y = floor((float(tmpvar_12) / _AtlasTiles.x));
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy + tmpvar_13) / _AtlasTiles);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _CloudCurlTiling) + ((_ES_CloudElapsedTime * vec2(1.2, 0.8)) * _CloudCurlSpeed));
  mediump vec3 viewDir_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(((unity_ObjectToWorld * tmpvar_15).xyz - _ES_SkyCenterWorldPos));
  viewDir_14 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (_ES_SkyWorldUpDir, viewDir_14);
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = viewDir_14;
  tmpvar_18.w = ((sign(tmpvar_17) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_17))) * (1.570796 + (abs(tmpvar_17) * (-0.2146018 + 
      (abs(tmpvar_17) * (0.08656672 + (abs(tmpvar_17) * -0.03102955)))
    ))))
  )) * 0.6366198);
  mediump float tmpvar_19;
  tmpvar_19 = dot (viewDir_14, _ES_SunDirection);
  mediump float tmpvar_20;
  tmpvar_20 = ((tmpvar_19 * 0.5) + 0.5);
  tmpvar_4.x = (tmpvar_20 * _ES_CloudSunBrightenIntensity);
  tmpvar_4.y = _FixedEdgeSmoothness;
  tmpvar_4.z = _glesColor.w;
  highp float tmpvar_21;
  tmpvar_21 = (_glesMultiTexCoord1.y / max (_glesMultiTexCoord1.x, 1e-05));
  agePercent_2 = tmpvar_21;
  agePercent_2 = (agePercent_2 * _ES_CloudAgePercent);
  highp float tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = clamp ((agePercent_2 / _glesMultiTexCoord1.z), 0.0, 1.0);
  tmpvar_22 = (tmpvar_23 * (tmpvar_23 * (3.0 - 
    (2.0 * tmpvar_23)
  )));
  highp float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((agePercent_2 - _glesMultiTexCoord1.w) / (1.0 - _glesMultiTexCoord1.w)), 0.0, 1.0);
  tmpvar_24 = (tmpvar_25 * (tmpvar_25 * (3.0 - 
    (2.0 * tmpvar_25)
  )));
  tmpvar_4.w = (1.0 - (tmpvar_22 * (1.0 - tmpvar_24)));
  mediump vec3 atomosphere_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (_ES_SunDirection, viewDir_14);
  mediump float tmpvar_28;
  tmpvar_28 = max (((tmpvar_27 * _ES_SkyFrontAndBackBlendFactor) + (1.0 - _ES_SkyFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_29;
  tmpvar_29 = ((tmpvar_28 * tmpvar_28) * tmpvar_28);
  mediump vec4 tmpvar_30;
  tmpvar_30.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_30.x = (abs(tmpvar_18.w) / max (_ES_BottomColorHeight, 0.0001));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DLod (_SkyGradientTex, tmpvar_30.xy, 0.0);
  mediump float tmpvar_32;
  tmpvar_32 = tmpvar_31.x;
  atomosphere_26 = mix (mix (_ES_TopBackColor, _ES_TopFrontColor, vec4(tmpvar_29)).xyz, mix (_ES_BottomBackColor, _ES_BottomFrontColor, vec4(tmpvar_29)).xyz, vec3(tmpvar_32));
  mediump vec4 tmpvar_33;
  tmpvar_33.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_33.x = (abs(tmpvar_18.w) / max (_ES_HorizonHaloHeight, 0.0001));
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DLod (_SkyGradientTex, tmpvar_33.xy, 0.0);
  mediump float tmpvar_35;
  tmpvar_35 = tmpvar_34.y;
  mediump float tmpvar_36;
  tmpvar_36 = clamp (((
    max (((tmpvar_27 * 0.5) + 0.5), 0.0)
   - 0.3) / 0.7), 0.0, 1.0);
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    abs(_ES_SunDirection.y)
   - 0.2) / 0.3), 0.0, 1.0);
  atomosphere_26 = (atomosphere_26 + ((
    (_ES_HorizonHaloColor * _ES_HorizonHaloIntensity)
   * tmpvar_35) * mix (
    (tmpvar_36 * (tmpvar_36 * (3.0 - (2.0 * tmpvar_36))))
  , 1.0, 
    (tmpvar_37 * (tmpvar_37 * (3.0 - (2.0 * tmpvar_37))))
  )));
  highp vec3 viewDir_38;
  viewDir_38 = tmpvar_18.xyz;
  highp float haloInfluence_39;
  mediump float vertical_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((
    dot (_ES_SunDirection, viewDir_38)
   * 0.5) + 0.5), 0.0, 1.0);
  highp float tmpvar_42;
  tmpvar_42 = dot (viewDir_38, _ES_SkyWorldUpDir);
  vertical_40 = tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = abs(vertical_40);
  mediump float y_44;
  y_44 = (_ES_SunHaloSize * tmpvar_43);
  mediump float y_45;
  y_45 = ((_ES_SunHaloSize * 0.1) * tmpvar_43);
  haloInfluence_39 = (clamp (pow (tmpvar_41, y_44), 0.0, 1.0) + (clamp (
    pow (tmpvar_41, y_45)
  , 0.0, 1.0) * 0.12));
  mediump float y_46;
  y_46 = ((_ES_SunHaloSize * 0.01) * tmpvar_43);
  haloInfluence_39 = (haloInfluence_39 + (clamp (
    pow (tmpvar_41, y_46)
  , 0.0, 1.0) * 0.03));
  highp float tmpvar_47;
  tmpvar_47 = clamp (((
    max (((dot (_ES_SunDirection, viewDir_38) * 0.5) + 0.5), 0.0)
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 tmpvar_48;
  tmpvar_48 = (((haloInfluence_39 * _ES_SunHaloIntensity) * _ES_SunHaloColor) * (tmpvar_47 * (tmpvar_47 * 
    (3.0 - (2.0 * tmpvar_47))
  )));
  tmpvar_5 = (atomosphere_26 + tmpvar_48);
  mediump float tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_49 = (tmpvar_50 * (tmpvar_50 * (3.0 - 
    (2.0 * tmpvar_50)
  )));
  highp vec3 viewDir_51;
  viewDir_51 = tmpvar_18.xyz;
  mediump float moonLunarCancel_52;
  mediump float tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (_ES_MoonDirection, viewDir_51), 0.0, 1.0);
  tmpvar_53 = tmpvar_54;
  highp float tmpvar_55;
  mediump float tmpvar_56;
  tmpvar_56 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_55 = (1.0 - (tmpvar_56 * 2.0));
  moonLunarCancel_52 = tmpvar_55;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((
    ((tmpvar_53 * tmpvar_53) * ((tmpvar_53 * tmpvar_53) * tmpvar_53))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_58;
  viewDir_58 = tmpvar_18.xyz;
  mediump float vertical_59;
  mediump float tmpvar_60;
  highp float tmpvar_61;
  tmpvar_61 = clamp (((
    dot (_ES_SunDirection, viewDir_58)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_60 = tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = dot (viewDir_58, _ES_SkyWorldUpDir);
  vertical_59 = tmpvar_62;
  mediump float tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = (1.0 - _ES_SunRimLightRadius);
  tmpvar_63 = clamp (((tmpvar_20 - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (((tmpvar_63 * 
    (tmpvar_63 * (3.0 - (2.0 * tmpvar_63)))
  ) * _ES_SunBrightness) * 0.125);
  mediump float tmpvar_66;
  tmpvar_66 = clamp (((
    ((dot (viewDir_14, _ES_MoonDirection) * 0.5) + 0.5)
   - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_67;
  tmpvar_67 = (((tmpvar_66 * 
    (tmpvar_66 * (3.0 - (2.0 * tmpvar_66)))
  ) * _ES_MoonBrightness) * 0.1);
  mediump float tmpvar_68;
  tmpvar_68 = max (((tmpvar_19 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_69;
  tmpvar_69 = ((tmpvar_68 * tmpvar_68) * tmpvar_68);
  gl_Position = clipPos_6;
  xlv_TEXCOORD0 = o_9;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = (((
    ((((tmpvar_57 * 
      (tmpvar_57 * (3.0 - (2.0 * tmpvar_57)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_52) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_60, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_59))
    ) * vertical_59), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_49);
  xlv_TEXCOORD6 = (((_ES_SunHaloColor * 
    (tmpvar_65 * tmpvar_65)
  ) + (_ES_MoonColor * 
    (tmpvar_67 * tmpvar_67)
  )) * tmpvar_49);
  xlv_TEXCOORD7 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_69));
  xlv_TEXCOORD8 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_69));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_CloudCoverage;
uniform sampler2D _CloudParticleAtlas;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 cloudCol_1;
  mediump vec4 texCol_2;
  highp vec3 curlNoise_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_CloudCurlTex, xlv_TEXCOORD1.zw).xyz;
  curlNoise_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD1.xy + ((
    (curlNoise_3.xy - 0.5)
   * curlNoise_3.z) * _CloudCurlAmplitude));
  tmpvar_5 = texture2D (_CloudParticleAtlas, P_6);
  texCol_2 = tmpvar_5;
  mediump float tmpvar_7;
  tmpvar_7 = max ((xlv_TEXCOORD3.w - xlv_TEXCOORD3.y), 0.0);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.y), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD2.w - -0.1) / 0.2), 0.0, 1.0);
  cloudCol_1.w = ((texCol_2.w * (tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  )) * (tmpvar_9 * (tmpvar_9 * 
    (3.0 - (2.0 * tmpvar_9))
  )));
  mediump float x_10;
  x_10 = (cloudCol_1.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.z), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  cloudCol_1.xyz = ((mix (xlv_TEXCOORD8, xlv_TEXCOORD7, texCol_2.xxx) + (xlv_TEXCOORD6 * 
    mix (texCol_2.y, ((1.0 - (tmpvar_11 * 
      (tmpvar_11 * (3.0 - (2.0 * tmpvar_11)))
    )) * 4.0), xlv_TEXCOORD3.w)
  )) + ((0.4 * xlv_TEXCOORD7) * _ES_CloudCoverage));
  cloudCol_1.xyz = (cloudCol_1.xyz + (xlv_TEXCOORD5 * texCol_2.x));
  cloudCol_1.xyz = (cloudCol_1.xyz * (xlv_TEXCOORD3.x + 1.0));
  mediump float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD2.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((_ES_CloudCoverage - 0.4) / 0.3), 0.0, 1.0);
  cloudCol_1.xyz = mix (xlv_TEXCOORD4, cloudCol_1.xyz, vec3(mix (clamp (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
  , 0.0, 1.0), 1.0, (tmpvar_13 * 
    (tmpvar_13 * (3.0 - (2.0 * tmpvar_13)))
  ))));
  cloudCol_1.w = clamp (cloudCol_1.w, 0.0, 1.0);
  gl_FragData[0] = cloudCol_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "FIXED_EDGE_SMOOTHNESS" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec4 _ES_TopFrontColor;
uniform mediump vec4 _ES_TopBackColor;
uniform mediump vec4 _ES_BottomFrontColor;
uniform mediump vec4 _ES_BottomBackColor;
uniform mediump float _ES_SkyFrontAndBackBlendFactor;
uniform mediump float _ES_BottomColorHeight;
uniform mediump vec3 _ES_HorizonHaloColor;
uniform mediump float _ES_HorizonHaloIntensity;
uniform mediump float _ES_HorizonHaloHeight;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump float _ES_SunHaloSize;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudAgePercent;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform sampler2D _SkyGradientTex;
uniform highp vec2 _AtlasTiles;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
uniform mediump float _FixedEdgeSmoothness;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float agePercent_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 clipPos_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  clipPos_6.xyw = tmpvar_7.xyw;
  clipPos_6.z = tmpvar_7.w;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7.xyww * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = clipPos_6.zw;
  highp int tmpvar_12;
  tmpvar_12 = int(floor((
    (_glesColor.y * ((_AtlasTiles.x * _AtlasTiles.y) - 1.0))
   + 0.5)));
  highp vec2 tmpvar_13;
  tmpvar_13.x = (float(mod (float(tmpvar_12), _AtlasTiles.x)));
  tmpvar_13.y = floor((float(tmpvar_12) / _AtlasTiles.x));
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy + tmpvar_13) / _AtlasTiles);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _CloudCurlTiling) + ((_ES_CloudElapsedTime * vec2(1.2, 0.8)) * _CloudCurlSpeed));
  mediump vec3 viewDir_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(((unity_ObjectToWorld * tmpvar_15).xyz - _ES_SkyCenterWorldPos));
  viewDir_14 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (_ES_SkyWorldUpDir, viewDir_14);
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = viewDir_14;
  tmpvar_18.w = ((sign(tmpvar_17) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_17))) * (1.570796 + (abs(tmpvar_17) * (-0.2146018 + 
      (abs(tmpvar_17) * (0.08656672 + (abs(tmpvar_17) * -0.03102955)))
    ))))
  )) * 0.6366198);
  mediump float tmpvar_19;
  tmpvar_19 = dot (viewDir_14, _ES_SunDirection);
  mediump float tmpvar_20;
  tmpvar_20 = ((tmpvar_19 * 0.5) + 0.5);
  tmpvar_4.x = (tmpvar_20 * _ES_CloudSunBrightenIntensity);
  tmpvar_4.y = _FixedEdgeSmoothness;
  tmpvar_4.z = _glesColor.w;
  highp float tmpvar_21;
  tmpvar_21 = (_glesMultiTexCoord1.y / max (_glesMultiTexCoord1.x, 1e-05));
  agePercent_2 = tmpvar_21;
  agePercent_2 = (agePercent_2 * _ES_CloudAgePercent);
  highp float tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = clamp ((agePercent_2 / _glesMultiTexCoord1.z), 0.0, 1.0);
  tmpvar_22 = (tmpvar_23 * (tmpvar_23 * (3.0 - 
    (2.0 * tmpvar_23)
  )));
  highp float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((agePercent_2 - _glesMultiTexCoord1.w) / (1.0 - _glesMultiTexCoord1.w)), 0.0, 1.0);
  tmpvar_24 = (tmpvar_25 * (tmpvar_25 * (3.0 - 
    (2.0 * tmpvar_25)
  )));
  tmpvar_4.w = (1.0 - (tmpvar_22 * (1.0 - tmpvar_24)));
  mediump vec3 atomosphere_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (_ES_SunDirection, viewDir_14);
  mediump float tmpvar_28;
  tmpvar_28 = max (((tmpvar_27 * _ES_SkyFrontAndBackBlendFactor) + (1.0 - _ES_SkyFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_29;
  tmpvar_29 = ((tmpvar_28 * tmpvar_28) * tmpvar_28);
  mediump vec4 tmpvar_30;
  tmpvar_30.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_30.x = (abs(tmpvar_18.w) / max (_ES_BottomColorHeight, 0.0001));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DLod (_SkyGradientTex, tmpvar_30.xy, 0.0);
  mediump float tmpvar_32;
  tmpvar_32 = tmpvar_31.x;
  atomosphere_26 = mix (mix (_ES_TopBackColor, _ES_TopFrontColor, vec4(tmpvar_29)).xyz, mix (_ES_BottomBackColor, _ES_BottomFrontColor, vec4(tmpvar_29)).xyz, vec3(tmpvar_32));
  mediump vec4 tmpvar_33;
  tmpvar_33.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_33.x = (abs(tmpvar_18.w) / max (_ES_HorizonHaloHeight, 0.0001));
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DLod (_SkyGradientTex, tmpvar_33.xy, 0.0);
  mediump float tmpvar_35;
  tmpvar_35 = tmpvar_34.y;
  mediump float tmpvar_36;
  tmpvar_36 = clamp (((
    max (((tmpvar_27 * 0.5) + 0.5), 0.0)
   - 0.3) / 0.7), 0.0, 1.0);
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    abs(_ES_SunDirection.y)
   - 0.2) / 0.3), 0.0, 1.0);
  atomosphere_26 = (atomosphere_26 + ((
    (_ES_HorizonHaloColor * _ES_HorizonHaloIntensity)
   * tmpvar_35) * mix (
    (tmpvar_36 * (tmpvar_36 * (3.0 - (2.0 * tmpvar_36))))
  , 1.0, 
    (tmpvar_37 * (tmpvar_37 * (3.0 - (2.0 * tmpvar_37))))
  )));
  highp vec3 viewDir_38;
  viewDir_38 = tmpvar_18.xyz;
  highp float haloInfluence_39;
  mediump float vertical_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((
    dot (_ES_SunDirection, viewDir_38)
   * 0.5) + 0.5), 0.0, 1.0);
  highp float tmpvar_42;
  tmpvar_42 = dot (viewDir_38, _ES_SkyWorldUpDir);
  vertical_40 = tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = abs(vertical_40);
  mediump float y_44;
  y_44 = (_ES_SunHaloSize * tmpvar_43);
  mediump float y_45;
  y_45 = ((_ES_SunHaloSize * 0.1) * tmpvar_43);
  haloInfluence_39 = (clamp (pow (tmpvar_41, y_44), 0.0, 1.0) + (clamp (
    pow (tmpvar_41, y_45)
  , 0.0, 1.0) * 0.12));
  mediump float y_46;
  y_46 = ((_ES_SunHaloSize * 0.01) * tmpvar_43);
  haloInfluence_39 = (haloInfluence_39 + (clamp (
    pow (tmpvar_41, y_46)
  , 0.0, 1.0) * 0.03));
  highp float tmpvar_47;
  tmpvar_47 = clamp (((
    max (((dot (_ES_SunDirection, viewDir_38) * 0.5) + 0.5), 0.0)
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 tmpvar_48;
  tmpvar_48 = (((haloInfluence_39 * _ES_SunHaloIntensity) * _ES_SunHaloColor) * (tmpvar_47 * (tmpvar_47 * 
    (3.0 - (2.0 * tmpvar_47))
  )));
  tmpvar_5 = (atomosphere_26 + tmpvar_48);
  mediump float tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_49 = (tmpvar_50 * (tmpvar_50 * (3.0 - 
    (2.0 * tmpvar_50)
  )));
  highp vec3 viewDir_51;
  viewDir_51 = tmpvar_18.xyz;
  mediump float moonLunarCancel_52;
  mediump float tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (_ES_MoonDirection, viewDir_51), 0.0, 1.0);
  tmpvar_53 = tmpvar_54;
  highp float tmpvar_55;
  mediump float tmpvar_56;
  tmpvar_56 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_55 = (1.0 - (tmpvar_56 * 2.0));
  moonLunarCancel_52 = tmpvar_55;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((
    ((tmpvar_53 * tmpvar_53) * ((tmpvar_53 * tmpvar_53) * tmpvar_53))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_58;
  viewDir_58 = tmpvar_18.xyz;
  mediump float vertical_59;
  mediump float tmpvar_60;
  highp float tmpvar_61;
  tmpvar_61 = clamp (((
    dot (_ES_SunDirection, viewDir_58)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_60 = tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = dot (viewDir_58, _ES_SkyWorldUpDir);
  vertical_59 = tmpvar_62;
  mediump float tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = (1.0 - _ES_SunRimLightRadius);
  tmpvar_63 = clamp (((tmpvar_20 - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (((tmpvar_63 * 
    (tmpvar_63 * (3.0 - (2.0 * tmpvar_63)))
  ) * _ES_SunBrightness) * 0.125);
  mediump float tmpvar_66;
  tmpvar_66 = clamp (((
    ((dot (viewDir_14, _ES_MoonDirection) * 0.5) + 0.5)
   - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_67;
  tmpvar_67 = (((tmpvar_66 * 
    (tmpvar_66 * (3.0 - (2.0 * tmpvar_66)))
  ) * _ES_MoonBrightness) * 0.1);
  mediump float tmpvar_68;
  tmpvar_68 = max (((tmpvar_19 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_69;
  tmpvar_69 = ((tmpvar_68 * tmpvar_68) * tmpvar_68);
  gl_Position = clipPos_6;
  xlv_TEXCOORD0 = o_9;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = (((
    ((((tmpvar_57 * 
      (tmpvar_57 * (3.0 - (2.0 * tmpvar_57)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_52) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_60, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_59))
    ) * vertical_59), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_49);
  xlv_TEXCOORD6 = (((_ES_SunHaloColor * 
    (tmpvar_65 * tmpvar_65)
  ) + (_ES_MoonColor * 
    (tmpvar_67 * tmpvar_67)
  )) * tmpvar_49);
  xlv_TEXCOORD7 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_69));
  xlv_TEXCOORD8 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_69));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_CloudCoverage;
uniform sampler2D _CloudParticleAtlas;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 cloudCol_1;
  mediump vec4 texCol_2;
  highp vec3 curlNoise_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_CloudCurlTex, xlv_TEXCOORD1.zw).xyz;
  curlNoise_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD1.xy + ((
    (curlNoise_3.xy - 0.5)
   * curlNoise_3.z) * _CloudCurlAmplitude));
  tmpvar_5 = texture2D (_CloudParticleAtlas, P_6);
  texCol_2 = tmpvar_5;
  mediump float tmpvar_7;
  tmpvar_7 = max ((xlv_TEXCOORD3.w - xlv_TEXCOORD3.y), 0.0);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.y), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD2.w - -0.1) / 0.2), 0.0, 1.0);
  cloudCol_1.w = ((texCol_2.w * (tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  )) * (tmpvar_9 * (tmpvar_9 * 
    (3.0 - (2.0 * tmpvar_9))
  )));
  mediump float x_10;
  x_10 = (cloudCol_1.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.z), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  cloudCol_1.xyz = ((mix (xlv_TEXCOORD8, xlv_TEXCOORD7, texCol_2.xxx) + (xlv_TEXCOORD6 * 
    mix (texCol_2.y, ((1.0 - (tmpvar_11 * 
      (tmpvar_11 * (3.0 - (2.0 * tmpvar_11)))
    )) * 4.0), xlv_TEXCOORD3.w)
  )) + ((0.4 * xlv_TEXCOORD7) * _ES_CloudCoverage));
  cloudCol_1.xyz = (cloudCol_1.xyz + (xlv_TEXCOORD5 * texCol_2.x));
  cloudCol_1.xyz = (cloudCol_1.xyz * (xlv_TEXCOORD3.x + 1.0));
  mediump float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD2.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((_ES_CloudCoverage - 0.4) / 0.3), 0.0, 1.0);
  cloudCol_1.xyz = mix (xlv_TEXCOORD4, cloudCol_1.xyz, vec3(mix (clamp (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
  , 0.0, 1.0), 1.0, (tmpvar_13 * 
    (tmpvar_13 * (3.0 - (2.0 * tmpvar_13)))
  ))));
  cloudCol_1.w = clamp (cloudCol_1.w, 0.0, 1.0);
  gl_FragData[0] = cloudCol_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "FIXED_EDGE_SMOOTHNESS" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec4 _ES_TopFrontColor;
uniform mediump vec4 _ES_TopBackColor;
uniform mediump vec4 _ES_BottomFrontColor;
uniform mediump vec4 _ES_BottomBackColor;
uniform mediump float _ES_SkyFrontAndBackBlendFactor;
uniform mediump float _ES_BottomColorHeight;
uniform mediump vec3 _ES_HorizonHaloColor;
uniform mediump float _ES_HorizonHaloIntensity;
uniform mediump float _ES_HorizonHaloHeight;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump float _ES_SunHaloSize;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudAgePercent;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform sampler2D _SkyGradientTex;
uniform highp vec2 _AtlasTiles;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
uniform mediump float _FixedEdgeSmoothness;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float agePercent_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 clipPos_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  clipPos_6.xyw = tmpvar_7.xyw;
  clipPos_6.z = tmpvar_7.w;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7.xyww * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = clipPos_6.zw;
  highp int tmpvar_12;
  tmpvar_12 = int(floor((
    (_glesColor.y * ((_AtlasTiles.x * _AtlasTiles.y) - 1.0))
   + 0.5)));
  highp vec2 tmpvar_13;
  tmpvar_13.x = (float(mod (float(tmpvar_12), _AtlasTiles.x)));
  tmpvar_13.y = floor((float(tmpvar_12) / _AtlasTiles.x));
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy + tmpvar_13) / _AtlasTiles);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _CloudCurlTiling) + ((_ES_CloudElapsedTime * vec2(1.2, 0.8)) * _CloudCurlSpeed));
  mediump vec3 viewDir_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(((unity_ObjectToWorld * tmpvar_15).xyz - _ES_SkyCenterWorldPos));
  viewDir_14 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (_ES_SkyWorldUpDir, viewDir_14);
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = viewDir_14;
  tmpvar_18.w = ((sign(tmpvar_17) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_17))) * (1.570796 + (abs(tmpvar_17) * (-0.2146018 + 
      (abs(tmpvar_17) * (0.08656672 + (abs(tmpvar_17) * -0.03102955)))
    ))))
  )) * 0.6366198);
  mediump float tmpvar_19;
  tmpvar_19 = dot (viewDir_14, _ES_SunDirection);
  mediump float tmpvar_20;
  tmpvar_20 = ((tmpvar_19 * 0.5) + 0.5);
  tmpvar_4.x = (tmpvar_20 * _ES_CloudSunBrightenIntensity);
  tmpvar_4.y = _FixedEdgeSmoothness;
  tmpvar_4.z = _glesColor.w;
  highp float tmpvar_21;
  tmpvar_21 = (_glesMultiTexCoord1.y / max (_glesMultiTexCoord1.x, 1e-05));
  agePercent_2 = tmpvar_21;
  agePercent_2 = (agePercent_2 * _ES_CloudAgePercent);
  highp float tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = clamp ((agePercent_2 / _glesMultiTexCoord1.z), 0.0, 1.0);
  tmpvar_22 = (tmpvar_23 * (tmpvar_23 * (3.0 - 
    (2.0 * tmpvar_23)
  )));
  highp float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((agePercent_2 - _glesMultiTexCoord1.w) / (1.0 - _glesMultiTexCoord1.w)), 0.0, 1.0);
  tmpvar_24 = (tmpvar_25 * (tmpvar_25 * (3.0 - 
    (2.0 * tmpvar_25)
  )));
  tmpvar_4.w = (1.0 - (tmpvar_22 * (1.0 - tmpvar_24)));
  mediump vec3 atomosphere_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (_ES_SunDirection, viewDir_14);
  mediump float tmpvar_28;
  tmpvar_28 = max (((tmpvar_27 * _ES_SkyFrontAndBackBlendFactor) + (1.0 - _ES_SkyFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_29;
  tmpvar_29 = ((tmpvar_28 * tmpvar_28) * tmpvar_28);
  mediump vec4 tmpvar_30;
  tmpvar_30.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_30.x = (abs(tmpvar_18.w) / max (_ES_BottomColorHeight, 0.0001));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DLod (_SkyGradientTex, tmpvar_30.xy, 0.0);
  mediump float tmpvar_32;
  tmpvar_32 = tmpvar_31.x;
  atomosphere_26 = mix (mix (_ES_TopBackColor, _ES_TopFrontColor, vec4(tmpvar_29)).xyz, mix (_ES_BottomBackColor, _ES_BottomFrontColor, vec4(tmpvar_29)).xyz, vec3(tmpvar_32));
  mediump vec4 tmpvar_33;
  tmpvar_33.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_33.x = (abs(tmpvar_18.w) / max (_ES_HorizonHaloHeight, 0.0001));
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DLod (_SkyGradientTex, tmpvar_33.xy, 0.0);
  mediump float tmpvar_35;
  tmpvar_35 = tmpvar_34.y;
  mediump float tmpvar_36;
  tmpvar_36 = clamp (((
    max (((tmpvar_27 * 0.5) + 0.5), 0.0)
   - 0.3) / 0.7), 0.0, 1.0);
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    abs(_ES_SunDirection.y)
   - 0.2) / 0.3), 0.0, 1.0);
  atomosphere_26 = (atomosphere_26 + ((
    (_ES_HorizonHaloColor * _ES_HorizonHaloIntensity)
   * tmpvar_35) * mix (
    (tmpvar_36 * (tmpvar_36 * (3.0 - (2.0 * tmpvar_36))))
  , 1.0, 
    (tmpvar_37 * (tmpvar_37 * (3.0 - (2.0 * tmpvar_37))))
  )));
  highp vec3 viewDir_38;
  viewDir_38 = tmpvar_18.xyz;
  highp float haloInfluence_39;
  mediump float vertical_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((
    dot (_ES_SunDirection, viewDir_38)
   * 0.5) + 0.5), 0.0, 1.0);
  highp float tmpvar_42;
  tmpvar_42 = dot (viewDir_38, _ES_SkyWorldUpDir);
  vertical_40 = tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = abs(vertical_40);
  mediump float y_44;
  y_44 = (_ES_SunHaloSize * tmpvar_43);
  mediump float y_45;
  y_45 = ((_ES_SunHaloSize * 0.1) * tmpvar_43);
  haloInfluence_39 = (clamp (pow (tmpvar_41, y_44), 0.0, 1.0) + (clamp (
    pow (tmpvar_41, y_45)
  , 0.0, 1.0) * 0.12));
  mediump float y_46;
  y_46 = ((_ES_SunHaloSize * 0.01) * tmpvar_43);
  haloInfluence_39 = (haloInfluence_39 + (clamp (
    pow (tmpvar_41, y_46)
  , 0.0, 1.0) * 0.03));
  highp float tmpvar_47;
  tmpvar_47 = clamp (((
    max (((dot (_ES_SunDirection, viewDir_38) * 0.5) + 0.5), 0.0)
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 tmpvar_48;
  tmpvar_48 = (((haloInfluence_39 * _ES_SunHaloIntensity) * _ES_SunHaloColor) * (tmpvar_47 * (tmpvar_47 * 
    (3.0 - (2.0 * tmpvar_47))
  )));
  tmpvar_5 = (atomosphere_26 + tmpvar_48);
  mediump float tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_49 = (tmpvar_50 * (tmpvar_50 * (3.0 - 
    (2.0 * tmpvar_50)
  )));
  highp vec3 viewDir_51;
  viewDir_51 = tmpvar_18.xyz;
  mediump float moonLunarCancel_52;
  mediump float tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (_ES_MoonDirection, viewDir_51), 0.0, 1.0);
  tmpvar_53 = tmpvar_54;
  highp float tmpvar_55;
  mediump float tmpvar_56;
  tmpvar_56 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_55 = (1.0 - (tmpvar_56 * 2.0));
  moonLunarCancel_52 = tmpvar_55;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((
    ((tmpvar_53 * tmpvar_53) * ((tmpvar_53 * tmpvar_53) * tmpvar_53))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_58;
  viewDir_58 = tmpvar_18.xyz;
  mediump float vertical_59;
  mediump float tmpvar_60;
  highp float tmpvar_61;
  tmpvar_61 = clamp (((
    dot (_ES_SunDirection, viewDir_58)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_60 = tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = dot (viewDir_58, _ES_SkyWorldUpDir);
  vertical_59 = tmpvar_62;
  mediump float tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = (1.0 - _ES_SunRimLightRadius);
  tmpvar_63 = clamp (((tmpvar_20 - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (((tmpvar_63 * 
    (tmpvar_63 * (3.0 - (2.0 * tmpvar_63)))
  ) * _ES_SunBrightness) * 0.125);
  mediump float tmpvar_66;
  tmpvar_66 = clamp (((
    ((dot (viewDir_14, _ES_MoonDirection) * 0.5) + 0.5)
   - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_67;
  tmpvar_67 = (((tmpvar_66 * 
    (tmpvar_66 * (3.0 - (2.0 * tmpvar_66)))
  ) * _ES_MoonBrightness) * 0.1);
  mediump float tmpvar_68;
  tmpvar_68 = max (((tmpvar_19 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_69;
  tmpvar_69 = ((tmpvar_68 * tmpvar_68) * tmpvar_68);
  gl_Position = clipPos_6;
  xlv_TEXCOORD0 = o_9;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = (((
    ((((tmpvar_57 * 
      (tmpvar_57 * (3.0 - (2.0 * tmpvar_57)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_52) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_60, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_59))
    ) * vertical_59), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_49);
  xlv_TEXCOORD6 = (((_ES_SunHaloColor * 
    (tmpvar_65 * tmpvar_65)
  ) + (_ES_MoonColor * 
    (tmpvar_67 * tmpvar_67)
  )) * tmpvar_49);
  xlv_TEXCOORD7 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_69));
  xlv_TEXCOORD8 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_69));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_CloudCoverage;
uniform sampler2D _CloudParticleAtlas;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 cloudCol_1;
  mediump vec4 texCol_2;
  highp vec3 curlNoise_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_CloudCurlTex, xlv_TEXCOORD1.zw).xyz;
  curlNoise_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD1.xy + ((
    (curlNoise_3.xy - 0.5)
   * curlNoise_3.z) * _CloudCurlAmplitude));
  tmpvar_5 = texture2D (_CloudParticleAtlas, P_6);
  texCol_2 = tmpvar_5;
  mediump float tmpvar_7;
  tmpvar_7 = max ((xlv_TEXCOORD3.w - xlv_TEXCOORD3.y), 0.0);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.y), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD2.w - -0.1) / 0.2), 0.0, 1.0);
  cloudCol_1.w = ((texCol_2.w * (tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  )) * (tmpvar_9 * (tmpvar_9 * 
    (3.0 - (2.0 * tmpvar_9))
  )));
  mediump float x_10;
  x_10 = (cloudCol_1.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.z), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  cloudCol_1.xyz = ((mix (xlv_TEXCOORD8, xlv_TEXCOORD7, texCol_2.xxx) + (xlv_TEXCOORD6 * 
    mix (texCol_2.y, ((1.0 - (tmpvar_11 * 
      (tmpvar_11 * (3.0 - (2.0 * tmpvar_11)))
    )) * 4.0), xlv_TEXCOORD3.w)
  )) + ((0.4 * xlv_TEXCOORD7) * _ES_CloudCoverage));
  cloudCol_1.xyz = (cloudCol_1.xyz + (xlv_TEXCOORD5 * texCol_2.x));
  cloudCol_1.xyz = (cloudCol_1.xyz * (xlv_TEXCOORD3.x + 1.0));
  mediump float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD2.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((_ES_CloudCoverage - 0.4) / 0.3), 0.0, 1.0);
  cloudCol_1.xyz = mix (xlv_TEXCOORD4, cloudCol_1.xyz, vec3(mix (clamp (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
  , 0.0, 1.0), 1.0, (tmpvar_13 * 
    (tmpvar_13 * (3.0 - (2.0 * tmpvar_13)))
  ))));
  cloudCol_1.w = clamp (cloudCol_1.w, 0.0, 1.0);
  gl_FragData[0] = cloudCol_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "FIXED_EDGE_SMOOTHNESS" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec4 _ES_TopFrontColor;
uniform mediump vec4 _ES_TopBackColor;
uniform mediump vec4 _ES_BottomFrontColor;
uniform mediump vec4 _ES_BottomBackColor;
uniform mediump float _ES_SkyFrontAndBackBlendFactor;
uniform mediump float _ES_BottomColorHeight;
uniform mediump vec3 _ES_HorizonHaloColor;
uniform mediump float _ES_HorizonHaloIntensity;
uniform mediump float _ES_HorizonHaloHeight;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump float _ES_SunHaloSize;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudAgePercent;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform sampler2D _SkyGradientTex;
uniform highp vec2 _AtlasTiles;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
uniform mediump float _FixedEdgeSmoothness;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float agePercent_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 clipPos_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  clipPos_6.xyw = tmpvar_7.xyw;
  clipPos_6.z = tmpvar_7.w;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7.xyww * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = clipPos_6.zw;
  highp int tmpvar_12;
  tmpvar_12 = int(floor((
    (_glesColor.y * ((_AtlasTiles.x * _AtlasTiles.y) - 1.0))
   + 0.5)));
  highp vec2 tmpvar_13;
  tmpvar_13.x = (float(mod (float(tmpvar_12), _AtlasTiles.x)));
  tmpvar_13.y = floor((float(tmpvar_12) / _AtlasTiles.x));
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy + tmpvar_13) / _AtlasTiles);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _CloudCurlTiling) + ((_ES_CloudElapsedTime * vec2(1.2, 0.8)) * _CloudCurlSpeed));
  mediump vec3 viewDir_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(((unity_ObjectToWorld * tmpvar_15).xyz - _ES_SkyCenterWorldPos));
  viewDir_14 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (_ES_SkyWorldUpDir, viewDir_14);
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = viewDir_14;
  tmpvar_18.w = ((sign(tmpvar_17) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_17))) * (1.570796 + (abs(tmpvar_17) * (-0.2146018 + 
      (abs(tmpvar_17) * (0.08656672 + (abs(tmpvar_17) * -0.03102955)))
    ))))
  )) * 0.6366198);
  mediump float tmpvar_19;
  tmpvar_19 = dot (viewDir_14, _ES_SunDirection);
  mediump float tmpvar_20;
  tmpvar_20 = ((tmpvar_19 * 0.5) + 0.5);
  tmpvar_4.x = (tmpvar_20 * _ES_CloudSunBrightenIntensity);
  tmpvar_4.y = _FixedEdgeSmoothness;
  tmpvar_4.z = _glesColor.w;
  highp float tmpvar_21;
  tmpvar_21 = (_glesMultiTexCoord1.y / max (_glesMultiTexCoord1.x, 1e-05));
  agePercent_2 = tmpvar_21;
  agePercent_2 = (agePercent_2 * _ES_CloudAgePercent);
  highp float tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = clamp ((agePercent_2 / _glesMultiTexCoord1.z), 0.0, 1.0);
  tmpvar_22 = (tmpvar_23 * (tmpvar_23 * (3.0 - 
    (2.0 * tmpvar_23)
  )));
  highp float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((agePercent_2 - _glesMultiTexCoord1.w) / (1.0 - _glesMultiTexCoord1.w)), 0.0, 1.0);
  tmpvar_24 = (tmpvar_25 * (tmpvar_25 * (3.0 - 
    (2.0 * tmpvar_25)
  )));
  tmpvar_4.w = (1.0 - (tmpvar_22 * (1.0 - tmpvar_24)));
  mediump vec3 atomosphere_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (_ES_SunDirection, viewDir_14);
  mediump float tmpvar_28;
  tmpvar_28 = max (((tmpvar_27 * _ES_SkyFrontAndBackBlendFactor) + (1.0 - _ES_SkyFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_29;
  tmpvar_29 = ((tmpvar_28 * tmpvar_28) * tmpvar_28);
  mediump vec4 tmpvar_30;
  tmpvar_30.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_30.x = (abs(tmpvar_18.w) / max (_ES_BottomColorHeight, 0.0001));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DLod (_SkyGradientTex, tmpvar_30.xy, 0.0);
  mediump float tmpvar_32;
  tmpvar_32 = tmpvar_31.x;
  atomosphere_26 = mix (mix (_ES_TopBackColor, _ES_TopFrontColor, vec4(tmpvar_29)).xyz, mix (_ES_BottomBackColor, _ES_BottomFrontColor, vec4(tmpvar_29)).xyz, vec3(tmpvar_32));
  mediump vec4 tmpvar_33;
  tmpvar_33.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_33.x = (abs(tmpvar_18.w) / max (_ES_HorizonHaloHeight, 0.0001));
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DLod (_SkyGradientTex, tmpvar_33.xy, 0.0);
  mediump float tmpvar_35;
  tmpvar_35 = tmpvar_34.y;
  mediump float tmpvar_36;
  tmpvar_36 = clamp (((
    max (((tmpvar_27 * 0.5) + 0.5), 0.0)
   - 0.3) / 0.7), 0.0, 1.0);
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    abs(_ES_SunDirection.y)
   - 0.2) / 0.3), 0.0, 1.0);
  atomosphere_26 = (atomosphere_26 + ((
    (_ES_HorizonHaloColor * _ES_HorizonHaloIntensity)
   * tmpvar_35) * mix (
    (tmpvar_36 * (tmpvar_36 * (3.0 - (2.0 * tmpvar_36))))
  , 1.0, 
    (tmpvar_37 * (tmpvar_37 * (3.0 - (2.0 * tmpvar_37))))
  )));
  highp vec3 viewDir_38;
  viewDir_38 = tmpvar_18.xyz;
  highp float haloInfluence_39;
  mediump float vertical_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((
    dot (_ES_SunDirection, viewDir_38)
   * 0.5) + 0.5), 0.0, 1.0);
  highp float tmpvar_42;
  tmpvar_42 = dot (viewDir_38, _ES_SkyWorldUpDir);
  vertical_40 = tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = abs(vertical_40);
  mediump float y_44;
  y_44 = (_ES_SunHaloSize * tmpvar_43);
  mediump float y_45;
  y_45 = ((_ES_SunHaloSize * 0.1) * tmpvar_43);
  haloInfluence_39 = (clamp (pow (tmpvar_41, y_44), 0.0, 1.0) + (clamp (
    pow (tmpvar_41, y_45)
  , 0.0, 1.0) * 0.12));
  mediump float y_46;
  y_46 = ((_ES_SunHaloSize * 0.01) * tmpvar_43);
  haloInfluence_39 = (haloInfluence_39 + (clamp (
    pow (tmpvar_41, y_46)
  , 0.0, 1.0) * 0.03));
  highp float tmpvar_47;
  tmpvar_47 = clamp (((
    max (((dot (_ES_SunDirection, viewDir_38) * 0.5) + 0.5), 0.0)
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 tmpvar_48;
  tmpvar_48 = (((haloInfluence_39 * _ES_SunHaloIntensity) * _ES_SunHaloColor) * (tmpvar_47 * (tmpvar_47 * 
    (3.0 - (2.0 * tmpvar_47))
  )));
  tmpvar_5 = (atomosphere_26 + tmpvar_48);
  mediump float tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_49 = (tmpvar_50 * (tmpvar_50 * (3.0 - 
    (2.0 * tmpvar_50)
  )));
  highp vec3 viewDir_51;
  viewDir_51 = tmpvar_18.xyz;
  mediump float moonLunarCancel_52;
  mediump float tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (_ES_MoonDirection, viewDir_51), 0.0, 1.0);
  tmpvar_53 = tmpvar_54;
  highp float tmpvar_55;
  mediump float tmpvar_56;
  tmpvar_56 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_55 = (1.0 - (tmpvar_56 * 2.0));
  moonLunarCancel_52 = tmpvar_55;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((
    ((tmpvar_53 * tmpvar_53) * ((tmpvar_53 * tmpvar_53) * tmpvar_53))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_58;
  viewDir_58 = tmpvar_18.xyz;
  mediump float vertical_59;
  mediump float tmpvar_60;
  highp float tmpvar_61;
  tmpvar_61 = clamp (((
    dot (_ES_SunDirection, viewDir_58)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_60 = tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = dot (viewDir_58, _ES_SkyWorldUpDir);
  vertical_59 = tmpvar_62;
  mediump float tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = (1.0 - _ES_SunRimLightRadius);
  tmpvar_63 = clamp (((tmpvar_20 - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (((tmpvar_63 * 
    (tmpvar_63 * (3.0 - (2.0 * tmpvar_63)))
  ) * _ES_SunBrightness) * 0.125);
  mediump float tmpvar_66;
  tmpvar_66 = clamp (((
    ((dot (viewDir_14, _ES_MoonDirection) * 0.5) + 0.5)
   - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_67;
  tmpvar_67 = (((tmpvar_66 * 
    (tmpvar_66 * (3.0 - (2.0 * tmpvar_66)))
  ) * _ES_MoonBrightness) * 0.1);
  mediump float tmpvar_68;
  tmpvar_68 = max (((tmpvar_19 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_69;
  tmpvar_69 = ((tmpvar_68 * tmpvar_68) * tmpvar_68);
  gl_Position = clipPos_6;
  xlv_TEXCOORD0 = o_9;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = (((
    ((((tmpvar_57 * 
      (tmpvar_57 * (3.0 - (2.0 * tmpvar_57)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_52) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_60, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_59))
    ) * vertical_59), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_49);
  xlv_TEXCOORD6 = (((_ES_SunHaloColor * 
    (tmpvar_65 * tmpvar_65)
  ) + (_ES_MoonColor * 
    (tmpvar_67 * tmpvar_67)
  )) * tmpvar_49);
  xlv_TEXCOORD7 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_69));
  xlv_TEXCOORD8 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_69));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_CloudCoverage;
uniform sampler2D _CloudParticleAtlas;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 cloudCol_1;
  mediump vec4 texCol_2;
  highp vec3 curlNoise_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_CloudCurlTex, xlv_TEXCOORD1.zw).xyz;
  curlNoise_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD1.xy + ((
    (curlNoise_3.xy - 0.5)
   * curlNoise_3.z) * _CloudCurlAmplitude));
  tmpvar_5 = texture2D (_CloudParticleAtlas, P_6);
  texCol_2 = tmpvar_5;
  mediump float tmpvar_7;
  tmpvar_7 = max ((xlv_TEXCOORD3.w - xlv_TEXCOORD3.y), 0.0);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.y), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD2.w - -0.1) / 0.2), 0.0, 1.0);
  cloudCol_1.w = ((texCol_2.w * (tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  )) * (tmpvar_9 * (tmpvar_9 * 
    (3.0 - (2.0 * tmpvar_9))
  )));
  mediump float x_10;
  x_10 = (cloudCol_1.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.z), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  cloudCol_1.xyz = ((mix (xlv_TEXCOORD8, xlv_TEXCOORD7, texCol_2.xxx) + (xlv_TEXCOORD6 * 
    mix (texCol_2.y, ((1.0 - (tmpvar_11 * 
      (tmpvar_11 * (3.0 - (2.0 * tmpvar_11)))
    )) * 4.0), xlv_TEXCOORD3.w)
  )) + ((0.4 * xlv_TEXCOORD7) * _ES_CloudCoverage));
  cloudCol_1.xyz = (cloudCol_1.xyz + (xlv_TEXCOORD5 * texCol_2.x));
  cloudCol_1.xyz = (cloudCol_1.xyz * (xlv_TEXCOORD3.x + 1.0));
  mediump float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD2.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((_ES_CloudCoverage - 0.4) / 0.3), 0.0, 1.0);
  cloudCol_1.xyz = mix (xlv_TEXCOORD4, cloudCol_1.xyz, vec3(mix (clamp (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
  , 0.0, 1.0), 1.0, (tmpvar_13 * 
    (tmpvar_13 * (3.0 - (2.0 * tmpvar_13)))
  ))));
  cloudCol_1.w = clamp (cloudCol_1.w, 0.0, 1.0);
  gl_FragData[0] = cloudCol_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FIXED_EDGE_SMOOTHNESS" "FIXED_RIMLIGHT_WIDTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec4 _ES_TopFrontColor;
uniform mediump vec4 _ES_TopBackColor;
uniform mediump vec4 _ES_BottomFrontColor;
uniform mediump vec4 _ES_BottomBackColor;
uniform mediump float _ES_SkyFrontAndBackBlendFactor;
uniform mediump float _ES_BottomColorHeight;
uniform mediump vec3 _ES_HorizonHaloColor;
uniform mediump float _ES_HorizonHaloIntensity;
uniform mediump float _ES_HorizonHaloHeight;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump float _ES_SunHaloSize;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudAgePercent;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform sampler2D _SkyGradientTex;
uniform highp vec2 _AtlasTiles;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
uniform mediump float _FixedEdgeSmoothness;
uniform mediump float _FixedRimLightWidth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float agePercent_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 clipPos_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  clipPos_6.xyw = tmpvar_7.xyw;
  clipPos_6.z = tmpvar_7.w;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7.xyww * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = clipPos_6.zw;
  highp int tmpvar_12;
  tmpvar_12 = int(floor((
    (_glesColor.y * ((_AtlasTiles.x * _AtlasTiles.y) - 1.0))
   + 0.5)));
  highp vec2 tmpvar_13;
  tmpvar_13.x = (float(mod (float(tmpvar_12), _AtlasTiles.x)));
  tmpvar_13.y = floor((float(tmpvar_12) / _AtlasTiles.x));
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy + tmpvar_13) / _AtlasTiles);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _CloudCurlTiling) + ((_ES_CloudElapsedTime * vec2(1.2, 0.8)) * _CloudCurlSpeed));
  mediump vec3 viewDir_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(((unity_ObjectToWorld * tmpvar_15).xyz - _ES_SkyCenterWorldPos));
  viewDir_14 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (_ES_SkyWorldUpDir, viewDir_14);
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = viewDir_14;
  tmpvar_18.w = ((sign(tmpvar_17) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_17))) * (1.570796 + (abs(tmpvar_17) * (-0.2146018 + 
      (abs(tmpvar_17) * (0.08656672 + (abs(tmpvar_17) * -0.03102955)))
    ))))
  )) * 0.6366198);
  mediump float tmpvar_19;
  tmpvar_19 = dot (viewDir_14, _ES_SunDirection);
  mediump float tmpvar_20;
  tmpvar_20 = ((tmpvar_19 * 0.5) + 0.5);
  tmpvar_4.x = (tmpvar_20 * _ES_CloudSunBrightenIntensity);
  tmpvar_4.y = _FixedEdgeSmoothness;
  tmpvar_4.z = _FixedRimLightWidth;
  highp float tmpvar_21;
  tmpvar_21 = (_glesMultiTexCoord1.y / max (_glesMultiTexCoord1.x, 1e-05));
  agePercent_2 = tmpvar_21;
  agePercent_2 = (agePercent_2 * _ES_CloudAgePercent);
  highp float tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = clamp ((agePercent_2 / _glesMultiTexCoord1.z), 0.0, 1.0);
  tmpvar_22 = (tmpvar_23 * (tmpvar_23 * (3.0 - 
    (2.0 * tmpvar_23)
  )));
  highp float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((agePercent_2 - _glesMultiTexCoord1.w) / (1.0 - _glesMultiTexCoord1.w)), 0.0, 1.0);
  tmpvar_24 = (tmpvar_25 * (tmpvar_25 * (3.0 - 
    (2.0 * tmpvar_25)
  )));
  tmpvar_4.w = (1.0 - (tmpvar_22 * (1.0 - tmpvar_24)));
  mediump vec3 atomosphere_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (_ES_SunDirection, viewDir_14);
  mediump float tmpvar_28;
  tmpvar_28 = max (((tmpvar_27 * _ES_SkyFrontAndBackBlendFactor) + (1.0 - _ES_SkyFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_29;
  tmpvar_29 = ((tmpvar_28 * tmpvar_28) * tmpvar_28);
  mediump vec4 tmpvar_30;
  tmpvar_30.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_30.x = (abs(tmpvar_18.w) / max (_ES_BottomColorHeight, 0.0001));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DLod (_SkyGradientTex, tmpvar_30.xy, 0.0);
  mediump float tmpvar_32;
  tmpvar_32 = tmpvar_31.x;
  atomosphere_26 = mix (mix (_ES_TopBackColor, _ES_TopFrontColor, vec4(tmpvar_29)).xyz, mix (_ES_BottomBackColor, _ES_BottomFrontColor, vec4(tmpvar_29)).xyz, vec3(tmpvar_32));
  mediump vec4 tmpvar_33;
  tmpvar_33.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_33.x = (abs(tmpvar_18.w) / max (_ES_HorizonHaloHeight, 0.0001));
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DLod (_SkyGradientTex, tmpvar_33.xy, 0.0);
  mediump float tmpvar_35;
  tmpvar_35 = tmpvar_34.y;
  mediump float tmpvar_36;
  tmpvar_36 = clamp (((
    max (((tmpvar_27 * 0.5) + 0.5), 0.0)
   - 0.3) / 0.7), 0.0, 1.0);
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    abs(_ES_SunDirection.y)
   - 0.2) / 0.3), 0.0, 1.0);
  atomosphere_26 = (atomosphere_26 + ((
    (_ES_HorizonHaloColor * _ES_HorizonHaloIntensity)
   * tmpvar_35) * mix (
    (tmpvar_36 * (tmpvar_36 * (3.0 - (2.0 * tmpvar_36))))
  , 1.0, 
    (tmpvar_37 * (tmpvar_37 * (3.0 - (2.0 * tmpvar_37))))
  )));
  highp vec3 viewDir_38;
  viewDir_38 = tmpvar_18.xyz;
  highp float haloInfluence_39;
  mediump float vertical_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((
    dot (_ES_SunDirection, viewDir_38)
   * 0.5) + 0.5), 0.0, 1.0);
  highp float tmpvar_42;
  tmpvar_42 = dot (viewDir_38, _ES_SkyWorldUpDir);
  vertical_40 = tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = abs(vertical_40);
  mediump float y_44;
  y_44 = (_ES_SunHaloSize * tmpvar_43);
  mediump float y_45;
  y_45 = ((_ES_SunHaloSize * 0.1) * tmpvar_43);
  haloInfluence_39 = (clamp (pow (tmpvar_41, y_44), 0.0, 1.0) + (clamp (
    pow (tmpvar_41, y_45)
  , 0.0, 1.0) * 0.12));
  mediump float y_46;
  y_46 = ((_ES_SunHaloSize * 0.01) * tmpvar_43);
  haloInfluence_39 = (haloInfluence_39 + (clamp (
    pow (tmpvar_41, y_46)
  , 0.0, 1.0) * 0.03));
  highp float tmpvar_47;
  tmpvar_47 = clamp (((
    max (((dot (_ES_SunDirection, viewDir_38) * 0.5) + 0.5), 0.0)
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 tmpvar_48;
  tmpvar_48 = (((haloInfluence_39 * _ES_SunHaloIntensity) * _ES_SunHaloColor) * (tmpvar_47 * (tmpvar_47 * 
    (3.0 - (2.0 * tmpvar_47))
  )));
  tmpvar_5 = (atomosphere_26 + tmpvar_48);
  mediump float tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_49 = (tmpvar_50 * (tmpvar_50 * (3.0 - 
    (2.0 * tmpvar_50)
  )));
  highp vec3 viewDir_51;
  viewDir_51 = tmpvar_18.xyz;
  mediump float moonLunarCancel_52;
  mediump float tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (_ES_MoonDirection, viewDir_51), 0.0, 1.0);
  tmpvar_53 = tmpvar_54;
  highp float tmpvar_55;
  mediump float tmpvar_56;
  tmpvar_56 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_55 = (1.0 - (tmpvar_56 * 2.0));
  moonLunarCancel_52 = tmpvar_55;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((
    ((tmpvar_53 * tmpvar_53) * ((tmpvar_53 * tmpvar_53) * tmpvar_53))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_58;
  viewDir_58 = tmpvar_18.xyz;
  mediump float vertical_59;
  mediump float tmpvar_60;
  highp float tmpvar_61;
  tmpvar_61 = clamp (((
    dot (_ES_SunDirection, viewDir_58)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_60 = tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = dot (viewDir_58, _ES_SkyWorldUpDir);
  vertical_59 = tmpvar_62;
  mediump float tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = (1.0 - _ES_SunRimLightRadius);
  tmpvar_63 = clamp (((tmpvar_20 - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (((tmpvar_63 * 
    (tmpvar_63 * (3.0 - (2.0 * tmpvar_63)))
  ) * _ES_SunBrightness) * 0.125);
  mediump float tmpvar_66;
  tmpvar_66 = clamp (((
    ((dot (viewDir_14, _ES_MoonDirection) * 0.5) + 0.5)
   - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_67;
  tmpvar_67 = (((tmpvar_66 * 
    (tmpvar_66 * (3.0 - (2.0 * tmpvar_66)))
  ) * _ES_MoonBrightness) * 0.1);
  mediump float tmpvar_68;
  tmpvar_68 = max (((tmpvar_19 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_69;
  tmpvar_69 = ((tmpvar_68 * tmpvar_68) * tmpvar_68);
  gl_Position = clipPos_6;
  xlv_TEXCOORD0 = o_9;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = (((
    ((((tmpvar_57 * 
      (tmpvar_57 * (3.0 - (2.0 * tmpvar_57)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_52) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_60, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_59))
    ) * vertical_59), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_49);
  xlv_TEXCOORD6 = (((_ES_SunHaloColor * 
    (tmpvar_65 * tmpvar_65)
  ) + (_ES_MoonColor * 
    (tmpvar_67 * tmpvar_67)
  )) * tmpvar_49);
  xlv_TEXCOORD7 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_69));
  xlv_TEXCOORD8 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_69));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_CloudCoverage;
uniform sampler2D _CloudParticleAtlas;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 cloudCol_1;
  mediump vec4 texCol_2;
  highp vec3 curlNoise_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_CloudCurlTex, xlv_TEXCOORD1.zw).xyz;
  curlNoise_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD1.xy + ((
    (curlNoise_3.xy - 0.5)
   * curlNoise_3.z) * _CloudCurlAmplitude));
  tmpvar_5 = texture2D (_CloudParticleAtlas, P_6);
  texCol_2 = tmpvar_5;
  mediump float tmpvar_7;
  tmpvar_7 = max ((xlv_TEXCOORD3.w - xlv_TEXCOORD3.y), 0.0);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.y), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD2.w - -0.1) / 0.2), 0.0, 1.0);
  cloudCol_1.w = ((texCol_2.w * (tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  )) * (tmpvar_9 * (tmpvar_9 * 
    (3.0 - (2.0 * tmpvar_9))
  )));
  mediump float x_10;
  x_10 = (cloudCol_1.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.z), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  cloudCol_1.xyz = ((mix (xlv_TEXCOORD8, xlv_TEXCOORD7, texCol_2.xxx) + (xlv_TEXCOORD6 * 
    mix (texCol_2.y, ((1.0 - (tmpvar_11 * 
      (tmpvar_11 * (3.0 - (2.0 * tmpvar_11)))
    )) * 4.0), xlv_TEXCOORD3.w)
  )) + ((0.4 * xlv_TEXCOORD7) * _ES_CloudCoverage));
  cloudCol_1.xyz = (cloudCol_1.xyz + (xlv_TEXCOORD5 * texCol_2.x));
  cloudCol_1.xyz = (cloudCol_1.xyz * (xlv_TEXCOORD3.x + 1.0));
  mediump float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD2.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((_ES_CloudCoverage - 0.4) / 0.3), 0.0, 1.0);
  cloudCol_1.xyz = mix (xlv_TEXCOORD4, cloudCol_1.xyz, vec3(mix (clamp (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
  , 0.0, 1.0), 1.0, (tmpvar_13 * 
    (tmpvar_13 * (3.0 - (2.0 * tmpvar_13)))
  ))));
  cloudCol_1.w = clamp (cloudCol_1.w, 0.0, 1.0);
  gl_FragData[0] = cloudCol_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FIXED_EDGE_SMOOTHNESS" "FIXED_RIMLIGHT_WIDTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec4 _ES_TopFrontColor;
uniform mediump vec4 _ES_TopBackColor;
uniform mediump vec4 _ES_BottomFrontColor;
uniform mediump vec4 _ES_BottomBackColor;
uniform mediump float _ES_SkyFrontAndBackBlendFactor;
uniform mediump float _ES_BottomColorHeight;
uniform mediump vec3 _ES_HorizonHaloColor;
uniform mediump float _ES_HorizonHaloIntensity;
uniform mediump float _ES_HorizonHaloHeight;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump float _ES_SunHaloSize;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudAgePercent;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform sampler2D _SkyGradientTex;
uniform highp vec2 _AtlasTiles;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
uniform mediump float _FixedEdgeSmoothness;
uniform mediump float _FixedRimLightWidth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float agePercent_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 clipPos_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  clipPos_6.xyw = tmpvar_7.xyw;
  clipPos_6.z = tmpvar_7.w;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7.xyww * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = clipPos_6.zw;
  highp int tmpvar_12;
  tmpvar_12 = int(floor((
    (_glesColor.y * ((_AtlasTiles.x * _AtlasTiles.y) - 1.0))
   + 0.5)));
  highp vec2 tmpvar_13;
  tmpvar_13.x = (float(mod (float(tmpvar_12), _AtlasTiles.x)));
  tmpvar_13.y = floor((float(tmpvar_12) / _AtlasTiles.x));
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy + tmpvar_13) / _AtlasTiles);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _CloudCurlTiling) + ((_ES_CloudElapsedTime * vec2(1.2, 0.8)) * _CloudCurlSpeed));
  mediump vec3 viewDir_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(((unity_ObjectToWorld * tmpvar_15).xyz - _ES_SkyCenterWorldPos));
  viewDir_14 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (_ES_SkyWorldUpDir, viewDir_14);
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = viewDir_14;
  tmpvar_18.w = ((sign(tmpvar_17) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_17))) * (1.570796 + (abs(tmpvar_17) * (-0.2146018 + 
      (abs(tmpvar_17) * (0.08656672 + (abs(tmpvar_17) * -0.03102955)))
    ))))
  )) * 0.6366198);
  mediump float tmpvar_19;
  tmpvar_19 = dot (viewDir_14, _ES_SunDirection);
  mediump float tmpvar_20;
  tmpvar_20 = ((tmpvar_19 * 0.5) + 0.5);
  tmpvar_4.x = (tmpvar_20 * _ES_CloudSunBrightenIntensity);
  tmpvar_4.y = _FixedEdgeSmoothness;
  tmpvar_4.z = _FixedRimLightWidth;
  highp float tmpvar_21;
  tmpvar_21 = (_glesMultiTexCoord1.y / max (_glesMultiTexCoord1.x, 1e-05));
  agePercent_2 = tmpvar_21;
  agePercent_2 = (agePercent_2 * _ES_CloudAgePercent);
  highp float tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = clamp ((agePercent_2 / _glesMultiTexCoord1.z), 0.0, 1.0);
  tmpvar_22 = (tmpvar_23 * (tmpvar_23 * (3.0 - 
    (2.0 * tmpvar_23)
  )));
  highp float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((agePercent_2 - _glesMultiTexCoord1.w) / (1.0 - _glesMultiTexCoord1.w)), 0.0, 1.0);
  tmpvar_24 = (tmpvar_25 * (tmpvar_25 * (3.0 - 
    (2.0 * tmpvar_25)
  )));
  tmpvar_4.w = (1.0 - (tmpvar_22 * (1.0 - tmpvar_24)));
  mediump vec3 atomosphere_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (_ES_SunDirection, viewDir_14);
  mediump float tmpvar_28;
  tmpvar_28 = max (((tmpvar_27 * _ES_SkyFrontAndBackBlendFactor) + (1.0 - _ES_SkyFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_29;
  tmpvar_29 = ((tmpvar_28 * tmpvar_28) * tmpvar_28);
  mediump vec4 tmpvar_30;
  tmpvar_30.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_30.x = (abs(tmpvar_18.w) / max (_ES_BottomColorHeight, 0.0001));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DLod (_SkyGradientTex, tmpvar_30.xy, 0.0);
  mediump float tmpvar_32;
  tmpvar_32 = tmpvar_31.x;
  atomosphere_26 = mix (mix (_ES_TopBackColor, _ES_TopFrontColor, vec4(tmpvar_29)).xyz, mix (_ES_BottomBackColor, _ES_BottomFrontColor, vec4(tmpvar_29)).xyz, vec3(tmpvar_32));
  mediump vec4 tmpvar_33;
  tmpvar_33.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_33.x = (abs(tmpvar_18.w) / max (_ES_HorizonHaloHeight, 0.0001));
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DLod (_SkyGradientTex, tmpvar_33.xy, 0.0);
  mediump float tmpvar_35;
  tmpvar_35 = tmpvar_34.y;
  mediump float tmpvar_36;
  tmpvar_36 = clamp (((
    max (((tmpvar_27 * 0.5) + 0.5), 0.0)
   - 0.3) / 0.7), 0.0, 1.0);
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    abs(_ES_SunDirection.y)
   - 0.2) / 0.3), 0.0, 1.0);
  atomosphere_26 = (atomosphere_26 + ((
    (_ES_HorizonHaloColor * _ES_HorizonHaloIntensity)
   * tmpvar_35) * mix (
    (tmpvar_36 * (tmpvar_36 * (3.0 - (2.0 * tmpvar_36))))
  , 1.0, 
    (tmpvar_37 * (tmpvar_37 * (3.0 - (2.0 * tmpvar_37))))
  )));
  highp vec3 viewDir_38;
  viewDir_38 = tmpvar_18.xyz;
  highp float haloInfluence_39;
  mediump float vertical_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((
    dot (_ES_SunDirection, viewDir_38)
   * 0.5) + 0.5), 0.0, 1.0);
  highp float tmpvar_42;
  tmpvar_42 = dot (viewDir_38, _ES_SkyWorldUpDir);
  vertical_40 = tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = abs(vertical_40);
  mediump float y_44;
  y_44 = (_ES_SunHaloSize * tmpvar_43);
  mediump float y_45;
  y_45 = ((_ES_SunHaloSize * 0.1) * tmpvar_43);
  haloInfluence_39 = (clamp (pow (tmpvar_41, y_44), 0.0, 1.0) + (clamp (
    pow (tmpvar_41, y_45)
  , 0.0, 1.0) * 0.12));
  mediump float y_46;
  y_46 = ((_ES_SunHaloSize * 0.01) * tmpvar_43);
  haloInfluence_39 = (haloInfluence_39 + (clamp (
    pow (tmpvar_41, y_46)
  , 0.0, 1.0) * 0.03));
  highp float tmpvar_47;
  tmpvar_47 = clamp (((
    max (((dot (_ES_SunDirection, viewDir_38) * 0.5) + 0.5), 0.0)
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 tmpvar_48;
  tmpvar_48 = (((haloInfluence_39 * _ES_SunHaloIntensity) * _ES_SunHaloColor) * (tmpvar_47 * (tmpvar_47 * 
    (3.0 - (2.0 * tmpvar_47))
  )));
  tmpvar_5 = (atomosphere_26 + tmpvar_48);
  mediump float tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_49 = (tmpvar_50 * (tmpvar_50 * (3.0 - 
    (2.0 * tmpvar_50)
  )));
  highp vec3 viewDir_51;
  viewDir_51 = tmpvar_18.xyz;
  mediump float moonLunarCancel_52;
  mediump float tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (_ES_MoonDirection, viewDir_51), 0.0, 1.0);
  tmpvar_53 = tmpvar_54;
  highp float tmpvar_55;
  mediump float tmpvar_56;
  tmpvar_56 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_55 = (1.0 - (tmpvar_56 * 2.0));
  moonLunarCancel_52 = tmpvar_55;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((
    ((tmpvar_53 * tmpvar_53) * ((tmpvar_53 * tmpvar_53) * tmpvar_53))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_58;
  viewDir_58 = tmpvar_18.xyz;
  mediump float vertical_59;
  mediump float tmpvar_60;
  highp float tmpvar_61;
  tmpvar_61 = clamp (((
    dot (_ES_SunDirection, viewDir_58)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_60 = tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = dot (viewDir_58, _ES_SkyWorldUpDir);
  vertical_59 = tmpvar_62;
  mediump float tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = (1.0 - _ES_SunRimLightRadius);
  tmpvar_63 = clamp (((tmpvar_20 - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (((tmpvar_63 * 
    (tmpvar_63 * (3.0 - (2.0 * tmpvar_63)))
  ) * _ES_SunBrightness) * 0.125);
  mediump float tmpvar_66;
  tmpvar_66 = clamp (((
    ((dot (viewDir_14, _ES_MoonDirection) * 0.5) + 0.5)
   - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_67;
  tmpvar_67 = (((tmpvar_66 * 
    (tmpvar_66 * (3.0 - (2.0 * tmpvar_66)))
  ) * _ES_MoonBrightness) * 0.1);
  mediump float tmpvar_68;
  tmpvar_68 = max (((tmpvar_19 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_69;
  tmpvar_69 = ((tmpvar_68 * tmpvar_68) * tmpvar_68);
  gl_Position = clipPos_6;
  xlv_TEXCOORD0 = o_9;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = (((
    ((((tmpvar_57 * 
      (tmpvar_57 * (3.0 - (2.0 * tmpvar_57)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_52) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_60, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_59))
    ) * vertical_59), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_49);
  xlv_TEXCOORD6 = (((_ES_SunHaloColor * 
    (tmpvar_65 * tmpvar_65)
  ) + (_ES_MoonColor * 
    (tmpvar_67 * tmpvar_67)
  )) * tmpvar_49);
  xlv_TEXCOORD7 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_69));
  xlv_TEXCOORD8 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_69));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_CloudCoverage;
uniform sampler2D _CloudParticleAtlas;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 cloudCol_1;
  mediump vec4 texCol_2;
  highp vec3 curlNoise_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_CloudCurlTex, xlv_TEXCOORD1.zw).xyz;
  curlNoise_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD1.xy + ((
    (curlNoise_3.xy - 0.5)
   * curlNoise_3.z) * _CloudCurlAmplitude));
  tmpvar_5 = texture2D (_CloudParticleAtlas, P_6);
  texCol_2 = tmpvar_5;
  mediump float tmpvar_7;
  tmpvar_7 = max ((xlv_TEXCOORD3.w - xlv_TEXCOORD3.y), 0.0);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.y), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD2.w - -0.1) / 0.2), 0.0, 1.0);
  cloudCol_1.w = ((texCol_2.w * (tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  )) * (tmpvar_9 * (tmpvar_9 * 
    (3.0 - (2.0 * tmpvar_9))
  )));
  mediump float x_10;
  x_10 = (cloudCol_1.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.z), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  cloudCol_1.xyz = ((mix (xlv_TEXCOORD8, xlv_TEXCOORD7, texCol_2.xxx) + (xlv_TEXCOORD6 * 
    mix (texCol_2.y, ((1.0 - (tmpvar_11 * 
      (tmpvar_11 * (3.0 - (2.0 * tmpvar_11)))
    )) * 4.0), xlv_TEXCOORD3.w)
  )) + ((0.4 * xlv_TEXCOORD7) * _ES_CloudCoverage));
  cloudCol_1.xyz = (cloudCol_1.xyz + (xlv_TEXCOORD5 * texCol_2.x));
  cloudCol_1.xyz = (cloudCol_1.xyz * (xlv_TEXCOORD3.x + 1.0));
  mediump float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD2.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((_ES_CloudCoverage - 0.4) / 0.3), 0.0, 1.0);
  cloudCol_1.xyz = mix (xlv_TEXCOORD4, cloudCol_1.xyz, vec3(mix (clamp (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
  , 0.0, 1.0), 1.0, (tmpvar_13 * 
    (tmpvar_13 * (3.0 - (2.0 * tmpvar_13)))
  ))));
  cloudCol_1.w = clamp (cloudCol_1.w, 0.0, 1.0);
  gl_FragData[0] = cloudCol_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FIXED_EDGE_SMOOTHNESS" "FIXED_RIMLIGHT_WIDTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec4 _ES_TopFrontColor;
uniform mediump vec4 _ES_TopBackColor;
uniform mediump vec4 _ES_BottomFrontColor;
uniform mediump vec4 _ES_BottomBackColor;
uniform mediump float _ES_SkyFrontAndBackBlendFactor;
uniform mediump float _ES_BottomColorHeight;
uniform mediump vec3 _ES_HorizonHaloColor;
uniform mediump float _ES_HorizonHaloIntensity;
uniform mediump float _ES_HorizonHaloHeight;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump float _ES_SunHaloSize;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudAgePercent;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform sampler2D _SkyGradientTex;
uniform highp vec2 _AtlasTiles;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
uniform mediump float _FixedEdgeSmoothness;
uniform mediump float _FixedRimLightWidth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float agePercent_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 clipPos_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  clipPos_6.xyw = tmpvar_7.xyw;
  clipPos_6.z = tmpvar_7.w;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7.xyww * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = clipPos_6.zw;
  highp int tmpvar_12;
  tmpvar_12 = int(floor((
    (_glesColor.y * ((_AtlasTiles.x * _AtlasTiles.y) - 1.0))
   + 0.5)));
  highp vec2 tmpvar_13;
  tmpvar_13.x = (float(mod (float(tmpvar_12), _AtlasTiles.x)));
  tmpvar_13.y = floor((float(tmpvar_12) / _AtlasTiles.x));
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy + tmpvar_13) / _AtlasTiles);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _CloudCurlTiling) + ((_ES_CloudElapsedTime * vec2(1.2, 0.8)) * _CloudCurlSpeed));
  mediump vec3 viewDir_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(((unity_ObjectToWorld * tmpvar_15).xyz - _ES_SkyCenterWorldPos));
  viewDir_14 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (_ES_SkyWorldUpDir, viewDir_14);
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = viewDir_14;
  tmpvar_18.w = ((sign(tmpvar_17) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_17))) * (1.570796 + (abs(tmpvar_17) * (-0.2146018 + 
      (abs(tmpvar_17) * (0.08656672 + (abs(tmpvar_17) * -0.03102955)))
    ))))
  )) * 0.6366198);
  mediump float tmpvar_19;
  tmpvar_19 = dot (viewDir_14, _ES_SunDirection);
  mediump float tmpvar_20;
  tmpvar_20 = ((tmpvar_19 * 0.5) + 0.5);
  tmpvar_4.x = (tmpvar_20 * _ES_CloudSunBrightenIntensity);
  tmpvar_4.y = _FixedEdgeSmoothness;
  tmpvar_4.z = _FixedRimLightWidth;
  highp float tmpvar_21;
  tmpvar_21 = (_glesMultiTexCoord1.y / max (_glesMultiTexCoord1.x, 1e-05));
  agePercent_2 = tmpvar_21;
  agePercent_2 = (agePercent_2 * _ES_CloudAgePercent);
  highp float tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = clamp ((agePercent_2 / _glesMultiTexCoord1.z), 0.0, 1.0);
  tmpvar_22 = (tmpvar_23 * (tmpvar_23 * (3.0 - 
    (2.0 * tmpvar_23)
  )));
  highp float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((agePercent_2 - _glesMultiTexCoord1.w) / (1.0 - _glesMultiTexCoord1.w)), 0.0, 1.0);
  tmpvar_24 = (tmpvar_25 * (tmpvar_25 * (3.0 - 
    (2.0 * tmpvar_25)
  )));
  tmpvar_4.w = (1.0 - (tmpvar_22 * (1.0 - tmpvar_24)));
  mediump vec3 atomosphere_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (_ES_SunDirection, viewDir_14);
  mediump float tmpvar_28;
  tmpvar_28 = max (((tmpvar_27 * _ES_SkyFrontAndBackBlendFactor) + (1.0 - _ES_SkyFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_29;
  tmpvar_29 = ((tmpvar_28 * tmpvar_28) * tmpvar_28);
  mediump vec4 tmpvar_30;
  tmpvar_30.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_30.x = (abs(tmpvar_18.w) / max (_ES_BottomColorHeight, 0.0001));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DLod (_SkyGradientTex, tmpvar_30.xy, 0.0);
  mediump float tmpvar_32;
  tmpvar_32 = tmpvar_31.x;
  atomosphere_26 = mix (mix (_ES_TopBackColor, _ES_TopFrontColor, vec4(tmpvar_29)).xyz, mix (_ES_BottomBackColor, _ES_BottomFrontColor, vec4(tmpvar_29)).xyz, vec3(tmpvar_32));
  mediump vec4 tmpvar_33;
  tmpvar_33.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_33.x = (abs(tmpvar_18.w) / max (_ES_HorizonHaloHeight, 0.0001));
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DLod (_SkyGradientTex, tmpvar_33.xy, 0.0);
  mediump float tmpvar_35;
  tmpvar_35 = tmpvar_34.y;
  mediump float tmpvar_36;
  tmpvar_36 = clamp (((
    max (((tmpvar_27 * 0.5) + 0.5), 0.0)
   - 0.3) / 0.7), 0.0, 1.0);
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    abs(_ES_SunDirection.y)
   - 0.2) / 0.3), 0.0, 1.0);
  atomosphere_26 = (atomosphere_26 + ((
    (_ES_HorizonHaloColor * _ES_HorizonHaloIntensity)
   * tmpvar_35) * mix (
    (tmpvar_36 * (tmpvar_36 * (3.0 - (2.0 * tmpvar_36))))
  , 1.0, 
    (tmpvar_37 * (tmpvar_37 * (3.0 - (2.0 * tmpvar_37))))
  )));
  highp vec3 viewDir_38;
  viewDir_38 = tmpvar_18.xyz;
  highp float haloInfluence_39;
  mediump float vertical_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((
    dot (_ES_SunDirection, viewDir_38)
   * 0.5) + 0.5), 0.0, 1.0);
  highp float tmpvar_42;
  tmpvar_42 = dot (viewDir_38, _ES_SkyWorldUpDir);
  vertical_40 = tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = abs(vertical_40);
  mediump float y_44;
  y_44 = (_ES_SunHaloSize * tmpvar_43);
  mediump float y_45;
  y_45 = ((_ES_SunHaloSize * 0.1) * tmpvar_43);
  haloInfluence_39 = (clamp (pow (tmpvar_41, y_44), 0.0, 1.0) + (clamp (
    pow (tmpvar_41, y_45)
  , 0.0, 1.0) * 0.12));
  mediump float y_46;
  y_46 = ((_ES_SunHaloSize * 0.01) * tmpvar_43);
  haloInfluence_39 = (haloInfluence_39 + (clamp (
    pow (tmpvar_41, y_46)
  , 0.0, 1.0) * 0.03));
  highp float tmpvar_47;
  tmpvar_47 = clamp (((
    max (((dot (_ES_SunDirection, viewDir_38) * 0.5) + 0.5), 0.0)
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 tmpvar_48;
  tmpvar_48 = (((haloInfluence_39 * _ES_SunHaloIntensity) * _ES_SunHaloColor) * (tmpvar_47 * (tmpvar_47 * 
    (3.0 - (2.0 * tmpvar_47))
  )));
  tmpvar_5 = (atomosphere_26 + tmpvar_48);
  mediump float tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_49 = (tmpvar_50 * (tmpvar_50 * (3.0 - 
    (2.0 * tmpvar_50)
  )));
  highp vec3 viewDir_51;
  viewDir_51 = tmpvar_18.xyz;
  mediump float moonLunarCancel_52;
  mediump float tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (_ES_MoonDirection, viewDir_51), 0.0, 1.0);
  tmpvar_53 = tmpvar_54;
  highp float tmpvar_55;
  mediump float tmpvar_56;
  tmpvar_56 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_55 = (1.0 - (tmpvar_56 * 2.0));
  moonLunarCancel_52 = tmpvar_55;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((
    ((tmpvar_53 * tmpvar_53) * ((tmpvar_53 * tmpvar_53) * tmpvar_53))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_58;
  viewDir_58 = tmpvar_18.xyz;
  mediump float vertical_59;
  mediump float tmpvar_60;
  highp float tmpvar_61;
  tmpvar_61 = clamp (((
    dot (_ES_SunDirection, viewDir_58)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_60 = tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = dot (viewDir_58, _ES_SkyWorldUpDir);
  vertical_59 = tmpvar_62;
  mediump float tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = (1.0 - _ES_SunRimLightRadius);
  tmpvar_63 = clamp (((tmpvar_20 - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (((tmpvar_63 * 
    (tmpvar_63 * (3.0 - (2.0 * tmpvar_63)))
  ) * _ES_SunBrightness) * 0.125);
  mediump float tmpvar_66;
  tmpvar_66 = clamp (((
    ((dot (viewDir_14, _ES_MoonDirection) * 0.5) + 0.5)
   - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_67;
  tmpvar_67 = (((tmpvar_66 * 
    (tmpvar_66 * (3.0 - (2.0 * tmpvar_66)))
  ) * _ES_MoonBrightness) * 0.1);
  mediump float tmpvar_68;
  tmpvar_68 = max (((tmpvar_19 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_69;
  tmpvar_69 = ((tmpvar_68 * tmpvar_68) * tmpvar_68);
  gl_Position = clipPos_6;
  xlv_TEXCOORD0 = o_9;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = (((
    ((((tmpvar_57 * 
      (tmpvar_57 * (3.0 - (2.0 * tmpvar_57)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_52) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_60, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_59))
    ) * vertical_59), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_49);
  xlv_TEXCOORD6 = (((_ES_SunHaloColor * 
    (tmpvar_65 * tmpvar_65)
  ) + (_ES_MoonColor * 
    (tmpvar_67 * tmpvar_67)
  )) * tmpvar_49);
  xlv_TEXCOORD7 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_69));
  xlv_TEXCOORD8 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_69));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_CloudCoverage;
uniform sampler2D _CloudParticleAtlas;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 cloudCol_1;
  mediump vec4 texCol_2;
  highp vec3 curlNoise_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_CloudCurlTex, xlv_TEXCOORD1.zw).xyz;
  curlNoise_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD1.xy + ((
    (curlNoise_3.xy - 0.5)
   * curlNoise_3.z) * _CloudCurlAmplitude));
  tmpvar_5 = texture2D (_CloudParticleAtlas, P_6);
  texCol_2 = tmpvar_5;
  mediump float tmpvar_7;
  tmpvar_7 = max ((xlv_TEXCOORD3.w - xlv_TEXCOORD3.y), 0.0);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.y), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD2.w - -0.1) / 0.2), 0.0, 1.0);
  cloudCol_1.w = ((texCol_2.w * (tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  )) * (tmpvar_9 * (tmpvar_9 * 
    (3.0 - (2.0 * tmpvar_9))
  )));
  mediump float x_10;
  x_10 = (cloudCol_1.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.z), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  cloudCol_1.xyz = ((mix (xlv_TEXCOORD8, xlv_TEXCOORD7, texCol_2.xxx) + (xlv_TEXCOORD6 * 
    mix (texCol_2.y, ((1.0 - (tmpvar_11 * 
      (tmpvar_11 * (3.0 - (2.0 * tmpvar_11)))
    )) * 4.0), xlv_TEXCOORD3.w)
  )) + ((0.4 * xlv_TEXCOORD7) * _ES_CloudCoverage));
  cloudCol_1.xyz = (cloudCol_1.xyz + (xlv_TEXCOORD5 * texCol_2.x));
  cloudCol_1.xyz = (cloudCol_1.xyz * (xlv_TEXCOORD3.x + 1.0));
  mediump float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD2.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((_ES_CloudCoverage - 0.4) / 0.3), 0.0, 1.0);
  cloudCol_1.xyz = mix (xlv_TEXCOORD4, cloudCol_1.xyz, vec3(mix (clamp (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
  , 0.0, 1.0), 1.0, (tmpvar_13 * 
    (tmpvar_13 * (3.0 - (2.0 * tmpvar_13)))
  ))));
  cloudCol_1.w = clamp (cloudCol_1.w, 0.0, 1.0);
  gl_FragData[0] = cloudCol_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "FIXED_EDGE_SMOOTHNESS" "FIXED_RIMLIGHT_WIDTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec4 _ES_TopFrontColor;
uniform mediump vec4 _ES_TopBackColor;
uniform mediump vec4 _ES_BottomFrontColor;
uniform mediump vec4 _ES_BottomBackColor;
uniform mediump float _ES_SkyFrontAndBackBlendFactor;
uniform mediump float _ES_BottomColorHeight;
uniform mediump vec3 _ES_HorizonHaloColor;
uniform mediump float _ES_HorizonHaloIntensity;
uniform mediump float _ES_HorizonHaloHeight;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump float _ES_SunHaloSize;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudAgePercent;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform sampler2D _SkyGradientTex;
uniform highp vec2 _AtlasTiles;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
uniform mediump float _FixedEdgeSmoothness;
uniform mediump float _FixedRimLightWidth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float agePercent_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 clipPos_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  clipPos_6.xyw = tmpvar_7.xyw;
  clipPos_6.z = tmpvar_7.w;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7.xyww * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = clipPos_6.zw;
  highp int tmpvar_12;
  tmpvar_12 = int(floor((
    (_glesColor.y * ((_AtlasTiles.x * _AtlasTiles.y) - 1.0))
   + 0.5)));
  highp vec2 tmpvar_13;
  tmpvar_13.x = (float(mod (float(tmpvar_12), _AtlasTiles.x)));
  tmpvar_13.y = floor((float(tmpvar_12) / _AtlasTiles.x));
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy + tmpvar_13) / _AtlasTiles);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _CloudCurlTiling) + ((_ES_CloudElapsedTime * vec2(1.2, 0.8)) * _CloudCurlSpeed));
  mediump vec3 viewDir_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(((unity_ObjectToWorld * tmpvar_15).xyz - _ES_SkyCenterWorldPos));
  viewDir_14 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (_ES_SkyWorldUpDir, viewDir_14);
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = viewDir_14;
  tmpvar_18.w = ((sign(tmpvar_17) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_17))) * (1.570796 + (abs(tmpvar_17) * (-0.2146018 + 
      (abs(tmpvar_17) * (0.08656672 + (abs(tmpvar_17) * -0.03102955)))
    ))))
  )) * 0.6366198);
  mediump float tmpvar_19;
  tmpvar_19 = dot (viewDir_14, _ES_SunDirection);
  mediump float tmpvar_20;
  tmpvar_20 = ((tmpvar_19 * 0.5) + 0.5);
  tmpvar_4.x = (tmpvar_20 * _ES_CloudSunBrightenIntensity);
  tmpvar_4.y = _FixedEdgeSmoothness;
  tmpvar_4.z = _FixedRimLightWidth;
  highp float tmpvar_21;
  tmpvar_21 = (_glesMultiTexCoord1.y / max (_glesMultiTexCoord1.x, 1e-05));
  agePercent_2 = tmpvar_21;
  agePercent_2 = (agePercent_2 * _ES_CloudAgePercent);
  highp float tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = clamp ((agePercent_2 / _glesMultiTexCoord1.z), 0.0, 1.0);
  tmpvar_22 = (tmpvar_23 * (tmpvar_23 * (3.0 - 
    (2.0 * tmpvar_23)
  )));
  highp float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((agePercent_2 - _glesMultiTexCoord1.w) / (1.0 - _glesMultiTexCoord1.w)), 0.0, 1.0);
  tmpvar_24 = (tmpvar_25 * (tmpvar_25 * (3.0 - 
    (2.0 * tmpvar_25)
  )));
  tmpvar_4.w = (1.0 - (tmpvar_22 * (1.0 - tmpvar_24)));
  mediump vec3 atomosphere_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (_ES_SunDirection, viewDir_14);
  mediump float tmpvar_28;
  tmpvar_28 = max (((tmpvar_27 * _ES_SkyFrontAndBackBlendFactor) + (1.0 - _ES_SkyFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_29;
  tmpvar_29 = ((tmpvar_28 * tmpvar_28) * tmpvar_28);
  mediump vec4 tmpvar_30;
  tmpvar_30.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_30.x = (abs(tmpvar_18.w) / max (_ES_BottomColorHeight, 0.0001));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DLod (_SkyGradientTex, tmpvar_30.xy, 0.0);
  mediump float tmpvar_32;
  tmpvar_32 = tmpvar_31.x;
  atomosphere_26 = mix (mix (_ES_TopBackColor, _ES_TopFrontColor, vec4(tmpvar_29)).xyz, mix (_ES_BottomBackColor, _ES_BottomFrontColor, vec4(tmpvar_29)).xyz, vec3(tmpvar_32));
  mediump vec4 tmpvar_33;
  tmpvar_33.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_33.x = (abs(tmpvar_18.w) / max (_ES_HorizonHaloHeight, 0.0001));
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DLod (_SkyGradientTex, tmpvar_33.xy, 0.0);
  mediump float tmpvar_35;
  tmpvar_35 = tmpvar_34.y;
  mediump float tmpvar_36;
  tmpvar_36 = clamp (((
    max (((tmpvar_27 * 0.5) + 0.5), 0.0)
   - 0.3) / 0.7), 0.0, 1.0);
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    abs(_ES_SunDirection.y)
   - 0.2) / 0.3), 0.0, 1.0);
  atomosphere_26 = (atomosphere_26 + ((
    (_ES_HorizonHaloColor * _ES_HorizonHaloIntensity)
   * tmpvar_35) * mix (
    (tmpvar_36 * (tmpvar_36 * (3.0 - (2.0 * tmpvar_36))))
  , 1.0, 
    (tmpvar_37 * (tmpvar_37 * (3.0 - (2.0 * tmpvar_37))))
  )));
  highp vec3 viewDir_38;
  viewDir_38 = tmpvar_18.xyz;
  highp float haloInfluence_39;
  mediump float vertical_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((
    dot (_ES_SunDirection, viewDir_38)
   * 0.5) + 0.5), 0.0, 1.0);
  highp float tmpvar_42;
  tmpvar_42 = dot (viewDir_38, _ES_SkyWorldUpDir);
  vertical_40 = tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = abs(vertical_40);
  mediump float y_44;
  y_44 = (_ES_SunHaloSize * tmpvar_43);
  mediump float y_45;
  y_45 = ((_ES_SunHaloSize * 0.1) * tmpvar_43);
  haloInfluence_39 = (clamp (pow (tmpvar_41, y_44), 0.0, 1.0) + (clamp (
    pow (tmpvar_41, y_45)
  , 0.0, 1.0) * 0.12));
  mediump float y_46;
  y_46 = ((_ES_SunHaloSize * 0.01) * tmpvar_43);
  haloInfluence_39 = (haloInfluence_39 + (clamp (
    pow (tmpvar_41, y_46)
  , 0.0, 1.0) * 0.03));
  highp float tmpvar_47;
  tmpvar_47 = clamp (((
    max (((dot (_ES_SunDirection, viewDir_38) * 0.5) + 0.5), 0.0)
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 tmpvar_48;
  tmpvar_48 = (((haloInfluence_39 * _ES_SunHaloIntensity) * _ES_SunHaloColor) * (tmpvar_47 * (tmpvar_47 * 
    (3.0 - (2.0 * tmpvar_47))
  )));
  tmpvar_5 = (atomosphere_26 + tmpvar_48);
  mediump float tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_49 = (tmpvar_50 * (tmpvar_50 * (3.0 - 
    (2.0 * tmpvar_50)
  )));
  highp vec3 viewDir_51;
  viewDir_51 = tmpvar_18.xyz;
  mediump float moonLunarCancel_52;
  mediump float tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (_ES_MoonDirection, viewDir_51), 0.0, 1.0);
  tmpvar_53 = tmpvar_54;
  highp float tmpvar_55;
  mediump float tmpvar_56;
  tmpvar_56 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_55 = (1.0 - (tmpvar_56 * 2.0));
  moonLunarCancel_52 = tmpvar_55;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((
    ((tmpvar_53 * tmpvar_53) * ((tmpvar_53 * tmpvar_53) * tmpvar_53))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_58;
  viewDir_58 = tmpvar_18.xyz;
  mediump float vertical_59;
  mediump float tmpvar_60;
  highp float tmpvar_61;
  tmpvar_61 = clamp (((
    dot (_ES_SunDirection, viewDir_58)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_60 = tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = dot (viewDir_58, _ES_SkyWorldUpDir);
  vertical_59 = tmpvar_62;
  mediump float tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = (1.0 - _ES_SunRimLightRadius);
  tmpvar_63 = clamp (((tmpvar_20 - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (((tmpvar_63 * 
    (tmpvar_63 * (3.0 - (2.0 * tmpvar_63)))
  ) * _ES_SunBrightness) * 0.125);
  mediump float tmpvar_66;
  tmpvar_66 = clamp (((
    ((dot (viewDir_14, _ES_MoonDirection) * 0.5) + 0.5)
   - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_67;
  tmpvar_67 = (((tmpvar_66 * 
    (tmpvar_66 * (3.0 - (2.0 * tmpvar_66)))
  ) * _ES_MoonBrightness) * 0.1);
  mediump float tmpvar_68;
  tmpvar_68 = max (((tmpvar_19 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_69;
  tmpvar_69 = ((tmpvar_68 * tmpvar_68) * tmpvar_68);
  gl_Position = clipPos_6;
  xlv_TEXCOORD0 = o_9;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = (((
    ((((tmpvar_57 * 
      (tmpvar_57 * (3.0 - (2.0 * tmpvar_57)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_52) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_60, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_59))
    ) * vertical_59), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_49);
  xlv_TEXCOORD6 = (((_ES_SunHaloColor * 
    (tmpvar_65 * tmpvar_65)
  ) + (_ES_MoonColor * 
    (tmpvar_67 * tmpvar_67)
  )) * tmpvar_49);
  xlv_TEXCOORD7 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_69));
  xlv_TEXCOORD8 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_69));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_CloudCoverage;
uniform sampler2D _CloudParticleAtlas;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 cloudCol_1;
  mediump vec4 texCol_2;
  highp vec3 curlNoise_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_CloudCurlTex, xlv_TEXCOORD1.zw).xyz;
  curlNoise_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD1.xy + ((
    (curlNoise_3.xy - 0.5)
   * curlNoise_3.z) * _CloudCurlAmplitude));
  tmpvar_5 = texture2D (_CloudParticleAtlas, P_6);
  texCol_2 = tmpvar_5;
  mediump float tmpvar_7;
  tmpvar_7 = max ((xlv_TEXCOORD3.w - xlv_TEXCOORD3.y), 0.0);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.y), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD2.w - -0.1) / 0.2), 0.0, 1.0);
  cloudCol_1.w = ((texCol_2.w * (tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  )) * (tmpvar_9 * (tmpvar_9 * 
    (3.0 - (2.0 * tmpvar_9))
  )));
  mediump float x_10;
  x_10 = (cloudCol_1.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.z), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  cloudCol_1.xyz = ((mix (xlv_TEXCOORD8, xlv_TEXCOORD7, texCol_2.xxx) + (xlv_TEXCOORD6 * 
    mix (texCol_2.y, ((1.0 - (tmpvar_11 * 
      (tmpvar_11 * (3.0 - (2.0 * tmpvar_11)))
    )) * 4.0), xlv_TEXCOORD3.w)
  )) + ((0.4 * xlv_TEXCOORD7) * _ES_CloudCoverage));
  cloudCol_1.xyz = (cloudCol_1.xyz + (xlv_TEXCOORD5 * texCol_2.x));
  cloudCol_1.xyz = (cloudCol_1.xyz * (xlv_TEXCOORD3.x + 1.0));
  mediump float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD2.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((_ES_CloudCoverage - 0.4) / 0.3), 0.0, 1.0);
  cloudCol_1.xyz = mix (xlv_TEXCOORD4, cloudCol_1.xyz, vec3(mix (clamp (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
  , 0.0, 1.0), 1.0, (tmpvar_13 * 
    (tmpvar_13 * (3.0 - (2.0 * tmpvar_13)))
  ))));
  cloudCol_1.w = clamp (cloudCol_1.w, 0.0, 1.0);
  gl_FragData[0] = cloudCol_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "FIXED_EDGE_SMOOTHNESS" "FIXED_RIMLIGHT_WIDTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec4 _ES_TopFrontColor;
uniform mediump vec4 _ES_TopBackColor;
uniform mediump vec4 _ES_BottomFrontColor;
uniform mediump vec4 _ES_BottomBackColor;
uniform mediump float _ES_SkyFrontAndBackBlendFactor;
uniform mediump float _ES_BottomColorHeight;
uniform mediump vec3 _ES_HorizonHaloColor;
uniform mediump float _ES_HorizonHaloIntensity;
uniform mediump float _ES_HorizonHaloHeight;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump float _ES_SunHaloSize;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudAgePercent;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform sampler2D _SkyGradientTex;
uniform highp vec2 _AtlasTiles;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
uniform mediump float _FixedEdgeSmoothness;
uniform mediump float _FixedRimLightWidth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float agePercent_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 clipPos_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  clipPos_6.xyw = tmpvar_7.xyw;
  clipPos_6.z = tmpvar_7.w;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7.xyww * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = clipPos_6.zw;
  highp int tmpvar_12;
  tmpvar_12 = int(floor((
    (_glesColor.y * ((_AtlasTiles.x * _AtlasTiles.y) - 1.0))
   + 0.5)));
  highp vec2 tmpvar_13;
  tmpvar_13.x = (float(mod (float(tmpvar_12), _AtlasTiles.x)));
  tmpvar_13.y = floor((float(tmpvar_12) / _AtlasTiles.x));
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy + tmpvar_13) / _AtlasTiles);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _CloudCurlTiling) + ((_ES_CloudElapsedTime * vec2(1.2, 0.8)) * _CloudCurlSpeed));
  mediump vec3 viewDir_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(((unity_ObjectToWorld * tmpvar_15).xyz - _ES_SkyCenterWorldPos));
  viewDir_14 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (_ES_SkyWorldUpDir, viewDir_14);
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = viewDir_14;
  tmpvar_18.w = ((sign(tmpvar_17) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_17))) * (1.570796 + (abs(tmpvar_17) * (-0.2146018 + 
      (abs(tmpvar_17) * (0.08656672 + (abs(tmpvar_17) * -0.03102955)))
    ))))
  )) * 0.6366198);
  mediump float tmpvar_19;
  tmpvar_19 = dot (viewDir_14, _ES_SunDirection);
  mediump float tmpvar_20;
  tmpvar_20 = ((tmpvar_19 * 0.5) + 0.5);
  tmpvar_4.x = (tmpvar_20 * _ES_CloudSunBrightenIntensity);
  tmpvar_4.y = _FixedEdgeSmoothness;
  tmpvar_4.z = _FixedRimLightWidth;
  highp float tmpvar_21;
  tmpvar_21 = (_glesMultiTexCoord1.y / max (_glesMultiTexCoord1.x, 1e-05));
  agePercent_2 = tmpvar_21;
  agePercent_2 = (agePercent_2 * _ES_CloudAgePercent);
  highp float tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = clamp ((agePercent_2 / _glesMultiTexCoord1.z), 0.0, 1.0);
  tmpvar_22 = (tmpvar_23 * (tmpvar_23 * (3.0 - 
    (2.0 * tmpvar_23)
  )));
  highp float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((agePercent_2 - _glesMultiTexCoord1.w) / (1.0 - _glesMultiTexCoord1.w)), 0.0, 1.0);
  tmpvar_24 = (tmpvar_25 * (tmpvar_25 * (3.0 - 
    (2.0 * tmpvar_25)
  )));
  tmpvar_4.w = (1.0 - (tmpvar_22 * (1.0 - tmpvar_24)));
  mediump vec3 atomosphere_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (_ES_SunDirection, viewDir_14);
  mediump float tmpvar_28;
  tmpvar_28 = max (((tmpvar_27 * _ES_SkyFrontAndBackBlendFactor) + (1.0 - _ES_SkyFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_29;
  tmpvar_29 = ((tmpvar_28 * tmpvar_28) * tmpvar_28);
  mediump vec4 tmpvar_30;
  tmpvar_30.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_30.x = (abs(tmpvar_18.w) / max (_ES_BottomColorHeight, 0.0001));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DLod (_SkyGradientTex, tmpvar_30.xy, 0.0);
  mediump float tmpvar_32;
  tmpvar_32 = tmpvar_31.x;
  atomosphere_26 = mix (mix (_ES_TopBackColor, _ES_TopFrontColor, vec4(tmpvar_29)).xyz, mix (_ES_BottomBackColor, _ES_BottomFrontColor, vec4(tmpvar_29)).xyz, vec3(tmpvar_32));
  mediump vec4 tmpvar_33;
  tmpvar_33.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_33.x = (abs(tmpvar_18.w) / max (_ES_HorizonHaloHeight, 0.0001));
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DLod (_SkyGradientTex, tmpvar_33.xy, 0.0);
  mediump float tmpvar_35;
  tmpvar_35 = tmpvar_34.y;
  mediump float tmpvar_36;
  tmpvar_36 = clamp (((
    max (((tmpvar_27 * 0.5) + 0.5), 0.0)
   - 0.3) / 0.7), 0.0, 1.0);
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    abs(_ES_SunDirection.y)
   - 0.2) / 0.3), 0.0, 1.0);
  atomosphere_26 = (atomosphere_26 + ((
    (_ES_HorizonHaloColor * _ES_HorizonHaloIntensity)
   * tmpvar_35) * mix (
    (tmpvar_36 * (tmpvar_36 * (3.0 - (2.0 * tmpvar_36))))
  , 1.0, 
    (tmpvar_37 * (tmpvar_37 * (3.0 - (2.0 * tmpvar_37))))
  )));
  highp vec3 viewDir_38;
  viewDir_38 = tmpvar_18.xyz;
  highp float haloInfluence_39;
  mediump float vertical_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((
    dot (_ES_SunDirection, viewDir_38)
   * 0.5) + 0.5), 0.0, 1.0);
  highp float tmpvar_42;
  tmpvar_42 = dot (viewDir_38, _ES_SkyWorldUpDir);
  vertical_40 = tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = abs(vertical_40);
  mediump float y_44;
  y_44 = (_ES_SunHaloSize * tmpvar_43);
  mediump float y_45;
  y_45 = ((_ES_SunHaloSize * 0.1) * tmpvar_43);
  haloInfluence_39 = (clamp (pow (tmpvar_41, y_44), 0.0, 1.0) + (clamp (
    pow (tmpvar_41, y_45)
  , 0.0, 1.0) * 0.12));
  mediump float y_46;
  y_46 = ((_ES_SunHaloSize * 0.01) * tmpvar_43);
  haloInfluence_39 = (haloInfluence_39 + (clamp (
    pow (tmpvar_41, y_46)
  , 0.0, 1.0) * 0.03));
  highp float tmpvar_47;
  tmpvar_47 = clamp (((
    max (((dot (_ES_SunDirection, viewDir_38) * 0.5) + 0.5), 0.0)
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 tmpvar_48;
  tmpvar_48 = (((haloInfluence_39 * _ES_SunHaloIntensity) * _ES_SunHaloColor) * (tmpvar_47 * (tmpvar_47 * 
    (3.0 - (2.0 * tmpvar_47))
  )));
  tmpvar_5 = (atomosphere_26 + tmpvar_48);
  mediump float tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_49 = (tmpvar_50 * (tmpvar_50 * (3.0 - 
    (2.0 * tmpvar_50)
  )));
  highp vec3 viewDir_51;
  viewDir_51 = tmpvar_18.xyz;
  mediump float moonLunarCancel_52;
  mediump float tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (_ES_MoonDirection, viewDir_51), 0.0, 1.0);
  tmpvar_53 = tmpvar_54;
  highp float tmpvar_55;
  mediump float tmpvar_56;
  tmpvar_56 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_55 = (1.0 - (tmpvar_56 * 2.0));
  moonLunarCancel_52 = tmpvar_55;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((
    ((tmpvar_53 * tmpvar_53) * ((tmpvar_53 * tmpvar_53) * tmpvar_53))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_58;
  viewDir_58 = tmpvar_18.xyz;
  mediump float vertical_59;
  mediump float tmpvar_60;
  highp float tmpvar_61;
  tmpvar_61 = clamp (((
    dot (_ES_SunDirection, viewDir_58)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_60 = tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = dot (viewDir_58, _ES_SkyWorldUpDir);
  vertical_59 = tmpvar_62;
  mediump float tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = (1.0 - _ES_SunRimLightRadius);
  tmpvar_63 = clamp (((tmpvar_20 - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (((tmpvar_63 * 
    (tmpvar_63 * (3.0 - (2.0 * tmpvar_63)))
  ) * _ES_SunBrightness) * 0.125);
  mediump float tmpvar_66;
  tmpvar_66 = clamp (((
    ((dot (viewDir_14, _ES_MoonDirection) * 0.5) + 0.5)
   - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_67;
  tmpvar_67 = (((tmpvar_66 * 
    (tmpvar_66 * (3.0 - (2.0 * tmpvar_66)))
  ) * _ES_MoonBrightness) * 0.1);
  mediump float tmpvar_68;
  tmpvar_68 = max (((tmpvar_19 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_69;
  tmpvar_69 = ((tmpvar_68 * tmpvar_68) * tmpvar_68);
  gl_Position = clipPos_6;
  xlv_TEXCOORD0 = o_9;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = (((
    ((((tmpvar_57 * 
      (tmpvar_57 * (3.0 - (2.0 * tmpvar_57)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_52) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_60, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_59))
    ) * vertical_59), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_49);
  xlv_TEXCOORD6 = (((_ES_SunHaloColor * 
    (tmpvar_65 * tmpvar_65)
  ) + (_ES_MoonColor * 
    (tmpvar_67 * tmpvar_67)
  )) * tmpvar_49);
  xlv_TEXCOORD7 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_69));
  xlv_TEXCOORD8 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_69));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_CloudCoverage;
uniform sampler2D _CloudParticleAtlas;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 cloudCol_1;
  mediump vec4 texCol_2;
  highp vec3 curlNoise_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_CloudCurlTex, xlv_TEXCOORD1.zw).xyz;
  curlNoise_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD1.xy + ((
    (curlNoise_3.xy - 0.5)
   * curlNoise_3.z) * _CloudCurlAmplitude));
  tmpvar_5 = texture2D (_CloudParticleAtlas, P_6);
  texCol_2 = tmpvar_5;
  mediump float tmpvar_7;
  tmpvar_7 = max ((xlv_TEXCOORD3.w - xlv_TEXCOORD3.y), 0.0);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.y), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD2.w - -0.1) / 0.2), 0.0, 1.0);
  cloudCol_1.w = ((texCol_2.w * (tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  )) * (tmpvar_9 * (tmpvar_9 * 
    (3.0 - (2.0 * tmpvar_9))
  )));
  mediump float x_10;
  x_10 = (cloudCol_1.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.z), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  cloudCol_1.xyz = ((mix (xlv_TEXCOORD8, xlv_TEXCOORD7, texCol_2.xxx) + (xlv_TEXCOORD6 * 
    mix (texCol_2.y, ((1.0 - (tmpvar_11 * 
      (tmpvar_11 * (3.0 - (2.0 * tmpvar_11)))
    )) * 4.0), xlv_TEXCOORD3.w)
  )) + ((0.4 * xlv_TEXCOORD7) * _ES_CloudCoverage));
  cloudCol_1.xyz = (cloudCol_1.xyz + (xlv_TEXCOORD5 * texCol_2.x));
  cloudCol_1.xyz = (cloudCol_1.xyz * (xlv_TEXCOORD3.x + 1.0));
  mediump float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD2.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((_ES_CloudCoverage - 0.4) / 0.3), 0.0, 1.0);
  cloudCol_1.xyz = mix (xlv_TEXCOORD4, cloudCol_1.xyz, vec3(mix (clamp (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
  , 0.0, 1.0), 1.0, (tmpvar_13 * 
    (tmpvar_13 * (3.0 - (2.0 * tmpvar_13)))
  ))));
  cloudCol_1.w = clamp (cloudCol_1.w, 0.0, 1.0);
  gl_FragData[0] = cloudCol_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "FIXED_EDGE_SMOOTHNESS" "FIXED_RIMLIGHT_WIDTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec4 _ES_TopFrontColor;
uniform mediump vec4 _ES_TopBackColor;
uniform mediump vec4 _ES_BottomFrontColor;
uniform mediump vec4 _ES_BottomBackColor;
uniform mediump float _ES_SkyFrontAndBackBlendFactor;
uniform mediump float _ES_BottomColorHeight;
uniform mediump vec3 _ES_HorizonHaloColor;
uniform mediump float _ES_HorizonHaloIntensity;
uniform mediump float _ES_HorizonHaloHeight;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump float _ES_SunHaloSize;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudAgePercent;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform sampler2D _SkyGradientTex;
uniform highp vec2 _AtlasTiles;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
uniform mediump float _FixedEdgeSmoothness;
uniform mediump float _FixedRimLightWidth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float agePercent_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 clipPos_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  clipPos_6.xyw = tmpvar_7.xyw;
  clipPos_6.z = tmpvar_7.w;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7.xyww * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = clipPos_6.zw;
  highp int tmpvar_12;
  tmpvar_12 = int(floor((
    (_glesColor.y * ((_AtlasTiles.x * _AtlasTiles.y) - 1.0))
   + 0.5)));
  highp vec2 tmpvar_13;
  tmpvar_13.x = (float(mod (float(tmpvar_12), _AtlasTiles.x)));
  tmpvar_13.y = floor((float(tmpvar_12) / _AtlasTiles.x));
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy + tmpvar_13) / _AtlasTiles);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _CloudCurlTiling) + ((_ES_CloudElapsedTime * vec2(1.2, 0.8)) * _CloudCurlSpeed));
  mediump vec3 viewDir_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(((unity_ObjectToWorld * tmpvar_15).xyz - _ES_SkyCenterWorldPos));
  viewDir_14 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (_ES_SkyWorldUpDir, viewDir_14);
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = viewDir_14;
  tmpvar_18.w = ((sign(tmpvar_17) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_17))) * (1.570796 + (abs(tmpvar_17) * (-0.2146018 + 
      (abs(tmpvar_17) * (0.08656672 + (abs(tmpvar_17) * -0.03102955)))
    ))))
  )) * 0.6366198);
  mediump float tmpvar_19;
  tmpvar_19 = dot (viewDir_14, _ES_SunDirection);
  mediump float tmpvar_20;
  tmpvar_20 = ((tmpvar_19 * 0.5) + 0.5);
  tmpvar_4.x = (tmpvar_20 * _ES_CloudSunBrightenIntensity);
  tmpvar_4.y = _FixedEdgeSmoothness;
  tmpvar_4.z = _FixedRimLightWidth;
  highp float tmpvar_21;
  tmpvar_21 = (_glesMultiTexCoord1.y / max (_glesMultiTexCoord1.x, 1e-05));
  agePercent_2 = tmpvar_21;
  agePercent_2 = (agePercent_2 * _ES_CloudAgePercent);
  highp float tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = clamp ((agePercent_2 / _glesMultiTexCoord1.z), 0.0, 1.0);
  tmpvar_22 = (tmpvar_23 * (tmpvar_23 * (3.0 - 
    (2.0 * tmpvar_23)
  )));
  highp float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((agePercent_2 - _glesMultiTexCoord1.w) / (1.0 - _glesMultiTexCoord1.w)), 0.0, 1.0);
  tmpvar_24 = (tmpvar_25 * (tmpvar_25 * (3.0 - 
    (2.0 * tmpvar_25)
  )));
  tmpvar_4.w = (1.0 - (tmpvar_22 * (1.0 - tmpvar_24)));
  mediump vec3 atomosphere_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (_ES_SunDirection, viewDir_14);
  mediump float tmpvar_28;
  tmpvar_28 = max (((tmpvar_27 * _ES_SkyFrontAndBackBlendFactor) + (1.0 - _ES_SkyFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_29;
  tmpvar_29 = ((tmpvar_28 * tmpvar_28) * tmpvar_28);
  mediump vec4 tmpvar_30;
  tmpvar_30.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_30.x = (abs(tmpvar_18.w) / max (_ES_BottomColorHeight, 0.0001));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DLod (_SkyGradientTex, tmpvar_30.xy, 0.0);
  mediump float tmpvar_32;
  tmpvar_32 = tmpvar_31.x;
  atomosphere_26 = mix (mix (_ES_TopBackColor, _ES_TopFrontColor, vec4(tmpvar_29)).xyz, mix (_ES_BottomBackColor, _ES_BottomFrontColor, vec4(tmpvar_29)).xyz, vec3(tmpvar_32));
  mediump vec4 tmpvar_33;
  tmpvar_33.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_33.x = (abs(tmpvar_18.w) / max (_ES_HorizonHaloHeight, 0.0001));
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DLod (_SkyGradientTex, tmpvar_33.xy, 0.0);
  mediump float tmpvar_35;
  tmpvar_35 = tmpvar_34.y;
  mediump float tmpvar_36;
  tmpvar_36 = clamp (((
    max (((tmpvar_27 * 0.5) + 0.5), 0.0)
   - 0.3) / 0.7), 0.0, 1.0);
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    abs(_ES_SunDirection.y)
   - 0.2) / 0.3), 0.0, 1.0);
  atomosphere_26 = (atomosphere_26 + ((
    (_ES_HorizonHaloColor * _ES_HorizonHaloIntensity)
   * tmpvar_35) * mix (
    (tmpvar_36 * (tmpvar_36 * (3.0 - (2.0 * tmpvar_36))))
  , 1.0, 
    (tmpvar_37 * (tmpvar_37 * (3.0 - (2.0 * tmpvar_37))))
  )));
  highp vec3 viewDir_38;
  viewDir_38 = tmpvar_18.xyz;
  highp float haloInfluence_39;
  mediump float vertical_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((
    dot (_ES_SunDirection, viewDir_38)
   * 0.5) + 0.5), 0.0, 1.0);
  highp float tmpvar_42;
  tmpvar_42 = dot (viewDir_38, _ES_SkyWorldUpDir);
  vertical_40 = tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = abs(vertical_40);
  mediump float y_44;
  y_44 = (_ES_SunHaloSize * tmpvar_43);
  mediump float y_45;
  y_45 = ((_ES_SunHaloSize * 0.1) * tmpvar_43);
  haloInfluence_39 = (clamp (pow (tmpvar_41, y_44), 0.0, 1.0) + (clamp (
    pow (tmpvar_41, y_45)
  , 0.0, 1.0) * 0.12));
  mediump float y_46;
  y_46 = ((_ES_SunHaloSize * 0.01) * tmpvar_43);
  haloInfluence_39 = (haloInfluence_39 + (clamp (
    pow (tmpvar_41, y_46)
  , 0.0, 1.0) * 0.03));
  highp float tmpvar_47;
  tmpvar_47 = clamp (((
    max (((dot (_ES_SunDirection, viewDir_38) * 0.5) + 0.5), 0.0)
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 tmpvar_48;
  tmpvar_48 = (((haloInfluence_39 * _ES_SunHaloIntensity) * _ES_SunHaloColor) * (tmpvar_47 * (tmpvar_47 * 
    (3.0 - (2.0 * tmpvar_47))
  )));
  tmpvar_5 = (atomosphere_26 + tmpvar_48);
  mediump float tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_49 = (tmpvar_50 * (tmpvar_50 * (3.0 - 
    (2.0 * tmpvar_50)
  )));
  highp vec3 viewDir_51;
  viewDir_51 = tmpvar_18.xyz;
  mediump float moonLunarCancel_52;
  mediump float tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (_ES_MoonDirection, viewDir_51), 0.0, 1.0);
  tmpvar_53 = tmpvar_54;
  highp float tmpvar_55;
  mediump float tmpvar_56;
  tmpvar_56 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_55 = (1.0 - (tmpvar_56 * 2.0));
  moonLunarCancel_52 = tmpvar_55;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((
    ((tmpvar_53 * tmpvar_53) * ((tmpvar_53 * tmpvar_53) * tmpvar_53))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_58;
  viewDir_58 = tmpvar_18.xyz;
  mediump float vertical_59;
  mediump float tmpvar_60;
  highp float tmpvar_61;
  tmpvar_61 = clamp (((
    dot (_ES_SunDirection, viewDir_58)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_60 = tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = dot (viewDir_58, _ES_SkyWorldUpDir);
  vertical_59 = tmpvar_62;
  mediump float tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = (1.0 - _ES_SunRimLightRadius);
  tmpvar_63 = clamp (((tmpvar_20 - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (((tmpvar_63 * 
    (tmpvar_63 * (3.0 - (2.0 * tmpvar_63)))
  ) * _ES_SunBrightness) * 0.125);
  mediump float tmpvar_66;
  tmpvar_66 = clamp (((
    ((dot (viewDir_14, _ES_MoonDirection) * 0.5) + 0.5)
   - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_67;
  tmpvar_67 = (((tmpvar_66 * 
    (tmpvar_66 * (3.0 - (2.0 * tmpvar_66)))
  ) * _ES_MoonBrightness) * 0.1);
  mediump float tmpvar_68;
  tmpvar_68 = max (((tmpvar_19 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_69;
  tmpvar_69 = ((tmpvar_68 * tmpvar_68) * tmpvar_68);
  gl_Position = clipPos_6;
  xlv_TEXCOORD0 = o_9;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = (((
    ((((tmpvar_57 * 
      (tmpvar_57 * (3.0 - (2.0 * tmpvar_57)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_52) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_60, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_59))
    ) * vertical_59), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_49);
  xlv_TEXCOORD6 = (((_ES_SunHaloColor * 
    (tmpvar_65 * tmpvar_65)
  ) + (_ES_MoonColor * 
    (tmpvar_67 * tmpvar_67)
  )) * tmpvar_49);
  xlv_TEXCOORD7 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_69));
  xlv_TEXCOORD8 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_69));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_CloudCoverage;
uniform sampler2D _CloudParticleAtlas;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 cloudCol_1;
  mediump vec4 texCol_2;
  highp vec3 curlNoise_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_CloudCurlTex, xlv_TEXCOORD1.zw).xyz;
  curlNoise_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD1.xy + ((
    (curlNoise_3.xy - 0.5)
   * curlNoise_3.z) * _CloudCurlAmplitude));
  tmpvar_5 = texture2D (_CloudParticleAtlas, P_6);
  texCol_2 = tmpvar_5;
  mediump float tmpvar_7;
  tmpvar_7 = max ((xlv_TEXCOORD3.w - xlv_TEXCOORD3.y), 0.0);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.y), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD2.w - -0.1) / 0.2), 0.0, 1.0);
  cloudCol_1.w = ((texCol_2.w * (tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  )) * (tmpvar_9 * (tmpvar_9 * 
    (3.0 - (2.0 * tmpvar_9))
  )));
  mediump float x_10;
  x_10 = (cloudCol_1.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.z), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  cloudCol_1.xyz = ((mix (xlv_TEXCOORD8, xlv_TEXCOORD7, texCol_2.xxx) + (xlv_TEXCOORD6 * 
    mix (texCol_2.y, ((1.0 - (tmpvar_11 * 
      (tmpvar_11 * (3.0 - (2.0 * tmpvar_11)))
    )) * 4.0), xlv_TEXCOORD3.w)
  )) + ((0.4 * xlv_TEXCOORD7) * _ES_CloudCoverage));
  cloudCol_1.xyz = (cloudCol_1.xyz + (xlv_TEXCOORD5 * texCol_2.x));
  cloudCol_1.xyz = (cloudCol_1.xyz * (xlv_TEXCOORD3.x + 1.0));
  mediump float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD2.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((_ES_CloudCoverage - 0.4) / 0.3), 0.0, 1.0);
  cloudCol_1.xyz = mix (xlv_TEXCOORD4, cloudCol_1.xyz, vec3(mix (clamp (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
  , 0.0, 1.0), 1.0, (tmpvar_13 * 
    (tmpvar_13 * (3.0 - (2.0 * tmpvar_13)))
  ))));
  cloudCol_1.w = clamp (cloudCol_1.w, 0.0, 1.0);
  gl_FragData[0] = cloudCol_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FIXED_SPRITE_ID" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec4 _ES_TopFrontColor;
uniform mediump vec4 _ES_TopBackColor;
uniform mediump vec4 _ES_BottomFrontColor;
uniform mediump vec4 _ES_BottomBackColor;
uniform mediump float _ES_SkyFrontAndBackBlendFactor;
uniform mediump float _ES_BottomColorHeight;
uniform mediump vec3 _ES_HorizonHaloColor;
uniform mediump float _ES_HorizonHaloIntensity;
uniform mediump float _ES_HorizonHaloHeight;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump float _ES_SunHaloSize;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudAgePercent;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform sampler2D _SkyGradientTex;
uniform highp vec2 _AtlasTiles;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
uniform highp int _FixedSpriteId;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  mediump float agePercent_3;
  highp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec4 clipPos_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  clipPos_7.xyw = tmpvar_8.xyw;
  clipPos_7.z = tmpvar_8.w;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8.xyww * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = clipPos_7.zw;
  highp vec2 tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = float(_FixedSpriteId);
  tmpvar_13.x = (float(mod (tmpvar_14, _AtlasTiles.x)));
  tmpvar_13.y = floor((tmpvar_14 / _AtlasTiles.x));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy + tmpvar_13) / _AtlasTiles);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _CloudCurlTiling) + ((_ES_CloudElapsedTime * vec2(1.2, 0.8)) * _CloudCurlSpeed));
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
  mediump float tmpvar_20;
  tmpvar_20 = dot (viewDir_15, _ES_SunDirection);
  mediump float tmpvar_21;
  tmpvar_21 = ((tmpvar_20 * 0.5) + 0.5);
  tmpvar_5.x = (tmpvar_21 * _ES_CloudSunBrightenIntensity);
  tmpvar_5.y = tmpvar_2.z;
  tmpvar_5.z = tmpvar_2.w;
  highp float tmpvar_22;
  tmpvar_22 = (_glesMultiTexCoord1.y / max (_glesMultiTexCoord1.x, 1e-05));
  agePercent_3 = tmpvar_22;
  agePercent_3 = (agePercent_3 * _ES_CloudAgePercent);
  highp float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = clamp ((agePercent_3 / _glesMultiTexCoord1.z), 0.0, 1.0);
  tmpvar_23 = (tmpvar_24 * (tmpvar_24 * (3.0 - 
    (2.0 * tmpvar_24)
  )));
  highp float tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = clamp (((agePercent_3 - _glesMultiTexCoord1.w) / (1.0 - _glesMultiTexCoord1.w)), 0.0, 1.0);
  tmpvar_25 = (tmpvar_26 * (tmpvar_26 * (3.0 - 
    (2.0 * tmpvar_26)
  )));
  tmpvar_5.w = (1.0 - (tmpvar_23 * (1.0 - tmpvar_25)));
  mediump vec3 atomosphere_27;
  mediump float tmpvar_28;
  tmpvar_28 = dot (_ES_SunDirection, viewDir_15);
  mediump float tmpvar_29;
  tmpvar_29 = max (((tmpvar_28 * _ES_SkyFrontAndBackBlendFactor) + (1.0 - _ES_SkyFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_30;
  tmpvar_30 = ((tmpvar_29 * tmpvar_29) * tmpvar_29);
  mediump vec4 tmpvar_31;
  tmpvar_31.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_31.x = (abs(tmpvar_19.w) / max (_ES_BottomColorHeight, 0.0001));
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DLod (_SkyGradientTex, tmpvar_31.xy, 0.0);
  mediump float tmpvar_33;
  tmpvar_33 = tmpvar_32.x;
  atomosphere_27 = mix (mix (_ES_TopBackColor, _ES_TopFrontColor, vec4(tmpvar_30)).xyz, mix (_ES_BottomBackColor, _ES_BottomFrontColor, vec4(tmpvar_30)).xyz, vec3(tmpvar_33));
  mediump vec4 tmpvar_34;
  tmpvar_34.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_34.x = (abs(tmpvar_19.w) / max (_ES_HorizonHaloHeight, 0.0001));
  lowp vec4 tmpvar_35;
  tmpvar_35 = texture2DLod (_SkyGradientTex, tmpvar_34.xy, 0.0);
  mediump float tmpvar_36;
  tmpvar_36 = tmpvar_35.y;
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    max (((tmpvar_28 * 0.5) + 0.5), 0.0)
   - 0.3) / 0.7), 0.0, 1.0);
  mediump float tmpvar_38;
  tmpvar_38 = clamp (((
    abs(_ES_SunDirection.y)
   - 0.2) / 0.3), 0.0, 1.0);
  atomosphere_27 = (atomosphere_27 + ((
    (_ES_HorizonHaloColor * _ES_HorizonHaloIntensity)
   * tmpvar_36) * mix (
    (tmpvar_37 * (tmpvar_37 * (3.0 - (2.0 * tmpvar_37))))
  , 1.0, 
    (tmpvar_38 * (tmpvar_38 * (3.0 - (2.0 * tmpvar_38))))
  )));
  highp vec3 viewDir_39;
  viewDir_39 = tmpvar_19.xyz;
  highp float haloInfluence_40;
  mediump float vertical_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((
    dot (_ES_SunDirection, viewDir_39)
   * 0.5) + 0.5), 0.0, 1.0);
  highp float tmpvar_43;
  tmpvar_43 = dot (viewDir_39, _ES_SkyWorldUpDir);
  vertical_41 = tmpvar_43;
  mediump float tmpvar_44;
  tmpvar_44 = abs(vertical_41);
  mediump float y_45;
  y_45 = (_ES_SunHaloSize * tmpvar_44);
  mediump float y_46;
  y_46 = ((_ES_SunHaloSize * 0.1) * tmpvar_44);
  haloInfluence_40 = (clamp (pow (tmpvar_42, y_45), 0.0, 1.0) + (clamp (
    pow (tmpvar_42, y_46)
  , 0.0, 1.0) * 0.12));
  mediump float y_47;
  y_47 = ((_ES_SunHaloSize * 0.01) * tmpvar_44);
  haloInfluence_40 = (haloInfluence_40 + (clamp (
    pow (tmpvar_42, y_47)
  , 0.0, 1.0) * 0.03));
  highp float tmpvar_48;
  tmpvar_48 = clamp (((
    max (((dot (_ES_SunDirection, viewDir_39) * 0.5) + 0.5), 0.0)
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 tmpvar_49;
  tmpvar_49 = (((haloInfluence_40 * _ES_SunHaloIntensity) * _ES_SunHaloColor) * (tmpvar_48 * (tmpvar_48 * 
    (3.0 - (2.0 * tmpvar_48))
  )));
  tmpvar_6 = (atomosphere_27 + tmpvar_49);
  mediump float tmpvar_50;
  mediump float tmpvar_51;
  tmpvar_51 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_50 = (tmpvar_51 * (tmpvar_51 * (3.0 - 
    (2.0 * tmpvar_51)
  )));
  highp vec3 viewDir_52;
  viewDir_52 = tmpvar_19.xyz;
  mediump float moonLunarCancel_53;
  mediump float tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = clamp (dot (_ES_MoonDirection, viewDir_52), 0.0, 1.0);
  tmpvar_54 = tmpvar_55;
  highp float tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_56 = (1.0 - (tmpvar_57 * 2.0));
  moonLunarCancel_53 = tmpvar_56;
  mediump float tmpvar_58;
  tmpvar_58 = clamp (((
    ((tmpvar_54 * tmpvar_54) * ((tmpvar_54 * tmpvar_54) * tmpvar_54))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_59;
  viewDir_59 = tmpvar_19.xyz;
  mediump float vertical_60;
  mediump float tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = clamp (((
    dot (_ES_SunDirection, viewDir_59)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_61 = tmpvar_62;
  highp float tmpvar_63;
  tmpvar_63 = dot (viewDir_59, _ES_SkyWorldUpDir);
  vertical_60 = tmpvar_63;
  mediump float tmpvar_64;
  mediump float tmpvar_65;
  tmpvar_65 = (1.0 - _ES_SunRimLightRadius);
  tmpvar_64 = clamp (((tmpvar_21 - _ES_SunRimLightRadius) / tmpvar_65), 0.0, 1.0);
  mediump float tmpvar_66;
  tmpvar_66 = (((tmpvar_64 * 
    (tmpvar_64 * (3.0 - (2.0 * tmpvar_64)))
  ) * _ES_SunBrightness) * 0.125);
  mediump float tmpvar_67;
  tmpvar_67 = clamp (((
    ((dot (viewDir_15, _ES_MoonDirection) * 0.5) + 0.5)
   - _ES_SunRimLightRadius) / tmpvar_65), 0.0, 1.0);
  mediump float tmpvar_68;
  tmpvar_68 = (((tmpvar_67 * 
    (tmpvar_67 * (3.0 - (2.0 * tmpvar_67)))
  ) * _ES_MoonBrightness) * 0.1);
  mediump float tmpvar_69;
  tmpvar_69 = max (((tmpvar_20 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_70;
  tmpvar_70 = ((tmpvar_69 * tmpvar_69) * tmpvar_69);
  gl_Position = clipPos_7;
  xlv_TEXCOORD0 = o_10;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_19;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = (((
    ((((tmpvar_58 * 
      (tmpvar_58 * (3.0 - (2.0 * tmpvar_58)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_53) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_61, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_60))
    ) * vertical_60), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_50);
  xlv_TEXCOORD6 = (((_ES_SunHaloColor * 
    (tmpvar_66 * tmpvar_66)
  ) + (_ES_MoonColor * 
    (tmpvar_68 * tmpvar_68)
  )) * tmpvar_50);
  xlv_TEXCOORD7 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_70));
  xlv_TEXCOORD8 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_70));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_CloudCoverage;
uniform sampler2D _CloudParticleAtlas;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 cloudCol_1;
  mediump vec4 texCol_2;
  highp vec3 curlNoise_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_CloudCurlTex, xlv_TEXCOORD1.zw).xyz;
  curlNoise_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD1.xy + ((
    (curlNoise_3.xy - 0.5)
   * curlNoise_3.z) * _CloudCurlAmplitude));
  tmpvar_5 = texture2D (_CloudParticleAtlas, P_6);
  texCol_2 = tmpvar_5;
  mediump float tmpvar_7;
  tmpvar_7 = max ((xlv_TEXCOORD3.w - xlv_TEXCOORD3.y), 0.0);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.y), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD2.w - -0.1) / 0.2), 0.0, 1.0);
  cloudCol_1.w = ((texCol_2.w * (tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  )) * (tmpvar_9 * (tmpvar_9 * 
    (3.0 - (2.0 * tmpvar_9))
  )));
  mediump float x_10;
  x_10 = (cloudCol_1.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.z), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  cloudCol_1.xyz = ((mix (xlv_TEXCOORD8, xlv_TEXCOORD7, texCol_2.xxx) + (xlv_TEXCOORD6 * 
    mix (texCol_2.y, ((1.0 - (tmpvar_11 * 
      (tmpvar_11 * (3.0 - (2.0 * tmpvar_11)))
    )) * 4.0), xlv_TEXCOORD3.w)
  )) + ((0.4 * xlv_TEXCOORD7) * _ES_CloudCoverage));
  cloudCol_1.xyz = (cloudCol_1.xyz + (xlv_TEXCOORD5 * texCol_2.x));
  cloudCol_1.xyz = (cloudCol_1.xyz * (xlv_TEXCOORD3.x + 1.0));
  mediump float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD2.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((_ES_CloudCoverage - 0.4) / 0.3), 0.0, 1.0);
  cloudCol_1.xyz = mix (xlv_TEXCOORD4, cloudCol_1.xyz, vec3(mix (clamp (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
  , 0.0, 1.0), 1.0, (tmpvar_13 * 
    (tmpvar_13 * (3.0 - (2.0 * tmpvar_13)))
  ))));
  cloudCol_1.w = clamp (cloudCol_1.w, 0.0, 1.0);
  gl_FragData[0] = cloudCol_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FIXED_SPRITE_ID" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec4 _ES_TopFrontColor;
uniform mediump vec4 _ES_TopBackColor;
uniform mediump vec4 _ES_BottomFrontColor;
uniform mediump vec4 _ES_BottomBackColor;
uniform mediump float _ES_SkyFrontAndBackBlendFactor;
uniform mediump float _ES_BottomColorHeight;
uniform mediump vec3 _ES_HorizonHaloColor;
uniform mediump float _ES_HorizonHaloIntensity;
uniform mediump float _ES_HorizonHaloHeight;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump float _ES_SunHaloSize;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudAgePercent;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform sampler2D _SkyGradientTex;
uniform highp vec2 _AtlasTiles;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
uniform highp int _FixedSpriteId;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  mediump float agePercent_3;
  highp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec4 clipPos_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  clipPos_7.xyw = tmpvar_8.xyw;
  clipPos_7.z = tmpvar_8.w;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8.xyww * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = clipPos_7.zw;
  highp vec2 tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = float(_FixedSpriteId);
  tmpvar_13.x = (float(mod (tmpvar_14, _AtlasTiles.x)));
  tmpvar_13.y = floor((tmpvar_14 / _AtlasTiles.x));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy + tmpvar_13) / _AtlasTiles);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _CloudCurlTiling) + ((_ES_CloudElapsedTime * vec2(1.2, 0.8)) * _CloudCurlSpeed));
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
  mediump float tmpvar_20;
  tmpvar_20 = dot (viewDir_15, _ES_SunDirection);
  mediump float tmpvar_21;
  tmpvar_21 = ((tmpvar_20 * 0.5) + 0.5);
  tmpvar_5.x = (tmpvar_21 * _ES_CloudSunBrightenIntensity);
  tmpvar_5.y = tmpvar_2.z;
  tmpvar_5.z = tmpvar_2.w;
  highp float tmpvar_22;
  tmpvar_22 = (_glesMultiTexCoord1.y / max (_glesMultiTexCoord1.x, 1e-05));
  agePercent_3 = tmpvar_22;
  agePercent_3 = (agePercent_3 * _ES_CloudAgePercent);
  highp float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = clamp ((agePercent_3 / _glesMultiTexCoord1.z), 0.0, 1.0);
  tmpvar_23 = (tmpvar_24 * (tmpvar_24 * (3.0 - 
    (2.0 * tmpvar_24)
  )));
  highp float tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = clamp (((agePercent_3 - _glesMultiTexCoord1.w) / (1.0 - _glesMultiTexCoord1.w)), 0.0, 1.0);
  tmpvar_25 = (tmpvar_26 * (tmpvar_26 * (3.0 - 
    (2.0 * tmpvar_26)
  )));
  tmpvar_5.w = (1.0 - (tmpvar_23 * (1.0 - tmpvar_25)));
  mediump vec3 atomosphere_27;
  mediump float tmpvar_28;
  tmpvar_28 = dot (_ES_SunDirection, viewDir_15);
  mediump float tmpvar_29;
  tmpvar_29 = max (((tmpvar_28 * _ES_SkyFrontAndBackBlendFactor) + (1.0 - _ES_SkyFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_30;
  tmpvar_30 = ((tmpvar_29 * tmpvar_29) * tmpvar_29);
  mediump vec4 tmpvar_31;
  tmpvar_31.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_31.x = (abs(tmpvar_19.w) / max (_ES_BottomColorHeight, 0.0001));
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DLod (_SkyGradientTex, tmpvar_31.xy, 0.0);
  mediump float tmpvar_33;
  tmpvar_33 = tmpvar_32.x;
  atomosphere_27 = mix (mix (_ES_TopBackColor, _ES_TopFrontColor, vec4(tmpvar_30)).xyz, mix (_ES_BottomBackColor, _ES_BottomFrontColor, vec4(tmpvar_30)).xyz, vec3(tmpvar_33));
  mediump vec4 tmpvar_34;
  tmpvar_34.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_34.x = (abs(tmpvar_19.w) / max (_ES_HorizonHaloHeight, 0.0001));
  lowp vec4 tmpvar_35;
  tmpvar_35 = texture2DLod (_SkyGradientTex, tmpvar_34.xy, 0.0);
  mediump float tmpvar_36;
  tmpvar_36 = tmpvar_35.y;
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    max (((tmpvar_28 * 0.5) + 0.5), 0.0)
   - 0.3) / 0.7), 0.0, 1.0);
  mediump float tmpvar_38;
  tmpvar_38 = clamp (((
    abs(_ES_SunDirection.y)
   - 0.2) / 0.3), 0.0, 1.0);
  atomosphere_27 = (atomosphere_27 + ((
    (_ES_HorizonHaloColor * _ES_HorizonHaloIntensity)
   * tmpvar_36) * mix (
    (tmpvar_37 * (tmpvar_37 * (3.0 - (2.0 * tmpvar_37))))
  , 1.0, 
    (tmpvar_38 * (tmpvar_38 * (3.0 - (2.0 * tmpvar_38))))
  )));
  highp vec3 viewDir_39;
  viewDir_39 = tmpvar_19.xyz;
  highp float haloInfluence_40;
  mediump float vertical_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((
    dot (_ES_SunDirection, viewDir_39)
   * 0.5) + 0.5), 0.0, 1.0);
  highp float tmpvar_43;
  tmpvar_43 = dot (viewDir_39, _ES_SkyWorldUpDir);
  vertical_41 = tmpvar_43;
  mediump float tmpvar_44;
  tmpvar_44 = abs(vertical_41);
  mediump float y_45;
  y_45 = (_ES_SunHaloSize * tmpvar_44);
  mediump float y_46;
  y_46 = ((_ES_SunHaloSize * 0.1) * tmpvar_44);
  haloInfluence_40 = (clamp (pow (tmpvar_42, y_45), 0.0, 1.0) + (clamp (
    pow (tmpvar_42, y_46)
  , 0.0, 1.0) * 0.12));
  mediump float y_47;
  y_47 = ((_ES_SunHaloSize * 0.01) * tmpvar_44);
  haloInfluence_40 = (haloInfluence_40 + (clamp (
    pow (tmpvar_42, y_47)
  , 0.0, 1.0) * 0.03));
  highp float tmpvar_48;
  tmpvar_48 = clamp (((
    max (((dot (_ES_SunDirection, viewDir_39) * 0.5) + 0.5), 0.0)
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 tmpvar_49;
  tmpvar_49 = (((haloInfluence_40 * _ES_SunHaloIntensity) * _ES_SunHaloColor) * (tmpvar_48 * (tmpvar_48 * 
    (3.0 - (2.0 * tmpvar_48))
  )));
  tmpvar_6 = (atomosphere_27 + tmpvar_49);
  mediump float tmpvar_50;
  mediump float tmpvar_51;
  tmpvar_51 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_50 = (tmpvar_51 * (tmpvar_51 * (3.0 - 
    (2.0 * tmpvar_51)
  )));
  highp vec3 viewDir_52;
  viewDir_52 = tmpvar_19.xyz;
  mediump float moonLunarCancel_53;
  mediump float tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = clamp (dot (_ES_MoonDirection, viewDir_52), 0.0, 1.0);
  tmpvar_54 = tmpvar_55;
  highp float tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_56 = (1.0 - (tmpvar_57 * 2.0));
  moonLunarCancel_53 = tmpvar_56;
  mediump float tmpvar_58;
  tmpvar_58 = clamp (((
    ((tmpvar_54 * tmpvar_54) * ((tmpvar_54 * tmpvar_54) * tmpvar_54))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_59;
  viewDir_59 = tmpvar_19.xyz;
  mediump float vertical_60;
  mediump float tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = clamp (((
    dot (_ES_SunDirection, viewDir_59)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_61 = tmpvar_62;
  highp float tmpvar_63;
  tmpvar_63 = dot (viewDir_59, _ES_SkyWorldUpDir);
  vertical_60 = tmpvar_63;
  mediump float tmpvar_64;
  mediump float tmpvar_65;
  tmpvar_65 = (1.0 - _ES_SunRimLightRadius);
  tmpvar_64 = clamp (((tmpvar_21 - _ES_SunRimLightRadius) / tmpvar_65), 0.0, 1.0);
  mediump float tmpvar_66;
  tmpvar_66 = (((tmpvar_64 * 
    (tmpvar_64 * (3.0 - (2.0 * tmpvar_64)))
  ) * _ES_SunBrightness) * 0.125);
  mediump float tmpvar_67;
  tmpvar_67 = clamp (((
    ((dot (viewDir_15, _ES_MoonDirection) * 0.5) + 0.5)
   - _ES_SunRimLightRadius) / tmpvar_65), 0.0, 1.0);
  mediump float tmpvar_68;
  tmpvar_68 = (((tmpvar_67 * 
    (tmpvar_67 * (3.0 - (2.0 * tmpvar_67)))
  ) * _ES_MoonBrightness) * 0.1);
  mediump float tmpvar_69;
  tmpvar_69 = max (((tmpvar_20 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_70;
  tmpvar_70 = ((tmpvar_69 * tmpvar_69) * tmpvar_69);
  gl_Position = clipPos_7;
  xlv_TEXCOORD0 = o_10;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_19;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = (((
    ((((tmpvar_58 * 
      (tmpvar_58 * (3.0 - (2.0 * tmpvar_58)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_53) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_61, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_60))
    ) * vertical_60), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_50);
  xlv_TEXCOORD6 = (((_ES_SunHaloColor * 
    (tmpvar_66 * tmpvar_66)
  ) + (_ES_MoonColor * 
    (tmpvar_68 * tmpvar_68)
  )) * tmpvar_50);
  xlv_TEXCOORD7 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_70));
  xlv_TEXCOORD8 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_70));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_CloudCoverage;
uniform sampler2D _CloudParticleAtlas;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 cloudCol_1;
  mediump vec4 texCol_2;
  highp vec3 curlNoise_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_CloudCurlTex, xlv_TEXCOORD1.zw).xyz;
  curlNoise_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD1.xy + ((
    (curlNoise_3.xy - 0.5)
   * curlNoise_3.z) * _CloudCurlAmplitude));
  tmpvar_5 = texture2D (_CloudParticleAtlas, P_6);
  texCol_2 = tmpvar_5;
  mediump float tmpvar_7;
  tmpvar_7 = max ((xlv_TEXCOORD3.w - xlv_TEXCOORD3.y), 0.0);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.y), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD2.w - -0.1) / 0.2), 0.0, 1.0);
  cloudCol_1.w = ((texCol_2.w * (tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  )) * (tmpvar_9 * (tmpvar_9 * 
    (3.0 - (2.0 * tmpvar_9))
  )));
  mediump float x_10;
  x_10 = (cloudCol_1.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.z), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  cloudCol_1.xyz = ((mix (xlv_TEXCOORD8, xlv_TEXCOORD7, texCol_2.xxx) + (xlv_TEXCOORD6 * 
    mix (texCol_2.y, ((1.0 - (tmpvar_11 * 
      (tmpvar_11 * (3.0 - (2.0 * tmpvar_11)))
    )) * 4.0), xlv_TEXCOORD3.w)
  )) + ((0.4 * xlv_TEXCOORD7) * _ES_CloudCoverage));
  cloudCol_1.xyz = (cloudCol_1.xyz + (xlv_TEXCOORD5 * texCol_2.x));
  cloudCol_1.xyz = (cloudCol_1.xyz * (xlv_TEXCOORD3.x + 1.0));
  mediump float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD2.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((_ES_CloudCoverage - 0.4) / 0.3), 0.0, 1.0);
  cloudCol_1.xyz = mix (xlv_TEXCOORD4, cloudCol_1.xyz, vec3(mix (clamp (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
  , 0.0, 1.0), 1.0, (tmpvar_13 * 
    (tmpvar_13 * (3.0 - (2.0 * tmpvar_13)))
  ))));
  cloudCol_1.w = clamp (cloudCol_1.w, 0.0, 1.0);
  gl_FragData[0] = cloudCol_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FIXED_SPRITE_ID" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec4 _ES_TopFrontColor;
uniform mediump vec4 _ES_TopBackColor;
uniform mediump vec4 _ES_BottomFrontColor;
uniform mediump vec4 _ES_BottomBackColor;
uniform mediump float _ES_SkyFrontAndBackBlendFactor;
uniform mediump float _ES_BottomColorHeight;
uniform mediump vec3 _ES_HorizonHaloColor;
uniform mediump float _ES_HorizonHaloIntensity;
uniform mediump float _ES_HorizonHaloHeight;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump float _ES_SunHaloSize;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudAgePercent;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform sampler2D _SkyGradientTex;
uniform highp vec2 _AtlasTiles;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
uniform highp int _FixedSpriteId;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  mediump float agePercent_3;
  highp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec4 clipPos_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  clipPos_7.xyw = tmpvar_8.xyw;
  clipPos_7.z = tmpvar_8.w;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8.xyww * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = clipPos_7.zw;
  highp vec2 tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = float(_FixedSpriteId);
  tmpvar_13.x = (float(mod (tmpvar_14, _AtlasTiles.x)));
  tmpvar_13.y = floor((tmpvar_14 / _AtlasTiles.x));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy + tmpvar_13) / _AtlasTiles);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _CloudCurlTiling) + ((_ES_CloudElapsedTime * vec2(1.2, 0.8)) * _CloudCurlSpeed));
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
  mediump float tmpvar_20;
  tmpvar_20 = dot (viewDir_15, _ES_SunDirection);
  mediump float tmpvar_21;
  tmpvar_21 = ((tmpvar_20 * 0.5) + 0.5);
  tmpvar_5.x = (tmpvar_21 * _ES_CloudSunBrightenIntensity);
  tmpvar_5.y = tmpvar_2.z;
  tmpvar_5.z = tmpvar_2.w;
  highp float tmpvar_22;
  tmpvar_22 = (_glesMultiTexCoord1.y / max (_glesMultiTexCoord1.x, 1e-05));
  agePercent_3 = tmpvar_22;
  agePercent_3 = (agePercent_3 * _ES_CloudAgePercent);
  highp float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = clamp ((agePercent_3 / _glesMultiTexCoord1.z), 0.0, 1.0);
  tmpvar_23 = (tmpvar_24 * (tmpvar_24 * (3.0 - 
    (2.0 * tmpvar_24)
  )));
  highp float tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = clamp (((agePercent_3 - _glesMultiTexCoord1.w) / (1.0 - _glesMultiTexCoord1.w)), 0.0, 1.0);
  tmpvar_25 = (tmpvar_26 * (tmpvar_26 * (3.0 - 
    (2.0 * tmpvar_26)
  )));
  tmpvar_5.w = (1.0 - (tmpvar_23 * (1.0 - tmpvar_25)));
  mediump vec3 atomosphere_27;
  mediump float tmpvar_28;
  tmpvar_28 = dot (_ES_SunDirection, viewDir_15);
  mediump float tmpvar_29;
  tmpvar_29 = max (((tmpvar_28 * _ES_SkyFrontAndBackBlendFactor) + (1.0 - _ES_SkyFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_30;
  tmpvar_30 = ((tmpvar_29 * tmpvar_29) * tmpvar_29);
  mediump vec4 tmpvar_31;
  tmpvar_31.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_31.x = (abs(tmpvar_19.w) / max (_ES_BottomColorHeight, 0.0001));
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DLod (_SkyGradientTex, tmpvar_31.xy, 0.0);
  mediump float tmpvar_33;
  tmpvar_33 = tmpvar_32.x;
  atomosphere_27 = mix (mix (_ES_TopBackColor, _ES_TopFrontColor, vec4(tmpvar_30)).xyz, mix (_ES_BottomBackColor, _ES_BottomFrontColor, vec4(tmpvar_30)).xyz, vec3(tmpvar_33));
  mediump vec4 tmpvar_34;
  tmpvar_34.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_34.x = (abs(tmpvar_19.w) / max (_ES_HorizonHaloHeight, 0.0001));
  lowp vec4 tmpvar_35;
  tmpvar_35 = texture2DLod (_SkyGradientTex, tmpvar_34.xy, 0.0);
  mediump float tmpvar_36;
  tmpvar_36 = tmpvar_35.y;
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    max (((tmpvar_28 * 0.5) + 0.5), 0.0)
   - 0.3) / 0.7), 0.0, 1.0);
  mediump float tmpvar_38;
  tmpvar_38 = clamp (((
    abs(_ES_SunDirection.y)
   - 0.2) / 0.3), 0.0, 1.0);
  atomosphere_27 = (atomosphere_27 + ((
    (_ES_HorizonHaloColor * _ES_HorizonHaloIntensity)
   * tmpvar_36) * mix (
    (tmpvar_37 * (tmpvar_37 * (3.0 - (2.0 * tmpvar_37))))
  , 1.0, 
    (tmpvar_38 * (tmpvar_38 * (3.0 - (2.0 * tmpvar_38))))
  )));
  highp vec3 viewDir_39;
  viewDir_39 = tmpvar_19.xyz;
  highp float haloInfluence_40;
  mediump float vertical_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((
    dot (_ES_SunDirection, viewDir_39)
   * 0.5) + 0.5), 0.0, 1.0);
  highp float tmpvar_43;
  tmpvar_43 = dot (viewDir_39, _ES_SkyWorldUpDir);
  vertical_41 = tmpvar_43;
  mediump float tmpvar_44;
  tmpvar_44 = abs(vertical_41);
  mediump float y_45;
  y_45 = (_ES_SunHaloSize * tmpvar_44);
  mediump float y_46;
  y_46 = ((_ES_SunHaloSize * 0.1) * tmpvar_44);
  haloInfluence_40 = (clamp (pow (tmpvar_42, y_45), 0.0, 1.0) + (clamp (
    pow (tmpvar_42, y_46)
  , 0.0, 1.0) * 0.12));
  mediump float y_47;
  y_47 = ((_ES_SunHaloSize * 0.01) * tmpvar_44);
  haloInfluence_40 = (haloInfluence_40 + (clamp (
    pow (tmpvar_42, y_47)
  , 0.0, 1.0) * 0.03));
  highp float tmpvar_48;
  tmpvar_48 = clamp (((
    max (((dot (_ES_SunDirection, viewDir_39) * 0.5) + 0.5), 0.0)
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 tmpvar_49;
  tmpvar_49 = (((haloInfluence_40 * _ES_SunHaloIntensity) * _ES_SunHaloColor) * (tmpvar_48 * (tmpvar_48 * 
    (3.0 - (2.0 * tmpvar_48))
  )));
  tmpvar_6 = (atomosphere_27 + tmpvar_49);
  mediump float tmpvar_50;
  mediump float tmpvar_51;
  tmpvar_51 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_50 = (tmpvar_51 * (tmpvar_51 * (3.0 - 
    (2.0 * tmpvar_51)
  )));
  highp vec3 viewDir_52;
  viewDir_52 = tmpvar_19.xyz;
  mediump float moonLunarCancel_53;
  mediump float tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = clamp (dot (_ES_MoonDirection, viewDir_52), 0.0, 1.0);
  tmpvar_54 = tmpvar_55;
  highp float tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_56 = (1.0 - (tmpvar_57 * 2.0));
  moonLunarCancel_53 = tmpvar_56;
  mediump float tmpvar_58;
  tmpvar_58 = clamp (((
    ((tmpvar_54 * tmpvar_54) * ((tmpvar_54 * tmpvar_54) * tmpvar_54))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_59;
  viewDir_59 = tmpvar_19.xyz;
  mediump float vertical_60;
  mediump float tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = clamp (((
    dot (_ES_SunDirection, viewDir_59)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_61 = tmpvar_62;
  highp float tmpvar_63;
  tmpvar_63 = dot (viewDir_59, _ES_SkyWorldUpDir);
  vertical_60 = tmpvar_63;
  mediump float tmpvar_64;
  mediump float tmpvar_65;
  tmpvar_65 = (1.0 - _ES_SunRimLightRadius);
  tmpvar_64 = clamp (((tmpvar_21 - _ES_SunRimLightRadius) / tmpvar_65), 0.0, 1.0);
  mediump float tmpvar_66;
  tmpvar_66 = (((tmpvar_64 * 
    (tmpvar_64 * (3.0 - (2.0 * tmpvar_64)))
  ) * _ES_SunBrightness) * 0.125);
  mediump float tmpvar_67;
  tmpvar_67 = clamp (((
    ((dot (viewDir_15, _ES_MoonDirection) * 0.5) + 0.5)
   - _ES_SunRimLightRadius) / tmpvar_65), 0.0, 1.0);
  mediump float tmpvar_68;
  tmpvar_68 = (((tmpvar_67 * 
    (tmpvar_67 * (3.0 - (2.0 * tmpvar_67)))
  ) * _ES_MoonBrightness) * 0.1);
  mediump float tmpvar_69;
  tmpvar_69 = max (((tmpvar_20 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_70;
  tmpvar_70 = ((tmpvar_69 * tmpvar_69) * tmpvar_69);
  gl_Position = clipPos_7;
  xlv_TEXCOORD0 = o_10;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_19;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = (((
    ((((tmpvar_58 * 
      (tmpvar_58 * (3.0 - (2.0 * tmpvar_58)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_53) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_61, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_60))
    ) * vertical_60), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_50);
  xlv_TEXCOORD6 = (((_ES_SunHaloColor * 
    (tmpvar_66 * tmpvar_66)
  ) + (_ES_MoonColor * 
    (tmpvar_68 * tmpvar_68)
  )) * tmpvar_50);
  xlv_TEXCOORD7 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_70));
  xlv_TEXCOORD8 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_70));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_CloudCoverage;
uniform sampler2D _CloudParticleAtlas;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 cloudCol_1;
  mediump vec4 texCol_2;
  highp vec3 curlNoise_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_CloudCurlTex, xlv_TEXCOORD1.zw).xyz;
  curlNoise_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD1.xy + ((
    (curlNoise_3.xy - 0.5)
   * curlNoise_3.z) * _CloudCurlAmplitude));
  tmpvar_5 = texture2D (_CloudParticleAtlas, P_6);
  texCol_2 = tmpvar_5;
  mediump float tmpvar_7;
  tmpvar_7 = max ((xlv_TEXCOORD3.w - xlv_TEXCOORD3.y), 0.0);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.y), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD2.w - -0.1) / 0.2), 0.0, 1.0);
  cloudCol_1.w = ((texCol_2.w * (tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  )) * (tmpvar_9 * (tmpvar_9 * 
    (3.0 - (2.0 * tmpvar_9))
  )));
  mediump float x_10;
  x_10 = (cloudCol_1.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.z), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  cloudCol_1.xyz = ((mix (xlv_TEXCOORD8, xlv_TEXCOORD7, texCol_2.xxx) + (xlv_TEXCOORD6 * 
    mix (texCol_2.y, ((1.0 - (tmpvar_11 * 
      (tmpvar_11 * (3.0 - (2.0 * tmpvar_11)))
    )) * 4.0), xlv_TEXCOORD3.w)
  )) + ((0.4 * xlv_TEXCOORD7) * _ES_CloudCoverage));
  cloudCol_1.xyz = (cloudCol_1.xyz + (xlv_TEXCOORD5 * texCol_2.x));
  cloudCol_1.xyz = (cloudCol_1.xyz * (xlv_TEXCOORD3.x + 1.0));
  mediump float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD2.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((_ES_CloudCoverage - 0.4) / 0.3), 0.0, 1.0);
  cloudCol_1.xyz = mix (xlv_TEXCOORD4, cloudCol_1.xyz, vec3(mix (clamp (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
  , 0.0, 1.0), 1.0, (tmpvar_13 * 
    (tmpvar_13 * (3.0 - (2.0 * tmpvar_13)))
  ))));
  cloudCol_1.w = clamp (cloudCol_1.w, 0.0, 1.0);
  gl_FragData[0] = cloudCol_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "FIXED_SPRITE_ID" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec4 _ES_TopFrontColor;
uniform mediump vec4 _ES_TopBackColor;
uniform mediump vec4 _ES_BottomFrontColor;
uniform mediump vec4 _ES_BottomBackColor;
uniform mediump float _ES_SkyFrontAndBackBlendFactor;
uniform mediump float _ES_BottomColorHeight;
uniform mediump vec3 _ES_HorizonHaloColor;
uniform mediump float _ES_HorizonHaloIntensity;
uniform mediump float _ES_HorizonHaloHeight;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump float _ES_SunHaloSize;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudAgePercent;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform sampler2D _SkyGradientTex;
uniform highp vec2 _AtlasTiles;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
uniform highp int _FixedSpriteId;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  mediump float agePercent_3;
  highp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec4 clipPos_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  clipPos_7.xyw = tmpvar_8.xyw;
  clipPos_7.z = tmpvar_8.w;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8.xyww * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = clipPos_7.zw;
  highp vec2 tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = float(_FixedSpriteId);
  tmpvar_13.x = (float(mod (tmpvar_14, _AtlasTiles.x)));
  tmpvar_13.y = floor((tmpvar_14 / _AtlasTiles.x));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy + tmpvar_13) / _AtlasTiles);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _CloudCurlTiling) + ((_ES_CloudElapsedTime * vec2(1.2, 0.8)) * _CloudCurlSpeed));
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
  mediump float tmpvar_20;
  tmpvar_20 = dot (viewDir_15, _ES_SunDirection);
  mediump float tmpvar_21;
  tmpvar_21 = ((tmpvar_20 * 0.5) + 0.5);
  tmpvar_5.x = (tmpvar_21 * _ES_CloudSunBrightenIntensity);
  tmpvar_5.y = tmpvar_2.z;
  tmpvar_5.z = tmpvar_2.w;
  highp float tmpvar_22;
  tmpvar_22 = (_glesMultiTexCoord1.y / max (_glesMultiTexCoord1.x, 1e-05));
  agePercent_3 = tmpvar_22;
  agePercent_3 = (agePercent_3 * _ES_CloudAgePercent);
  highp float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = clamp ((agePercent_3 / _glesMultiTexCoord1.z), 0.0, 1.0);
  tmpvar_23 = (tmpvar_24 * (tmpvar_24 * (3.0 - 
    (2.0 * tmpvar_24)
  )));
  highp float tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = clamp (((agePercent_3 - _glesMultiTexCoord1.w) / (1.0 - _glesMultiTexCoord1.w)), 0.0, 1.0);
  tmpvar_25 = (tmpvar_26 * (tmpvar_26 * (3.0 - 
    (2.0 * tmpvar_26)
  )));
  tmpvar_5.w = (1.0 - (tmpvar_23 * (1.0 - tmpvar_25)));
  mediump vec3 atomosphere_27;
  mediump float tmpvar_28;
  tmpvar_28 = dot (_ES_SunDirection, viewDir_15);
  mediump float tmpvar_29;
  tmpvar_29 = max (((tmpvar_28 * _ES_SkyFrontAndBackBlendFactor) + (1.0 - _ES_SkyFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_30;
  tmpvar_30 = ((tmpvar_29 * tmpvar_29) * tmpvar_29);
  mediump vec4 tmpvar_31;
  tmpvar_31.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_31.x = (abs(tmpvar_19.w) / max (_ES_BottomColorHeight, 0.0001));
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DLod (_SkyGradientTex, tmpvar_31.xy, 0.0);
  mediump float tmpvar_33;
  tmpvar_33 = tmpvar_32.x;
  atomosphere_27 = mix (mix (_ES_TopBackColor, _ES_TopFrontColor, vec4(tmpvar_30)).xyz, mix (_ES_BottomBackColor, _ES_BottomFrontColor, vec4(tmpvar_30)).xyz, vec3(tmpvar_33));
  mediump vec4 tmpvar_34;
  tmpvar_34.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_34.x = (abs(tmpvar_19.w) / max (_ES_HorizonHaloHeight, 0.0001));
  lowp vec4 tmpvar_35;
  tmpvar_35 = texture2DLod (_SkyGradientTex, tmpvar_34.xy, 0.0);
  mediump float tmpvar_36;
  tmpvar_36 = tmpvar_35.y;
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    max (((tmpvar_28 * 0.5) + 0.5), 0.0)
   - 0.3) / 0.7), 0.0, 1.0);
  mediump float tmpvar_38;
  tmpvar_38 = clamp (((
    abs(_ES_SunDirection.y)
   - 0.2) / 0.3), 0.0, 1.0);
  atomosphere_27 = (atomosphere_27 + ((
    (_ES_HorizonHaloColor * _ES_HorizonHaloIntensity)
   * tmpvar_36) * mix (
    (tmpvar_37 * (tmpvar_37 * (3.0 - (2.0 * tmpvar_37))))
  , 1.0, 
    (tmpvar_38 * (tmpvar_38 * (3.0 - (2.0 * tmpvar_38))))
  )));
  highp vec3 viewDir_39;
  viewDir_39 = tmpvar_19.xyz;
  highp float haloInfluence_40;
  mediump float vertical_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((
    dot (_ES_SunDirection, viewDir_39)
   * 0.5) + 0.5), 0.0, 1.0);
  highp float tmpvar_43;
  tmpvar_43 = dot (viewDir_39, _ES_SkyWorldUpDir);
  vertical_41 = tmpvar_43;
  mediump float tmpvar_44;
  tmpvar_44 = abs(vertical_41);
  mediump float y_45;
  y_45 = (_ES_SunHaloSize * tmpvar_44);
  mediump float y_46;
  y_46 = ((_ES_SunHaloSize * 0.1) * tmpvar_44);
  haloInfluence_40 = (clamp (pow (tmpvar_42, y_45), 0.0, 1.0) + (clamp (
    pow (tmpvar_42, y_46)
  , 0.0, 1.0) * 0.12));
  mediump float y_47;
  y_47 = ((_ES_SunHaloSize * 0.01) * tmpvar_44);
  haloInfluence_40 = (haloInfluence_40 + (clamp (
    pow (tmpvar_42, y_47)
  , 0.0, 1.0) * 0.03));
  highp float tmpvar_48;
  tmpvar_48 = clamp (((
    max (((dot (_ES_SunDirection, viewDir_39) * 0.5) + 0.5), 0.0)
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 tmpvar_49;
  tmpvar_49 = (((haloInfluence_40 * _ES_SunHaloIntensity) * _ES_SunHaloColor) * (tmpvar_48 * (tmpvar_48 * 
    (3.0 - (2.0 * tmpvar_48))
  )));
  tmpvar_6 = (atomosphere_27 + tmpvar_49);
  mediump float tmpvar_50;
  mediump float tmpvar_51;
  tmpvar_51 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_50 = (tmpvar_51 * (tmpvar_51 * (3.0 - 
    (2.0 * tmpvar_51)
  )));
  highp vec3 viewDir_52;
  viewDir_52 = tmpvar_19.xyz;
  mediump float moonLunarCancel_53;
  mediump float tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = clamp (dot (_ES_MoonDirection, viewDir_52), 0.0, 1.0);
  tmpvar_54 = tmpvar_55;
  highp float tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_56 = (1.0 - (tmpvar_57 * 2.0));
  moonLunarCancel_53 = tmpvar_56;
  mediump float tmpvar_58;
  tmpvar_58 = clamp (((
    ((tmpvar_54 * tmpvar_54) * ((tmpvar_54 * tmpvar_54) * tmpvar_54))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_59;
  viewDir_59 = tmpvar_19.xyz;
  mediump float vertical_60;
  mediump float tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = clamp (((
    dot (_ES_SunDirection, viewDir_59)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_61 = tmpvar_62;
  highp float tmpvar_63;
  tmpvar_63 = dot (viewDir_59, _ES_SkyWorldUpDir);
  vertical_60 = tmpvar_63;
  mediump float tmpvar_64;
  mediump float tmpvar_65;
  tmpvar_65 = (1.0 - _ES_SunRimLightRadius);
  tmpvar_64 = clamp (((tmpvar_21 - _ES_SunRimLightRadius) / tmpvar_65), 0.0, 1.0);
  mediump float tmpvar_66;
  tmpvar_66 = (((tmpvar_64 * 
    (tmpvar_64 * (3.0 - (2.0 * tmpvar_64)))
  ) * _ES_SunBrightness) * 0.125);
  mediump float tmpvar_67;
  tmpvar_67 = clamp (((
    ((dot (viewDir_15, _ES_MoonDirection) * 0.5) + 0.5)
   - _ES_SunRimLightRadius) / tmpvar_65), 0.0, 1.0);
  mediump float tmpvar_68;
  tmpvar_68 = (((tmpvar_67 * 
    (tmpvar_67 * (3.0 - (2.0 * tmpvar_67)))
  ) * _ES_MoonBrightness) * 0.1);
  mediump float tmpvar_69;
  tmpvar_69 = max (((tmpvar_20 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_70;
  tmpvar_70 = ((tmpvar_69 * tmpvar_69) * tmpvar_69);
  gl_Position = clipPos_7;
  xlv_TEXCOORD0 = o_10;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_19;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = (((
    ((((tmpvar_58 * 
      (tmpvar_58 * (3.0 - (2.0 * tmpvar_58)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_53) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_61, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_60))
    ) * vertical_60), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_50);
  xlv_TEXCOORD6 = (((_ES_SunHaloColor * 
    (tmpvar_66 * tmpvar_66)
  ) + (_ES_MoonColor * 
    (tmpvar_68 * tmpvar_68)
  )) * tmpvar_50);
  xlv_TEXCOORD7 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_70));
  xlv_TEXCOORD8 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_70));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_CloudCoverage;
uniform sampler2D _CloudParticleAtlas;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 cloudCol_1;
  mediump vec4 texCol_2;
  highp vec3 curlNoise_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_CloudCurlTex, xlv_TEXCOORD1.zw).xyz;
  curlNoise_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD1.xy + ((
    (curlNoise_3.xy - 0.5)
   * curlNoise_3.z) * _CloudCurlAmplitude));
  tmpvar_5 = texture2D (_CloudParticleAtlas, P_6);
  texCol_2 = tmpvar_5;
  mediump float tmpvar_7;
  tmpvar_7 = max ((xlv_TEXCOORD3.w - xlv_TEXCOORD3.y), 0.0);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.y), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD2.w - -0.1) / 0.2), 0.0, 1.0);
  cloudCol_1.w = ((texCol_2.w * (tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  )) * (tmpvar_9 * (tmpvar_9 * 
    (3.0 - (2.0 * tmpvar_9))
  )));
  mediump float x_10;
  x_10 = (cloudCol_1.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.z), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  cloudCol_1.xyz = ((mix (xlv_TEXCOORD8, xlv_TEXCOORD7, texCol_2.xxx) + (xlv_TEXCOORD6 * 
    mix (texCol_2.y, ((1.0 - (tmpvar_11 * 
      (tmpvar_11 * (3.0 - (2.0 * tmpvar_11)))
    )) * 4.0), xlv_TEXCOORD3.w)
  )) + ((0.4 * xlv_TEXCOORD7) * _ES_CloudCoverage));
  cloudCol_1.xyz = (cloudCol_1.xyz + (xlv_TEXCOORD5 * texCol_2.x));
  cloudCol_1.xyz = (cloudCol_1.xyz * (xlv_TEXCOORD3.x + 1.0));
  mediump float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD2.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((_ES_CloudCoverage - 0.4) / 0.3), 0.0, 1.0);
  cloudCol_1.xyz = mix (xlv_TEXCOORD4, cloudCol_1.xyz, vec3(mix (clamp (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
  , 0.0, 1.0), 1.0, (tmpvar_13 * 
    (tmpvar_13 * (3.0 - (2.0 * tmpvar_13)))
  ))));
  cloudCol_1.w = clamp (cloudCol_1.w, 0.0, 1.0);
  gl_FragData[0] = cloudCol_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "FIXED_SPRITE_ID" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec4 _ES_TopFrontColor;
uniform mediump vec4 _ES_TopBackColor;
uniform mediump vec4 _ES_BottomFrontColor;
uniform mediump vec4 _ES_BottomBackColor;
uniform mediump float _ES_SkyFrontAndBackBlendFactor;
uniform mediump float _ES_BottomColorHeight;
uniform mediump vec3 _ES_HorizonHaloColor;
uniform mediump float _ES_HorizonHaloIntensity;
uniform mediump float _ES_HorizonHaloHeight;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump float _ES_SunHaloSize;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudAgePercent;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform sampler2D _SkyGradientTex;
uniform highp vec2 _AtlasTiles;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
uniform highp int _FixedSpriteId;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  mediump float agePercent_3;
  highp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec4 clipPos_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  clipPos_7.xyw = tmpvar_8.xyw;
  clipPos_7.z = tmpvar_8.w;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8.xyww * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = clipPos_7.zw;
  highp vec2 tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = float(_FixedSpriteId);
  tmpvar_13.x = (float(mod (tmpvar_14, _AtlasTiles.x)));
  tmpvar_13.y = floor((tmpvar_14 / _AtlasTiles.x));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy + tmpvar_13) / _AtlasTiles);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _CloudCurlTiling) + ((_ES_CloudElapsedTime * vec2(1.2, 0.8)) * _CloudCurlSpeed));
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
  mediump float tmpvar_20;
  tmpvar_20 = dot (viewDir_15, _ES_SunDirection);
  mediump float tmpvar_21;
  tmpvar_21 = ((tmpvar_20 * 0.5) + 0.5);
  tmpvar_5.x = (tmpvar_21 * _ES_CloudSunBrightenIntensity);
  tmpvar_5.y = tmpvar_2.z;
  tmpvar_5.z = tmpvar_2.w;
  highp float tmpvar_22;
  tmpvar_22 = (_glesMultiTexCoord1.y / max (_glesMultiTexCoord1.x, 1e-05));
  agePercent_3 = tmpvar_22;
  agePercent_3 = (agePercent_3 * _ES_CloudAgePercent);
  highp float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = clamp ((agePercent_3 / _glesMultiTexCoord1.z), 0.0, 1.0);
  tmpvar_23 = (tmpvar_24 * (tmpvar_24 * (3.0 - 
    (2.0 * tmpvar_24)
  )));
  highp float tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = clamp (((agePercent_3 - _glesMultiTexCoord1.w) / (1.0 - _glesMultiTexCoord1.w)), 0.0, 1.0);
  tmpvar_25 = (tmpvar_26 * (tmpvar_26 * (3.0 - 
    (2.0 * tmpvar_26)
  )));
  tmpvar_5.w = (1.0 - (tmpvar_23 * (1.0 - tmpvar_25)));
  mediump vec3 atomosphere_27;
  mediump float tmpvar_28;
  tmpvar_28 = dot (_ES_SunDirection, viewDir_15);
  mediump float tmpvar_29;
  tmpvar_29 = max (((tmpvar_28 * _ES_SkyFrontAndBackBlendFactor) + (1.0 - _ES_SkyFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_30;
  tmpvar_30 = ((tmpvar_29 * tmpvar_29) * tmpvar_29);
  mediump vec4 tmpvar_31;
  tmpvar_31.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_31.x = (abs(tmpvar_19.w) / max (_ES_BottomColorHeight, 0.0001));
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DLod (_SkyGradientTex, tmpvar_31.xy, 0.0);
  mediump float tmpvar_33;
  tmpvar_33 = tmpvar_32.x;
  atomosphere_27 = mix (mix (_ES_TopBackColor, _ES_TopFrontColor, vec4(tmpvar_30)).xyz, mix (_ES_BottomBackColor, _ES_BottomFrontColor, vec4(tmpvar_30)).xyz, vec3(tmpvar_33));
  mediump vec4 tmpvar_34;
  tmpvar_34.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_34.x = (abs(tmpvar_19.w) / max (_ES_HorizonHaloHeight, 0.0001));
  lowp vec4 tmpvar_35;
  tmpvar_35 = texture2DLod (_SkyGradientTex, tmpvar_34.xy, 0.0);
  mediump float tmpvar_36;
  tmpvar_36 = tmpvar_35.y;
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    max (((tmpvar_28 * 0.5) + 0.5), 0.0)
   - 0.3) / 0.7), 0.0, 1.0);
  mediump float tmpvar_38;
  tmpvar_38 = clamp (((
    abs(_ES_SunDirection.y)
   - 0.2) / 0.3), 0.0, 1.0);
  atomosphere_27 = (atomosphere_27 + ((
    (_ES_HorizonHaloColor * _ES_HorizonHaloIntensity)
   * tmpvar_36) * mix (
    (tmpvar_37 * (tmpvar_37 * (3.0 - (2.0 * tmpvar_37))))
  , 1.0, 
    (tmpvar_38 * (tmpvar_38 * (3.0 - (2.0 * tmpvar_38))))
  )));
  highp vec3 viewDir_39;
  viewDir_39 = tmpvar_19.xyz;
  highp float haloInfluence_40;
  mediump float vertical_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((
    dot (_ES_SunDirection, viewDir_39)
   * 0.5) + 0.5), 0.0, 1.0);
  highp float tmpvar_43;
  tmpvar_43 = dot (viewDir_39, _ES_SkyWorldUpDir);
  vertical_41 = tmpvar_43;
  mediump float tmpvar_44;
  tmpvar_44 = abs(vertical_41);
  mediump float y_45;
  y_45 = (_ES_SunHaloSize * tmpvar_44);
  mediump float y_46;
  y_46 = ((_ES_SunHaloSize * 0.1) * tmpvar_44);
  haloInfluence_40 = (clamp (pow (tmpvar_42, y_45), 0.0, 1.0) + (clamp (
    pow (tmpvar_42, y_46)
  , 0.0, 1.0) * 0.12));
  mediump float y_47;
  y_47 = ((_ES_SunHaloSize * 0.01) * tmpvar_44);
  haloInfluence_40 = (haloInfluence_40 + (clamp (
    pow (tmpvar_42, y_47)
  , 0.0, 1.0) * 0.03));
  highp float tmpvar_48;
  tmpvar_48 = clamp (((
    max (((dot (_ES_SunDirection, viewDir_39) * 0.5) + 0.5), 0.0)
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 tmpvar_49;
  tmpvar_49 = (((haloInfluence_40 * _ES_SunHaloIntensity) * _ES_SunHaloColor) * (tmpvar_48 * (tmpvar_48 * 
    (3.0 - (2.0 * tmpvar_48))
  )));
  tmpvar_6 = (atomosphere_27 + tmpvar_49);
  mediump float tmpvar_50;
  mediump float tmpvar_51;
  tmpvar_51 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_50 = (tmpvar_51 * (tmpvar_51 * (3.0 - 
    (2.0 * tmpvar_51)
  )));
  highp vec3 viewDir_52;
  viewDir_52 = tmpvar_19.xyz;
  mediump float moonLunarCancel_53;
  mediump float tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = clamp (dot (_ES_MoonDirection, viewDir_52), 0.0, 1.0);
  tmpvar_54 = tmpvar_55;
  highp float tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_56 = (1.0 - (tmpvar_57 * 2.0));
  moonLunarCancel_53 = tmpvar_56;
  mediump float tmpvar_58;
  tmpvar_58 = clamp (((
    ((tmpvar_54 * tmpvar_54) * ((tmpvar_54 * tmpvar_54) * tmpvar_54))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_59;
  viewDir_59 = tmpvar_19.xyz;
  mediump float vertical_60;
  mediump float tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = clamp (((
    dot (_ES_SunDirection, viewDir_59)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_61 = tmpvar_62;
  highp float tmpvar_63;
  tmpvar_63 = dot (viewDir_59, _ES_SkyWorldUpDir);
  vertical_60 = tmpvar_63;
  mediump float tmpvar_64;
  mediump float tmpvar_65;
  tmpvar_65 = (1.0 - _ES_SunRimLightRadius);
  tmpvar_64 = clamp (((tmpvar_21 - _ES_SunRimLightRadius) / tmpvar_65), 0.0, 1.0);
  mediump float tmpvar_66;
  tmpvar_66 = (((tmpvar_64 * 
    (tmpvar_64 * (3.0 - (2.0 * tmpvar_64)))
  ) * _ES_SunBrightness) * 0.125);
  mediump float tmpvar_67;
  tmpvar_67 = clamp (((
    ((dot (viewDir_15, _ES_MoonDirection) * 0.5) + 0.5)
   - _ES_SunRimLightRadius) / tmpvar_65), 0.0, 1.0);
  mediump float tmpvar_68;
  tmpvar_68 = (((tmpvar_67 * 
    (tmpvar_67 * (3.0 - (2.0 * tmpvar_67)))
  ) * _ES_MoonBrightness) * 0.1);
  mediump float tmpvar_69;
  tmpvar_69 = max (((tmpvar_20 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_70;
  tmpvar_70 = ((tmpvar_69 * tmpvar_69) * tmpvar_69);
  gl_Position = clipPos_7;
  xlv_TEXCOORD0 = o_10;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_19;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = (((
    ((((tmpvar_58 * 
      (tmpvar_58 * (3.0 - (2.0 * tmpvar_58)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_53) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_61, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_60))
    ) * vertical_60), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_50);
  xlv_TEXCOORD6 = (((_ES_SunHaloColor * 
    (tmpvar_66 * tmpvar_66)
  ) + (_ES_MoonColor * 
    (tmpvar_68 * tmpvar_68)
  )) * tmpvar_50);
  xlv_TEXCOORD7 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_70));
  xlv_TEXCOORD8 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_70));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_CloudCoverage;
uniform sampler2D _CloudParticleAtlas;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 cloudCol_1;
  mediump vec4 texCol_2;
  highp vec3 curlNoise_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_CloudCurlTex, xlv_TEXCOORD1.zw).xyz;
  curlNoise_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD1.xy + ((
    (curlNoise_3.xy - 0.5)
   * curlNoise_3.z) * _CloudCurlAmplitude));
  tmpvar_5 = texture2D (_CloudParticleAtlas, P_6);
  texCol_2 = tmpvar_5;
  mediump float tmpvar_7;
  tmpvar_7 = max ((xlv_TEXCOORD3.w - xlv_TEXCOORD3.y), 0.0);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.y), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD2.w - -0.1) / 0.2), 0.0, 1.0);
  cloudCol_1.w = ((texCol_2.w * (tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  )) * (tmpvar_9 * (tmpvar_9 * 
    (3.0 - (2.0 * tmpvar_9))
  )));
  mediump float x_10;
  x_10 = (cloudCol_1.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.z), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  cloudCol_1.xyz = ((mix (xlv_TEXCOORD8, xlv_TEXCOORD7, texCol_2.xxx) + (xlv_TEXCOORD6 * 
    mix (texCol_2.y, ((1.0 - (tmpvar_11 * 
      (tmpvar_11 * (3.0 - (2.0 * tmpvar_11)))
    )) * 4.0), xlv_TEXCOORD3.w)
  )) + ((0.4 * xlv_TEXCOORD7) * _ES_CloudCoverage));
  cloudCol_1.xyz = (cloudCol_1.xyz + (xlv_TEXCOORD5 * texCol_2.x));
  cloudCol_1.xyz = (cloudCol_1.xyz * (xlv_TEXCOORD3.x + 1.0));
  mediump float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD2.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((_ES_CloudCoverage - 0.4) / 0.3), 0.0, 1.0);
  cloudCol_1.xyz = mix (xlv_TEXCOORD4, cloudCol_1.xyz, vec3(mix (clamp (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
  , 0.0, 1.0), 1.0, (tmpvar_13 * 
    (tmpvar_13 * (3.0 - (2.0 * tmpvar_13)))
  ))));
  cloudCol_1.w = clamp (cloudCol_1.w, 0.0, 1.0);
  gl_FragData[0] = cloudCol_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "FIXED_SPRITE_ID" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec4 _ES_TopFrontColor;
uniform mediump vec4 _ES_TopBackColor;
uniform mediump vec4 _ES_BottomFrontColor;
uniform mediump vec4 _ES_BottomBackColor;
uniform mediump float _ES_SkyFrontAndBackBlendFactor;
uniform mediump float _ES_BottomColorHeight;
uniform mediump vec3 _ES_HorizonHaloColor;
uniform mediump float _ES_HorizonHaloIntensity;
uniform mediump float _ES_HorizonHaloHeight;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump float _ES_SunHaloSize;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudAgePercent;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform sampler2D _SkyGradientTex;
uniform highp vec2 _AtlasTiles;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
uniform highp int _FixedSpriteId;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  mediump float agePercent_3;
  highp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec4 clipPos_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  clipPos_7.xyw = tmpvar_8.xyw;
  clipPos_7.z = tmpvar_8.w;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8.xyww * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = clipPos_7.zw;
  highp vec2 tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = float(_FixedSpriteId);
  tmpvar_13.x = (float(mod (tmpvar_14, _AtlasTiles.x)));
  tmpvar_13.y = floor((tmpvar_14 / _AtlasTiles.x));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy + tmpvar_13) / _AtlasTiles);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _CloudCurlTiling) + ((_ES_CloudElapsedTime * vec2(1.2, 0.8)) * _CloudCurlSpeed));
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
  mediump float tmpvar_20;
  tmpvar_20 = dot (viewDir_15, _ES_SunDirection);
  mediump float tmpvar_21;
  tmpvar_21 = ((tmpvar_20 * 0.5) + 0.5);
  tmpvar_5.x = (tmpvar_21 * _ES_CloudSunBrightenIntensity);
  tmpvar_5.y = tmpvar_2.z;
  tmpvar_5.z = tmpvar_2.w;
  highp float tmpvar_22;
  tmpvar_22 = (_glesMultiTexCoord1.y / max (_glesMultiTexCoord1.x, 1e-05));
  agePercent_3 = tmpvar_22;
  agePercent_3 = (agePercent_3 * _ES_CloudAgePercent);
  highp float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = clamp ((agePercent_3 / _glesMultiTexCoord1.z), 0.0, 1.0);
  tmpvar_23 = (tmpvar_24 * (tmpvar_24 * (3.0 - 
    (2.0 * tmpvar_24)
  )));
  highp float tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = clamp (((agePercent_3 - _glesMultiTexCoord1.w) / (1.0 - _glesMultiTexCoord1.w)), 0.0, 1.0);
  tmpvar_25 = (tmpvar_26 * (tmpvar_26 * (3.0 - 
    (2.0 * tmpvar_26)
  )));
  tmpvar_5.w = (1.0 - (tmpvar_23 * (1.0 - tmpvar_25)));
  mediump vec3 atomosphere_27;
  mediump float tmpvar_28;
  tmpvar_28 = dot (_ES_SunDirection, viewDir_15);
  mediump float tmpvar_29;
  tmpvar_29 = max (((tmpvar_28 * _ES_SkyFrontAndBackBlendFactor) + (1.0 - _ES_SkyFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_30;
  tmpvar_30 = ((tmpvar_29 * tmpvar_29) * tmpvar_29);
  mediump vec4 tmpvar_31;
  tmpvar_31.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_31.x = (abs(tmpvar_19.w) / max (_ES_BottomColorHeight, 0.0001));
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DLod (_SkyGradientTex, tmpvar_31.xy, 0.0);
  mediump float tmpvar_33;
  tmpvar_33 = tmpvar_32.x;
  atomosphere_27 = mix (mix (_ES_TopBackColor, _ES_TopFrontColor, vec4(tmpvar_30)).xyz, mix (_ES_BottomBackColor, _ES_BottomFrontColor, vec4(tmpvar_30)).xyz, vec3(tmpvar_33));
  mediump vec4 tmpvar_34;
  tmpvar_34.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_34.x = (abs(tmpvar_19.w) / max (_ES_HorizonHaloHeight, 0.0001));
  lowp vec4 tmpvar_35;
  tmpvar_35 = texture2DLod (_SkyGradientTex, tmpvar_34.xy, 0.0);
  mediump float tmpvar_36;
  tmpvar_36 = tmpvar_35.y;
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    max (((tmpvar_28 * 0.5) + 0.5), 0.0)
   - 0.3) / 0.7), 0.0, 1.0);
  mediump float tmpvar_38;
  tmpvar_38 = clamp (((
    abs(_ES_SunDirection.y)
   - 0.2) / 0.3), 0.0, 1.0);
  atomosphere_27 = (atomosphere_27 + ((
    (_ES_HorizonHaloColor * _ES_HorizonHaloIntensity)
   * tmpvar_36) * mix (
    (tmpvar_37 * (tmpvar_37 * (3.0 - (2.0 * tmpvar_37))))
  , 1.0, 
    (tmpvar_38 * (tmpvar_38 * (3.0 - (2.0 * tmpvar_38))))
  )));
  highp vec3 viewDir_39;
  viewDir_39 = tmpvar_19.xyz;
  highp float haloInfluence_40;
  mediump float vertical_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((
    dot (_ES_SunDirection, viewDir_39)
   * 0.5) + 0.5), 0.0, 1.0);
  highp float tmpvar_43;
  tmpvar_43 = dot (viewDir_39, _ES_SkyWorldUpDir);
  vertical_41 = tmpvar_43;
  mediump float tmpvar_44;
  tmpvar_44 = abs(vertical_41);
  mediump float y_45;
  y_45 = (_ES_SunHaloSize * tmpvar_44);
  mediump float y_46;
  y_46 = ((_ES_SunHaloSize * 0.1) * tmpvar_44);
  haloInfluence_40 = (clamp (pow (tmpvar_42, y_45), 0.0, 1.0) + (clamp (
    pow (tmpvar_42, y_46)
  , 0.0, 1.0) * 0.12));
  mediump float y_47;
  y_47 = ((_ES_SunHaloSize * 0.01) * tmpvar_44);
  haloInfluence_40 = (haloInfluence_40 + (clamp (
    pow (tmpvar_42, y_47)
  , 0.0, 1.0) * 0.03));
  highp float tmpvar_48;
  tmpvar_48 = clamp (((
    max (((dot (_ES_SunDirection, viewDir_39) * 0.5) + 0.5), 0.0)
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 tmpvar_49;
  tmpvar_49 = (((haloInfluence_40 * _ES_SunHaloIntensity) * _ES_SunHaloColor) * (tmpvar_48 * (tmpvar_48 * 
    (3.0 - (2.0 * tmpvar_48))
  )));
  tmpvar_6 = (atomosphere_27 + tmpvar_49);
  mediump float tmpvar_50;
  mediump float tmpvar_51;
  tmpvar_51 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_50 = (tmpvar_51 * (tmpvar_51 * (3.0 - 
    (2.0 * tmpvar_51)
  )));
  highp vec3 viewDir_52;
  viewDir_52 = tmpvar_19.xyz;
  mediump float moonLunarCancel_53;
  mediump float tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = clamp (dot (_ES_MoonDirection, viewDir_52), 0.0, 1.0);
  tmpvar_54 = tmpvar_55;
  highp float tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_56 = (1.0 - (tmpvar_57 * 2.0));
  moonLunarCancel_53 = tmpvar_56;
  mediump float tmpvar_58;
  tmpvar_58 = clamp (((
    ((tmpvar_54 * tmpvar_54) * ((tmpvar_54 * tmpvar_54) * tmpvar_54))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_59;
  viewDir_59 = tmpvar_19.xyz;
  mediump float vertical_60;
  mediump float tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = clamp (((
    dot (_ES_SunDirection, viewDir_59)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_61 = tmpvar_62;
  highp float tmpvar_63;
  tmpvar_63 = dot (viewDir_59, _ES_SkyWorldUpDir);
  vertical_60 = tmpvar_63;
  mediump float tmpvar_64;
  mediump float tmpvar_65;
  tmpvar_65 = (1.0 - _ES_SunRimLightRadius);
  tmpvar_64 = clamp (((tmpvar_21 - _ES_SunRimLightRadius) / tmpvar_65), 0.0, 1.0);
  mediump float tmpvar_66;
  tmpvar_66 = (((tmpvar_64 * 
    (tmpvar_64 * (3.0 - (2.0 * tmpvar_64)))
  ) * _ES_SunBrightness) * 0.125);
  mediump float tmpvar_67;
  tmpvar_67 = clamp (((
    ((dot (viewDir_15, _ES_MoonDirection) * 0.5) + 0.5)
   - _ES_SunRimLightRadius) / tmpvar_65), 0.0, 1.0);
  mediump float tmpvar_68;
  tmpvar_68 = (((tmpvar_67 * 
    (tmpvar_67 * (3.0 - (2.0 * tmpvar_67)))
  ) * _ES_MoonBrightness) * 0.1);
  mediump float tmpvar_69;
  tmpvar_69 = max (((tmpvar_20 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_70;
  tmpvar_70 = ((tmpvar_69 * tmpvar_69) * tmpvar_69);
  gl_Position = clipPos_7;
  xlv_TEXCOORD0 = o_10;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_19;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = (((
    ((((tmpvar_58 * 
      (tmpvar_58 * (3.0 - (2.0 * tmpvar_58)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_53) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_61, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_60))
    ) * vertical_60), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_50);
  xlv_TEXCOORD6 = (((_ES_SunHaloColor * 
    (tmpvar_66 * tmpvar_66)
  ) + (_ES_MoonColor * 
    (tmpvar_68 * tmpvar_68)
  )) * tmpvar_50);
  xlv_TEXCOORD7 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_70));
  xlv_TEXCOORD8 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_70));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_CloudCoverage;
uniform sampler2D _CloudParticleAtlas;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 cloudCol_1;
  mediump vec4 texCol_2;
  highp vec3 curlNoise_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_CloudCurlTex, xlv_TEXCOORD1.zw).xyz;
  curlNoise_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD1.xy + ((
    (curlNoise_3.xy - 0.5)
   * curlNoise_3.z) * _CloudCurlAmplitude));
  tmpvar_5 = texture2D (_CloudParticleAtlas, P_6);
  texCol_2 = tmpvar_5;
  mediump float tmpvar_7;
  tmpvar_7 = max ((xlv_TEXCOORD3.w - xlv_TEXCOORD3.y), 0.0);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.y), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD2.w - -0.1) / 0.2), 0.0, 1.0);
  cloudCol_1.w = ((texCol_2.w * (tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  )) * (tmpvar_9 * (tmpvar_9 * 
    (3.0 - (2.0 * tmpvar_9))
  )));
  mediump float x_10;
  x_10 = (cloudCol_1.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.z), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  cloudCol_1.xyz = ((mix (xlv_TEXCOORD8, xlv_TEXCOORD7, texCol_2.xxx) + (xlv_TEXCOORD6 * 
    mix (texCol_2.y, ((1.0 - (tmpvar_11 * 
      (tmpvar_11 * (3.0 - (2.0 * tmpvar_11)))
    )) * 4.0), xlv_TEXCOORD3.w)
  )) + ((0.4 * xlv_TEXCOORD7) * _ES_CloudCoverage));
  cloudCol_1.xyz = (cloudCol_1.xyz + (xlv_TEXCOORD5 * texCol_2.x));
  cloudCol_1.xyz = (cloudCol_1.xyz * (xlv_TEXCOORD3.x + 1.0));
  mediump float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD2.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((_ES_CloudCoverage - 0.4) / 0.3), 0.0, 1.0);
  cloudCol_1.xyz = mix (xlv_TEXCOORD4, cloudCol_1.xyz, vec3(mix (clamp (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
  , 0.0, 1.0), 1.0, (tmpvar_13 * 
    (tmpvar_13 * (3.0 - (2.0 * tmpvar_13)))
  ))));
  cloudCol_1.w = clamp (cloudCol_1.w, 0.0, 1.0);
  gl_FragData[0] = cloudCol_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FIXED_SPRITE_ID" "FIXED_RIMLIGHT_WIDTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec4 _ES_TopFrontColor;
uniform mediump vec4 _ES_TopBackColor;
uniform mediump vec4 _ES_BottomFrontColor;
uniform mediump vec4 _ES_BottomBackColor;
uniform mediump float _ES_SkyFrontAndBackBlendFactor;
uniform mediump float _ES_BottomColorHeight;
uniform mediump vec3 _ES_HorizonHaloColor;
uniform mediump float _ES_HorizonHaloIntensity;
uniform mediump float _ES_HorizonHaloHeight;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump float _ES_SunHaloSize;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudAgePercent;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform sampler2D _SkyGradientTex;
uniform highp vec2 _AtlasTiles;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
uniform highp int _FixedSpriteId;
uniform mediump float _FixedRimLightWidth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float agePercent_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 clipPos_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  clipPos_6.xyw = tmpvar_7.xyw;
  clipPos_6.z = tmpvar_7.w;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7.xyww * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = clipPos_6.zw;
  highp vec2 tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = float(_FixedSpriteId);
  tmpvar_12.x = (float(mod (tmpvar_13, _AtlasTiles.x)));
  tmpvar_12.y = floor((tmpvar_13 / _AtlasTiles.x));
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy + tmpvar_12) / _AtlasTiles);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _CloudCurlTiling) + ((_ES_CloudElapsedTime * vec2(1.2, 0.8)) * _CloudCurlSpeed));
  mediump vec3 viewDir_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(((unity_ObjectToWorld * tmpvar_15).xyz - _ES_SkyCenterWorldPos));
  viewDir_14 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (_ES_SkyWorldUpDir, viewDir_14);
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = viewDir_14;
  tmpvar_18.w = ((sign(tmpvar_17) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_17))) * (1.570796 + (abs(tmpvar_17) * (-0.2146018 + 
      (abs(tmpvar_17) * (0.08656672 + (abs(tmpvar_17) * -0.03102955)))
    ))))
  )) * 0.6366198);
  mediump float tmpvar_19;
  tmpvar_19 = dot (viewDir_14, _ES_SunDirection);
  mediump float tmpvar_20;
  tmpvar_20 = ((tmpvar_19 * 0.5) + 0.5);
  tmpvar_4.x = (tmpvar_20 * _ES_CloudSunBrightenIntensity);
  tmpvar_4.y = _glesColor.z;
  tmpvar_4.z = _FixedRimLightWidth;
  highp float tmpvar_21;
  tmpvar_21 = (_glesMultiTexCoord1.y / max (_glesMultiTexCoord1.x, 1e-05));
  agePercent_2 = tmpvar_21;
  agePercent_2 = (agePercent_2 * _ES_CloudAgePercent);
  highp float tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = clamp ((agePercent_2 / _glesMultiTexCoord1.z), 0.0, 1.0);
  tmpvar_22 = (tmpvar_23 * (tmpvar_23 * (3.0 - 
    (2.0 * tmpvar_23)
  )));
  highp float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((agePercent_2 - _glesMultiTexCoord1.w) / (1.0 - _glesMultiTexCoord1.w)), 0.0, 1.0);
  tmpvar_24 = (tmpvar_25 * (tmpvar_25 * (3.0 - 
    (2.0 * tmpvar_25)
  )));
  tmpvar_4.w = (1.0 - (tmpvar_22 * (1.0 - tmpvar_24)));
  mediump vec3 atomosphere_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (_ES_SunDirection, viewDir_14);
  mediump float tmpvar_28;
  tmpvar_28 = max (((tmpvar_27 * _ES_SkyFrontAndBackBlendFactor) + (1.0 - _ES_SkyFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_29;
  tmpvar_29 = ((tmpvar_28 * tmpvar_28) * tmpvar_28);
  mediump vec4 tmpvar_30;
  tmpvar_30.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_30.x = (abs(tmpvar_18.w) / max (_ES_BottomColorHeight, 0.0001));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DLod (_SkyGradientTex, tmpvar_30.xy, 0.0);
  mediump float tmpvar_32;
  tmpvar_32 = tmpvar_31.x;
  atomosphere_26 = mix (mix (_ES_TopBackColor, _ES_TopFrontColor, vec4(tmpvar_29)).xyz, mix (_ES_BottomBackColor, _ES_BottomFrontColor, vec4(tmpvar_29)).xyz, vec3(tmpvar_32));
  mediump vec4 tmpvar_33;
  tmpvar_33.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_33.x = (abs(tmpvar_18.w) / max (_ES_HorizonHaloHeight, 0.0001));
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DLod (_SkyGradientTex, tmpvar_33.xy, 0.0);
  mediump float tmpvar_35;
  tmpvar_35 = tmpvar_34.y;
  mediump float tmpvar_36;
  tmpvar_36 = clamp (((
    max (((tmpvar_27 * 0.5) + 0.5), 0.0)
   - 0.3) / 0.7), 0.0, 1.0);
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    abs(_ES_SunDirection.y)
   - 0.2) / 0.3), 0.0, 1.0);
  atomosphere_26 = (atomosphere_26 + ((
    (_ES_HorizonHaloColor * _ES_HorizonHaloIntensity)
   * tmpvar_35) * mix (
    (tmpvar_36 * (tmpvar_36 * (3.0 - (2.0 * tmpvar_36))))
  , 1.0, 
    (tmpvar_37 * (tmpvar_37 * (3.0 - (2.0 * tmpvar_37))))
  )));
  highp vec3 viewDir_38;
  viewDir_38 = tmpvar_18.xyz;
  highp float haloInfluence_39;
  mediump float vertical_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((
    dot (_ES_SunDirection, viewDir_38)
   * 0.5) + 0.5), 0.0, 1.0);
  highp float tmpvar_42;
  tmpvar_42 = dot (viewDir_38, _ES_SkyWorldUpDir);
  vertical_40 = tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = abs(vertical_40);
  mediump float y_44;
  y_44 = (_ES_SunHaloSize * tmpvar_43);
  mediump float y_45;
  y_45 = ((_ES_SunHaloSize * 0.1) * tmpvar_43);
  haloInfluence_39 = (clamp (pow (tmpvar_41, y_44), 0.0, 1.0) + (clamp (
    pow (tmpvar_41, y_45)
  , 0.0, 1.0) * 0.12));
  mediump float y_46;
  y_46 = ((_ES_SunHaloSize * 0.01) * tmpvar_43);
  haloInfluence_39 = (haloInfluence_39 + (clamp (
    pow (tmpvar_41, y_46)
  , 0.0, 1.0) * 0.03));
  highp float tmpvar_47;
  tmpvar_47 = clamp (((
    max (((dot (_ES_SunDirection, viewDir_38) * 0.5) + 0.5), 0.0)
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 tmpvar_48;
  tmpvar_48 = (((haloInfluence_39 * _ES_SunHaloIntensity) * _ES_SunHaloColor) * (tmpvar_47 * (tmpvar_47 * 
    (3.0 - (2.0 * tmpvar_47))
  )));
  tmpvar_5 = (atomosphere_26 + tmpvar_48);
  mediump float tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_49 = (tmpvar_50 * (tmpvar_50 * (3.0 - 
    (2.0 * tmpvar_50)
  )));
  highp vec3 viewDir_51;
  viewDir_51 = tmpvar_18.xyz;
  mediump float moonLunarCancel_52;
  mediump float tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (_ES_MoonDirection, viewDir_51), 0.0, 1.0);
  tmpvar_53 = tmpvar_54;
  highp float tmpvar_55;
  mediump float tmpvar_56;
  tmpvar_56 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_55 = (1.0 - (tmpvar_56 * 2.0));
  moonLunarCancel_52 = tmpvar_55;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((
    ((tmpvar_53 * tmpvar_53) * ((tmpvar_53 * tmpvar_53) * tmpvar_53))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_58;
  viewDir_58 = tmpvar_18.xyz;
  mediump float vertical_59;
  mediump float tmpvar_60;
  highp float tmpvar_61;
  tmpvar_61 = clamp (((
    dot (_ES_SunDirection, viewDir_58)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_60 = tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = dot (viewDir_58, _ES_SkyWorldUpDir);
  vertical_59 = tmpvar_62;
  mediump float tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = (1.0 - _ES_SunRimLightRadius);
  tmpvar_63 = clamp (((tmpvar_20 - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (((tmpvar_63 * 
    (tmpvar_63 * (3.0 - (2.0 * tmpvar_63)))
  ) * _ES_SunBrightness) * 0.125);
  mediump float tmpvar_66;
  tmpvar_66 = clamp (((
    ((dot (viewDir_14, _ES_MoonDirection) * 0.5) + 0.5)
   - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_67;
  tmpvar_67 = (((tmpvar_66 * 
    (tmpvar_66 * (3.0 - (2.0 * tmpvar_66)))
  ) * _ES_MoonBrightness) * 0.1);
  mediump float tmpvar_68;
  tmpvar_68 = max (((tmpvar_19 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_69;
  tmpvar_69 = ((tmpvar_68 * tmpvar_68) * tmpvar_68);
  gl_Position = clipPos_6;
  xlv_TEXCOORD0 = o_9;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = (((
    ((((tmpvar_57 * 
      (tmpvar_57 * (3.0 - (2.0 * tmpvar_57)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_52) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_60, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_59))
    ) * vertical_59), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_49);
  xlv_TEXCOORD6 = (((_ES_SunHaloColor * 
    (tmpvar_65 * tmpvar_65)
  ) + (_ES_MoonColor * 
    (tmpvar_67 * tmpvar_67)
  )) * tmpvar_49);
  xlv_TEXCOORD7 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_69));
  xlv_TEXCOORD8 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_69));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_CloudCoverage;
uniform sampler2D _CloudParticleAtlas;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 cloudCol_1;
  mediump vec4 texCol_2;
  highp vec3 curlNoise_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_CloudCurlTex, xlv_TEXCOORD1.zw).xyz;
  curlNoise_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD1.xy + ((
    (curlNoise_3.xy - 0.5)
   * curlNoise_3.z) * _CloudCurlAmplitude));
  tmpvar_5 = texture2D (_CloudParticleAtlas, P_6);
  texCol_2 = tmpvar_5;
  mediump float tmpvar_7;
  tmpvar_7 = max ((xlv_TEXCOORD3.w - xlv_TEXCOORD3.y), 0.0);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.y), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD2.w - -0.1) / 0.2), 0.0, 1.0);
  cloudCol_1.w = ((texCol_2.w * (tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  )) * (tmpvar_9 * (tmpvar_9 * 
    (3.0 - (2.0 * tmpvar_9))
  )));
  mediump float x_10;
  x_10 = (cloudCol_1.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.z), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  cloudCol_1.xyz = ((mix (xlv_TEXCOORD8, xlv_TEXCOORD7, texCol_2.xxx) + (xlv_TEXCOORD6 * 
    mix (texCol_2.y, ((1.0 - (tmpvar_11 * 
      (tmpvar_11 * (3.0 - (2.0 * tmpvar_11)))
    )) * 4.0), xlv_TEXCOORD3.w)
  )) + ((0.4 * xlv_TEXCOORD7) * _ES_CloudCoverage));
  cloudCol_1.xyz = (cloudCol_1.xyz + (xlv_TEXCOORD5 * texCol_2.x));
  cloudCol_1.xyz = (cloudCol_1.xyz * (xlv_TEXCOORD3.x + 1.0));
  mediump float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD2.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((_ES_CloudCoverage - 0.4) / 0.3), 0.0, 1.0);
  cloudCol_1.xyz = mix (xlv_TEXCOORD4, cloudCol_1.xyz, vec3(mix (clamp (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
  , 0.0, 1.0), 1.0, (tmpvar_13 * 
    (tmpvar_13 * (3.0 - (2.0 * tmpvar_13)))
  ))));
  cloudCol_1.w = clamp (cloudCol_1.w, 0.0, 1.0);
  gl_FragData[0] = cloudCol_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FIXED_SPRITE_ID" "FIXED_RIMLIGHT_WIDTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec4 _ES_TopFrontColor;
uniform mediump vec4 _ES_TopBackColor;
uniform mediump vec4 _ES_BottomFrontColor;
uniform mediump vec4 _ES_BottomBackColor;
uniform mediump float _ES_SkyFrontAndBackBlendFactor;
uniform mediump float _ES_BottomColorHeight;
uniform mediump vec3 _ES_HorizonHaloColor;
uniform mediump float _ES_HorizonHaloIntensity;
uniform mediump float _ES_HorizonHaloHeight;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump float _ES_SunHaloSize;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudAgePercent;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform sampler2D _SkyGradientTex;
uniform highp vec2 _AtlasTiles;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
uniform highp int _FixedSpriteId;
uniform mediump float _FixedRimLightWidth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float agePercent_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 clipPos_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  clipPos_6.xyw = tmpvar_7.xyw;
  clipPos_6.z = tmpvar_7.w;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7.xyww * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = clipPos_6.zw;
  highp vec2 tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = float(_FixedSpriteId);
  tmpvar_12.x = (float(mod (tmpvar_13, _AtlasTiles.x)));
  tmpvar_12.y = floor((tmpvar_13 / _AtlasTiles.x));
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy + tmpvar_12) / _AtlasTiles);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _CloudCurlTiling) + ((_ES_CloudElapsedTime * vec2(1.2, 0.8)) * _CloudCurlSpeed));
  mediump vec3 viewDir_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(((unity_ObjectToWorld * tmpvar_15).xyz - _ES_SkyCenterWorldPos));
  viewDir_14 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (_ES_SkyWorldUpDir, viewDir_14);
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = viewDir_14;
  tmpvar_18.w = ((sign(tmpvar_17) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_17))) * (1.570796 + (abs(tmpvar_17) * (-0.2146018 + 
      (abs(tmpvar_17) * (0.08656672 + (abs(tmpvar_17) * -0.03102955)))
    ))))
  )) * 0.6366198);
  mediump float tmpvar_19;
  tmpvar_19 = dot (viewDir_14, _ES_SunDirection);
  mediump float tmpvar_20;
  tmpvar_20 = ((tmpvar_19 * 0.5) + 0.5);
  tmpvar_4.x = (tmpvar_20 * _ES_CloudSunBrightenIntensity);
  tmpvar_4.y = _glesColor.z;
  tmpvar_4.z = _FixedRimLightWidth;
  highp float tmpvar_21;
  tmpvar_21 = (_glesMultiTexCoord1.y / max (_glesMultiTexCoord1.x, 1e-05));
  agePercent_2 = tmpvar_21;
  agePercent_2 = (agePercent_2 * _ES_CloudAgePercent);
  highp float tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = clamp ((agePercent_2 / _glesMultiTexCoord1.z), 0.0, 1.0);
  tmpvar_22 = (tmpvar_23 * (tmpvar_23 * (3.0 - 
    (2.0 * tmpvar_23)
  )));
  highp float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((agePercent_2 - _glesMultiTexCoord1.w) / (1.0 - _glesMultiTexCoord1.w)), 0.0, 1.0);
  tmpvar_24 = (tmpvar_25 * (tmpvar_25 * (3.0 - 
    (2.0 * tmpvar_25)
  )));
  tmpvar_4.w = (1.0 - (tmpvar_22 * (1.0 - tmpvar_24)));
  mediump vec3 atomosphere_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (_ES_SunDirection, viewDir_14);
  mediump float tmpvar_28;
  tmpvar_28 = max (((tmpvar_27 * _ES_SkyFrontAndBackBlendFactor) + (1.0 - _ES_SkyFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_29;
  tmpvar_29 = ((tmpvar_28 * tmpvar_28) * tmpvar_28);
  mediump vec4 tmpvar_30;
  tmpvar_30.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_30.x = (abs(tmpvar_18.w) / max (_ES_BottomColorHeight, 0.0001));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DLod (_SkyGradientTex, tmpvar_30.xy, 0.0);
  mediump float tmpvar_32;
  tmpvar_32 = tmpvar_31.x;
  atomosphere_26 = mix (mix (_ES_TopBackColor, _ES_TopFrontColor, vec4(tmpvar_29)).xyz, mix (_ES_BottomBackColor, _ES_BottomFrontColor, vec4(tmpvar_29)).xyz, vec3(tmpvar_32));
  mediump vec4 tmpvar_33;
  tmpvar_33.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_33.x = (abs(tmpvar_18.w) / max (_ES_HorizonHaloHeight, 0.0001));
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DLod (_SkyGradientTex, tmpvar_33.xy, 0.0);
  mediump float tmpvar_35;
  tmpvar_35 = tmpvar_34.y;
  mediump float tmpvar_36;
  tmpvar_36 = clamp (((
    max (((tmpvar_27 * 0.5) + 0.5), 0.0)
   - 0.3) / 0.7), 0.0, 1.0);
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    abs(_ES_SunDirection.y)
   - 0.2) / 0.3), 0.0, 1.0);
  atomosphere_26 = (atomosphere_26 + ((
    (_ES_HorizonHaloColor * _ES_HorizonHaloIntensity)
   * tmpvar_35) * mix (
    (tmpvar_36 * (tmpvar_36 * (3.0 - (2.0 * tmpvar_36))))
  , 1.0, 
    (tmpvar_37 * (tmpvar_37 * (3.0 - (2.0 * tmpvar_37))))
  )));
  highp vec3 viewDir_38;
  viewDir_38 = tmpvar_18.xyz;
  highp float haloInfluence_39;
  mediump float vertical_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((
    dot (_ES_SunDirection, viewDir_38)
   * 0.5) + 0.5), 0.0, 1.0);
  highp float tmpvar_42;
  tmpvar_42 = dot (viewDir_38, _ES_SkyWorldUpDir);
  vertical_40 = tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = abs(vertical_40);
  mediump float y_44;
  y_44 = (_ES_SunHaloSize * tmpvar_43);
  mediump float y_45;
  y_45 = ((_ES_SunHaloSize * 0.1) * tmpvar_43);
  haloInfluence_39 = (clamp (pow (tmpvar_41, y_44), 0.0, 1.0) + (clamp (
    pow (tmpvar_41, y_45)
  , 0.0, 1.0) * 0.12));
  mediump float y_46;
  y_46 = ((_ES_SunHaloSize * 0.01) * tmpvar_43);
  haloInfluence_39 = (haloInfluence_39 + (clamp (
    pow (tmpvar_41, y_46)
  , 0.0, 1.0) * 0.03));
  highp float tmpvar_47;
  tmpvar_47 = clamp (((
    max (((dot (_ES_SunDirection, viewDir_38) * 0.5) + 0.5), 0.0)
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 tmpvar_48;
  tmpvar_48 = (((haloInfluence_39 * _ES_SunHaloIntensity) * _ES_SunHaloColor) * (tmpvar_47 * (tmpvar_47 * 
    (3.0 - (2.0 * tmpvar_47))
  )));
  tmpvar_5 = (atomosphere_26 + tmpvar_48);
  mediump float tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_49 = (tmpvar_50 * (tmpvar_50 * (3.0 - 
    (2.0 * tmpvar_50)
  )));
  highp vec3 viewDir_51;
  viewDir_51 = tmpvar_18.xyz;
  mediump float moonLunarCancel_52;
  mediump float tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (_ES_MoonDirection, viewDir_51), 0.0, 1.0);
  tmpvar_53 = tmpvar_54;
  highp float tmpvar_55;
  mediump float tmpvar_56;
  tmpvar_56 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_55 = (1.0 - (tmpvar_56 * 2.0));
  moonLunarCancel_52 = tmpvar_55;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((
    ((tmpvar_53 * tmpvar_53) * ((tmpvar_53 * tmpvar_53) * tmpvar_53))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_58;
  viewDir_58 = tmpvar_18.xyz;
  mediump float vertical_59;
  mediump float tmpvar_60;
  highp float tmpvar_61;
  tmpvar_61 = clamp (((
    dot (_ES_SunDirection, viewDir_58)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_60 = tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = dot (viewDir_58, _ES_SkyWorldUpDir);
  vertical_59 = tmpvar_62;
  mediump float tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = (1.0 - _ES_SunRimLightRadius);
  tmpvar_63 = clamp (((tmpvar_20 - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (((tmpvar_63 * 
    (tmpvar_63 * (3.0 - (2.0 * tmpvar_63)))
  ) * _ES_SunBrightness) * 0.125);
  mediump float tmpvar_66;
  tmpvar_66 = clamp (((
    ((dot (viewDir_14, _ES_MoonDirection) * 0.5) + 0.5)
   - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_67;
  tmpvar_67 = (((tmpvar_66 * 
    (tmpvar_66 * (3.0 - (2.0 * tmpvar_66)))
  ) * _ES_MoonBrightness) * 0.1);
  mediump float tmpvar_68;
  tmpvar_68 = max (((tmpvar_19 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_69;
  tmpvar_69 = ((tmpvar_68 * tmpvar_68) * tmpvar_68);
  gl_Position = clipPos_6;
  xlv_TEXCOORD0 = o_9;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = (((
    ((((tmpvar_57 * 
      (tmpvar_57 * (3.0 - (2.0 * tmpvar_57)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_52) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_60, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_59))
    ) * vertical_59), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_49);
  xlv_TEXCOORD6 = (((_ES_SunHaloColor * 
    (tmpvar_65 * tmpvar_65)
  ) + (_ES_MoonColor * 
    (tmpvar_67 * tmpvar_67)
  )) * tmpvar_49);
  xlv_TEXCOORD7 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_69));
  xlv_TEXCOORD8 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_69));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_CloudCoverage;
uniform sampler2D _CloudParticleAtlas;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 cloudCol_1;
  mediump vec4 texCol_2;
  highp vec3 curlNoise_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_CloudCurlTex, xlv_TEXCOORD1.zw).xyz;
  curlNoise_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD1.xy + ((
    (curlNoise_3.xy - 0.5)
   * curlNoise_3.z) * _CloudCurlAmplitude));
  tmpvar_5 = texture2D (_CloudParticleAtlas, P_6);
  texCol_2 = tmpvar_5;
  mediump float tmpvar_7;
  tmpvar_7 = max ((xlv_TEXCOORD3.w - xlv_TEXCOORD3.y), 0.0);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.y), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD2.w - -0.1) / 0.2), 0.0, 1.0);
  cloudCol_1.w = ((texCol_2.w * (tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  )) * (tmpvar_9 * (tmpvar_9 * 
    (3.0 - (2.0 * tmpvar_9))
  )));
  mediump float x_10;
  x_10 = (cloudCol_1.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.z), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  cloudCol_1.xyz = ((mix (xlv_TEXCOORD8, xlv_TEXCOORD7, texCol_2.xxx) + (xlv_TEXCOORD6 * 
    mix (texCol_2.y, ((1.0 - (tmpvar_11 * 
      (tmpvar_11 * (3.0 - (2.0 * tmpvar_11)))
    )) * 4.0), xlv_TEXCOORD3.w)
  )) + ((0.4 * xlv_TEXCOORD7) * _ES_CloudCoverage));
  cloudCol_1.xyz = (cloudCol_1.xyz + (xlv_TEXCOORD5 * texCol_2.x));
  cloudCol_1.xyz = (cloudCol_1.xyz * (xlv_TEXCOORD3.x + 1.0));
  mediump float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD2.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((_ES_CloudCoverage - 0.4) / 0.3), 0.0, 1.0);
  cloudCol_1.xyz = mix (xlv_TEXCOORD4, cloudCol_1.xyz, vec3(mix (clamp (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
  , 0.0, 1.0), 1.0, (tmpvar_13 * 
    (tmpvar_13 * (3.0 - (2.0 * tmpvar_13)))
  ))));
  cloudCol_1.w = clamp (cloudCol_1.w, 0.0, 1.0);
  gl_FragData[0] = cloudCol_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FIXED_SPRITE_ID" "FIXED_RIMLIGHT_WIDTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec4 _ES_TopFrontColor;
uniform mediump vec4 _ES_TopBackColor;
uniform mediump vec4 _ES_BottomFrontColor;
uniform mediump vec4 _ES_BottomBackColor;
uniform mediump float _ES_SkyFrontAndBackBlendFactor;
uniform mediump float _ES_BottomColorHeight;
uniform mediump vec3 _ES_HorizonHaloColor;
uniform mediump float _ES_HorizonHaloIntensity;
uniform mediump float _ES_HorizonHaloHeight;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump float _ES_SunHaloSize;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudAgePercent;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform sampler2D _SkyGradientTex;
uniform highp vec2 _AtlasTiles;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
uniform highp int _FixedSpriteId;
uniform mediump float _FixedRimLightWidth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float agePercent_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 clipPos_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  clipPos_6.xyw = tmpvar_7.xyw;
  clipPos_6.z = tmpvar_7.w;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7.xyww * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = clipPos_6.zw;
  highp vec2 tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = float(_FixedSpriteId);
  tmpvar_12.x = (float(mod (tmpvar_13, _AtlasTiles.x)));
  tmpvar_12.y = floor((tmpvar_13 / _AtlasTiles.x));
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy + tmpvar_12) / _AtlasTiles);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _CloudCurlTiling) + ((_ES_CloudElapsedTime * vec2(1.2, 0.8)) * _CloudCurlSpeed));
  mediump vec3 viewDir_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(((unity_ObjectToWorld * tmpvar_15).xyz - _ES_SkyCenterWorldPos));
  viewDir_14 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (_ES_SkyWorldUpDir, viewDir_14);
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = viewDir_14;
  tmpvar_18.w = ((sign(tmpvar_17) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_17))) * (1.570796 + (abs(tmpvar_17) * (-0.2146018 + 
      (abs(tmpvar_17) * (0.08656672 + (abs(tmpvar_17) * -0.03102955)))
    ))))
  )) * 0.6366198);
  mediump float tmpvar_19;
  tmpvar_19 = dot (viewDir_14, _ES_SunDirection);
  mediump float tmpvar_20;
  tmpvar_20 = ((tmpvar_19 * 0.5) + 0.5);
  tmpvar_4.x = (tmpvar_20 * _ES_CloudSunBrightenIntensity);
  tmpvar_4.y = _glesColor.z;
  tmpvar_4.z = _FixedRimLightWidth;
  highp float tmpvar_21;
  tmpvar_21 = (_glesMultiTexCoord1.y / max (_glesMultiTexCoord1.x, 1e-05));
  agePercent_2 = tmpvar_21;
  agePercent_2 = (agePercent_2 * _ES_CloudAgePercent);
  highp float tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = clamp ((agePercent_2 / _glesMultiTexCoord1.z), 0.0, 1.0);
  tmpvar_22 = (tmpvar_23 * (tmpvar_23 * (3.0 - 
    (2.0 * tmpvar_23)
  )));
  highp float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((agePercent_2 - _glesMultiTexCoord1.w) / (1.0 - _glesMultiTexCoord1.w)), 0.0, 1.0);
  tmpvar_24 = (tmpvar_25 * (tmpvar_25 * (3.0 - 
    (2.0 * tmpvar_25)
  )));
  tmpvar_4.w = (1.0 - (tmpvar_22 * (1.0 - tmpvar_24)));
  mediump vec3 atomosphere_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (_ES_SunDirection, viewDir_14);
  mediump float tmpvar_28;
  tmpvar_28 = max (((tmpvar_27 * _ES_SkyFrontAndBackBlendFactor) + (1.0 - _ES_SkyFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_29;
  tmpvar_29 = ((tmpvar_28 * tmpvar_28) * tmpvar_28);
  mediump vec4 tmpvar_30;
  tmpvar_30.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_30.x = (abs(tmpvar_18.w) / max (_ES_BottomColorHeight, 0.0001));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DLod (_SkyGradientTex, tmpvar_30.xy, 0.0);
  mediump float tmpvar_32;
  tmpvar_32 = tmpvar_31.x;
  atomosphere_26 = mix (mix (_ES_TopBackColor, _ES_TopFrontColor, vec4(tmpvar_29)).xyz, mix (_ES_BottomBackColor, _ES_BottomFrontColor, vec4(tmpvar_29)).xyz, vec3(tmpvar_32));
  mediump vec4 tmpvar_33;
  tmpvar_33.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_33.x = (abs(tmpvar_18.w) / max (_ES_HorizonHaloHeight, 0.0001));
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DLod (_SkyGradientTex, tmpvar_33.xy, 0.0);
  mediump float tmpvar_35;
  tmpvar_35 = tmpvar_34.y;
  mediump float tmpvar_36;
  tmpvar_36 = clamp (((
    max (((tmpvar_27 * 0.5) + 0.5), 0.0)
   - 0.3) / 0.7), 0.0, 1.0);
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    abs(_ES_SunDirection.y)
   - 0.2) / 0.3), 0.0, 1.0);
  atomosphere_26 = (atomosphere_26 + ((
    (_ES_HorizonHaloColor * _ES_HorizonHaloIntensity)
   * tmpvar_35) * mix (
    (tmpvar_36 * (tmpvar_36 * (3.0 - (2.0 * tmpvar_36))))
  , 1.0, 
    (tmpvar_37 * (tmpvar_37 * (3.0 - (2.0 * tmpvar_37))))
  )));
  highp vec3 viewDir_38;
  viewDir_38 = tmpvar_18.xyz;
  highp float haloInfluence_39;
  mediump float vertical_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((
    dot (_ES_SunDirection, viewDir_38)
   * 0.5) + 0.5), 0.0, 1.0);
  highp float tmpvar_42;
  tmpvar_42 = dot (viewDir_38, _ES_SkyWorldUpDir);
  vertical_40 = tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = abs(vertical_40);
  mediump float y_44;
  y_44 = (_ES_SunHaloSize * tmpvar_43);
  mediump float y_45;
  y_45 = ((_ES_SunHaloSize * 0.1) * tmpvar_43);
  haloInfluence_39 = (clamp (pow (tmpvar_41, y_44), 0.0, 1.0) + (clamp (
    pow (tmpvar_41, y_45)
  , 0.0, 1.0) * 0.12));
  mediump float y_46;
  y_46 = ((_ES_SunHaloSize * 0.01) * tmpvar_43);
  haloInfluence_39 = (haloInfluence_39 + (clamp (
    pow (tmpvar_41, y_46)
  , 0.0, 1.0) * 0.03));
  highp float tmpvar_47;
  tmpvar_47 = clamp (((
    max (((dot (_ES_SunDirection, viewDir_38) * 0.5) + 0.5), 0.0)
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 tmpvar_48;
  tmpvar_48 = (((haloInfluence_39 * _ES_SunHaloIntensity) * _ES_SunHaloColor) * (tmpvar_47 * (tmpvar_47 * 
    (3.0 - (2.0 * tmpvar_47))
  )));
  tmpvar_5 = (atomosphere_26 + tmpvar_48);
  mediump float tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_49 = (tmpvar_50 * (tmpvar_50 * (3.0 - 
    (2.0 * tmpvar_50)
  )));
  highp vec3 viewDir_51;
  viewDir_51 = tmpvar_18.xyz;
  mediump float moonLunarCancel_52;
  mediump float tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (_ES_MoonDirection, viewDir_51), 0.0, 1.0);
  tmpvar_53 = tmpvar_54;
  highp float tmpvar_55;
  mediump float tmpvar_56;
  tmpvar_56 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_55 = (1.0 - (tmpvar_56 * 2.0));
  moonLunarCancel_52 = tmpvar_55;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((
    ((tmpvar_53 * tmpvar_53) * ((tmpvar_53 * tmpvar_53) * tmpvar_53))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_58;
  viewDir_58 = tmpvar_18.xyz;
  mediump float vertical_59;
  mediump float tmpvar_60;
  highp float tmpvar_61;
  tmpvar_61 = clamp (((
    dot (_ES_SunDirection, viewDir_58)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_60 = tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = dot (viewDir_58, _ES_SkyWorldUpDir);
  vertical_59 = tmpvar_62;
  mediump float tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = (1.0 - _ES_SunRimLightRadius);
  tmpvar_63 = clamp (((tmpvar_20 - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (((tmpvar_63 * 
    (tmpvar_63 * (3.0 - (2.0 * tmpvar_63)))
  ) * _ES_SunBrightness) * 0.125);
  mediump float tmpvar_66;
  tmpvar_66 = clamp (((
    ((dot (viewDir_14, _ES_MoonDirection) * 0.5) + 0.5)
   - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_67;
  tmpvar_67 = (((tmpvar_66 * 
    (tmpvar_66 * (3.0 - (2.0 * tmpvar_66)))
  ) * _ES_MoonBrightness) * 0.1);
  mediump float tmpvar_68;
  tmpvar_68 = max (((tmpvar_19 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_69;
  tmpvar_69 = ((tmpvar_68 * tmpvar_68) * tmpvar_68);
  gl_Position = clipPos_6;
  xlv_TEXCOORD0 = o_9;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = (((
    ((((tmpvar_57 * 
      (tmpvar_57 * (3.0 - (2.0 * tmpvar_57)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_52) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_60, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_59))
    ) * vertical_59), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_49);
  xlv_TEXCOORD6 = (((_ES_SunHaloColor * 
    (tmpvar_65 * tmpvar_65)
  ) + (_ES_MoonColor * 
    (tmpvar_67 * tmpvar_67)
  )) * tmpvar_49);
  xlv_TEXCOORD7 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_69));
  xlv_TEXCOORD8 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_69));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_CloudCoverage;
uniform sampler2D _CloudParticleAtlas;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 cloudCol_1;
  mediump vec4 texCol_2;
  highp vec3 curlNoise_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_CloudCurlTex, xlv_TEXCOORD1.zw).xyz;
  curlNoise_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD1.xy + ((
    (curlNoise_3.xy - 0.5)
   * curlNoise_3.z) * _CloudCurlAmplitude));
  tmpvar_5 = texture2D (_CloudParticleAtlas, P_6);
  texCol_2 = tmpvar_5;
  mediump float tmpvar_7;
  tmpvar_7 = max ((xlv_TEXCOORD3.w - xlv_TEXCOORD3.y), 0.0);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.y), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD2.w - -0.1) / 0.2), 0.0, 1.0);
  cloudCol_1.w = ((texCol_2.w * (tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  )) * (tmpvar_9 * (tmpvar_9 * 
    (3.0 - (2.0 * tmpvar_9))
  )));
  mediump float x_10;
  x_10 = (cloudCol_1.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.z), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  cloudCol_1.xyz = ((mix (xlv_TEXCOORD8, xlv_TEXCOORD7, texCol_2.xxx) + (xlv_TEXCOORD6 * 
    mix (texCol_2.y, ((1.0 - (tmpvar_11 * 
      (tmpvar_11 * (3.0 - (2.0 * tmpvar_11)))
    )) * 4.0), xlv_TEXCOORD3.w)
  )) + ((0.4 * xlv_TEXCOORD7) * _ES_CloudCoverage));
  cloudCol_1.xyz = (cloudCol_1.xyz + (xlv_TEXCOORD5 * texCol_2.x));
  cloudCol_1.xyz = (cloudCol_1.xyz * (xlv_TEXCOORD3.x + 1.0));
  mediump float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD2.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((_ES_CloudCoverage - 0.4) / 0.3), 0.0, 1.0);
  cloudCol_1.xyz = mix (xlv_TEXCOORD4, cloudCol_1.xyz, vec3(mix (clamp (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
  , 0.0, 1.0), 1.0, (tmpvar_13 * 
    (tmpvar_13 * (3.0 - (2.0 * tmpvar_13)))
  ))));
  cloudCol_1.w = clamp (cloudCol_1.w, 0.0, 1.0);
  gl_FragData[0] = cloudCol_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "FIXED_SPRITE_ID" "FIXED_RIMLIGHT_WIDTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec4 _ES_TopFrontColor;
uniform mediump vec4 _ES_TopBackColor;
uniform mediump vec4 _ES_BottomFrontColor;
uniform mediump vec4 _ES_BottomBackColor;
uniform mediump float _ES_SkyFrontAndBackBlendFactor;
uniform mediump float _ES_BottomColorHeight;
uniform mediump vec3 _ES_HorizonHaloColor;
uniform mediump float _ES_HorizonHaloIntensity;
uniform mediump float _ES_HorizonHaloHeight;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump float _ES_SunHaloSize;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudAgePercent;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform sampler2D _SkyGradientTex;
uniform highp vec2 _AtlasTiles;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
uniform highp int _FixedSpriteId;
uniform mediump float _FixedRimLightWidth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float agePercent_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 clipPos_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  clipPos_6.xyw = tmpvar_7.xyw;
  clipPos_6.z = tmpvar_7.w;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7.xyww * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = clipPos_6.zw;
  highp vec2 tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = float(_FixedSpriteId);
  tmpvar_12.x = (float(mod (tmpvar_13, _AtlasTiles.x)));
  tmpvar_12.y = floor((tmpvar_13 / _AtlasTiles.x));
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy + tmpvar_12) / _AtlasTiles);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _CloudCurlTiling) + ((_ES_CloudElapsedTime * vec2(1.2, 0.8)) * _CloudCurlSpeed));
  mediump vec3 viewDir_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(((unity_ObjectToWorld * tmpvar_15).xyz - _ES_SkyCenterWorldPos));
  viewDir_14 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (_ES_SkyWorldUpDir, viewDir_14);
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = viewDir_14;
  tmpvar_18.w = ((sign(tmpvar_17) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_17))) * (1.570796 + (abs(tmpvar_17) * (-0.2146018 + 
      (abs(tmpvar_17) * (0.08656672 + (abs(tmpvar_17) * -0.03102955)))
    ))))
  )) * 0.6366198);
  mediump float tmpvar_19;
  tmpvar_19 = dot (viewDir_14, _ES_SunDirection);
  mediump float tmpvar_20;
  tmpvar_20 = ((tmpvar_19 * 0.5) + 0.5);
  tmpvar_4.x = (tmpvar_20 * _ES_CloudSunBrightenIntensity);
  tmpvar_4.y = _glesColor.z;
  tmpvar_4.z = _FixedRimLightWidth;
  highp float tmpvar_21;
  tmpvar_21 = (_glesMultiTexCoord1.y / max (_glesMultiTexCoord1.x, 1e-05));
  agePercent_2 = tmpvar_21;
  agePercent_2 = (agePercent_2 * _ES_CloudAgePercent);
  highp float tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = clamp ((agePercent_2 / _glesMultiTexCoord1.z), 0.0, 1.0);
  tmpvar_22 = (tmpvar_23 * (tmpvar_23 * (3.0 - 
    (2.0 * tmpvar_23)
  )));
  highp float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((agePercent_2 - _glesMultiTexCoord1.w) / (1.0 - _glesMultiTexCoord1.w)), 0.0, 1.0);
  tmpvar_24 = (tmpvar_25 * (tmpvar_25 * (3.0 - 
    (2.0 * tmpvar_25)
  )));
  tmpvar_4.w = (1.0 - (tmpvar_22 * (1.0 - tmpvar_24)));
  mediump vec3 atomosphere_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (_ES_SunDirection, viewDir_14);
  mediump float tmpvar_28;
  tmpvar_28 = max (((tmpvar_27 * _ES_SkyFrontAndBackBlendFactor) + (1.0 - _ES_SkyFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_29;
  tmpvar_29 = ((tmpvar_28 * tmpvar_28) * tmpvar_28);
  mediump vec4 tmpvar_30;
  tmpvar_30.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_30.x = (abs(tmpvar_18.w) / max (_ES_BottomColorHeight, 0.0001));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DLod (_SkyGradientTex, tmpvar_30.xy, 0.0);
  mediump float tmpvar_32;
  tmpvar_32 = tmpvar_31.x;
  atomosphere_26 = mix (mix (_ES_TopBackColor, _ES_TopFrontColor, vec4(tmpvar_29)).xyz, mix (_ES_BottomBackColor, _ES_BottomFrontColor, vec4(tmpvar_29)).xyz, vec3(tmpvar_32));
  mediump vec4 tmpvar_33;
  tmpvar_33.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_33.x = (abs(tmpvar_18.w) / max (_ES_HorizonHaloHeight, 0.0001));
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DLod (_SkyGradientTex, tmpvar_33.xy, 0.0);
  mediump float tmpvar_35;
  tmpvar_35 = tmpvar_34.y;
  mediump float tmpvar_36;
  tmpvar_36 = clamp (((
    max (((tmpvar_27 * 0.5) + 0.5), 0.0)
   - 0.3) / 0.7), 0.0, 1.0);
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    abs(_ES_SunDirection.y)
   - 0.2) / 0.3), 0.0, 1.0);
  atomosphere_26 = (atomosphere_26 + ((
    (_ES_HorizonHaloColor * _ES_HorizonHaloIntensity)
   * tmpvar_35) * mix (
    (tmpvar_36 * (tmpvar_36 * (3.0 - (2.0 * tmpvar_36))))
  , 1.0, 
    (tmpvar_37 * (tmpvar_37 * (3.0 - (2.0 * tmpvar_37))))
  )));
  highp vec3 viewDir_38;
  viewDir_38 = tmpvar_18.xyz;
  highp float haloInfluence_39;
  mediump float vertical_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((
    dot (_ES_SunDirection, viewDir_38)
   * 0.5) + 0.5), 0.0, 1.0);
  highp float tmpvar_42;
  tmpvar_42 = dot (viewDir_38, _ES_SkyWorldUpDir);
  vertical_40 = tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = abs(vertical_40);
  mediump float y_44;
  y_44 = (_ES_SunHaloSize * tmpvar_43);
  mediump float y_45;
  y_45 = ((_ES_SunHaloSize * 0.1) * tmpvar_43);
  haloInfluence_39 = (clamp (pow (tmpvar_41, y_44), 0.0, 1.0) + (clamp (
    pow (tmpvar_41, y_45)
  , 0.0, 1.0) * 0.12));
  mediump float y_46;
  y_46 = ((_ES_SunHaloSize * 0.01) * tmpvar_43);
  haloInfluence_39 = (haloInfluence_39 + (clamp (
    pow (tmpvar_41, y_46)
  , 0.0, 1.0) * 0.03));
  highp float tmpvar_47;
  tmpvar_47 = clamp (((
    max (((dot (_ES_SunDirection, viewDir_38) * 0.5) + 0.5), 0.0)
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 tmpvar_48;
  tmpvar_48 = (((haloInfluence_39 * _ES_SunHaloIntensity) * _ES_SunHaloColor) * (tmpvar_47 * (tmpvar_47 * 
    (3.0 - (2.0 * tmpvar_47))
  )));
  tmpvar_5 = (atomosphere_26 + tmpvar_48);
  mediump float tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_49 = (tmpvar_50 * (tmpvar_50 * (3.0 - 
    (2.0 * tmpvar_50)
  )));
  highp vec3 viewDir_51;
  viewDir_51 = tmpvar_18.xyz;
  mediump float moonLunarCancel_52;
  mediump float tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (_ES_MoonDirection, viewDir_51), 0.0, 1.0);
  tmpvar_53 = tmpvar_54;
  highp float tmpvar_55;
  mediump float tmpvar_56;
  tmpvar_56 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_55 = (1.0 - (tmpvar_56 * 2.0));
  moonLunarCancel_52 = tmpvar_55;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((
    ((tmpvar_53 * tmpvar_53) * ((tmpvar_53 * tmpvar_53) * tmpvar_53))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_58;
  viewDir_58 = tmpvar_18.xyz;
  mediump float vertical_59;
  mediump float tmpvar_60;
  highp float tmpvar_61;
  tmpvar_61 = clamp (((
    dot (_ES_SunDirection, viewDir_58)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_60 = tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = dot (viewDir_58, _ES_SkyWorldUpDir);
  vertical_59 = tmpvar_62;
  mediump float tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = (1.0 - _ES_SunRimLightRadius);
  tmpvar_63 = clamp (((tmpvar_20 - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (((tmpvar_63 * 
    (tmpvar_63 * (3.0 - (2.0 * tmpvar_63)))
  ) * _ES_SunBrightness) * 0.125);
  mediump float tmpvar_66;
  tmpvar_66 = clamp (((
    ((dot (viewDir_14, _ES_MoonDirection) * 0.5) + 0.5)
   - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_67;
  tmpvar_67 = (((tmpvar_66 * 
    (tmpvar_66 * (3.0 - (2.0 * tmpvar_66)))
  ) * _ES_MoonBrightness) * 0.1);
  mediump float tmpvar_68;
  tmpvar_68 = max (((tmpvar_19 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_69;
  tmpvar_69 = ((tmpvar_68 * tmpvar_68) * tmpvar_68);
  gl_Position = clipPos_6;
  xlv_TEXCOORD0 = o_9;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = (((
    ((((tmpvar_57 * 
      (tmpvar_57 * (3.0 - (2.0 * tmpvar_57)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_52) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_60, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_59))
    ) * vertical_59), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_49);
  xlv_TEXCOORD6 = (((_ES_SunHaloColor * 
    (tmpvar_65 * tmpvar_65)
  ) + (_ES_MoonColor * 
    (tmpvar_67 * tmpvar_67)
  )) * tmpvar_49);
  xlv_TEXCOORD7 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_69));
  xlv_TEXCOORD8 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_69));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_CloudCoverage;
uniform sampler2D _CloudParticleAtlas;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 cloudCol_1;
  mediump vec4 texCol_2;
  highp vec3 curlNoise_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_CloudCurlTex, xlv_TEXCOORD1.zw).xyz;
  curlNoise_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD1.xy + ((
    (curlNoise_3.xy - 0.5)
   * curlNoise_3.z) * _CloudCurlAmplitude));
  tmpvar_5 = texture2D (_CloudParticleAtlas, P_6);
  texCol_2 = tmpvar_5;
  mediump float tmpvar_7;
  tmpvar_7 = max ((xlv_TEXCOORD3.w - xlv_TEXCOORD3.y), 0.0);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.y), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD2.w - -0.1) / 0.2), 0.0, 1.0);
  cloudCol_1.w = ((texCol_2.w * (tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  )) * (tmpvar_9 * (tmpvar_9 * 
    (3.0 - (2.0 * tmpvar_9))
  )));
  mediump float x_10;
  x_10 = (cloudCol_1.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.z), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  cloudCol_1.xyz = ((mix (xlv_TEXCOORD8, xlv_TEXCOORD7, texCol_2.xxx) + (xlv_TEXCOORD6 * 
    mix (texCol_2.y, ((1.0 - (tmpvar_11 * 
      (tmpvar_11 * (3.0 - (2.0 * tmpvar_11)))
    )) * 4.0), xlv_TEXCOORD3.w)
  )) + ((0.4 * xlv_TEXCOORD7) * _ES_CloudCoverage));
  cloudCol_1.xyz = (cloudCol_1.xyz + (xlv_TEXCOORD5 * texCol_2.x));
  cloudCol_1.xyz = (cloudCol_1.xyz * (xlv_TEXCOORD3.x + 1.0));
  mediump float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD2.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((_ES_CloudCoverage - 0.4) / 0.3), 0.0, 1.0);
  cloudCol_1.xyz = mix (xlv_TEXCOORD4, cloudCol_1.xyz, vec3(mix (clamp (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
  , 0.0, 1.0), 1.0, (tmpvar_13 * 
    (tmpvar_13 * (3.0 - (2.0 * tmpvar_13)))
  ))));
  cloudCol_1.w = clamp (cloudCol_1.w, 0.0, 1.0);
  gl_FragData[0] = cloudCol_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "FIXED_SPRITE_ID" "FIXED_RIMLIGHT_WIDTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec4 _ES_TopFrontColor;
uniform mediump vec4 _ES_TopBackColor;
uniform mediump vec4 _ES_BottomFrontColor;
uniform mediump vec4 _ES_BottomBackColor;
uniform mediump float _ES_SkyFrontAndBackBlendFactor;
uniform mediump float _ES_BottomColorHeight;
uniform mediump vec3 _ES_HorizonHaloColor;
uniform mediump float _ES_HorizonHaloIntensity;
uniform mediump float _ES_HorizonHaloHeight;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump float _ES_SunHaloSize;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudAgePercent;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform sampler2D _SkyGradientTex;
uniform highp vec2 _AtlasTiles;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
uniform highp int _FixedSpriteId;
uniform mediump float _FixedRimLightWidth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float agePercent_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 clipPos_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  clipPos_6.xyw = tmpvar_7.xyw;
  clipPos_6.z = tmpvar_7.w;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7.xyww * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = clipPos_6.zw;
  highp vec2 tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = float(_FixedSpriteId);
  tmpvar_12.x = (float(mod (tmpvar_13, _AtlasTiles.x)));
  tmpvar_12.y = floor((tmpvar_13 / _AtlasTiles.x));
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy + tmpvar_12) / _AtlasTiles);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _CloudCurlTiling) + ((_ES_CloudElapsedTime * vec2(1.2, 0.8)) * _CloudCurlSpeed));
  mediump vec3 viewDir_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(((unity_ObjectToWorld * tmpvar_15).xyz - _ES_SkyCenterWorldPos));
  viewDir_14 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (_ES_SkyWorldUpDir, viewDir_14);
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = viewDir_14;
  tmpvar_18.w = ((sign(tmpvar_17) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_17))) * (1.570796 + (abs(tmpvar_17) * (-0.2146018 + 
      (abs(tmpvar_17) * (0.08656672 + (abs(tmpvar_17) * -0.03102955)))
    ))))
  )) * 0.6366198);
  mediump float tmpvar_19;
  tmpvar_19 = dot (viewDir_14, _ES_SunDirection);
  mediump float tmpvar_20;
  tmpvar_20 = ((tmpvar_19 * 0.5) + 0.5);
  tmpvar_4.x = (tmpvar_20 * _ES_CloudSunBrightenIntensity);
  tmpvar_4.y = _glesColor.z;
  tmpvar_4.z = _FixedRimLightWidth;
  highp float tmpvar_21;
  tmpvar_21 = (_glesMultiTexCoord1.y / max (_glesMultiTexCoord1.x, 1e-05));
  agePercent_2 = tmpvar_21;
  agePercent_2 = (agePercent_2 * _ES_CloudAgePercent);
  highp float tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = clamp ((agePercent_2 / _glesMultiTexCoord1.z), 0.0, 1.0);
  tmpvar_22 = (tmpvar_23 * (tmpvar_23 * (3.0 - 
    (2.0 * tmpvar_23)
  )));
  highp float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((agePercent_2 - _glesMultiTexCoord1.w) / (1.0 - _glesMultiTexCoord1.w)), 0.0, 1.0);
  tmpvar_24 = (tmpvar_25 * (tmpvar_25 * (3.0 - 
    (2.0 * tmpvar_25)
  )));
  tmpvar_4.w = (1.0 - (tmpvar_22 * (1.0 - tmpvar_24)));
  mediump vec3 atomosphere_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (_ES_SunDirection, viewDir_14);
  mediump float tmpvar_28;
  tmpvar_28 = max (((tmpvar_27 * _ES_SkyFrontAndBackBlendFactor) + (1.0 - _ES_SkyFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_29;
  tmpvar_29 = ((tmpvar_28 * tmpvar_28) * tmpvar_28);
  mediump vec4 tmpvar_30;
  tmpvar_30.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_30.x = (abs(tmpvar_18.w) / max (_ES_BottomColorHeight, 0.0001));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DLod (_SkyGradientTex, tmpvar_30.xy, 0.0);
  mediump float tmpvar_32;
  tmpvar_32 = tmpvar_31.x;
  atomosphere_26 = mix (mix (_ES_TopBackColor, _ES_TopFrontColor, vec4(tmpvar_29)).xyz, mix (_ES_BottomBackColor, _ES_BottomFrontColor, vec4(tmpvar_29)).xyz, vec3(tmpvar_32));
  mediump vec4 tmpvar_33;
  tmpvar_33.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_33.x = (abs(tmpvar_18.w) / max (_ES_HorizonHaloHeight, 0.0001));
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DLod (_SkyGradientTex, tmpvar_33.xy, 0.0);
  mediump float tmpvar_35;
  tmpvar_35 = tmpvar_34.y;
  mediump float tmpvar_36;
  tmpvar_36 = clamp (((
    max (((tmpvar_27 * 0.5) + 0.5), 0.0)
   - 0.3) / 0.7), 0.0, 1.0);
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    abs(_ES_SunDirection.y)
   - 0.2) / 0.3), 0.0, 1.0);
  atomosphere_26 = (atomosphere_26 + ((
    (_ES_HorizonHaloColor * _ES_HorizonHaloIntensity)
   * tmpvar_35) * mix (
    (tmpvar_36 * (tmpvar_36 * (3.0 - (2.0 * tmpvar_36))))
  , 1.0, 
    (tmpvar_37 * (tmpvar_37 * (3.0 - (2.0 * tmpvar_37))))
  )));
  highp vec3 viewDir_38;
  viewDir_38 = tmpvar_18.xyz;
  highp float haloInfluence_39;
  mediump float vertical_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((
    dot (_ES_SunDirection, viewDir_38)
   * 0.5) + 0.5), 0.0, 1.0);
  highp float tmpvar_42;
  tmpvar_42 = dot (viewDir_38, _ES_SkyWorldUpDir);
  vertical_40 = tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = abs(vertical_40);
  mediump float y_44;
  y_44 = (_ES_SunHaloSize * tmpvar_43);
  mediump float y_45;
  y_45 = ((_ES_SunHaloSize * 0.1) * tmpvar_43);
  haloInfluence_39 = (clamp (pow (tmpvar_41, y_44), 0.0, 1.0) + (clamp (
    pow (tmpvar_41, y_45)
  , 0.0, 1.0) * 0.12));
  mediump float y_46;
  y_46 = ((_ES_SunHaloSize * 0.01) * tmpvar_43);
  haloInfluence_39 = (haloInfluence_39 + (clamp (
    pow (tmpvar_41, y_46)
  , 0.0, 1.0) * 0.03));
  highp float tmpvar_47;
  tmpvar_47 = clamp (((
    max (((dot (_ES_SunDirection, viewDir_38) * 0.5) + 0.5), 0.0)
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 tmpvar_48;
  tmpvar_48 = (((haloInfluence_39 * _ES_SunHaloIntensity) * _ES_SunHaloColor) * (tmpvar_47 * (tmpvar_47 * 
    (3.0 - (2.0 * tmpvar_47))
  )));
  tmpvar_5 = (atomosphere_26 + tmpvar_48);
  mediump float tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_49 = (tmpvar_50 * (tmpvar_50 * (3.0 - 
    (2.0 * tmpvar_50)
  )));
  highp vec3 viewDir_51;
  viewDir_51 = tmpvar_18.xyz;
  mediump float moonLunarCancel_52;
  mediump float tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (_ES_MoonDirection, viewDir_51), 0.0, 1.0);
  tmpvar_53 = tmpvar_54;
  highp float tmpvar_55;
  mediump float tmpvar_56;
  tmpvar_56 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_55 = (1.0 - (tmpvar_56 * 2.0));
  moonLunarCancel_52 = tmpvar_55;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((
    ((tmpvar_53 * tmpvar_53) * ((tmpvar_53 * tmpvar_53) * tmpvar_53))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_58;
  viewDir_58 = tmpvar_18.xyz;
  mediump float vertical_59;
  mediump float tmpvar_60;
  highp float tmpvar_61;
  tmpvar_61 = clamp (((
    dot (_ES_SunDirection, viewDir_58)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_60 = tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = dot (viewDir_58, _ES_SkyWorldUpDir);
  vertical_59 = tmpvar_62;
  mediump float tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = (1.0 - _ES_SunRimLightRadius);
  tmpvar_63 = clamp (((tmpvar_20 - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (((tmpvar_63 * 
    (tmpvar_63 * (3.0 - (2.0 * tmpvar_63)))
  ) * _ES_SunBrightness) * 0.125);
  mediump float tmpvar_66;
  tmpvar_66 = clamp (((
    ((dot (viewDir_14, _ES_MoonDirection) * 0.5) + 0.5)
   - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_67;
  tmpvar_67 = (((tmpvar_66 * 
    (tmpvar_66 * (3.0 - (2.0 * tmpvar_66)))
  ) * _ES_MoonBrightness) * 0.1);
  mediump float tmpvar_68;
  tmpvar_68 = max (((tmpvar_19 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_69;
  tmpvar_69 = ((tmpvar_68 * tmpvar_68) * tmpvar_68);
  gl_Position = clipPos_6;
  xlv_TEXCOORD0 = o_9;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = (((
    ((((tmpvar_57 * 
      (tmpvar_57 * (3.0 - (2.0 * tmpvar_57)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_52) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_60, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_59))
    ) * vertical_59), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_49);
  xlv_TEXCOORD6 = (((_ES_SunHaloColor * 
    (tmpvar_65 * tmpvar_65)
  ) + (_ES_MoonColor * 
    (tmpvar_67 * tmpvar_67)
  )) * tmpvar_49);
  xlv_TEXCOORD7 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_69));
  xlv_TEXCOORD8 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_69));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_CloudCoverage;
uniform sampler2D _CloudParticleAtlas;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 cloudCol_1;
  mediump vec4 texCol_2;
  highp vec3 curlNoise_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_CloudCurlTex, xlv_TEXCOORD1.zw).xyz;
  curlNoise_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD1.xy + ((
    (curlNoise_3.xy - 0.5)
   * curlNoise_3.z) * _CloudCurlAmplitude));
  tmpvar_5 = texture2D (_CloudParticleAtlas, P_6);
  texCol_2 = tmpvar_5;
  mediump float tmpvar_7;
  tmpvar_7 = max ((xlv_TEXCOORD3.w - xlv_TEXCOORD3.y), 0.0);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.y), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD2.w - -0.1) / 0.2), 0.0, 1.0);
  cloudCol_1.w = ((texCol_2.w * (tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  )) * (tmpvar_9 * (tmpvar_9 * 
    (3.0 - (2.0 * tmpvar_9))
  )));
  mediump float x_10;
  x_10 = (cloudCol_1.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.z), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  cloudCol_1.xyz = ((mix (xlv_TEXCOORD8, xlv_TEXCOORD7, texCol_2.xxx) + (xlv_TEXCOORD6 * 
    mix (texCol_2.y, ((1.0 - (tmpvar_11 * 
      (tmpvar_11 * (3.0 - (2.0 * tmpvar_11)))
    )) * 4.0), xlv_TEXCOORD3.w)
  )) + ((0.4 * xlv_TEXCOORD7) * _ES_CloudCoverage));
  cloudCol_1.xyz = (cloudCol_1.xyz + (xlv_TEXCOORD5 * texCol_2.x));
  cloudCol_1.xyz = (cloudCol_1.xyz * (xlv_TEXCOORD3.x + 1.0));
  mediump float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD2.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((_ES_CloudCoverage - 0.4) / 0.3), 0.0, 1.0);
  cloudCol_1.xyz = mix (xlv_TEXCOORD4, cloudCol_1.xyz, vec3(mix (clamp (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
  , 0.0, 1.0), 1.0, (tmpvar_13 * 
    (tmpvar_13 * (3.0 - (2.0 * tmpvar_13)))
  ))));
  cloudCol_1.w = clamp (cloudCol_1.w, 0.0, 1.0);
  gl_FragData[0] = cloudCol_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "FIXED_SPRITE_ID" "FIXED_RIMLIGHT_WIDTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec4 _ES_TopFrontColor;
uniform mediump vec4 _ES_TopBackColor;
uniform mediump vec4 _ES_BottomFrontColor;
uniform mediump vec4 _ES_BottomBackColor;
uniform mediump float _ES_SkyFrontAndBackBlendFactor;
uniform mediump float _ES_BottomColorHeight;
uniform mediump vec3 _ES_HorizonHaloColor;
uniform mediump float _ES_HorizonHaloIntensity;
uniform mediump float _ES_HorizonHaloHeight;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump float _ES_SunHaloSize;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudAgePercent;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform sampler2D _SkyGradientTex;
uniform highp vec2 _AtlasTiles;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
uniform highp int _FixedSpriteId;
uniform mediump float _FixedRimLightWidth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float agePercent_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 clipPos_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  clipPos_6.xyw = tmpvar_7.xyw;
  clipPos_6.z = tmpvar_7.w;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7.xyww * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = clipPos_6.zw;
  highp vec2 tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = float(_FixedSpriteId);
  tmpvar_12.x = (float(mod (tmpvar_13, _AtlasTiles.x)));
  tmpvar_12.y = floor((tmpvar_13 / _AtlasTiles.x));
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy + tmpvar_12) / _AtlasTiles);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _CloudCurlTiling) + ((_ES_CloudElapsedTime * vec2(1.2, 0.8)) * _CloudCurlSpeed));
  mediump vec3 viewDir_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(((unity_ObjectToWorld * tmpvar_15).xyz - _ES_SkyCenterWorldPos));
  viewDir_14 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (_ES_SkyWorldUpDir, viewDir_14);
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = viewDir_14;
  tmpvar_18.w = ((sign(tmpvar_17) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_17))) * (1.570796 + (abs(tmpvar_17) * (-0.2146018 + 
      (abs(tmpvar_17) * (0.08656672 + (abs(tmpvar_17) * -0.03102955)))
    ))))
  )) * 0.6366198);
  mediump float tmpvar_19;
  tmpvar_19 = dot (viewDir_14, _ES_SunDirection);
  mediump float tmpvar_20;
  tmpvar_20 = ((tmpvar_19 * 0.5) + 0.5);
  tmpvar_4.x = (tmpvar_20 * _ES_CloudSunBrightenIntensity);
  tmpvar_4.y = _glesColor.z;
  tmpvar_4.z = _FixedRimLightWidth;
  highp float tmpvar_21;
  tmpvar_21 = (_glesMultiTexCoord1.y / max (_glesMultiTexCoord1.x, 1e-05));
  agePercent_2 = tmpvar_21;
  agePercent_2 = (agePercent_2 * _ES_CloudAgePercent);
  highp float tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = clamp ((agePercent_2 / _glesMultiTexCoord1.z), 0.0, 1.0);
  tmpvar_22 = (tmpvar_23 * (tmpvar_23 * (3.0 - 
    (2.0 * tmpvar_23)
  )));
  highp float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((agePercent_2 - _glesMultiTexCoord1.w) / (1.0 - _glesMultiTexCoord1.w)), 0.0, 1.0);
  tmpvar_24 = (tmpvar_25 * (tmpvar_25 * (3.0 - 
    (2.0 * tmpvar_25)
  )));
  tmpvar_4.w = (1.0 - (tmpvar_22 * (1.0 - tmpvar_24)));
  mediump vec3 atomosphere_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (_ES_SunDirection, viewDir_14);
  mediump float tmpvar_28;
  tmpvar_28 = max (((tmpvar_27 * _ES_SkyFrontAndBackBlendFactor) + (1.0 - _ES_SkyFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_29;
  tmpvar_29 = ((tmpvar_28 * tmpvar_28) * tmpvar_28);
  mediump vec4 tmpvar_30;
  tmpvar_30.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_30.x = (abs(tmpvar_18.w) / max (_ES_BottomColorHeight, 0.0001));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DLod (_SkyGradientTex, tmpvar_30.xy, 0.0);
  mediump float tmpvar_32;
  tmpvar_32 = tmpvar_31.x;
  atomosphere_26 = mix (mix (_ES_TopBackColor, _ES_TopFrontColor, vec4(tmpvar_29)).xyz, mix (_ES_BottomBackColor, _ES_BottomFrontColor, vec4(tmpvar_29)).xyz, vec3(tmpvar_32));
  mediump vec4 tmpvar_33;
  tmpvar_33.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_33.x = (abs(tmpvar_18.w) / max (_ES_HorizonHaloHeight, 0.0001));
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DLod (_SkyGradientTex, tmpvar_33.xy, 0.0);
  mediump float tmpvar_35;
  tmpvar_35 = tmpvar_34.y;
  mediump float tmpvar_36;
  tmpvar_36 = clamp (((
    max (((tmpvar_27 * 0.5) + 0.5), 0.0)
   - 0.3) / 0.7), 0.0, 1.0);
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    abs(_ES_SunDirection.y)
   - 0.2) / 0.3), 0.0, 1.0);
  atomosphere_26 = (atomosphere_26 + ((
    (_ES_HorizonHaloColor * _ES_HorizonHaloIntensity)
   * tmpvar_35) * mix (
    (tmpvar_36 * (tmpvar_36 * (3.0 - (2.0 * tmpvar_36))))
  , 1.0, 
    (tmpvar_37 * (tmpvar_37 * (3.0 - (2.0 * tmpvar_37))))
  )));
  highp vec3 viewDir_38;
  viewDir_38 = tmpvar_18.xyz;
  highp float haloInfluence_39;
  mediump float vertical_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((
    dot (_ES_SunDirection, viewDir_38)
   * 0.5) + 0.5), 0.0, 1.0);
  highp float tmpvar_42;
  tmpvar_42 = dot (viewDir_38, _ES_SkyWorldUpDir);
  vertical_40 = tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = abs(vertical_40);
  mediump float y_44;
  y_44 = (_ES_SunHaloSize * tmpvar_43);
  mediump float y_45;
  y_45 = ((_ES_SunHaloSize * 0.1) * tmpvar_43);
  haloInfluence_39 = (clamp (pow (tmpvar_41, y_44), 0.0, 1.0) + (clamp (
    pow (tmpvar_41, y_45)
  , 0.0, 1.0) * 0.12));
  mediump float y_46;
  y_46 = ((_ES_SunHaloSize * 0.01) * tmpvar_43);
  haloInfluence_39 = (haloInfluence_39 + (clamp (
    pow (tmpvar_41, y_46)
  , 0.0, 1.0) * 0.03));
  highp float tmpvar_47;
  tmpvar_47 = clamp (((
    max (((dot (_ES_SunDirection, viewDir_38) * 0.5) + 0.5), 0.0)
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 tmpvar_48;
  tmpvar_48 = (((haloInfluence_39 * _ES_SunHaloIntensity) * _ES_SunHaloColor) * (tmpvar_47 * (tmpvar_47 * 
    (3.0 - (2.0 * tmpvar_47))
  )));
  tmpvar_5 = (atomosphere_26 + tmpvar_48);
  mediump float tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_49 = (tmpvar_50 * (tmpvar_50 * (3.0 - 
    (2.0 * tmpvar_50)
  )));
  highp vec3 viewDir_51;
  viewDir_51 = tmpvar_18.xyz;
  mediump float moonLunarCancel_52;
  mediump float tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (_ES_MoonDirection, viewDir_51), 0.0, 1.0);
  tmpvar_53 = tmpvar_54;
  highp float tmpvar_55;
  mediump float tmpvar_56;
  tmpvar_56 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_55 = (1.0 - (tmpvar_56 * 2.0));
  moonLunarCancel_52 = tmpvar_55;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((
    ((tmpvar_53 * tmpvar_53) * ((tmpvar_53 * tmpvar_53) * tmpvar_53))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_58;
  viewDir_58 = tmpvar_18.xyz;
  mediump float vertical_59;
  mediump float tmpvar_60;
  highp float tmpvar_61;
  tmpvar_61 = clamp (((
    dot (_ES_SunDirection, viewDir_58)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_60 = tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = dot (viewDir_58, _ES_SkyWorldUpDir);
  vertical_59 = tmpvar_62;
  mediump float tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = (1.0 - _ES_SunRimLightRadius);
  tmpvar_63 = clamp (((tmpvar_20 - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (((tmpvar_63 * 
    (tmpvar_63 * (3.0 - (2.0 * tmpvar_63)))
  ) * _ES_SunBrightness) * 0.125);
  mediump float tmpvar_66;
  tmpvar_66 = clamp (((
    ((dot (viewDir_14, _ES_MoonDirection) * 0.5) + 0.5)
   - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_67;
  tmpvar_67 = (((tmpvar_66 * 
    (tmpvar_66 * (3.0 - (2.0 * tmpvar_66)))
  ) * _ES_MoonBrightness) * 0.1);
  mediump float tmpvar_68;
  tmpvar_68 = max (((tmpvar_19 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_69;
  tmpvar_69 = ((tmpvar_68 * tmpvar_68) * tmpvar_68);
  gl_Position = clipPos_6;
  xlv_TEXCOORD0 = o_9;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = (((
    ((((tmpvar_57 * 
      (tmpvar_57 * (3.0 - (2.0 * tmpvar_57)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_52) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_60, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_59))
    ) * vertical_59), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_49);
  xlv_TEXCOORD6 = (((_ES_SunHaloColor * 
    (tmpvar_65 * tmpvar_65)
  ) + (_ES_MoonColor * 
    (tmpvar_67 * tmpvar_67)
  )) * tmpvar_49);
  xlv_TEXCOORD7 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_69));
  xlv_TEXCOORD8 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_69));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_CloudCoverage;
uniform sampler2D _CloudParticleAtlas;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 cloudCol_1;
  mediump vec4 texCol_2;
  highp vec3 curlNoise_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_CloudCurlTex, xlv_TEXCOORD1.zw).xyz;
  curlNoise_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD1.xy + ((
    (curlNoise_3.xy - 0.5)
   * curlNoise_3.z) * _CloudCurlAmplitude));
  tmpvar_5 = texture2D (_CloudParticleAtlas, P_6);
  texCol_2 = tmpvar_5;
  mediump float tmpvar_7;
  tmpvar_7 = max ((xlv_TEXCOORD3.w - xlv_TEXCOORD3.y), 0.0);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.y), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD2.w - -0.1) / 0.2), 0.0, 1.0);
  cloudCol_1.w = ((texCol_2.w * (tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  )) * (tmpvar_9 * (tmpvar_9 * 
    (3.0 - (2.0 * tmpvar_9))
  )));
  mediump float x_10;
  x_10 = (cloudCol_1.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.z), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  cloudCol_1.xyz = ((mix (xlv_TEXCOORD8, xlv_TEXCOORD7, texCol_2.xxx) + (xlv_TEXCOORD6 * 
    mix (texCol_2.y, ((1.0 - (tmpvar_11 * 
      (tmpvar_11 * (3.0 - (2.0 * tmpvar_11)))
    )) * 4.0), xlv_TEXCOORD3.w)
  )) + ((0.4 * xlv_TEXCOORD7) * _ES_CloudCoverage));
  cloudCol_1.xyz = (cloudCol_1.xyz + (xlv_TEXCOORD5 * texCol_2.x));
  cloudCol_1.xyz = (cloudCol_1.xyz * (xlv_TEXCOORD3.x + 1.0));
  mediump float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD2.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((_ES_CloudCoverage - 0.4) / 0.3), 0.0, 1.0);
  cloudCol_1.xyz = mix (xlv_TEXCOORD4, cloudCol_1.xyz, vec3(mix (clamp (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
  , 0.0, 1.0), 1.0, (tmpvar_13 * 
    (tmpvar_13 * (3.0 - (2.0 * tmpvar_13)))
  ))));
  cloudCol_1.w = clamp (cloudCol_1.w, 0.0, 1.0);
  gl_FragData[0] = cloudCol_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FIXED_SPRITE_ID" "FIXED_EDGE_SMOOTHNESS" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec4 _ES_TopFrontColor;
uniform mediump vec4 _ES_TopBackColor;
uniform mediump vec4 _ES_BottomFrontColor;
uniform mediump vec4 _ES_BottomBackColor;
uniform mediump float _ES_SkyFrontAndBackBlendFactor;
uniform mediump float _ES_BottomColorHeight;
uniform mediump vec3 _ES_HorizonHaloColor;
uniform mediump float _ES_HorizonHaloIntensity;
uniform mediump float _ES_HorizonHaloHeight;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump float _ES_SunHaloSize;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudAgePercent;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform sampler2D _SkyGradientTex;
uniform highp vec2 _AtlasTiles;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
uniform highp int _FixedSpriteId;
uniform mediump float _FixedEdgeSmoothness;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float agePercent_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 clipPos_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  clipPos_6.xyw = tmpvar_7.xyw;
  clipPos_6.z = tmpvar_7.w;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7.xyww * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = clipPos_6.zw;
  highp vec2 tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = float(_FixedSpriteId);
  tmpvar_12.x = (float(mod (tmpvar_13, _AtlasTiles.x)));
  tmpvar_12.y = floor((tmpvar_13 / _AtlasTiles.x));
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy + tmpvar_12) / _AtlasTiles);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _CloudCurlTiling) + ((_ES_CloudElapsedTime * vec2(1.2, 0.8)) * _CloudCurlSpeed));
  mediump vec3 viewDir_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(((unity_ObjectToWorld * tmpvar_15).xyz - _ES_SkyCenterWorldPos));
  viewDir_14 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (_ES_SkyWorldUpDir, viewDir_14);
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = viewDir_14;
  tmpvar_18.w = ((sign(tmpvar_17) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_17))) * (1.570796 + (abs(tmpvar_17) * (-0.2146018 + 
      (abs(tmpvar_17) * (0.08656672 + (abs(tmpvar_17) * -0.03102955)))
    ))))
  )) * 0.6366198);
  mediump float tmpvar_19;
  tmpvar_19 = dot (viewDir_14, _ES_SunDirection);
  mediump float tmpvar_20;
  tmpvar_20 = ((tmpvar_19 * 0.5) + 0.5);
  tmpvar_4.x = (tmpvar_20 * _ES_CloudSunBrightenIntensity);
  tmpvar_4.y = _FixedEdgeSmoothness;
  tmpvar_4.z = _glesColor.w;
  highp float tmpvar_21;
  tmpvar_21 = (_glesMultiTexCoord1.y / max (_glesMultiTexCoord1.x, 1e-05));
  agePercent_2 = tmpvar_21;
  agePercent_2 = (agePercent_2 * _ES_CloudAgePercent);
  highp float tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = clamp ((agePercent_2 / _glesMultiTexCoord1.z), 0.0, 1.0);
  tmpvar_22 = (tmpvar_23 * (tmpvar_23 * (3.0 - 
    (2.0 * tmpvar_23)
  )));
  highp float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((agePercent_2 - _glesMultiTexCoord1.w) / (1.0 - _glesMultiTexCoord1.w)), 0.0, 1.0);
  tmpvar_24 = (tmpvar_25 * (tmpvar_25 * (3.0 - 
    (2.0 * tmpvar_25)
  )));
  tmpvar_4.w = (1.0 - (tmpvar_22 * (1.0 - tmpvar_24)));
  mediump vec3 atomosphere_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (_ES_SunDirection, viewDir_14);
  mediump float tmpvar_28;
  tmpvar_28 = max (((tmpvar_27 * _ES_SkyFrontAndBackBlendFactor) + (1.0 - _ES_SkyFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_29;
  tmpvar_29 = ((tmpvar_28 * tmpvar_28) * tmpvar_28);
  mediump vec4 tmpvar_30;
  tmpvar_30.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_30.x = (abs(tmpvar_18.w) / max (_ES_BottomColorHeight, 0.0001));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DLod (_SkyGradientTex, tmpvar_30.xy, 0.0);
  mediump float tmpvar_32;
  tmpvar_32 = tmpvar_31.x;
  atomosphere_26 = mix (mix (_ES_TopBackColor, _ES_TopFrontColor, vec4(tmpvar_29)).xyz, mix (_ES_BottomBackColor, _ES_BottomFrontColor, vec4(tmpvar_29)).xyz, vec3(tmpvar_32));
  mediump vec4 tmpvar_33;
  tmpvar_33.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_33.x = (abs(tmpvar_18.w) / max (_ES_HorizonHaloHeight, 0.0001));
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DLod (_SkyGradientTex, tmpvar_33.xy, 0.0);
  mediump float tmpvar_35;
  tmpvar_35 = tmpvar_34.y;
  mediump float tmpvar_36;
  tmpvar_36 = clamp (((
    max (((tmpvar_27 * 0.5) + 0.5), 0.0)
   - 0.3) / 0.7), 0.0, 1.0);
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    abs(_ES_SunDirection.y)
   - 0.2) / 0.3), 0.0, 1.0);
  atomosphere_26 = (atomosphere_26 + ((
    (_ES_HorizonHaloColor * _ES_HorizonHaloIntensity)
   * tmpvar_35) * mix (
    (tmpvar_36 * (tmpvar_36 * (3.0 - (2.0 * tmpvar_36))))
  , 1.0, 
    (tmpvar_37 * (tmpvar_37 * (3.0 - (2.0 * tmpvar_37))))
  )));
  highp vec3 viewDir_38;
  viewDir_38 = tmpvar_18.xyz;
  highp float haloInfluence_39;
  mediump float vertical_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((
    dot (_ES_SunDirection, viewDir_38)
   * 0.5) + 0.5), 0.0, 1.0);
  highp float tmpvar_42;
  tmpvar_42 = dot (viewDir_38, _ES_SkyWorldUpDir);
  vertical_40 = tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = abs(vertical_40);
  mediump float y_44;
  y_44 = (_ES_SunHaloSize * tmpvar_43);
  mediump float y_45;
  y_45 = ((_ES_SunHaloSize * 0.1) * tmpvar_43);
  haloInfluence_39 = (clamp (pow (tmpvar_41, y_44), 0.0, 1.0) + (clamp (
    pow (tmpvar_41, y_45)
  , 0.0, 1.0) * 0.12));
  mediump float y_46;
  y_46 = ((_ES_SunHaloSize * 0.01) * tmpvar_43);
  haloInfluence_39 = (haloInfluence_39 + (clamp (
    pow (tmpvar_41, y_46)
  , 0.0, 1.0) * 0.03));
  highp float tmpvar_47;
  tmpvar_47 = clamp (((
    max (((dot (_ES_SunDirection, viewDir_38) * 0.5) + 0.5), 0.0)
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 tmpvar_48;
  tmpvar_48 = (((haloInfluence_39 * _ES_SunHaloIntensity) * _ES_SunHaloColor) * (tmpvar_47 * (tmpvar_47 * 
    (3.0 - (2.0 * tmpvar_47))
  )));
  tmpvar_5 = (atomosphere_26 + tmpvar_48);
  mediump float tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_49 = (tmpvar_50 * (tmpvar_50 * (3.0 - 
    (2.0 * tmpvar_50)
  )));
  highp vec3 viewDir_51;
  viewDir_51 = tmpvar_18.xyz;
  mediump float moonLunarCancel_52;
  mediump float tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (_ES_MoonDirection, viewDir_51), 0.0, 1.0);
  tmpvar_53 = tmpvar_54;
  highp float tmpvar_55;
  mediump float tmpvar_56;
  tmpvar_56 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_55 = (1.0 - (tmpvar_56 * 2.0));
  moonLunarCancel_52 = tmpvar_55;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((
    ((tmpvar_53 * tmpvar_53) * ((tmpvar_53 * tmpvar_53) * tmpvar_53))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_58;
  viewDir_58 = tmpvar_18.xyz;
  mediump float vertical_59;
  mediump float tmpvar_60;
  highp float tmpvar_61;
  tmpvar_61 = clamp (((
    dot (_ES_SunDirection, viewDir_58)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_60 = tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = dot (viewDir_58, _ES_SkyWorldUpDir);
  vertical_59 = tmpvar_62;
  mediump float tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = (1.0 - _ES_SunRimLightRadius);
  tmpvar_63 = clamp (((tmpvar_20 - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (((tmpvar_63 * 
    (tmpvar_63 * (3.0 - (2.0 * tmpvar_63)))
  ) * _ES_SunBrightness) * 0.125);
  mediump float tmpvar_66;
  tmpvar_66 = clamp (((
    ((dot (viewDir_14, _ES_MoonDirection) * 0.5) + 0.5)
   - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_67;
  tmpvar_67 = (((tmpvar_66 * 
    (tmpvar_66 * (3.0 - (2.0 * tmpvar_66)))
  ) * _ES_MoonBrightness) * 0.1);
  mediump float tmpvar_68;
  tmpvar_68 = max (((tmpvar_19 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_69;
  tmpvar_69 = ((tmpvar_68 * tmpvar_68) * tmpvar_68);
  gl_Position = clipPos_6;
  xlv_TEXCOORD0 = o_9;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = (((
    ((((tmpvar_57 * 
      (tmpvar_57 * (3.0 - (2.0 * tmpvar_57)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_52) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_60, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_59))
    ) * vertical_59), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_49);
  xlv_TEXCOORD6 = (((_ES_SunHaloColor * 
    (tmpvar_65 * tmpvar_65)
  ) + (_ES_MoonColor * 
    (tmpvar_67 * tmpvar_67)
  )) * tmpvar_49);
  xlv_TEXCOORD7 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_69));
  xlv_TEXCOORD8 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_69));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_CloudCoverage;
uniform sampler2D _CloudParticleAtlas;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 cloudCol_1;
  mediump vec4 texCol_2;
  highp vec3 curlNoise_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_CloudCurlTex, xlv_TEXCOORD1.zw).xyz;
  curlNoise_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD1.xy + ((
    (curlNoise_3.xy - 0.5)
   * curlNoise_3.z) * _CloudCurlAmplitude));
  tmpvar_5 = texture2D (_CloudParticleAtlas, P_6);
  texCol_2 = tmpvar_5;
  mediump float tmpvar_7;
  tmpvar_7 = max ((xlv_TEXCOORD3.w - xlv_TEXCOORD3.y), 0.0);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.y), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD2.w - -0.1) / 0.2), 0.0, 1.0);
  cloudCol_1.w = ((texCol_2.w * (tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  )) * (tmpvar_9 * (tmpvar_9 * 
    (3.0 - (2.0 * tmpvar_9))
  )));
  mediump float x_10;
  x_10 = (cloudCol_1.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.z), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  cloudCol_1.xyz = ((mix (xlv_TEXCOORD8, xlv_TEXCOORD7, texCol_2.xxx) + (xlv_TEXCOORD6 * 
    mix (texCol_2.y, ((1.0 - (tmpvar_11 * 
      (tmpvar_11 * (3.0 - (2.0 * tmpvar_11)))
    )) * 4.0), xlv_TEXCOORD3.w)
  )) + ((0.4 * xlv_TEXCOORD7) * _ES_CloudCoverage));
  cloudCol_1.xyz = (cloudCol_1.xyz + (xlv_TEXCOORD5 * texCol_2.x));
  cloudCol_1.xyz = (cloudCol_1.xyz * (xlv_TEXCOORD3.x + 1.0));
  mediump float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD2.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((_ES_CloudCoverage - 0.4) / 0.3), 0.0, 1.0);
  cloudCol_1.xyz = mix (xlv_TEXCOORD4, cloudCol_1.xyz, vec3(mix (clamp (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
  , 0.0, 1.0), 1.0, (tmpvar_13 * 
    (tmpvar_13 * (3.0 - (2.0 * tmpvar_13)))
  ))));
  cloudCol_1.w = clamp (cloudCol_1.w, 0.0, 1.0);
  gl_FragData[0] = cloudCol_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FIXED_SPRITE_ID" "FIXED_EDGE_SMOOTHNESS" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec4 _ES_TopFrontColor;
uniform mediump vec4 _ES_TopBackColor;
uniform mediump vec4 _ES_BottomFrontColor;
uniform mediump vec4 _ES_BottomBackColor;
uniform mediump float _ES_SkyFrontAndBackBlendFactor;
uniform mediump float _ES_BottomColorHeight;
uniform mediump vec3 _ES_HorizonHaloColor;
uniform mediump float _ES_HorizonHaloIntensity;
uniform mediump float _ES_HorizonHaloHeight;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump float _ES_SunHaloSize;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudAgePercent;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform sampler2D _SkyGradientTex;
uniform highp vec2 _AtlasTiles;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
uniform highp int _FixedSpriteId;
uniform mediump float _FixedEdgeSmoothness;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float agePercent_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 clipPos_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  clipPos_6.xyw = tmpvar_7.xyw;
  clipPos_6.z = tmpvar_7.w;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7.xyww * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = clipPos_6.zw;
  highp vec2 tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = float(_FixedSpriteId);
  tmpvar_12.x = (float(mod (tmpvar_13, _AtlasTiles.x)));
  tmpvar_12.y = floor((tmpvar_13 / _AtlasTiles.x));
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy + tmpvar_12) / _AtlasTiles);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _CloudCurlTiling) + ((_ES_CloudElapsedTime * vec2(1.2, 0.8)) * _CloudCurlSpeed));
  mediump vec3 viewDir_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(((unity_ObjectToWorld * tmpvar_15).xyz - _ES_SkyCenterWorldPos));
  viewDir_14 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (_ES_SkyWorldUpDir, viewDir_14);
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = viewDir_14;
  tmpvar_18.w = ((sign(tmpvar_17) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_17))) * (1.570796 + (abs(tmpvar_17) * (-0.2146018 + 
      (abs(tmpvar_17) * (0.08656672 + (abs(tmpvar_17) * -0.03102955)))
    ))))
  )) * 0.6366198);
  mediump float tmpvar_19;
  tmpvar_19 = dot (viewDir_14, _ES_SunDirection);
  mediump float tmpvar_20;
  tmpvar_20 = ((tmpvar_19 * 0.5) + 0.5);
  tmpvar_4.x = (tmpvar_20 * _ES_CloudSunBrightenIntensity);
  tmpvar_4.y = _FixedEdgeSmoothness;
  tmpvar_4.z = _glesColor.w;
  highp float tmpvar_21;
  tmpvar_21 = (_glesMultiTexCoord1.y / max (_glesMultiTexCoord1.x, 1e-05));
  agePercent_2 = tmpvar_21;
  agePercent_2 = (agePercent_2 * _ES_CloudAgePercent);
  highp float tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = clamp ((agePercent_2 / _glesMultiTexCoord1.z), 0.0, 1.0);
  tmpvar_22 = (tmpvar_23 * (tmpvar_23 * (3.0 - 
    (2.0 * tmpvar_23)
  )));
  highp float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((agePercent_2 - _glesMultiTexCoord1.w) / (1.0 - _glesMultiTexCoord1.w)), 0.0, 1.0);
  tmpvar_24 = (tmpvar_25 * (tmpvar_25 * (3.0 - 
    (2.0 * tmpvar_25)
  )));
  tmpvar_4.w = (1.0 - (tmpvar_22 * (1.0 - tmpvar_24)));
  mediump vec3 atomosphere_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (_ES_SunDirection, viewDir_14);
  mediump float tmpvar_28;
  tmpvar_28 = max (((tmpvar_27 * _ES_SkyFrontAndBackBlendFactor) + (1.0 - _ES_SkyFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_29;
  tmpvar_29 = ((tmpvar_28 * tmpvar_28) * tmpvar_28);
  mediump vec4 tmpvar_30;
  tmpvar_30.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_30.x = (abs(tmpvar_18.w) / max (_ES_BottomColorHeight, 0.0001));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DLod (_SkyGradientTex, tmpvar_30.xy, 0.0);
  mediump float tmpvar_32;
  tmpvar_32 = tmpvar_31.x;
  atomosphere_26 = mix (mix (_ES_TopBackColor, _ES_TopFrontColor, vec4(tmpvar_29)).xyz, mix (_ES_BottomBackColor, _ES_BottomFrontColor, vec4(tmpvar_29)).xyz, vec3(tmpvar_32));
  mediump vec4 tmpvar_33;
  tmpvar_33.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_33.x = (abs(tmpvar_18.w) / max (_ES_HorizonHaloHeight, 0.0001));
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DLod (_SkyGradientTex, tmpvar_33.xy, 0.0);
  mediump float tmpvar_35;
  tmpvar_35 = tmpvar_34.y;
  mediump float tmpvar_36;
  tmpvar_36 = clamp (((
    max (((tmpvar_27 * 0.5) + 0.5), 0.0)
   - 0.3) / 0.7), 0.0, 1.0);
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    abs(_ES_SunDirection.y)
   - 0.2) / 0.3), 0.0, 1.0);
  atomosphere_26 = (atomosphere_26 + ((
    (_ES_HorizonHaloColor * _ES_HorizonHaloIntensity)
   * tmpvar_35) * mix (
    (tmpvar_36 * (tmpvar_36 * (3.0 - (2.0 * tmpvar_36))))
  , 1.0, 
    (tmpvar_37 * (tmpvar_37 * (3.0 - (2.0 * tmpvar_37))))
  )));
  highp vec3 viewDir_38;
  viewDir_38 = tmpvar_18.xyz;
  highp float haloInfluence_39;
  mediump float vertical_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((
    dot (_ES_SunDirection, viewDir_38)
   * 0.5) + 0.5), 0.0, 1.0);
  highp float tmpvar_42;
  tmpvar_42 = dot (viewDir_38, _ES_SkyWorldUpDir);
  vertical_40 = tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = abs(vertical_40);
  mediump float y_44;
  y_44 = (_ES_SunHaloSize * tmpvar_43);
  mediump float y_45;
  y_45 = ((_ES_SunHaloSize * 0.1) * tmpvar_43);
  haloInfluence_39 = (clamp (pow (tmpvar_41, y_44), 0.0, 1.0) + (clamp (
    pow (tmpvar_41, y_45)
  , 0.0, 1.0) * 0.12));
  mediump float y_46;
  y_46 = ((_ES_SunHaloSize * 0.01) * tmpvar_43);
  haloInfluence_39 = (haloInfluence_39 + (clamp (
    pow (tmpvar_41, y_46)
  , 0.0, 1.0) * 0.03));
  highp float tmpvar_47;
  tmpvar_47 = clamp (((
    max (((dot (_ES_SunDirection, viewDir_38) * 0.5) + 0.5), 0.0)
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 tmpvar_48;
  tmpvar_48 = (((haloInfluence_39 * _ES_SunHaloIntensity) * _ES_SunHaloColor) * (tmpvar_47 * (tmpvar_47 * 
    (3.0 - (2.0 * tmpvar_47))
  )));
  tmpvar_5 = (atomosphere_26 + tmpvar_48);
  mediump float tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_49 = (tmpvar_50 * (tmpvar_50 * (3.0 - 
    (2.0 * tmpvar_50)
  )));
  highp vec3 viewDir_51;
  viewDir_51 = tmpvar_18.xyz;
  mediump float moonLunarCancel_52;
  mediump float tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (_ES_MoonDirection, viewDir_51), 0.0, 1.0);
  tmpvar_53 = tmpvar_54;
  highp float tmpvar_55;
  mediump float tmpvar_56;
  tmpvar_56 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_55 = (1.0 - (tmpvar_56 * 2.0));
  moonLunarCancel_52 = tmpvar_55;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((
    ((tmpvar_53 * tmpvar_53) * ((tmpvar_53 * tmpvar_53) * tmpvar_53))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_58;
  viewDir_58 = tmpvar_18.xyz;
  mediump float vertical_59;
  mediump float tmpvar_60;
  highp float tmpvar_61;
  tmpvar_61 = clamp (((
    dot (_ES_SunDirection, viewDir_58)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_60 = tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = dot (viewDir_58, _ES_SkyWorldUpDir);
  vertical_59 = tmpvar_62;
  mediump float tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = (1.0 - _ES_SunRimLightRadius);
  tmpvar_63 = clamp (((tmpvar_20 - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (((tmpvar_63 * 
    (tmpvar_63 * (3.0 - (2.0 * tmpvar_63)))
  ) * _ES_SunBrightness) * 0.125);
  mediump float tmpvar_66;
  tmpvar_66 = clamp (((
    ((dot (viewDir_14, _ES_MoonDirection) * 0.5) + 0.5)
   - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_67;
  tmpvar_67 = (((tmpvar_66 * 
    (tmpvar_66 * (3.0 - (2.0 * tmpvar_66)))
  ) * _ES_MoonBrightness) * 0.1);
  mediump float tmpvar_68;
  tmpvar_68 = max (((tmpvar_19 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_69;
  tmpvar_69 = ((tmpvar_68 * tmpvar_68) * tmpvar_68);
  gl_Position = clipPos_6;
  xlv_TEXCOORD0 = o_9;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = (((
    ((((tmpvar_57 * 
      (tmpvar_57 * (3.0 - (2.0 * tmpvar_57)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_52) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_60, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_59))
    ) * vertical_59), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_49);
  xlv_TEXCOORD6 = (((_ES_SunHaloColor * 
    (tmpvar_65 * tmpvar_65)
  ) + (_ES_MoonColor * 
    (tmpvar_67 * tmpvar_67)
  )) * tmpvar_49);
  xlv_TEXCOORD7 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_69));
  xlv_TEXCOORD8 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_69));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_CloudCoverage;
uniform sampler2D _CloudParticleAtlas;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 cloudCol_1;
  mediump vec4 texCol_2;
  highp vec3 curlNoise_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_CloudCurlTex, xlv_TEXCOORD1.zw).xyz;
  curlNoise_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD1.xy + ((
    (curlNoise_3.xy - 0.5)
   * curlNoise_3.z) * _CloudCurlAmplitude));
  tmpvar_5 = texture2D (_CloudParticleAtlas, P_6);
  texCol_2 = tmpvar_5;
  mediump float tmpvar_7;
  tmpvar_7 = max ((xlv_TEXCOORD3.w - xlv_TEXCOORD3.y), 0.0);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.y), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD2.w - -0.1) / 0.2), 0.0, 1.0);
  cloudCol_1.w = ((texCol_2.w * (tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  )) * (tmpvar_9 * (tmpvar_9 * 
    (3.0 - (2.0 * tmpvar_9))
  )));
  mediump float x_10;
  x_10 = (cloudCol_1.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.z), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  cloudCol_1.xyz = ((mix (xlv_TEXCOORD8, xlv_TEXCOORD7, texCol_2.xxx) + (xlv_TEXCOORD6 * 
    mix (texCol_2.y, ((1.0 - (tmpvar_11 * 
      (tmpvar_11 * (3.0 - (2.0 * tmpvar_11)))
    )) * 4.0), xlv_TEXCOORD3.w)
  )) + ((0.4 * xlv_TEXCOORD7) * _ES_CloudCoverage));
  cloudCol_1.xyz = (cloudCol_1.xyz + (xlv_TEXCOORD5 * texCol_2.x));
  cloudCol_1.xyz = (cloudCol_1.xyz * (xlv_TEXCOORD3.x + 1.0));
  mediump float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD2.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((_ES_CloudCoverage - 0.4) / 0.3), 0.0, 1.0);
  cloudCol_1.xyz = mix (xlv_TEXCOORD4, cloudCol_1.xyz, vec3(mix (clamp (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
  , 0.0, 1.0), 1.0, (tmpvar_13 * 
    (tmpvar_13 * (3.0 - (2.0 * tmpvar_13)))
  ))));
  cloudCol_1.w = clamp (cloudCol_1.w, 0.0, 1.0);
  gl_FragData[0] = cloudCol_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FIXED_SPRITE_ID" "FIXED_EDGE_SMOOTHNESS" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec4 _ES_TopFrontColor;
uniform mediump vec4 _ES_TopBackColor;
uniform mediump vec4 _ES_BottomFrontColor;
uniform mediump vec4 _ES_BottomBackColor;
uniform mediump float _ES_SkyFrontAndBackBlendFactor;
uniform mediump float _ES_BottomColorHeight;
uniform mediump vec3 _ES_HorizonHaloColor;
uniform mediump float _ES_HorizonHaloIntensity;
uniform mediump float _ES_HorizonHaloHeight;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump float _ES_SunHaloSize;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudAgePercent;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform sampler2D _SkyGradientTex;
uniform highp vec2 _AtlasTiles;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
uniform highp int _FixedSpriteId;
uniform mediump float _FixedEdgeSmoothness;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float agePercent_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 clipPos_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  clipPos_6.xyw = tmpvar_7.xyw;
  clipPos_6.z = tmpvar_7.w;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7.xyww * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = clipPos_6.zw;
  highp vec2 tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = float(_FixedSpriteId);
  tmpvar_12.x = (float(mod (tmpvar_13, _AtlasTiles.x)));
  tmpvar_12.y = floor((tmpvar_13 / _AtlasTiles.x));
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy + tmpvar_12) / _AtlasTiles);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _CloudCurlTiling) + ((_ES_CloudElapsedTime * vec2(1.2, 0.8)) * _CloudCurlSpeed));
  mediump vec3 viewDir_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(((unity_ObjectToWorld * tmpvar_15).xyz - _ES_SkyCenterWorldPos));
  viewDir_14 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (_ES_SkyWorldUpDir, viewDir_14);
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = viewDir_14;
  tmpvar_18.w = ((sign(tmpvar_17) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_17))) * (1.570796 + (abs(tmpvar_17) * (-0.2146018 + 
      (abs(tmpvar_17) * (0.08656672 + (abs(tmpvar_17) * -0.03102955)))
    ))))
  )) * 0.6366198);
  mediump float tmpvar_19;
  tmpvar_19 = dot (viewDir_14, _ES_SunDirection);
  mediump float tmpvar_20;
  tmpvar_20 = ((tmpvar_19 * 0.5) + 0.5);
  tmpvar_4.x = (tmpvar_20 * _ES_CloudSunBrightenIntensity);
  tmpvar_4.y = _FixedEdgeSmoothness;
  tmpvar_4.z = _glesColor.w;
  highp float tmpvar_21;
  tmpvar_21 = (_glesMultiTexCoord1.y / max (_glesMultiTexCoord1.x, 1e-05));
  agePercent_2 = tmpvar_21;
  agePercent_2 = (agePercent_2 * _ES_CloudAgePercent);
  highp float tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = clamp ((agePercent_2 / _glesMultiTexCoord1.z), 0.0, 1.0);
  tmpvar_22 = (tmpvar_23 * (tmpvar_23 * (3.0 - 
    (2.0 * tmpvar_23)
  )));
  highp float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((agePercent_2 - _glesMultiTexCoord1.w) / (1.0 - _glesMultiTexCoord1.w)), 0.0, 1.0);
  tmpvar_24 = (tmpvar_25 * (tmpvar_25 * (3.0 - 
    (2.0 * tmpvar_25)
  )));
  tmpvar_4.w = (1.0 - (tmpvar_22 * (1.0 - tmpvar_24)));
  mediump vec3 atomosphere_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (_ES_SunDirection, viewDir_14);
  mediump float tmpvar_28;
  tmpvar_28 = max (((tmpvar_27 * _ES_SkyFrontAndBackBlendFactor) + (1.0 - _ES_SkyFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_29;
  tmpvar_29 = ((tmpvar_28 * tmpvar_28) * tmpvar_28);
  mediump vec4 tmpvar_30;
  tmpvar_30.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_30.x = (abs(tmpvar_18.w) / max (_ES_BottomColorHeight, 0.0001));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DLod (_SkyGradientTex, tmpvar_30.xy, 0.0);
  mediump float tmpvar_32;
  tmpvar_32 = tmpvar_31.x;
  atomosphere_26 = mix (mix (_ES_TopBackColor, _ES_TopFrontColor, vec4(tmpvar_29)).xyz, mix (_ES_BottomBackColor, _ES_BottomFrontColor, vec4(tmpvar_29)).xyz, vec3(tmpvar_32));
  mediump vec4 tmpvar_33;
  tmpvar_33.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_33.x = (abs(tmpvar_18.w) / max (_ES_HorizonHaloHeight, 0.0001));
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DLod (_SkyGradientTex, tmpvar_33.xy, 0.0);
  mediump float tmpvar_35;
  tmpvar_35 = tmpvar_34.y;
  mediump float tmpvar_36;
  tmpvar_36 = clamp (((
    max (((tmpvar_27 * 0.5) + 0.5), 0.0)
   - 0.3) / 0.7), 0.0, 1.0);
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    abs(_ES_SunDirection.y)
   - 0.2) / 0.3), 0.0, 1.0);
  atomosphere_26 = (atomosphere_26 + ((
    (_ES_HorizonHaloColor * _ES_HorizonHaloIntensity)
   * tmpvar_35) * mix (
    (tmpvar_36 * (tmpvar_36 * (3.0 - (2.0 * tmpvar_36))))
  , 1.0, 
    (tmpvar_37 * (tmpvar_37 * (3.0 - (2.0 * tmpvar_37))))
  )));
  highp vec3 viewDir_38;
  viewDir_38 = tmpvar_18.xyz;
  highp float haloInfluence_39;
  mediump float vertical_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((
    dot (_ES_SunDirection, viewDir_38)
   * 0.5) + 0.5), 0.0, 1.0);
  highp float tmpvar_42;
  tmpvar_42 = dot (viewDir_38, _ES_SkyWorldUpDir);
  vertical_40 = tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = abs(vertical_40);
  mediump float y_44;
  y_44 = (_ES_SunHaloSize * tmpvar_43);
  mediump float y_45;
  y_45 = ((_ES_SunHaloSize * 0.1) * tmpvar_43);
  haloInfluence_39 = (clamp (pow (tmpvar_41, y_44), 0.0, 1.0) + (clamp (
    pow (tmpvar_41, y_45)
  , 0.0, 1.0) * 0.12));
  mediump float y_46;
  y_46 = ((_ES_SunHaloSize * 0.01) * tmpvar_43);
  haloInfluence_39 = (haloInfluence_39 + (clamp (
    pow (tmpvar_41, y_46)
  , 0.0, 1.0) * 0.03));
  highp float tmpvar_47;
  tmpvar_47 = clamp (((
    max (((dot (_ES_SunDirection, viewDir_38) * 0.5) + 0.5), 0.0)
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 tmpvar_48;
  tmpvar_48 = (((haloInfluence_39 * _ES_SunHaloIntensity) * _ES_SunHaloColor) * (tmpvar_47 * (tmpvar_47 * 
    (3.0 - (2.0 * tmpvar_47))
  )));
  tmpvar_5 = (atomosphere_26 + tmpvar_48);
  mediump float tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_49 = (tmpvar_50 * (tmpvar_50 * (3.0 - 
    (2.0 * tmpvar_50)
  )));
  highp vec3 viewDir_51;
  viewDir_51 = tmpvar_18.xyz;
  mediump float moonLunarCancel_52;
  mediump float tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (_ES_MoonDirection, viewDir_51), 0.0, 1.0);
  tmpvar_53 = tmpvar_54;
  highp float tmpvar_55;
  mediump float tmpvar_56;
  tmpvar_56 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_55 = (1.0 - (tmpvar_56 * 2.0));
  moonLunarCancel_52 = tmpvar_55;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((
    ((tmpvar_53 * tmpvar_53) * ((tmpvar_53 * tmpvar_53) * tmpvar_53))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_58;
  viewDir_58 = tmpvar_18.xyz;
  mediump float vertical_59;
  mediump float tmpvar_60;
  highp float tmpvar_61;
  tmpvar_61 = clamp (((
    dot (_ES_SunDirection, viewDir_58)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_60 = tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = dot (viewDir_58, _ES_SkyWorldUpDir);
  vertical_59 = tmpvar_62;
  mediump float tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = (1.0 - _ES_SunRimLightRadius);
  tmpvar_63 = clamp (((tmpvar_20 - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (((tmpvar_63 * 
    (tmpvar_63 * (3.0 - (2.0 * tmpvar_63)))
  ) * _ES_SunBrightness) * 0.125);
  mediump float tmpvar_66;
  tmpvar_66 = clamp (((
    ((dot (viewDir_14, _ES_MoonDirection) * 0.5) + 0.5)
   - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_67;
  tmpvar_67 = (((tmpvar_66 * 
    (tmpvar_66 * (3.0 - (2.0 * tmpvar_66)))
  ) * _ES_MoonBrightness) * 0.1);
  mediump float tmpvar_68;
  tmpvar_68 = max (((tmpvar_19 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_69;
  tmpvar_69 = ((tmpvar_68 * tmpvar_68) * tmpvar_68);
  gl_Position = clipPos_6;
  xlv_TEXCOORD0 = o_9;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = (((
    ((((tmpvar_57 * 
      (tmpvar_57 * (3.0 - (2.0 * tmpvar_57)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_52) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_60, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_59))
    ) * vertical_59), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_49);
  xlv_TEXCOORD6 = (((_ES_SunHaloColor * 
    (tmpvar_65 * tmpvar_65)
  ) + (_ES_MoonColor * 
    (tmpvar_67 * tmpvar_67)
  )) * tmpvar_49);
  xlv_TEXCOORD7 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_69));
  xlv_TEXCOORD8 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_69));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_CloudCoverage;
uniform sampler2D _CloudParticleAtlas;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 cloudCol_1;
  mediump vec4 texCol_2;
  highp vec3 curlNoise_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_CloudCurlTex, xlv_TEXCOORD1.zw).xyz;
  curlNoise_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD1.xy + ((
    (curlNoise_3.xy - 0.5)
   * curlNoise_3.z) * _CloudCurlAmplitude));
  tmpvar_5 = texture2D (_CloudParticleAtlas, P_6);
  texCol_2 = tmpvar_5;
  mediump float tmpvar_7;
  tmpvar_7 = max ((xlv_TEXCOORD3.w - xlv_TEXCOORD3.y), 0.0);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.y), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD2.w - -0.1) / 0.2), 0.0, 1.0);
  cloudCol_1.w = ((texCol_2.w * (tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  )) * (tmpvar_9 * (tmpvar_9 * 
    (3.0 - (2.0 * tmpvar_9))
  )));
  mediump float x_10;
  x_10 = (cloudCol_1.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.z), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  cloudCol_1.xyz = ((mix (xlv_TEXCOORD8, xlv_TEXCOORD7, texCol_2.xxx) + (xlv_TEXCOORD6 * 
    mix (texCol_2.y, ((1.0 - (tmpvar_11 * 
      (tmpvar_11 * (3.0 - (2.0 * tmpvar_11)))
    )) * 4.0), xlv_TEXCOORD3.w)
  )) + ((0.4 * xlv_TEXCOORD7) * _ES_CloudCoverage));
  cloudCol_1.xyz = (cloudCol_1.xyz + (xlv_TEXCOORD5 * texCol_2.x));
  cloudCol_1.xyz = (cloudCol_1.xyz * (xlv_TEXCOORD3.x + 1.0));
  mediump float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD2.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((_ES_CloudCoverage - 0.4) / 0.3), 0.0, 1.0);
  cloudCol_1.xyz = mix (xlv_TEXCOORD4, cloudCol_1.xyz, vec3(mix (clamp (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
  , 0.0, 1.0), 1.0, (tmpvar_13 * 
    (tmpvar_13 * (3.0 - (2.0 * tmpvar_13)))
  ))));
  cloudCol_1.w = clamp (cloudCol_1.w, 0.0, 1.0);
  gl_FragData[0] = cloudCol_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "FIXED_SPRITE_ID" "FIXED_EDGE_SMOOTHNESS" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec4 _ES_TopFrontColor;
uniform mediump vec4 _ES_TopBackColor;
uniform mediump vec4 _ES_BottomFrontColor;
uniform mediump vec4 _ES_BottomBackColor;
uniform mediump float _ES_SkyFrontAndBackBlendFactor;
uniform mediump float _ES_BottomColorHeight;
uniform mediump vec3 _ES_HorizonHaloColor;
uniform mediump float _ES_HorizonHaloIntensity;
uniform mediump float _ES_HorizonHaloHeight;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump float _ES_SunHaloSize;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudAgePercent;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform sampler2D _SkyGradientTex;
uniform highp vec2 _AtlasTiles;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
uniform highp int _FixedSpriteId;
uniform mediump float _FixedEdgeSmoothness;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float agePercent_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 clipPos_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  clipPos_6.xyw = tmpvar_7.xyw;
  clipPos_6.z = tmpvar_7.w;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7.xyww * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = clipPos_6.zw;
  highp vec2 tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = float(_FixedSpriteId);
  tmpvar_12.x = (float(mod (tmpvar_13, _AtlasTiles.x)));
  tmpvar_12.y = floor((tmpvar_13 / _AtlasTiles.x));
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy + tmpvar_12) / _AtlasTiles);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _CloudCurlTiling) + ((_ES_CloudElapsedTime * vec2(1.2, 0.8)) * _CloudCurlSpeed));
  mediump vec3 viewDir_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(((unity_ObjectToWorld * tmpvar_15).xyz - _ES_SkyCenterWorldPos));
  viewDir_14 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (_ES_SkyWorldUpDir, viewDir_14);
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = viewDir_14;
  tmpvar_18.w = ((sign(tmpvar_17) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_17))) * (1.570796 + (abs(tmpvar_17) * (-0.2146018 + 
      (abs(tmpvar_17) * (0.08656672 + (abs(tmpvar_17) * -0.03102955)))
    ))))
  )) * 0.6366198);
  mediump float tmpvar_19;
  tmpvar_19 = dot (viewDir_14, _ES_SunDirection);
  mediump float tmpvar_20;
  tmpvar_20 = ((tmpvar_19 * 0.5) + 0.5);
  tmpvar_4.x = (tmpvar_20 * _ES_CloudSunBrightenIntensity);
  tmpvar_4.y = _FixedEdgeSmoothness;
  tmpvar_4.z = _glesColor.w;
  highp float tmpvar_21;
  tmpvar_21 = (_glesMultiTexCoord1.y / max (_glesMultiTexCoord1.x, 1e-05));
  agePercent_2 = tmpvar_21;
  agePercent_2 = (agePercent_2 * _ES_CloudAgePercent);
  highp float tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = clamp ((agePercent_2 / _glesMultiTexCoord1.z), 0.0, 1.0);
  tmpvar_22 = (tmpvar_23 * (tmpvar_23 * (3.0 - 
    (2.0 * tmpvar_23)
  )));
  highp float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((agePercent_2 - _glesMultiTexCoord1.w) / (1.0 - _glesMultiTexCoord1.w)), 0.0, 1.0);
  tmpvar_24 = (tmpvar_25 * (tmpvar_25 * (3.0 - 
    (2.0 * tmpvar_25)
  )));
  tmpvar_4.w = (1.0 - (tmpvar_22 * (1.0 - tmpvar_24)));
  mediump vec3 atomosphere_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (_ES_SunDirection, viewDir_14);
  mediump float tmpvar_28;
  tmpvar_28 = max (((tmpvar_27 * _ES_SkyFrontAndBackBlendFactor) + (1.0 - _ES_SkyFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_29;
  tmpvar_29 = ((tmpvar_28 * tmpvar_28) * tmpvar_28);
  mediump vec4 tmpvar_30;
  tmpvar_30.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_30.x = (abs(tmpvar_18.w) / max (_ES_BottomColorHeight, 0.0001));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DLod (_SkyGradientTex, tmpvar_30.xy, 0.0);
  mediump float tmpvar_32;
  tmpvar_32 = tmpvar_31.x;
  atomosphere_26 = mix (mix (_ES_TopBackColor, _ES_TopFrontColor, vec4(tmpvar_29)).xyz, mix (_ES_BottomBackColor, _ES_BottomFrontColor, vec4(tmpvar_29)).xyz, vec3(tmpvar_32));
  mediump vec4 tmpvar_33;
  tmpvar_33.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_33.x = (abs(tmpvar_18.w) / max (_ES_HorizonHaloHeight, 0.0001));
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DLod (_SkyGradientTex, tmpvar_33.xy, 0.0);
  mediump float tmpvar_35;
  tmpvar_35 = tmpvar_34.y;
  mediump float tmpvar_36;
  tmpvar_36 = clamp (((
    max (((tmpvar_27 * 0.5) + 0.5), 0.0)
   - 0.3) / 0.7), 0.0, 1.0);
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    abs(_ES_SunDirection.y)
   - 0.2) / 0.3), 0.0, 1.0);
  atomosphere_26 = (atomosphere_26 + ((
    (_ES_HorizonHaloColor * _ES_HorizonHaloIntensity)
   * tmpvar_35) * mix (
    (tmpvar_36 * (tmpvar_36 * (3.0 - (2.0 * tmpvar_36))))
  , 1.0, 
    (tmpvar_37 * (tmpvar_37 * (3.0 - (2.0 * tmpvar_37))))
  )));
  highp vec3 viewDir_38;
  viewDir_38 = tmpvar_18.xyz;
  highp float haloInfluence_39;
  mediump float vertical_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((
    dot (_ES_SunDirection, viewDir_38)
   * 0.5) + 0.5), 0.0, 1.0);
  highp float tmpvar_42;
  tmpvar_42 = dot (viewDir_38, _ES_SkyWorldUpDir);
  vertical_40 = tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = abs(vertical_40);
  mediump float y_44;
  y_44 = (_ES_SunHaloSize * tmpvar_43);
  mediump float y_45;
  y_45 = ((_ES_SunHaloSize * 0.1) * tmpvar_43);
  haloInfluence_39 = (clamp (pow (tmpvar_41, y_44), 0.0, 1.0) + (clamp (
    pow (tmpvar_41, y_45)
  , 0.0, 1.0) * 0.12));
  mediump float y_46;
  y_46 = ((_ES_SunHaloSize * 0.01) * tmpvar_43);
  haloInfluence_39 = (haloInfluence_39 + (clamp (
    pow (tmpvar_41, y_46)
  , 0.0, 1.0) * 0.03));
  highp float tmpvar_47;
  tmpvar_47 = clamp (((
    max (((dot (_ES_SunDirection, viewDir_38) * 0.5) + 0.5), 0.0)
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 tmpvar_48;
  tmpvar_48 = (((haloInfluence_39 * _ES_SunHaloIntensity) * _ES_SunHaloColor) * (tmpvar_47 * (tmpvar_47 * 
    (3.0 - (2.0 * tmpvar_47))
  )));
  tmpvar_5 = (atomosphere_26 + tmpvar_48);
  mediump float tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_49 = (tmpvar_50 * (tmpvar_50 * (3.0 - 
    (2.0 * tmpvar_50)
  )));
  highp vec3 viewDir_51;
  viewDir_51 = tmpvar_18.xyz;
  mediump float moonLunarCancel_52;
  mediump float tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (_ES_MoonDirection, viewDir_51), 0.0, 1.0);
  tmpvar_53 = tmpvar_54;
  highp float tmpvar_55;
  mediump float tmpvar_56;
  tmpvar_56 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_55 = (1.0 - (tmpvar_56 * 2.0));
  moonLunarCancel_52 = tmpvar_55;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((
    ((tmpvar_53 * tmpvar_53) * ((tmpvar_53 * tmpvar_53) * tmpvar_53))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_58;
  viewDir_58 = tmpvar_18.xyz;
  mediump float vertical_59;
  mediump float tmpvar_60;
  highp float tmpvar_61;
  tmpvar_61 = clamp (((
    dot (_ES_SunDirection, viewDir_58)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_60 = tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = dot (viewDir_58, _ES_SkyWorldUpDir);
  vertical_59 = tmpvar_62;
  mediump float tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = (1.0 - _ES_SunRimLightRadius);
  tmpvar_63 = clamp (((tmpvar_20 - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (((tmpvar_63 * 
    (tmpvar_63 * (3.0 - (2.0 * tmpvar_63)))
  ) * _ES_SunBrightness) * 0.125);
  mediump float tmpvar_66;
  tmpvar_66 = clamp (((
    ((dot (viewDir_14, _ES_MoonDirection) * 0.5) + 0.5)
   - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_67;
  tmpvar_67 = (((tmpvar_66 * 
    (tmpvar_66 * (3.0 - (2.0 * tmpvar_66)))
  ) * _ES_MoonBrightness) * 0.1);
  mediump float tmpvar_68;
  tmpvar_68 = max (((tmpvar_19 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_69;
  tmpvar_69 = ((tmpvar_68 * tmpvar_68) * tmpvar_68);
  gl_Position = clipPos_6;
  xlv_TEXCOORD0 = o_9;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = (((
    ((((tmpvar_57 * 
      (tmpvar_57 * (3.0 - (2.0 * tmpvar_57)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_52) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_60, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_59))
    ) * vertical_59), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_49);
  xlv_TEXCOORD6 = (((_ES_SunHaloColor * 
    (tmpvar_65 * tmpvar_65)
  ) + (_ES_MoonColor * 
    (tmpvar_67 * tmpvar_67)
  )) * tmpvar_49);
  xlv_TEXCOORD7 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_69));
  xlv_TEXCOORD8 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_69));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_CloudCoverage;
uniform sampler2D _CloudParticleAtlas;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 cloudCol_1;
  mediump vec4 texCol_2;
  highp vec3 curlNoise_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_CloudCurlTex, xlv_TEXCOORD1.zw).xyz;
  curlNoise_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD1.xy + ((
    (curlNoise_3.xy - 0.5)
   * curlNoise_3.z) * _CloudCurlAmplitude));
  tmpvar_5 = texture2D (_CloudParticleAtlas, P_6);
  texCol_2 = tmpvar_5;
  mediump float tmpvar_7;
  tmpvar_7 = max ((xlv_TEXCOORD3.w - xlv_TEXCOORD3.y), 0.0);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.y), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD2.w - -0.1) / 0.2), 0.0, 1.0);
  cloudCol_1.w = ((texCol_2.w * (tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  )) * (tmpvar_9 * (tmpvar_9 * 
    (3.0 - (2.0 * tmpvar_9))
  )));
  mediump float x_10;
  x_10 = (cloudCol_1.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.z), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  cloudCol_1.xyz = ((mix (xlv_TEXCOORD8, xlv_TEXCOORD7, texCol_2.xxx) + (xlv_TEXCOORD6 * 
    mix (texCol_2.y, ((1.0 - (tmpvar_11 * 
      (tmpvar_11 * (3.0 - (2.0 * tmpvar_11)))
    )) * 4.0), xlv_TEXCOORD3.w)
  )) + ((0.4 * xlv_TEXCOORD7) * _ES_CloudCoverage));
  cloudCol_1.xyz = (cloudCol_1.xyz + (xlv_TEXCOORD5 * texCol_2.x));
  cloudCol_1.xyz = (cloudCol_1.xyz * (xlv_TEXCOORD3.x + 1.0));
  mediump float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD2.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((_ES_CloudCoverage - 0.4) / 0.3), 0.0, 1.0);
  cloudCol_1.xyz = mix (xlv_TEXCOORD4, cloudCol_1.xyz, vec3(mix (clamp (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
  , 0.0, 1.0), 1.0, (tmpvar_13 * 
    (tmpvar_13 * (3.0 - (2.0 * tmpvar_13)))
  ))));
  cloudCol_1.w = clamp (cloudCol_1.w, 0.0, 1.0);
  gl_FragData[0] = cloudCol_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "FIXED_SPRITE_ID" "FIXED_EDGE_SMOOTHNESS" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec4 _ES_TopFrontColor;
uniform mediump vec4 _ES_TopBackColor;
uniform mediump vec4 _ES_BottomFrontColor;
uniform mediump vec4 _ES_BottomBackColor;
uniform mediump float _ES_SkyFrontAndBackBlendFactor;
uniform mediump float _ES_BottomColorHeight;
uniform mediump vec3 _ES_HorizonHaloColor;
uniform mediump float _ES_HorizonHaloIntensity;
uniform mediump float _ES_HorizonHaloHeight;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump float _ES_SunHaloSize;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudAgePercent;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform sampler2D _SkyGradientTex;
uniform highp vec2 _AtlasTiles;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
uniform highp int _FixedSpriteId;
uniform mediump float _FixedEdgeSmoothness;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float agePercent_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 clipPos_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  clipPos_6.xyw = tmpvar_7.xyw;
  clipPos_6.z = tmpvar_7.w;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7.xyww * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = clipPos_6.zw;
  highp vec2 tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = float(_FixedSpriteId);
  tmpvar_12.x = (float(mod (tmpvar_13, _AtlasTiles.x)));
  tmpvar_12.y = floor((tmpvar_13 / _AtlasTiles.x));
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy + tmpvar_12) / _AtlasTiles);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _CloudCurlTiling) + ((_ES_CloudElapsedTime * vec2(1.2, 0.8)) * _CloudCurlSpeed));
  mediump vec3 viewDir_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(((unity_ObjectToWorld * tmpvar_15).xyz - _ES_SkyCenterWorldPos));
  viewDir_14 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (_ES_SkyWorldUpDir, viewDir_14);
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = viewDir_14;
  tmpvar_18.w = ((sign(tmpvar_17) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_17))) * (1.570796 + (abs(tmpvar_17) * (-0.2146018 + 
      (abs(tmpvar_17) * (0.08656672 + (abs(tmpvar_17) * -0.03102955)))
    ))))
  )) * 0.6366198);
  mediump float tmpvar_19;
  tmpvar_19 = dot (viewDir_14, _ES_SunDirection);
  mediump float tmpvar_20;
  tmpvar_20 = ((tmpvar_19 * 0.5) + 0.5);
  tmpvar_4.x = (tmpvar_20 * _ES_CloudSunBrightenIntensity);
  tmpvar_4.y = _FixedEdgeSmoothness;
  tmpvar_4.z = _glesColor.w;
  highp float tmpvar_21;
  tmpvar_21 = (_glesMultiTexCoord1.y / max (_glesMultiTexCoord1.x, 1e-05));
  agePercent_2 = tmpvar_21;
  agePercent_2 = (agePercent_2 * _ES_CloudAgePercent);
  highp float tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = clamp ((agePercent_2 / _glesMultiTexCoord1.z), 0.0, 1.0);
  tmpvar_22 = (tmpvar_23 * (tmpvar_23 * (3.0 - 
    (2.0 * tmpvar_23)
  )));
  highp float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((agePercent_2 - _glesMultiTexCoord1.w) / (1.0 - _glesMultiTexCoord1.w)), 0.0, 1.0);
  tmpvar_24 = (tmpvar_25 * (tmpvar_25 * (3.0 - 
    (2.0 * tmpvar_25)
  )));
  tmpvar_4.w = (1.0 - (tmpvar_22 * (1.0 - tmpvar_24)));
  mediump vec3 atomosphere_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (_ES_SunDirection, viewDir_14);
  mediump float tmpvar_28;
  tmpvar_28 = max (((tmpvar_27 * _ES_SkyFrontAndBackBlendFactor) + (1.0 - _ES_SkyFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_29;
  tmpvar_29 = ((tmpvar_28 * tmpvar_28) * tmpvar_28);
  mediump vec4 tmpvar_30;
  tmpvar_30.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_30.x = (abs(tmpvar_18.w) / max (_ES_BottomColorHeight, 0.0001));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DLod (_SkyGradientTex, tmpvar_30.xy, 0.0);
  mediump float tmpvar_32;
  tmpvar_32 = tmpvar_31.x;
  atomosphere_26 = mix (mix (_ES_TopBackColor, _ES_TopFrontColor, vec4(tmpvar_29)).xyz, mix (_ES_BottomBackColor, _ES_BottomFrontColor, vec4(tmpvar_29)).xyz, vec3(tmpvar_32));
  mediump vec4 tmpvar_33;
  tmpvar_33.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_33.x = (abs(tmpvar_18.w) / max (_ES_HorizonHaloHeight, 0.0001));
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DLod (_SkyGradientTex, tmpvar_33.xy, 0.0);
  mediump float tmpvar_35;
  tmpvar_35 = tmpvar_34.y;
  mediump float tmpvar_36;
  tmpvar_36 = clamp (((
    max (((tmpvar_27 * 0.5) + 0.5), 0.0)
   - 0.3) / 0.7), 0.0, 1.0);
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    abs(_ES_SunDirection.y)
   - 0.2) / 0.3), 0.0, 1.0);
  atomosphere_26 = (atomosphere_26 + ((
    (_ES_HorizonHaloColor * _ES_HorizonHaloIntensity)
   * tmpvar_35) * mix (
    (tmpvar_36 * (tmpvar_36 * (3.0 - (2.0 * tmpvar_36))))
  , 1.0, 
    (tmpvar_37 * (tmpvar_37 * (3.0 - (2.0 * tmpvar_37))))
  )));
  highp vec3 viewDir_38;
  viewDir_38 = tmpvar_18.xyz;
  highp float haloInfluence_39;
  mediump float vertical_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((
    dot (_ES_SunDirection, viewDir_38)
   * 0.5) + 0.5), 0.0, 1.0);
  highp float tmpvar_42;
  tmpvar_42 = dot (viewDir_38, _ES_SkyWorldUpDir);
  vertical_40 = tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = abs(vertical_40);
  mediump float y_44;
  y_44 = (_ES_SunHaloSize * tmpvar_43);
  mediump float y_45;
  y_45 = ((_ES_SunHaloSize * 0.1) * tmpvar_43);
  haloInfluence_39 = (clamp (pow (tmpvar_41, y_44), 0.0, 1.0) + (clamp (
    pow (tmpvar_41, y_45)
  , 0.0, 1.0) * 0.12));
  mediump float y_46;
  y_46 = ((_ES_SunHaloSize * 0.01) * tmpvar_43);
  haloInfluence_39 = (haloInfluence_39 + (clamp (
    pow (tmpvar_41, y_46)
  , 0.0, 1.0) * 0.03));
  highp float tmpvar_47;
  tmpvar_47 = clamp (((
    max (((dot (_ES_SunDirection, viewDir_38) * 0.5) + 0.5), 0.0)
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 tmpvar_48;
  tmpvar_48 = (((haloInfluence_39 * _ES_SunHaloIntensity) * _ES_SunHaloColor) * (tmpvar_47 * (tmpvar_47 * 
    (3.0 - (2.0 * tmpvar_47))
  )));
  tmpvar_5 = (atomosphere_26 + tmpvar_48);
  mediump float tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_49 = (tmpvar_50 * (tmpvar_50 * (3.0 - 
    (2.0 * tmpvar_50)
  )));
  highp vec3 viewDir_51;
  viewDir_51 = tmpvar_18.xyz;
  mediump float moonLunarCancel_52;
  mediump float tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (_ES_MoonDirection, viewDir_51), 0.0, 1.0);
  tmpvar_53 = tmpvar_54;
  highp float tmpvar_55;
  mediump float tmpvar_56;
  tmpvar_56 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_55 = (1.0 - (tmpvar_56 * 2.0));
  moonLunarCancel_52 = tmpvar_55;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((
    ((tmpvar_53 * tmpvar_53) * ((tmpvar_53 * tmpvar_53) * tmpvar_53))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_58;
  viewDir_58 = tmpvar_18.xyz;
  mediump float vertical_59;
  mediump float tmpvar_60;
  highp float tmpvar_61;
  tmpvar_61 = clamp (((
    dot (_ES_SunDirection, viewDir_58)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_60 = tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = dot (viewDir_58, _ES_SkyWorldUpDir);
  vertical_59 = tmpvar_62;
  mediump float tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = (1.0 - _ES_SunRimLightRadius);
  tmpvar_63 = clamp (((tmpvar_20 - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (((tmpvar_63 * 
    (tmpvar_63 * (3.0 - (2.0 * tmpvar_63)))
  ) * _ES_SunBrightness) * 0.125);
  mediump float tmpvar_66;
  tmpvar_66 = clamp (((
    ((dot (viewDir_14, _ES_MoonDirection) * 0.5) + 0.5)
   - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_67;
  tmpvar_67 = (((tmpvar_66 * 
    (tmpvar_66 * (3.0 - (2.0 * tmpvar_66)))
  ) * _ES_MoonBrightness) * 0.1);
  mediump float tmpvar_68;
  tmpvar_68 = max (((tmpvar_19 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_69;
  tmpvar_69 = ((tmpvar_68 * tmpvar_68) * tmpvar_68);
  gl_Position = clipPos_6;
  xlv_TEXCOORD0 = o_9;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = (((
    ((((tmpvar_57 * 
      (tmpvar_57 * (3.0 - (2.0 * tmpvar_57)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_52) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_60, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_59))
    ) * vertical_59), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_49);
  xlv_TEXCOORD6 = (((_ES_SunHaloColor * 
    (tmpvar_65 * tmpvar_65)
  ) + (_ES_MoonColor * 
    (tmpvar_67 * tmpvar_67)
  )) * tmpvar_49);
  xlv_TEXCOORD7 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_69));
  xlv_TEXCOORD8 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_69));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_CloudCoverage;
uniform sampler2D _CloudParticleAtlas;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 cloudCol_1;
  mediump vec4 texCol_2;
  highp vec3 curlNoise_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_CloudCurlTex, xlv_TEXCOORD1.zw).xyz;
  curlNoise_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD1.xy + ((
    (curlNoise_3.xy - 0.5)
   * curlNoise_3.z) * _CloudCurlAmplitude));
  tmpvar_5 = texture2D (_CloudParticleAtlas, P_6);
  texCol_2 = tmpvar_5;
  mediump float tmpvar_7;
  tmpvar_7 = max ((xlv_TEXCOORD3.w - xlv_TEXCOORD3.y), 0.0);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.y), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD2.w - -0.1) / 0.2), 0.0, 1.0);
  cloudCol_1.w = ((texCol_2.w * (tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  )) * (tmpvar_9 * (tmpvar_9 * 
    (3.0 - (2.0 * tmpvar_9))
  )));
  mediump float x_10;
  x_10 = (cloudCol_1.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.z), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  cloudCol_1.xyz = ((mix (xlv_TEXCOORD8, xlv_TEXCOORD7, texCol_2.xxx) + (xlv_TEXCOORD6 * 
    mix (texCol_2.y, ((1.0 - (tmpvar_11 * 
      (tmpvar_11 * (3.0 - (2.0 * tmpvar_11)))
    )) * 4.0), xlv_TEXCOORD3.w)
  )) + ((0.4 * xlv_TEXCOORD7) * _ES_CloudCoverage));
  cloudCol_1.xyz = (cloudCol_1.xyz + (xlv_TEXCOORD5 * texCol_2.x));
  cloudCol_1.xyz = (cloudCol_1.xyz * (xlv_TEXCOORD3.x + 1.0));
  mediump float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD2.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((_ES_CloudCoverage - 0.4) / 0.3), 0.0, 1.0);
  cloudCol_1.xyz = mix (xlv_TEXCOORD4, cloudCol_1.xyz, vec3(mix (clamp (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
  , 0.0, 1.0), 1.0, (tmpvar_13 * 
    (tmpvar_13 * (3.0 - (2.0 * tmpvar_13)))
  ))));
  cloudCol_1.w = clamp (cloudCol_1.w, 0.0, 1.0);
  gl_FragData[0] = cloudCol_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "FIXED_SPRITE_ID" "FIXED_EDGE_SMOOTHNESS" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec4 _ES_TopFrontColor;
uniform mediump vec4 _ES_TopBackColor;
uniform mediump vec4 _ES_BottomFrontColor;
uniform mediump vec4 _ES_BottomBackColor;
uniform mediump float _ES_SkyFrontAndBackBlendFactor;
uniform mediump float _ES_BottomColorHeight;
uniform mediump vec3 _ES_HorizonHaloColor;
uniform mediump float _ES_HorizonHaloIntensity;
uniform mediump float _ES_HorizonHaloHeight;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump float _ES_SunHaloSize;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudAgePercent;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform sampler2D _SkyGradientTex;
uniform highp vec2 _AtlasTiles;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
uniform highp int _FixedSpriteId;
uniform mediump float _FixedEdgeSmoothness;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float agePercent_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 clipPos_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  clipPos_6.xyw = tmpvar_7.xyw;
  clipPos_6.z = tmpvar_7.w;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7.xyww * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = clipPos_6.zw;
  highp vec2 tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = float(_FixedSpriteId);
  tmpvar_12.x = (float(mod (tmpvar_13, _AtlasTiles.x)));
  tmpvar_12.y = floor((tmpvar_13 / _AtlasTiles.x));
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy + tmpvar_12) / _AtlasTiles);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _CloudCurlTiling) + ((_ES_CloudElapsedTime * vec2(1.2, 0.8)) * _CloudCurlSpeed));
  mediump vec3 viewDir_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(((unity_ObjectToWorld * tmpvar_15).xyz - _ES_SkyCenterWorldPos));
  viewDir_14 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (_ES_SkyWorldUpDir, viewDir_14);
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = viewDir_14;
  tmpvar_18.w = ((sign(tmpvar_17) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_17))) * (1.570796 + (abs(tmpvar_17) * (-0.2146018 + 
      (abs(tmpvar_17) * (0.08656672 + (abs(tmpvar_17) * -0.03102955)))
    ))))
  )) * 0.6366198);
  mediump float tmpvar_19;
  tmpvar_19 = dot (viewDir_14, _ES_SunDirection);
  mediump float tmpvar_20;
  tmpvar_20 = ((tmpvar_19 * 0.5) + 0.5);
  tmpvar_4.x = (tmpvar_20 * _ES_CloudSunBrightenIntensity);
  tmpvar_4.y = _FixedEdgeSmoothness;
  tmpvar_4.z = _glesColor.w;
  highp float tmpvar_21;
  tmpvar_21 = (_glesMultiTexCoord1.y / max (_glesMultiTexCoord1.x, 1e-05));
  agePercent_2 = tmpvar_21;
  agePercent_2 = (agePercent_2 * _ES_CloudAgePercent);
  highp float tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = clamp ((agePercent_2 / _glesMultiTexCoord1.z), 0.0, 1.0);
  tmpvar_22 = (tmpvar_23 * (tmpvar_23 * (3.0 - 
    (2.0 * tmpvar_23)
  )));
  highp float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((agePercent_2 - _glesMultiTexCoord1.w) / (1.0 - _glesMultiTexCoord1.w)), 0.0, 1.0);
  tmpvar_24 = (tmpvar_25 * (tmpvar_25 * (3.0 - 
    (2.0 * tmpvar_25)
  )));
  tmpvar_4.w = (1.0 - (tmpvar_22 * (1.0 - tmpvar_24)));
  mediump vec3 atomosphere_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (_ES_SunDirection, viewDir_14);
  mediump float tmpvar_28;
  tmpvar_28 = max (((tmpvar_27 * _ES_SkyFrontAndBackBlendFactor) + (1.0 - _ES_SkyFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_29;
  tmpvar_29 = ((tmpvar_28 * tmpvar_28) * tmpvar_28);
  mediump vec4 tmpvar_30;
  tmpvar_30.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_30.x = (abs(tmpvar_18.w) / max (_ES_BottomColorHeight, 0.0001));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DLod (_SkyGradientTex, tmpvar_30.xy, 0.0);
  mediump float tmpvar_32;
  tmpvar_32 = tmpvar_31.x;
  atomosphere_26 = mix (mix (_ES_TopBackColor, _ES_TopFrontColor, vec4(tmpvar_29)).xyz, mix (_ES_BottomBackColor, _ES_BottomFrontColor, vec4(tmpvar_29)).xyz, vec3(tmpvar_32));
  mediump vec4 tmpvar_33;
  tmpvar_33.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_33.x = (abs(tmpvar_18.w) / max (_ES_HorizonHaloHeight, 0.0001));
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DLod (_SkyGradientTex, tmpvar_33.xy, 0.0);
  mediump float tmpvar_35;
  tmpvar_35 = tmpvar_34.y;
  mediump float tmpvar_36;
  tmpvar_36 = clamp (((
    max (((tmpvar_27 * 0.5) + 0.5), 0.0)
   - 0.3) / 0.7), 0.0, 1.0);
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    abs(_ES_SunDirection.y)
   - 0.2) / 0.3), 0.0, 1.0);
  atomosphere_26 = (atomosphere_26 + ((
    (_ES_HorizonHaloColor * _ES_HorizonHaloIntensity)
   * tmpvar_35) * mix (
    (tmpvar_36 * (tmpvar_36 * (3.0 - (2.0 * tmpvar_36))))
  , 1.0, 
    (tmpvar_37 * (tmpvar_37 * (3.0 - (2.0 * tmpvar_37))))
  )));
  highp vec3 viewDir_38;
  viewDir_38 = tmpvar_18.xyz;
  highp float haloInfluence_39;
  mediump float vertical_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((
    dot (_ES_SunDirection, viewDir_38)
   * 0.5) + 0.5), 0.0, 1.0);
  highp float tmpvar_42;
  tmpvar_42 = dot (viewDir_38, _ES_SkyWorldUpDir);
  vertical_40 = tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = abs(vertical_40);
  mediump float y_44;
  y_44 = (_ES_SunHaloSize * tmpvar_43);
  mediump float y_45;
  y_45 = ((_ES_SunHaloSize * 0.1) * tmpvar_43);
  haloInfluence_39 = (clamp (pow (tmpvar_41, y_44), 0.0, 1.0) + (clamp (
    pow (tmpvar_41, y_45)
  , 0.0, 1.0) * 0.12));
  mediump float y_46;
  y_46 = ((_ES_SunHaloSize * 0.01) * tmpvar_43);
  haloInfluence_39 = (haloInfluence_39 + (clamp (
    pow (tmpvar_41, y_46)
  , 0.0, 1.0) * 0.03));
  highp float tmpvar_47;
  tmpvar_47 = clamp (((
    max (((dot (_ES_SunDirection, viewDir_38) * 0.5) + 0.5), 0.0)
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 tmpvar_48;
  tmpvar_48 = (((haloInfluence_39 * _ES_SunHaloIntensity) * _ES_SunHaloColor) * (tmpvar_47 * (tmpvar_47 * 
    (3.0 - (2.0 * tmpvar_47))
  )));
  tmpvar_5 = (atomosphere_26 + tmpvar_48);
  mediump float tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_49 = (tmpvar_50 * (tmpvar_50 * (3.0 - 
    (2.0 * tmpvar_50)
  )));
  highp vec3 viewDir_51;
  viewDir_51 = tmpvar_18.xyz;
  mediump float moonLunarCancel_52;
  mediump float tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (_ES_MoonDirection, viewDir_51), 0.0, 1.0);
  tmpvar_53 = tmpvar_54;
  highp float tmpvar_55;
  mediump float tmpvar_56;
  tmpvar_56 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_55 = (1.0 - (tmpvar_56 * 2.0));
  moonLunarCancel_52 = tmpvar_55;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((
    ((tmpvar_53 * tmpvar_53) * ((tmpvar_53 * tmpvar_53) * tmpvar_53))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_58;
  viewDir_58 = tmpvar_18.xyz;
  mediump float vertical_59;
  mediump float tmpvar_60;
  highp float tmpvar_61;
  tmpvar_61 = clamp (((
    dot (_ES_SunDirection, viewDir_58)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_60 = tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = dot (viewDir_58, _ES_SkyWorldUpDir);
  vertical_59 = tmpvar_62;
  mediump float tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = (1.0 - _ES_SunRimLightRadius);
  tmpvar_63 = clamp (((tmpvar_20 - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (((tmpvar_63 * 
    (tmpvar_63 * (3.0 - (2.0 * tmpvar_63)))
  ) * _ES_SunBrightness) * 0.125);
  mediump float tmpvar_66;
  tmpvar_66 = clamp (((
    ((dot (viewDir_14, _ES_MoonDirection) * 0.5) + 0.5)
   - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_67;
  tmpvar_67 = (((tmpvar_66 * 
    (tmpvar_66 * (3.0 - (2.0 * tmpvar_66)))
  ) * _ES_MoonBrightness) * 0.1);
  mediump float tmpvar_68;
  tmpvar_68 = max (((tmpvar_19 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_69;
  tmpvar_69 = ((tmpvar_68 * tmpvar_68) * tmpvar_68);
  gl_Position = clipPos_6;
  xlv_TEXCOORD0 = o_9;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = (((
    ((((tmpvar_57 * 
      (tmpvar_57 * (3.0 - (2.0 * tmpvar_57)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_52) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_60, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_59))
    ) * vertical_59), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_49);
  xlv_TEXCOORD6 = (((_ES_SunHaloColor * 
    (tmpvar_65 * tmpvar_65)
  ) + (_ES_MoonColor * 
    (tmpvar_67 * tmpvar_67)
  )) * tmpvar_49);
  xlv_TEXCOORD7 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_69));
  xlv_TEXCOORD8 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_69));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_CloudCoverage;
uniform sampler2D _CloudParticleAtlas;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 cloudCol_1;
  mediump vec4 texCol_2;
  highp vec3 curlNoise_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_CloudCurlTex, xlv_TEXCOORD1.zw).xyz;
  curlNoise_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD1.xy + ((
    (curlNoise_3.xy - 0.5)
   * curlNoise_3.z) * _CloudCurlAmplitude));
  tmpvar_5 = texture2D (_CloudParticleAtlas, P_6);
  texCol_2 = tmpvar_5;
  mediump float tmpvar_7;
  tmpvar_7 = max ((xlv_TEXCOORD3.w - xlv_TEXCOORD3.y), 0.0);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.y), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD2.w - -0.1) / 0.2), 0.0, 1.0);
  cloudCol_1.w = ((texCol_2.w * (tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  )) * (tmpvar_9 * (tmpvar_9 * 
    (3.0 - (2.0 * tmpvar_9))
  )));
  mediump float x_10;
  x_10 = (cloudCol_1.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.z), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  cloudCol_1.xyz = ((mix (xlv_TEXCOORD8, xlv_TEXCOORD7, texCol_2.xxx) + (xlv_TEXCOORD6 * 
    mix (texCol_2.y, ((1.0 - (tmpvar_11 * 
      (tmpvar_11 * (3.0 - (2.0 * tmpvar_11)))
    )) * 4.0), xlv_TEXCOORD3.w)
  )) + ((0.4 * xlv_TEXCOORD7) * _ES_CloudCoverage));
  cloudCol_1.xyz = (cloudCol_1.xyz + (xlv_TEXCOORD5 * texCol_2.x));
  cloudCol_1.xyz = (cloudCol_1.xyz * (xlv_TEXCOORD3.x + 1.0));
  mediump float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD2.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((_ES_CloudCoverage - 0.4) / 0.3), 0.0, 1.0);
  cloudCol_1.xyz = mix (xlv_TEXCOORD4, cloudCol_1.xyz, vec3(mix (clamp (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
  , 0.0, 1.0), 1.0, (tmpvar_13 * 
    (tmpvar_13 * (3.0 - (2.0 * tmpvar_13)))
  ))));
  cloudCol_1.w = clamp (cloudCol_1.w, 0.0, 1.0);
  gl_FragData[0] = cloudCol_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FIXED_SPRITE_ID" "FIXED_EDGE_SMOOTHNESS" "FIXED_RIMLIGHT_WIDTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec4 _ES_TopFrontColor;
uniform mediump vec4 _ES_TopBackColor;
uniform mediump vec4 _ES_BottomFrontColor;
uniform mediump vec4 _ES_BottomBackColor;
uniform mediump float _ES_SkyFrontAndBackBlendFactor;
uniform mediump float _ES_BottomColorHeight;
uniform mediump vec3 _ES_HorizonHaloColor;
uniform mediump float _ES_HorizonHaloIntensity;
uniform mediump float _ES_HorizonHaloHeight;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump float _ES_SunHaloSize;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudAgePercent;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform sampler2D _SkyGradientTex;
uniform highp vec2 _AtlasTiles;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
uniform highp int _FixedSpriteId;
uniform mediump float _FixedEdgeSmoothness;
uniform mediump float _FixedRimLightWidth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float agePercent_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 clipPos_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  clipPos_6.xyw = tmpvar_7.xyw;
  clipPos_6.z = tmpvar_7.w;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7.xyww * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = clipPos_6.zw;
  highp vec2 tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = float(_FixedSpriteId);
  tmpvar_12.x = (float(mod (tmpvar_13, _AtlasTiles.x)));
  tmpvar_12.y = floor((tmpvar_13 / _AtlasTiles.x));
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy + tmpvar_12) / _AtlasTiles);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _CloudCurlTiling) + ((_ES_CloudElapsedTime * vec2(1.2, 0.8)) * _CloudCurlSpeed));
  mediump vec3 viewDir_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(((unity_ObjectToWorld * tmpvar_15).xyz - _ES_SkyCenterWorldPos));
  viewDir_14 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (_ES_SkyWorldUpDir, viewDir_14);
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = viewDir_14;
  tmpvar_18.w = ((sign(tmpvar_17) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_17))) * (1.570796 + (abs(tmpvar_17) * (-0.2146018 + 
      (abs(tmpvar_17) * (0.08656672 + (abs(tmpvar_17) * -0.03102955)))
    ))))
  )) * 0.6366198);
  mediump float tmpvar_19;
  tmpvar_19 = dot (viewDir_14, _ES_SunDirection);
  mediump float tmpvar_20;
  tmpvar_20 = ((tmpvar_19 * 0.5) + 0.5);
  tmpvar_4.x = (tmpvar_20 * _ES_CloudSunBrightenIntensity);
  tmpvar_4.y = _FixedEdgeSmoothness;
  tmpvar_4.z = _FixedRimLightWidth;
  highp float tmpvar_21;
  tmpvar_21 = (_glesMultiTexCoord1.y / max (_glesMultiTexCoord1.x, 1e-05));
  agePercent_2 = tmpvar_21;
  agePercent_2 = (agePercent_2 * _ES_CloudAgePercent);
  highp float tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = clamp ((agePercent_2 / _glesMultiTexCoord1.z), 0.0, 1.0);
  tmpvar_22 = (tmpvar_23 * (tmpvar_23 * (3.0 - 
    (2.0 * tmpvar_23)
  )));
  highp float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((agePercent_2 - _glesMultiTexCoord1.w) / (1.0 - _glesMultiTexCoord1.w)), 0.0, 1.0);
  tmpvar_24 = (tmpvar_25 * (tmpvar_25 * (3.0 - 
    (2.0 * tmpvar_25)
  )));
  tmpvar_4.w = (1.0 - (tmpvar_22 * (1.0 - tmpvar_24)));
  mediump vec3 atomosphere_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (_ES_SunDirection, viewDir_14);
  mediump float tmpvar_28;
  tmpvar_28 = max (((tmpvar_27 * _ES_SkyFrontAndBackBlendFactor) + (1.0 - _ES_SkyFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_29;
  tmpvar_29 = ((tmpvar_28 * tmpvar_28) * tmpvar_28);
  mediump vec4 tmpvar_30;
  tmpvar_30.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_30.x = (abs(tmpvar_18.w) / max (_ES_BottomColorHeight, 0.0001));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DLod (_SkyGradientTex, tmpvar_30.xy, 0.0);
  mediump float tmpvar_32;
  tmpvar_32 = tmpvar_31.x;
  atomosphere_26 = mix (mix (_ES_TopBackColor, _ES_TopFrontColor, vec4(tmpvar_29)).xyz, mix (_ES_BottomBackColor, _ES_BottomFrontColor, vec4(tmpvar_29)).xyz, vec3(tmpvar_32));
  mediump vec4 tmpvar_33;
  tmpvar_33.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_33.x = (abs(tmpvar_18.w) / max (_ES_HorizonHaloHeight, 0.0001));
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DLod (_SkyGradientTex, tmpvar_33.xy, 0.0);
  mediump float tmpvar_35;
  tmpvar_35 = tmpvar_34.y;
  mediump float tmpvar_36;
  tmpvar_36 = clamp (((
    max (((tmpvar_27 * 0.5) + 0.5), 0.0)
   - 0.3) / 0.7), 0.0, 1.0);
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    abs(_ES_SunDirection.y)
   - 0.2) / 0.3), 0.0, 1.0);
  atomosphere_26 = (atomosphere_26 + ((
    (_ES_HorizonHaloColor * _ES_HorizonHaloIntensity)
   * tmpvar_35) * mix (
    (tmpvar_36 * (tmpvar_36 * (3.0 - (2.0 * tmpvar_36))))
  , 1.0, 
    (tmpvar_37 * (tmpvar_37 * (3.0 - (2.0 * tmpvar_37))))
  )));
  highp vec3 viewDir_38;
  viewDir_38 = tmpvar_18.xyz;
  highp float haloInfluence_39;
  mediump float vertical_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((
    dot (_ES_SunDirection, viewDir_38)
   * 0.5) + 0.5), 0.0, 1.0);
  highp float tmpvar_42;
  tmpvar_42 = dot (viewDir_38, _ES_SkyWorldUpDir);
  vertical_40 = tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = abs(vertical_40);
  mediump float y_44;
  y_44 = (_ES_SunHaloSize * tmpvar_43);
  mediump float y_45;
  y_45 = ((_ES_SunHaloSize * 0.1) * tmpvar_43);
  haloInfluence_39 = (clamp (pow (tmpvar_41, y_44), 0.0, 1.0) + (clamp (
    pow (tmpvar_41, y_45)
  , 0.0, 1.0) * 0.12));
  mediump float y_46;
  y_46 = ((_ES_SunHaloSize * 0.01) * tmpvar_43);
  haloInfluence_39 = (haloInfluence_39 + (clamp (
    pow (tmpvar_41, y_46)
  , 0.0, 1.0) * 0.03));
  highp float tmpvar_47;
  tmpvar_47 = clamp (((
    max (((dot (_ES_SunDirection, viewDir_38) * 0.5) + 0.5), 0.0)
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 tmpvar_48;
  tmpvar_48 = (((haloInfluence_39 * _ES_SunHaloIntensity) * _ES_SunHaloColor) * (tmpvar_47 * (tmpvar_47 * 
    (3.0 - (2.0 * tmpvar_47))
  )));
  tmpvar_5 = (atomosphere_26 + tmpvar_48);
  mediump float tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_49 = (tmpvar_50 * (tmpvar_50 * (3.0 - 
    (2.0 * tmpvar_50)
  )));
  highp vec3 viewDir_51;
  viewDir_51 = tmpvar_18.xyz;
  mediump float moonLunarCancel_52;
  mediump float tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (_ES_MoonDirection, viewDir_51), 0.0, 1.0);
  tmpvar_53 = tmpvar_54;
  highp float tmpvar_55;
  mediump float tmpvar_56;
  tmpvar_56 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_55 = (1.0 - (tmpvar_56 * 2.0));
  moonLunarCancel_52 = tmpvar_55;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((
    ((tmpvar_53 * tmpvar_53) * ((tmpvar_53 * tmpvar_53) * tmpvar_53))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_58;
  viewDir_58 = tmpvar_18.xyz;
  mediump float vertical_59;
  mediump float tmpvar_60;
  highp float tmpvar_61;
  tmpvar_61 = clamp (((
    dot (_ES_SunDirection, viewDir_58)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_60 = tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = dot (viewDir_58, _ES_SkyWorldUpDir);
  vertical_59 = tmpvar_62;
  mediump float tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = (1.0 - _ES_SunRimLightRadius);
  tmpvar_63 = clamp (((tmpvar_20 - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (((tmpvar_63 * 
    (tmpvar_63 * (3.0 - (2.0 * tmpvar_63)))
  ) * _ES_SunBrightness) * 0.125);
  mediump float tmpvar_66;
  tmpvar_66 = clamp (((
    ((dot (viewDir_14, _ES_MoonDirection) * 0.5) + 0.5)
   - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_67;
  tmpvar_67 = (((tmpvar_66 * 
    (tmpvar_66 * (3.0 - (2.0 * tmpvar_66)))
  ) * _ES_MoonBrightness) * 0.1);
  mediump float tmpvar_68;
  tmpvar_68 = max (((tmpvar_19 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_69;
  tmpvar_69 = ((tmpvar_68 * tmpvar_68) * tmpvar_68);
  gl_Position = clipPos_6;
  xlv_TEXCOORD0 = o_9;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = (((
    ((((tmpvar_57 * 
      (tmpvar_57 * (3.0 - (2.0 * tmpvar_57)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_52) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_60, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_59))
    ) * vertical_59), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_49);
  xlv_TEXCOORD6 = (((_ES_SunHaloColor * 
    (tmpvar_65 * tmpvar_65)
  ) + (_ES_MoonColor * 
    (tmpvar_67 * tmpvar_67)
  )) * tmpvar_49);
  xlv_TEXCOORD7 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_69));
  xlv_TEXCOORD8 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_69));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_CloudCoverage;
uniform sampler2D _CloudParticleAtlas;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 cloudCol_1;
  mediump vec4 texCol_2;
  highp vec3 curlNoise_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_CloudCurlTex, xlv_TEXCOORD1.zw).xyz;
  curlNoise_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD1.xy + ((
    (curlNoise_3.xy - 0.5)
   * curlNoise_3.z) * _CloudCurlAmplitude));
  tmpvar_5 = texture2D (_CloudParticleAtlas, P_6);
  texCol_2 = tmpvar_5;
  mediump float tmpvar_7;
  tmpvar_7 = max ((xlv_TEXCOORD3.w - xlv_TEXCOORD3.y), 0.0);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.y), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD2.w - -0.1) / 0.2), 0.0, 1.0);
  cloudCol_1.w = ((texCol_2.w * (tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  )) * (tmpvar_9 * (tmpvar_9 * 
    (3.0 - (2.0 * tmpvar_9))
  )));
  mediump float x_10;
  x_10 = (cloudCol_1.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.z), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  cloudCol_1.xyz = ((mix (xlv_TEXCOORD8, xlv_TEXCOORD7, texCol_2.xxx) + (xlv_TEXCOORD6 * 
    mix (texCol_2.y, ((1.0 - (tmpvar_11 * 
      (tmpvar_11 * (3.0 - (2.0 * tmpvar_11)))
    )) * 4.0), xlv_TEXCOORD3.w)
  )) + ((0.4 * xlv_TEXCOORD7) * _ES_CloudCoverage));
  cloudCol_1.xyz = (cloudCol_1.xyz + (xlv_TEXCOORD5 * texCol_2.x));
  cloudCol_1.xyz = (cloudCol_1.xyz * (xlv_TEXCOORD3.x + 1.0));
  mediump float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD2.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((_ES_CloudCoverage - 0.4) / 0.3), 0.0, 1.0);
  cloudCol_1.xyz = mix (xlv_TEXCOORD4, cloudCol_1.xyz, vec3(mix (clamp (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
  , 0.0, 1.0), 1.0, (tmpvar_13 * 
    (tmpvar_13 * (3.0 - (2.0 * tmpvar_13)))
  ))));
  cloudCol_1.w = clamp (cloudCol_1.w, 0.0, 1.0);
  gl_FragData[0] = cloudCol_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FIXED_SPRITE_ID" "FIXED_EDGE_SMOOTHNESS" "FIXED_RIMLIGHT_WIDTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec4 _ES_TopFrontColor;
uniform mediump vec4 _ES_TopBackColor;
uniform mediump vec4 _ES_BottomFrontColor;
uniform mediump vec4 _ES_BottomBackColor;
uniform mediump float _ES_SkyFrontAndBackBlendFactor;
uniform mediump float _ES_BottomColorHeight;
uniform mediump vec3 _ES_HorizonHaloColor;
uniform mediump float _ES_HorizonHaloIntensity;
uniform mediump float _ES_HorizonHaloHeight;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump float _ES_SunHaloSize;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudAgePercent;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform sampler2D _SkyGradientTex;
uniform highp vec2 _AtlasTiles;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
uniform highp int _FixedSpriteId;
uniform mediump float _FixedEdgeSmoothness;
uniform mediump float _FixedRimLightWidth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float agePercent_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 clipPos_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  clipPos_6.xyw = tmpvar_7.xyw;
  clipPos_6.z = tmpvar_7.w;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7.xyww * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = clipPos_6.zw;
  highp vec2 tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = float(_FixedSpriteId);
  tmpvar_12.x = (float(mod (tmpvar_13, _AtlasTiles.x)));
  tmpvar_12.y = floor((tmpvar_13 / _AtlasTiles.x));
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy + tmpvar_12) / _AtlasTiles);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _CloudCurlTiling) + ((_ES_CloudElapsedTime * vec2(1.2, 0.8)) * _CloudCurlSpeed));
  mediump vec3 viewDir_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(((unity_ObjectToWorld * tmpvar_15).xyz - _ES_SkyCenterWorldPos));
  viewDir_14 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (_ES_SkyWorldUpDir, viewDir_14);
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = viewDir_14;
  tmpvar_18.w = ((sign(tmpvar_17) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_17))) * (1.570796 + (abs(tmpvar_17) * (-0.2146018 + 
      (abs(tmpvar_17) * (0.08656672 + (abs(tmpvar_17) * -0.03102955)))
    ))))
  )) * 0.6366198);
  mediump float tmpvar_19;
  tmpvar_19 = dot (viewDir_14, _ES_SunDirection);
  mediump float tmpvar_20;
  tmpvar_20 = ((tmpvar_19 * 0.5) + 0.5);
  tmpvar_4.x = (tmpvar_20 * _ES_CloudSunBrightenIntensity);
  tmpvar_4.y = _FixedEdgeSmoothness;
  tmpvar_4.z = _FixedRimLightWidth;
  highp float tmpvar_21;
  tmpvar_21 = (_glesMultiTexCoord1.y / max (_glesMultiTexCoord1.x, 1e-05));
  agePercent_2 = tmpvar_21;
  agePercent_2 = (agePercent_2 * _ES_CloudAgePercent);
  highp float tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = clamp ((agePercent_2 / _glesMultiTexCoord1.z), 0.0, 1.0);
  tmpvar_22 = (tmpvar_23 * (tmpvar_23 * (3.0 - 
    (2.0 * tmpvar_23)
  )));
  highp float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((agePercent_2 - _glesMultiTexCoord1.w) / (1.0 - _glesMultiTexCoord1.w)), 0.0, 1.0);
  tmpvar_24 = (tmpvar_25 * (tmpvar_25 * (3.0 - 
    (2.0 * tmpvar_25)
  )));
  tmpvar_4.w = (1.0 - (tmpvar_22 * (1.0 - tmpvar_24)));
  mediump vec3 atomosphere_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (_ES_SunDirection, viewDir_14);
  mediump float tmpvar_28;
  tmpvar_28 = max (((tmpvar_27 * _ES_SkyFrontAndBackBlendFactor) + (1.0 - _ES_SkyFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_29;
  tmpvar_29 = ((tmpvar_28 * tmpvar_28) * tmpvar_28);
  mediump vec4 tmpvar_30;
  tmpvar_30.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_30.x = (abs(tmpvar_18.w) / max (_ES_BottomColorHeight, 0.0001));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DLod (_SkyGradientTex, tmpvar_30.xy, 0.0);
  mediump float tmpvar_32;
  tmpvar_32 = tmpvar_31.x;
  atomosphere_26 = mix (mix (_ES_TopBackColor, _ES_TopFrontColor, vec4(tmpvar_29)).xyz, mix (_ES_BottomBackColor, _ES_BottomFrontColor, vec4(tmpvar_29)).xyz, vec3(tmpvar_32));
  mediump vec4 tmpvar_33;
  tmpvar_33.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_33.x = (abs(tmpvar_18.w) / max (_ES_HorizonHaloHeight, 0.0001));
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DLod (_SkyGradientTex, tmpvar_33.xy, 0.0);
  mediump float tmpvar_35;
  tmpvar_35 = tmpvar_34.y;
  mediump float tmpvar_36;
  tmpvar_36 = clamp (((
    max (((tmpvar_27 * 0.5) + 0.5), 0.0)
   - 0.3) / 0.7), 0.0, 1.0);
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    abs(_ES_SunDirection.y)
   - 0.2) / 0.3), 0.0, 1.0);
  atomosphere_26 = (atomosphere_26 + ((
    (_ES_HorizonHaloColor * _ES_HorizonHaloIntensity)
   * tmpvar_35) * mix (
    (tmpvar_36 * (tmpvar_36 * (3.0 - (2.0 * tmpvar_36))))
  , 1.0, 
    (tmpvar_37 * (tmpvar_37 * (3.0 - (2.0 * tmpvar_37))))
  )));
  highp vec3 viewDir_38;
  viewDir_38 = tmpvar_18.xyz;
  highp float haloInfluence_39;
  mediump float vertical_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((
    dot (_ES_SunDirection, viewDir_38)
   * 0.5) + 0.5), 0.0, 1.0);
  highp float tmpvar_42;
  tmpvar_42 = dot (viewDir_38, _ES_SkyWorldUpDir);
  vertical_40 = tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = abs(vertical_40);
  mediump float y_44;
  y_44 = (_ES_SunHaloSize * tmpvar_43);
  mediump float y_45;
  y_45 = ((_ES_SunHaloSize * 0.1) * tmpvar_43);
  haloInfluence_39 = (clamp (pow (tmpvar_41, y_44), 0.0, 1.0) + (clamp (
    pow (tmpvar_41, y_45)
  , 0.0, 1.0) * 0.12));
  mediump float y_46;
  y_46 = ((_ES_SunHaloSize * 0.01) * tmpvar_43);
  haloInfluence_39 = (haloInfluence_39 + (clamp (
    pow (tmpvar_41, y_46)
  , 0.0, 1.0) * 0.03));
  highp float tmpvar_47;
  tmpvar_47 = clamp (((
    max (((dot (_ES_SunDirection, viewDir_38) * 0.5) + 0.5), 0.0)
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 tmpvar_48;
  tmpvar_48 = (((haloInfluence_39 * _ES_SunHaloIntensity) * _ES_SunHaloColor) * (tmpvar_47 * (tmpvar_47 * 
    (3.0 - (2.0 * tmpvar_47))
  )));
  tmpvar_5 = (atomosphere_26 + tmpvar_48);
  mediump float tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_49 = (tmpvar_50 * (tmpvar_50 * (3.0 - 
    (2.0 * tmpvar_50)
  )));
  highp vec3 viewDir_51;
  viewDir_51 = tmpvar_18.xyz;
  mediump float moonLunarCancel_52;
  mediump float tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (_ES_MoonDirection, viewDir_51), 0.0, 1.0);
  tmpvar_53 = tmpvar_54;
  highp float tmpvar_55;
  mediump float tmpvar_56;
  tmpvar_56 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_55 = (1.0 - (tmpvar_56 * 2.0));
  moonLunarCancel_52 = tmpvar_55;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((
    ((tmpvar_53 * tmpvar_53) * ((tmpvar_53 * tmpvar_53) * tmpvar_53))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_58;
  viewDir_58 = tmpvar_18.xyz;
  mediump float vertical_59;
  mediump float tmpvar_60;
  highp float tmpvar_61;
  tmpvar_61 = clamp (((
    dot (_ES_SunDirection, viewDir_58)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_60 = tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = dot (viewDir_58, _ES_SkyWorldUpDir);
  vertical_59 = tmpvar_62;
  mediump float tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = (1.0 - _ES_SunRimLightRadius);
  tmpvar_63 = clamp (((tmpvar_20 - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (((tmpvar_63 * 
    (tmpvar_63 * (3.0 - (2.0 * tmpvar_63)))
  ) * _ES_SunBrightness) * 0.125);
  mediump float tmpvar_66;
  tmpvar_66 = clamp (((
    ((dot (viewDir_14, _ES_MoonDirection) * 0.5) + 0.5)
   - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_67;
  tmpvar_67 = (((tmpvar_66 * 
    (tmpvar_66 * (3.0 - (2.0 * tmpvar_66)))
  ) * _ES_MoonBrightness) * 0.1);
  mediump float tmpvar_68;
  tmpvar_68 = max (((tmpvar_19 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_69;
  tmpvar_69 = ((tmpvar_68 * tmpvar_68) * tmpvar_68);
  gl_Position = clipPos_6;
  xlv_TEXCOORD0 = o_9;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = (((
    ((((tmpvar_57 * 
      (tmpvar_57 * (3.0 - (2.0 * tmpvar_57)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_52) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_60, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_59))
    ) * vertical_59), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_49);
  xlv_TEXCOORD6 = (((_ES_SunHaloColor * 
    (tmpvar_65 * tmpvar_65)
  ) + (_ES_MoonColor * 
    (tmpvar_67 * tmpvar_67)
  )) * tmpvar_49);
  xlv_TEXCOORD7 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_69));
  xlv_TEXCOORD8 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_69));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_CloudCoverage;
uniform sampler2D _CloudParticleAtlas;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 cloudCol_1;
  mediump vec4 texCol_2;
  highp vec3 curlNoise_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_CloudCurlTex, xlv_TEXCOORD1.zw).xyz;
  curlNoise_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD1.xy + ((
    (curlNoise_3.xy - 0.5)
   * curlNoise_3.z) * _CloudCurlAmplitude));
  tmpvar_5 = texture2D (_CloudParticleAtlas, P_6);
  texCol_2 = tmpvar_5;
  mediump float tmpvar_7;
  tmpvar_7 = max ((xlv_TEXCOORD3.w - xlv_TEXCOORD3.y), 0.0);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.y), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD2.w - -0.1) / 0.2), 0.0, 1.0);
  cloudCol_1.w = ((texCol_2.w * (tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  )) * (tmpvar_9 * (tmpvar_9 * 
    (3.0 - (2.0 * tmpvar_9))
  )));
  mediump float x_10;
  x_10 = (cloudCol_1.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.z), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  cloudCol_1.xyz = ((mix (xlv_TEXCOORD8, xlv_TEXCOORD7, texCol_2.xxx) + (xlv_TEXCOORD6 * 
    mix (texCol_2.y, ((1.0 - (tmpvar_11 * 
      (tmpvar_11 * (3.0 - (2.0 * tmpvar_11)))
    )) * 4.0), xlv_TEXCOORD3.w)
  )) + ((0.4 * xlv_TEXCOORD7) * _ES_CloudCoverage));
  cloudCol_1.xyz = (cloudCol_1.xyz + (xlv_TEXCOORD5 * texCol_2.x));
  cloudCol_1.xyz = (cloudCol_1.xyz * (xlv_TEXCOORD3.x + 1.0));
  mediump float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD2.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((_ES_CloudCoverage - 0.4) / 0.3), 0.0, 1.0);
  cloudCol_1.xyz = mix (xlv_TEXCOORD4, cloudCol_1.xyz, vec3(mix (clamp (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
  , 0.0, 1.0), 1.0, (tmpvar_13 * 
    (tmpvar_13 * (3.0 - (2.0 * tmpvar_13)))
  ))));
  cloudCol_1.w = clamp (cloudCol_1.w, 0.0, 1.0);
  gl_FragData[0] = cloudCol_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FIXED_SPRITE_ID" "FIXED_EDGE_SMOOTHNESS" "FIXED_RIMLIGHT_WIDTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec4 _ES_TopFrontColor;
uniform mediump vec4 _ES_TopBackColor;
uniform mediump vec4 _ES_BottomFrontColor;
uniform mediump vec4 _ES_BottomBackColor;
uniform mediump float _ES_SkyFrontAndBackBlendFactor;
uniform mediump float _ES_BottomColorHeight;
uniform mediump vec3 _ES_HorizonHaloColor;
uniform mediump float _ES_HorizonHaloIntensity;
uniform mediump float _ES_HorizonHaloHeight;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump float _ES_SunHaloSize;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudAgePercent;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform sampler2D _SkyGradientTex;
uniform highp vec2 _AtlasTiles;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
uniform highp int _FixedSpriteId;
uniform mediump float _FixedEdgeSmoothness;
uniform mediump float _FixedRimLightWidth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float agePercent_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 clipPos_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  clipPos_6.xyw = tmpvar_7.xyw;
  clipPos_6.z = tmpvar_7.w;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7.xyww * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = clipPos_6.zw;
  highp vec2 tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = float(_FixedSpriteId);
  tmpvar_12.x = (float(mod (tmpvar_13, _AtlasTiles.x)));
  tmpvar_12.y = floor((tmpvar_13 / _AtlasTiles.x));
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy + tmpvar_12) / _AtlasTiles);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _CloudCurlTiling) + ((_ES_CloudElapsedTime * vec2(1.2, 0.8)) * _CloudCurlSpeed));
  mediump vec3 viewDir_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(((unity_ObjectToWorld * tmpvar_15).xyz - _ES_SkyCenterWorldPos));
  viewDir_14 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (_ES_SkyWorldUpDir, viewDir_14);
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = viewDir_14;
  tmpvar_18.w = ((sign(tmpvar_17) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_17))) * (1.570796 + (abs(tmpvar_17) * (-0.2146018 + 
      (abs(tmpvar_17) * (0.08656672 + (abs(tmpvar_17) * -0.03102955)))
    ))))
  )) * 0.6366198);
  mediump float tmpvar_19;
  tmpvar_19 = dot (viewDir_14, _ES_SunDirection);
  mediump float tmpvar_20;
  tmpvar_20 = ((tmpvar_19 * 0.5) + 0.5);
  tmpvar_4.x = (tmpvar_20 * _ES_CloudSunBrightenIntensity);
  tmpvar_4.y = _FixedEdgeSmoothness;
  tmpvar_4.z = _FixedRimLightWidth;
  highp float tmpvar_21;
  tmpvar_21 = (_glesMultiTexCoord1.y / max (_glesMultiTexCoord1.x, 1e-05));
  agePercent_2 = tmpvar_21;
  agePercent_2 = (agePercent_2 * _ES_CloudAgePercent);
  highp float tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = clamp ((agePercent_2 / _glesMultiTexCoord1.z), 0.0, 1.0);
  tmpvar_22 = (tmpvar_23 * (tmpvar_23 * (3.0 - 
    (2.0 * tmpvar_23)
  )));
  highp float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((agePercent_2 - _glesMultiTexCoord1.w) / (1.0 - _glesMultiTexCoord1.w)), 0.0, 1.0);
  tmpvar_24 = (tmpvar_25 * (tmpvar_25 * (3.0 - 
    (2.0 * tmpvar_25)
  )));
  tmpvar_4.w = (1.0 - (tmpvar_22 * (1.0 - tmpvar_24)));
  mediump vec3 atomosphere_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (_ES_SunDirection, viewDir_14);
  mediump float tmpvar_28;
  tmpvar_28 = max (((tmpvar_27 * _ES_SkyFrontAndBackBlendFactor) + (1.0 - _ES_SkyFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_29;
  tmpvar_29 = ((tmpvar_28 * tmpvar_28) * tmpvar_28);
  mediump vec4 tmpvar_30;
  tmpvar_30.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_30.x = (abs(tmpvar_18.w) / max (_ES_BottomColorHeight, 0.0001));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DLod (_SkyGradientTex, tmpvar_30.xy, 0.0);
  mediump float tmpvar_32;
  tmpvar_32 = tmpvar_31.x;
  atomosphere_26 = mix (mix (_ES_TopBackColor, _ES_TopFrontColor, vec4(tmpvar_29)).xyz, mix (_ES_BottomBackColor, _ES_BottomFrontColor, vec4(tmpvar_29)).xyz, vec3(tmpvar_32));
  mediump vec4 tmpvar_33;
  tmpvar_33.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_33.x = (abs(tmpvar_18.w) / max (_ES_HorizonHaloHeight, 0.0001));
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DLod (_SkyGradientTex, tmpvar_33.xy, 0.0);
  mediump float tmpvar_35;
  tmpvar_35 = tmpvar_34.y;
  mediump float tmpvar_36;
  tmpvar_36 = clamp (((
    max (((tmpvar_27 * 0.5) + 0.5), 0.0)
   - 0.3) / 0.7), 0.0, 1.0);
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    abs(_ES_SunDirection.y)
   - 0.2) / 0.3), 0.0, 1.0);
  atomosphere_26 = (atomosphere_26 + ((
    (_ES_HorizonHaloColor * _ES_HorizonHaloIntensity)
   * tmpvar_35) * mix (
    (tmpvar_36 * (tmpvar_36 * (3.0 - (2.0 * tmpvar_36))))
  , 1.0, 
    (tmpvar_37 * (tmpvar_37 * (3.0 - (2.0 * tmpvar_37))))
  )));
  highp vec3 viewDir_38;
  viewDir_38 = tmpvar_18.xyz;
  highp float haloInfluence_39;
  mediump float vertical_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((
    dot (_ES_SunDirection, viewDir_38)
   * 0.5) + 0.5), 0.0, 1.0);
  highp float tmpvar_42;
  tmpvar_42 = dot (viewDir_38, _ES_SkyWorldUpDir);
  vertical_40 = tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = abs(vertical_40);
  mediump float y_44;
  y_44 = (_ES_SunHaloSize * tmpvar_43);
  mediump float y_45;
  y_45 = ((_ES_SunHaloSize * 0.1) * tmpvar_43);
  haloInfluence_39 = (clamp (pow (tmpvar_41, y_44), 0.0, 1.0) + (clamp (
    pow (tmpvar_41, y_45)
  , 0.0, 1.0) * 0.12));
  mediump float y_46;
  y_46 = ((_ES_SunHaloSize * 0.01) * tmpvar_43);
  haloInfluence_39 = (haloInfluence_39 + (clamp (
    pow (tmpvar_41, y_46)
  , 0.0, 1.0) * 0.03));
  highp float tmpvar_47;
  tmpvar_47 = clamp (((
    max (((dot (_ES_SunDirection, viewDir_38) * 0.5) + 0.5), 0.0)
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 tmpvar_48;
  tmpvar_48 = (((haloInfluence_39 * _ES_SunHaloIntensity) * _ES_SunHaloColor) * (tmpvar_47 * (tmpvar_47 * 
    (3.0 - (2.0 * tmpvar_47))
  )));
  tmpvar_5 = (atomosphere_26 + tmpvar_48);
  mediump float tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_49 = (tmpvar_50 * (tmpvar_50 * (3.0 - 
    (2.0 * tmpvar_50)
  )));
  highp vec3 viewDir_51;
  viewDir_51 = tmpvar_18.xyz;
  mediump float moonLunarCancel_52;
  mediump float tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (_ES_MoonDirection, viewDir_51), 0.0, 1.0);
  tmpvar_53 = tmpvar_54;
  highp float tmpvar_55;
  mediump float tmpvar_56;
  tmpvar_56 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_55 = (1.0 - (tmpvar_56 * 2.0));
  moonLunarCancel_52 = tmpvar_55;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((
    ((tmpvar_53 * tmpvar_53) * ((tmpvar_53 * tmpvar_53) * tmpvar_53))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_58;
  viewDir_58 = tmpvar_18.xyz;
  mediump float vertical_59;
  mediump float tmpvar_60;
  highp float tmpvar_61;
  tmpvar_61 = clamp (((
    dot (_ES_SunDirection, viewDir_58)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_60 = tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = dot (viewDir_58, _ES_SkyWorldUpDir);
  vertical_59 = tmpvar_62;
  mediump float tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = (1.0 - _ES_SunRimLightRadius);
  tmpvar_63 = clamp (((tmpvar_20 - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (((tmpvar_63 * 
    (tmpvar_63 * (3.0 - (2.0 * tmpvar_63)))
  ) * _ES_SunBrightness) * 0.125);
  mediump float tmpvar_66;
  tmpvar_66 = clamp (((
    ((dot (viewDir_14, _ES_MoonDirection) * 0.5) + 0.5)
   - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_67;
  tmpvar_67 = (((tmpvar_66 * 
    (tmpvar_66 * (3.0 - (2.0 * tmpvar_66)))
  ) * _ES_MoonBrightness) * 0.1);
  mediump float tmpvar_68;
  tmpvar_68 = max (((tmpvar_19 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_69;
  tmpvar_69 = ((tmpvar_68 * tmpvar_68) * tmpvar_68);
  gl_Position = clipPos_6;
  xlv_TEXCOORD0 = o_9;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = (((
    ((((tmpvar_57 * 
      (tmpvar_57 * (3.0 - (2.0 * tmpvar_57)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_52) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_60, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_59))
    ) * vertical_59), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_49);
  xlv_TEXCOORD6 = (((_ES_SunHaloColor * 
    (tmpvar_65 * tmpvar_65)
  ) + (_ES_MoonColor * 
    (tmpvar_67 * tmpvar_67)
  )) * tmpvar_49);
  xlv_TEXCOORD7 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_69));
  xlv_TEXCOORD8 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_69));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_CloudCoverage;
uniform sampler2D _CloudParticleAtlas;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 cloudCol_1;
  mediump vec4 texCol_2;
  highp vec3 curlNoise_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_CloudCurlTex, xlv_TEXCOORD1.zw).xyz;
  curlNoise_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD1.xy + ((
    (curlNoise_3.xy - 0.5)
   * curlNoise_3.z) * _CloudCurlAmplitude));
  tmpvar_5 = texture2D (_CloudParticleAtlas, P_6);
  texCol_2 = tmpvar_5;
  mediump float tmpvar_7;
  tmpvar_7 = max ((xlv_TEXCOORD3.w - xlv_TEXCOORD3.y), 0.0);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.y), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD2.w - -0.1) / 0.2), 0.0, 1.0);
  cloudCol_1.w = ((texCol_2.w * (tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  )) * (tmpvar_9 * (tmpvar_9 * 
    (3.0 - (2.0 * tmpvar_9))
  )));
  mediump float x_10;
  x_10 = (cloudCol_1.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.z), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  cloudCol_1.xyz = ((mix (xlv_TEXCOORD8, xlv_TEXCOORD7, texCol_2.xxx) + (xlv_TEXCOORD6 * 
    mix (texCol_2.y, ((1.0 - (tmpvar_11 * 
      (tmpvar_11 * (3.0 - (2.0 * tmpvar_11)))
    )) * 4.0), xlv_TEXCOORD3.w)
  )) + ((0.4 * xlv_TEXCOORD7) * _ES_CloudCoverage));
  cloudCol_1.xyz = (cloudCol_1.xyz + (xlv_TEXCOORD5 * texCol_2.x));
  cloudCol_1.xyz = (cloudCol_1.xyz * (xlv_TEXCOORD3.x + 1.0));
  mediump float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD2.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((_ES_CloudCoverage - 0.4) / 0.3), 0.0, 1.0);
  cloudCol_1.xyz = mix (xlv_TEXCOORD4, cloudCol_1.xyz, vec3(mix (clamp (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
  , 0.0, 1.0), 1.0, (tmpvar_13 * 
    (tmpvar_13 * (3.0 - (2.0 * tmpvar_13)))
  ))));
  cloudCol_1.w = clamp (cloudCol_1.w, 0.0, 1.0);
  gl_FragData[0] = cloudCol_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "FIXED_SPRITE_ID" "FIXED_EDGE_SMOOTHNESS" "FIXED_RIMLIGHT_WIDTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec4 _ES_TopFrontColor;
uniform mediump vec4 _ES_TopBackColor;
uniform mediump vec4 _ES_BottomFrontColor;
uniform mediump vec4 _ES_BottomBackColor;
uniform mediump float _ES_SkyFrontAndBackBlendFactor;
uniform mediump float _ES_BottomColorHeight;
uniform mediump vec3 _ES_HorizonHaloColor;
uniform mediump float _ES_HorizonHaloIntensity;
uniform mediump float _ES_HorizonHaloHeight;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump float _ES_SunHaloSize;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudAgePercent;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform sampler2D _SkyGradientTex;
uniform highp vec2 _AtlasTiles;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
uniform highp int _FixedSpriteId;
uniform mediump float _FixedEdgeSmoothness;
uniform mediump float _FixedRimLightWidth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float agePercent_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 clipPos_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  clipPos_6.xyw = tmpvar_7.xyw;
  clipPos_6.z = tmpvar_7.w;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7.xyww * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = clipPos_6.zw;
  highp vec2 tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = float(_FixedSpriteId);
  tmpvar_12.x = (float(mod (tmpvar_13, _AtlasTiles.x)));
  tmpvar_12.y = floor((tmpvar_13 / _AtlasTiles.x));
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy + tmpvar_12) / _AtlasTiles);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _CloudCurlTiling) + ((_ES_CloudElapsedTime * vec2(1.2, 0.8)) * _CloudCurlSpeed));
  mediump vec3 viewDir_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(((unity_ObjectToWorld * tmpvar_15).xyz - _ES_SkyCenterWorldPos));
  viewDir_14 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (_ES_SkyWorldUpDir, viewDir_14);
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = viewDir_14;
  tmpvar_18.w = ((sign(tmpvar_17) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_17))) * (1.570796 + (abs(tmpvar_17) * (-0.2146018 + 
      (abs(tmpvar_17) * (0.08656672 + (abs(tmpvar_17) * -0.03102955)))
    ))))
  )) * 0.6366198);
  mediump float tmpvar_19;
  tmpvar_19 = dot (viewDir_14, _ES_SunDirection);
  mediump float tmpvar_20;
  tmpvar_20 = ((tmpvar_19 * 0.5) + 0.5);
  tmpvar_4.x = (tmpvar_20 * _ES_CloudSunBrightenIntensity);
  tmpvar_4.y = _FixedEdgeSmoothness;
  tmpvar_4.z = _FixedRimLightWidth;
  highp float tmpvar_21;
  tmpvar_21 = (_glesMultiTexCoord1.y / max (_glesMultiTexCoord1.x, 1e-05));
  agePercent_2 = tmpvar_21;
  agePercent_2 = (agePercent_2 * _ES_CloudAgePercent);
  highp float tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = clamp ((agePercent_2 / _glesMultiTexCoord1.z), 0.0, 1.0);
  tmpvar_22 = (tmpvar_23 * (tmpvar_23 * (3.0 - 
    (2.0 * tmpvar_23)
  )));
  highp float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((agePercent_2 - _glesMultiTexCoord1.w) / (1.0 - _glesMultiTexCoord1.w)), 0.0, 1.0);
  tmpvar_24 = (tmpvar_25 * (tmpvar_25 * (3.0 - 
    (2.0 * tmpvar_25)
  )));
  tmpvar_4.w = (1.0 - (tmpvar_22 * (1.0 - tmpvar_24)));
  mediump vec3 atomosphere_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (_ES_SunDirection, viewDir_14);
  mediump float tmpvar_28;
  tmpvar_28 = max (((tmpvar_27 * _ES_SkyFrontAndBackBlendFactor) + (1.0 - _ES_SkyFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_29;
  tmpvar_29 = ((tmpvar_28 * tmpvar_28) * tmpvar_28);
  mediump vec4 tmpvar_30;
  tmpvar_30.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_30.x = (abs(tmpvar_18.w) / max (_ES_BottomColorHeight, 0.0001));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DLod (_SkyGradientTex, tmpvar_30.xy, 0.0);
  mediump float tmpvar_32;
  tmpvar_32 = tmpvar_31.x;
  atomosphere_26 = mix (mix (_ES_TopBackColor, _ES_TopFrontColor, vec4(tmpvar_29)).xyz, mix (_ES_BottomBackColor, _ES_BottomFrontColor, vec4(tmpvar_29)).xyz, vec3(tmpvar_32));
  mediump vec4 tmpvar_33;
  tmpvar_33.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_33.x = (abs(tmpvar_18.w) / max (_ES_HorizonHaloHeight, 0.0001));
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DLod (_SkyGradientTex, tmpvar_33.xy, 0.0);
  mediump float tmpvar_35;
  tmpvar_35 = tmpvar_34.y;
  mediump float tmpvar_36;
  tmpvar_36 = clamp (((
    max (((tmpvar_27 * 0.5) + 0.5), 0.0)
   - 0.3) / 0.7), 0.0, 1.0);
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    abs(_ES_SunDirection.y)
   - 0.2) / 0.3), 0.0, 1.0);
  atomosphere_26 = (atomosphere_26 + ((
    (_ES_HorizonHaloColor * _ES_HorizonHaloIntensity)
   * tmpvar_35) * mix (
    (tmpvar_36 * (tmpvar_36 * (3.0 - (2.0 * tmpvar_36))))
  , 1.0, 
    (tmpvar_37 * (tmpvar_37 * (3.0 - (2.0 * tmpvar_37))))
  )));
  highp vec3 viewDir_38;
  viewDir_38 = tmpvar_18.xyz;
  highp float haloInfluence_39;
  mediump float vertical_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((
    dot (_ES_SunDirection, viewDir_38)
   * 0.5) + 0.5), 0.0, 1.0);
  highp float tmpvar_42;
  tmpvar_42 = dot (viewDir_38, _ES_SkyWorldUpDir);
  vertical_40 = tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = abs(vertical_40);
  mediump float y_44;
  y_44 = (_ES_SunHaloSize * tmpvar_43);
  mediump float y_45;
  y_45 = ((_ES_SunHaloSize * 0.1) * tmpvar_43);
  haloInfluence_39 = (clamp (pow (tmpvar_41, y_44), 0.0, 1.0) + (clamp (
    pow (tmpvar_41, y_45)
  , 0.0, 1.0) * 0.12));
  mediump float y_46;
  y_46 = ((_ES_SunHaloSize * 0.01) * tmpvar_43);
  haloInfluence_39 = (haloInfluence_39 + (clamp (
    pow (tmpvar_41, y_46)
  , 0.0, 1.0) * 0.03));
  highp float tmpvar_47;
  tmpvar_47 = clamp (((
    max (((dot (_ES_SunDirection, viewDir_38) * 0.5) + 0.5), 0.0)
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 tmpvar_48;
  tmpvar_48 = (((haloInfluence_39 * _ES_SunHaloIntensity) * _ES_SunHaloColor) * (tmpvar_47 * (tmpvar_47 * 
    (3.0 - (2.0 * tmpvar_47))
  )));
  tmpvar_5 = (atomosphere_26 + tmpvar_48);
  mediump float tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_49 = (tmpvar_50 * (tmpvar_50 * (3.0 - 
    (2.0 * tmpvar_50)
  )));
  highp vec3 viewDir_51;
  viewDir_51 = tmpvar_18.xyz;
  mediump float moonLunarCancel_52;
  mediump float tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (_ES_MoonDirection, viewDir_51), 0.0, 1.0);
  tmpvar_53 = tmpvar_54;
  highp float tmpvar_55;
  mediump float tmpvar_56;
  tmpvar_56 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_55 = (1.0 - (tmpvar_56 * 2.0));
  moonLunarCancel_52 = tmpvar_55;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((
    ((tmpvar_53 * tmpvar_53) * ((tmpvar_53 * tmpvar_53) * tmpvar_53))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_58;
  viewDir_58 = tmpvar_18.xyz;
  mediump float vertical_59;
  mediump float tmpvar_60;
  highp float tmpvar_61;
  tmpvar_61 = clamp (((
    dot (_ES_SunDirection, viewDir_58)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_60 = tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = dot (viewDir_58, _ES_SkyWorldUpDir);
  vertical_59 = tmpvar_62;
  mediump float tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = (1.0 - _ES_SunRimLightRadius);
  tmpvar_63 = clamp (((tmpvar_20 - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (((tmpvar_63 * 
    (tmpvar_63 * (3.0 - (2.0 * tmpvar_63)))
  ) * _ES_SunBrightness) * 0.125);
  mediump float tmpvar_66;
  tmpvar_66 = clamp (((
    ((dot (viewDir_14, _ES_MoonDirection) * 0.5) + 0.5)
   - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_67;
  tmpvar_67 = (((tmpvar_66 * 
    (tmpvar_66 * (3.0 - (2.0 * tmpvar_66)))
  ) * _ES_MoonBrightness) * 0.1);
  mediump float tmpvar_68;
  tmpvar_68 = max (((tmpvar_19 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_69;
  tmpvar_69 = ((tmpvar_68 * tmpvar_68) * tmpvar_68);
  gl_Position = clipPos_6;
  xlv_TEXCOORD0 = o_9;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = (((
    ((((tmpvar_57 * 
      (tmpvar_57 * (3.0 - (2.0 * tmpvar_57)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_52) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_60, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_59))
    ) * vertical_59), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_49);
  xlv_TEXCOORD6 = (((_ES_SunHaloColor * 
    (tmpvar_65 * tmpvar_65)
  ) + (_ES_MoonColor * 
    (tmpvar_67 * tmpvar_67)
  )) * tmpvar_49);
  xlv_TEXCOORD7 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_69));
  xlv_TEXCOORD8 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_69));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_CloudCoverage;
uniform sampler2D _CloudParticleAtlas;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 cloudCol_1;
  mediump vec4 texCol_2;
  highp vec3 curlNoise_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_CloudCurlTex, xlv_TEXCOORD1.zw).xyz;
  curlNoise_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD1.xy + ((
    (curlNoise_3.xy - 0.5)
   * curlNoise_3.z) * _CloudCurlAmplitude));
  tmpvar_5 = texture2D (_CloudParticleAtlas, P_6);
  texCol_2 = tmpvar_5;
  mediump float tmpvar_7;
  tmpvar_7 = max ((xlv_TEXCOORD3.w - xlv_TEXCOORD3.y), 0.0);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.y), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD2.w - -0.1) / 0.2), 0.0, 1.0);
  cloudCol_1.w = ((texCol_2.w * (tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  )) * (tmpvar_9 * (tmpvar_9 * 
    (3.0 - (2.0 * tmpvar_9))
  )));
  mediump float x_10;
  x_10 = (cloudCol_1.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.z), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  cloudCol_1.xyz = ((mix (xlv_TEXCOORD8, xlv_TEXCOORD7, texCol_2.xxx) + (xlv_TEXCOORD6 * 
    mix (texCol_2.y, ((1.0 - (tmpvar_11 * 
      (tmpvar_11 * (3.0 - (2.0 * tmpvar_11)))
    )) * 4.0), xlv_TEXCOORD3.w)
  )) + ((0.4 * xlv_TEXCOORD7) * _ES_CloudCoverage));
  cloudCol_1.xyz = (cloudCol_1.xyz + (xlv_TEXCOORD5 * texCol_2.x));
  cloudCol_1.xyz = (cloudCol_1.xyz * (xlv_TEXCOORD3.x + 1.0));
  mediump float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD2.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((_ES_CloudCoverage - 0.4) / 0.3), 0.0, 1.0);
  cloudCol_1.xyz = mix (xlv_TEXCOORD4, cloudCol_1.xyz, vec3(mix (clamp (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
  , 0.0, 1.0), 1.0, (tmpvar_13 * 
    (tmpvar_13 * (3.0 - (2.0 * tmpvar_13)))
  ))));
  cloudCol_1.w = clamp (cloudCol_1.w, 0.0, 1.0);
  gl_FragData[0] = cloudCol_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "FIXED_SPRITE_ID" "FIXED_EDGE_SMOOTHNESS" "FIXED_RIMLIGHT_WIDTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec4 _ES_TopFrontColor;
uniform mediump vec4 _ES_TopBackColor;
uniform mediump vec4 _ES_BottomFrontColor;
uniform mediump vec4 _ES_BottomBackColor;
uniform mediump float _ES_SkyFrontAndBackBlendFactor;
uniform mediump float _ES_BottomColorHeight;
uniform mediump vec3 _ES_HorizonHaloColor;
uniform mediump float _ES_HorizonHaloIntensity;
uniform mediump float _ES_HorizonHaloHeight;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump float _ES_SunHaloSize;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudAgePercent;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform sampler2D _SkyGradientTex;
uniform highp vec2 _AtlasTiles;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
uniform highp int _FixedSpriteId;
uniform mediump float _FixedEdgeSmoothness;
uniform mediump float _FixedRimLightWidth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float agePercent_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 clipPos_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  clipPos_6.xyw = tmpvar_7.xyw;
  clipPos_6.z = tmpvar_7.w;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7.xyww * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = clipPos_6.zw;
  highp vec2 tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = float(_FixedSpriteId);
  tmpvar_12.x = (float(mod (tmpvar_13, _AtlasTiles.x)));
  tmpvar_12.y = floor((tmpvar_13 / _AtlasTiles.x));
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy + tmpvar_12) / _AtlasTiles);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _CloudCurlTiling) + ((_ES_CloudElapsedTime * vec2(1.2, 0.8)) * _CloudCurlSpeed));
  mediump vec3 viewDir_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(((unity_ObjectToWorld * tmpvar_15).xyz - _ES_SkyCenterWorldPos));
  viewDir_14 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (_ES_SkyWorldUpDir, viewDir_14);
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = viewDir_14;
  tmpvar_18.w = ((sign(tmpvar_17) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_17))) * (1.570796 + (abs(tmpvar_17) * (-0.2146018 + 
      (abs(tmpvar_17) * (0.08656672 + (abs(tmpvar_17) * -0.03102955)))
    ))))
  )) * 0.6366198);
  mediump float tmpvar_19;
  tmpvar_19 = dot (viewDir_14, _ES_SunDirection);
  mediump float tmpvar_20;
  tmpvar_20 = ((tmpvar_19 * 0.5) + 0.5);
  tmpvar_4.x = (tmpvar_20 * _ES_CloudSunBrightenIntensity);
  tmpvar_4.y = _FixedEdgeSmoothness;
  tmpvar_4.z = _FixedRimLightWidth;
  highp float tmpvar_21;
  tmpvar_21 = (_glesMultiTexCoord1.y / max (_glesMultiTexCoord1.x, 1e-05));
  agePercent_2 = tmpvar_21;
  agePercent_2 = (agePercent_2 * _ES_CloudAgePercent);
  highp float tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = clamp ((agePercent_2 / _glesMultiTexCoord1.z), 0.0, 1.0);
  tmpvar_22 = (tmpvar_23 * (tmpvar_23 * (3.0 - 
    (2.0 * tmpvar_23)
  )));
  highp float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((agePercent_2 - _glesMultiTexCoord1.w) / (1.0 - _glesMultiTexCoord1.w)), 0.0, 1.0);
  tmpvar_24 = (tmpvar_25 * (tmpvar_25 * (3.0 - 
    (2.0 * tmpvar_25)
  )));
  tmpvar_4.w = (1.0 - (tmpvar_22 * (1.0 - tmpvar_24)));
  mediump vec3 atomosphere_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (_ES_SunDirection, viewDir_14);
  mediump float tmpvar_28;
  tmpvar_28 = max (((tmpvar_27 * _ES_SkyFrontAndBackBlendFactor) + (1.0 - _ES_SkyFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_29;
  tmpvar_29 = ((tmpvar_28 * tmpvar_28) * tmpvar_28);
  mediump vec4 tmpvar_30;
  tmpvar_30.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_30.x = (abs(tmpvar_18.w) / max (_ES_BottomColorHeight, 0.0001));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DLod (_SkyGradientTex, tmpvar_30.xy, 0.0);
  mediump float tmpvar_32;
  tmpvar_32 = tmpvar_31.x;
  atomosphere_26 = mix (mix (_ES_TopBackColor, _ES_TopFrontColor, vec4(tmpvar_29)).xyz, mix (_ES_BottomBackColor, _ES_BottomFrontColor, vec4(tmpvar_29)).xyz, vec3(tmpvar_32));
  mediump vec4 tmpvar_33;
  tmpvar_33.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_33.x = (abs(tmpvar_18.w) / max (_ES_HorizonHaloHeight, 0.0001));
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DLod (_SkyGradientTex, tmpvar_33.xy, 0.0);
  mediump float tmpvar_35;
  tmpvar_35 = tmpvar_34.y;
  mediump float tmpvar_36;
  tmpvar_36 = clamp (((
    max (((tmpvar_27 * 0.5) + 0.5), 0.0)
   - 0.3) / 0.7), 0.0, 1.0);
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    abs(_ES_SunDirection.y)
   - 0.2) / 0.3), 0.0, 1.0);
  atomosphere_26 = (atomosphere_26 + ((
    (_ES_HorizonHaloColor * _ES_HorizonHaloIntensity)
   * tmpvar_35) * mix (
    (tmpvar_36 * (tmpvar_36 * (3.0 - (2.0 * tmpvar_36))))
  , 1.0, 
    (tmpvar_37 * (tmpvar_37 * (3.0 - (2.0 * tmpvar_37))))
  )));
  highp vec3 viewDir_38;
  viewDir_38 = tmpvar_18.xyz;
  highp float haloInfluence_39;
  mediump float vertical_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((
    dot (_ES_SunDirection, viewDir_38)
   * 0.5) + 0.5), 0.0, 1.0);
  highp float tmpvar_42;
  tmpvar_42 = dot (viewDir_38, _ES_SkyWorldUpDir);
  vertical_40 = tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = abs(vertical_40);
  mediump float y_44;
  y_44 = (_ES_SunHaloSize * tmpvar_43);
  mediump float y_45;
  y_45 = ((_ES_SunHaloSize * 0.1) * tmpvar_43);
  haloInfluence_39 = (clamp (pow (tmpvar_41, y_44), 0.0, 1.0) + (clamp (
    pow (tmpvar_41, y_45)
  , 0.0, 1.0) * 0.12));
  mediump float y_46;
  y_46 = ((_ES_SunHaloSize * 0.01) * tmpvar_43);
  haloInfluence_39 = (haloInfluence_39 + (clamp (
    pow (tmpvar_41, y_46)
  , 0.0, 1.0) * 0.03));
  highp float tmpvar_47;
  tmpvar_47 = clamp (((
    max (((dot (_ES_SunDirection, viewDir_38) * 0.5) + 0.5), 0.0)
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 tmpvar_48;
  tmpvar_48 = (((haloInfluence_39 * _ES_SunHaloIntensity) * _ES_SunHaloColor) * (tmpvar_47 * (tmpvar_47 * 
    (3.0 - (2.0 * tmpvar_47))
  )));
  tmpvar_5 = (atomosphere_26 + tmpvar_48);
  mediump float tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_49 = (tmpvar_50 * (tmpvar_50 * (3.0 - 
    (2.0 * tmpvar_50)
  )));
  highp vec3 viewDir_51;
  viewDir_51 = tmpvar_18.xyz;
  mediump float moonLunarCancel_52;
  mediump float tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (_ES_MoonDirection, viewDir_51), 0.0, 1.0);
  tmpvar_53 = tmpvar_54;
  highp float tmpvar_55;
  mediump float tmpvar_56;
  tmpvar_56 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_55 = (1.0 - (tmpvar_56 * 2.0));
  moonLunarCancel_52 = tmpvar_55;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((
    ((tmpvar_53 * tmpvar_53) * ((tmpvar_53 * tmpvar_53) * tmpvar_53))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_58;
  viewDir_58 = tmpvar_18.xyz;
  mediump float vertical_59;
  mediump float tmpvar_60;
  highp float tmpvar_61;
  tmpvar_61 = clamp (((
    dot (_ES_SunDirection, viewDir_58)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_60 = tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = dot (viewDir_58, _ES_SkyWorldUpDir);
  vertical_59 = tmpvar_62;
  mediump float tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = (1.0 - _ES_SunRimLightRadius);
  tmpvar_63 = clamp (((tmpvar_20 - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (((tmpvar_63 * 
    (tmpvar_63 * (3.0 - (2.0 * tmpvar_63)))
  ) * _ES_SunBrightness) * 0.125);
  mediump float tmpvar_66;
  tmpvar_66 = clamp (((
    ((dot (viewDir_14, _ES_MoonDirection) * 0.5) + 0.5)
   - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_67;
  tmpvar_67 = (((tmpvar_66 * 
    (tmpvar_66 * (3.0 - (2.0 * tmpvar_66)))
  ) * _ES_MoonBrightness) * 0.1);
  mediump float tmpvar_68;
  tmpvar_68 = max (((tmpvar_19 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_69;
  tmpvar_69 = ((tmpvar_68 * tmpvar_68) * tmpvar_68);
  gl_Position = clipPos_6;
  xlv_TEXCOORD0 = o_9;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = (((
    ((((tmpvar_57 * 
      (tmpvar_57 * (3.0 - (2.0 * tmpvar_57)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_52) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_60, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_59))
    ) * vertical_59), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_49);
  xlv_TEXCOORD6 = (((_ES_SunHaloColor * 
    (tmpvar_65 * tmpvar_65)
  ) + (_ES_MoonColor * 
    (tmpvar_67 * tmpvar_67)
  )) * tmpvar_49);
  xlv_TEXCOORD7 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_69));
  xlv_TEXCOORD8 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_69));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_CloudCoverage;
uniform sampler2D _CloudParticleAtlas;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 cloudCol_1;
  mediump vec4 texCol_2;
  highp vec3 curlNoise_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_CloudCurlTex, xlv_TEXCOORD1.zw).xyz;
  curlNoise_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD1.xy + ((
    (curlNoise_3.xy - 0.5)
   * curlNoise_3.z) * _CloudCurlAmplitude));
  tmpvar_5 = texture2D (_CloudParticleAtlas, P_6);
  texCol_2 = tmpvar_5;
  mediump float tmpvar_7;
  tmpvar_7 = max ((xlv_TEXCOORD3.w - xlv_TEXCOORD3.y), 0.0);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.y), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD2.w - -0.1) / 0.2), 0.0, 1.0);
  cloudCol_1.w = ((texCol_2.w * (tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  )) * (tmpvar_9 * (tmpvar_9 * 
    (3.0 - (2.0 * tmpvar_9))
  )));
  mediump float x_10;
  x_10 = (cloudCol_1.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.z), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  cloudCol_1.xyz = ((mix (xlv_TEXCOORD8, xlv_TEXCOORD7, texCol_2.xxx) + (xlv_TEXCOORD6 * 
    mix (texCol_2.y, ((1.0 - (tmpvar_11 * 
      (tmpvar_11 * (3.0 - (2.0 * tmpvar_11)))
    )) * 4.0), xlv_TEXCOORD3.w)
  )) + ((0.4 * xlv_TEXCOORD7) * _ES_CloudCoverage));
  cloudCol_1.xyz = (cloudCol_1.xyz + (xlv_TEXCOORD5 * texCol_2.x));
  cloudCol_1.xyz = (cloudCol_1.xyz * (xlv_TEXCOORD3.x + 1.0));
  mediump float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD2.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((_ES_CloudCoverage - 0.4) / 0.3), 0.0, 1.0);
  cloudCol_1.xyz = mix (xlv_TEXCOORD4, cloudCol_1.xyz, vec3(mix (clamp (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
  , 0.0, 1.0), 1.0, (tmpvar_13 * 
    (tmpvar_13 * (3.0 - (2.0 * tmpvar_13)))
  ))));
  cloudCol_1.w = clamp (cloudCol_1.w, 0.0, 1.0);
  gl_FragData[0] = cloudCol_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "FIXED_SPRITE_ID" "FIXED_EDGE_SMOOTHNESS" "FIXED_RIMLIGHT_WIDTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec4 _ES_TopFrontColor;
uniform mediump vec4 _ES_TopBackColor;
uniform mediump vec4 _ES_BottomFrontColor;
uniform mediump vec4 _ES_BottomBackColor;
uniform mediump float _ES_SkyFrontAndBackBlendFactor;
uniform mediump float _ES_BottomColorHeight;
uniform mediump vec3 _ES_HorizonHaloColor;
uniform mediump float _ES_HorizonHaloIntensity;
uniform mediump float _ES_HorizonHaloHeight;
uniform mediump vec3 _ES_SunDirection;
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunRimLightRadius;
uniform mediump float _ES_SunHaloSize;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform highp float _ES_CloudElapsedTime;
uniform mediump vec3 _ES_CloudLightFrontColor;
uniform mediump vec3 _ES_CloudLightBackColor;
uniform mediump vec3 _ES_CloudDarkFrontColor;
uniform mediump vec3 _ES_CloudDarkBackColor;
uniform mediump float _ES_CloudFrontAndBackBlendFactor;
uniform mediump float _ES_CloudCoverage;
uniform highp float _ES_CloudAgePercent;
uniform mediump float _ES_CloudSunBrightenIntensity;
uniform sampler2D _SkyGradientTex;
uniform highp vec2 _AtlasTiles;
uniform highp float _CloudCurlTiling;
uniform highp float _CloudCurlSpeed;
uniform highp int _FixedSpriteId;
uniform mediump float _FixedEdgeSmoothness;
uniform mediump float _FixedRimLightWidth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float agePercent_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 clipPos_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  clipPos_6.xyw = tmpvar_7.xyw;
  clipPos_6.z = tmpvar_7.w;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7.xyww * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = clipPos_6.zw;
  highp vec2 tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = float(_FixedSpriteId);
  tmpvar_12.x = (float(mod (tmpvar_13, _AtlasTiles.x)));
  tmpvar_12.y = floor((tmpvar_13 / _AtlasTiles.x));
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy + tmpvar_12) / _AtlasTiles);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _CloudCurlTiling) + ((_ES_CloudElapsedTime * vec2(1.2, 0.8)) * _CloudCurlSpeed));
  mediump vec3 viewDir_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(((unity_ObjectToWorld * tmpvar_15).xyz - _ES_SkyCenterWorldPos));
  viewDir_14 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (_ES_SkyWorldUpDir, viewDir_14);
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = viewDir_14;
  tmpvar_18.w = ((sign(tmpvar_17) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_17))) * (1.570796 + (abs(tmpvar_17) * (-0.2146018 + 
      (abs(tmpvar_17) * (0.08656672 + (abs(tmpvar_17) * -0.03102955)))
    ))))
  )) * 0.6366198);
  mediump float tmpvar_19;
  tmpvar_19 = dot (viewDir_14, _ES_SunDirection);
  mediump float tmpvar_20;
  tmpvar_20 = ((tmpvar_19 * 0.5) + 0.5);
  tmpvar_4.x = (tmpvar_20 * _ES_CloudSunBrightenIntensity);
  tmpvar_4.y = _FixedEdgeSmoothness;
  tmpvar_4.z = _FixedRimLightWidth;
  highp float tmpvar_21;
  tmpvar_21 = (_glesMultiTexCoord1.y / max (_glesMultiTexCoord1.x, 1e-05));
  agePercent_2 = tmpvar_21;
  agePercent_2 = (agePercent_2 * _ES_CloudAgePercent);
  highp float tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = clamp ((agePercent_2 / _glesMultiTexCoord1.z), 0.0, 1.0);
  tmpvar_22 = (tmpvar_23 * (tmpvar_23 * (3.0 - 
    (2.0 * tmpvar_23)
  )));
  highp float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((agePercent_2 - _glesMultiTexCoord1.w) / (1.0 - _glesMultiTexCoord1.w)), 0.0, 1.0);
  tmpvar_24 = (tmpvar_25 * (tmpvar_25 * (3.0 - 
    (2.0 * tmpvar_25)
  )));
  tmpvar_4.w = (1.0 - (tmpvar_22 * (1.0 - tmpvar_24)));
  mediump vec3 atomosphere_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (_ES_SunDirection, viewDir_14);
  mediump float tmpvar_28;
  tmpvar_28 = max (((tmpvar_27 * _ES_SkyFrontAndBackBlendFactor) + (1.0 - _ES_SkyFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_29;
  tmpvar_29 = ((tmpvar_28 * tmpvar_28) * tmpvar_28);
  mediump vec4 tmpvar_30;
  tmpvar_30.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_30.x = (abs(tmpvar_18.w) / max (_ES_BottomColorHeight, 0.0001));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DLod (_SkyGradientTex, tmpvar_30.xy, 0.0);
  mediump float tmpvar_32;
  tmpvar_32 = tmpvar_31.x;
  atomosphere_26 = mix (mix (_ES_TopBackColor, _ES_TopFrontColor, vec4(tmpvar_29)).xyz, mix (_ES_BottomBackColor, _ES_BottomFrontColor, vec4(tmpvar_29)).xyz, vec3(tmpvar_32));
  mediump vec4 tmpvar_33;
  tmpvar_33.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_33.x = (abs(tmpvar_18.w) / max (_ES_HorizonHaloHeight, 0.0001));
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DLod (_SkyGradientTex, tmpvar_33.xy, 0.0);
  mediump float tmpvar_35;
  tmpvar_35 = tmpvar_34.y;
  mediump float tmpvar_36;
  tmpvar_36 = clamp (((
    max (((tmpvar_27 * 0.5) + 0.5), 0.0)
   - 0.3) / 0.7), 0.0, 1.0);
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((
    abs(_ES_SunDirection.y)
   - 0.2) / 0.3), 0.0, 1.0);
  atomosphere_26 = (atomosphere_26 + ((
    (_ES_HorizonHaloColor * _ES_HorizonHaloIntensity)
   * tmpvar_35) * mix (
    (tmpvar_36 * (tmpvar_36 * (3.0 - (2.0 * tmpvar_36))))
  , 1.0, 
    (tmpvar_37 * (tmpvar_37 * (3.0 - (2.0 * tmpvar_37))))
  )));
  highp vec3 viewDir_38;
  viewDir_38 = tmpvar_18.xyz;
  highp float haloInfluence_39;
  mediump float vertical_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((
    dot (_ES_SunDirection, viewDir_38)
   * 0.5) + 0.5), 0.0, 1.0);
  highp float tmpvar_42;
  tmpvar_42 = dot (viewDir_38, _ES_SkyWorldUpDir);
  vertical_40 = tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = abs(vertical_40);
  mediump float y_44;
  y_44 = (_ES_SunHaloSize * tmpvar_43);
  mediump float y_45;
  y_45 = ((_ES_SunHaloSize * 0.1) * tmpvar_43);
  haloInfluence_39 = (clamp (pow (tmpvar_41, y_44), 0.0, 1.0) + (clamp (
    pow (tmpvar_41, y_45)
  , 0.0, 1.0) * 0.12));
  mediump float y_46;
  y_46 = ((_ES_SunHaloSize * 0.01) * tmpvar_43);
  haloInfluence_39 = (haloInfluence_39 + (clamp (
    pow (tmpvar_41, y_46)
  , 0.0, 1.0) * 0.03));
  highp float tmpvar_47;
  tmpvar_47 = clamp (((
    max (((dot (_ES_SunDirection, viewDir_38) * 0.5) + 0.5), 0.0)
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 tmpvar_48;
  tmpvar_48 = (((haloInfluence_39 * _ES_SunHaloIntensity) * _ES_SunHaloColor) * (tmpvar_47 * (tmpvar_47 * 
    (3.0 - (2.0 * tmpvar_47))
  )));
  tmpvar_5 = (atomosphere_26 + tmpvar_48);
  mediump float tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = clamp (((
    (1.0 - _ES_CloudCoverage)
   - 0.3) / 0.4), 0.0, 1.0);
  tmpvar_49 = (tmpvar_50 * (tmpvar_50 * (3.0 - 
    (2.0 * tmpvar_50)
  )));
  highp vec3 viewDir_51;
  viewDir_51 = tmpvar_18.xyz;
  mediump float moonLunarCancel_52;
  mediump float tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (_ES_MoonDirection, viewDir_51), 0.0, 1.0);
  tmpvar_53 = tmpvar_54;
  highp float tmpvar_55;
  mediump float tmpvar_56;
  tmpvar_56 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_55 = (1.0 - (tmpvar_56 * 2.0));
  moonLunarCancel_52 = tmpvar_55;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((
    ((tmpvar_53 * tmpvar_53) * ((tmpvar_53 * tmpvar_53) * tmpvar_53))
   - 0.5) / 0.5), 0.0, 1.0);
  highp vec3 viewDir_58;
  viewDir_58 = tmpvar_18.xyz;
  mediump float vertical_59;
  mediump float tmpvar_60;
  highp float tmpvar_61;
  tmpvar_61 = clamp (((
    dot (_ES_SunDirection, viewDir_58)
   * 0.5) + 0.5), 0.0, 1.0);
  tmpvar_60 = tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = dot (viewDir_58, _ES_SkyWorldUpDir);
  vertical_59 = tmpvar_62;
  mediump float tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = (1.0 - _ES_SunRimLightRadius);
  tmpvar_63 = clamp (((tmpvar_20 - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (((tmpvar_63 * 
    (tmpvar_63 * (3.0 - (2.0 * tmpvar_63)))
  ) * _ES_SunBrightness) * 0.125);
  mediump float tmpvar_66;
  tmpvar_66 = clamp (((
    ((dot (viewDir_14, _ES_MoonDirection) * 0.5) + 0.5)
   - _ES_SunRimLightRadius) / tmpvar_64), 0.0, 1.0);
  mediump float tmpvar_67;
  tmpvar_67 = (((tmpvar_66 * 
    (tmpvar_66 * (3.0 - (2.0 * tmpvar_66)))
  ) * _ES_MoonBrightness) * 0.1);
  mediump float tmpvar_68;
  tmpvar_68 = max (((tmpvar_19 * _ES_CloudFrontAndBackBlendFactor) + (1.0 - _ES_CloudFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_69;
  tmpvar_69 = ((tmpvar_68 * tmpvar_68) * tmpvar_68);
  gl_Position = clipPos_6;
  xlv_TEXCOORD0 = o_9;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = (((
    ((((tmpvar_57 * 
      (tmpvar_57 * (3.0 - (2.0 * tmpvar_57)))
    ) * _ES_MoonGlowIntensity) * moonLunarCancel_52) * _ES_MoonColor)
   * 
    clamp (_ES_MoonBrightness, 0.0, 0.8)
  ) + (
    (clamp ((pow (tmpvar_60, 
      ((_ES_SunHaloSize * 0.5) * abs(vertical_59))
    ) * vertical_59), 0.0, 1.0) * _ES_SunHaloIntensity)
   * _ES_SunColor)) * tmpvar_49);
  xlv_TEXCOORD6 = (((_ES_SunHaloColor * 
    (tmpvar_65 * tmpvar_65)
  ) + (_ES_MoonColor * 
    (tmpvar_67 * tmpvar_67)
  )) * tmpvar_49);
  xlv_TEXCOORD7 = mix (_ES_CloudLightBackColor, _ES_CloudLightFrontColor, vec3(tmpvar_69));
  xlv_TEXCOORD8 = mix (_ES_CloudDarkBackColor, _ES_CloudDarkFrontColor, vec3(tmpvar_69));
}


#endif
#ifdef FRAGMENT
uniform mediump float _ES_CloudCoverage;
uniform sampler2D _CloudParticleAtlas;
uniform sampler2D _CloudCurlTex;
uniform highp float _CloudCurlAmplitude;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 cloudCol_1;
  mediump vec4 texCol_2;
  highp vec3 curlNoise_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_CloudCurlTex, xlv_TEXCOORD1.zw).xyz;
  curlNoise_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD1.xy + ((
    (curlNoise_3.xy - 0.5)
   * curlNoise_3.z) * _CloudCurlAmplitude));
  tmpvar_5 = texture2D (_CloudParticleAtlas, P_6);
  texCol_2 = tmpvar_5;
  mediump float tmpvar_7;
  tmpvar_7 = max ((xlv_TEXCOORD3.w - xlv_TEXCOORD3.y), 0.0);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.y), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD2.w - -0.1) / 0.2), 0.0, 1.0);
  cloudCol_1.w = ((texCol_2.w * (tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  )) * (tmpvar_9 * (tmpvar_9 * 
    (3.0 - (2.0 * tmpvar_9))
  )));
  mediump float x_10;
  x_10 = (cloudCol_1.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((texCol_2.z - tmpvar_7) / (
    min ((xlv_TEXCOORD3.w + xlv_TEXCOORD3.z), 1.0)
   - tmpvar_7)), 0.0, 1.0);
  cloudCol_1.xyz = ((mix (xlv_TEXCOORD8, xlv_TEXCOORD7, texCol_2.xxx) + (xlv_TEXCOORD6 * 
    mix (texCol_2.y, ((1.0 - (tmpvar_11 * 
      (tmpvar_11 * (3.0 - (2.0 * tmpvar_11)))
    )) * 4.0), xlv_TEXCOORD3.w)
  )) + ((0.4 * xlv_TEXCOORD7) * _ES_CloudCoverage));
  cloudCol_1.xyz = (cloudCol_1.xyz + (xlv_TEXCOORD5 * texCol_2.x));
  cloudCol_1.xyz = (cloudCol_1.xyz * (xlv_TEXCOORD3.x + 1.0));
  mediump float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD2.w / 0.1), 0.0, 1.0);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((_ES_CloudCoverage - 0.4) / 0.3), 0.0, 1.0);
  cloudCol_1.xyz = mix (xlv_TEXCOORD4, cloudCol_1.xyz, vec3(mix (clamp (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
  , 0.0, 1.0), 1.0, (tmpvar_13 * 
    (tmpvar_13 * (3.0 - (2.0 * tmpvar_13)))
  ))));
  cloudCol_1.w = clamp (cloudCol_1.w, 0.0, 1.0);
  gl_FragData[0] = cloudCol_1;
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
Keywords { "FIXED_SPRITE_ID" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FIXED_SPRITE_ID" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FIXED_SPRITE_ID" }
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
Keywords { "FOG_LERP" "FIXED_SPRITE_ID" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "FIXED_SPRITE_ID" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "FIXED_SPRITE_ID" }
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
Keywords { "FOG_HEIGHT" "FIXED_SPRITE_ID" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "FIXED_SPRITE_ID" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "FIXED_SPRITE_ID" }
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
Keywords { "FOG_HEIGHT" "FOG_LERP" "FIXED_SPRITE_ID" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "FIXED_SPRITE_ID" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "FIXED_SPRITE_ID" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FIXED_RIMLIGHT_WIDTH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FIXED_RIMLIGHT_WIDTH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FIXED_RIMLIGHT_WIDTH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FIXED_SPRITE_ID" "FIXED_RIMLIGHT_WIDTH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FIXED_SPRITE_ID" "FIXED_RIMLIGHT_WIDTH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FIXED_SPRITE_ID" "FIXED_RIMLIGHT_WIDTH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "FIXED_RIMLIGHT_WIDTH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "FIXED_RIMLIGHT_WIDTH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "FIXED_RIMLIGHT_WIDTH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "FIXED_SPRITE_ID" "FIXED_RIMLIGHT_WIDTH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "FIXED_SPRITE_ID" "FIXED_RIMLIGHT_WIDTH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "FIXED_SPRITE_ID" "FIXED_RIMLIGHT_WIDTH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" "FIXED_RIMLIGHT_WIDTH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "FIXED_RIMLIGHT_WIDTH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "FIXED_RIMLIGHT_WIDTH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" "FIXED_SPRITE_ID" "FIXED_RIMLIGHT_WIDTH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "FIXED_SPRITE_ID" "FIXED_RIMLIGHT_WIDTH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "FIXED_SPRITE_ID" "FIXED_RIMLIGHT_WIDTH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "FIXED_RIMLIGHT_WIDTH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "FIXED_RIMLIGHT_WIDTH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "FIXED_RIMLIGHT_WIDTH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "FIXED_SPRITE_ID" "FIXED_RIMLIGHT_WIDTH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "FIXED_SPRITE_ID" "FIXED_RIMLIGHT_WIDTH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "FIXED_SPRITE_ID" "FIXED_RIMLIGHT_WIDTH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FIXED_EDGE_SMOOTHNESS" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FIXED_EDGE_SMOOTHNESS" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FIXED_EDGE_SMOOTHNESS" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FIXED_SPRITE_ID" "FIXED_EDGE_SMOOTHNESS" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FIXED_SPRITE_ID" "FIXED_EDGE_SMOOTHNESS" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FIXED_SPRITE_ID" "FIXED_EDGE_SMOOTHNESS" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "FIXED_EDGE_SMOOTHNESS" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "FIXED_EDGE_SMOOTHNESS" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "FIXED_EDGE_SMOOTHNESS" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "FIXED_SPRITE_ID" "FIXED_EDGE_SMOOTHNESS" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "FIXED_SPRITE_ID" "FIXED_EDGE_SMOOTHNESS" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "FIXED_SPRITE_ID" "FIXED_EDGE_SMOOTHNESS" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" "FIXED_EDGE_SMOOTHNESS" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "FIXED_EDGE_SMOOTHNESS" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "FIXED_EDGE_SMOOTHNESS" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" "FIXED_SPRITE_ID" "FIXED_EDGE_SMOOTHNESS" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "FIXED_SPRITE_ID" "FIXED_EDGE_SMOOTHNESS" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "FIXED_SPRITE_ID" "FIXED_EDGE_SMOOTHNESS" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "FIXED_EDGE_SMOOTHNESS" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "FIXED_EDGE_SMOOTHNESS" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "FIXED_EDGE_SMOOTHNESS" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "FIXED_SPRITE_ID" "FIXED_EDGE_SMOOTHNESS" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "FIXED_SPRITE_ID" "FIXED_EDGE_SMOOTHNESS" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "FIXED_SPRITE_ID" "FIXED_EDGE_SMOOTHNESS" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FIXED_EDGE_SMOOTHNESS" "FIXED_RIMLIGHT_WIDTH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FIXED_EDGE_SMOOTHNESS" "FIXED_RIMLIGHT_WIDTH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FIXED_EDGE_SMOOTHNESS" "FIXED_RIMLIGHT_WIDTH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FIXED_SPRITE_ID" "FIXED_EDGE_SMOOTHNESS" "FIXED_RIMLIGHT_WIDTH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FIXED_SPRITE_ID" "FIXED_EDGE_SMOOTHNESS" "FIXED_RIMLIGHT_WIDTH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FIXED_SPRITE_ID" "FIXED_EDGE_SMOOTHNESS" "FIXED_RIMLIGHT_WIDTH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "FIXED_EDGE_SMOOTHNESS" "FIXED_RIMLIGHT_WIDTH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "FIXED_EDGE_SMOOTHNESS" "FIXED_RIMLIGHT_WIDTH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "FIXED_EDGE_SMOOTHNESS" "FIXED_RIMLIGHT_WIDTH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "FIXED_SPRITE_ID" "FIXED_EDGE_SMOOTHNESS" "FIXED_RIMLIGHT_WIDTH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "FIXED_SPRITE_ID" "FIXED_EDGE_SMOOTHNESS" "FIXED_RIMLIGHT_WIDTH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "FIXED_SPRITE_ID" "FIXED_EDGE_SMOOTHNESS" "FIXED_RIMLIGHT_WIDTH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" "FIXED_EDGE_SMOOTHNESS" "FIXED_RIMLIGHT_WIDTH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "FIXED_EDGE_SMOOTHNESS" "FIXED_RIMLIGHT_WIDTH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "FIXED_EDGE_SMOOTHNESS" "FIXED_RIMLIGHT_WIDTH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" "FIXED_SPRITE_ID" "FIXED_EDGE_SMOOTHNESS" "FIXED_RIMLIGHT_WIDTH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "FIXED_SPRITE_ID" "FIXED_EDGE_SMOOTHNESS" "FIXED_RIMLIGHT_WIDTH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "FIXED_SPRITE_ID" "FIXED_EDGE_SMOOTHNESS" "FIXED_RIMLIGHT_WIDTH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "FIXED_EDGE_SMOOTHNESS" "FIXED_RIMLIGHT_WIDTH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "FIXED_EDGE_SMOOTHNESS" "FIXED_RIMLIGHT_WIDTH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "FIXED_EDGE_SMOOTHNESS" "FIXED_RIMLIGHT_WIDTH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "FIXED_SPRITE_ID" "FIXED_EDGE_SMOOTHNESS" "FIXED_RIMLIGHT_WIDTH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "FIXED_SPRITE_ID" "FIXED_EDGE_SMOOTHNESS" "FIXED_RIMLIGHT_WIDTH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "FIXED_SPRITE_ID" "FIXED_EDGE_SMOOTHNESS" "FIXED_RIMLIGHT_WIDTH" }
""
}
}
}
}
}