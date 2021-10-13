//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/PPOutline" {
Properties {
_MainTex ("Texture", 2D) = "" { }
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 43292
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
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _MainTex;
uniform sampler2D _CustomDepthTexture;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _BloomFactor;
uniform highp vec4 _LineColor;
uniform highp float _LineWidth;
uniform highp float _DepthThreshold;
uniform highp float _NearStart;
uniform highp float _NearEnd;
uniform highp float _FarStart;
uniform highp float _FarEnd;
uniform highp float _LineMaxDist;
uniform highp float _ColorMultiplier;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 finalColor_1;
  mediump vec4 color_2;
  mediump vec4 edgeColor_3;
  highp float edgeDepth_4;
  highp float depth3_5;
  highp float depth2_6;
  highp float depth1_7;
  highp float depth0_8;
  highp float tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = (_LineWidth * 0.5);
  tmpvar_9 = floor(tmpvar_10);
  highp float tmpvar_11;
  tmpvar_11 = ceil(tmpvar_10);
  highp vec2 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD0 - (_MainTex_TexelSize.xy * tmpvar_9));
  highp vec2 tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD0 + (_MainTex_TexelSize.xy * tmpvar_11));
  highp vec2 tmpvar_14;
  tmpvar_14.x = (_MainTex_TexelSize.x * tmpvar_11);
  tmpvar_14.y = (-(_MainTex_TexelSize.y) * tmpvar_9);
  highp vec2 tmpvar_15;
  tmpvar_15 = (xlv_TEXCOORD0 + tmpvar_14);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (-(_MainTex_TexelSize.x) * tmpvar_9);
  tmpvar_16.y = (_MainTex_TexelSize.y * tmpvar_11);
  highp vec2 tmpvar_17;
  tmpvar_17 = (xlv_TEXCOORD0 + tmpvar_16);
  lowp float tmpvar_18;
  tmpvar_18 = texture2D (_CustomDepthTexture, tmpvar_12).x;
  depth0_8 = tmpvar_18;
  lowp float tmpvar_19;
  tmpvar_19 = texture2D (_CustomDepthTexture, tmpvar_13).x;
  depth1_7 = tmpvar_19;
  lowp float tmpvar_20;
  tmpvar_20 = texture2D (_CustomDepthTexture, tmpvar_15).x;
  depth2_6 = tmpvar_20;
  lowp float tmpvar_21;
  tmpvar_21 = texture2D (_CustomDepthTexture, tmpvar_17).x;
  depth3_5 = tmpvar_21;
  highp float tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (depth1_7 - depth0_8);
  highp float tmpvar_24;
  tmpvar_24 = (depth3_5 - depth2_6);
  tmpvar_22 = (sqrt((
    (tmpvar_23 * tmpvar_23)
   + 
    (tmpvar_24 * tmpvar_24)
  )) * 100.0);
  edgeDepth_4 = tmpvar_22;
  highp int tmpvar_25;
  if ((tmpvar_22 > (_DepthThreshold * depth0_8))) {
    tmpvar_25 = 1;
  } else {
    tmpvar_25 = 0;
  };
  edgeDepth_4 = float(tmpvar_25);
  highp float dist_26;
  dist_26 = (((1.0/(
    ((_ZBufferParams.x * max (max (depth0_8, depth1_7), max (depth2_6, depth3_5))) + _ZBufferParams.y)
  )) * _ProjectionParams.z) - _ProjectionParams.y);
  highp float tmpvar_27;
  tmpvar_27 = clamp (((dist_26 - _NearStart) / (_NearEnd - _NearStart)), 0.0, 1.0);
  highp float tmpvar_28;
  tmpvar_28 = clamp (((dist_26 - _FarStart) / (_FarEnd - _FarStart)), 0.0, 1.0);
  edgeDepth_4 = (edgeDepth_4 * ((
    (tmpvar_27 * (tmpvar_27 * (3.0 - (2.0 * tmpvar_27))))
   - 
    (tmpvar_28 * (tmpvar_28 * (3.0 - (2.0 * tmpvar_28))))
  ) * (1.0 - 
    clamp (((dist_26 - _LineMaxDist) * 100.0), 0.0, 1.0)
  )));
  highp vec4 tmpvar_29;
  tmpvar_29.xyz = _LineColor.xyz;
  tmpvar_29.w = (_LineColor.w * edgeDepth_4);
  edgeColor_3 = tmpvar_29;
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_2 = tmpvar_30;
  highp vec4 top_31;
  top_31 = edgeColor_3;
  highp vec4 bottom_32;
  bottom_32 = color_2;
  highp vec4 tmpvar_33;
  tmpvar_33.xyz = ((top_31.xyz * top_31.w) + (bottom_32.xyz * (1.0 - top_31.w)));
  tmpvar_33.w = bottom_32.w;
  finalColor_1 = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = mix (1.0, (1.0 + _ColorMultiplier), edgeDepth_4);
  finalColor_1.xyz = (finalColor_1.xyz * tmpvar_34);
  highp float tmpvar_35;
  tmpvar_35 = mix (finalColor_1.w, _BloomFactor, edgeDepth_4);
  finalColor_1.w = tmpvar_35;
  gl_FragData[0] = finalColor_1;
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
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _MainTex;
uniform sampler2D _CustomDepthTexture;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _BloomFactor;
uniform highp vec4 _LineColor;
uniform highp float _LineWidth;
uniform highp float _DepthThreshold;
uniform highp float _NearStart;
uniform highp float _NearEnd;
uniform highp float _FarStart;
uniform highp float _FarEnd;
uniform highp float _LineMaxDist;
uniform highp float _ColorMultiplier;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 finalColor_1;
  mediump vec4 color_2;
  mediump vec4 edgeColor_3;
  highp float edgeDepth_4;
  highp float depth3_5;
  highp float depth2_6;
  highp float depth1_7;
  highp float depth0_8;
  highp float tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = (_LineWidth * 0.5);
  tmpvar_9 = floor(tmpvar_10);
  highp float tmpvar_11;
  tmpvar_11 = ceil(tmpvar_10);
  highp vec2 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD0 - (_MainTex_TexelSize.xy * tmpvar_9));
  highp vec2 tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD0 + (_MainTex_TexelSize.xy * tmpvar_11));
  highp vec2 tmpvar_14;
  tmpvar_14.x = (_MainTex_TexelSize.x * tmpvar_11);
  tmpvar_14.y = (-(_MainTex_TexelSize.y) * tmpvar_9);
  highp vec2 tmpvar_15;
  tmpvar_15 = (xlv_TEXCOORD0 + tmpvar_14);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (-(_MainTex_TexelSize.x) * tmpvar_9);
  tmpvar_16.y = (_MainTex_TexelSize.y * tmpvar_11);
  highp vec2 tmpvar_17;
  tmpvar_17 = (xlv_TEXCOORD0 + tmpvar_16);
  lowp float tmpvar_18;
  tmpvar_18 = texture2D (_CustomDepthTexture, tmpvar_12).x;
  depth0_8 = tmpvar_18;
  lowp float tmpvar_19;
  tmpvar_19 = texture2D (_CustomDepthTexture, tmpvar_13).x;
  depth1_7 = tmpvar_19;
  lowp float tmpvar_20;
  tmpvar_20 = texture2D (_CustomDepthTexture, tmpvar_15).x;
  depth2_6 = tmpvar_20;
  lowp float tmpvar_21;
  tmpvar_21 = texture2D (_CustomDepthTexture, tmpvar_17).x;
  depth3_5 = tmpvar_21;
  highp float tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (depth1_7 - depth0_8);
  highp float tmpvar_24;
  tmpvar_24 = (depth3_5 - depth2_6);
  tmpvar_22 = (sqrt((
    (tmpvar_23 * tmpvar_23)
   + 
    (tmpvar_24 * tmpvar_24)
  )) * 100.0);
  edgeDepth_4 = tmpvar_22;
  highp int tmpvar_25;
  if ((tmpvar_22 > (_DepthThreshold * depth0_8))) {
    tmpvar_25 = 1;
  } else {
    tmpvar_25 = 0;
  };
  edgeDepth_4 = float(tmpvar_25);
  highp float dist_26;
  dist_26 = (((1.0/(
    ((_ZBufferParams.x * max (max (depth0_8, depth1_7), max (depth2_6, depth3_5))) + _ZBufferParams.y)
  )) * _ProjectionParams.z) - _ProjectionParams.y);
  highp float tmpvar_27;
  tmpvar_27 = clamp (((dist_26 - _NearStart) / (_NearEnd - _NearStart)), 0.0, 1.0);
  highp float tmpvar_28;
  tmpvar_28 = clamp (((dist_26 - _FarStart) / (_FarEnd - _FarStart)), 0.0, 1.0);
  edgeDepth_4 = (edgeDepth_4 * ((
    (tmpvar_27 * (tmpvar_27 * (3.0 - (2.0 * tmpvar_27))))
   - 
    (tmpvar_28 * (tmpvar_28 * (3.0 - (2.0 * tmpvar_28))))
  ) * (1.0 - 
    clamp (((dist_26 - _LineMaxDist) * 100.0), 0.0, 1.0)
  )));
  highp vec4 tmpvar_29;
  tmpvar_29.xyz = _LineColor.xyz;
  tmpvar_29.w = (_LineColor.w * edgeDepth_4);
  edgeColor_3 = tmpvar_29;
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_2 = tmpvar_30;
  highp vec4 top_31;
  top_31 = edgeColor_3;
  highp vec4 bottom_32;
  bottom_32 = color_2;
  highp vec4 tmpvar_33;
  tmpvar_33.xyz = ((top_31.xyz * top_31.w) + (bottom_32.xyz * (1.0 - top_31.w)));
  tmpvar_33.w = bottom_32.w;
  finalColor_1 = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = mix (1.0, (1.0 + _ColorMultiplier), edgeDepth_4);
  finalColor_1.xyz = (finalColor_1.xyz * tmpvar_34);
  highp float tmpvar_35;
  tmpvar_35 = mix (finalColor_1.w, _BloomFactor, edgeDepth_4);
  finalColor_1.w = tmpvar_35;
  gl_FragData[0] = finalColor_1;
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
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _MainTex;
uniform sampler2D _CustomDepthTexture;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _BloomFactor;
uniform highp vec4 _LineColor;
uniform highp float _LineWidth;
uniform highp float _DepthThreshold;
uniform highp float _NearStart;
uniform highp float _NearEnd;
uniform highp float _FarStart;
uniform highp float _FarEnd;
uniform highp float _LineMaxDist;
uniform highp float _ColorMultiplier;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 finalColor_1;
  mediump vec4 color_2;
  mediump vec4 edgeColor_3;
  highp float edgeDepth_4;
  highp float depth3_5;
  highp float depth2_6;
  highp float depth1_7;
  highp float depth0_8;
  highp float tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = (_LineWidth * 0.5);
  tmpvar_9 = floor(tmpvar_10);
  highp float tmpvar_11;
  tmpvar_11 = ceil(tmpvar_10);
  highp vec2 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD0 - (_MainTex_TexelSize.xy * tmpvar_9));
  highp vec2 tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD0 + (_MainTex_TexelSize.xy * tmpvar_11));
  highp vec2 tmpvar_14;
  tmpvar_14.x = (_MainTex_TexelSize.x * tmpvar_11);
  tmpvar_14.y = (-(_MainTex_TexelSize.y) * tmpvar_9);
  highp vec2 tmpvar_15;
  tmpvar_15 = (xlv_TEXCOORD0 + tmpvar_14);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (-(_MainTex_TexelSize.x) * tmpvar_9);
  tmpvar_16.y = (_MainTex_TexelSize.y * tmpvar_11);
  highp vec2 tmpvar_17;
  tmpvar_17 = (xlv_TEXCOORD0 + tmpvar_16);
  lowp float tmpvar_18;
  tmpvar_18 = texture2D (_CustomDepthTexture, tmpvar_12).x;
  depth0_8 = tmpvar_18;
  lowp float tmpvar_19;
  tmpvar_19 = texture2D (_CustomDepthTexture, tmpvar_13).x;
  depth1_7 = tmpvar_19;
  lowp float tmpvar_20;
  tmpvar_20 = texture2D (_CustomDepthTexture, tmpvar_15).x;
  depth2_6 = tmpvar_20;
  lowp float tmpvar_21;
  tmpvar_21 = texture2D (_CustomDepthTexture, tmpvar_17).x;
  depth3_5 = tmpvar_21;
  highp float tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (depth1_7 - depth0_8);
  highp float tmpvar_24;
  tmpvar_24 = (depth3_5 - depth2_6);
  tmpvar_22 = (sqrt((
    (tmpvar_23 * tmpvar_23)
   + 
    (tmpvar_24 * tmpvar_24)
  )) * 100.0);
  edgeDepth_4 = tmpvar_22;
  highp int tmpvar_25;
  if ((tmpvar_22 > (_DepthThreshold * depth0_8))) {
    tmpvar_25 = 1;
  } else {
    tmpvar_25 = 0;
  };
  edgeDepth_4 = float(tmpvar_25);
  highp float dist_26;
  dist_26 = (((1.0/(
    ((_ZBufferParams.x * max (max (depth0_8, depth1_7), max (depth2_6, depth3_5))) + _ZBufferParams.y)
  )) * _ProjectionParams.z) - _ProjectionParams.y);
  highp float tmpvar_27;
  tmpvar_27 = clamp (((dist_26 - _NearStart) / (_NearEnd - _NearStart)), 0.0, 1.0);
  highp float tmpvar_28;
  tmpvar_28 = clamp (((dist_26 - _FarStart) / (_FarEnd - _FarStart)), 0.0, 1.0);
  edgeDepth_4 = (edgeDepth_4 * ((
    (tmpvar_27 * (tmpvar_27 * (3.0 - (2.0 * tmpvar_27))))
   - 
    (tmpvar_28 * (tmpvar_28 * (3.0 - (2.0 * tmpvar_28))))
  ) * (1.0 - 
    clamp (((dist_26 - _LineMaxDist) * 100.0), 0.0, 1.0)
  )));
  highp vec4 tmpvar_29;
  tmpvar_29.xyz = _LineColor.xyz;
  tmpvar_29.w = (_LineColor.w * edgeDepth_4);
  edgeColor_3 = tmpvar_29;
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_2 = tmpvar_30;
  highp vec4 top_31;
  top_31 = edgeColor_3;
  highp vec4 bottom_32;
  bottom_32 = color_2;
  highp vec4 tmpvar_33;
  tmpvar_33.xyz = ((top_31.xyz * top_31.w) + (bottom_32.xyz * (1.0 - top_31.w)));
  tmpvar_33.w = bottom_32.w;
  finalColor_1 = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = mix (1.0, (1.0 + _ColorMultiplier), edgeDepth_4);
  finalColor_1.xyz = (finalColor_1.xyz * tmpvar_34);
  highp float tmpvar_35;
  tmpvar_35 = mix (finalColor_1.w, _BloomFactor, edgeDepth_4);
  finalColor_1.w = tmpvar_35;
  gl_FragData[0] = finalColor_1;
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