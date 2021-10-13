//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_DLC/DLCFireV1" {
Properties {
_MainTex ("Particle Texture", 2D) = "white" { }
_BloomFactor ("Bloom Factor", Float) = 1
[Toggle(TEXTURE_SCALE)] _TextureScale ("Texture Scale", Float) = 0
_TSAspectRatio ("Texture Aspect Ratio (width : height)", Float) = 1
_ColorInner ("ColorInner", Color) = (1,0.753779,0.2132353,0)
_ColorOutter ("ColorOutter", Color) = (0.8970588,0.2483743,0.07915227,0)
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
_Alpha ("Alpha", Float) = 1
[KeywordEnum(R,G,B,A)] _Noise01ChannelToggle ("Noise01ChannelToggle", Float) = 0
[Toggle(_NOISE01_RANDOMTOGGLE_ON)] _Noise01_RandomToggle ("Noise01_RandomToggle", Float) = 0
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 36353
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
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
uniform highp float _Alpha;
uniform highp vec4 _ColorInner;
uniform highp vec4 _ColorOutter;
uniform mediump float _Noise01ChannelToggle;
uniform mediump float _Noise01_RandomToggle;
uniform mediump float _NoiseAsVcoord;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 shapeValue_3;
  highp float shapeUVy_4;
  highp float noiseChannel_5;
  highp vec4 noiseValue_6;
  highp vec2 noiseUV_7;
  highp vec2 tmpvar_8;
  tmpvar_8.x = ((_Time.y * (_Noise1_USpeed * _TimeScale)) + xlv_TEXCOORD0.x);
  tmpvar_8.y = (xlv_TEXCOORD0.y + (_Time.y * (_TimeScale * _Noise1_VSpeed)));
  if ((_Noise01_RandomToggle > 0.0)) {
    noiseUV_7 = (tmpvar_8 + xlv_TEXCOORD0.zw);
  } else {
    noiseUV_7 = tmpvar_8;
  };
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_NoiseTex01, noiseUV_7);
  noiseValue_6 = tmpvar_9;
  if ((_Noise01ChannelToggle == 0.0)) {
    noiseChannel_5 = noiseValue_6.x;
  } else {
    if ((_Noise01ChannelToggle == 1.0)) {
      noiseChannel_5 = noiseValue_6.y;
    } else {
      if ((_Noise01ChannelToggle == 2.0)) {
        noiseChannel_5 = noiseValue_6.z;
      } else {
        if ((_Noise01ChannelToggle == 3.0)) {
          noiseChannel_5 = noiseValue_6.w;
        } else {
          noiseChannel_5 = noiseValue_6.x;
        };
      };
    };
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ShapeTexture, xlv_TEXCOORD0.xy);
  highp float tmpvar_11;
  tmpvar_11 = ((tmpvar_10.z * _ShapeBlueBrightness) * ((noiseChannel_5 * _NoiseTex01Brightness) - _NoiseTex01BrightnessAdd));
  if ((_NoiseAsVcoord > 0.0)) {
    shapeUVy_4 = tmpvar_11;
  } else {
    shapeUVy_4 = ((xlv_TEXCOORD0.y * _VcoordMultiplier) - tmpvar_11);
  };
  highp vec2 tmpvar_12;
  tmpvar_12.x = xlv_TEXCOORD0.x;
  tmpvar_12.y = shapeUVy_4;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShapeTexture, tmpvar_12);
  shapeValue_3 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (clamp ((xlv_COLOR.x * 
    (clamp ((shapeValue_3.y * (shapeUVy_4 * _OpacityIntensity)), 0.0, 1.0) - ((1.0 - xlv_COLOR.w) + _GrassFireBurnOut))
  ), 0.0, 1.0) * _Alpha);
  aseOutAlpha_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (mix (_ColorInner, _ColorOutter, vec4(clamp (
    (shapeValue_3.x + (shapeValue_3.w * shapeValue_3.w))
  , 0.0, 1.0))) * xlv_COLOR.y).xyz;
  aseOutColor_1 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = aseOutColor_1;
  tmpvar_17.w = tmpvar_16;
  gl_FragData[0] = tmpvar_17;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
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
uniform highp float _Alpha;
uniform highp vec4 _ColorInner;
uniform highp vec4 _ColorOutter;
uniform mediump float _Noise01ChannelToggle;
uniform mediump float _Noise01_RandomToggle;
uniform mediump float _NoiseAsVcoord;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 shapeValue_3;
  highp float shapeUVy_4;
  highp float noiseChannel_5;
  highp vec4 noiseValue_6;
  highp vec2 noiseUV_7;
  highp vec2 tmpvar_8;
  tmpvar_8.x = ((_Time.y * (_Noise1_USpeed * _TimeScale)) + xlv_TEXCOORD0.x);
  tmpvar_8.y = (xlv_TEXCOORD0.y + (_Time.y * (_TimeScale * _Noise1_VSpeed)));
  if ((_Noise01_RandomToggle > 0.0)) {
    noiseUV_7 = (tmpvar_8 + xlv_TEXCOORD0.zw);
  } else {
    noiseUV_7 = tmpvar_8;
  };
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_NoiseTex01, noiseUV_7);
  noiseValue_6 = tmpvar_9;
  if ((_Noise01ChannelToggle == 0.0)) {
    noiseChannel_5 = noiseValue_6.x;
  } else {
    if ((_Noise01ChannelToggle == 1.0)) {
      noiseChannel_5 = noiseValue_6.y;
    } else {
      if ((_Noise01ChannelToggle == 2.0)) {
        noiseChannel_5 = noiseValue_6.z;
      } else {
        if ((_Noise01ChannelToggle == 3.0)) {
          noiseChannel_5 = noiseValue_6.w;
        } else {
          noiseChannel_5 = noiseValue_6.x;
        };
      };
    };
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ShapeTexture, xlv_TEXCOORD0.xy);
  highp float tmpvar_11;
  tmpvar_11 = ((tmpvar_10.z * _ShapeBlueBrightness) * ((noiseChannel_5 * _NoiseTex01Brightness) - _NoiseTex01BrightnessAdd));
  if ((_NoiseAsVcoord > 0.0)) {
    shapeUVy_4 = tmpvar_11;
  } else {
    shapeUVy_4 = ((xlv_TEXCOORD0.y * _VcoordMultiplier) - tmpvar_11);
  };
  highp vec2 tmpvar_12;
  tmpvar_12.x = xlv_TEXCOORD0.x;
  tmpvar_12.y = shapeUVy_4;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShapeTexture, tmpvar_12);
  shapeValue_3 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (clamp ((xlv_COLOR.x * 
    (clamp ((shapeValue_3.y * (shapeUVy_4 * _OpacityIntensity)), 0.0, 1.0) - ((1.0 - xlv_COLOR.w) + _GrassFireBurnOut))
  ), 0.0, 1.0) * _Alpha);
  aseOutAlpha_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (mix (_ColorInner, _ColorOutter, vec4(clamp (
    (shapeValue_3.x + (shapeValue_3.w * shapeValue_3.w))
  , 0.0, 1.0))) * xlv_COLOR.y).xyz;
  aseOutColor_1 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = aseOutColor_1;
  tmpvar_17.w = tmpvar_16;
  gl_FragData[0] = tmpvar_17;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
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
uniform highp float _Alpha;
uniform highp vec4 _ColorInner;
uniform highp vec4 _ColorOutter;
uniform mediump float _Noise01ChannelToggle;
uniform mediump float _Noise01_RandomToggle;
uniform mediump float _NoiseAsVcoord;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 shapeValue_3;
  highp float shapeUVy_4;
  highp float noiseChannel_5;
  highp vec4 noiseValue_6;
  highp vec2 noiseUV_7;
  highp vec2 tmpvar_8;
  tmpvar_8.x = ((_Time.y * (_Noise1_USpeed * _TimeScale)) + xlv_TEXCOORD0.x);
  tmpvar_8.y = (xlv_TEXCOORD0.y + (_Time.y * (_TimeScale * _Noise1_VSpeed)));
  if ((_Noise01_RandomToggle > 0.0)) {
    noiseUV_7 = (tmpvar_8 + xlv_TEXCOORD0.zw);
  } else {
    noiseUV_7 = tmpvar_8;
  };
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_NoiseTex01, noiseUV_7);
  noiseValue_6 = tmpvar_9;
  if ((_Noise01ChannelToggle == 0.0)) {
    noiseChannel_5 = noiseValue_6.x;
  } else {
    if ((_Noise01ChannelToggle == 1.0)) {
      noiseChannel_5 = noiseValue_6.y;
    } else {
      if ((_Noise01ChannelToggle == 2.0)) {
        noiseChannel_5 = noiseValue_6.z;
      } else {
        if ((_Noise01ChannelToggle == 3.0)) {
          noiseChannel_5 = noiseValue_6.w;
        } else {
          noiseChannel_5 = noiseValue_6.x;
        };
      };
    };
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ShapeTexture, xlv_TEXCOORD0.xy);
  highp float tmpvar_11;
  tmpvar_11 = ((tmpvar_10.z * _ShapeBlueBrightness) * ((noiseChannel_5 * _NoiseTex01Brightness) - _NoiseTex01BrightnessAdd));
  if ((_NoiseAsVcoord > 0.0)) {
    shapeUVy_4 = tmpvar_11;
  } else {
    shapeUVy_4 = ((xlv_TEXCOORD0.y * _VcoordMultiplier) - tmpvar_11);
  };
  highp vec2 tmpvar_12;
  tmpvar_12.x = xlv_TEXCOORD0.x;
  tmpvar_12.y = shapeUVy_4;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShapeTexture, tmpvar_12);
  shapeValue_3 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (clamp ((xlv_COLOR.x * 
    (clamp ((shapeValue_3.y * (shapeUVy_4 * _OpacityIntensity)), 0.0, 1.0) - ((1.0 - xlv_COLOR.w) + _GrassFireBurnOut))
  ), 0.0, 1.0) * _Alpha);
  aseOutAlpha_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (mix (_ColorInner, _ColorOutter, vec4(clamp (
    (shapeValue_3.x + (shapeValue_3.w * shapeValue_3.w))
  , 0.0, 1.0))) * xlv_COLOR.y).xyz;
  aseOutColor_1 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = aseOutColor_1;
  tmpvar_17.w = tmpvar_16;
  gl_FragData[0] = tmpvar_17;
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
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 105180
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump float tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1.w;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp float x_2;
  x_2 = (texture2D (_MainTex, xlv_TEXCOORD0).w - 0.01);
  if ((x_2 < 0.0)) {
    discard;
  };
  color_1.w = (_BloomFactor * xlv_TEXCOORD1);
  gl_FragData[0] = color_1;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump float tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1.w;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp float x_2;
  x_2 = (texture2D (_MainTex, xlv_TEXCOORD0).w - 0.01);
  if ((x_2 < 0.0)) {
    discard;
  };
  color_1.w = (_BloomFactor * xlv_TEXCOORD1);
  gl_FragData[0] = color_1;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump float tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1.w;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp float x_2;
  x_2 = (texture2D (_MainTex, xlv_TEXCOORD0).w - 0.01);
  if ((x_2 < 0.0)) {
    discard;
  };
  color_1.w = (_BloomFactor * xlv_TEXCOORD1);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "TEXTURE_SCALE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _TSAspectRatio;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump float tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2 = tmpvar_1.w;
  highp vec2 texcoord_5;
  texcoord_5 = (_glesMultiTexCoord0.xy - 0.5);
  if ((1.0 < _TSAspectRatio)) {
    highp vec2 tmpvar_6;
    tmpvar_6.x = 1.0;
    tmpvar_6.y = _TSAspectRatio;
    texcoord_5 = (texcoord_5 * tmpvar_6);
  } else {
    highp vec2 tmpvar_7;
    tmpvar_7.y = 1.0;
    tmpvar_7.x = (1.0/(_TSAspectRatio));
    texcoord_5 = (texcoord_5 * tmpvar_7);
  };
  texcoord_5 = (texcoord_5 + 0.5);
  texcoord_5 = ((texcoord_5 * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_8;
  tmpvar_8.xy = vec2(0.0, 0.0);
  tmpvar_8.zw = _MainTex_ST.xy;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_5;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (tmpvar_8 + _MainTex_ST.zwzw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 color_1;
  highp float x_2;
  x_2 = (xlv_TEXCOORD0.x - xlv_TEXCOORD2.x);
  if ((x_2 < 0.0)) {
    discard;
  };
  highp float x_3;
  x_3 = (xlv_TEXCOORD0.y - xlv_TEXCOORD2.y);
  if ((x_3 < 0.0)) {
    discard;
  };
  highp float x_4;
  x_4 = (xlv_TEXCOORD2.z - xlv_TEXCOORD0.x);
  if ((x_4 < 0.0)) {
    discard;
  };
  highp float x_5;
  x_5 = (xlv_TEXCOORD2.w - xlv_TEXCOORD0.y);
  if ((x_5 < 0.0)) {
    discard;
  };
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp float x_6;
  x_6 = (texture2D (_MainTex, xlv_TEXCOORD0).w - 0.01);
  if ((x_6 < 0.0)) {
    discard;
  };
  color_1.w = (_BloomFactor * xlv_TEXCOORD1);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "TEXTURE_SCALE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _TSAspectRatio;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump float tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2 = tmpvar_1.w;
  highp vec2 texcoord_5;
  texcoord_5 = (_glesMultiTexCoord0.xy - 0.5);
  if ((1.0 < _TSAspectRatio)) {
    highp vec2 tmpvar_6;
    tmpvar_6.x = 1.0;
    tmpvar_6.y = _TSAspectRatio;
    texcoord_5 = (texcoord_5 * tmpvar_6);
  } else {
    highp vec2 tmpvar_7;
    tmpvar_7.y = 1.0;
    tmpvar_7.x = (1.0/(_TSAspectRatio));
    texcoord_5 = (texcoord_5 * tmpvar_7);
  };
  texcoord_5 = (texcoord_5 + 0.5);
  texcoord_5 = ((texcoord_5 * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_8;
  tmpvar_8.xy = vec2(0.0, 0.0);
  tmpvar_8.zw = _MainTex_ST.xy;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_5;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (tmpvar_8 + _MainTex_ST.zwzw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 color_1;
  highp float x_2;
  x_2 = (xlv_TEXCOORD0.x - xlv_TEXCOORD2.x);
  if ((x_2 < 0.0)) {
    discard;
  };
  highp float x_3;
  x_3 = (xlv_TEXCOORD0.y - xlv_TEXCOORD2.y);
  if ((x_3 < 0.0)) {
    discard;
  };
  highp float x_4;
  x_4 = (xlv_TEXCOORD2.z - xlv_TEXCOORD0.x);
  if ((x_4 < 0.0)) {
    discard;
  };
  highp float x_5;
  x_5 = (xlv_TEXCOORD2.w - xlv_TEXCOORD0.y);
  if ((x_5 < 0.0)) {
    discard;
  };
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp float x_6;
  x_6 = (texture2D (_MainTex, xlv_TEXCOORD0).w - 0.01);
  if ((x_6 < 0.0)) {
    discard;
  };
  color_1.w = (_BloomFactor * xlv_TEXCOORD1);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "TEXTURE_SCALE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _TSAspectRatio;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump float tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2 = tmpvar_1.w;
  highp vec2 texcoord_5;
  texcoord_5 = (_glesMultiTexCoord0.xy - 0.5);
  if ((1.0 < _TSAspectRatio)) {
    highp vec2 tmpvar_6;
    tmpvar_6.x = 1.0;
    tmpvar_6.y = _TSAspectRatio;
    texcoord_5 = (texcoord_5 * tmpvar_6);
  } else {
    highp vec2 tmpvar_7;
    tmpvar_7.y = 1.0;
    tmpvar_7.x = (1.0/(_TSAspectRatio));
    texcoord_5 = (texcoord_5 * tmpvar_7);
  };
  texcoord_5 = (texcoord_5 + 0.5);
  texcoord_5 = ((texcoord_5 * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_8;
  tmpvar_8.xy = vec2(0.0, 0.0);
  tmpvar_8.zw = _MainTex_ST.xy;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_5;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (tmpvar_8 + _MainTex_ST.zwzw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 color_1;
  highp float x_2;
  x_2 = (xlv_TEXCOORD0.x - xlv_TEXCOORD2.x);
  if ((x_2 < 0.0)) {
    discard;
  };
  highp float x_3;
  x_3 = (xlv_TEXCOORD0.y - xlv_TEXCOORD2.y);
  if ((x_3 < 0.0)) {
    discard;
  };
  highp float x_4;
  x_4 = (xlv_TEXCOORD2.z - xlv_TEXCOORD0.x);
  if ((x_4 < 0.0)) {
    discard;
  };
  highp float x_5;
  x_5 = (xlv_TEXCOORD2.w - xlv_TEXCOORD0.y);
  if ((x_5 < 0.0)) {
    discard;
  };
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp float x_6;
  x_6 = (texture2D (_MainTex, xlv_TEXCOORD0).w - 0.01);
  if ((x_6 < 0.0)) {
    discard;
  };
  color_1.w = (_BloomFactor * xlv_TEXCOORD1);
  gl_FragData[0] = color_1;
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
Keywords { "TEXTURE_SCALE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "TEXTURE_SCALE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "TEXTURE_SCALE" }
""
}
}
}
}
CustomEditor "ASEMaterialInspector"
}