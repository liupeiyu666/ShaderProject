//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Particles/ChannelMix/Multiply (Simple)" {
Properties {
_MainTex ("Main Tex", 2D) = "white" { }
[Enum(R, 0, G, 1, B, 2, A, 3)] _AlphaChannelMapping ("Alpha Channel Mapping", Float) = 2
_ColorA ("Color A", Color) = (1,0,0,0)
_ColorB ("Color B", Color) = (0,1,0,0)
_ColorC ("Color C", Color) = (0,0,1,0)
[Toggle(_COLORCTOGGLE_ON)] _ColorCToggle ("Color C Toggle", Float) = 0
[Toggle(_PARTICLECOLORTOGGLE_ON)] _ParticleColorAsColorA ("Particle Color As Color A", Float) = 0
[Header(Bloom)] _BloomFactor ("Bloom Factor", Float) = 1
_EmissionScaler ("Emission Scaler", Range(0, 50)) = 1
[Header(Render Options)] [Enum(Off, 4, On, 0)] _AlwaysOnTop ("Always On Top", Float) = 4
}
SubShader {
 LOD 200
 Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 9707
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, _ColorA.xyz, MainTexSampler_1.xxx);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, _ColorA.xyz, MainTexSampler_1.xxx);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, _ColorA.xyz, MainTexSampler_1.xxx);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, _ColorA.xyz, MainTexSampler_1.xxx);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  o_2.xyz = mix (o_2.xyz, vec3(dot (o_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, _ColorA.xyz, MainTexSampler_1.xxx);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  o_2.xyz = mix (o_2.xyz, vec3(dot (o_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, _ColorA.xyz, MainTexSampler_1.xxx);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  o_2.xyz = mix (o_2.xyz, vec3(dot (o_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, _ColorA.xyz, MainTexSampler_1.xxx);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, _ColorA.xyz, MainTexSampler_1.xxx);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, _ColorA.xyz, MainTexSampler_1.xxx);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, _ColorA.xyz, MainTexSampler_1.xxx);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  o_2.xyz = mix (o_2.xyz, vec3(dot (o_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, _ColorA.xyz, MainTexSampler_1.xxx);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  o_2.xyz = mix (o_2.xyz, vec3(dot (o_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, _ColorA.xyz, MainTexSampler_1.xxx);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  o_2.xyz = mix (o_2.xyz, vec3(dot (o_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, _ColorA.xyz, MainTexSampler_1.xxx);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, _ColorA.xyz, MainTexSampler_1.xxx);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, _ColorA.xyz, MainTexSampler_1.xxx);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, _ColorA.xyz, MainTexSampler_1.xxx);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  o_2.xyz = mix (o_2.xyz, vec3(dot (o_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, _ColorA.xyz, MainTexSampler_1.xxx);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  o_2.xyz = mix (o_2.xyz, vec3(dot (o_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, _ColorA.xyz, MainTexSampler_1.xxx);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  o_2.xyz = mix (o_2.xyz, vec3(dot (o_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, _ColorA.xyz, MainTexSampler_1.xxx);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, _ColorA.xyz, MainTexSampler_1.xxx);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, _ColorA.xyz, MainTexSampler_1.xxx);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, _ColorA.xyz, MainTexSampler_1.xxx);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  o_2.xyz = mix (o_2.xyz, vec3(dot (o_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, _ColorA.xyz, MainTexSampler_1.xxx);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  o_2.xyz = mix (o_2.xyz, vec3(dot (o_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, _ColorA.xyz, MainTexSampler_1.xxx);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  o_2.xyz = mix (o_2.xyz, vec3(dot (o_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, MainTexSampler_1.xxx);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, MainTexSampler_1.xxx);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, MainTexSampler_1.xxx);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, MainTexSampler_1.xxx);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  o_2.xyz = mix (o_2.xyz, vec3(dot (o_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, MainTexSampler_1.xxx);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  o_2.xyz = mix (o_2.xyz, vec3(dot (o_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, MainTexSampler_1.xxx);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  o_2.xyz = mix (o_2.xyz, vec3(dot (o_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, MainTexSampler_1.xxx);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, MainTexSampler_1.xxx);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, MainTexSampler_1.xxx);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, MainTexSampler_1.xxx);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  o_2.xyz = mix (o_2.xyz, vec3(dot (o_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, MainTexSampler_1.xxx);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  o_2.xyz = mix (o_2.xyz, vec3(dot (o_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, MainTexSampler_1.xxx);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  o_2.xyz = mix (o_2.xyz, vec3(dot (o_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, MainTexSampler_1.xxx);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, MainTexSampler_1.xxx);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, MainTexSampler_1.xxx);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, MainTexSampler_1.xxx);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  o_2.xyz = mix (o_2.xyz, vec3(dot (o_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, MainTexSampler_1.xxx);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  o_2.xyz = mix (o_2.xyz, vec3(dot (o_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, MainTexSampler_1.xxx);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  o_2.xyz = mix (o_2.xyz, vec3(dot (o_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, MainTexSampler_1.xxx);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, MainTexSampler_1.xxx);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, MainTexSampler_1.xxx);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, MainTexSampler_1.xxx);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  o_2.xyz = mix (o_2.xyz, vec3(dot (o_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, MainTexSampler_1.xxx);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  o_2.xyz = mix (o_2.xyz, vec3(dot (o_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, MainTexSampler_1.xxx);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  o_2.xyz = mix (o_2.xyz, vec3(dot (o_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, _ColorA.xyz, MainTexSampler_1.xxx);
  o_2.xyz = mix (_ColorC.xyz, o_2.xyz, MainTexSampler_1.yyy);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, _ColorA.xyz, MainTexSampler_1.xxx);
  o_2.xyz = mix (_ColorC.xyz, o_2.xyz, MainTexSampler_1.yyy);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, _ColorA.xyz, MainTexSampler_1.xxx);
  o_2.xyz = mix (_ColorC.xyz, o_2.xyz, MainTexSampler_1.yyy);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  gl_FragData[0] = o_2;
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
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, _ColorA.xyz, MainTexSampler_1.xxx);
  o_2.xyz = mix (_ColorC.xyz, o_2.xyz, MainTexSampler_1.yyy);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  o_2.xyz = mix (o_2.xyz, vec3(dot (o_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = o_2;
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
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, _ColorA.xyz, MainTexSampler_1.xxx);
  o_2.xyz = mix (_ColorC.xyz, o_2.xyz, MainTexSampler_1.yyy);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  o_2.xyz = mix (o_2.xyz, vec3(dot (o_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = o_2;
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
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, _ColorA.xyz, MainTexSampler_1.xxx);
  o_2.xyz = mix (_ColorC.xyz, o_2.xyz, MainTexSampler_1.yyy);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  o_2.xyz = mix (o_2.xyz, vec3(dot (o_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, _ColorA.xyz, MainTexSampler_1.xxx);
  o_2.xyz = mix (_ColorC.xyz, o_2.xyz, MainTexSampler_1.yyy);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, _ColorA.xyz, MainTexSampler_1.xxx);
  o_2.xyz = mix (_ColorC.xyz, o_2.xyz, MainTexSampler_1.yyy);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, _ColorA.xyz, MainTexSampler_1.xxx);
  o_2.xyz = mix (_ColorC.xyz, o_2.xyz, MainTexSampler_1.yyy);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  gl_FragData[0] = o_2;
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
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, _ColorA.xyz, MainTexSampler_1.xxx);
  o_2.xyz = mix (_ColorC.xyz, o_2.xyz, MainTexSampler_1.yyy);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  o_2.xyz = mix (o_2.xyz, vec3(dot (o_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = o_2;
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
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, _ColorA.xyz, MainTexSampler_1.xxx);
  o_2.xyz = mix (_ColorC.xyz, o_2.xyz, MainTexSampler_1.yyy);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  o_2.xyz = mix (o_2.xyz, vec3(dot (o_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = o_2;
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
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, _ColorA.xyz, MainTexSampler_1.xxx);
  o_2.xyz = mix (_ColorC.xyz, o_2.xyz, MainTexSampler_1.yyy);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  o_2.xyz = mix (o_2.xyz, vec3(dot (o_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, _ColorA.xyz, MainTexSampler_1.xxx);
  o_2.xyz = mix (_ColorC.xyz, o_2.xyz, MainTexSampler_1.yyy);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, _ColorA.xyz, MainTexSampler_1.xxx);
  o_2.xyz = mix (_ColorC.xyz, o_2.xyz, MainTexSampler_1.yyy);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, _ColorA.xyz, MainTexSampler_1.xxx);
  o_2.xyz = mix (_ColorC.xyz, o_2.xyz, MainTexSampler_1.yyy);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  gl_FragData[0] = o_2;
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
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, _ColorA.xyz, MainTexSampler_1.xxx);
  o_2.xyz = mix (_ColorC.xyz, o_2.xyz, MainTexSampler_1.yyy);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  o_2.xyz = mix (o_2.xyz, vec3(dot (o_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = o_2;
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
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, _ColorA.xyz, MainTexSampler_1.xxx);
  o_2.xyz = mix (_ColorC.xyz, o_2.xyz, MainTexSampler_1.yyy);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  o_2.xyz = mix (o_2.xyz, vec3(dot (o_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = o_2;
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
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, _ColorA.xyz, MainTexSampler_1.xxx);
  o_2.xyz = mix (_ColorC.xyz, o_2.xyz, MainTexSampler_1.yyy);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  o_2.xyz = mix (o_2.xyz, vec3(dot (o_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, _ColorA.xyz, MainTexSampler_1.xxx);
  o_2.xyz = mix (_ColorC.xyz, o_2.xyz, MainTexSampler_1.yyy);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, _ColorA.xyz, MainTexSampler_1.xxx);
  o_2.xyz = mix (_ColorC.xyz, o_2.xyz, MainTexSampler_1.yyy);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorA;
uniform mediump vec4 _ColorB;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, _ColorA.xyz, MainTexSampler_1.xxx);
  o_2.xyz = mix (_ColorC.xyz, o_2.xyz, MainTexSampler_1.yyy);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  gl_FragData[0] = o_2;
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
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, _ColorA.xyz, MainTexSampler_1.xxx);
  o_2.xyz = mix (_ColorC.xyz, o_2.xyz, MainTexSampler_1.yyy);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  o_2.xyz = mix (o_2.xyz, vec3(dot (o_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = o_2;
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
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, _ColorA.xyz, MainTexSampler_1.xxx);
  o_2.xyz = mix (_ColorC.xyz, o_2.xyz, MainTexSampler_1.yyy);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  o_2.xyz = mix (o_2.xyz, vec3(dot (o_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = o_2;
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
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, _ColorA.xyz, MainTexSampler_1.xxx);
  o_2.xyz = mix (_ColorC.xyz, o_2.xyz, MainTexSampler_1.yyy);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  o_2.xyz = mix (o_2.xyz, vec3(dot (o_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, MainTexSampler_1.xxx);
  o_2.xyz = mix (_ColorC.xyz, o_2.xyz, MainTexSampler_1.yyy);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, MainTexSampler_1.xxx);
  o_2.xyz = mix (_ColorC.xyz, o_2.xyz, MainTexSampler_1.yyy);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, MainTexSampler_1.xxx);
  o_2.xyz = mix (_ColorC.xyz, o_2.xyz, MainTexSampler_1.yyy);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, MainTexSampler_1.xxx);
  o_2.xyz = mix (_ColorC.xyz, o_2.xyz, MainTexSampler_1.yyy);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  o_2.xyz = mix (o_2.xyz, vec3(dot (o_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, MainTexSampler_1.xxx);
  o_2.xyz = mix (_ColorC.xyz, o_2.xyz, MainTexSampler_1.yyy);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  o_2.xyz = mix (o_2.xyz, vec3(dot (o_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, MainTexSampler_1.xxx);
  o_2.xyz = mix (_ColorC.xyz, o_2.xyz, MainTexSampler_1.yyy);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  o_2.xyz = mix (o_2.xyz, vec3(dot (o_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, MainTexSampler_1.xxx);
  o_2.xyz = mix (_ColorC.xyz, o_2.xyz, MainTexSampler_1.yyy);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, MainTexSampler_1.xxx);
  o_2.xyz = mix (_ColorC.xyz, o_2.xyz, MainTexSampler_1.yyy);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, MainTexSampler_1.xxx);
  o_2.xyz = mix (_ColorC.xyz, o_2.xyz, MainTexSampler_1.yyy);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, MainTexSampler_1.xxx);
  o_2.xyz = mix (_ColorC.xyz, o_2.xyz, MainTexSampler_1.yyy);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  o_2.xyz = mix (o_2.xyz, vec3(dot (o_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, MainTexSampler_1.xxx);
  o_2.xyz = mix (_ColorC.xyz, o_2.xyz, MainTexSampler_1.yyy);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  o_2.xyz = mix (o_2.xyz, vec3(dot (o_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, MainTexSampler_1.xxx);
  o_2.xyz = mix (_ColorC.xyz, o_2.xyz, MainTexSampler_1.yyy);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  o_2.xyz = mix (o_2.xyz, vec3(dot (o_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, MainTexSampler_1.xxx);
  o_2.xyz = mix (_ColorC.xyz, o_2.xyz, MainTexSampler_1.yyy);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, MainTexSampler_1.xxx);
  o_2.xyz = mix (_ColorC.xyz, o_2.xyz, MainTexSampler_1.yyy);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, MainTexSampler_1.xxx);
  o_2.xyz = mix (_ColorC.xyz, o_2.xyz, MainTexSampler_1.yyy);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, MainTexSampler_1.xxx);
  o_2.xyz = mix (_ColorC.xyz, o_2.xyz, MainTexSampler_1.yyy);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  o_2.xyz = mix (o_2.xyz, vec3(dot (o_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, MainTexSampler_1.xxx);
  o_2.xyz = mix (_ColorC.xyz, o_2.xyz, MainTexSampler_1.yyy);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  o_2.xyz = mix (o_2.xyz, vec3(dot (o_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, MainTexSampler_1.xxx);
  o_2.xyz = mix (_ColorC.xyz, o_2.xyz, MainTexSampler_1.yyy);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  o_2.xyz = mix (o_2.xyz, vec3(dot (o_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, MainTexSampler_1.xxx);
  o_2.xyz = mix (_ColorC.xyz, o_2.xyz, MainTexSampler_1.yyy);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, MainTexSampler_1.xxx);
  o_2.xyz = mix (_ColorC.xyz, o_2.xyz, MainTexSampler_1.yyy);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, MainTexSampler_1.xxx);
  o_2.xyz = mix (_ColorC.xyz, o_2.xyz, MainTexSampler_1.yyy);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, MainTexSampler_1.xxx);
  o_2.xyz = mix (_ColorC.xyz, o_2.xyz, MainTexSampler_1.yyy);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  o_2.xyz = mix (o_2.xyz, vec3(dot (o_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, MainTexSampler_1.xxx);
  o_2.xyz = mix (_ColorC.xyz, o_2.xyz, MainTexSampler_1.yyy);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  o_2.xyz = mix (o_2.xyz, vec3(dot (o_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = o_2;
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
uniform highp float _AlphaChannelMapping;
uniform mediump vec4 _ColorB;
uniform mediump vec4 _ColorC;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 MainTexSampler_1;
  mediump vec4 o_2;
  o_2.w = xlv_COLOR.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  MainTexSampler_1 = tmpvar_4;
  o_2.xyz = mix (_ColorB.xyz, xlv_COLOR.xyz, MainTexSampler_1.xxx);
  o_2.xyz = mix (_ColorC.xyz, o_2.xyz, MainTexSampler_1.yyy);
  o_2.xyz = (o_2.xyz * _EmissionScaler);
  if ((_AlphaChannelMapping == 0.0)) {
    o_2.w = (xlv_COLOR.w * MainTexSampler_1.x);
  } else {
    if ((_AlphaChannelMapping == 1.0)) {
      o_2.w = (o_2.w * MainTexSampler_1.y);
    } else {
      if ((_AlphaChannelMapping == 2.0)) {
        o_2.w = (o_2.w * MainTexSampler_1.z);
      } else {
        if ((_AlphaChannelMapping == 3.0)) {
          o_2.w = (o_2.w * MainTexSampler_1.w);
        };
      };
    };
  };
  o_2.xyz = mix (vec3(1.0, 1.0, 1.0), o_2.xyz, o_2.www);
  o_2.xyz = mix (o_2.xyz, vec3(dot (o_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
}
}