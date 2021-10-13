//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/VisualizeWeatherMap" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 45952
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp int _VisualizeOption;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_2 = tmpvar_3;
  if ((_VisualizeOption == 1)) {
    mediump vec4 tmpvar_4;
    tmpvar_4.w = 1.0;
    tmpvar_4.xyz = col_2.xxx;
    tmpvar_1 = tmpvar_4;
  } else {
    if ((_VisualizeOption == 2)) {
      mediump vec4 tmpvar_5;
      tmpvar_5.w = 1.0;
      tmpvar_5.xyz = col_2.yyy;
      tmpvar_1 = tmpvar_5;
    } else {
      if ((_VisualizeOption == 3)) {
        mediump vec4 tmpvar_6;
        tmpvar_6.w = 1.0;
        tmpvar_6.xyz = col_2.zzz;
        tmpvar_1 = tmpvar_6;
      } else {
        if ((_VisualizeOption == 4)) {
          mediump vec4 tmpvar_7;
          tmpvar_7.w = 1.0;
          tmpvar_7.xyz = col_2.www;
          tmpvar_1 = tmpvar_7;
        } else {
          tmpvar_1 = col_2;
        };
      };
    };
  };
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp int _VisualizeOption;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_2 = tmpvar_3;
  if ((_VisualizeOption == 1)) {
    mediump vec4 tmpvar_4;
    tmpvar_4.w = 1.0;
    tmpvar_4.xyz = col_2.xxx;
    tmpvar_1 = tmpvar_4;
  } else {
    if ((_VisualizeOption == 2)) {
      mediump vec4 tmpvar_5;
      tmpvar_5.w = 1.0;
      tmpvar_5.xyz = col_2.yyy;
      tmpvar_1 = tmpvar_5;
    } else {
      if ((_VisualizeOption == 3)) {
        mediump vec4 tmpvar_6;
        tmpvar_6.w = 1.0;
        tmpvar_6.xyz = col_2.zzz;
        tmpvar_1 = tmpvar_6;
      } else {
        if ((_VisualizeOption == 4)) {
          mediump vec4 tmpvar_7;
          tmpvar_7.w = 1.0;
          tmpvar_7.xyz = col_2.www;
          tmpvar_1 = tmpvar_7;
        } else {
          tmpvar_1 = col_2;
        };
      };
    };
  };
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp int _VisualizeOption;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_2 = tmpvar_3;
  if ((_VisualizeOption == 1)) {
    mediump vec4 tmpvar_4;
    tmpvar_4.w = 1.0;
    tmpvar_4.xyz = col_2.xxx;
    tmpvar_1 = tmpvar_4;
  } else {
    if ((_VisualizeOption == 2)) {
      mediump vec4 tmpvar_5;
      tmpvar_5.w = 1.0;
      tmpvar_5.xyz = col_2.yyy;
      tmpvar_1 = tmpvar_5;
    } else {
      if ((_VisualizeOption == 3)) {
        mediump vec4 tmpvar_6;
        tmpvar_6.w = 1.0;
        tmpvar_6.xyz = col_2.zzz;
        tmpvar_1 = tmpvar_6;
      } else {
        if ((_VisualizeOption == 4)) {
          mediump vec4 tmpvar_7;
          tmpvar_7.w = 1.0;
          tmpvar_7.xyz = col_2.www;
          tmpvar_1 = tmpvar_7;
        } else {
          tmpvar_1 = col_2;
        };
      };
    };
  };
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
}
}
}
}