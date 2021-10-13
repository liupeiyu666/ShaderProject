//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Particles/ChannelMix/Alpha_Blended" {
Properties {
_MainTex ("Main Tex", 2D) = "white" { }
[Enum(R, 0, G, 1, B, 2, A, 3)] _LerpChannelAMapping ("Lerp Channel A Mapping", Float) = 0
[Enum(R, 0, G, 1, B, 2, A, 3)] _LerpChannelBMapping ("Lerp Channel B Mapping", Float) = 1
[Enum(R, 0, G, 1, B, 2, A, 3)] _AlphaChannelMapping ("Alpha Channel Mapping", Float) = 2
_ColorA ("Color A", Color) = (1,0,0,0)
_ColorB ("Color B", Color) = (0,1,0,0)
_ColorC ("Color C", Color) = (0,0,1,0)
[Toggle(_COLORCTOGGLE_ON)] _ColorCToggle ("Color C Toggle", Float) = 0
[Toggle(_PARTICLECOLORTOGGLE_ON)] _ParticleColorAsColorA ("Particle Color As Color A", Float) = 0
[Toggle(_CUSTOMCOLOR1TOGGLE_ON)] _CustomColor1AsColorB ("Custom Color 1 As Color B", Float) = 0
[Toggle(_CUSTOMCOLOR2TOGGLE_ON)] _CustomColor2AsColorC ("Custom Color 2 As Color C", Float) = 0
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
  GpuProgramID 682
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float LerpChannelA_1;
  mediump vec4 MainTexSampler_2;
  mediump vec4 o_3;
  o_3 = xlv_COLOR;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, tmpvar_4);
  MainTexSampler_2 = tmpvar_5;
  LerpChannelA_1 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_1 = MainTexSampler_2.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_1 = MainTexSampler_2.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_1 = MainTexSampler_2.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_1 = MainTexSampler_2.w;
        };
      };
    };
  };
  o_3.xyz = (xlv_COLOR.xyz * mix (_ColorB.xyz, _ColorA.xyz, vec3(LerpChannelA_1)));
  o_3.xyz = (o_3.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_3.w = (xlv_COLOR.w * MainTexSampler_2.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_3.w = (o_3.w * MainTexSampler_2.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_3.w = (o_3.w * MainTexSampler_2.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_3.w = (o_3.w * MainTexSampler_2.w);
        };
      };
    };
  };
  o_3.w = clamp (o_3.w, 0.0, 1.0);
  gl_FragData[0] = o_3;
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float LerpChannelA_1;
  mediump vec4 MainTexSampler_2;
  mediump vec4 o_3;
  o_3 = xlv_COLOR;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, tmpvar_4);
  MainTexSampler_2 = tmpvar_5;
  LerpChannelA_1 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_1 = MainTexSampler_2.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_1 = MainTexSampler_2.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_1 = MainTexSampler_2.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_1 = MainTexSampler_2.w;
        };
      };
    };
  };
  o_3.xyz = (xlv_COLOR.xyz * mix (_ColorB.xyz, _ColorA.xyz, vec3(LerpChannelA_1)));
  o_3.xyz = (o_3.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_3.w = (xlv_COLOR.w * MainTexSampler_2.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_3.w = (o_3.w * MainTexSampler_2.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_3.w = (o_3.w * MainTexSampler_2.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_3.w = (o_3.w * MainTexSampler_2.w);
        };
      };
    };
  };
  o_3.w = clamp (o_3.w, 0.0, 1.0);
  gl_FragData[0] = o_3;
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float LerpChannelA_1;
  mediump vec4 MainTexSampler_2;
  mediump vec4 o_3;
  o_3 = xlv_COLOR;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, tmpvar_4);
  MainTexSampler_2 = tmpvar_5;
  LerpChannelA_1 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_1 = MainTexSampler_2.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_1 = MainTexSampler_2.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_1 = MainTexSampler_2.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_1 = MainTexSampler_2.w;
        };
      };
    };
  };
  o_3.xyz = (xlv_COLOR.xyz * mix (_ColorB.xyz, _ColorA.xyz, vec3(LerpChannelA_1)));
  o_3.xyz = (o_3.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_3.w = (xlv_COLOR.w * MainTexSampler_2.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_3.w = (o_3.w * MainTexSampler_2.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_3.w = (o_3.w * MainTexSampler_2.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_3.w = (o_3.w * MainTexSampler_2.w);
        };
      };
    };
  };
  o_3.w = clamp (o_3.w, 0.0, 1.0);
  gl_FragData[0] = o_3;
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float LerpChannelA_1;
  mediump vec4 MainTexSampler_2;
  mediump vec4 o_3;
  o_3 = xlv_COLOR;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, tmpvar_4);
  MainTexSampler_2 = tmpvar_5;
  LerpChannelA_1 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_1 = MainTexSampler_2.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_1 = MainTexSampler_2.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_1 = MainTexSampler_2.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_1 = MainTexSampler_2.w;
        };
      };
    };
  };
  o_3.xyz = (xlv_COLOR.xyz * mix (_ColorB.xyz, _ColorA.xyz, vec3(LerpChannelA_1)));
  o_3.xyz = (o_3.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_3.w = (xlv_COLOR.w * MainTexSampler_2.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_3.w = (o_3.w * MainTexSampler_2.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_3.w = (o_3.w * MainTexSampler_2.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_3.w = (o_3.w * MainTexSampler_2.w);
        };
      };
    };
  };
  o_3.xyz = mix (o_3.xyz, vec3(dot (o_3.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  o_3.w = clamp (o_3.w, 0.0, 1.0);
  gl_FragData[0] = o_3;
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float LerpChannelA_1;
  mediump vec4 MainTexSampler_2;
  mediump vec4 o_3;
  o_3 = xlv_COLOR;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, tmpvar_4);
  MainTexSampler_2 = tmpvar_5;
  LerpChannelA_1 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_1 = MainTexSampler_2.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_1 = MainTexSampler_2.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_1 = MainTexSampler_2.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_1 = MainTexSampler_2.w;
        };
      };
    };
  };
  o_3.xyz = (xlv_COLOR.xyz * mix (_ColorB.xyz, _ColorA.xyz, vec3(LerpChannelA_1)));
  o_3.xyz = (o_3.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_3.w = (xlv_COLOR.w * MainTexSampler_2.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_3.w = (o_3.w * MainTexSampler_2.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_3.w = (o_3.w * MainTexSampler_2.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_3.w = (o_3.w * MainTexSampler_2.w);
        };
      };
    };
  };
  o_3.xyz = mix (o_3.xyz, vec3(dot (o_3.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  o_3.w = clamp (o_3.w, 0.0, 1.0);
  gl_FragData[0] = o_3;
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float LerpChannelA_1;
  mediump vec4 MainTexSampler_2;
  mediump vec4 o_3;
  o_3 = xlv_COLOR;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, tmpvar_4);
  MainTexSampler_2 = tmpvar_5;
  LerpChannelA_1 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_1 = MainTexSampler_2.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_1 = MainTexSampler_2.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_1 = MainTexSampler_2.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_1 = MainTexSampler_2.w;
        };
      };
    };
  };
  o_3.xyz = (xlv_COLOR.xyz * mix (_ColorB.xyz, _ColorA.xyz, vec3(LerpChannelA_1)));
  o_3.xyz = (o_3.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_3.w = (xlv_COLOR.w * MainTexSampler_2.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_3.w = (o_3.w * MainTexSampler_2.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_3.w = (o_3.w * MainTexSampler_2.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_3.w = (o_3.w * MainTexSampler_2.w);
        };
      };
    };
  };
  o_3.xyz = mix (o_3.xyz, vec3(dot (o_3.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  o_3.w = clamp (o_3.w, 0.0, 1.0);
  gl_FragData[0] = o_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float LerpChannelA_1;
  mediump vec4 MainTexSampler_2;
  mediump vec4 o_3;
  o_3 = xlv_COLOR;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, tmpvar_4);
  MainTexSampler_2 = tmpvar_5;
  LerpChannelA_1 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_1 = MainTexSampler_2.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_1 = MainTexSampler_2.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_1 = MainTexSampler_2.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_1 = MainTexSampler_2.w;
        };
      };
    };
  };
  o_3.xyz = (xlv_COLOR.xyz * mix (_ColorB.xyz, _ColorA.xyz, vec3(LerpChannelA_1)));
  o_3.xyz = (o_3.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_3.w = (xlv_COLOR.w * MainTexSampler_2.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_3.w = (o_3.w * MainTexSampler_2.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_3.w = (o_3.w * MainTexSampler_2.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_3.w = (o_3.w * MainTexSampler_2.w);
        };
      };
    };
  };
  o_3.w = clamp (o_3.w, 0.0, 1.0);
  gl_FragData[0] = o_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float LerpChannelA_1;
  mediump vec4 MainTexSampler_2;
  mediump vec4 o_3;
  o_3 = xlv_COLOR;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, tmpvar_4);
  MainTexSampler_2 = tmpvar_5;
  LerpChannelA_1 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_1 = MainTexSampler_2.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_1 = MainTexSampler_2.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_1 = MainTexSampler_2.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_1 = MainTexSampler_2.w;
        };
      };
    };
  };
  o_3.xyz = (xlv_COLOR.xyz * mix (_ColorB.xyz, _ColorA.xyz, vec3(LerpChannelA_1)));
  o_3.xyz = (o_3.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_3.w = (xlv_COLOR.w * MainTexSampler_2.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_3.w = (o_3.w * MainTexSampler_2.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_3.w = (o_3.w * MainTexSampler_2.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_3.w = (o_3.w * MainTexSampler_2.w);
        };
      };
    };
  };
  o_3.w = clamp (o_3.w, 0.0, 1.0);
  gl_FragData[0] = o_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float LerpChannelA_1;
  mediump vec4 MainTexSampler_2;
  mediump vec4 o_3;
  o_3 = xlv_COLOR;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, tmpvar_4);
  MainTexSampler_2 = tmpvar_5;
  LerpChannelA_1 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_1 = MainTexSampler_2.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_1 = MainTexSampler_2.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_1 = MainTexSampler_2.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_1 = MainTexSampler_2.w;
        };
      };
    };
  };
  o_3.xyz = (xlv_COLOR.xyz * mix (_ColorB.xyz, _ColorA.xyz, vec3(LerpChannelA_1)));
  o_3.xyz = (o_3.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_3.w = (xlv_COLOR.w * MainTexSampler_2.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_3.w = (o_3.w * MainTexSampler_2.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_3.w = (o_3.w * MainTexSampler_2.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_3.w = (o_3.w * MainTexSampler_2.w);
        };
      };
    };
  };
  o_3.w = clamp (o_3.w, 0.0, 1.0);
  gl_FragData[0] = o_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float LerpChannelA_1;
  mediump vec4 MainTexSampler_2;
  mediump vec4 o_3;
  o_3 = xlv_COLOR;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, tmpvar_4);
  MainTexSampler_2 = tmpvar_5;
  LerpChannelA_1 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_1 = MainTexSampler_2.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_1 = MainTexSampler_2.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_1 = MainTexSampler_2.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_1 = MainTexSampler_2.w;
        };
      };
    };
  };
  o_3.xyz = (xlv_COLOR.xyz * mix (_ColorB.xyz, _ColorA.xyz, vec3(LerpChannelA_1)));
  o_3.xyz = (o_3.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_3.w = (xlv_COLOR.w * MainTexSampler_2.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_3.w = (o_3.w * MainTexSampler_2.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_3.w = (o_3.w * MainTexSampler_2.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_3.w = (o_3.w * MainTexSampler_2.w);
        };
      };
    };
  };
  o_3.xyz = mix (o_3.xyz, vec3(dot (o_3.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  o_3.w = clamp (o_3.w, 0.0, 1.0);
  gl_FragData[0] = o_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float LerpChannelA_1;
  mediump vec4 MainTexSampler_2;
  mediump vec4 o_3;
  o_3 = xlv_COLOR;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, tmpvar_4);
  MainTexSampler_2 = tmpvar_5;
  LerpChannelA_1 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_1 = MainTexSampler_2.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_1 = MainTexSampler_2.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_1 = MainTexSampler_2.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_1 = MainTexSampler_2.w;
        };
      };
    };
  };
  o_3.xyz = (xlv_COLOR.xyz * mix (_ColorB.xyz, _ColorA.xyz, vec3(LerpChannelA_1)));
  o_3.xyz = (o_3.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_3.w = (xlv_COLOR.w * MainTexSampler_2.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_3.w = (o_3.w * MainTexSampler_2.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_3.w = (o_3.w * MainTexSampler_2.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_3.w = (o_3.w * MainTexSampler_2.w);
        };
      };
    };
  };
  o_3.xyz = mix (o_3.xyz, vec3(dot (o_3.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  o_3.w = clamp (o_3.w, 0.0, 1.0);
  gl_FragData[0] = o_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float LerpChannelA_1;
  mediump vec4 MainTexSampler_2;
  mediump vec4 o_3;
  o_3 = xlv_COLOR;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, tmpvar_4);
  MainTexSampler_2 = tmpvar_5;
  LerpChannelA_1 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_1 = MainTexSampler_2.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_1 = MainTexSampler_2.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_1 = MainTexSampler_2.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_1 = MainTexSampler_2.w;
        };
      };
    };
  };
  o_3.xyz = (xlv_COLOR.xyz * mix (_ColorB.xyz, _ColorA.xyz, vec3(LerpChannelA_1)));
  o_3.xyz = (o_3.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_3.w = (xlv_COLOR.w * MainTexSampler_2.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_3.w = (o_3.w * MainTexSampler_2.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_3.w = (o_3.w * MainTexSampler_2.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_3.w = (o_3.w * MainTexSampler_2.w);
        };
      };
    };
  };
  o_3.xyz = mix (o_3.xyz, vec3(dot (o_3.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  o_3.w = clamp (o_3.w, 0.0, 1.0);
  gl_FragData[0] = o_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_CUSTOMCOLOR1TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 ColorB_1;
  mediump float LerpChannelA_2;
  mediump vec4 MainTexSampler_3;
  mediump vec4 o_4;
  o_4 = xlv_COLOR;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, tmpvar_5);
  MainTexSampler_3 = tmpvar_6;
  LerpChannelA_2 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_2 = MainTexSampler_3.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_2 = MainTexSampler_3.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_2 = MainTexSampler_3.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_2 = MainTexSampler_3.w;
        };
      };
    };
  };
  highp vec3 tmpvar_7;
  tmpvar_7.xy = xlv_TEXCOORD0.zw;
  tmpvar_7.z = xlv_TEXCOORD1.x;
  ColorB_1 = tmpvar_7;
  o_4.xyz = (xlv_COLOR.xyz * mix (ColorB_1, _ColorA.xyz, vec3(LerpChannelA_2)));
  o_4.xyz = (o_4.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_4.w = (xlv_COLOR.w * MainTexSampler_3.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_4.w = (o_4.w * MainTexSampler_3.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_4.w = (o_4.w * MainTexSampler_3.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_4.w = (o_4.w * MainTexSampler_3.w);
        };
      };
    };
  };
  o_4.w = clamp (o_4.w, 0.0, 1.0);
  gl_FragData[0] = o_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_CUSTOMCOLOR1TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 ColorB_1;
  mediump float LerpChannelA_2;
  mediump vec4 MainTexSampler_3;
  mediump vec4 o_4;
  o_4 = xlv_COLOR;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, tmpvar_5);
  MainTexSampler_3 = tmpvar_6;
  LerpChannelA_2 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_2 = MainTexSampler_3.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_2 = MainTexSampler_3.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_2 = MainTexSampler_3.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_2 = MainTexSampler_3.w;
        };
      };
    };
  };
  highp vec3 tmpvar_7;
  tmpvar_7.xy = xlv_TEXCOORD0.zw;
  tmpvar_7.z = xlv_TEXCOORD1.x;
  ColorB_1 = tmpvar_7;
  o_4.xyz = (xlv_COLOR.xyz * mix (ColorB_1, _ColorA.xyz, vec3(LerpChannelA_2)));
  o_4.xyz = (o_4.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_4.w = (xlv_COLOR.w * MainTexSampler_3.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_4.w = (o_4.w * MainTexSampler_3.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_4.w = (o_4.w * MainTexSampler_3.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_4.w = (o_4.w * MainTexSampler_3.w);
        };
      };
    };
  };
  o_4.w = clamp (o_4.w, 0.0, 1.0);
  gl_FragData[0] = o_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_CUSTOMCOLOR1TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 ColorB_1;
  mediump float LerpChannelA_2;
  mediump vec4 MainTexSampler_3;
  mediump vec4 o_4;
  o_4 = xlv_COLOR;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, tmpvar_5);
  MainTexSampler_3 = tmpvar_6;
  LerpChannelA_2 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_2 = MainTexSampler_3.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_2 = MainTexSampler_3.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_2 = MainTexSampler_3.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_2 = MainTexSampler_3.w;
        };
      };
    };
  };
  highp vec3 tmpvar_7;
  tmpvar_7.xy = xlv_TEXCOORD0.zw;
  tmpvar_7.z = xlv_TEXCOORD1.x;
  ColorB_1 = tmpvar_7;
  o_4.xyz = (xlv_COLOR.xyz * mix (ColorB_1, _ColorA.xyz, vec3(LerpChannelA_2)));
  o_4.xyz = (o_4.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_4.w = (xlv_COLOR.w * MainTexSampler_3.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_4.w = (o_4.w * MainTexSampler_3.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_4.w = (o_4.w * MainTexSampler_3.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_4.w = (o_4.w * MainTexSampler_3.w);
        };
      };
    };
  };
  o_4.w = clamp (o_4.w, 0.0, 1.0);
  gl_FragData[0] = o_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_CUSTOMCOLOR1TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 ColorB_1;
  mediump float LerpChannelA_2;
  mediump vec4 MainTexSampler_3;
  mediump vec4 o_4;
  o_4 = xlv_COLOR;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, tmpvar_5);
  MainTexSampler_3 = tmpvar_6;
  LerpChannelA_2 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_2 = MainTexSampler_3.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_2 = MainTexSampler_3.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_2 = MainTexSampler_3.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_2 = MainTexSampler_3.w;
        };
      };
    };
  };
  highp vec3 tmpvar_7;
  tmpvar_7.xy = xlv_TEXCOORD0.zw;
  tmpvar_7.z = xlv_TEXCOORD1.x;
  ColorB_1 = tmpvar_7;
  o_4.xyz = (xlv_COLOR.xyz * mix (ColorB_1, _ColorA.xyz, vec3(LerpChannelA_2)));
  o_4.xyz = (o_4.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_4.w = (xlv_COLOR.w * MainTexSampler_3.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_4.w = (o_4.w * MainTexSampler_3.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_4.w = (o_4.w * MainTexSampler_3.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_4.w = (o_4.w * MainTexSampler_3.w);
        };
      };
    };
  };
  o_4.xyz = mix (o_4.xyz, vec3(dot (o_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  o_4.w = clamp (o_4.w, 0.0, 1.0);
  gl_FragData[0] = o_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_CUSTOMCOLOR1TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 ColorB_1;
  mediump float LerpChannelA_2;
  mediump vec4 MainTexSampler_3;
  mediump vec4 o_4;
  o_4 = xlv_COLOR;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, tmpvar_5);
  MainTexSampler_3 = tmpvar_6;
  LerpChannelA_2 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_2 = MainTexSampler_3.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_2 = MainTexSampler_3.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_2 = MainTexSampler_3.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_2 = MainTexSampler_3.w;
        };
      };
    };
  };
  highp vec3 tmpvar_7;
  tmpvar_7.xy = xlv_TEXCOORD0.zw;
  tmpvar_7.z = xlv_TEXCOORD1.x;
  ColorB_1 = tmpvar_7;
  o_4.xyz = (xlv_COLOR.xyz * mix (ColorB_1, _ColorA.xyz, vec3(LerpChannelA_2)));
  o_4.xyz = (o_4.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_4.w = (xlv_COLOR.w * MainTexSampler_3.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_4.w = (o_4.w * MainTexSampler_3.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_4.w = (o_4.w * MainTexSampler_3.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_4.w = (o_4.w * MainTexSampler_3.w);
        };
      };
    };
  };
  o_4.xyz = mix (o_4.xyz, vec3(dot (o_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  o_4.w = clamp (o_4.w, 0.0, 1.0);
  gl_FragData[0] = o_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_CUSTOMCOLOR1TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 ColorB_1;
  mediump float LerpChannelA_2;
  mediump vec4 MainTexSampler_3;
  mediump vec4 o_4;
  o_4 = xlv_COLOR;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, tmpvar_5);
  MainTexSampler_3 = tmpvar_6;
  LerpChannelA_2 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_2 = MainTexSampler_3.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_2 = MainTexSampler_3.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_2 = MainTexSampler_3.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_2 = MainTexSampler_3.w;
        };
      };
    };
  };
  highp vec3 tmpvar_7;
  tmpvar_7.xy = xlv_TEXCOORD0.zw;
  tmpvar_7.z = xlv_TEXCOORD1.x;
  ColorB_1 = tmpvar_7;
  o_4.xyz = (xlv_COLOR.xyz * mix (ColorB_1, _ColorA.xyz, vec3(LerpChannelA_2)));
  o_4.xyz = (o_4.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_4.w = (xlv_COLOR.w * MainTexSampler_3.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_4.w = (o_4.w * MainTexSampler_3.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_4.w = (o_4.w * MainTexSampler_3.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_4.w = (o_4.w * MainTexSampler_3.w);
        };
      };
    };
  };
  o_4.xyz = mix (o_4.xyz, vec3(dot (o_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  o_4.w = clamp (o_4.w, 0.0, 1.0);
  gl_FragData[0] = o_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 ColorB_1;
  mediump float LerpChannelA_2;
  mediump vec4 MainTexSampler_3;
  mediump vec4 o_4;
  o_4 = xlv_COLOR;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, tmpvar_5);
  MainTexSampler_3 = tmpvar_6;
  LerpChannelA_2 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_2 = MainTexSampler_3.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_2 = MainTexSampler_3.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_2 = MainTexSampler_3.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_2 = MainTexSampler_3.w;
        };
      };
    };
  };
  highp vec3 tmpvar_7;
  tmpvar_7.xy = xlv_TEXCOORD0.zw;
  tmpvar_7.z = xlv_TEXCOORD1.x;
  ColorB_1 = tmpvar_7;
  o_4.xyz = (xlv_COLOR.xyz * mix (ColorB_1, _ColorA.xyz, vec3(LerpChannelA_2)));
  o_4.xyz = (o_4.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_4.w = (xlv_COLOR.w * MainTexSampler_3.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_4.w = (o_4.w * MainTexSampler_3.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_4.w = (o_4.w * MainTexSampler_3.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_4.w = (o_4.w * MainTexSampler_3.w);
        };
      };
    };
  };
  o_4.w = clamp (o_4.w, 0.0, 1.0);
  gl_FragData[0] = o_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 ColorB_1;
  mediump float LerpChannelA_2;
  mediump vec4 MainTexSampler_3;
  mediump vec4 o_4;
  o_4 = xlv_COLOR;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, tmpvar_5);
  MainTexSampler_3 = tmpvar_6;
  LerpChannelA_2 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_2 = MainTexSampler_3.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_2 = MainTexSampler_3.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_2 = MainTexSampler_3.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_2 = MainTexSampler_3.w;
        };
      };
    };
  };
  highp vec3 tmpvar_7;
  tmpvar_7.xy = xlv_TEXCOORD0.zw;
  tmpvar_7.z = xlv_TEXCOORD1.x;
  ColorB_1 = tmpvar_7;
  o_4.xyz = (xlv_COLOR.xyz * mix (ColorB_1, _ColorA.xyz, vec3(LerpChannelA_2)));
  o_4.xyz = (o_4.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_4.w = (xlv_COLOR.w * MainTexSampler_3.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_4.w = (o_4.w * MainTexSampler_3.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_4.w = (o_4.w * MainTexSampler_3.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_4.w = (o_4.w * MainTexSampler_3.w);
        };
      };
    };
  };
  o_4.w = clamp (o_4.w, 0.0, 1.0);
  gl_FragData[0] = o_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 ColorB_1;
  mediump float LerpChannelA_2;
  mediump vec4 MainTexSampler_3;
  mediump vec4 o_4;
  o_4 = xlv_COLOR;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, tmpvar_5);
  MainTexSampler_3 = tmpvar_6;
  LerpChannelA_2 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_2 = MainTexSampler_3.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_2 = MainTexSampler_3.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_2 = MainTexSampler_3.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_2 = MainTexSampler_3.w;
        };
      };
    };
  };
  highp vec3 tmpvar_7;
  tmpvar_7.xy = xlv_TEXCOORD0.zw;
  tmpvar_7.z = xlv_TEXCOORD1.x;
  ColorB_1 = tmpvar_7;
  o_4.xyz = (xlv_COLOR.xyz * mix (ColorB_1, _ColorA.xyz, vec3(LerpChannelA_2)));
  o_4.xyz = (o_4.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_4.w = (xlv_COLOR.w * MainTexSampler_3.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_4.w = (o_4.w * MainTexSampler_3.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_4.w = (o_4.w * MainTexSampler_3.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_4.w = (o_4.w * MainTexSampler_3.w);
        };
      };
    };
  };
  o_4.w = clamp (o_4.w, 0.0, 1.0);
  gl_FragData[0] = o_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 ColorB_1;
  mediump float LerpChannelA_2;
  mediump vec4 MainTexSampler_3;
  mediump vec4 o_4;
  o_4 = xlv_COLOR;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, tmpvar_5);
  MainTexSampler_3 = tmpvar_6;
  LerpChannelA_2 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_2 = MainTexSampler_3.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_2 = MainTexSampler_3.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_2 = MainTexSampler_3.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_2 = MainTexSampler_3.w;
        };
      };
    };
  };
  highp vec3 tmpvar_7;
  tmpvar_7.xy = xlv_TEXCOORD0.zw;
  tmpvar_7.z = xlv_TEXCOORD1.x;
  ColorB_1 = tmpvar_7;
  o_4.xyz = (xlv_COLOR.xyz * mix (ColorB_1, _ColorA.xyz, vec3(LerpChannelA_2)));
  o_4.xyz = (o_4.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_4.w = (xlv_COLOR.w * MainTexSampler_3.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_4.w = (o_4.w * MainTexSampler_3.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_4.w = (o_4.w * MainTexSampler_3.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_4.w = (o_4.w * MainTexSampler_3.w);
        };
      };
    };
  };
  o_4.xyz = mix (o_4.xyz, vec3(dot (o_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  o_4.w = clamp (o_4.w, 0.0, 1.0);
  gl_FragData[0] = o_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 ColorB_1;
  mediump float LerpChannelA_2;
  mediump vec4 MainTexSampler_3;
  mediump vec4 o_4;
  o_4 = xlv_COLOR;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, tmpvar_5);
  MainTexSampler_3 = tmpvar_6;
  LerpChannelA_2 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_2 = MainTexSampler_3.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_2 = MainTexSampler_3.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_2 = MainTexSampler_3.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_2 = MainTexSampler_3.w;
        };
      };
    };
  };
  highp vec3 tmpvar_7;
  tmpvar_7.xy = xlv_TEXCOORD0.zw;
  tmpvar_7.z = xlv_TEXCOORD1.x;
  ColorB_1 = tmpvar_7;
  o_4.xyz = (xlv_COLOR.xyz * mix (ColorB_1, _ColorA.xyz, vec3(LerpChannelA_2)));
  o_4.xyz = (o_4.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_4.w = (xlv_COLOR.w * MainTexSampler_3.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_4.w = (o_4.w * MainTexSampler_3.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_4.w = (o_4.w * MainTexSampler_3.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_4.w = (o_4.w * MainTexSampler_3.w);
        };
      };
    };
  };
  o_4.xyz = mix (o_4.xyz, vec3(dot (o_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  o_4.w = clamp (o_4.w, 0.0, 1.0);
  gl_FragData[0] = o_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 ColorB_1;
  mediump float LerpChannelA_2;
  mediump vec4 MainTexSampler_3;
  mediump vec4 o_4;
  o_4 = xlv_COLOR;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, tmpvar_5);
  MainTexSampler_3 = tmpvar_6;
  LerpChannelA_2 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_2 = MainTexSampler_3.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_2 = MainTexSampler_3.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_2 = MainTexSampler_3.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_2 = MainTexSampler_3.w;
        };
      };
    };
  };
  highp vec3 tmpvar_7;
  tmpvar_7.xy = xlv_TEXCOORD0.zw;
  tmpvar_7.z = xlv_TEXCOORD1.x;
  ColorB_1 = tmpvar_7;
  o_4.xyz = (xlv_COLOR.xyz * mix (ColorB_1, _ColorA.xyz, vec3(LerpChannelA_2)));
  o_4.xyz = (o_4.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_4.w = (xlv_COLOR.w * MainTexSampler_3.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_4.w = (o_4.w * MainTexSampler_3.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_4.w = (o_4.w * MainTexSampler_3.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_4.w = (o_4.w * MainTexSampler_3.w);
        };
      };
    };
  };
  o_4.xyz = mix (o_4.xyz, vec3(dot (o_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  o_4.w = clamp (o_4.w, 0.0, 1.0);
  gl_FragData[0] = o_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_PARTICLECOLORTOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float LerpChannelA_1;
  mediump vec4 MainTexSampler_2;
  mediump vec4 o_3;
  o_3 = xlv_COLOR;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, tmpvar_4);
  MainTexSampler_2 = tmpvar_5;
  LerpChannelA_1 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_1 = MainTexSampler_2.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_1 = MainTexSampler_2.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_1 = MainTexSampler_2.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_1 = MainTexSampler_2.w;
        };
      };
    };
  };
  o_3.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, vec3(LerpChannelA_1));
  o_3.xyz = (o_3.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_3.w = (xlv_COLOR.w * MainTexSampler_2.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_3.w = (o_3.w * MainTexSampler_2.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_3.w = (o_3.w * MainTexSampler_2.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_3.w = (o_3.w * MainTexSampler_2.w);
        };
      };
    };
  };
  o_3.w = clamp (o_3.w, 0.0, 1.0);
  gl_FragData[0] = o_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_PARTICLECOLORTOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float LerpChannelA_1;
  mediump vec4 MainTexSampler_2;
  mediump vec4 o_3;
  o_3 = xlv_COLOR;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, tmpvar_4);
  MainTexSampler_2 = tmpvar_5;
  LerpChannelA_1 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_1 = MainTexSampler_2.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_1 = MainTexSampler_2.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_1 = MainTexSampler_2.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_1 = MainTexSampler_2.w;
        };
      };
    };
  };
  o_3.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, vec3(LerpChannelA_1));
  o_3.xyz = (o_3.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_3.w = (xlv_COLOR.w * MainTexSampler_2.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_3.w = (o_3.w * MainTexSampler_2.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_3.w = (o_3.w * MainTexSampler_2.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_3.w = (o_3.w * MainTexSampler_2.w);
        };
      };
    };
  };
  o_3.w = clamp (o_3.w, 0.0, 1.0);
  gl_FragData[0] = o_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_PARTICLECOLORTOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float LerpChannelA_1;
  mediump vec4 MainTexSampler_2;
  mediump vec4 o_3;
  o_3 = xlv_COLOR;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, tmpvar_4);
  MainTexSampler_2 = tmpvar_5;
  LerpChannelA_1 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_1 = MainTexSampler_2.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_1 = MainTexSampler_2.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_1 = MainTexSampler_2.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_1 = MainTexSampler_2.w;
        };
      };
    };
  };
  o_3.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, vec3(LerpChannelA_1));
  o_3.xyz = (o_3.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_3.w = (xlv_COLOR.w * MainTexSampler_2.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_3.w = (o_3.w * MainTexSampler_2.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_3.w = (o_3.w * MainTexSampler_2.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_3.w = (o_3.w * MainTexSampler_2.w);
        };
      };
    };
  };
  o_3.w = clamp (o_3.w, 0.0, 1.0);
  gl_FragData[0] = o_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_PARTICLECOLORTOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float LerpChannelA_1;
  mediump vec4 MainTexSampler_2;
  mediump vec4 o_3;
  o_3 = xlv_COLOR;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, tmpvar_4);
  MainTexSampler_2 = tmpvar_5;
  LerpChannelA_1 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_1 = MainTexSampler_2.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_1 = MainTexSampler_2.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_1 = MainTexSampler_2.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_1 = MainTexSampler_2.w;
        };
      };
    };
  };
  o_3.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, vec3(LerpChannelA_1));
  o_3.xyz = (o_3.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_3.w = (xlv_COLOR.w * MainTexSampler_2.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_3.w = (o_3.w * MainTexSampler_2.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_3.w = (o_3.w * MainTexSampler_2.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_3.w = (o_3.w * MainTexSampler_2.w);
        };
      };
    };
  };
  o_3.xyz = mix (o_3.xyz, vec3(dot (o_3.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  o_3.w = clamp (o_3.w, 0.0, 1.0);
  gl_FragData[0] = o_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_PARTICLECOLORTOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float LerpChannelA_1;
  mediump vec4 MainTexSampler_2;
  mediump vec4 o_3;
  o_3 = xlv_COLOR;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, tmpvar_4);
  MainTexSampler_2 = tmpvar_5;
  LerpChannelA_1 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_1 = MainTexSampler_2.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_1 = MainTexSampler_2.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_1 = MainTexSampler_2.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_1 = MainTexSampler_2.w;
        };
      };
    };
  };
  o_3.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, vec3(LerpChannelA_1));
  o_3.xyz = (o_3.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_3.w = (xlv_COLOR.w * MainTexSampler_2.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_3.w = (o_3.w * MainTexSampler_2.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_3.w = (o_3.w * MainTexSampler_2.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_3.w = (o_3.w * MainTexSampler_2.w);
        };
      };
    };
  };
  o_3.xyz = mix (o_3.xyz, vec3(dot (o_3.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  o_3.w = clamp (o_3.w, 0.0, 1.0);
  gl_FragData[0] = o_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_PARTICLECOLORTOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float LerpChannelA_1;
  mediump vec4 MainTexSampler_2;
  mediump vec4 o_3;
  o_3 = xlv_COLOR;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, tmpvar_4);
  MainTexSampler_2 = tmpvar_5;
  LerpChannelA_1 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_1 = MainTexSampler_2.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_1 = MainTexSampler_2.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_1 = MainTexSampler_2.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_1 = MainTexSampler_2.w;
        };
      };
    };
  };
  o_3.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, vec3(LerpChannelA_1));
  o_3.xyz = (o_3.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_3.w = (xlv_COLOR.w * MainTexSampler_2.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_3.w = (o_3.w * MainTexSampler_2.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_3.w = (o_3.w * MainTexSampler_2.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_3.w = (o_3.w * MainTexSampler_2.w);
        };
      };
    };
  };
  o_3.xyz = mix (o_3.xyz, vec3(dot (o_3.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  o_3.w = clamp (o_3.w, 0.0, 1.0);
  gl_FragData[0] = o_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float LerpChannelA_1;
  mediump vec4 MainTexSampler_2;
  mediump vec4 o_3;
  o_3 = xlv_COLOR;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, tmpvar_4);
  MainTexSampler_2 = tmpvar_5;
  LerpChannelA_1 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_1 = MainTexSampler_2.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_1 = MainTexSampler_2.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_1 = MainTexSampler_2.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_1 = MainTexSampler_2.w;
        };
      };
    };
  };
  o_3.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, vec3(LerpChannelA_1));
  o_3.xyz = (o_3.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_3.w = (xlv_COLOR.w * MainTexSampler_2.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_3.w = (o_3.w * MainTexSampler_2.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_3.w = (o_3.w * MainTexSampler_2.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_3.w = (o_3.w * MainTexSampler_2.w);
        };
      };
    };
  };
  o_3.w = clamp (o_3.w, 0.0, 1.0);
  gl_FragData[0] = o_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float LerpChannelA_1;
  mediump vec4 MainTexSampler_2;
  mediump vec4 o_3;
  o_3 = xlv_COLOR;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, tmpvar_4);
  MainTexSampler_2 = tmpvar_5;
  LerpChannelA_1 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_1 = MainTexSampler_2.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_1 = MainTexSampler_2.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_1 = MainTexSampler_2.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_1 = MainTexSampler_2.w;
        };
      };
    };
  };
  o_3.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, vec3(LerpChannelA_1));
  o_3.xyz = (o_3.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_3.w = (xlv_COLOR.w * MainTexSampler_2.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_3.w = (o_3.w * MainTexSampler_2.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_3.w = (o_3.w * MainTexSampler_2.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_3.w = (o_3.w * MainTexSampler_2.w);
        };
      };
    };
  };
  o_3.w = clamp (o_3.w, 0.0, 1.0);
  gl_FragData[0] = o_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float LerpChannelA_1;
  mediump vec4 MainTexSampler_2;
  mediump vec4 o_3;
  o_3 = xlv_COLOR;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, tmpvar_4);
  MainTexSampler_2 = tmpvar_5;
  LerpChannelA_1 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_1 = MainTexSampler_2.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_1 = MainTexSampler_2.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_1 = MainTexSampler_2.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_1 = MainTexSampler_2.w;
        };
      };
    };
  };
  o_3.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, vec3(LerpChannelA_1));
  o_3.xyz = (o_3.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_3.w = (xlv_COLOR.w * MainTexSampler_2.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_3.w = (o_3.w * MainTexSampler_2.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_3.w = (o_3.w * MainTexSampler_2.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_3.w = (o_3.w * MainTexSampler_2.w);
        };
      };
    };
  };
  o_3.w = clamp (o_3.w, 0.0, 1.0);
  gl_FragData[0] = o_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float LerpChannelA_1;
  mediump vec4 MainTexSampler_2;
  mediump vec4 o_3;
  o_3 = xlv_COLOR;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, tmpvar_4);
  MainTexSampler_2 = tmpvar_5;
  LerpChannelA_1 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_1 = MainTexSampler_2.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_1 = MainTexSampler_2.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_1 = MainTexSampler_2.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_1 = MainTexSampler_2.w;
        };
      };
    };
  };
  o_3.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, vec3(LerpChannelA_1));
  o_3.xyz = (o_3.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_3.w = (xlv_COLOR.w * MainTexSampler_2.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_3.w = (o_3.w * MainTexSampler_2.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_3.w = (o_3.w * MainTexSampler_2.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_3.w = (o_3.w * MainTexSampler_2.w);
        };
      };
    };
  };
  o_3.xyz = mix (o_3.xyz, vec3(dot (o_3.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  o_3.w = clamp (o_3.w, 0.0, 1.0);
  gl_FragData[0] = o_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float LerpChannelA_1;
  mediump vec4 MainTexSampler_2;
  mediump vec4 o_3;
  o_3 = xlv_COLOR;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, tmpvar_4);
  MainTexSampler_2 = tmpvar_5;
  LerpChannelA_1 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_1 = MainTexSampler_2.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_1 = MainTexSampler_2.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_1 = MainTexSampler_2.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_1 = MainTexSampler_2.w;
        };
      };
    };
  };
  o_3.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, vec3(LerpChannelA_1));
  o_3.xyz = (o_3.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_3.w = (xlv_COLOR.w * MainTexSampler_2.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_3.w = (o_3.w * MainTexSampler_2.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_3.w = (o_3.w * MainTexSampler_2.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_3.w = (o_3.w * MainTexSampler_2.w);
        };
      };
    };
  };
  o_3.xyz = mix (o_3.xyz, vec3(dot (o_3.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  o_3.w = clamp (o_3.w, 0.0, 1.0);
  gl_FragData[0] = o_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float LerpChannelA_1;
  mediump vec4 MainTexSampler_2;
  mediump vec4 o_3;
  o_3 = xlv_COLOR;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, tmpvar_4);
  MainTexSampler_2 = tmpvar_5;
  LerpChannelA_1 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_1 = MainTexSampler_2.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_1 = MainTexSampler_2.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_1 = MainTexSampler_2.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_1 = MainTexSampler_2.w;
        };
      };
    };
  };
  o_3.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, vec3(LerpChannelA_1));
  o_3.xyz = (o_3.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_3.w = (xlv_COLOR.w * MainTexSampler_2.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_3.w = (o_3.w * MainTexSampler_2.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_3.w = (o_3.w * MainTexSampler_2.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_3.w = (o_3.w * MainTexSampler_2.w);
        };
      };
    };
  };
  o_3.xyz = mix (o_3.xyz, vec3(dot (o_3.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  o_3.w = clamp (o_3.w, 0.0, 1.0);
  gl_FragData[0] = o_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _AlphaChannelMapping;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 ColorB_1;
  mediump float LerpChannelA_2;
  mediump vec4 MainTexSampler_3;
  mediump vec4 o_4;
  o_4 = xlv_COLOR;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, tmpvar_5);
  MainTexSampler_3 = tmpvar_6;
  LerpChannelA_2 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_2 = MainTexSampler_3.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_2 = MainTexSampler_3.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_2 = MainTexSampler_3.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_2 = MainTexSampler_3.w;
        };
      };
    };
  };
  highp vec3 tmpvar_7;
  tmpvar_7.xy = xlv_TEXCOORD0.zw;
  tmpvar_7.z = xlv_TEXCOORD1.x;
  ColorB_1 = tmpvar_7;
  o_4.xyz = mix (ColorB_1, xlv_COLOR.xyz, vec3(LerpChannelA_2));
  o_4.xyz = (o_4.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_4.w = (xlv_COLOR.w * MainTexSampler_3.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_4.w = (o_4.w * MainTexSampler_3.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_4.w = (o_4.w * MainTexSampler_3.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_4.w = (o_4.w * MainTexSampler_3.w);
        };
      };
    };
  };
  o_4.w = clamp (o_4.w, 0.0, 1.0);
  gl_FragData[0] = o_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _AlphaChannelMapping;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 ColorB_1;
  mediump float LerpChannelA_2;
  mediump vec4 MainTexSampler_3;
  mediump vec4 o_4;
  o_4 = xlv_COLOR;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, tmpvar_5);
  MainTexSampler_3 = tmpvar_6;
  LerpChannelA_2 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_2 = MainTexSampler_3.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_2 = MainTexSampler_3.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_2 = MainTexSampler_3.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_2 = MainTexSampler_3.w;
        };
      };
    };
  };
  highp vec3 tmpvar_7;
  tmpvar_7.xy = xlv_TEXCOORD0.zw;
  tmpvar_7.z = xlv_TEXCOORD1.x;
  ColorB_1 = tmpvar_7;
  o_4.xyz = mix (ColorB_1, xlv_COLOR.xyz, vec3(LerpChannelA_2));
  o_4.xyz = (o_4.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_4.w = (xlv_COLOR.w * MainTexSampler_3.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_4.w = (o_4.w * MainTexSampler_3.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_4.w = (o_4.w * MainTexSampler_3.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_4.w = (o_4.w * MainTexSampler_3.w);
        };
      };
    };
  };
  o_4.w = clamp (o_4.w, 0.0, 1.0);
  gl_FragData[0] = o_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _AlphaChannelMapping;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 ColorB_1;
  mediump float LerpChannelA_2;
  mediump vec4 MainTexSampler_3;
  mediump vec4 o_4;
  o_4 = xlv_COLOR;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, tmpvar_5);
  MainTexSampler_3 = tmpvar_6;
  LerpChannelA_2 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_2 = MainTexSampler_3.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_2 = MainTexSampler_3.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_2 = MainTexSampler_3.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_2 = MainTexSampler_3.w;
        };
      };
    };
  };
  highp vec3 tmpvar_7;
  tmpvar_7.xy = xlv_TEXCOORD0.zw;
  tmpvar_7.z = xlv_TEXCOORD1.x;
  ColorB_1 = tmpvar_7;
  o_4.xyz = mix (ColorB_1, xlv_COLOR.xyz, vec3(LerpChannelA_2));
  o_4.xyz = (o_4.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_4.w = (xlv_COLOR.w * MainTexSampler_3.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_4.w = (o_4.w * MainTexSampler_3.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_4.w = (o_4.w * MainTexSampler_3.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_4.w = (o_4.w * MainTexSampler_3.w);
        };
      };
    };
  };
  o_4.w = clamp (o_4.w, 0.0, 1.0);
  gl_FragData[0] = o_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _AlphaChannelMapping;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 ColorB_1;
  mediump float LerpChannelA_2;
  mediump vec4 MainTexSampler_3;
  mediump vec4 o_4;
  o_4 = xlv_COLOR;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, tmpvar_5);
  MainTexSampler_3 = tmpvar_6;
  LerpChannelA_2 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_2 = MainTexSampler_3.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_2 = MainTexSampler_3.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_2 = MainTexSampler_3.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_2 = MainTexSampler_3.w;
        };
      };
    };
  };
  highp vec3 tmpvar_7;
  tmpvar_7.xy = xlv_TEXCOORD0.zw;
  tmpvar_7.z = xlv_TEXCOORD1.x;
  ColorB_1 = tmpvar_7;
  o_4.xyz = mix (ColorB_1, xlv_COLOR.xyz, vec3(LerpChannelA_2));
  o_4.xyz = (o_4.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_4.w = (xlv_COLOR.w * MainTexSampler_3.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_4.w = (o_4.w * MainTexSampler_3.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_4.w = (o_4.w * MainTexSampler_3.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_4.w = (o_4.w * MainTexSampler_3.w);
        };
      };
    };
  };
  o_4.xyz = mix (o_4.xyz, vec3(dot (o_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  o_4.w = clamp (o_4.w, 0.0, 1.0);
  gl_FragData[0] = o_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _AlphaChannelMapping;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 ColorB_1;
  mediump float LerpChannelA_2;
  mediump vec4 MainTexSampler_3;
  mediump vec4 o_4;
  o_4 = xlv_COLOR;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, tmpvar_5);
  MainTexSampler_3 = tmpvar_6;
  LerpChannelA_2 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_2 = MainTexSampler_3.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_2 = MainTexSampler_3.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_2 = MainTexSampler_3.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_2 = MainTexSampler_3.w;
        };
      };
    };
  };
  highp vec3 tmpvar_7;
  tmpvar_7.xy = xlv_TEXCOORD0.zw;
  tmpvar_7.z = xlv_TEXCOORD1.x;
  ColorB_1 = tmpvar_7;
  o_4.xyz = mix (ColorB_1, xlv_COLOR.xyz, vec3(LerpChannelA_2));
  o_4.xyz = (o_4.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_4.w = (xlv_COLOR.w * MainTexSampler_3.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_4.w = (o_4.w * MainTexSampler_3.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_4.w = (o_4.w * MainTexSampler_3.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_4.w = (o_4.w * MainTexSampler_3.w);
        };
      };
    };
  };
  o_4.xyz = mix (o_4.xyz, vec3(dot (o_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  o_4.w = clamp (o_4.w, 0.0, 1.0);
  gl_FragData[0] = o_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _AlphaChannelMapping;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 ColorB_1;
  mediump float LerpChannelA_2;
  mediump vec4 MainTexSampler_3;
  mediump vec4 o_4;
  o_4 = xlv_COLOR;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, tmpvar_5);
  MainTexSampler_3 = tmpvar_6;
  LerpChannelA_2 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_2 = MainTexSampler_3.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_2 = MainTexSampler_3.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_2 = MainTexSampler_3.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_2 = MainTexSampler_3.w;
        };
      };
    };
  };
  highp vec3 tmpvar_7;
  tmpvar_7.xy = xlv_TEXCOORD0.zw;
  tmpvar_7.z = xlv_TEXCOORD1.x;
  ColorB_1 = tmpvar_7;
  o_4.xyz = mix (ColorB_1, xlv_COLOR.xyz, vec3(LerpChannelA_2));
  o_4.xyz = (o_4.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_4.w = (xlv_COLOR.w * MainTexSampler_3.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_4.w = (o_4.w * MainTexSampler_3.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_4.w = (o_4.w * MainTexSampler_3.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_4.w = (o_4.w * MainTexSampler_3.w);
        };
      };
    };
  };
  o_4.xyz = mix (o_4.xyz, vec3(dot (o_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  o_4.w = clamp (o_4.w, 0.0, 1.0);
  gl_FragData[0] = o_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _AlphaChannelMapping;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 ColorB_1;
  mediump float LerpChannelA_2;
  mediump vec4 MainTexSampler_3;
  mediump vec4 o_4;
  o_4 = xlv_COLOR;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, tmpvar_5);
  MainTexSampler_3 = tmpvar_6;
  LerpChannelA_2 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_2 = MainTexSampler_3.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_2 = MainTexSampler_3.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_2 = MainTexSampler_3.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_2 = MainTexSampler_3.w;
        };
      };
    };
  };
  highp vec3 tmpvar_7;
  tmpvar_7.xy = xlv_TEXCOORD0.zw;
  tmpvar_7.z = xlv_TEXCOORD1.x;
  ColorB_1 = tmpvar_7;
  o_4.xyz = mix (ColorB_1, xlv_COLOR.xyz, vec3(LerpChannelA_2));
  o_4.xyz = (o_4.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_4.w = (xlv_COLOR.w * MainTexSampler_3.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_4.w = (o_4.w * MainTexSampler_3.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_4.w = (o_4.w * MainTexSampler_3.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_4.w = (o_4.w * MainTexSampler_3.w);
        };
      };
    };
  };
  o_4.w = clamp (o_4.w, 0.0, 1.0);
  gl_FragData[0] = o_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _AlphaChannelMapping;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 ColorB_1;
  mediump float LerpChannelA_2;
  mediump vec4 MainTexSampler_3;
  mediump vec4 o_4;
  o_4 = xlv_COLOR;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, tmpvar_5);
  MainTexSampler_3 = tmpvar_6;
  LerpChannelA_2 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_2 = MainTexSampler_3.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_2 = MainTexSampler_3.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_2 = MainTexSampler_3.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_2 = MainTexSampler_3.w;
        };
      };
    };
  };
  highp vec3 tmpvar_7;
  tmpvar_7.xy = xlv_TEXCOORD0.zw;
  tmpvar_7.z = xlv_TEXCOORD1.x;
  ColorB_1 = tmpvar_7;
  o_4.xyz = mix (ColorB_1, xlv_COLOR.xyz, vec3(LerpChannelA_2));
  o_4.xyz = (o_4.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_4.w = (xlv_COLOR.w * MainTexSampler_3.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_4.w = (o_4.w * MainTexSampler_3.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_4.w = (o_4.w * MainTexSampler_3.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_4.w = (o_4.w * MainTexSampler_3.w);
        };
      };
    };
  };
  o_4.w = clamp (o_4.w, 0.0, 1.0);
  gl_FragData[0] = o_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _AlphaChannelMapping;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 ColorB_1;
  mediump float LerpChannelA_2;
  mediump vec4 MainTexSampler_3;
  mediump vec4 o_4;
  o_4 = xlv_COLOR;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, tmpvar_5);
  MainTexSampler_3 = tmpvar_6;
  LerpChannelA_2 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_2 = MainTexSampler_3.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_2 = MainTexSampler_3.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_2 = MainTexSampler_3.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_2 = MainTexSampler_3.w;
        };
      };
    };
  };
  highp vec3 tmpvar_7;
  tmpvar_7.xy = xlv_TEXCOORD0.zw;
  tmpvar_7.z = xlv_TEXCOORD1.x;
  ColorB_1 = tmpvar_7;
  o_4.xyz = mix (ColorB_1, xlv_COLOR.xyz, vec3(LerpChannelA_2));
  o_4.xyz = (o_4.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_4.w = (xlv_COLOR.w * MainTexSampler_3.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_4.w = (o_4.w * MainTexSampler_3.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_4.w = (o_4.w * MainTexSampler_3.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_4.w = (o_4.w * MainTexSampler_3.w);
        };
      };
    };
  };
  o_4.w = clamp (o_4.w, 0.0, 1.0);
  gl_FragData[0] = o_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _AlphaChannelMapping;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 ColorB_1;
  mediump float LerpChannelA_2;
  mediump vec4 MainTexSampler_3;
  mediump vec4 o_4;
  o_4 = xlv_COLOR;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, tmpvar_5);
  MainTexSampler_3 = tmpvar_6;
  LerpChannelA_2 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_2 = MainTexSampler_3.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_2 = MainTexSampler_3.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_2 = MainTexSampler_3.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_2 = MainTexSampler_3.w;
        };
      };
    };
  };
  highp vec3 tmpvar_7;
  tmpvar_7.xy = xlv_TEXCOORD0.zw;
  tmpvar_7.z = xlv_TEXCOORD1.x;
  ColorB_1 = tmpvar_7;
  o_4.xyz = mix (ColorB_1, xlv_COLOR.xyz, vec3(LerpChannelA_2));
  o_4.xyz = (o_4.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_4.w = (xlv_COLOR.w * MainTexSampler_3.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_4.w = (o_4.w * MainTexSampler_3.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_4.w = (o_4.w * MainTexSampler_3.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_4.w = (o_4.w * MainTexSampler_3.w);
        };
      };
    };
  };
  o_4.xyz = mix (o_4.xyz, vec3(dot (o_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  o_4.w = clamp (o_4.w, 0.0, 1.0);
  gl_FragData[0] = o_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _AlphaChannelMapping;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 ColorB_1;
  mediump float LerpChannelA_2;
  mediump vec4 MainTexSampler_3;
  mediump vec4 o_4;
  o_4 = xlv_COLOR;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, tmpvar_5);
  MainTexSampler_3 = tmpvar_6;
  LerpChannelA_2 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_2 = MainTexSampler_3.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_2 = MainTexSampler_3.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_2 = MainTexSampler_3.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_2 = MainTexSampler_3.w;
        };
      };
    };
  };
  highp vec3 tmpvar_7;
  tmpvar_7.xy = xlv_TEXCOORD0.zw;
  tmpvar_7.z = xlv_TEXCOORD1.x;
  ColorB_1 = tmpvar_7;
  o_4.xyz = mix (ColorB_1, xlv_COLOR.xyz, vec3(LerpChannelA_2));
  o_4.xyz = (o_4.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_4.w = (xlv_COLOR.w * MainTexSampler_3.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_4.w = (o_4.w * MainTexSampler_3.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_4.w = (o_4.w * MainTexSampler_3.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_4.w = (o_4.w * MainTexSampler_3.w);
        };
      };
    };
  };
  o_4.xyz = mix (o_4.xyz, vec3(dot (o_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  o_4.w = clamp (o_4.w, 0.0, 1.0);
  gl_FragData[0] = o_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _AlphaChannelMapping;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 ColorB_1;
  mediump float LerpChannelA_2;
  mediump vec4 MainTexSampler_3;
  mediump vec4 o_4;
  o_4 = xlv_COLOR;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, tmpvar_5);
  MainTexSampler_3 = tmpvar_6;
  LerpChannelA_2 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_2 = MainTexSampler_3.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_2 = MainTexSampler_3.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_2 = MainTexSampler_3.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_2 = MainTexSampler_3.w;
        };
      };
    };
  };
  highp vec3 tmpvar_7;
  tmpvar_7.xy = xlv_TEXCOORD0.zw;
  tmpvar_7.z = xlv_TEXCOORD1.x;
  ColorB_1 = tmpvar_7;
  o_4.xyz = mix (ColorB_1, xlv_COLOR.xyz, vec3(LerpChannelA_2));
  o_4.xyz = (o_4.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_4.w = (xlv_COLOR.w * MainTexSampler_3.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_4.w = (o_4.w * MainTexSampler_3.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_4.w = (o_4.w * MainTexSampler_3.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_4.w = (o_4.w * MainTexSampler_3.w);
        };
      };
    };
  };
  o_4.xyz = mix (o_4.xyz, vec3(dot (o_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  o_4.w = clamp (o_4.w, 0.0, 1.0);
  gl_FragData[0] = o_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_COLORCTOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _LerpChannelBMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float LerpChannelB_1;
  mediump float LerpChannelA_2;
  mediump vec4 MainTexSampler_3;
  mediump vec4 o_4;
  o_4 = xlv_COLOR;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, tmpvar_5);
  MainTexSampler_3 = tmpvar_6;
  LerpChannelA_2 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_2 = MainTexSampler_3.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_2 = MainTexSampler_3.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_2 = MainTexSampler_3.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_2 = MainTexSampler_3.w;
        };
      };
    };
  };
  o_4.xyz = (xlv_COLOR.xyz * mix (_ColorB.xyz, _ColorA.xyz, vec3(LerpChannelA_2)));
  LerpChannelB_1 = 0.0;
  if ((_LerpChannelBMapping == 0.0)) {
    LerpChannelB_1 = MainTexSampler_3.x;
  } else {
    if ((_LerpChannelBMapping == 1.0)) {
      LerpChannelB_1 = MainTexSampler_3.y;
    } else {
      if ((_LerpChannelBMapping == 2.0)) {
        LerpChannelB_1 = MainTexSampler_3.z;
      } else {
        if ((_LerpChannelBMapping == 3.0)) {
          LerpChannelB_1 = MainTexSampler_3.w;
        };
      };
    };
  };
  o_4.xyz = mix (_ColorC.xyz, o_4.xyz, vec3(LerpChannelB_1));
  o_4.xyz = (o_4.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_4.w = (xlv_COLOR.w * MainTexSampler_3.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_4.w = (o_4.w * MainTexSampler_3.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_4.w = (o_4.w * MainTexSampler_3.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_4.w = (o_4.w * MainTexSampler_3.w);
        };
      };
    };
  };
  o_4.w = clamp (o_4.w, 0.0, 1.0);
  gl_FragData[0] = o_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_COLORCTOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _LerpChannelBMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float LerpChannelB_1;
  mediump float LerpChannelA_2;
  mediump vec4 MainTexSampler_3;
  mediump vec4 o_4;
  o_4 = xlv_COLOR;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, tmpvar_5);
  MainTexSampler_3 = tmpvar_6;
  LerpChannelA_2 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_2 = MainTexSampler_3.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_2 = MainTexSampler_3.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_2 = MainTexSampler_3.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_2 = MainTexSampler_3.w;
        };
      };
    };
  };
  o_4.xyz = (xlv_COLOR.xyz * mix (_ColorB.xyz, _ColorA.xyz, vec3(LerpChannelA_2)));
  LerpChannelB_1 = 0.0;
  if ((_LerpChannelBMapping == 0.0)) {
    LerpChannelB_1 = MainTexSampler_3.x;
  } else {
    if ((_LerpChannelBMapping == 1.0)) {
      LerpChannelB_1 = MainTexSampler_3.y;
    } else {
      if ((_LerpChannelBMapping == 2.0)) {
        LerpChannelB_1 = MainTexSampler_3.z;
      } else {
        if ((_LerpChannelBMapping == 3.0)) {
          LerpChannelB_1 = MainTexSampler_3.w;
        };
      };
    };
  };
  o_4.xyz = mix (_ColorC.xyz, o_4.xyz, vec3(LerpChannelB_1));
  o_4.xyz = (o_4.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_4.w = (xlv_COLOR.w * MainTexSampler_3.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_4.w = (o_4.w * MainTexSampler_3.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_4.w = (o_4.w * MainTexSampler_3.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_4.w = (o_4.w * MainTexSampler_3.w);
        };
      };
    };
  };
  o_4.w = clamp (o_4.w, 0.0, 1.0);
  gl_FragData[0] = o_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_COLORCTOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _LerpChannelBMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float LerpChannelB_1;
  mediump float LerpChannelA_2;
  mediump vec4 MainTexSampler_3;
  mediump vec4 o_4;
  o_4 = xlv_COLOR;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, tmpvar_5);
  MainTexSampler_3 = tmpvar_6;
  LerpChannelA_2 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_2 = MainTexSampler_3.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_2 = MainTexSampler_3.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_2 = MainTexSampler_3.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_2 = MainTexSampler_3.w;
        };
      };
    };
  };
  o_4.xyz = (xlv_COLOR.xyz * mix (_ColorB.xyz, _ColorA.xyz, vec3(LerpChannelA_2)));
  LerpChannelB_1 = 0.0;
  if ((_LerpChannelBMapping == 0.0)) {
    LerpChannelB_1 = MainTexSampler_3.x;
  } else {
    if ((_LerpChannelBMapping == 1.0)) {
      LerpChannelB_1 = MainTexSampler_3.y;
    } else {
      if ((_LerpChannelBMapping == 2.0)) {
        LerpChannelB_1 = MainTexSampler_3.z;
      } else {
        if ((_LerpChannelBMapping == 3.0)) {
          LerpChannelB_1 = MainTexSampler_3.w;
        };
      };
    };
  };
  o_4.xyz = mix (_ColorC.xyz, o_4.xyz, vec3(LerpChannelB_1));
  o_4.xyz = (o_4.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_4.w = (xlv_COLOR.w * MainTexSampler_3.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_4.w = (o_4.w * MainTexSampler_3.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_4.w = (o_4.w * MainTexSampler_3.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_4.w = (o_4.w * MainTexSampler_3.w);
        };
      };
    };
  };
  o_4.w = clamp (o_4.w, 0.0, 1.0);
  gl_FragData[0] = o_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _LerpChannelBMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float LerpChannelB_1;
  mediump float LerpChannelA_2;
  mediump vec4 MainTexSampler_3;
  mediump vec4 o_4;
  o_4 = xlv_COLOR;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, tmpvar_5);
  MainTexSampler_3 = tmpvar_6;
  LerpChannelA_2 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_2 = MainTexSampler_3.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_2 = MainTexSampler_3.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_2 = MainTexSampler_3.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_2 = MainTexSampler_3.w;
        };
      };
    };
  };
  o_4.xyz = (xlv_COLOR.xyz * mix (_ColorB.xyz, _ColorA.xyz, vec3(LerpChannelA_2)));
  LerpChannelB_1 = 0.0;
  if ((_LerpChannelBMapping == 0.0)) {
    LerpChannelB_1 = MainTexSampler_3.x;
  } else {
    if ((_LerpChannelBMapping == 1.0)) {
      LerpChannelB_1 = MainTexSampler_3.y;
    } else {
      if ((_LerpChannelBMapping == 2.0)) {
        LerpChannelB_1 = MainTexSampler_3.z;
      } else {
        if ((_LerpChannelBMapping == 3.0)) {
          LerpChannelB_1 = MainTexSampler_3.w;
        };
      };
    };
  };
  o_4.xyz = mix (_ColorC.xyz, o_4.xyz, vec3(LerpChannelB_1));
  o_4.xyz = (o_4.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_4.w = (xlv_COLOR.w * MainTexSampler_3.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_4.w = (o_4.w * MainTexSampler_3.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_4.w = (o_4.w * MainTexSampler_3.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_4.w = (o_4.w * MainTexSampler_3.w);
        };
      };
    };
  };
  o_4.xyz = mix (o_4.xyz, vec3(dot (o_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  o_4.w = clamp (o_4.w, 0.0, 1.0);
  gl_FragData[0] = o_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _LerpChannelBMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float LerpChannelB_1;
  mediump float LerpChannelA_2;
  mediump vec4 MainTexSampler_3;
  mediump vec4 o_4;
  o_4 = xlv_COLOR;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, tmpvar_5);
  MainTexSampler_3 = tmpvar_6;
  LerpChannelA_2 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_2 = MainTexSampler_3.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_2 = MainTexSampler_3.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_2 = MainTexSampler_3.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_2 = MainTexSampler_3.w;
        };
      };
    };
  };
  o_4.xyz = (xlv_COLOR.xyz * mix (_ColorB.xyz, _ColorA.xyz, vec3(LerpChannelA_2)));
  LerpChannelB_1 = 0.0;
  if ((_LerpChannelBMapping == 0.0)) {
    LerpChannelB_1 = MainTexSampler_3.x;
  } else {
    if ((_LerpChannelBMapping == 1.0)) {
      LerpChannelB_1 = MainTexSampler_3.y;
    } else {
      if ((_LerpChannelBMapping == 2.0)) {
        LerpChannelB_1 = MainTexSampler_3.z;
      } else {
        if ((_LerpChannelBMapping == 3.0)) {
          LerpChannelB_1 = MainTexSampler_3.w;
        };
      };
    };
  };
  o_4.xyz = mix (_ColorC.xyz, o_4.xyz, vec3(LerpChannelB_1));
  o_4.xyz = (o_4.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_4.w = (xlv_COLOR.w * MainTexSampler_3.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_4.w = (o_4.w * MainTexSampler_3.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_4.w = (o_4.w * MainTexSampler_3.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_4.w = (o_4.w * MainTexSampler_3.w);
        };
      };
    };
  };
  o_4.xyz = mix (o_4.xyz, vec3(dot (o_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  o_4.w = clamp (o_4.w, 0.0, 1.0);
  gl_FragData[0] = o_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _LerpChannelBMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float LerpChannelB_1;
  mediump float LerpChannelA_2;
  mediump vec4 MainTexSampler_3;
  mediump vec4 o_4;
  o_4 = xlv_COLOR;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, tmpvar_5);
  MainTexSampler_3 = tmpvar_6;
  LerpChannelA_2 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_2 = MainTexSampler_3.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_2 = MainTexSampler_3.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_2 = MainTexSampler_3.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_2 = MainTexSampler_3.w;
        };
      };
    };
  };
  o_4.xyz = (xlv_COLOR.xyz * mix (_ColorB.xyz, _ColorA.xyz, vec3(LerpChannelA_2)));
  LerpChannelB_1 = 0.0;
  if ((_LerpChannelBMapping == 0.0)) {
    LerpChannelB_1 = MainTexSampler_3.x;
  } else {
    if ((_LerpChannelBMapping == 1.0)) {
      LerpChannelB_1 = MainTexSampler_3.y;
    } else {
      if ((_LerpChannelBMapping == 2.0)) {
        LerpChannelB_1 = MainTexSampler_3.z;
      } else {
        if ((_LerpChannelBMapping == 3.0)) {
          LerpChannelB_1 = MainTexSampler_3.w;
        };
      };
    };
  };
  o_4.xyz = mix (_ColorC.xyz, o_4.xyz, vec3(LerpChannelB_1));
  o_4.xyz = (o_4.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_4.w = (xlv_COLOR.w * MainTexSampler_3.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_4.w = (o_4.w * MainTexSampler_3.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_4.w = (o_4.w * MainTexSampler_3.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_4.w = (o_4.w * MainTexSampler_3.w);
        };
      };
    };
  };
  o_4.xyz = mix (o_4.xyz, vec3(dot (o_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  o_4.w = clamp (o_4.w, 0.0, 1.0);
  gl_FragData[0] = o_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_COLORCTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _LerpChannelBMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float LerpChannelB_1;
  mediump vec3 ColorC_2;
  mediump float LerpChannelA_3;
  mediump vec4 MainTexSampler_4;
  mediump vec4 o_5;
  o_5 = xlv_COLOR;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, tmpvar_6);
  MainTexSampler_4 = tmpvar_7;
  LerpChannelA_3 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_3 = MainTexSampler_4.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_3 = MainTexSampler_4.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_3 = MainTexSampler_4.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_3 = MainTexSampler_4.w;
        };
      };
    };
  };
  o_5.xyz = (xlv_COLOR.xyz * mix (_ColorB.xyz, _ColorA.xyz, vec3(LerpChannelA_3)));
  ColorC_2 = xlv_TEXCOORD1.yzw;
  LerpChannelB_1 = 0.0;
  if ((_LerpChannelBMapping == 0.0)) {
    LerpChannelB_1 = MainTexSampler_4.x;
  } else {
    if ((_LerpChannelBMapping == 1.0)) {
      LerpChannelB_1 = MainTexSampler_4.y;
    } else {
      if ((_LerpChannelBMapping == 2.0)) {
        LerpChannelB_1 = MainTexSampler_4.z;
      } else {
        if ((_LerpChannelBMapping == 3.0)) {
          LerpChannelB_1 = MainTexSampler_4.w;
        };
      };
    };
  };
  o_5.xyz = mix (ColorC_2, o_5.xyz, vec3(LerpChannelB_1));
  o_5.xyz = (o_5.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_5.w = (xlv_COLOR.w * MainTexSampler_4.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_5.w = (o_5.w * MainTexSampler_4.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_5.w = (o_5.w * MainTexSampler_4.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_5.w = (o_5.w * MainTexSampler_4.w);
        };
      };
    };
  };
  o_5.w = clamp (o_5.w, 0.0, 1.0);
  gl_FragData[0] = o_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_COLORCTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _LerpChannelBMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float LerpChannelB_1;
  mediump vec3 ColorC_2;
  mediump float LerpChannelA_3;
  mediump vec4 MainTexSampler_4;
  mediump vec4 o_5;
  o_5 = xlv_COLOR;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, tmpvar_6);
  MainTexSampler_4 = tmpvar_7;
  LerpChannelA_3 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_3 = MainTexSampler_4.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_3 = MainTexSampler_4.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_3 = MainTexSampler_4.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_3 = MainTexSampler_4.w;
        };
      };
    };
  };
  o_5.xyz = (xlv_COLOR.xyz * mix (_ColorB.xyz, _ColorA.xyz, vec3(LerpChannelA_3)));
  ColorC_2 = xlv_TEXCOORD1.yzw;
  LerpChannelB_1 = 0.0;
  if ((_LerpChannelBMapping == 0.0)) {
    LerpChannelB_1 = MainTexSampler_4.x;
  } else {
    if ((_LerpChannelBMapping == 1.0)) {
      LerpChannelB_1 = MainTexSampler_4.y;
    } else {
      if ((_LerpChannelBMapping == 2.0)) {
        LerpChannelB_1 = MainTexSampler_4.z;
      } else {
        if ((_LerpChannelBMapping == 3.0)) {
          LerpChannelB_1 = MainTexSampler_4.w;
        };
      };
    };
  };
  o_5.xyz = mix (ColorC_2, o_5.xyz, vec3(LerpChannelB_1));
  o_5.xyz = (o_5.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_5.w = (xlv_COLOR.w * MainTexSampler_4.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_5.w = (o_5.w * MainTexSampler_4.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_5.w = (o_5.w * MainTexSampler_4.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_5.w = (o_5.w * MainTexSampler_4.w);
        };
      };
    };
  };
  o_5.w = clamp (o_5.w, 0.0, 1.0);
  gl_FragData[0] = o_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_COLORCTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _LerpChannelBMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float LerpChannelB_1;
  mediump vec3 ColorC_2;
  mediump float LerpChannelA_3;
  mediump vec4 MainTexSampler_4;
  mediump vec4 o_5;
  o_5 = xlv_COLOR;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, tmpvar_6);
  MainTexSampler_4 = tmpvar_7;
  LerpChannelA_3 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_3 = MainTexSampler_4.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_3 = MainTexSampler_4.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_3 = MainTexSampler_4.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_3 = MainTexSampler_4.w;
        };
      };
    };
  };
  o_5.xyz = (xlv_COLOR.xyz * mix (_ColorB.xyz, _ColorA.xyz, vec3(LerpChannelA_3)));
  ColorC_2 = xlv_TEXCOORD1.yzw;
  LerpChannelB_1 = 0.0;
  if ((_LerpChannelBMapping == 0.0)) {
    LerpChannelB_1 = MainTexSampler_4.x;
  } else {
    if ((_LerpChannelBMapping == 1.0)) {
      LerpChannelB_1 = MainTexSampler_4.y;
    } else {
      if ((_LerpChannelBMapping == 2.0)) {
        LerpChannelB_1 = MainTexSampler_4.z;
      } else {
        if ((_LerpChannelBMapping == 3.0)) {
          LerpChannelB_1 = MainTexSampler_4.w;
        };
      };
    };
  };
  o_5.xyz = mix (ColorC_2, o_5.xyz, vec3(LerpChannelB_1));
  o_5.xyz = (o_5.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_5.w = (xlv_COLOR.w * MainTexSampler_4.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_5.w = (o_5.w * MainTexSampler_4.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_5.w = (o_5.w * MainTexSampler_4.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_5.w = (o_5.w * MainTexSampler_4.w);
        };
      };
    };
  };
  o_5.w = clamp (o_5.w, 0.0, 1.0);
  gl_FragData[0] = o_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _LerpChannelBMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float LerpChannelB_1;
  mediump vec3 ColorC_2;
  mediump float LerpChannelA_3;
  mediump vec4 MainTexSampler_4;
  mediump vec4 o_5;
  o_5 = xlv_COLOR;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, tmpvar_6);
  MainTexSampler_4 = tmpvar_7;
  LerpChannelA_3 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_3 = MainTexSampler_4.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_3 = MainTexSampler_4.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_3 = MainTexSampler_4.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_3 = MainTexSampler_4.w;
        };
      };
    };
  };
  o_5.xyz = (xlv_COLOR.xyz * mix (_ColorB.xyz, _ColorA.xyz, vec3(LerpChannelA_3)));
  ColorC_2 = xlv_TEXCOORD1.yzw;
  LerpChannelB_1 = 0.0;
  if ((_LerpChannelBMapping == 0.0)) {
    LerpChannelB_1 = MainTexSampler_4.x;
  } else {
    if ((_LerpChannelBMapping == 1.0)) {
      LerpChannelB_1 = MainTexSampler_4.y;
    } else {
      if ((_LerpChannelBMapping == 2.0)) {
        LerpChannelB_1 = MainTexSampler_4.z;
      } else {
        if ((_LerpChannelBMapping == 3.0)) {
          LerpChannelB_1 = MainTexSampler_4.w;
        };
      };
    };
  };
  o_5.xyz = mix (ColorC_2, o_5.xyz, vec3(LerpChannelB_1));
  o_5.xyz = (o_5.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_5.w = (xlv_COLOR.w * MainTexSampler_4.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_5.w = (o_5.w * MainTexSampler_4.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_5.w = (o_5.w * MainTexSampler_4.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_5.w = (o_5.w * MainTexSampler_4.w);
        };
      };
    };
  };
  o_5.xyz = mix (o_5.xyz, vec3(dot (o_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  o_5.w = clamp (o_5.w, 0.0, 1.0);
  gl_FragData[0] = o_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _LerpChannelBMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float LerpChannelB_1;
  mediump vec3 ColorC_2;
  mediump float LerpChannelA_3;
  mediump vec4 MainTexSampler_4;
  mediump vec4 o_5;
  o_5 = xlv_COLOR;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, tmpvar_6);
  MainTexSampler_4 = tmpvar_7;
  LerpChannelA_3 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_3 = MainTexSampler_4.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_3 = MainTexSampler_4.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_3 = MainTexSampler_4.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_3 = MainTexSampler_4.w;
        };
      };
    };
  };
  o_5.xyz = (xlv_COLOR.xyz * mix (_ColorB.xyz, _ColorA.xyz, vec3(LerpChannelA_3)));
  ColorC_2 = xlv_TEXCOORD1.yzw;
  LerpChannelB_1 = 0.0;
  if ((_LerpChannelBMapping == 0.0)) {
    LerpChannelB_1 = MainTexSampler_4.x;
  } else {
    if ((_LerpChannelBMapping == 1.0)) {
      LerpChannelB_1 = MainTexSampler_4.y;
    } else {
      if ((_LerpChannelBMapping == 2.0)) {
        LerpChannelB_1 = MainTexSampler_4.z;
      } else {
        if ((_LerpChannelBMapping == 3.0)) {
          LerpChannelB_1 = MainTexSampler_4.w;
        };
      };
    };
  };
  o_5.xyz = mix (ColorC_2, o_5.xyz, vec3(LerpChannelB_1));
  o_5.xyz = (o_5.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_5.w = (xlv_COLOR.w * MainTexSampler_4.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_5.w = (o_5.w * MainTexSampler_4.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_5.w = (o_5.w * MainTexSampler_4.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_5.w = (o_5.w * MainTexSampler_4.w);
        };
      };
    };
  };
  o_5.xyz = mix (o_5.xyz, vec3(dot (o_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  o_5.w = clamp (o_5.w, 0.0, 1.0);
  gl_FragData[0] = o_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _LerpChannelBMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float LerpChannelB_1;
  mediump vec3 ColorC_2;
  mediump float LerpChannelA_3;
  mediump vec4 MainTexSampler_4;
  mediump vec4 o_5;
  o_5 = xlv_COLOR;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, tmpvar_6);
  MainTexSampler_4 = tmpvar_7;
  LerpChannelA_3 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_3 = MainTexSampler_4.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_3 = MainTexSampler_4.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_3 = MainTexSampler_4.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_3 = MainTexSampler_4.w;
        };
      };
    };
  };
  o_5.xyz = (xlv_COLOR.xyz * mix (_ColorB.xyz, _ColorA.xyz, vec3(LerpChannelA_3)));
  ColorC_2 = xlv_TEXCOORD1.yzw;
  LerpChannelB_1 = 0.0;
  if ((_LerpChannelBMapping == 0.0)) {
    LerpChannelB_1 = MainTexSampler_4.x;
  } else {
    if ((_LerpChannelBMapping == 1.0)) {
      LerpChannelB_1 = MainTexSampler_4.y;
    } else {
      if ((_LerpChannelBMapping == 2.0)) {
        LerpChannelB_1 = MainTexSampler_4.z;
      } else {
        if ((_LerpChannelBMapping == 3.0)) {
          LerpChannelB_1 = MainTexSampler_4.w;
        };
      };
    };
  };
  o_5.xyz = mix (ColorC_2, o_5.xyz, vec3(LerpChannelB_1));
  o_5.xyz = (o_5.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_5.w = (xlv_COLOR.w * MainTexSampler_4.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_5.w = (o_5.w * MainTexSampler_4.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_5.w = (o_5.w * MainTexSampler_4.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_5.w = (o_5.w * MainTexSampler_4.w);
        };
      };
    };
  };
  o_5.xyz = mix (o_5.xyz, vec3(dot (o_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  o_5.w = clamp (o_5.w, 0.0, 1.0);
  gl_FragData[0] = o_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_COLORCTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _LerpChannelBMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float LerpChannelB_1;
  mediump vec3 ColorB_2;
  mediump float LerpChannelA_3;
  mediump vec4 MainTexSampler_4;
  mediump vec4 o_5;
  o_5 = xlv_COLOR;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, tmpvar_6);
  MainTexSampler_4 = tmpvar_7;
  LerpChannelA_3 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_3 = MainTexSampler_4.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_3 = MainTexSampler_4.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_3 = MainTexSampler_4.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_3 = MainTexSampler_4.w;
        };
      };
    };
  };
  highp vec3 tmpvar_8;
  tmpvar_8.xy = xlv_TEXCOORD0.zw;
  tmpvar_8.z = xlv_TEXCOORD1.x;
  ColorB_2 = tmpvar_8;
  o_5.xyz = (xlv_COLOR.xyz * mix (ColorB_2, _ColorA.xyz, vec3(LerpChannelA_3)));
  LerpChannelB_1 = 0.0;
  if ((_LerpChannelBMapping == 0.0)) {
    LerpChannelB_1 = MainTexSampler_4.x;
  } else {
    if ((_LerpChannelBMapping == 1.0)) {
      LerpChannelB_1 = MainTexSampler_4.y;
    } else {
      if ((_LerpChannelBMapping == 2.0)) {
        LerpChannelB_1 = MainTexSampler_4.z;
      } else {
        if ((_LerpChannelBMapping == 3.0)) {
          LerpChannelB_1 = MainTexSampler_4.w;
        };
      };
    };
  };
  o_5.xyz = mix (_ColorC.xyz, o_5.xyz, vec3(LerpChannelB_1));
  o_5.xyz = (o_5.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_5.w = (xlv_COLOR.w * MainTexSampler_4.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_5.w = (o_5.w * MainTexSampler_4.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_5.w = (o_5.w * MainTexSampler_4.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_5.w = (o_5.w * MainTexSampler_4.w);
        };
      };
    };
  };
  o_5.w = clamp (o_5.w, 0.0, 1.0);
  gl_FragData[0] = o_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_COLORCTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _LerpChannelBMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float LerpChannelB_1;
  mediump vec3 ColorB_2;
  mediump float LerpChannelA_3;
  mediump vec4 MainTexSampler_4;
  mediump vec4 o_5;
  o_5 = xlv_COLOR;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, tmpvar_6);
  MainTexSampler_4 = tmpvar_7;
  LerpChannelA_3 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_3 = MainTexSampler_4.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_3 = MainTexSampler_4.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_3 = MainTexSampler_4.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_3 = MainTexSampler_4.w;
        };
      };
    };
  };
  highp vec3 tmpvar_8;
  tmpvar_8.xy = xlv_TEXCOORD0.zw;
  tmpvar_8.z = xlv_TEXCOORD1.x;
  ColorB_2 = tmpvar_8;
  o_5.xyz = (xlv_COLOR.xyz * mix (ColorB_2, _ColorA.xyz, vec3(LerpChannelA_3)));
  LerpChannelB_1 = 0.0;
  if ((_LerpChannelBMapping == 0.0)) {
    LerpChannelB_1 = MainTexSampler_4.x;
  } else {
    if ((_LerpChannelBMapping == 1.0)) {
      LerpChannelB_1 = MainTexSampler_4.y;
    } else {
      if ((_LerpChannelBMapping == 2.0)) {
        LerpChannelB_1 = MainTexSampler_4.z;
      } else {
        if ((_LerpChannelBMapping == 3.0)) {
          LerpChannelB_1 = MainTexSampler_4.w;
        };
      };
    };
  };
  o_5.xyz = mix (_ColorC.xyz, o_5.xyz, vec3(LerpChannelB_1));
  o_5.xyz = (o_5.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_5.w = (xlv_COLOR.w * MainTexSampler_4.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_5.w = (o_5.w * MainTexSampler_4.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_5.w = (o_5.w * MainTexSampler_4.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_5.w = (o_5.w * MainTexSampler_4.w);
        };
      };
    };
  };
  o_5.w = clamp (o_5.w, 0.0, 1.0);
  gl_FragData[0] = o_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_COLORCTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _LerpChannelBMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float LerpChannelB_1;
  mediump vec3 ColorB_2;
  mediump float LerpChannelA_3;
  mediump vec4 MainTexSampler_4;
  mediump vec4 o_5;
  o_5 = xlv_COLOR;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, tmpvar_6);
  MainTexSampler_4 = tmpvar_7;
  LerpChannelA_3 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_3 = MainTexSampler_4.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_3 = MainTexSampler_4.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_3 = MainTexSampler_4.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_3 = MainTexSampler_4.w;
        };
      };
    };
  };
  highp vec3 tmpvar_8;
  tmpvar_8.xy = xlv_TEXCOORD0.zw;
  tmpvar_8.z = xlv_TEXCOORD1.x;
  ColorB_2 = tmpvar_8;
  o_5.xyz = (xlv_COLOR.xyz * mix (ColorB_2, _ColorA.xyz, vec3(LerpChannelA_3)));
  LerpChannelB_1 = 0.0;
  if ((_LerpChannelBMapping == 0.0)) {
    LerpChannelB_1 = MainTexSampler_4.x;
  } else {
    if ((_LerpChannelBMapping == 1.0)) {
      LerpChannelB_1 = MainTexSampler_4.y;
    } else {
      if ((_LerpChannelBMapping == 2.0)) {
        LerpChannelB_1 = MainTexSampler_4.z;
      } else {
        if ((_LerpChannelBMapping == 3.0)) {
          LerpChannelB_1 = MainTexSampler_4.w;
        };
      };
    };
  };
  o_5.xyz = mix (_ColorC.xyz, o_5.xyz, vec3(LerpChannelB_1));
  o_5.xyz = (o_5.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_5.w = (xlv_COLOR.w * MainTexSampler_4.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_5.w = (o_5.w * MainTexSampler_4.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_5.w = (o_5.w * MainTexSampler_4.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_5.w = (o_5.w * MainTexSampler_4.w);
        };
      };
    };
  };
  o_5.w = clamp (o_5.w, 0.0, 1.0);
  gl_FragData[0] = o_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _LerpChannelBMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float LerpChannelB_1;
  mediump vec3 ColorB_2;
  mediump float LerpChannelA_3;
  mediump vec4 MainTexSampler_4;
  mediump vec4 o_5;
  o_5 = xlv_COLOR;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, tmpvar_6);
  MainTexSampler_4 = tmpvar_7;
  LerpChannelA_3 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_3 = MainTexSampler_4.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_3 = MainTexSampler_4.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_3 = MainTexSampler_4.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_3 = MainTexSampler_4.w;
        };
      };
    };
  };
  highp vec3 tmpvar_8;
  tmpvar_8.xy = xlv_TEXCOORD0.zw;
  tmpvar_8.z = xlv_TEXCOORD1.x;
  ColorB_2 = tmpvar_8;
  o_5.xyz = (xlv_COLOR.xyz * mix (ColorB_2, _ColorA.xyz, vec3(LerpChannelA_3)));
  LerpChannelB_1 = 0.0;
  if ((_LerpChannelBMapping == 0.0)) {
    LerpChannelB_1 = MainTexSampler_4.x;
  } else {
    if ((_LerpChannelBMapping == 1.0)) {
      LerpChannelB_1 = MainTexSampler_4.y;
    } else {
      if ((_LerpChannelBMapping == 2.0)) {
        LerpChannelB_1 = MainTexSampler_4.z;
      } else {
        if ((_LerpChannelBMapping == 3.0)) {
          LerpChannelB_1 = MainTexSampler_4.w;
        };
      };
    };
  };
  o_5.xyz = mix (_ColorC.xyz, o_5.xyz, vec3(LerpChannelB_1));
  o_5.xyz = (o_5.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_5.w = (xlv_COLOR.w * MainTexSampler_4.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_5.w = (o_5.w * MainTexSampler_4.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_5.w = (o_5.w * MainTexSampler_4.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_5.w = (o_5.w * MainTexSampler_4.w);
        };
      };
    };
  };
  o_5.xyz = mix (o_5.xyz, vec3(dot (o_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  o_5.w = clamp (o_5.w, 0.0, 1.0);
  gl_FragData[0] = o_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _LerpChannelBMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float LerpChannelB_1;
  mediump vec3 ColorB_2;
  mediump float LerpChannelA_3;
  mediump vec4 MainTexSampler_4;
  mediump vec4 o_5;
  o_5 = xlv_COLOR;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, tmpvar_6);
  MainTexSampler_4 = tmpvar_7;
  LerpChannelA_3 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_3 = MainTexSampler_4.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_3 = MainTexSampler_4.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_3 = MainTexSampler_4.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_3 = MainTexSampler_4.w;
        };
      };
    };
  };
  highp vec3 tmpvar_8;
  tmpvar_8.xy = xlv_TEXCOORD0.zw;
  tmpvar_8.z = xlv_TEXCOORD1.x;
  ColorB_2 = tmpvar_8;
  o_5.xyz = (xlv_COLOR.xyz * mix (ColorB_2, _ColorA.xyz, vec3(LerpChannelA_3)));
  LerpChannelB_1 = 0.0;
  if ((_LerpChannelBMapping == 0.0)) {
    LerpChannelB_1 = MainTexSampler_4.x;
  } else {
    if ((_LerpChannelBMapping == 1.0)) {
      LerpChannelB_1 = MainTexSampler_4.y;
    } else {
      if ((_LerpChannelBMapping == 2.0)) {
        LerpChannelB_1 = MainTexSampler_4.z;
      } else {
        if ((_LerpChannelBMapping == 3.0)) {
          LerpChannelB_1 = MainTexSampler_4.w;
        };
      };
    };
  };
  o_5.xyz = mix (_ColorC.xyz, o_5.xyz, vec3(LerpChannelB_1));
  o_5.xyz = (o_5.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_5.w = (xlv_COLOR.w * MainTexSampler_4.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_5.w = (o_5.w * MainTexSampler_4.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_5.w = (o_5.w * MainTexSampler_4.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_5.w = (o_5.w * MainTexSampler_4.w);
        };
      };
    };
  };
  o_5.xyz = mix (o_5.xyz, vec3(dot (o_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  o_5.w = clamp (o_5.w, 0.0, 1.0);
  gl_FragData[0] = o_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _LerpChannelBMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float LerpChannelB_1;
  mediump vec3 ColorB_2;
  mediump float LerpChannelA_3;
  mediump vec4 MainTexSampler_4;
  mediump vec4 o_5;
  o_5 = xlv_COLOR;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, tmpvar_6);
  MainTexSampler_4 = tmpvar_7;
  LerpChannelA_3 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_3 = MainTexSampler_4.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_3 = MainTexSampler_4.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_3 = MainTexSampler_4.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_3 = MainTexSampler_4.w;
        };
      };
    };
  };
  highp vec3 tmpvar_8;
  tmpvar_8.xy = xlv_TEXCOORD0.zw;
  tmpvar_8.z = xlv_TEXCOORD1.x;
  ColorB_2 = tmpvar_8;
  o_5.xyz = (xlv_COLOR.xyz * mix (ColorB_2, _ColorA.xyz, vec3(LerpChannelA_3)));
  LerpChannelB_1 = 0.0;
  if ((_LerpChannelBMapping == 0.0)) {
    LerpChannelB_1 = MainTexSampler_4.x;
  } else {
    if ((_LerpChannelBMapping == 1.0)) {
      LerpChannelB_1 = MainTexSampler_4.y;
    } else {
      if ((_LerpChannelBMapping == 2.0)) {
        LerpChannelB_1 = MainTexSampler_4.z;
      } else {
        if ((_LerpChannelBMapping == 3.0)) {
          LerpChannelB_1 = MainTexSampler_4.w;
        };
      };
    };
  };
  o_5.xyz = mix (_ColorC.xyz, o_5.xyz, vec3(LerpChannelB_1));
  o_5.xyz = (o_5.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_5.w = (xlv_COLOR.w * MainTexSampler_4.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_5.w = (o_5.w * MainTexSampler_4.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_5.w = (o_5.w * MainTexSampler_4.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_5.w = (o_5.w * MainTexSampler_4.w);
        };
      };
    };
  };
  o_5.xyz = mix (o_5.xyz, vec3(dot (o_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  o_5.w = clamp (o_5.w, 0.0, 1.0);
  gl_FragData[0] = o_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_COLORCTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _LerpChannelBMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float LerpChannelB_1;
  mediump vec3 ColorC_2;
  mediump vec3 ColorB_3;
  mediump float LerpChannelA_4;
  mediump vec4 MainTexSampler_5;
  mediump vec4 o_6;
  o_6 = xlv_COLOR;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, tmpvar_7);
  MainTexSampler_5 = tmpvar_8;
  LerpChannelA_4 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_4 = MainTexSampler_5.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_4 = MainTexSampler_5.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_4 = MainTexSampler_5.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_4 = MainTexSampler_5.w;
        };
      };
    };
  };
  highp vec3 tmpvar_9;
  tmpvar_9.xy = xlv_TEXCOORD0.zw;
  tmpvar_9.z = xlv_TEXCOORD1.x;
  ColorB_3 = tmpvar_9;
  o_6.xyz = (xlv_COLOR.xyz * mix (ColorB_3, _ColorA.xyz, vec3(LerpChannelA_4)));
  ColorC_2 = xlv_TEXCOORD1.yzw;
  LerpChannelB_1 = 0.0;
  if ((_LerpChannelBMapping == 0.0)) {
    LerpChannelB_1 = MainTexSampler_5.x;
  } else {
    if ((_LerpChannelBMapping == 1.0)) {
      LerpChannelB_1 = MainTexSampler_5.y;
    } else {
      if ((_LerpChannelBMapping == 2.0)) {
        LerpChannelB_1 = MainTexSampler_5.z;
      } else {
        if ((_LerpChannelBMapping == 3.0)) {
          LerpChannelB_1 = MainTexSampler_5.w;
        };
      };
    };
  };
  o_6.xyz = mix (ColorC_2, o_6.xyz, vec3(LerpChannelB_1));
  o_6.xyz = (o_6.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_6.w = (xlv_COLOR.w * MainTexSampler_5.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_6.w = (o_6.w * MainTexSampler_5.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_6.w = (o_6.w * MainTexSampler_5.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_6.w = (o_6.w * MainTexSampler_5.w);
        };
      };
    };
  };
  o_6.w = clamp (o_6.w, 0.0, 1.0);
  gl_FragData[0] = o_6;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_COLORCTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _LerpChannelBMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float LerpChannelB_1;
  mediump vec3 ColorC_2;
  mediump vec3 ColorB_3;
  mediump float LerpChannelA_4;
  mediump vec4 MainTexSampler_5;
  mediump vec4 o_6;
  o_6 = xlv_COLOR;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, tmpvar_7);
  MainTexSampler_5 = tmpvar_8;
  LerpChannelA_4 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_4 = MainTexSampler_5.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_4 = MainTexSampler_5.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_4 = MainTexSampler_5.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_4 = MainTexSampler_5.w;
        };
      };
    };
  };
  highp vec3 tmpvar_9;
  tmpvar_9.xy = xlv_TEXCOORD0.zw;
  tmpvar_9.z = xlv_TEXCOORD1.x;
  ColorB_3 = tmpvar_9;
  o_6.xyz = (xlv_COLOR.xyz * mix (ColorB_3, _ColorA.xyz, vec3(LerpChannelA_4)));
  ColorC_2 = xlv_TEXCOORD1.yzw;
  LerpChannelB_1 = 0.0;
  if ((_LerpChannelBMapping == 0.0)) {
    LerpChannelB_1 = MainTexSampler_5.x;
  } else {
    if ((_LerpChannelBMapping == 1.0)) {
      LerpChannelB_1 = MainTexSampler_5.y;
    } else {
      if ((_LerpChannelBMapping == 2.0)) {
        LerpChannelB_1 = MainTexSampler_5.z;
      } else {
        if ((_LerpChannelBMapping == 3.0)) {
          LerpChannelB_1 = MainTexSampler_5.w;
        };
      };
    };
  };
  o_6.xyz = mix (ColorC_2, o_6.xyz, vec3(LerpChannelB_1));
  o_6.xyz = (o_6.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_6.w = (xlv_COLOR.w * MainTexSampler_5.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_6.w = (o_6.w * MainTexSampler_5.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_6.w = (o_6.w * MainTexSampler_5.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_6.w = (o_6.w * MainTexSampler_5.w);
        };
      };
    };
  };
  o_6.w = clamp (o_6.w, 0.0, 1.0);
  gl_FragData[0] = o_6;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_COLORCTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _LerpChannelBMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float LerpChannelB_1;
  mediump vec3 ColorC_2;
  mediump vec3 ColorB_3;
  mediump float LerpChannelA_4;
  mediump vec4 MainTexSampler_5;
  mediump vec4 o_6;
  o_6 = xlv_COLOR;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, tmpvar_7);
  MainTexSampler_5 = tmpvar_8;
  LerpChannelA_4 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_4 = MainTexSampler_5.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_4 = MainTexSampler_5.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_4 = MainTexSampler_5.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_4 = MainTexSampler_5.w;
        };
      };
    };
  };
  highp vec3 tmpvar_9;
  tmpvar_9.xy = xlv_TEXCOORD0.zw;
  tmpvar_9.z = xlv_TEXCOORD1.x;
  ColorB_3 = tmpvar_9;
  o_6.xyz = (xlv_COLOR.xyz * mix (ColorB_3, _ColorA.xyz, vec3(LerpChannelA_4)));
  ColorC_2 = xlv_TEXCOORD1.yzw;
  LerpChannelB_1 = 0.0;
  if ((_LerpChannelBMapping == 0.0)) {
    LerpChannelB_1 = MainTexSampler_5.x;
  } else {
    if ((_LerpChannelBMapping == 1.0)) {
      LerpChannelB_1 = MainTexSampler_5.y;
    } else {
      if ((_LerpChannelBMapping == 2.0)) {
        LerpChannelB_1 = MainTexSampler_5.z;
      } else {
        if ((_LerpChannelBMapping == 3.0)) {
          LerpChannelB_1 = MainTexSampler_5.w;
        };
      };
    };
  };
  o_6.xyz = mix (ColorC_2, o_6.xyz, vec3(LerpChannelB_1));
  o_6.xyz = (o_6.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_6.w = (xlv_COLOR.w * MainTexSampler_5.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_6.w = (o_6.w * MainTexSampler_5.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_6.w = (o_6.w * MainTexSampler_5.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_6.w = (o_6.w * MainTexSampler_5.w);
        };
      };
    };
  };
  o_6.w = clamp (o_6.w, 0.0, 1.0);
  gl_FragData[0] = o_6;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _LerpChannelBMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float LerpChannelB_1;
  mediump vec3 ColorC_2;
  mediump vec3 ColorB_3;
  mediump float LerpChannelA_4;
  mediump vec4 MainTexSampler_5;
  mediump vec4 o_6;
  o_6 = xlv_COLOR;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, tmpvar_7);
  MainTexSampler_5 = tmpvar_8;
  LerpChannelA_4 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_4 = MainTexSampler_5.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_4 = MainTexSampler_5.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_4 = MainTexSampler_5.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_4 = MainTexSampler_5.w;
        };
      };
    };
  };
  highp vec3 tmpvar_9;
  tmpvar_9.xy = xlv_TEXCOORD0.zw;
  tmpvar_9.z = xlv_TEXCOORD1.x;
  ColorB_3 = tmpvar_9;
  o_6.xyz = (xlv_COLOR.xyz * mix (ColorB_3, _ColorA.xyz, vec3(LerpChannelA_4)));
  ColorC_2 = xlv_TEXCOORD1.yzw;
  LerpChannelB_1 = 0.0;
  if ((_LerpChannelBMapping == 0.0)) {
    LerpChannelB_1 = MainTexSampler_5.x;
  } else {
    if ((_LerpChannelBMapping == 1.0)) {
      LerpChannelB_1 = MainTexSampler_5.y;
    } else {
      if ((_LerpChannelBMapping == 2.0)) {
        LerpChannelB_1 = MainTexSampler_5.z;
      } else {
        if ((_LerpChannelBMapping == 3.0)) {
          LerpChannelB_1 = MainTexSampler_5.w;
        };
      };
    };
  };
  o_6.xyz = mix (ColorC_2, o_6.xyz, vec3(LerpChannelB_1));
  o_6.xyz = (o_6.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_6.w = (xlv_COLOR.w * MainTexSampler_5.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_6.w = (o_6.w * MainTexSampler_5.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_6.w = (o_6.w * MainTexSampler_5.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_6.w = (o_6.w * MainTexSampler_5.w);
        };
      };
    };
  };
  o_6.xyz = mix (o_6.xyz, vec3(dot (o_6.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  o_6.w = clamp (o_6.w, 0.0, 1.0);
  gl_FragData[0] = o_6;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _LerpChannelBMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float LerpChannelB_1;
  mediump vec3 ColorC_2;
  mediump vec3 ColorB_3;
  mediump float LerpChannelA_4;
  mediump vec4 MainTexSampler_5;
  mediump vec4 o_6;
  o_6 = xlv_COLOR;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, tmpvar_7);
  MainTexSampler_5 = tmpvar_8;
  LerpChannelA_4 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_4 = MainTexSampler_5.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_4 = MainTexSampler_5.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_4 = MainTexSampler_5.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_4 = MainTexSampler_5.w;
        };
      };
    };
  };
  highp vec3 tmpvar_9;
  tmpvar_9.xy = xlv_TEXCOORD0.zw;
  tmpvar_9.z = xlv_TEXCOORD1.x;
  ColorB_3 = tmpvar_9;
  o_6.xyz = (xlv_COLOR.xyz * mix (ColorB_3, _ColorA.xyz, vec3(LerpChannelA_4)));
  ColorC_2 = xlv_TEXCOORD1.yzw;
  LerpChannelB_1 = 0.0;
  if ((_LerpChannelBMapping == 0.0)) {
    LerpChannelB_1 = MainTexSampler_5.x;
  } else {
    if ((_LerpChannelBMapping == 1.0)) {
      LerpChannelB_1 = MainTexSampler_5.y;
    } else {
      if ((_LerpChannelBMapping == 2.0)) {
        LerpChannelB_1 = MainTexSampler_5.z;
      } else {
        if ((_LerpChannelBMapping == 3.0)) {
          LerpChannelB_1 = MainTexSampler_5.w;
        };
      };
    };
  };
  o_6.xyz = mix (ColorC_2, o_6.xyz, vec3(LerpChannelB_1));
  o_6.xyz = (o_6.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_6.w = (xlv_COLOR.w * MainTexSampler_5.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_6.w = (o_6.w * MainTexSampler_5.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_6.w = (o_6.w * MainTexSampler_5.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_6.w = (o_6.w * MainTexSampler_5.w);
        };
      };
    };
  };
  o_6.xyz = mix (o_6.xyz, vec3(dot (o_6.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  o_6.w = clamp (o_6.w, 0.0, 1.0);
  gl_FragData[0] = o_6;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _LerpChannelBMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float LerpChannelB_1;
  mediump vec3 ColorC_2;
  mediump vec3 ColorB_3;
  mediump float LerpChannelA_4;
  mediump vec4 MainTexSampler_5;
  mediump vec4 o_6;
  o_6 = xlv_COLOR;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, tmpvar_7);
  MainTexSampler_5 = tmpvar_8;
  LerpChannelA_4 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_4 = MainTexSampler_5.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_4 = MainTexSampler_5.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_4 = MainTexSampler_5.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_4 = MainTexSampler_5.w;
        };
      };
    };
  };
  highp vec3 tmpvar_9;
  tmpvar_9.xy = xlv_TEXCOORD0.zw;
  tmpvar_9.z = xlv_TEXCOORD1.x;
  ColorB_3 = tmpvar_9;
  o_6.xyz = (xlv_COLOR.xyz * mix (ColorB_3, _ColorA.xyz, vec3(LerpChannelA_4)));
  ColorC_2 = xlv_TEXCOORD1.yzw;
  LerpChannelB_1 = 0.0;
  if ((_LerpChannelBMapping == 0.0)) {
    LerpChannelB_1 = MainTexSampler_5.x;
  } else {
    if ((_LerpChannelBMapping == 1.0)) {
      LerpChannelB_1 = MainTexSampler_5.y;
    } else {
      if ((_LerpChannelBMapping == 2.0)) {
        LerpChannelB_1 = MainTexSampler_5.z;
      } else {
        if ((_LerpChannelBMapping == 3.0)) {
          LerpChannelB_1 = MainTexSampler_5.w;
        };
      };
    };
  };
  o_6.xyz = mix (ColorC_2, o_6.xyz, vec3(LerpChannelB_1));
  o_6.xyz = (o_6.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_6.w = (xlv_COLOR.w * MainTexSampler_5.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_6.w = (o_6.w * MainTexSampler_5.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_6.w = (o_6.w * MainTexSampler_5.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_6.w = (o_6.w * MainTexSampler_5.w);
        };
      };
    };
  };
  o_6.xyz = mix (o_6.xyz, vec3(dot (o_6.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  o_6.w = clamp (o_6.w, 0.0, 1.0);
  gl_FragData[0] = o_6;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _LerpChannelBMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float LerpChannelB_1;
  mediump float LerpChannelA_2;
  mediump vec4 MainTexSampler_3;
  mediump vec4 o_4;
  o_4 = xlv_COLOR;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, tmpvar_5);
  MainTexSampler_3 = tmpvar_6;
  LerpChannelA_2 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_2 = MainTexSampler_3.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_2 = MainTexSampler_3.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_2 = MainTexSampler_3.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_2 = MainTexSampler_3.w;
        };
      };
    };
  };
  o_4.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, vec3(LerpChannelA_2));
  LerpChannelB_1 = 0.0;
  if ((_LerpChannelBMapping == 0.0)) {
    LerpChannelB_1 = MainTexSampler_3.x;
  } else {
    if ((_LerpChannelBMapping == 1.0)) {
      LerpChannelB_1 = MainTexSampler_3.y;
    } else {
      if ((_LerpChannelBMapping == 2.0)) {
        LerpChannelB_1 = MainTexSampler_3.z;
      } else {
        if ((_LerpChannelBMapping == 3.0)) {
          LerpChannelB_1 = MainTexSampler_3.w;
        };
      };
    };
  };
  o_4.xyz = mix (_ColorC.xyz, o_4.xyz, vec3(LerpChannelB_1));
  o_4.xyz = (o_4.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_4.w = (xlv_COLOR.w * MainTexSampler_3.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_4.w = (o_4.w * MainTexSampler_3.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_4.w = (o_4.w * MainTexSampler_3.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_4.w = (o_4.w * MainTexSampler_3.w);
        };
      };
    };
  };
  o_4.w = clamp (o_4.w, 0.0, 1.0);
  gl_FragData[0] = o_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _LerpChannelBMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float LerpChannelB_1;
  mediump float LerpChannelA_2;
  mediump vec4 MainTexSampler_3;
  mediump vec4 o_4;
  o_4 = xlv_COLOR;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, tmpvar_5);
  MainTexSampler_3 = tmpvar_6;
  LerpChannelA_2 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_2 = MainTexSampler_3.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_2 = MainTexSampler_3.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_2 = MainTexSampler_3.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_2 = MainTexSampler_3.w;
        };
      };
    };
  };
  o_4.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, vec3(LerpChannelA_2));
  LerpChannelB_1 = 0.0;
  if ((_LerpChannelBMapping == 0.0)) {
    LerpChannelB_1 = MainTexSampler_3.x;
  } else {
    if ((_LerpChannelBMapping == 1.0)) {
      LerpChannelB_1 = MainTexSampler_3.y;
    } else {
      if ((_LerpChannelBMapping == 2.0)) {
        LerpChannelB_1 = MainTexSampler_3.z;
      } else {
        if ((_LerpChannelBMapping == 3.0)) {
          LerpChannelB_1 = MainTexSampler_3.w;
        };
      };
    };
  };
  o_4.xyz = mix (_ColorC.xyz, o_4.xyz, vec3(LerpChannelB_1));
  o_4.xyz = (o_4.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_4.w = (xlv_COLOR.w * MainTexSampler_3.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_4.w = (o_4.w * MainTexSampler_3.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_4.w = (o_4.w * MainTexSampler_3.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_4.w = (o_4.w * MainTexSampler_3.w);
        };
      };
    };
  };
  o_4.w = clamp (o_4.w, 0.0, 1.0);
  gl_FragData[0] = o_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _LerpChannelBMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float LerpChannelB_1;
  mediump float LerpChannelA_2;
  mediump vec4 MainTexSampler_3;
  mediump vec4 o_4;
  o_4 = xlv_COLOR;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, tmpvar_5);
  MainTexSampler_3 = tmpvar_6;
  LerpChannelA_2 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_2 = MainTexSampler_3.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_2 = MainTexSampler_3.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_2 = MainTexSampler_3.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_2 = MainTexSampler_3.w;
        };
      };
    };
  };
  o_4.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, vec3(LerpChannelA_2));
  LerpChannelB_1 = 0.0;
  if ((_LerpChannelBMapping == 0.0)) {
    LerpChannelB_1 = MainTexSampler_3.x;
  } else {
    if ((_LerpChannelBMapping == 1.0)) {
      LerpChannelB_1 = MainTexSampler_3.y;
    } else {
      if ((_LerpChannelBMapping == 2.0)) {
        LerpChannelB_1 = MainTexSampler_3.z;
      } else {
        if ((_LerpChannelBMapping == 3.0)) {
          LerpChannelB_1 = MainTexSampler_3.w;
        };
      };
    };
  };
  o_4.xyz = mix (_ColorC.xyz, o_4.xyz, vec3(LerpChannelB_1));
  o_4.xyz = (o_4.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_4.w = (xlv_COLOR.w * MainTexSampler_3.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_4.w = (o_4.w * MainTexSampler_3.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_4.w = (o_4.w * MainTexSampler_3.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_4.w = (o_4.w * MainTexSampler_3.w);
        };
      };
    };
  };
  o_4.w = clamp (o_4.w, 0.0, 1.0);
  gl_FragData[0] = o_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _LerpChannelBMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float LerpChannelB_1;
  mediump float LerpChannelA_2;
  mediump vec4 MainTexSampler_3;
  mediump vec4 o_4;
  o_4 = xlv_COLOR;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, tmpvar_5);
  MainTexSampler_3 = tmpvar_6;
  LerpChannelA_2 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_2 = MainTexSampler_3.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_2 = MainTexSampler_3.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_2 = MainTexSampler_3.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_2 = MainTexSampler_3.w;
        };
      };
    };
  };
  o_4.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, vec3(LerpChannelA_2));
  LerpChannelB_1 = 0.0;
  if ((_LerpChannelBMapping == 0.0)) {
    LerpChannelB_1 = MainTexSampler_3.x;
  } else {
    if ((_LerpChannelBMapping == 1.0)) {
      LerpChannelB_1 = MainTexSampler_3.y;
    } else {
      if ((_LerpChannelBMapping == 2.0)) {
        LerpChannelB_1 = MainTexSampler_3.z;
      } else {
        if ((_LerpChannelBMapping == 3.0)) {
          LerpChannelB_1 = MainTexSampler_3.w;
        };
      };
    };
  };
  o_4.xyz = mix (_ColorC.xyz, o_4.xyz, vec3(LerpChannelB_1));
  o_4.xyz = (o_4.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_4.w = (xlv_COLOR.w * MainTexSampler_3.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_4.w = (o_4.w * MainTexSampler_3.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_4.w = (o_4.w * MainTexSampler_3.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_4.w = (o_4.w * MainTexSampler_3.w);
        };
      };
    };
  };
  o_4.xyz = mix (o_4.xyz, vec3(dot (o_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  o_4.w = clamp (o_4.w, 0.0, 1.0);
  gl_FragData[0] = o_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _LerpChannelBMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float LerpChannelB_1;
  mediump float LerpChannelA_2;
  mediump vec4 MainTexSampler_3;
  mediump vec4 o_4;
  o_4 = xlv_COLOR;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, tmpvar_5);
  MainTexSampler_3 = tmpvar_6;
  LerpChannelA_2 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_2 = MainTexSampler_3.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_2 = MainTexSampler_3.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_2 = MainTexSampler_3.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_2 = MainTexSampler_3.w;
        };
      };
    };
  };
  o_4.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, vec3(LerpChannelA_2));
  LerpChannelB_1 = 0.0;
  if ((_LerpChannelBMapping == 0.0)) {
    LerpChannelB_1 = MainTexSampler_3.x;
  } else {
    if ((_LerpChannelBMapping == 1.0)) {
      LerpChannelB_1 = MainTexSampler_3.y;
    } else {
      if ((_LerpChannelBMapping == 2.0)) {
        LerpChannelB_1 = MainTexSampler_3.z;
      } else {
        if ((_LerpChannelBMapping == 3.0)) {
          LerpChannelB_1 = MainTexSampler_3.w;
        };
      };
    };
  };
  o_4.xyz = mix (_ColorC.xyz, o_4.xyz, vec3(LerpChannelB_1));
  o_4.xyz = (o_4.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_4.w = (xlv_COLOR.w * MainTexSampler_3.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_4.w = (o_4.w * MainTexSampler_3.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_4.w = (o_4.w * MainTexSampler_3.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_4.w = (o_4.w * MainTexSampler_3.w);
        };
      };
    };
  };
  o_4.xyz = mix (o_4.xyz, vec3(dot (o_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  o_4.w = clamp (o_4.w, 0.0, 1.0);
  gl_FragData[0] = o_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _LerpChannelBMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float LerpChannelB_1;
  mediump float LerpChannelA_2;
  mediump vec4 MainTexSampler_3;
  mediump vec4 o_4;
  o_4 = xlv_COLOR;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, tmpvar_5);
  MainTexSampler_3 = tmpvar_6;
  LerpChannelA_2 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_2 = MainTexSampler_3.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_2 = MainTexSampler_3.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_2 = MainTexSampler_3.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_2 = MainTexSampler_3.w;
        };
      };
    };
  };
  o_4.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, vec3(LerpChannelA_2));
  LerpChannelB_1 = 0.0;
  if ((_LerpChannelBMapping == 0.0)) {
    LerpChannelB_1 = MainTexSampler_3.x;
  } else {
    if ((_LerpChannelBMapping == 1.0)) {
      LerpChannelB_1 = MainTexSampler_3.y;
    } else {
      if ((_LerpChannelBMapping == 2.0)) {
        LerpChannelB_1 = MainTexSampler_3.z;
      } else {
        if ((_LerpChannelBMapping == 3.0)) {
          LerpChannelB_1 = MainTexSampler_3.w;
        };
      };
    };
  };
  o_4.xyz = mix (_ColorC.xyz, o_4.xyz, vec3(LerpChannelB_1));
  o_4.xyz = (o_4.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_4.w = (xlv_COLOR.w * MainTexSampler_3.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_4.w = (o_4.w * MainTexSampler_3.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_4.w = (o_4.w * MainTexSampler_3.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_4.w = (o_4.w * MainTexSampler_3.w);
        };
      };
    };
  };
  o_4.xyz = mix (o_4.xyz, vec3(dot (o_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  o_4.w = clamp (o_4.w, 0.0, 1.0);
  gl_FragData[0] = o_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _LerpChannelBMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float LerpChannelB_1;
  mediump vec3 ColorC_2;
  mediump float LerpChannelA_3;
  mediump vec4 MainTexSampler_4;
  mediump vec4 o_5;
  o_5 = xlv_COLOR;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, tmpvar_6);
  MainTexSampler_4 = tmpvar_7;
  LerpChannelA_3 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_3 = MainTexSampler_4.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_3 = MainTexSampler_4.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_3 = MainTexSampler_4.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_3 = MainTexSampler_4.w;
        };
      };
    };
  };
  o_5.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, vec3(LerpChannelA_3));
  ColorC_2 = xlv_TEXCOORD1.yzw;
  LerpChannelB_1 = 0.0;
  if ((_LerpChannelBMapping == 0.0)) {
    LerpChannelB_1 = MainTexSampler_4.x;
  } else {
    if ((_LerpChannelBMapping == 1.0)) {
      LerpChannelB_1 = MainTexSampler_4.y;
    } else {
      if ((_LerpChannelBMapping == 2.0)) {
        LerpChannelB_1 = MainTexSampler_4.z;
      } else {
        if ((_LerpChannelBMapping == 3.0)) {
          LerpChannelB_1 = MainTexSampler_4.w;
        };
      };
    };
  };
  o_5.xyz = mix (ColorC_2, o_5.xyz, vec3(LerpChannelB_1));
  o_5.xyz = (o_5.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_5.w = (xlv_COLOR.w * MainTexSampler_4.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_5.w = (o_5.w * MainTexSampler_4.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_5.w = (o_5.w * MainTexSampler_4.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_5.w = (o_5.w * MainTexSampler_4.w);
        };
      };
    };
  };
  o_5.w = clamp (o_5.w, 0.0, 1.0);
  gl_FragData[0] = o_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _LerpChannelBMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float LerpChannelB_1;
  mediump vec3 ColorC_2;
  mediump float LerpChannelA_3;
  mediump vec4 MainTexSampler_4;
  mediump vec4 o_5;
  o_5 = xlv_COLOR;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, tmpvar_6);
  MainTexSampler_4 = tmpvar_7;
  LerpChannelA_3 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_3 = MainTexSampler_4.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_3 = MainTexSampler_4.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_3 = MainTexSampler_4.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_3 = MainTexSampler_4.w;
        };
      };
    };
  };
  o_5.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, vec3(LerpChannelA_3));
  ColorC_2 = xlv_TEXCOORD1.yzw;
  LerpChannelB_1 = 0.0;
  if ((_LerpChannelBMapping == 0.0)) {
    LerpChannelB_1 = MainTexSampler_4.x;
  } else {
    if ((_LerpChannelBMapping == 1.0)) {
      LerpChannelB_1 = MainTexSampler_4.y;
    } else {
      if ((_LerpChannelBMapping == 2.0)) {
        LerpChannelB_1 = MainTexSampler_4.z;
      } else {
        if ((_LerpChannelBMapping == 3.0)) {
          LerpChannelB_1 = MainTexSampler_4.w;
        };
      };
    };
  };
  o_5.xyz = mix (ColorC_2, o_5.xyz, vec3(LerpChannelB_1));
  o_5.xyz = (o_5.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_5.w = (xlv_COLOR.w * MainTexSampler_4.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_5.w = (o_5.w * MainTexSampler_4.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_5.w = (o_5.w * MainTexSampler_4.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_5.w = (o_5.w * MainTexSampler_4.w);
        };
      };
    };
  };
  o_5.w = clamp (o_5.w, 0.0, 1.0);
  gl_FragData[0] = o_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _LerpChannelBMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float LerpChannelB_1;
  mediump vec3 ColorC_2;
  mediump float LerpChannelA_3;
  mediump vec4 MainTexSampler_4;
  mediump vec4 o_5;
  o_5 = xlv_COLOR;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, tmpvar_6);
  MainTexSampler_4 = tmpvar_7;
  LerpChannelA_3 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_3 = MainTexSampler_4.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_3 = MainTexSampler_4.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_3 = MainTexSampler_4.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_3 = MainTexSampler_4.w;
        };
      };
    };
  };
  o_5.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, vec3(LerpChannelA_3));
  ColorC_2 = xlv_TEXCOORD1.yzw;
  LerpChannelB_1 = 0.0;
  if ((_LerpChannelBMapping == 0.0)) {
    LerpChannelB_1 = MainTexSampler_4.x;
  } else {
    if ((_LerpChannelBMapping == 1.0)) {
      LerpChannelB_1 = MainTexSampler_4.y;
    } else {
      if ((_LerpChannelBMapping == 2.0)) {
        LerpChannelB_1 = MainTexSampler_4.z;
      } else {
        if ((_LerpChannelBMapping == 3.0)) {
          LerpChannelB_1 = MainTexSampler_4.w;
        };
      };
    };
  };
  o_5.xyz = mix (ColorC_2, o_5.xyz, vec3(LerpChannelB_1));
  o_5.xyz = (o_5.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_5.w = (xlv_COLOR.w * MainTexSampler_4.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_5.w = (o_5.w * MainTexSampler_4.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_5.w = (o_5.w * MainTexSampler_4.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_5.w = (o_5.w * MainTexSampler_4.w);
        };
      };
    };
  };
  o_5.w = clamp (o_5.w, 0.0, 1.0);
  gl_FragData[0] = o_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _LerpChannelBMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float LerpChannelB_1;
  mediump vec3 ColorC_2;
  mediump float LerpChannelA_3;
  mediump vec4 MainTexSampler_4;
  mediump vec4 o_5;
  o_5 = xlv_COLOR;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, tmpvar_6);
  MainTexSampler_4 = tmpvar_7;
  LerpChannelA_3 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_3 = MainTexSampler_4.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_3 = MainTexSampler_4.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_3 = MainTexSampler_4.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_3 = MainTexSampler_4.w;
        };
      };
    };
  };
  o_5.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, vec3(LerpChannelA_3));
  ColorC_2 = xlv_TEXCOORD1.yzw;
  LerpChannelB_1 = 0.0;
  if ((_LerpChannelBMapping == 0.0)) {
    LerpChannelB_1 = MainTexSampler_4.x;
  } else {
    if ((_LerpChannelBMapping == 1.0)) {
      LerpChannelB_1 = MainTexSampler_4.y;
    } else {
      if ((_LerpChannelBMapping == 2.0)) {
        LerpChannelB_1 = MainTexSampler_4.z;
      } else {
        if ((_LerpChannelBMapping == 3.0)) {
          LerpChannelB_1 = MainTexSampler_4.w;
        };
      };
    };
  };
  o_5.xyz = mix (ColorC_2, o_5.xyz, vec3(LerpChannelB_1));
  o_5.xyz = (o_5.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_5.w = (xlv_COLOR.w * MainTexSampler_4.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_5.w = (o_5.w * MainTexSampler_4.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_5.w = (o_5.w * MainTexSampler_4.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_5.w = (o_5.w * MainTexSampler_4.w);
        };
      };
    };
  };
  o_5.xyz = mix (o_5.xyz, vec3(dot (o_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  o_5.w = clamp (o_5.w, 0.0, 1.0);
  gl_FragData[0] = o_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _LerpChannelBMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float LerpChannelB_1;
  mediump vec3 ColorC_2;
  mediump float LerpChannelA_3;
  mediump vec4 MainTexSampler_4;
  mediump vec4 o_5;
  o_5 = xlv_COLOR;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, tmpvar_6);
  MainTexSampler_4 = tmpvar_7;
  LerpChannelA_3 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_3 = MainTexSampler_4.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_3 = MainTexSampler_4.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_3 = MainTexSampler_4.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_3 = MainTexSampler_4.w;
        };
      };
    };
  };
  o_5.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, vec3(LerpChannelA_3));
  ColorC_2 = xlv_TEXCOORD1.yzw;
  LerpChannelB_1 = 0.0;
  if ((_LerpChannelBMapping == 0.0)) {
    LerpChannelB_1 = MainTexSampler_4.x;
  } else {
    if ((_LerpChannelBMapping == 1.0)) {
      LerpChannelB_1 = MainTexSampler_4.y;
    } else {
      if ((_LerpChannelBMapping == 2.0)) {
        LerpChannelB_1 = MainTexSampler_4.z;
      } else {
        if ((_LerpChannelBMapping == 3.0)) {
          LerpChannelB_1 = MainTexSampler_4.w;
        };
      };
    };
  };
  o_5.xyz = mix (ColorC_2, o_5.xyz, vec3(LerpChannelB_1));
  o_5.xyz = (o_5.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_5.w = (xlv_COLOR.w * MainTexSampler_4.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_5.w = (o_5.w * MainTexSampler_4.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_5.w = (o_5.w * MainTexSampler_4.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_5.w = (o_5.w * MainTexSampler_4.w);
        };
      };
    };
  };
  o_5.xyz = mix (o_5.xyz, vec3(dot (o_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  o_5.w = clamp (o_5.w, 0.0, 1.0);
  gl_FragData[0] = o_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _LerpChannelBMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float LerpChannelB_1;
  mediump vec3 ColorC_2;
  mediump float LerpChannelA_3;
  mediump vec4 MainTexSampler_4;
  mediump vec4 o_5;
  o_5 = xlv_COLOR;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, tmpvar_6);
  MainTexSampler_4 = tmpvar_7;
  LerpChannelA_3 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_3 = MainTexSampler_4.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_3 = MainTexSampler_4.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_3 = MainTexSampler_4.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_3 = MainTexSampler_4.w;
        };
      };
    };
  };
  o_5.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, vec3(LerpChannelA_3));
  ColorC_2 = xlv_TEXCOORD1.yzw;
  LerpChannelB_1 = 0.0;
  if ((_LerpChannelBMapping == 0.0)) {
    LerpChannelB_1 = MainTexSampler_4.x;
  } else {
    if ((_LerpChannelBMapping == 1.0)) {
      LerpChannelB_1 = MainTexSampler_4.y;
    } else {
      if ((_LerpChannelBMapping == 2.0)) {
        LerpChannelB_1 = MainTexSampler_4.z;
      } else {
        if ((_LerpChannelBMapping == 3.0)) {
          LerpChannelB_1 = MainTexSampler_4.w;
        };
      };
    };
  };
  o_5.xyz = mix (ColorC_2, o_5.xyz, vec3(LerpChannelB_1));
  o_5.xyz = (o_5.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_5.w = (xlv_COLOR.w * MainTexSampler_4.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_5.w = (o_5.w * MainTexSampler_4.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_5.w = (o_5.w * MainTexSampler_4.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_5.w = (o_5.w * MainTexSampler_4.w);
        };
      };
    };
  };
  o_5.xyz = mix (o_5.xyz, vec3(dot (o_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  o_5.w = clamp (o_5.w, 0.0, 1.0);
  gl_FragData[0] = o_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _LerpChannelBMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float LerpChannelB_1;
  mediump vec3 ColorB_2;
  mediump float LerpChannelA_3;
  mediump vec4 MainTexSampler_4;
  mediump vec4 o_5;
  o_5 = xlv_COLOR;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, tmpvar_6);
  MainTexSampler_4 = tmpvar_7;
  LerpChannelA_3 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_3 = MainTexSampler_4.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_3 = MainTexSampler_4.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_3 = MainTexSampler_4.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_3 = MainTexSampler_4.w;
        };
      };
    };
  };
  highp vec3 tmpvar_8;
  tmpvar_8.xy = xlv_TEXCOORD0.zw;
  tmpvar_8.z = xlv_TEXCOORD1.x;
  ColorB_2 = tmpvar_8;
  o_5.xyz = mix (ColorB_2, xlv_COLOR.xyz, vec3(LerpChannelA_3));
  LerpChannelB_1 = 0.0;
  if ((_LerpChannelBMapping == 0.0)) {
    LerpChannelB_1 = MainTexSampler_4.x;
  } else {
    if ((_LerpChannelBMapping == 1.0)) {
      LerpChannelB_1 = MainTexSampler_4.y;
    } else {
      if ((_LerpChannelBMapping == 2.0)) {
        LerpChannelB_1 = MainTexSampler_4.z;
      } else {
        if ((_LerpChannelBMapping == 3.0)) {
          LerpChannelB_1 = MainTexSampler_4.w;
        };
      };
    };
  };
  o_5.xyz = mix (_ColorC.xyz, o_5.xyz, vec3(LerpChannelB_1));
  o_5.xyz = (o_5.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_5.w = (xlv_COLOR.w * MainTexSampler_4.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_5.w = (o_5.w * MainTexSampler_4.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_5.w = (o_5.w * MainTexSampler_4.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_5.w = (o_5.w * MainTexSampler_4.w);
        };
      };
    };
  };
  o_5.w = clamp (o_5.w, 0.0, 1.0);
  gl_FragData[0] = o_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _LerpChannelBMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float LerpChannelB_1;
  mediump vec3 ColorB_2;
  mediump float LerpChannelA_3;
  mediump vec4 MainTexSampler_4;
  mediump vec4 o_5;
  o_5 = xlv_COLOR;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, tmpvar_6);
  MainTexSampler_4 = tmpvar_7;
  LerpChannelA_3 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_3 = MainTexSampler_4.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_3 = MainTexSampler_4.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_3 = MainTexSampler_4.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_3 = MainTexSampler_4.w;
        };
      };
    };
  };
  highp vec3 tmpvar_8;
  tmpvar_8.xy = xlv_TEXCOORD0.zw;
  tmpvar_8.z = xlv_TEXCOORD1.x;
  ColorB_2 = tmpvar_8;
  o_5.xyz = mix (ColorB_2, xlv_COLOR.xyz, vec3(LerpChannelA_3));
  LerpChannelB_1 = 0.0;
  if ((_LerpChannelBMapping == 0.0)) {
    LerpChannelB_1 = MainTexSampler_4.x;
  } else {
    if ((_LerpChannelBMapping == 1.0)) {
      LerpChannelB_1 = MainTexSampler_4.y;
    } else {
      if ((_LerpChannelBMapping == 2.0)) {
        LerpChannelB_1 = MainTexSampler_4.z;
      } else {
        if ((_LerpChannelBMapping == 3.0)) {
          LerpChannelB_1 = MainTexSampler_4.w;
        };
      };
    };
  };
  o_5.xyz = mix (_ColorC.xyz, o_5.xyz, vec3(LerpChannelB_1));
  o_5.xyz = (o_5.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_5.w = (xlv_COLOR.w * MainTexSampler_4.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_5.w = (o_5.w * MainTexSampler_4.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_5.w = (o_5.w * MainTexSampler_4.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_5.w = (o_5.w * MainTexSampler_4.w);
        };
      };
    };
  };
  o_5.w = clamp (o_5.w, 0.0, 1.0);
  gl_FragData[0] = o_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _LerpChannelBMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float LerpChannelB_1;
  mediump vec3 ColorB_2;
  mediump float LerpChannelA_3;
  mediump vec4 MainTexSampler_4;
  mediump vec4 o_5;
  o_5 = xlv_COLOR;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, tmpvar_6);
  MainTexSampler_4 = tmpvar_7;
  LerpChannelA_3 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_3 = MainTexSampler_4.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_3 = MainTexSampler_4.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_3 = MainTexSampler_4.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_3 = MainTexSampler_4.w;
        };
      };
    };
  };
  highp vec3 tmpvar_8;
  tmpvar_8.xy = xlv_TEXCOORD0.zw;
  tmpvar_8.z = xlv_TEXCOORD1.x;
  ColorB_2 = tmpvar_8;
  o_5.xyz = mix (ColorB_2, xlv_COLOR.xyz, vec3(LerpChannelA_3));
  LerpChannelB_1 = 0.0;
  if ((_LerpChannelBMapping == 0.0)) {
    LerpChannelB_1 = MainTexSampler_4.x;
  } else {
    if ((_LerpChannelBMapping == 1.0)) {
      LerpChannelB_1 = MainTexSampler_4.y;
    } else {
      if ((_LerpChannelBMapping == 2.0)) {
        LerpChannelB_1 = MainTexSampler_4.z;
      } else {
        if ((_LerpChannelBMapping == 3.0)) {
          LerpChannelB_1 = MainTexSampler_4.w;
        };
      };
    };
  };
  o_5.xyz = mix (_ColorC.xyz, o_5.xyz, vec3(LerpChannelB_1));
  o_5.xyz = (o_5.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_5.w = (xlv_COLOR.w * MainTexSampler_4.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_5.w = (o_5.w * MainTexSampler_4.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_5.w = (o_5.w * MainTexSampler_4.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_5.w = (o_5.w * MainTexSampler_4.w);
        };
      };
    };
  };
  o_5.w = clamp (o_5.w, 0.0, 1.0);
  gl_FragData[0] = o_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _LerpChannelBMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float LerpChannelB_1;
  mediump vec3 ColorB_2;
  mediump float LerpChannelA_3;
  mediump vec4 MainTexSampler_4;
  mediump vec4 o_5;
  o_5 = xlv_COLOR;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, tmpvar_6);
  MainTexSampler_4 = tmpvar_7;
  LerpChannelA_3 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_3 = MainTexSampler_4.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_3 = MainTexSampler_4.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_3 = MainTexSampler_4.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_3 = MainTexSampler_4.w;
        };
      };
    };
  };
  highp vec3 tmpvar_8;
  tmpvar_8.xy = xlv_TEXCOORD0.zw;
  tmpvar_8.z = xlv_TEXCOORD1.x;
  ColorB_2 = tmpvar_8;
  o_5.xyz = mix (ColorB_2, xlv_COLOR.xyz, vec3(LerpChannelA_3));
  LerpChannelB_1 = 0.0;
  if ((_LerpChannelBMapping == 0.0)) {
    LerpChannelB_1 = MainTexSampler_4.x;
  } else {
    if ((_LerpChannelBMapping == 1.0)) {
      LerpChannelB_1 = MainTexSampler_4.y;
    } else {
      if ((_LerpChannelBMapping == 2.0)) {
        LerpChannelB_1 = MainTexSampler_4.z;
      } else {
        if ((_LerpChannelBMapping == 3.0)) {
          LerpChannelB_1 = MainTexSampler_4.w;
        };
      };
    };
  };
  o_5.xyz = mix (_ColorC.xyz, o_5.xyz, vec3(LerpChannelB_1));
  o_5.xyz = (o_5.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_5.w = (xlv_COLOR.w * MainTexSampler_4.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_5.w = (o_5.w * MainTexSampler_4.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_5.w = (o_5.w * MainTexSampler_4.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_5.w = (o_5.w * MainTexSampler_4.w);
        };
      };
    };
  };
  o_5.xyz = mix (o_5.xyz, vec3(dot (o_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  o_5.w = clamp (o_5.w, 0.0, 1.0);
  gl_FragData[0] = o_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _LerpChannelBMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float LerpChannelB_1;
  mediump vec3 ColorB_2;
  mediump float LerpChannelA_3;
  mediump vec4 MainTexSampler_4;
  mediump vec4 o_5;
  o_5 = xlv_COLOR;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, tmpvar_6);
  MainTexSampler_4 = tmpvar_7;
  LerpChannelA_3 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_3 = MainTexSampler_4.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_3 = MainTexSampler_4.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_3 = MainTexSampler_4.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_3 = MainTexSampler_4.w;
        };
      };
    };
  };
  highp vec3 tmpvar_8;
  tmpvar_8.xy = xlv_TEXCOORD0.zw;
  tmpvar_8.z = xlv_TEXCOORD1.x;
  ColorB_2 = tmpvar_8;
  o_5.xyz = mix (ColorB_2, xlv_COLOR.xyz, vec3(LerpChannelA_3));
  LerpChannelB_1 = 0.0;
  if ((_LerpChannelBMapping == 0.0)) {
    LerpChannelB_1 = MainTexSampler_4.x;
  } else {
    if ((_LerpChannelBMapping == 1.0)) {
      LerpChannelB_1 = MainTexSampler_4.y;
    } else {
      if ((_LerpChannelBMapping == 2.0)) {
        LerpChannelB_1 = MainTexSampler_4.z;
      } else {
        if ((_LerpChannelBMapping == 3.0)) {
          LerpChannelB_1 = MainTexSampler_4.w;
        };
      };
    };
  };
  o_5.xyz = mix (_ColorC.xyz, o_5.xyz, vec3(LerpChannelB_1));
  o_5.xyz = (o_5.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_5.w = (xlv_COLOR.w * MainTexSampler_4.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_5.w = (o_5.w * MainTexSampler_4.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_5.w = (o_5.w * MainTexSampler_4.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_5.w = (o_5.w * MainTexSampler_4.w);
        };
      };
    };
  };
  o_5.xyz = mix (o_5.xyz, vec3(dot (o_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  o_5.w = clamp (o_5.w, 0.0, 1.0);
  gl_FragData[0] = o_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _LerpChannelBMapping;
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float LerpChannelB_1;
  mediump vec3 ColorB_2;
  mediump float LerpChannelA_3;
  mediump vec4 MainTexSampler_4;
  mediump vec4 o_5;
  o_5 = xlv_COLOR;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, tmpvar_6);
  MainTexSampler_4 = tmpvar_7;
  LerpChannelA_3 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_3 = MainTexSampler_4.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_3 = MainTexSampler_4.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_3 = MainTexSampler_4.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_3 = MainTexSampler_4.w;
        };
      };
    };
  };
  highp vec3 tmpvar_8;
  tmpvar_8.xy = xlv_TEXCOORD0.zw;
  tmpvar_8.z = xlv_TEXCOORD1.x;
  ColorB_2 = tmpvar_8;
  o_5.xyz = mix (ColorB_2, xlv_COLOR.xyz, vec3(LerpChannelA_3));
  LerpChannelB_1 = 0.0;
  if ((_LerpChannelBMapping == 0.0)) {
    LerpChannelB_1 = MainTexSampler_4.x;
  } else {
    if ((_LerpChannelBMapping == 1.0)) {
      LerpChannelB_1 = MainTexSampler_4.y;
    } else {
      if ((_LerpChannelBMapping == 2.0)) {
        LerpChannelB_1 = MainTexSampler_4.z;
      } else {
        if ((_LerpChannelBMapping == 3.0)) {
          LerpChannelB_1 = MainTexSampler_4.w;
        };
      };
    };
  };
  o_5.xyz = mix (_ColorC.xyz, o_5.xyz, vec3(LerpChannelB_1));
  o_5.xyz = (o_5.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_5.w = (xlv_COLOR.w * MainTexSampler_4.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_5.w = (o_5.w * MainTexSampler_4.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_5.w = (o_5.w * MainTexSampler_4.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_5.w = (o_5.w * MainTexSampler_4.w);
        };
      };
    };
  };
  o_5.xyz = mix (o_5.xyz, vec3(dot (o_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  o_5.w = clamp (o_5.w, 0.0, 1.0);
  gl_FragData[0] = o_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _LerpChannelBMapping;
uniform highp float _AlphaChannelMapping;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float LerpChannelB_1;
  mediump vec3 ColorC_2;
  mediump vec3 ColorB_3;
  mediump float LerpChannelA_4;
  mediump vec4 MainTexSampler_5;
  mediump vec4 o_6;
  o_6 = xlv_COLOR;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, tmpvar_7);
  MainTexSampler_5 = tmpvar_8;
  LerpChannelA_4 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_4 = MainTexSampler_5.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_4 = MainTexSampler_5.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_4 = MainTexSampler_5.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_4 = MainTexSampler_5.w;
        };
      };
    };
  };
  highp vec3 tmpvar_9;
  tmpvar_9.xy = xlv_TEXCOORD0.zw;
  tmpvar_9.z = xlv_TEXCOORD1.x;
  ColorB_3 = tmpvar_9;
  o_6.xyz = mix (ColorB_3, xlv_COLOR.xyz, vec3(LerpChannelA_4));
  ColorC_2 = xlv_TEXCOORD1.yzw;
  LerpChannelB_1 = 0.0;
  if ((_LerpChannelBMapping == 0.0)) {
    LerpChannelB_1 = MainTexSampler_5.x;
  } else {
    if ((_LerpChannelBMapping == 1.0)) {
      LerpChannelB_1 = MainTexSampler_5.y;
    } else {
      if ((_LerpChannelBMapping == 2.0)) {
        LerpChannelB_1 = MainTexSampler_5.z;
      } else {
        if ((_LerpChannelBMapping == 3.0)) {
          LerpChannelB_1 = MainTexSampler_5.w;
        };
      };
    };
  };
  o_6.xyz = mix (ColorC_2, o_6.xyz, vec3(LerpChannelB_1));
  o_6.xyz = (o_6.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_6.w = (xlv_COLOR.w * MainTexSampler_5.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_6.w = (o_6.w * MainTexSampler_5.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_6.w = (o_6.w * MainTexSampler_5.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_6.w = (o_6.w * MainTexSampler_5.w);
        };
      };
    };
  };
  o_6.w = clamp (o_6.w, 0.0, 1.0);
  gl_FragData[0] = o_6;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _LerpChannelBMapping;
uniform highp float _AlphaChannelMapping;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float LerpChannelB_1;
  mediump vec3 ColorC_2;
  mediump vec3 ColorB_3;
  mediump float LerpChannelA_4;
  mediump vec4 MainTexSampler_5;
  mediump vec4 o_6;
  o_6 = xlv_COLOR;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, tmpvar_7);
  MainTexSampler_5 = tmpvar_8;
  LerpChannelA_4 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_4 = MainTexSampler_5.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_4 = MainTexSampler_5.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_4 = MainTexSampler_5.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_4 = MainTexSampler_5.w;
        };
      };
    };
  };
  highp vec3 tmpvar_9;
  tmpvar_9.xy = xlv_TEXCOORD0.zw;
  tmpvar_9.z = xlv_TEXCOORD1.x;
  ColorB_3 = tmpvar_9;
  o_6.xyz = mix (ColorB_3, xlv_COLOR.xyz, vec3(LerpChannelA_4));
  ColorC_2 = xlv_TEXCOORD1.yzw;
  LerpChannelB_1 = 0.0;
  if ((_LerpChannelBMapping == 0.0)) {
    LerpChannelB_1 = MainTexSampler_5.x;
  } else {
    if ((_LerpChannelBMapping == 1.0)) {
      LerpChannelB_1 = MainTexSampler_5.y;
    } else {
      if ((_LerpChannelBMapping == 2.0)) {
        LerpChannelB_1 = MainTexSampler_5.z;
      } else {
        if ((_LerpChannelBMapping == 3.0)) {
          LerpChannelB_1 = MainTexSampler_5.w;
        };
      };
    };
  };
  o_6.xyz = mix (ColorC_2, o_6.xyz, vec3(LerpChannelB_1));
  o_6.xyz = (o_6.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_6.w = (xlv_COLOR.w * MainTexSampler_5.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_6.w = (o_6.w * MainTexSampler_5.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_6.w = (o_6.w * MainTexSampler_5.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_6.w = (o_6.w * MainTexSampler_5.w);
        };
      };
    };
  };
  o_6.w = clamp (o_6.w, 0.0, 1.0);
  gl_FragData[0] = o_6;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _LerpChannelBMapping;
uniform highp float _AlphaChannelMapping;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float LerpChannelB_1;
  mediump vec3 ColorC_2;
  mediump vec3 ColorB_3;
  mediump float LerpChannelA_4;
  mediump vec4 MainTexSampler_5;
  mediump vec4 o_6;
  o_6 = xlv_COLOR;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, tmpvar_7);
  MainTexSampler_5 = tmpvar_8;
  LerpChannelA_4 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_4 = MainTexSampler_5.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_4 = MainTexSampler_5.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_4 = MainTexSampler_5.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_4 = MainTexSampler_5.w;
        };
      };
    };
  };
  highp vec3 tmpvar_9;
  tmpvar_9.xy = xlv_TEXCOORD0.zw;
  tmpvar_9.z = xlv_TEXCOORD1.x;
  ColorB_3 = tmpvar_9;
  o_6.xyz = mix (ColorB_3, xlv_COLOR.xyz, vec3(LerpChannelA_4));
  ColorC_2 = xlv_TEXCOORD1.yzw;
  LerpChannelB_1 = 0.0;
  if ((_LerpChannelBMapping == 0.0)) {
    LerpChannelB_1 = MainTexSampler_5.x;
  } else {
    if ((_LerpChannelBMapping == 1.0)) {
      LerpChannelB_1 = MainTexSampler_5.y;
    } else {
      if ((_LerpChannelBMapping == 2.0)) {
        LerpChannelB_1 = MainTexSampler_5.z;
      } else {
        if ((_LerpChannelBMapping == 3.0)) {
          LerpChannelB_1 = MainTexSampler_5.w;
        };
      };
    };
  };
  o_6.xyz = mix (ColorC_2, o_6.xyz, vec3(LerpChannelB_1));
  o_6.xyz = (o_6.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_6.w = (xlv_COLOR.w * MainTexSampler_5.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_6.w = (o_6.w * MainTexSampler_5.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_6.w = (o_6.w * MainTexSampler_5.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_6.w = (o_6.w * MainTexSampler_5.w);
        };
      };
    };
  };
  o_6.w = clamp (o_6.w, 0.0, 1.0);
  gl_FragData[0] = o_6;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _LerpChannelBMapping;
uniform highp float _AlphaChannelMapping;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float LerpChannelB_1;
  mediump vec3 ColorC_2;
  mediump vec3 ColorB_3;
  mediump float LerpChannelA_4;
  mediump vec4 MainTexSampler_5;
  mediump vec4 o_6;
  o_6 = xlv_COLOR;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, tmpvar_7);
  MainTexSampler_5 = tmpvar_8;
  LerpChannelA_4 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_4 = MainTexSampler_5.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_4 = MainTexSampler_5.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_4 = MainTexSampler_5.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_4 = MainTexSampler_5.w;
        };
      };
    };
  };
  highp vec3 tmpvar_9;
  tmpvar_9.xy = xlv_TEXCOORD0.zw;
  tmpvar_9.z = xlv_TEXCOORD1.x;
  ColorB_3 = tmpvar_9;
  o_6.xyz = mix (ColorB_3, xlv_COLOR.xyz, vec3(LerpChannelA_4));
  ColorC_2 = xlv_TEXCOORD1.yzw;
  LerpChannelB_1 = 0.0;
  if ((_LerpChannelBMapping == 0.0)) {
    LerpChannelB_1 = MainTexSampler_5.x;
  } else {
    if ((_LerpChannelBMapping == 1.0)) {
      LerpChannelB_1 = MainTexSampler_5.y;
    } else {
      if ((_LerpChannelBMapping == 2.0)) {
        LerpChannelB_1 = MainTexSampler_5.z;
      } else {
        if ((_LerpChannelBMapping == 3.0)) {
          LerpChannelB_1 = MainTexSampler_5.w;
        };
      };
    };
  };
  o_6.xyz = mix (ColorC_2, o_6.xyz, vec3(LerpChannelB_1));
  o_6.xyz = (o_6.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_6.w = (xlv_COLOR.w * MainTexSampler_5.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_6.w = (o_6.w * MainTexSampler_5.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_6.w = (o_6.w * MainTexSampler_5.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_6.w = (o_6.w * MainTexSampler_5.w);
        };
      };
    };
  };
  o_6.xyz = mix (o_6.xyz, vec3(dot (o_6.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  o_6.w = clamp (o_6.w, 0.0, 1.0);
  gl_FragData[0] = o_6;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _LerpChannelBMapping;
uniform highp float _AlphaChannelMapping;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float LerpChannelB_1;
  mediump vec3 ColorC_2;
  mediump vec3 ColorB_3;
  mediump float LerpChannelA_4;
  mediump vec4 MainTexSampler_5;
  mediump vec4 o_6;
  o_6 = xlv_COLOR;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, tmpvar_7);
  MainTexSampler_5 = tmpvar_8;
  LerpChannelA_4 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_4 = MainTexSampler_5.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_4 = MainTexSampler_5.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_4 = MainTexSampler_5.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_4 = MainTexSampler_5.w;
        };
      };
    };
  };
  highp vec3 tmpvar_9;
  tmpvar_9.xy = xlv_TEXCOORD0.zw;
  tmpvar_9.z = xlv_TEXCOORD1.x;
  ColorB_3 = tmpvar_9;
  o_6.xyz = mix (ColorB_3, xlv_COLOR.xyz, vec3(LerpChannelA_4));
  ColorC_2 = xlv_TEXCOORD1.yzw;
  LerpChannelB_1 = 0.0;
  if ((_LerpChannelBMapping == 0.0)) {
    LerpChannelB_1 = MainTexSampler_5.x;
  } else {
    if ((_LerpChannelBMapping == 1.0)) {
      LerpChannelB_1 = MainTexSampler_5.y;
    } else {
      if ((_LerpChannelBMapping == 2.0)) {
        LerpChannelB_1 = MainTexSampler_5.z;
      } else {
        if ((_LerpChannelBMapping == 3.0)) {
          LerpChannelB_1 = MainTexSampler_5.w;
        };
      };
    };
  };
  o_6.xyz = mix (ColorC_2, o_6.xyz, vec3(LerpChannelB_1));
  o_6.xyz = (o_6.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_6.w = (xlv_COLOR.w * MainTexSampler_5.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_6.w = (o_6.w * MainTexSampler_5.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_6.w = (o_6.w * MainTexSampler_5.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_6.w = (o_6.w * MainTexSampler_5.w);
        };
      };
    };
  };
  o_6.xyz = mix (o_6.xyz, vec3(dot (o_6.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  o_6.w = clamp (o_6.w, 0.0, 1.0);
  gl_FragData[0] = o_6;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _LerpChannelAMapping;
uniform highp float _LerpChannelBMapping;
uniform highp float _AlphaChannelMapping;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float LerpChannelB_1;
  mediump vec3 ColorC_2;
  mediump vec3 ColorB_3;
  mediump float LerpChannelA_4;
  mediump vec4 MainTexSampler_5;
  mediump vec4 o_6;
  o_6 = xlv_COLOR;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, tmpvar_7);
  MainTexSampler_5 = tmpvar_8;
  LerpChannelA_4 = 0.0;
  if ((_LerpChannelAMapping == 0.0)) {
    LerpChannelA_4 = MainTexSampler_5.x;
  } else {
    if ((_LerpChannelAMapping == 1.0)) {
      LerpChannelA_4 = MainTexSampler_5.y;
    } else {
      if ((_LerpChannelAMapping == 2.0)) {
        LerpChannelA_4 = MainTexSampler_5.z;
      } else {
        if ((_LerpChannelAMapping == 3.0)) {
          LerpChannelA_4 = MainTexSampler_5.w;
        };
      };
    };
  };
  highp vec3 tmpvar_9;
  tmpvar_9.xy = xlv_TEXCOORD0.zw;
  tmpvar_9.z = xlv_TEXCOORD1.x;
  ColorB_3 = tmpvar_9;
  o_6.xyz = mix (ColorB_3, xlv_COLOR.xyz, vec3(LerpChannelA_4));
  ColorC_2 = xlv_TEXCOORD1.yzw;
  LerpChannelB_1 = 0.0;
  if ((_LerpChannelBMapping == 0.0)) {
    LerpChannelB_1 = MainTexSampler_5.x;
  } else {
    if ((_LerpChannelBMapping == 1.0)) {
      LerpChannelB_1 = MainTexSampler_5.y;
    } else {
      if ((_LerpChannelBMapping == 2.0)) {
        LerpChannelB_1 = MainTexSampler_5.z;
      } else {
        if ((_LerpChannelBMapping == 3.0)) {
          LerpChannelB_1 = MainTexSampler_5.w;
        };
      };
    };
  };
  o_6.xyz = mix (ColorC_2, o_6.xyz, vec3(LerpChannelB_1));
  o_6.xyz = (o_6.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_6.w = (xlv_COLOR.w * MainTexSampler_5.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_6.w = (o_6.w * MainTexSampler_5.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_6.w = (o_6.w * MainTexSampler_5.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_6.w = (o_6.w * MainTexSampler_5.w);
        };
      };
    };
  };
  o_6.xyz = mix (o_6.xyz, vec3(dot (o_6.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  o_6.w = clamp (o_6.w, 0.0, 1.0);
  gl_FragData[0] = o_6;
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
Keywords { "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_CUSTOMCOLOR1TOGGLE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_CUSTOMCOLOR1TOGGLE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_CUSTOMCOLOR1TOGGLE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_CUSTOMCOLOR1TOGGLE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_CUSTOMCOLOR1TOGGLE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_CUSTOMCOLOR1TOGGLE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_PARTICLECOLORTOGGLE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_PARTICLECOLORTOGGLE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_PARTICLECOLORTOGGLE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_PARTICLECOLORTOGGLE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_PARTICLECOLORTOGGLE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_PARTICLECOLORTOGGLE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_COLORCTOGGLE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_COLORCTOGGLE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_COLORCTOGGLE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_COLORCTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_COLORCTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_COLORCTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_COLORCTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_COLORCTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_COLORCTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_COLORCTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_COLORCTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_COLORCTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_COLORCTOGGLE_ON" "_PARTICLECOLORTOGGLE_ON" "_CUSTOMCOLOR1TOGGLE_ON" "_CUSTOMCOLOR2TOGGLE_ON" }
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
  GpuProgramID 107176
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = _glesColor.w;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _AlphaChannelMapping;
uniform highp float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = MainTexSampler_1.x;
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = MainTexSampler_1.y;
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = MainTexSampler_1.z;
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = MainTexSampler_1.w;
        };
      };
    };
  };
  o_2.w = (o_2.w * (xlv_TEXCOORD1 * _BloomFactor));
  gl_FragData[0] = o_2;
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
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = _glesColor.w;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _AlphaChannelMapping;
uniform highp float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = MainTexSampler_1.x;
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = MainTexSampler_1.y;
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = MainTexSampler_1.z;
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = MainTexSampler_1.w;
        };
      };
    };
  };
  o_2.w = (o_2.w * (xlv_TEXCOORD1 * _BloomFactor));
  gl_FragData[0] = o_2;
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
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = _glesColor.w;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _AlphaChannelMapping;
uniform highp float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = MainTexSampler_1.x;
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = MainTexSampler_1.y;
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = MainTexSampler_1.z;
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = MainTexSampler_1.w;
        };
      };
    };
  };
  o_2.w = (o_2.w * (xlv_TEXCOORD1 * _BloomFactor));
  gl_FragData[0] = o_2;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_COLORCTOGGLE_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = _glesColor.w;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _AlphaChannelMapping;
uniform highp float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = MainTexSampler_1.x;
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = MainTexSampler_1.y;
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = MainTexSampler_1.z;
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = MainTexSampler_1.w;
        };
      };
    };
  };
  o_2.w = (o_2.w * (xlv_TEXCOORD1 * _BloomFactor));
  gl_FragData[0] = o_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_COLORCTOGGLE_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = _glesColor.w;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _AlphaChannelMapping;
uniform highp float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = MainTexSampler_1.x;
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = MainTexSampler_1.y;
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = MainTexSampler_1.z;
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = MainTexSampler_1.w;
        };
      };
    };
  };
  o_2.w = (o_2.w * (xlv_TEXCOORD1 * _BloomFactor));
  gl_FragData[0] = o_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_COLORCTOGGLE_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = _glesColor.w;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _AlphaChannelMapping;
uniform highp float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = MainTexSampler_1.x;
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = MainTexSampler_1.y;
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = MainTexSampler_1.z;
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = MainTexSampler_1.w;
        };
      };
    };
  };
  o_2.w = (o_2.w * (xlv_TEXCOORD1 * _BloomFactor));
  gl_FragData[0] = o_2;
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
Keywords { "_COLORCTOGGLE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_COLORCTOGGLE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_COLORCTOGGLE_ON" }
""
}
}
}
}
}