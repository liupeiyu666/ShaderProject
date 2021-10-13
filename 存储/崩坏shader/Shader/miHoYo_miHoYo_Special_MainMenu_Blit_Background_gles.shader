//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Special/MainMenu/Blit_Background" {
Properties {
[Toggle(MAINMENU_BG_NEED_REVERSE_Y)] _MainMenuBgNeedReverseY ("Main Menu BG Need ReverseY", Float) = 0
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Background+1" }
 Pass {
  LOD 200
  Tags { "QUEUE" = "Background+1" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 65325
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 1.0);
  tmpvar_1.xy = (_glesVertex.xy / abs(_glesVertex.xy));
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform mediump float _MainMenuBgNeedReverseY;
uniform sampler2D _miHoYo_Background;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = xlv_TEXCOORD0;
  mediump vec4 color_2;
  if ((_MainMenuBgNeedReverseY > 0.0)) {
    tmpvar_1.y = (1.0 - xlv_TEXCOORD0.y);
  };
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_miHoYo_Background, tmpvar_1);
  color_2 = tmpvar_3;
  gl_FragData[0] = color_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 1.0);
  tmpvar_1.xy = (_glesVertex.xy / abs(_glesVertex.xy));
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform mediump float _MainMenuBgNeedReverseY;
uniform sampler2D _miHoYo_Background;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = xlv_TEXCOORD0;
  mediump vec4 color_2;
  if ((_MainMenuBgNeedReverseY > 0.0)) {
    tmpvar_1.y = (1.0 - xlv_TEXCOORD0.y);
  };
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_miHoYo_Background, tmpvar_1);
  color_2 = tmpvar_3;
  gl_FragData[0] = color_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 1.0);
  tmpvar_1.xy = (_glesVertex.xy / abs(_glesVertex.xy));
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform mediump float _MainMenuBgNeedReverseY;
uniform sampler2D _miHoYo_Background;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = xlv_TEXCOORD0;
  mediump vec4 color_2;
  if ((_MainMenuBgNeedReverseY > 0.0)) {
    tmpvar_1.y = (1.0 - xlv_TEXCOORD0.y);
  };
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_miHoYo_Background, tmpvar_1);
  color_2 = tmpvar_3;
  gl_FragData[0] = color_2;
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