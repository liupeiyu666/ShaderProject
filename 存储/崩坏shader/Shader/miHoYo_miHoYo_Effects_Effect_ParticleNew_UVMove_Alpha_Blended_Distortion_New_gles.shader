//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_ParticleNew/UVMove_Alpha_Blended_Distortion_New" {
Properties {
_MainColor ("MainColor", Color) = (1,1,1,0)
_MainIntensity ("MainIntensity", Float) = 1
_MainTexture ("MainTexture", 2D) = "white" { }
_mainTexSpeed ("mainTexSpeed", Vector) = (0,0,0,0)
_MainAlphaTexture ("MainAlphaTexture ", 2D) = "white" { }
[Enum(R,0,G,1,B,2,A,3)] _MainAlphaTextureChannelToggle ("MainAlphaTextureChannelToggle", Float) = 3
_NoiseTex ("NoiseTex", 2D) = "white" { }
_NoiseSpeed ("NoiseSpeed", Vector) = (0,0,0,0)
_NoiseIntensity ("NoiseIntensity", Float) = 0
_texcoord ("", 2D) = "white" { }
_DisTex ("DisTex", 2D) = "white" { }
_DisMain ("DisMain", Range(0, 1)) = 0.4408133
_DisEdgeColor ("DisEdgeColor", Color) = (1,0.07075471,0.07075471,0)
_DisEdgeSoft ("DisEdgeSoft", Range(0, 1)) = 0
_DisEdgeIntensiy ("DisEdgeIntensiy", Float) = 1
_DisEdge ("DisEdge", Range(0, 2)) = 0.13
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Off
  GpuProgramID 24344
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
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainAlphaTexture;
uniform highp vec4 _MainAlphaTexture_ST;
uniform mediump float _MainAlphaTextureChannelToggle;
uniform sampler2D _MainTexture;
uniform highp vec2 _mainTexSpeed;
uniform highp vec4 _MainTexture_ST;
uniform sampler2D _NoiseTex;
uniform highp vec2 _NoiseSpeed;
uniform highp vec4 _NoiseTex_ST;
uniform highp float _NoiseIntensity;
uniform highp vec4 _MainColor;
uniform highp float _MainIntensity;
uniform highp float _DisMain;
uniform highp float _DisEdgeSoft;
uniform sampler2D _DisTex;
uniform highp vec4 _DisTex_ST;
uniform highp float _DisEdge;
uniform highp vec4 _DisEdgeColor;
uniform highp float _DisEdgeIntensiy;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 aseOutColor_1;
  highp vec4 tex2DNode4_2;
  mediump vec4 aseOutAlphaTemp_3;
  mediump float aseOutAlpha_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _MainAlphaTexture_ST.xy) + _MainAlphaTexture_ST.zw);
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_Time.y * _mainTexSpeed) + ((xlv_TEXCOORD0.xy * _MainTexture_ST.xy) + _MainTexture_ST.zw));
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_Time.y * _NoiseSpeed) + ((xlv_TEXCOORD0.xy * _NoiseTex_ST.xy) + _NoiseTex_ST.zw));
  aseOutAlpha_4 = 0.0;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainAlphaTexture, tmpvar_5);
  aseOutAlphaTemp_3 = tmpvar_8;
  if ((_MainAlphaTextureChannelToggle == 0.0)) {
    aseOutAlpha_4 = aseOutAlphaTemp_3.x;
  } else {
    if ((_MainAlphaTextureChannelToggle == 1.0)) {
      aseOutAlpha_4 = aseOutAlphaTemp_3.y;
    } else {
      if ((_MainAlphaTextureChannelToggle == 2.0)) {
        aseOutAlpha_4 = aseOutAlphaTemp_3.z;
      } else {
        if ((_MainAlphaTextureChannelToggle == 3.0)) {
          aseOutAlpha_4 = aseOutAlphaTemp_3.w;
        };
      };
    };
  };
  highp float tmpvar_9;
  tmpvar_9 = ((_DisMain + xlv_TEXCOORD1.x) + -0.1);
  highp float tmpvar_10;
  tmpvar_10 = (tmpvar_9 + _DisEdgeSoft);
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD0.xy * _DisTex_ST.xy) + _DisTex_ST.zw);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_DisTex, tmpvar_11);
  tex2DNode4_2 = tmpvar_12;
  highp float tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = clamp (((tex2DNode4_2.x - tmpvar_9) / (tmpvar_10 - tmpvar_9)), 0.0, 1.0);
  tmpvar_13 = (tmpvar_14 * (tmpvar_14 * (3.0 - 
    (2.0 * tmpvar_14)
  )));
  highp float edge0_15;
  edge0_15 = (tmpvar_9 + _DisEdge);
  highp float tmpvar_16;
  tmpvar_16 = clamp (((tex2DNode4_2.x - edge0_15) / (
    (tmpvar_10 + _DisEdge)
   - edge0_15)), 0.0, 1.0);
  aseOutAlpha_4 = (aseOutAlpha_4 * tmpvar_13);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_NoiseTex, tmpvar_7);
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = (tmpvar_6 + (tmpvar_17.x * _NoiseIntensity));
  tmpvar_18 = texture2D (_MainTexture, P_19);
  highp vec3 tmpvar_20;
  tmpvar_20 = (((tmpvar_18 * _MainColor) * _MainIntensity) + ((
    (tmpvar_13 - (tmpvar_16 * (tmpvar_16 * (3.0 - 
      (2.0 * tmpvar_16)
    ))))
   * _DisEdgeColor) * _DisEdgeIntensiy)).xyz;
  aseOutColor_1 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = clamp (aseOutAlpha_4, 0.0, 1.0);
  aseOutAlpha_4 = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22.xyz = aseOutColor_1;
  tmpvar_22.w = tmpvar_21;
  gl_FragData[0] = tmpvar_22;
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
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainAlphaTexture;
uniform highp vec4 _MainAlphaTexture_ST;
uniform mediump float _MainAlphaTextureChannelToggle;
uniform sampler2D _MainTexture;
uniform highp vec2 _mainTexSpeed;
uniform highp vec4 _MainTexture_ST;
uniform sampler2D _NoiseTex;
uniform highp vec2 _NoiseSpeed;
uniform highp vec4 _NoiseTex_ST;
uniform highp float _NoiseIntensity;
uniform highp vec4 _MainColor;
uniform highp float _MainIntensity;
uniform highp float _DisMain;
uniform highp float _DisEdgeSoft;
uniform sampler2D _DisTex;
uniform highp vec4 _DisTex_ST;
uniform highp float _DisEdge;
uniform highp vec4 _DisEdgeColor;
uniform highp float _DisEdgeIntensiy;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 aseOutColor_1;
  highp vec4 tex2DNode4_2;
  mediump vec4 aseOutAlphaTemp_3;
  mediump float aseOutAlpha_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _MainAlphaTexture_ST.xy) + _MainAlphaTexture_ST.zw);
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_Time.y * _mainTexSpeed) + ((xlv_TEXCOORD0.xy * _MainTexture_ST.xy) + _MainTexture_ST.zw));
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_Time.y * _NoiseSpeed) + ((xlv_TEXCOORD0.xy * _NoiseTex_ST.xy) + _NoiseTex_ST.zw));
  aseOutAlpha_4 = 0.0;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainAlphaTexture, tmpvar_5);
  aseOutAlphaTemp_3 = tmpvar_8;
  if ((_MainAlphaTextureChannelToggle == 0.0)) {
    aseOutAlpha_4 = aseOutAlphaTemp_3.x;
  } else {
    if ((_MainAlphaTextureChannelToggle == 1.0)) {
      aseOutAlpha_4 = aseOutAlphaTemp_3.y;
    } else {
      if ((_MainAlphaTextureChannelToggle == 2.0)) {
        aseOutAlpha_4 = aseOutAlphaTemp_3.z;
      } else {
        if ((_MainAlphaTextureChannelToggle == 3.0)) {
          aseOutAlpha_4 = aseOutAlphaTemp_3.w;
        };
      };
    };
  };
  highp float tmpvar_9;
  tmpvar_9 = ((_DisMain + xlv_TEXCOORD1.x) + -0.1);
  highp float tmpvar_10;
  tmpvar_10 = (tmpvar_9 + _DisEdgeSoft);
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD0.xy * _DisTex_ST.xy) + _DisTex_ST.zw);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_DisTex, tmpvar_11);
  tex2DNode4_2 = tmpvar_12;
  highp float tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = clamp (((tex2DNode4_2.x - tmpvar_9) / (tmpvar_10 - tmpvar_9)), 0.0, 1.0);
  tmpvar_13 = (tmpvar_14 * (tmpvar_14 * (3.0 - 
    (2.0 * tmpvar_14)
  )));
  highp float edge0_15;
  edge0_15 = (tmpvar_9 + _DisEdge);
  highp float tmpvar_16;
  tmpvar_16 = clamp (((tex2DNode4_2.x - edge0_15) / (
    (tmpvar_10 + _DisEdge)
   - edge0_15)), 0.0, 1.0);
  aseOutAlpha_4 = (aseOutAlpha_4 * tmpvar_13);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_NoiseTex, tmpvar_7);
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = (tmpvar_6 + (tmpvar_17.x * _NoiseIntensity));
  tmpvar_18 = texture2D (_MainTexture, P_19);
  highp vec3 tmpvar_20;
  tmpvar_20 = (((tmpvar_18 * _MainColor) * _MainIntensity) + ((
    (tmpvar_13 - (tmpvar_16 * (tmpvar_16 * (3.0 - 
      (2.0 * tmpvar_16)
    ))))
   * _DisEdgeColor) * _DisEdgeIntensiy)).xyz;
  aseOutColor_1 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = clamp (aseOutAlpha_4, 0.0, 1.0);
  aseOutAlpha_4 = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22.xyz = aseOutColor_1;
  tmpvar_22.w = tmpvar_21;
  gl_FragData[0] = tmpvar_22;
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
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainAlphaTexture;
uniform highp vec4 _MainAlphaTexture_ST;
uniform mediump float _MainAlphaTextureChannelToggle;
uniform sampler2D _MainTexture;
uniform highp vec2 _mainTexSpeed;
uniform highp vec4 _MainTexture_ST;
uniform sampler2D _NoiseTex;
uniform highp vec2 _NoiseSpeed;
uniform highp vec4 _NoiseTex_ST;
uniform highp float _NoiseIntensity;
uniform highp vec4 _MainColor;
uniform highp float _MainIntensity;
uniform highp float _DisMain;
uniform highp float _DisEdgeSoft;
uniform sampler2D _DisTex;
uniform highp vec4 _DisTex_ST;
uniform highp float _DisEdge;
uniform highp vec4 _DisEdgeColor;
uniform highp float _DisEdgeIntensiy;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 aseOutColor_1;
  highp vec4 tex2DNode4_2;
  mediump vec4 aseOutAlphaTemp_3;
  mediump float aseOutAlpha_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _MainAlphaTexture_ST.xy) + _MainAlphaTexture_ST.zw);
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_Time.y * _mainTexSpeed) + ((xlv_TEXCOORD0.xy * _MainTexture_ST.xy) + _MainTexture_ST.zw));
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_Time.y * _NoiseSpeed) + ((xlv_TEXCOORD0.xy * _NoiseTex_ST.xy) + _NoiseTex_ST.zw));
  aseOutAlpha_4 = 0.0;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainAlphaTexture, tmpvar_5);
  aseOutAlphaTemp_3 = tmpvar_8;
  if ((_MainAlphaTextureChannelToggle == 0.0)) {
    aseOutAlpha_4 = aseOutAlphaTemp_3.x;
  } else {
    if ((_MainAlphaTextureChannelToggle == 1.0)) {
      aseOutAlpha_4 = aseOutAlphaTemp_3.y;
    } else {
      if ((_MainAlphaTextureChannelToggle == 2.0)) {
        aseOutAlpha_4 = aseOutAlphaTemp_3.z;
      } else {
        if ((_MainAlphaTextureChannelToggle == 3.0)) {
          aseOutAlpha_4 = aseOutAlphaTemp_3.w;
        };
      };
    };
  };
  highp float tmpvar_9;
  tmpvar_9 = ((_DisMain + xlv_TEXCOORD1.x) + -0.1);
  highp float tmpvar_10;
  tmpvar_10 = (tmpvar_9 + _DisEdgeSoft);
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD0.xy * _DisTex_ST.xy) + _DisTex_ST.zw);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_DisTex, tmpvar_11);
  tex2DNode4_2 = tmpvar_12;
  highp float tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = clamp (((tex2DNode4_2.x - tmpvar_9) / (tmpvar_10 - tmpvar_9)), 0.0, 1.0);
  tmpvar_13 = (tmpvar_14 * (tmpvar_14 * (3.0 - 
    (2.0 * tmpvar_14)
  )));
  highp float edge0_15;
  edge0_15 = (tmpvar_9 + _DisEdge);
  highp float tmpvar_16;
  tmpvar_16 = clamp (((tex2DNode4_2.x - edge0_15) / (
    (tmpvar_10 + _DisEdge)
   - edge0_15)), 0.0, 1.0);
  aseOutAlpha_4 = (aseOutAlpha_4 * tmpvar_13);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_NoiseTex, tmpvar_7);
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = (tmpvar_6 + (tmpvar_17.x * _NoiseIntensity));
  tmpvar_18 = texture2D (_MainTexture, P_19);
  highp vec3 tmpvar_20;
  tmpvar_20 = (((tmpvar_18 * _MainColor) * _MainIntensity) + ((
    (tmpvar_13 - (tmpvar_16 * (tmpvar_16 * (3.0 - 
      (2.0 * tmpvar_16)
    ))))
   * _DisEdgeColor) * _DisEdgeIntensiy)).xyz;
  aseOutColor_1 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = clamp (aseOutAlpha_4, 0.0, 1.0);
  aseOutAlpha_4 = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22.xyz = aseOutColor_1;
  tmpvar_22.w = tmpvar_21;
  gl_FragData[0] = tmpvar_22;
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
Fallback "Diffuse"
CustomEditor "MoleMole.ParticleShaderEditorBase"
}