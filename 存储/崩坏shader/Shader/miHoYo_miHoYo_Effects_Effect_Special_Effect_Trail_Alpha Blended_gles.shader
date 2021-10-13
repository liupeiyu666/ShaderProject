//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Special/Effect_Trail/Alpha Blended" {
Properties {
_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
_MainTex ("Particle Texture", 2D) = "white" { }
_AppearTime ("Appear Time", Range(0, 1)) = 0
_VanishTime ("Vanish Time", Range(0, 1)) = 0
_AlphaOverLife ("Alpha Over Life", Vector) = (0.197,0.815,0,0)
_CamForward ("Camera Forward", Vector) = (0,0,1,0)
_IsUseCamForward ("Is Use Camera Forward", Range(0, 1)) = 1
_BloomFactor ("Bloom Factor", Float) = 1
_EmissionScaler ("Emission Scaler", Range(0, 50)) = 1
[Toggle(DISTORTION)] _Distortion ("Distortion", Float) = 0
_DTTex ("Distortion Tex", 2D) = "gray" { }
_DTIntensity ("Distortion Intensity", Range(0, 10)) = 5
}
SubShader {
 Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
 Pass {
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 2673
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _AppearTime;
uniform highp float _VanishTime;
uniform highp vec2 _AlphaOverLife;
uniform highp vec3 _CamForward;
uniform highp float _IsUseCamForward;
uniform highp mat4 _SizeOverLife;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_3;
  tmpvar_3 = _glesNormal;
  highp vec4 tmpvar_4;
  tmpvar_4 = _glesVertex;
  highp vec3 faceForward_5;
  highp float time_6;
  highp vec2 tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_7 = vec2(0.0, 0.0);
  tmpvar_8 = vec4(0.0, 0.0, 0.0, 0.0);
  highp float tmpvar_9;
  if ((_VanishTime < 0.01)) {
    tmpvar_9 = _AppearTime;
  } else {
    tmpvar_9 = (1.0 + _VanishTime);
  };
  time_6 = (tmpvar_9 - _glesMultiTexCoord0.x);
  highp float tmpvar_10;
  tmpvar_10 = clamp (time_6, 0.0, 1.0);
  highp float t_11;
  highp float size_12;
  t_11 = (tmpvar_10 * 14.99);
  highp int tmpvar_13;
  tmpvar_13 = int(floor(t_11));
  highp int tmpvar_14;
  tmpvar_14 = (tmpvar_13 + 1);
  highp int tmpvar_15;
  tmpvar_15 = (tmpvar_13 / 4);
  highp int tmpvar_16;
  tmpvar_16 = int((float(mod (float(tmpvar_13), 4.0))));
  highp int tmpvar_17;
  tmpvar_17 = (tmpvar_14 / 4);
  highp int tmpvar_18;
  tmpvar_18 = int((float(mod (float(tmpvar_14), 4.0))));
  size_12 = 0.0;
  highp float tmpvar_19;
  tmpvar_19 = (t_11 - float(tmpvar_13));
  if ((tmpvar_15 == 0)) {
    if ((tmpvar_17 == 0)) {
      size_12 = mix (_SizeOverLife[tmpvar_16].x, _SizeOverLife[tmpvar_18].x, tmpvar_19);
    } else {
      size_12 = mix (_SizeOverLife[tmpvar_16].x, _SizeOverLife[tmpvar_18].y, tmpvar_19);
    };
  } else {
    if ((tmpvar_15 == 1)) {
      if ((tmpvar_17 == 1)) {
        size_12 = mix (_SizeOverLife[tmpvar_16].y, _SizeOverLife[tmpvar_18].y, tmpvar_19);
      } else {
        size_12 = mix (_SizeOverLife[tmpvar_16].y, _SizeOverLife[tmpvar_18].z, tmpvar_19);
      };
    } else {
      if ((tmpvar_15 == 2)) {
        if ((tmpvar_17 == 2)) {
          size_12 = mix (_SizeOverLife[tmpvar_16].z, _SizeOverLife[tmpvar_18].z, tmpvar_19);
        } else {
          size_12 = mix (_SizeOverLife[tmpvar_16].z, _SizeOverLife[tmpvar_18].w, tmpvar_19);
        };
      } else {
        if ((tmpvar_15 == 3)) {
          size_12 = mix (_SizeOverLife[tmpvar_16].w, _SizeOverLife[tmpvar_18].w, tmpvar_19);
        };
      };
    };
  };
  if ((_IsUseCamForward >= 0.5)) {
    faceForward_5 = (sqrt(dot (_glesNormal, _glesNormal)) * normalize((
      (_glesNormal.yzx * _CamForward.zxy)
     - 
      (_glesNormal.zxy * _CamForward.yzx)
    )));
  } else {
    faceForward_5 = tmpvar_3;
  };
  tmpvar_4.xyz = (_glesVertex.xyz + (faceForward_5 * size_12));
  highp vec4 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = tmpvar_4.xyz;
  tmpvar_20 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_21));
  tmpvar_8 = tmpvar_1;
  mediump float alpha_22;
  alpha_22 = 1.0;
  highp float tmpvar_23;
  if ((tmpvar_10 < _AlphaOverLife.x)) {
    tmpvar_23 = (tmpvar_10 / _AlphaOverLife.x);
  } else {
    tmpvar_23 = 1.0;
  };
  alpha_22 = tmpvar_23;
  highp float tmpvar_24;
  if ((_AlphaOverLife.y < tmpvar_10)) {
    tmpvar_24 = ((1.0 - tmpvar_10) / (1.0 - _AlphaOverLife.y));
  } else {
    tmpvar_24 = alpha_22;
  };
  alpha_22 = tmpvar_24;
  tmpvar_8.w = alpha_22;
  highp float tmpvar_25;
  tmpvar_25 = max (0.0, _VanishTime);
  tmpvar_7.x = ((_glesMultiTexCoord0.x - tmpvar_25) / (_AppearTime - tmpvar_25));
  tmpvar_7.y = tmpvar_2.y;
  gl_Position = tmpvar_20;
  xlv_TEXCOORD0 = ((tmpvar_7 * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = time_6;
  xlv_COLOR = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 color_1;
  highp float x_2;
  x_2 = (xlv_TEXCOORD1 - 0.001);
  if ((x_2 < 0.0)) {
    discard;
  };
  highp float x_3;
  x_3 = (0.999 - xlv_TEXCOORD1);
  if ((x_3 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_5;
  tmpvar_5 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_4));
  color_1.xyz = (tmpvar_5.xyz * _EmissionScaler);
  color_1.w = clamp (tmpvar_5.w, 0.0, 1.0);
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _AppearTime;
uniform highp float _VanishTime;
uniform highp vec2 _AlphaOverLife;
uniform highp vec3 _CamForward;
uniform highp float _IsUseCamForward;
uniform highp mat4 _SizeOverLife;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_3;
  tmpvar_3 = _glesNormal;
  highp vec4 tmpvar_4;
  tmpvar_4 = _glesVertex;
  highp vec3 faceForward_5;
  highp float time_6;
  highp vec2 tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_7 = vec2(0.0, 0.0);
  tmpvar_8 = vec4(0.0, 0.0, 0.0, 0.0);
  highp float tmpvar_9;
  if ((_VanishTime < 0.01)) {
    tmpvar_9 = _AppearTime;
  } else {
    tmpvar_9 = (1.0 + _VanishTime);
  };
  time_6 = (tmpvar_9 - _glesMultiTexCoord0.x);
  highp float tmpvar_10;
  tmpvar_10 = clamp (time_6, 0.0, 1.0);
  highp float t_11;
  highp float size_12;
  t_11 = (tmpvar_10 * 14.99);
  highp int tmpvar_13;
  tmpvar_13 = int(floor(t_11));
  highp int tmpvar_14;
  tmpvar_14 = (tmpvar_13 + 1);
  highp int tmpvar_15;
  tmpvar_15 = (tmpvar_13 / 4);
  highp int tmpvar_16;
  tmpvar_16 = int((float(mod (float(tmpvar_13), 4.0))));
  highp int tmpvar_17;
  tmpvar_17 = (tmpvar_14 / 4);
  highp int tmpvar_18;
  tmpvar_18 = int((float(mod (float(tmpvar_14), 4.0))));
  size_12 = 0.0;
  highp float tmpvar_19;
  tmpvar_19 = (t_11 - float(tmpvar_13));
  if ((tmpvar_15 == 0)) {
    if ((tmpvar_17 == 0)) {
      size_12 = mix (_SizeOverLife[tmpvar_16].x, _SizeOverLife[tmpvar_18].x, tmpvar_19);
    } else {
      size_12 = mix (_SizeOverLife[tmpvar_16].x, _SizeOverLife[tmpvar_18].y, tmpvar_19);
    };
  } else {
    if ((tmpvar_15 == 1)) {
      if ((tmpvar_17 == 1)) {
        size_12 = mix (_SizeOverLife[tmpvar_16].y, _SizeOverLife[tmpvar_18].y, tmpvar_19);
      } else {
        size_12 = mix (_SizeOverLife[tmpvar_16].y, _SizeOverLife[tmpvar_18].z, tmpvar_19);
      };
    } else {
      if ((tmpvar_15 == 2)) {
        if ((tmpvar_17 == 2)) {
          size_12 = mix (_SizeOverLife[tmpvar_16].z, _SizeOverLife[tmpvar_18].z, tmpvar_19);
        } else {
          size_12 = mix (_SizeOverLife[tmpvar_16].z, _SizeOverLife[tmpvar_18].w, tmpvar_19);
        };
      } else {
        if ((tmpvar_15 == 3)) {
          size_12 = mix (_SizeOverLife[tmpvar_16].w, _SizeOverLife[tmpvar_18].w, tmpvar_19);
        };
      };
    };
  };
  if ((_IsUseCamForward >= 0.5)) {
    faceForward_5 = (sqrt(dot (_glesNormal, _glesNormal)) * normalize((
      (_glesNormal.yzx * _CamForward.zxy)
     - 
      (_glesNormal.zxy * _CamForward.yzx)
    )));
  } else {
    faceForward_5 = tmpvar_3;
  };
  tmpvar_4.xyz = (_glesVertex.xyz + (faceForward_5 * size_12));
  highp vec4 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = tmpvar_4.xyz;
  tmpvar_20 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_21));
  tmpvar_8 = tmpvar_1;
  mediump float alpha_22;
  alpha_22 = 1.0;
  highp float tmpvar_23;
  if ((tmpvar_10 < _AlphaOverLife.x)) {
    tmpvar_23 = (tmpvar_10 / _AlphaOverLife.x);
  } else {
    tmpvar_23 = 1.0;
  };
  alpha_22 = tmpvar_23;
  highp float tmpvar_24;
  if ((_AlphaOverLife.y < tmpvar_10)) {
    tmpvar_24 = ((1.0 - tmpvar_10) / (1.0 - _AlphaOverLife.y));
  } else {
    tmpvar_24 = alpha_22;
  };
  alpha_22 = tmpvar_24;
  tmpvar_8.w = alpha_22;
  highp float tmpvar_25;
  tmpvar_25 = max (0.0, _VanishTime);
  tmpvar_7.x = ((_glesMultiTexCoord0.x - tmpvar_25) / (_AppearTime - tmpvar_25));
  tmpvar_7.y = tmpvar_2.y;
  gl_Position = tmpvar_20;
  xlv_TEXCOORD0 = ((tmpvar_7 * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = time_6;
  xlv_COLOR = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 color_1;
  highp float x_2;
  x_2 = (xlv_TEXCOORD1 - 0.001);
  if ((x_2 < 0.0)) {
    discard;
  };
  highp float x_3;
  x_3 = (0.999 - xlv_TEXCOORD1);
  if ((x_3 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_5;
  tmpvar_5 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_4));
  color_1.xyz = (tmpvar_5.xyz * _EmissionScaler);
  color_1.w = clamp (tmpvar_5.w, 0.0, 1.0);
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _AppearTime;
uniform highp float _VanishTime;
uniform highp vec2 _AlphaOverLife;
uniform highp vec3 _CamForward;
uniform highp float _IsUseCamForward;
uniform highp mat4 _SizeOverLife;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_3;
  tmpvar_3 = _glesNormal;
  highp vec4 tmpvar_4;
  tmpvar_4 = _glesVertex;
  highp vec3 faceForward_5;
  highp float time_6;
  highp vec2 tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_7 = vec2(0.0, 0.0);
  tmpvar_8 = vec4(0.0, 0.0, 0.0, 0.0);
  highp float tmpvar_9;
  if ((_VanishTime < 0.01)) {
    tmpvar_9 = _AppearTime;
  } else {
    tmpvar_9 = (1.0 + _VanishTime);
  };
  time_6 = (tmpvar_9 - _glesMultiTexCoord0.x);
  highp float tmpvar_10;
  tmpvar_10 = clamp (time_6, 0.0, 1.0);
  highp float t_11;
  highp float size_12;
  t_11 = (tmpvar_10 * 14.99);
  highp int tmpvar_13;
  tmpvar_13 = int(floor(t_11));
  highp int tmpvar_14;
  tmpvar_14 = (tmpvar_13 + 1);
  highp int tmpvar_15;
  tmpvar_15 = (tmpvar_13 / 4);
  highp int tmpvar_16;
  tmpvar_16 = int((float(mod (float(tmpvar_13), 4.0))));
  highp int tmpvar_17;
  tmpvar_17 = (tmpvar_14 / 4);
  highp int tmpvar_18;
  tmpvar_18 = int((float(mod (float(tmpvar_14), 4.0))));
  size_12 = 0.0;
  highp float tmpvar_19;
  tmpvar_19 = (t_11 - float(tmpvar_13));
  if ((tmpvar_15 == 0)) {
    if ((tmpvar_17 == 0)) {
      size_12 = mix (_SizeOverLife[tmpvar_16].x, _SizeOverLife[tmpvar_18].x, tmpvar_19);
    } else {
      size_12 = mix (_SizeOverLife[tmpvar_16].x, _SizeOverLife[tmpvar_18].y, tmpvar_19);
    };
  } else {
    if ((tmpvar_15 == 1)) {
      if ((tmpvar_17 == 1)) {
        size_12 = mix (_SizeOverLife[tmpvar_16].y, _SizeOverLife[tmpvar_18].y, tmpvar_19);
      } else {
        size_12 = mix (_SizeOverLife[tmpvar_16].y, _SizeOverLife[tmpvar_18].z, tmpvar_19);
      };
    } else {
      if ((tmpvar_15 == 2)) {
        if ((tmpvar_17 == 2)) {
          size_12 = mix (_SizeOverLife[tmpvar_16].z, _SizeOverLife[tmpvar_18].z, tmpvar_19);
        } else {
          size_12 = mix (_SizeOverLife[tmpvar_16].z, _SizeOverLife[tmpvar_18].w, tmpvar_19);
        };
      } else {
        if ((tmpvar_15 == 3)) {
          size_12 = mix (_SizeOverLife[tmpvar_16].w, _SizeOverLife[tmpvar_18].w, tmpvar_19);
        };
      };
    };
  };
  if ((_IsUseCamForward >= 0.5)) {
    faceForward_5 = (sqrt(dot (_glesNormal, _glesNormal)) * normalize((
      (_glesNormal.yzx * _CamForward.zxy)
     - 
      (_glesNormal.zxy * _CamForward.yzx)
    )));
  } else {
    faceForward_5 = tmpvar_3;
  };
  tmpvar_4.xyz = (_glesVertex.xyz + (faceForward_5 * size_12));
  highp vec4 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = tmpvar_4.xyz;
  tmpvar_20 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_21));
  tmpvar_8 = tmpvar_1;
  mediump float alpha_22;
  alpha_22 = 1.0;
  highp float tmpvar_23;
  if ((tmpvar_10 < _AlphaOverLife.x)) {
    tmpvar_23 = (tmpvar_10 / _AlphaOverLife.x);
  } else {
    tmpvar_23 = 1.0;
  };
  alpha_22 = tmpvar_23;
  highp float tmpvar_24;
  if ((_AlphaOverLife.y < tmpvar_10)) {
    tmpvar_24 = ((1.0 - tmpvar_10) / (1.0 - _AlphaOverLife.y));
  } else {
    tmpvar_24 = alpha_22;
  };
  alpha_22 = tmpvar_24;
  tmpvar_8.w = alpha_22;
  highp float tmpvar_25;
  tmpvar_25 = max (0.0, _VanishTime);
  tmpvar_7.x = ((_glesMultiTexCoord0.x - tmpvar_25) / (_AppearTime - tmpvar_25));
  tmpvar_7.y = tmpvar_2.y;
  gl_Position = tmpvar_20;
  xlv_TEXCOORD0 = ((tmpvar_7 * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = time_6;
  xlv_COLOR = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 color_1;
  highp float x_2;
  x_2 = (xlv_TEXCOORD1 - 0.001);
  if ((x_2 < 0.0)) {
    discard;
  };
  highp float x_3;
  x_3 = (0.999 - xlv_TEXCOORD1);
  if ((x_3 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_5;
  tmpvar_5 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_4));
  color_1.xyz = (tmpvar_5.xyz * _EmissionScaler);
  color_1.w = clamp (tmpvar_5.w, 0.0, 1.0);
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
}
}
 Pass {
  Name "CONSTANT_MAX"
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 116039
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _AppearTime;
uniform highp float _VanishTime;
uniform highp vec2 _AlphaOverLife;
uniform highp vec3 _CamForward;
uniform highp float _IsUseCamForward;
uniform highp mat4 _SizeOverLife;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_3;
  tmpvar_3 = _glesNormal;
  highp vec4 tmpvar_4;
  tmpvar_4 = _glesVertex;
  highp vec3 faceForward_5;
  highp float time_6;
  highp vec2 tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_7 = vec2(0.0, 0.0);
  tmpvar_8 = vec4(0.0, 0.0, 0.0, 0.0);
  highp float tmpvar_9;
  if ((_VanishTime < 0.01)) {
    tmpvar_9 = _AppearTime;
  } else {
    tmpvar_9 = (1.0 + _VanishTime);
  };
  time_6 = (tmpvar_9 - _glesMultiTexCoord0.x);
  highp float tmpvar_10;
  tmpvar_10 = clamp (time_6, 0.0, 1.0);
  highp float t_11;
  highp float size_12;
  t_11 = (tmpvar_10 * 14.99);
  highp int tmpvar_13;
  tmpvar_13 = int(floor(t_11));
  highp int tmpvar_14;
  tmpvar_14 = (tmpvar_13 + 1);
  highp int tmpvar_15;
  tmpvar_15 = (tmpvar_13 / 4);
  highp int tmpvar_16;
  tmpvar_16 = int((float(mod (float(tmpvar_13), 4.0))));
  highp int tmpvar_17;
  tmpvar_17 = (tmpvar_14 / 4);
  highp int tmpvar_18;
  tmpvar_18 = int((float(mod (float(tmpvar_14), 4.0))));
  size_12 = 0.0;
  highp float tmpvar_19;
  tmpvar_19 = (t_11 - float(tmpvar_13));
  if ((tmpvar_15 == 0)) {
    if ((tmpvar_17 == 0)) {
      size_12 = mix (_SizeOverLife[tmpvar_16].x, _SizeOverLife[tmpvar_18].x, tmpvar_19);
    } else {
      size_12 = mix (_SizeOverLife[tmpvar_16].x, _SizeOverLife[tmpvar_18].y, tmpvar_19);
    };
  } else {
    if ((tmpvar_15 == 1)) {
      if ((tmpvar_17 == 1)) {
        size_12 = mix (_SizeOverLife[tmpvar_16].y, _SizeOverLife[tmpvar_18].y, tmpvar_19);
      } else {
        size_12 = mix (_SizeOverLife[tmpvar_16].y, _SizeOverLife[tmpvar_18].z, tmpvar_19);
      };
    } else {
      if ((tmpvar_15 == 2)) {
        if ((tmpvar_17 == 2)) {
          size_12 = mix (_SizeOverLife[tmpvar_16].z, _SizeOverLife[tmpvar_18].z, tmpvar_19);
        } else {
          size_12 = mix (_SizeOverLife[tmpvar_16].z, _SizeOverLife[tmpvar_18].w, tmpvar_19);
        };
      } else {
        if ((tmpvar_15 == 3)) {
          size_12 = mix (_SizeOverLife[tmpvar_16].w, _SizeOverLife[tmpvar_18].w, tmpvar_19);
        };
      };
    };
  };
  if ((_IsUseCamForward >= 0.5)) {
    faceForward_5 = (sqrt(dot (_glesNormal, _glesNormal)) * normalize((
      (_glesNormal.yzx * _CamForward.zxy)
     - 
      (_glesNormal.zxy * _CamForward.yzx)
    )));
  } else {
    faceForward_5 = tmpvar_3;
  };
  tmpvar_4.xyz = (_glesVertex.xyz + (faceForward_5 * size_12));
  highp vec4 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = tmpvar_4.xyz;
  tmpvar_20 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_21));
  tmpvar_8 = tmpvar_1;
  mediump float alpha_22;
  alpha_22 = 1.0;
  highp float tmpvar_23;
  if ((tmpvar_10 < _AlphaOverLife.x)) {
    tmpvar_23 = (tmpvar_10 / _AlphaOverLife.x);
  } else {
    tmpvar_23 = 1.0;
  };
  alpha_22 = tmpvar_23;
  highp float tmpvar_24;
  if ((_AlphaOverLife.y < tmpvar_10)) {
    tmpvar_24 = ((1.0 - tmpvar_10) / (1.0 - _AlphaOverLife.y));
  } else {
    tmpvar_24 = alpha_22;
  };
  alpha_22 = tmpvar_24;
  tmpvar_8.w = alpha_22;
  highp float tmpvar_25;
  tmpvar_25 = max (0.0, _VanishTime);
  tmpvar_7.x = ((_glesMultiTexCoord0.x - tmpvar_25) / (_AppearTime - tmpvar_25));
  tmpvar_7.y = tmpvar_2.y;
  gl_Position = tmpvar_20;
  xlv_TEXCOORD0 = ((tmpvar_7 * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = time_6;
  xlv_COLOR = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  highp float x_2;
  x_2 = (xlv_TEXCOORD1 - 0.001);
  if ((x_2 < 0.0)) {
    discard;
  };
  highp float x_3;
  x_3 = (0.999 - xlv_TEXCOORD1);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp float x_4;
  x_4 = (texture2D (_MainTex, xlv_TEXCOORD0).w - 0.01);
  if ((x_4 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _AppearTime;
uniform highp float _VanishTime;
uniform highp vec2 _AlphaOverLife;
uniform highp vec3 _CamForward;
uniform highp float _IsUseCamForward;
uniform highp mat4 _SizeOverLife;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_3;
  tmpvar_3 = _glesNormal;
  highp vec4 tmpvar_4;
  tmpvar_4 = _glesVertex;
  highp vec3 faceForward_5;
  highp float time_6;
  highp vec2 tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_7 = vec2(0.0, 0.0);
  tmpvar_8 = vec4(0.0, 0.0, 0.0, 0.0);
  highp float tmpvar_9;
  if ((_VanishTime < 0.01)) {
    tmpvar_9 = _AppearTime;
  } else {
    tmpvar_9 = (1.0 + _VanishTime);
  };
  time_6 = (tmpvar_9 - _glesMultiTexCoord0.x);
  highp float tmpvar_10;
  tmpvar_10 = clamp (time_6, 0.0, 1.0);
  highp float t_11;
  highp float size_12;
  t_11 = (tmpvar_10 * 14.99);
  highp int tmpvar_13;
  tmpvar_13 = int(floor(t_11));
  highp int tmpvar_14;
  tmpvar_14 = (tmpvar_13 + 1);
  highp int tmpvar_15;
  tmpvar_15 = (tmpvar_13 / 4);
  highp int tmpvar_16;
  tmpvar_16 = int((float(mod (float(tmpvar_13), 4.0))));
  highp int tmpvar_17;
  tmpvar_17 = (tmpvar_14 / 4);
  highp int tmpvar_18;
  tmpvar_18 = int((float(mod (float(tmpvar_14), 4.0))));
  size_12 = 0.0;
  highp float tmpvar_19;
  tmpvar_19 = (t_11 - float(tmpvar_13));
  if ((tmpvar_15 == 0)) {
    if ((tmpvar_17 == 0)) {
      size_12 = mix (_SizeOverLife[tmpvar_16].x, _SizeOverLife[tmpvar_18].x, tmpvar_19);
    } else {
      size_12 = mix (_SizeOverLife[tmpvar_16].x, _SizeOverLife[tmpvar_18].y, tmpvar_19);
    };
  } else {
    if ((tmpvar_15 == 1)) {
      if ((tmpvar_17 == 1)) {
        size_12 = mix (_SizeOverLife[tmpvar_16].y, _SizeOverLife[tmpvar_18].y, tmpvar_19);
      } else {
        size_12 = mix (_SizeOverLife[tmpvar_16].y, _SizeOverLife[tmpvar_18].z, tmpvar_19);
      };
    } else {
      if ((tmpvar_15 == 2)) {
        if ((tmpvar_17 == 2)) {
          size_12 = mix (_SizeOverLife[tmpvar_16].z, _SizeOverLife[tmpvar_18].z, tmpvar_19);
        } else {
          size_12 = mix (_SizeOverLife[tmpvar_16].z, _SizeOverLife[tmpvar_18].w, tmpvar_19);
        };
      } else {
        if ((tmpvar_15 == 3)) {
          size_12 = mix (_SizeOverLife[tmpvar_16].w, _SizeOverLife[tmpvar_18].w, tmpvar_19);
        };
      };
    };
  };
  if ((_IsUseCamForward >= 0.5)) {
    faceForward_5 = (sqrt(dot (_glesNormal, _glesNormal)) * normalize((
      (_glesNormal.yzx * _CamForward.zxy)
     - 
      (_glesNormal.zxy * _CamForward.yzx)
    )));
  } else {
    faceForward_5 = tmpvar_3;
  };
  tmpvar_4.xyz = (_glesVertex.xyz + (faceForward_5 * size_12));
  highp vec4 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = tmpvar_4.xyz;
  tmpvar_20 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_21));
  tmpvar_8 = tmpvar_1;
  mediump float alpha_22;
  alpha_22 = 1.0;
  highp float tmpvar_23;
  if ((tmpvar_10 < _AlphaOverLife.x)) {
    tmpvar_23 = (tmpvar_10 / _AlphaOverLife.x);
  } else {
    tmpvar_23 = 1.0;
  };
  alpha_22 = tmpvar_23;
  highp float tmpvar_24;
  if ((_AlphaOverLife.y < tmpvar_10)) {
    tmpvar_24 = ((1.0 - tmpvar_10) / (1.0 - _AlphaOverLife.y));
  } else {
    tmpvar_24 = alpha_22;
  };
  alpha_22 = tmpvar_24;
  tmpvar_8.w = alpha_22;
  highp float tmpvar_25;
  tmpvar_25 = max (0.0, _VanishTime);
  tmpvar_7.x = ((_glesMultiTexCoord0.x - tmpvar_25) / (_AppearTime - tmpvar_25));
  tmpvar_7.y = tmpvar_2.y;
  gl_Position = tmpvar_20;
  xlv_TEXCOORD0 = ((tmpvar_7 * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = time_6;
  xlv_COLOR = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  highp float x_2;
  x_2 = (xlv_TEXCOORD1 - 0.001);
  if ((x_2 < 0.0)) {
    discard;
  };
  highp float x_3;
  x_3 = (0.999 - xlv_TEXCOORD1);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp float x_4;
  x_4 = (texture2D (_MainTex, xlv_TEXCOORD0).w - 0.01);
  if ((x_4 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _AppearTime;
uniform highp float _VanishTime;
uniform highp vec2 _AlphaOverLife;
uniform highp vec3 _CamForward;
uniform highp float _IsUseCamForward;
uniform highp mat4 _SizeOverLife;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_3;
  tmpvar_3 = _glesNormal;
  highp vec4 tmpvar_4;
  tmpvar_4 = _glesVertex;
  highp vec3 faceForward_5;
  highp float time_6;
  highp vec2 tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_7 = vec2(0.0, 0.0);
  tmpvar_8 = vec4(0.0, 0.0, 0.0, 0.0);
  highp float tmpvar_9;
  if ((_VanishTime < 0.01)) {
    tmpvar_9 = _AppearTime;
  } else {
    tmpvar_9 = (1.0 + _VanishTime);
  };
  time_6 = (tmpvar_9 - _glesMultiTexCoord0.x);
  highp float tmpvar_10;
  tmpvar_10 = clamp (time_6, 0.0, 1.0);
  highp float t_11;
  highp float size_12;
  t_11 = (tmpvar_10 * 14.99);
  highp int tmpvar_13;
  tmpvar_13 = int(floor(t_11));
  highp int tmpvar_14;
  tmpvar_14 = (tmpvar_13 + 1);
  highp int tmpvar_15;
  tmpvar_15 = (tmpvar_13 / 4);
  highp int tmpvar_16;
  tmpvar_16 = int((float(mod (float(tmpvar_13), 4.0))));
  highp int tmpvar_17;
  tmpvar_17 = (tmpvar_14 / 4);
  highp int tmpvar_18;
  tmpvar_18 = int((float(mod (float(tmpvar_14), 4.0))));
  size_12 = 0.0;
  highp float tmpvar_19;
  tmpvar_19 = (t_11 - float(tmpvar_13));
  if ((tmpvar_15 == 0)) {
    if ((tmpvar_17 == 0)) {
      size_12 = mix (_SizeOverLife[tmpvar_16].x, _SizeOverLife[tmpvar_18].x, tmpvar_19);
    } else {
      size_12 = mix (_SizeOverLife[tmpvar_16].x, _SizeOverLife[tmpvar_18].y, tmpvar_19);
    };
  } else {
    if ((tmpvar_15 == 1)) {
      if ((tmpvar_17 == 1)) {
        size_12 = mix (_SizeOverLife[tmpvar_16].y, _SizeOverLife[tmpvar_18].y, tmpvar_19);
      } else {
        size_12 = mix (_SizeOverLife[tmpvar_16].y, _SizeOverLife[tmpvar_18].z, tmpvar_19);
      };
    } else {
      if ((tmpvar_15 == 2)) {
        if ((tmpvar_17 == 2)) {
          size_12 = mix (_SizeOverLife[tmpvar_16].z, _SizeOverLife[tmpvar_18].z, tmpvar_19);
        } else {
          size_12 = mix (_SizeOverLife[tmpvar_16].z, _SizeOverLife[tmpvar_18].w, tmpvar_19);
        };
      } else {
        if ((tmpvar_15 == 3)) {
          size_12 = mix (_SizeOverLife[tmpvar_16].w, _SizeOverLife[tmpvar_18].w, tmpvar_19);
        };
      };
    };
  };
  if ((_IsUseCamForward >= 0.5)) {
    faceForward_5 = (sqrt(dot (_glesNormal, _glesNormal)) * normalize((
      (_glesNormal.yzx * _CamForward.zxy)
     - 
      (_glesNormal.zxy * _CamForward.yzx)
    )));
  } else {
    faceForward_5 = tmpvar_3;
  };
  tmpvar_4.xyz = (_glesVertex.xyz + (faceForward_5 * size_12));
  highp vec4 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = tmpvar_4.xyz;
  tmpvar_20 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_21));
  tmpvar_8 = tmpvar_1;
  mediump float alpha_22;
  alpha_22 = 1.0;
  highp float tmpvar_23;
  if ((tmpvar_10 < _AlphaOverLife.x)) {
    tmpvar_23 = (tmpvar_10 / _AlphaOverLife.x);
  } else {
    tmpvar_23 = 1.0;
  };
  alpha_22 = tmpvar_23;
  highp float tmpvar_24;
  if ((_AlphaOverLife.y < tmpvar_10)) {
    tmpvar_24 = ((1.0 - tmpvar_10) / (1.0 - _AlphaOverLife.y));
  } else {
    tmpvar_24 = alpha_22;
  };
  alpha_22 = tmpvar_24;
  tmpvar_8.w = alpha_22;
  highp float tmpvar_25;
  tmpvar_25 = max (0.0, _VanishTime);
  tmpvar_7.x = ((_glesMultiTexCoord0.x - tmpvar_25) / (_AppearTime - tmpvar_25));
  tmpvar_7.y = tmpvar_2.y;
  gl_Position = tmpvar_20;
  xlv_TEXCOORD0 = ((tmpvar_7 * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = time_6;
  xlv_COLOR = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  highp float x_2;
  x_2 = (xlv_TEXCOORD1 - 0.001);
  if ((x_2 < 0.0)) {
    discard;
  };
  highp float x_3;
  x_3 = (0.999 - xlv_TEXCOORD1);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp float x_4;
  x_4 = (texture2D (_MainTex, xlv_TEXCOORD0).w - 0.01);
  if ((x_4 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
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
}
}
}
CustomEditor "MoleMole.TrailShaderEditorBase"
}