//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_DLC/Common" {
Properties {
_AlphaCtrl ("AlphaCtrl", Range(0, 1)) = 1
[Enum(UnityEngine.Rendering.BlendMode)] _SrcFactor ("SrcFactor()", Float) = 5
[Enum(UnityEngine.Rendering.BlendMode)] _DstFactor ("DstFactor()", Float) = 10
[Enum(UnityEngine.Rendering.CullMode)] _CullMode ("消隐模式(CullMode)", Float) = 0
[Enum(LessEqual,4,Always,8)] _ZTestMode ("深度测试(ZTest)", Float) = 4
_Color ("Color", Color) = (1,1,1,1)
_Multiplier ("亮度", Range(1, 20)) = 1
_MainTex ("MainTex", 2D) = "white" { }
[Enum(R,0,G,1,B,2,A,3,RGBA,4)] _Channel ("MainTex色彩通道", Float) = 0
[Toggle] _RgbAsAlpha ("颜色输出至透明(RgbAsAlpha)", Float) = 0
_MainTexRot ("Tex rotation", Range(0, 360)) = 0
_MainTexX ("TexUscroll", Float) = 0
_MainTexY ("TexVscroll", Float) = 0
_MaskTex ("mask", 2D) = "white" { }
_MaskTexRot ("mask_rotation", Range(0, 360)) = 0
_MaskTexX ("maskUscroll", Float) = 0
_MaskTexY ("maskVscroll", Float) = 0
_DissolveTex ("dissolveTex", 2D) = "white" { }
_Dissolve ("dissolveValue", Range(0, 1)) = 0
_DissolveColor1 ("dissolveColor1", Color) = (1,0,0,1)
_DissolveColor2 ("dissolveColor2", Color) = (0,0,0,1)
_DissolveRot ("dissolve rotation", Range(0, 360)) = 0
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 51504
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Color;
uniform highp float _Multiplier;
uniform highp vec4 _MainTex_ST;
uniform highp float _MainTexRot;
uniform highp float _MainTexX;
uniform highp float _MainTexY;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + ((_MainTex_ST.zw + vec2(0.5, 0.5)) - (_MainTex_ST.xy * 0.5)));
  mediump vec2 uv_3;
  uv_3 = tmpvar_1.xy;
  mediump float uvRotate_4;
  uvRotate_4 = _MainTexRot;
  mediump vec2 outUV_5;
  mediump float tmpvar_6;
  tmpvar_6 = sin((uvRotate_4 / 57.2958));
  mediump float tmpvar_7;
  tmpvar_7 = cos((uvRotate_4 / 57.2958));
  outUV_5 = (uv_3 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_8;
  tmpvar_8.x = ((outUV_5.x * tmpvar_7) - (outUV_5.y * tmpvar_6));
  tmpvar_8.y = ((outUV_5.x * tmpvar_6) + (outUV_5.y * tmpvar_7));
  outUV_5 = (tmpvar_8 + vec2(0.5, 0.5));
  tmpvar_1.xy = outUV_5;
  highp vec2 tmpvar_9;
  tmpvar_9.x = _MainTexX;
  tmpvar_9.y = _MainTexY;
  tmpvar_1.xy = (tmpvar_1.xy + (_Time.z * tmpvar_9));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_COLOR = ((_glesColor * _Color) * _Multiplier);
}


#endif
#ifdef FRAGMENT
uniform highp float _AlphaCtrl;
uniform highp float _Channel;
uniform sampler2D _MainTex;
uniform highp float _RgbAsAlpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp float aa_1[2];
  highp float gray_2;
  mediump vec4 result_3;
  mediump vec4 texColor_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_4 = tmpvar_5;
  result_3 = xlv_COLOR;
  mediump vec4 tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = float((0.1 >= _Channel));
  highp float tmpvar_8;
  tmpvar_8 = float((_Channel >= 2.9));
  highp vec2 tmpvar_9;
  tmpvar_9.x = float((1.1 >= _Channel));
  tmpvar_9.y = float((_Channel >= 1.9));
  highp vec4 tmpvar_10;
  tmpvar_10.x = tmpvar_7;
  tmpvar_10.yz = ((1.0 - max (tmpvar_7, tmpvar_8)) * tmpvar_9);
  tmpvar_10.w = tmpvar_8;
  tmpvar_6 = tmpvar_10;
  result_3.w = (result_3.w * dot (texColor_4, tmpvar_6));
  highp float tmpvar_11;
  tmpvar_11 = float((_Channel >= 3.1));
  result_3.xyz = (result_3.xyz * ((
    (tmpvar_11 * texColor_4.xyz)
   + 1.0) - tmpvar_11));
  mediump float tmpvar_12;
  tmpvar_12 = dot (result_3.xyz, vec3(0.33, 0.34, 0.33));
  gray_2 = tmpvar_12;
  aa_1[0] = result_3.w;
  aa_1[1] = gray_2;
  result_3.w = (result_3.w * aa_1[int(_RgbAsAlpha)]);
  result_3.w = (result_3.w * _AlphaCtrl);
  gl_FragData[0] = result_3;
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
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Color;
uniform highp float _Multiplier;
uniform highp vec4 _MainTex_ST;
uniform highp float _MainTexRot;
uniform highp float _MainTexX;
uniform highp float _MainTexY;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + ((_MainTex_ST.zw + vec2(0.5, 0.5)) - (_MainTex_ST.xy * 0.5)));
  mediump vec2 uv_3;
  uv_3 = tmpvar_1.xy;
  mediump float uvRotate_4;
  uvRotate_4 = _MainTexRot;
  mediump vec2 outUV_5;
  mediump float tmpvar_6;
  tmpvar_6 = sin((uvRotate_4 / 57.2958));
  mediump float tmpvar_7;
  tmpvar_7 = cos((uvRotate_4 / 57.2958));
  outUV_5 = (uv_3 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_8;
  tmpvar_8.x = ((outUV_5.x * tmpvar_7) - (outUV_5.y * tmpvar_6));
  tmpvar_8.y = ((outUV_5.x * tmpvar_6) + (outUV_5.y * tmpvar_7));
  outUV_5 = (tmpvar_8 + vec2(0.5, 0.5));
  tmpvar_1.xy = outUV_5;
  highp vec2 tmpvar_9;
  tmpvar_9.x = _MainTexX;
  tmpvar_9.y = _MainTexY;
  tmpvar_1.xy = (tmpvar_1.xy + (_Time.z * tmpvar_9));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_COLOR = ((_glesColor * _Color) * _Multiplier);
}


#endif
#ifdef FRAGMENT
uniform highp float _AlphaCtrl;
uniform highp float _Channel;
uniform sampler2D _MainTex;
uniform highp float _RgbAsAlpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp float aa_1[2];
  highp float gray_2;
  mediump vec4 result_3;
  mediump vec4 texColor_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_4 = tmpvar_5;
  result_3 = xlv_COLOR;
  mediump vec4 tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = float((0.1 >= _Channel));
  highp float tmpvar_8;
  tmpvar_8 = float((_Channel >= 2.9));
  highp vec2 tmpvar_9;
  tmpvar_9.x = float((1.1 >= _Channel));
  tmpvar_9.y = float((_Channel >= 1.9));
  highp vec4 tmpvar_10;
  tmpvar_10.x = tmpvar_7;
  tmpvar_10.yz = ((1.0 - max (tmpvar_7, tmpvar_8)) * tmpvar_9);
  tmpvar_10.w = tmpvar_8;
  tmpvar_6 = tmpvar_10;
  result_3.w = (result_3.w * dot (texColor_4, tmpvar_6));
  highp float tmpvar_11;
  tmpvar_11 = float((_Channel >= 3.1));
  result_3.xyz = (result_3.xyz * ((
    (tmpvar_11 * texColor_4.xyz)
   + 1.0) - tmpvar_11));
  mediump float tmpvar_12;
  tmpvar_12 = dot (result_3.xyz, vec3(0.33, 0.34, 0.33));
  gray_2 = tmpvar_12;
  aa_1[0] = result_3.w;
  aa_1[1] = gray_2;
  result_3.w = (result_3.w * aa_1[int(_RgbAsAlpha)]);
  result_3.w = (result_3.w * _AlphaCtrl);
  gl_FragData[0] = result_3;
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
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Color;
uniform highp float _Multiplier;
uniform highp vec4 _MainTex_ST;
uniform highp float _MainTexRot;
uniform highp float _MainTexX;
uniform highp float _MainTexY;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + ((_MainTex_ST.zw + vec2(0.5, 0.5)) - (_MainTex_ST.xy * 0.5)));
  mediump vec2 uv_3;
  uv_3 = tmpvar_1.xy;
  mediump float uvRotate_4;
  uvRotate_4 = _MainTexRot;
  mediump vec2 outUV_5;
  mediump float tmpvar_6;
  tmpvar_6 = sin((uvRotate_4 / 57.2958));
  mediump float tmpvar_7;
  tmpvar_7 = cos((uvRotate_4 / 57.2958));
  outUV_5 = (uv_3 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_8;
  tmpvar_8.x = ((outUV_5.x * tmpvar_7) - (outUV_5.y * tmpvar_6));
  tmpvar_8.y = ((outUV_5.x * tmpvar_6) + (outUV_5.y * tmpvar_7));
  outUV_5 = (tmpvar_8 + vec2(0.5, 0.5));
  tmpvar_1.xy = outUV_5;
  highp vec2 tmpvar_9;
  tmpvar_9.x = _MainTexX;
  tmpvar_9.y = _MainTexY;
  tmpvar_1.xy = (tmpvar_1.xy + (_Time.z * tmpvar_9));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_COLOR = ((_glesColor * _Color) * _Multiplier);
}


#endif
#ifdef FRAGMENT
uniform highp float _AlphaCtrl;
uniform highp float _Channel;
uniform sampler2D _MainTex;
uniform highp float _RgbAsAlpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp float aa_1[2];
  highp float gray_2;
  mediump vec4 result_3;
  mediump vec4 texColor_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_4 = tmpvar_5;
  result_3 = xlv_COLOR;
  mediump vec4 tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = float((0.1 >= _Channel));
  highp float tmpvar_8;
  tmpvar_8 = float((_Channel >= 2.9));
  highp vec2 tmpvar_9;
  tmpvar_9.x = float((1.1 >= _Channel));
  tmpvar_9.y = float((_Channel >= 1.9));
  highp vec4 tmpvar_10;
  tmpvar_10.x = tmpvar_7;
  tmpvar_10.yz = ((1.0 - max (tmpvar_7, tmpvar_8)) * tmpvar_9);
  tmpvar_10.w = tmpvar_8;
  tmpvar_6 = tmpvar_10;
  result_3.w = (result_3.w * dot (texColor_4, tmpvar_6));
  highp float tmpvar_11;
  tmpvar_11 = float((_Channel >= 3.1));
  result_3.xyz = (result_3.xyz * ((
    (tmpvar_11 * texColor_4.xyz)
   + 1.0) - tmpvar_11));
  mediump float tmpvar_12;
  tmpvar_12 = dot (result_3.xyz, vec3(0.33, 0.34, 0.33));
  gray_2 = tmpvar_12;
  aa_1[0] = result_3.w;
  aa_1[1] = gray_2;
  result_3.w = (result_3.w * aa_1[int(_RgbAsAlpha)]);
  result_3.w = (result_3.w * _AlphaCtrl);
  gl_FragData[0] = result_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "RT_PASS_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Color;
uniform highp float _Multiplier;
uniform highp vec4 _MainTex_ST;
uniform highp float _MainTexRot;
uniform highp float _MainTexX;
uniform highp float _MainTexY;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + ((_MainTex_ST.zw + vec2(0.5, 0.5)) - (_MainTex_ST.xy * 0.5)));
  mediump vec2 uv_3;
  uv_3 = tmpvar_1.xy;
  mediump float uvRotate_4;
  uvRotate_4 = _MainTexRot;
  mediump vec2 outUV_5;
  mediump float tmpvar_6;
  tmpvar_6 = sin((uvRotate_4 / 57.2958));
  mediump float tmpvar_7;
  tmpvar_7 = cos((uvRotate_4 / 57.2958));
  outUV_5 = (uv_3 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_8;
  tmpvar_8.x = ((outUV_5.x * tmpvar_7) - (outUV_5.y * tmpvar_6));
  tmpvar_8.y = ((outUV_5.x * tmpvar_6) + (outUV_5.y * tmpvar_7));
  outUV_5 = (tmpvar_8 + vec2(0.5, 0.5));
  tmpvar_1.xy = outUV_5;
  highp vec2 tmpvar_9;
  tmpvar_9.x = _MainTexX;
  tmpvar_9.y = _MainTexY;
  tmpvar_1.xy = (tmpvar_1.xy + (_Time.z * tmpvar_9));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_COLOR = ((_glesColor * _Color) * _Multiplier);
}


#endif
#ifdef FRAGMENT
uniform highp float _AlphaCtrl;
uniform highp float _Channel;
uniform sampler2D _MainTex;
uniform highp float _RgbAsAlpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp float aa_1[2];
  highp float gray_2;
  mediump vec4 result_3;
  mediump vec4 texColor_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_4 = tmpvar_5;
  result_3 = xlv_COLOR;
  mediump vec4 tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = float((0.1 >= _Channel));
  highp float tmpvar_8;
  tmpvar_8 = float((_Channel >= 2.9));
  highp vec2 tmpvar_9;
  tmpvar_9.x = float((1.1 >= _Channel));
  tmpvar_9.y = float((_Channel >= 1.9));
  highp vec4 tmpvar_10;
  tmpvar_10.x = tmpvar_7;
  tmpvar_10.yz = ((1.0 - max (tmpvar_7, tmpvar_8)) * tmpvar_9);
  tmpvar_10.w = tmpvar_8;
  tmpvar_6 = tmpvar_10;
  result_3.w = (result_3.w * dot (texColor_4, tmpvar_6));
  highp float tmpvar_11;
  tmpvar_11 = float((_Channel >= 3.1));
  result_3.xyz = (result_3.xyz * ((
    (tmpvar_11 * texColor_4.xyz)
   + 1.0) - tmpvar_11));
  mediump float tmpvar_12;
  tmpvar_12 = dot (result_3.xyz, vec3(0.33, 0.34, 0.33));
  gray_2 = tmpvar_12;
  aa_1[0] = result_3.w;
  aa_1[1] = gray_2;
  result_3.w = (result_3.w * aa_1[int(_RgbAsAlpha)]);
  result_3.w = (result_3.w * _AlphaCtrl);
  gl_FragData[0] = result_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "RT_PASS_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Color;
uniform highp float _Multiplier;
uniform highp vec4 _MainTex_ST;
uniform highp float _MainTexRot;
uniform highp float _MainTexX;
uniform highp float _MainTexY;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + ((_MainTex_ST.zw + vec2(0.5, 0.5)) - (_MainTex_ST.xy * 0.5)));
  mediump vec2 uv_3;
  uv_3 = tmpvar_1.xy;
  mediump float uvRotate_4;
  uvRotate_4 = _MainTexRot;
  mediump vec2 outUV_5;
  mediump float tmpvar_6;
  tmpvar_6 = sin((uvRotate_4 / 57.2958));
  mediump float tmpvar_7;
  tmpvar_7 = cos((uvRotate_4 / 57.2958));
  outUV_5 = (uv_3 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_8;
  tmpvar_8.x = ((outUV_5.x * tmpvar_7) - (outUV_5.y * tmpvar_6));
  tmpvar_8.y = ((outUV_5.x * tmpvar_6) + (outUV_5.y * tmpvar_7));
  outUV_5 = (tmpvar_8 + vec2(0.5, 0.5));
  tmpvar_1.xy = outUV_5;
  highp vec2 tmpvar_9;
  tmpvar_9.x = _MainTexX;
  tmpvar_9.y = _MainTexY;
  tmpvar_1.xy = (tmpvar_1.xy + (_Time.z * tmpvar_9));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_COLOR = ((_glesColor * _Color) * _Multiplier);
}


#endif
#ifdef FRAGMENT
uniform highp float _AlphaCtrl;
uniform highp float _Channel;
uniform sampler2D _MainTex;
uniform highp float _RgbAsAlpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp float aa_1[2];
  highp float gray_2;
  mediump vec4 result_3;
  mediump vec4 texColor_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_4 = tmpvar_5;
  result_3 = xlv_COLOR;
  mediump vec4 tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = float((0.1 >= _Channel));
  highp float tmpvar_8;
  tmpvar_8 = float((_Channel >= 2.9));
  highp vec2 tmpvar_9;
  tmpvar_9.x = float((1.1 >= _Channel));
  tmpvar_9.y = float((_Channel >= 1.9));
  highp vec4 tmpvar_10;
  tmpvar_10.x = tmpvar_7;
  tmpvar_10.yz = ((1.0 - max (tmpvar_7, tmpvar_8)) * tmpvar_9);
  tmpvar_10.w = tmpvar_8;
  tmpvar_6 = tmpvar_10;
  result_3.w = (result_3.w * dot (texColor_4, tmpvar_6));
  highp float tmpvar_11;
  tmpvar_11 = float((_Channel >= 3.1));
  result_3.xyz = (result_3.xyz * ((
    (tmpvar_11 * texColor_4.xyz)
   + 1.0) - tmpvar_11));
  mediump float tmpvar_12;
  tmpvar_12 = dot (result_3.xyz, vec3(0.33, 0.34, 0.33));
  gray_2 = tmpvar_12;
  aa_1[0] = result_3.w;
  aa_1[1] = gray_2;
  result_3.w = (result_3.w * aa_1[int(_RgbAsAlpha)]);
  result_3.w = (result_3.w * _AlphaCtrl);
  gl_FragData[0] = result_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "RT_PASS_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Color;
uniform highp float _Multiplier;
uniform highp vec4 _MainTex_ST;
uniform highp float _MainTexRot;
uniform highp float _MainTexX;
uniform highp float _MainTexY;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + ((_MainTex_ST.zw + vec2(0.5, 0.5)) - (_MainTex_ST.xy * 0.5)));
  mediump vec2 uv_3;
  uv_3 = tmpvar_1.xy;
  mediump float uvRotate_4;
  uvRotate_4 = _MainTexRot;
  mediump vec2 outUV_5;
  mediump float tmpvar_6;
  tmpvar_6 = sin((uvRotate_4 / 57.2958));
  mediump float tmpvar_7;
  tmpvar_7 = cos((uvRotate_4 / 57.2958));
  outUV_5 = (uv_3 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_8;
  tmpvar_8.x = ((outUV_5.x * tmpvar_7) - (outUV_5.y * tmpvar_6));
  tmpvar_8.y = ((outUV_5.x * tmpvar_6) + (outUV_5.y * tmpvar_7));
  outUV_5 = (tmpvar_8 + vec2(0.5, 0.5));
  tmpvar_1.xy = outUV_5;
  highp vec2 tmpvar_9;
  tmpvar_9.x = _MainTexX;
  tmpvar_9.y = _MainTexY;
  tmpvar_1.xy = (tmpvar_1.xy + (_Time.z * tmpvar_9));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_COLOR = ((_glesColor * _Color) * _Multiplier);
}


#endif
#ifdef FRAGMENT
uniform highp float _AlphaCtrl;
uniform highp float _Channel;
uniform sampler2D _MainTex;
uniform highp float _RgbAsAlpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp float aa_1[2];
  highp float gray_2;
  mediump vec4 result_3;
  mediump vec4 texColor_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_4 = tmpvar_5;
  result_3 = xlv_COLOR;
  mediump vec4 tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = float((0.1 >= _Channel));
  highp float tmpvar_8;
  tmpvar_8 = float((_Channel >= 2.9));
  highp vec2 tmpvar_9;
  tmpvar_9.x = float((1.1 >= _Channel));
  tmpvar_9.y = float((_Channel >= 1.9));
  highp vec4 tmpvar_10;
  tmpvar_10.x = tmpvar_7;
  tmpvar_10.yz = ((1.0 - max (tmpvar_7, tmpvar_8)) * tmpvar_9);
  tmpvar_10.w = tmpvar_8;
  tmpvar_6 = tmpvar_10;
  result_3.w = (result_3.w * dot (texColor_4, tmpvar_6));
  highp float tmpvar_11;
  tmpvar_11 = float((_Channel >= 3.1));
  result_3.xyz = (result_3.xyz * ((
    (tmpvar_11 * texColor_4.xyz)
   + 1.0) - tmpvar_11));
  mediump float tmpvar_12;
  tmpvar_12 = dot (result_3.xyz, vec3(0.33, 0.34, 0.33));
  gray_2 = tmpvar_12;
  aa_1[0] = result_3.w;
  aa_1[1] = gray_2;
  result_3.w = (result_3.w * aa_1[int(_RgbAsAlpha)]);
  result_3.w = (result_3.w * _AlphaCtrl);
  gl_FragData[0] = result_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "MultiplyBlend_On" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Color;
uniform highp float _Multiplier;
uniform highp vec4 _MainTex_ST;
uniform highp float _MainTexRot;
uniform highp float _MainTexX;
uniform highp float _MainTexY;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + ((_MainTex_ST.zw + vec2(0.5, 0.5)) - (_MainTex_ST.xy * 0.5)));
  mediump vec2 uv_3;
  uv_3 = tmpvar_1.xy;
  mediump float uvRotate_4;
  uvRotate_4 = _MainTexRot;
  mediump vec2 outUV_5;
  mediump float tmpvar_6;
  tmpvar_6 = sin((uvRotate_4 / 57.2958));
  mediump float tmpvar_7;
  tmpvar_7 = cos((uvRotate_4 / 57.2958));
  outUV_5 = (uv_3 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_8;
  tmpvar_8.x = ((outUV_5.x * tmpvar_7) - (outUV_5.y * tmpvar_6));
  tmpvar_8.y = ((outUV_5.x * tmpvar_6) + (outUV_5.y * tmpvar_7));
  outUV_5 = (tmpvar_8 + vec2(0.5, 0.5));
  tmpvar_1.xy = outUV_5;
  highp vec2 tmpvar_9;
  tmpvar_9.x = _MainTexX;
  tmpvar_9.y = _MainTexY;
  tmpvar_1.xy = (tmpvar_1.xy + (_Time.z * tmpvar_9));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_COLOR = ((_glesColor * _Color) * _Multiplier);
}


#endif
#ifdef FRAGMENT
uniform highp float _AlphaCtrl;
uniform highp float _Channel;
uniform sampler2D _MainTex;
uniform highp float _SrcFactor;
uniform highp float _RgbAsAlpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp float aa_1[2];
  highp float gray_2;
  mediump vec4 result_3;
  mediump vec4 texColor_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_4 = tmpvar_5;
  result_3 = xlv_COLOR;
  mediump vec4 tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = float((0.1 >= _Channel));
  highp float tmpvar_8;
  tmpvar_8 = float((_Channel >= 2.9));
  highp vec2 tmpvar_9;
  tmpvar_9.x = float((1.1 >= _Channel));
  tmpvar_9.y = float((_Channel >= 1.9));
  highp vec4 tmpvar_10;
  tmpvar_10.x = tmpvar_7;
  tmpvar_10.yz = ((1.0 - max (tmpvar_7, tmpvar_8)) * tmpvar_9);
  tmpvar_10.w = tmpvar_8;
  tmpvar_6 = tmpvar_10;
  result_3.w = (result_3.w * dot (texColor_4, tmpvar_6));
  highp float tmpvar_11;
  tmpvar_11 = float((_Channel >= 3.1));
  result_3.xyz = (result_3.xyz * ((
    (tmpvar_11 * texColor_4.xyz)
   + 1.0) - tmpvar_11));
  mediump float tmpvar_12;
  tmpvar_12 = dot (result_3.xyz, vec3(0.33, 0.34, 0.33));
  gray_2 = tmpvar_12;
  aa_1[0] = result_3.w;
  aa_1[1] = gray_2;
  result_3.w = (result_3.w * aa_1[int(_RgbAsAlpha)]);
  mediump vec4 tmpvar_13;
  tmpvar_13 = mix (vec4(1.0, 1.0, 1.0, 1.0), result_3, result_3.wwww);
  highp vec4 tmpvar_14;
  tmpvar_14 = mix (result_3, tmpvar_13, vec4(float((_SrcFactor == 0.0))));
  result_3 = tmpvar_14;
  result_3.w = (result_3.w * _AlphaCtrl);
  gl_FragData[0] = result_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "MultiplyBlend_On" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Color;
uniform highp float _Multiplier;
uniform highp vec4 _MainTex_ST;
uniform highp float _MainTexRot;
uniform highp float _MainTexX;
uniform highp float _MainTexY;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + ((_MainTex_ST.zw + vec2(0.5, 0.5)) - (_MainTex_ST.xy * 0.5)));
  mediump vec2 uv_3;
  uv_3 = tmpvar_1.xy;
  mediump float uvRotate_4;
  uvRotate_4 = _MainTexRot;
  mediump vec2 outUV_5;
  mediump float tmpvar_6;
  tmpvar_6 = sin((uvRotate_4 / 57.2958));
  mediump float tmpvar_7;
  tmpvar_7 = cos((uvRotate_4 / 57.2958));
  outUV_5 = (uv_3 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_8;
  tmpvar_8.x = ((outUV_5.x * tmpvar_7) - (outUV_5.y * tmpvar_6));
  tmpvar_8.y = ((outUV_5.x * tmpvar_6) + (outUV_5.y * tmpvar_7));
  outUV_5 = (tmpvar_8 + vec2(0.5, 0.5));
  tmpvar_1.xy = outUV_5;
  highp vec2 tmpvar_9;
  tmpvar_9.x = _MainTexX;
  tmpvar_9.y = _MainTexY;
  tmpvar_1.xy = (tmpvar_1.xy + (_Time.z * tmpvar_9));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_COLOR = ((_glesColor * _Color) * _Multiplier);
}


#endif
#ifdef FRAGMENT
uniform highp float _AlphaCtrl;
uniform highp float _Channel;
uniform sampler2D _MainTex;
uniform highp float _SrcFactor;
uniform highp float _RgbAsAlpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp float aa_1[2];
  highp float gray_2;
  mediump vec4 result_3;
  mediump vec4 texColor_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_4 = tmpvar_5;
  result_3 = xlv_COLOR;
  mediump vec4 tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = float((0.1 >= _Channel));
  highp float tmpvar_8;
  tmpvar_8 = float((_Channel >= 2.9));
  highp vec2 tmpvar_9;
  tmpvar_9.x = float((1.1 >= _Channel));
  tmpvar_9.y = float((_Channel >= 1.9));
  highp vec4 tmpvar_10;
  tmpvar_10.x = tmpvar_7;
  tmpvar_10.yz = ((1.0 - max (tmpvar_7, tmpvar_8)) * tmpvar_9);
  tmpvar_10.w = tmpvar_8;
  tmpvar_6 = tmpvar_10;
  result_3.w = (result_3.w * dot (texColor_4, tmpvar_6));
  highp float tmpvar_11;
  tmpvar_11 = float((_Channel >= 3.1));
  result_3.xyz = (result_3.xyz * ((
    (tmpvar_11 * texColor_4.xyz)
   + 1.0) - tmpvar_11));
  mediump float tmpvar_12;
  tmpvar_12 = dot (result_3.xyz, vec3(0.33, 0.34, 0.33));
  gray_2 = tmpvar_12;
  aa_1[0] = result_3.w;
  aa_1[1] = gray_2;
  result_3.w = (result_3.w * aa_1[int(_RgbAsAlpha)]);
  mediump vec4 tmpvar_13;
  tmpvar_13 = mix (vec4(1.0, 1.0, 1.0, 1.0), result_3, result_3.wwww);
  highp vec4 tmpvar_14;
  tmpvar_14 = mix (result_3, tmpvar_13, vec4(float((_SrcFactor == 0.0))));
  result_3 = tmpvar_14;
  result_3.w = (result_3.w * _AlphaCtrl);
  gl_FragData[0] = result_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "MultiplyBlend_On" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Color;
uniform highp float _Multiplier;
uniform highp vec4 _MainTex_ST;
uniform highp float _MainTexRot;
uniform highp float _MainTexX;
uniform highp float _MainTexY;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + ((_MainTex_ST.zw + vec2(0.5, 0.5)) - (_MainTex_ST.xy * 0.5)));
  mediump vec2 uv_3;
  uv_3 = tmpvar_1.xy;
  mediump float uvRotate_4;
  uvRotate_4 = _MainTexRot;
  mediump vec2 outUV_5;
  mediump float tmpvar_6;
  tmpvar_6 = sin((uvRotate_4 / 57.2958));
  mediump float tmpvar_7;
  tmpvar_7 = cos((uvRotate_4 / 57.2958));
  outUV_5 = (uv_3 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_8;
  tmpvar_8.x = ((outUV_5.x * tmpvar_7) - (outUV_5.y * tmpvar_6));
  tmpvar_8.y = ((outUV_5.x * tmpvar_6) + (outUV_5.y * tmpvar_7));
  outUV_5 = (tmpvar_8 + vec2(0.5, 0.5));
  tmpvar_1.xy = outUV_5;
  highp vec2 tmpvar_9;
  tmpvar_9.x = _MainTexX;
  tmpvar_9.y = _MainTexY;
  tmpvar_1.xy = (tmpvar_1.xy + (_Time.z * tmpvar_9));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_COLOR = ((_glesColor * _Color) * _Multiplier);
}


#endif
#ifdef FRAGMENT
uniform highp float _AlphaCtrl;
uniform highp float _Channel;
uniform sampler2D _MainTex;
uniform highp float _SrcFactor;
uniform highp float _RgbAsAlpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp float aa_1[2];
  highp float gray_2;
  mediump vec4 result_3;
  mediump vec4 texColor_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_4 = tmpvar_5;
  result_3 = xlv_COLOR;
  mediump vec4 tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = float((0.1 >= _Channel));
  highp float tmpvar_8;
  tmpvar_8 = float((_Channel >= 2.9));
  highp vec2 tmpvar_9;
  tmpvar_9.x = float((1.1 >= _Channel));
  tmpvar_9.y = float((_Channel >= 1.9));
  highp vec4 tmpvar_10;
  tmpvar_10.x = tmpvar_7;
  tmpvar_10.yz = ((1.0 - max (tmpvar_7, tmpvar_8)) * tmpvar_9);
  tmpvar_10.w = tmpvar_8;
  tmpvar_6 = tmpvar_10;
  result_3.w = (result_3.w * dot (texColor_4, tmpvar_6));
  highp float tmpvar_11;
  tmpvar_11 = float((_Channel >= 3.1));
  result_3.xyz = (result_3.xyz * ((
    (tmpvar_11 * texColor_4.xyz)
   + 1.0) - tmpvar_11));
  mediump float tmpvar_12;
  tmpvar_12 = dot (result_3.xyz, vec3(0.33, 0.34, 0.33));
  gray_2 = tmpvar_12;
  aa_1[0] = result_3.w;
  aa_1[1] = gray_2;
  result_3.w = (result_3.w * aa_1[int(_RgbAsAlpha)]);
  mediump vec4 tmpvar_13;
  tmpvar_13 = mix (vec4(1.0, 1.0, 1.0, 1.0), result_3, result_3.wwww);
  highp vec4 tmpvar_14;
  tmpvar_14 = mix (result_3, tmpvar_13, vec4(float((_SrcFactor == 0.0))));
  result_3 = tmpvar_14;
  result_3.w = (result_3.w * _AlphaCtrl);
  gl_FragData[0] = result_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "MultiplyBlend_On" "RT_PASS_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Color;
uniform highp float _Multiplier;
uniform highp vec4 _MainTex_ST;
uniform highp float _MainTexRot;
uniform highp float _MainTexX;
uniform highp float _MainTexY;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + ((_MainTex_ST.zw + vec2(0.5, 0.5)) - (_MainTex_ST.xy * 0.5)));
  mediump vec2 uv_3;
  uv_3 = tmpvar_1.xy;
  mediump float uvRotate_4;
  uvRotate_4 = _MainTexRot;
  mediump vec2 outUV_5;
  mediump float tmpvar_6;
  tmpvar_6 = sin((uvRotate_4 / 57.2958));
  mediump float tmpvar_7;
  tmpvar_7 = cos((uvRotate_4 / 57.2958));
  outUV_5 = (uv_3 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_8;
  tmpvar_8.x = ((outUV_5.x * tmpvar_7) - (outUV_5.y * tmpvar_6));
  tmpvar_8.y = ((outUV_5.x * tmpvar_6) + (outUV_5.y * tmpvar_7));
  outUV_5 = (tmpvar_8 + vec2(0.5, 0.5));
  tmpvar_1.xy = outUV_5;
  highp vec2 tmpvar_9;
  tmpvar_9.x = _MainTexX;
  tmpvar_9.y = _MainTexY;
  tmpvar_1.xy = (tmpvar_1.xy + (_Time.z * tmpvar_9));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_COLOR = ((_glesColor * _Color) * _Multiplier);
}


#endif
#ifdef FRAGMENT
uniform highp float _AlphaCtrl;
uniform highp float _Channel;
uniform sampler2D _MainTex;
uniform highp float _SrcFactor;
uniform highp float _RgbAsAlpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp float aa_1[2];
  highp float gray_2;
  mediump vec4 result_3;
  mediump vec4 texColor_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_4 = tmpvar_5;
  result_3 = xlv_COLOR;
  mediump vec4 tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = float((0.1 >= _Channel));
  highp float tmpvar_8;
  tmpvar_8 = float((_Channel >= 2.9));
  highp vec2 tmpvar_9;
  tmpvar_9.x = float((1.1 >= _Channel));
  tmpvar_9.y = float((_Channel >= 1.9));
  highp vec4 tmpvar_10;
  tmpvar_10.x = tmpvar_7;
  tmpvar_10.yz = ((1.0 - max (tmpvar_7, tmpvar_8)) * tmpvar_9);
  tmpvar_10.w = tmpvar_8;
  tmpvar_6 = tmpvar_10;
  result_3.w = (result_3.w * dot (texColor_4, tmpvar_6));
  highp float tmpvar_11;
  tmpvar_11 = float((_Channel >= 3.1));
  result_3.xyz = (result_3.xyz * ((
    (tmpvar_11 * texColor_4.xyz)
   + 1.0) - tmpvar_11));
  mediump float tmpvar_12;
  tmpvar_12 = dot (result_3.xyz, vec3(0.33, 0.34, 0.33));
  gray_2 = tmpvar_12;
  aa_1[0] = result_3.w;
  aa_1[1] = gray_2;
  result_3.w = (result_3.w * aa_1[int(_RgbAsAlpha)]);
  mediump vec4 tmpvar_13;
  tmpvar_13 = mix (vec4(1.0, 1.0, 1.0, 1.0), result_3, result_3.wwww);
  highp vec4 tmpvar_14;
  tmpvar_14 = mix (result_3, tmpvar_13, vec4(float((_SrcFactor == 0.0))));
  result_3 = tmpvar_14;
  result_3.w = (result_3.w * _AlphaCtrl);
  gl_FragData[0] = result_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "MultiplyBlend_On" "RT_PASS_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Color;
uniform highp float _Multiplier;
uniform highp vec4 _MainTex_ST;
uniform highp float _MainTexRot;
uniform highp float _MainTexX;
uniform highp float _MainTexY;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + ((_MainTex_ST.zw + vec2(0.5, 0.5)) - (_MainTex_ST.xy * 0.5)));
  mediump vec2 uv_3;
  uv_3 = tmpvar_1.xy;
  mediump float uvRotate_4;
  uvRotate_4 = _MainTexRot;
  mediump vec2 outUV_5;
  mediump float tmpvar_6;
  tmpvar_6 = sin((uvRotate_4 / 57.2958));
  mediump float tmpvar_7;
  tmpvar_7 = cos((uvRotate_4 / 57.2958));
  outUV_5 = (uv_3 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_8;
  tmpvar_8.x = ((outUV_5.x * tmpvar_7) - (outUV_5.y * tmpvar_6));
  tmpvar_8.y = ((outUV_5.x * tmpvar_6) + (outUV_5.y * tmpvar_7));
  outUV_5 = (tmpvar_8 + vec2(0.5, 0.5));
  tmpvar_1.xy = outUV_5;
  highp vec2 tmpvar_9;
  tmpvar_9.x = _MainTexX;
  tmpvar_9.y = _MainTexY;
  tmpvar_1.xy = (tmpvar_1.xy + (_Time.z * tmpvar_9));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_COLOR = ((_glesColor * _Color) * _Multiplier);
}


#endif
#ifdef FRAGMENT
uniform highp float _AlphaCtrl;
uniform highp float _Channel;
uniform sampler2D _MainTex;
uniform highp float _SrcFactor;
uniform highp float _RgbAsAlpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp float aa_1[2];
  highp float gray_2;
  mediump vec4 result_3;
  mediump vec4 texColor_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_4 = tmpvar_5;
  result_3 = xlv_COLOR;
  mediump vec4 tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = float((0.1 >= _Channel));
  highp float tmpvar_8;
  tmpvar_8 = float((_Channel >= 2.9));
  highp vec2 tmpvar_9;
  tmpvar_9.x = float((1.1 >= _Channel));
  tmpvar_9.y = float((_Channel >= 1.9));
  highp vec4 tmpvar_10;
  tmpvar_10.x = tmpvar_7;
  tmpvar_10.yz = ((1.0 - max (tmpvar_7, tmpvar_8)) * tmpvar_9);
  tmpvar_10.w = tmpvar_8;
  tmpvar_6 = tmpvar_10;
  result_3.w = (result_3.w * dot (texColor_4, tmpvar_6));
  highp float tmpvar_11;
  tmpvar_11 = float((_Channel >= 3.1));
  result_3.xyz = (result_3.xyz * ((
    (tmpvar_11 * texColor_4.xyz)
   + 1.0) - tmpvar_11));
  mediump float tmpvar_12;
  tmpvar_12 = dot (result_3.xyz, vec3(0.33, 0.34, 0.33));
  gray_2 = tmpvar_12;
  aa_1[0] = result_3.w;
  aa_1[1] = gray_2;
  result_3.w = (result_3.w * aa_1[int(_RgbAsAlpha)]);
  mediump vec4 tmpvar_13;
  tmpvar_13 = mix (vec4(1.0, 1.0, 1.0, 1.0), result_3, result_3.wwww);
  highp vec4 tmpvar_14;
  tmpvar_14 = mix (result_3, tmpvar_13, vec4(float((_SrcFactor == 0.0))));
  result_3 = tmpvar_14;
  result_3.w = (result_3.w * _AlphaCtrl);
  gl_FragData[0] = result_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "MultiplyBlend_On" "RT_PASS_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Color;
uniform highp float _Multiplier;
uniform highp vec4 _MainTex_ST;
uniform highp float _MainTexRot;
uniform highp float _MainTexX;
uniform highp float _MainTexY;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + ((_MainTex_ST.zw + vec2(0.5, 0.5)) - (_MainTex_ST.xy * 0.5)));
  mediump vec2 uv_3;
  uv_3 = tmpvar_1.xy;
  mediump float uvRotate_4;
  uvRotate_4 = _MainTexRot;
  mediump vec2 outUV_5;
  mediump float tmpvar_6;
  tmpvar_6 = sin((uvRotate_4 / 57.2958));
  mediump float tmpvar_7;
  tmpvar_7 = cos((uvRotate_4 / 57.2958));
  outUV_5 = (uv_3 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_8;
  tmpvar_8.x = ((outUV_5.x * tmpvar_7) - (outUV_5.y * tmpvar_6));
  tmpvar_8.y = ((outUV_5.x * tmpvar_6) + (outUV_5.y * tmpvar_7));
  outUV_5 = (tmpvar_8 + vec2(0.5, 0.5));
  tmpvar_1.xy = outUV_5;
  highp vec2 tmpvar_9;
  tmpvar_9.x = _MainTexX;
  tmpvar_9.y = _MainTexY;
  tmpvar_1.xy = (tmpvar_1.xy + (_Time.z * tmpvar_9));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_COLOR = ((_glesColor * _Color) * _Multiplier);
}


#endif
#ifdef FRAGMENT
uniform highp float _AlphaCtrl;
uniform highp float _Channel;
uniform sampler2D _MainTex;
uniform highp float _SrcFactor;
uniform highp float _RgbAsAlpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp float aa_1[2];
  highp float gray_2;
  mediump vec4 result_3;
  mediump vec4 texColor_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_4 = tmpvar_5;
  result_3 = xlv_COLOR;
  mediump vec4 tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = float((0.1 >= _Channel));
  highp float tmpvar_8;
  tmpvar_8 = float((_Channel >= 2.9));
  highp vec2 tmpvar_9;
  tmpvar_9.x = float((1.1 >= _Channel));
  tmpvar_9.y = float((_Channel >= 1.9));
  highp vec4 tmpvar_10;
  tmpvar_10.x = tmpvar_7;
  tmpvar_10.yz = ((1.0 - max (tmpvar_7, tmpvar_8)) * tmpvar_9);
  tmpvar_10.w = tmpvar_8;
  tmpvar_6 = tmpvar_10;
  result_3.w = (result_3.w * dot (texColor_4, tmpvar_6));
  highp float tmpvar_11;
  tmpvar_11 = float((_Channel >= 3.1));
  result_3.xyz = (result_3.xyz * ((
    (tmpvar_11 * texColor_4.xyz)
   + 1.0) - tmpvar_11));
  mediump float tmpvar_12;
  tmpvar_12 = dot (result_3.xyz, vec3(0.33, 0.34, 0.33));
  gray_2 = tmpvar_12;
  aa_1[0] = result_3.w;
  aa_1[1] = gray_2;
  result_3.w = (result_3.w * aa_1[int(_RgbAsAlpha)]);
  mediump vec4 tmpvar_13;
  tmpvar_13 = mix (vec4(1.0, 1.0, 1.0, 1.0), result_3, result_3.wwww);
  highp vec4 tmpvar_14;
  tmpvar_14 = mix (result_3, tmpvar_13, vec4(float((_SrcFactor == 0.0))));
  result_3 = tmpvar_14;
  result_3.w = (result_3.w * _AlphaCtrl);
  gl_FragData[0] = result_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DissolveTex_On" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Color;
uniform highp float _Multiplier;
uniform highp vec4 _MainTex_ST;
uniform highp float _MainTexRot;
uniform highp float _MainTexX;
uniform highp float _MainTexY;
uniform highp vec4 _DissolveTex_ST;
uniform highp float _DissolveRot;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_2.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + ((_MainTex_ST.zw + vec2(0.5, 0.5)) - (_MainTex_ST.xy * 0.5)));
  mediump vec2 uv_4;
  uv_4 = tmpvar_1.xy;
  mediump float uvRotate_5;
  uvRotate_5 = _MainTexRot;
  mediump vec2 outUV_6;
  mediump float tmpvar_7;
  tmpvar_7 = sin((uvRotate_5 / 57.2958));
  mediump float tmpvar_8;
  tmpvar_8 = cos((uvRotate_5 / 57.2958));
  outUV_6 = (uv_4 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_9;
  tmpvar_9.x = ((outUV_6.x * tmpvar_8) - (outUV_6.y * tmpvar_7));
  tmpvar_9.y = ((outUV_6.x * tmpvar_7) + (outUV_6.y * tmpvar_8));
  outUV_6 = (tmpvar_9 + vec2(0.5, 0.5));
  tmpvar_1.xy = outUV_6;
  highp vec2 tmpvar_10;
  tmpvar_10.x = _MainTexX;
  tmpvar_10.y = _MainTexY;
  tmpvar_1.xy = (tmpvar_1.xy + (_Time.z * tmpvar_10));
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _DissolveTex_ST.xy) + ((_DissolveTex_ST.zw + vec2(0.5, 0.5)) - (_DissolveTex_ST.xy * 0.5)));
  mediump vec2 uv_11;
  uv_11 = tmpvar_2.xy;
  mediump float uvRotate_12;
  uvRotate_12 = _DissolveRot;
  mediump vec2 outUV_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin((uvRotate_12 / 57.2958));
  mediump float tmpvar_15;
  tmpvar_15 = cos((uvRotate_12 / 57.2958));
  outUV_13 = (uv_11 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_16;
  tmpvar_16.x = ((outUV_13.x * tmpvar_15) - (outUV_13.y * tmpvar_14));
  tmpvar_16.y = ((outUV_13.x * tmpvar_14) + (outUV_13.y * tmpvar_15));
  outUV_13 = (tmpvar_16 + vec2(0.5, 0.5));
  tmpvar_2.xy = outUV_13;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = ((_glesColor * _Color) * _Multiplier);
}


#endif
#ifdef FRAGMENT
uniform highp float _AlphaCtrl;
uniform highp float _Channel;
uniform sampler2D _MainTex;
uniform sampler2D _DissolveTex;
uniform highp float _Dissolve;
uniform mediump vec4 _DissolveColor1;
uniform mediump vec4 _DissolveColor2;
uniform highp float _RgbAsAlpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp float aa_1[2];
  highp float gray_2;
  mediump vec4 dissColor_3;
  mediump vec4 result_4;
  mediump vec4 texColor_5;
  mediump vec4 dissolveColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_DissolveTex, xlv_TEXCOORD1.xy);
  dissolveColor_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = ((dissolveColor_6.x + (
    (_Dissolve * -1.2)
   + 0.6)) - 0.5);
  if ((tmpvar_8 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_5 = tmpvar_9;
  result_4 = xlv_COLOR;
  mediump vec4 tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = float((0.1 >= _Channel));
  highp float tmpvar_12;
  tmpvar_12 = float((_Channel >= 2.9));
  highp vec2 tmpvar_13;
  tmpvar_13.x = float((1.1 >= _Channel));
  tmpvar_13.y = float((_Channel >= 1.9));
  highp vec4 tmpvar_14;
  tmpvar_14.x = tmpvar_11;
  tmpvar_14.yz = ((1.0 - max (tmpvar_11, tmpvar_12)) * tmpvar_13);
  tmpvar_14.w = tmpvar_12;
  tmpvar_10 = tmpvar_14;
  result_4.w = (result_4.w * dot (texColor_5, tmpvar_10));
  highp float tmpvar_15;
  tmpvar_15 = float((_Channel >= 3.1));
  result_4.xyz = (result_4.xyz * ((
    (tmpvar_15 * texColor_5.xyz)
   + 1.0) - tmpvar_15));
  highp float tmpvar_16;
  tmpvar_16 = clamp ((tmpvar_8 * 3.0), 0.0, 1.0);
  highp vec4 tmpvar_17;
  tmpvar_17 = mix (_DissolveColor1, _DissolveColor2, vec4(float((tmpvar_16 > 0.2))));
  dissColor_3 = tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = mix (dissColor_3, result_4, vec4(clamp ((tmpvar_16 + 
    float((_Dissolve < 0.001))
  ), 0.0, 1.0)));
  result_4.xyz = tmpvar_18.xyz;
  mediump float tmpvar_19;
  tmpvar_19 = dot (result_4.xyz, vec3(0.33, 0.34, 0.33));
  gray_2 = tmpvar_19;
  aa_1[0] = result_4.w;
  aa_1[1] = gray_2;
  result_4.w = (result_4.w * aa_1[int(_RgbAsAlpha)]);
  result_4.w = (result_4.w * _AlphaCtrl);
  gl_FragData[0] = result_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DissolveTex_On" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Color;
uniform highp float _Multiplier;
uniform highp vec4 _MainTex_ST;
uniform highp float _MainTexRot;
uniform highp float _MainTexX;
uniform highp float _MainTexY;
uniform highp vec4 _DissolveTex_ST;
uniform highp float _DissolveRot;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_2.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + ((_MainTex_ST.zw + vec2(0.5, 0.5)) - (_MainTex_ST.xy * 0.5)));
  mediump vec2 uv_4;
  uv_4 = tmpvar_1.xy;
  mediump float uvRotate_5;
  uvRotate_5 = _MainTexRot;
  mediump vec2 outUV_6;
  mediump float tmpvar_7;
  tmpvar_7 = sin((uvRotate_5 / 57.2958));
  mediump float tmpvar_8;
  tmpvar_8 = cos((uvRotate_5 / 57.2958));
  outUV_6 = (uv_4 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_9;
  tmpvar_9.x = ((outUV_6.x * tmpvar_8) - (outUV_6.y * tmpvar_7));
  tmpvar_9.y = ((outUV_6.x * tmpvar_7) + (outUV_6.y * tmpvar_8));
  outUV_6 = (tmpvar_9 + vec2(0.5, 0.5));
  tmpvar_1.xy = outUV_6;
  highp vec2 tmpvar_10;
  tmpvar_10.x = _MainTexX;
  tmpvar_10.y = _MainTexY;
  tmpvar_1.xy = (tmpvar_1.xy + (_Time.z * tmpvar_10));
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _DissolveTex_ST.xy) + ((_DissolveTex_ST.zw + vec2(0.5, 0.5)) - (_DissolveTex_ST.xy * 0.5)));
  mediump vec2 uv_11;
  uv_11 = tmpvar_2.xy;
  mediump float uvRotate_12;
  uvRotate_12 = _DissolveRot;
  mediump vec2 outUV_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin((uvRotate_12 / 57.2958));
  mediump float tmpvar_15;
  tmpvar_15 = cos((uvRotate_12 / 57.2958));
  outUV_13 = (uv_11 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_16;
  tmpvar_16.x = ((outUV_13.x * tmpvar_15) - (outUV_13.y * tmpvar_14));
  tmpvar_16.y = ((outUV_13.x * tmpvar_14) + (outUV_13.y * tmpvar_15));
  outUV_13 = (tmpvar_16 + vec2(0.5, 0.5));
  tmpvar_2.xy = outUV_13;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = ((_glesColor * _Color) * _Multiplier);
}


#endif
#ifdef FRAGMENT
uniform highp float _AlphaCtrl;
uniform highp float _Channel;
uniform sampler2D _MainTex;
uniform sampler2D _DissolveTex;
uniform highp float _Dissolve;
uniform mediump vec4 _DissolveColor1;
uniform mediump vec4 _DissolveColor2;
uniform highp float _RgbAsAlpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp float aa_1[2];
  highp float gray_2;
  mediump vec4 dissColor_3;
  mediump vec4 result_4;
  mediump vec4 texColor_5;
  mediump vec4 dissolveColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_DissolveTex, xlv_TEXCOORD1.xy);
  dissolveColor_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = ((dissolveColor_6.x + (
    (_Dissolve * -1.2)
   + 0.6)) - 0.5);
  if ((tmpvar_8 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_5 = tmpvar_9;
  result_4 = xlv_COLOR;
  mediump vec4 tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = float((0.1 >= _Channel));
  highp float tmpvar_12;
  tmpvar_12 = float((_Channel >= 2.9));
  highp vec2 tmpvar_13;
  tmpvar_13.x = float((1.1 >= _Channel));
  tmpvar_13.y = float((_Channel >= 1.9));
  highp vec4 tmpvar_14;
  tmpvar_14.x = tmpvar_11;
  tmpvar_14.yz = ((1.0 - max (tmpvar_11, tmpvar_12)) * tmpvar_13);
  tmpvar_14.w = tmpvar_12;
  tmpvar_10 = tmpvar_14;
  result_4.w = (result_4.w * dot (texColor_5, tmpvar_10));
  highp float tmpvar_15;
  tmpvar_15 = float((_Channel >= 3.1));
  result_4.xyz = (result_4.xyz * ((
    (tmpvar_15 * texColor_5.xyz)
   + 1.0) - tmpvar_15));
  highp float tmpvar_16;
  tmpvar_16 = clamp ((tmpvar_8 * 3.0), 0.0, 1.0);
  highp vec4 tmpvar_17;
  tmpvar_17 = mix (_DissolveColor1, _DissolveColor2, vec4(float((tmpvar_16 > 0.2))));
  dissColor_3 = tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = mix (dissColor_3, result_4, vec4(clamp ((tmpvar_16 + 
    float((_Dissolve < 0.001))
  ), 0.0, 1.0)));
  result_4.xyz = tmpvar_18.xyz;
  mediump float tmpvar_19;
  tmpvar_19 = dot (result_4.xyz, vec3(0.33, 0.34, 0.33));
  gray_2 = tmpvar_19;
  aa_1[0] = result_4.w;
  aa_1[1] = gray_2;
  result_4.w = (result_4.w * aa_1[int(_RgbAsAlpha)]);
  result_4.w = (result_4.w * _AlphaCtrl);
  gl_FragData[0] = result_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DissolveTex_On" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Color;
uniform highp float _Multiplier;
uniform highp vec4 _MainTex_ST;
uniform highp float _MainTexRot;
uniform highp float _MainTexX;
uniform highp float _MainTexY;
uniform highp vec4 _DissolveTex_ST;
uniform highp float _DissolveRot;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_2.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + ((_MainTex_ST.zw + vec2(0.5, 0.5)) - (_MainTex_ST.xy * 0.5)));
  mediump vec2 uv_4;
  uv_4 = tmpvar_1.xy;
  mediump float uvRotate_5;
  uvRotate_5 = _MainTexRot;
  mediump vec2 outUV_6;
  mediump float tmpvar_7;
  tmpvar_7 = sin((uvRotate_5 / 57.2958));
  mediump float tmpvar_8;
  tmpvar_8 = cos((uvRotate_5 / 57.2958));
  outUV_6 = (uv_4 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_9;
  tmpvar_9.x = ((outUV_6.x * tmpvar_8) - (outUV_6.y * tmpvar_7));
  tmpvar_9.y = ((outUV_6.x * tmpvar_7) + (outUV_6.y * tmpvar_8));
  outUV_6 = (tmpvar_9 + vec2(0.5, 0.5));
  tmpvar_1.xy = outUV_6;
  highp vec2 tmpvar_10;
  tmpvar_10.x = _MainTexX;
  tmpvar_10.y = _MainTexY;
  tmpvar_1.xy = (tmpvar_1.xy + (_Time.z * tmpvar_10));
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _DissolveTex_ST.xy) + ((_DissolveTex_ST.zw + vec2(0.5, 0.5)) - (_DissolveTex_ST.xy * 0.5)));
  mediump vec2 uv_11;
  uv_11 = tmpvar_2.xy;
  mediump float uvRotate_12;
  uvRotate_12 = _DissolveRot;
  mediump vec2 outUV_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin((uvRotate_12 / 57.2958));
  mediump float tmpvar_15;
  tmpvar_15 = cos((uvRotate_12 / 57.2958));
  outUV_13 = (uv_11 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_16;
  tmpvar_16.x = ((outUV_13.x * tmpvar_15) - (outUV_13.y * tmpvar_14));
  tmpvar_16.y = ((outUV_13.x * tmpvar_14) + (outUV_13.y * tmpvar_15));
  outUV_13 = (tmpvar_16 + vec2(0.5, 0.5));
  tmpvar_2.xy = outUV_13;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = ((_glesColor * _Color) * _Multiplier);
}


#endif
#ifdef FRAGMENT
uniform highp float _AlphaCtrl;
uniform highp float _Channel;
uniform sampler2D _MainTex;
uniform sampler2D _DissolveTex;
uniform highp float _Dissolve;
uniform mediump vec4 _DissolveColor1;
uniform mediump vec4 _DissolveColor2;
uniform highp float _RgbAsAlpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp float aa_1[2];
  highp float gray_2;
  mediump vec4 dissColor_3;
  mediump vec4 result_4;
  mediump vec4 texColor_5;
  mediump vec4 dissolveColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_DissolveTex, xlv_TEXCOORD1.xy);
  dissolveColor_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = ((dissolveColor_6.x + (
    (_Dissolve * -1.2)
   + 0.6)) - 0.5);
  if ((tmpvar_8 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_5 = tmpvar_9;
  result_4 = xlv_COLOR;
  mediump vec4 tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = float((0.1 >= _Channel));
  highp float tmpvar_12;
  tmpvar_12 = float((_Channel >= 2.9));
  highp vec2 tmpvar_13;
  tmpvar_13.x = float((1.1 >= _Channel));
  tmpvar_13.y = float((_Channel >= 1.9));
  highp vec4 tmpvar_14;
  tmpvar_14.x = tmpvar_11;
  tmpvar_14.yz = ((1.0 - max (tmpvar_11, tmpvar_12)) * tmpvar_13);
  tmpvar_14.w = tmpvar_12;
  tmpvar_10 = tmpvar_14;
  result_4.w = (result_4.w * dot (texColor_5, tmpvar_10));
  highp float tmpvar_15;
  tmpvar_15 = float((_Channel >= 3.1));
  result_4.xyz = (result_4.xyz * ((
    (tmpvar_15 * texColor_5.xyz)
   + 1.0) - tmpvar_15));
  highp float tmpvar_16;
  tmpvar_16 = clamp ((tmpvar_8 * 3.0), 0.0, 1.0);
  highp vec4 tmpvar_17;
  tmpvar_17 = mix (_DissolveColor1, _DissolveColor2, vec4(float((tmpvar_16 > 0.2))));
  dissColor_3 = tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = mix (dissColor_3, result_4, vec4(clamp ((tmpvar_16 + 
    float((_Dissolve < 0.001))
  ), 0.0, 1.0)));
  result_4.xyz = tmpvar_18.xyz;
  mediump float tmpvar_19;
  tmpvar_19 = dot (result_4.xyz, vec3(0.33, 0.34, 0.33));
  gray_2 = tmpvar_19;
  aa_1[0] = result_4.w;
  aa_1[1] = gray_2;
  result_4.w = (result_4.w * aa_1[int(_RgbAsAlpha)]);
  result_4.w = (result_4.w * _AlphaCtrl);
  gl_FragData[0] = result_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DissolveTex_On" "RT_PASS_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Color;
uniform highp float _Multiplier;
uniform highp vec4 _MainTex_ST;
uniform highp float _MainTexRot;
uniform highp float _MainTexX;
uniform highp float _MainTexY;
uniform highp vec4 _DissolveTex_ST;
uniform highp float _DissolveRot;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_2.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + ((_MainTex_ST.zw + vec2(0.5, 0.5)) - (_MainTex_ST.xy * 0.5)));
  mediump vec2 uv_4;
  uv_4 = tmpvar_1.xy;
  mediump float uvRotate_5;
  uvRotate_5 = _MainTexRot;
  mediump vec2 outUV_6;
  mediump float tmpvar_7;
  tmpvar_7 = sin((uvRotate_5 / 57.2958));
  mediump float tmpvar_8;
  tmpvar_8 = cos((uvRotate_5 / 57.2958));
  outUV_6 = (uv_4 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_9;
  tmpvar_9.x = ((outUV_6.x * tmpvar_8) - (outUV_6.y * tmpvar_7));
  tmpvar_9.y = ((outUV_6.x * tmpvar_7) + (outUV_6.y * tmpvar_8));
  outUV_6 = (tmpvar_9 + vec2(0.5, 0.5));
  tmpvar_1.xy = outUV_6;
  highp vec2 tmpvar_10;
  tmpvar_10.x = _MainTexX;
  tmpvar_10.y = _MainTexY;
  tmpvar_1.xy = (tmpvar_1.xy + (_Time.z * tmpvar_10));
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _DissolveTex_ST.xy) + ((_DissolveTex_ST.zw + vec2(0.5, 0.5)) - (_DissolveTex_ST.xy * 0.5)));
  mediump vec2 uv_11;
  uv_11 = tmpvar_2.xy;
  mediump float uvRotate_12;
  uvRotate_12 = _DissolveRot;
  mediump vec2 outUV_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin((uvRotate_12 / 57.2958));
  mediump float tmpvar_15;
  tmpvar_15 = cos((uvRotate_12 / 57.2958));
  outUV_13 = (uv_11 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_16;
  tmpvar_16.x = ((outUV_13.x * tmpvar_15) - (outUV_13.y * tmpvar_14));
  tmpvar_16.y = ((outUV_13.x * tmpvar_14) + (outUV_13.y * tmpvar_15));
  outUV_13 = (tmpvar_16 + vec2(0.5, 0.5));
  tmpvar_2.xy = outUV_13;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = ((_glesColor * _Color) * _Multiplier);
}


#endif
#ifdef FRAGMENT
uniform highp float _AlphaCtrl;
uniform highp float _Channel;
uniform sampler2D _MainTex;
uniform sampler2D _DissolveTex;
uniform highp float _Dissolve;
uniform mediump vec4 _DissolveColor1;
uniform mediump vec4 _DissolveColor2;
uniform highp float _RgbAsAlpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp float aa_1[2];
  highp float gray_2;
  mediump vec4 dissColor_3;
  mediump vec4 result_4;
  mediump vec4 texColor_5;
  mediump vec4 dissolveColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_DissolveTex, xlv_TEXCOORD1.xy);
  dissolveColor_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = ((dissolveColor_6.x + (
    (_Dissolve * -1.2)
   + 0.6)) - 0.5);
  if ((tmpvar_8 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_5 = tmpvar_9;
  result_4 = xlv_COLOR;
  mediump vec4 tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = float((0.1 >= _Channel));
  highp float tmpvar_12;
  tmpvar_12 = float((_Channel >= 2.9));
  highp vec2 tmpvar_13;
  tmpvar_13.x = float((1.1 >= _Channel));
  tmpvar_13.y = float((_Channel >= 1.9));
  highp vec4 tmpvar_14;
  tmpvar_14.x = tmpvar_11;
  tmpvar_14.yz = ((1.0 - max (tmpvar_11, tmpvar_12)) * tmpvar_13);
  tmpvar_14.w = tmpvar_12;
  tmpvar_10 = tmpvar_14;
  result_4.w = (result_4.w * dot (texColor_5, tmpvar_10));
  highp float tmpvar_15;
  tmpvar_15 = float((_Channel >= 3.1));
  result_4.xyz = (result_4.xyz * ((
    (tmpvar_15 * texColor_5.xyz)
   + 1.0) - tmpvar_15));
  highp float tmpvar_16;
  tmpvar_16 = clamp ((tmpvar_8 * 3.0), 0.0, 1.0);
  highp vec4 tmpvar_17;
  tmpvar_17 = mix (_DissolveColor1, _DissolveColor2, vec4(float((tmpvar_16 > 0.2))));
  dissColor_3 = tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = mix (dissColor_3, result_4, vec4(clamp ((tmpvar_16 + 
    float((_Dissolve < 0.001))
  ), 0.0, 1.0)));
  result_4.xyz = tmpvar_18.xyz;
  mediump float tmpvar_19;
  tmpvar_19 = dot (result_4.xyz, vec3(0.33, 0.34, 0.33));
  gray_2 = tmpvar_19;
  aa_1[0] = result_4.w;
  aa_1[1] = gray_2;
  result_4.w = (result_4.w * aa_1[int(_RgbAsAlpha)]);
  result_4.w = (result_4.w * _AlphaCtrl);
  gl_FragData[0] = result_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DissolveTex_On" "RT_PASS_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Color;
uniform highp float _Multiplier;
uniform highp vec4 _MainTex_ST;
uniform highp float _MainTexRot;
uniform highp float _MainTexX;
uniform highp float _MainTexY;
uniform highp vec4 _DissolveTex_ST;
uniform highp float _DissolveRot;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_2.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + ((_MainTex_ST.zw + vec2(0.5, 0.5)) - (_MainTex_ST.xy * 0.5)));
  mediump vec2 uv_4;
  uv_4 = tmpvar_1.xy;
  mediump float uvRotate_5;
  uvRotate_5 = _MainTexRot;
  mediump vec2 outUV_6;
  mediump float tmpvar_7;
  tmpvar_7 = sin((uvRotate_5 / 57.2958));
  mediump float tmpvar_8;
  tmpvar_8 = cos((uvRotate_5 / 57.2958));
  outUV_6 = (uv_4 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_9;
  tmpvar_9.x = ((outUV_6.x * tmpvar_8) - (outUV_6.y * tmpvar_7));
  tmpvar_9.y = ((outUV_6.x * tmpvar_7) + (outUV_6.y * tmpvar_8));
  outUV_6 = (tmpvar_9 + vec2(0.5, 0.5));
  tmpvar_1.xy = outUV_6;
  highp vec2 tmpvar_10;
  tmpvar_10.x = _MainTexX;
  tmpvar_10.y = _MainTexY;
  tmpvar_1.xy = (tmpvar_1.xy + (_Time.z * tmpvar_10));
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _DissolveTex_ST.xy) + ((_DissolveTex_ST.zw + vec2(0.5, 0.5)) - (_DissolveTex_ST.xy * 0.5)));
  mediump vec2 uv_11;
  uv_11 = tmpvar_2.xy;
  mediump float uvRotate_12;
  uvRotate_12 = _DissolveRot;
  mediump vec2 outUV_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin((uvRotate_12 / 57.2958));
  mediump float tmpvar_15;
  tmpvar_15 = cos((uvRotate_12 / 57.2958));
  outUV_13 = (uv_11 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_16;
  tmpvar_16.x = ((outUV_13.x * tmpvar_15) - (outUV_13.y * tmpvar_14));
  tmpvar_16.y = ((outUV_13.x * tmpvar_14) + (outUV_13.y * tmpvar_15));
  outUV_13 = (tmpvar_16 + vec2(0.5, 0.5));
  tmpvar_2.xy = outUV_13;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = ((_glesColor * _Color) * _Multiplier);
}


#endif
#ifdef FRAGMENT
uniform highp float _AlphaCtrl;
uniform highp float _Channel;
uniform sampler2D _MainTex;
uniform sampler2D _DissolveTex;
uniform highp float _Dissolve;
uniform mediump vec4 _DissolveColor1;
uniform mediump vec4 _DissolveColor2;
uniform highp float _RgbAsAlpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp float aa_1[2];
  highp float gray_2;
  mediump vec4 dissColor_3;
  mediump vec4 result_4;
  mediump vec4 texColor_5;
  mediump vec4 dissolveColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_DissolveTex, xlv_TEXCOORD1.xy);
  dissolveColor_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = ((dissolveColor_6.x + (
    (_Dissolve * -1.2)
   + 0.6)) - 0.5);
  if ((tmpvar_8 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_5 = tmpvar_9;
  result_4 = xlv_COLOR;
  mediump vec4 tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = float((0.1 >= _Channel));
  highp float tmpvar_12;
  tmpvar_12 = float((_Channel >= 2.9));
  highp vec2 tmpvar_13;
  tmpvar_13.x = float((1.1 >= _Channel));
  tmpvar_13.y = float((_Channel >= 1.9));
  highp vec4 tmpvar_14;
  tmpvar_14.x = tmpvar_11;
  tmpvar_14.yz = ((1.0 - max (tmpvar_11, tmpvar_12)) * tmpvar_13);
  tmpvar_14.w = tmpvar_12;
  tmpvar_10 = tmpvar_14;
  result_4.w = (result_4.w * dot (texColor_5, tmpvar_10));
  highp float tmpvar_15;
  tmpvar_15 = float((_Channel >= 3.1));
  result_4.xyz = (result_4.xyz * ((
    (tmpvar_15 * texColor_5.xyz)
   + 1.0) - tmpvar_15));
  highp float tmpvar_16;
  tmpvar_16 = clamp ((tmpvar_8 * 3.0), 0.0, 1.0);
  highp vec4 tmpvar_17;
  tmpvar_17 = mix (_DissolveColor1, _DissolveColor2, vec4(float((tmpvar_16 > 0.2))));
  dissColor_3 = tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = mix (dissColor_3, result_4, vec4(clamp ((tmpvar_16 + 
    float((_Dissolve < 0.001))
  ), 0.0, 1.0)));
  result_4.xyz = tmpvar_18.xyz;
  mediump float tmpvar_19;
  tmpvar_19 = dot (result_4.xyz, vec3(0.33, 0.34, 0.33));
  gray_2 = tmpvar_19;
  aa_1[0] = result_4.w;
  aa_1[1] = gray_2;
  result_4.w = (result_4.w * aa_1[int(_RgbAsAlpha)]);
  result_4.w = (result_4.w * _AlphaCtrl);
  gl_FragData[0] = result_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DissolveTex_On" "RT_PASS_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Color;
uniform highp float _Multiplier;
uniform highp vec4 _MainTex_ST;
uniform highp float _MainTexRot;
uniform highp float _MainTexX;
uniform highp float _MainTexY;
uniform highp vec4 _DissolveTex_ST;
uniform highp float _DissolveRot;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_2.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + ((_MainTex_ST.zw + vec2(0.5, 0.5)) - (_MainTex_ST.xy * 0.5)));
  mediump vec2 uv_4;
  uv_4 = tmpvar_1.xy;
  mediump float uvRotate_5;
  uvRotate_5 = _MainTexRot;
  mediump vec2 outUV_6;
  mediump float tmpvar_7;
  tmpvar_7 = sin((uvRotate_5 / 57.2958));
  mediump float tmpvar_8;
  tmpvar_8 = cos((uvRotate_5 / 57.2958));
  outUV_6 = (uv_4 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_9;
  tmpvar_9.x = ((outUV_6.x * tmpvar_8) - (outUV_6.y * tmpvar_7));
  tmpvar_9.y = ((outUV_6.x * tmpvar_7) + (outUV_6.y * tmpvar_8));
  outUV_6 = (tmpvar_9 + vec2(0.5, 0.5));
  tmpvar_1.xy = outUV_6;
  highp vec2 tmpvar_10;
  tmpvar_10.x = _MainTexX;
  tmpvar_10.y = _MainTexY;
  tmpvar_1.xy = (tmpvar_1.xy + (_Time.z * tmpvar_10));
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _DissolveTex_ST.xy) + ((_DissolveTex_ST.zw + vec2(0.5, 0.5)) - (_DissolveTex_ST.xy * 0.5)));
  mediump vec2 uv_11;
  uv_11 = tmpvar_2.xy;
  mediump float uvRotate_12;
  uvRotate_12 = _DissolveRot;
  mediump vec2 outUV_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin((uvRotate_12 / 57.2958));
  mediump float tmpvar_15;
  tmpvar_15 = cos((uvRotate_12 / 57.2958));
  outUV_13 = (uv_11 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_16;
  tmpvar_16.x = ((outUV_13.x * tmpvar_15) - (outUV_13.y * tmpvar_14));
  tmpvar_16.y = ((outUV_13.x * tmpvar_14) + (outUV_13.y * tmpvar_15));
  outUV_13 = (tmpvar_16 + vec2(0.5, 0.5));
  tmpvar_2.xy = outUV_13;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = ((_glesColor * _Color) * _Multiplier);
}


#endif
#ifdef FRAGMENT
uniform highp float _AlphaCtrl;
uniform highp float _Channel;
uniform sampler2D _MainTex;
uniform sampler2D _DissolveTex;
uniform highp float _Dissolve;
uniform mediump vec4 _DissolveColor1;
uniform mediump vec4 _DissolveColor2;
uniform highp float _RgbAsAlpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp float aa_1[2];
  highp float gray_2;
  mediump vec4 dissColor_3;
  mediump vec4 result_4;
  mediump vec4 texColor_5;
  mediump vec4 dissolveColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_DissolveTex, xlv_TEXCOORD1.xy);
  dissolveColor_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = ((dissolveColor_6.x + (
    (_Dissolve * -1.2)
   + 0.6)) - 0.5);
  if ((tmpvar_8 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_5 = tmpvar_9;
  result_4 = xlv_COLOR;
  mediump vec4 tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = float((0.1 >= _Channel));
  highp float tmpvar_12;
  tmpvar_12 = float((_Channel >= 2.9));
  highp vec2 tmpvar_13;
  tmpvar_13.x = float((1.1 >= _Channel));
  tmpvar_13.y = float((_Channel >= 1.9));
  highp vec4 tmpvar_14;
  tmpvar_14.x = tmpvar_11;
  tmpvar_14.yz = ((1.0 - max (tmpvar_11, tmpvar_12)) * tmpvar_13);
  tmpvar_14.w = tmpvar_12;
  tmpvar_10 = tmpvar_14;
  result_4.w = (result_4.w * dot (texColor_5, tmpvar_10));
  highp float tmpvar_15;
  tmpvar_15 = float((_Channel >= 3.1));
  result_4.xyz = (result_4.xyz * ((
    (tmpvar_15 * texColor_5.xyz)
   + 1.0) - tmpvar_15));
  highp float tmpvar_16;
  tmpvar_16 = clamp ((tmpvar_8 * 3.0), 0.0, 1.0);
  highp vec4 tmpvar_17;
  tmpvar_17 = mix (_DissolveColor1, _DissolveColor2, vec4(float((tmpvar_16 > 0.2))));
  dissColor_3 = tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = mix (dissColor_3, result_4, vec4(clamp ((tmpvar_16 + 
    float((_Dissolve < 0.001))
  ), 0.0, 1.0)));
  result_4.xyz = tmpvar_18.xyz;
  mediump float tmpvar_19;
  tmpvar_19 = dot (result_4.xyz, vec3(0.33, 0.34, 0.33));
  gray_2 = tmpvar_19;
  aa_1[0] = result_4.w;
  aa_1[1] = gray_2;
  result_4.w = (result_4.w * aa_1[int(_RgbAsAlpha)]);
  result_4.w = (result_4.w * _AlphaCtrl);
  gl_FragData[0] = result_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DissolveTex_On" "MultiplyBlend_On" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Color;
uniform highp float _Multiplier;
uniform highp vec4 _MainTex_ST;
uniform highp float _MainTexRot;
uniform highp float _MainTexX;
uniform highp float _MainTexY;
uniform highp vec4 _DissolveTex_ST;
uniform highp float _DissolveRot;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_2.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + ((_MainTex_ST.zw + vec2(0.5, 0.5)) - (_MainTex_ST.xy * 0.5)));
  mediump vec2 uv_4;
  uv_4 = tmpvar_1.xy;
  mediump float uvRotate_5;
  uvRotate_5 = _MainTexRot;
  mediump vec2 outUV_6;
  mediump float tmpvar_7;
  tmpvar_7 = sin((uvRotate_5 / 57.2958));
  mediump float tmpvar_8;
  tmpvar_8 = cos((uvRotate_5 / 57.2958));
  outUV_6 = (uv_4 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_9;
  tmpvar_9.x = ((outUV_6.x * tmpvar_8) - (outUV_6.y * tmpvar_7));
  tmpvar_9.y = ((outUV_6.x * tmpvar_7) + (outUV_6.y * tmpvar_8));
  outUV_6 = (tmpvar_9 + vec2(0.5, 0.5));
  tmpvar_1.xy = outUV_6;
  highp vec2 tmpvar_10;
  tmpvar_10.x = _MainTexX;
  tmpvar_10.y = _MainTexY;
  tmpvar_1.xy = (tmpvar_1.xy + (_Time.z * tmpvar_10));
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _DissolveTex_ST.xy) + ((_DissolveTex_ST.zw + vec2(0.5, 0.5)) - (_DissolveTex_ST.xy * 0.5)));
  mediump vec2 uv_11;
  uv_11 = tmpvar_2.xy;
  mediump float uvRotate_12;
  uvRotate_12 = _DissolveRot;
  mediump vec2 outUV_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin((uvRotate_12 / 57.2958));
  mediump float tmpvar_15;
  tmpvar_15 = cos((uvRotate_12 / 57.2958));
  outUV_13 = (uv_11 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_16;
  tmpvar_16.x = ((outUV_13.x * tmpvar_15) - (outUV_13.y * tmpvar_14));
  tmpvar_16.y = ((outUV_13.x * tmpvar_14) + (outUV_13.y * tmpvar_15));
  outUV_13 = (tmpvar_16 + vec2(0.5, 0.5));
  tmpvar_2.xy = outUV_13;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = ((_glesColor * _Color) * _Multiplier);
}


#endif
#ifdef FRAGMENT
uniform highp float _AlphaCtrl;
uniform highp float _Channel;
uniform sampler2D _MainTex;
uniform sampler2D _DissolveTex;
uniform highp float _Dissolve;
uniform mediump vec4 _DissolveColor1;
uniform mediump vec4 _DissolveColor2;
uniform highp float _SrcFactor;
uniform highp float _RgbAsAlpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp float aa_1[2];
  highp float gray_2;
  mediump vec4 dissColor_3;
  mediump vec4 result_4;
  mediump vec4 texColor_5;
  mediump vec4 dissolveColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_DissolveTex, xlv_TEXCOORD1.xy);
  dissolveColor_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = ((dissolveColor_6.x + (
    (_Dissolve * -1.2)
   + 0.6)) - 0.5);
  if ((tmpvar_8 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_5 = tmpvar_9;
  result_4 = xlv_COLOR;
  mediump vec4 tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = float((0.1 >= _Channel));
  highp float tmpvar_12;
  tmpvar_12 = float((_Channel >= 2.9));
  highp vec2 tmpvar_13;
  tmpvar_13.x = float((1.1 >= _Channel));
  tmpvar_13.y = float((_Channel >= 1.9));
  highp vec4 tmpvar_14;
  tmpvar_14.x = tmpvar_11;
  tmpvar_14.yz = ((1.0 - max (tmpvar_11, tmpvar_12)) * tmpvar_13);
  tmpvar_14.w = tmpvar_12;
  tmpvar_10 = tmpvar_14;
  result_4.w = (result_4.w * dot (texColor_5, tmpvar_10));
  highp float tmpvar_15;
  tmpvar_15 = float((_Channel >= 3.1));
  result_4.xyz = (result_4.xyz * ((
    (tmpvar_15 * texColor_5.xyz)
   + 1.0) - tmpvar_15));
  highp float tmpvar_16;
  tmpvar_16 = clamp ((tmpvar_8 * 3.0), 0.0, 1.0);
  highp vec4 tmpvar_17;
  tmpvar_17 = mix (_DissolveColor1, _DissolveColor2, vec4(float((tmpvar_16 > 0.2))));
  dissColor_3 = tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = mix (dissColor_3, result_4, vec4(clamp ((tmpvar_16 + 
    float((_Dissolve < 0.001))
  ), 0.0, 1.0)));
  result_4.xyz = tmpvar_18.xyz;
  mediump float tmpvar_19;
  tmpvar_19 = dot (result_4.xyz, vec3(0.33, 0.34, 0.33));
  gray_2 = tmpvar_19;
  aa_1[0] = result_4.w;
  aa_1[1] = gray_2;
  result_4.w = (result_4.w * aa_1[int(_RgbAsAlpha)]);
  mediump vec4 tmpvar_20;
  tmpvar_20 = mix (vec4(1.0, 1.0, 1.0, 1.0), result_4, result_4.wwww);
  highp vec4 tmpvar_21;
  tmpvar_21 = mix (result_4, tmpvar_20, vec4(float((_SrcFactor == 0.0))));
  result_4 = tmpvar_21;
  result_4.w = (result_4.w * _AlphaCtrl);
  gl_FragData[0] = result_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DissolveTex_On" "MultiplyBlend_On" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Color;
uniform highp float _Multiplier;
uniform highp vec4 _MainTex_ST;
uniform highp float _MainTexRot;
uniform highp float _MainTexX;
uniform highp float _MainTexY;
uniform highp vec4 _DissolveTex_ST;
uniform highp float _DissolveRot;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_2.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + ((_MainTex_ST.zw + vec2(0.5, 0.5)) - (_MainTex_ST.xy * 0.5)));
  mediump vec2 uv_4;
  uv_4 = tmpvar_1.xy;
  mediump float uvRotate_5;
  uvRotate_5 = _MainTexRot;
  mediump vec2 outUV_6;
  mediump float tmpvar_7;
  tmpvar_7 = sin((uvRotate_5 / 57.2958));
  mediump float tmpvar_8;
  tmpvar_8 = cos((uvRotate_5 / 57.2958));
  outUV_6 = (uv_4 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_9;
  tmpvar_9.x = ((outUV_6.x * tmpvar_8) - (outUV_6.y * tmpvar_7));
  tmpvar_9.y = ((outUV_6.x * tmpvar_7) + (outUV_6.y * tmpvar_8));
  outUV_6 = (tmpvar_9 + vec2(0.5, 0.5));
  tmpvar_1.xy = outUV_6;
  highp vec2 tmpvar_10;
  tmpvar_10.x = _MainTexX;
  tmpvar_10.y = _MainTexY;
  tmpvar_1.xy = (tmpvar_1.xy + (_Time.z * tmpvar_10));
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _DissolveTex_ST.xy) + ((_DissolveTex_ST.zw + vec2(0.5, 0.5)) - (_DissolveTex_ST.xy * 0.5)));
  mediump vec2 uv_11;
  uv_11 = tmpvar_2.xy;
  mediump float uvRotate_12;
  uvRotate_12 = _DissolveRot;
  mediump vec2 outUV_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin((uvRotate_12 / 57.2958));
  mediump float tmpvar_15;
  tmpvar_15 = cos((uvRotate_12 / 57.2958));
  outUV_13 = (uv_11 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_16;
  tmpvar_16.x = ((outUV_13.x * tmpvar_15) - (outUV_13.y * tmpvar_14));
  tmpvar_16.y = ((outUV_13.x * tmpvar_14) + (outUV_13.y * tmpvar_15));
  outUV_13 = (tmpvar_16 + vec2(0.5, 0.5));
  tmpvar_2.xy = outUV_13;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = ((_glesColor * _Color) * _Multiplier);
}


#endif
#ifdef FRAGMENT
uniform highp float _AlphaCtrl;
uniform highp float _Channel;
uniform sampler2D _MainTex;
uniform sampler2D _DissolveTex;
uniform highp float _Dissolve;
uniform mediump vec4 _DissolveColor1;
uniform mediump vec4 _DissolveColor2;
uniform highp float _SrcFactor;
uniform highp float _RgbAsAlpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp float aa_1[2];
  highp float gray_2;
  mediump vec4 dissColor_3;
  mediump vec4 result_4;
  mediump vec4 texColor_5;
  mediump vec4 dissolveColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_DissolveTex, xlv_TEXCOORD1.xy);
  dissolveColor_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = ((dissolveColor_6.x + (
    (_Dissolve * -1.2)
   + 0.6)) - 0.5);
  if ((tmpvar_8 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_5 = tmpvar_9;
  result_4 = xlv_COLOR;
  mediump vec4 tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = float((0.1 >= _Channel));
  highp float tmpvar_12;
  tmpvar_12 = float((_Channel >= 2.9));
  highp vec2 tmpvar_13;
  tmpvar_13.x = float((1.1 >= _Channel));
  tmpvar_13.y = float((_Channel >= 1.9));
  highp vec4 tmpvar_14;
  tmpvar_14.x = tmpvar_11;
  tmpvar_14.yz = ((1.0 - max (tmpvar_11, tmpvar_12)) * tmpvar_13);
  tmpvar_14.w = tmpvar_12;
  tmpvar_10 = tmpvar_14;
  result_4.w = (result_4.w * dot (texColor_5, tmpvar_10));
  highp float tmpvar_15;
  tmpvar_15 = float((_Channel >= 3.1));
  result_4.xyz = (result_4.xyz * ((
    (tmpvar_15 * texColor_5.xyz)
   + 1.0) - tmpvar_15));
  highp float tmpvar_16;
  tmpvar_16 = clamp ((tmpvar_8 * 3.0), 0.0, 1.0);
  highp vec4 tmpvar_17;
  tmpvar_17 = mix (_DissolveColor1, _DissolveColor2, vec4(float((tmpvar_16 > 0.2))));
  dissColor_3 = tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = mix (dissColor_3, result_4, vec4(clamp ((tmpvar_16 + 
    float((_Dissolve < 0.001))
  ), 0.0, 1.0)));
  result_4.xyz = tmpvar_18.xyz;
  mediump float tmpvar_19;
  tmpvar_19 = dot (result_4.xyz, vec3(0.33, 0.34, 0.33));
  gray_2 = tmpvar_19;
  aa_1[0] = result_4.w;
  aa_1[1] = gray_2;
  result_4.w = (result_4.w * aa_1[int(_RgbAsAlpha)]);
  mediump vec4 tmpvar_20;
  tmpvar_20 = mix (vec4(1.0, 1.0, 1.0, 1.0), result_4, result_4.wwww);
  highp vec4 tmpvar_21;
  tmpvar_21 = mix (result_4, tmpvar_20, vec4(float((_SrcFactor == 0.0))));
  result_4 = tmpvar_21;
  result_4.w = (result_4.w * _AlphaCtrl);
  gl_FragData[0] = result_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DissolveTex_On" "MultiplyBlend_On" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Color;
uniform highp float _Multiplier;
uniform highp vec4 _MainTex_ST;
uniform highp float _MainTexRot;
uniform highp float _MainTexX;
uniform highp float _MainTexY;
uniform highp vec4 _DissolveTex_ST;
uniform highp float _DissolveRot;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_2.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + ((_MainTex_ST.zw + vec2(0.5, 0.5)) - (_MainTex_ST.xy * 0.5)));
  mediump vec2 uv_4;
  uv_4 = tmpvar_1.xy;
  mediump float uvRotate_5;
  uvRotate_5 = _MainTexRot;
  mediump vec2 outUV_6;
  mediump float tmpvar_7;
  tmpvar_7 = sin((uvRotate_5 / 57.2958));
  mediump float tmpvar_8;
  tmpvar_8 = cos((uvRotate_5 / 57.2958));
  outUV_6 = (uv_4 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_9;
  tmpvar_9.x = ((outUV_6.x * tmpvar_8) - (outUV_6.y * tmpvar_7));
  tmpvar_9.y = ((outUV_6.x * tmpvar_7) + (outUV_6.y * tmpvar_8));
  outUV_6 = (tmpvar_9 + vec2(0.5, 0.5));
  tmpvar_1.xy = outUV_6;
  highp vec2 tmpvar_10;
  tmpvar_10.x = _MainTexX;
  tmpvar_10.y = _MainTexY;
  tmpvar_1.xy = (tmpvar_1.xy + (_Time.z * tmpvar_10));
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _DissolveTex_ST.xy) + ((_DissolveTex_ST.zw + vec2(0.5, 0.5)) - (_DissolveTex_ST.xy * 0.5)));
  mediump vec2 uv_11;
  uv_11 = tmpvar_2.xy;
  mediump float uvRotate_12;
  uvRotate_12 = _DissolveRot;
  mediump vec2 outUV_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin((uvRotate_12 / 57.2958));
  mediump float tmpvar_15;
  tmpvar_15 = cos((uvRotate_12 / 57.2958));
  outUV_13 = (uv_11 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_16;
  tmpvar_16.x = ((outUV_13.x * tmpvar_15) - (outUV_13.y * tmpvar_14));
  tmpvar_16.y = ((outUV_13.x * tmpvar_14) + (outUV_13.y * tmpvar_15));
  outUV_13 = (tmpvar_16 + vec2(0.5, 0.5));
  tmpvar_2.xy = outUV_13;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = ((_glesColor * _Color) * _Multiplier);
}


#endif
#ifdef FRAGMENT
uniform highp float _AlphaCtrl;
uniform highp float _Channel;
uniform sampler2D _MainTex;
uniform sampler2D _DissolveTex;
uniform highp float _Dissolve;
uniform mediump vec4 _DissolveColor1;
uniform mediump vec4 _DissolveColor2;
uniform highp float _SrcFactor;
uniform highp float _RgbAsAlpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp float aa_1[2];
  highp float gray_2;
  mediump vec4 dissColor_3;
  mediump vec4 result_4;
  mediump vec4 texColor_5;
  mediump vec4 dissolveColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_DissolveTex, xlv_TEXCOORD1.xy);
  dissolveColor_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = ((dissolveColor_6.x + (
    (_Dissolve * -1.2)
   + 0.6)) - 0.5);
  if ((tmpvar_8 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_5 = tmpvar_9;
  result_4 = xlv_COLOR;
  mediump vec4 tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = float((0.1 >= _Channel));
  highp float tmpvar_12;
  tmpvar_12 = float((_Channel >= 2.9));
  highp vec2 tmpvar_13;
  tmpvar_13.x = float((1.1 >= _Channel));
  tmpvar_13.y = float((_Channel >= 1.9));
  highp vec4 tmpvar_14;
  tmpvar_14.x = tmpvar_11;
  tmpvar_14.yz = ((1.0 - max (tmpvar_11, tmpvar_12)) * tmpvar_13);
  tmpvar_14.w = tmpvar_12;
  tmpvar_10 = tmpvar_14;
  result_4.w = (result_4.w * dot (texColor_5, tmpvar_10));
  highp float tmpvar_15;
  tmpvar_15 = float((_Channel >= 3.1));
  result_4.xyz = (result_4.xyz * ((
    (tmpvar_15 * texColor_5.xyz)
   + 1.0) - tmpvar_15));
  highp float tmpvar_16;
  tmpvar_16 = clamp ((tmpvar_8 * 3.0), 0.0, 1.0);
  highp vec4 tmpvar_17;
  tmpvar_17 = mix (_DissolveColor1, _DissolveColor2, vec4(float((tmpvar_16 > 0.2))));
  dissColor_3 = tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = mix (dissColor_3, result_4, vec4(clamp ((tmpvar_16 + 
    float((_Dissolve < 0.001))
  ), 0.0, 1.0)));
  result_4.xyz = tmpvar_18.xyz;
  mediump float tmpvar_19;
  tmpvar_19 = dot (result_4.xyz, vec3(0.33, 0.34, 0.33));
  gray_2 = tmpvar_19;
  aa_1[0] = result_4.w;
  aa_1[1] = gray_2;
  result_4.w = (result_4.w * aa_1[int(_RgbAsAlpha)]);
  mediump vec4 tmpvar_20;
  tmpvar_20 = mix (vec4(1.0, 1.0, 1.0, 1.0), result_4, result_4.wwww);
  highp vec4 tmpvar_21;
  tmpvar_21 = mix (result_4, tmpvar_20, vec4(float((_SrcFactor == 0.0))));
  result_4 = tmpvar_21;
  result_4.w = (result_4.w * _AlphaCtrl);
  gl_FragData[0] = result_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DissolveTex_On" "MultiplyBlend_On" "RT_PASS_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Color;
uniform highp float _Multiplier;
uniform highp vec4 _MainTex_ST;
uniform highp float _MainTexRot;
uniform highp float _MainTexX;
uniform highp float _MainTexY;
uniform highp vec4 _DissolveTex_ST;
uniform highp float _DissolveRot;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_2.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + ((_MainTex_ST.zw + vec2(0.5, 0.5)) - (_MainTex_ST.xy * 0.5)));
  mediump vec2 uv_4;
  uv_4 = tmpvar_1.xy;
  mediump float uvRotate_5;
  uvRotate_5 = _MainTexRot;
  mediump vec2 outUV_6;
  mediump float tmpvar_7;
  tmpvar_7 = sin((uvRotate_5 / 57.2958));
  mediump float tmpvar_8;
  tmpvar_8 = cos((uvRotate_5 / 57.2958));
  outUV_6 = (uv_4 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_9;
  tmpvar_9.x = ((outUV_6.x * tmpvar_8) - (outUV_6.y * tmpvar_7));
  tmpvar_9.y = ((outUV_6.x * tmpvar_7) + (outUV_6.y * tmpvar_8));
  outUV_6 = (tmpvar_9 + vec2(0.5, 0.5));
  tmpvar_1.xy = outUV_6;
  highp vec2 tmpvar_10;
  tmpvar_10.x = _MainTexX;
  tmpvar_10.y = _MainTexY;
  tmpvar_1.xy = (tmpvar_1.xy + (_Time.z * tmpvar_10));
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _DissolveTex_ST.xy) + ((_DissolveTex_ST.zw + vec2(0.5, 0.5)) - (_DissolveTex_ST.xy * 0.5)));
  mediump vec2 uv_11;
  uv_11 = tmpvar_2.xy;
  mediump float uvRotate_12;
  uvRotate_12 = _DissolveRot;
  mediump vec2 outUV_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin((uvRotate_12 / 57.2958));
  mediump float tmpvar_15;
  tmpvar_15 = cos((uvRotate_12 / 57.2958));
  outUV_13 = (uv_11 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_16;
  tmpvar_16.x = ((outUV_13.x * tmpvar_15) - (outUV_13.y * tmpvar_14));
  tmpvar_16.y = ((outUV_13.x * tmpvar_14) + (outUV_13.y * tmpvar_15));
  outUV_13 = (tmpvar_16 + vec2(0.5, 0.5));
  tmpvar_2.xy = outUV_13;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = ((_glesColor * _Color) * _Multiplier);
}


#endif
#ifdef FRAGMENT
uniform highp float _AlphaCtrl;
uniform highp float _Channel;
uniform sampler2D _MainTex;
uniform sampler2D _DissolveTex;
uniform highp float _Dissolve;
uniform mediump vec4 _DissolveColor1;
uniform mediump vec4 _DissolveColor2;
uniform highp float _SrcFactor;
uniform highp float _RgbAsAlpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp float aa_1[2];
  highp float gray_2;
  mediump vec4 dissColor_3;
  mediump vec4 result_4;
  mediump vec4 texColor_5;
  mediump vec4 dissolveColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_DissolveTex, xlv_TEXCOORD1.xy);
  dissolveColor_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = ((dissolveColor_6.x + (
    (_Dissolve * -1.2)
   + 0.6)) - 0.5);
  if ((tmpvar_8 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_5 = tmpvar_9;
  result_4 = xlv_COLOR;
  mediump vec4 tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = float((0.1 >= _Channel));
  highp float tmpvar_12;
  tmpvar_12 = float((_Channel >= 2.9));
  highp vec2 tmpvar_13;
  tmpvar_13.x = float((1.1 >= _Channel));
  tmpvar_13.y = float((_Channel >= 1.9));
  highp vec4 tmpvar_14;
  tmpvar_14.x = tmpvar_11;
  tmpvar_14.yz = ((1.0 - max (tmpvar_11, tmpvar_12)) * tmpvar_13);
  tmpvar_14.w = tmpvar_12;
  tmpvar_10 = tmpvar_14;
  result_4.w = (result_4.w * dot (texColor_5, tmpvar_10));
  highp float tmpvar_15;
  tmpvar_15 = float((_Channel >= 3.1));
  result_4.xyz = (result_4.xyz * ((
    (tmpvar_15 * texColor_5.xyz)
   + 1.0) - tmpvar_15));
  highp float tmpvar_16;
  tmpvar_16 = clamp ((tmpvar_8 * 3.0), 0.0, 1.0);
  highp vec4 tmpvar_17;
  tmpvar_17 = mix (_DissolveColor1, _DissolveColor2, vec4(float((tmpvar_16 > 0.2))));
  dissColor_3 = tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = mix (dissColor_3, result_4, vec4(clamp ((tmpvar_16 + 
    float((_Dissolve < 0.001))
  ), 0.0, 1.0)));
  result_4.xyz = tmpvar_18.xyz;
  mediump float tmpvar_19;
  tmpvar_19 = dot (result_4.xyz, vec3(0.33, 0.34, 0.33));
  gray_2 = tmpvar_19;
  aa_1[0] = result_4.w;
  aa_1[1] = gray_2;
  result_4.w = (result_4.w * aa_1[int(_RgbAsAlpha)]);
  mediump vec4 tmpvar_20;
  tmpvar_20 = mix (vec4(1.0, 1.0, 1.0, 1.0), result_4, result_4.wwww);
  highp vec4 tmpvar_21;
  tmpvar_21 = mix (result_4, tmpvar_20, vec4(float((_SrcFactor == 0.0))));
  result_4 = tmpvar_21;
  result_4.w = (result_4.w * _AlphaCtrl);
  gl_FragData[0] = result_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DissolveTex_On" "MultiplyBlend_On" "RT_PASS_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Color;
uniform highp float _Multiplier;
uniform highp vec4 _MainTex_ST;
uniform highp float _MainTexRot;
uniform highp float _MainTexX;
uniform highp float _MainTexY;
uniform highp vec4 _DissolveTex_ST;
uniform highp float _DissolveRot;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_2.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + ((_MainTex_ST.zw + vec2(0.5, 0.5)) - (_MainTex_ST.xy * 0.5)));
  mediump vec2 uv_4;
  uv_4 = tmpvar_1.xy;
  mediump float uvRotate_5;
  uvRotate_5 = _MainTexRot;
  mediump vec2 outUV_6;
  mediump float tmpvar_7;
  tmpvar_7 = sin((uvRotate_5 / 57.2958));
  mediump float tmpvar_8;
  tmpvar_8 = cos((uvRotate_5 / 57.2958));
  outUV_6 = (uv_4 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_9;
  tmpvar_9.x = ((outUV_6.x * tmpvar_8) - (outUV_6.y * tmpvar_7));
  tmpvar_9.y = ((outUV_6.x * tmpvar_7) + (outUV_6.y * tmpvar_8));
  outUV_6 = (tmpvar_9 + vec2(0.5, 0.5));
  tmpvar_1.xy = outUV_6;
  highp vec2 tmpvar_10;
  tmpvar_10.x = _MainTexX;
  tmpvar_10.y = _MainTexY;
  tmpvar_1.xy = (tmpvar_1.xy + (_Time.z * tmpvar_10));
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _DissolveTex_ST.xy) + ((_DissolveTex_ST.zw + vec2(0.5, 0.5)) - (_DissolveTex_ST.xy * 0.5)));
  mediump vec2 uv_11;
  uv_11 = tmpvar_2.xy;
  mediump float uvRotate_12;
  uvRotate_12 = _DissolveRot;
  mediump vec2 outUV_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin((uvRotate_12 / 57.2958));
  mediump float tmpvar_15;
  tmpvar_15 = cos((uvRotate_12 / 57.2958));
  outUV_13 = (uv_11 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_16;
  tmpvar_16.x = ((outUV_13.x * tmpvar_15) - (outUV_13.y * tmpvar_14));
  tmpvar_16.y = ((outUV_13.x * tmpvar_14) + (outUV_13.y * tmpvar_15));
  outUV_13 = (tmpvar_16 + vec2(0.5, 0.5));
  tmpvar_2.xy = outUV_13;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = ((_glesColor * _Color) * _Multiplier);
}


#endif
#ifdef FRAGMENT
uniform highp float _AlphaCtrl;
uniform highp float _Channel;
uniform sampler2D _MainTex;
uniform sampler2D _DissolveTex;
uniform highp float _Dissolve;
uniform mediump vec4 _DissolveColor1;
uniform mediump vec4 _DissolveColor2;
uniform highp float _SrcFactor;
uniform highp float _RgbAsAlpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp float aa_1[2];
  highp float gray_2;
  mediump vec4 dissColor_3;
  mediump vec4 result_4;
  mediump vec4 texColor_5;
  mediump vec4 dissolveColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_DissolveTex, xlv_TEXCOORD1.xy);
  dissolveColor_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = ((dissolveColor_6.x + (
    (_Dissolve * -1.2)
   + 0.6)) - 0.5);
  if ((tmpvar_8 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_5 = tmpvar_9;
  result_4 = xlv_COLOR;
  mediump vec4 tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = float((0.1 >= _Channel));
  highp float tmpvar_12;
  tmpvar_12 = float((_Channel >= 2.9));
  highp vec2 tmpvar_13;
  tmpvar_13.x = float((1.1 >= _Channel));
  tmpvar_13.y = float((_Channel >= 1.9));
  highp vec4 tmpvar_14;
  tmpvar_14.x = tmpvar_11;
  tmpvar_14.yz = ((1.0 - max (tmpvar_11, tmpvar_12)) * tmpvar_13);
  tmpvar_14.w = tmpvar_12;
  tmpvar_10 = tmpvar_14;
  result_4.w = (result_4.w * dot (texColor_5, tmpvar_10));
  highp float tmpvar_15;
  tmpvar_15 = float((_Channel >= 3.1));
  result_4.xyz = (result_4.xyz * ((
    (tmpvar_15 * texColor_5.xyz)
   + 1.0) - tmpvar_15));
  highp float tmpvar_16;
  tmpvar_16 = clamp ((tmpvar_8 * 3.0), 0.0, 1.0);
  highp vec4 tmpvar_17;
  tmpvar_17 = mix (_DissolveColor1, _DissolveColor2, vec4(float((tmpvar_16 > 0.2))));
  dissColor_3 = tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = mix (dissColor_3, result_4, vec4(clamp ((tmpvar_16 + 
    float((_Dissolve < 0.001))
  ), 0.0, 1.0)));
  result_4.xyz = tmpvar_18.xyz;
  mediump float tmpvar_19;
  tmpvar_19 = dot (result_4.xyz, vec3(0.33, 0.34, 0.33));
  gray_2 = tmpvar_19;
  aa_1[0] = result_4.w;
  aa_1[1] = gray_2;
  result_4.w = (result_4.w * aa_1[int(_RgbAsAlpha)]);
  mediump vec4 tmpvar_20;
  tmpvar_20 = mix (vec4(1.0, 1.0, 1.0, 1.0), result_4, result_4.wwww);
  highp vec4 tmpvar_21;
  tmpvar_21 = mix (result_4, tmpvar_20, vec4(float((_SrcFactor == 0.0))));
  result_4 = tmpvar_21;
  result_4.w = (result_4.w * _AlphaCtrl);
  gl_FragData[0] = result_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DissolveTex_On" "MultiplyBlend_On" "RT_PASS_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Color;
uniform highp float _Multiplier;
uniform highp vec4 _MainTex_ST;
uniform highp float _MainTexRot;
uniform highp float _MainTexX;
uniform highp float _MainTexY;
uniform highp vec4 _DissolveTex_ST;
uniform highp float _DissolveRot;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_2.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + ((_MainTex_ST.zw + vec2(0.5, 0.5)) - (_MainTex_ST.xy * 0.5)));
  mediump vec2 uv_4;
  uv_4 = tmpvar_1.xy;
  mediump float uvRotate_5;
  uvRotate_5 = _MainTexRot;
  mediump vec2 outUV_6;
  mediump float tmpvar_7;
  tmpvar_7 = sin((uvRotate_5 / 57.2958));
  mediump float tmpvar_8;
  tmpvar_8 = cos((uvRotate_5 / 57.2958));
  outUV_6 = (uv_4 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_9;
  tmpvar_9.x = ((outUV_6.x * tmpvar_8) - (outUV_6.y * tmpvar_7));
  tmpvar_9.y = ((outUV_6.x * tmpvar_7) + (outUV_6.y * tmpvar_8));
  outUV_6 = (tmpvar_9 + vec2(0.5, 0.5));
  tmpvar_1.xy = outUV_6;
  highp vec2 tmpvar_10;
  tmpvar_10.x = _MainTexX;
  tmpvar_10.y = _MainTexY;
  tmpvar_1.xy = (tmpvar_1.xy + (_Time.z * tmpvar_10));
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _DissolveTex_ST.xy) + ((_DissolveTex_ST.zw + vec2(0.5, 0.5)) - (_DissolveTex_ST.xy * 0.5)));
  mediump vec2 uv_11;
  uv_11 = tmpvar_2.xy;
  mediump float uvRotate_12;
  uvRotate_12 = _DissolveRot;
  mediump vec2 outUV_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin((uvRotate_12 / 57.2958));
  mediump float tmpvar_15;
  tmpvar_15 = cos((uvRotate_12 / 57.2958));
  outUV_13 = (uv_11 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_16;
  tmpvar_16.x = ((outUV_13.x * tmpvar_15) - (outUV_13.y * tmpvar_14));
  tmpvar_16.y = ((outUV_13.x * tmpvar_14) + (outUV_13.y * tmpvar_15));
  outUV_13 = (tmpvar_16 + vec2(0.5, 0.5));
  tmpvar_2.xy = outUV_13;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = ((_glesColor * _Color) * _Multiplier);
}


#endif
#ifdef FRAGMENT
uniform highp float _AlphaCtrl;
uniform highp float _Channel;
uniform sampler2D _MainTex;
uniform sampler2D _DissolveTex;
uniform highp float _Dissolve;
uniform mediump vec4 _DissolveColor1;
uniform mediump vec4 _DissolveColor2;
uniform highp float _SrcFactor;
uniform highp float _RgbAsAlpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp float aa_1[2];
  highp float gray_2;
  mediump vec4 dissColor_3;
  mediump vec4 result_4;
  mediump vec4 texColor_5;
  mediump vec4 dissolveColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_DissolveTex, xlv_TEXCOORD1.xy);
  dissolveColor_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = ((dissolveColor_6.x + (
    (_Dissolve * -1.2)
   + 0.6)) - 0.5);
  if ((tmpvar_8 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_5 = tmpvar_9;
  result_4 = xlv_COLOR;
  mediump vec4 tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = float((0.1 >= _Channel));
  highp float tmpvar_12;
  tmpvar_12 = float((_Channel >= 2.9));
  highp vec2 tmpvar_13;
  tmpvar_13.x = float((1.1 >= _Channel));
  tmpvar_13.y = float((_Channel >= 1.9));
  highp vec4 tmpvar_14;
  tmpvar_14.x = tmpvar_11;
  tmpvar_14.yz = ((1.0 - max (tmpvar_11, tmpvar_12)) * tmpvar_13);
  tmpvar_14.w = tmpvar_12;
  tmpvar_10 = tmpvar_14;
  result_4.w = (result_4.w * dot (texColor_5, tmpvar_10));
  highp float tmpvar_15;
  tmpvar_15 = float((_Channel >= 3.1));
  result_4.xyz = (result_4.xyz * ((
    (tmpvar_15 * texColor_5.xyz)
   + 1.0) - tmpvar_15));
  highp float tmpvar_16;
  tmpvar_16 = clamp ((tmpvar_8 * 3.0), 0.0, 1.0);
  highp vec4 tmpvar_17;
  tmpvar_17 = mix (_DissolveColor1, _DissolveColor2, vec4(float((tmpvar_16 > 0.2))));
  dissColor_3 = tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = mix (dissColor_3, result_4, vec4(clamp ((tmpvar_16 + 
    float((_Dissolve < 0.001))
  ), 0.0, 1.0)));
  result_4.xyz = tmpvar_18.xyz;
  mediump float tmpvar_19;
  tmpvar_19 = dot (result_4.xyz, vec3(0.33, 0.34, 0.33));
  gray_2 = tmpvar_19;
  aa_1[0] = result_4.w;
  aa_1[1] = gray_2;
  result_4.w = (result_4.w * aa_1[int(_RgbAsAlpha)]);
  mediump vec4 tmpvar_20;
  tmpvar_20 = mix (vec4(1.0, 1.0, 1.0, 1.0), result_4, result_4.wwww);
  highp vec4 tmpvar_21;
  tmpvar_21 = mix (result_4, tmpvar_20, vec4(float((_SrcFactor == 0.0))));
  result_4 = tmpvar_21;
  result_4.w = (result_4.w * _AlphaCtrl);
  gl_FragData[0] = result_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "MaskTex_On" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Color;
uniform highp float _Multiplier;
uniform highp vec4 _MainTex_ST;
uniform highp float _MainTexRot;
uniform highp float _MainTexX;
uniform highp float _MainTexY;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskTexRot;
uniform highp float _MaskTexX;
uniform highp float _MaskTexY;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + ((_MainTex_ST.zw + vec2(0.5, 0.5)) - (_MainTex_ST.xy * 0.5)));
  mediump vec2 uv_3;
  uv_3 = tmpvar_1.xy;
  mediump float uvRotate_4;
  uvRotate_4 = _MainTexRot;
  mediump vec2 outUV_5;
  mediump float tmpvar_6;
  tmpvar_6 = sin((uvRotate_4 / 57.2958));
  mediump float tmpvar_7;
  tmpvar_7 = cos((uvRotate_4 / 57.2958));
  outUV_5 = (uv_3 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_8;
  tmpvar_8.x = ((outUV_5.x * tmpvar_7) - (outUV_5.y * tmpvar_6));
  tmpvar_8.y = ((outUV_5.x * tmpvar_6) + (outUV_5.y * tmpvar_7));
  outUV_5 = (tmpvar_8 + vec2(0.5, 0.5));
  tmpvar_1.xy = outUV_5;
  highp vec2 tmpvar_9;
  tmpvar_9.x = _MainTexX;
  tmpvar_9.y = _MainTexY;
  tmpvar_1.xy = (tmpvar_1.xy + (_Time.z * tmpvar_9));
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _MaskTex_ST.xy) + ((_MaskTex_ST.zw + vec2(0.5, 0.5)) - (_MaskTex_ST.xy * 0.5)));
  mediump vec2 uv_10;
  uv_10 = tmpvar_1.zw;
  mediump float uvRotate_11;
  uvRotate_11 = _MaskTexRot;
  mediump vec2 outUV_12;
  mediump float tmpvar_13;
  tmpvar_13 = sin((uvRotate_11 / 57.2958));
  mediump float tmpvar_14;
  tmpvar_14 = cos((uvRotate_11 / 57.2958));
  outUV_12 = (uv_10 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_15;
  tmpvar_15.x = ((outUV_12.x * tmpvar_14) - (outUV_12.y * tmpvar_13));
  tmpvar_15.y = ((outUV_12.x * tmpvar_13) + (outUV_12.y * tmpvar_14));
  outUV_12 = (tmpvar_15 + vec2(0.5, 0.5));
  tmpvar_1.zw = outUV_12;
  highp vec2 tmpvar_16;
  tmpvar_16.x = _MaskTexX;
  tmpvar_16.y = _MaskTexY;
  tmpvar_1.zw = (tmpvar_1.zw + (_Time.z * tmpvar_16));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_COLOR = ((_glesColor * _Color) * _Multiplier);
}


#endif
#ifdef FRAGMENT
uniform highp float _AlphaCtrl;
uniform highp float _Channel;
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform highp float _RgbAsAlpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp float aa_1[2];
  highp float gray_2;
  mediump vec4 maskColor_3;
  mediump vec4 result_4;
  mediump vec4 texColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_5 = tmpvar_6;
  result_4 = xlv_COLOR;
  mediump vec4 tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = float((0.1 >= _Channel));
  highp float tmpvar_9;
  tmpvar_9 = float((_Channel >= 2.9));
  highp vec2 tmpvar_10;
  tmpvar_10.x = float((1.1 >= _Channel));
  tmpvar_10.y = float((_Channel >= 1.9));
  highp vec4 tmpvar_11;
  tmpvar_11.x = tmpvar_8;
  tmpvar_11.yz = ((1.0 - max (tmpvar_8, tmpvar_9)) * tmpvar_10);
  tmpvar_11.w = tmpvar_9;
  tmpvar_7 = tmpvar_11;
  result_4.w = (result_4.w * dot (texColor_5, tmpvar_7));
  highp float tmpvar_12;
  tmpvar_12 = float((_Channel >= 3.1));
  result_4.xyz = (result_4.xyz * ((
    (tmpvar_12 * texColor_5.xyz)
   + 1.0) - tmpvar_12));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MaskTex, xlv_TEXCOORD0.zw);
  maskColor_3 = tmpvar_13;
  result_4.w = (result_4.w * maskColor_3.x);
  mediump float tmpvar_14;
  tmpvar_14 = dot (result_4.xyz, vec3(0.33, 0.34, 0.33));
  gray_2 = tmpvar_14;
  aa_1[0] = result_4.w;
  aa_1[1] = gray_2;
  result_4.w = (result_4.w * aa_1[int(_RgbAsAlpha)]);
  result_4.w = (result_4.w * _AlphaCtrl);
  gl_FragData[0] = result_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "MaskTex_On" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Color;
uniform highp float _Multiplier;
uniform highp vec4 _MainTex_ST;
uniform highp float _MainTexRot;
uniform highp float _MainTexX;
uniform highp float _MainTexY;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskTexRot;
uniform highp float _MaskTexX;
uniform highp float _MaskTexY;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + ((_MainTex_ST.zw + vec2(0.5, 0.5)) - (_MainTex_ST.xy * 0.5)));
  mediump vec2 uv_3;
  uv_3 = tmpvar_1.xy;
  mediump float uvRotate_4;
  uvRotate_4 = _MainTexRot;
  mediump vec2 outUV_5;
  mediump float tmpvar_6;
  tmpvar_6 = sin((uvRotate_4 / 57.2958));
  mediump float tmpvar_7;
  tmpvar_7 = cos((uvRotate_4 / 57.2958));
  outUV_5 = (uv_3 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_8;
  tmpvar_8.x = ((outUV_5.x * tmpvar_7) - (outUV_5.y * tmpvar_6));
  tmpvar_8.y = ((outUV_5.x * tmpvar_6) + (outUV_5.y * tmpvar_7));
  outUV_5 = (tmpvar_8 + vec2(0.5, 0.5));
  tmpvar_1.xy = outUV_5;
  highp vec2 tmpvar_9;
  tmpvar_9.x = _MainTexX;
  tmpvar_9.y = _MainTexY;
  tmpvar_1.xy = (tmpvar_1.xy + (_Time.z * tmpvar_9));
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _MaskTex_ST.xy) + ((_MaskTex_ST.zw + vec2(0.5, 0.5)) - (_MaskTex_ST.xy * 0.5)));
  mediump vec2 uv_10;
  uv_10 = tmpvar_1.zw;
  mediump float uvRotate_11;
  uvRotate_11 = _MaskTexRot;
  mediump vec2 outUV_12;
  mediump float tmpvar_13;
  tmpvar_13 = sin((uvRotate_11 / 57.2958));
  mediump float tmpvar_14;
  tmpvar_14 = cos((uvRotate_11 / 57.2958));
  outUV_12 = (uv_10 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_15;
  tmpvar_15.x = ((outUV_12.x * tmpvar_14) - (outUV_12.y * tmpvar_13));
  tmpvar_15.y = ((outUV_12.x * tmpvar_13) + (outUV_12.y * tmpvar_14));
  outUV_12 = (tmpvar_15 + vec2(0.5, 0.5));
  tmpvar_1.zw = outUV_12;
  highp vec2 tmpvar_16;
  tmpvar_16.x = _MaskTexX;
  tmpvar_16.y = _MaskTexY;
  tmpvar_1.zw = (tmpvar_1.zw + (_Time.z * tmpvar_16));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_COLOR = ((_glesColor * _Color) * _Multiplier);
}


#endif
#ifdef FRAGMENT
uniform highp float _AlphaCtrl;
uniform highp float _Channel;
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform highp float _RgbAsAlpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp float aa_1[2];
  highp float gray_2;
  mediump vec4 maskColor_3;
  mediump vec4 result_4;
  mediump vec4 texColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_5 = tmpvar_6;
  result_4 = xlv_COLOR;
  mediump vec4 tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = float((0.1 >= _Channel));
  highp float tmpvar_9;
  tmpvar_9 = float((_Channel >= 2.9));
  highp vec2 tmpvar_10;
  tmpvar_10.x = float((1.1 >= _Channel));
  tmpvar_10.y = float((_Channel >= 1.9));
  highp vec4 tmpvar_11;
  tmpvar_11.x = tmpvar_8;
  tmpvar_11.yz = ((1.0 - max (tmpvar_8, tmpvar_9)) * tmpvar_10);
  tmpvar_11.w = tmpvar_9;
  tmpvar_7 = tmpvar_11;
  result_4.w = (result_4.w * dot (texColor_5, tmpvar_7));
  highp float tmpvar_12;
  tmpvar_12 = float((_Channel >= 3.1));
  result_4.xyz = (result_4.xyz * ((
    (tmpvar_12 * texColor_5.xyz)
   + 1.0) - tmpvar_12));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MaskTex, xlv_TEXCOORD0.zw);
  maskColor_3 = tmpvar_13;
  result_4.w = (result_4.w * maskColor_3.x);
  mediump float tmpvar_14;
  tmpvar_14 = dot (result_4.xyz, vec3(0.33, 0.34, 0.33));
  gray_2 = tmpvar_14;
  aa_1[0] = result_4.w;
  aa_1[1] = gray_2;
  result_4.w = (result_4.w * aa_1[int(_RgbAsAlpha)]);
  result_4.w = (result_4.w * _AlphaCtrl);
  gl_FragData[0] = result_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "MaskTex_On" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Color;
uniform highp float _Multiplier;
uniform highp vec4 _MainTex_ST;
uniform highp float _MainTexRot;
uniform highp float _MainTexX;
uniform highp float _MainTexY;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskTexRot;
uniform highp float _MaskTexX;
uniform highp float _MaskTexY;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + ((_MainTex_ST.zw + vec2(0.5, 0.5)) - (_MainTex_ST.xy * 0.5)));
  mediump vec2 uv_3;
  uv_3 = tmpvar_1.xy;
  mediump float uvRotate_4;
  uvRotate_4 = _MainTexRot;
  mediump vec2 outUV_5;
  mediump float tmpvar_6;
  tmpvar_6 = sin((uvRotate_4 / 57.2958));
  mediump float tmpvar_7;
  tmpvar_7 = cos((uvRotate_4 / 57.2958));
  outUV_5 = (uv_3 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_8;
  tmpvar_8.x = ((outUV_5.x * tmpvar_7) - (outUV_5.y * tmpvar_6));
  tmpvar_8.y = ((outUV_5.x * tmpvar_6) + (outUV_5.y * tmpvar_7));
  outUV_5 = (tmpvar_8 + vec2(0.5, 0.5));
  tmpvar_1.xy = outUV_5;
  highp vec2 tmpvar_9;
  tmpvar_9.x = _MainTexX;
  tmpvar_9.y = _MainTexY;
  tmpvar_1.xy = (tmpvar_1.xy + (_Time.z * tmpvar_9));
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _MaskTex_ST.xy) + ((_MaskTex_ST.zw + vec2(0.5, 0.5)) - (_MaskTex_ST.xy * 0.5)));
  mediump vec2 uv_10;
  uv_10 = tmpvar_1.zw;
  mediump float uvRotate_11;
  uvRotate_11 = _MaskTexRot;
  mediump vec2 outUV_12;
  mediump float tmpvar_13;
  tmpvar_13 = sin((uvRotate_11 / 57.2958));
  mediump float tmpvar_14;
  tmpvar_14 = cos((uvRotate_11 / 57.2958));
  outUV_12 = (uv_10 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_15;
  tmpvar_15.x = ((outUV_12.x * tmpvar_14) - (outUV_12.y * tmpvar_13));
  tmpvar_15.y = ((outUV_12.x * tmpvar_13) + (outUV_12.y * tmpvar_14));
  outUV_12 = (tmpvar_15 + vec2(0.5, 0.5));
  tmpvar_1.zw = outUV_12;
  highp vec2 tmpvar_16;
  tmpvar_16.x = _MaskTexX;
  tmpvar_16.y = _MaskTexY;
  tmpvar_1.zw = (tmpvar_1.zw + (_Time.z * tmpvar_16));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_COLOR = ((_glesColor * _Color) * _Multiplier);
}


#endif
#ifdef FRAGMENT
uniform highp float _AlphaCtrl;
uniform highp float _Channel;
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform highp float _RgbAsAlpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp float aa_1[2];
  highp float gray_2;
  mediump vec4 maskColor_3;
  mediump vec4 result_4;
  mediump vec4 texColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_5 = tmpvar_6;
  result_4 = xlv_COLOR;
  mediump vec4 tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = float((0.1 >= _Channel));
  highp float tmpvar_9;
  tmpvar_9 = float((_Channel >= 2.9));
  highp vec2 tmpvar_10;
  tmpvar_10.x = float((1.1 >= _Channel));
  tmpvar_10.y = float((_Channel >= 1.9));
  highp vec4 tmpvar_11;
  tmpvar_11.x = tmpvar_8;
  tmpvar_11.yz = ((1.0 - max (tmpvar_8, tmpvar_9)) * tmpvar_10);
  tmpvar_11.w = tmpvar_9;
  tmpvar_7 = tmpvar_11;
  result_4.w = (result_4.w * dot (texColor_5, tmpvar_7));
  highp float tmpvar_12;
  tmpvar_12 = float((_Channel >= 3.1));
  result_4.xyz = (result_4.xyz * ((
    (tmpvar_12 * texColor_5.xyz)
   + 1.0) - tmpvar_12));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MaskTex, xlv_TEXCOORD0.zw);
  maskColor_3 = tmpvar_13;
  result_4.w = (result_4.w * maskColor_3.x);
  mediump float tmpvar_14;
  tmpvar_14 = dot (result_4.xyz, vec3(0.33, 0.34, 0.33));
  gray_2 = tmpvar_14;
  aa_1[0] = result_4.w;
  aa_1[1] = gray_2;
  result_4.w = (result_4.w * aa_1[int(_RgbAsAlpha)]);
  result_4.w = (result_4.w * _AlphaCtrl);
  gl_FragData[0] = result_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "MaskTex_On" "RT_PASS_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Color;
uniform highp float _Multiplier;
uniform highp vec4 _MainTex_ST;
uniform highp float _MainTexRot;
uniform highp float _MainTexX;
uniform highp float _MainTexY;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskTexRot;
uniform highp float _MaskTexX;
uniform highp float _MaskTexY;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + ((_MainTex_ST.zw + vec2(0.5, 0.5)) - (_MainTex_ST.xy * 0.5)));
  mediump vec2 uv_3;
  uv_3 = tmpvar_1.xy;
  mediump float uvRotate_4;
  uvRotate_4 = _MainTexRot;
  mediump vec2 outUV_5;
  mediump float tmpvar_6;
  tmpvar_6 = sin((uvRotate_4 / 57.2958));
  mediump float tmpvar_7;
  tmpvar_7 = cos((uvRotate_4 / 57.2958));
  outUV_5 = (uv_3 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_8;
  tmpvar_8.x = ((outUV_5.x * tmpvar_7) - (outUV_5.y * tmpvar_6));
  tmpvar_8.y = ((outUV_5.x * tmpvar_6) + (outUV_5.y * tmpvar_7));
  outUV_5 = (tmpvar_8 + vec2(0.5, 0.5));
  tmpvar_1.xy = outUV_5;
  highp vec2 tmpvar_9;
  tmpvar_9.x = _MainTexX;
  tmpvar_9.y = _MainTexY;
  tmpvar_1.xy = (tmpvar_1.xy + (_Time.z * tmpvar_9));
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _MaskTex_ST.xy) + ((_MaskTex_ST.zw + vec2(0.5, 0.5)) - (_MaskTex_ST.xy * 0.5)));
  mediump vec2 uv_10;
  uv_10 = tmpvar_1.zw;
  mediump float uvRotate_11;
  uvRotate_11 = _MaskTexRot;
  mediump vec2 outUV_12;
  mediump float tmpvar_13;
  tmpvar_13 = sin((uvRotate_11 / 57.2958));
  mediump float tmpvar_14;
  tmpvar_14 = cos((uvRotate_11 / 57.2958));
  outUV_12 = (uv_10 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_15;
  tmpvar_15.x = ((outUV_12.x * tmpvar_14) - (outUV_12.y * tmpvar_13));
  tmpvar_15.y = ((outUV_12.x * tmpvar_13) + (outUV_12.y * tmpvar_14));
  outUV_12 = (tmpvar_15 + vec2(0.5, 0.5));
  tmpvar_1.zw = outUV_12;
  highp vec2 tmpvar_16;
  tmpvar_16.x = _MaskTexX;
  tmpvar_16.y = _MaskTexY;
  tmpvar_1.zw = (tmpvar_1.zw + (_Time.z * tmpvar_16));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_COLOR = ((_glesColor * _Color) * _Multiplier);
}


#endif
#ifdef FRAGMENT
uniform highp float _AlphaCtrl;
uniform highp float _Channel;
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform highp float _RgbAsAlpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp float aa_1[2];
  highp float gray_2;
  mediump vec4 maskColor_3;
  mediump vec4 result_4;
  mediump vec4 texColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_5 = tmpvar_6;
  result_4 = xlv_COLOR;
  mediump vec4 tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = float((0.1 >= _Channel));
  highp float tmpvar_9;
  tmpvar_9 = float((_Channel >= 2.9));
  highp vec2 tmpvar_10;
  tmpvar_10.x = float((1.1 >= _Channel));
  tmpvar_10.y = float((_Channel >= 1.9));
  highp vec4 tmpvar_11;
  tmpvar_11.x = tmpvar_8;
  tmpvar_11.yz = ((1.0 - max (tmpvar_8, tmpvar_9)) * tmpvar_10);
  tmpvar_11.w = tmpvar_9;
  tmpvar_7 = tmpvar_11;
  result_4.w = (result_4.w * dot (texColor_5, tmpvar_7));
  highp float tmpvar_12;
  tmpvar_12 = float((_Channel >= 3.1));
  result_4.xyz = (result_4.xyz * ((
    (tmpvar_12 * texColor_5.xyz)
   + 1.0) - tmpvar_12));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MaskTex, xlv_TEXCOORD0.zw);
  maskColor_3 = tmpvar_13;
  result_4.w = (result_4.w * maskColor_3.x);
  mediump float tmpvar_14;
  tmpvar_14 = dot (result_4.xyz, vec3(0.33, 0.34, 0.33));
  gray_2 = tmpvar_14;
  aa_1[0] = result_4.w;
  aa_1[1] = gray_2;
  result_4.w = (result_4.w * aa_1[int(_RgbAsAlpha)]);
  result_4.w = (result_4.w * _AlphaCtrl);
  gl_FragData[0] = result_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "MaskTex_On" "RT_PASS_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Color;
uniform highp float _Multiplier;
uniform highp vec4 _MainTex_ST;
uniform highp float _MainTexRot;
uniform highp float _MainTexX;
uniform highp float _MainTexY;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskTexRot;
uniform highp float _MaskTexX;
uniform highp float _MaskTexY;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + ((_MainTex_ST.zw + vec2(0.5, 0.5)) - (_MainTex_ST.xy * 0.5)));
  mediump vec2 uv_3;
  uv_3 = tmpvar_1.xy;
  mediump float uvRotate_4;
  uvRotate_4 = _MainTexRot;
  mediump vec2 outUV_5;
  mediump float tmpvar_6;
  tmpvar_6 = sin((uvRotate_4 / 57.2958));
  mediump float tmpvar_7;
  tmpvar_7 = cos((uvRotate_4 / 57.2958));
  outUV_5 = (uv_3 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_8;
  tmpvar_8.x = ((outUV_5.x * tmpvar_7) - (outUV_5.y * tmpvar_6));
  tmpvar_8.y = ((outUV_5.x * tmpvar_6) + (outUV_5.y * tmpvar_7));
  outUV_5 = (tmpvar_8 + vec2(0.5, 0.5));
  tmpvar_1.xy = outUV_5;
  highp vec2 tmpvar_9;
  tmpvar_9.x = _MainTexX;
  tmpvar_9.y = _MainTexY;
  tmpvar_1.xy = (tmpvar_1.xy + (_Time.z * tmpvar_9));
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _MaskTex_ST.xy) + ((_MaskTex_ST.zw + vec2(0.5, 0.5)) - (_MaskTex_ST.xy * 0.5)));
  mediump vec2 uv_10;
  uv_10 = tmpvar_1.zw;
  mediump float uvRotate_11;
  uvRotate_11 = _MaskTexRot;
  mediump vec2 outUV_12;
  mediump float tmpvar_13;
  tmpvar_13 = sin((uvRotate_11 / 57.2958));
  mediump float tmpvar_14;
  tmpvar_14 = cos((uvRotate_11 / 57.2958));
  outUV_12 = (uv_10 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_15;
  tmpvar_15.x = ((outUV_12.x * tmpvar_14) - (outUV_12.y * tmpvar_13));
  tmpvar_15.y = ((outUV_12.x * tmpvar_13) + (outUV_12.y * tmpvar_14));
  outUV_12 = (tmpvar_15 + vec2(0.5, 0.5));
  tmpvar_1.zw = outUV_12;
  highp vec2 tmpvar_16;
  tmpvar_16.x = _MaskTexX;
  tmpvar_16.y = _MaskTexY;
  tmpvar_1.zw = (tmpvar_1.zw + (_Time.z * tmpvar_16));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_COLOR = ((_glesColor * _Color) * _Multiplier);
}


#endif
#ifdef FRAGMENT
uniform highp float _AlphaCtrl;
uniform highp float _Channel;
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform highp float _RgbAsAlpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp float aa_1[2];
  highp float gray_2;
  mediump vec4 maskColor_3;
  mediump vec4 result_4;
  mediump vec4 texColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_5 = tmpvar_6;
  result_4 = xlv_COLOR;
  mediump vec4 tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = float((0.1 >= _Channel));
  highp float tmpvar_9;
  tmpvar_9 = float((_Channel >= 2.9));
  highp vec2 tmpvar_10;
  tmpvar_10.x = float((1.1 >= _Channel));
  tmpvar_10.y = float((_Channel >= 1.9));
  highp vec4 tmpvar_11;
  tmpvar_11.x = tmpvar_8;
  tmpvar_11.yz = ((1.0 - max (tmpvar_8, tmpvar_9)) * tmpvar_10);
  tmpvar_11.w = tmpvar_9;
  tmpvar_7 = tmpvar_11;
  result_4.w = (result_4.w * dot (texColor_5, tmpvar_7));
  highp float tmpvar_12;
  tmpvar_12 = float((_Channel >= 3.1));
  result_4.xyz = (result_4.xyz * ((
    (tmpvar_12 * texColor_5.xyz)
   + 1.0) - tmpvar_12));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MaskTex, xlv_TEXCOORD0.zw);
  maskColor_3 = tmpvar_13;
  result_4.w = (result_4.w * maskColor_3.x);
  mediump float tmpvar_14;
  tmpvar_14 = dot (result_4.xyz, vec3(0.33, 0.34, 0.33));
  gray_2 = tmpvar_14;
  aa_1[0] = result_4.w;
  aa_1[1] = gray_2;
  result_4.w = (result_4.w * aa_1[int(_RgbAsAlpha)]);
  result_4.w = (result_4.w * _AlphaCtrl);
  gl_FragData[0] = result_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "MaskTex_On" "RT_PASS_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Color;
uniform highp float _Multiplier;
uniform highp vec4 _MainTex_ST;
uniform highp float _MainTexRot;
uniform highp float _MainTexX;
uniform highp float _MainTexY;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskTexRot;
uniform highp float _MaskTexX;
uniform highp float _MaskTexY;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + ((_MainTex_ST.zw + vec2(0.5, 0.5)) - (_MainTex_ST.xy * 0.5)));
  mediump vec2 uv_3;
  uv_3 = tmpvar_1.xy;
  mediump float uvRotate_4;
  uvRotate_4 = _MainTexRot;
  mediump vec2 outUV_5;
  mediump float tmpvar_6;
  tmpvar_6 = sin((uvRotate_4 / 57.2958));
  mediump float tmpvar_7;
  tmpvar_7 = cos((uvRotate_4 / 57.2958));
  outUV_5 = (uv_3 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_8;
  tmpvar_8.x = ((outUV_5.x * tmpvar_7) - (outUV_5.y * tmpvar_6));
  tmpvar_8.y = ((outUV_5.x * tmpvar_6) + (outUV_5.y * tmpvar_7));
  outUV_5 = (tmpvar_8 + vec2(0.5, 0.5));
  tmpvar_1.xy = outUV_5;
  highp vec2 tmpvar_9;
  tmpvar_9.x = _MainTexX;
  tmpvar_9.y = _MainTexY;
  tmpvar_1.xy = (tmpvar_1.xy + (_Time.z * tmpvar_9));
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _MaskTex_ST.xy) + ((_MaskTex_ST.zw + vec2(0.5, 0.5)) - (_MaskTex_ST.xy * 0.5)));
  mediump vec2 uv_10;
  uv_10 = tmpvar_1.zw;
  mediump float uvRotate_11;
  uvRotate_11 = _MaskTexRot;
  mediump vec2 outUV_12;
  mediump float tmpvar_13;
  tmpvar_13 = sin((uvRotate_11 / 57.2958));
  mediump float tmpvar_14;
  tmpvar_14 = cos((uvRotate_11 / 57.2958));
  outUV_12 = (uv_10 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_15;
  tmpvar_15.x = ((outUV_12.x * tmpvar_14) - (outUV_12.y * tmpvar_13));
  tmpvar_15.y = ((outUV_12.x * tmpvar_13) + (outUV_12.y * tmpvar_14));
  outUV_12 = (tmpvar_15 + vec2(0.5, 0.5));
  tmpvar_1.zw = outUV_12;
  highp vec2 tmpvar_16;
  tmpvar_16.x = _MaskTexX;
  tmpvar_16.y = _MaskTexY;
  tmpvar_1.zw = (tmpvar_1.zw + (_Time.z * tmpvar_16));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_COLOR = ((_glesColor * _Color) * _Multiplier);
}


#endif
#ifdef FRAGMENT
uniform highp float _AlphaCtrl;
uniform highp float _Channel;
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform highp float _RgbAsAlpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp float aa_1[2];
  highp float gray_2;
  mediump vec4 maskColor_3;
  mediump vec4 result_4;
  mediump vec4 texColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_5 = tmpvar_6;
  result_4 = xlv_COLOR;
  mediump vec4 tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = float((0.1 >= _Channel));
  highp float tmpvar_9;
  tmpvar_9 = float((_Channel >= 2.9));
  highp vec2 tmpvar_10;
  tmpvar_10.x = float((1.1 >= _Channel));
  tmpvar_10.y = float((_Channel >= 1.9));
  highp vec4 tmpvar_11;
  tmpvar_11.x = tmpvar_8;
  tmpvar_11.yz = ((1.0 - max (tmpvar_8, tmpvar_9)) * tmpvar_10);
  tmpvar_11.w = tmpvar_9;
  tmpvar_7 = tmpvar_11;
  result_4.w = (result_4.w * dot (texColor_5, tmpvar_7));
  highp float tmpvar_12;
  tmpvar_12 = float((_Channel >= 3.1));
  result_4.xyz = (result_4.xyz * ((
    (tmpvar_12 * texColor_5.xyz)
   + 1.0) - tmpvar_12));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MaskTex, xlv_TEXCOORD0.zw);
  maskColor_3 = tmpvar_13;
  result_4.w = (result_4.w * maskColor_3.x);
  mediump float tmpvar_14;
  tmpvar_14 = dot (result_4.xyz, vec3(0.33, 0.34, 0.33));
  gray_2 = tmpvar_14;
  aa_1[0] = result_4.w;
  aa_1[1] = gray_2;
  result_4.w = (result_4.w * aa_1[int(_RgbAsAlpha)]);
  result_4.w = (result_4.w * _AlphaCtrl);
  gl_FragData[0] = result_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "MaskTex_On" "MultiplyBlend_On" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Color;
uniform highp float _Multiplier;
uniform highp vec4 _MainTex_ST;
uniform highp float _MainTexRot;
uniform highp float _MainTexX;
uniform highp float _MainTexY;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskTexRot;
uniform highp float _MaskTexX;
uniform highp float _MaskTexY;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + ((_MainTex_ST.zw + vec2(0.5, 0.5)) - (_MainTex_ST.xy * 0.5)));
  mediump vec2 uv_3;
  uv_3 = tmpvar_1.xy;
  mediump float uvRotate_4;
  uvRotate_4 = _MainTexRot;
  mediump vec2 outUV_5;
  mediump float tmpvar_6;
  tmpvar_6 = sin((uvRotate_4 / 57.2958));
  mediump float tmpvar_7;
  tmpvar_7 = cos((uvRotate_4 / 57.2958));
  outUV_5 = (uv_3 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_8;
  tmpvar_8.x = ((outUV_5.x * tmpvar_7) - (outUV_5.y * tmpvar_6));
  tmpvar_8.y = ((outUV_5.x * tmpvar_6) + (outUV_5.y * tmpvar_7));
  outUV_5 = (tmpvar_8 + vec2(0.5, 0.5));
  tmpvar_1.xy = outUV_5;
  highp vec2 tmpvar_9;
  tmpvar_9.x = _MainTexX;
  tmpvar_9.y = _MainTexY;
  tmpvar_1.xy = (tmpvar_1.xy + (_Time.z * tmpvar_9));
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _MaskTex_ST.xy) + ((_MaskTex_ST.zw + vec2(0.5, 0.5)) - (_MaskTex_ST.xy * 0.5)));
  mediump vec2 uv_10;
  uv_10 = tmpvar_1.zw;
  mediump float uvRotate_11;
  uvRotate_11 = _MaskTexRot;
  mediump vec2 outUV_12;
  mediump float tmpvar_13;
  tmpvar_13 = sin((uvRotate_11 / 57.2958));
  mediump float tmpvar_14;
  tmpvar_14 = cos((uvRotate_11 / 57.2958));
  outUV_12 = (uv_10 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_15;
  tmpvar_15.x = ((outUV_12.x * tmpvar_14) - (outUV_12.y * tmpvar_13));
  tmpvar_15.y = ((outUV_12.x * tmpvar_13) + (outUV_12.y * tmpvar_14));
  outUV_12 = (tmpvar_15 + vec2(0.5, 0.5));
  tmpvar_1.zw = outUV_12;
  highp vec2 tmpvar_16;
  tmpvar_16.x = _MaskTexX;
  tmpvar_16.y = _MaskTexY;
  tmpvar_1.zw = (tmpvar_1.zw + (_Time.z * tmpvar_16));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_COLOR = ((_glesColor * _Color) * _Multiplier);
}


#endif
#ifdef FRAGMENT
uniform highp float _AlphaCtrl;
uniform highp float _Channel;
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform highp float _SrcFactor;
uniform highp float _RgbAsAlpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp float aa_1[2];
  highp float gray_2;
  mediump vec4 maskColor_3;
  mediump vec4 result_4;
  mediump vec4 texColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_5 = tmpvar_6;
  result_4 = xlv_COLOR;
  mediump vec4 tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = float((0.1 >= _Channel));
  highp float tmpvar_9;
  tmpvar_9 = float((_Channel >= 2.9));
  highp vec2 tmpvar_10;
  tmpvar_10.x = float((1.1 >= _Channel));
  tmpvar_10.y = float((_Channel >= 1.9));
  highp vec4 tmpvar_11;
  tmpvar_11.x = tmpvar_8;
  tmpvar_11.yz = ((1.0 - max (tmpvar_8, tmpvar_9)) * tmpvar_10);
  tmpvar_11.w = tmpvar_9;
  tmpvar_7 = tmpvar_11;
  result_4.w = (result_4.w * dot (texColor_5, tmpvar_7));
  highp float tmpvar_12;
  tmpvar_12 = float((_Channel >= 3.1));
  result_4.xyz = (result_4.xyz * ((
    (tmpvar_12 * texColor_5.xyz)
   + 1.0) - tmpvar_12));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MaskTex, xlv_TEXCOORD0.zw);
  maskColor_3 = tmpvar_13;
  result_4.w = (result_4.w * maskColor_3.x);
  mediump float tmpvar_14;
  tmpvar_14 = dot (result_4.xyz, vec3(0.33, 0.34, 0.33));
  gray_2 = tmpvar_14;
  aa_1[0] = result_4.w;
  aa_1[1] = gray_2;
  result_4.w = (result_4.w * aa_1[int(_RgbAsAlpha)]);
  mediump vec4 tmpvar_15;
  tmpvar_15 = mix (vec4(1.0, 1.0, 1.0, 1.0), result_4, result_4.wwww);
  highp vec4 tmpvar_16;
  tmpvar_16 = mix (result_4, tmpvar_15, vec4(float((_SrcFactor == 0.0))));
  result_4 = tmpvar_16;
  result_4.w = (result_4.w * _AlphaCtrl);
  gl_FragData[0] = result_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "MaskTex_On" "MultiplyBlend_On" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Color;
uniform highp float _Multiplier;
uniform highp vec4 _MainTex_ST;
uniform highp float _MainTexRot;
uniform highp float _MainTexX;
uniform highp float _MainTexY;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskTexRot;
uniform highp float _MaskTexX;
uniform highp float _MaskTexY;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + ((_MainTex_ST.zw + vec2(0.5, 0.5)) - (_MainTex_ST.xy * 0.5)));
  mediump vec2 uv_3;
  uv_3 = tmpvar_1.xy;
  mediump float uvRotate_4;
  uvRotate_4 = _MainTexRot;
  mediump vec2 outUV_5;
  mediump float tmpvar_6;
  tmpvar_6 = sin((uvRotate_4 / 57.2958));
  mediump float tmpvar_7;
  tmpvar_7 = cos((uvRotate_4 / 57.2958));
  outUV_5 = (uv_3 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_8;
  tmpvar_8.x = ((outUV_5.x * tmpvar_7) - (outUV_5.y * tmpvar_6));
  tmpvar_8.y = ((outUV_5.x * tmpvar_6) + (outUV_5.y * tmpvar_7));
  outUV_5 = (tmpvar_8 + vec2(0.5, 0.5));
  tmpvar_1.xy = outUV_5;
  highp vec2 tmpvar_9;
  tmpvar_9.x = _MainTexX;
  tmpvar_9.y = _MainTexY;
  tmpvar_1.xy = (tmpvar_1.xy + (_Time.z * tmpvar_9));
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _MaskTex_ST.xy) + ((_MaskTex_ST.zw + vec2(0.5, 0.5)) - (_MaskTex_ST.xy * 0.5)));
  mediump vec2 uv_10;
  uv_10 = tmpvar_1.zw;
  mediump float uvRotate_11;
  uvRotate_11 = _MaskTexRot;
  mediump vec2 outUV_12;
  mediump float tmpvar_13;
  tmpvar_13 = sin((uvRotate_11 / 57.2958));
  mediump float tmpvar_14;
  tmpvar_14 = cos((uvRotate_11 / 57.2958));
  outUV_12 = (uv_10 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_15;
  tmpvar_15.x = ((outUV_12.x * tmpvar_14) - (outUV_12.y * tmpvar_13));
  tmpvar_15.y = ((outUV_12.x * tmpvar_13) + (outUV_12.y * tmpvar_14));
  outUV_12 = (tmpvar_15 + vec2(0.5, 0.5));
  tmpvar_1.zw = outUV_12;
  highp vec2 tmpvar_16;
  tmpvar_16.x = _MaskTexX;
  tmpvar_16.y = _MaskTexY;
  tmpvar_1.zw = (tmpvar_1.zw + (_Time.z * tmpvar_16));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_COLOR = ((_glesColor * _Color) * _Multiplier);
}


#endif
#ifdef FRAGMENT
uniform highp float _AlphaCtrl;
uniform highp float _Channel;
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform highp float _SrcFactor;
uniform highp float _RgbAsAlpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp float aa_1[2];
  highp float gray_2;
  mediump vec4 maskColor_3;
  mediump vec4 result_4;
  mediump vec4 texColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_5 = tmpvar_6;
  result_4 = xlv_COLOR;
  mediump vec4 tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = float((0.1 >= _Channel));
  highp float tmpvar_9;
  tmpvar_9 = float((_Channel >= 2.9));
  highp vec2 tmpvar_10;
  tmpvar_10.x = float((1.1 >= _Channel));
  tmpvar_10.y = float((_Channel >= 1.9));
  highp vec4 tmpvar_11;
  tmpvar_11.x = tmpvar_8;
  tmpvar_11.yz = ((1.0 - max (tmpvar_8, tmpvar_9)) * tmpvar_10);
  tmpvar_11.w = tmpvar_9;
  tmpvar_7 = tmpvar_11;
  result_4.w = (result_4.w * dot (texColor_5, tmpvar_7));
  highp float tmpvar_12;
  tmpvar_12 = float((_Channel >= 3.1));
  result_4.xyz = (result_4.xyz * ((
    (tmpvar_12 * texColor_5.xyz)
   + 1.0) - tmpvar_12));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MaskTex, xlv_TEXCOORD0.zw);
  maskColor_3 = tmpvar_13;
  result_4.w = (result_4.w * maskColor_3.x);
  mediump float tmpvar_14;
  tmpvar_14 = dot (result_4.xyz, vec3(0.33, 0.34, 0.33));
  gray_2 = tmpvar_14;
  aa_1[0] = result_4.w;
  aa_1[1] = gray_2;
  result_4.w = (result_4.w * aa_1[int(_RgbAsAlpha)]);
  mediump vec4 tmpvar_15;
  tmpvar_15 = mix (vec4(1.0, 1.0, 1.0, 1.0), result_4, result_4.wwww);
  highp vec4 tmpvar_16;
  tmpvar_16 = mix (result_4, tmpvar_15, vec4(float((_SrcFactor == 0.0))));
  result_4 = tmpvar_16;
  result_4.w = (result_4.w * _AlphaCtrl);
  gl_FragData[0] = result_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "MaskTex_On" "MultiplyBlend_On" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Color;
uniform highp float _Multiplier;
uniform highp vec4 _MainTex_ST;
uniform highp float _MainTexRot;
uniform highp float _MainTexX;
uniform highp float _MainTexY;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskTexRot;
uniform highp float _MaskTexX;
uniform highp float _MaskTexY;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + ((_MainTex_ST.zw + vec2(0.5, 0.5)) - (_MainTex_ST.xy * 0.5)));
  mediump vec2 uv_3;
  uv_3 = tmpvar_1.xy;
  mediump float uvRotate_4;
  uvRotate_4 = _MainTexRot;
  mediump vec2 outUV_5;
  mediump float tmpvar_6;
  tmpvar_6 = sin((uvRotate_4 / 57.2958));
  mediump float tmpvar_7;
  tmpvar_7 = cos((uvRotate_4 / 57.2958));
  outUV_5 = (uv_3 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_8;
  tmpvar_8.x = ((outUV_5.x * tmpvar_7) - (outUV_5.y * tmpvar_6));
  tmpvar_8.y = ((outUV_5.x * tmpvar_6) + (outUV_5.y * tmpvar_7));
  outUV_5 = (tmpvar_8 + vec2(0.5, 0.5));
  tmpvar_1.xy = outUV_5;
  highp vec2 tmpvar_9;
  tmpvar_9.x = _MainTexX;
  tmpvar_9.y = _MainTexY;
  tmpvar_1.xy = (tmpvar_1.xy + (_Time.z * tmpvar_9));
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _MaskTex_ST.xy) + ((_MaskTex_ST.zw + vec2(0.5, 0.5)) - (_MaskTex_ST.xy * 0.5)));
  mediump vec2 uv_10;
  uv_10 = tmpvar_1.zw;
  mediump float uvRotate_11;
  uvRotate_11 = _MaskTexRot;
  mediump vec2 outUV_12;
  mediump float tmpvar_13;
  tmpvar_13 = sin((uvRotate_11 / 57.2958));
  mediump float tmpvar_14;
  tmpvar_14 = cos((uvRotate_11 / 57.2958));
  outUV_12 = (uv_10 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_15;
  tmpvar_15.x = ((outUV_12.x * tmpvar_14) - (outUV_12.y * tmpvar_13));
  tmpvar_15.y = ((outUV_12.x * tmpvar_13) + (outUV_12.y * tmpvar_14));
  outUV_12 = (tmpvar_15 + vec2(0.5, 0.5));
  tmpvar_1.zw = outUV_12;
  highp vec2 tmpvar_16;
  tmpvar_16.x = _MaskTexX;
  tmpvar_16.y = _MaskTexY;
  tmpvar_1.zw = (tmpvar_1.zw + (_Time.z * tmpvar_16));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_COLOR = ((_glesColor * _Color) * _Multiplier);
}


#endif
#ifdef FRAGMENT
uniform highp float _AlphaCtrl;
uniform highp float _Channel;
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform highp float _SrcFactor;
uniform highp float _RgbAsAlpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp float aa_1[2];
  highp float gray_2;
  mediump vec4 maskColor_3;
  mediump vec4 result_4;
  mediump vec4 texColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_5 = tmpvar_6;
  result_4 = xlv_COLOR;
  mediump vec4 tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = float((0.1 >= _Channel));
  highp float tmpvar_9;
  tmpvar_9 = float((_Channel >= 2.9));
  highp vec2 tmpvar_10;
  tmpvar_10.x = float((1.1 >= _Channel));
  tmpvar_10.y = float((_Channel >= 1.9));
  highp vec4 tmpvar_11;
  tmpvar_11.x = tmpvar_8;
  tmpvar_11.yz = ((1.0 - max (tmpvar_8, tmpvar_9)) * tmpvar_10);
  tmpvar_11.w = tmpvar_9;
  tmpvar_7 = tmpvar_11;
  result_4.w = (result_4.w * dot (texColor_5, tmpvar_7));
  highp float tmpvar_12;
  tmpvar_12 = float((_Channel >= 3.1));
  result_4.xyz = (result_4.xyz * ((
    (tmpvar_12 * texColor_5.xyz)
   + 1.0) - tmpvar_12));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MaskTex, xlv_TEXCOORD0.zw);
  maskColor_3 = tmpvar_13;
  result_4.w = (result_4.w * maskColor_3.x);
  mediump float tmpvar_14;
  tmpvar_14 = dot (result_4.xyz, vec3(0.33, 0.34, 0.33));
  gray_2 = tmpvar_14;
  aa_1[0] = result_4.w;
  aa_1[1] = gray_2;
  result_4.w = (result_4.w * aa_1[int(_RgbAsAlpha)]);
  mediump vec4 tmpvar_15;
  tmpvar_15 = mix (vec4(1.0, 1.0, 1.0, 1.0), result_4, result_4.wwww);
  highp vec4 tmpvar_16;
  tmpvar_16 = mix (result_4, tmpvar_15, vec4(float((_SrcFactor == 0.0))));
  result_4 = tmpvar_16;
  result_4.w = (result_4.w * _AlphaCtrl);
  gl_FragData[0] = result_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "MaskTex_On" "MultiplyBlend_On" "RT_PASS_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Color;
uniform highp float _Multiplier;
uniform highp vec4 _MainTex_ST;
uniform highp float _MainTexRot;
uniform highp float _MainTexX;
uniform highp float _MainTexY;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskTexRot;
uniform highp float _MaskTexX;
uniform highp float _MaskTexY;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + ((_MainTex_ST.zw + vec2(0.5, 0.5)) - (_MainTex_ST.xy * 0.5)));
  mediump vec2 uv_3;
  uv_3 = tmpvar_1.xy;
  mediump float uvRotate_4;
  uvRotate_4 = _MainTexRot;
  mediump vec2 outUV_5;
  mediump float tmpvar_6;
  tmpvar_6 = sin((uvRotate_4 / 57.2958));
  mediump float tmpvar_7;
  tmpvar_7 = cos((uvRotate_4 / 57.2958));
  outUV_5 = (uv_3 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_8;
  tmpvar_8.x = ((outUV_5.x * tmpvar_7) - (outUV_5.y * tmpvar_6));
  tmpvar_8.y = ((outUV_5.x * tmpvar_6) + (outUV_5.y * tmpvar_7));
  outUV_5 = (tmpvar_8 + vec2(0.5, 0.5));
  tmpvar_1.xy = outUV_5;
  highp vec2 tmpvar_9;
  tmpvar_9.x = _MainTexX;
  tmpvar_9.y = _MainTexY;
  tmpvar_1.xy = (tmpvar_1.xy + (_Time.z * tmpvar_9));
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _MaskTex_ST.xy) + ((_MaskTex_ST.zw + vec2(0.5, 0.5)) - (_MaskTex_ST.xy * 0.5)));
  mediump vec2 uv_10;
  uv_10 = tmpvar_1.zw;
  mediump float uvRotate_11;
  uvRotate_11 = _MaskTexRot;
  mediump vec2 outUV_12;
  mediump float tmpvar_13;
  tmpvar_13 = sin((uvRotate_11 / 57.2958));
  mediump float tmpvar_14;
  tmpvar_14 = cos((uvRotate_11 / 57.2958));
  outUV_12 = (uv_10 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_15;
  tmpvar_15.x = ((outUV_12.x * tmpvar_14) - (outUV_12.y * tmpvar_13));
  tmpvar_15.y = ((outUV_12.x * tmpvar_13) + (outUV_12.y * tmpvar_14));
  outUV_12 = (tmpvar_15 + vec2(0.5, 0.5));
  tmpvar_1.zw = outUV_12;
  highp vec2 tmpvar_16;
  tmpvar_16.x = _MaskTexX;
  tmpvar_16.y = _MaskTexY;
  tmpvar_1.zw = (tmpvar_1.zw + (_Time.z * tmpvar_16));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_COLOR = ((_glesColor * _Color) * _Multiplier);
}


#endif
#ifdef FRAGMENT
uniform highp float _AlphaCtrl;
uniform highp float _Channel;
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform highp float _SrcFactor;
uniform highp float _RgbAsAlpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp float aa_1[2];
  highp float gray_2;
  mediump vec4 maskColor_3;
  mediump vec4 result_4;
  mediump vec4 texColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_5 = tmpvar_6;
  result_4 = xlv_COLOR;
  mediump vec4 tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = float((0.1 >= _Channel));
  highp float tmpvar_9;
  tmpvar_9 = float((_Channel >= 2.9));
  highp vec2 tmpvar_10;
  tmpvar_10.x = float((1.1 >= _Channel));
  tmpvar_10.y = float((_Channel >= 1.9));
  highp vec4 tmpvar_11;
  tmpvar_11.x = tmpvar_8;
  tmpvar_11.yz = ((1.0 - max (tmpvar_8, tmpvar_9)) * tmpvar_10);
  tmpvar_11.w = tmpvar_9;
  tmpvar_7 = tmpvar_11;
  result_4.w = (result_4.w * dot (texColor_5, tmpvar_7));
  highp float tmpvar_12;
  tmpvar_12 = float((_Channel >= 3.1));
  result_4.xyz = (result_4.xyz * ((
    (tmpvar_12 * texColor_5.xyz)
   + 1.0) - tmpvar_12));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MaskTex, xlv_TEXCOORD0.zw);
  maskColor_3 = tmpvar_13;
  result_4.w = (result_4.w * maskColor_3.x);
  mediump float tmpvar_14;
  tmpvar_14 = dot (result_4.xyz, vec3(0.33, 0.34, 0.33));
  gray_2 = tmpvar_14;
  aa_1[0] = result_4.w;
  aa_1[1] = gray_2;
  result_4.w = (result_4.w * aa_1[int(_RgbAsAlpha)]);
  mediump vec4 tmpvar_15;
  tmpvar_15 = mix (vec4(1.0, 1.0, 1.0, 1.0), result_4, result_4.wwww);
  highp vec4 tmpvar_16;
  tmpvar_16 = mix (result_4, tmpvar_15, vec4(float((_SrcFactor == 0.0))));
  result_4 = tmpvar_16;
  result_4.w = (result_4.w * _AlphaCtrl);
  gl_FragData[0] = result_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "MaskTex_On" "MultiplyBlend_On" "RT_PASS_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Color;
uniform highp float _Multiplier;
uniform highp vec4 _MainTex_ST;
uniform highp float _MainTexRot;
uniform highp float _MainTexX;
uniform highp float _MainTexY;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskTexRot;
uniform highp float _MaskTexX;
uniform highp float _MaskTexY;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + ((_MainTex_ST.zw + vec2(0.5, 0.5)) - (_MainTex_ST.xy * 0.5)));
  mediump vec2 uv_3;
  uv_3 = tmpvar_1.xy;
  mediump float uvRotate_4;
  uvRotate_4 = _MainTexRot;
  mediump vec2 outUV_5;
  mediump float tmpvar_6;
  tmpvar_6 = sin((uvRotate_4 / 57.2958));
  mediump float tmpvar_7;
  tmpvar_7 = cos((uvRotate_4 / 57.2958));
  outUV_5 = (uv_3 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_8;
  tmpvar_8.x = ((outUV_5.x * tmpvar_7) - (outUV_5.y * tmpvar_6));
  tmpvar_8.y = ((outUV_5.x * tmpvar_6) + (outUV_5.y * tmpvar_7));
  outUV_5 = (tmpvar_8 + vec2(0.5, 0.5));
  tmpvar_1.xy = outUV_5;
  highp vec2 tmpvar_9;
  tmpvar_9.x = _MainTexX;
  tmpvar_9.y = _MainTexY;
  tmpvar_1.xy = (tmpvar_1.xy + (_Time.z * tmpvar_9));
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _MaskTex_ST.xy) + ((_MaskTex_ST.zw + vec2(0.5, 0.5)) - (_MaskTex_ST.xy * 0.5)));
  mediump vec2 uv_10;
  uv_10 = tmpvar_1.zw;
  mediump float uvRotate_11;
  uvRotate_11 = _MaskTexRot;
  mediump vec2 outUV_12;
  mediump float tmpvar_13;
  tmpvar_13 = sin((uvRotate_11 / 57.2958));
  mediump float tmpvar_14;
  tmpvar_14 = cos((uvRotate_11 / 57.2958));
  outUV_12 = (uv_10 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_15;
  tmpvar_15.x = ((outUV_12.x * tmpvar_14) - (outUV_12.y * tmpvar_13));
  tmpvar_15.y = ((outUV_12.x * tmpvar_13) + (outUV_12.y * tmpvar_14));
  outUV_12 = (tmpvar_15 + vec2(0.5, 0.5));
  tmpvar_1.zw = outUV_12;
  highp vec2 tmpvar_16;
  tmpvar_16.x = _MaskTexX;
  tmpvar_16.y = _MaskTexY;
  tmpvar_1.zw = (tmpvar_1.zw + (_Time.z * tmpvar_16));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_COLOR = ((_glesColor * _Color) * _Multiplier);
}


#endif
#ifdef FRAGMENT
uniform highp float _AlphaCtrl;
uniform highp float _Channel;
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform highp float _SrcFactor;
uniform highp float _RgbAsAlpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp float aa_1[2];
  highp float gray_2;
  mediump vec4 maskColor_3;
  mediump vec4 result_4;
  mediump vec4 texColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_5 = tmpvar_6;
  result_4 = xlv_COLOR;
  mediump vec4 tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = float((0.1 >= _Channel));
  highp float tmpvar_9;
  tmpvar_9 = float((_Channel >= 2.9));
  highp vec2 tmpvar_10;
  tmpvar_10.x = float((1.1 >= _Channel));
  tmpvar_10.y = float((_Channel >= 1.9));
  highp vec4 tmpvar_11;
  tmpvar_11.x = tmpvar_8;
  tmpvar_11.yz = ((1.0 - max (tmpvar_8, tmpvar_9)) * tmpvar_10);
  tmpvar_11.w = tmpvar_9;
  tmpvar_7 = tmpvar_11;
  result_4.w = (result_4.w * dot (texColor_5, tmpvar_7));
  highp float tmpvar_12;
  tmpvar_12 = float((_Channel >= 3.1));
  result_4.xyz = (result_4.xyz * ((
    (tmpvar_12 * texColor_5.xyz)
   + 1.0) - tmpvar_12));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MaskTex, xlv_TEXCOORD0.zw);
  maskColor_3 = tmpvar_13;
  result_4.w = (result_4.w * maskColor_3.x);
  mediump float tmpvar_14;
  tmpvar_14 = dot (result_4.xyz, vec3(0.33, 0.34, 0.33));
  gray_2 = tmpvar_14;
  aa_1[0] = result_4.w;
  aa_1[1] = gray_2;
  result_4.w = (result_4.w * aa_1[int(_RgbAsAlpha)]);
  mediump vec4 tmpvar_15;
  tmpvar_15 = mix (vec4(1.0, 1.0, 1.0, 1.0), result_4, result_4.wwww);
  highp vec4 tmpvar_16;
  tmpvar_16 = mix (result_4, tmpvar_15, vec4(float((_SrcFactor == 0.0))));
  result_4 = tmpvar_16;
  result_4.w = (result_4.w * _AlphaCtrl);
  gl_FragData[0] = result_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "MaskTex_On" "MultiplyBlend_On" "RT_PASS_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Color;
uniform highp float _Multiplier;
uniform highp vec4 _MainTex_ST;
uniform highp float _MainTexRot;
uniform highp float _MainTexX;
uniform highp float _MainTexY;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskTexRot;
uniform highp float _MaskTexX;
uniform highp float _MaskTexY;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + ((_MainTex_ST.zw + vec2(0.5, 0.5)) - (_MainTex_ST.xy * 0.5)));
  mediump vec2 uv_3;
  uv_3 = tmpvar_1.xy;
  mediump float uvRotate_4;
  uvRotate_4 = _MainTexRot;
  mediump vec2 outUV_5;
  mediump float tmpvar_6;
  tmpvar_6 = sin((uvRotate_4 / 57.2958));
  mediump float tmpvar_7;
  tmpvar_7 = cos((uvRotate_4 / 57.2958));
  outUV_5 = (uv_3 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_8;
  tmpvar_8.x = ((outUV_5.x * tmpvar_7) - (outUV_5.y * tmpvar_6));
  tmpvar_8.y = ((outUV_5.x * tmpvar_6) + (outUV_5.y * tmpvar_7));
  outUV_5 = (tmpvar_8 + vec2(0.5, 0.5));
  tmpvar_1.xy = outUV_5;
  highp vec2 tmpvar_9;
  tmpvar_9.x = _MainTexX;
  tmpvar_9.y = _MainTexY;
  tmpvar_1.xy = (tmpvar_1.xy + (_Time.z * tmpvar_9));
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _MaskTex_ST.xy) + ((_MaskTex_ST.zw + vec2(0.5, 0.5)) - (_MaskTex_ST.xy * 0.5)));
  mediump vec2 uv_10;
  uv_10 = tmpvar_1.zw;
  mediump float uvRotate_11;
  uvRotate_11 = _MaskTexRot;
  mediump vec2 outUV_12;
  mediump float tmpvar_13;
  tmpvar_13 = sin((uvRotate_11 / 57.2958));
  mediump float tmpvar_14;
  tmpvar_14 = cos((uvRotate_11 / 57.2958));
  outUV_12 = (uv_10 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_15;
  tmpvar_15.x = ((outUV_12.x * tmpvar_14) - (outUV_12.y * tmpvar_13));
  tmpvar_15.y = ((outUV_12.x * tmpvar_13) + (outUV_12.y * tmpvar_14));
  outUV_12 = (tmpvar_15 + vec2(0.5, 0.5));
  tmpvar_1.zw = outUV_12;
  highp vec2 tmpvar_16;
  tmpvar_16.x = _MaskTexX;
  tmpvar_16.y = _MaskTexY;
  tmpvar_1.zw = (tmpvar_1.zw + (_Time.z * tmpvar_16));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_COLOR = ((_glesColor * _Color) * _Multiplier);
}


#endif
#ifdef FRAGMENT
uniform highp float _AlphaCtrl;
uniform highp float _Channel;
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform highp float _SrcFactor;
uniform highp float _RgbAsAlpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp float aa_1[2];
  highp float gray_2;
  mediump vec4 maskColor_3;
  mediump vec4 result_4;
  mediump vec4 texColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_5 = tmpvar_6;
  result_4 = xlv_COLOR;
  mediump vec4 tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = float((0.1 >= _Channel));
  highp float tmpvar_9;
  tmpvar_9 = float((_Channel >= 2.9));
  highp vec2 tmpvar_10;
  tmpvar_10.x = float((1.1 >= _Channel));
  tmpvar_10.y = float((_Channel >= 1.9));
  highp vec4 tmpvar_11;
  tmpvar_11.x = tmpvar_8;
  tmpvar_11.yz = ((1.0 - max (tmpvar_8, tmpvar_9)) * tmpvar_10);
  tmpvar_11.w = tmpvar_9;
  tmpvar_7 = tmpvar_11;
  result_4.w = (result_4.w * dot (texColor_5, tmpvar_7));
  highp float tmpvar_12;
  tmpvar_12 = float((_Channel >= 3.1));
  result_4.xyz = (result_4.xyz * ((
    (tmpvar_12 * texColor_5.xyz)
   + 1.0) - tmpvar_12));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MaskTex, xlv_TEXCOORD0.zw);
  maskColor_3 = tmpvar_13;
  result_4.w = (result_4.w * maskColor_3.x);
  mediump float tmpvar_14;
  tmpvar_14 = dot (result_4.xyz, vec3(0.33, 0.34, 0.33));
  gray_2 = tmpvar_14;
  aa_1[0] = result_4.w;
  aa_1[1] = gray_2;
  result_4.w = (result_4.w * aa_1[int(_RgbAsAlpha)]);
  mediump vec4 tmpvar_15;
  tmpvar_15 = mix (vec4(1.0, 1.0, 1.0, 1.0), result_4, result_4.wwww);
  highp vec4 tmpvar_16;
  tmpvar_16 = mix (result_4, tmpvar_15, vec4(float((_SrcFactor == 0.0))));
  result_4 = tmpvar_16;
  result_4.w = (result_4.w * _AlphaCtrl);
  gl_FragData[0] = result_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "MaskTex_On" "DissolveTex_On" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Color;
uniform highp float _Multiplier;
uniform highp vec4 _MainTex_ST;
uniform highp float _MainTexRot;
uniform highp float _MainTexX;
uniform highp float _MainTexY;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskTexRot;
uniform highp float _MaskTexX;
uniform highp float _MaskTexY;
uniform highp vec4 _DissolveTex_ST;
uniform highp float _DissolveRot;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_2.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + ((_MainTex_ST.zw + vec2(0.5, 0.5)) - (_MainTex_ST.xy * 0.5)));
  mediump vec2 uv_4;
  uv_4 = tmpvar_1.xy;
  mediump float uvRotate_5;
  uvRotate_5 = _MainTexRot;
  mediump vec2 outUV_6;
  mediump float tmpvar_7;
  tmpvar_7 = sin((uvRotate_5 / 57.2958));
  mediump float tmpvar_8;
  tmpvar_8 = cos((uvRotate_5 / 57.2958));
  outUV_6 = (uv_4 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_9;
  tmpvar_9.x = ((outUV_6.x * tmpvar_8) - (outUV_6.y * tmpvar_7));
  tmpvar_9.y = ((outUV_6.x * tmpvar_7) + (outUV_6.y * tmpvar_8));
  outUV_6 = (tmpvar_9 + vec2(0.5, 0.5));
  tmpvar_1.xy = outUV_6;
  highp vec2 tmpvar_10;
  tmpvar_10.x = _MainTexX;
  tmpvar_10.y = _MainTexY;
  tmpvar_1.xy = (tmpvar_1.xy + (_Time.z * tmpvar_10));
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _MaskTex_ST.xy) + ((_MaskTex_ST.zw + vec2(0.5, 0.5)) - (_MaskTex_ST.xy * 0.5)));
  mediump vec2 uv_11;
  uv_11 = tmpvar_1.zw;
  mediump float uvRotate_12;
  uvRotate_12 = _MaskTexRot;
  mediump vec2 outUV_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin((uvRotate_12 / 57.2958));
  mediump float tmpvar_15;
  tmpvar_15 = cos((uvRotate_12 / 57.2958));
  outUV_13 = (uv_11 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_16;
  tmpvar_16.x = ((outUV_13.x * tmpvar_15) - (outUV_13.y * tmpvar_14));
  tmpvar_16.y = ((outUV_13.x * tmpvar_14) + (outUV_13.y * tmpvar_15));
  outUV_13 = (tmpvar_16 + vec2(0.5, 0.5));
  tmpvar_1.zw = outUV_13;
  highp vec2 tmpvar_17;
  tmpvar_17.x = _MaskTexX;
  tmpvar_17.y = _MaskTexY;
  tmpvar_1.zw = (tmpvar_1.zw + (_Time.z * tmpvar_17));
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _DissolveTex_ST.xy) + ((_DissolveTex_ST.zw + vec2(0.5, 0.5)) - (_DissolveTex_ST.xy * 0.5)));
  mediump vec2 uv_18;
  uv_18 = tmpvar_2.xy;
  mediump float uvRotate_19;
  uvRotate_19 = _DissolveRot;
  mediump vec2 outUV_20;
  mediump float tmpvar_21;
  tmpvar_21 = sin((uvRotate_19 / 57.2958));
  mediump float tmpvar_22;
  tmpvar_22 = cos((uvRotate_19 / 57.2958));
  outUV_20 = (uv_18 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_23;
  tmpvar_23.x = ((outUV_20.x * tmpvar_22) - (outUV_20.y * tmpvar_21));
  tmpvar_23.y = ((outUV_20.x * tmpvar_21) + (outUV_20.y * tmpvar_22));
  outUV_20 = (tmpvar_23 + vec2(0.5, 0.5));
  tmpvar_2.xy = outUV_20;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = ((_glesColor * _Color) * _Multiplier);
}


#endif
#ifdef FRAGMENT
uniform highp float _AlphaCtrl;
uniform highp float _Channel;
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform sampler2D _DissolveTex;
uniform highp float _Dissolve;
uniform mediump vec4 _DissolveColor1;
uniform mediump vec4 _DissolveColor2;
uniform highp float _RgbAsAlpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp float aa_1[2];
  highp float gray_2;
  mediump vec4 maskColor_3;
  mediump vec4 dissColor_4;
  mediump vec4 result_5;
  mediump vec4 texColor_6;
  mediump vec4 dissolveColor_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_DissolveTex, xlv_TEXCOORD1.xy);
  dissolveColor_7 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = ((dissolveColor_7.x + (
    (_Dissolve * -1.2)
   + 0.6)) - 0.5);
  if ((tmpvar_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_6 = tmpvar_10;
  result_5 = xlv_COLOR;
  mediump vec4 tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = float((0.1 >= _Channel));
  highp float tmpvar_13;
  tmpvar_13 = float((_Channel >= 2.9));
  highp vec2 tmpvar_14;
  tmpvar_14.x = float((1.1 >= _Channel));
  tmpvar_14.y = float((_Channel >= 1.9));
  highp vec4 tmpvar_15;
  tmpvar_15.x = tmpvar_12;
  tmpvar_15.yz = ((1.0 - max (tmpvar_12, tmpvar_13)) * tmpvar_14);
  tmpvar_15.w = tmpvar_13;
  tmpvar_11 = tmpvar_15;
  result_5.w = (result_5.w * dot (texColor_6, tmpvar_11));
  highp float tmpvar_16;
  tmpvar_16 = float((_Channel >= 3.1));
  result_5.xyz = (result_5.xyz * ((
    (tmpvar_16 * texColor_6.xyz)
   + 1.0) - tmpvar_16));
  highp float tmpvar_17;
  tmpvar_17 = clamp ((tmpvar_9 * 3.0), 0.0, 1.0);
  highp vec4 tmpvar_18;
  tmpvar_18 = mix (_DissolveColor1, _DissolveColor2, vec4(float((tmpvar_17 > 0.2))));
  dissColor_4 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = mix (dissColor_4, result_5, vec4(clamp ((tmpvar_17 + 
    float((_Dissolve < 0.001))
  ), 0.0, 1.0)));
  result_5.xyz = tmpvar_19.xyz;
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_MaskTex, xlv_TEXCOORD0.zw);
  maskColor_3 = tmpvar_20;
  result_5.w = (result_5.w * maskColor_3.x);
  mediump float tmpvar_21;
  tmpvar_21 = dot (result_5.xyz, vec3(0.33, 0.34, 0.33));
  gray_2 = tmpvar_21;
  aa_1[0] = result_5.w;
  aa_1[1] = gray_2;
  result_5.w = (result_5.w * aa_1[int(_RgbAsAlpha)]);
  result_5.w = (result_5.w * _AlphaCtrl);
  gl_FragData[0] = result_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "MaskTex_On" "DissolveTex_On" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Color;
uniform highp float _Multiplier;
uniform highp vec4 _MainTex_ST;
uniform highp float _MainTexRot;
uniform highp float _MainTexX;
uniform highp float _MainTexY;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskTexRot;
uniform highp float _MaskTexX;
uniform highp float _MaskTexY;
uniform highp vec4 _DissolveTex_ST;
uniform highp float _DissolveRot;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_2.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + ((_MainTex_ST.zw + vec2(0.5, 0.5)) - (_MainTex_ST.xy * 0.5)));
  mediump vec2 uv_4;
  uv_4 = tmpvar_1.xy;
  mediump float uvRotate_5;
  uvRotate_5 = _MainTexRot;
  mediump vec2 outUV_6;
  mediump float tmpvar_7;
  tmpvar_7 = sin((uvRotate_5 / 57.2958));
  mediump float tmpvar_8;
  tmpvar_8 = cos((uvRotate_5 / 57.2958));
  outUV_6 = (uv_4 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_9;
  tmpvar_9.x = ((outUV_6.x * tmpvar_8) - (outUV_6.y * tmpvar_7));
  tmpvar_9.y = ((outUV_6.x * tmpvar_7) + (outUV_6.y * tmpvar_8));
  outUV_6 = (tmpvar_9 + vec2(0.5, 0.5));
  tmpvar_1.xy = outUV_6;
  highp vec2 tmpvar_10;
  tmpvar_10.x = _MainTexX;
  tmpvar_10.y = _MainTexY;
  tmpvar_1.xy = (tmpvar_1.xy + (_Time.z * tmpvar_10));
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _MaskTex_ST.xy) + ((_MaskTex_ST.zw + vec2(0.5, 0.5)) - (_MaskTex_ST.xy * 0.5)));
  mediump vec2 uv_11;
  uv_11 = tmpvar_1.zw;
  mediump float uvRotate_12;
  uvRotate_12 = _MaskTexRot;
  mediump vec2 outUV_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin((uvRotate_12 / 57.2958));
  mediump float tmpvar_15;
  tmpvar_15 = cos((uvRotate_12 / 57.2958));
  outUV_13 = (uv_11 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_16;
  tmpvar_16.x = ((outUV_13.x * tmpvar_15) - (outUV_13.y * tmpvar_14));
  tmpvar_16.y = ((outUV_13.x * tmpvar_14) + (outUV_13.y * tmpvar_15));
  outUV_13 = (tmpvar_16 + vec2(0.5, 0.5));
  tmpvar_1.zw = outUV_13;
  highp vec2 tmpvar_17;
  tmpvar_17.x = _MaskTexX;
  tmpvar_17.y = _MaskTexY;
  tmpvar_1.zw = (tmpvar_1.zw + (_Time.z * tmpvar_17));
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _DissolveTex_ST.xy) + ((_DissolveTex_ST.zw + vec2(0.5, 0.5)) - (_DissolveTex_ST.xy * 0.5)));
  mediump vec2 uv_18;
  uv_18 = tmpvar_2.xy;
  mediump float uvRotate_19;
  uvRotate_19 = _DissolveRot;
  mediump vec2 outUV_20;
  mediump float tmpvar_21;
  tmpvar_21 = sin((uvRotate_19 / 57.2958));
  mediump float tmpvar_22;
  tmpvar_22 = cos((uvRotate_19 / 57.2958));
  outUV_20 = (uv_18 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_23;
  tmpvar_23.x = ((outUV_20.x * tmpvar_22) - (outUV_20.y * tmpvar_21));
  tmpvar_23.y = ((outUV_20.x * tmpvar_21) + (outUV_20.y * tmpvar_22));
  outUV_20 = (tmpvar_23 + vec2(0.5, 0.5));
  tmpvar_2.xy = outUV_20;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = ((_glesColor * _Color) * _Multiplier);
}


#endif
#ifdef FRAGMENT
uniform highp float _AlphaCtrl;
uniform highp float _Channel;
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform sampler2D _DissolveTex;
uniform highp float _Dissolve;
uniform mediump vec4 _DissolveColor1;
uniform mediump vec4 _DissolveColor2;
uniform highp float _RgbAsAlpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp float aa_1[2];
  highp float gray_2;
  mediump vec4 maskColor_3;
  mediump vec4 dissColor_4;
  mediump vec4 result_5;
  mediump vec4 texColor_6;
  mediump vec4 dissolveColor_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_DissolveTex, xlv_TEXCOORD1.xy);
  dissolveColor_7 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = ((dissolveColor_7.x + (
    (_Dissolve * -1.2)
   + 0.6)) - 0.5);
  if ((tmpvar_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_6 = tmpvar_10;
  result_5 = xlv_COLOR;
  mediump vec4 tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = float((0.1 >= _Channel));
  highp float tmpvar_13;
  tmpvar_13 = float((_Channel >= 2.9));
  highp vec2 tmpvar_14;
  tmpvar_14.x = float((1.1 >= _Channel));
  tmpvar_14.y = float((_Channel >= 1.9));
  highp vec4 tmpvar_15;
  tmpvar_15.x = tmpvar_12;
  tmpvar_15.yz = ((1.0 - max (tmpvar_12, tmpvar_13)) * tmpvar_14);
  tmpvar_15.w = tmpvar_13;
  tmpvar_11 = tmpvar_15;
  result_5.w = (result_5.w * dot (texColor_6, tmpvar_11));
  highp float tmpvar_16;
  tmpvar_16 = float((_Channel >= 3.1));
  result_5.xyz = (result_5.xyz * ((
    (tmpvar_16 * texColor_6.xyz)
   + 1.0) - tmpvar_16));
  highp float tmpvar_17;
  tmpvar_17 = clamp ((tmpvar_9 * 3.0), 0.0, 1.0);
  highp vec4 tmpvar_18;
  tmpvar_18 = mix (_DissolveColor1, _DissolveColor2, vec4(float((tmpvar_17 > 0.2))));
  dissColor_4 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = mix (dissColor_4, result_5, vec4(clamp ((tmpvar_17 + 
    float((_Dissolve < 0.001))
  ), 0.0, 1.0)));
  result_5.xyz = tmpvar_19.xyz;
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_MaskTex, xlv_TEXCOORD0.zw);
  maskColor_3 = tmpvar_20;
  result_5.w = (result_5.w * maskColor_3.x);
  mediump float tmpvar_21;
  tmpvar_21 = dot (result_5.xyz, vec3(0.33, 0.34, 0.33));
  gray_2 = tmpvar_21;
  aa_1[0] = result_5.w;
  aa_1[1] = gray_2;
  result_5.w = (result_5.w * aa_1[int(_RgbAsAlpha)]);
  result_5.w = (result_5.w * _AlphaCtrl);
  gl_FragData[0] = result_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "MaskTex_On" "DissolveTex_On" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Color;
uniform highp float _Multiplier;
uniform highp vec4 _MainTex_ST;
uniform highp float _MainTexRot;
uniform highp float _MainTexX;
uniform highp float _MainTexY;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskTexRot;
uniform highp float _MaskTexX;
uniform highp float _MaskTexY;
uniform highp vec4 _DissolveTex_ST;
uniform highp float _DissolveRot;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_2.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + ((_MainTex_ST.zw + vec2(0.5, 0.5)) - (_MainTex_ST.xy * 0.5)));
  mediump vec2 uv_4;
  uv_4 = tmpvar_1.xy;
  mediump float uvRotate_5;
  uvRotate_5 = _MainTexRot;
  mediump vec2 outUV_6;
  mediump float tmpvar_7;
  tmpvar_7 = sin((uvRotate_5 / 57.2958));
  mediump float tmpvar_8;
  tmpvar_8 = cos((uvRotate_5 / 57.2958));
  outUV_6 = (uv_4 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_9;
  tmpvar_9.x = ((outUV_6.x * tmpvar_8) - (outUV_6.y * tmpvar_7));
  tmpvar_9.y = ((outUV_6.x * tmpvar_7) + (outUV_6.y * tmpvar_8));
  outUV_6 = (tmpvar_9 + vec2(0.5, 0.5));
  tmpvar_1.xy = outUV_6;
  highp vec2 tmpvar_10;
  tmpvar_10.x = _MainTexX;
  tmpvar_10.y = _MainTexY;
  tmpvar_1.xy = (tmpvar_1.xy + (_Time.z * tmpvar_10));
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _MaskTex_ST.xy) + ((_MaskTex_ST.zw + vec2(0.5, 0.5)) - (_MaskTex_ST.xy * 0.5)));
  mediump vec2 uv_11;
  uv_11 = tmpvar_1.zw;
  mediump float uvRotate_12;
  uvRotate_12 = _MaskTexRot;
  mediump vec2 outUV_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin((uvRotate_12 / 57.2958));
  mediump float tmpvar_15;
  tmpvar_15 = cos((uvRotate_12 / 57.2958));
  outUV_13 = (uv_11 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_16;
  tmpvar_16.x = ((outUV_13.x * tmpvar_15) - (outUV_13.y * tmpvar_14));
  tmpvar_16.y = ((outUV_13.x * tmpvar_14) + (outUV_13.y * tmpvar_15));
  outUV_13 = (tmpvar_16 + vec2(0.5, 0.5));
  tmpvar_1.zw = outUV_13;
  highp vec2 tmpvar_17;
  tmpvar_17.x = _MaskTexX;
  tmpvar_17.y = _MaskTexY;
  tmpvar_1.zw = (tmpvar_1.zw + (_Time.z * tmpvar_17));
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _DissolveTex_ST.xy) + ((_DissolveTex_ST.zw + vec2(0.5, 0.5)) - (_DissolveTex_ST.xy * 0.5)));
  mediump vec2 uv_18;
  uv_18 = tmpvar_2.xy;
  mediump float uvRotate_19;
  uvRotate_19 = _DissolveRot;
  mediump vec2 outUV_20;
  mediump float tmpvar_21;
  tmpvar_21 = sin((uvRotate_19 / 57.2958));
  mediump float tmpvar_22;
  tmpvar_22 = cos((uvRotate_19 / 57.2958));
  outUV_20 = (uv_18 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_23;
  tmpvar_23.x = ((outUV_20.x * tmpvar_22) - (outUV_20.y * tmpvar_21));
  tmpvar_23.y = ((outUV_20.x * tmpvar_21) + (outUV_20.y * tmpvar_22));
  outUV_20 = (tmpvar_23 + vec2(0.5, 0.5));
  tmpvar_2.xy = outUV_20;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = ((_glesColor * _Color) * _Multiplier);
}


#endif
#ifdef FRAGMENT
uniform highp float _AlphaCtrl;
uniform highp float _Channel;
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform sampler2D _DissolveTex;
uniform highp float _Dissolve;
uniform mediump vec4 _DissolveColor1;
uniform mediump vec4 _DissolveColor2;
uniform highp float _RgbAsAlpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp float aa_1[2];
  highp float gray_2;
  mediump vec4 maskColor_3;
  mediump vec4 dissColor_4;
  mediump vec4 result_5;
  mediump vec4 texColor_6;
  mediump vec4 dissolveColor_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_DissolveTex, xlv_TEXCOORD1.xy);
  dissolveColor_7 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = ((dissolveColor_7.x + (
    (_Dissolve * -1.2)
   + 0.6)) - 0.5);
  if ((tmpvar_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_6 = tmpvar_10;
  result_5 = xlv_COLOR;
  mediump vec4 tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = float((0.1 >= _Channel));
  highp float tmpvar_13;
  tmpvar_13 = float((_Channel >= 2.9));
  highp vec2 tmpvar_14;
  tmpvar_14.x = float((1.1 >= _Channel));
  tmpvar_14.y = float((_Channel >= 1.9));
  highp vec4 tmpvar_15;
  tmpvar_15.x = tmpvar_12;
  tmpvar_15.yz = ((1.0 - max (tmpvar_12, tmpvar_13)) * tmpvar_14);
  tmpvar_15.w = tmpvar_13;
  tmpvar_11 = tmpvar_15;
  result_5.w = (result_5.w * dot (texColor_6, tmpvar_11));
  highp float tmpvar_16;
  tmpvar_16 = float((_Channel >= 3.1));
  result_5.xyz = (result_5.xyz * ((
    (tmpvar_16 * texColor_6.xyz)
   + 1.0) - tmpvar_16));
  highp float tmpvar_17;
  tmpvar_17 = clamp ((tmpvar_9 * 3.0), 0.0, 1.0);
  highp vec4 tmpvar_18;
  tmpvar_18 = mix (_DissolveColor1, _DissolveColor2, vec4(float((tmpvar_17 > 0.2))));
  dissColor_4 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = mix (dissColor_4, result_5, vec4(clamp ((tmpvar_17 + 
    float((_Dissolve < 0.001))
  ), 0.0, 1.0)));
  result_5.xyz = tmpvar_19.xyz;
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_MaskTex, xlv_TEXCOORD0.zw);
  maskColor_3 = tmpvar_20;
  result_5.w = (result_5.w * maskColor_3.x);
  mediump float tmpvar_21;
  tmpvar_21 = dot (result_5.xyz, vec3(0.33, 0.34, 0.33));
  gray_2 = tmpvar_21;
  aa_1[0] = result_5.w;
  aa_1[1] = gray_2;
  result_5.w = (result_5.w * aa_1[int(_RgbAsAlpha)]);
  result_5.w = (result_5.w * _AlphaCtrl);
  gl_FragData[0] = result_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "MaskTex_On" "DissolveTex_On" "RT_PASS_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Color;
uniform highp float _Multiplier;
uniform highp vec4 _MainTex_ST;
uniform highp float _MainTexRot;
uniform highp float _MainTexX;
uniform highp float _MainTexY;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskTexRot;
uniform highp float _MaskTexX;
uniform highp float _MaskTexY;
uniform highp vec4 _DissolveTex_ST;
uniform highp float _DissolveRot;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_2.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + ((_MainTex_ST.zw + vec2(0.5, 0.5)) - (_MainTex_ST.xy * 0.5)));
  mediump vec2 uv_4;
  uv_4 = tmpvar_1.xy;
  mediump float uvRotate_5;
  uvRotate_5 = _MainTexRot;
  mediump vec2 outUV_6;
  mediump float tmpvar_7;
  tmpvar_7 = sin((uvRotate_5 / 57.2958));
  mediump float tmpvar_8;
  tmpvar_8 = cos((uvRotate_5 / 57.2958));
  outUV_6 = (uv_4 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_9;
  tmpvar_9.x = ((outUV_6.x * tmpvar_8) - (outUV_6.y * tmpvar_7));
  tmpvar_9.y = ((outUV_6.x * tmpvar_7) + (outUV_6.y * tmpvar_8));
  outUV_6 = (tmpvar_9 + vec2(0.5, 0.5));
  tmpvar_1.xy = outUV_6;
  highp vec2 tmpvar_10;
  tmpvar_10.x = _MainTexX;
  tmpvar_10.y = _MainTexY;
  tmpvar_1.xy = (tmpvar_1.xy + (_Time.z * tmpvar_10));
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _MaskTex_ST.xy) + ((_MaskTex_ST.zw + vec2(0.5, 0.5)) - (_MaskTex_ST.xy * 0.5)));
  mediump vec2 uv_11;
  uv_11 = tmpvar_1.zw;
  mediump float uvRotate_12;
  uvRotate_12 = _MaskTexRot;
  mediump vec2 outUV_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin((uvRotate_12 / 57.2958));
  mediump float tmpvar_15;
  tmpvar_15 = cos((uvRotate_12 / 57.2958));
  outUV_13 = (uv_11 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_16;
  tmpvar_16.x = ((outUV_13.x * tmpvar_15) - (outUV_13.y * tmpvar_14));
  tmpvar_16.y = ((outUV_13.x * tmpvar_14) + (outUV_13.y * tmpvar_15));
  outUV_13 = (tmpvar_16 + vec2(0.5, 0.5));
  tmpvar_1.zw = outUV_13;
  highp vec2 tmpvar_17;
  tmpvar_17.x = _MaskTexX;
  tmpvar_17.y = _MaskTexY;
  tmpvar_1.zw = (tmpvar_1.zw + (_Time.z * tmpvar_17));
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _DissolveTex_ST.xy) + ((_DissolveTex_ST.zw + vec2(0.5, 0.5)) - (_DissolveTex_ST.xy * 0.5)));
  mediump vec2 uv_18;
  uv_18 = tmpvar_2.xy;
  mediump float uvRotate_19;
  uvRotate_19 = _DissolveRot;
  mediump vec2 outUV_20;
  mediump float tmpvar_21;
  tmpvar_21 = sin((uvRotate_19 / 57.2958));
  mediump float tmpvar_22;
  tmpvar_22 = cos((uvRotate_19 / 57.2958));
  outUV_20 = (uv_18 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_23;
  tmpvar_23.x = ((outUV_20.x * tmpvar_22) - (outUV_20.y * tmpvar_21));
  tmpvar_23.y = ((outUV_20.x * tmpvar_21) + (outUV_20.y * tmpvar_22));
  outUV_20 = (tmpvar_23 + vec2(0.5, 0.5));
  tmpvar_2.xy = outUV_20;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = ((_glesColor * _Color) * _Multiplier);
}


#endif
#ifdef FRAGMENT
uniform highp float _AlphaCtrl;
uniform highp float _Channel;
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform sampler2D _DissolveTex;
uniform highp float _Dissolve;
uniform mediump vec4 _DissolveColor1;
uniform mediump vec4 _DissolveColor2;
uniform highp float _RgbAsAlpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp float aa_1[2];
  highp float gray_2;
  mediump vec4 maskColor_3;
  mediump vec4 dissColor_4;
  mediump vec4 result_5;
  mediump vec4 texColor_6;
  mediump vec4 dissolveColor_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_DissolveTex, xlv_TEXCOORD1.xy);
  dissolveColor_7 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = ((dissolveColor_7.x + (
    (_Dissolve * -1.2)
   + 0.6)) - 0.5);
  if ((tmpvar_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_6 = tmpvar_10;
  result_5 = xlv_COLOR;
  mediump vec4 tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = float((0.1 >= _Channel));
  highp float tmpvar_13;
  tmpvar_13 = float((_Channel >= 2.9));
  highp vec2 tmpvar_14;
  tmpvar_14.x = float((1.1 >= _Channel));
  tmpvar_14.y = float((_Channel >= 1.9));
  highp vec4 tmpvar_15;
  tmpvar_15.x = tmpvar_12;
  tmpvar_15.yz = ((1.0 - max (tmpvar_12, tmpvar_13)) * tmpvar_14);
  tmpvar_15.w = tmpvar_13;
  tmpvar_11 = tmpvar_15;
  result_5.w = (result_5.w * dot (texColor_6, tmpvar_11));
  highp float tmpvar_16;
  tmpvar_16 = float((_Channel >= 3.1));
  result_5.xyz = (result_5.xyz * ((
    (tmpvar_16 * texColor_6.xyz)
   + 1.0) - tmpvar_16));
  highp float tmpvar_17;
  tmpvar_17 = clamp ((tmpvar_9 * 3.0), 0.0, 1.0);
  highp vec4 tmpvar_18;
  tmpvar_18 = mix (_DissolveColor1, _DissolveColor2, vec4(float((tmpvar_17 > 0.2))));
  dissColor_4 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = mix (dissColor_4, result_5, vec4(clamp ((tmpvar_17 + 
    float((_Dissolve < 0.001))
  ), 0.0, 1.0)));
  result_5.xyz = tmpvar_19.xyz;
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_MaskTex, xlv_TEXCOORD0.zw);
  maskColor_3 = tmpvar_20;
  result_5.w = (result_5.w * maskColor_3.x);
  mediump float tmpvar_21;
  tmpvar_21 = dot (result_5.xyz, vec3(0.33, 0.34, 0.33));
  gray_2 = tmpvar_21;
  aa_1[0] = result_5.w;
  aa_1[1] = gray_2;
  result_5.w = (result_5.w * aa_1[int(_RgbAsAlpha)]);
  result_5.w = (result_5.w * _AlphaCtrl);
  gl_FragData[0] = result_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "MaskTex_On" "DissolveTex_On" "RT_PASS_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Color;
uniform highp float _Multiplier;
uniform highp vec4 _MainTex_ST;
uniform highp float _MainTexRot;
uniform highp float _MainTexX;
uniform highp float _MainTexY;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskTexRot;
uniform highp float _MaskTexX;
uniform highp float _MaskTexY;
uniform highp vec4 _DissolveTex_ST;
uniform highp float _DissolveRot;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_2.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + ((_MainTex_ST.zw + vec2(0.5, 0.5)) - (_MainTex_ST.xy * 0.5)));
  mediump vec2 uv_4;
  uv_4 = tmpvar_1.xy;
  mediump float uvRotate_5;
  uvRotate_5 = _MainTexRot;
  mediump vec2 outUV_6;
  mediump float tmpvar_7;
  tmpvar_7 = sin((uvRotate_5 / 57.2958));
  mediump float tmpvar_8;
  tmpvar_8 = cos((uvRotate_5 / 57.2958));
  outUV_6 = (uv_4 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_9;
  tmpvar_9.x = ((outUV_6.x * tmpvar_8) - (outUV_6.y * tmpvar_7));
  tmpvar_9.y = ((outUV_6.x * tmpvar_7) + (outUV_6.y * tmpvar_8));
  outUV_6 = (tmpvar_9 + vec2(0.5, 0.5));
  tmpvar_1.xy = outUV_6;
  highp vec2 tmpvar_10;
  tmpvar_10.x = _MainTexX;
  tmpvar_10.y = _MainTexY;
  tmpvar_1.xy = (tmpvar_1.xy + (_Time.z * tmpvar_10));
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _MaskTex_ST.xy) + ((_MaskTex_ST.zw + vec2(0.5, 0.5)) - (_MaskTex_ST.xy * 0.5)));
  mediump vec2 uv_11;
  uv_11 = tmpvar_1.zw;
  mediump float uvRotate_12;
  uvRotate_12 = _MaskTexRot;
  mediump vec2 outUV_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin((uvRotate_12 / 57.2958));
  mediump float tmpvar_15;
  tmpvar_15 = cos((uvRotate_12 / 57.2958));
  outUV_13 = (uv_11 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_16;
  tmpvar_16.x = ((outUV_13.x * tmpvar_15) - (outUV_13.y * tmpvar_14));
  tmpvar_16.y = ((outUV_13.x * tmpvar_14) + (outUV_13.y * tmpvar_15));
  outUV_13 = (tmpvar_16 + vec2(0.5, 0.5));
  tmpvar_1.zw = outUV_13;
  highp vec2 tmpvar_17;
  tmpvar_17.x = _MaskTexX;
  tmpvar_17.y = _MaskTexY;
  tmpvar_1.zw = (tmpvar_1.zw + (_Time.z * tmpvar_17));
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _DissolveTex_ST.xy) + ((_DissolveTex_ST.zw + vec2(0.5, 0.5)) - (_DissolveTex_ST.xy * 0.5)));
  mediump vec2 uv_18;
  uv_18 = tmpvar_2.xy;
  mediump float uvRotate_19;
  uvRotate_19 = _DissolveRot;
  mediump vec2 outUV_20;
  mediump float tmpvar_21;
  tmpvar_21 = sin((uvRotate_19 / 57.2958));
  mediump float tmpvar_22;
  tmpvar_22 = cos((uvRotate_19 / 57.2958));
  outUV_20 = (uv_18 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_23;
  tmpvar_23.x = ((outUV_20.x * tmpvar_22) - (outUV_20.y * tmpvar_21));
  tmpvar_23.y = ((outUV_20.x * tmpvar_21) + (outUV_20.y * tmpvar_22));
  outUV_20 = (tmpvar_23 + vec2(0.5, 0.5));
  tmpvar_2.xy = outUV_20;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = ((_glesColor * _Color) * _Multiplier);
}


#endif
#ifdef FRAGMENT
uniform highp float _AlphaCtrl;
uniform highp float _Channel;
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform sampler2D _DissolveTex;
uniform highp float _Dissolve;
uniform mediump vec4 _DissolveColor1;
uniform mediump vec4 _DissolveColor2;
uniform highp float _RgbAsAlpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp float aa_1[2];
  highp float gray_2;
  mediump vec4 maskColor_3;
  mediump vec4 dissColor_4;
  mediump vec4 result_5;
  mediump vec4 texColor_6;
  mediump vec4 dissolveColor_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_DissolveTex, xlv_TEXCOORD1.xy);
  dissolveColor_7 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = ((dissolveColor_7.x + (
    (_Dissolve * -1.2)
   + 0.6)) - 0.5);
  if ((tmpvar_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_6 = tmpvar_10;
  result_5 = xlv_COLOR;
  mediump vec4 tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = float((0.1 >= _Channel));
  highp float tmpvar_13;
  tmpvar_13 = float((_Channel >= 2.9));
  highp vec2 tmpvar_14;
  tmpvar_14.x = float((1.1 >= _Channel));
  tmpvar_14.y = float((_Channel >= 1.9));
  highp vec4 tmpvar_15;
  tmpvar_15.x = tmpvar_12;
  tmpvar_15.yz = ((1.0 - max (tmpvar_12, tmpvar_13)) * tmpvar_14);
  tmpvar_15.w = tmpvar_13;
  tmpvar_11 = tmpvar_15;
  result_5.w = (result_5.w * dot (texColor_6, tmpvar_11));
  highp float tmpvar_16;
  tmpvar_16 = float((_Channel >= 3.1));
  result_5.xyz = (result_5.xyz * ((
    (tmpvar_16 * texColor_6.xyz)
   + 1.0) - tmpvar_16));
  highp float tmpvar_17;
  tmpvar_17 = clamp ((tmpvar_9 * 3.0), 0.0, 1.0);
  highp vec4 tmpvar_18;
  tmpvar_18 = mix (_DissolveColor1, _DissolveColor2, vec4(float((tmpvar_17 > 0.2))));
  dissColor_4 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = mix (dissColor_4, result_5, vec4(clamp ((tmpvar_17 + 
    float((_Dissolve < 0.001))
  ), 0.0, 1.0)));
  result_5.xyz = tmpvar_19.xyz;
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_MaskTex, xlv_TEXCOORD0.zw);
  maskColor_3 = tmpvar_20;
  result_5.w = (result_5.w * maskColor_3.x);
  mediump float tmpvar_21;
  tmpvar_21 = dot (result_5.xyz, vec3(0.33, 0.34, 0.33));
  gray_2 = tmpvar_21;
  aa_1[0] = result_5.w;
  aa_1[1] = gray_2;
  result_5.w = (result_5.w * aa_1[int(_RgbAsAlpha)]);
  result_5.w = (result_5.w * _AlphaCtrl);
  gl_FragData[0] = result_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "MaskTex_On" "DissolveTex_On" "RT_PASS_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Color;
uniform highp float _Multiplier;
uniform highp vec4 _MainTex_ST;
uniform highp float _MainTexRot;
uniform highp float _MainTexX;
uniform highp float _MainTexY;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskTexRot;
uniform highp float _MaskTexX;
uniform highp float _MaskTexY;
uniform highp vec4 _DissolveTex_ST;
uniform highp float _DissolveRot;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_2.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + ((_MainTex_ST.zw + vec2(0.5, 0.5)) - (_MainTex_ST.xy * 0.5)));
  mediump vec2 uv_4;
  uv_4 = tmpvar_1.xy;
  mediump float uvRotate_5;
  uvRotate_5 = _MainTexRot;
  mediump vec2 outUV_6;
  mediump float tmpvar_7;
  tmpvar_7 = sin((uvRotate_5 / 57.2958));
  mediump float tmpvar_8;
  tmpvar_8 = cos((uvRotate_5 / 57.2958));
  outUV_6 = (uv_4 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_9;
  tmpvar_9.x = ((outUV_6.x * tmpvar_8) - (outUV_6.y * tmpvar_7));
  tmpvar_9.y = ((outUV_6.x * tmpvar_7) + (outUV_6.y * tmpvar_8));
  outUV_6 = (tmpvar_9 + vec2(0.5, 0.5));
  tmpvar_1.xy = outUV_6;
  highp vec2 tmpvar_10;
  tmpvar_10.x = _MainTexX;
  tmpvar_10.y = _MainTexY;
  tmpvar_1.xy = (tmpvar_1.xy + (_Time.z * tmpvar_10));
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _MaskTex_ST.xy) + ((_MaskTex_ST.zw + vec2(0.5, 0.5)) - (_MaskTex_ST.xy * 0.5)));
  mediump vec2 uv_11;
  uv_11 = tmpvar_1.zw;
  mediump float uvRotate_12;
  uvRotate_12 = _MaskTexRot;
  mediump vec2 outUV_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin((uvRotate_12 / 57.2958));
  mediump float tmpvar_15;
  tmpvar_15 = cos((uvRotate_12 / 57.2958));
  outUV_13 = (uv_11 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_16;
  tmpvar_16.x = ((outUV_13.x * tmpvar_15) - (outUV_13.y * tmpvar_14));
  tmpvar_16.y = ((outUV_13.x * tmpvar_14) + (outUV_13.y * tmpvar_15));
  outUV_13 = (tmpvar_16 + vec2(0.5, 0.5));
  tmpvar_1.zw = outUV_13;
  highp vec2 tmpvar_17;
  tmpvar_17.x = _MaskTexX;
  tmpvar_17.y = _MaskTexY;
  tmpvar_1.zw = (tmpvar_1.zw + (_Time.z * tmpvar_17));
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _DissolveTex_ST.xy) + ((_DissolveTex_ST.zw + vec2(0.5, 0.5)) - (_DissolveTex_ST.xy * 0.5)));
  mediump vec2 uv_18;
  uv_18 = tmpvar_2.xy;
  mediump float uvRotate_19;
  uvRotate_19 = _DissolveRot;
  mediump vec2 outUV_20;
  mediump float tmpvar_21;
  tmpvar_21 = sin((uvRotate_19 / 57.2958));
  mediump float tmpvar_22;
  tmpvar_22 = cos((uvRotate_19 / 57.2958));
  outUV_20 = (uv_18 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_23;
  tmpvar_23.x = ((outUV_20.x * tmpvar_22) - (outUV_20.y * tmpvar_21));
  tmpvar_23.y = ((outUV_20.x * tmpvar_21) + (outUV_20.y * tmpvar_22));
  outUV_20 = (tmpvar_23 + vec2(0.5, 0.5));
  tmpvar_2.xy = outUV_20;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = ((_glesColor * _Color) * _Multiplier);
}


#endif
#ifdef FRAGMENT
uniform highp float _AlphaCtrl;
uniform highp float _Channel;
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform sampler2D _DissolveTex;
uniform highp float _Dissolve;
uniform mediump vec4 _DissolveColor1;
uniform mediump vec4 _DissolveColor2;
uniform highp float _RgbAsAlpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp float aa_1[2];
  highp float gray_2;
  mediump vec4 maskColor_3;
  mediump vec4 dissColor_4;
  mediump vec4 result_5;
  mediump vec4 texColor_6;
  mediump vec4 dissolveColor_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_DissolveTex, xlv_TEXCOORD1.xy);
  dissolveColor_7 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = ((dissolveColor_7.x + (
    (_Dissolve * -1.2)
   + 0.6)) - 0.5);
  if ((tmpvar_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_6 = tmpvar_10;
  result_5 = xlv_COLOR;
  mediump vec4 tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = float((0.1 >= _Channel));
  highp float tmpvar_13;
  tmpvar_13 = float((_Channel >= 2.9));
  highp vec2 tmpvar_14;
  tmpvar_14.x = float((1.1 >= _Channel));
  tmpvar_14.y = float((_Channel >= 1.9));
  highp vec4 tmpvar_15;
  tmpvar_15.x = tmpvar_12;
  tmpvar_15.yz = ((1.0 - max (tmpvar_12, tmpvar_13)) * tmpvar_14);
  tmpvar_15.w = tmpvar_13;
  tmpvar_11 = tmpvar_15;
  result_5.w = (result_5.w * dot (texColor_6, tmpvar_11));
  highp float tmpvar_16;
  tmpvar_16 = float((_Channel >= 3.1));
  result_5.xyz = (result_5.xyz * ((
    (tmpvar_16 * texColor_6.xyz)
   + 1.0) - tmpvar_16));
  highp float tmpvar_17;
  tmpvar_17 = clamp ((tmpvar_9 * 3.0), 0.0, 1.0);
  highp vec4 tmpvar_18;
  tmpvar_18 = mix (_DissolveColor1, _DissolveColor2, vec4(float((tmpvar_17 > 0.2))));
  dissColor_4 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = mix (dissColor_4, result_5, vec4(clamp ((tmpvar_17 + 
    float((_Dissolve < 0.001))
  ), 0.0, 1.0)));
  result_5.xyz = tmpvar_19.xyz;
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_MaskTex, xlv_TEXCOORD0.zw);
  maskColor_3 = tmpvar_20;
  result_5.w = (result_5.w * maskColor_3.x);
  mediump float tmpvar_21;
  tmpvar_21 = dot (result_5.xyz, vec3(0.33, 0.34, 0.33));
  gray_2 = tmpvar_21;
  aa_1[0] = result_5.w;
  aa_1[1] = gray_2;
  result_5.w = (result_5.w * aa_1[int(_RgbAsAlpha)]);
  result_5.w = (result_5.w * _AlphaCtrl);
  gl_FragData[0] = result_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "MaskTex_On" "DissolveTex_On" "MultiplyBlend_On" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Color;
uniform highp float _Multiplier;
uniform highp vec4 _MainTex_ST;
uniform highp float _MainTexRot;
uniform highp float _MainTexX;
uniform highp float _MainTexY;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskTexRot;
uniform highp float _MaskTexX;
uniform highp float _MaskTexY;
uniform highp vec4 _DissolveTex_ST;
uniform highp float _DissolveRot;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_2.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + ((_MainTex_ST.zw + vec2(0.5, 0.5)) - (_MainTex_ST.xy * 0.5)));
  mediump vec2 uv_4;
  uv_4 = tmpvar_1.xy;
  mediump float uvRotate_5;
  uvRotate_5 = _MainTexRot;
  mediump vec2 outUV_6;
  mediump float tmpvar_7;
  tmpvar_7 = sin((uvRotate_5 / 57.2958));
  mediump float tmpvar_8;
  tmpvar_8 = cos((uvRotate_5 / 57.2958));
  outUV_6 = (uv_4 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_9;
  tmpvar_9.x = ((outUV_6.x * tmpvar_8) - (outUV_6.y * tmpvar_7));
  tmpvar_9.y = ((outUV_6.x * tmpvar_7) + (outUV_6.y * tmpvar_8));
  outUV_6 = (tmpvar_9 + vec2(0.5, 0.5));
  tmpvar_1.xy = outUV_6;
  highp vec2 tmpvar_10;
  tmpvar_10.x = _MainTexX;
  tmpvar_10.y = _MainTexY;
  tmpvar_1.xy = (tmpvar_1.xy + (_Time.z * tmpvar_10));
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _MaskTex_ST.xy) + ((_MaskTex_ST.zw + vec2(0.5, 0.5)) - (_MaskTex_ST.xy * 0.5)));
  mediump vec2 uv_11;
  uv_11 = tmpvar_1.zw;
  mediump float uvRotate_12;
  uvRotate_12 = _MaskTexRot;
  mediump vec2 outUV_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin((uvRotate_12 / 57.2958));
  mediump float tmpvar_15;
  tmpvar_15 = cos((uvRotate_12 / 57.2958));
  outUV_13 = (uv_11 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_16;
  tmpvar_16.x = ((outUV_13.x * tmpvar_15) - (outUV_13.y * tmpvar_14));
  tmpvar_16.y = ((outUV_13.x * tmpvar_14) + (outUV_13.y * tmpvar_15));
  outUV_13 = (tmpvar_16 + vec2(0.5, 0.5));
  tmpvar_1.zw = outUV_13;
  highp vec2 tmpvar_17;
  tmpvar_17.x = _MaskTexX;
  tmpvar_17.y = _MaskTexY;
  tmpvar_1.zw = (tmpvar_1.zw + (_Time.z * tmpvar_17));
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _DissolveTex_ST.xy) + ((_DissolveTex_ST.zw + vec2(0.5, 0.5)) - (_DissolveTex_ST.xy * 0.5)));
  mediump vec2 uv_18;
  uv_18 = tmpvar_2.xy;
  mediump float uvRotate_19;
  uvRotate_19 = _DissolveRot;
  mediump vec2 outUV_20;
  mediump float tmpvar_21;
  tmpvar_21 = sin((uvRotate_19 / 57.2958));
  mediump float tmpvar_22;
  tmpvar_22 = cos((uvRotate_19 / 57.2958));
  outUV_20 = (uv_18 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_23;
  tmpvar_23.x = ((outUV_20.x * tmpvar_22) - (outUV_20.y * tmpvar_21));
  tmpvar_23.y = ((outUV_20.x * tmpvar_21) + (outUV_20.y * tmpvar_22));
  outUV_20 = (tmpvar_23 + vec2(0.5, 0.5));
  tmpvar_2.xy = outUV_20;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = ((_glesColor * _Color) * _Multiplier);
}


#endif
#ifdef FRAGMENT
uniform highp float _AlphaCtrl;
uniform highp float _Channel;
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform sampler2D _DissolveTex;
uniform highp float _Dissolve;
uniform mediump vec4 _DissolveColor1;
uniform mediump vec4 _DissolveColor2;
uniform highp float _SrcFactor;
uniform highp float _RgbAsAlpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp float aa_1[2];
  highp float gray_2;
  mediump vec4 maskColor_3;
  mediump vec4 dissColor_4;
  mediump vec4 result_5;
  mediump vec4 texColor_6;
  mediump vec4 dissolveColor_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_DissolveTex, xlv_TEXCOORD1.xy);
  dissolveColor_7 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = ((dissolveColor_7.x + (
    (_Dissolve * -1.2)
   + 0.6)) - 0.5);
  if ((tmpvar_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_6 = tmpvar_10;
  result_5 = xlv_COLOR;
  mediump vec4 tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = float((0.1 >= _Channel));
  highp float tmpvar_13;
  tmpvar_13 = float((_Channel >= 2.9));
  highp vec2 tmpvar_14;
  tmpvar_14.x = float((1.1 >= _Channel));
  tmpvar_14.y = float((_Channel >= 1.9));
  highp vec4 tmpvar_15;
  tmpvar_15.x = tmpvar_12;
  tmpvar_15.yz = ((1.0 - max (tmpvar_12, tmpvar_13)) * tmpvar_14);
  tmpvar_15.w = tmpvar_13;
  tmpvar_11 = tmpvar_15;
  result_5.w = (result_5.w * dot (texColor_6, tmpvar_11));
  highp float tmpvar_16;
  tmpvar_16 = float((_Channel >= 3.1));
  result_5.xyz = (result_5.xyz * ((
    (tmpvar_16 * texColor_6.xyz)
   + 1.0) - tmpvar_16));
  highp float tmpvar_17;
  tmpvar_17 = clamp ((tmpvar_9 * 3.0), 0.0, 1.0);
  highp vec4 tmpvar_18;
  tmpvar_18 = mix (_DissolveColor1, _DissolveColor2, vec4(float((tmpvar_17 > 0.2))));
  dissColor_4 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = mix (dissColor_4, result_5, vec4(clamp ((tmpvar_17 + 
    float((_Dissolve < 0.001))
  ), 0.0, 1.0)));
  result_5.xyz = tmpvar_19.xyz;
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_MaskTex, xlv_TEXCOORD0.zw);
  maskColor_3 = tmpvar_20;
  result_5.w = (result_5.w * maskColor_3.x);
  mediump float tmpvar_21;
  tmpvar_21 = dot (result_5.xyz, vec3(0.33, 0.34, 0.33));
  gray_2 = tmpvar_21;
  aa_1[0] = result_5.w;
  aa_1[1] = gray_2;
  result_5.w = (result_5.w * aa_1[int(_RgbAsAlpha)]);
  mediump vec4 tmpvar_22;
  tmpvar_22 = mix (vec4(1.0, 1.0, 1.0, 1.0), result_5, result_5.wwww);
  highp vec4 tmpvar_23;
  tmpvar_23 = mix (result_5, tmpvar_22, vec4(float((_SrcFactor == 0.0))));
  result_5 = tmpvar_23;
  result_5.w = (result_5.w * _AlphaCtrl);
  gl_FragData[0] = result_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "MaskTex_On" "DissolveTex_On" "MultiplyBlend_On" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Color;
uniform highp float _Multiplier;
uniform highp vec4 _MainTex_ST;
uniform highp float _MainTexRot;
uniform highp float _MainTexX;
uniform highp float _MainTexY;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskTexRot;
uniform highp float _MaskTexX;
uniform highp float _MaskTexY;
uniform highp vec4 _DissolveTex_ST;
uniform highp float _DissolveRot;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_2.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + ((_MainTex_ST.zw + vec2(0.5, 0.5)) - (_MainTex_ST.xy * 0.5)));
  mediump vec2 uv_4;
  uv_4 = tmpvar_1.xy;
  mediump float uvRotate_5;
  uvRotate_5 = _MainTexRot;
  mediump vec2 outUV_6;
  mediump float tmpvar_7;
  tmpvar_7 = sin((uvRotate_5 / 57.2958));
  mediump float tmpvar_8;
  tmpvar_8 = cos((uvRotate_5 / 57.2958));
  outUV_6 = (uv_4 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_9;
  tmpvar_9.x = ((outUV_6.x * tmpvar_8) - (outUV_6.y * tmpvar_7));
  tmpvar_9.y = ((outUV_6.x * tmpvar_7) + (outUV_6.y * tmpvar_8));
  outUV_6 = (tmpvar_9 + vec2(0.5, 0.5));
  tmpvar_1.xy = outUV_6;
  highp vec2 tmpvar_10;
  tmpvar_10.x = _MainTexX;
  tmpvar_10.y = _MainTexY;
  tmpvar_1.xy = (tmpvar_1.xy + (_Time.z * tmpvar_10));
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _MaskTex_ST.xy) + ((_MaskTex_ST.zw + vec2(0.5, 0.5)) - (_MaskTex_ST.xy * 0.5)));
  mediump vec2 uv_11;
  uv_11 = tmpvar_1.zw;
  mediump float uvRotate_12;
  uvRotate_12 = _MaskTexRot;
  mediump vec2 outUV_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin((uvRotate_12 / 57.2958));
  mediump float tmpvar_15;
  tmpvar_15 = cos((uvRotate_12 / 57.2958));
  outUV_13 = (uv_11 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_16;
  tmpvar_16.x = ((outUV_13.x * tmpvar_15) - (outUV_13.y * tmpvar_14));
  tmpvar_16.y = ((outUV_13.x * tmpvar_14) + (outUV_13.y * tmpvar_15));
  outUV_13 = (tmpvar_16 + vec2(0.5, 0.5));
  tmpvar_1.zw = outUV_13;
  highp vec2 tmpvar_17;
  tmpvar_17.x = _MaskTexX;
  tmpvar_17.y = _MaskTexY;
  tmpvar_1.zw = (tmpvar_1.zw + (_Time.z * tmpvar_17));
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _DissolveTex_ST.xy) + ((_DissolveTex_ST.zw + vec2(0.5, 0.5)) - (_DissolveTex_ST.xy * 0.5)));
  mediump vec2 uv_18;
  uv_18 = tmpvar_2.xy;
  mediump float uvRotate_19;
  uvRotate_19 = _DissolveRot;
  mediump vec2 outUV_20;
  mediump float tmpvar_21;
  tmpvar_21 = sin((uvRotate_19 / 57.2958));
  mediump float tmpvar_22;
  tmpvar_22 = cos((uvRotate_19 / 57.2958));
  outUV_20 = (uv_18 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_23;
  tmpvar_23.x = ((outUV_20.x * tmpvar_22) - (outUV_20.y * tmpvar_21));
  tmpvar_23.y = ((outUV_20.x * tmpvar_21) + (outUV_20.y * tmpvar_22));
  outUV_20 = (tmpvar_23 + vec2(0.5, 0.5));
  tmpvar_2.xy = outUV_20;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = ((_glesColor * _Color) * _Multiplier);
}


#endif
#ifdef FRAGMENT
uniform highp float _AlphaCtrl;
uniform highp float _Channel;
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform sampler2D _DissolveTex;
uniform highp float _Dissolve;
uniform mediump vec4 _DissolveColor1;
uniform mediump vec4 _DissolveColor2;
uniform highp float _SrcFactor;
uniform highp float _RgbAsAlpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp float aa_1[2];
  highp float gray_2;
  mediump vec4 maskColor_3;
  mediump vec4 dissColor_4;
  mediump vec4 result_5;
  mediump vec4 texColor_6;
  mediump vec4 dissolveColor_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_DissolveTex, xlv_TEXCOORD1.xy);
  dissolveColor_7 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = ((dissolveColor_7.x + (
    (_Dissolve * -1.2)
   + 0.6)) - 0.5);
  if ((tmpvar_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_6 = tmpvar_10;
  result_5 = xlv_COLOR;
  mediump vec4 tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = float((0.1 >= _Channel));
  highp float tmpvar_13;
  tmpvar_13 = float((_Channel >= 2.9));
  highp vec2 tmpvar_14;
  tmpvar_14.x = float((1.1 >= _Channel));
  tmpvar_14.y = float((_Channel >= 1.9));
  highp vec4 tmpvar_15;
  tmpvar_15.x = tmpvar_12;
  tmpvar_15.yz = ((1.0 - max (tmpvar_12, tmpvar_13)) * tmpvar_14);
  tmpvar_15.w = tmpvar_13;
  tmpvar_11 = tmpvar_15;
  result_5.w = (result_5.w * dot (texColor_6, tmpvar_11));
  highp float tmpvar_16;
  tmpvar_16 = float((_Channel >= 3.1));
  result_5.xyz = (result_5.xyz * ((
    (tmpvar_16 * texColor_6.xyz)
   + 1.0) - tmpvar_16));
  highp float tmpvar_17;
  tmpvar_17 = clamp ((tmpvar_9 * 3.0), 0.0, 1.0);
  highp vec4 tmpvar_18;
  tmpvar_18 = mix (_DissolveColor1, _DissolveColor2, vec4(float((tmpvar_17 > 0.2))));
  dissColor_4 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = mix (dissColor_4, result_5, vec4(clamp ((tmpvar_17 + 
    float((_Dissolve < 0.001))
  ), 0.0, 1.0)));
  result_5.xyz = tmpvar_19.xyz;
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_MaskTex, xlv_TEXCOORD0.zw);
  maskColor_3 = tmpvar_20;
  result_5.w = (result_5.w * maskColor_3.x);
  mediump float tmpvar_21;
  tmpvar_21 = dot (result_5.xyz, vec3(0.33, 0.34, 0.33));
  gray_2 = tmpvar_21;
  aa_1[0] = result_5.w;
  aa_1[1] = gray_2;
  result_5.w = (result_5.w * aa_1[int(_RgbAsAlpha)]);
  mediump vec4 tmpvar_22;
  tmpvar_22 = mix (vec4(1.0, 1.0, 1.0, 1.0), result_5, result_5.wwww);
  highp vec4 tmpvar_23;
  tmpvar_23 = mix (result_5, tmpvar_22, vec4(float((_SrcFactor == 0.0))));
  result_5 = tmpvar_23;
  result_5.w = (result_5.w * _AlphaCtrl);
  gl_FragData[0] = result_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "MaskTex_On" "DissolveTex_On" "MultiplyBlend_On" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Color;
uniform highp float _Multiplier;
uniform highp vec4 _MainTex_ST;
uniform highp float _MainTexRot;
uniform highp float _MainTexX;
uniform highp float _MainTexY;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskTexRot;
uniform highp float _MaskTexX;
uniform highp float _MaskTexY;
uniform highp vec4 _DissolveTex_ST;
uniform highp float _DissolveRot;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_2.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + ((_MainTex_ST.zw + vec2(0.5, 0.5)) - (_MainTex_ST.xy * 0.5)));
  mediump vec2 uv_4;
  uv_4 = tmpvar_1.xy;
  mediump float uvRotate_5;
  uvRotate_5 = _MainTexRot;
  mediump vec2 outUV_6;
  mediump float tmpvar_7;
  tmpvar_7 = sin((uvRotate_5 / 57.2958));
  mediump float tmpvar_8;
  tmpvar_8 = cos((uvRotate_5 / 57.2958));
  outUV_6 = (uv_4 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_9;
  tmpvar_9.x = ((outUV_6.x * tmpvar_8) - (outUV_6.y * tmpvar_7));
  tmpvar_9.y = ((outUV_6.x * tmpvar_7) + (outUV_6.y * tmpvar_8));
  outUV_6 = (tmpvar_9 + vec2(0.5, 0.5));
  tmpvar_1.xy = outUV_6;
  highp vec2 tmpvar_10;
  tmpvar_10.x = _MainTexX;
  tmpvar_10.y = _MainTexY;
  tmpvar_1.xy = (tmpvar_1.xy + (_Time.z * tmpvar_10));
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _MaskTex_ST.xy) + ((_MaskTex_ST.zw + vec2(0.5, 0.5)) - (_MaskTex_ST.xy * 0.5)));
  mediump vec2 uv_11;
  uv_11 = tmpvar_1.zw;
  mediump float uvRotate_12;
  uvRotate_12 = _MaskTexRot;
  mediump vec2 outUV_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin((uvRotate_12 / 57.2958));
  mediump float tmpvar_15;
  tmpvar_15 = cos((uvRotate_12 / 57.2958));
  outUV_13 = (uv_11 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_16;
  tmpvar_16.x = ((outUV_13.x * tmpvar_15) - (outUV_13.y * tmpvar_14));
  tmpvar_16.y = ((outUV_13.x * tmpvar_14) + (outUV_13.y * tmpvar_15));
  outUV_13 = (tmpvar_16 + vec2(0.5, 0.5));
  tmpvar_1.zw = outUV_13;
  highp vec2 tmpvar_17;
  tmpvar_17.x = _MaskTexX;
  tmpvar_17.y = _MaskTexY;
  tmpvar_1.zw = (tmpvar_1.zw + (_Time.z * tmpvar_17));
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _DissolveTex_ST.xy) + ((_DissolveTex_ST.zw + vec2(0.5, 0.5)) - (_DissolveTex_ST.xy * 0.5)));
  mediump vec2 uv_18;
  uv_18 = tmpvar_2.xy;
  mediump float uvRotate_19;
  uvRotate_19 = _DissolveRot;
  mediump vec2 outUV_20;
  mediump float tmpvar_21;
  tmpvar_21 = sin((uvRotate_19 / 57.2958));
  mediump float tmpvar_22;
  tmpvar_22 = cos((uvRotate_19 / 57.2958));
  outUV_20 = (uv_18 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_23;
  tmpvar_23.x = ((outUV_20.x * tmpvar_22) - (outUV_20.y * tmpvar_21));
  tmpvar_23.y = ((outUV_20.x * tmpvar_21) + (outUV_20.y * tmpvar_22));
  outUV_20 = (tmpvar_23 + vec2(0.5, 0.5));
  tmpvar_2.xy = outUV_20;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = ((_glesColor * _Color) * _Multiplier);
}


#endif
#ifdef FRAGMENT
uniform highp float _AlphaCtrl;
uniform highp float _Channel;
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform sampler2D _DissolveTex;
uniform highp float _Dissolve;
uniform mediump vec4 _DissolveColor1;
uniform mediump vec4 _DissolveColor2;
uniform highp float _SrcFactor;
uniform highp float _RgbAsAlpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp float aa_1[2];
  highp float gray_2;
  mediump vec4 maskColor_3;
  mediump vec4 dissColor_4;
  mediump vec4 result_5;
  mediump vec4 texColor_6;
  mediump vec4 dissolveColor_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_DissolveTex, xlv_TEXCOORD1.xy);
  dissolveColor_7 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = ((dissolveColor_7.x + (
    (_Dissolve * -1.2)
   + 0.6)) - 0.5);
  if ((tmpvar_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_6 = tmpvar_10;
  result_5 = xlv_COLOR;
  mediump vec4 tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = float((0.1 >= _Channel));
  highp float tmpvar_13;
  tmpvar_13 = float((_Channel >= 2.9));
  highp vec2 tmpvar_14;
  tmpvar_14.x = float((1.1 >= _Channel));
  tmpvar_14.y = float((_Channel >= 1.9));
  highp vec4 tmpvar_15;
  tmpvar_15.x = tmpvar_12;
  tmpvar_15.yz = ((1.0 - max (tmpvar_12, tmpvar_13)) * tmpvar_14);
  tmpvar_15.w = tmpvar_13;
  tmpvar_11 = tmpvar_15;
  result_5.w = (result_5.w * dot (texColor_6, tmpvar_11));
  highp float tmpvar_16;
  tmpvar_16 = float((_Channel >= 3.1));
  result_5.xyz = (result_5.xyz * ((
    (tmpvar_16 * texColor_6.xyz)
   + 1.0) - tmpvar_16));
  highp float tmpvar_17;
  tmpvar_17 = clamp ((tmpvar_9 * 3.0), 0.0, 1.0);
  highp vec4 tmpvar_18;
  tmpvar_18 = mix (_DissolveColor1, _DissolveColor2, vec4(float((tmpvar_17 > 0.2))));
  dissColor_4 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = mix (dissColor_4, result_5, vec4(clamp ((tmpvar_17 + 
    float((_Dissolve < 0.001))
  ), 0.0, 1.0)));
  result_5.xyz = tmpvar_19.xyz;
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_MaskTex, xlv_TEXCOORD0.zw);
  maskColor_3 = tmpvar_20;
  result_5.w = (result_5.w * maskColor_3.x);
  mediump float tmpvar_21;
  tmpvar_21 = dot (result_5.xyz, vec3(0.33, 0.34, 0.33));
  gray_2 = tmpvar_21;
  aa_1[0] = result_5.w;
  aa_1[1] = gray_2;
  result_5.w = (result_5.w * aa_1[int(_RgbAsAlpha)]);
  mediump vec4 tmpvar_22;
  tmpvar_22 = mix (vec4(1.0, 1.0, 1.0, 1.0), result_5, result_5.wwww);
  highp vec4 tmpvar_23;
  tmpvar_23 = mix (result_5, tmpvar_22, vec4(float((_SrcFactor == 0.0))));
  result_5 = tmpvar_23;
  result_5.w = (result_5.w * _AlphaCtrl);
  gl_FragData[0] = result_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "MaskTex_On" "DissolveTex_On" "MultiplyBlend_On" "RT_PASS_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Color;
uniform highp float _Multiplier;
uniform highp vec4 _MainTex_ST;
uniform highp float _MainTexRot;
uniform highp float _MainTexX;
uniform highp float _MainTexY;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskTexRot;
uniform highp float _MaskTexX;
uniform highp float _MaskTexY;
uniform highp vec4 _DissolveTex_ST;
uniform highp float _DissolveRot;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_2.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + ((_MainTex_ST.zw + vec2(0.5, 0.5)) - (_MainTex_ST.xy * 0.5)));
  mediump vec2 uv_4;
  uv_4 = tmpvar_1.xy;
  mediump float uvRotate_5;
  uvRotate_5 = _MainTexRot;
  mediump vec2 outUV_6;
  mediump float tmpvar_7;
  tmpvar_7 = sin((uvRotate_5 / 57.2958));
  mediump float tmpvar_8;
  tmpvar_8 = cos((uvRotate_5 / 57.2958));
  outUV_6 = (uv_4 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_9;
  tmpvar_9.x = ((outUV_6.x * tmpvar_8) - (outUV_6.y * tmpvar_7));
  tmpvar_9.y = ((outUV_6.x * tmpvar_7) + (outUV_6.y * tmpvar_8));
  outUV_6 = (tmpvar_9 + vec2(0.5, 0.5));
  tmpvar_1.xy = outUV_6;
  highp vec2 tmpvar_10;
  tmpvar_10.x = _MainTexX;
  tmpvar_10.y = _MainTexY;
  tmpvar_1.xy = (tmpvar_1.xy + (_Time.z * tmpvar_10));
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _MaskTex_ST.xy) + ((_MaskTex_ST.zw + vec2(0.5, 0.5)) - (_MaskTex_ST.xy * 0.5)));
  mediump vec2 uv_11;
  uv_11 = tmpvar_1.zw;
  mediump float uvRotate_12;
  uvRotate_12 = _MaskTexRot;
  mediump vec2 outUV_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin((uvRotate_12 / 57.2958));
  mediump float tmpvar_15;
  tmpvar_15 = cos((uvRotate_12 / 57.2958));
  outUV_13 = (uv_11 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_16;
  tmpvar_16.x = ((outUV_13.x * tmpvar_15) - (outUV_13.y * tmpvar_14));
  tmpvar_16.y = ((outUV_13.x * tmpvar_14) + (outUV_13.y * tmpvar_15));
  outUV_13 = (tmpvar_16 + vec2(0.5, 0.5));
  tmpvar_1.zw = outUV_13;
  highp vec2 tmpvar_17;
  tmpvar_17.x = _MaskTexX;
  tmpvar_17.y = _MaskTexY;
  tmpvar_1.zw = (tmpvar_1.zw + (_Time.z * tmpvar_17));
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _DissolveTex_ST.xy) + ((_DissolveTex_ST.zw + vec2(0.5, 0.5)) - (_DissolveTex_ST.xy * 0.5)));
  mediump vec2 uv_18;
  uv_18 = tmpvar_2.xy;
  mediump float uvRotate_19;
  uvRotate_19 = _DissolveRot;
  mediump vec2 outUV_20;
  mediump float tmpvar_21;
  tmpvar_21 = sin((uvRotate_19 / 57.2958));
  mediump float tmpvar_22;
  tmpvar_22 = cos((uvRotate_19 / 57.2958));
  outUV_20 = (uv_18 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_23;
  tmpvar_23.x = ((outUV_20.x * tmpvar_22) - (outUV_20.y * tmpvar_21));
  tmpvar_23.y = ((outUV_20.x * tmpvar_21) + (outUV_20.y * tmpvar_22));
  outUV_20 = (tmpvar_23 + vec2(0.5, 0.5));
  tmpvar_2.xy = outUV_20;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = ((_glesColor * _Color) * _Multiplier);
}


#endif
#ifdef FRAGMENT
uniform highp float _AlphaCtrl;
uniform highp float _Channel;
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform sampler2D _DissolveTex;
uniform highp float _Dissolve;
uniform mediump vec4 _DissolveColor1;
uniform mediump vec4 _DissolveColor2;
uniform highp float _SrcFactor;
uniform highp float _RgbAsAlpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp float aa_1[2];
  highp float gray_2;
  mediump vec4 maskColor_3;
  mediump vec4 dissColor_4;
  mediump vec4 result_5;
  mediump vec4 texColor_6;
  mediump vec4 dissolveColor_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_DissolveTex, xlv_TEXCOORD1.xy);
  dissolveColor_7 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = ((dissolveColor_7.x + (
    (_Dissolve * -1.2)
   + 0.6)) - 0.5);
  if ((tmpvar_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_6 = tmpvar_10;
  result_5 = xlv_COLOR;
  mediump vec4 tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = float((0.1 >= _Channel));
  highp float tmpvar_13;
  tmpvar_13 = float((_Channel >= 2.9));
  highp vec2 tmpvar_14;
  tmpvar_14.x = float((1.1 >= _Channel));
  tmpvar_14.y = float((_Channel >= 1.9));
  highp vec4 tmpvar_15;
  tmpvar_15.x = tmpvar_12;
  tmpvar_15.yz = ((1.0 - max (tmpvar_12, tmpvar_13)) * tmpvar_14);
  tmpvar_15.w = tmpvar_13;
  tmpvar_11 = tmpvar_15;
  result_5.w = (result_5.w * dot (texColor_6, tmpvar_11));
  highp float tmpvar_16;
  tmpvar_16 = float((_Channel >= 3.1));
  result_5.xyz = (result_5.xyz * ((
    (tmpvar_16 * texColor_6.xyz)
   + 1.0) - tmpvar_16));
  highp float tmpvar_17;
  tmpvar_17 = clamp ((tmpvar_9 * 3.0), 0.0, 1.0);
  highp vec4 tmpvar_18;
  tmpvar_18 = mix (_DissolveColor1, _DissolveColor2, vec4(float((tmpvar_17 > 0.2))));
  dissColor_4 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = mix (dissColor_4, result_5, vec4(clamp ((tmpvar_17 + 
    float((_Dissolve < 0.001))
  ), 0.0, 1.0)));
  result_5.xyz = tmpvar_19.xyz;
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_MaskTex, xlv_TEXCOORD0.zw);
  maskColor_3 = tmpvar_20;
  result_5.w = (result_5.w * maskColor_3.x);
  mediump float tmpvar_21;
  tmpvar_21 = dot (result_5.xyz, vec3(0.33, 0.34, 0.33));
  gray_2 = tmpvar_21;
  aa_1[0] = result_5.w;
  aa_1[1] = gray_2;
  result_5.w = (result_5.w * aa_1[int(_RgbAsAlpha)]);
  mediump vec4 tmpvar_22;
  tmpvar_22 = mix (vec4(1.0, 1.0, 1.0, 1.0), result_5, result_5.wwww);
  highp vec4 tmpvar_23;
  tmpvar_23 = mix (result_5, tmpvar_22, vec4(float((_SrcFactor == 0.0))));
  result_5 = tmpvar_23;
  result_5.w = (result_5.w * _AlphaCtrl);
  gl_FragData[0] = result_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "MaskTex_On" "DissolveTex_On" "MultiplyBlend_On" "RT_PASS_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Color;
uniform highp float _Multiplier;
uniform highp vec4 _MainTex_ST;
uniform highp float _MainTexRot;
uniform highp float _MainTexX;
uniform highp float _MainTexY;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskTexRot;
uniform highp float _MaskTexX;
uniform highp float _MaskTexY;
uniform highp vec4 _DissolveTex_ST;
uniform highp float _DissolveRot;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_2.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + ((_MainTex_ST.zw + vec2(0.5, 0.5)) - (_MainTex_ST.xy * 0.5)));
  mediump vec2 uv_4;
  uv_4 = tmpvar_1.xy;
  mediump float uvRotate_5;
  uvRotate_5 = _MainTexRot;
  mediump vec2 outUV_6;
  mediump float tmpvar_7;
  tmpvar_7 = sin((uvRotate_5 / 57.2958));
  mediump float tmpvar_8;
  tmpvar_8 = cos((uvRotate_5 / 57.2958));
  outUV_6 = (uv_4 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_9;
  tmpvar_9.x = ((outUV_6.x * tmpvar_8) - (outUV_6.y * tmpvar_7));
  tmpvar_9.y = ((outUV_6.x * tmpvar_7) + (outUV_6.y * tmpvar_8));
  outUV_6 = (tmpvar_9 + vec2(0.5, 0.5));
  tmpvar_1.xy = outUV_6;
  highp vec2 tmpvar_10;
  tmpvar_10.x = _MainTexX;
  tmpvar_10.y = _MainTexY;
  tmpvar_1.xy = (tmpvar_1.xy + (_Time.z * tmpvar_10));
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _MaskTex_ST.xy) + ((_MaskTex_ST.zw + vec2(0.5, 0.5)) - (_MaskTex_ST.xy * 0.5)));
  mediump vec2 uv_11;
  uv_11 = tmpvar_1.zw;
  mediump float uvRotate_12;
  uvRotate_12 = _MaskTexRot;
  mediump vec2 outUV_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin((uvRotate_12 / 57.2958));
  mediump float tmpvar_15;
  tmpvar_15 = cos((uvRotate_12 / 57.2958));
  outUV_13 = (uv_11 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_16;
  tmpvar_16.x = ((outUV_13.x * tmpvar_15) - (outUV_13.y * tmpvar_14));
  tmpvar_16.y = ((outUV_13.x * tmpvar_14) + (outUV_13.y * tmpvar_15));
  outUV_13 = (tmpvar_16 + vec2(0.5, 0.5));
  tmpvar_1.zw = outUV_13;
  highp vec2 tmpvar_17;
  tmpvar_17.x = _MaskTexX;
  tmpvar_17.y = _MaskTexY;
  tmpvar_1.zw = (tmpvar_1.zw + (_Time.z * tmpvar_17));
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _DissolveTex_ST.xy) + ((_DissolveTex_ST.zw + vec2(0.5, 0.5)) - (_DissolveTex_ST.xy * 0.5)));
  mediump vec2 uv_18;
  uv_18 = tmpvar_2.xy;
  mediump float uvRotate_19;
  uvRotate_19 = _DissolveRot;
  mediump vec2 outUV_20;
  mediump float tmpvar_21;
  tmpvar_21 = sin((uvRotate_19 / 57.2958));
  mediump float tmpvar_22;
  tmpvar_22 = cos((uvRotate_19 / 57.2958));
  outUV_20 = (uv_18 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_23;
  tmpvar_23.x = ((outUV_20.x * tmpvar_22) - (outUV_20.y * tmpvar_21));
  tmpvar_23.y = ((outUV_20.x * tmpvar_21) + (outUV_20.y * tmpvar_22));
  outUV_20 = (tmpvar_23 + vec2(0.5, 0.5));
  tmpvar_2.xy = outUV_20;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = ((_glesColor * _Color) * _Multiplier);
}


#endif
#ifdef FRAGMENT
uniform highp float _AlphaCtrl;
uniform highp float _Channel;
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform sampler2D _DissolveTex;
uniform highp float _Dissolve;
uniform mediump vec4 _DissolveColor1;
uniform mediump vec4 _DissolveColor2;
uniform highp float _SrcFactor;
uniform highp float _RgbAsAlpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp float aa_1[2];
  highp float gray_2;
  mediump vec4 maskColor_3;
  mediump vec4 dissColor_4;
  mediump vec4 result_5;
  mediump vec4 texColor_6;
  mediump vec4 dissolveColor_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_DissolveTex, xlv_TEXCOORD1.xy);
  dissolveColor_7 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = ((dissolveColor_7.x + (
    (_Dissolve * -1.2)
   + 0.6)) - 0.5);
  if ((tmpvar_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_6 = tmpvar_10;
  result_5 = xlv_COLOR;
  mediump vec4 tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = float((0.1 >= _Channel));
  highp float tmpvar_13;
  tmpvar_13 = float((_Channel >= 2.9));
  highp vec2 tmpvar_14;
  tmpvar_14.x = float((1.1 >= _Channel));
  tmpvar_14.y = float((_Channel >= 1.9));
  highp vec4 tmpvar_15;
  tmpvar_15.x = tmpvar_12;
  tmpvar_15.yz = ((1.0 - max (tmpvar_12, tmpvar_13)) * tmpvar_14);
  tmpvar_15.w = tmpvar_13;
  tmpvar_11 = tmpvar_15;
  result_5.w = (result_5.w * dot (texColor_6, tmpvar_11));
  highp float tmpvar_16;
  tmpvar_16 = float((_Channel >= 3.1));
  result_5.xyz = (result_5.xyz * ((
    (tmpvar_16 * texColor_6.xyz)
   + 1.0) - tmpvar_16));
  highp float tmpvar_17;
  tmpvar_17 = clamp ((tmpvar_9 * 3.0), 0.0, 1.0);
  highp vec4 tmpvar_18;
  tmpvar_18 = mix (_DissolveColor1, _DissolveColor2, vec4(float((tmpvar_17 > 0.2))));
  dissColor_4 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = mix (dissColor_4, result_5, vec4(clamp ((tmpvar_17 + 
    float((_Dissolve < 0.001))
  ), 0.0, 1.0)));
  result_5.xyz = tmpvar_19.xyz;
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_MaskTex, xlv_TEXCOORD0.zw);
  maskColor_3 = tmpvar_20;
  result_5.w = (result_5.w * maskColor_3.x);
  mediump float tmpvar_21;
  tmpvar_21 = dot (result_5.xyz, vec3(0.33, 0.34, 0.33));
  gray_2 = tmpvar_21;
  aa_1[0] = result_5.w;
  aa_1[1] = gray_2;
  result_5.w = (result_5.w * aa_1[int(_RgbAsAlpha)]);
  mediump vec4 tmpvar_22;
  tmpvar_22 = mix (vec4(1.0, 1.0, 1.0, 1.0), result_5, result_5.wwww);
  highp vec4 tmpvar_23;
  tmpvar_23 = mix (result_5, tmpvar_22, vec4(float((_SrcFactor == 0.0))));
  result_5 = tmpvar_23;
  result_5.w = (result_5.w * _AlphaCtrl);
  gl_FragData[0] = result_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "MaskTex_On" "DissolveTex_On" "MultiplyBlend_On" "RT_PASS_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Color;
uniform highp float _Multiplier;
uniform highp vec4 _MainTex_ST;
uniform highp float _MainTexRot;
uniform highp float _MainTexX;
uniform highp float _MainTexY;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskTexRot;
uniform highp float _MaskTexX;
uniform highp float _MaskTexY;
uniform highp vec4 _DissolveTex_ST;
uniform highp float _DissolveRot;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_2.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + ((_MainTex_ST.zw + vec2(0.5, 0.5)) - (_MainTex_ST.xy * 0.5)));
  mediump vec2 uv_4;
  uv_4 = tmpvar_1.xy;
  mediump float uvRotate_5;
  uvRotate_5 = _MainTexRot;
  mediump vec2 outUV_6;
  mediump float tmpvar_7;
  tmpvar_7 = sin((uvRotate_5 / 57.2958));
  mediump float tmpvar_8;
  tmpvar_8 = cos((uvRotate_5 / 57.2958));
  outUV_6 = (uv_4 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_9;
  tmpvar_9.x = ((outUV_6.x * tmpvar_8) - (outUV_6.y * tmpvar_7));
  tmpvar_9.y = ((outUV_6.x * tmpvar_7) + (outUV_6.y * tmpvar_8));
  outUV_6 = (tmpvar_9 + vec2(0.5, 0.5));
  tmpvar_1.xy = outUV_6;
  highp vec2 tmpvar_10;
  tmpvar_10.x = _MainTexX;
  tmpvar_10.y = _MainTexY;
  tmpvar_1.xy = (tmpvar_1.xy + (_Time.z * tmpvar_10));
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _MaskTex_ST.xy) + ((_MaskTex_ST.zw + vec2(0.5, 0.5)) - (_MaskTex_ST.xy * 0.5)));
  mediump vec2 uv_11;
  uv_11 = tmpvar_1.zw;
  mediump float uvRotate_12;
  uvRotate_12 = _MaskTexRot;
  mediump vec2 outUV_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin((uvRotate_12 / 57.2958));
  mediump float tmpvar_15;
  tmpvar_15 = cos((uvRotate_12 / 57.2958));
  outUV_13 = (uv_11 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_16;
  tmpvar_16.x = ((outUV_13.x * tmpvar_15) - (outUV_13.y * tmpvar_14));
  tmpvar_16.y = ((outUV_13.x * tmpvar_14) + (outUV_13.y * tmpvar_15));
  outUV_13 = (tmpvar_16 + vec2(0.5, 0.5));
  tmpvar_1.zw = outUV_13;
  highp vec2 tmpvar_17;
  tmpvar_17.x = _MaskTexX;
  tmpvar_17.y = _MaskTexY;
  tmpvar_1.zw = (tmpvar_1.zw + (_Time.z * tmpvar_17));
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _DissolveTex_ST.xy) + ((_DissolveTex_ST.zw + vec2(0.5, 0.5)) - (_DissolveTex_ST.xy * 0.5)));
  mediump vec2 uv_18;
  uv_18 = tmpvar_2.xy;
  mediump float uvRotate_19;
  uvRotate_19 = _DissolveRot;
  mediump vec2 outUV_20;
  mediump float tmpvar_21;
  tmpvar_21 = sin((uvRotate_19 / 57.2958));
  mediump float tmpvar_22;
  tmpvar_22 = cos((uvRotate_19 / 57.2958));
  outUV_20 = (uv_18 - vec2(0.5, 0.5));
  mediump vec2 tmpvar_23;
  tmpvar_23.x = ((outUV_20.x * tmpvar_22) - (outUV_20.y * tmpvar_21));
  tmpvar_23.y = ((outUV_20.x * tmpvar_21) + (outUV_20.y * tmpvar_22));
  outUV_20 = (tmpvar_23 + vec2(0.5, 0.5));
  tmpvar_2.xy = outUV_20;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = ((_glesColor * _Color) * _Multiplier);
}


#endif
#ifdef FRAGMENT
uniform highp float _AlphaCtrl;
uniform highp float _Channel;
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform sampler2D _DissolveTex;
uniform highp float _Dissolve;
uniform mediump vec4 _DissolveColor1;
uniform mediump vec4 _DissolveColor2;
uniform highp float _SrcFactor;
uniform highp float _RgbAsAlpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp float aa_1[2];
  highp float gray_2;
  mediump vec4 maskColor_3;
  mediump vec4 dissColor_4;
  mediump vec4 result_5;
  mediump vec4 texColor_6;
  mediump vec4 dissolveColor_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_DissolveTex, xlv_TEXCOORD1.xy);
  dissolveColor_7 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = ((dissolveColor_7.x + (
    (_Dissolve * -1.2)
   + 0.6)) - 0.5);
  if ((tmpvar_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_6 = tmpvar_10;
  result_5 = xlv_COLOR;
  mediump vec4 tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = float((0.1 >= _Channel));
  highp float tmpvar_13;
  tmpvar_13 = float((_Channel >= 2.9));
  highp vec2 tmpvar_14;
  tmpvar_14.x = float((1.1 >= _Channel));
  tmpvar_14.y = float((_Channel >= 1.9));
  highp vec4 tmpvar_15;
  tmpvar_15.x = tmpvar_12;
  tmpvar_15.yz = ((1.0 - max (tmpvar_12, tmpvar_13)) * tmpvar_14);
  tmpvar_15.w = tmpvar_13;
  tmpvar_11 = tmpvar_15;
  result_5.w = (result_5.w * dot (texColor_6, tmpvar_11));
  highp float tmpvar_16;
  tmpvar_16 = float((_Channel >= 3.1));
  result_5.xyz = (result_5.xyz * ((
    (tmpvar_16 * texColor_6.xyz)
   + 1.0) - tmpvar_16));
  highp float tmpvar_17;
  tmpvar_17 = clamp ((tmpvar_9 * 3.0), 0.0, 1.0);
  highp vec4 tmpvar_18;
  tmpvar_18 = mix (_DissolveColor1, _DissolveColor2, vec4(float((tmpvar_17 > 0.2))));
  dissColor_4 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = mix (dissColor_4, result_5, vec4(clamp ((tmpvar_17 + 
    float((_Dissolve < 0.001))
  ), 0.0, 1.0)));
  result_5.xyz = tmpvar_19.xyz;
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_MaskTex, xlv_TEXCOORD0.zw);
  maskColor_3 = tmpvar_20;
  result_5.w = (result_5.w * maskColor_3.x);
  mediump float tmpvar_21;
  tmpvar_21 = dot (result_5.xyz, vec3(0.33, 0.34, 0.33));
  gray_2 = tmpvar_21;
  aa_1[0] = result_5.w;
  aa_1[1] = gray_2;
  result_5.w = (result_5.w * aa_1[int(_RgbAsAlpha)]);
  mediump vec4 tmpvar_22;
  tmpvar_22 = mix (vec4(1.0, 1.0, 1.0, 1.0), result_5, result_5.wwww);
  highp vec4 tmpvar_23;
  tmpvar_23 = mix (result_5, tmpvar_22, vec4(float((_SrcFactor == 0.0))));
  result_5 = tmpvar_23;
  result_5.w = (result_5.w * _AlphaCtrl);
  gl_FragData[0] = result_5;
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
Keywords { "RT_PASS_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "RT_PASS_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "RT_PASS_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "MultiplyBlend_On" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "MultiplyBlend_On" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "MultiplyBlend_On" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "MultiplyBlend_On" "RT_PASS_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "MultiplyBlend_On" "RT_PASS_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "MultiplyBlend_On" "RT_PASS_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DissolveTex_On" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DissolveTex_On" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DissolveTex_On" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DissolveTex_On" "RT_PASS_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DissolveTex_On" "RT_PASS_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DissolveTex_On" "RT_PASS_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DissolveTex_On" "MultiplyBlend_On" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DissolveTex_On" "MultiplyBlend_On" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DissolveTex_On" "MultiplyBlend_On" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DissolveTex_On" "MultiplyBlend_On" "RT_PASS_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DissolveTex_On" "MultiplyBlend_On" "RT_PASS_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DissolveTex_On" "MultiplyBlend_On" "RT_PASS_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "MaskTex_On" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "MaskTex_On" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "MaskTex_On" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "MaskTex_On" "RT_PASS_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "MaskTex_On" "RT_PASS_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "MaskTex_On" "RT_PASS_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "MaskTex_On" "MultiplyBlend_On" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "MaskTex_On" "MultiplyBlend_On" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "MaskTex_On" "MultiplyBlend_On" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "MaskTex_On" "MultiplyBlend_On" "RT_PASS_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "MaskTex_On" "MultiplyBlend_On" "RT_PASS_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "MaskTex_On" "MultiplyBlend_On" "RT_PASS_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "MaskTex_On" "DissolveTex_On" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "MaskTex_On" "DissolveTex_On" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "MaskTex_On" "DissolveTex_On" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "MaskTex_On" "DissolveTex_On" "RT_PASS_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "MaskTex_On" "DissolveTex_On" "RT_PASS_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "MaskTex_On" "DissolveTex_On" "RT_PASS_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "MaskTex_On" "DissolveTex_On" "MultiplyBlend_On" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "MaskTex_On" "DissolveTex_On" "MultiplyBlend_On" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "MaskTex_On" "DissolveTex_On" "MultiplyBlend_On" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "MaskTex_On" "DissolveTex_On" "MultiplyBlend_On" "RT_PASS_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "MaskTex_On" "DissolveTex_On" "MultiplyBlend_On" "RT_PASS_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "MaskTex_On" "DissolveTex_On" "MultiplyBlend_On" "RT_PASS_ON" }
""
}
}
}
}
}