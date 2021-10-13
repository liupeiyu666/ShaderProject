//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Particles/Dissolution_2Color/Multiply" {
Properties {
[Header(Main Texture)] _MainTex ("Main Tex", 2D) = "white" { }
[Enum(R, 0, G, 1, B, 2, A, 3)] _ColorChannelMapping ("Color Channel Mapping", Float) = 0
[Enum(R, 0, G, 1, B, 2, A, 3)] _AlphaChannelMapping ("Alpha Channel Mapping", Float) = 3
[Toggle] _UseVertexColor ("Use Particle Color As Color A", Float) = 0
_ColorA ("Color A", Color) = (1,0,0,0)
[Toggle] _UseCustomColor ("Use Particle Custom Color As Color B", Float) = 0
_ColorB ("Color B", Color) = (1,1,0,0)
_LerpBrightness ("Lerp Brightness", Float) = 1
[Header(Dissolve Map)] _DissolveTex ("Dissolve Tex", 2D) = "white" { }
[Enum(R, 0, G, 1, B, 2, A, 3)] _DissolveChannelMapping ("Dissolve Channel Mapping", Float) = 0
_DissolveUSpeed ("U Speed", Float) = 0
_DissolveVSpeed ("V Speed", Float) = 0
_DissolveRandomRange ("Random Speed Range", Float) = 0
[Toggle] _DissolveUVRandom ("Random UV", Float) = 0
[Header(Noise Map)] [Toggle(_NOISE_ON)] _Noise ("Use Noise", Float) = 0
_NoiseTex ("Noise Tex", 2D) = "white" { }
[Enum(R, 0, G, 1, B, 2, A, 3)] _NoiseChannelMapping ("Noise Channel Mapping", Float) = 0
_NoiseUSpeed ("U Speed", Float) = 0
_NoiseVSpeed ("V Speed", Float) = 0
_NoiseRandomRange ("Random Speed Range", Float) = 0
_NoiseBrightness ("Noise Brightness", Float) = 0.1
[Toggle] _NoiseUVRandom ("Random UV", Float) = 0
[Header(Bloom)] _BloomFactor ("Bloom Factor", Float) = 1
_EmissionScaler ("Emission Scaler", Range(0, 50)) = 1
[Header(Render Options)] [Enum(Off, 4, On, 0)] _AlwaysOnTop ("Always On Top", Float) = 4
}
SubShader {
 Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
 Pass {
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 15096
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _ColorChannelMapping;
uniform highp float _AlphaChannelMapping;
uniform highp float _UseVertexColor;
uniform mediump vec4 _ColorA;
uniform highp float _UseCustomColor;
uniform mediump vec4 _ColorB;
uniform highp float _LerpBrightness;
uniform sampler2D _DissolveTex;
uniform highp vec4 _DissolveTex_ST;
uniform highp float _DissolveChannelMapping;
uniform highp float _DissolveUSpeed;
uniform highp float _DissolveVSpeed;
uniform highp float _DissolveRandomRange;
uniform highp float _DissolveUVRandom;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float alpha_1;
  mediump vec3 ColorB_2;
  mediump vec3 ColorA_3;
  mediump float MainTexAlpha_4;
  mediump float MainTexColor_5;
  mediump vec4 MainTexSampler_6;
  mediump float DissolveChannel_7;
  mediump vec4 DissolveTexSampler_8;
  highp vec2 DissolveTex_UV_9;
  mediump vec4 o_10;
  o_10 = vec4(1.0, 1.0, 1.0, 1.0);
  highp float tmpvar_11;
  tmpvar_11 = (((xlv_TEXCOORD1.w - 0.5) * abs(_DissolveRandomRange)) + 1.0);
  highp vec2 tmpvar_12;
  tmpvar_12.x = ((_Time.y * _DissolveUSpeed) * tmpvar_11);
  tmpvar_12.y = ((_Time.y * _DissolveVSpeed) * tmpvar_11);
  DissolveTex_UV_9 = (((xlv_TEXCOORD0.xy * _DissolveTex_ST.xy) + _DissolveTex_ST.zw) + tmpvar_12);
  if (bool(_DissolveUVRandom)) {
    DissolveTex_UV_9 = (DissolveTex_UV_9 + xlv_TEXCOORD0.zw);
  };
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_DissolveTex, DissolveTex_UV_9);
  DissolveTexSampler_8 = tmpvar_13;
  DissolveChannel_7 = 0.0;
  if ((_DissolveChannelMapping == 0.0)) {
    DissolveChannel_7 = DissolveTexSampler_8.x;
  } else {
    if ((_DissolveChannelMapping == 1.0)) {
      DissolveChannel_7 = DissolveTexSampler_8.y;
    } else {
      if ((_DissolveChannelMapping == 2.0)) {
        DissolveChannel_7 = DissolveTexSampler_8.z;
      } else {
        if ((_DissolveChannelMapping == 3.0)) {
          DissolveChannel_7 = DissolveTexSampler_8.w;
        };
      };
    };
  };
  highp vec2 tmpvar_14;
  tmpvar_14 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, tmpvar_14);
  MainTexSampler_6 = tmpvar_15;
  MainTexColor_5 = 0.0;
  if ((_ColorChannelMapping == 0.0)) {
    MainTexColor_5 = MainTexSampler_6.x;
  } else {
    if ((_ColorChannelMapping == 1.0)) {
      MainTexColor_5 = MainTexSampler_6.y;
    } else {
      if ((_ColorChannelMapping == 2.0)) {
        MainTexColor_5 = MainTexSampler_6.z;
      } else {
        if ((_ColorChannelMapping == 3.0)) {
          MainTexColor_5 = MainTexSampler_6.w;
        };
      };
    };
  };
  MainTexAlpha_4 = 0.0;
  if ((_AlphaChannelMapping == 0.0)) {
    MainTexAlpha_4 = MainTexSampler_6.x;
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      MainTexAlpha_4 = MainTexSampler_6.y;
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        MainTexAlpha_4 = MainTexSampler_6.z;
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          MainTexAlpha_4 = MainTexSampler_6.w;
        };
      };
    };
  };
  ColorA_3 = _ColorA.xyz;
  if (bool(_UseVertexColor)) {
    ColorA_3 = xlv_COLOR.xyz;
  };
  ColorB_2 = _ColorB.xyz;
  if (bool(_UseCustomColor)) {
    ColorB_2 = xlv_TEXCOORD1.xyz;
  };
  highp vec3 tmpvar_16;
  tmpvar_16 = mix (ColorA_3, ColorB_2, vec3(clamp ((
    (_LerpBrightness * DissolveChannel_7)
   * MainTexColor_5), 0.0, 1.0)));
  o_10.xyz = (tmpvar_16 * _EmissionScaler);
  alpha_1 = 0.0;
  if (((DissolveChannel_7 * MainTexAlpha_4) <= (1.0 - xlv_COLOR.w))) {
    alpha_1 = 0.0;
  } else {
    alpha_1 = 1.0;
  };
  o_10.xyz = mix (vec3(1.0, 1.0, 1.0), o_10.xyz, vec3(alpha_1));
  gl_FragData[0] = o_10;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _ColorChannelMapping;
uniform highp float _AlphaChannelMapping;
uniform highp float _UseVertexColor;
uniform mediump vec4 _ColorA;
uniform highp float _UseCustomColor;
uniform mediump vec4 _ColorB;
uniform highp float _LerpBrightness;
uniform sampler2D _DissolveTex;
uniform highp vec4 _DissolveTex_ST;
uniform highp float _DissolveChannelMapping;
uniform highp float _DissolveUSpeed;
uniform highp float _DissolveVSpeed;
uniform highp float _DissolveRandomRange;
uniform highp float _DissolveUVRandom;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float alpha_1;
  mediump vec3 ColorB_2;
  mediump vec3 ColorA_3;
  mediump float MainTexAlpha_4;
  mediump float MainTexColor_5;
  mediump vec4 MainTexSampler_6;
  mediump float DissolveChannel_7;
  mediump vec4 DissolveTexSampler_8;
  highp vec2 DissolveTex_UV_9;
  mediump vec4 o_10;
  o_10 = vec4(1.0, 1.0, 1.0, 1.0);
  highp float tmpvar_11;
  tmpvar_11 = (((xlv_TEXCOORD1.w - 0.5) * abs(_DissolveRandomRange)) + 1.0);
  highp vec2 tmpvar_12;
  tmpvar_12.x = ((_Time.y * _DissolveUSpeed) * tmpvar_11);
  tmpvar_12.y = ((_Time.y * _DissolveVSpeed) * tmpvar_11);
  DissolveTex_UV_9 = (((xlv_TEXCOORD0.xy * _DissolveTex_ST.xy) + _DissolveTex_ST.zw) + tmpvar_12);
  if (bool(_DissolveUVRandom)) {
    DissolveTex_UV_9 = (DissolveTex_UV_9 + xlv_TEXCOORD0.zw);
  };
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_DissolveTex, DissolveTex_UV_9);
  DissolveTexSampler_8 = tmpvar_13;
  DissolveChannel_7 = 0.0;
  if ((_DissolveChannelMapping == 0.0)) {
    DissolveChannel_7 = DissolveTexSampler_8.x;
  } else {
    if ((_DissolveChannelMapping == 1.0)) {
      DissolveChannel_7 = DissolveTexSampler_8.y;
    } else {
      if ((_DissolveChannelMapping == 2.0)) {
        DissolveChannel_7 = DissolveTexSampler_8.z;
      } else {
        if ((_DissolveChannelMapping == 3.0)) {
          DissolveChannel_7 = DissolveTexSampler_8.w;
        };
      };
    };
  };
  highp vec2 tmpvar_14;
  tmpvar_14 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, tmpvar_14);
  MainTexSampler_6 = tmpvar_15;
  MainTexColor_5 = 0.0;
  if ((_ColorChannelMapping == 0.0)) {
    MainTexColor_5 = MainTexSampler_6.x;
  } else {
    if ((_ColorChannelMapping == 1.0)) {
      MainTexColor_5 = MainTexSampler_6.y;
    } else {
      if ((_ColorChannelMapping == 2.0)) {
        MainTexColor_5 = MainTexSampler_6.z;
      } else {
        if ((_ColorChannelMapping == 3.0)) {
          MainTexColor_5 = MainTexSampler_6.w;
        };
      };
    };
  };
  MainTexAlpha_4 = 0.0;
  if ((_AlphaChannelMapping == 0.0)) {
    MainTexAlpha_4 = MainTexSampler_6.x;
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      MainTexAlpha_4 = MainTexSampler_6.y;
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        MainTexAlpha_4 = MainTexSampler_6.z;
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          MainTexAlpha_4 = MainTexSampler_6.w;
        };
      };
    };
  };
  ColorA_3 = _ColorA.xyz;
  if (bool(_UseVertexColor)) {
    ColorA_3 = xlv_COLOR.xyz;
  };
  ColorB_2 = _ColorB.xyz;
  if (bool(_UseCustomColor)) {
    ColorB_2 = xlv_TEXCOORD1.xyz;
  };
  highp vec3 tmpvar_16;
  tmpvar_16 = mix (ColorA_3, ColorB_2, vec3(clamp ((
    (_LerpBrightness * DissolveChannel_7)
   * MainTexColor_5), 0.0, 1.0)));
  o_10.xyz = (tmpvar_16 * _EmissionScaler);
  alpha_1 = 0.0;
  if (((DissolveChannel_7 * MainTexAlpha_4) <= (1.0 - xlv_COLOR.w))) {
    alpha_1 = 0.0;
  } else {
    alpha_1 = 1.0;
  };
  o_10.xyz = mix (vec3(1.0, 1.0, 1.0), o_10.xyz, vec3(alpha_1));
  gl_FragData[0] = o_10;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _ColorChannelMapping;
uniform highp float _AlphaChannelMapping;
uniform highp float _UseVertexColor;
uniform mediump vec4 _ColorA;
uniform highp float _UseCustomColor;
uniform mediump vec4 _ColorB;
uniform highp float _LerpBrightness;
uniform sampler2D _DissolveTex;
uniform highp vec4 _DissolveTex_ST;
uniform highp float _DissolveChannelMapping;
uniform highp float _DissolveUSpeed;
uniform highp float _DissolveVSpeed;
uniform highp float _DissolveRandomRange;
uniform highp float _DissolveUVRandom;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float alpha_1;
  mediump vec3 ColorB_2;
  mediump vec3 ColorA_3;
  mediump float MainTexAlpha_4;
  mediump float MainTexColor_5;
  mediump vec4 MainTexSampler_6;
  mediump float DissolveChannel_7;
  mediump vec4 DissolveTexSampler_8;
  highp vec2 DissolveTex_UV_9;
  mediump vec4 o_10;
  o_10 = vec4(1.0, 1.0, 1.0, 1.0);
  highp float tmpvar_11;
  tmpvar_11 = (((xlv_TEXCOORD1.w - 0.5) * abs(_DissolveRandomRange)) + 1.0);
  highp vec2 tmpvar_12;
  tmpvar_12.x = ((_Time.y * _DissolveUSpeed) * tmpvar_11);
  tmpvar_12.y = ((_Time.y * _DissolveVSpeed) * tmpvar_11);
  DissolveTex_UV_9 = (((xlv_TEXCOORD0.xy * _DissolveTex_ST.xy) + _DissolveTex_ST.zw) + tmpvar_12);
  if (bool(_DissolveUVRandom)) {
    DissolveTex_UV_9 = (DissolveTex_UV_9 + xlv_TEXCOORD0.zw);
  };
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_DissolveTex, DissolveTex_UV_9);
  DissolveTexSampler_8 = tmpvar_13;
  DissolveChannel_7 = 0.0;
  if ((_DissolveChannelMapping == 0.0)) {
    DissolveChannel_7 = DissolveTexSampler_8.x;
  } else {
    if ((_DissolveChannelMapping == 1.0)) {
      DissolveChannel_7 = DissolveTexSampler_8.y;
    } else {
      if ((_DissolveChannelMapping == 2.0)) {
        DissolveChannel_7 = DissolveTexSampler_8.z;
      } else {
        if ((_DissolveChannelMapping == 3.0)) {
          DissolveChannel_7 = DissolveTexSampler_8.w;
        };
      };
    };
  };
  highp vec2 tmpvar_14;
  tmpvar_14 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, tmpvar_14);
  MainTexSampler_6 = tmpvar_15;
  MainTexColor_5 = 0.0;
  if ((_ColorChannelMapping == 0.0)) {
    MainTexColor_5 = MainTexSampler_6.x;
  } else {
    if ((_ColorChannelMapping == 1.0)) {
      MainTexColor_5 = MainTexSampler_6.y;
    } else {
      if ((_ColorChannelMapping == 2.0)) {
        MainTexColor_5 = MainTexSampler_6.z;
      } else {
        if ((_ColorChannelMapping == 3.0)) {
          MainTexColor_5 = MainTexSampler_6.w;
        };
      };
    };
  };
  MainTexAlpha_4 = 0.0;
  if ((_AlphaChannelMapping == 0.0)) {
    MainTexAlpha_4 = MainTexSampler_6.x;
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      MainTexAlpha_4 = MainTexSampler_6.y;
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        MainTexAlpha_4 = MainTexSampler_6.z;
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          MainTexAlpha_4 = MainTexSampler_6.w;
        };
      };
    };
  };
  ColorA_3 = _ColorA.xyz;
  if (bool(_UseVertexColor)) {
    ColorA_3 = xlv_COLOR.xyz;
  };
  ColorB_2 = _ColorB.xyz;
  if (bool(_UseCustomColor)) {
    ColorB_2 = xlv_TEXCOORD1.xyz;
  };
  highp vec3 tmpvar_16;
  tmpvar_16 = mix (ColorA_3, ColorB_2, vec3(clamp ((
    (_LerpBrightness * DissolveChannel_7)
   * MainTexColor_5), 0.0, 1.0)));
  o_10.xyz = (tmpvar_16 * _EmissionScaler);
  alpha_1 = 0.0;
  if (((DissolveChannel_7 * MainTexAlpha_4) <= (1.0 - xlv_COLOR.w))) {
    alpha_1 = 0.0;
  } else {
    alpha_1 = 1.0;
  };
  o_10.xyz = mix (vec3(1.0, 1.0, 1.0), o_10.xyz, vec3(alpha_1));
  gl_FragData[0] = o_10;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _ColorChannelMapping;
uniform highp float _AlphaChannelMapping;
uniform highp float _UseVertexColor;
uniform mediump vec4 _ColorA;
uniform highp float _UseCustomColor;
uniform mediump vec4 _ColorB;
uniform highp float _LerpBrightness;
uniform sampler2D _DissolveTex;
uniform highp vec4 _DissolveTex_ST;
uniform highp float _DissolveChannelMapping;
uniform highp float _DissolveUSpeed;
uniform highp float _DissolveVSpeed;
uniform highp float _DissolveRandomRange;
uniform highp float _DissolveUVRandom;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float alpha_1;
  mediump vec3 ColorB_2;
  mediump vec3 ColorA_3;
  mediump float MainTexAlpha_4;
  mediump float MainTexColor_5;
  mediump vec4 MainTexSampler_6;
  mediump float DissolveChannel_7;
  mediump vec4 DissolveTexSampler_8;
  highp vec2 DissolveTex_UV_9;
  mediump vec4 o_10;
  o_10 = vec4(1.0, 1.0, 1.0, 1.0);
  highp float tmpvar_11;
  tmpvar_11 = (((xlv_TEXCOORD1.w - 0.5) * abs(_DissolveRandomRange)) + 1.0);
  highp vec2 tmpvar_12;
  tmpvar_12.x = ((_Time.y * _DissolveUSpeed) * tmpvar_11);
  tmpvar_12.y = ((_Time.y * _DissolveVSpeed) * tmpvar_11);
  DissolveTex_UV_9 = (((xlv_TEXCOORD0.xy * _DissolveTex_ST.xy) + _DissolveTex_ST.zw) + tmpvar_12);
  if (bool(_DissolveUVRandom)) {
    DissolveTex_UV_9 = (DissolveTex_UV_9 + xlv_TEXCOORD0.zw);
  };
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_DissolveTex, DissolveTex_UV_9);
  DissolveTexSampler_8 = tmpvar_13;
  DissolveChannel_7 = 0.0;
  if ((_DissolveChannelMapping == 0.0)) {
    DissolveChannel_7 = DissolveTexSampler_8.x;
  } else {
    if ((_DissolveChannelMapping == 1.0)) {
      DissolveChannel_7 = DissolveTexSampler_8.y;
    } else {
      if ((_DissolveChannelMapping == 2.0)) {
        DissolveChannel_7 = DissolveTexSampler_8.z;
      } else {
        if ((_DissolveChannelMapping == 3.0)) {
          DissolveChannel_7 = DissolveTexSampler_8.w;
        };
      };
    };
  };
  highp vec2 tmpvar_14;
  tmpvar_14 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, tmpvar_14);
  MainTexSampler_6 = tmpvar_15;
  MainTexColor_5 = 0.0;
  if ((_ColorChannelMapping == 0.0)) {
    MainTexColor_5 = MainTexSampler_6.x;
  } else {
    if ((_ColorChannelMapping == 1.0)) {
      MainTexColor_5 = MainTexSampler_6.y;
    } else {
      if ((_ColorChannelMapping == 2.0)) {
        MainTexColor_5 = MainTexSampler_6.z;
      } else {
        if ((_ColorChannelMapping == 3.0)) {
          MainTexColor_5 = MainTexSampler_6.w;
        };
      };
    };
  };
  MainTexAlpha_4 = 0.0;
  if ((_AlphaChannelMapping == 0.0)) {
    MainTexAlpha_4 = MainTexSampler_6.x;
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      MainTexAlpha_4 = MainTexSampler_6.y;
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        MainTexAlpha_4 = MainTexSampler_6.z;
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          MainTexAlpha_4 = MainTexSampler_6.w;
        };
      };
    };
  };
  ColorA_3 = _ColorA.xyz;
  if (bool(_UseVertexColor)) {
    ColorA_3 = xlv_COLOR.xyz;
  };
  ColorB_2 = _ColorB.xyz;
  if (bool(_UseCustomColor)) {
    ColorB_2 = xlv_TEXCOORD1.xyz;
  };
  highp vec3 tmpvar_16;
  tmpvar_16 = mix (ColorA_3, ColorB_2, vec3(clamp ((
    (_LerpBrightness * DissolveChannel_7)
   * MainTexColor_5), 0.0, 1.0)));
  o_10.xyz = (tmpvar_16 * _EmissionScaler);
  alpha_1 = 0.0;
  if (((DissolveChannel_7 * MainTexAlpha_4) <= (1.0 - xlv_COLOR.w))) {
    alpha_1 = 0.0;
  } else {
    alpha_1 = 1.0;
  };
  o_10.xyz = mix (vec3(1.0, 1.0, 1.0), o_10.xyz, vec3(alpha_1));
  o_10.xyz = mix (o_10.xyz, vec3(dot (o_10.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = o_10;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _ColorChannelMapping;
uniform highp float _AlphaChannelMapping;
uniform highp float _UseVertexColor;
uniform mediump vec4 _ColorA;
uniform highp float _UseCustomColor;
uniform mediump vec4 _ColorB;
uniform highp float _LerpBrightness;
uniform sampler2D _DissolveTex;
uniform highp vec4 _DissolveTex_ST;
uniform highp float _DissolveChannelMapping;
uniform highp float _DissolveUSpeed;
uniform highp float _DissolveVSpeed;
uniform highp float _DissolveRandomRange;
uniform highp float _DissolveUVRandom;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float alpha_1;
  mediump vec3 ColorB_2;
  mediump vec3 ColorA_3;
  mediump float MainTexAlpha_4;
  mediump float MainTexColor_5;
  mediump vec4 MainTexSampler_6;
  mediump float DissolveChannel_7;
  mediump vec4 DissolveTexSampler_8;
  highp vec2 DissolveTex_UV_9;
  mediump vec4 o_10;
  o_10 = vec4(1.0, 1.0, 1.0, 1.0);
  highp float tmpvar_11;
  tmpvar_11 = (((xlv_TEXCOORD1.w - 0.5) * abs(_DissolveRandomRange)) + 1.0);
  highp vec2 tmpvar_12;
  tmpvar_12.x = ((_Time.y * _DissolveUSpeed) * tmpvar_11);
  tmpvar_12.y = ((_Time.y * _DissolveVSpeed) * tmpvar_11);
  DissolveTex_UV_9 = (((xlv_TEXCOORD0.xy * _DissolveTex_ST.xy) + _DissolveTex_ST.zw) + tmpvar_12);
  if (bool(_DissolveUVRandom)) {
    DissolveTex_UV_9 = (DissolveTex_UV_9 + xlv_TEXCOORD0.zw);
  };
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_DissolveTex, DissolveTex_UV_9);
  DissolveTexSampler_8 = tmpvar_13;
  DissolveChannel_7 = 0.0;
  if ((_DissolveChannelMapping == 0.0)) {
    DissolveChannel_7 = DissolveTexSampler_8.x;
  } else {
    if ((_DissolveChannelMapping == 1.0)) {
      DissolveChannel_7 = DissolveTexSampler_8.y;
    } else {
      if ((_DissolveChannelMapping == 2.0)) {
        DissolveChannel_7 = DissolveTexSampler_8.z;
      } else {
        if ((_DissolveChannelMapping == 3.0)) {
          DissolveChannel_7 = DissolveTexSampler_8.w;
        };
      };
    };
  };
  highp vec2 tmpvar_14;
  tmpvar_14 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, tmpvar_14);
  MainTexSampler_6 = tmpvar_15;
  MainTexColor_5 = 0.0;
  if ((_ColorChannelMapping == 0.0)) {
    MainTexColor_5 = MainTexSampler_6.x;
  } else {
    if ((_ColorChannelMapping == 1.0)) {
      MainTexColor_5 = MainTexSampler_6.y;
    } else {
      if ((_ColorChannelMapping == 2.0)) {
        MainTexColor_5 = MainTexSampler_6.z;
      } else {
        if ((_ColorChannelMapping == 3.0)) {
          MainTexColor_5 = MainTexSampler_6.w;
        };
      };
    };
  };
  MainTexAlpha_4 = 0.0;
  if ((_AlphaChannelMapping == 0.0)) {
    MainTexAlpha_4 = MainTexSampler_6.x;
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      MainTexAlpha_4 = MainTexSampler_6.y;
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        MainTexAlpha_4 = MainTexSampler_6.z;
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          MainTexAlpha_4 = MainTexSampler_6.w;
        };
      };
    };
  };
  ColorA_3 = _ColorA.xyz;
  if (bool(_UseVertexColor)) {
    ColorA_3 = xlv_COLOR.xyz;
  };
  ColorB_2 = _ColorB.xyz;
  if (bool(_UseCustomColor)) {
    ColorB_2 = xlv_TEXCOORD1.xyz;
  };
  highp vec3 tmpvar_16;
  tmpvar_16 = mix (ColorA_3, ColorB_2, vec3(clamp ((
    (_LerpBrightness * DissolveChannel_7)
   * MainTexColor_5), 0.0, 1.0)));
  o_10.xyz = (tmpvar_16 * _EmissionScaler);
  alpha_1 = 0.0;
  if (((DissolveChannel_7 * MainTexAlpha_4) <= (1.0 - xlv_COLOR.w))) {
    alpha_1 = 0.0;
  } else {
    alpha_1 = 1.0;
  };
  o_10.xyz = mix (vec3(1.0, 1.0, 1.0), o_10.xyz, vec3(alpha_1));
  o_10.xyz = mix (o_10.xyz, vec3(dot (o_10.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = o_10;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _ColorChannelMapping;
uniform highp float _AlphaChannelMapping;
uniform highp float _UseVertexColor;
uniform mediump vec4 _ColorA;
uniform highp float _UseCustomColor;
uniform mediump vec4 _ColorB;
uniform highp float _LerpBrightness;
uniform sampler2D _DissolveTex;
uniform highp vec4 _DissolveTex_ST;
uniform highp float _DissolveChannelMapping;
uniform highp float _DissolveUSpeed;
uniform highp float _DissolveVSpeed;
uniform highp float _DissolveRandomRange;
uniform highp float _DissolveUVRandom;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float alpha_1;
  mediump vec3 ColorB_2;
  mediump vec3 ColorA_3;
  mediump float MainTexAlpha_4;
  mediump float MainTexColor_5;
  mediump vec4 MainTexSampler_6;
  mediump float DissolveChannel_7;
  mediump vec4 DissolveTexSampler_8;
  highp vec2 DissolveTex_UV_9;
  mediump vec4 o_10;
  o_10 = vec4(1.0, 1.0, 1.0, 1.0);
  highp float tmpvar_11;
  tmpvar_11 = (((xlv_TEXCOORD1.w - 0.5) * abs(_DissolveRandomRange)) + 1.0);
  highp vec2 tmpvar_12;
  tmpvar_12.x = ((_Time.y * _DissolveUSpeed) * tmpvar_11);
  tmpvar_12.y = ((_Time.y * _DissolveVSpeed) * tmpvar_11);
  DissolveTex_UV_9 = (((xlv_TEXCOORD0.xy * _DissolveTex_ST.xy) + _DissolveTex_ST.zw) + tmpvar_12);
  if (bool(_DissolveUVRandom)) {
    DissolveTex_UV_9 = (DissolveTex_UV_9 + xlv_TEXCOORD0.zw);
  };
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_DissolveTex, DissolveTex_UV_9);
  DissolveTexSampler_8 = tmpvar_13;
  DissolveChannel_7 = 0.0;
  if ((_DissolveChannelMapping == 0.0)) {
    DissolveChannel_7 = DissolveTexSampler_8.x;
  } else {
    if ((_DissolveChannelMapping == 1.0)) {
      DissolveChannel_7 = DissolveTexSampler_8.y;
    } else {
      if ((_DissolveChannelMapping == 2.0)) {
        DissolveChannel_7 = DissolveTexSampler_8.z;
      } else {
        if ((_DissolveChannelMapping == 3.0)) {
          DissolveChannel_7 = DissolveTexSampler_8.w;
        };
      };
    };
  };
  highp vec2 tmpvar_14;
  tmpvar_14 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, tmpvar_14);
  MainTexSampler_6 = tmpvar_15;
  MainTexColor_5 = 0.0;
  if ((_ColorChannelMapping == 0.0)) {
    MainTexColor_5 = MainTexSampler_6.x;
  } else {
    if ((_ColorChannelMapping == 1.0)) {
      MainTexColor_5 = MainTexSampler_6.y;
    } else {
      if ((_ColorChannelMapping == 2.0)) {
        MainTexColor_5 = MainTexSampler_6.z;
      } else {
        if ((_ColorChannelMapping == 3.0)) {
          MainTexColor_5 = MainTexSampler_6.w;
        };
      };
    };
  };
  MainTexAlpha_4 = 0.0;
  if ((_AlphaChannelMapping == 0.0)) {
    MainTexAlpha_4 = MainTexSampler_6.x;
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      MainTexAlpha_4 = MainTexSampler_6.y;
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        MainTexAlpha_4 = MainTexSampler_6.z;
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          MainTexAlpha_4 = MainTexSampler_6.w;
        };
      };
    };
  };
  ColorA_3 = _ColorA.xyz;
  if (bool(_UseVertexColor)) {
    ColorA_3 = xlv_COLOR.xyz;
  };
  ColorB_2 = _ColorB.xyz;
  if (bool(_UseCustomColor)) {
    ColorB_2 = xlv_TEXCOORD1.xyz;
  };
  highp vec3 tmpvar_16;
  tmpvar_16 = mix (ColorA_3, ColorB_2, vec3(clamp ((
    (_LerpBrightness * DissolveChannel_7)
   * MainTexColor_5), 0.0, 1.0)));
  o_10.xyz = (tmpvar_16 * _EmissionScaler);
  alpha_1 = 0.0;
  if (((DissolveChannel_7 * MainTexAlpha_4) <= (1.0 - xlv_COLOR.w))) {
    alpha_1 = 0.0;
  } else {
    alpha_1 = 1.0;
  };
  o_10.xyz = mix (vec3(1.0, 1.0, 1.0), o_10.xyz, vec3(alpha_1));
  o_10.xyz = mix (o_10.xyz, vec3(dot (o_10.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = o_10;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_NOISE_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _ColorChannelMapping;
uniform highp float _AlphaChannelMapping;
uniform highp float _UseVertexColor;
uniform mediump vec4 _ColorA;
uniform highp float _UseCustomColor;
uniform mediump vec4 _ColorB;
uniform highp float _LerpBrightness;
uniform sampler2D _DissolveTex;
uniform highp vec4 _DissolveTex_ST;
uniform highp float _DissolveChannelMapping;
uniform highp float _DissolveUSpeed;
uniform highp float _DissolveVSpeed;
uniform highp float _DissolveRandomRange;
uniform highp float _DissolveUVRandom;
uniform sampler2D _NoiseTex;
uniform highp vec4 _NoiseTex_ST;
uniform highp float _NoiseChannelMapping;
uniform highp float _NoiseUSpeed;
uniform highp float _NoiseVSpeed;
uniform highp float _NoiseRandomRange;
uniform highp float _NoiseBrightness;
uniform highp float _NoiseUVRandom;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float alpha_1;
  mediump vec3 ColorB_2;
  mediump vec3 ColorA_3;
  mediump float MainTexAlpha_4;
  mediump float MainTexColor_5;
  mediump vec4 MainTexSampler_6;
  mediump float DissolveChannel_7;
  mediump vec4 DissolveTexSampler_8;
  mediump float NoiseChannel_9;
  mediump vec4 NoiseTexSampler_10;
  highp vec2 NoiseTex_UV_11;
  highp vec2 DissolveTex_UV_12;
  mediump vec4 o_13;
  o_13 = vec4(1.0, 1.0, 1.0, 1.0);
  highp float tmpvar_14;
  tmpvar_14 = (((xlv_TEXCOORD1.w - 0.5) * abs(_DissolveRandomRange)) + 1.0);
  highp vec2 tmpvar_15;
  tmpvar_15.x = ((_Time.y * _DissolveUSpeed) * tmpvar_14);
  tmpvar_15.y = ((_Time.y * _DissolveVSpeed) * tmpvar_14);
  DissolveTex_UV_12 = (((xlv_TEXCOORD0.xy * _DissolveTex_ST.xy) + _DissolveTex_ST.zw) + tmpvar_15);
  if (bool(_DissolveUVRandom)) {
    DissolveTex_UV_12 = (DissolveTex_UV_12 + xlv_TEXCOORD0.zw);
  };
  highp float tmpvar_16;
  tmpvar_16 = (((xlv_TEXCOORD1.w - 0.5) * abs(_NoiseRandomRange)) + 1.0);
  highp vec2 tmpvar_17;
  tmpvar_17.x = ((_Time.y * _NoiseUSpeed) * tmpvar_16);
  tmpvar_17.y = ((_Time.y * _NoiseVSpeed) * tmpvar_16);
  NoiseTex_UV_11 = (((xlv_TEXCOORD0.xy * _NoiseTex_ST.xy) + _NoiseTex_ST.zw) + tmpvar_17);
  if (bool(_NoiseUVRandom)) {
    NoiseTex_UV_11 = (NoiseTex_UV_11 + xlv_TEXCOORD0.zw);
  };
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_NoiseTex, NoiseTex_UV_11);
  NoiseTexSampler_10 = tmpvar_18;
  NoiseChannel_9 = 0.0;
  if ((_NoiseChannelMapping == 0.0)) {
    NoiseChannel_9 = NoiseTexSampler_10.x;
  } else {
    if ((_NoiseChannelMapping == 1.0)) {
      NoiseChannel_9 = NoiseTexSampler_10.y;
    } else {
      if ((_NoiseChannelMapping == 2.0)) {
        NoiseChannel_9 = NoiseTexSampler_10.z;
      } else {
        if ((_NoiseChannelMapping == 3.0)) {
          NoiseChannel_9 = NoiseTexSampler_10.w;
        };
      };
    };
  };
  DissolveTex_UV_12 = (DissolveTex_UV_12 + ((
    (NoiseChannel_9 - 0.5)
   * 2.0) * _NoiseBrightness));
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_DissolveTex, DissolveTex_UV_12);
  DissolveTexSampler_8 = tmpvar_19;
  DissolveChannel_7 = 0.0;
  if ((_DissolveChannelMapping == 0.0)) {
    DissolveChannel_7 = DissolveTexSampler_8.x;
  } else {
    if ((_DissolveChannelMapping == 1.0)) {
      DissolveChannel_7 = DissolveTexSampler_8.y;
    } else {
      if ((_DissolveChannelMapping == 2.0)) {
        DissolveChannel_7 = DissolveTexSampler_8.z;
      } else {
        if ((_DissolveChannelMapping == 3.0)) {
          DissolveChannel_7 = DissolveTexSampler_8.w;
        };
      };
    };
  };
  highp vec2 tmpvar_20;
  tmpvar_20 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex, tmpvar_20);
  MainTexSampler_6 = tmpvar_21;
  MainTexColor_5 = 0.0;
  if ((_ColorChannelMapping == 0.0)) {
    MainTexColor_5 = MainTexSampler_6.x;
  } else {
    if ((_ColorChannelMapping == 1.0)) {
      MainTexColor_5 = MainTexSampler_6.y;
    } else {
      if ((_ColorChannelMapping == 2.0)) {
        MainTexColor_5 = MainTexSampler_6.z;
      } else {
        if ((_ColorChannelMapping == 3.0)) {
          MainTexColor_5 = MainTexSampler_6.w;
        };
      };
    };
  };
  MainTexAlpha_4 = 0.0;
  if ((_AlphaChannelMapping == 0.0)) {
    MainTexAlpha_4 = MainTexSampler_6.x;
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      MainTexAlpha_4 = MainTexSampler_6.y;
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        MainTexAlpha_4 = MainTexSampler_6.z;
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          MainTexAlpha_4 = MainTexSampler_6.w;
        };
      };
    };
  };
  ColorA_3 = _ColorA.xyz;
  if (bool(_UseVertexColor)) {
    ColorA_3 = xlv_COLOR.xyz;
  };
  ColorB_2 = _ColorB.xyz;
  if (bool(_UseCustomColor)) {
    ColorB_2 = xlv_TEXCOORD1.xyz;
  };
  highp vec3 tmpvar_22;
  tmpvar_22 = mix (ColorA_3, ColorB_2, vec3(clamp ((
    (_LerpBrightness * DissolveChannel_7)
   * MainTexColor_5), 0.0, 1.0)));
  o_13.xyz = (tmpvar_22 * _EmissionScaler);
  alpha_1 = 0.0;
  if (((DissolveChannel_7 * MainTexAlpha_4) <= (1.0 - xlv_COLOR.w))) {
    alpha_1 = 0.0;
  } else {
    alpha_1 = 1.0;
  };
  o_13.xyz = mix (vec3(1.0, 1.0, 1.0), o_13.xyz, vec3(alpha_1));
  gl_FragData[0] = o_13;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_NOISE_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _ColorChannelMapping;
uniform highp float _AlphaChannelMapping;
uniform highp float _UseVertexColor;
uniform mediump vec4 _ColorA;
uniform highp float _UseCustomColor;
uniform mediump vec4 _ColorB;
uniform highp float _LerpBrightness;
uniform sampler2D _DissolveTex;
uniform highp vec4 _DissolveTex_ST;
uniform highp float _DissolveChannelMapping;
uniform highp float _DissolveUSpeed;
uniform highp float _DissolveVSpeed;
uniform highp float _DissolveRandomRange;
uniform highp float _DissolveUVRandom;
uniform sampler2D _NoiseTex;
uniform highp vec4 _NoiseTex_ST;
uniform highp float _NoiseChannelMapping;
uniform highp float _NoiseUSpeed;
uniform highp float _NoiseVSpeed;
uniform highp float _NoiseRandomRange;
uniform highp float _NoiseBrightness;
uniform highp float _NoiseUVRandom;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float alpha_1;
  mediump vec3 ColorB_2;
  mediump vec3 ColorA_3;
  mediump float MainTexAlpha_4;
  mediump float MainTexColor_5;
  mediump vec4 MainTexSampler_6;
  mediump float DissolveChannel_7;
  mediump vec4 DissolveTexSampler_8;
  mediump float NoiseChannel_9;
  mediump vec4 NoiseTexSampler_10;
  highp vec2 NoiseTex_UV_11;
  highp vec2 DissolveTex_UV_12;
  mediump vec4 o_13;
  o_13 = vec4(1.0, 1.0, 1.0, 1.0);
  highp float tmpvar_14;
  tmpvar_14 = (((xlv_TEXCOORD1.w - 0.5) * abs(_DissolveRandomRange)) + 1.0);
  highp vec2 tmpvar_15;
  tmpvar_15.x = ((_Time.y * _DissolveUSpeed) * tmpvar_14);
  tmpvar_15.y = ((_Time.y * _DissolveVSpeed) * tmpvar_14);
  DissolveTex_UV_12 = (((xlv_TEXCOORD0.xy * _DissolveTex_ST.xy) + _DissolveTex_ST.zw) + tmpvar_15);
  if (bool(_DissolveUVRandom)) {
    DissolveTex_UV_12 = (DissolveTex_UV_12 + xlv_TEXCOORD0.zw);
  };
  highp float tmpvar_16;
  tmpvar_16 = (((xlv_TEXCOORD1.w - 0.5) * abs(_NoiseRandomRange)) + 1.0);
  highp vec2 tmpvar_17;
  tmpvar_17.x = ((_Time.y * _NoiseUSpeed) * tmpvar_16);
  tmpvar_17.y = ((_Time.y * _NoiseVSpeed) * tmpvar_16);
  NoiseTex_UV_11 = (((xlv_TEXCOORD0.xy * _NoiseTex_ST.xy) + _NoiseTex_ST.zw) + tmpvar_17);
  if (bool(_NoiseUVRandom)) {
    NoiseTex_UV_11 = (NoiseTex_UV_11 + xlv_TEXCOORD0.zw);
  };
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_NoiseTex, NoiseTex_UV_11);
  NoiseTexSampler_10 = tmpvar_18;
  NoiseChannel_9 = 0.0;
  if ((_NoiseChannelMapping == 0.0)) {
    NoiseChannel_9 = NoiseTexSampler_10.x;
  } else {
    if ((_NoiseChannelMapping == 1.0)) {
      NoiseChannel_9 = NoiseTexSampler_10.y;
    } else {
      if ((_NoiseChannelMapping == 2.0)) {
        NoiseChannel_9 = NoiseTexSampler_10.z;
      } else {
        if ((_NoiseChannelMapping == 3.0)) {
          NoiseChannel_9 = NoiseTexSampler_10.w;
        };
      };
    };
  };
  DissolveTex_UV_12 = (DissolveTex_UV_12 + ((
    (NoiseChannel_9 - 0.5)
   * 2.0) * _NoiseBrightness));
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_DissolveTex, DissolveTex_UV_12);
  DissolveTexSampler_8 = tmpvar_19;
  DissolveChannel_7 = 0.0;
  if ((_DissolveChannelMapping == 0.0)) {
    DissolveChannel_7 = DissolveTexSampler_8.x;
  } else {
    if ((_DissolveChannelMapping == 1.0)) {
      DissolveChannel_7 = DissolveTexSampler_8.y;
    } else {
      if ((_DissolveChannelMapping == 2.0)) {
        DissolveChannel_7 = DissolveTexSampler_8.z;
      } else {
        if ((_DissolveChannelMapping == 3.0)) {
          DissolveChannel_7 = DissolveTexSampler_8.w;
        };
      };
    };
  };
  highp vec2 tmpvar_20;
  tmpvar_20 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex, tmpvar_20);
  MainTexSampler_6 = tmpvar_21;
  MainTexColor_5 = 0.0;
  if ((_ColorChannelMapping == 0.0)) {
    MainTexColor_5 = MainTexSampler_6.x;
  } else {
    if ((_ColorChannelMapping == 1.0)) {
      MainTexColor_5 = MainTexSampler_6.y;
    } else {
      if ((_ColorChannelMapping == 2.0)) {
        MainTexColor_5 = MainTexSampler_6.z;
      } else {
        if ((_ColorChannelMapping == 3.0)) {
          MainTexColor_5 = MainTexSampler_6.w;
        };
      };
    };
  };
  MainTexAlpha_4 = 0.0;
  if ((_AlphaChannelMapping == 0.0)) {
    MainTexAlpha_4 = MainTexSampler_6.x;
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      MainTexAlpha_4 = MainTexSampler_6.y;
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        MainTexAlpha_4 = MainTexSampler_6.z;
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          MainTexAlpha_4 = MainTexSampler_6.w;
        };
      };
    };
  };
  ColorA_3 = _ColorA.xyz;
  if (bool(_UseVertexColor)) {
    ColorA_3 = xlv_COLOR.xyz;
  };
  ColorB_2 = _ColorB.xyz;
  if (bool(_UseCustomColor)) {
    ColorB_2 = xlv_TEXCOORD1.xyz;
  };
  highp vec3 tmpvar_22;
  tmpvar_22 = mix (ColorA_3, ColorB_2, vec3(clamp ((
    (_LerpBrightness * DissolveChannel_7)
   * MainTexColor_5), 0.0, 1.0)));
  o_13.xyz = (tmpvar_22 * _EmissionScaler);
  alpha_1 = 0.0;
  if (((DissolveChannel_7 * MainTexAlpha_4) <= (1.0 - xlv_COLOR.w))) {
    alpha_1 = 0.0;
  } else {
    alpha_1 = 1.0;
  };
  o_13.xyz = mix (vec3(1.0, 1.0, 1.0), o_13.xyz, vec3(alpha_1));
  gl_FragData[0] = o_13;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_NOISE_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _ColorChannelMapping;
uniform highp float _AlphaChannelMapping;
uniform highp float _UseVertexColor;
uniform mediump vec4 _ColorA;
uniform highp float _UseCustomColor;
uniform mediump vec4 _ColorB;
uniform highp float _LerpBrightness;
uniform sampler2D _DissolveTex;
uniform highp vec4 _DissolveTex_ST;
uniform highp float _DissolveChannelMapping;
uniform highp float _DissolveUSpeed;
uniform highp float _DissolveVSpeed;
uniform highp float _DissolveRandomRange;
uniform highp float _DissolveUVRandom;
uniform sampler2D _NoiseTex;
uniform highp vec4 _NoiseTex_ST;
uniform highp float _NoiseChannelMapping;
uniform highp float _NoiseUSpeed;
uniform highp float _NoiseVSpeed;
uniform highp float _NoiseRandomRange;
uniform highp float _NoiseBrightness;
uniform highp float _NoiseUVRandom;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float alpha_1;
  mediump vec3 ColorB_2;
  mediump vec3 ColorA_3;
  mediump float MainTexAlpha_4;
  mediump float MainTexColor_5;
  mediump vec4 MainTexSampler_6;
  mediump float DissolveChannel_7;
  mediump vec4 DissolveTexSampler_8;
  mediump float NoiseChannel_9;
  mediump vec4 NoiseTexSampler_10;
  highp vec2 NoiseTex_UV_11;
  highp vec2 DissolveTex_UV_12;
  mediump vec4 o_13;
  o_13 = vec4(1.0, 1.0, 1.0, 1.0);
  highp float tmpvar_14;
  tmpvar_14 = (((xlv_TEXCOORD1.w - 0.5) * abs(_DissolveRandomRange)) + 1.0);
  highp vec2 tmpvar_15;
  tmpvar_15.x = ((_Time.y * _DissolveUSpeed) * tmpvar_14);
  tmpvar_15.y = ((_Time.y * _DissolveVSpeed) * tmpvar_14);
  DissolveTex_UV_12 = (((xlv_TEXCOORD0.xy * _DissolveTex_ST.xy) + _DissolveTex_ST.zw) + tmpvar_15);
  if (bool(_DissolveUVRandom)) {
    DissolveTex_UV_12 = (DissolveTex_UV_12 + xlv_TEXCOORD0.zw);
  };
  highp float tmpvar_16;
  tmpvar_16 = (((xlv_TEXCOORD1.w - 0.5) * abs(_NoiseRandomRange)) + 1.0);
  highp vec2 tmpvar_17;
  tmpvar_17.x = ((_Time.y * _NoiseUSpeed) * tmpvar_16);
  tmpvar_17.y = ((_Time.y * _NoiseVSpeed) * tmpvar_16);
  NoiseTex_UV_11 = (((xlv_TEXCOORD0.xy * _NoiseTex_ST.xy) + _NoiseTex_ST.zw) + tmpvar_17);
  if (bool(_NoiseUVRandom)) {
    NoiseTex_UV_11 = (NoiseTex_UV_11 + xlv_TEXCOORD0.zw);
  };
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_NoiseTex, NoiseTex_UV_11);
  NoiseTexSampler_10 = tmpvar_18;
  NoiseChannel_9 = 0.0;
  if ((_NoiseChannelMapping == 0.0)) {
    NoiseChannel_9 = NoiseTexSampler_10.x;
  } else {
    if ((_NoiseChannelMapping == 1.0)) {
      NoiseChannel_9 = NoiseTexSampler_10.y;
    } else {
      if ((_NoiseChannelMapping == 2.0)) {
        NoiseChannel_9 = NoiseTexSampler_10.z;
      } else {
        if ((_NoiseChannelMapping == 3.0)) {
          NoiseChannel_9 = NoiseTexSampler_10.w;
        };
      };
    };
  };
  DissolveTex_UV_12 = (DissolveTex_UV_12 + ((
    (NoiseChannel_9 - 0.5)
   * 2.0) * _NoiseBrightness));
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_DissolveTex, DissolveTex_UV_12);
  DissolveTexSampler_8 = tmpvar_19;
  DissolveChannel_7 = 0.0;
  if ((_DissolveChannelMapping == 0.0)) {
    DissolveChannel_7 = DissolveTexSampler_8.x;
  } else {
    if ((_DissolveChannelMapping == 1.0)) {
      DissolveChannel_7 = DissolveTexSampler_8.y;
    } else {
      if ((_DissolveChannelMapping == 2.0)) {
        DissolveChannel_7 = DissolveTexSampler_8.z;
      } else {
        if ((_DissolveChannelMapping == 3.0)) {
          DissolveChannel_7 = DissolveTexSampler_8.w;
        };
      };
    };
  };
  highp vec2 tmpvar_20;
  tmpvar_20 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex, tmpvar_20);
  MainTexSampler_6 = tmpvar_21;
  MainTexColor_5 = 0.0;
  if ((_ColorChannelMapping == 0.0)) {
    MainTexColor_5 = MainTexSampler_6.x;
  } else {
    if ((_ColorChannelMapping == 1.0)) {
      MainTexColor_5 = MainTexSampler_6.y;
    } else {
      if ((_ColorChannelMapping == 2.0)) {
        MainTexColor_5 = MainTexSampler_6.z;
      } else {
        if ((_ColorChannelMapping == 3.0)) {
          MainTexColor_5 = MainTexSampler_6.w;
        };
      };
    };
  };
  MainTexAlpha_4 = 0.0;
  if ((_AlphaChannelMapping == 0.0)) {
    MainTexAlpha_4 = MainTexSampler_6.x;
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      MainTexAlpha_4 = MainTexSampler_6.y;
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        MainTexAlpha_4 = MainTexSampler_6.z;
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          MainTexAlpha_4 = MainTexSampler_6.w;
        };
      };
    };
  };
  ColorA_3 = _ColorA.xyz;
  if (bool(_UseVertexColor)) {
    ColorA_3 = xlv_COLOR.xyz;
  };
  ColorB_2 = _ColorB.xyz;
  if (bool(_UseCustomColor)) {
    ColorB_2 = xlv_TEXCOORD1.xyz;
  };
  highp vec3 tmpvar_22;
  tmpvar_22 = mix (ColorA_3, ColorB_2, vec3(clamp ((
    (_LerpBrightness * DissolveChannel_7)
   * MainTexColor_5), 0.0, 1.0)));
  o_13.xyz = (tmpvar_22 * _EmissionScaler);
  alpha_1 = 0.0;
  if (((DissolveChannel_7 * MainTexAlpha_4) <= (1.0 - xlv_COLOR.w))) {
    alpha_1 = 0.0;
  } else {
    alpha_1 = 1.0;
  };
  o_13.xyz = mix (vec3(1.0, 1.0, 1.0), o_13.xyz, vec3(alpha_1));
  gl_FragData[0] = o_13;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_NOISE_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _ColorChannelMapping;
uniform highp float _AlphaChannelMapping;
uniform highp float _UseVertexColor;
uniform mediump vec4 _ColorA;
uniform highp float _UseCustomColor;
uniform mediump vec4 _ColorB;
uniform highp float _LerpBrightness;
uniform sampler2D _DissolveTex;
uniform highp vec4 _DissolveTex_ST;
uniform highp float _DissolveChannelMapping;
uniform highp float _DissolveUSpeed;
uniform highp float _DissolveVSpeed;
uniform highp float _DissolveRandomRange;
uniform highp float _DissolveUVRandom;
uniform sampler2D _NoiseTex;
uniform highp vec4 _NoiseTex_ST;
uniform highp float _NoiseChannelMapping;
uniform highp float _NoiseUSpeed;
uniform highp float _NoiseVSpeed;
uniform highp float _NoiseRandomRange;
uniform highp float _NoiseBrightness;
uniform highp float _NoiseUVRandom;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float alpha_1;
  mediump vec3 ColorB_2;
  mediump vec3 ColorA_3;
  mediump float MainTexAlpha_4;
  mediump float MainTexColor_5;
  mediump vec4 MainTexSampler_6;
  mediump float DissolveChannel_7;
  mediump vec4 DissolveTexSampler_8;
  mediump float NoiseChannel_9;
  mediump vec4 NoiseTexSampler_10;
  highp vec2 NoiseTex_UV_11;
  highp vec2 DissolveTex_UV_12;
  mediump vec4 o_13;
  o_13 = vec4(1.0, 1.0, 1.0, 1.0);
  highp float tmpvar_14;
  tmpvar_14 = (((xlv_TEXCOORD1.w - 0.5) * abs(_DissolveRandomRange)) + 1.0);
  highp vec2 tmpvar_15;
  tmpvar_15.x = ((_Time.y * _DissolveUSpeed) * tmpvar_14);
  tmpvar_15.y = ((_Time.y * _DissolveVSpeed) * tmpvar_14);
  DissolveTex_UV_12 = (((xlv_TEXCOORD0.xy * _DissolveTex_ST.xy) + _DissolveTex_ST.zw) + tmpvar_15);
  if (bool(_DissolveUVRandom)) {
    DissolveTex_UV_12 = (DissolveTex_UV_12 + xlv_TEXCOORD0.zw);
  };
  highp float tmpvar_16;
  tmpvar_16 = (((xlv_TEXCOORD1.w - 0.5) * abs(_NoiseRandomRange)) + 1.0);
  highp vec2 tmpvar_17;
  tmpvar_17.x = ((_Time.y * _NoiseUSpeed) * tmpvar_16);
  tmpvar_17.y = ((_Time.y * _NoiseVSpeed) * tmpvar_16);
  NoiseTex_UV_11 = (((xlv_TEXCOORD0.xy * _NoiseTex_ST.xy) + _NoiseTex_ST.zw) + tmpvar_17);
  if (bool(_NoiseUVRandom)) {
    NoiseTex_UV_11 = (NoiseTex_UV_11 + xlv_TEXCOORD0.zw);
  };
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_NoiseTex, NoiseTex_UV_11);
  NoiseTexSampler_10 = tmpvar_18;
  NoiseChannel_9 = 0.0;
  if ((_NoiseChannelMapping == 0.0)) {
    NoiseChannel_9 = NoiseTexSampler_10.x;
  } else {
    if ((_NoiseChannelMapping == 1.0)) {
      NoiseChannel_9 = NoiseTexSampler_10.y;
    } else {
      if ((_NoiseChannelMapping == 2.0)) {
        NoiseChannel_9 = NoiseTexSampler_10.z;
      } else {
        if ((_NoiseChannelMapping == 3.0)) {
          NoiseChannel_9 = NoiseTexSampler_10.w;
        };
      };
    };
  };
  DissolveTex_UV_12 = (DissolveTex_UV_12 + ((
    (NoiseChannel_9 - 0.5)
   * 2.0) * _NoiseBrightness));
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_DissolveTex, DissolveTex_UV_12);
  DissolveTexSampler_8 = tmpvar_19;
  DissolveChannel_7 = 0.0;
  if ((_DissolveChannelMapping == 0.0)) {
    DissolveChannel_7 = DissolveTexSampler_8.x;
  } else {
    if ((_DissolveChannelMapping == 1.0)) {
      DissolveChannel_7 = DissolveTexSampler_8.y;
    } else {
      if ((_DissolveChannelMapping == 2.0)) {
        DissolveChannel_7 = DissolveTexSampler_8.z;
      } else {
        if ((_DissolveChannelMapping == 3.0)) {
          DissolveChannel_7 = DissolveTexSampler_8.w;
        };
      };
    };
  };
  highp vec2 tmpvar_20;
  tmpvar_20 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex, tmpvar_20);
  MainTexSampler_6 = tmpvar_21;
  MainTexColor_5 = 0.0;
  if ((_ColorChannelMapping == 0.0)) {
    MainTexColor_5 = MainTexSampler_6.x;
  } else {
    if ((_ColorChannelMapping == 1.0)) {
      MainTexColor_5 = MainTexSampler_6.y;
    } else {
      if ((_ColorChannelMapping == 2.0)) {
        MainTexColor_5 = MainTexSampler_6.z;
      } else {
        if ((_ColorChannelMapping == 3.0)) {
          MainTexColor_5 = MainTexSampler_6.w;
        };
      };
    };
  };
  MainTexAlpha_4 = 0.0;
  if ((_AlphaChannelMapping == 0.0)) {
    MainTexAlpha_4 = MainTexSampler_6.x;
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      MainTexAlpha_4 = MainTexSampler_6.y;
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        MainTexAlpha_4 = MainTexSampler_6.z;
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          MainTexAlpha_4 = MainTexSampler_6.w;
        };
      };
    };
  };
  ColorA_3 = _ColorA.xyz;
  if (bool(_UseVertexColor)) {
    ColorA_3 = xlv_COLOR.xyz;
  };
  ColorB_2 = _ColorB.xyz;
  if (bool(_UseCustomColor)) {
    ColorB_2 = xlv_TEXCOORD1.xyz;
  };
  highp vec3 tmpvar_22;
  tmpvar_22 = mix (ColorA_3, ColorB_2, vec3(clamp ((
    (_LerpBrightness * DissolveChannel_7)
   * MainTexColor_5), 0.0, 1.0)));
  o_13.xyz = (tmpvar_22 * _EmissionScaler);
  alpha_1 = 0.0;
  if (((DissolveChannel_7 * MainTexAlpha_4) <= (1.0 - xlv_COLOR.w))) {
    alpha_1 = 0.0;
  } else {
    alpha_1 = 1.0;
  };
  o_13.xyz = mix (vec3(1.0, 1.0, 1.0), o_13.xyz, vec3(alpha_1));
  o_13.xyz = mix (o_13.xyz, vec3(dot (o_13.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = o_13;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_NOISE_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _ColorChannelMapping;
uniform highp float _AlphaChannelMapping;
uniform highp float _UseVertexColor;
uniform mediump vec4 _ColorA;
uniform highp float _UseCustomColor;
uniform mediump vec4 _ColorB;
uniform highp float _LerpBrightness;
uniform sampler2D _DissolveTex;
uniform highp vec4 _DissolveTex_ST;
uniform highp float _DissolveChannelMapping;
uniform highp float _DissolveUSpeed;
uniform highp float _DissolveVSpeed;
uniform highp float _DissolveRandomRange;
uniform highp float _DissolveUVRandom;
uniform sampler2D _NoiseTex;
uniform highp vec4 _NoiseTex_ST;
uniform highp float _NoiseChannelMapping;
uniform highp float _NoiseUSpeed;
uniform highp float _NoiseVSpeed;
uniform highp float _NoiseRandomRange;
uniform highp float _NoiseBrightness;
uniform highp float _NoiseUVRandom;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float alpha_1;
  mediump vec3 ColorB_2;
  mediump vec3 ColorA_3;
  mediump float MainTexAlpha_4;
  mediump float MainTexColor_5;
  mediump vec4 MainTexSampler_6;
  mediump float DissolveChannel_7;
  mediump vec4 DissolveTexSampler_8;
  mediump float NoiseChannel_9;
  mediump vec4 NoiseTexSampler_10;
  highp vec2 NoiseTex_UV_11;
  highp vec2 DissolveTex_UV_12;
  mediump vec4 o_13;
  o_13 = vec4(1.0, 1.0, 1.0, 1.0);
  highp float tmpvar_14;
  tmpvar_14 = (((xlv_TEXCOORD1.w - 0.5) * abs(_DissolveRandomRange)) + 1.0);
  highp vec2 tmpvar_15;
  tmpvar_15.x = ((_Time.y * _DissolveUSpeed) * tmpvar_14);
  tmpvar_15.y = ((_Time.y * _DissolveVSpeed) * tmpvar_14);
  DissolveTex_UV_12 = (((xlv_TEXCOORD0.xy * _DissolveTex_ST.xy) + _DissolveTex_ST.zw) + tmpvar_15);
  if (bool(_DissolveUVRandom)) {
    DissolveTex_UV_12 = (DissolveTex_UV_12 + xlv_TEXCOORD0.zw);
  };
  highp float tmpvar_16;
  tmpvar_16 = (((xlv_TEXCOORD1.w - 0.5) * abs(_NoiseRandomRange)) + 1.0);
  highp vec2 tmpvar_17;
  tmpvar_17.x = ((_Time.y * _NoiseUSpeed) * tmpvar_16);
  tmpvar_17.y = ((_Time.y * _NoiseVSpeed) * tmpvar_16);
  NoiseTex_UV_11 = (((xlv_TEXCOORD0.xy * _NoiseTex_ST.xy) + _NoiseTex_ST.zw) + tmpvar_17);
  if (bool(_NoiseUVRandom)) {
    NoiseTex_UV_11 = (NoiseTex_UV_11 + xlv_TEXCOORD0.zw);
  };
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_NoiseTex, NoiseTex_UV_11);
  NoiseTexSampler_10 = tmpvar_18;
  NoiseChannel_9 = 0.0;
  if ((_NoiseChannelMapping == 0.0)) {
    NoiseChannel_9 = NoiseTexSampler_10.x;
  } else {
    if ((_NoiseChannelMapping == 1.0)) {
      NoiseChannel_9 = NoiseTexSampler_10.y;
    } else {
      if ((_NoiseChannelMapping == 2.0)) {
        NoiseChannel_9 = NoiseTexSampler_10.z;
      } else {
        if ((_NoiseChannelMapping == 3.0)) {
          NoiseChannel_9 = NoiseTexSampler_10.w;
        };
      };
    };
  };
  DissolveTex_UV_12 = (DissolveTex_UV_12 + ((
    (NoiseChannel_9 - 0.5)
   * 2.0) * _NoiseBrightness));
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_DissolveTex, DissolveTex_UV_12);
  DissolveTexSampler_8 = tmpvar_19;
  DissolveChannel_7 = 0.0;
  if ((_DissolveChannelMapping == 0.0)) {
    DissolveChannel_7 = DissolveTexSampler_8.x;
  } else {
    if ((_DissolveChannelMapping == 1.0)) {
      DissolveChannel_7 = DissolveTexSampler_8.y;
    } else {
      if ((_DissolveChannelMapping == 2.0)) {
        DissolveChannel_7 = DissolveTexSampler_8.z;
      } else {
        if ((_DissolveChannelMapping == 3.0)) {
          DissolveChannel_7 = DissolveTexSampler_8.w;
        };
      };
    };
  };
  highp vec2 tmpvar_20;
  tmpvar_20 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex, tmpvar_20);
  MainTexSampler_6 = tmpvar_21;
  MainTexColor_5 = 0.0;
  if ((_ColorChannelMapping == 0.0)) {
    MainTexColor_5 = MainTexSampler_6.x;
  } else {
    if ((_ColorChannelMapping == 1.0)) {
      MainTexColor_5 = MainTexSampler_6.y;
    } else {
      if ((_ColorChannelMapping == 2.0)) {
        MainTexColor_5 = MainTexSampler_6.z;
      } else {
        if ((_ColorChannelMapping == 3.0)) {
          MainTexColor_5 = MainTexSampler_6.w;
        };
      };
    };
  };
  MainTexAlpha_4 = 0.0;
  if ((_AlphaChannelMapping == 0.0)) {
    MainTexAlpha_4 = MainTexSampler_6.x;
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      MainTexAlpha_4 = MainTexSampler_6.y;
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        MainTexAlpha_4 = MainTexSampler_6.z;
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          MainTexAlpha_4 = MainTexSampler_6.w;
        };
      };
    };
  };
  ColorA_3 = _ColorA.xyz;
  if (bool(_UseVertexColor)) {
    ColorA_3 = xlv_COLOR.xyz;
  };
  ColorB_2 = _ColorB.xyz;
  if (bool(_UseCustomColor)) {
    ColorB_2 = xlv_TEXCOORD1.xyz;
  };
  highp vec3 tmpvar_22;
  tmpvar_22 = mix (ColorA_3, ColorB_2, vec3(clamp ((
    (_LerpBrightness * DissolveChannel_7)
   * MainTexColor_5), 0.0, 1.0)));
  o_13.xyz = (tmpvar_22 * _EmissionScaler);
  alpha_1 = 0.0;
  if (((DissolveChannel_7 * MainTexAlpha_4) <= (1.0 - xlv_COLOR.w))) {
    alpha_1 = 0.0;
  } else {
    alpha_1 = 1.0;
  };
  o_13.xyz = mix (vec3(1.0, 1.0, 1.0), o_13.xyz, vec3(alpha_1));
  o_13.xyz = mix (o_13.xyz, vec3(dot (o_13.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = o_13;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_NOISE_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _ColorChannelMapping;
uniform highp float _AlphaChannelMapping;
uniform highp float _UseVertexColor;
uniform mediump vec4 _ColorA;
uniform highp float _UseCustomColor;
uniform mediump vec4 _ColorB;
uniform highp float _LerpBrightness;
uniform sampler2D _DissolveTex;
uniform highp vec4 _DissolveTex_ST;
uniform highp float _DissolveChannelMapping;
uniform highp float _DissolveUSpeed;
uniform highp float _DissolveVSpeed;
uniform highp float _DissolveRandomRange;
uniform highp float _DissolveUVRandom;
uniform sampler2D _NoiseTex;
uniform highp vec4 _NoiseTex_ST;
uniform highp float _NoiseChannelMapping;
uniform highp float _NoiseUSpeed;
uniform highp float _NoiseVSpeed;
uniform highp float _NoiseRandomRange;
uniform highp float _NoiseBrightness;
uniform highp float _NoiseUVRandom;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float alpha_1;
  mediump vec3 ColorB_2;
  mediump vec3 ColorA_3;
  mediump float MainTexAlpha_4;
  mediump float MainTexColor_5;
  mediump vec4 MainTexSampler_6;
  mediump float DissolveChannel_7;
  mediump vec4 DissolveTexSampler_8;
  mediump float NoiseChannel_9;
  mediump vec4 NoiseTexSampler_10;
  highp vec2 NoiseTex_UV_11;
  highp vec2 DissolveTex_UV_12;
  mediump vec4 o_13;
  o_13 = vec4(1.0, 1.0, 1.0, 1.0);
  highp float tmpvar_14;
  tmpvar_14 = (((xlv_TEXCOORD1.w - 0.5) * abs(_DissolveRandomRange)) + 1.0);
  highp vec2 tmpvar_15;
  tmpvar_15.x = ((_Time.y * _DissolveUSpeed) * tmpvar_14);
  tmpvar_15.y = ((_Time.y * _DissolveVSpeed) * tmpvar_14);
  DissolveTex_UV_12 = (((xlv_TEXCOORD0.xy * _DissolveTex_ST.xy) + _DissolveTex_ST.zw) + tmpvar_15);
  if (bool(_DissolveUVRandom)) {
    DissolveTex_UV_12 = (DissolveTex_UV_12 + xlv_TEXCOORD0.zw);
  };
  highp float tmpvar_16;
  tmpvar_16 = (((xlv_TEXCOORD1.w - 0.5) * abs(_NoiseRandomRange)) + 1.0);
  highp vec2 tmpvar_17;
  tmpvar_17.x = ((_Time.y * _NoiseUSpeed) * tmpvar_16);
  tmpvar_17.y = ((_Time.y * _NoiseVSpeed) * tmpvar_16);
  NoiseTex_UV_11 = (((xlv_TEXCOORD0.xy * _NoiseTex_ST.xy) + _NoiseTex_ST.zw) + tmpvar_17);
  if (bool(_NoiseUVRandom)) {
    NoiseTex_UV_11 = (NoiseTex_UV_11 + xlv_TEXCOORD0.zw);
  };
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_NoiseTex, NoiseTex_UV_11);
  NoiseTexSampler_10 = tmpvar_18;
  NoiseChannel_9 = 0.0;
  if ((_NoiseChannelMapping == 0.0)) {
    NoiseChannel_9 = NoiseTexSampler_10.x;
  } else {
    if ((_NoiseChannelMapping == 1.0)) {
      NoiseChannel_9 = NoiseTexSampler_10.y;
    } else {
      if ((_NoiseChannelMapping == 2.0)) {
        NoiseChannel_9 = NoiseTexSampler_10.z;
      } else {
        if ((_NoiseChannelMapping == 3.0)) {
          NoiseChannel_9 = NoiseTexSampler_10.w;
        };
      };
    };
  };
  DissolveTex_UV_12 = (DissolveTex_UV_12 + ((
    (NoiseChannel_9 - 0.5)
   * 2.0) * _NoiseBrightness));
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_DissolveTex, DissolveTex_UV_12);
  DissolveTexSampler_8 = tmpvar_19;
  DissolveChannel_7 = 0.0;
  if ((_DissolveChannelMapping == 0.0)) {
    DissolveChannel_7 = DissolveTexSampler_8.x;
  } else {
    if ((_DissolveChannelMapping == 1.0)) {
      DissolveChannel_7 = DissolveTexSampler_8.y;
    } else {
      if ((_DissolveChannelMapping == 2.0)) {
        DissolveChannel_7 = DissolveTexSampler_8.z;
      } else {
        if ((_DissolveChannelMapping == 3.0)) {
          DissolveChannel_7 = DissolveTexSampler_8.w;
        };
      };
    };
  };
  highp vec2 tmpvar_20;
  tmpvar_20 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex, tmpvar_20);
  MainTexSampler_6 = tmpvar_21;
  MainTexColor_5 = 0.0;
  if ((_ColorChannelMapping == 0.0)) {
    MainTexColor_5 = MainTexSampler_6.x;
  } else {
    if ((_ColorChannelMapping == 1.0)) {
      MainTexColor_5 = MainTexSampler_6.y;
    } else {
      if ((_ColorChannelMapping == 2.0)) {
        MainTexColor_5 = MainTexSampler_6.z;
      } else {
        if ((_ColorChannelMapping == 3.0)) {
          MainTexColor_5 = MainTexSampler_6.w;
        };
      };
    };
  };
  MainTexAlpha_4 = 0.0;
  if ((_AlphaChannelMapping == 0.0)) {
    MainTexAlpha_4 = MainTexSampler_6.x;
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      MainTexAlpha_4 = MainTexSampler_6.y;
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        MainTexAlpha_4 = MainTexSampler_6.z;
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          MainTexAlpha_4 = MainTexSampler_6.w;
        };
      };
    };
  };
  ColorA_3 = _ColorA.xyz;
  if (bool(_UseVertexColor)) {
    ColorA_3 = xlv_COLOR.xyz;
  };
  ColorB_2 = _ColorB.xyz;
  if (bool(_UseCustomColor)) {
    ColorB_2 = xlv_TEXCOORD1.xyz;
  };
  highp vec3 tmpvar_22;
  tmpvar_22 = mix (ColorA_3, ColorB_2, vec3(clamp ((
    (_LerpBrightness * DissolveChannel_7)
   * MainTexColor_5), 0.0, 1.0)));
  o_13.xyz = (tmpvar_22 * _EmissionScaler);
  alpha_1 = 0.0;
  if (((DissolveChannel_7 * MainTexAlpha_4) <= (1.0 - xlv_COLOR.w))) {
    alpha_1 = 0.0;
  } else {
    alpha_1 = 1.0;
  };
  o_13.xyz = mix (vec3(1.0, 1.0, 1.0), o_13.xyz, vec3(alpha_1));
  o_13.xyz = mix (o_13.xyz, vec3(dot (o_13.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = o_13;
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
SubProgram "gles hw_tier00 " {
Keywords { "_NOISE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_NOISE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_NOISE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_NOISE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_NOISE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_NOISE_ON" }
""
}
}
}
 Pass {
  Name "CONSTANT_MAX"
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 79406
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _AlphaChannelMapping;
uniform sampler2D _DissolveTex;
uniform highp vec4 _DissolveTex_ST;
uniform highp float _DissolveChannelMapping;
uniform highp float _DissolveUSpeed;
uniform highp float _DissolveVSpeed;
uniform highp float _DissolveRandomRange;
uniform highp float _DissolveUVRandom;
uniform highp float _BloomFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float MainTexAlpha_1;
  mediump vec4 MainTexSampler_2;
  mediump float DissolveChannel_3;
  mediump vec4 DissolveTexSampler_4;
  highp vec2 DissolveTex_UV_5;
  mediump vec4 o_6;
  o_6 = vec4(0.0, 0.0, 0.0, 0.0);
  highp float tmpvar_7;
  tmpvar_7 = (((xlv_TEXCOORD1.w - 0.5) * abs(_DissolveRandomRange)) + 1.0);
  highp vec2 tmpvar_8;
  tmpvar_8.x = ((_Time.y * _DissolveUSpeed) * tmpvar_7);
  tmpvar_8.y = ((_Time.y * _DissolveVSpeed) * tmpvar_7);
  DissolveTex_UV_5 = (((xlv_TEXCOORD0.xy * _DissolveTex_ST.xy) + _DissolveTex_ST.zw) + tmpvar_8);
  if (bool(_DissolveUVRandom)) {
    DissolveTex_UV_5 = (DissolveTex_UV_5 + xlv_TEXCOORD0.zw);
  };
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_DissolveTex, DissolveTex_UV_5);
  DissolveTexSampler_4 = tmpvar_9;
  DissolveChannel_3 = 0.0;
  if ((_DissolveChannelMapping == 0.0)) {
    DissolveChannel_3 = DissolveTexSampler_4.x;
  } else {
    if ((_DissolveChannelMapping == 1.0)) {
      DissolveChannel_3 = DissolveTexSampler_4.y;
    } else {
      if ((_DissolveChannelMapping == 2.0)) {
        DissolveChannel_3 = DissolveTexSampler_4.z;
      } else {
        if ((_DissolveChannelMapping == 3.0)) {
          DissolveChannel_3 = DissolveTexSampler_4.w;
        };
      };
    };
  };
  highp vec2 tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, tmpvar_10);
  MainTexSampler_2 = tmpvar_11;
  MainTexAlpha_1 = 0.0;
  if ((_AlphaChannelMapping == 0.0)) {
    MainTexAlpha_1 = MainTexSampler_2.x;
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      MainTexAlpha_1 = MainTexSampler_2.y;
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        MainTexAlpha_1 = MainTexSampler_2.z;
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          MainTexAlpha_1 = MainTexSampler_2.w;
        };
      };
    };
  };
  o_6.w = ((DissolveChannel_3 * MainTexAlpha_1) * xlv_COLOR.w);
  o_6.w = (o_6.w * _BloomFactor);
  gl_FragData[0] = o_6;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _AlphaChannelMapping;
uniform sampler2D _DissolveTex;
uniform highp vec4 _DissolveTex_ST;
uniform highp float _DissolveChannelMapping;
uniform highp float _DissolveUSpeed;
uniform highp float _DissolveVSpeed;
uniform highp float _DissolveRandomRange;
uniform highp float _DissolveUVRandom;
uniform highp float _BloomFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float MainTexAlpha_1;
  mediump vec4 MainTexSampler_2;
  mediump float DissolveChannel_3;
  mediump vec4 DissolveTexSampler_4;
  highp vec2 DissolveTex_UV_5;
  mediump vec4 o_6;
  o_6 = vec4(0.0, 0.0, 0.0, 0.0);
  highp float tmpvar_7;
  tmpvar_7 = (((xlv_TEXCOORD1.w - 0.5) * abs(_DissolveRandomRange)) + 1.0);
  highp vec2 tmpvar_8;
  tmpvar_8.x = ((_Time.y * _DissolveUSpeed) * tmpvar_7);
  tmpvar_8.y = ((_Time.y * _DissolveVSpeed) * tmpvar_7);
  DissolveTex_UV_5 = (((xlv_TEXCOORD0.xy * _DissolveTex_ST.xy) + _DissolveTex_ST.zw) + tmpvar_8);
  if (bool(_DissolveUVRandom)) {
    DissolveTex_UV_5 = (DissolveTex_UV_5 + xlv_TEXCOORD0.zw);
  };
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_DissolveTex, DissolveTex_UV_5);
  DissolveTexSampler_4 = tmpvar_9;
  DissolveChannel_3 = 0.0;
  if ((_DissolveChannelMapping == 0.0)) {
    DissolveChannel_3 = DissolveTexSampler_4.x;
  } else {
    if ((_DissolveChannelMapping == 1.0)) {
      DissolveChannel_3 = DissolveTexSampler_4.y;
    } else {
      if ((_DissolveChannelMapping == 2.0)) {
        DissolveChannel_3 = DissolveTexSampler_4.z;
      } else {
        if ((_DissolveChannelMapping == 3.0)) {
          DissolveChannel_3 = DissolveTexSampler_4.w;
        };
      };
    };
  };
  highp vec2 tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, tmpvar_10);
  MainTexSampler_2 = tmpvar_11;
  MainTexAlpha_1 = 0.0;
  if ((_AlphaChannelMapping == 0.0)) {
    MainTexAlpha_1 = MainTexSampler_2.x;
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      MainTexAlpha_1 = MainTexSampler_2.y;
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        MainTexAlpha_1 = MainTexSampler_2.z;
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          MainTexAlpha_1 = MainTexSampler_2.w;
        };
      };
    };
  };
  o_6.w = ((DissolveChannel_3 * MainTexAlpha_1) * xlv_COLOR.w);
  o_6.w = (o_6.w * _BloomFactor);
  gl_FragData[0] = o_6;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _AlphaChannelMapping;
uniform sampler2D _DissolveTex;
uniform highp vec4 _DissolveTex_ST;
uniform highp float _DissolveChannelMapping;
uniform highp float _DissolveUSpeed;
uniform highp float _DissolveVSpeed;
uniform highp float _DissolveRandomRange;
uniform highp float _DissolveUVRandom;
uniform highp float _BloomFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float MainTexAlpha_1;
  mediump vec4 MainTexSampler_2;
  mediump float DissolveChannel_3;
  mediump vec4 DissolveTexSampler_4;
  highp vec2 DissolveTex_UV_5;
  mediump vec4 o_6;
  o_6 = vec4(0.0, 0.0, 0.0, 0.0);
  highp float tmpvar_7;
  tmpvar_7 = (((xlv_TEXCOORD1.w - 0.5) * abs(_DissolveRandomRange)) + 1.0);
  highp vec2 tmpvar_8;
  tmpvar_8.x = ((_Time.y * _DissolveUSpeed) * tmpvar_7);
  tmpvar_8.y = ((_Time.y * _DissolveVSpeed) * tmpvar_7);
  DissolveTex_UV_5 = (((xlv_TEXCOORD0.xy * _DissolveTex_ST.xy) + _DissolveTex_ST.zw) + tmpvar_8);
  if (bool(_DissolveUVRandom)) {
    DissolveTex_UV_5 = (DissolveTex_UV_5 + xlv_TEXCOORD0.zw);
  };
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_DissolveTex, DissolveTex_UV_5);
  DissolveTexSampler_4 = tmpvar_9;
  DissolveChannel_3 = 0.0;
  if ((_DissolveChannelMapping == 0.0)) {
    DissolveChannel_3 = DissolveTexSampler_4.x;
  } else {
    if ((_DissolveChannelMapping == 1.0)) {
      DissolveChannel_3 = DissolveTexSampler_4.y;
    } else {
      if ((_DissolveChannelMapping == 2.0)) {
        DissolveChannel_3 = DissolveTexSampler_4.z;
      } else {
        if ((_DissolveChannelMapping == 3.0)) {
          DissolveChannel_3 = DissolveTexSampler_4.w;
        };
      };
    };
  };
  highp vec2 tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, tmpvar_10);
  MainTexSampler_2 = tmpvar_11;
  MainTexAlpha_1 = 0.0;
  if ((_AlphaChannelMapping == 0.0)) {
    MainTexAlpha_1 = MainTexSampler_2.x;
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      MainTexAlpha_1 = MainTexSampler_2.y;
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        MainTexAlpha_1 = MainTexSampler_2.z;
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          MainTexAlpha_1 = MainTexSampler_2.w;
        };
      };
    };
  };
  o_6.w = ((DissolveChannel_3 * MainTexAlpha_1) * xlv_COLOR.w);
  o_6.w = (o_6.w * _BloomFactor);
  gl_FragData[0] = o_6;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_NOISE_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _AlphaChannelMapping;
uniform sampler2D _DissolveTex;
uniform highp vec4 _DissolveTex_ST;
uniform highp float _DissolveChannelMapping;
uniform highp float _DissolveUSpeed;
uniform highp float _DissolveVSpeed;
uniform highp float _DissolveRandomRange;
uniform highp float _DissolveUVRandom;
uniform sampler2D _NoiseTex;
uniform highp vec4 _NoiseTex_ST;
uniform highp float _NoiseChannelMapping;
uniform highp float _NoiseUSpeed;
uniform highp float _NoiseVSpeed;
uniform highp float _NoiseRandomRange;
uniform highp float _NoiseUVRandom;
uniform highp float _NoiseBrightness;
uniform highp float _BloomFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float MainTexAlpha_1;
  mediump vec4 MainTexSampler_2;
  mediump float DissolveChannel_3;
  mediump vec4 DissolveTexSampler_4;
  mediump float NoiseChannel_5;
  mediump vec4 NoiseTexSampler_6;
  highp vec2 NoiseTex_UV_7;
  highp vec2 DissolveTex_UV_8;
  mediump vec4 o_9;
  o_9 = vec4(0.0, 0.0, 0.0, 0.0);
  highp float tmpvar_10;
  tmpvar_10 = (((xlv_TEXCOORD1.w - 0.5) * abs(_DissolveRandomRange)) + 1.0);
  highp vec2 tmpvar_11;
  tmpvar_11.x = ((_Time.y * _DissolveUSpeed) * tmpvar_10);
  tmpvar_11.y = ((_Time.y * _DissolveVSpeed) * tmpvar_10);
  DissolveTex_UV_8 = (((xlv_TEXCOORD0.xy * _DissolveTex_ST.xy) + _DissolveTex_ST.zw) + tmpvar_11);
  if (bool(_DissolveUVRandom)) {
    DissolveTex_UV_8 = (DissolveTex_UV_8 + xlv_TEXCOORD0.zw);
  };
  highp float tmpvar_12;
  tmpvar_12 = (((xlv_TEXCOORD1.w - 0.5) * abs(_NoiseRandomRange)) + 1.0);
  highp vec2 tmpvar_13;
  tmpvar_13.x = ((_Time.y * _NoiseUSpeed) * tmpvar_12);
  tmpvar_13.y = ((_Time.y * _NoiseVSpeed) * tmpvar_12);
  NoiseTex_UV_7 = (((xlv_TEXCOORD0.xy * _NoiseTex_ST.xy) + _NoiseTex_ST.zw) + tmpvar_13);
  if (bool(_NoiseUVRandom)) {
    NoiseTex_UV_7 = (NoiseTex_UV_7 + xlv_TEXCOORD0.zw);
  };
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_NoiseTex, NoiseTex_UV_7);
  NoiseTexSampler_6 = tmpvar_14;
  NoiseChannel_5 = 0.0;
  if ((_NoiseChannelMapping == 0.0)) {
    NoiseChannel_5 = NoiseTexSampler_6.x;
  } else {
    if ((_NoiseChannelMapping == 1.0)) {
      NoiseChannel_5 = NoiseTexSampler_6.y;
    } else {
      if ((_NoiseChannelMapping == 2.0)) {
        NoiseChannel_5 = NoiseTexSampler_6.z;
      } else {
        if ((_NoiseChannelMapping == 3.0)) {
          NoiseChannel_5 = NoiseTexSampler_6.w;
        };
      };
    };
  };
  DissolveTex_UV_8 = (DissolveTex_UV_8 + ((
    (NoiseChannel_5 - 0.5)
   * 2.0) * _NoiseBrightness));
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_DissolveTex, DissolveTex_UV_8);
  DissolveTexSampler_4 = tmpvar_15;
  DissolveChannel_3 = 0.0;
  if ((_DissolveChannelMapping == 0.0)) {
    DissolveChannel_3 = DissolveTexSampler_4.x;
  } else {
    if ((_DissolveChannelMapping == 1.0)) {
      DissolveChannel_3 = DissolveTexSampler_4.y;
    } else {
      if ((_DissolveChannelMapping == 2.0)) {
        DissolveChannel_3 = DissolveTexSampler_4.z;
      } else {
        if ((_DissolveChannelMapping == 3.0)) {
          DissolveChannel_3 = DissolveTexSampler_4.w;
        };
      };
    };
  };
  highp vec2 tmpvar_16;
  tmpvar_16 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MainTex, tmpvar_16);
  MainTexSampler_2 = tmpvar_17;
  MainTexAlpha_1 = 0.0;
  if ((_AlphaChannelMapping == 0.0)) {
    MainTexAlpha_1 = MainTexSampler_2.x;
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      MainTexAlpha_1 = MainTexSampler_2.y;
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        MainTexAlpha_1 = MainTexSampler_2.z;
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          MainTexAlpha_1 = MainTexSampler_2.w;
        };
      };
    };
  };
  o_9.w = ((DissolveChannel_3 * MainTexAlpha_1) * xlv_COLOR.w);
  o_9.w = (o_9.w * _BloomFactor);
  gl_FragData[0] = o_9;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_NOISE_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _AlphaChannelMapping;
uniform sampler2D _DissolveTex;
uniform highp vec4 _DissolveTex_ST;
uniform highp float _DissolveChannelMapping;
uniform highp float _DissolveUSpeed;
uniform highp float _DissolveVSpeed;
uniform highp float _DissolveRandomRange;
uniform highp float _DissolveUVRandom;
uniform sampler2D _NoiseTex;
uniform highp vec4 _NoiseTex_ST;
uniform highp float _NoiseChannelMapping;
uniform highp float _NoiseUSpeed;
uniform highp float _NoiseVSpeed;
uniform highp float _NoiseRandomRange;
uniform highp float _NoiseUVRandom;
uniform highp float _NoiseBrightness;
uniform highp float _BloomFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float MainTexAlpha_1;
  mediump vec4 MainTexSampler_2;
  mediump float DissolveChannel_3;
  mediump vec4 DissolveTexSampler_4;
  mediump float NoiseChannel_5;
  mediump vec4 NoiseTexSampler_6;
  highp vec2 NoiseTex_UV_7;
  highp vec2 DissolveTex_UV_8;
  mediump vec4 o_9;
  o_9 = vec4(0.0, 0.0, 0.0, 0.0);
  highp float tmpvar_10;
  tmpvar_10 = (((xlv_TEXCOORD1.w - 0.5) * abs(_DissolveRandomRange)) + 1.0);
  highp vec2 tmpvar_11;
  tmpvar_11.x = ((_Time.y * _DissolveUSpeed) * tmpvar_10);
  tmpvar_11.y = ((_Time.y * _DissolveVSpeed) * tmpvar_10);
  DissolveTex_UV_8 = (((xlv_TEXCOORD0.xy * _DissolveTex_ST.xy) + _DissolveTex_ST.zw) + tmpvar_11);
  if (bool(_DissolveUVRandom)) {
    DissolveTex_UV_8 = (DissolveTex_UV_8 + xlv_TEXCOORD0.zw);
  };
  highp float tmpvar_12;
  tmpvar_12 = (((xlv_TEXCOORD1.w - 0.5) * abs(_NoiseRandomRange)) + 1.0);
  highp vec2 tmpvar_13;
  tmpvar_13.x = ((_Time.y * _NoiseUSpeed) * tmpvar_12);
  tmpvar_13.y = ((_Time.y * _NoiseVSpeed) * tmpvar_12);
  NoiseTex_UV_7 = (((xlv_TEXCOORD0.xy * _NoiseTex_ST.xy) + _NoiseTex_ST.zw) + tmpvar_13);
  if (bool(_NoiseUVRandom)) {
    NoiseTex_UV_7 = (NoiseTex_UV_7 + xlv_TEXCOORD0.zw);
  };
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_NoiseTex, NoiseTex_UV_7);
  NoiseTexSampler_6 = tmpvar_14;
  NoiseChannel_5 = 0.0;
  if ((_NoiseChannelMapping == 0.0)) {
    NoiseChannel_5 = NoiseTexSampler_6.x;
  } else {
    if ((_NoiseChannelMapping == 1.0)) {
      NoiseChannel_5 = NoiseTexSampler_6.y;
    } else {
      if ((_NoiseChannelMapping == 2.0)) {
        NoiseChannel_5 = NoiseTexSampler_6.z;
      } else {
        if ((_NoiseChannelMapping == 3.0)) {
          NoiseChannel_5 = NoiseTexSampler_6.w;
        };
      };
    };
  };
  DissolveTex_UV_8 = (DissolveTex_UV_8 + ((
    (NoiseChannel_5 - 0.5)
   * 2.0) * _NoiseBrightness));
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_DissolveTex, DissolveTex_UV_8);
  DissolveTexSampler_4 = tmpvar_15;
  DissolveChannel_3 = 0.0;
  if ((_DissolveChannelMapping == 0.0)) {
    DissolveChannel_3 = DissolveTexSampler_4.x;
  } else {
    if ((_DissolveChannelMapping == 1.0)) {
      DissolveChannel_3 = DissolveTexSampler_4.y;
    } else {
      if ((_DissolveChannelMapping == 2.0)) {
        DissolveChannel_3 = DissolveTexSampler_4.z;
      } else {
        if ((_DissolveChannelMapping == 3.0)) {
          DissolveChannel_3 = DissolveTexSampler_4.w;
        };
      };
    };
  };
  highp vec2 tmpvar_16;
  tmpvar_16 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MainTex, tmpvar_16);
  MainTexSampler_2 = tmpvar_17;
  MainTexAlpha_1 = 0.0;
  if ((_AlphaChannelMapping == 0.0)) {
    MainTexAlpha_1 = MainTexSampler_2.x;
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      MainTexAlpha_1 = MainTexSampler_2.y;
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        MainTexAlpha_1 = MainTexSampler_2.z;
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          MainTexAlpha_1 = MainTexSampler_2.w;
        };
      };
    };
  };
  o_9.w = ((DissolveChannel_3 * MainTexAlpha_1) * xlv_COLOR.w);
  o_9.w = (o_9.w * _BloomFactor);
  gl_FragData[0] = o_9;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_NOISE_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _AlphaChannelMapping;
uniform sampler2D _DissolveTex;
uniform highp vec4 _DissolveTex_ST;
uniform highp float _DissolveChannelMapping;
uniform highp float _DissolveUSpeed;
uniform highp float _DissolveVSpeed;
uniform highp float _DissolveRandomRange;
uniform highp float _DissolveUVRandom;
uniform sampler2D _NoiseTex;
uniform highp vec4 _NoiseTex_ST;
uniform highp float _NoiseChannelMapping;
uniform highp float _NoiseUSpeed;
uniform highp float _NoiseVSpeed;
uniform highp float _NoiseRandomRange;
uniform highp float _NoiseUVRandom;
uniform highp float _NoiseBrightness;
uniform highp float _BloomFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float MainTexAlpha_1;
  mediump vec4 MainTexSampler_2;
  mediump float DissolveChannel_3;
  mediump vec4 DissolveTexSampler_4;
  mediump float NoiseChannel_5;
  mediump vec4 NoiseTexSampler_6;
  highp vec2 NoiseTex_UV_7;
  highp vec2 DissolveTex_UV_8;
  mediump vec4 o_9;
  o_9 = vec4(0.0, 0.0, 0.0, 0.0);
  highp float tmpvar_10;
  tmpvar_10 = (((xlv_TEXCOORD1.w - 0.5) * abs(_DissolveRandomRange)) + 1.0);
  highp vec2 tmpvar_11;
  tmpvar_11.x = ((_Time.y * _DissolveUSpeed) * tmpvar_10);
  tmpvar_11.y = ((_Time.y * _DissolveVSpeed) * tmpvar_10);
  DissolveTex_UV_8 = (((xlv_TEXCOORD0.xy * _DissolveTex_ST.xy) + _DissolveTex_ST.zw) + tmpvar_11);
  if (bool(_DissolveUVRandom)) {
    DissolveTex_UV_8 = (DissolveTex_UV_8 + xlv_TEXCOORD0.zw);
  };
  highp float tmpvar_12;
  tmpvar_12 = (((xlv_TEXCOORD1.w - 0.5) * abs(_NoiseRandomRange)) + 1.0);
  highp vec2 tmpvar_13;
  tmpvar_13.x = ((_Time.y * _NoiseUSpeed) * tmpvar_12);
  tmpvar_13.y = ((_Time.y * _NoiseVSpeed) * tmpvar_12);
  NoiseTex_UV_7 = (((xlv_TEXCOORD0.xy * _NoiseTex_ST.xy) + _NoiseTex_ST.zw) + tmpvar_13);
  if (bool(_NoiseUVRandom)) {
    NoiseTex_UV_7 = (NoiseTex_UV_7 + xlv_TEXCOORD0.zw);
  };
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_NoiseTex, NoiseTex_UV_7);
  NoiseTexSampler_6 = tmpvar_14;
  NoiseChannel_5 = 0.0;
  if ((_NoiseChannelMapping == 0.0)) {
    NoiseChannel_5 = NoiseTexSampler_6.x;
  } else {
    if ((_NoiseChannelMapping == 1.0)) {
      NoiseChannel_5 = NoiseTexSampler_6.y;
    } else {
      if ((_NoiseChannelMapping == 2.0)) {
        NoiseChannel_5 = NoiseTexSampler_6.z;
      } else {
        if ((_NoiseChannelMapping == 3.0)) {
          NoiseChannel_5 = NoiseTexSampler_6.w;
        };
      };
    };
  };
  DissolveTex_UV_8 = (DissolveTex_UV_8 + ((
    (NoiseChannel_5 - 0.5)
   * 2.0) * _NoiseBrightness));
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_DissolveTex, DissolveTex_UV_8);
  DissolveTexSampler_4 = tmpvar_15;
  DissolveChannel_3 = 0.0;
  if ((_DissolveChannelMapping == 0.0)) {
    DissolveChannel_3 = DissolveTexSampler_4.x;
  } else {
    if ((_DissolveChannelMapping == 1.0)) {
      DissolveChannel_3 = DissolveTexSampler_4.y;
    } else {
      if ((_DissolveChannelMapping == 2.0)) {
        DissolveChannel_3 = DissolveTexSampler_4.z;
      } else {
        if ((_DissolveChannelMapping == 3.0)) {
          DissolveChannel_3 = DissolveTexSampler_4.w;
        };
      };
    };
  };
  highp vec2 tmpvar_16;
  tmpvar_16 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MainTex, tmpvar_16);
  MainTexSampler_2 = tmpvar_17;
  MainTexAlpha_1 = 0.0;
  if ((_AlphaChannelMapping == 0.0)) {
    MainTexAlpha_1 = MainTexSampler_2.x;
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      MainTexAlpha_1 = MainTexSampler_2.y;
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        MainTexAlpha_1 = MainTexSampler_2.z;
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          MainTexAlpha_1 = MainTexSampler_2.w;
        };
      };
    };
  };
  o_9.w = ((DissolveChannel_3 * MainTexAlpha_1) * xlv_COLOR.w);
  o_9.w = (o_9.w * _BloomFactor);
  gl_FragData[0] = o_9;
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
Keywords { "_NOISE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_NOISE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_NOISE_ON" }
""
}
}
}
}
}