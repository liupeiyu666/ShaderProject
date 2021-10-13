//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Dynamic Sky/Atmosphere Layer" {
Properties {
_SkyGradientTex ("Sky Gradient Tex", 2D) = "white" { }
_StarsTex ("Stars (Alpha)", 2D) = "white" { }
_StarsColorPalette ("Stars Color Palette", 2D) = "white" { }
_NoiseTex ("Noise Tex (Alpha)", 2D) = "white" { }
}
SubShader {
 Tags { "QUEUE" = "Background" "RenderType" = "Transparent" }
 Pass {
  Tags { "QUEUE" = "Background" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 18576
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform highp float _ES_StarsScintillation;
uniform sampler2D _SkyGradientTex;
uniform highp vec4 _StarsTex_ST;
uniform highp vec4 _NoiseTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
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
  mediump vec3 viewDir_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(((unity_ObjectToWorld * tmpvar_13).xyz - _ES_SkyCenterWorldPos));
  viewDir_12 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (_ES_SkyWorldUpDir, viewDir_12);
  mediump vec4 tmpvar_16;
  tmpvar_16.xyz = viewDir_12;
  tmpvar_16.w = ((sign(tmpvar_15) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_15))) * (1.570796 + (abs(tmpvar_15) * (-0.2146018 + 
      (abs(tmpvar_15) * (0.08656672 + (abs(tmpvar_15) * -0.03102955)))
    ))))
  )) * 0.6366198);
  tmpvar_4 = tmpvar_16;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _StarsTex_ST.xy) + _StarsTex_ST.zw);
  tmpvar_2.zw = (_glesMultiTexCoord0.xy * 20.0);
  highp vec2 tmpvar_17;
  tmpvar_17 = (_glesMultiTexCoord0.xy * _NoiseTex_ST.xy);
  highp vec2 tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = (_Time.y * _ES_StarsScintillation);
  tmpvar_18.x = (tmpvar_19 * 0.4);
  tmpvar_18.y = (tmpvar_19 * 0.2);
  tmpvar_3.xy = (tmpvar_17 + tmpvar_18);
  highp vec2 tmpvar_20;
  tmpvar_20.x = (tmpvar_19 * 0.1);
  tmpvar_20.y = (tmpvar_19 * 0.5);
  tmpvar_3.zw = ((tmpvar_17 * 2.0) + tmpvar_20);
  mediump vec3 viewDir_21;
  viewDir_21 = tmpvar_4.xyz;
  mediump float verticalBlend_22;
  verticalBlend_22 = tmpvar_4.w;
  mediump vec3 atomosphere_23;
  mediump float tmpvar_24;
  tmpvar_24 = dot (_ES_SunDirection, viewDir_21);
  mediump float tmpvar_25;
  tmpvar_25 = max (((tmpvar_24 * _ES_SkyFrontAndBackBlendFactor) + (1.0 - _ES_SkyFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_26;
  tmpvar_26 = ((tmpvar_25 * tmpvar_25) * tmpvar_25);
  mediump vec4 tmpvar_27;
  tmpvar_27.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_27.x = (abs(verticalBlend_22) / max (_ES_BottomColorHeight, 0.0001));
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2DLod (_SkyGradientTex, tmpvar_27.xy, 0.0);
  mediump float tmpvar_29;
  tmpvar_29 = tmpvar_28.x;
  atomosphere_23 = mix (mix (_ES_TopBackColor, _ES_TopFrontColor, vec4(tmpvar_26)).xyz, mix (_ES_BottomBackColor, _ES_BottomFrontColor, vec4(tmpvar_26)).xyz, vec3(tmpvar_29));
  mediump vec4 tmpvar_30;
  tmpvar_30.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_30.x = (abs(verticalBlend_22) / max (_ES_HorizonHaloHeight, 0.0001));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DLod (_SkyGradientTex, tmpvar_30.xy, 0.0);
  mediump float tmpvar_32;
  tmpvar_32 = tmpvar_31.y;
  mediump float tmpvar_33;
  tmpvar_33 = clamp (((
    max (((tmpvar_24 * 0.5) + 0.5), 0.0)
   - 0.3) / 0.7), 0.0, 1.0);
  mediump float tmpvar_34;
  tmpvar_34 = clamp (((
    abs(_ES_SunDirection.y)
   - 0.2) / 0.3), 0.0, 1.0);
  atomosphere_23 = (atomosphere_23 + ((
    (_ES_HorizonHaloColor * _ES_HorizonHaloIntensity)
   * tmpvar_32) * mix (
    (tmpvar_33 * (tmpvar_33 * (3.0 - (2.0 * tmpvar_33))))
  , 1.0, 
    (tmpvar_34 * (tmpvar_34 * (3.0 - (2.0 * tmpvar_34))))
  )));
  mediump vec4 tmpvar_35;
  tmpvar_35.xyz = atomosphere_23;
  tmpvar_35.w = tmpvar_26;
  tmpvar_5 = tmpvar_35;
  gl_Position = clipPos_6;
  xlv_TEXCOORD0 = o_9;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec3 _ES_SunDirection;
uniform mediump float _ES_SunHaloSize;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump float _ES_MoonSize;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform mediump float _ES_StarsBrightness;
uniform mediump float _ES_StarsDensity;
uniform sampler2D _StarsTex;
uniform sampler2D _StarsColorPalette;
uniform highp vec4 _StarsColorPalette_ST;
uniform sampler2D _NoiseTex;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 starsColor_2;
  highp float starsDensity_3;
  highp float starsNoise_4;
  highp float scintillation_5;
  highp float stars_6;
  highp vec3 col_7;
  highp vec4 tmpvar_8;
  tmpvar_8.xyz = normalize(xlv_TEXCOORD3.xyz);
  tmpvar_8.w = xlv_TEXCOORD3.w;
  highp float haloInfluence_9;
  mediump float vertical_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp (((
    dot (_ES_SunDirection, tmpvar_8.xyz)
   * 0.5) + 0.5), 0.0, 1.0);
  highp float tmpvar_12;
  tmpvar_12 = dot (tmpvar_8.xyz, _ES_SkyWorldUpDir);
  vertical_10 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = abs(vertical_10);
  mediump float y_14;
  y_14 = (_ES_SunHaloSize * tmpvar_13);
  mediump float y_15;
  y_15 = ((_ES_SunHaloSize * 0.1) * tmpvar_13);
  haloInfluence_9 = (clamp (pow (tmpvar_11, y_14), 0.0, 1.0) + (clamp (
    pow (tmpvar_11, y_15)
  , 0.0, 1.0) * 0.12));
  mediump float y_16;
  y_16 = ((_ES_SunHaloSize * 0.01) * tmpvar_13);
  haloInfluence_9 = (haloInfluence_9 + (clamp (
    pow (tmpvar_11, y_16)
  , 0.0, 1.0) * 0.03));
  highp float tmpvar_17;
  tmpvar_17 = clamp (((
    max (((dot (_ES_SunDirection, tmpvar_8.xyz) * 0.5) + 0.5), 0.0)
   - 0.5) / 0.5), 0.0, 1.0);
  col_7 = (xlv_TEXCOORD4.xyz + ((
    (haloInfluence_9 * _ES_SunHaloIntensity)
   * _ES_SunHaloColor) * (tmpvar_17 * 
    (tmpvar_17 * (3.0 - (2.0 * tmpvar_17)))
  )));
  highp float moonGradient_18;
  highp float tmpvar_19;
  tmpvar_19 = clamp (dot (_ES_MoonDirection, tmpvar_8.xyz), 0.0, 1.0);
  highp float tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = clamp (_ES_MoonBrightness, 0.0, 1.0);
  tmpvar_20 = tmpvar_21;
  highp float tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_22 = (1.0 - (tmpvar_23 * 2.0));
  mediump float a_24;
  a_24 = tmpvar_19;
  mediump float x_25;
  x_25 = (a_24 - 1.0);
  mediump float tmpvar_26;
  tmpvar_26 = clamp ((1.0 - (
    sqrt((x_25 * x_25))
   * 
    (1.0/(max ((_ES_MoonSize * 0.1), 1e-05)))
  )), 0.0, 1.0);
  moonGradient_18 = tmpvar_26;
  mediump float tmpvar_27;
  mediump float x_28;
  x_28 = moonGradient_18;
  tmpvar_27 = (((x_28 * x_28) * (x_28 * x_28)) * (x_28 * x_28));
  moonGradient_18 = tmpvar_27;
  moonGradient_18 = (moonGradient_18 * (_ES_MoonGlowIntensity * tmpvar_22));
  col_7 = (col_7 + ((moonGradient_18 * _ES_MoonColor) * tmpvar_20));
  lowp float tmpvar_29;
  tmpvar_29 = texture2D (_StarsTex, xlv_TEXCOORD1.xy).w;
  stars_6 = tmpvar_29;
  lowp float tmpvar_30;
  tmpvar_30 = ((texture2D (_NoiseTex, xlv_TEXCOORD2.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD2.zw).w) * 3.0);
  scintillation_5 = tmpvar_30;
  lowp float tmpvar_31;
  tmpvar_31 = texture2D (_NoiseTex, xlv_TEXCOORD1.zw).w;
  starsNoise_4 = tmpvar_31;
  mediump float value_32;
  value_32 = starsNoise_4;
  mediump float tmpvar_33;
  tmpvar_33 = clamp (((value_32 - _ES_StarsDensity) / (1.0 - _ES_StarsDensity)), 0.0, 1.0);
  starsDensity_3 = tmpvar_33;
  highp vec2 tmpvar_34;
  tmpvar_34.y = 0.5;
  tmpvar_34.x = ((starsNoise_4 * _StarsColorPalette_ST.x) + _StarsColorPalette_ST.z);
  lowp vec3 tmpvar_35;
  tmpvar_35 = texture2D (_StarsColorPalette, tmpvar_34).xyz;
  starsColor_2 = tmpvar_35;
  col_7 = (col_7 + ((
    (starsColor_2 * _ES_StarsBrightness)
   * 
    (((stars_6 * scintillation_5) * clamp ((xlv_TEXCOORD3.w * 1.5), 0.0, 1.0)) * starsDensity_3)
  ) * float(
    (0.05 >= moonGradient_18)
  )));
  highp vec4 tmpvar_36;
  tmpvar_36.w = 1.0;
  tmpvar_36.xyz = col_7;
  tmpvar_1 = tmpvar_36;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform highp float _ES_StarsScintillation;
uniform sampler2D _SkyGradientTex;
uniform highp vec4 _StarsTex_ST;
uniform highp vec4 _NoiseTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
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
  mediump vec3 viewDir_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(((unity_ObjectToWorld * tmpvar_13).xyz - _ES_SkyCenterWorldPos));
  viewDir_12 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (_ES_SkyWorldUpDir, viewDir_12);
  mediump vec4 tmpvar_16;
  tmpvar_16.xyz = viewDir_12;
  tmpvar_16.w = ((sign(tmpvar_15) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_15))) * (1.570796 + (abs(tmpvar_15) * (-0.2146018 + 
      (abs(tmpvar_15) * (0.08656672 + (abs(tmpvar_15) * -0.03102955)))
    ))))
  )) * 0.6366198);
  tmpvar_4 = tmpvar_16;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _StarsTex_ST.xy) + _StarsTex_ST.zw);
  tmpvar_2.zw = (_glesMultiTexCoord0.xy * 20.0);
  highp vec2 tmpvar_17;
  tmpvar_17 = (_glesMultiTexCoord0.xy * _NoiseTex_ST.xy);
  highp vec2 tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = (_Time.y * _ES_StarsScintillation);
  tmpvar_18.x = (tmpvar_19 * 0.4);
  tmpvar_18.y = (tmpvar_19 * 0.2);
  tmpvar_3.xy = (tmpvar_17 + tmpvar_18);
  highp vec2 tmpvar_20;
  tmpvar_20.x = (tmpvar_19 * 0.1);
  tmpvar_20.y = (tmpvar_19 * 0.5);
  tmpvar_3.zw = ((tmpvar_17 * 2.0) + tmpvar_20);
  mediump vec3 viewDir_21;
  viewDir_21 = tmpvar_4.xyz;
  mediump float verticalBlend_22;
  verticalBlend_22 = tmpvar_4.w;
  mediump vec3 atomosphere_23;
  mediump float tmpvar_24;
  tmpvar_24 = dot (_ES_SunDirection, viewDir_21);
  mediump float tmpvar_25;
  tmpvar_25 = max (((tmpvar_24 * _ES_SkyFrontAndBackBlendFactor) + (1.0 - _ES_SkyFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_26;
  tmpvar_26 = ((tmpvar_25 * tmpvar_25) * tmpvar_25);
  mediump vec4 tmpvar_27;
  tmpvar_27.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_27.x = (abs(verticalBlend_22) / max (_ES_BottomColorHeight, 0.0001));
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2DLod (_SkyGradientTex, tmpvar_27.xy, 0.0);
  mediump float tmpvar_29;
  tmpvar_29 = tmpvar_28.x;
  atomosphere_23 = mix (mix (_ES_TopBackColor, _ES_TopFrontColor, vec4(tmpvar_26)).xyz, mix (_ES_BottomBackColor, _ES_BottomFrontColor, vec4(tmpvar_26)).xyz, vec3(tmpvar_29));
  mediump vec4 tmpvar_30;
  tmpvar_30.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_30.x = (abs(verticalBlend_22) / max (_ES_HorizonHaloHeight, 0.0001));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DLod (_SkyGradientTex, tmpvar_30.xy, 0.0);
  mediump float tmpvar_32;
  tmpvar_32 = tmpvar_31.y;
  mediump float tmpvar_33;
  tmpvar_33 = clamp (((
    max (((tmpvar_24 * 0.5) + 0.5), 0.0)
   - 0.3) / 0.7), 0.0, 1.0);
  mediump float tmpvar_34;
  tmpvar_34 = clamp (((
    abs(_ES_SunDirection.y)
   - 0.2) / 0.3), 0.0, 1.0);
  atomosphere_23 = (atomosphere_23 + ((
    (_ES_HorizonHaloColor * _ES_HorizonHaloIntensity)
   * tmpvar_32) * mix (
    (tmpvar_33 * (tmpvar_33 * (3.0 - (2.0 * tmpvar_33))))
  , 1.0, 
    (tmpvar_34 * (tmpvar_34 * (3.0 - (2.0 * tmpvar_34))))
  )));
  mediump vec4 tmpvar_35;
  tmpvar_35.xyz = atomosphere_23;
  tmpvar_35.w = tmpvar_26;
  tmpvar_5 = tmpvar_35;
  gl_Position = clipPos_6;
  xlv_TEXCOORD0 = o_9;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec3 _ES_SunDirection;
uniform mediump float _ES_SunHaloSize;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump float _ES_MoonSize;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform mediump float _ES_StarsBrightness;
uniform mediump float _ES_StarsDensity;
uniform sampler2D _StarsTex;
uniform sampler2D _StarsColorPalette;
uniform highp vec4 _StarsColorPalette_ST;
uniform sampler2D _NoiseTex;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 starsColor_2;
  highp float starsDensity_3;
  highp float starsNoise_4;
  highp float scintillation_5;
  highp float stars_6;
  highp vec3 col_7;
  highp vec4 tmpvar_8;
  tmpvar_8.xyz = normalize(xlv_TEXCOORD3.xyz);
  tmpvar_8.w = xlv_TEXCOORD3.w;
  highp float haloInfluence_9;
  mediump float vertical_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp (((
    dot (_ES_SunDirection, tmpvar_8.xyz)
   * 0.5) + 0.5), 0.0, 1.0);
  highp float tmpvar_12;
  tmpvar_12 = dot (tmpvar_8.xyz, _ES_SkyWorldUpDir);
  vertical_10 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = abs(vertical_10);
  mediump float y_14;
  y_14 = (_ES_SunHaloSize * tmpvar_13);
  mediump float y_15;
  y_15 = ((_ES_SunHaloSize * 0.1) * tmpvar_13);
  haloInfluence_9 = (clamp (pow (tmpvar_11, y_14), 0.0, 1.0) + (clamp (
    pow (tmpvar_11, y_15)
  , 0.0, 1.0) * 0.12));
  mediump float y_16;
  y_16 = ((_ES_SunHaloSize * 0.01) * tmpvar_13);
  haloInfluence_9 = (haloInfluence_9 + (clamp (
    pow (tmpvar_11, y_16)
  , 0.0, 1.0) * 0.03));
  highp float tmpvar_17;
  tmpvar_17 = clamp (((
    max (((dot (_ES_SunDirection, tmpvar_8.xyz) * 0.5) + 0.5), 0.0)
   - 0.5) / 0.5), 0.0, 1.0);
  col_7 = (xlv_TEXCOORD4.xyz + ((
    (haloInfluence_9 * _ES_SunHaloIntensity)
   * _ES_SunHaloColor) * (tmpvar_17 * 
    (tmpvar_17 * (3.0 - (2.0 * tmpvar_17)))
  )));
  highp float moonGradient_18;
  highp float tmpvar_19;
  tmpvar_19 = clamp (dot (_ES_MoonDirection, tmpvar_8.xyz), 0.0, 1.0);
  highp float tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = clamp (_ES_MoonBrightness, 0.0, 1.0);
  tmpvar_20 = tmpvar_21;
  highp float tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_22 = (1.0 - (tmpvar_23 * 2.0));
  mediump float a_24;
  a_24 = tmpvar_19;
  mediump float x_25;
  x_25 = (a_24 - 1.0);
  mediump float tmpvar_26;
  tmpvar_26 = clamp ((1.0 - (
    sqrt((x_25 * x_25))
   * 
    (1.0/(max ((_ES_MoonSize * 0.1), 1e-05)))
  )), 0.0, 1.0);
  moonGradient_18 = tmpvar_26;
  mediump float tmpvar_27;
  mediump float x_28;
  x_28 = moonGradient_18;
  tmpvar_27 = (((x_28 * x_28) * (x_28 * x_28)) * (x_28 * x_28));
  moonGradient_18 = tmpvar_27;
  moonGradient_18 = (moonGradient_18 * (_ES_MoonGlowIntensity * tmpvar_22));
  col_7 = (col_7 + ((moonGradient_18 * _ES_MoonColor) * tmpvar_20));
  lowp float tmpvar_29;
  tmpvar_29 = texture2D (_StarsTex, xlv_TEXCOORD1.xy).w;
  stars_6 = tmpvar_29;
  lowp float tmpvar_30;
  tmpvar_30 = ((texture2D (_NoiseTex, xlv_TEXCOORD2.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD2.zw).w) * 3.0);
  scintillation_5 = tmpvar_30;
  lowp float tmpvar_31;
  tmpvar_31 = texture2D (_NoiseTex, xlv_TEXCOORD1.zw).w;
  starsNoise_4 = tmpvar_31;
  mediump float value_32;
  value_32 = starsNoise_4;
  mediump float tmpvar_33;
  tmpvar_33 = clamp (((value_32 - _ES_StarsDensity) / (1.0 - _ES_StarsDensity)), 0.0, 1.0);
  starsDensity_3 = tmpvar_33;
  highp vec2 tmpvar_34;
  tmpvar_34.y = 0.5;
  tmpvar_34.x = ((starsNoise_4 * _StarsColorPalette_ST.x) + _StarsColorPalette_ST.z);
  lowp vec3 tmpvar_35;
  tmpvar_35 = texture2D (_StarsColorPalette, tmpvar_34).xyz;
  starsColor_2 = tmpvar_35;
  col_7 = (col_7 + ((
    (starsColor_2 * _ES_StarsBrightness)
   * 
    (((stars_6 * scintillation_5) * clamp ((xlv_TEXCOORD3.w * 1.5), 0.0, 1.0)) * starsDensity_3)
  ) * float(
    (0.05 >= moonGradient_18)
  )));
  highp vec4 tmpvar_36;
  tmpvar_36.w = 1.0;
  tmpvar_36.xyz = col_7;
  tmpvar_1 = tmpvar_36;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform highp float _ES_StarsScintillation;
uniform sampler2D _SkyGradientTex;
uniform highp vec4 _StarsTex_ST;
uniform highp vec4 _NoiseTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
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
  mediump vec3 viewDir_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(((unity_ObjectToWorld * tmpvar_13).xyz - _ES_SkyCenterWorldPos));
  viewDir_12 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (_ES_SkyWorldUpDir, viewDir_12);
  mediump vec4 tmpvar_16;
  tmpvar_16.xyz = viewDir_12;
  tmpvar_16.w = ((sign(tmpvar_15) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_15))) * (1.570796 + (abs(tmpvar_15) * (-0.2146018 + 
      (abs(tmpvar_15) * (0.08656672 + (abs(tmpvar_15) * -0.03102955)))
    ))))
  )) * 0.6366198);
  tmpvar_4 = tmpvar_16;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _StarsTex_ST.xy) + _StarsTex_ST.zw);
  tmpvar_2.zw = (_glesMultiTexCoord0.xy * 20.0);
  highp vec2 tmpvar_17;
  tmpvar_17 = (_glesMultiTexCoord0.xy * _NoiseTex_ST.xy);
  highp vec2 tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = (_Time.y * _ES_StarsScintillation);
  tmpvar_18.x = (tmpvar_19 * 0.4);
  tmpvar_18.y = (tmpvar_19 * 0.2);
  tmpvar_3.xy = (tmpvar_17 + tmpvar_18);
  highp vec2 tmpvar_20;
  tmpvar_20.x = (tmpvar_19 * 0.1);
  tmpvar_20.y = (tmpvar_19 * 0.5);
  tmpvar_3.zw = ((tmpvar_17 * 2.0) + tmpvar_20);
  mediump vec3 viewDir_21;
  viewDir_21 = tmpvar_4.xyz;
  mediump float verticalBlend_22;
  verticalBlend_22 = tmpvar_4.w;
  mediump vec3 atomosphere_23;
  mediump float tmpvar_24;
  tmpvar_24 = dot (_ES_SunDirection, viewDir_21);
  mediump float tmpvar_25;
  tmpvar_25 = max (((tmpvar_24 * _ES_SkyFrontAndBackBlendFactor) + (1.0 - _ES_SkyFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_26;
  tmpvar_26 = ((tmpvar_25 * tmpvar_25) * tmpvar_25);
  mediump vec4 tmpvar_27;
  tmpvar_27.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_27.x = (abs(verticalBlend_22) / max (_ES_BottomColorHeight, 0.0001));
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2DLod (_SkyGradientTex, tmpvar_27.xy, 0.0);
  mediump float tmpvar_29;
  tmpvar_29 = tmpvar_28.x;
  atomosphere_23 = mix (mix (_ES_TopBackColor, _ES_TopFrontColor, vec4(tmpvar_26)).xyz, mix (_ES_BottomBackColor, _ES_BottomFrontColor, vec4(tmpvar_26)).xyz, vec3(tmpvar_29));
  mediump vec4 tmpvar_30;
  tmpvar_30.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_30.x = (abs(verticalBlend_22) / max (_ES_HorizonHaloHeight, 0.0001));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DLod (_SkyGradientTex, tmpvar_30.xy, 0.0);
  mediump float tmpvar_32;
  tmpvar_32 = tmpvar_31.y;
  mediump float tmpvar_33;
  tmpvar_33 = clamp (((
    max (((tmpvar_24 * 0.5) + 0.5), 0.0)
   - 0.3) / 0.7), 0.0, 1.0);
  mediump float tmpvar_34;
  tmpvar_34 = clamp (((
    abs(_ES_SunDirection.y)
   - 0.2) / 0.3), 0.0, 1.0);
  atomosphere_23 = (atomosphere_23 + ((
    (_ES_HorizonHaloColor * _ES_HorizonHaloIntensity)
   * tmpvar_32) * mix (
    (tmpvar_33 * (tmpvar_33 * (3.0 - (2.0 * tmpvar_33))))
  , 1.0, 
    (tmpvar_34 * (tmpvar_34 * (3.0 - (2.0 * tmpvar_34))))
  )));
  mediump vec4 tmpvar_35;
  tmpvar_35.xyz = atomosphere_23;
  tmpvar_35.w = tmpvar_26;
  tmpvar_5 = tmpvar_35;
  gl_Position = clipPos_6;
  xlv_TEXCOORD0 = o_9;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec3 _ES_SunDirection;
uniform mediump float _ES_SunHaloSize;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump float _ES_MoonSize;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform mediump float _ES_StarsBrightness;
uniform mediump float _ES_StarsDensity;
uniform sampler2D _StarsTex;
uniform sampler2D _StarsColorPalette;
uniform highp vec4 _StarsColorPalette_ST;
uniform sampler2D _NoiseTex;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 starsColor_2;
  highp float starsDensity_3;
  highp float starsNoise_4;
  highp float scintillation_5;
  highp float stars_6;
  highp vec3 col_7;
  highp vec4 tmpvar_8;
  tmpvar_8.xyz = normalize(xlv_TEXCOORD3.xyz);
  tmpvar_8.w = xlv_TEXCOORD3.w;
  highp float haloInfluence_9;
  mediump float vertical_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp (((
    dot (_ES_SunDirection, tmpvar_8.xyz)
   * 0.5) + 0.5), 0.0, 1.0);
  highp float tmpvar_12;
  tmpvar_12 = dot (tmpvar_8.xyz, _ES_SkyWorldUpDir);
  vertical_10 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = abs(vertical_10);
  mediump float y_14;
  y_14 = (_ES_SunHaloSize * tmpvar_13);
  mediump float y_15;
  y_15 = ((_ES_SunHaloSize * 0.1) * tmpvar_13);
  haloInfluence_9 = (clamp (pow (tmpvar_11, y_14), 0.0, 1.0) + (clamp (
    pow (tmpvar_11, y_15)
  , 0.0, 1.0) * 0.12));
  mediump float y_16;
  y_16 = ((_ES_SunHaloSize * 0.01) * tmpvar_13);
  haloInfluence_9 = (haloInfluence_9 + (clamp (
    pow (tmpvar_11, y_16)
  , 0.0, 1.0) * 0.03));
  highp float tmpvar_17;
  tmpvar_17 = clamp (((
    max (((dot (_ES_SunDirection, tmpvar_8.xyz) * 0.5) + 0.5), 0.0)
   - 0.5) / 0.5), 0.0, 1.0);
  col_7 = (xlv_TEXCOORD4.xyz + ((
    (haloInfluence_9 * _ES_SunHaloIntensity)
   * _ES_SunHaloColor) * (tmpvar_17 * 
    (tmpvar_17 * (3.0 - (2.0 * tmpvar_17)))
  )));
  highp float moonGradient_18;
  highp float tmpvar_19;
  tmpvar_19 = clamp (dot (_ES_MoonDirection, tmpvar_8.xyz), 0.0, 1.0);
  highp float tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = clamp (_ES_MoonBrightness, 0.0, 1.0);
  tmpvar_20 = tmpvar_21;
  highp float tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_22 = (1.0 - (tmpvar_23 * 2.0));
  mediump float a_24;
  a_24 = tmpvar_19;
  mediump float x_25;
  x_25 = (a_24 - 1.0);
  mediump float tmpvar_26;
  tmpvar_26 = clamp ((1.0 - (
    sqrt((x_25 * x_25))
   * 
    (1.0/(max ((_ES_MoonSize * 0.1), 1e-05)))
  )), 0.0, 1.0);
  moonGradient_18 = tmpvar_26;
  mediump float tmpvar_27;
  mediump float x_28;
  x_28 = moonGradient_18;
  tmpvar_27 = (((x_28 * x_28) * (x_28 * x_28)) * (x_28 * x_28));
  moonGradient_18 = tmpvar_27;
  moonGradient_18 = (moonGradient_18 * (_ES_MoonGlowIntensity * tmpvar_22));
  col_7 = (col_7 + ((moonGradient_18 * _ES_MoonColor) * tmpvar_20));
  lowp float tmpvar_29;
  tmpvar_29 = texture2D (_StarsTex, xlv_TEXCOORD1.xy).w;
  stars_6 = tmpvar_29;
  lowp float tmpvar_30;
  tmpvar_30 = ((texture2D (_NoiseTex, xlv_TEXCOORD2.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD2.zw).w) * 3.0);
  scintillation_5 = tmpvar_30;
  lowp float tmpvar_31;
  tmpvar_31 = texture2D (_NoiseTex, xlv_TEXCOORD1.zw).w;
  starsNoise_4 = tmpvar_31;
  mediump float value_32;
  value_32 = starsNoise_4;
  mediump float tmpvar_33;
  tmpvar_33 = clamp (((value_32 - _ES_StarsDensity) / (1.0 - _ES_StarsDensity)), 0.0, 1.0);
  starsDensity_3 = tmpvar_33;
  highp vec2 tmpvar_34;
  tmpvar_34.y = 0.5;
  tmpvar_34.x = ((starsNoise_4 * _StarsColorPalette_ST.x) + _StarsColorPalette_ST.z);
  lowp vec3 tmpvar_35;
  tmpvar_35 = texture2D (_StarsColorPalette, tmpvar_34).xyz;
  starsColor_2 = tmpvar_35;
  col_7 = (col_7 + ((
    (starsColor_2 * _ES_StarsBrightness)
   * 
    (((stars_6 * scintillation_5) * clamp ((xlv_TEXCOORD3.w * 1.5), 0.0, 1.0)) * starsDensity_3)
  ) * float(
    (0.05 >= moonGradient_18)
  )));
  highp vec4 tmpvar_36;
  tmpvar_36.w = 1.0;
  tmpvar_36.xyz = col_7;
  tmpvar_1 = tmpvar_36;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform highp float _ES_StarsScintillation;
uniform sampler2D _SkyGradientTex;
uniform highp vec4 _StarsTex_ST;
uniform highp vec4 _NoiseTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
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
  mediump vec3 viewDir_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(((unity_ObjectToWorld * tmpvar_13).xyz - _ES_SkyCenterWorldPos));
  viewDir_12 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (_ES_SkyWorldUpDir, viewDir_12);
  mediump vec4 tmpvar_16;
  tmpvar_16.xyz = viewDir_12;
  tmpvar_16.w = ((sign(tmpvar_15) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_15))) * (1.570796 + (abs(tmpvar_15) * (-0.2146018 + 
      (abs(tmpvar_15) * (0.08656672 + (abs(tmpvar_15) * -0.03102955)))
    ))))
  )) * 0.6366198);
  tmpvar_4 = tmpvar_16;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _StarsTex_ST.xy) + _StarsTex_ST.zw);
  tmpvar_2.zw = (_glesMultiTexCoord0.xy * 20.0);
  highp vec2 tmpvar_17;
  tmpvar_17 = (_glesMultiTexCoord0.xy * _NoiseTex_ST.xy);
  highp vec2 tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = (_Time.y * _ES_StarsScintillation);
  tmpvar_18.x = (tmpvar_19 * 0.4);
  tmpvar_18.y = (tmpvar_19 * 0.2);
  tmpvar_3.xy = (tmpvar_17 + tmpvar_18);
  highp vec2 tmpvar_20;
  tmpvar_20.x = (tmpvar_19 * 0.1);
  tmpvar_20.y = (tmpvar_19 * 0.5);
  tmpvar_3.zw = ((tmpvar_17 * 2.0) + tmpvar_20);
  mediump vec3 viewDir_21;
  viewDir_21 = tmpvar_4.xyz;
  mediump float verticalBlend_22;
  verticalBlend_22 = tmpvar_4.w;
  mediump vec3 atomosphere_23;
  mediump float tmpvar_24;
  tmpvar_24 = dot (_ES_SunDirection, viewDir_21);
  mediump float tmpvar_25;
  tmpvar_25 = max (((tmpvar_24 * _ES_SkyFrontAndBackBlendFactor) + (1.0 - _ES_SkyFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_26;
  tmpvar_26 = ((tmpvar_25 * tmpvar_25) * tmpvar_25);
  mediump vec4 tmpvar_27;
  tmpvar_27.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_27.x = (abs(verticalBlend_22) / max (_ES_BottomColorHeight, 0.0001));
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2DLod (_SkyGradientTex, tmpvar_27.xy, 0.0);
  mediump float tmpvar_29;
  tmpvar_29 = tmpvar_28.x;
  atomosphere_23 = mix (mix (_ES_TopBackColor, _ES_TopFrontColor, vec4(tmpvar_26)).xyz, mix (_ES_BottomBackColor, _ES_BottomFrontColor, vec4(tmpvar_26)).xyz, vec3(tmpvar_29));
  mediump vec4 tmpvar_30;
  tmpvar_30.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_30.x = (abs(verticalBlend_22) / max (_ES_HorizonHaloHeight, 0.0001));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DLod (_SkyGradientTex, tmpvar_30.xy, 0.0);
  mediump float tmpvar_32;
  tmpvar_32 = tmpvar_31.y;
  mediump float tmpvar_33;
  tmpvar_33 = clamp (((
    max (((tmpvar_24 * 0.5) + 0.5), 0.0)
   - 0.3) / 0.7), 0.0, 1.0);
  mediump float tmpvar_34;
  tmpvar_34 = clamp (((
    abs(_ES_SunDirection.y)
   - 0.2) / 0.3), 0.0, 1.0);
  atomosphere_23 = (atomosphere_23 + ((
    (_ES_HorizonHaloColor * _ES_HorizonHaloIntensity)
   * tmpvar_32) * mix (
    (tmpvar_33 * (tmpvar_33 * (3.0 - (2.0 * tmpvar_33))))
  , 1.0, 
    (tmpvar_34 * (tmpvar_34 * (3.0 - (2.0 * tmpvar_34))))
  )));
  mediump vec4 tmpvar_35;
  tmpvar_35.xyz = atomosphere_23;
  tmpvar_35.w = tmpvar_26;
  tmpvar_5 = tmpvar_35;
  gl_Position = clipPos_6;
  xlv_TEXCOORD0 = o_9;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec3 _ES_SunDirection;
uniform mediump float _ES_SunHaloSize;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump float _ES_MoonSize;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform mediump float _ES_StarsBrightness;
uniform mediump float _ES_StarsDensity;
uniform sampler2D _StarsTex;
uniform sampler2D _StarsColorPalette;
uniform highp vec4 _StarsColorPalette_ST;
uniform sampler2D _NoiseTex;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 starsColor_2;
  highp float starsDensity_3;
  highp float starsNoise_4;
  highp float scintillation_5;
  highp float stars_6;
  highp vec3 col_7;
  highp vec4 tmpvar_8;
  tmpvar_8.xyz = normalize(xlv_TEXCOORD3.xyz);
  tmpvar_8.w = xlv_TEXCOORD3.w;
  highp float haloInfluence_9;
  mediump float vertical_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp (((
    dot (_ES_SunDirection, tmpvar_8.xyz)
   * 0.5) + 0.5), 0.0, 1.0);
  highp float tmpvar_12;
  tmpvar_12 = dot (tmpvar_8.xyz, _ES_SkyWorldUpDir);
  vertical_10 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = abs(vertical_10);
  mediump float y_14;
  y_14 = (_ES_SunHaloSize * tmpvar_13);
  mediump float y_15;
  y_15 = ((_ES_SunHaloSize * 0.1) * tmpvar_13);
  haloInfluence_9 = (clamp (pow (tmpvar_11, y_14), 0.0, 1.0) + (clamp (
    pow (tmpvar_11, y_15)
  , 0.0, 1.0) * 0.12));
  mediump float y_16;
  y_16 = ((_ES_SunHaloSize * 0.01) * tmpvar_13);
  haloInfluence_9 = (haloInfluence_9 + (clamp (
    pow (tmpvar_11, y_16)
  , 0.0, 1.0) * 0.03));
  highp float tmpvar_17;
  tmpvar_17 = clamp (((
    max (((dot (_ES_SunDirection, tmpvar_8.xyz) * 0.5) + 0.5), 0.0)
   - 0.5) / 0.5), 0.0, 1.0);
  col_7 = (xlv_TEXCOORD4.xyz + ((
    (haloInfluence_9 * _ES_SunHaloIntensity)
   * _ES_SunHaloColor) * (tmpvar_17 * 
    (tmpvar_17 * (3.0 - (2.0 * tmpvar_17)))
  )));
  highp float moonGradient_18;
  highp float tmpvar_19;
  tmpvar_19 = clamp (dot (_ES_MoonDirection, tmpvar_8.xyz), 0.0, 1.0);
  highp float tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = clamp (_ES_MoonBrightness, 0.0, 1.0);
  tmpvar_20 = tmpvar_21;
  highp float tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_22 = (1.0 - (tmpvar_23 * 2.0));
  mediump float a_24;
  a_24 = tmpvar_19;
  mediump float x_25;
  x_25 = (a_24 - 1.0);
  mediump float tmpvar_26;
  tmpvar_26 = clamp ((1.0 - (
    sqrt((x_25 * x_25))
   * 
    (1.0/(max ((_ES_MoonSize * 0.1), 1e-05)))
  )), 0.0, 1.0);
  moonGradient_18 = tmpvar_26;
  mediump float tmpvar_27;
  mediump float x_28;
  x_28 = moonGradient_18;
  tmpvar_27 = (((x_28 * x_28) * (x_28 * x_28)) * (x_28 * x_28));
  moonGradient_18 = tmpvar_27;
  moonGradient_18 = (moonGradient_18 * (_ES_MoonGlowIntensity * tmpvar_22));
  col_7 = (col_7 + ((moonGradient_18 * _ES_MoonColor) * tmpvar_20));
  lowp float tmpvar_29;
  tmpvar_29 = texture2D (_StarsTex, xlv_TEXCOORD1.xy).w;
  stars_6 = tmpvar_29;
  lowp float tmpvar_30;
  tmpvar_30 = ((texture2D (_NoiseTex, xlv_TEXCOORD2.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD2.zw).w) * 3.0);
  scintillation_5 = tmpvar_30;
  lowp float tmpvar_31;
  tmpvar_31 = texture2D (_NoiseTex, xlv_TEXCOORD1.zw).w;
  starsNoise_4 = tmpvar_31;
  mediump float value_32;
  value_32 = starsNoise_4;
  mediump float tmpvar_33;
  tmpvar_33 = clamp (((value_32 - _ES_StarsDensity) / (1.0 - _ES_StarsDensity)), 0.0, 1.0);
  starsDensity_3 = tmpvar_33;
  highp vec2 tmpvar_34;
  tmpvar_34.y = 0.5;
  tmpvar_34.x = ((starsNoise_4 * _StarsColorPalette_ST.x) + _StarsColorPalette_ST.z);
  lowp vec3 tmpvar_35;
  tmpvar_35 = texture2D (_StarsColorPalette, tmpvar_34).xyz;
  starsColor_2 = tmpvar_35;
  col_7 = (col_7 + ((
    (starsColor_2 * _ES_StarsBrightness)
   * 
    (((stars_6 * scintillation_5) * clamp ((xlv_TEXCOORD3.w * 1.5), 0.0, 1.0)) * starsDensity_3)
  ) * float(
    (0.05 >= moonGradient_18)
  )));
  highp vec4 tmpvar_36;
  tmpvar_36.w = 1.0;
  tmpvar_36.xyz = col_7;
  tmpvar_1 = tmpvar_36;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform highp float _ES_StarsScintillation;
uniform sampler2D _SkyGradientTex;
uniform highp vec4 _StarsTex_ST;
uniform highp vec4 _NoiseTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
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
  mediump vec3 viewDir_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(((unity_ObjectToWorld * tmpvar_13).xyz - _ES_SkyCenterWorldPos));
  viewDir_12 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (_ES_SkyWorldUpDir, viewDir_12);
  mediump vec4 tmpvar_16;
  tmpvar_16.xyz = viewDir_12;
  tmpvar_16.w = ((sign(tmpvar_15) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_15))) * (1.570796 + (abs(tmpvar_15) * (-0.2146018 + 
      (abs(tmpvar_15) * (0.08656672 + (abs(tmpvar_15) * -0.03102955)))
    ))))
  )) * 0.6366198);
  tmpvar_4 = tmpvar_16;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _StarsTex_ST.xy) + _StarsTex_ST.zw);
  tmpvar_2.zw = (_glesMultiTexCoord0.xy * 20.0);
  highp vec2 tmpvar_17;
  tmpvar_17 = (_glesMultiTexCoord0.xy * _NoiseTex_ST.xy);
  highp vec2 tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = (_Time.y * _ES_StarsScintillation);
  tmpvar_18.x = (tmpvar_19 * 0.4);
  tmpvar_18.y = (tmpvar_19 * 0.2);
  tmpvar_3.xy = (tmpvar_17 + tmpvar_18);
  highp vec2 tmpvar_20;
  tmpvar_20.x = (tmpvar_19 * 0.1);
  tmpvar_20.y = (tmpvar_19 * 0.5);
  tmpvar_3.zw = ((tmpvar_17 * 2.0) + tmpvar_20);
  mediump vec3 viewDir_21;
  viewDir_21 = tmpvar_4.xyz;
  mediump float verticalBlend_22;
  verticalBlend_22 = tmpvar_4.w;
  mediump vec3 atomosphere_23;
  mediump float tmpvar_24;
  tmpvar_24 = dot (_ES_SunDirection, viewDir_21);
  mediump float tmpvar_25;
  tmpvar_25 = max (((tmpvar_24 * _ES_SkyFrontAndBackBlendFactor) + (1.0 - _ES_SkyFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_26;
  tmpvar_26 = ((tmpvar_25 * tmpvar_25) * tmpvar_25);
  mediump vec4 tmpvar_27;
  tmpvar_27.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_27.x = (abs(verticalBlend_22) / max (_ES_BottomColorHeight, 0.0001));
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2DLod (_SkyGradientTex, tmpvar_27.xy, 0.0);
  mediump float tmpvar_29;
  tmpvar_29 = tmpvar_28.x;
  atomosphere_23 = mix (mix (_ES_TopBackColor, _ES_TopFrontColor, vec4(tmpvar_26)).xyz, mix (_ES_BottomBackColor, _ES_BottomFrontColor, vec4(tmpvar_26)).xyz, vec3(tmpvar_29));
  mediump vec4 tmpvar_30;
  tmpvar_30.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_30.x = (abs(verticalBlend_22) / max (_ES_HorizonHaloHeight, 0.0001));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DLod (_SkyGradientTex, tmpvar_30.xy, 0.0);
  mediump float tmpvar_32;
  tmpvar_32 = tmpvar_31.y;
  mediump float tmpvar_33;
  tmpvar_33 = clamp (((
    max (((tmpvar_24 * 0.5) + 0.5), 0.0)
   - 0.3) / 0.7), 0.0, 1.0);
  mediump float tmpvar_34;
  tmpvar_34 = clamp (((
    abs(_ES_SunDirection.y)
   - 0.2) / 0.3), 0.0, 1.0);
  atomosphere_23 = (atomosphere_23 + ((
    (_ES_HorizonHaloColor * _ES_HorizonHaloIntensity)
   * tmpvar_32) * mix (
    (tmpvar_33 * (tmpvar_33 * (3.0 - (2.0 * tmpvar_33))))
  , 1.0, 
    (tmpvar_34 * (tmpvar_34 * (3.0 - (2.0 * tmpvar_34))))
  )));
  mediump vec4 tmpvar_35;
  tmpvar_35.xyz = atomosphere_23;
  tmpvar_35.w = tmpvar_26;
  tmpvar_5 = tmpvar_35;
  gl_Position = clipPos_6;
  xlv_TEXCOORD0 = o_9;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec3 _ES_SunDirection;
uniform mediump float _ES_SunHaloSize;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump float _ES_MoonSize;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform mediump float _ES_StarsBrightness;
uniform mediump float _ES_StarsDensity;
uniform sampler2D _StarsTex;
uniform sampler2D _StarsColorPalette;
uniform highp vec4 _StarsColorPalette_ST;
uniform sampler2D _NoiseTex;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 starsColor_2;
  highp float starsDensity_3;
  highp float starsNoise_4;
  highp float scintillation_5;
  highp float stars_6;
  highp vec3 col_7;
  highp vec4 tmpvar_8;
  tmpvar_8.xyz = normalize(xlv_TEXCOORD3.xyz);
  tmpvar_8.w = xlv_TEXCOORD3.w;
  highp float haloInfluence_9;
  mediump float vertical_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp (((
    dot (_ES_SunDirection, tmpvar_8.xyz)
   * 0.5) + 0.5), 0.0, 1.0);
  highp float tmpvar_12;
  tmpvar_12 = dot (tmpvar_8.xyz, _ES_SkyWorldUpDir);
  vertical_10 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = abs(vertical_10);
  mediump float y_14;
  y_14 = (_ES_SunHaloSize * tmpvar_13);
  mediump float y_15;
  y_15 = ((_ES_SunHaloSize * 0.1) * tmpvar_13);
  haloInfluence_9 = (clamp (pow (tmpvar_11, y_14), 0.0, 1.0) + (clamp (
    pow (tmpvar_11, y_15)
  , 0.0, 1.0) * 0.12));
  mediump float y_16;
  y_16 = ((_ES_SunHaloSize * 0.01) * tmpvar_13);
  haloInfluence_9 = (haloInfluence_9 + (clamp (
    pow (tmpvar_11, y_16)
  , 0.0, 1.0) * 0.03));
  highp float tmpvar_17;
  tmpvar_17 = clamp (((
    max (((dot (_ES_SunDirection, tmpvar_8.xyz) * 0.5) + 0.5), 0.0)
   - 0.5) / 0.5), 0.0, 1.0);
  col_7 = (xlv_TEXCOORD4.xyz + ((
    (haloInfluence_9 * _ES_SunHaloIntensity)
   * _ES_SunHaloColor) * (tmpvar_17 * 
    (tmpvar_17 * (3.0 - (2.0 * tmpvar_17)))
  )));
  highp float moonGradient_18;
  highp float tmpvar_19;
  tmpvar_19 = clamp (dot (_ES_MoonDirection, tmpvar_8.xyz), 0.0, 1.0);
  highp float tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = clamp (_ES_MoonBrightness, 0.0, 1.0);
  tmpvar_20 = tmpvar_21;
  highp float tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_22 = (1.0 - (tmpvar_23 * 2.0));
  mediump float a_24;
  a_24 = tmpvar_19;
  mediump float x_25;
  x_25 = (a_24 - 1.0);
  mediump float tmpvar_26;
  tmpvar_26 = clamp ((1.0 - (
    sqrt((x_25 * x_25))
   * 
    (1.0/(max ((_ES_MoonSize * 0.1), 1e-05)))
  )), 0.0, 1.0);
  moonGradient_18 = tmpvar_26;
  mediump float tmpvar_27;
  mediump float x_28;
  x_28 = moonGradient_18;
  tmpvar_27 = (((x_28 * x_28) * (x_28 * x_28)) * (x_28 * x_28));
  moonGradient_18 = tmpvar_27;
  moonGradient_18 = (moonGradient_18 * (_ES_MoonGlowIntensity * tmpvar_22));
  col_7 = (col_7 + ((moonGradient_18 * _ES_MoonColor) * tmpvar_20));
  lowp float tmpvar_29;
  tmpvar_29 = texture2D (_StarsTex, xlv_TEXCOORD1.xy).w;
  stars_6 = tmpvar_29;
  lowp float tmpvar_30;
  tmpvar_30 = ((texture2D (_NoiseTex, xlv_TEXCOORD2.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD2.zw).w) * 3.0);
  scintillation_5 = tmpvar_30;
  lowp float tmpvar_31;
  tmpvar_31 = texture2D (_NoiseTex, xlv_TEXCOORD1.zw).w;
  starsNoise_4 = tmpvar_31;
  mediump float value_32;
  value_32 = starsNoise_4;
  mediump float tmpvar_33;
  tmpvar_33 = clamp (((value_32 - _ES_StarsDensity) / (1.0 - _ES_StarsDensity)), 0.0, 1.0);
  starsDensity_3 = tmpvar_33;
  highp vec2 tmpvar_34;
  tmpvar_34.y = 0.5;
  tmpvar_34.x = ((starsNoise_4 * _StarsColorPalette_ST.x) + _StarsColorPalette_ST.z);
  lowp vec3 tmpvar_35;
  tmpvar_35 = texture2D (_StarsColorPalette, tmpvar_34).xyz;
  starsColor_2 = tmpvar_35;
  col_7 = (col_7 + ((
    (starsColor_2 * _ES_StarsBrightness)
   * 
    (((stars_6 * scintillation_5) * clamp ((xlv_TEXCOORD3.w * 1.5), 0.0, 1.0)) * starsDensity_3)
  ) * float(
    (0.05 >= moonGradient_18)
  )));
  highp vec4 tmpvar_36;
  tmpvar_36.w = 1.0;
  tmpvar_36.xyz = col_7;
  tmpvar_1 = tmpvar_36;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform highp float _ES_StarsScintillation;
uniform sampler2D _SkyGradientTex;
uniform highp vec4 _StarsTex_ST;
uniform highp vec4 _NoiseTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
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
  mediump vec3 viewDir_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(((unity_ObjectToWorld * tmpvar_13).xyz - _ES_SkyCenterWorldPos));
  viewDir_12 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (_ES_SkyWorldUpDir, viewDir_12);
  mediump vec4 tmpvar_16;
  tmpvar_16.xyz = viewDir_12;
  tmpvar_16.w = ((sign(tmpvar_15) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_15))) * (1.570796 + (abs(tmpvar_15) * (-0.2146018 + 
      (abs(tmpvar_15) * (0.08656672 + (abs(tmpvar_15) * -0.03102955)))
    ))))
  )) * 0.6366198);
  tmpvar_4 = tmpvar_16;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _StarsTex_ST.xy) + _StarsTex_ST.zw);
  tmpvar_2.zw = (_glesMultiTexCoord0.xy * 20.0);
  highp vec2 tmpvar_17;
  tmpvar_17 = (_glesMultiTexCoord0.xy * _NoiseTex_ST.xy);
  highp vec2 tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = (_Time.y * _ES_StarsScintillation);
  tmpvar_18.x = (tmpvar_19 * 0.4);
  tmpvar_18.y = (tmpvar_19 * 0.2);
  tmpvar_3.xy = (tmpvar_17 + tmpvar_18);
  highp vec2 tmpvar_20;
  tmpvar_20.x = (tmpvar_19 * 0.1);
  tmpvar_20.y = (tmpvar_19 * 0.5);
  tmpvar_3.zw = ((tmpvar_17 * 2.0) + tmpvar_20);
  mediump vec3 viewDir_21;
  viewDir_21 = tmpvar_4.xyz;
  mediump float verticalBlend_22;
  verticalBlend_22 = tmpvar_4.w;
  mediump vec3 atomosphere_23;
  mediump float tmpvar_24;
  tmpvar_24 = dot (_ES_SunDirection, viewDir_21);
  mediump float tmpvar_25;
  tmpvar_25 = max (((tmpvar_24 * _ES_SkyFrontAndBackBlendFactor) + (1.0 - _ES_SkyFrontAndBackBlendFactor)), 0.0);
  mediump float tmpvar_26;
  tmpvar_26 = ((tmpvar_25 * tmpvar_25) * tmpvar_25);
  mediump vec4 tmpvar_27;
  tmpvar_27.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_27.x = (abs(verticalBlend_22) / max (_ES_BottomColorHeight, 0.0001));
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2DLod (_SkyGradientTex, tmpvar_27.xy, 0.0);
  mediump float tmpvar_29;
  tmpvar_29 = tmpvar_28.x;
  atomosphere_23 = mix (mix (_ES_TopBackColor, _ES_TopFrontColor, vec4(tmpvar_26)).xyz, mix (_ES_BottomBackColor, _ES_BottomFrontColor, vec4(tmpvar_26)).xyz, vec3(tmpvar_29));
  mediump vec4 tmpvar_30;
  tmpvar_30.yzw = vec3(0.5, 0.0, 0.0);
  tmpvar_30.x = (abs(verticalBlend_22) / max (_ES_HorizonHaloHeight, 0.0001));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DLod (_SkyGradientTex, tmpvar_30.xy, 0.0);
  mediump float tmpvar_32;
  tmpvar_32 = tmpvar_31.y;
  mediump float tmpvar_33;
  tmpvar_33 = clamp (((
    max (((tmpvar_24 * 0.5) + 0.5), 0.0)
   - 0.3) / 0.7), 0.0, 1.0);
  mediump float tmpvar_34;
  tmpvar_34 = clamp (((
    abs(_ES_SunDirection.y)
   - 0.2) / 0.3), 0.0, 1.0);
  atomosphere_23 = (atomosphere_23 + ((
    (_ES_HorizonHaloColor * _ES_HorizonHaloIntensity)
   * tmpvar_32) * mix (
    (tmpvar_33 * (tmpvar_33 * (3.0 - (2.0 * tmpvar_33))))
  , 1.0, 
    (tmpvar_34 * (tmpvar_34 * (3.0 - (2.0 * tmpvar_34))))
  )));
  mediump vec4 tmpvar_35;
  tmpvar_35.xyz = atomosphere_23;
  tmpvar_35.w = tmpvar_26;
  tmpvar_5 = tmpvar_35;
  gl_Position = clipPos_6;
  xlv_TEXCOORD0 = o_9;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump vec3 _ES_SunDirection;
uniform mediump float _ES_SunHaloSize;
uniform mediump vec3 _ES_SunHaloColor;
uniform mediump float _ES_SunHaloIntensity;
uniform mediump vec3 _ES_MoonDirection;
uniform mediump float _ES_MoonSize;
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform mediump float _ES_MoonGlowIntensity;
uniform mediump float _ES_MoonLunarPhase;
uniform mediump float _ES_StarsBrightness;
uniform mediump float _ES_StarsDensity;
uniform sampler2D _StarsTex;
uniform sampler2D _StarsColorPalette;
uniform highp vec4 _StarsColorPalette_ST;
uniform sampler2D _NoiseTex;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 starsColor_2;
  highp float starsDensity_3;
  highp float starsNoise_4;
  highp float scintillation_5;
  highp float stars_6;
  highp vec3 col_7;
  highp vec4 tmpvar_8;
  tmpvar_8.xyz = normalize(xlv_TEXCOORD3.xyz);
  tmpvar_8.w = xlv_TEXCOORD3.w;
  highp float haloInfluence_9;
  mediump float vertical_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp (((
    dot (_ES_SunDirection, tmpvar_8.xyz)
   * 0.5) + 0.5), 0.0, 1.0);
  highp float tmpvar_12;
  tmpvar_12 = dot (tmpvar_8.xyz, _ES_SkyWorldUpDir);
  vertical_10 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = abs(vertical_10);
  mediump float y_14;
  y_14 = (_ES_SunHaloSize * tmpvar_13);
  mediump float y_15;
  y_15 = ((_ES_SunHaloSize * 0.1) * tmpvar_13);
  haloInfluence_9 = (clamp (pow (tmpvar_11, y_14), 0.0, 1.0) + (clamp (
    pow (tmpvar_11, y_15)
  , 0.0, 1.0) * 0.12));
  mediump float y_16;
  y_16 = ((_ES_SunHaloSize * 0.01) * tmpvar_13);
  haloInfluence_9 = (haloInfluence_9 + (clamp (
    pow (tmpvar_11, y_16)
  , 0.0, 1.0) * 0.03));
  highp float tmpvar_17;
  tmpvar_17 = clamp (((
    max (((dot (_ES_SunDirection, tmpvar_8.xyz) * 0.5) + 0.5), 0.0)
   - 0.5) / 0.5), 0.0, 1.0);
  col_7 = (xlv_TEXCOORD4.xyz + ((
    (haloInfluence_9 * _ES_SunHaloIntensity)
   * _ES_SunHaloColor) * (tmpvar_17 * 
    (tmpvar_17 * (3.0 - (2.0 * tmpvar_17)))
  )));
  highp float moonGradient_18;
  highp float tmpvar_19;
  tmpvar_19 = clamp (dot (_ES_MoonDirection, tmpvar_8.xyz), 0.0, 1.0);
  highp float tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = clamp (_ES_MoonBrightness, 0.0, 1.0);
  tmpvar_20 = tmpvar_21;
  highp float tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = abs((_ES_MoonLunarPhase - 0.5));
  tmpvar_22 = (1.0 - (tmpvar_23 * 2.0));
  mediump float a_24;
  a_24 = tmpvar_19;
  mediump float x_25;
  x_25 = (a_24 - 1.0);
  mediump float tmpvar_26;
  tmpvar_26 = clamp ((1.0 - (
    sqrt((x_25 * x_25))
   * 
    (1.0/(max ((_ES_MoonSize * 0.1), 1e-05)))
  )), 0.0, 1.0);
  moonGradient_18 = tmpvar_26;
  mediump float tmpvar_27;
  mediump float x_28;
  x_28 = moonGradient_18;
  tmpvar_27 = (((x_28 * x_28) * (x_28 * x_28)) * (x_28 * x_28));
  moonGradient_18 = tmpvar_27;
  moonGradient_18 = (moonGradient_18 * (_ES_MoonGlowIntensity * tmpvar_22));
  col_7 = (col_7 + ((moonGradient_18 * _ES_MoonColor) * tmpvar_20));
  lowp float tmpvar_29;
  tmpvar_29 = texture2D (_StarsTex, xlv_TEXCOORD1.xy).w;
  stars_6 = tmpvar_29;
  lowp float tmpvar_30;
  tmpvar_30 = ((texture2D (_NoiseTex, xlv_TEXCOORD2.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD2.zw).w) * 3.0);
  scintillation_5 = tmpvar_30;
  lowp float tmpvar_31;
  tmpvar_31 = texture2D (_NoiseTex, xlv_TEXCOORD1.zw).w;
  starsNoise_4 = tmpvar_31;
  mediump float value_32;
  value_32 = starsNoise_4;
  mediump float tmpvar_33;
  tmpvar_33 = clamp (((value_32 - _ES_StarsDensity) / (1.0 - _ES_StarsDensity)), 0.0, 1.0);
  starsDensity_3 = tmpvar_33;
  highp vec2 tmpvar_34;
  tmpvar_34.y = 0.5;
  tmpvar_34.x = ((starsNoise_4 * _StarsColorPalette_ST.x) + _StarsColorPalette_ST.z);
  lowp vec3 tmpvar_35;
  tmpvar_35 = texture2D (_StarsColorPalette, tmpvar_34).xyz;
  starsColor_2 = tmpvar_35;
  col_7 = (col_7 + ((
    (starsColor_2 * _ES_StarsBrightness)
   * 
    (((stars_6 * scintillation_5) * clamp ((xlv_TEXCOORD3.w * 1.5), 0.0, 1.0)) * starsDensity_3)
  ) * float(
    (0.05 >= moonGradient_18)
  )));
  highp vec4 tmpvar_36;
  tmpvar_36.w = 1.0;
  tmpvar_36.xyz = col_7;
  tmpvar_1 = tmpvar_36;
  gl_FragData[0] = tmpvar_1;
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
}