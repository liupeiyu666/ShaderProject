//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_UI/HUD Fan" {
Properties {
_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
_Texture ("Texture", 2D) = "white" { }
_FanAngle ("Fan Angle", Range(0.1, 6.28318)) = 1.57
_BorderAngle ("Border Triangle Angle", Range(0, 0.3)) = 0
_BloomFactor ("Bloom Factor", Float) = 1
_EmissionScaler ("Emission Scaler", Range(0, 50)) = 1
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+3" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+3" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 8392
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _FanAngle;
uniform highp float _BorderAngle;
uniform highp vec4 _Texture_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float xsign_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = vec2(0.0, 0.0);
  highp float tmpvar_4;
  tmpvar_4 = abs(_glesVertex.x);
  highp float tmpvar_5;
  tmpvar_5 = (_glesVertex.x / tmpvar_4);
  xsign_2 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = sqrt(dot (_glesVertex.xz, _glesVertex.xz));
  highp float tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = (min (abs(
    (tmpvar_4 / _glesVertex.z)
  ), 1.0) / max (abs(
    (tmpvar_4 / _glesVertex.z)
  ), 1.0));
  highp float tmpvar_9;
  tmpvar_9 = (tmpvar_8 * tmpvar_8);
  tmpvar_9 = (((
    ((((
      ((((-0.01213232 * tmpvar_9) + 0.05368138) * tmpvar_9) - 0.1173503)
     * tmpvar_9) + 0.1938925) * tmpvar_9) - 0.3326756)
   * tmpvar_9) + 0.9999793) * tmpvar_8);
  tmpvar_9 = (tmpvar_9 + (float(
    (abs((tmpvar_4 / _glesVertex.z)) > 1.0)
  ) * (
    (tmpvar_9 * -2.0)
   + 1.570796)));
  tmpvar_7 = (tmpvar_9 * sign((tmpvar_4 / _glesVertex.z)));
  if ((abs(_glesVertex.z) > (1e-08 * abs(tmpvar_4)))) {
    if ((_glesVertex.z < 0.0)) {
      if ((tmpvar_4 >= 0.0)) {
        tmpvar_7 += 3.141593;
      } else {
        tmpvar_7 = (tmpvar_7 - 3.141593);
      };
    };
  } else {
    tmpvar_7 = (sign(tmpvar_4) * 1.570796);
  };
  highp float tmpvar_10;
  tmpvar_10 = (3.14159 - _BorderAngle);
  highp float tmpvar_11;
  tmpvar_11 = ((_FanAngle * 0.5) - _BorderAngle);
  highp float tmpvar_12;
  if ((tmpvar_7 < tmpvar_10)) {
    tmpvar_12 = ((tmpvar_11 * tmpvar_7) / tmpvar_10);
  } else {
    tmpvar_12 = ((tmpvar_11 + tmpvar_7) - tmpvar_10);
  };
  tmpvar_1.x = ((xsign_2 * sin(tmpvar_12)) * tmpvar_6);
  tmpvar_1.z = (cos(tmpvar_12) * tmpvar_6);
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_1.xyz;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = 0.0;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TintColor;
uniform sampler2D _Texture;
uniform mediump float _EmissionScaler;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 texColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_Texture, xlv_TEXCOORD0);
  texColor_2 = tmpvar_3;
  mediump vec4 tmpvar_4;
  tmpvar_4 = ((2.0 * _TintColor) * texColor_2);
  color_1.w = tmpvar_4.w;
  color_1.xyz = (tmpvar_4.xyz * _EmissionScaler);
  gl_FragData[0] = color_1;
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
uniform highp float _FanAngle;
uniform highp float _BorderAngle;
uniform highp vec4 _Texture_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float xsign_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = vec2(0.0, 0.0);
  highp float tmpvar_4;
  tmpvar_4 = abs(_glesVertex.x);
  highp float tmpvar_5;
  tmpvar_5 = (_glesVertex.x / tmpvar_4);
  xsign_2 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = sqrt(dot (_glesVertex.xz, _glesVertex.xz));
  highp float tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = (min (abs(
    (tmpvar_4 / _glesVertex.z)
  ), 1.0) / max (abs(
    (tmpvar_4 / _glesVertex.z)
  ), 1.0));
  highp float tmpvar_9;
  tmpvar_9 = (tmpvar_8 * tmpvar_8);
  tmpvar_9 = (((
    ((((
      ((((-0.01213232 * tmpvar_9) + 0.05368138) * tmpvar_9) - 0.1173503)
     * tmpvar_9) + 0.1938925) * tmpvar_9) - 0.3326756)
   * tmpvar_9) + 0.9999793) * tmpvar_8);
  tmpvar_9 = (tmpvar_9 + (float(
    (abs((tmpvar_4 / _glesVertex.z)) > 1.0)
  ) * (
    (tmpvar_9 * -2.0)
   + 1.570796)));
  tmpvar_7 = (tmpvar_9 * sign((tmpvar_4 / _glesVertex.z)));
  if ((abs(_glesVertex.z) > (1e-08 * abs(tmpvar_4)))) {
    if ((_glesVertex.z < 0.0)) {
      if ((tmpvar_4 >= 0.0)) {
        tmpvar_7 += 3.141593;
      } else {
        tmpvar_7 = (tmpvar_7 - 3.141593);
      };
    };
  } else {
    tmpvar_7 = (sign(tmpvar_4) * 1.570796);
  };
  highp float tmpvar_10;
  tmpvar_10 = (3.14159 - _BorderAngle);
  highp float tmpvar_11;
  tmpvar_11 = ((_FanAngle * 0.5) - _BorderAngle);
  highp float tmpvar_12;
  if ((tmpvar_7 < tmpvar_10)) {
    tmpvar_12 = ((tmpvar_11 * tmpvar_7) / tmpvar_10);
  } else {
    tmpvar_12 = ((tmpvar_11 + tmpvar_7) - tmpvar_10);
  };
  tmpvar_1.x = ((xsign_2 * sin(tmpvar_12)) * tmpvar_6);
  tmpvar_1.z = (cos(tmpvar_12) * tmpvar_6);
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_1.xyz;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = 0.0;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TintColor;
uniform sampler2D _Texture;
uniform mediump float _EmissionScaler;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 texColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_Texture, xlv_TEXCOORD0);
  texColor_2 = tmpvar_3;
  mediump vec4 tmpvar_4;
  tmpvar_4 = ((2.0 * _TintColor) * texColor_2);
  color_1.w = tmpvar_4.w;
  color_1.xyz = (tmpvar_4.xyz * _EmissionScaler);
  gl_FragData[0] = color_1;
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
uniform highp float _FanAngle;
uniform highp float _BorderAngle;
uniform highp vec4 _Texture_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float xsign_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = vec2(0.0, 0.0);
  highp float tmpvar_4;
  tmpvar_4 = abs(_glesVertex.x);
  highp float tmpvar_5;
  tmpvar_5 = (_glesVertex.x / tmpvar_4);
  xsign_2 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = sqrt(dot (_glesVertex.xz, _glesVertex.xz));
  highp float tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = (min (abs(
    (tmpvar_4 / _glesVertex.z)
  ), 1.0) / max (abs(
    (tmpvar_4 / _glesVertex.z)
  ), 1.0));
  highp float tmpvar_9;
  tmpvar_9 = (tmpvar_8 * tmpvar_8);
  tmpvar_9 = (((
    ((((
      ((((-0.01213232 * tmpvar_9) + 0.05368138) * tmpvar_9) - 0.1173503)
     * tmpvar_9) + 0.1938925) * tmpvar_9) - 0.3326756)
   * tmpvar_9) + 0.9999793) * tmpvar_8);
  tmpvar_9 = (tmpvar_9 + (float(
    (abs((tmpvar_4 / _glesVertex.z)) > 1.0)
  ) * (
    (tmpvar_9 * -2.0)
   + 1.570796)));
  tmpvar_7 = (tmpvar_9 * sign((tmpvar_4 / _glesVertex.z)));
  if ((abs(_glesVertex.z) > (1e-08 * abs(tmpvar_4)))) {
    if ((_glesVertex.z < 0.0)) {
      if ((tmpvar_4 >= 0.0)) {
        tmpvar_7 += 3.141593;
      } else {
        tmpvar_7 = (tmpvar_7 - 3.141593);
      };
    };
  } else {
    tmpvar_7 = (sign(tmpvar_4) * 1.570796);
  };
  highp float tmpvar_10;
  tmpvar_10 = (3.14159 - _BorderAngle);
  highp float tmpvar_11;
  tmpvar_11 = ((_FanAngle * 0.5) - _BorderAngle);
  highp float tmpvar_12;
  if ((tmpvar_7 < tmpvar_10)) {
    tmpvar_12 = ((tmpvar_11 * tmpvar_7) / tmpvar_10);
  } else {
    tmpvar_12 = ((tmpvar_11 + tmpvar_7) - tmpvar_10);
  };
  tmpvar_1.x = ((xsign_2 * sin(tmpvar_12)) * tmpvar_6);
  tmpvar_1.z = (cos(tmpvar_12) * tmpvar_6);
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_1.xyz;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = 0.0;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TintColor;
uniform sampler2D _Texture;
uniform mediump float _EmissionScaler;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 texColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_Texture, xlv_TEXCOORD0);
  texColor_2 = tmpvar_3;
  mediump vec4 tmpvar_4;
  tmpvar_4 = ((2.0 * _TintColor) * texColor_2);
  color_1.w = tmpvar_4.w;
  color_1.xyz = (tmpvar_4.xyz * _EmissionScaler);
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
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+3" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 113508
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Texture_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _Texture;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  mediump float alpha_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_Texture, xlv_TEXCOORD0).w;
  alpha_2 = tmpvar_3;
  mediump float x_4;
  x_4 = (alpha_2 - 0.01);
  if ((x_4 < 0.0)) {
    discard;
  };
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_ORIG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Texture_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _Texture;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  mediump float alpha_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_Texture, xlv_TEXCOORD0).w;
  alpha_2 = tmpvar_3;
  mediump float x_4;
  x_4 = (alpha_2 - 0.01);
  if ((x_4 < 0.0)) {
    discard;
  };
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_ORIG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Texture_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _Texture;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  mediump float alpha_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_Texture, xlv_TEXCOORD0).w;
  alpha_2 = tmpvar_3;
  mediump float x_4;
  x_4 = (alpha_2 - 0.01);
  if ((x_4 < 0.0)) {
    discard;
  };
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Texture_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _Texture;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  mediump float alpha_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_Texture, xlv_TEXCOORD0).w;
  alpha_2 = tmpvar_3;
  mediump float x_4;
  x_4 = (alpha_2 - 0.01);
  if ((x_4 < 0.0)) {
    discard;
  };
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Texture_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _Texture;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  mediump float alpha_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_Texture, xlv_TEXCOORD0).w;
  alpha_2 = tmpvar_3;
  mediump float x_4;
  x_4 = (alpha_2 - 0.01);
  if ((x_4 < 0.0)) {
    discard;
  };
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Texture_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _Texture;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  mediump float alpha_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_Texture, xlv_TEXCOORD0).w;
  alpha_2 = tmpvar_3;
  mediump float x_4;
  x_4 = (alpha_2 - 0.01);
  if ((x_4 < 0.0)) {
    discard;
  };
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Texture_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _Texture;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  mediump float alpha_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_Texture, xlv_TEXCOORD0).w;
  alpha_2 = tmpvar_3;
  mediump float x_4;
  x_4 = (alpha_2 - 0.01);
  if ((x_4 < 0.0)) {
    discard;
  };
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Texture_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _Texture;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  mediump float alpha_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_Texture, xlv_TEXCOORD0).w;
  alpha_2 = tmpvar_3;
  mediump float x_4;
  x_4 = (alpha_2 - 0.01);
  if ((x_4 < 0.0)) {
    discard;
  };
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Texture_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _Texture;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  mediump float alpha_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_Texture, xlv_TEXCOORD0).w;
  alpha_2 = tmpvar_3;
  mediump float x_4;
  x_4 = (alpha_2 - 0.01);
  if ((x_4 < 0.0)) {
    discard;
  };
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Texture_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _Texture;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  mediump float alpha_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_Texture, xlv_TEXCOORD0).w;
  alpha_2 = tmpvar_3;
  mediump float x_4;
  x_4 = (alpha_2 - 0.01);
  if ((x_4 < 0.0)) {
    discard;
  };
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Texture_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _Texture;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  mediump float alpha_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_Texture, xlv_TEXCOORD0).w;
  alpha_2 = tmpvar_3;
  mediump float x_4;
  x_4 = (alpha_2 - 0.01);
  if ((x_4 < 0.0)) {
    discard;
  };
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Texture_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _Texture;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  mediump float alpha_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_Texture, xlv_TEXCOORD0).w;
  alpha_2 = tmpvar_3;
  mediump float x_4;
  x_4 = (alpha_2 - 0.01);
  if ((x_4 < 0.0)) {
    discard;
  };
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_ORIG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_ORIG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" }
""
}
}
}
}
Fallback "Diffuse"
CustomEditor "MoleMole.ShaderEditorBase"
}