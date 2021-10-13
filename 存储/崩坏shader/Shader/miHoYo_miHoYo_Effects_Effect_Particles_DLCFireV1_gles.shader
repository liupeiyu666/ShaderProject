//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Particles/DLCFireV1" {
Properties {
_ColorInner ("ColorInner", Color) = (1,0.753779,0.2132353,0)
_InnerColorIntensity ("InnerColorIntensity", Float) = 1
_ColorOutter ("ColorOutter", Color) = (0.8970588,0.2483743,0.07915227,0)
_OutColorIntensity ("OutColorIntensity", Float) = 1
_ShapeTexture ("ShapeTexture", 2D) = "white" { }
_ShapeBlueBrightness ("ShapeBlueBrightness", Float) = 0.8
_VcoordMultiplier ("VcoordMultiplier", Float) = 1
_NoiseTex01 ("NoiseTex01", 2D) = "white" { }
_Noise1_USpeed ("Noise1_USpeed", Float) = 0
_Noise1_VSpeed ("Noise1_VSpeed", Float) = -0.9
_NoiseTex01Brightness ("NoiseTex01Brightness", Range(0, 3)) = 1.22
_NoiseTex01BrightnessAdd ("NoiseTex01BrightnessAdd", Range(0, 2)) = 0
[Toggle(_NOISEASVCOORD_ON)] _NoiseAsVcoord ("NoiseAsVcoord", Float) = 1
_OpacityIntensity ("OpacityIntensity", Float) = 1
_TimeScale ("TimeScale", Float) = 1
_GrassFireBurnOut ("GrassFireBurnOut", Float) = 0
[Toggle(_NOISE01_RANDOMTOGGLE_ON)] _Noise01_RandomToggle ("Noise01_RandomToggle", Float) = 0
[KeywordEnum(R,G,B,A)] _Noise01ChannelToggle ("Noise01ChannelToggle", Float) = 0
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 53649
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _ShapeTexture;
uniform highp float _VcoordMultiplier;
uniform highp float _ShapeBlueBrightness;
uniform sampler2D _NoiseTex01;
uniform highp float _Noise1_USpeed;
uniform highp float _TimeScale;
uniform highp float _Noise1_VSpeed;
uniform highp float _NoiseTex01Brightness;
uniform highp float _NoiseTex01BrightnessAdd;
uniform highp float _OpacityIntensity;
uniform highp float _GrassFireBurnOut;
uniform highp vec4 _ColorOutter;
uniform highp float _OutColorIntensity;
uniform highp vec4 _ColorInner;
uniform highp float _InnerColorIntensity;
uniform mediump float _Noise01ChannelToggle;
uniform mediump float _Noise01_RandomToggle;
uniform mediump float _NoiseAsVcoord;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 tex2DNode165_3;
  highp float staticSwitch148_4;
  highp float staticSwitch216_5;
  highp vec4 tex2DNode205_6;
  highp vec2 staticSwitch214_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = xlv_TEXCOORD0.xy;
  highp vec2 tmpvar_9;
  tmpvar_9.x = ((_Time.y * (_Noise1_USpeed * _TimeScale)) + xlv_TEXCOORD0.x);
  tmpvar_9.y = (xlv_TEXCOORD0.y + (_Time.y * (_TimeScale * _Noise1_VSpeed)));
  if ((_Noise01_RandomToggle > 0.0)) {
    staticSwitch214_7 = (tmpvar_9 + xlv_TEXCOORD0.zw);
  } else {
    staticSwitch214_7 = tmpvar_9;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_NoiseTex01, staticSwitch214_7);
  tex2DNode205_6 = tmpvar_10;
  if ((_Noise01ChannelToggle == 0.0)) {
    staticSwitch216_5 = tex2DNode205_6.x;
  } else {
    if ((_Noise01ChannelToggle == 1.0)) {
      staticSwitch216_5 = tex2DNode205_6.y;
    } else {
      if ((_Noise01ChannelToggle == 2.0)) {
        staticSwitch216_5 = tex2DNode205_6.z;
      } else {
        if ((_Noise01ChannelToggle == 3.0)) {
          staticSwitch216_5 = tex2DNode205_6.w;
        } else {
          staticSwitch216_5 = tex2DNode205_6.x;
        };
      };
    };
  };
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_ShapeTexture, xlv_TEXCOORD0.xy);
  highp float tmpvar_12;
  tmpvar_12 = ((tmpvar_11.z * _ShapeBlueBrightness) * ((staticSwitch216_5 * _NoiseTex01Brightness) - _NoiseTex01BrightnessAdd));
  if ((_NoiseAsVcoord > 0.0)) {
    staticSwitch148_4 = tmpvar_12;
  } else {
    staticSwitch148_4 = ((xlv_TEXCOORD0.y * _VcoordMultiplier) - tmpvar_12);
  };
  highp vec4 tmpvar_13;
  tmpvar_13.zw = vec2(0.0, 0.0);
  tmpvar_13.x = tmpvar_8.x;
  tmpvar_13.y = staticSwitch148_4;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ShapeTexture, tmpvar_13.xy);
  tex2DNode165_3 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = clamp ((xlv_COLOR.x * (
    clamp ((tex2DNode165_3.y * (staticSwitch148_4 * _OpacityIntensity)), 0.0, 1.0)
   - 
    ((1.0 - xlv_COLOR.w) + _GrassFireBurnOut)
  )), 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (mix ((_ColorOutter * _OutColorIntensity), (_ColorInner * _InnerColorIntensity), vec4(clamp (
    (tex2DNode165_3.x + (tex2DNode165_3.w * tex2DNode165_3.w))
  , 0.0, 1.0))) * xlv_COLOR.y).xyz;
  aseOutColor_1 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = aseOutColor_1;
  tmpvar_18.w = tmpvar_17;
  gl_FragData[0] = tmpvar_18;
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
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _ShapeTexture;
uniform highp float _VcoordMultiplier;
uniform highp float _ShapeBlueBrightness;
uniform sampler2D _NoiseTex01;
uniform highp float _Noise1_USpeed;
uniform highp float _TimeScale;
uniform highp float _Noise1_VSpeed;
uniform highp float _NoiseTex01Brightness;
uniform highp float _NoiseTex01BrightnessAdd;
uniform highp float _OpacityIntensity;
uniform highp float _GrassFireBurnOut;
uniform highp vec4 _ColorOutter;
uniform highp float _OutColorIntensity;
uniform highp vec4 _ColorInner;
uniform highp float _InnerColorIntensity;
uniform mediump float _Noise01ChannelToggle;
uniform mediump float _Noise01_RandomToggle;
uniform mediump float _NoiseAsVcoord;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 tex2DNode165_3;
  highp float staticSwitch148_4;
  highp float staticSwitch216_5;
  highp vec4 tex2DNode205_6;
  highp vec2 staticSwitch214_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = xlv_TEXCOORD0.xy;
  highp vec2 tmpvar_9;
  tmpvar_9.x = ((_Time.y * (_Noise1_USpeed * _TimeScale)) + xlv_TEXCOORD0.x);
  tmpvar_9.y = (xlv_TEXCOORD0.y + (_Time.y * (_TimeScale * _Noise1_VSpeed)));
  if ((_Noise01_RandomToggle > 0.0)) {
    staticSwitch214_7 = (tmpvar_9 + xlv_TEXCOORD0.zw);
  } else {
    staticSwitch214_7 = tmpvar_9;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_NoiseTex01, staticSwitch214_7);
  tex2DNode205_6 = tmpvar_10;
  if ((_Noise01ChannelToggle == 0.0)) {
    staticSwitch216_5 = tex2DNode205_6.x;
  } else {
    if ((_Noise01ChannelToggle == 1.0)) {
      staticSwitch216_5 = tex2DNode205_6.y;
    } else {
      if ((_Noise01ChannelToggle == 2.0)) {
        staticSwitch216_5 = tex2DNode205_6.z;
      } else {
        if ((_Noise01ChannelToggle == 3.0)) {
          staticSwitch216_5 = tex2DNode205_6.w;
        } else {
          staticSwitch216_5 = tex2DNode205_6.x;
        };
      };
    };
  };
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_ShapeTexture, xlv_TEXCOORD0.xy);
  highp float tmpvar_12;
  tmpvar_12 = ((tmpvar_11.z * _ShapeBlueBrightness) * ((staticSwitch216_5 * _NoiseTex01Brightness) - _NoiseTex01BrightnessAdd));
  if ((_NoiseAsVcoord > 0.0)) {
    staticSwitch148_4 = tmpvar_12;
  } else {
    staticSwitch148_4 = ((xlv_TEXCOORD0.y * _VcoordMultiplier) - tmpvar_12);
  };
  highp vec4 tmpvar_13;
  tmpvar_13.zw = vec2(0.0, 0.0);
  tmpvar_13.x = tmpvar_8.x;
  tmpvar_13.y = staticSwitch148_4;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ShapeTexture, tmpvar_13.xy);
  tex2DNode165_3 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = clamp ((xlv_COLOR.x * (
    clamp ((tex2DNode165_3.y * (staticSwitch148_4 * _OpacityIntensity)), 0.0, 1.0)
   - 
    ((1.0 - xlv_COLOR.w) + _GrassFireBurnOut)
  )), 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (mix ((_ColorOutter * _OutColorIntensity), (_ColorInner * _InnerColorIntensity), vec4(clamp (
    (tex2DNode165_3.x + (tex2DNode165_3.w * tex2DNode165_3.w))
  , 0.0, 1.0))) * xlv_COLOR.y).xyz;
  aseOutColor_1 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = aseOutColor_1;
  tmpvar_18.w = tmpvar_17;
  gl_FragData[0] = tmpvar_18;
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
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _ShapeTexture;
uniform highp float _VcoordMultiplier;
uniform highp float _ShapeBlueBrightness;
uniform sampler2D _NoiseTex01;
uniform highp float _Noise1_USpeed;
uniform highp float _TimeScale;
uniform highp float _Noise1_VSpeed;
uniform highp float _NoiseTex01Brightness;
uniform highp float _NoiseTex01BrightnessAdd;
uniform highp float _OpacityIntensity;
uniform highp float _GrassFireBurnOut;
uniform highp vec4 _ColorOutter;
uniform highp float _OutColorIntensity;
uniform highp vec4 _ColorInner;
uniform highp float _InnerColorIntensity;
uniform mediump float _Noise01ChannelToggle;
uniform mediump float _Noise01_RandomToggle;
uniform mediump float _NoiseAsVcoord;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 tex2DNode165_3;
  highp float staticSwitch148_4;
  highp float staticSwitch216_5;
  highp vec4 tex2DNode205_6;
  highp vec2 staticSwitch214_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = xlv_TEXCOORD0.xy;
  highp vec2 tmpvar_9;
  tmpvar_9.x = ((_Time.y * (_Noise1_USpeed * _TimeScale)) + xlv_TEXCOORD0.x);
  tmpvar_9.y = (xlv_TEXCOORD0.y + (_Time.y * (_TimeScale * _Noise1_VSpeed)));
  if ((_Noise01_RandomToggle > 0.0)) {
    staticSwitch214_7 = (tmpvar_9 + xlv_TEXCOORD0.zw);
  } else {
    staticSwitch214_7 = tmpvar_9;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_NoiseTex01, staticSwitch214_7);
  tex2DNode205_6 = tmpvar_10;
  if ((_Noise01ChannelToggle == 0.0)) {
    staticSwitch216_5 = tex2DNode205_6.x;
  } else {
    if ((_Noise01ChannelToggle == 1.0)) {
      staticSwitch216_5 = tex2DNode205_6.y;
    } else {
      if ((_Noise01ChannelToggle == 2.0)) {
        staticSwitch216_5 = tex2DNode205_6.z;
      } else {
        if ((_Noise01ChannelToggle == 3.0)) {
          staticSwitch216_5 = tex2DNode205_6.w;
        } else {
          staticSwitch216_5 = tex2DNode205_6.x;
        };
      };
    };
  };
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_ShapeTexture, xlv_TEXCOORD0.xy);
  highp float tmpvar_12;
  tmpvar_12 = ((tmpvar_11.z * _ShapeBlueBrightness) * ((staticSwitch216_5 * _NoiseTex01Brightness) - _NoiseTex01BrightnessAdd));
  if ((_NoiseAsVcoord > 0.0)) {
    staticSwitch148_4 = tmpvar_12;
  } else {
    staticSwitch148_4 = ((xlv_TEXCOORD0.y * _VcoordMultiplier) - tmpvar_12);
  };
  highp vec4 tmpvar_13;
  tmpvar_13.zw = vec2(0.0, 0.0);
  tmpvar_13.x = tmpvar_8.x;
  tmpvar_13.y = staticSwitch148_4;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ShapeTexture, tmpvar_13.xy);
  tex2DNode165_3 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = clamp ((xlv_COLOR.x * (
    clamp ((tex2DNode165_3.y * (staticSwitch148_4 * _OpacityIntensity)), 0.0, 1.0)
   - 
    ((1.0 - xlv_COLOR.w) + _GrassFireBurnOut)
  )), 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (mix ((_ColorOutter * _OutColorIntensity), (_ColorInner * _InnerColorIntensity), vec4(clamp (
    (tex2DNode165_3.x + (tex2DNode165_3.w * tex2DNode165_3.w))
  , 0.0, 1.0))) * xlv_COLOR.y).xyz;
  aseOutColor_1 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = aseOutColor_1;
  tmpvar_18.w = tmpvar_17;
  gl_FragData[0] = tmpvar_18;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _ShapeTexture;
uniform highp float _VcoordMultiplier;
uniform highp float _ShapeBlueBrightness;
uniform sampler2D _NoiseTex01;
uniform highp float _Noise1_USpeed;
uniform highp float _TimeScale;
uniform highp float _Noise1_VSpeed;
uniform highp float _NoiseTex01Brightness;
uniform highp float _NoiseTex01BrightnessAdd;
uniform highp float _OpacityIntensity;
uniform highp float _GrassFireBurnOut;
uniform highp vec4 _ColorOutter;
uniform highp float _OutColorIntensity;
uniform highp vec4 _ColorInner;
uniform highp float _InnerColorIntensity;
uniform mediump float _LumiFactor;
uniform mediump float _Noise01ChannelToggle;
uniform mediump float _Noise01_RandomToggle;
uniform mediump float _NoiseAsVcoord;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 tex2DNode165_3;
  highp float staticSwitch148_4;
  highp float staticSwitch216_5;
  highp vec4 tex2DNode205_6;
  highp vec2 staticSwitch214_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = xlv_TEXCOORD0.xy;
  highp vec2 tmpvar_9;
  tmpvar_9.x = ((_Time.y * (_Noise1_USpeed * _TimeScale)) + xlv_TEXCOORD0.x);
  tmpvar_9.y = (xlv_TEXCOORD0.y + (_Time.y * (_TimeScale * _Noise1_VSpeed)));
  if ((_Noise01_RandomToggle > 0.0)) {
    staticSwitch214_7 = (tmpvar_9 + xlv_TEXCOORD0.zw);
  } else {
    staticSwitch214_7 = tmpvar_9;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_NoiseTex01, staticSwitch214_7);
  tex2DNode205_6 = tmpvar_10;
  if ((_Noise01ChannelToggle == 0.0)) {
    staticSwitch216_5 = tex2DNode205_6.x;
  } else {
    if ((_Noise01ChannelToggle == 1.0)) {
      staticSwitch216_5 = tex2DNode205_6.y;
    } else {
      if ((_Noise01ChannelToggle == 2.0)) {
        staticSwitch216_5 = tex2DNode205_6.z;
      } else {
        if ((_Noise01ChannelToggle == 3.0)) {
          staticSwitch216_5 = tex2DNode205_6.w;
        } else {
          staticSwitch216_5 = tex2DNode205_6.x;
        };
      };
    };
  };
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_ShapeTexture, xlv_TEXCOORD0.xy);
  highp float tmpvar_12;
  tmpvar_12 = ((tmpvar_11.z * _ShapeBlueBrightness) * ((staticSwitch216_5 * _NoiseTex01Brightness) - _NoiseTex01BrightnessAdd));
  if ((_NoiseAsVcoord > 0.0)) {
    staticSwitch148_4 = tmpvar_12;
  } else {
    staticSwitch148_4 = ((xlv_TEXCOORD0.y * _VcoordMultiplier) - tmpvar_12);
  };
  highp vec4 tmpvar_13;
  tmpvar_13.zw = vec2(0.0, 0.0);
  tmpvar_13.x = tmpvar_8.x;
  tmpvar_13.y = staticSwitch148_4;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ShapeTexture, tmpvar_13.xy);
  tex2DNode165_3 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = clamp ((xlv_COLOR.x * (
    clamp ((tex2DNode165_3.y * (staticSwitch148_4 * _OpacityIntensity)), 0.0, 1.0)
   - 
    ((1.0 - xlv_COLOR.w) + _GrassFireBurnOut)
  )), 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (mix ((_ColorOutter * _OutColorIntensity), (_ColorInner * _InnerColorIntensity), vec4(clamp (
    (tex2DNode165_3.x + (tex2DNode165_3.w * tex2DNode165_3.w))
  , 0.0, 1.0))) * xlv_COLOR.y).xyz;
  aseOutColor_1 = tmpvar_16;
  aseOutColor_1 = mix (aseOutColor_1, vec3(dot (aseOutColor_1, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  mediump float tmpvar_17;
  tmpvar_17 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = aseOutColor_1;
  tmpvar_18.w = tmpvar_17;
  gl_FragData[0] = tmpvar_18;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _ShapeTexture;
uniform highp float _VcoordMultiplier;
uniform highp float _ShapeBlueBrightness;
uniform sampler2D _NoiseTex01;
uniform highp float _Noise1_USpeed;
uniform highp float _TimeScale;
uniform highp float _Noise1_VSpeed;
uniform highp float _NoiseTex01Brightness;
uniform highp float _NoiseTex01BrightnessAdd;
uniform highp float _OpacityIntensity;
uniform highp float _GrassFireBurnOut;
uniform highp vec4 _ColorOutter;
uniform highp float _OutColorIntensity;
uniform highp vec4 _ColorInner;
uniform highp float _InnerColorIntensity;
uniform mediump float _LumiFactor;
uniform mediump float _Noise01ChannelToggle;
uniform mediump float _Noise01_RandomToggle;
uniform mediump float _NoiseAsVcoord;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 tex2DNode165_3;
  highp float staticSwitch148_4;
  highp float staticSwitch216_5;
  highp vec4 tex2DNode205_6;
  highp vec2 staticSwitch214_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = xlv_TEXCOORD0.xy;
  highp vec2 tmpvar_9;
  tmpvar_9.x = ((_Time.y * (_Noise1_USpeed * _TimeScale)) + xlv_TEXCOORD0.x);
  tmpvar_9.y = (xlv_TEXCOORD0.y + (_Time.y * (_TimeScale * _Noise1_VSpeed)));
  if ((_Noise01_RandomToggle > 0.0)) {
    staticSwitch214_7 = (tmpvar_9 + xlv_TEXCOORD0.zw);
  } else {
    staticSwitch214_7 = tmpvar_9;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_NoiseTex01, staticSwitch214_7);
  tex2DNode205_6 = tmpvar_10;
  if ((_Noise01ChannelToggle == 0.0)) {
    staticSwitch216_5 = tex2DNode205_6.x;
  } else {
    if ((_Noise01ChannelToggle == 1.0)) {
      staticSwitch216_5 = tex2DNode205_6.y;
    } else {
      if ((_Noise01ChannelToggle == 2.0)) {
        staticSwitch216_5 = tex2DNode205_6.z;
      } else {
        if ((_Noise01ChannelToggle == 3.0)) {
          staticSwitch216_5 = tex2DNode205_6.w;
        } else {
          staticSwitch216_5 = tex2DNode205_6.x;
        };
      };
    };
  };
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_ShapeTexture, xlv_TEXCOORD0.xy);
  highp float tmpvar_12;
  tmpvar_12 = ((tmpvar_11.z * _ShapeBlueBrightness) * ((staticSwitch216_5 * _NoiseTex01Brightness) - _NoiseTex01BrightnessAdd));
  if ((_NoiseAsVcoord > 0.0)) {
    staticSwitch148_4 = tmpvar_12;
  } else {
    staticSwitch148_4 = ((xlv_TEXCOORD0.y * _VcoordMultiplier) - tmpvar_12);
  };
  highp vec4 tmpvar_13;
  tmpvar_13.zw = vec2(0.0, 0.0);
  tmpvar_13.x = tmpvar_8.x;
  tmpvar_13.y = staticSwitch148_4;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ShapeTexture, tmpvar_13.xy);
  tex2DNode165_3 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = clamp ((xlv_COLOR.x * (
    clamp ((tex2DNode165_3.y * (staticSwitch148_4 * _OpacityIntensity)), 0.0, 1.0)
   - 
    ((1.0 - xlv_COLOR.w) + _GrassFireBurnOut)
  )), 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (mix ((_ColorOutter * _OutColorIntensity), (_ColorInner * _InnerColorIntensity), vec4(clamp (
    (tex2DNode165_3.x + (tex2DNode165_3.w * tex2DNode165_3.w))
  , 0.0, 1.0))) * xlv_COLOR.y).xyz;
  aseOutColor_1 = tmpvar_16;
  aseOutColor_1 = mix (aseOutColor_1, vec3(dot (aseOutColor_1, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  mediump float tmpvar_17;
  tmpvar_17 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = aseOutColor_1;
  tmpvar_18.w = tmpvar_17;
  gl_FragData[0] = tmpvar_18;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _ShapeTexture;
uniform highp float _VcoordMultiplier;
uniform highp float _ShapeBlueBrightness;
uniform sampler2D _NoiseTex01;
uniform highp float _Noise1_USpeed;
uniform highp float _TimeScale;
uniform highp float _Noise1_VSpeed;
uniform highp float _NoiseTex01Brightness;
uniform highp float _NoiseTex01BrightnessAdd;
uniform highp float _OpacityIntensity;
uniform highp float _GrassFireBurnOut;
uniform highp vec4 _ColorOutter;
uniform highp float _OutColorIntensity;
uniform highp vec4 _ColorInner;
uniform highp float _InnerColorIntensity;
uniform mediump float _LumiFactor;
uniform mediump float _Noise01ChannelToggle;
uniform mediump float _Noise01_RandomToggle;
uniform mediump float _NoiseAsVcoord;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 tex2DNode165_3;
  highp float staticSwitch148_4;
  highp float staticSwitch216_5;
  highp vec4 tex2DNode205_6;
  highp vec2 staticSwitch214_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = xlv_TEXCOORD0.xy;
  highp vec2 tmpvar_9;
  tmpvar_9.x = ((_Time.y * (_Noise1_USpeed * _TimeScale)) + xlv_TEXCOORD0.x);
  tmpvar_9.y = (xlv_TEXCOORD0.y + (_Time.y * (_TimeScale * _Noise1_VSpeed)));
  if ((_Noise01_RandomToggle > 0.0)) {
    staticSwitch214_7 = (tmpvar_9 + xlv_TEXCOORD0.zw);
  } else {
    staticSwitch214_7 = tmpvar_9;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_NoiseTex01, staticSwitch214_7);
  tex2DNode205_6 = tmpvar_10;
  if ((_Noise01ChannelToggle == 0.0)) {
    staticSwitch216_5 = tex2DNode205_6.x;
  } else {
    if ((_Noise01ChannelToggle == 1.0)) {
      staticSwitch216_5 = tex2DNode205_6.y;
    } else {
      if ((_Noise01ChannelToggle == 2.0)) {
        staticSwitch216_5 = tex2DNode205_6.z;
      } else {
        if ((_Noise01ChannelToggle == 3.0)) {
          staticSwitch216_5 = tex2DNode205_6.w;
        } else {
          staticSwitch216_5 = tex2DNode205_6.x;
        };
      };
    };
  };
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_ShapeTexture, xlv_TEXCOORD0.xy);
  highp float tmpvar_12;
  tmpvar_12 = ((tmpvar_11.z * _ShapeBlueBrightness) * ((staticSwitch216_5 * _NoiseTex01Brightness) - _NoiseTex01BrightnessAdd));
  if ((_NoiseAsVcoord > 0.0)) {
    staticSwitch148_4 = tmpvar_12;
  } else {
    staticSwitch148_4 = ((xlv_TEXCOORD0.y * _VcoordMultiplier) - tmpvar_12);
  };
  highp vec4 tmpvar_13;
  tmpvar_13.zw = vec2(0.0, 0.0);
  tmpvar_13.x = tmpvar_8.x;
  tmpvar_13.y = staticSwitch148_4;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ShapeTexture, tmpvar_13.xy);
  tex2DNode165_3 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = clamp ((xlv_COLOR.x * (
    clamp ((tex2DNode165_3.y * (staticSwitch148_4 * _OpacityIntensity)), 0.0, 1.0)
   - 
    ((1.0 - xlv_COLOR.w) + _GrassFireBurnOut)
  )), 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (mix ((_ColorOutter * _OutColorIntensity), (_ColorInner * _InnerColorIntensity), vec4(clamp (
    (tex2DNode165_3.x + (tex2DNode165_3.w * tex2DNode165_3.w))
  , 0.0, 1.0))) * xlv_COLOR.y).xyz;
  aseOutColor_1 = tmpvar_16;
  aseOutColor_1 = mix (aseOutColor_1, vec3(dot (aseOutColor_1, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  mediump float tmpvar_17;
  tmpvar_17 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = aseOutColor_1;
  tmpvar_18.w = tmpvar_17;
  gl_FragData[0] = tmpvar_18;
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
}
}
}
CustomEditor "ASEMaterialInspector"
}