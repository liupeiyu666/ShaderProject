//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Character/Character_DLC/Avatar Face" {
Properties {
[MHYHelpBox(Info, Vertex Color B (outline width))] [MHYHeaderBox(OPTIONS)] [Enum(UnityEngine.Rendering.CullMode)] _CullMode ("Cull Mode", Float) = 2
_PolygonOffsetFactor ("Polygon Offset Factor", Float) = 0
_PolygonOffsetUnits ("Polygon Offset Units", Float) = 0
_OutlinePolygonOffsetFactor ("Outline Polygon Offset Factor", Float) = 0
_OutlinePolygonOffsetUnits ("Outline Polygon Offset Units", Float) = 0
[MHYHeaderBox(MAPS)] [MHYHeader(Main Maps)] [MHYSingleLineTextureNoScaleOffset(_Color)] _MainTex ("Albedo", 2D) = "white" { }
_Color ("Color", Color) = (1,1,1,1)
_EnvColor ("Env Color", Color) = (1,1,1,1)
[MHYSingleLineTextureNoScaleOffset] _LightMap ("Light Map |R (sepcular intensity) G (diffuse threshold) B (specular threshold)", 2D) = "grey" { }
[MHYSingleLineTextureNoScaleOffset] _FaceMap ("Face Map |A (distance field)", 2D) = "white" { }
[MHYTextureScaleOffset] _MainMaps_ST ("Main Maps ST", Vector) = (1,1,0,0)
[MHYHeaderBox(LIGHTING)] _BloomIntensity ("Bloom Intensity", Float) = 1
[MHYHeaderBox(DIFFUSE)] [Toggle(_FACEMAP_ON)] _EnableFaceMap ("Enable Face Map", Float) = 1
_ShadowColor ("Shadow Color", Color) = (0.5,0.5,0.5,1)
_ShadowThreshold ("Shadow Threshold", Range(0, 1)) = 0.5
_ShadowFeather ("Shadow Feather", Range(0.0001, 0.05)) = 0.0001
[MHYHeaderBox(OUTLINE)] _OutlineColor ("Outline Color", Color) = (0,0,0,1)
_OutlineWidth ("Outline Width", Range(0, 1)) = 0.1
[KeywordEnum(Normal, Tangent, UV2)] _OutlineNormalFrom ("Outline Normal From", Float) = 0
_Opaqueness ("Opaqueness", Range(0, 1)) = 1
[MHYHeaderBox(DITHER)] [Toggle(USINGDITHERALPAH)] _UsingDitherAlpha ("UsingDitherAlpha", Float) = 0
_DitherAlpha ("Dither Alpha Value", Range(0, 1)) = 1
}
SubShader {
 LOD 600
 Tags { "OutlineType" = "Complex" "PerformanceChecks" = "False" "QUEUE" = "Geometry+10" "RenderType" = "Opaque" }
 Pass {
  LOD 600
  Tags { "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "Complex" "PerformanceChecks" = "False" "QUEUE" = "Geometry+10" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 57777
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_4 = o_9;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  tmpvar_6 = normalize((_glesNormal * tmpvar_12));
  highp vec3 tmpvar_13;
  tmpvar_13 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_13;
  highp vec3 lightWorldDir_14;
  lightWorldDir_14 = lightDir_1;
  highp vec2 texcoord_15;
  texcoord_15 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_16;
  bool flipInYAxis_17;
  highp vec3 lightLocalDir_18;
  highp float tmpvar_19;
  tmpvar_19 = sqrt(dot (lightWorldDir_14, lightWorldDir_14));
  if ((tmpvar_19 < 0.9)) {
    tmpvar_16 = vec3(0.0, 1.0, 0.0);
  } else {
    highp mat3 tmpvar_20;
    tmpvar_20[0] = unity_WorldToObject[0].xyz;
    tmpvar_20[1] = unity_WorldToObject[1].xyz;
    tmpvar_20[2] = unity_WorldToObject[2].xyz;
    lightLocalDir_18 = (mat3(1.0, 0.0, 0.0, 0.0, 0.98481, -0.17365, 0.0, 0.17365, 0.98481) * (tmpvar_20 * lightWorldDir_14));
    highp float tmpvar_21;
    highp float tmpvar_22;
    tmpvar_22 = (min (abs(
      (lightLocalDir_18.z / lightLocalDir_18.y)
    ), 1.0) / max (abs(
      (lightLocalDir_18.z / lightLocalDir_18.y)
    ), 1.0));
    highp float tmpvar_23;
    tmpvar_23 = (tmpvar_22 * tmpvar_22);
    tmpvar_23 = (((
      ((((
        ((((-0.01213232 * tmpvar_23) + 0.05368138) * tmpvar_23) - 0.1173503)
       * tmpvar_23) + 0.1938925) * tmpvar_23) - 0.3326756)
     * tmpvar_23) + 0.9999793) * tmpvar_22);
    tmpvar_23 = (tmpvar_23 + (float(
      (abs((lightLocalDir_18.z / lightLocalDir_18.y)) > 1.0)
    ) * (
      (tmpvar_23 * -2.0)
     + 1.570796)));
    tmpvar_21 = (tmpvar_23 * sign((lightLocalDir_18.z / lightLocalDir_18.y)));
    if ((abs(lightLocalDir_18.y) > (1e-08 * abs(lightLocalDir_18.z)))) {
      if ((lightLocalDir_18.y < 0.0)) {
        if ((lightLocalDir_18.z >= 0.0)) {
          tmpvar_21 += 3.141593;
        } else {
          tmpvar_21 = (tmpvar_21 - 3.141593);
        };
      };
    } else {
      tmpvar_21 = (sign(lightLocalDir_18.z) * 1.570796);
    };
    highp float tmpvar_24;
    tmpvar_24 = (-(tmpvar_21) * 57.29578);
    flipInYAxis_17 = bool(0);
    if ((tmpvar_24 > 0.0)) {
      flipInYAxis_17 = bool(1);
    };
    highp float tmpvar_25;
    tmpvar_25 = clamp (abs((tmpvar_24 / 180.0)), 0.0001, 0.9999);
    if (flipInYAxis_17) {
      texcoord_15 = ((_glesMultiTexCoord0.xy * vec2(-1.0, 1.0)) + vec2(1.0, 0.0));
    };
    highp vec3 tmpvar_26;
    tmpvar_26.xy = texcoord_15;
    tmpvar_26.z = tmpvar_25;
    tmpvar_16 = tmpvar_26;
  };
  if (bool(_UsingDitherAlpha)) {
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_16;
  xlv_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _ShadowThreshold;
uniform mediump float _ShadowFeather;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 lightDir_1;
  mediump vec3 normalDir_2;
  mediump vec4 col_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = max ((_ShadowThreshold - _ShadowFeather), 0.0001);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((
    ((dot (normalDir_2, lightDir_1) * 0.5) + 0.5)
   - tmpvar_7) / (
    min ((_ShadowThreshold + _ShadowFeather), 0.9999)
   - tmpvar_7)), 0.0, 1.0);
  col_3.xyz = (mix (_ShadowColor, vec3(1.0, 1.0, 1.0), vec3((tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  ))) * ((tmpvar_4 * _Color) * _EnvColor).xyz);
  col_3.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_9;
    scrpos_9 = xlv_TEXCOORD2;
    mediump float a_10;
    a_10 = xlv_TEXCOORD2.z;
    if ((a_10 < 0.95)) {
      scrpos_9.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_10 = (a_10 * 17.0);
      highp float tmpvar_11;
      tmpvar_11 = (scrpos_9.y / 4.0);
      highp float tmpvar_12;
      tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
      highp float tmpvar_13;
      if ((tmpvar_11 >= 0.0)) {
        tmpvar_13 = tmpvar_12;
      } else {
        tmpvar_13 = -(tmpvar_12);
      };
      highp float tmpvar_14;
      tmpvar_14 = (scrpos_9.x / 4.0);
      highp float tmpvar_15;
      tmpvar_15 = (fract(abs(tmpvar_14)) * 4.0);
      highp float tmpvar_16;
      if ((tmpvar_14 >= 0.0)) {
        tmpvar_16 = tmpvar_15;
      } else {
        tmpvar_16 = -(tmpvar_15);
      };
      highp float x_17;
      x_17 = ((a_10 - _DITHERMATRIX[
        int(tmpvar_13)
      ][
        int(tmpvar_16)
      ]) - 0.01);
      if ((x_17 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_3;
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
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_4 = o_9;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  tmpvar_6 = normalize((_glesNormal * tmpvar_12));
  highp vec3 tmpvar_13;
  tmpvar_13 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_13;
  highp vec3 lightWorldDir_14;
  lightWorldDir_14 = lightDir_1;
  highp vec2 texcoord_15;
  texcoord_15 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_16;
  bool flipInYAxis_17;
  highp vec3 lightLocalDir_18;
  highp float tmpvar_19;
  tmpvar_19 = sqrt(dot (lightWorldDir_14, lightWorldDir_14));
  if ((tmpvar_19 < 0.9)) {
    tmpvar_16 = vec3(0.0, 1.0, 0.0);
  } else {
    highp mat3 tmpvar_20;
    tmpvar_20[0] = unity_WorldToObject[0].xyz;
    tmpvar_20[1] = unity_WorldToObject[1].xyz;
    tmpvar_20[2] = unity_WorldToObject[2].xyz;
    lightLocalDir_18 = (mat3(1.0, 0.0, 0.0, 0.0, 0.98481, -0.17365, 0.0, 0.17365, 0.98481) * (tmpvar_20 * lightWorldDir_14));
    highp float tmpvar_21;
    highp float tmpvar_22;
    tmpvar_22 = (min (abs(
      (lightLocalDir_18.z / lightLocalDir_18.y)
    ), 1.0) / max (abs(
      (lightLocalDir_18.z / lightLocalDir_18.y)
    ), 1.0));
    highp float tmpvar_23;
    tmpvar_23 = (tmpvar_22 * tmpvar_22);
    tmpvar_23 = (((
      ((((
        ((((-0.01213232 * tmpvar_23) + 0.05368138) * tmpvar_23) - 0.1173503)
       * tmpvar_23) + 0.1938925) * tmpvar_23) - 0.3326756)
     * tmpvar_23) + 0.9999793) * tmpvar_22);
    tmpvar_23 = (tmpvar_23 + (float(
      (abs((lightLocalDir_18.z / lightLocalDir_18.y)) > 1.0)
    ) * (
      (tmpvar_23 * -2.0)
     + 1.570796)));
    tmpvar_21 = (tmpvar_23 * sign((lightLocalDir_18.z / lightLocalDir_18.y)));
    if ((abs(lightLocalDir_18.y) > (1e-08 * abs(lightLocalDir_18.z)))) {
      if ((lightLocalDir_18.y < 0.0)) {
        if ((lightLocalDir_18.z >= 0.0)) {
          tmpvar_21 += 3.141593;
        } else {
          tmpvar_21 = (tmpvar_21 - 3.141593);
        };
      };
    } else {
      tmpvar_21 = (sign(lightLocalDir_18.z) * 1.570796);
    };
    highp float tmpvar_24;
    tmpvar_24 = (-(tmpvar_21) * 57.29578);
    flipInYAxis_17 = bool(0);
    if ((tmpvar_24 > 0.0)) {
      flipInYAxis_17 = bool(1);
    };
    highp float tmpvar_25;
    tmpvar_25 = clamp (abs((tmpvar_24 / 180.0)), 0.0001, 0.9999);
    if (flipInYAxis_17) {
      texcoord_15 = ((_glesMultiTexCoord0.xy * vec2(-1.0, 1.0)) + vec2(1.0, 0.0));
    };
    highp vec3 tmpvar_26;
    tmpvar_26.xy = texcoord_15;
    tmpvar_26.z = tmpvar_25;
    tmpvar_16 = tmpvar_26;
  };
  if (bool(_UsingDitherAlpha)) {
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_16;
  xlv_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _ShadowThreshold;
uniform mediump float _ShadowFeather;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 lightDir_1;
  mediump vec3 normalDir_2;
  mediump vec4 col_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = max ((_ShadowThreshold - _ShadowFeather), 0.0001);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((
    ((dot (normalDir_2, lightDir_1) * 0.5) + 0.5)
   - tmpvar_7) / (
    min ((_ShadowThreshold + _ShadowFeather), 0.9999)
   - tmpvar_7)), 0.0, 1.0);
  col_3.xyz = (mix (_ShadowColor, vec3(1.0, 1.0, 1.0), vec3((tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  ))) * ((tmpvar_4 * _Color) * _EnvColor).xyz);
  col_3.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_9;
    scrpos_9 = xlv_TEXCOORD2;
    mediump float a_10;
    a_10 = xlv_TEXCOORD2.z;
    if ((a_10 < 0.95)) {
      scrpos_9.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_10 = (a_10 * 17.0);
      highp float tmpvar_11;
      tmpvar_11 = (scrpos_9.y / 4.0);
      highp float tmpvar_12;
      tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
      highp float tmpvar_13;
      if ((tmpvar_11 >= 0.0)) {
        tmpvar_13 = tmpvar_12;
      } else {
        tmpvar_13 = -(tmpvar_12);
      };
      highp float tmpvar_14;
      tmpvar_14 = (scrpos_9.x / 4.0);
      highp float tmpvar_15;
      tmpvar_15 = (fract(abs(tmpvar_14)) * 4.0);
      highp float tmpvar_16;
      if ((tmpvar_14 >= 0.0)) {
        tmpvar_16 = tmpvar_15;
      } else {
        tmpvar_16 = -(tmpvar_15);
      };
      highp float x_17;
      x_17 = ((a_10 - _DITHERMATRIX[
        int(tmpvar_13)
      ][
        int(tmpvar_16)
      ]) - 0.01);
      if ((x_17 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_3;
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
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_4 = o_9;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  tmpvar_6 = normalize((_glesNormal * tmpvar_12));
  highp vec3 tmpvar_13;
  tmpvar_13 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_13;
  highp vec3 lightWorldDir_14;
  lightWorldDir_14 = lightDir_1;
  highp vec2 texcoord_15;
  texcoord_15 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_16;
  bool flipInYAxis_17;
  highp vec3 lightLocalDir_18;
  highp float tmpvar_19;
  tmpvar_19 = sqrt(dot (lightWorldDir_14, lightWorldDir_14));
  if ((tmpvar_19 < 0.9)) {
    tmpvar_16 = vec3(0.0, 1.0, 0.0);
  } else {
    highp mat3 tmpvar_20;
    tmpvar_20[0] = unity_WorldToObject[0].xyz;
    tmpvar_20[1] = unity_WorldToObject[1].xyz;
    tmpvar_20[2] = unity_WorldToObject[2].xyz;
    lightLocalDir_18 = (mat3(1.0, 0.0, 0.0, 0.0, 0.98481, -0.17365, 0.0, 0.17365, 0.98481) * (tmpvar_20 * lightWorldDir_14));
    highp float tmpvar_21;
    highp float tmpvar_22;
    tmpvar_22 = (min (abs(
      (lightLocalDir_18.z / lightLocalDir_18.y)
    ), 1.0) / max (abs(
      (lightLocalDir_18.z / lightLocalDir_18.y)
    ), 1.0));
    highp float tmpvar_23;
    tmpvar_23 = (tmpvar_22 * tmpvar_22);
    tmpvar_23 = (((
      ((((
        ((((-0.01213232 * tmpvar_23) + 0.05368138) * tmpvar_23) - 0.1173503)
       * tmpvar_23) + 0.1938925) * tmpvar_23) - 0.3326756)
     * tmpvar_23) + 0.9999793) * tmpvar_22);
    tmpvar_23 = (tmpvar_23 + (float(
      (abs((lightLocalDir_18.z / lightLocalDir_18.y)) > 1.0)
    ) * (
      (tmpvar_23 * -2.0)
     + 1.570796)));
    tmpvar_21 = (tmpvar_23 * sign((lightLocalDir_18.z / lightLocalDir_18.y)));
    if ((abs(lightLocalDir_18.y) > (1e-08 * abs(lightLocalDir_18.z)))) {
      if ((lightLocalDir_18.y < 0.0)) {
        if ((lightLocalDir_18.z >= 0.0)) {
          tmpvar_21 += 3.141593;
        } else {
          tmpvar_21 = (tmpvar_21 - 3.141593);
        };
      };
    } else {
      tmpvar_21 = (sign(lightLocalDir_18.z) * 1.570796);
    };
    highp float tmpvar_24;
    tmpvar_24 = (-(tmpvar_21) * 57.29578);
    flipInYAxis_17 = bool(0);
    if ((tmpvar_24 > 0.0)) {
      flipInYAxis_17 = bool(1);
    };
    highp float tmpvar_25;
    tmpvar_25 = clamp (abs((tmpvar_24 / 180.0)), 0.0001, 0.9999);
    if (flipInYAxis_17) {
      texcoord_15 = ((_glesMultiTexCoord0.xy * vec2(-1.0, 1.0)) + vec2(1.0, 0.0));
    };
    highp vec3 tmpvar_26;
    tmpvar_26.xy = texcoord_15;
    tmpvar_26.z = tmpvar_25;
    tmpvar_16 = tmpvar_26;
  };
  if (bool(_UsingDitherAlpha)) {
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_16;
  xlv_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _ShadowThreshold;
uniform mediump float _ShadowFeather;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 lightDir_1;
  mediump vec3 normalDir_2;
  mediump vec4 col_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = max ((_ShadowThreshold - _ShadowFeather), 0.0001);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((
    ((dot (normalDir_2, lightDir_1) * 0.5) + 0.5)
   - tmpvar_7) / (
    min ((_ShadowThreshold + _ShadowFeather), 0.9999)
   - tmpvar_7)), 0.0, 1.0);
  col_3.xyz = (mix (_ShadowColor, vec3(1.0, 1.0, 1.0), vec3((tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  ))) * ((tmpvar_4 * _Color) * _EnvColor).xyz);
  col_3.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_9;
    scrpos_9 = xlv_TEXCOORD2;
    mediump float a_10;
    a_10 = xlv_TEXCOORD2.z;
    if ((a_10 < 0.95)) {
      scrpos_9.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_10 = (a_10 * 17.0);
      highp float tmpvar_11;
      tmpvar_11 = (scrpos_9.y / 4.0);
      highp float tmpvar_12;
      tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
      highp float tmpvar_13;
      if ((tmpvar_11 >= 0.0)) {
        tmpvar_13 = tmpvar_12;
      } else {
        tmpvar_13 = -(tmpvar_12);
      };
      highp float tmpvar_14;
      tmpvar_14 = (scrpos_9.x / 4.0);
      highp float tmpvar_15;
      tmpvar_15 = (fract(abs(tmpvar_14)) * 4.0);
      highp float tmpvar_16;
      if ((tmpvar_14 >= 0.0)) {
        tmpvar_16 = tmpvar_15;
      } else {
        tmpvar_16 = -(tmpvar_15);
      };
      highp float x_17;
      x_17 = ((a_10 - _DITHERMATRIX[
        int(tmpvar_13)
      ][
        int(tmpvar_16)
      ]) - 0.01);
      if ((x_17 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_4 = o_10;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  tmpvar_6 = normalize((_glesNormal * tmpvar_13));
  highp vec3 tmpvar_14;
  tmpvar_14 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_14;
  highp vec3 lightWorldDir_15;
  lightWorldDir_15 = lightDir_1;
  highp vec2 texcoord_16;
  texcoord_16 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_17;
  bool flipInYAxis_18;
  highp vec3 lightLocalDir_19;
  highp float tmpvar_20;
  tmpvar_20 = sqrt(dot (lightWorldDir_15, lightWorldDir_15));
  if ((tmpvar_20 < 0.9)) {
    tmpvar_17 = vec3(0.0, 1.0, 0.0);
  } else {
    highp mat3 tmpvar_21;
    tmpvar_21[0] = unity_WorldToObject[0].xyz;
    tmpvar_21[1] = unity_WorldToObject[1].xyz;
    tmpvar_21[2] = unity_WorldToObject[2].xyz;
    lightLocalDir_19 = (mat3(1.0, 0.0, 0.0, 0.0, 0.98481, -0.17365, 0.0, 0.17365, 0.98481) * (tmpvar_21 * lightWorldDir_15));
    highp float tmpvar_22;
    highp float tmpvar_23;
    tmpvar_23 = (min (abs(
      (lightLocalDir_19.z / lightLocalDir_19.y)
    ), 1.0) / max (abs(
      (lightLocalDir_19.z / lightLocalDir_19.y)
    ), 1.0));
    highp float tmpvar_24;
    tmpvar_24 = (tmpvar_23 * tmpvar_23);
    tmpvar_24 = (((
      ((((
        ((((-0.01213232 * tmpvar_24) + 0.05368138) * tmpvar_24) - 0.1173503)
       * tmpvar_24) + 0.1938925) * tmpvar_24) - 0.3326756)
     * tmpvar_24) + 0.9999793) * tmpvar_23);
    tmpvar_24 = (tmpvar_24 + (float(
      (abs((lightLocalDir_19.z / lightLocalDir_19.y)) > 1.0)
    ) * (
      (tmpvar_24 * -2.0)
     + 1.570796)));
    tmpvar_22 = (tmpvar_24 * sign((lightLocalDir_19.z / lightLocalDir_19.y)));
    if ((abs(lightLocalDir_19.y) > (1e-08 * abs(lightLocalDir_19.z)))) {
      if ((lightLocalDir_19.y < 0.0)) {
        if ((lightLocalDir_19.z >= 0.0)) {
          tmpvar_22 += 3.141593;
        } else {
          tmpvar_22 = (tmpvar_22 - 3.141593);
        };
      };
    } else {
      tmpvar_22 = (sign(lightLocalDir_19.z) * 1.570796);
    };
    highp float tmpvar_25;
    tmpvar_25 = (-(tmpvar_22) * 57.29578);
    flipInYAxis_18 = bool(0);
    if ((tmpvar_25 > 0.0)) {
      flipInYAxis_18 = bool(1);
    };
    highp float tmpvar_26;
    tmpvar_26 = clamp (abs((tmpvar_25 / 180.0)), 0.0001, 0.9999);
    if (flipInYAxis_18) {
      texcoord_16 = ((_glesMultiTexCoord0.xy * vec2(-1.0, 1.0)) + vec2(1.0, 0.0));
    };
    highp vec3 tmpvar_27;
    tmpvar_27.xy = texcoord_16;
    tmpvar_27.z = tmpvar_26;
    tmpvar_17 = tmpvar_27;
  };
  mediump vec3 tmpvar_28;
  highp vec3 lightColor0_29;
  lightColor0_29 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_30;
  lightColor1_30 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_31;
  lightColor2_31 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_32;
  lightColor3_32 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_33;
  lightAttenSq_33 = unity_4LightAtten0;
  highp vec3 col_34;
  highp vec4 ndotl_35;
  highp vec4 lengthSq_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_38;
  tmpvar_38 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_39;
  tmpvar_39 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_36 = (tmpvar_37 * tmpvar_37);
  lengthSq_36 = (lengthSq_36 + (tmpvar_38 * tmpvar_38));
  lengthSq_36 = (lengthSq_36 + (tmpvar_39 * tmpvar_39));
  highp vec4 tmpvar_40;
  tmpvar_40 = max (lengthSq_36, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_36 = tmpvar_40;
  ndotl_35 = (tmpvar_37 * tmpvar_6.x);
  ndotl_35 = (ndotl_35 + (tmpvar_38 * tmpvar_6.y));
  ndotl_35 = (ndotl_35 + (tmpvar_39 * tmpvar_6.z));
  highp vec4 tmpvar_41;
  tmpvar_41 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_35 * inversesqrt(tmpvar_40)));
  ndotl_35 = tmpvar_41;
  highp vec4 tmpvar_42;
  tmpvar_42 = (tmpvar_41 * (1.0/((1.0 + 
    (tmpvar_40 * lightAttenSq_33)
  ))));
  col_34 = (lightColor0_29 * tmpvar_42.x);
  col_34 = (col_34 + (lightColor1_30 * tmpvar_42.y));
  col_34 = (col_34 + (lightColor2_31 * tmpvar_42.z));
  col_34 = (col_34 + (lightColor3_32 * tmpvar_42.w));
  tmpvar_28 = col_34;
  tmpvar_7.xyz = tmpvar_28;
  if (bool(_UsingDitherAlpha)) {
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_17;
  xlv_TEXCOORD6 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _ShadowThreshold;
uniform mediump float _ShadowFeather;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  mediump vec3 normalDir_2;
  mediump vec4 col_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = max ((_ShadowThreshold - _ShadowFeather), 0.0001);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((
    ((dot (normalDir_2, lightDir_1) * 0.5) + 0.5)
   - tmpvar_7) / (
    min ((_ShadowThreshold + _ShadowFeather), 0.9999)
   - tmpvar_7)), 0.0, 1.0);
  col_3.xyz = ((mix (_ShadowColor, vec3(1.0, 1.0, 1.0), vec3(
    (tmpvar_8 * (tmpvar_8 * (3.0 - (2.0 * tmpvar_8))))
  )) * (
    (tmpvar_4 * _Color)
   * _EnvColor).xyz) * (vec3(1.0, 1.0, 1.0) + xlv_TEXCOORD6.xyz));
  col_3.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_9;
    scrpos_9 = xlv_TEXCOORD2;
    mediump float a_10;
    a_10 = xlv_TEXCOORD2.z;
    if ((a_10 < 0.95)) {
      scrpos_9.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_10 = (a_10 * 17.0);
      highp float tmpvar_11;
      tmpvar_11 = (scrpos_9.y / 4.0);
      highp float tmpvar_12;
      tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
      highp float tmpvar_13;
      if ((tmpvar_11 >= 0.0)) {
        tmpvar_13 = tmpvar_12;
      } else {
        tmpvar_13 = -(tmpvar_12);
      };
      highp float tmpvar_14;
      tmpvar_14 = (scrpos_9.x / 4.0);
      highp float tmpvar_15;
      tmpvar_15 = (fract(abs(tmpvar_14)) * 4.0);
      highp float tmpvar_16;
      if ((tmpvar_14 >= 0.0)) {
        tmpvar_16 = tmpvar_15;
      } else {
        tmpvar_16 = -(tmpvar_15);
      };
      highp float x_17;
      x_17 = ((a_10 - _DITHERMATRIX[
        int(tmpvar_13)
      ][
        int(tmpvar_16)
      ]) - 0.01);
      if ((x_17 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_4 = o_10;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  tmpvar_6 = normalize((_glesNormal * tmpvar_13));
  highp vec3 tmpvar_14;
  tmpvar_14 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_14;
  highp vec3 lightWorldDir_15;
  lightWorldDir_15 = lightDir_1;
  highp vec2 texcoord_16;
  texcoord_16 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_17;
  bool flipInYAxis_18;
  highp vec3 lightLocalDir_19;
  highp float tmpvar_20;
  tmpvar_20 = sqrt(dot (lightWorldDir_15, lightWorldDir_15));
  if ((tmpvar_20 < 0.9)) {
    tmpvar_17 = vec3(0.0, 1.0, 0.0);
  } else {
    highp mat3 tmpvar_21;
    tmpvar_21[0] = unity_WorldToObject[0].xyz;
    tmpvar_21[1] = unity_WorldToObject[1].xyz;
    tmpvar_21[2] = unity_WorldToObject[2].xyz;
    lightLocalDir_19 = (mat3(1.0, 0.0, 0.0, 0.0, 0.98481, -0.17365, 0.0, 0.17365, 0.98481) * (tmpvar_21 * lightWorldDir_15));
    highp float tmpvar_22;
    highp float tmpvar_23;
    tmpvar_23 = (min (abs(
      (lightLocalDir_19.z / lightLocalDir_19.y)
    ), 1.0) / max (abs(
      (lightLocalDir_19.z / lightLocalDir_19.y)
    ), 1.0));
    highp float tmpvar_24;
    tmpvar_24 = (tmpvar_23 * tmpvar_23);
    tmpvar_24 = (((
      ((((
        ((((-0.01213232 * tmpvar_24) + 0.05368138) * tmpvar_24) - 0.1173503)
       * tmpvar_24) + 0.1938925) * tmpvar_24) - 0.3326756)
     * tmpvar_24) + 0.9999793) * tmpvar_23);
    tmpvar_24 = (tmpvar_24 + (float(
      (abs((lightLocalDir_19.z / lightLocalDir_19.y)) > 1.0)
    ) * (
      (tmpvar_24 * -2.0)
     + 1.570796)));
    tmpvar_22 = (tmpvar_24 * sign((lightLocalDir_19.z / lightLocalDir_19.y)));
    if ((abs(lightLocalDir_19.y) > (1e-08 * abs(lightLocalDir_19.z)))) {
      if ((lightLocalDir_19.y < 0.0)) {
        if ((lightLocalDir_19.z >= 0.0)) {
          tmpvar_22 += 3.141593;
        } else {
          tmpvar_22 = (tmpvar_22 - 3.141593);
        };
      };
    } else {
      tmpvar_22 = (sign(lightLocalDir_19.z) * 1.570796);
    };
    highp float tmpvar_25;
    tmpvar_25 = (-(tmpvar_22) * 57.29578);
    flipInYAxis_18 = bool(0);
    if ((tmpvar_25 > 0.0)) {
      flipInYAxis_18 = bool(1);
    };
    highp float tmpvar_26;
    tmpvar_26 = clamp (abs((tmpvar_25 / 180.0)), 0.0001, 0.9999);
    if (flipInYAxis_18) {
      texcoord_16 = ((_glesMultiTexCoord0.xy * vec2(-1.0, 1.0)) + vec2(1.0, 0.0));
    };
    highp vec3 tmpvar_27;
    tmpvar_27.xy = texcoord_16;
    tmpvar_27.z = tmpvar_26;
    tmpvar_17 = tmpvar_27;
  };
  mediump vec3 tmpvar_28;
  highp vec3 lightColor0_29;
  lightColor0_29 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_30;
  lightColor1_30 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_31;
  lightColor2_31 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_32;
  lightColor3_32 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_33;
  lightAttenSq_33 = unity_4LightAtten0;
  highp vec3 col_34;
  highp vec4 ndotl_35;
  highp vec4 lengthSq_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_38;
  tmpvar_38 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_39;
  tmpvar_39 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_36 = (tmpvar_37 * tmpvar_37);
  lengthSq_36 = (lengthSq_36 + (tmpvar_38 * tmpvar_38));
  lengthSq_36 = (lengthSq_36 + (tmpvar_39 * tmpvar_39));
  highp vec4 tmpvar_40;
  tmpvar_40 = max (lengthSq_36, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_36 = tmpvar_40;
  ndotl_35 = (tmpvar_37 * tmpvar_6.x);
  ndotl_35 = (ndotl_35 + (tmpvar_38 * tmpvar_6.y));
  ndotl_35 = (ndotl_35 + (tmpvar_39 * tmpvar_6.z));
  highp vec4 tmpvar_41;
  tmpvar_41 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_35 * inversesqrt(tmpvar_40)));
  ndotl_35 = tmpvar_41;
  highp vec4 tmpvar_42;
  tmpvar_42 = (tmpvar_41 * (1.0/((1.0 + 
    (tmpvar_40 * lightAttenSq_33)
  ))));
  col_34 = (lightColor0_29 * tmpvar_42.x);
  col_34 = (col_34 + (lightColor1_30 * tmpvar_42.y));
  col_34 = (col_34 + (lightColor2_31 * tmpvar_42.z));
  col_34 = (col_34 + (lightColor3_32 * tmpvar_42.w));
  tmpvar_28 = col_34;
  tmpvar_7.xyz = tmpvar_28;
  if (bool(_UsingDitherAlpha)) {
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_17;
  xlv_TEXCOORD6 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _ShadowThreshold;
uniform mediump float _ShadowFeather;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  mediump vec3 normalDir_2;
  mediump vec4 col_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = max ((_ShadowThreshold - _ShadowFeather), 0.0001);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((
    ((dot (normalDir_2, lightDir_1) * 0.5) + 0.5)
   - tmpvar_7) / (
    min ((_ShadowThreshold + _ShadowFeather), 0.9999)
   - tmpvar_7)), 0.0, 1.0);
  col_3.xyz = ((mix (_ShadowColor, vec3(1.0, 1.0, 1.0), vec3(
    (tmpvar_8 * (tmpvar_8 * (3.0 - (2.0 * tmpvar_8))))
  )) * (
    (tmpvar_4 * _Color)
   * _EnvColor).xyz) * (vec3(1.0, 1.0, 1.0) + xlv_TEXCOORD6.xyz));
  col_3.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_9;
    scrpos_9 = xlv_TEXCOORD2;
    mediump float a_10;
    a_10 = xlv_TEXCOORD2.z;
    if ((a_10 < 0.95)) {
      scrpos_9.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_10 = (a_10 * 17.0);
      highp float tmpvar_11;
      tmpvar_11 = (scrpos_9.y / 4.0);
      highp float tmpvar_12;
      tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
      highp float tmpvar_13;
      if ((tmpvar_11 >= 0.0)) {
        tmpvar_13 = tmpvar_12;
      } else {
        tmpvar_13 = -(tmpvar_12);
      };
      highp float tmpvar_14;
      tmpvar_14 = (scrpos_9.x / 4.0);
      highp float tmpvar_15;
      tmpvar_15 = (fract(abs(tmpvar_14)) * 4.0);
      highp float tmpvar_16;
      if ((tmpvar_14 >= 0.0)) {
        tmpvar_16 = tmpvar_15;
      } else {
        tmpvar_16 = -(tmpvar_15);
      };
      highp float x_17;
      x_17 = ((a_10 - _DITHERMATRIX[
        int(tmpvar_13)
      ][
        int(tmpvar_16)
      ]) - 0.01);
      if ((x_17 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_4 = o_10;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  tmpvar_6 = normalize((_glesNormal * tmpvar_13));
  highp vec3 tmpvar_14;
  tmpvar_14 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_14;
  highp vec3 lightWorldDir_15;
  lightWorldDir_15 = lightDir_1;
  highp vec2 texcoord_16;
  texcoord_16 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_17;
  bool flipInYAxis_18;
  highp vec3 lightLocalDir_19;
  highp float tmpvar_20;
  tmpvar_20 = sqrt(dot (lightWorldDir_15, lightWorldDir_15));
  if ((tmpvar_20 < 0.9)) {
    tmpvar_17 = vec3(0.0, 1.0, 0.0);
  } else {
    highp mat3 tmpvar_21;
    tmpvar_21[0] = unity_WorldToObject[0].xyz;
    tmpvar_21[1] = unity_WorldToObject[1].xyz;
    tmpvar_21[2] = unity_WorldToObject[2].xyz;
    lightLocalDir_19 = (mat3(1.0, 0.0, 0.0, 0.0, 0.98481, -0.17365, 0.0, 0.17365, 0.98481) * (tmpvar_21 * lightWorldDir_15));
    highp float tmpvar_22;
    highp float tmpvar_23;
    tmpvar_23 = (min (abs(
      (lightLocalDir_19.z / lightLocalDir_19.y)
    ), 1.0) / max (abs(
      (lightLocalDir_19.z / lightLocalDir_19.y)
    ), 1.0));
    highp float tmpvar_24;
    tmpvar_24 = (tmpvar_23 * tmpvar_23);
    tmpvar_24 = (((
      ((((
        ((((-0.01213232 * tmpvar_24) + 0.05368138) * tmpvar_24) - 0.1173503)
       * tmpvar_24) + 0.1938925) * tmpvar_24) - 0.3326756)
     * tmpvar_24) + 0.9999793) * tmpvar_23);
    tmpvar_24 = (tmpvar_24 + (float(
      (abs((lightLocalDir_19.z / lightLocalDir_19.y)) > 1.0)
    ) * (
      (tmpvar_24 * -2.0)
     + 1.570796)));
    tmpvar_22 = (tmpvar_24 * sign((lightLocalDir_19.z / lightLocalDir_19.y)));
    if ((abs(lightLocalDir_19.y) > (1e-08 * abs(lightLocalDir_19.z)))) {
      if ((lightLocalDir_19.y < 0.0)) {
        if ((lightLocalDir_19.z >= 0.0)) {
          tmpvar_22 += 3.141593;
        } else {
          tmpvar_22 = (tmpvar_22 - 3.141593);
        };
      };
    } else {
      tmpvar_22 = (sign(lightLocalDir_19.z) * 1.570796);
    };
    highp float tmpvar_25;
    tmpvar_25 = (-(tmpvar_22) * 57.29578);
    flipInYAxis_18 = bool(0);
    if ((tmpvar_25 > 0.0)) {
      flipInYAxis_18 = bool(1);
    };
    highp float tmpvar_26;
    tmpvar_26 = clamp (abs((tmpvar_25 / 180.0)), 0.0001, 0.9999);
    if (flipInYAxis_18) {
      texcoord_16 = ((_glesMultiTexCoord0.xy * vec2(-1.0, 1.0)) + vec2(1.0, 0.0));
    };
    highp vec3 tmpvar_27;
    tmpvar_27.xy = texcoord_16;
    tmpvar_27.z = tmpvar_26;
    tmpvar_17 = tmpvar_27;
  };
  mediump vec3 tmpvar_28;
  highp vec3 lightColor0_29;
  lightColor0_29 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_30;
  lightColor1_30 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_31;
  lightColor2_31 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_32;
  lightColor3_32 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_33;
  lightAttenSq_33 = unity_4LightAtten0;
  highp vec3 col_34;
  highp vec4 ndotl_35;
  highp vec4 lengthSq_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_38;
  tmpvar_38 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_39;
  tmpvar_39 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_36 = (tmpvar_37 * tmpvar_37);
  lengthSq_36 = (lengthSq_36 + (tmpvar_38 * tmpvar_38));
  lengthSq_36 = (lengthSq_36 + (tmpvar_39 * tmpvar_39));
  highp vec4 tmpvar_40;
  tmpvar_40 = max (lengthSq_36, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_36 = tmpvar_40;
  ndotl_35 = (tmpvar_37 * tmpvar_6.x);
  ndotl_35 = (ndotl_35 + (tmpvar_38 * tmpvar_6.y));
  ndotl_35 = (ndotl_35 + (tmpvar_39 * tmpvar_6.z));
  highp vec4 tmpvar_41;
  tmpvar_41 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_35 * inversesqrt(tmpvar_40)));
  ndotl_35 = tmpvar_41;
  highp vec4 tmpvar_42;
  tmpvar_42 = (tmpvar_41 * (1.0/((1.0 + 
    (tmpvar_40 * lightAttenSq_33)
  ))));
  col_34 = (lightColor0_29 * tmpvar_42.x);
  col_34 = (col_34 + (lightColor1_30 * tmpvar_42.y));
  col_34 = (col_34 + (lightColor2_31 * tmpvar_42.z));
  col_34 = (col_34 + (lightColor3_32 * tmpvar_42.w));
  tmpvar_28 = col_34;
  tmpvar_7.xyz = tmpvar_28;
  if (bool(_UsingDitherAlpha)) {
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_17;
  xlv_TEXCOORD6 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _ShadowThreshold;
uniform mediump float _ShadowFeather;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  mediump vec3 normalDir_2;
  mediump vec4 col_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = max ((_ShadowThreshold - _ShadowFeather), 0.0001);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((
    ((dot (normalDir_2, lightDir_1) * 0.5) + 0.5)
   - tmpvar_7) / (
    min ((_ShadowThreshold + _ShadowFeather), 0.9999)
   - tmpvar_7)), 0.0, 1.0);
  col_3.xyz = ((mix (_ShadowColor, vec3(1.0, 1.0, 1.0), vec3(
    (tmpvar_8 * (tmpvar_8 * (3.0 - (2.0 * tmpvar_8))))
  )) * (
    (tmpvar_4 * _Color)
   * _EnvColor).xyz) * (vec3(1.0, 1.0, 1.0) + xlv_TEXCOORD6.xyz));
  col_3.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_9;
    scrpos_9 = xlv_TEXCOORD2;
    mediump float a_10;
    a_10 = xlv_TEXCOORD2.z;
    if ((a_10 < 0.95)) {
      scrpos_9.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_10 = (a_10 * 17.0);
      highp float tmpvar_11;
      tmpvar_11 = (scrpos_9.y / 4.0);
      highp float tmpvar_12;
      tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
      highp float tmpvar_13;
      if ((tmpvar_11 >= 0.0)) {
        tmpvar_13 = tmpvar_12;
      } else {
        tmpvar_13 = -(tmpvar_12);
      };
      highp float tmpvar_14;
      tmpvar_14 = (scrpos_9.x / 4.0);
      highp float tmpvar_15;
      tmpvar_15 = (fract(abs(tmpvar_14)) * 4.0);
      highp float tmpvar_16;
      if ((tmpvar_14 >= 0.0)) {
        tmpvar_16 = tmpvar_15;
      } else {
        tmpvar_16 = -(tmpvar_15);
      };
      highp float x_17;
      x_17 = ((a_10 - _DITHERMATRIX[
        int(tmpvar_13)
      ][
        int(tmpvar_16)
      ]) - 0.01);
      if ((x_17 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_4 = o_9;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  tmpvar_6 = normalize((_glesNormal * tmpvar_12));
  highp vec3 tmpvar_13;
  tmpvar_13 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_13;
  highp vec3 lightWorldDir_14;
  lightWorldDir_14 = lightDir_1;
  highp vec2 texcoord_15;
  texcoord_15 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_16;
  bool flipInYAxis_17;
  highp vec3 lightLocalDir_18;
  highp float tmpvar_19;
  tmpvar_19 = sqrt(dot (lightWorldDir_14, lightWorldDir_14));
  if ((tmpvar_19 < 0.9)) {
    tmpvar_16 = vec3(0.0, 1.0, 0.0);
  } else {
    highp mat3 tmpvar_20;
    tmpvar_20[0] = unity_WorldToObject[0].xyz;
    tmpvar_20[1] = unity_WorldToObject[1].xyz;
    tmpvar_20[2] = unity_WorldToObject[2].xyz;
    lightLocalDir_18 = (mat3(1.0, 0.0, 0.0, 0.0, 0.98481, -0.17365, 0.0, 0.17365, 0.98481) * (tmpvar_20 * lightWorldDir_14));
    highp float tmpvar_21;
    highp float tmpvar_22;
    tmpvar_22 = (min (abs(
      (lightLocalDir_18.z / lightLocalDir_18.y)
    ), 1.0) / max (abs(
      (lightLocalDir_18.z / lightLocalDir_18.y)
    ), 1.0));
    highp float tmpvar_23;
    tmpvar_23 = (tmpvar_22 * tmpvar_22);
    tmpvar_23 = (((
      ((((
        ((((-0.01213232 * tmpvar_23) + 0.05368138) * tmpvar_23) - 0.1173503)
       * tmpvar_23) + 0.1938925) * tmpvar_23) - 0.3326756)
     * tmpvar_23) + 0.9999793) * tmpvar_22);
    tmpvar_23 = (tmpvar_23 + (float(
      (abs((lightLocalDir_18.z / lightLocalDir_18.y)) > 1.0)
    ) * (
      (tmpvar_23 * -2.0)
     + 1.570796)));
    tmpvar_21 = (tmpvar_23 * sign((lightLocalDir_18.z / lightLocalDir_18.y)));
    if ((abs(lightLocalDir_18.y) > (1e-08 * abs(lightLocalDir_18.z)))) {
      if ((lightLocalDir_18.y < 0.0)) {
        if ((lightLocalDir_18.z >= 0.0)) {
          tmpvar_21 += 3.141593;
        } else {
          tmpvar_21 = (tmpvar_21 - 3.141593);
        };
      };
    } else {
      tmpvar_21 = (sign(lightLocalDir_18.z) * 1.570796);
    };
    highp float tmpvar_24;
    tmpvar_24 = (-(tmpvar_21) * 57.29578);
    flipInYAxis_17 = bool(0);
    if ((tmpvar_24 > 0.0)) {
      flipInYAxis_17 = bool(1);
    };
    highp float tmpvar_25;
    tmpvar_25 = clamp (abs((tmpvar_24 / 180.0)), 0.0001, 0.9999);
    if (flipInYAxis_17) {
      texcoord_15 = ((_glesMultiTexCoord0.xy * vec2(-1.0, 1.0)) + vec2(1.0, 0.0));
    };
    highp vec3 tmpvar_26;
    tmpvar_26.xy = texcoord_15;
    tmpvar_26.z = tmpvar_25;
    tmpvar_16 = tmpvar_26;
  };
  if (bool(_UsingDitherAlpha)) {
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_16;
  xlv_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _ShadowThreshold;
uniform mediump float _ShadowFeather;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 lightDir_1;
  mediump vec3 normalDir_2;
  mediump vec4 col_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = max ((_ShadowThreshold - _ShadowFeather), 0.0001);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((
    ((dot (normalDir_2, lightDir_1) * 0.5) + 0.5)
   - tmpvar_7) / (
    min ((_ShadowThreshold + _ShadowFeather), 0.9999)
   - tmpvar_7)), 0.0, 1.0);
  col_3.xyz = (mix (_ShadowColor, vec3(1.0, 1.0, 1.0), vec3((tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  ))) * ((tmpvar_4 * _Color) * _EnvColor).xyz);
  col_3.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_9;
    scrpos_9 = xlv_TEXCOORD2;
    mediump float a_10;
    a_10 = xlv_TEXCOORD2.z;
    if ((a_10 < 0.95)) {
      scrpos_9.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_10 = (a_10 * 17.0);
      highp float tmpvar_11;
      tmpvar_11 = (scrpos_9.y / 4.0);
      highp float tmpvar_12;
      tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
      highp float tmpvar_13;
      if ((tmpvar_11 >= 0.0)) {
        tmpvar_13 = tmpvar_12;
      } else {
        tmpvar_13 = -(tmpvar_12);
      };
      highp float tmpvar_14;
      tmpvar_14 = (scrpos_9.x / 4.0);
      highp float tmpvar_15;
      tmpvar_15 = (fract(abs(tmpvar_14)) * 4.0);
      highp float tmpvar_16;
      if ((tmpvar_14 >= 0.0)) {
        tmpvar_16 = tmpvar_15;
      } else {
        tmpvar_16 = -(tmpvar_15);
      };
      highp float x_17;
      x_17 = ((a_10 - _DITHERMATRIX[
        int(tmpvar_13)
      ][
        int(tmpvar_16)
      ]) - 0.01);
      if ((x_17 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_4 = o_9;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  tmpvar_6 = normalize((_glesNormal * tmpvar_12));
  highp vec3 tmpvar_13;
  tmpvar_13 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_13;
  highp vec3 lightWorldDir_14;
  lightWorldDir_14 = lightDir_1;
  highp vec2 texcoord_15;
  texcoord_15 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_16;
  bool flipInYAxis_17;
  highp vec3 lightLocalDir_18;
  highp float tmpvar_19;
  tmpvar_19 = sqrt(dot (lightWorldDir_14, lightWorldDir_14));
  if ((tmpvar_19 < 0.9)) {
    tmpvar_16 = vec3(0.0, 1.0, 0.0);
  } else {
    highp mat3 tmpvar_20;
    tmpvar_20[0] = unity_WorldToObject[0].xyz;
    tmpvar_20[1] = unity_WorldToObject[1].xyz;
    tmpvar_20[2] = unity_WorldToObject[2].xyz;
    lightLocalDir_18 = (mat3(1.0, 0.0, 0.0, 0.0, 0.98481, -0.17365, 0.0, 0.17365, 0.98481) * (tmpvar_20 * lightWorldDir_14));
    highp float tmpvar_21;
    highp float tmpvar_22;
    tmpvar_22 = (min (abs(
      (lightLocalDir_18.z / lightLocalDir_18.y)
    ), 1.0) / max (abs(
      (lightLocalDir_18.z / lightLocalDir_18.y)
    ), 1.0));
    highp float tmpvar_23;
    tmpvar_23 = (tmpvar_22 * tmpvar_22);
    tmpvar_23 = (((
      ((((
        ((((-0.01213232 * tmpvar_23) + 0.05368138) * tmpvar_23) - 0.1173503)
       * tmpvar_23) + 0.1938925) * tmpvar_23) - 0.3326756)
     * tmpvar_23) + 0.9999793) * tmpvar_22);
    tmpvar_23 = (tmpvar_23 + (float(
      (abs((lightLocalDir_18.z / lightLocalDir_18.y)) > 1.0)
    ) * (
      (tmpvar_23 * -2.0)
     + 1.570796)));
    tmpvar_21 = (tmpvar_23 * sign((lightLocalDir_18.z / lightLocalDir_18.y)));
    if ((abs(lightLocalDir_18.y) > (1e-08 * abs(lightLocalDir_18.z)))) {
      if ((lightLocalDir_18.y < 0.0)) {
        if ((lightLocalDir_18.z >= 0.0)) {
          tmpvar_21 += 3.141593;
        } else {
          tmpvar_21 = (tmpvar_21 - 3.141593);
        };
      };
    } else {
      tmpvar_21 = (sign(lightLocalDir_18.z) * 1.570796);
    };
    highp float tmpvar_24;
    tmpvar_24 = (-(tmpvar_21) * 57.29578);
    flipInYAxis_17 = bool(0);
    if ((tmpvar_24 > 0.0)) {
      flipInYAxis_17 = bool(1);
    };
    highp float tmpvar_25;
    tmpvar_25 = clamp (abs((tmpvar_24 / 180.0)), 0.0001, 0.9999);
    if (flipInYAxis_17) {
      texcoord_15 = ((_glesMultiTexCoord0.xy * vec2(-1.0, 1.0)) + vec2(1.0, 0.0));
    };
    highp vec3 tmpvar_26;
    tmpvar_26.xy = texcoord_15;
    tmpvar_26.z = tmpvar_25;
    tmpvar_16 = tmpvar_26;
  };
  if (bool(_UsingDitherAlpha)) {
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_16;
  xlv_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _ShadowThreshold;
uniform mediump float _ShadowFeather;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 lightDir_1;
  mediump vec3 normalDir_2;
  mediump vec4 col_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = max ((_ShadowThreshold - _ShadowFeather), 0.0001);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((
    ((dot (normalDir_2, lightDir_1) * 0.5) + 0.5)
   - tmpvar_7) / (
    min ((_ShadowThreshold + _ShadowFeather), 0.9999)
   - tmpvar_7)), 0.0, 1.0);
  col_3.xyz = (mix (_ShadowColor, vec3(1.0, 1.0, 1.0), vec3((tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  ))) * ((tmpvar_4 * _Color) * _EnvColor).xyz);
  col_3.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_9;
    scrpos_9 = xlv_TEXCOORD2;
    mediump float a_10;
    a_10 = xlv_TEXCOORD2.z;
    if ((a_10 < 0.95)) {
      scrpos_9.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_10 = (a_10 * 17.0);
      highp float tmpvar_11;
      tmpvar_11 = (scrpos_9.y / 4.0);
      highp float tmpvar_12;
      tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
      highp float tmpvar_13;
      if ((tmpvar_11 >= 0.0)) {
        tmpvar_13 = tmpvar_12;
      } else {
        tmpvar_13 = -(tmpvar_12);
      };
      highp float tmpvar_14;
      tmpvar_14 = (scrpos_9.x / 4.0);
      highp float tmpvar_15;
      tmpvar_15 = (fract(abs(tmpvar_14)) * 4.0);
      highp float tmpvar_16;
      if ((tmpvar_14 >= 0.0)) {
        tmpvar_16 = tmpvar_15;
      } else {
        tmpvar_16 = -(tmpvar_15);
      };
      highp float x_17;
      x_17 = ((a_10 - _DITHERMATRIX[
        int(tmpvar_13)
      ][
        int(tmpvar_16)
      ]) - 0.01);
      if ((x_17 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_4 = o_9;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  tmpvar_6 = normalize((_glesNormal * tmpvar_12));
  highp vec3 tmpvar_13;
  tmpvar_13 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_13;
  highp vec3 lightWorldDir_14;
  lightWorldDir_14 = lightDir_1;
  highp vec2 texcoord_15;
  texcoord_15 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_16;
  bool flipInYAxis_17;
  highp vec3 lightLocalDir_18;
  highp float tmpvar_19;
  tmpvar_19 = sqrt(dot (lightWorldDir_14, lightWorldDir_14));
  if ((tmpvar_19 < 0.9)) {
    tmpvar_16 = vec3(0.0, 1.0, 0.0);
  } else {
    highp mat3 tmpvar_20;
    tmpvar_20[0] = unity_WorldToObject[0].xyz;
    tmpvar_20[1] = unity_WorldToObject[1].xyz;
    tmpvar_20[2] = unity_WorldToObject[2].xyz;
    lightLocalDir_18 = (mat3(1.0, 0.0, 0.0, 0.0, 0.98481, -0.17365, 0.0, 0.17365, 0.98481) * (tmpvar_20 * lightWorldDir_14));
    highp float tmpvar_21;
    highp float tmpvar_22;
    tmpvar_22 = (min (abs(
      (lightLocalDir_18.z / lightLocalDir_18.y)
    ), 1.0) / max (abs(
      (lightLocalDir_18.z / lightLocalDir_18.y)
    ), 1.0));
    highp float tmpvar_23;
    tmpvar_23 = (tmpvar_22 * tmpvar_22);
    tmpvar_23 = (((
      ((((
        ((((-0.01213232 * tmpvar_23) + 0.05368138) * tmpvar_23) - 0.1173503)
       * tmpvar_23) + 0.1938925) * tmpvar_23) - 0.3326756)
     * tmpvar_23) + 0.9999793) * tmpvar_22);
    tmpvar_23 = (tmpvar_23 + (float(
      (abs((lightLocalDir_18.z / lightLocalDir_18.y)) > 1.0)
    ) * (
      (tmpvar_23 * -2.0)
     + 1.570796)));
    tmpvar_21 = (tmpvar_23 * sign((lightLocalDir_18.z / lightLocalDir_18.y)));
    if ((abs(lightLocalDir_18.y) > (1e-08 * abs(lightLocalDir_18.z)))) {
      if ((lightLocalDir_18.y < 0.0)) {
        if ((lightLocalDir_18.z >= 0.0)) {
          tmpvar_21 += 3.141593;
        } else {
          tmpvar_21 = (tmpvar_21 - 3.141593);
        };
      };
    } else {
      tmpvar_21 = (sign(lightLocalDir_18.z) * 1.570796);
    };
    highp float tmpvar_24;
    tmpvar_24 = (-(tmpvar_21) * 57.29578);
    flipInYAxis_17 = bool(0);
    if ((tmpvar_24 > 0.0)) {
      flipInYAxis_17 = bool(1);
    };
    highp float tmpvar_25;
    tmpvar_25 = clamp (abs((tmpvar_24 / 180.0)), 0.0001, 0.9999);
    if (flipInYAxis_17) {
      texcoord_15 = ((_glesMultiTexCoord0.xy * vec2(-1.0, 1.0)) + vec2(1.0, 0.0));
    };
    highp vec3 tmpvar_26;
    tmpvar_26.xy = texcoord_15;
    tmpvar_26.z = tmpvar_25;
    tmpvar_16 = tmpvar_26;
  };
  if (bool(_UsingDitherAlpha)) {
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_16;
  xlv_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _ShadowThreshold;
uniform mediump float _ShadowFeather;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 lightDir_1;
  mediump vec3 normalDir_2;
  mediump vec4 col_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = max ((_ShadowThreshold - _ShadowFeather), 0.0001);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((
    ((dot (normalDir_2, lightDir_1) * 0.5) + 0.5)
   - tmpvar_7) / (
    min ((_ShadowThreshold + _ShadowFeather), 0.9999)
   - tmpvar_7)), 0.0, 1.0);
  col_3.xyz = (mix (_ShadowColor, vec3(1.0, 1.0, 1.0), vec3((tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  ))) * ((tmpvar_4 * _Color) * _EnvColor).xyz);
  col_3.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_9;
    scrpos_9 = xlv_TEXCOORD2;
    mediump float a_10;
    a_10 = xlv_TEXCOORD2.z;
    if ((a_10 < 0.95)) {
      scrpos_9.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_10 = (a_10 * 17.0);
      highp float tmpvar_11;
      tmpvar_11 = (scrpos_9.y / 4.0);
      highp float tmpvar_12;
      tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
      highp float tmpvar_13;
      if ((tmpvar_11 >= 0.0)) {
        tmpvar_13 = tmpvar_12;
      } else {
        tmpvar_13 = -(tmpvar_12);
      };
      highp float tmpvar_14;
      tmpvar_14 = (scrpos_9.x / 4.0);
      highp float tmpvar_15;
      tmpvar_15 = (fract(abs(tmpvar_14)) * 4.0);
      highp float tmpvar_16;
      if ((tmpvar_14 >= 0.0)) {
        tmpvar_16 = tmpvar_15;
      } else {
        tmpvar_16 = -(tmpvar_15);
      };
      highp float x_17;
      x_17 = ((a_10 - _DITHERMATRIX[
        int(tmpvar_13)
      ][
        int(tmpvar_16)
      ]) - 0.01);
      if ((x_17 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_4 = o_10;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  tmpvar_6 = normalize((_glesNormal * tmpvar_13));
  highp vec3 tmpvar_14;
  tmpvar_14 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_14;
  highp vec3 lightWorldDir_15;
  lightWorldDir_15 = lightDir_1;
  highp vec2 texcoord_16;
  texcoord_16 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_17;
  bool flipInYAxis_18;
  highp vec3 lightLocalDir_19;
  highp float tmpvar_20;
  tmpvar_20 = sqrt(dot (lightWorldDir_15, lightWorldDir_15));
  if ((tmpvar_20 < 0.9)) {
    tmpvar_17 = vec3(0.0, 1.0, 0.0);
  } else {
    highp mat3 tmpvar_21;
    tmpvar_21[0] = unity_WorldToObject[0].xyz;
    tmpvar_21[1] = unity_WorldToObject[1].xyz;
    tmpvar_21[2] = unity_WorldToObject[2].xyz;
    lightLocalDir_19 = (mat3(1.0, 0.0, 0.0, 0.0, 0.98481, -0.17365, 0.0, 0.17365, 0.98481) * (tmpvar_21 * lightWorldDir_15));
    highp float tmpvar_22;
    highp float tmpvar_23;
    tmpvar_23 = (min (abs(
      (lightLocalDir_19.z / lightLocalDir_19.y)
    ), 1.0) / max (abs(
      (lightLocalDir_19.z / lightLocalDir_19.y)
    ), 1.0));
    highp float tmpvar_24;
    tmpvar_24 = (tmpvar_23 * tmpvar_23);
    tmpvar_24 = (((
      ((((
        ((((-0.01213232 * tmpvar_24) + 0.05368138) * tmpvar_24) - 0.1173503)
       * tmpvar_24) + 0.1938925) * tmpvar_24) - 0.3326756)
     * tmpvar_24) + 0.9999793) * tmpvar_23);
    tmpvar_24 = (tmpvar_24 + (float(
      (abs((lightLocalDir_19.z / lightLocalDir_19.y)) > 1.0)
    ) * (
      (tmpvar_24 * -2.0)
     + 1.570796)));
    tmpvar_22 = (tmpvar_24 * sign((lightLocalDir_19.z / lightLocalDir_19.y)));
    if ((abs(lightLocalDir_19.y) > (1e-08 * abs(lightLocalDir_19.z)))) {
      if ((lightLocalDir_19.y < 0.0)) {
        if ((lightLocalDir_19.z >= 0.0)) {
          tmpvar_22 += 3.141593;
        } else {
          tmpvar_22 = (tmpvar_22 - 3.141593);
        };
      };
    } else {
      tmpvar_22 = (sign(lightLocalDir_19.z) * 1.570796);
    };
    highp float tmpvar_25;
    tmpvar_25 = (-(tmpvar_22) * 57.29578);
    flipInYAxis_18 = bool(0);
    if ((tmpvar_25 > 0.0)) {
      flipInYAxis_18 = bool(1);
    };
    highp float tmpvar_26;
    tmpvar_26 = clamp (abs((tmpvar_25 / 180.0)), 0.0001, 0.9999);
    if (flipInYAxis_18) {
      texcoord_16 = ((_glesMultiTexCoord0.xy * vec2(-1.0, 1.0)) + vec2(1.0, 0.0));
    };
    highp vec3 tmpvar_27;
    tmpvar_27.xy = texcoord_16;
    tmpvar_27.z = tmpvar_26;
    tmpvar_17 = tmpvar_27;
  };
  mediump vec3 tmpvar_28;
  highp vec3 lightColor0_29;
  lightColor0_29 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_30;
  lightColor1_30 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_31;
  lightColor2_31 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_32;
  lightColor3_32 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_33;
  lightAttenSq_33 = unity_4LightAtten0;
  highp vec3 col_34;
  highp vec4 ndotl_35;
  highp vec4 lengthSq_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_38;
  tmpvar_38 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_39;
  tmpvar_39 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_36 = (tmpvar_37 * tmpvar_37);
  lengthSq_36 = (lengthSq_36 + (tmpvar_38 * tmpvar_38));
  lengthSq_36 = (lengthSq_36 + (tmpvar_39 * tmpvar_39));
  highp vec4 tmpvar_40;
  tmpvar_40 = max (lengthSq_36, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_36 = tmpvar_40;
  ndotl_35 = (tmpvar_37 * tmpvar_6.x);
  ndotl_35 = (ndotl_35 + (tmpvar_38 * tmpvar_6.y));
  ndotl_35 = (ndotl_35 + (tmpvar_39 * tmpvar_6.z));
  highp vec4 tmpvar_41;
  tmpvar_41 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_35 * inversesqrt(tmpvar_40)));
  ndotl_35 = tmpvar_41;
  highp vec4 tmpvar_42;
  tmpvar_42 = (tmpvar_41 * (1.0/((1.0 + 
    (tmpvar_40 * lightAttenSq_33)
  ))));
  col_34 = (lightColor0_29 * tmpvar_42.x);
  col_34 = (col_34 + (lightColor1_30 * tmpvar_42.y));
  col_34 = (col_34 + (lightColor2_31 * tmpvar_42.z));
  col_34 = (col_34 + (lightColor3_32 * tmpvar_42.w));
  tmpvar_28 = col_34;
  tmpvar_7.xyz = tmpvar_28;
  if (bool(_UsingDitherAlpha)) {
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_17;
  xlv_TEXCOORD6 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _ShadowThreshold;
uniform mediump float _ShadowFeather;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  mediump vec3 normalDir_2;
  mediump vec4 col_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = max ((_ShadowThreshold - _ShadowFeather), 0.0001);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((
    ((dot (normalDir_2, lightDir_1) * 0.5) + 0.5)
   - tmpvar_7) / (
    min ((_ShadowThreshold + _ShadowFeather), 0.9999)
   - tmpvar_7)), 0.0, 1.0);
  col_3.xyz = ((mix (_ShadowColor, vec3(1.0, 1.0, 1.0), vec3(
    (tmpvar_8 * (tmpvar_8 * (3.0 - (2.0 * tmpvar_8))))
  )) * (
    (tmpvar_4 * _Color)
   * _EnvColor).xyz) * (vec3(1.0, 1.0, 1.0) + xlv_TEXCOORD6.xyz));
  col_3.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_9;
    scrpos_9 = xlv_TEXCOORD2;
    mediump float a_10;
    a_10 = xlv_TEXCOORD2.z;
    if ((a_10 < 0.95)) {
      scrpos_9.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_10 = (a_10 * 17.0);
      highp float tmpvar_11;
      tmpvar_11 = (scrpos_9.y / 4.0);
      highp float tmpvar_12;
      tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
      highp float tmpvar_13;
      if ((tmpvar_11 >= 0.0)) {
        tmpvar_13 = tmpvar_12;
      } else {
        tmpvar_13 = -(tmpvar_12);
      };
      highp float tmpvar_14;
      tmpvar_14 = (scrpos_9.x / 4.0);
      highp float tmpvar_15;
      tmpvar_15 = (fract(abs(tmpvar_14)) * 4.0);
      highp float tmpvar_16;
      if ((tmpvar_14 >= 0.0)) {
        tmpvar_16 = tmpvar_15;
      } else {
        tmpvar_16 = -(tmpvar_15);
      };
      highp float x_17;
      x_17 = ((a_10 - _DITHERMATRIX[
        int(tmpvar_13)
      ][
        int(tmpvar_16)
      ]) - 0.01);
      if ((x_17 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_4 = o_10;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  tmpvar_6 = normalize((_glesNormal * tmpvar_13));
  highp vec3 tmpvar_14;
  tmpvar_14 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_14;
  highp vec3 lightWorldDir_15;
  lightWorldDir_15 = lightDir_1;
  highp vec2 texcoord_16;
  texcoord_16 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_17;
  bool flipInYAxis_18;
  highp vec3 lightLocalDir_19;
  highp float tmpvar_20;
  tmpvar_20 = sqrt(dot (lightWorldDir_15, lightWorldDir_15));
  if ((tmpvar_20 < 0.9)) {
    tmpvar_17 = vec3(0.0, 1.0, 0.0);
  } else {
    highp mat3 tmpvar_21;
    tmpvar_21[0] = unity_WorldToObject[0].xyz;
    tmpvar_21[1] = unity_WorldToObject[1].xyz;
    tmpvar_21[2] = unity_WorldToObject[2].xyz;
    lightLocalDir_19 = (mat3(1.0, 0.0, 0.0, 0.0, 0.98481, -0.17365, 0.0, 0.17365, 0.98481) * (tmpvar_21 * lightWorldDir_15));
    highp float tmpvar_22;
    highp float tmpvar_23;
    tmpvar_23 = (min (abs(
      (lightLocalDir_19.z / lightLocalDir_19.y)
    ), 1.0) / max (abs(
      (lightLocalDir_19.z / lightLocalDir_19.y)
    ), 1.0));
    highp float tmpvar_24;
    tmpvar_24 = (tmpvar_23 * tmpvar_23);
    tmpvar_24 = (((
      ((((
        ((((-0.01213232 * tmpvar_24) + 0.05368138) * tmpvar_24) - 0.1173503)
       * tmpvar_24) + 0.1938925) * tmpvar_24) - 0.3326756)
     * tmpvar_24) + 0.9999793) * tmpvar_23);
    tmpvar_24 = (tmpvar_24 + (float(
      (abs((lightLocalDir_19.z / lightLocalDir_19.y)) > 1.0)
    ) * (
      (tmpvar_24 * -2.0)
     + 1.570796)));
    tmpvar_22 = (tmpvar_24 * sign((lightLocalDir_19.z / lightLocalDir_19.y)));
    if ((abs(lightLocalDir_19.y) > (1e-08 * abs(lightLocalDir_19.z)))) {
      if ((lightLocalDir_19.y < 0.0)) {
        if ((lightLocalDir_19.z >= 0.0)) {
          tmpvar_22 += 3.141593;
        } else {
          tmpvar_22 = (tmpvar_22 - 3.141593);
        };
      };
    } else {
      tmpvar_22 = (sign(lightLocalDir_19.z) * 1.570796);
    };
    highp float tmpvar_25;
    tmpvar_25 = (-(tmpvar_22) * 57.29578);
    flipInYAxis_18 = bool(0);
    if ((tmpvar_25 > 0.0)) {
      flipInYAxis_18 = bool(1);
    };
    highp float tmpvar_26;
    tmpvar_26 = clamp (abs((tmpvar_25 / 180.0)), 0.0001, 0.9999);
    if (flipInYAxis_18) {
      texcoord_16 = ((_glesMultiTexCoord0.xy * vec2(-1.0, 1.0)) + vec2(1.0, 0.0));
    };
    highp vec3 tmpvar_27;
    tmpvar_27.xy = texcoord_16;
    tmpvar_27.z = tmpvar_26;
    tmpvar_17 = tmpvar_27;
  };
  mediump vec3 tmpvar_28;
  highp vec3 lightColor0_29;
  lightColor0_29 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_30;
  lightColor1_30 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_31;
  lightColor2_31 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_32;
  lightColor3_32 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_33;
  lightAttenSq_33 = unity_4LightAtten0;
  highp vec3 col_34;
  highp vec4 ndotl_35;
  highp vec4 lengthSq_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_38;
  tmpvar_38 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_39;
  tmpvar_39 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_36 = (tmpvar_37 * tmpvar_37);
  lengthSq_36 = (lengthSq_36 + (tmpvar_38 * tmpvar_38));
  lengthSq_36 = (lengthSq_36 + (tmpvar_39 * tmpvar_39));
  highp vec4 tmpvar_40;
  tmpvar_40 = max (lengthSq_36, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_36 = tmpvar_40;
  ndotl_35 = (tmpvar_37 * tmpvar_6.x);
  ndotl_35 = (ndotl_35 + (tmpvar_38 * tmpvar_6.y));
  ndotl_35 = (ndotl_35 + (tmpvar_39 * tmpvar_6.z));
  highp vec4 tmpvar_41;
  tmpvar_41 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_35 * inversesqrt(tmpvar_40)));
  ndotl_35 = tmpvar_41;
  highp vec4 tmpvar_42;
  tmpvar_42 = (tmpvar_41 * (1.0/((1.0 + 
    (tmpvar_40 * lightAttenSq_33)
  ))));
  col_34 = (lightColor0_29 * tmpvar_42.x);
  col_34 = (col_34 + (lightColor1_30 * tmpvar_42.y));
  col_34 = (col_34 + (lightColor2_31 * tmpvar_42.z));
  col_34 = (col_34 + (lightColor3_32 * tmpvar_42.w));
  tmpvar_28 = col_34;
  tmpvar_7.xyz = tmpvar_28;
  if (bool(_UsingDitherAlpha)) {
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_17;
  xlv_TEXCOORD6 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _ShadowThreshold;
uniform mediump float _ShadowFeather;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  mediump vec3 normalDir_2;
  mediump vec4 col_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = max ((_ShadowThreshold - _ShadowFeather), 0.0001);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((
    ((dot (normalDir_2, lightDir_1) * 0.5) + 0.5)
   - tmpvar_7) / (
    min ((_ShadowThreshold + _ShadowFeather), 0.9999)
   - tmpvar_7)), 0.0, 1.0);
  col_3.xyz = ((mix (_ShadowColor, vec3(1.0, 1.0, 1.0), vec3(
    (tmpvar_8 * (tmpvar_8 * (3.0 - (2.0 * tmpvar_8))))
  )) * (
    (tmpvar_4 * _Color)
   * _EnvColor).xyz) * (vec3(1.0, 1.0, 1.0) + xlv_TEXCOORD6.xyz));
  col_3.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_9;
    scrpos_9 = xlv_TEXCOORD2;
    mediump float a_10;
    a_10 = xlv_TEXCOORD2.z;
    if ((a_10 < 0.95)) {
      scrpos_9.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_10 = (a_10 * 17.0);
      highp float tmpvar_11;
      tmpvar_11 = (scrpos_9.y / 4.0);
      highp float tmpvar_12;
      tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
      highp float tmpvar_13;
      if ((tmpvar_11 >= 0.0)) {
        tmpvar_13 = tmpvar_12;
      } else {
        tmpvar_13 = -(tmpvar_12);
      };
      highp float tmpvar_14;
      tmpvar_14 = (scrpos_9.x / 4.0);
      highp float tmpvar_15;
      tmpvar_15 = (fract(abs(tmpvar_14)) * 4.0);
      highp float tmpvar_16;
      if ((tmpvar_14 >= 0.0)) {
        tmpvar_16 = tmpvar_15;
      } else {
        tmpvar_16 = -(tmpvar_15);
      };
      highp float x_17;
      x_17 = ((a_10 - _DITHERMATRIX[
        int(tmpvar_13)
      ][
        int(tmpvar_16)
      ]) - 0.01);
      if ((x_17 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_4 = o_10;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  tmpvar_6 = normalize((_glesNormal * tmpvar_13));
  highp vec3 tmpvar_14;
  tmpvar_14 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_14;
  highp vec3 lightWorldDir_15;
  lightWorldDir_15 = lightDir_1;
  highp vec2 texcoord_16;
  texcoord_16 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_17;
  bool flipInYAxis_18;
  highp vec3 lightLocalDir_19;
  highp float tmpvar_20;
  tmpvar_20 = sqrt(dot (lightWorldDir_15, lightWorldDir_15));
  if ((tmpvar_20 < 0.9)) {
    tmpvar_17 = vec3(0.0, 1.0, 0.0);
  } else {
    highp mat3 tmpvar_21;
    tmpvar_21[0] = unity_WorldToObject[0].xyz;
    tmpvar_21[1] = unity_WorldToObject[1].xyz;
    tmpvar_21[2] = unity_WorldToObject[2].xyz;
    lightLocalDir_19 = (mat3(1.0, 0.0, 0.0, 0.0, 0.98481, -0.17365, 0.0, 0.17365, 0.98481) * (tmpvar_21 * lightWorldDir_15));
    highp float tmpvar_22;
    highp float tmpvar_23;
    tmpvar_23 = (min (abs(
      (lightLocalDir_19.z / lightLocalDir_19.y)
    ), 1.0) / max (abs(
      (lightLocalDir_19.z / lightLocalDir_19.y)
    ), 1.0));
    highp float tmpvar_24;
    tmpvar_24 = (tmpvar_23 * tmpvar_23);
    tmpvar_24 = (((
      ((((
        ((((-0.01213232 * tmpvar_24) + 0.05368138) * tmpvar_24) - 0.1173503)
       * tmpvar_24) + 0.1938925) * tmpvar_24) - 0.3326756)
     * tmpvar_24) + 0.9999793) * tmpvar_23);
    tmpvar_24 = (tmpvar_24 + (float(
      (abs((lightLocalDir_19.z / lightLocalDir_19.y)) > 1.0)
    ) * (
      (tmpvar_24 * -2.0)
     + 1.570796)));
    tmpvar_22 = (tmpvar_24 * sign((lightLocalDir_19.z / lightLocalDir_19.y)));
    if ((abs(lightLocalDir_19.y) > (1e-08 * abs(lightLocalDir_19.z)))) {
      if ((lightLocalDir_19.y < 0.0)) {
        if ((lightLocalDir_19.z >= 0.0)) {
          tmpvar_22 += 3.141593;
        } else {
          tmpvar_22 = (tmpvar_22 - 3.141593);
        };
      };
    } else {
      tmpvar_22 = (sign(lightLocalDir_19.z) * 1.570796);
    };
    highp float tmpvar_25;
    tmpvar_25 = (-(tmpvar_22) * 57.29578);
    flipInYAxis_18 = bool(0);
    if ((tmpvar_25 > 0.0)) {
      flipInYAxis_18 = bool(1);
    };
    highp float tmpvar_26;
    tmpvar_26 = clamp (abs((tmpvar_25 / 180.0)), 0.0001, 0.9999);
    if (flipInYAxis_18) {
      texcoord_16 = ((_glesMultiTexCoord0.xy * vec2(-1.0, 1.0)) + vec2(1.0, 0.0));
    };
    highp vec3 tmpvar_27;
    tmpvar_27.xy = texcoord_16;
    tmpvar_27.z = tmpvar_26;
    tmpvar_17 = tmpvar_27;
  };
  mediump vec3 tmpvar_28;
  highp vec3 lightColor0_29;
  lightColor0_29 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_30;
  lightColor1_30 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_31;
  lightColor2_31 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_32;
  lightColor3_32 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_33;
  lightAttenSq_33 = unity_4LightAtten0;
  highp vec3 col_34;
  highp vec4 ndotl_35;
  highp vec4 lengthSq_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_38;
  tmpvar_38 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_39;
  tmpvar_39 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_36 = (tmpvar_37 * tmpvar_37);
  lengthSq_36 = (lengthSq_36 + (tmpvar_38 * tmpvar_38));
  lengthSq_36 = (lengthSq_36 + (tmpvar_39 * tmpvar_39));
  highp vec4 tmpvar_40;
  tmpvar_40 = max (lengthSq_36, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_36 = tmpvar_40;
  ndotl_35 = (tmpvar_37 * tmpvar_6.x);
  ndotl_35 = (ndotl_35 + (tmpvar_38 * tmpvar_6.y));
  ndotl_35 = (ndotl_35 + (tmpvar_39 * tmpvar_6.z));
  highp vec4 tmpvar_41;
  tmpvar_41 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_35 * inversesqrt(tmpvar_40)));
  ndotl_35 = tmpvar_41;
  highp vec4 tmpvar_42;
  tmpvar_42 = (tmpvar_41 * (1.0/((1.0 + 
    (tmpvar_40 * lightAttenSq_33)
  ))));
  col_34 = (lightColor0_29 * tmpvar_42.x);
  col_34 = (col_34 + (lightColor1_30 * tmpvar_42.y));
  col_34 = (col_34 + (lightColor2_31 * tmpvar_42.z));
  col_34 = (col_34 + (lightColor3_32 * tmpvar_42.w));
  tmpvar_28 = col_34;
  tmpvar_7.xyz = tmpvar_28;
  if (bool(_UsingDitherAlpha)) {
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_17;
  xlv_TEXCOORD6 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _ShadowThreshold;
uniform mediump float _ShadowFeather;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  mediump vec3 normalDir_2;
  mediump vec4 col_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = max ((_ShadowThreshold - _ShadowFeather), 0.0001);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((
    ((dot (normalDir_2, lightDir_1) * 0.5) + 0.5)
   - tmpvar_7) / (
    min ((_ShadowThreshold + _ShadowFeather), 0.9999)
   - tmpvar_7)), 0.0, 1.0);
  col_3.xyz = ((mix (_ShadowColor, vec3(1.0, 1.0, 1.0), vec3(
    (tmpvar_8 * (tmpvar_8 * (3.0 - (2.0 * tmpvar_8))))
  )) * (
    (tmpvar_4 * _Color)
   * _EnvColor).xyz) * (vec3(1.0, 1.0, 1.0) + xlv_TEXCOORD6.xyz));
  col_3.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_9;
    scrpos_9 = xlv_TEXCOORD2;
    mediump float a_10;
    a_10 = xlv_TEXCOORD2.z;
    if ((a_10 < 0.95)) {
      scrpos_9.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_10 = (a_10 * 17.0);
      highp float tmpvar_11;
      tmpvar_11 = (scrpos_9.y / 4.0);
      highp float tmpvar_12;
      tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
      highp float tmpvar_13;
      if ((tmpvar_11 >= 0.0)) {
        tmpvar_13 = tmpvar_12;
      } else {
        tmpvar_13 = -(tmpvar_12);
      };
      highp float tmpvar_14;
      tmpvar_14 = (scrpos_9.x / 4.0);
      highp float tmpvar_15;
      tmpvar_15 = (fract(abs(tmpvar_14)) * 4.0);
      highp float tmpvar_16;
      if ((tmpvar_14 >= 0.0)) {
        tmpvar_16 = tmpvar_15;
      } else {
        tmpvar_16 = -(tmpvar_15);
      };
      highp float x_17;
      x_17 = ((a_10 - _DITHERMATRIX[
        int(tmpvar_13)
      ][
        int(tmpvar_16)
      ]) - 0.01);
      if ((x_17 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_FACEMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_4 = o_9;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  tmpvar_6 = normalize((_glesNormal * tmpvar_12));
  highp vec3 tmpvar_13;
  tmpvar_13 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_13;
  highp vec3 lightWorldDir_14;
  lightWorldDir_14 = lightDir_1;
  highp vec2 texcoord_15;
  texcoord_15 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_16;
  bool flipInYAxis_17;
  highp vec3 lightLocalDir_18;
  highp float tmpvar_19;
  tmpvar_19 = sqrt(dot (lightWorldDir_14, lightWorldDir_14));
  if ((tmpvar_19 < 0.9)) {
    tmpvar_16 = vec3(0.0, 1.0, 0.0);
  } else {
    highp mat3 tmpvar_20;
    tmpvar_20[0] = unity_WorldToObject[0].xyz;
    tmpvar_20[1] = unity_WorldToObject[1].xyz;
    tmpvar_20[2] = unity_WorldToObject[2].xyz;
    lightLocalDir_18 = (mat3(1.0, 0.0, 0.0, 0.0, 0.98481, -0.17365, 0.0, 0.17365, 0.98481) * (tmpvar_20 * lightWorldDir_14));
    highp float tmpvar_21;
    highp float tmpvar_22;
    tmpvar_22 = (min (abs(
      (lightLocalDir_18.z / lightLocalDir_18.y)
    ), 1.0) / max (abs(
      (lightLocalDir_18.z / lightLocalDir_18.y)
    ), 1.0));
    highp float tmpvar_23;
    tmpvar_23 = (tmpvar_22 * tmpvar_22);
    tmpvar_23 = (((
      ((((
        ((((-0.01213232 * tmpvar_23) + 0.05368138) * tmpvar_23) - 0.1173503)
       * tmpvar_23) + 0.1938925) * tmpvar_23) - 0.3326756)
     * tmpvar_23) + 0.9999793) * tmpvar_22);
    tmpvar_23 = (tmpvar_23 + (float(
      (abs((lightLocalDir_18.z / lightLocalDir_18.y)) > 1.0)
    ) * (
      (tmpvar_23 * -2.0)
     + 1.570796)));
    tmpvar_21 = (tmpvar_23 * sign((lightLocalDir_18.z / lightLocalDir_18.y)));
    if ((abs(lightLocalDir_18.y) > (1e-08 * abs(lightLocalDir_18.z)))) {
      if ((lightLocalDir_18.y < 0.0)) {
        if ((lightLocalDir_18.z >= 0.0)) {
          tmpvar_21 += 3.141593;
        } else {
          tmpvar_21 = (tmpvar_21 - 3.141593);
        };
      };
    } else {
      tmpvar_21 = (sign(lightLocalDir_18.z) * 1.570796);
    };
    highp float tmpvar_24;
    tmpvar_24 = (-(tmpvar_21) * 57.29578);
    flipInYAxis_17 = bool(0);
    if ((tmpvar_24 > 0.0)) {
      flipInYAxis_17 = bool(1);
    };
    highp float tmpvar_25;
    tmpvar_25 = clamp (abs((tmpvar_24 / 180.0)), 0.0001, 0.9999);
    if (flipInYAxis_17) {
      texcoord_15 = ((_glesMultiTexCoord0.xy * vec2(-1.0, 1.0)) + vec2(1.0, 0.0));
    };
    highp vec3 tmpvar_26;
    tmpvar_26.xy = texcoord_15;
    tmpvar_26.z = tmpvar_25;
    tmpvar_16 = tmpvar_26;
  };
  if (bool(_UsingDitherAlpha)) {
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_16;
  xlv_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _ShadowFeather;
uniform mediump float _UsingDitherAlpha;
uniform sampler2D _FaceMap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  mediump float diffuseThreshold_1;
  mediump vec4 col_2;
  mediump vec3 lightmap_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMap, xlv_TEXCOORD0).xyz;
  lightmap_3 = tmpvar_5;
  lowp float tmpvar_6;
  tmpvar_6 = texture2D (_FaceMap, xlv_TEXCOORD5.xy).w;
  diffuseThreshold_1 = tmpvar_6;
  mediump float lightingThreshold_7;
  lightingThreshold_7 = xlv_TEXCOORD5.z;
  mediump float tmpvar_8;
  tmpvar_8 = max ((lightingThreshold_7 - _ShadowFeather), 0.0001);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((diffuseThreshold_1 - tmpvar_8) / (
    min ((lightingThreshold_7 + _ShadowFeather), 0.9999)
   - tmpvar_8)), 0.0, 1.0);
  col_2.xyz = (mix (_ShadowColor, vec3(1.0, 1.0, 1.0), vec3((
    (tmpvar_9 * (tmpvar_9 * (3.0 - (2.0 * tmpvar_9))))
   * lightmap_3.y))) * ((tmpvar_4 * _Color) * _EnvColor).xyz);
  col_2.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_10;
    scrpos_10 = xlv_TEXCOORD2;
    mediump float a_11;
    a_11 = xlv_TEXCOORD2.z;
    if ((a_11 < 0.95)) {
      scrpos_10.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_11 = (a_11 * 17.0);
      highp float tmpvar_12;
      tmpvar_12 = (scrpos_10.y / 4.0);
      highp float tmpvar_13;
      tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
      highp float tmpvar_14;
      if ((tmpvar_12 >= 0.0)) {
        tmpvar_14 = tmpvar_13;
      } else {
        tmpvar_14 = -(tmpvar_13);
      };
      highp float tmpvar_15;
      tmpvar_15 = (scrpos_10.x / 4.0);
      highp float tmpvar_16;
      tmpvar_16 = (fract(abs(tmpvar_15)) * 4.0);
      highp float tmpvar_17;
      if ((tmpvar_15 >= 0.0)) {
        tmpvar_17 = tmpvar_16;
      } else {
        tmpvar_17 = -(tmpvar_16);
      };
      highp float x_18;
      x_18 = ((a_11 - _DITHERMATRIX[
        int(tmpvar_14)
      ][
        int(tmpvar_17)
      ]) - 0.01);
      if ((x_18 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_FACEMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_4 = o_9;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  tmpvar_6 = normalize((_glesNormal * tmpvar_12));
  highp vec3 tmpvar_13;
  tmpvar_13 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_13;
  highp vec3 lightWorldDir_14;
  lightWorldDir_14 = lightDir_1;
  highp vec2 texcoord_15;
  texcoord_15 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_16;
  bool flipInYAxis_17;
  highp vec3 lightLocalDir_18;
  highp float tmpvar_19;
  tmpvar_19 = sqrt(dot (lightWorldDir_14, lightWorldDir_14));
  if ((tmpvar_19 < 0.9)) {
    tmpvar_16 = vec3(0.0, 1.0, 0.0);
  } else {
    highp mat3 tmpvar_20;
    tmpvar_20[0] = unity_WorldToObject[0].xyz;
    tmpvar_20[1] = unity_WorldToObject[1].xyz;
    tmpvar_20[2] = unity_WorldToObject[2].xyz;
    lightLocalDir_18 = (mat3(1.0, 0.0, 0.0, 0.0, 0.98481, -0.17365, 0.0, 0.17365, 0.98481) * (tmpvar_20 * lightWorldDir_14));
    highp float tmpvar_21;
    highp float tmpvar_22;
    tmpvar_22 = (min (abs(
      (lightLocalDir_18.z / lightLocalDir_18.y)
    ), 1.0) / max (abs(
      (lightLocalDir_18.z / lightLocalDir_18.y)
    ), 1.0));
    highp float tmpvar_23;
    tmpvar_23 = (tmpvar_22 * tmpvar_22);
    tmpvar_23 = (((
      ((((
        ((((-0.01213232 * tmpvar_23) + 0.05368138) * tmpvar_23) - 0.1173503)
       * tmpvar_23) + 0.1938925) * tmpvar_23) - 0.3326756)
     * tmpvar_23) + 0.9999793) * tmpvar_22);
    tmpvar_23 = (tmpvar_23 + (float(
      (abs((lightLocalDir_18.z / lightLocalDir_18.y)) > 1.0)
    ) * (
      (tmpvar_23 * -2.0)
     + 1.570796)));
    tmpvar_21 = (tmpvar_23 * sign((lightLocalDir_18.z / lightLocalDir_18.y)));
    if ((abs(lightLocalDir_18.y) > (1e-08 * abs(lightLocalDir_18.z)))) {
      if ((lightLocalDir_18.y < 0.0)) {
        if ((lightLocalDir_18.z >= 0.0)) {
          tmpvar_21 += 3.141593;
        } else {
          tmpvar_21 = (tmpvar_21 - 3.141593);
        };
      };
    } else {
      tmpvar_21 = (sign(lightLocalDir_18.z) * 1.570796);
    };
    highp float tmpvar_24;
    tmpvar_24 = (-(tmpvar_21) * 57.29578);
    flipInYAxis_17 = bool(0);
    if ((tmpvar_24 > 0.0)) {
      flipInYAxis_17 = bool(1);
    };
    highp float tmpvar_25;
    tmpvar_25 = clamp (abs((tmpvar_24 / 180.0)), 0.0001, 0.9999);
    if (flipInYAxis_17) {
      texcoord_15 = ((_glesMultiTexCoord0.xy * vec2(-1.0, 1.0)) + vec2(1.0, 0.0));
    };
    highp vec3 tmpvar_26;
    tmpvar_26.xy = texcoord_15;
    tmpvar_26.z = tmpvar_25;
    tmpvar_16 = tmpvar_26;
  };
  if (bool(_UsingDitherAlpha)) {
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_16;
  xlv_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _ShadowFeather;
uniform mediump float _UsingDitherAlpha;
uniform sampler2D _FaceMap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  mediump float diffuseThreshold_1;
  mediump vec4 col_2;
  mediump vec3 lightmap_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMap, xlv_TEXCOORD0).xyz;
  lightmap_3 = tmpvar_5;
  lowp float tmpvar_6;
  tmpvar_6 = texture2D (_FaceMap, xlv_TEXCOORD5.xy).w;
  diffuseThreshold_1 = tmpvar_6;
  mediump float lightingThreshold_7;
  lightingThreshold_7 = xlv_TEXCOORD5.z;
  mediump float tmpvar_8;
  tmpvar_8 = max ((lightingThreshold_7 - _ShadowFeather), 0.0001);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((diffuseThreshold_1 - tmpvar_8) / (
    min ((lightingThreshold_7 + _ShadowFeather), 0.9999)
   - tmpvar_8)), 0.0, 1.0);
  col_2.xyz = (mix (_ShadowColor, vec3(1.0, 1.0, 1.0), vec3((
    (tmpvar_9 * (tmpvar_9 * (3.0 - (2.0 * tmpvar_9))))
   * lightmap_3.y))) * ((tmpvar_4 * _Color) * _EnvColor).xyz);
  col_2.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_10;
    scrpos_10 = xlv_TEXCOORD2;
    mediump float a_11;
    a_11 = xlv_TEXCOORD2.z;
    if ((a_11 < 0.95)) {
      scrpos_10.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_11 = (a_11 * 17.0);
      highp float tmpvar_12;
      tmpvar_12 = (scrpos_10.y / 4.0);
      highp float tmpvar_13;
      tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
      highp float tmpvar_14;
      if ((tmpvar_12 >= 0.0)) {
        tmpvar_14 = tmpvar_13;
      } else {
        tmpvar_14 = -(tmpvar_13);
      };
      highp float tmpvar_15;
      tmpvar_15 = (scrpos_10.x / 4.0);
      highp float tmpvar_16;
      tmpvar_16 = (fract(abs(tmpvar_15)) * 4.0);
      highp float tmpvar_17;
      if ((tmpvar_15 >= 0.0)) {
        tmpvar_17 = tmpvar_16;
      } else {
        tmpvar_17 = -(tmpvar_16);
      };
      highp float x_18;
      x_18 = ((a_11 - _DITHERMATRIX[
        int(tmpvar_14)
      ][
        int(tmpvar_17)
      ]) - 0.01);
      if ((x_18 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_FACEMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_4 = o_9;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  tmpvar_6 = normalize((_glesNormal * tmpvar_12));
  highp vec3 tmpvar_13;
  tmpvar_13 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_13;
  highp vec3 lightWorldDir_14;
  lightWorldDir_14 = lightDir_1;
  highp vec2 texcoord_15;
  texcoord_15 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_16;
  bool flipInYAxis_17;
  highp vec3 lightLocalDir_18;
  highp float tmpvar_19;
  tmpvar_19 = sqrt(dot (lightWorldDir_14, lightWorldDir_14));
  if ((tmpvar_19 < 0.9)) {
    tmpvar_16 = vec3(0.0, 1.0, 0.0);
  } else {
    highp mat3 tmpvar_20;
    tmpvar_20[0] = unity_WorldToObject[0].xyz;
    tmpvar_20[1] = unity_WorldToObject[1].xyz;
    tmpvar_20[2] = unity_WorldToObject[2].xyz;
    lightLocalDir_18 = (mat3(1.0, 0.0, 0.0, 0.0, 0.98481, -0.17365, 0.0, 0.17365, 0.98481) * (tmpvar_20 * lightWorldDir_14));
    highp float tmpvar_21;
    highp float tmpvar_22;
    tmpvar_22 = (min (abs(
      (lightLocalDir_18.z / lightLocalDir_18.y)
    ), 1.0) / max (abs(
      (lightLocalDir_18.z / lightLocalDir_18.y)
    ), 1.0));
    highp float tmpvar_23;
    tmpvar_23 = (tmpvar_22 * tmpvar_22);
    tmpvar_23 = (((
      ((((
        ((((-0.01213232 * tmpvar_23) + 0.05368138) * tmpvar_23) - 0.1173503)
       * tmpvar_23) + 0.1938925) * tmpvar_23) - 0.3326756)
     * tmpvar_23) + 0.9999793) * tmpvar_22);
    tmpvar_23 = (tmpvar_23 + (float(
      (abs((lightLocalDir_18.z / lightLocalDir_18.y)) > 1.0)
    ) * (
      (tmpvar_23 * -2.0)
     + 1.570796)));
    tmpvar_21 = (tmpvar_23 * sign((lightLocalDir_18.z / lightLocalDir_18.y)));
    if ((abs(lightLocalDir_18.y) > (1e-08 * abs(lightLocalDir_18.z)))) {
      if ((lightLocalDir_18.y < 0.0)) {
        if ((lightLocalDir_18.z >= 0.0)) {
          tmpvar_21 += 3.141593;
        } else {
          tmpvar_21 = (tmpvar_21 - 3.141593);
        };
      };
    } else {
      tmpvar_21 = (sign(lightLocalDir_18.z) * 1.570796);
    };
    highp float tmpvar_24;
    tmpvar_24 = (-(tmpvar_21) * 57.29578);
    flipInYAxis_17 = bool(0);
    if ((tmpvar_24 > 0.0)) {
      flipInYAxis_17 = bool(1);
    };
    highp float tmpvar_25;
    tmpvar_25 = clamp (abs((tmpvar_24 / 180.0)), 0.0001, 0.9999);
    if (flipInYAxis_17) {
      texcoord_15 = ((_glesMultiTexCoord0.xy * vec2(-1.0, 1.0)) + vec2(1.0, 0.0));
    };
    highp vec3 tmpvar_26;
    tmpvar_26.xy = texcoord_15;
    tmpvar_26.z = tmpvar_25;
    tmpvar_16 = tmpvar_26;
  };
  if (bool(_UsingDitherAlpha)) {
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_16;
  xlv_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _ShadowFeather;
uniform mediump float _UsingDitherAlpha;
uniform sampler2D _FaceMap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  mediump float diffuseThreshold_1;
  mediump vec4 col_2;
  mediump vec3 lightmap_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMap, xlv_TEXCOORD0).xyz;
  lightmap_3 = tmpvar_5;
  lowp float tmpvar_6;
  tmpvar_6 = texture2D (_FaceMap, xlv_TEXCOORD5.xy).w;
  diffuseThreshold_1 = tmpvar_6;
  mediump float lightingThreshold_7;
  lightingThreshold_7 = xlv_TEXCOORD5.z;
  mediump float tmpvar_8;
  tmpvar_8 = max ((lightingThreshold_7 - _ShadowFeather), 0.0001);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((diffuseThreshold_1 - tmpvar_8) / (
    min ((lightingThreshold_7 + _ShadowFeather), 0.9999)
   - tmpvar_8)), 0.0, 1.0);
  col_2.xyz = (mix (_ShadowColor, vec3(1.0, 1.0, 1.0), vec3((
    (tmpvar_9 * (tmpvar_9 * (3.0 - (2.0 * tmpvar_9))))
   * lightmap_3.y))) * ((tmpvar_4 * _Color) * _EnvColor).xyz);
  col_2.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_10;
    scrpos_10 = xlv_TEXCOORD2;
    mediump float a_11;
    a_11 = xlv_TEXCOORD2.z;
    if ((a_11 < 0.95)) {
      scrpos_10.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_11 = (a_11 * 17.0);
      highp float tmpvar_12;
      tmpvar_12 = (scrpos_10.y / 4.0);
      highp float tmpvar_13;
      tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
      highp float tmpvar_14;
      if ((tmpvar_12 >= 0.0)) {
        tmpvar_14 = tmpvar_13;
      } else {
        tmpvar_14 = -(tmpvar_13);
      };
      highp float tmpvar_15;
      tmpvar_15 = (scrpos_10.x / 4.0);
      highp float tmpvar_16;
      tmpvar_16 = (fract(abs(tmpvar_15)) * 4.0);
      highp float tmpvar_17;
      if ((tmpvar_15 >= 0.0)) {
        tmpvar_17 = tmpvar_16;
      } else {
        tmpvar_17 = -(tmpvar_16);
      };
      highp float x_18;
      x_18 = ((a_11 - _DITHERMATRIX[
        int(tmpvar_14)
      ][
        int(tmpvar_17)
      ]) - 0.01);
      if ((x_18 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "_FACEMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_4 = o_10;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  tmpvar_6 = normalize((_glesNormal * tmpvar_13));
  highp vec3 tmpvar_14;
  tmpvar_14 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_14;
  highp vec3 lightWorldDir_15;
  lightWorldDir_15 = lightDir_1;
  highp vec2 texcoord_16;
  texcoord_16 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_17;
  bool flipInYAxis_18;
  highp vec3 lightLocalDir_19;
  highp float tmpvar_20;
  tmpvar_20 = sqrt(dot (lightWorldDir_15, lightWorldDir_15));
  if ((tmpvar_20 < 0.9)) {
    tmpvar_17 = vec3(0.0, 1.0, 0.0);
  } else {
    highp mat3 tmpvar_21;
    tmpvar_21[0] = unity_WorldToObject[0].xyz;
    tmpvar_21[1] = unity_WorldToObject[1].xyz;
    tmpvar_21[2] = unity_WorldToObject[2].xyz;
    lightLocalDir_19 = (mat3(1.0, 0.0, 0.0, 0.0, 0.98481, -0.17365, 0.0, 0.17365, 0.98481) * (tmpvar_21 * lightWorldDir_15));
    highp float tmpvar_22;
    highp float tmpvar_23;
    tmpvar_23 = (min (abs(
      (lightLocalDir_19.z / lightLocalDir_19.y)
    ), 1.0) / max (abs(
      (lightLocalDir_19.z / lightLocalDir_19.y)
    ), 1.0));
    highp float tmpvar_24;
    tmpvar_24 = (tmpvar_23 * tmpvar_23);
    tmpvar_24 = (((
      ((((
        ((((-0.01213232 * tmpvar_24) + 0.05368138) * tmpvar_24) - 0.1173503)
       * tmpvar_24) + 0.1938925) * tmpvar_24) - 0.3326756)
     * tmpvar_24) + 0.9999793) * tmpvar_23);
    tmpvar_24 = (tmpvar_24 + (float(
      (abs((lightLocalDir_19.z / lightLocalDir_19.y)) > 1.0)
    ) * (
      (tmpvar_24 * -2.0)
     + 1.570796)));
    tmpvar_22 = (tmpvar_24 * sign((lightLocalDir_19.z / lightLocalDir_19.y)));
    if ((abs(lightLocalDir_19.y) > (1e-08 * abs(lightLocalDir_19.z)))) {
      if ((lightLocalDir_19.y < 0.0)) {
        if ((lightLocalDir_19.z >= 0.0)) {
          tmpvar_22 += 3.141593;
        } else {
          tmpvar_22 = (tmpvar_22 - 3.141593);
        };
      };
    } else {
      tmpvar_22 = (sign(lightLocalDir_19.z) * 1.570796);
    };
    highp float tmpvar_25;
    tmpvar_25 = (-(tmpvar_22) * 57.29578);
    flipInYAxis_18 = bool(0);
    if ((tmpvar_25 > 0.0)) {
      flipInYAxis_18 = bool(1);
    };
    highp float tmpvar_26;
    tmpvar_26 = clamp (abs((tmpvar_25 / 180.0)), 0.0001, 0.9999);
    if (flipInYAxis_18) {
      texcoord_16 = ((_glesMultiTexCoord0.xy * vec2(-1.0, 1.0)) + vec2(1.0, 0.0));
    };
    highp vec3 tmpvar_27;
    tmpvar_27.xy = texcoord_16;
    tmpvar_27.z = tmpvar_26;
    tmpvar_17 = tmpvar_27;
  };
  mediump vec3 tmpvar_28;
  highp vec3 lightColor0_29;
  lightColor0_29 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_30;
  lightColor1_30 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_31;
  lightColor2_31 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_32;
  lightColor3_32 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_33;
  lightAttenSq_33 = unity_4LightAtten0;
  highp vec3 col_34;
  highp vec4 ndotl_35;
  highp vec4 lengthSq_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_38;
  tmpvar_38 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_39;
  tmpvar_39 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_36 = (tmpvar_37 * tmpvar_37);
  lengthSq_36 = (lengthSq_36 + (tmpvar_38 * tmpvar_38));
  lengthSq_36 = (lengthSq_36 + (tmpvar_39 * tmpvar_39));
  highp vec4 tmpvar_40;
  tmpvar_40 = max (lengthSq_36, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_36 = tmpvar_40;
  ndotl_35 = (tmpvar_37 * tmpvar_6.x);
  ndotl_35 = (ndotl_35 + (tmpvar_38 * tmpvar_6.y));
  ndotl_35 = (ndotl_35 + (tmpvar_39 * tmpvar_6.z));
  highp vec4 tmpvar_41;
  tmpvar_41 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_35 * inversesqrt(tmpvar_40)));
  ndotl_35 = tmpvar_41;
  highp vec4 tmpvar_42;
  tmpvar_42 = (tmpvar_41 * (1.0/((1.0 + 
    (tmpvar_40 * lightAttenSq_33)
  ))));
  col_34 = (lightColor0_29 * tmpvar_42.x);
  col_34 = (col_34 + (lightColor1_30 * tmpvar_42.y));
  col_34 = (col_34 + (lightColor2_31 * tmpvar_42.z));
  col_34 = (col_34 + (lightColor3_32 * tmpvar_42.w));
  tmpvar_28 = col_34;
  tmpvar_7.xyz = tmpvar_28;
  if (bool(_UsingDitherAlpha)) {
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_17;
  xlv_TEXCOORD6 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _ShadowFeather;
uniform mediump float _UsingDitherAlpha;
uniform sampler2D _FaceMap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump float diffuseThreshold_1;
  mediump vec4 col_2;
  mediump vec3 lightmap_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMap, xlv_TEXCOORD0).xyz;
  lightmap_3 = tmpvar_5;
  lowp float tmpvar_6;
  tmpvar_6 = texture2D (_FaceMap, xlv_TEXCOORD5.xy).w;
  diffuseThreshold_1 = tmpvar_6;
  mediump float lightingThreshold_7;
  lightingThreshold_7 = xlv_TEXCOORD5.z;
  mediump float tmpvar_8;
  tmpvar_8 = max ((lightingThreshold_7 - _ShadowFeather), 0.0001);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((diffuseThreshold_1 - tmpvar_8) / (
    min ((lightingThreshold_7 + _ShadowFeather), 0.9999)
   - tmpvar_8)), 0.0, 1.0);
  col_2.xyz = ((mix (_ShadowColor, vec3(1.0, 1.0, 1.0), vec3(
    ((tmpvar_9 * (tmpvar_9 * (3.0 - 
      (2.0 * tmpvar_9)
    ))) * lightmap_3.y)
  )) * (
    (tmpvar_4 * _Color)
   * _EnvColor).xyz) * (vec3(1.0, 1.0, 1.0) + xlv_TEXCOORD6.xyz));
  col_2.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_10;
    scrpos_10 = xlv_TEXCOORD2;
    mediump float a_11;
    a_11 = xlv_TEXCOORD2.z;
    if ((a_11 < 0.95)) {
      scrpos_10.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_11 = (a_11 * 17.0);
      highp float tmpvar_12;
      tmpvar_12 = (scrpos_10.y / 4.0);
      highp float tmpvar_13;
      tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
      highp float tmpvar_14;
      if ((tmpvar_12 >= 0.0)) {
        tmpvar_14 = tmpvar_13;
      } else {
        tmpvar_14 = -(tmpvar_13);
      };
      highp float tmpvar_15;
      tmpvar_15 = (scrpos_10.x / 4.0);
      highp float tmpvar_16;
      tmpvar_16 = (fract(abs(tmpvar_15)) * 4.0);
      highp float tmpvar_17;
      if ((tmpvar_15 >= 0.0)) {
        tmpvar_17 = tmpvar_16;
      } else {
        tmpvar_17 = -(tmpvar_16);
      };
      highp float x_18;
      x_18 = ((a_11 - _DITHERMATRIX[
        int(tmpvar_14)
      ][
        int(tmpvar_17)
      ]) - 0.01);
      if ((x_18 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "_FACEMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_4 = o_10;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  tmpvar_6 = normalize((_glesNormal * tmpvar_13));
  highp vec3 tmpvar_14;
  tmpvar_14 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_14;
  highp vec3 lightWorldDir_15;
  lightWorldDir_15 = lightDir_1;
  highp vec2 texcoord_16;
  texcoord_16 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_17;
  bool flipInYAxis_18;
  highp vec3 lightLocalDir_19;
  highp float tmpvar_20;
  tmpvar_20 = sqrt(dot (lightWorldDir_15, lightWorldDir_15));
  if ((tmpvar_20 < 0.9)) {
    tmpvar_17 = vec3(0.0, 1.0, 0.0);
  } else {
    highp mat3 tmpvar_21;
    tmpvar_21[0] = unity_WorldToObject[0].xyz;
    tmpvar_21[1] = unity_WorldToObject[1].xyz;
    tmpvar_21[2] = unity_WorldToObject[2].xyz;
    lightLocalDir_19 = (mat3(1.0, 0.0, 0.0, 0.0, 0.98481, -0.17365, 0.0, 0.17365, 0.98481) * (tmpvar_21 * lightWorldDir_15));
    highp float tmpvar_22;
    highp float tmpvar_23;
    tmpvar_23 = (min (abs(
      (lightLocalDir_19.z / lightLocalDir_19.y)
    ), 1.0) / max (abs(
      (lightLocalDir_19.z / lightLocalDir_19.y)
    ), 1.0));
    highp float tmpvar_24;
    tmpvar_24 = (tmpvar_23 * tmpvar_23);
    tmpvar_24 = (((
      ((((
        ((((-0.01213232 * tmpvar_24) + 0.05368138) * tmpvar_24) - 0.1173503)
       * tmpvar_24) + 0.1938925) * tmpvar_24) - 0.3326756)
     * tmpvar_24) + 0.9999793) * tmpvar_23);
    tmpvar_24 = (tmpvar_24 + (float(
      (abs((lightLocalDir_19.z / lightLocalDir_19.y)) > 1.0)
    ) * (
      (tmpvar_24 * -2.0)
     + 1.570796)));
    tmpvar_22 = (tmpvar_24 * sign((lightLocalDir_19.z / lightLocalDir_19.y)));
    if ((abs(lightLocalDir_19.y) > (1e-08 * abs(lightLocalDir_19.z)))) {
      if ((lightLocalDir_19.y < 0.0)) {
        if ((lightLocalDir_19.z >= 0.0)) {
          tmpvar_22 += 3.141593;
        } else {
          tmpvar_22 = (tmpvar_22 - 3.141593);
        };
      };
    } else {
      tmpvar_22 = (sign(lightLocalDir_19.z) * 1.570796);
    };
    highp float tmpvar_25;
    tmpvar_25 = (-(tmpvar_22) * 57.29578);
    flipInYAxis_18 = bool(0);
    if ((tmpvar_25 > 0.0)) {
      flipInYAxis_18 = bool(1);
    };
    highp float tmpvar_26;
    tmpvar_26 = clamp (abs((tmpvar_25 / 180.0)), 0.0001, 0.9999);
    if (flipInYAxis_18) {
      texcoord_16 = ((_glesMultiTexCoord0.xy * vec2(-1.0, 1.0)) + vec2(1.0, 0.0));
    };
    highp vec3 tmpvar_27;
    tmpvar_27.xy = texcoord_16;
    tmpvar_27.z = tmpvar_26;
    tmpvar_17 = tmpvar_27;
  };
  mediump vec3 tmpvar_28;
  highp vec3 lightColor0_29;
  lightColor0_29 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_30;
  lightColor1_30 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_31;
  lightColor2_31 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_32;
  lightColor3_32 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_33;
  lightAttenSq_33 = unity_4LightAtten0;
  highp vec3 col_34;
  highp vec4 ndotl_35;
  highp vec4 lengthSq_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_38;
  tmpvar_38 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_39;
  tmpvar_39 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_36 = (tmpvar_37 * tmpvar_37);
  lengthSq_36 = (lengthSq_36 + (tmpvar_38 * tmpvar_38));
  lengthSq_36 = (lengthSq_36 + (tmpvar_39 * tmpvar_39));
  highp vec4 tmpvar_40;
  tmpvar_40 = max (lengthSq_36, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_36 = tmpvar_40;
  ndotl_35 = (tmpvar_37 * tmpvar_6.x);
  ndotl_35 = (ndotl_35 + (tmpvar_38 * tmpvar_6.y));
  ndotl_35 = (ndotl_35 + (tmpvar_39 * tmpvar_6.z));
  highp vec4 tmpvar_41;
  tmpvar_41 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_35 * inversesqrt(tmpvar_40)));
  ndotl_35 = tmpvar_41;
  highp vec4 tmpvar_42;
  tmpvar_42 = (tmpvar_41 * (1.0/((1.0 + 
    (tmpvar_40 * lightAttenSq_33)
  ))));
  col_34 = (lightColor0_29 * tmpvar_42.x);
  col_34 = (col_34 + (lightColor1_30 * tmpvar_42.y));
  col_34 = (col_34 + (lightColor2_31 * tmpvar_42.z));
  col_34 = (col_34 + (lightColor3_32 * tmpvar_42.w));
  tmpvar_28 = col_34;
  tmpvar_7.xyz = tmpvar_28;
  if (bool(_UsingDitherAlpha)) {
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_17;
  xlv_TEXCOORD6 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _ShadowFeather;
uniform mediump float _UsingDitherAlpha;
uniform sampler2D _FaceMap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump float diffuseThreshold_1;
  mediump vec4 col_2;
  mediump vec3 lightmap_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMap, xlv_TEXCOORD0).xyz;
  lightmap_3 = tmpvar_5;
  lowp float tmpvar_6;
  tmpvar_6 = texture2D (_FaceMap, xlv_TEXCOORD5.xy).w;
  diffuseThreshold_1 = tmpvar_6;
  mediump float lightingThreshold_7;
  lightingThreshold_7 = xlv_TEXCOORD5.z;
  mediump float tmpvar_8;
  tmpvar_8 = max ((lightingThreshold_7 - _ShadowFeather), 0.0001);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((diffuseThreshold_1 - tmpvar_8) / (
    min ((lightingThreshold_7 + _ShadowFeather), 0.9999)
   - tmpvar_8)), 0.0, 1.0);
  col_2.xyz = ((mix (_ShadowColor, vec3(1.0, 1.0, 1.0), vec3(
    ((tmpvar_9 * (tmpvar_9 * (3.0 - 
      (2.0 * tmpvar_9)
    ))) * lightmap_3.y)
  )) * (
    (tmpvar_4 * _Color)
   * _EnvColor).xyz) * (vec3(1.0, 1.0, 1.0) + xlv_TEXCOORD6.xyz));
  col_2.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_10;
    scrpos_10 = xlv_TEXCOORD2;
    mediump float a_11;
    a_11 = xlv_TEXCOORD2.z;
    if ((a_11 < 0.95)) {
      scrpos_10.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_11 = (a_11 * 17.0);
      highp float tmpvar_12;
      tmpvar_12 = (scrpos_10.y / 4.0);
      highp float tmpvar_13;
      tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
      highp float tmpvar_14;
      if ((tmpvar_12 >= 0.0)) {
        tmpvar_14 = tmpvar_13;
      } else {
        tmpvar_14 = -(tmpvar_13);
      };
      highp float tmpvar_15;
      tmpvar_15 = (scrpos_10.x / 4.0);
      highp float tmpvar_16;
      tmpvar_16 = (fract(abs(tmpvar_15)) * 4.0);
      highp float tmpvar_17;
      if ((tmpvar_15 >= 0.0)) {
        tmpvar_17 = tmpvar_16;
      } else {
        tmpvar_17 = -(tmpvar_16);
      };
      highp float x_18;
      x_18 = ((a_11 - _DITHERMATRIX[
        int(tmpvar_14)
      ][
        int(tmpvar_17)
      ]) - 0.01);
      if ((x_18 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "_FACEMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_4 = o_10;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  tmpvar_6 = normalize((_glesNormal * tmpvar_13));
  highp vec3 tmpvar_14;
  tmpvar_14 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_14;
  highp vec3 lightWorldDir_15;
  lightWorldDir_15 = lightDir_1;
  highp vec2 texcoord_16;
  texcoord_16 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_17;
  bool flipInYAxis_18;
  highp vec3 lightLocalDir_19;
  highp float tmpvar_20;
  tmpvar_20 = sqrt(dot (lightWorldDir_15, lightWorldDir_15));
  if ((tmpvar_20 < 0.9)) {
    tmpvar_17 = vec3(0.0, 1.0, 0.0);
  } else {
    highp mat3 tmpvar_21;
    tmpvar_21[0] = unity_WorldToObject[0].xyz;
    tmpvar_21[1] = unity_WorldToObject[1].xyz;
    tmpvar_21[2] = unity_WorldToObject[2].xyz;
    lightLocalDir_19 = (mat3(1.0, 0.0, 0.0, 0.0, 0.98481, -0.17365, 0.0, 0.17365, 0.98481) * (tmpvar_21 * lightWorldDir_15));
    highp float tmpvar_22;
    highp float tmpvar_23;
    tmpvar_23 = (min (abs(
      (lightLocalDir_19.z / lightLocalDir_19.y)
    ), 1.0) / max (abs(
      (lightLocalDir_19.z / lightLocalDir_19.y)
    ), 1.0));
    highp float tmpvar_24;
    tmpvar_24 = (tmpvar_23 * tmpvar_23);
    tmpvar_24 = (((
      ((((
        ((((-0.01213232 * tmpvar_24) + 0.05368138) * tmpvar_24) - 0.1173503)
       * tmpvar_24) + 0.1938925) * tmpvar_24) - 0.3326756)
     * tmpvar_24) + 0.9999793) * tmpvar_23);
    tmpvar_24 = (tmpvar_24 + (float(
      (abs((lightLocalDir_19.z / lightLocalDir_19.y)) > 1.0)
    ) * (
      (tmpvar_24 * -2.0)
     + 1.570796)));
    tmpvar_22 = (tmpvar_24 * sign((lightLocalDir_19.z / lightLocalDir_19.y)));
    if ((abs(lightLocalDir_19.y) > (1e-08 * abs(lightLocalDir_19.z)))) {
      if ((lightLocalDir_19.y < 0.0)) {
        if ((lightLocalDir_19.z >= 0.0)) {
          tmpvar_22 += 3.141593;
        } else {
          tmpvar_22 = (tmpvar_22 - 3.141593);
        };
      };
    } else {
      tmpvar_22 = (sign(lightLocalDir_19.z) * 1.570796);
    };
    highp float tmpvar_25;
    tmpvar_25 = (-(tmpvar_22) * 57.29578);
    flipInYAxis_18 = bool(0);
    if ((tmpvar_25 > 0.0)) {
      flipInYAxis_18 = bool(1);
    };
    highp float tmpvar_26;
    tmpvar_26 = clamp (abs((tmpvar_25 / 180.0)), 0.0001, 0.9999);
    if (flipInYAxis_18) {
      texcoord_16 = ((_glesMultiTexCoord0.xy * vec2(-1.0, 1.0)) + vec2(1.0, 0.0));
    };
    highp vec3 tmpvar_27;
    tmpvar_27.xy = texcoord_16;
    tmpvar_27.z = tmpvar_26;
    tmpvar_17 = tmpvar_27;
  };
  mediump vec3 tmpvar_28;
  highp vec3 lightColor0_29;
  lightColor0_29 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_30;
  lightColor1_30 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_31;
  lightColor2_31 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_32;
  lightColor3_32 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_33;
  lightAttenSq_33 = unity_4LightAtten0;
  highp vec3 col_34;
  highp vec4 ndotl_35;
  highp vec4 lengthSq_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_38;
  tmpvar_38 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_39;
  tmpvar_39 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_36 = (tmpvar_37 * tmpvar_37);
  lengthSq_36 = (lengthSq_36 + (tmpvar_38 * tmpvar_38));
  lengthSq_36 = (lengthSq_36 + (tmpvar_39 * tmpvar_39));
  highp vec4 tmpvar_40;
  tmpvar_40 = max (lengthSq_36, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_36 = tmpvar_40;
  ndotl_35 = (tmpvar_37 * tmpvar_6.x);
  ndotl_35 = (ndotl_35 + (tmpvar_38 * tmpvar_6.y));
  ndotl_35 = (ndotl_35 + (tmpvar_39 * tmpvar_6.z));
  highp vec4 tmpvar_41;
  tmpvar_41 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_35 * inversesqrt(tmpvar_40)));
  ndotl_35 = tmpvar_41;
  highp vec4 tmpvar_42;
  tmpvar_42 = (tmpvar_41 * (1.0/((1.0 + 
    (tmpvar_40 * lightAttenSq_33)
  ))));
  col_34 = (lightColor0_29 * tmpvar_42.x);
  col_34 = (col_34 + (lightColor1_30 * tmpvar_42.y));
  col_34 = (col_34 + (lightColor2_31 * tmpvar_42.z));
  col_34 = (col_34 + (lightColor3_32 * tmpvar_42.w));
  tmpvar_28 = col_34;
  tmpvar_7.xyz = tmpvar_28;
  if (bool(_UsingDitherAlpha)) {
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_17;
  xlv_TEXCOORD6 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _ShadowFeather;
uniform mediump float _UsingDitherAlpha;
uniform sampler2D _FaceMap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump float diffuseThreshold_1;
  mediump vec4 col_2;
  mediump vec3 lightmap_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMap, xlv_TEXCOORD0).xyz;
  lightmap_3 = tmpvar_5;
  lowp float tmpvar_6;
  tmpvar_6 = texture2D (_FaceMap, xlv_TEXCOORD5.xy).w;
  diffuseThreshold_1 = tmpvar_6;
  mediump float lightingThreshold_7;
  lightingThreshold_7 = xlv_TEXCOORD5.z;
  mediump float tmpvar_8;
  tmpvar_8 = max ((lightingThreshold_7 - _ShadowFeather), 0.0001);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((diffuseThreshold_1 - tmpvar_8) / (
    min ((lightingThreshold_7 + _ShadowFeather), 0.9999)
   - tmpvar_8)), 0.0, 1.0);
  col_2.xyz = ((mix (_ShadowColor, vec3(1.0, 1.0, 1.0), vec3(
    ((tmpvar_9 * (tmpvar_9 * (3.0 - 
      (2.0 * tmpvar_9)
    ))) * lightmap_3.y)
  )) * (
    (tmpvar_4 * _Color)
   * _EnvColor).xyz) * (vec3(1.0, 1.0, 1.0) + xlv_TEXCOORD6.xyz));
  col_2.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_10;
    scrpos_10 = xlv_TEXCOORD2;
    mediump float a_11;
    a_11 = xlv_TEXCOORD2.z;
    if ((a_11 < 0.95)) {
      scrpos_10.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_11 = (a_11 * 17.0);
      highp float tmpvar_12;
      tmpvar_12 = (scrpos_10.y / 4.0);
      highp float tmpvar_13;
      tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
      highp float tmpvar_14;
      if ((tmpvar_12 >= 0.0)) {
        tmpvar_14 = tmpvar_13;
      } else {
        tmpvar_14 = -(tmpvar_13);
      };
      highp float tmpvar_15;
      tmpvar_15 = (scrpos_10.x / 4.0);
      highp float tmpvar_16;
      tmpvar_16 = (fract(abs(tmpvar_15)) * 4.0);
      highp float tmpvar_17;
      if ((tmpvar_15 >= 0.0)) {
        tmpvar_17 = tmpvar_16;
      } else {
        tmpvar_17 = -(tmpvar_16);
      };
      highp float x_18;
      x_18 = ((a_11 - _DITHERMATRIX[
        int(tmpvar_14)
      ][
        int(tmpvar_17)
      ]) - 0.01);
      if ((x_18 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_FACEMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_4 = o_9;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  tmpvar_6 = normalize((_glesNormal * tmpvar_12));
  highp vec3 tmpvar_13;
  tmpvar_13 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_13;
  highp vec3 lightWorldDir_14;
  lightWorldDir_14 = lightDir_1;
  highp vec2 texcoord_15;
  texcoord_15 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_16;
  bool flipInYAxis_17;
  highp vec3 lightLocalDir_18;
  highp float tmpvar_19;
  tmpvar_19 = sqrt(dot (lightWorldDir_14, lightWorldDir_14));
  if ((tmpvar_19 < 0.9)) {
    tmpvar_16 = vec3(0.0, 1.0, 0.0);
  } else {
    highp mat3 tmpvar_20;
    tmpvar_20[0] = unity_WorldToObject[0].xyz;
    tmpvar_20[1] = unity_WorldToObject[1].xyz;
    tmpvar_20[2] = unity_WorldToObject[2].xyz;
    lightLocalDir_18 = (mat3(1.0, 0.0, 0.0, 0.0, 0.98481, -0.17365, 0.0, 0.17365, 0.98481) * (tmpvar_20 * lightWorldDir_14));
    highp float tmpvar_21;
    highp float tmpvar_22;
    tmpvar_22 = (min (abs(
      (lightLocalDir_18.z / lightLocalDir_18.y)
    ), 1.0) / max (abs(
      (lightLocalDir_18.z / lightLocalDir_18.y)
    ), 1.0));
    highp float tmpvar_23;
    tmpvar_23 = (tmpvar_22 * tmpvar_22);
    tmpvar_23 = (((
      ((((
        ((((-0.01213232 * tmpvar_23) + 0.05368138) * tmpvar_23) - 0.1173503)
       * tmpvar_23) + 0.1938925) * tmpvar_23) - 0.3326756)
     * tmpvar_23) + 0.9999793) * tmpvar_22);
    tmpvar_23 = (tmpvar_23 + (float(
      (abs((lightLocalDir_18.z / lightLocalDir_18.y)) > 1.0)
    ) * (
      (tmpvar_23 * -2.0)
     + 1.570796)));
    tmpvar_21 = (tmpvar_23 * sign((lightLocalDir_18.z / lightLocalDir_18.y)));
    if ((abs(lightLocalDir_18.y) > (1e-08 * abs(lightLocalDir_18.z)))) {
      if ((lightLocalDir_18.y < 0.0)) {
        if ((lightLocalDir_18.z >= 0.0)) {
          tmpvar_21 += 3.141593;
        } else {
          tmpvar_21 = (tmpvar_21 - 3.141593);
        };
      };
    } else {
      tmpvar_21 = (sign(lightLocalDir_18.z) * 1.570796);
    };
    highp float tmpvar_24;
    tmpvar_24 = (-(tmpvar_21) * 57.29578);
    flipInYAxis_17 = bool(0);
    if ((tmpvar_24 > 0.0)) {
      flipInYAxis_17 = bool(1);
    };
    highp float tmpvar_25;
    tmpvar_25 = clamp (abs((tmpvar_24 / 180.0)), 0.0001, 0.9999);
    if (flipInYAxis_17) {
      texcoord_15 = ((_glesMultiTexCoord0.xy * vec2(-1.0, 1.0)) + vec2(1.0, 0.0));
    };
    highp vec3 tmpvar_26;
    tmpvar_26.xy = texcoord_15;
    tmpvar_26.z = tmpvar_25;
    tmpvar_16 = tmpvar_26;
  };
  if (bool(_UsingDitherAlpha)) {
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_16;
  xlv_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _ShadowFeather;
uniform mediump float _UsingDitherAlpha;
uniform sampler2D _FaceMap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  mediump float diffuseThreshold_1;
  mediump vec4 col_2;
  mediump vec3 lightmap_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_5;
  tmpvar_5 = ((tmpvar_4 * _Color) * _EnvColor);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMap, xlv_TEXCOORD0).xyz;
  lightmap_3 = tmpvar_6;
  highp vec2 screenCoord_7;
  screenCoord_7 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_8;
  shadow_8 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_7);
    shadow_8 = tmpvar_9.x;
  };
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_FaceMap, xlv_TEXCOORD5.xy).w;
  diffuseThreshold_1 = tmpvar_10;
  mediump float lightingThreshold_11;
  lightingThreshold_11 = xlv_TEXCOORD5.z;
  mediump float tmpvar_12;
  tmpvar_12 = max ((lightingThreshold_11 - _ShadowFeather), 0.0001);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((diffuseThreshold_1 - tmpvar_12) / (
    min ((lightingThreshold_11 + _ShadowFeather), 0.9999)
   - tmpvar_12)), 0.0, 1.0);
  col_2.xyz = (mix (_ShadowColor, vec3(1.0, 1.0, 1.0), vec3((
    (tmpvar_13 * (tmpvar_13 * (3.0 - (2.0 * tmpvar_13))))
   * 
    (lightmap_3.y * shadow_8)
  ))) * tmpvar_5.xyz);
  col_2.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_14;
    scrpos_14 = xlv_TEXCOORD2;
    mediump float a_15;
    a_15 = xlv_TEXCOORD2.z;
    if ((a_15 < 0.95)) {
      scrpos_14.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_15 = (a_15 * 17.0);
      highp float tmpvar_16;
      tmpvar_16 = (scrpos_14.y / 4.0);
      highp float tmpvar_17;
      tmpvar_17 = (fract(abs(tmpvar_16)) * 4.0);
      highp float tmpvar_18;
      if ((tmpvar_16 >= 0.0)) {
        tmpvar_18 = tmpvar_17;
      } else {
        tmpvar_18 = -(tmpvar_17);
      };
      highp float tmpvar_19;
      tmpvar_19 = (scrpos_14.x / 4.0);
      highp float tmpvar_20;
      tmpvar_20 = (fract(abs(tmpvar_19)) * 4.0);
      highp float tmpvar_21;
      if ((tmpvar_19 >= 0.0)) {
        tmpvar_21 = tmpvar_20;
      } else {
        tmpvar_21 = -(tmpvar_20);
      };
      highp float x_22;
      x_22 = ((a_15 - _DITHERMATRIX[
        int(tmpvar_18)
      ][
        int(tmpvar_21)
      ]) - 0.01);
      if ((x_22 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_FACEMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_4 = o_9;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  tmpvar_6 = normalize((_glesNormal * tmpvar_12));
  highp vec3 tmpvar_13;
  tmpvar_13 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_13;
  highp vec3 lightWorldDir_14;
  lightWorldDir_14 = lightDir_1;
  highp vec2 texcoord_15;
  texcoord_15 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_16;
  bool flipInYAxis_17;
  highp vec3 lightLocalDir_18;
  highp float tmpvar_19;
  tmpvar_19 = sqrt(dot (lightWorldDir_14, lightWorldDir_14));
  if ((tmpvar_19 < 0.9)) {
    tmpvar_16 = vec3(0.0, 1.0, 0.0);
  } else {
    highp mat3 tmpvar_20;
    tmpvar_20[0] = unity_WorldToObject[0].xyz;
    tmpvar_20[1] = unity_WorldToObject[1].xyz;
    tmpvar_20[2] = unity_WorldToObject[2].xyz;
    lightLocalDir_18 = (mat3(1.0, 0.0, 0.0, 0.0, 0.98481, -0.17365, 0.0, 0.17365, 0.98481) * (tmpvar_20 * lightWorldDir_14));
    highp float tmpvar_21;
    highp float tmpvar_22;
    tmpvar_22 = (min (abs(
      (lightLocalDir_18.z / lightLocalDir_18.y)
    ), 1.0) / max (abs(
      (lightLocalDir_18.z / lightLocalDir_18.y)
    ), 1.0));
    highp float tmpvar_23;
    tmpvar_23 = (tmpvar_22 * tmpvar_22);
    tmpvar_23 = (((
      ((((
        ((((-0.01213232 * tmpvar_23) + 0.05368138) * tmpvar_23) - 0.1173503)
       * tmpvar_23) + 0.1938925) * tmpvar_23) - 0.3326756)
     * tmpvar_23) + 0.9999793) * tmpvar_22);
    tmpvar_23 = (tmpvar_23 + (float(
      (abs((lightLocalDir_18.z / lightLocalDir_18.y)) > 1.0)
    ) * (
      (tmpvar_23 * -2.0)
     + 1.570796)));
    tmpvar_21 = (tmpvar_23 * sign((lightLocalDir_18.z / lightLocalDir_18.y)));
    if ((abs(lightLocalDir_18.y) > (1e-08 * abs(lightLocalDir_18.z)))) {
      if ((lightLocalDir_18.y < 0.0)) {
        if ((lightLocalDir_18.z >= 0.0)) {
          tmpvar_21 += 3.141593;
        } else {
          tmpvar_21 = (tmpvar_21 - 3.141593);
        };
      };
    } else {
      tmpvar_21 = (sign(lightLocalDir_18.z) * 1.570796);
    };
    highp float tmpvar_24;
    tmpvar_24 = (-(tmpvar_21) * 57.29578);
    flipInYAxis_17 = bool(0);
    if ((tmpvar_24 > 0.0)) {
      flipInYAxis_17 = bool(1);
    };
    highp float tmpvar_25;
    tmpvar_25 = clamp (abs((tmpvar_24 / 180.0)), 0.0001, 0.9999);
    if (flipInYAxis_17) {
      texcoord_15 = ((_glesMultiTexCoord0.xy * vec2(-1.0, 1.0)) + vec2(1.0, 0.0));
    };
    highp vec3 tmpvar_26;
    tmpvar_26.xy = texcoord_15;
    tmpvar_26.z = tmpvar_25;
    tmpvar_16 = tmpvar_26;
  };
  if (bool(_UsingDitherAlpha)) {
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_16;
  xlv_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _ShadowFeather;
uniform mediump float _UsingDitherAlpha;
uniform sampler2D _FaceMap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  mediump float diffuseThreshold_1;
  mediump vec4 col_2;
  mediump vec3 lightmap_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_5;
  tmpvar_5 = ((tmpvar_4 * _Color) * _EnvColor);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMap, xlv_TEXCOORD0).xyz;
  lightmap_3 = tmpvar_6;
  highp vec2 screenCoord_7;
  screenCoord_7 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_8;
  shadow_8 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_7);
    shadow_8 = tmpvar_9.x;
  };
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_FaceMap, xlv_TEXCOORD5.xy).w;
  diffuseThreshold_1 = tmpvar_10;
  mediump float lightingThreshold_11;
  lightingThreshold_11 = xlv_TEXCOORD5.z;
  mediump float tmpvar_12;
  tmpvar_12 = max ((lightingThreshold_11 - _ShadowFeather), 0.0001);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((diffuseThreshold_1 - tmpvar_12) / (
    min ((lightingThreshold_11 + _ShadowFeather), 0.9999)
   - tmpvar_12)), 0.0, 1.0);
  col_2.xyz = (mix (_ShadowColor, vec3(1.0, 1.0, 1.0), vec3((
    (tmpvar_13 * (tmpvar_13 * (3.0 - (2.0 * tmpvar_13))))
   * 
    (lightmap_3.y * shadow_8)
  ))) * tmpvar_5.xyz);
  col_2.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_14;
    scrpos_14 = xlv_TEXCOORD2;
    mediump float a_15;
    a_15 = xlv_TEXCOORD2.z;
    if ((a_15 < 0.95)) {
      scrpos_14.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_15 = (a_15 * 17.0);
      highp float tmpvar_16;
      tmpvar_16 = (scrpos_14.y / 4.0);
      highp float tmpvar_17;
      tmpvar_17 = (fract(abs(tmpvar_16)) * 4.0);
      highp float tmpvar_18;
      if ((tmpvar_16 >= 0.0)) {
        tmpvar_18 = tmpvar_17;
      } else {
        tmpvar_18 = -(tmpvar_17);
      };
      highp float tmpvar_19;
      tmpvar_19 = (scrpos_14.x / 4.0);
      highp float tmpvar_20;
      tmpvar_20 = (fract(abs(tmpvar_19)) * 4.0);
      highp float tmpvar_21;
      if ((tmpvar_19 >= 0.0)) {
        tmpvar_21 = tmpvar_20;
      } else {
        tmpvar_21 = -(tmpvar_20);
      };
      highp float x_22;
      x_22 = ((a_15 - _DITHERMATRIX[
        int(tmpvar_18)
      ][
        int(tmpvar_21)
      ]) - 0.01);
      if ((x_22 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_FACEMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_4 = o_9;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  tmpvar_6 = normalize((_glesNormal * tmpvar_12));
  highp vec3 tmpvar_13;
  tmpvar_13 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_13;
  highp vec3 lightWorldDir_14;
  lightWorldDir_14 = lightDir_1;
  highp vec2 texcoord_15;
  texcoord_15 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_16;
  bool flipInYAxis_17;
  highp vec3 lightLocalDir_18;
  highp float tmpvar_19;
  tmpvar_19 = sqrt(dot (lightWorldDir_14, lightWorldDir_14));
  if ((tmpvar_19 < 0.9)) {
    tmpvar_16 = vec3(0.0, 1.0, 0.0);
  } else {
    highp mat3 tmpvar_20;
    tmpvar_20[0] = unity_WorldToObject[0].xyz;
    tmpvar_20[1] = unity_WorldToObject[1].xyz;
    tmpvar_20[2] = unity_WorldToObject[2].xyz;
    lightLocalDir_18 = (mat3(1.0, 0.0, 0.0, 0.0, 0.98481, -0.17365, 0.0, 0.17365, 0.98481) * (tmpvar_20 * lightWorldDir_14));
    highp float tmpvar_21;
    highp float tmpvar_22;
    tmpvar_22 = (min (abs(
      (lightLocalDir_18.z / lightLocalDir_18.y)
    ), 1.0) / max (abs(
      (lightLocalDir_18.z / lightLocalDir_18.y)
    ), 1.0));
    highp float tmpvar_23;
    tmpvar_23 = (tmpvar_22 * tmpvar_22);
    tmpvar_23 = (((
      ((((
        ((((-0.01213232 * tmpvar_23) + 0.05368138) * tmpvar_23) - 0.1173503)
       * tmpvar_23) + 0.1938925) * tmpvar_23) - 0.3326756)
     * tmpvar_23) + 0.9999793) * tmpvar_22);
    tmpvar_23 = (tmpvar_23 + (float(
      (abs((lightLocalDir_18.z / lightLocalDir_18.y)) > 1.0)
    ) * (
      (tmpvar_23 * -2.0)
     + 1.570796)));
    tmpvar_21 = (tmpvar_23 * sign((lightLocalDir_18.z / lightLocalDir_18.y)));
    if ((abs(lightLocalDir_18.y) > (1e-08 * abs(lightLocalDir_18.z)))) {
      if ((lightLocalDir_18.y < 0.0)) {
        if ((lightLocalDir_18.z >= 0.0)) {
          tmpvar_21 += 3.141593;
        } else {
          tmpvar_21 = (tmpvar_21 - 3.141593);
        };
      };
    } else {
      tmpvar_21 = (sign(lightLocalDir_18.z) * 1.570796);
    };
    highp float tmpvar_24;
    tmpvar_24 = (-(tmpvar_21) * 57.29578);
    flipInYAxis_17 = bool(0);
    if ((tmpvar_24 > 0.0)) {
      flipInYAxis_17 = bool(1);
    };
    highp float tmpvar_25;
    tmpvar_25 = clamp (abs((tmpvar_24 / 180.0)), 0.0001, 0.9999);
    if (flipInYAxis_17) {
      texcoord_15 = ((_glesMultiTexCoord0.xy * vec2(-1.0, 1.0)) + vec2(1.0, 0.0));
    };
    highp vec3 tmpvar_26;
    tmpvar_26.xy = texcoord_15;
    tmpvar_26.z = tmpvar_25;
    tmpvar_16 = tmpvar_26;
  };
  if (bool(_UsingDitherAlpha)) {
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_16;
  xlv_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _ShadowFeather;
uniform mediump float _UsingDitherAlpha;
uniform sampler2D _FaceMap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  mediump float diffuseThreshold_1;
  mediump vec4 col_2;
  mediump vec3 lightmap_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_5;
  tmpvar_5 = ((tmpvar_4 * _Color) * _EnvColor);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMap, xlv_TEXCOORD0).xyz;
  lightmap_3 = tmpvar_6;
  highp vec2 screenCoord_7;
  screenCoord_7 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_8;
  shadow_8 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_7);
    shadow_8 = tmpvar_9.x;
  };
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_FaceMap, xlv_TEXCOORD5.xy).w;
  diffuseThreshold_1 = tmpvar_10;
  mediump float lightingThreshold_11;
  lightingThreshold_11 = xlv_TEXCOORD5.z;
  mediump float tmpvar_12;
  tmpvar_12 = max ((lightingThreshold_11 - _ShadowFeather), 0.0001);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((diffuseThreshold_1 - tmpvar_12) / (
    min ((lightingThreshold_11 + _ShadowFeather), 0.9999)
   - tmpvar_12)), 0.0, 1.0);
  col_2.xyz = (mix (_ShadowColor, vec3(1.0, 1.0, 1.0), vec3((
    (tmpvar_13 * (tmpvar_13 * (3.0 - (2.0 * tmpvar_13))))
   * 
    (lightmap_3.y * shadow_8)
  ))) * tmpvar_5.xyz);
  col_2.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_14;
    scrpos_14 = xlv_TEXCOORD2;
    mediump float a_15;
    a_15 = xlv_TEXCOORD2.z;
    if ((a_15 < 0.95)) {
      scrpos_14.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_15 = (a_15 * 17.0);
      highp float tmpvar_16;
      tmpvar_16 = (scrpos_14.y / 4.0);
      highp float tmpvar_17;
      tmpvar_17 = (fract(abs(tmpvar_16)) * 4.0);
      highp float tmpvar_18;
      if ((tmpvar_16 >= 0.0)) {
        tmpvar_18 = tmpvar_17;
      } else {
        tmpvar_18 = -(tmpvar_17);
      };
      highp float tmpvar_19;
      tmpvar_19 = (scrpos_14.x / 4.0);
      highp float tmpvar_20;
      tmpvar_20 = (fract(abs(tmpvar_19)) * 4.0);
      highp float tmpvar_21;
      if ((tmpvar_19 >= 0.0)) {
        tmpvar_21 = tmpvar_20;
      } else {
        tmpvar_21 = -(tmpvar_20);
      };
      highp float x_22;
      x_22 = ((a_15 - _DITHERMATRIX[
        int(tmpvar_18)
      ][
        int(tmpvar_21)
      ]) - 0.01);
      if ((x_22 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_FACEMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_4 = o_10;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  tmpvar_6 = normalize((_glesNormal * tmpvar_13));
  highp vec3 tmpvar_14;
  tmpvar_14 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_14;
  highp vec3 lightWorldDir_15;
  lightWorldDir_15 = lightDir_1;
  highp vec2 texcoord_16;
  texcoord_16 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_17;
  bool flipInYAxis_18;
  highp vec3 lightLocalDir_19;
  highp float tmpvar_20;
  tmpvar_20 = sqrt(dot (lightWorldDir_15, lightWorldDir_15));
  if ((tmpvar_20 < 0.9)) {
    tmpvar_17 = vec3(0.0, 1.0, 0.0);
  } else {
    highp mat3 tmpvar_21;
    tmpvar_21[0] = unity_WorldToObject[0].xyz;
    tmpvar_21[1] = unity_WorldToObject[1].xyz;
    tmpvar_21[2] = unity_WorldToObject[2].xyz;
    lightLocalDir_19 = (mat3(1.0, 0.0, 0.0, 0.0, 0.98481, -0.17365, 0.0, 0.17365, 0.98481) * (tmpvar_21 * lightWorldDir_15));
    highp float tmpvar_22;
    highp float tmpvar_23;
    tmpvar_23 = (min (abs(
      (lightLocalDir_19.z / lightLocalDir_19.y)
    ), 1.0) / max (abs(
      (lightLocalDir_19.z / lightLocalDir_19.y)
    ), 1.0));
    highp float tmpvar_24;
    tmpvar_24 = (tmpvar_23 * tmpvar_23);
    tmpvar_24 = (((
      ((((
        ((((-0.01213232 * tmpvar_24) + 0.05368138) * tmpvar_24) - 0.1173503)
       * tmpvar_24) + 0.1938925) * tmpvar_24) - 0.3326756)
     * tmpvar_24) + 0.9999793) * tmpvar_23);
    tmpvar_24 = (tmpvar_24 + (float(
      (abs((lightLocalDir_19.z / lightLocalDir_19.y)) > 1.0)
    ) * (
      (tmpvar_24 * -2.0)
     + 1.570796)));
    tmpvar_22 = (tmpvar_24 * sign((lightLocalDir_19.z / lightLocalDir_19.y)));
    if ((abs(lightLocalDir_19.y) > (1e-08 * abs(lightLocalDir_19.z)))) {
      if ((lightLocalDir_19.y < 0.0)) {
        if ((lightLocalDir_19.z >= 0.0)) {
          tmpvar_22 += 3.141593;
        } else {
          tmpvar_22 = (tmpvar_22 - 3.141593);
        };
      };
    } else {
      tmpvar_22 = (sign(lightLocalDir_19.z) * 1.570796);
    };
    highp float tmpvar_25;
    tmpvar_25 = (-(tmpvar_22) * 57.29578);
    flipInYAxis_18 = bool(0);
    if ((tmpvar_25 > 0.0)) {
      flipInYAxis_18 = bool(1);
    };
    highp float tmpvar_26;
    tmpvar_26 = clamp (abs((tmpvar_25 / 180.0)), 0.0001, 0.9999);
    if (flipInYAxis_18) {
      texcoord_16 = ((_glesMultiTexCoord0.xy * vec2(-1.0, 1.0)) + vec2(1.0, 0.0));
    };
    highp vec3 tmpvar_27;
    tmpvar_27.xy = texcoord_16;
    tmpvar_27.z = tmpvar_26;
    tmpvar_17 = tmpvar_27;
  };
  mediump vec3 tmpvar_28;
  highp vec3 lightColor0_29;
  lightColor0_29 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_30;
  lightColor1_30 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_31;
  lightColor2_31 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_32;
  lightColor3_32 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_33;
  lightAttenSq_33 = unity_4LightAtten0;
  highp vec3 col_34;
  highp vec4 ndotl_35;
  highp vec4 lengthSq_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_38;
  tmpvar_38 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_39;
  tmpvar_39 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_36 = (tmpvar_37 * tmpvar_37);
  lengthSq_36 = (lengthSq_36 + (tmpvar_38 * tmpvar_38));
  lengthSq_36 = (lengthSq_36 + (tmpvar_39 * tmpvar_39));
  highp vec4 tmpvar_40;
  tmpvar_40 = max (lengthSq_36, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_36 = tmpvar_40;
  ndotl_35 = (tmpvar_37 * tmpvar_6.x);
  ndotl_35 = (ndotl_35 + (tmpvar_38 * tmpvar_6.y));
  ndotl_35 = (ndotl_35 + (tmpvar_39 * tmpvar_6.z));
  highp vec4 tmpvar_41;
  tmpvar_41 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_35 * inversesqrt(tmpvar_40)));
  ndotl_35 = tmpvar_41;
  highp vec4 tmpvar_42;
  tmpvar_42 = (tmpvar_41 * (1.0/((1.0 + 
    (tmpvar_40 * lightAttenSq_33)
  ))));
  col_34 = (lightColor0_29 * tmpvar_42.x);
  col_34 = (col_34 + (lightColor1_30 * tmpvar_42.y));
  col_34 = (col_34 + (lightColor2_31 * tmpvar_42.z));
  col_34 = (col_34 + (lightColor3_32 * tmpvar_42.w));
  tmpvar_28 = col_34;
  tmpvar_7.xyz = tmpvar_28;
  if (bool(_UsingDitherAlpha)) {
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_17;
  xlv_TEXCOORD6 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _ShadowFeather;
uniform mediump float _UsingDitherAlpha;
uniform sampler2D _FaceMap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump float diffuseThreshold_1;
  mediump vec4 col_2;
  mediump vec3 lightColor_3;
  mediump vec3 lightmap_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_6;
  tmpvar_6 = ((tmpvar_5 * _Color) * _EnvColor);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_LightMap, xlv_TEXCOORD0).xyz;
  lightmap_4 = tmpvar_7;
  lightColor_3 = (vec3(1.0, 1.0, 1.0) + xlv_TEXCOORD6.xyz);
  highp vec2 screenCoord_8;
  screenCoord_8 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_9;
  shadow_9 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_10;
    tmpvar_10 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_8);
    shadow_9 = tmpvar_10.x;
  };
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_FaceMap, xlv_TEXCOORD5.xy).w;
  diffuseThreshold_1 = tmpvar_11;
  mediump float lightingThreshold_12;
  lightingThreshold_12 = xlv_TEXCOORD5.z;
  mediump float tmpvar_13;
  tmpvar_13 = max ((lightingThreshold_12 - _ShadowFeather), 0.0001);
  mediump float tmpvar_14;
  tmpvar_14 = clamp (((diffuseThreshold_1 - tmpvar_13) / (
    min ((lightingThreshold_12 + _ShadowFeather), 0.9999)
   - tmpvar_13)), 0.0, 1.0);
  col_2.xyz = ((mix (_ShadowColor, vec3(1.0, 1.0, 1.0), vec3(
    ((tmpvar_14 * (tmpvar_14 * (3.0 - 
      (2.0 * tmpvar_14)
    ))) * (lightmap_4.y * shadow_9))
  )) * tmpvar_6.xyz) * lightColor_3);
  col_2.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_15;
    scrpos_15 = xlv_TEXCOORD2;
    mediump float a_16;
    a_16 = xlv_TEXCOORD2.z;
    if ((a_16 < 0.95)) {
      scrpos_15.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_16 = (a_16 * 17.0);
      highp float tmpvar_17;
      tmpvar_17 = (scrpos_15.y / 4.0);
      highp float tmpvar_18;
      tmpvar_18 = (fract(abs(tmpvar_17)) * 4.0);
      highp float tmpvar_19;
      if ((tmpvar_17 >= 0.0)) {
        tmpvar_19 = tmpvar_18;
      } else {
        tmpvar_19 = -(tmpvar_18);
      };
      highp float tmpvar_20;
      tmpvar_20 = (scrpos_15.x / 4.0);
      highp float tmpvar_21;
      tmpvar_21 = (fract(abs(tmpvar_20)) * 4.0);
      highp float tmpvar_22;
      if ((tmpvar_20 >= 0.0)) {
        tmpvar_22 = tmpvar_21;
      } else {
        tmpvar_22 = -(tmpvar_21);
      };
      highp float x_23;
      x_23 = ((a_16 - _DITHERMATRIX[
        int(tmpvar_19)
      ][
        int(tmpvar_22)
      ]) - 0.01);
      if ((x_23 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_FACEMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_4 = o_10;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  tmpvar_6 = normalize((_glesNormal * tmpvar_13));
  highp vec3 tmpvar_14;
  tmpvar_14 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_14;
  highp vec3 lightWorldDir_15;
  lightWorldDir_15 = lightDir_1;
  highp vec2 texcoord_16;
  texcoord_16 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_17;
  bool flipInYAxis_18;
  highp vec3 lightLocalDir_19;
  highp float tmpvar_20;
  tmpvar_20 = sqrt(dot (lightWorldDir_15, lightWorldDir_15));
  if ((tmpvar_20 < 0.9)) {
    tmpvar_17 = vec3(0.0, 1.0, 0.0);
  } else {
    highp mat3 tmpvar_21;
    tmpvar_21[0] = unity_WorldToObject[0].xyz;
    tmpvar_21[1] = unity_WorldToObject[1].xyz;
    tmpvar_21[2] = unity_WorldToObject[2].xyz;
    lightLocalDir_19 = (mat3(1.0, 0.0, 0.0, 0.0, 0.98481, -0.17365, 0.0, 0.17365, 0.98481) * (tmpvar_21 * lightWorldDir_15));
    highp float tmpvar_22;
    highp float tmpvar_23;
    tmpvar_23 = (min (abs(
      (lightLocalDir_19.z / lightLocalDir_19.y)
    ), 1.0) / max (abs(
      (lightLocalDir_19.z / lightLocalDir_19.y)
    ), 1.0));
    highp float tmpvar_24;
    tmpvar_24 = (tmpvar_23 * tmpvar_23);
    tmpvar_24 = (((
      ((((
        ((((-0.01213232 * tmpvar_24) + 0.05368138) * tmpvar_24) - 0.1173503)
       * tmpvar_24) + 0.1938925) * tmpvar_24) - 0.3326756)
     * tmpvar_24) + 0.9999793) * tmpvar_23);
    tmpvar_24 = (tmpvar_24 + (float(
      (abs((lightLocalDir_19.z / lightLocalDir_19.y)) > 1.0)
    ) * (
      (tmpvar_24 * -2.0)
     + 1.570796)));
    tmpvar_22 = (tmpvar_24 * sign((lightLocalDir_19.z / lightLocalDir_19.y)));
    if ((abs(lightLocalDir_19.y) > (1e-08 * abs(lightLocalDir_19.z)))) {
      if ((lightLocalDir_19.y < 0.0)) {
        if ((lightLocalDir_19.z >= 0.0)) {
          tmpvar_22 += 3.141593;
        } else {
          tmpvar_22 = (tmpvar_22 - 3.141593);
        };
      };
    } else {
      tmpvar_22 = (sign(lightLocalDir_19.z) * 1.570796);
    };
    highp float tmpvar_25;
    tmpvar_25 = (-(tmpvar_22) * 57.29578);
    flipInYAxis_18 = bool(0);
    if ((tmpvar_25 > 0.0)) {
      flipInYAxis_18 = bool(1);
    };
    highp float tmpvar_26;
    tmpvar_26 = clamp (abs((tmpvar_25 / 180.0)), 0.0001, 0.9999);
    if (flipInYAxis_18) {
      texcoord_16 = ((_glesMultiTexCoord0.xy * vec2(-1.0, 1.0)) + vec2(1.0, 0.0));
    };
    highp vec3 tmpvar_27;
    tmpvar_27.xy = texcoord_16;
    tmpvar_27.z = tmpvar_26;
    tmpvar_17 = tmpvar_27;
  };
  mediump vec3 tmpvar_28;
  highp vec3 lightColor0_29;
  lightColor0_29 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_30;
  lightColor1_30 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_31;
  lightColor2_31 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_32;
  lightColor3_32 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_33;
  lightAttenSq_33 = unity_4LightAtten0;
  highp vec3 col_34;
  highp vec4 ndotl_35;
  highp vec4 lengthSq_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_38;
  tmpvar_38 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_39;
  tmpvar_39 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_36 = (tmpvar_37 * tmpvar_37);
  lengthSq_36 = (lengthSq_36 + (tmpvar_38 * tmpvar_38));
  lengthSq_36 = (lengthSq_36 + (tmpvar_39 * tmpvar_39));
  highp vec4 tmpvar_40;
  tmpvar_40 = max (lengthSq_36, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_36 = tmpvar_40;
  ndotl_35 = (tmpvar_37 * tmpvar_6.x);
  ndotl_35 = (ndotl_35 + (tmpvar_38 * tmpvar_6.y));
  ndotl_35 = (ndotl_35 + (tmpvar_39 * tmpvar_6.z));
  highp vec4 tmpvar_41;
  tmpvar_41 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_35 * inversesqrt(tmpvar_40)));
  ndotl_35 = tmpvar_41;
  highp vec4 tmpvar_42;
  tmpvar_42 = (tmpvar_41 * (1.0/((1.0 + 
    (tmpvar_40 * lightAttenSq_33)
  ))));
  col_34 = (lightColor0_29 * tmpvar_42.x);
  col_34 = (col_34 + (lightColor1_30 * tmpvar_42.y));
  col_34 = (col_34 + (lightColor2_31 * tmpvar_42.z));
  col_34 = (col_34 + (lightColor3_32 * tmpvar_42.w));
  tmpvar_28 = col_34;
  tmpvar_7.xyz = tmpvar_28;
  if (bool(_UsingDitherAlpha)) {
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_17;
  xlv_TEXCOORD6 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _ShadowFeather;
uniform mediump float _UsingDitherAlpha;
uniform sampler2D _FaceMap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump float diffuseThreshold_1;
  mediump vec4 col_2;
  mediump vec3 lightColor_3;
  mediump vec3 lightmap_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_6;
  tmpvar_6 = ((tmpvar_5 * _Color) * _EnvColor);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_LightMap, xlv_TEXCOORD0).xyz;
  lightmap_4 = tmpvar_7;
  lightColor_3 = (vec3(1.0, 1.0, 1.0) + xlv_TEXCOORD6.xyz);
  highp vec2 screenCoord_8;
  screenCoord_8 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_9;
  shadow_9 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_10;
    tmpvar_10 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_8);
    shadow_9 = tmpvar_10.x;
  };
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_FaceMap, xlv_TEXCOORD5.xy).w;
  diffuseThreshold_1 = tmpvar_11;
  mediump float lightingThreshold_12;
  lightingThreshold_12 = xlv_TEXCOORD5.z;
  mediump float tmpvar_13;
  tmpvar_13 = max ((lightingThreshold_12 - _ShadowFeather), 0.0001);
  mediump float tmpvar_14;
  tmpvar_14 = clamp (((diffuseThreshold_1 - tmpvar_13) / (
    min ((lightingThreshold_12 + _ShadowFeather), 0.9999)
   - tmpvar_13)), 0.0, 1.0);
  col_2.xyz = ((mix (_ShadowColor, vec3(1.0, 1.0, 1.0), vec3(
    ((tmpvar_14 * (tmpvar_14 * (3.0 - 
      (2.0 * tmpvar_14)
    ))) * (lightmap_4.y * shadow_9))
  )) * tmpvar_6.xyz) * lightColor_3);
  col_2.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_15;
    scrpos_15 = xlv_TEXCOORD2;
    mediump float a_16;
    a_16 = xlv_TEXCOORD2.z;
    if ((a_16 < 0.95)) {
      scrpos_15.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_16 = (a_16 * 17.0);
      highp float tmpvar_17;
      tmpvar_17 = (scrpos_15.y / 4.0);
      highp float tmpvar_18;
      tmpvar_18 = (fract(abs(tmpvar_17)) * 4.0);
      highp float tmpvar_19;
      if ((tmpvar_17 >= 0.0)) {
        tmpvar_19 = tmpvar_18;
      } else {
        tmpvar_19 = -(tmpvar_18);
      };
      highp float tmpvar_20;
      tmpvar_20 = (scrpos_15.x / 4.0);
      highp float tmpvar_21;
      tmpvar_21 = (fract(abs(tmpvar_20)) * 4.0);
      highp float tmpvar_22;
      if ((tmpvar_20 >= 0.0)) {
        tmpvar_22 = tmpvar_21;
      } else {
        tmpvar_22 = -(tmpvar_21);
      };
      highp float x_23;
      x_23 = ((a_16 - _DITHERMATRIX[
        int(tmpvar_19)
      ][
        int(tmpvar_22)
      ]) - 0.01);
      if ((x_23 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_FACEMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_4 = o_10;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  tmpvar_6 = normalize((_glesNormal * tmpvar_13));
  highp vec3 tmpvar_14;
  tmpvar_14 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_14;
  highp vec3 lightWorldDir_15;
  lightWorldDir_15 = lightDir_1;
  highp vec2 texcoord_16;
  texcoord_16 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_17;
  bool flipInYAxis_18;
  highp vec3 lightLocalDir_19;
  highp float tmpvar_20;
  tmpvar_20 = sqrt(dot (lightWorldDir_15, lightWorldDir_15));
  if ((tmpvar_20 < 0.9)) {
    tmpvar_17 = vec3(0.0, 1.0, 0.0);
  } else {
    highp mat3 tmpvar_21;
    tmpvar_21[0] = unity_WorldToObject[0].xyz;
    tmpvar_21[1] = unity_WorldToObject[1].xyz;
    tmpvar_21[2] = unity_WorldToObject[2].xyz;
    lightLocalDir_19 = (mat3(1.0, 0.0, 0.0, 0.0, 0.98481, -0.17365, 0.0, 0.17365, 0.98481) * (tmpvar_21 * lightWorldDir_15));
    highp float tmpvar_22;
    highp float tmpvar_23;
    tmpvar_23 = (min (abs(
      (lightLocalDir_19.z / lightLocalDir_19.y)
    ), 1.0) / max (abs(
      (lightLocalDir_19.z / lightLocalDir_19.y)
    ), 1.0));
    highp float tmpvar_24;
    tmpvar_24 = (tmpvar_23 * tmpvar_23);
    tmpvar_24 = (((
      ((((
        ((((-0.01213232 * tmpvar_24) + 0.05368138) * tmpvar_24) - 0.1173503)
       * tmpvar_24) + 0.1938925) * tmpvar_24) - 0.3326756)
     * tmpvar_24) + 0.9999793) * tmpvar_23);
    tmpvar_24 = (tmpvar_24 + (float(
      (abs((lightLocalDir_19.z / lightLocalDir_19.y)) > 1.0)
    ) * (
      (tmpvar_24 * -2.0)
     + 1.570796)));
    tmpvar_22 = (tmpvar_24 * sign((lightLocalDir_19.z / lightLocalDir_19.y)));
    if ((abs(lightLocalDir_19.y) > (1e-08 * abs(lightLocalDir_19.z)))) {
      if ((lightLocalDir_19.y < 0.0)) {
        if ((lightLocalDir_19.z >= 0.0)) {
          tmpvar_22 += 3.141593;
        } else {
          tmpvar_22 = (tmpvar_22 - 3.141593);
        };
      };
    } else {
      tmpvar_22 = (sign(lightLocalDir_19.z) * 1.570796);
    };
    highp float tmpvar_25;
    tmpvar_25 = (-(tmpvar_22) * 57.29578);
    flipInYAxis_18 = bool(0);
    if ((tmpvar_25 > 0.0)) {
      flipInYAxis_18 = bool(1);
    };
    highp float tmpvar_26;
    tmpvar_26 = clamp (abs((tmpvar_25 / 180.0)), 0.0001, 0.9999);
    if (flipInYAxis_18) {
      texcoord_16 = ((_glesMultiTexCoord0.xy * vec2(-1.0, 1.0)) + vec2(1.0, 0.0));
    };
    highp vec3 tmpvar_27;
    tmpvar_27.xy = texcoord_16;
    tmpvar_27.z = tmpvar_26;
    tmpvar_17 = tmpvar_27;
  };
  mediump vec3 tmpvar_28;
  highp vec3 lightColor0_29;
  lightColor0_29 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_30;
  lightColor1_30 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_31;
  lightColor2_31 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_32;
  lightColor3_32 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_33;
  lightAttenSq_33 = unity_4LightAtten0;
  highp vec3 col_34;
  highp vec4 ndotl_35;
  highp vec4 lengthSq_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_38;
  tmpvar_38 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_39;
  tmpvar_39 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_36 = (tmpvar_37 * tmpvar_37);
  lengthSq_36 = (lengthSq_36 + (tmpvar_38 * tmpvar_38));
  lengthSq_36 = (lengthSq_36 + (tmpvar_39 * tmpvar_39));
  highp vec4 tmpvar_40;
  tmpvar_40 = max (lengthSq_36, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_36 = tmpvar_40;
  ndotl_35 = (tmpvar_37 * tmpvar_6.x);
  ndotl_35 = (ndotl_35 + (tmpvar_38 * tmpvar_6.y));
  ndotl_35 = (ndotl_35 + (tmpvar_39 * tmpvar_6.z));
  highp vec4 tmpvar_41;
  tmpvar_41 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_35 * inversesqrt(tmpvar_40)));
  ndotl_35 = tmpvar_41;
  highp vec4 tmpvar_42;
  tmpvar_42 = (tmpvar_41 * (1.0/((1.0 + 
    (tmpvar_40 * lightAttenSq_33)
  ))));
  col_34 = (lightColor0_29 * tmpvar_42.x);
  col_34 = (col_34 + (lightColor1_30 * tmpvar_42.y));
  col_34 = (col_34 + (lightColor2_31 * tmpvar_42.z));
  col_34 = (col_34 + (lightColor3_32 * tmpvar_42.w));
  tmpvar_28 = col_34;
  tmpvar_7.xyz = tmpvar_28;
  if (bool(_UsingDitherAlpha)) {
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_17;
  xlv_TEXCOORD6 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _ShadowFeather;
uniform mediump float _UsingDitherAlpha;
uniform sampler2D _FaceMap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump float diffuseThreshold_1;
  mediump vec4 col_2;
  mediump vec3 lightColor_3;
  mediump vec3 lightmap_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_6;
  tmpvar_6 = ((tmpvar_5 * _Color) * _EnvColor);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_LightMap, xlv_TEXCOORD0).xyz;
  lightmap_4 = tmpvar_7;
  lightColor_3 = (vec3(1.0, 1.0, 1.0) + xlv_TEXCOORD6.xyz);
  highp vec2 screenCoord_8;
  screenCoord_8 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_9;
  shadow_9 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_10;
    tmpvar_10 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_8);
    shadow_9 = tmpvar_10.x;
  };
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_FaceMap, xlv_TEXCOORD5.xy).w;
  diffuseThreshold_1 = tmpvar_11;
  mediump float lightingThreshold_12;
  lightingThreshold_12 = xlv_TEXCOORD5.z;
  mediump float tmpvar_13;
  tmpvar_13 = max ((lightingThreshold_12 - _ShadowFeather), 0.0001);
  mediump float tmpvar_14;
  tmpvar_14 = clamp (((diffuseThreshold_1 - tmpvar_13) / (
    min ((lightingThreshold_12 + _ShadowFeather), 0.9999)
   - tmpvar_13)), 0.0, 1.0);
  col_2.xyz = ((mix (_ShadowColor, vec3(1.0, 1.0, 1.0), vec3(
    ((tmpvar_14 * (tmpvar_14 * (3.0 - 
      (2.0 * tmpvar_14)
    ))) * (lightmap_4.y * shadow_9))
  )) * tmpvar_6.xyz) * lightColor_3);
  col_2.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_15;
    scrpos_15 = xlv_TEXCOORD2;
    mediump float a_16;
    a_16 = xlv_TEXCOORD2.z;
    if ((a_16 < 0.95)) {
      scrpos_15.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_16 = (a_16 * 17.0);
      highp float tmpvar_17;
      tmpvar_17 = (scrpos_15.y / 4.0);
      highp float tmpvar_18;
      tmpvar_18 = (fract(abs(tmpvar_17)) * 4.0);
      highp float tmpvar_19;
      if ((tmpvar_17 >= 0.0)) {
        tmpvar_19 = tmpvar_18;
      } else {
        tmpvar_19 = -(tmpvar_18);
      };
      highp float tmpvar_20;
      tmpvar_20 = (scrpos_15.x / 4.0);
      highp float tmpvar_21;
      tmpvar_21 = (fract(abs(tmpvar_20)) * 4.0);
      highp float tmpvar_22;
      if ((tmpvar_20 >= 0.0)) {
        tmpvar_22 = tmpvar_21;
      } else {
        tmpvar_22 = -(tmpvar_21);
      };
      highp float x_23;
      x_23 = ((a_16 - _DITHERMATRIX[
        int(tmpvar_19)
      ][
        int(tmpvar_22)
      ]) - 0.01);
      if ((x_23 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_2;
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
Keywords { "VERTEXLIGHT_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_FACEMAP_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_FACEMAP_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_FACEMAP_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "_FACEMAP_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "_FACEMAP_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "_FACEMAP_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_FACEMAP_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_FACEMAP_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_FACEMAP_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_FACEMAP_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_FACEMAP_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_FACEMAP_ON" }
""
}
}
}
 UsePass "Hidden/miHoYo/DLC/Character/Shared/OPAQUEOUTLINE"
 UsePass "Hidden/miHoYo/DLC/Common/Shared/PREDEPTH"
}
SubShader {
 LOD 200
 Tags { "OutlineType" = "Complex" "PerformanceChecks" = "False" "QUEUE" = "Geometry+10" "RenderType" = "Opaque" }
 Pass {
  LOD 200
  Tags { "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "Complex" "PerformanceChecks" = "False" "QUEUE" = "Geometry+10" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 108166
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_4 = o_9;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  tmpvar_6 = normalize((_glesNormal * tmpvar_12));
  highp vec3 tmpvar_13;
  tmpvar_13 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_13;
  highp vec3 lightWorldDir_14;
  lightWorldDir_14 = lightDir_1;
  highp vec2 texcoord_15;
  texcoord_15 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_16;
  bool flipInYAxis_17;
  highp vec3 lightLocalDir_18;
  highp float tmpvar_19;
  tmpvar_19 = sqrt(dot (lightWorldDir_14, lightWorldDir_14));
  if ((tmpvar_19 < 0.9)) {
    tmpvar_16 = vec3(0.0, 1.0, 0.0);
  } else {
    highp mat3 tmpvar_20;
    tmpvar_20[0] = unity_WorldToObject[0].xyz;
    tmpvar_20[1] = unity_WorldToObject[1].xyz;
    tmpvar_20[2] = unity_WorldToObject[2].xyz;
    lightLocalDir_18 = (mat3(1.0, 0.0, 0.0, 0.0, 0.98481, -0.17365, 0.0, 0.17365, 0.98481) * (tmpvar_20 * lightWorldDir_14));
    highp float tmpvar_21;
    highp float tmpvar_22;
    tmpvar_22 = (min (abs(
      (lightLocalDir_18.z / lightLocalDir_18.y)
    ), 1.0) / max (abs(
      (lightLocalDir_18.z / lightLocalDir_18.y)
    ), 1.0));
    highp float tmpvar_23;
    tmpvar_23 = (tmpvar_22 * tmpvar_22);
    tmpvar_23 = (((
      ((((
        ((((-0.01213232 * tmpvar_23) + 0.05368138) * tmpvar_23) - 0.1173503)
       * tmpvar_23) + 0.1938925) * tmpvar_23) - 0.3326756)
     * tmpvar_23) + 0.9999793) * tmpvar_22);
    tmpvar_23 = (tmpvar_23 + (float(
      (abs((lightLocalDir_18.z / lightLocalDir_18.y)) > 1.0)
    ) * (
      (tmpvar_23 * -2.0)
     + 1.570796)));
    tmpvar_21 = (tmpvar_23 * sign((lightLocalDir_18.z / lightLocalDir_18.y)));
    if ((abs(lightLocalDir_18.y) > (1e-08 * abs(lightLocalDir_18.z)))) {
      if ((lightLocalDir_18.y < 0.0)) {
        if ((lightLocalDir_18.z >= 0.0)) {
          tmpvar_21 += 3.141593;
        } else {
          tmpvar_21 = (tmpvar_21 - 3.141593);
        };
      };
    } else {
      tmpvar_21 = (sign(lightLocalDir_18.z) * 1.570796);
    };
    highp float tmpvar_24;
    tmpvar_24 = (-(tmpvar_21) * 57.29578);
    flipInYAxis_17 = bool(0);
    if ((tmpvar_24 > 0.0)) {
      flipInYAxis_17 = bool(1);
    };
    highp float tmpvar_25;
    tmpvar_25 = clamp (abs((tmpvar_24 / 180.0)), 0.0001, 0.9999);
    if (flipInYAxis_17) {
      texcoord_15 = ((_glesMultiTexCoord0.xy * vec2(-1.0, 1.0)) + vec2(1.0, 0.0));
    };
    highp vec3 tmpvar_26;
    tmpvar_26.xy = texcoord_15;
    tmpvar_26.z = tmpvar_25;
    tmpvar_16 = tmpvar_26;
  };
  if (bool(_UsingDitherAlpha)) {
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_16;
  xlv_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _ShadowThreshold;
uniform mediump float _ShadowFeather;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 lightDir_1;
  mediump vec3 normalDir_2;
  mediump vec4 col_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = max ((_ShadowThreshold - _ShadowFeather), 0.0001);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((
    ((dot (normalDir_2, lightDir_1) * 0.5) + 0.5)
   - tmpvar_7) / (
    min ((_ShadowThreshold + _ShadowFeather), 0.9999)
   - tmpvar_7)), 0.0, 1.0);
  col_3.xyz = (mix (_ShadowColor, vec3(1.0, 1.0, 1.0), vec3((tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  ))) * ((tmpvar_4 * _Color) * _EnvColor).xyz);
  col_3.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_9;
    scrpos_9 = xlv_TEXCOORD2;
    mediump float a_10;
    a_10 = xlv_TEXCOORD2.z;
    if ((a_10 < 0.95)) {
      scrpos_9.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_10 = (a_10 * 17.0);
      highp float tmpvar_11;
      tmpvar_11 = (scrpos_9.y / 4.0);
      highp float tmpvar_12;
      tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
      highp float tmpvar_13;
      if ((tmpvar_11 >= 0.0)) {
        tmpvar_13 = tmpvar_12;
      } else {
        tmpvar_13 = -(tmpvar_12);
      };
      highp float tmpvar_14;
      tmpvar_14 = (scrpos_9.x / 4.0);
      highp float tmpvar_15;
      tmpvar_15 = (fract(abs(tmpvar_14)) * 4.0);
      highp float tmpvar_16;
      if ((tmpvar_14 >= 0.0)) {
        tmpvar_16 = tmpvar_15;
      } else {
        tmpvar_16 = -(tmpvar_15);
      };
      highp float x_17;
      x_17 = ((a_10 - _DITHERMATRIX[
        int(tmpvar_13)
      ][
        int(tmpvar_16)
      ]) - 0.01);
      if ((x_17 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_3;
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
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_4 = o_9;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  tmpvar_6 = normalize((_glesNormal * tmpvar_12));
  highp vec3 tmpvar_13;
  tmpvar_13 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_13;
  highp vec3 lightWorldDir_14;
  lightWorldDir_14 = lightDir_1;
  highp vec2 texcoord_15;
  texcoord_15 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_16;
  bool flipInYAxis_17;
  highp vec3 lightLocalDir_18;
  highp float tmpvar_19;
  tmpvar_19 = sqrt(dot (lightWorldDir_14, lightWorldDir_14));
  if ((tmpvar_19 < 0.9)) {
    tmpvar_16 = vec3(0.0, 1.0, 0.0);
  } else {
    highp mat3 tmpvar_20;
    tmpvar_20[0] = unity_WorldToObject[0].xyz;
    tmpvar_20[1] = unity_WorldToObject[1].xyz;
    tmpvar_20[2] = unity_WorldToObject[2].xyz;
    lightLocalDir_18 = (mat3(1.0, 0.0, 0.0, 0.0, 0.98481, -0.17365, 0.0, 0.17365, 0.98481) * (tmpvar_20 * lightWorldDir_14));
    highp float tmpvar_21;
    highp float tmpvar_22;
    tmpvar_22 = (min (abs(
      (lightLocalDir_18.z / lightLocalDir_18.y)
    ), 1.0) / max (abs(
      (lightLocalDir_18.z / lightLocalDir_18.y)
    ), 1.0));
    highp float tmpvar_23;
    tmpvar_23 = (tmpvar_22 * tmpvar_22);
    tmpvar_23 = (((
      ((((
        ((((-0.01213232 * tmpvar_23) + 0.05368138) * tmpvar_23) - 0.1173503)
       * tmpvar_23) + 0.1938925) * tmpvar_23) - 0.3326756)
     * tmpvar_23) + 0.9999793) * tmpvar_22);
    tmpvar_23 = (tmpvar_23 + (float(
      (abs((lightLocalDir_18.z / lightLocalDir_18.y)) > 1.0)
    ) * (
      (tmpvar_23 * -2.0)
     + 1.570796)));
    tmpvar_21 = (tmpvar_23 * sign((lightLocalDir_18.z / lightLocalDir_18.y)));
    if ((abs(lightLocalDir_18.y) > (1e-08 * abs(lightLocalDir_18.z)))) {
      if ((lightLocalDir_18.y < 0.0)) {
        if ((lightLocalDir_18.z >= 0.0)) {
          tmpvar_21 += 3.141593;
        } else {
          tmpvar_21 = (tmpvar_21 - 3.141593);
        };
      };
    } else {
      tmpvar_21 = (sign(lightLocalDir_18.z) * 1.570796);
    };
    highp float tmpvar_24;
    tmpvar_24 = (-(tmpvar_21) * 57.29578);
    flipInYAxis_17 = bool(0);
    if ((tmpvar_24 > 0.0)) {
      flipInYAxis_17 = bool(1);
    };
    highp float tmpvar_25;
    tmpvar_25 = clamp (abs((tmpvar_24 / 180.0)), 0.0001, 0.9999);
    if (flipInYAxis_17) {
      texcoord_15 = ((_glesMultiTexCoord0.xy * vec2(-1.0, 1.0)) + vec2(1.0, 0.0));
    };
    highp vec3 tmpvar_26;
    tmpvar_26.xy = texcoord_15;
    tmpvar_26.z = tmpvar_25;
    tmpvar_16 = tmpvar_26;
  };
  if (bool(_UsingDitherAlpha)) {
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_16;
  xlv_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _ShadowThreshold;
uniform mediump float _ShadowFeather;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 lightDir_1;
  mediump vec3 normalDir_2;
  mediump vec4 col_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = max ((_ShadowThreshold - _ShadowFeather), 0.0001);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((
    ((dot (normalDir_2, lightDir_1) * 0.5) + 0.5)
   - tmpvar_7) / (
    min ((_ShadowThreshold + _ShadowFeather), 0.9999)
   - tmpvar_7)), 0.0, 1.0);
  col_3.xyz = (mix (_ShadowColor, vec3(1.0, 1.0, 1.0), vec3((tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  ))) * ((tmpvar_4 * _Color) * _EnvColor).xyz);
  col_3.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_9;
    scrpos_9 = xlv_TEXCOORD2;
    mediump float a_10;
    a_10 = xlv_TEXCOORD2.z;
    if ((a_10 < 0.95)) {
      scrpos_9.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_10 = (a_10 * 17.0);
      highp float tmpvar_11;
      tmpvar_11 = (scrpos_9.y / 4.0);
      highp float tmpvar_12;
      tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
      highp float tmpvar_13;
      if ((tmpvar_11 >= 0.0)) {
        tmpvar_13 = tmpvar_12;
      } else {
        tmpvar_13 = -(tmpvar_12);
      };
      highp float tmpvar_14;
      tmpvar_14 = (scrpos_9.x / 4.0);
      highp float tmpvar_15;
      tmpvar_15 = (fract(abs(tmpvar_14)) * 4.0);
      highp float tmpvar_16;
      if ((tmpvar_14 >= 0.0)) {
        tmpvar_16 = tmpvar_15;
      } else {
        tmpvar_16 = -(tmpvar_15);
      };
      highp float x_17;
      x_17 = ((a_10 - _DITHERMATRIX[
        int(tmpvar_13)
      ][
        int(tmpvar_16)
      ]) - 0.01);
      if ((x_17 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_3;
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
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_4 = o_9;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  tmpvar_6 = normalize((_glesNormal * tmpvar_12));
  highp vec3 tmpvar_13;
  tmpvar_13 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_13;
  highp vec3 lightWorldDir_14;
  lightWorldDir_14 = lightDir_1;
  highp vec2 texcoord_15;
  texcoord_15 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_16;
  bool flipInYAxis_17;
  highp vec3 lightLocalDir_18;
  highp float tmpvar_19;
  tmpvar_19 = sqrt(dot (lightWorldDir_14, lightWorldDir_14));
  if ((tmpvar_19 < 0.9)) {
    tmpvar_16 = vec3(0.0, 1.0, 0.0);
  } else {
    highp mat3 tmpvar_20;
    tmpvar_20[0] = unity_WorldToObject[0].xyz;
    tmpvar_20[1] = unity_WorldToObject[1].xyz;
    tmpvar_20[2] = unity_WorldToObject[2].xyz;
    lightLocalDir_18 = (mat3(1.0, 0.0, 0.0, 0.0, 0.98481, -0.17365, 0.0, 0.17365, 0.98481) * (tmpvar_20 * lightWorldDir_14));
    highp float tmpvar_21;
    highp float tmpvar_22;
    tmpvar_22 = (min (abs(
      (lightLocalDir_18.z / lightLocalDir_18.y)
    ), 1.0) / max (abs(
      (lightLocalDir_18.z / lightLocalDir_18.y)
    ), 1.0));
    highp float tmpvar_23;
    tmpvar_23 = (tmpvar_22 * tmpvar_22);
    tmpvar_23 = (((
      ((((
        ((((-0.01213232 * tmpvar_23) + 0.05368138) * tmpvar_23) - 0.1173503)
       * tmpvar_23) + 0.1938925) * tmpvar_23) - 0.3326756)
     * tmpvar_23) + 0.9999793) * tmpvar_22);
    tmpvar_23 = (tmpvar_23 + (float(
      (abs((lightLocalDir_18.z / lightLocalDir_18.y)) > 1.0)
    ) * (
      (tmpvar_23 * -2.0)
     + 1.570796)));
    tmpvar_21 = (tmpvar_23 * sign((lightLocalDir_18.z / lightLocalDir_18.y)));
    if ((abs(lightLocalDir_18.y) > (1e-08 * abs(lightLocalDir_18.z)))) {
      if ((lightLocalDir_18.y < 0.0)) {
        if ((lightLocalDir_18.z >= 0.0)) {
          tmpvar_21 += 3.141593;
        } else {
          tmpvar_21 = (tmpvar_21 - 3.141593);
        };
      };
    } else {
      tmpvar_21 = (sign(lightLocalDir_18.z) * 1.570796);
    };
    highp float tmpvar_24;
    tmpvar_24 = (-(tmpvar_21) * 57.29578);
    flipInYAxis_17 = bool(0);
    if ((tmpvar_24 > 0.0)) {
      flipInYAxis_17 = bool(1);
    };
    highp float tmpvar_25;
    tmpvar_25 = clamp (abs((tmpvar_24 / 180.0)), 0.0001, 0.9999);
    if (flipInYAxis_17) {
      texcoord_15 = ((_glesMultiTexCoord0.xy * vec2(-1.0, 1.0)) + vec2(1.0, 0.0));
    };
    highp vec3 tmpvar_26;
    tmpvar_26.xy = texcoord_15;
    tmpvar_26.z = tmpvar_25;
    tmpvar_16 = tmpvar_26;
  };
  if (bool(_UsingDitherAlpha)) {
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_16;
  xlv_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _ShadowThreshold;
uniform mediump float _ShadowFeather;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 lightDir_1;
  mediump vec3 normalDir_2;
  mediump vec4 col_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = max ((_ShadowThreshold - _ShadowFeather), 0.0001);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((
    ((dot (normalDir_2, lightDir_1) * 0.5) + 0.5)
   - tmpvar_7) / (
    min ((_ShadowThreshold + _ShadowFeather), 0.9999)
   - tmpvar_7)), 0.0, 1.0);
  col_3.xyz = (mix (_ShadowColor, vec3(1.0, 1.0, 1.0), vec3((tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  ))) * ((tmpvar_4 * _Color) * _EnvColor).xyz);
  col_3.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_9;
    scrpos_9 = xlv_TEXCOORD2;
    mediump float a_10;
    a_10 = xlv_TEXCOORD2.z;
    if ((a_10 < 0.95)) {
      scrpos_9.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_10 = (a_10 * 17.0);
      highp float tmpvar_11;
      tmpvar_11 = (scrpos_9.y / 4.0);
      highp float tmpvar_12;
      tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
      highp float tmpvar_13;
      if ((tmpvar_11 >= 0.0)) {
        tmpvar_13 = tmpvar_12;
      } else {
        tmpvar_13 = -(tmpvar_12);
      };
      highp float tmpvar_14;
      tmpvar_14 = (scrpos_9.x / 4.0);
      highp float tmpvar_15;
      tmpvar_15 = (fract(abs(tmpvar_14)) * 4.0);
      highp float tmpvar_16;
      if ((tmpvar_14 >= 0.0)) {
        tmpvar_16 = tmpvar_15;
      } else {
        tmpvar_16 = -(tmpvar_15);
      };
      highp float x_17;
      x_17 = ((a_10 - _DITHERMATRIX[
        int(tmpvar_13)
      ][
        int(tmpvar_16)
      ]) - 0.01);
      if ((x_17 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_4 = o_10;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  tmpvar_6 = normalize((_glesNormal * tmpvar_13));
  highp vec3 tmpvar_14;
  tmpvar_14 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_14;
  highp vec3 lightWorldDir_15;
  lightWorldDir_15 = lightDir_1;
  highp vec2 texcoord_16;
  texcoord_16 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_17;
  bool flipInYAxis_18;
  highp vec3 lightLocalDir_19;
  highp float tmpvar_20;
  tmpvar_20 = sqrt(dot (lightWorldDir_15, lightWorldDir_15));
  if ((tmpvar_20 < 0.9)) {
    tmpvar_17 = vec3(0.0, 1.0, 0.0);
  } else {
    highp mat3 tmpvar_21;
    tmpvar_21[0] = unity_WorldToObject[0].xyz;
    tmpvar_21[1] = unity_WorldToObject[1].xyz;
    tmpvar_21[2] = unity_WorldToObject[2].xyz;
    lightLocalDir_19 = (mat3(1.0, 0.0, 0.0, 0.0, 0.98481, -0.17365, 0.0, 0.17365, 0.98481) * (tmpvar_21 * lightWorldDir_15));
    highp float tmpvar_22;
    highp float tmpvar_23;
    tmpvar_23 = (min (abs(
      (lightLocalDir_19.z / lightLocalDir_19.y)
    ), 1.0) / max (abs(
      (lightLocalDir_19.z / lightLocalDir_19.y)
    ), 1.0));
    highp float tmpvar_24;
    tmpvar_24 = (tmpvar_23 * tmpvar_23);
    tmpvar_24 = (((
      ((((
        ((((-0.01213232 * tmpvar_24) + 0.05368138) * tmpvar_24) - 0.1173503)
       * tmpvar_24) + 0.1938925) * tmpvar_24) - 0.3326756)
     * tmpvar_24) + 0.9999793) * tmpvar_23);
    tmpvar_24 = (tmpvar_24 + (float(
      (abs((lightLocalDir_19.z / lightLocalDir_19.y)) > 1.0)
    ) * (
      (tmpvar_24 * -2.0)
     + 1.570796)));
    tmpvar_22 = (tmpvar_24 * sign((lightLocalDir_19.z / lightLocalDir_19.y)));
    if ((abs(lightLocalDir_19.y) > (1e-08 * abs(lightLocalDir_19.z)))) {
      if ((lightLocalDir_19.y < 0.0)) {
        if ((lightLocalDir_19.z >= 0.0)) {
          tmpvar_22 += 3.141593;
        } else {
          tmpvar_22 = (tmpvar_22 - 3.141593);
        };
      };
    } else {
      tmpvar_22 = (sign(lightLocalDir_19.z) * 1.570796);
    };
    highp float tmpvar_25;
    tmpvar_25 = (-(tmpvar_22) * 57.29578);
    flipInYAxis_18 = bool(0);
    if ((tmpvar_25 > 0.0)) {
      flipInYAxis_18 = bool(1);
    };
    highp float tmpvar_26;
    tmpvar_26 = clamp (abs((tmpvar_25 / 180.0)), 0.0001, 0.9999);
    if (flipInYAxis_18) {
      texcoord_16 = ((_glesMultiTexCoord0.xy * vec2(-1.0, 1.0)) + vec2(1.0, 0.0));
    };
    highp vec3 tmpvar_27;
    tmpvar_27.xy = texcoord_16;
    tmpvar_27.z = tmpvar_26;
    tmpvar_17 = tmpvar_27;
  };
  mediump vec3 tmpvar_28;
  highp vec3 lightColor0_29;
  lightColor0_29 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_30;
  lightColor1_30 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_31;
  lightColor2_31 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_32;
  lightColor3_32 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_33;
  lightAttenSq_33 = unity_4LightAtten0;
  highp vec3 col_34;
  highp vec4 ndotl_35;
  highp vec4 lengthSq_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_38;
  tmpvar_38 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_39;
  tmpvar_39 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_36 = (tmpvar_37 * tmpvar_37);
  lengthSq_36 = (lengthSq_36 + (tmpvar_38 * tmpvar_38));
  lengthSq_36 = (lengthSq_36 + (tmpvar_39 * tmpvar_39));
  highp vec4 tmpvar_40;
  tmpvar_40 = max (lengthSq_36, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_36 = tmpvar_40;
  ndotl_35 = (tmpvar_37 * tmpvar_6.x);
  ndotl_35 = (ndotl_35 + (tmpvar_38 * tmpvar_6.y));
  ndotl_35 = (ndotl_35 + (tmpvar_39 * tmpvar_6.z));
  highp vec4 tmpvar_41;
  tmpvar_41 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_35 * inversesqrt(tmpvar_40)));
  ndotl_35 = tmpvar_41;
  highp vec4 tmpvar_42;
  tmpvar_42 = (tmpvar_41 * (1.0/((1.0 + 
    (tmpvar_40 * lightAttenSq_33)
  ))));
  col_34 = (lightColor0_29 * tmpvar_42.x);
  col_34 = (col_34 + (lightColor1_30 * tmpvar_42.y));
  col_34 = (col_34 + (lightColor2_31 * tmpvar_42.z));
  col_34 = (col_34 + (lightColor3_32 * tmpvar_42.w));
  tmpvar_28 = col_34;
  tmpvar_7.xyz = tmpvar_28;
  if (bool(_UsingDitherAlpha)) {
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_17;
  xlv_TEXCOORD6 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _ShadowThreshold;
uniform mediump float _ShadowFeather;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  mediump vec3 normalDir_2;
  mediump vec4 col_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = max ((_ShadowThreshold - _ShadowFeather), 0.0001);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((
    ((dot (normalDir_2, lightDir_1) * 0.5) + 0.5)
   - tmpvar_7) / (
    min ((_ShadowThreshold + _ShadowFeather), 0.9999)
   - tmpvar_7)), 0.0, 1.0);
  col_3.xyz = ((mix (_ShadowColor, vec3(1.0, 1.0, 1.0), vec3(
    (tmpvar_8 * (tmpvar_8 * (3.0 - (2.0 * tmpvar_8))))
  )) * (
    (tmpvar_4 * _Color)
   * _EnvColor).xyz) * (vec3(1.0, 1.0, 1.0) + xlv_TEXCOORD6.xyz));
  col_3.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_9;
    scrpos_9 = xlv_TEXCOORD2;
    mediump float a_10;
    a_10 = xlv_TEXCOORD2.z;
    if ((a_10 < 0.95)) {
      scrpos_9.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_10 = (a_10 * 17.0);
      highp float tmpvar_11;
      tmpvar_11 = (scrpos_9.y / 4.0);
      highp float tmpvar_12;
      tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
      highp float tmpvar_13;
      if ((tmpvar_11 >= 0.0)) {
        tmpvar_13 = tmpvar_12;
      } else {
        tmpvar_13 = -(tmpvar_12);
      };
      highp float tmpvar_14;
      tmpvar_14 = (scrpos_9.x / 4.0);
      highp float tmpvar_15;
      tmpvar_15 = (fract(abs(tmpvar_14)) * 4.0);
      highp float tmpvar_16;
      if ((tmpvar_14 >= 0.0)) {
        tmpvar_16 = tmpvar_15;
      } else {
        tmpvar_16 = -(tmpvar_15);
      };
      highp float x_17;
      x_17 = ((a_10 - _DITHERMATRIX[
        int(tmpvar_13)
      ][
        int(tmpvar_16)
      ]) - 0.01);
      if ((x_17 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_4 = o_10;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  tmpvar_6 = normalize((_glesNormal * tmpvar_13));
  highp vec3 tmpvar_14;
  tmpvar_14 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_14;
  highp vec3 lightWorldDir_15;
  lightWorldDir_15 = lightDir_1;
  highp vec2 texcoord_16;
  texcoord_16 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_17;
  bool flipInYAxis_18;
  highp vec3 lightLocalDir_19;
  highp float tmpvar_20;
  tmpvar_20 = sqrt(dot (lightWorldDir_15, lightWorldDir_15));
  if ((tmpvar_20 < 0.9)) {
    tmpvar_17 = vec3(0.0, 1.0, 0.0);
  } else {
    highp mat3 tmpvar_21;
    tmpvar_21[0] = unity_WorldToObject[0].xyz;
    tmpvar_21[1] = unity_WorldToObject[1].xyz;
    tmpvar_21[2] = unity_WorldToObject[2].xyz;
    lightLocalDir_19 = (mat3(1.0, 0.0, 0.0, 0.0, 0.98481, -0.17365, 0.0, 0.17365, 0.98481) * (tmpvar_21 * lightWorldDir_15));
    highp float tmpvar_22;
    highp float tmpvar_23;
    tmpvar_23 = (min (abs(
      (lightLocalDir_19.z / lightLocalDir_19.y)
    ), 1.0) / max (abs(
      (lightLocalDir_19.z / lightLocalDir_19.y)
    ), 1.0));
    highp float tmpvar_24;
    tmpvar_24 = (tmpvar_23 * tmpvar_23);
    tmpvar_24 = (((
      ((((
        ((((-0.01213232 * tmpvar_24) + 0.05368138) * tmpvar_24) - 0.1173503)
       * tmpvar_24) + 0.1938925) * tmpvar_24) - 0.3326756)
     * tmpvar_24) + 0.9999793) * tmpvar_23);
    tmpvar_24 = (tmpvar_24 + (float(
      (abs((lightLocalDir_19.z / lightLocalDir_19.y)) > 1.0)
    ) * (
      (tmpvar_24 * -2.0)
     + 1.570796)));
    tmpvar_22 = (tmpvar_24 * sign((lightLocalDir_19.z / lightLocalDir_19.y)));
    if ((abs(lightLocalDir_19.y) > (1e-08 * abs(lightLocalDir_19.z)))) {
      if ((lightLocalDir_19.y < 0.0)) {
        if ((lightLocalDir_19.z >= 0.0)) {
          tmpvar_22 += 3.141593;
        } else {
          tmpvar_22 = (tmpvar_22 - 3.141593);
        };
      };
    } else {
      tmpvar_22 = (sign(lightLocalDir_19.z) * 1.570796);
    };
    highp float tmpvar_25;
    tmpvar_25 = (-(tmpvar_22) * 57.29578);
    flipInYAxis_18 = bool(0);
    if ((tmpvar_25 > 0.0)) {
      flipInYAxis_18 = bool(1);
    };
    highp float tmpvar_26;
    tmpvar_26 = clamp (abs((tmpvar_25 / 180.0)), 0.0001, 0.9999);
    if (flipInYAxis_18) {
      texcoord_16 = ((_glesMultiTexCoord0.xy * vec2(-1.0, 1.0)) + vec2(1.0, 0.0));
    };
    highp vec3 tmpvar_27;
    tmpvar_27.xy = texcoord_16;
    tmpvar_27.z = tmpvar_26;
    tmpvar_17 = tmpvar_27;
  };
  mediump vec3 tmpvar_28;
  highp vec3 lightColor0_29;
  lightColor0_29 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_30;
  lightColor1_30 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_31;
  lightColor2_31 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_32;
  lightColor3_32 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_33;
  lightAttenSq_33 = unity_4LightAtten0;
  highp vec3 col_34;
  highp vec4 ndotl_35;
  highp vec4 lengthSq_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_38;
  tmpvar_38 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_39;
  tmpvar_39 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_36 = (tmpvar_37 * tmpvar_37);
  lengthSq_36 = (lengthSq_36 + (tmpvar_38 * tmpvar_38));
  lengthSq_36 = (lengthSq_36 + (tmpvar_39 * tmpvar_39));
  highp vec4 tmpvar_40;
  tmpvar_40 = max (lengthSq_36, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_36 = tmpvar_40;
  ndotl_35 = (tmpvar_37 * tmpvar_6.x);
  ndotl_35 = (ndotl_35 + (tmpvar_38 * tmpvar_6.y));
  ndotl_35 = (ndotl_35 + (tmpvar_39 * tmpvar_6.z));
  highp vec4 tmpvar_41;
  tmpvar_41 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_35 * inversesqrt(tmpvar_40)));
  ndotl_35 = tmpvar_41;
  highp vec4 tmpvar_42;
  tmpvar_42 = (tmpvar_41 * (1.0/((1.0 + 
    (tmpvar_40 * lightAttenSq_33)
  ))));
  col_34 = (lightColor0_29 * tmpvar_42.x);
  col_34 = (col_34 + (lightColor1_30 * tmpvar_42.y));
  col_34 = (col_34 + (lightColor2_31 * tmpvar_42.z));
  col_34 = (col_34 + (lightColor3_32 * tmpvar_42.w));
  tmpvar_28 = col_34;
  tmpvar_7.xyz = tmpvar_28;
  if (bool(_UsingDitherAlpha)) {
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_17;
  xlv_TEXCOORD6 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _ShadowThreshold;
uniform mediump float _ShadowFeather;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  mediump vec3 normalDir_2;
  mediump vec4 col_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = max ((_ShadowThreshold - _ShadowFeather), 0.0001);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((
    ((dot (normalDir_2, lightDir_1) * 0.5) + 0.5)
   - tmpvar_7) / (
    min ((_ShadowThreshold + _ShadowFeather), 0.9999)
   - tmpvar_7)), 0.0, 1.0);
  col_3.xyz = ((mix (_ShadowColor, vec3(1.0, 1.0, 1.0), vec3(
    (tmpvar_8 * (tmpvar_8 * (3.0 - (2.0 * tmpvar_8))))
  )) * (
    (tmpvar_4 * _Color)
   * _EnvColor).xyz) * (vec3(1.0, 1.0, 1.0) + xlv_TEXCOORD6.xyz));
  col_3.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_9;
    scrpos_9 = xlv_TEXCOORD2;
    mediump float a_10;
    a_10 = xlv_TEXCOORD2.z;
    if ((a_10 < 0.95)) {
      scrpos_9.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_10 = (a_10 * 17.0);
      highp float tmpvar_11;
      tmpvar_11 = (scrpos_9.y / 4.0);
      highp float tmpvar_12;
      tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
      highp float tmpvar_13;
      if ((tmpvar_11 >= 0.0)) {
        tmpvar_13 = tmpvar_12;
      } else {
        tmpvar_13 = -(tmpvar_12);
      };
      highp float tmpvar_14;
      tmpvar_14 = (scrpos_9.x / 4.0);
      highp float tmpvar_15;
      tmpvar_15 = (fract(abs(tmpvar_14)) * 4.0);
      highp float tmpvar_16;
      if ((tmpvar_14 >= 0.0)) {
        tmpvar_16 = tmpvar_15;
      } else {
        tmpvar_16 = -(tmpvar_15);
      };
      highp float x_17;
      x_17 = ((a_10 - _DITHERMATRIX[
        int(tmpvar_13)
      ][
        int(tmpvar_16)
      ]) - 0.01);
      if ((x_17 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_4 = o_10;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  tmpvar_6 = normalize((_glesNormal * tmpvar_13));
  highp vec3 tmpvar_14;
  tmpvar_14 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_14;
  highp vec3 lightWorldDir_15;
  lightWorldDir_15 = lightDir_1;
  highp vec2 texcoord_16;
  texcoord_16 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_17;
  bool flipInYAxis_18;
  highp vec3 lightLocalDir_19;
  highp float tmpvar_20;
  tmpvar_20 = sqrt(dot (lightWorldDir_15, lightWorldDir_15));
  if ((tmpvar_20 < 0.9)) {
    tmpvar_17 = vec3(0.0, 1.0, 0.0);
  } else {
    highp mat3 tmpvar_21;
    tmpvar_21[0] = unity_WorldToObject[0].xyz;
    tmpvar_21[1] = unity_WorldToObject[1].xyz;
    tmpvar_21[2] = unity_WorldToObject[2].xyz;
    lightLocalDir_19 = (mat3(1.0, 0.0, 0.0, 0.0, 0.98481, -0.17365, 0.0, 0.17365, 0.98481) * (tmpvar_21 * lightWorldDir_15));
    highp float tmpvar_22;
    highp float tmpvar_23;
    tmpvar_23 = (min (abs(
      (lightLocalDir_19.z / lightLocalDir_19.y)
    ), 1.0) / max (abs(
      (lightLocalDir_19.z / lightLocalDir_19.y)
    ), 1.0));
    highp float tmpvar_24;
    tmpvar_24 = (tmpvar_23 * tmpvar_23);
    tmpvar_24 = (((
      ((((
        ((((-0.01213232 * tmpvar_24) + 0.05368138) * tmpvar_24) - 0.1173503)
       * tmpvar_24) + 0.1938925) * tmpvar_24) - 0.3326756)
     * tmpvar_24) + 0.9999793) * tmpvar_23);
    tmpvar_24 = (tmpvar_24 + (float(
      (abs((lightLocalDir_19.z / lightLocalDir_19.y)) > 1.0)
    ) * (
      (tmpvar_24 * -2.0)
     + 1.570796)));
    tmpvar_22 = (tmpvar_24 * sign((lightLocalDir_19.z / lightLocalDir_19.y)));
    if ((abs(lightLocalDir_19.y) > (1e-08 * abs(lightLocalDir_19.z)))) {
      if ((lightLocalDir_19.y < 0.0)) {
        if ((lightLocalDir_19.z >= 0.0)) {
          tmpvar_22 += 3.141593;
        } else {
          tmpvar_22 = (tmpvar_22 - 3.141593);
        };
      };
    } else {
      tmpvar_22 = (sign(lightLocalDir_19.z) * 1.570796);
    };
    highp float tmpvar_25;
    tmpvar_25 = (-(tmpvar_22) * 57.29578);
    flipInYAxis_18 = bool(0);
    if ((tmpvar_25 > 0.0)) {
      flipInYAxis_18 = bool(1);
    };
    highp float tmpvar_26;
    tmpvar_26 = clamp (abs((tmpvar_25 / 180.0)), 0.0001, 0.9999);
    if (flipInYAxis_18) {
      texcoord_16 = ((_glesMultiTexCoord0.xy * vec2(-1.0, 1.0)) + vec2(1.0, 0.0));
    };
    highp vec3 tmpvar_27;
    tmpvar_27.xy = texcoord_16;
    tmpvar_27.z = tmpvar_26;
    tmpvar_17 = tmpvar_27;
  };
  mediump vec3 tmpvar_28;
  highp vec3 lightColor0_29;
  lightColor0_29 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_30;
  lightColor1_30 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_31;
  lightColor2_31 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_32;
  lightColor3_32 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_33;
  lightAttenSq_33 = unity_4LightAtten0;
  highp vec3 col_34;
  highp vec4 ndotl_35;
  highp vec4 lengthSq_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_38;
  tmpvar_38 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_39;
  tmpvar_39 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_36 = (tmpvar_37 * tmpvar_37);
  lengthSq_36 = (lengthSq_36 + (tmpvar_38 * tmpvar_38));
  lengthSq_36 = (lengthSq_36 + (tmpvar_39 * tmpvar_39));
  highp vec4 tmpvar_40;
  tmpvar_40 = max (lengthSq_36, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_36 = tmpvar_40;
  ndotl_35 = (tmpvar_37 * tmpvar_6.x);
  ndotl_35 = (ndotl_35 + (tmpvar_38 * tmpvar_6.y));
  ndotl_35 = (ndotl_35 + (tmpvar_39 * tmpvar_6.z));
  highp vec4 tmpvar_41;
  tmpvar_41 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_35 * inversesqrt(tmpvar_40)));
  ndotl_35 = tmpvar_41;
  highp vec4 tmpvar_42;
  tmpvar_42 = (tmpvar_41 * (1.0/((1.0 + 
    (tmpvar_40 * lightAttenSq_33)
  ))));
  col_34 = (lightColor0_29 * tmpvar_42.x);
  col_34 = (col_34 + (lightColor1_30 * tmpvar_42.y));
  col_34 = (col_34 + (lightColor2_31 * tmpvar_42.z));
  col_34 = (col_34 + (lightColor3_32 * tmpvar_42.w));
  tmpvar_28 = col_34;
  tmpvar_7.xyz = tmpvar_28;
  if (bool(_UsingDitherAlpha)) {
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_17;
  xlv_TEXCOORD6 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _ShadowThreshold;
uniform mediump float _ShadowFeather;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  mediump vec3 normalDir_2;
  mediump vec4 col_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = max ((_ShadowThreshold - _ShadowFeather), 0.0001);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((
    ((dot (normalDir_2, lightDir_1) * 0.5) + 0.5)
   - tmpvar_7) / (
    min ((_ShadowThreshold + _ShadowFeather), 0.9999)
   - tmpvar_7)), 0.0, 1.0);
  col_3.xyz = ((mix (_ShadowColor, vec3(1.0, 1.0, 1.0), vec3(
    (tmpvar_8 * (tmpvar_8 * (3.0 - (2.0 * tmpvar_8))))
  )) * (
    (tmpvar_4 * _Color)
   * _EnvColor).xyz) * (vec3(1.0, 1.0, 1.0) + xlv_TEXCOORD6.xyz));
  col_3.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_9;
    scrpos_9 = xlv_TEXCOORD2;
    mediump float a_10;
    a_10 = xlv_TEXCOORD2.z;
    if ((a_10 < 0.95)) {
      scrpos_9.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_10 = (a_10 * 17.0);
      highp float tmpvar_11;
      tmpvar_11 = (scrpos_9.y / 4.0);
      highp float tmpvar_12;
      tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
      highp float tmpvar_13;
      if ((tmpvar_11 >= 0.0)) {
        tmpvar_13 = tmpvar_12;
      } else {
        tmpvar_13 = -(tmpvar_12);
      };
      highp float tmpvar_14;
      tmpvar_14 = (scrpos_9.x / 4.0);
      highp float tmpvar_15;
      tmpvar_15 = (fract(abs(tmpvar_14)) * 4.0);
      highp float tmpvar_16;
      if ((tmpvar_14 >= 0.0)) {
        tmpvar_16 = tmpvar_15;
      } else {
        tmpvar_16 = -(tmpvar_15);
      };
      highp float x_17;
      x_17 = ((a_10 - _DITHERMATRIX[
        int(tmpvar_13)
      ][
        int(tmpvar_16)
      ]) - 0.01);
      if ((x_17 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_4 = o_9;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  tmpvar_6 = normalize((_glesNormal * tmpvar_12));
  highp vec3 tmpvar_13;
  tmpvar_13 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_13;
  highp vec3 lightWorldDir_14;
  lightWorldDir_14 = lightDir_1;
  highp vec2 texcoord_15;
  texcoord_15 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_16;
  bool flipInYAxis_17;
  highp vec3 lightLocalDir_18;
  highp float tmpvar_19;
  tmpvar_19 = sqrt(dot (lightWorldDir_14, lightWorldDir_14));
  if ((tmpvar_19 < 0.9)) {
    tmpvar_16 = vec3(0.0, 1.0, 0.0);
  } else {
    highp mat3 tmpvar_20;
    tmpvar_20[0] = unity_WorldToObject[0].xyz;
    tmpvar_20[1] = unity_WorldToObject[1].xyz;
    tmpvar_20[2] = unity_WorldToObject[2].xyz;
    lightLocalDir_18 = (mat3(1.0, 0.0, 0.0, 0.0, 0.98481, -0.17365, 0.0, 0.17365, 0.98481) * (tmpvar_20 * lightWorldDir_14));
    highp float tmpvar_21;
    highp float tmpvar_22;
    tmpvar_22 = (min (abs(
      (lightLocalDir_18.z / lightLocalDir_18.y)
    ), 1.0) / max (abs(
      (lightLocalDir_18.z / lightLocalDir_18.y)
    ), 1.0));
    highp float tmpvar_23;
    tmpvar_23 = (tmpvar_22 * tmpvar_22);
    tmpvar_23 = (((
      ((((
        ((((-0.01213232 * tmpvar_23) + 0.05368138) * tmpvar_23) - 0.1173503)
       * tmpvar_23) + 0.1938925) * tmpvar_23) - 0.3326756)
     * tmpvar_23) + 0.9999793) * tmpvar_22);
    tmpvar_23 = (tmpvar_23 + (float(
      (abs((lightLocalDir_18.z / lightLocalDir_18.y)) > 1.0)
    ) * (
      (tmpvar_23 * -2.0)
     + 1.570796)));
    tmpvar_21 = (tmpvar_23 * sign((lightLocalDir_18.z / lightLocalDir_18.y)));
    if ((abs(lightLocalDir_18.y) > (1e-08 * abs(lightLocalDir_18.z)))) {
      if ((lightLocalDir_18.y < 0.0)) {
        if ((lightLocalDir_18.z >= 0.0)) {
          tmpvar_21 += 3.141593;
        } else {
          tmpvar_21 = (tmpvar_21 - 3.141593);
        };
      };
    } else {
      tmpvar_21 = (sign(lightLocalDir_18.z) * 1.570796);
    };
    highp float tmpvar_24;
    tmpvar_24 = (-(tmpvar_21) * 57.29578);
    flipInYAxis_17 = bool(0);
    if ((tmpvar_24 > 0.0)) {
      flipInYAxis_17 = bool(1);
    };
    highp float tmpvar_25;
    tmpvar_25 = clamp (abs((tmpvar_24 / 180.0)), 0.0001, 0.9999);
    if (flipInYAxis_17) {
      texcoord_15 = ((_glesMultiTexCoord0.xy * vec2(-1.0, 1.0)) + vec2(1.0, 0.0));
    };
    highp vec3 tmpvar_26;
    tmpvar_26.xy = texcoord_15;
    tmpvar_26.z = tmpvar_25;
    tmpvar_16 = tmpvar_26;
  };
  if (bool(_UsingDitherAlpha)) {
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_16;
  xlv_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _ShadowThreshold;
uniform mediump float _ShadowFeather;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 lightDir_1;
  mediump vec3 normalDir_2;
  mediump vec4 col_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = max ((_ShadowThreshold - _ShadowFeather), 0.0001);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((
    ((dot (normalDir_2, lightDir_1) * 0.5) + 0.5)
   - tmpvar_7) / (
    min ((_ShadowThreshold + _ShadowFeather), 0.9999)
   - tmpvar_7)), 0.0, 1.0);
  col_3.xyz = (mix (_ShadowColor, vec3(1.0, 1.0, 1.0), vec3((tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  ))) * ((tmpvar_4 * _Color) * _EnvColor).xyz);
  col_3.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_9;
    scrpos_9 = xlv_TEXCOORD2;
    mediump float a_10;
    a_10 = xlv_TEXCOORD2.z;
    if ((a_10 < 0.95)) {
      scrpos_9.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_10 = (a_10 * 17.0);
      highp float tmpvar_11;
      tmpvar_11 = (scrpos_9.y / 4.0);
      highp float tmpvar_12;
      tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
      highp float tmpvar_13;
      if ((tmpvar_11 >= 0.0)) {
        tmpvar_13 = tmpvar_12;
      } else {
        tmpvar_13 = -(tmpvar_12);
      };
      highp float tmpvar_14;
      tmpvar_14 = (scrpos_9.x / 4.0);
      highp float tmpvar_15;
      tmpvar_15 = (fract(abs(tmpvar_14)) * 4.0);
      highp float tmpvar_16;
      if ((tmpvar_14 >= 0.0)) {
        tmpvar_16 = tmpvar_15;
      } else {
        tmpvar_16 = -(tmpvar_15);
      };
      highp float x_17;
      x_17 = ((a_10 - _DITHERMATRIX[
        int(tmpvar_13)
      ][
        int(tmpvar_16)
      ]) - 0.01);
      if ((x_17 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_4 = o_9;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  tmpvar_6 = normalize((_glesNormal * tmpvar_12));
  highp vec3 tmpvar_13;
  tmpvar_13 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_13;
  highp vec3 lightWorldDir_14;
  lightWorldDir_14 = lightDir_1;
  highp vec2 texcoord_15;
  texcoord_15 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_16;
  bool flipInYAxis_17;
  highp vec3 lightLocalDir_18;
  highp float tmpvar_19;
  tmpvar_19 = sqrt(dot (lightWorldDir_14, lightWorldDir_14));
  if ((tmpvar_19 < 0.9)) {
    tmpvar_16 = vec3(0.0, 1.0, 0.0);
  } else {
    highp mat3 tmpvar_20;
    tmpvar_20[0] = unity_WorldToObject[0].xyz;
    tmpvar_20[1] = unity_WorldToObject[1].xyz;
    tmpvar_20[2] = unity_WorldToObject[2].xyz;
    lightLocalDir_18 = (mat3(1.0, 0.0, 0.0, 0.0, 0.98481, -0.17365, 0.0, 0.17365, 0.98481) * (tmpvar_20 * lightWorldDir_14));
    highp float tmpvar_21;
    highp float tmpvar_22;
    tmpvar_22 = (min (abs(
      (lightLocalDir_18.z / lightLocalDir_18.y)
    ), 1.0) / max (abs(
      (lightLocalDir_18.z / lightLocalDir_18.y)
    ), 1.0));
    highp float tmpvar_23;
    tmpvar_23 = (tmpvar_22 * tmpvar_22);
    tmpvar_23 = (((
      ((((
        ((((-0.01213232 * tmpvar_23) + 0.05368138) * tmpvar_23) - 0.1173503)
       * tmpvar_23) + 0.1938925) * tmpvar_23) - 0.3326756)
     * tmpvar_23) + 0.9999793) * tmpvar_22);
    tmpvar_23 = (tmpvar_23 + (float(
      (abs((lightLocalDir_18.z / lightLocalDir_18.y)) > 1.0)
    ) * (
      (tmpvar_23 * -2.0)
     + 1.570796)));
    tmpvar_21 = (tmpvar_23 * sign((lightLocalDir_18.z / lightLocalDir_18.y)));
    if ((abs(lightLocalDir_18.y) > (1e-08 * abs(lightLocalDir_18.z)))) {
      if ((lightLocalDir_18.y < 0.0)) {
        if ((lightLocalDir_18.z >= 0.0)) {
          tmpvar_21 += 3.141593;
        } else {
          tmpvar_21 = (tmpvar_21 - 3.141593);
        };
      };
    } else {
      tmpvar_21 = (sign(lightLocalDir_18.z) * 1.570796);
    };
    highp float tmpvar_24;
    tmpvar_24 = (-(tmpvar_21) * 57.29578);
    flipInYAxis_17 = bool(0);
    if ((tmpvar_24 > 0.0)) {
      flipInYAxis_17 = bool(1);
    };
    highp float tmpvar_25;
    tmpvar_25 = clamp (abs((tmpvar_24 / 180.0)), 0.0001, 0.9999);
    if (flipInYAxis_17) {
      texcoord_15 = ((_glesMultiTexCoord0.xy * vec2(-1.0, 1.0)) + vec2(1.0, 0.0));
    };
    highp vec3 tmpvar_26;
    tmpvar_26.xy = texcoord_15;
    tmpvar_26.z = tmpvar_25;
    tmpvar_16 = tmpvar_26;
  };
  if (bool(_UsingDitherAlpha)) {
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_16;
  xlv_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _ShadowThreshold;
uniform mediump float _ShadowFeather;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 lightDir_1;
  mediump vec3 normalDir_2;
  mediump vec4 col_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = max ((_ShadowThreshold - _ShadowFeather), 0.0001);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((
    ((dot (normalDir_2, lightDir_1) * 0.5) + 0.5)
   - tmpvar_7) / (
    min ((_ShadowThreshold + _ShadowFeather), 0.9999)
   - tmpvar_7)), 0.0, 1.0);
  col_3.xyz = (mix (_ShadowColor, vec3(1.0, 1.0, 1.0), vec3((tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  ))) * ((tmpvar_4 * _Color) * _EnvColor).xyz);
  col_3.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_9;
    scrpos_9 = xlv_TEXCOORD2;
    mediump float a_10;
    a_10 = xlv_TEXCOORD2.z;
    if ((a_10 < 0.95)) {
      scrpos_9.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_10 = (a_10 * 17.0);
      highp float tmpvar_11;
      tmpvar_11 = (scrpos_9.y / 4.0);
      highp float tmpvar_12;
      tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
      highp float tmpvar_13;
      if ((tmpvar_11 >= 0.0)) {
        tmpvar_13 = tmpvar_12;
      } else {
        tmpvar_13 = -(tmpvar_12);
      };
      highp float tmpvar_14;
      tmpvar_14 = (scrpos_9.x / 4.0);
      highp float tmpvar_15;
      tmpvar_15 = (fract(abs(tmpvar_14)) * 4.0);
      highp float tmpvar_16;
      if ((tmpvar_14 >= 0.0)) {
        tmpvar_16 = tmpvar_15;
      } else {
        tmpvar_16 = -(tmpvar_15);
      };
      highp float x_17;
      x_17 = ((a_10 - _DITHERMATRIX[
        int(tmpvar_13)
      ][
        int(tmpvar_16)
      ]) - 0.01);
      if ((x_17 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_4 = o_9;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  tmpvar_6 = normalize((_glesNormal * tmpvar_12));
  highp vec3 tmpvar_13;
  tmpvar_13 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_13;
  highp vec3 lightWorldDir_14;
  lightWorldDir_14 = lightDir_1;
  highp vec2 texcoord_15;
  texcoord_15 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_16;
  bool flipInYAxis_17;
  highp vec3 lightLocalDir_18;
  highp float tmpvar_19;
  tmpvar_19 = sqrt(dot (lightWorldDir_14, lightWorldDir_14));
  if ((tmpvar_19 < 0.9)) {
    tmpvar_16 = vec3(0.0, 1.0, 0.0);
  } else {
    highp mat3 tmpvar_20;
    tmpvar_20[0] = unity_WorldToObject[0].xyz;
    tmpvar_20[1] = unity_WorldToObject[1].xyz;
    tmpvar_20[2] = unity_WorldToObject[2].xyz;
    lightLocalDir_18 = (mat3(1.0, 0.0, 0.0, 0.0, 0.98481, -0.17365, 0.0, 0.17365, 0.98481) * (tmpvar_20 * lightWorldDir_14));
    highp float tmpvar_21;
    highp float tmpvar_22;
    tmpvar_22 = (min (abs(
      (lightLocalDir_18.z / lightLocalDir_18.y)
    ), 1.0) / max (abs(
      (lightLocalDir_18.z / lightLocalDir_18.y)
    ), 1.0));
    highp float tmpvar_23;
    tmpvar_23 = (tmpvar_22 * tmpvar_22);
    tmpvar_23 = (((
      ((((
        ((((-0.01213232 * tmpvar_23) + 0.05368138) * tmpvar_23) - 0.1173503)
       * tmpvar_23) + 0.1938925) * tmpvar_23) - 0.3326756)
     * tmpvar_23) + 0.9999793) * tmpvar_22);
    tmpvar_23 = (tmpvar_23 + (float(
      (abs((lightLocalDir_18.z / lightLocalDir_18.y)) > 1.0)
    ) * (
      (tmpvar_23 * -2.0)
     + 1.570796)));
    tmpvar_21 = (tmpvar_23 * sign((lightLocalDir_18.z / lightLocalDir_18.y)));
    if ((abs(lightLocalDir_18.y) > (1e-08 * abs(lightLocalDir_18.z)))) {
      if ((lightLocalDir_18.y < 0.0)) {
        if ((lightLocalDir_18.z >= 0.0)) {
          tmpvar_21 += 3.141593;
        } else {
          tmpvar_21 = (tmpvar_21 - 3.141593);
        };
      };
    } else {
      tmpvar_21 = (sign(lightLocalDir_18.z) * 1.570796);
    };
    highp float tmpvar_24;
    tmpvar_24 = (-(tmpvar_21) * 57.29578);
    flipInYAxis_17 = bool(0);
    if ((tmpvar_24 > 0.0)) {
      flipInYAxis_17 = bool(1);
    };
    highp float tmpvar_25;
    tmpvar_25 = clamp (abs((tmpvar_24 / 180.0)), 0.0001, 0.9999);
    if (flipInYAxis_17) {
      texcoord_15 = ((_glesMultiTexCoord0.xy * vec2(-1.0, 1.0)) + vec2(1.0, 0.0));
    };
    highp vec3 tmpvar_26;
    tmpvar_26.xy = texcoord_15;
    tmpvar_26.z = tmpvar_25;
    tmpvar_16 = tmpvar_26;
  };
  if (bool(_UsingDitherAlpha)) {
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_16;
  xlv_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _ShadowThreshold;
uniform mediump float _ShadowFeather;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 lightDir_1;
  mediump vec3 normalDir_2;
  mediump vec4 col_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = max ((_ShadowThreshold - _ShadowFeather), 0.0001);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((
    ((dot (normalDir_2, lightDir_1) * 0.5) + 0.5)
   - tmpvar_7) / (
    min ((_ShadowThreshold + _ShadowFeather), 0.9999)
   - tmpvar_7)), 0.0, 1.0);
  col_3.xyz = (mix (_ShadowColor, vec3(1.0, 1.0, 1.0), vec3((tmpvar_8 * 
    (tmpvar_8 * (3.0 - (2.0 * tmpvar_8)))
  ))) * ((tmpvar_4 * _Color) * _EnvColor).xyz);
  col_3.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_9;
    scrpos_9 = xlv_TEXCOORD2;
    mediump float a_10;
    a_10 = xlv_TEXCOORD2.z;
    if ((a_10 < 0.95)) {
      scrpos_9.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_10 = (a_10 * 17.0);
      highp float tmpvar_11;
      tmpvar_11 = (scrpos_9.y / 4.0);
      highp float tmpvar_12;
      tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
      highp float tmpvar_13;
      if ((tmpvar_11 >= 0.0)) {
        tmpvar_13 = tmpvar_12;
      } else {
        tmpvar_13 = -(tmpvar_12);
      };
      highp float tmpvar_14;
      tmpvar_14 = (scrpos_9.x / 4.0);
      highp float tmpvar_15;
      tmpvar_15 = (fract(abs(tmpvar_14)) * 4.0);
      highp float tmpvar_16;
      if ((tmpvar_14 >= 0.0)) {
        tmpvar_16 = tmpvar_15;
      } else {
        tmpvar_16 = -(tmpvar_15);
      };
      highp float x_17;
      x_17 = ((a_10 - _DITHERMATRIX[
        int(tmpvar_13)
      ][
        int(tmpvar_16)
      ]) - 0.01);
      if ((x_17 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_4 = o_10;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  tmpvar_6 = normalize((_glesNormal * tmpvar_13));
  highp vec3 tmpvar_14;
  tmpvar_14 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_14;
  highp vec3 lightWorldDir_15;
  lightWorldDir_15 = lightDir_1;
  highp vec2 texcoord_16;
  texcoord_16 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_17;
  bool flipInYAxis_18;
  highp vec3 lightLocalDir_19;
  highp float tmpvar_20;
  tmpvar_20 = sqrt(dot (lightWorldDir_15, lightWorldDir_15));
  if ((tmpvar_20 < 0.9)) {
    tmpvar_17 = vec3(0.0, 1.0, 0.0);
  } else {
    highp mat3 tmpvar_21;
    tmpvar_21[0] = unity_WorldToObject[0].xyz;
    tmpvar_21[1] = unity_WorldToObject[1].xyz;
    tmpvar_21[2] = unity_WorldToObject[2].xyz;
    lightLocalDir_19 = (mat3(1.0, 0.0, 0.0, 0.0, 0.98481, -0.17365, 0.0, 0.17365, 0.98481) * (tmpvar_21 * lightWorldDir_15));
    highp float tmpvar_22;
    highp float tmpvar_23;
    tmpvar_23 = (min (abs(
      (lightLocalDir_19.z / lightLocalDir_19.y)
    ), 1.0) / max (abs(
      (lightLocalDir_19.z / lightLocalDir_19.y)
    ), 1.0));
    highp float tmpvar_24;
    tmpvar_24 = (tmpvar_23 * tmpvar_23);
    tmpvar_24 = (((
      ((((
        ((((-0.01213232 * tmpvar_24) + 0.05368138) * tmpvar_24) - 0.1173503)
       * tmpvar_24) + 0.1938925) * tmpvar_24) - 0.3326756)
     * tmpvar_24) + 0.9999793) * tmpvar_23);
    tmpvar_24 = (tmpvar_24 + (float(
      (abs((lightLocalDir_19.z / lightLocalDir_19.y)) > 1.0)
    ) * (
      (tmpvar_24 * -2.0)
     + 1.570796)));
    tmpvar_22 = (tmpvar_24 * sign((lightLocalDir_19.z / lightLocalDir_19.y)));
    if ((abs(lightLocalDir_19.y) > (1e-08 * abs(lightLocalDir_19.z)))) {
      if ((lightLocalDir_19.y < 0.0)) {
        if ((lightLocalDir_19.z >= 0.0)) {
          tmpvar_22 += 3.141593;
        } else {
          tmpvar_22 = (tmpvar_22 - 3.141593);
        };
      };
    } else {
      tmpvar_22 = (sign(lightLocalDir_19.z) * 1.570796);
    };
    highp float tmpvar_25;
    tmpvar_25 = (-(tmpvar_22) * 57.29578);
    flipInYAxis_18 = bool(0);
    if ((tmpvar_25 > 0.0)) {
      flipInYAxis_18 = bool(1);
    };
    highp float tmpvar_26;
    tmpvar_26 = clamp (abs((tmpvar_25 / 180.0)), 0.0001, 0.9999);
    if (flipInYAxis_18) {
      texcoord_16 = ((_glesMultiTexCoord0.xy * vec2(-1.0, 1.0)) + vec2(1.0, 0.0));
    };
    highp vec3 tmpvar_27;
    tmpvar_27.xy = texcoord_16;
    tmpvar_27.z = tmpvar_26;
    tmpvar_17 = tmpvar_27;
  };
  mediump vec3 tmpvar_28;
  highp vec3 lightColor0_29;
  lightColor0_29 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_30;
  lightColor1_30 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_31;
  lightColor2_31 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_32;
  lightColor3_32 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_33;
  lightAttenSq_33 = unity_4LightAtten0;
  highp vec3 col_34;
  highp vec4 ndotl_35;
  highp vec4 lengthSq_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_38;
  tmpvar_38 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_39;
  tmpvar_39 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_36 = (tmpvar_37 * tmpvar_37);
  lengthSq_36 = (lengthSq_36 + (tmpvar_38 * tmpvar_38));
  lengthSq_36 = (lengthSq_36 + (tmpvar_39 * tmpvar_39));
  highp vec4 tmpvar_40;
  tmpvar_40 = max (lengthSq_36, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_36 = tmpvar_40;
  ndotl_35 = (tmpvar_37 * tmpvar_6.x);
  ndotl_35 = (ndotl_35 + (tmpvar_38 * tmpvar_6.y));
  ndotl_35 = (ndotl_35 + (tmpvar_39 * tmpvar_6.z));
  highp vec4 tmpvar_41;
  tmpvar_41 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_35 * inversesqrt(tmpvar_40)));
  ndotl_35 = tmpvar_41;
  highp vec4 tmpvar_42;
  tmpvar_42 = (tmpvar_41 * (1.0/((1.0 + 
    (tmpvar_40 * lightAttenSq_33)
  ))));
  col_34 = (lightColor0_29 * tmpvar_42.x);
  col_34 = (col_34 + (lightColor1_30 * tmpvar_42.y));
  col_34 = (col_34 + (lightColor2_31 * tmpvar_42.z));
  col_34 = (col_34 + (lightColor3_32 * tmpvar_42.w));
  tmpvar_28 = col_34;
  tmpvar_7.xyz = tmpvar_28;
  if (bool(_UsingDitherAlpha)) {
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_17;
  xlv_TEXCOORD6 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _ShadowThreshold;
uniform mediump float _ShadowFeather;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  mediump vec3 normalDir_2;
  mediump vec4 col_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = max ((_ShadowThreshold - _ShadowFeather), 0.0001);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((
    ((dot (normalDir_2, lightDir_1) * 0.5) + 0.5)
   - tmpvar_7) / (
    min ((_ShadowThreshold + _ShadowFeather), 0.9999)
   - tmpvar_7)), 0.0, 1.0);
  col_3.xyz = ((mix (_ShadowColor, vec3(1.0, 1.0, 1.0), vec3(
    (tmpvar_8 * (tmpvar_8 * (3.0 - (2.0 * tmpvar_8))))
  )) * (
    (tmpvar_4 * _Color)
   * _EnvColor).xyz) * (vec3(1.0, 1.0, 1.0) + xlv_TEXCOORD6.xyz));
  col_3.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_9;
    scrpos_9 = xlv_TEXCOORD2;
    mediump float a_10;
    a_10 = xlv_TEXCOORD2.z;
    if ((a_10 < 0.95)) {
      scrpos_9.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_10 = (a_10 * 17.0);
      highp float tmpvar_11;
      tmpvar_11 = (scrpos_9.y / 4.0);
      highp float tmpvar_12;
      tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
      highp float tmpvar_13;
      if ((tmpvar_11 >= 0.0)) {
        tmpvar_13 = tmpvar_12;
      } else {
        tmpvar_13 = -(tmpvar_12);
      };
      highp float tmpvar_14;
      tmpvar_14 = (scrpos_9.x / 4.0);
      highp float tmpvar_15;
      tmpvar_15 = (fract(abs(tmpvar_14)) * 4.0);
      highp float tmpvar_16;
      if ((tmpvar_14 >= 0.0)) {
        tmpvar_16 = tmpvar_15;
      } else {
        tmpvar_16 = -(tmpvar_15);
      };
      highp float x_17;
      x_17 = ((a_10 - _DITHERMATRIX[
        int(tmpvar_13)
      ][
        int(tmpvar_16)
      ]) - 0.01);
      if ((x_17 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_4 = o_10;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  tmpvar_6 = normalize((_glesNormal * tmpvar_13));
  highp vec3 tmpvar_14;
  tmpvar_14 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_14;
  highp vec3 lightWorldDir_15;
  lightWorldDir_15 = lightDir_1;
  highp vec2 texcoord_16;
  texcoord_16 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_17;
  bool flipInYAxis_18;
  highp vec3 lightLocalDir_19;
  highp float tmpvar_20;
  tmpvar_20 = sqrt(dot (lightWorldDir_15, lightWorldDir_15));
  if ((tmpvar_20 < 0.9)) {
    tmpvar_17 = vec3(0.0, 1.0, 0.0);
  } else {
    highp mat3 tmpvar_21;
    tmpvar_21[0] = unity_WorldToObject[0].xyz;
    tmpvar_21[1] = unity_WorldToObject[1].xyz;
    tmpvar_21[2] = unity_WorldToObject[2].xyz;
    lightLocalDir_19 = (mat3(1.0, 0.0, 0.0, 0.0, 0.98481, -0.17365, 0.0, 0.17365, 0.98481) * (tmpvar_21 * lightWorldDir_15));
    highp float tmpvar_22;
    highp float tmpvar_23;
    tmpvar_23 = (min (abs(
      (lightLocalDir_19.z / lightLocalDir_19.y)
    ), 1.0) / max (abs(
      (lightLocalDir_19.z / lightLocalDir_19.y)
    ), 1.0));
    highp float tmpvar_24;
    tmpvar_24 = (tmpvar_23 * tmpvar_23);
    tmpvar_24 = (((
      ((((
        ((((-0.01213232 * tmpvar_24) + 0.05368138) * tmpvar_24) - 0.1173503)
       * tmpvar_24) + 0.1938925) * tmpvar_24) - 0.3326756)
     * tmpvar_24) + 0.9999793) * tmpvar_23);
    tmpvar_24 = (tmpvar_24 + (float(
      (abs((lightLocalDir_19.z / lightLocalDir_19.y)) > 1.0)
    ) * (
      (tmpvar_24 * -2.0)
     + 1.570796)));
    tmpvar_22 = (tmpvar_24 * sign((lightLocalDir_19.z / lightLocalDir_19.y)));
    if ((abs(lightLocalDir_19.y) > (1e-08 * abs(lightLocalDir_19.z)))) {
      if ((lightLocalDir_19.y < 0.0)) {
        if ((lightLocalDir_19.z >= 0.0)) {
          tmpvar_22 += 3.141593;
        } else {
          tmpvar_22 = (tmpvar_22 - 3.141593);
        };
      };
    } else {
      tmpvar_22 = (sign(lightLocalDir_19.z) * 1.570796);
    };
    highp float tmpvar_25;
    tmpvar_25 = (-(tmpvar_22) * 57.29578);
    flipInYAxis_18 = bool(0);
    if ((tmpvar_25 > 0.0)) {
      flipInYAxis_18 = bool(1);
    };
    highp float tmpvar_26;
    tmpvar_26 = clamp (abs((tmpvar_25 / 180.0)), 0.0001, 0.9999);
    if (flipInYAxis_18) {
      texcoord_16 = ((_glesMultiTexCoord0.xy * vec2(-1.0, 1.0)) + vec2(1.0, 0.0));
    };
    highp vec3 tmpvar_27;
    tmpvar_27.xy = texcoord_16;
    tmpvar_27.z = tmpvar_26;
    tmpvar_17 = tmpvar_27;
  };
  mediump vec3 tmpvar_28;
  highp vec3 lightColor0_29;
  lightColor0_29 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_30;
  lightColor1_30 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_31;
  lightColor2_31 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_32;
  lightColor3_32 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_33;
  lightAttenSq_33 = unity_4LightAtten0;
  highp vec3 col_34;
  highp vec4 ndotl_35;
  highp vec4 lengthSq_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_38;
  tmpvar_38 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_39;
  tmpvar_39 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_36 = (tmpvar_37 * tmpvar_37);
  lengthSq_36 = (lengthSq_36 + (tmpvar_38 * tmpvar_38));
  lengthSq_36 = (lengthSq_36 + (tmpvar_39 * tmpvar_39));
  highp vec4 tmpvar_40;
  tmpvar_40 = max (lengthSq_36, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_36 = tmpvar_40;
  ndotl_35 = (tmpvar_37 * tmpvar_6.x);
  ndotl_35 = (ndotl_35 + (tmpvar_38 * tmpvar_6.y));
  ndotl_35 = (ndotl_35 + (tmpvar_39 * tmpvar_6.z));
  highp vec4 tmpvar_41;
  tmpvar_41 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_35 * inversesqrt(tmpvar_40)));
  ndotl_35 = tmpvar_41;
  highp vec4 tmpvar_42;
  tmpvar_42 = (tmpvar_41 * (1.0/((1.0 + 
    (tmpvar_40 * lightAttenSq_33)
  ))));
  col_34 = (lightColor0_29 * tmpvar_42.x);
  col_34 = (col_34 + (lightColor1_30 * tmpvar_42.y));
  col_34 = (col_34 + (lightColor2_31 * tmpvar_42.z));
  col_34 = (col_34 + (lightColor3_32 * tmpvar_42.w));
  tmpvar_28 = col_34;
  tmpvar_7.xyz = tmpvar_28;
  if (bool(_UsingDitherAlpha)) {
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_17;
  xlv_TEXCOORD6 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _ShadowThreshold;
uniform mediump float _ShadowFeather;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  mediump vec3 normalDir_2;
  mediump vec4 col_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = max ((_ShadowThreshold - _ShadowFeather), 0.0001);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((
    ((dot (normalDir_2, lightDir_1) * 0.5) + 0.5)
   - tmpvar_7) / (
    min ((_ShadowThreshold + _ShadowFeather), 0.9999)
   - tmpvar_7)), 0.0, 1.0);
  col_3.xyz = ((mix (_ShadowColor, vec3(1.0, 1.0, 1.0), vec3(
    (tmpvar_8 * (tmpvar_8 * (3.0 - (2.0 * tmpvar_8))))
  )) * (
    (tmpvar_4 * _Color)
   * _EnvColor).xyz) * (vec3(1.0, 1.0, 1.0) + xlv_TEXCOORD6.xyz));
  col_3.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_9;
    scrpos_9 = xlv_TEXCOORD2;
    mediump float a_10;
    a_10 = xlv_TEXCOORD2.z;
    if ((a_10 < 0.95)) {
      scrpos_9.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_10 = (a_10 * 17.0);
      highp float tmpvar_11;
      tmpvar_11 = (scrpos_9.y / 4.0);
      highp float tmpvar_12;
      tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
      highp float tmpvar_13;
      if ((tmpvar_11 >= 0.0)) {
        tmpvar_13 = tmpvar_12;
      } else {
        tmpvar_13 = -(tmpvar_12);
      };
      highp float tmpvar_14;
      tmpvar_14 = (scrpos_9.x / 4.0);
      highp float tmpvar_15;
      tmpvar_15 = (fract(abs(tmpvar_14)) * 4.0);
      highp float tmpvar_16;
      if ((tmpvar_14 >= 0.0)) {
        tmpvar_16 = tmpvar_15;
      } else {
        tmpvar_16 = -(tmpvar_15);
      };
      highp float x_17;
      x_17 = ((a_10 - _DITHERMATRIX[
        int(tmpvar_13)
      ][
        int(tmpvar_16)
      ]) - 0.01);
      if ((x_17 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_4 = o_10;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  tmpvar_6 = normalize((_glesNormal * tmpvar_13));
  highp vec3 tmpvar_14;
  tmpvar_14 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_14;
  highp vec3 lightWorldDir_15;
  lightWorldDir_15 = lightDir_1;
  highp vec2 texcoord_16;
  texcoord_16 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_17;
  bool flipInYAxis_18;
  highp vec3 lightLocalDir_19;
  highp float tmpvar_20;
  tmpvar_20 = sqrt(dot (lightWorldDir_15, lightWorldDir_15));
  if ((tmpvar_20 < 0.9)) {
    tmpvar_17 = vec3(0.0, 1.0, 0.0);
  } else {
    highp mat3 tmpvar_21;
    tmpvar_21[0] = unity_WorldToObject[0].xyz;
    tmpvar_21[1] = unity_WorldToObject[1].xyz;
    tmpvar_21[2] = unity_WorldToObject[2].xyz;
    lightLocalDir_19 = (mat3(1.0, 0.0, 0.0, 0.0, 0.98481, -0.17365, 0.0, 0.17365, 0.98481) * (tmpvar_21 * lightWorldDir_15));
    highp float tmpvar_22;
    highp float tmpvar_23;
    tmpvar_23 = (min (abs(
      (lightLocalDir_19.z / lightLocalDir_19.y)
    ), 1.0) / max (abs(
      (lightLocalDir_19.z / lightLocalDir_19.y)
    ), 1.0));
    highp float tmpvar_24;
    tmpvar_24 = (tmpvar_23 * tmpvar_23);
    tmpvar_24 = (((
      ((((
        ((((-0.01213232 * tmpvar_24) + 0.05368138) * tmpvar_24) - 0.1173503)
       * tmpvar_24) + 0.1938925) * tmpvar_24) - 0.3326756)
     * tmpvar_24) + 0.9999793) * tmpvar_23);
    tmpvar_24 = (tmpvar_24 + (float(
      (abs((lightLocalDir_19.z / lightLocalDir_19.y)) > 1.0)
    ) * (
      (tmpvar_24 * -2.0)
     + 1.570796)));
    tmpvar_22 = (tmpvar_24 * sign((lightLocalDir_19.z / lightLocalDir_19.y)));
    if ((abs(lightLocalDir_19.y) > (1e-08 * abs(lightLocalDir_19.z)))) {
      if ((lightLocalDir_19.y < 0.0)) {
        if ((lightLocalDir_19.z >= 0.0)) {
          tmpvar_22 += 3.141593;
        } else {
          tmpvar_22 = (tmpvar_22 - 3.141593);
        };
      };
    } else {
      tmpvar_22 = (sign(lightLocalDir_19.z) * 1.570796);
    };
    highp float tmpvar_25;
    tmpvar_25 = (-(tmpvar_22) * 57.29578);
    flipInYAxis_18 = bool(0);
    if ((tmpvar_25 > 0.0)) {
      flipInYAxis_18 = bool(1);
    };
    highp float tmpvar_26;
    tmpvar_26 = clamp (abs((tmpvar_25 / 180.0)), 0.0001, 0.9999);
    if (flipInYAxis_18) {
      texcoord_16 = ((_glesMultiTexCoord0.xy * vec2(-1.0, 1.0)) + vec2(1.0, 0.0));
    };
    highp vec3 tmpvar_27;
    tmpvar_27.xy = texcoord_16;
    tmpvar_27.z = tmpvar_26;
    tmpvar_17 = tmpvar_27;
  };
  mediump vec3 tmpvar_28;
  highp vec3 lightColor0_29;
  lightColor0_29 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_30;
  lightColor1_30 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_31;
  lightColor2_31 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_32;
  lightColor3_32 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_33;
  lightAttenSq_33 = unity_4LightAtten0;
  highp vec3 col_34;
  highp vec4 ndotl_35;
  highp vec4 lengthSq_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_38;
  tmpvar_38 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_39;
  tmpvar_39 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_36 = (tmpvar_37 * tmpvar_37);
  lengthSq_36 = (lengthSq_36 + (tmpvar_38 * tmpvar_38));
  lengthSq_36 = (lengthSq_36 + (tmpvar_39 * tmpvar_39));
  highp vec4 tmpvar_40;
  tmpvar_40 = max (lengthSq_36, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_36 = tmpvar_40;
  ndotl_35 = (tmpvar_37 * tmpvar_6.x);
  ndotl_35 = (ndotl_35 + (tmpvar_38 * tmpvar_6.y));
  ndotl_35 = (ndotl_35 + (tmpvar_39 * tmpvar_6.z));
  highp vec4 tmpvar_41;
  tmpvar_41 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_35 * inversesqrt(tmpvar_40)));
  ndotl_35 = tmpvar_41;
  highp vec4 tmpvar_42;
  tmpvar_42 = (tmpvar_41 * (1.0/((1.0 + 
    (tmpvar_40 * lightAttenSq_33)
  ))));
  col_34 = (lightColor0_29 * tmpvar_42.x);
  col_34 = (col_34 + (lightColor1_30 * tmpvar_42.y));
  col_34 = (col_34 + (lightColor2_31 * tmpvar_42.z));
  col_34 = (col_34 + (lightColor3_32 * tmpvar_42.w));
  tmpvar_28 = col_34;
  tmpvar_7.xyz = tmpvar_28;
  if (bool(_UsingDitherAlpha)) {
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_17;
  xlv_TEXCOORD6 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _ShadowThreshold;
uniform mediump float _ShadowFeather;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  mediump vec3 normalDir_2;
  mediump vec4 col_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = max ((_ShadowThreshold - _ShadowFeather), 0.0001);
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((
    ((dot (normalDir_2, lightDir_1) * 0.5) + 0.5)
   - tmpvar_7) / (
    min ((_ShadowThreshold + _ShadowFeather), 0.9999)
   - tmpvar_7)), 0.0, 1.0);
  col_3.xyz = ((mix (_ShadowColor, vec3(1.0, 1.0, 1.0), vec3(
    (tmpvar_8 * (tmpvar_8 * (3.0 - (2.0 * tmpvar_8))))
  )) * (
    (tmpvar_4 * _Color)
   * _EnvColor).xyz) * (vec3(1.0, 1.0, 1.0) + xlv_TEXCOORD6.xyz));
  col_3.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_9;
    scrpos_9 = xlv_TEXCOORD2;
    mediump float a_10;
    a_10 = xlv_TEXCOORD2.z;
    if ((a_10 < 0.95)) {
      scrpos_9.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_10 = (a_10 * 17.0);
      highp float tmpvar_11;
      tmpvar_11 = (scrpos_9.y / 4.0);
      highp float tmpvar_12;
      tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
      highp float tmpvar_13;
      if ((tmpvar_11 >= 0.0)) {
        tmpvar_13 = tmpvar_12;
      } else {
        tmpvar_13 = -(tmpvar_12);
      };
      highp float tmpvar_14;
      tmpvar_14 = (scrpos_9.x / 4.0);
      highp float tmpvar_15;
      tmpvar_15 = (fract(abs(tmpvar_14)) * 4.0);
      highp float tmpvar_16;
      if ((tmpvar_14 >= 0.0)) {
        tmpvar_16 = tmpvar_15;
      } else {
        tmpvar_16 = -(tmpvar_15);
      };
      highp float x_17;
      x_17 = ((a_10 - _DITHERMATRIX[
        int(tmpvar_13)
      ][
        int(tmpvar_16)
      ]) - 0.01);
      if ((x_17 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_FACEMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_4 = o_9;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  tmpvar_6 = normalize((_glesNormal * tmpvar_12));
  highp vec3 tmpvar_13;
  tmpvar_13 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_13;
  highp vec3 lightWorldDir_14;
  lightWorldDir_14 = lightDir_1;
  highp vec2 texcoord_15;
  texcoord_15 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_16;
  bool flipInYAxis_17;
  highp vec3 lightLocalDir_18;
  highp float tmpvar_19;
  tmpvar_19 = sqrt(dot (lightWorldDir_14, lightWorldDir_14));
  if ((tmpvar_19 < 0.9)) {
    tmpvar_16 = vec3(0.0, 1.0, 0.0);
  } else {
    highp mat3 tmpvar_20;
    tmpvar_20[0] = unity_WorldToObject[0].xyz;
    tmpvar_20[1] = unity_WorldToObject[1].xyz;
    tmpvar_20[2] = unity_WorldToObject[2].xyz;
    lightLocalDir_18 = (mat3(1.0, 0.0, 0.0, 0.0, 0.98481, -0.17365, 0.0, 0.17365, 0.98481) * (tmpvar_20 * lightWorldDir_14));
    highp float tmpvar_21;
    highp float tmpvar_22;
    tmpvar_22 = (min (abs(
      (lightLocalDir_18.z / lightLocalDir_18.y)
    ), 1.0) / max (abs(
      (lightLocalDir_18.z / lightLocalDir_18.y)
    ), 1.0));
    highp float tmpvar_23;
    tmpvar_23 = (tmpvar_22 * tmpvar_22);
    tmpvar_23 = (((
      ((((
        ((((-0.01213232 * tmpvar_23) + 0.05368138) * tmpvar_23) - 0.1173503)
       * tmpvar_23) + 0.1938925) * tmpvar_23) - 0.3326756)
     * tmpvar_23) + 0.9999793) * tmpvar_22);
    tmpvar_23 = (tmpvar_23 + (float(
      (abs((lightLocalDir_18.z / lightLocalDir_18.y)) > 1.0)
    ) * (
      (tmpvar_23 * -2.0)
     + 1.570796)));
    tmpvar_21 = (tmpvar_23 * sign((lightLocalDir_18.z / lightLocalDir_18.y)));
    if ((abs(lightLocalDir_18.y) > (1e-08 * abs(lightLocalDir_18.z)))) {
      if ((lightLocalDir_18.y < 0.0)) {
        if ((lightLocalDir_18.z >= 0.0)) {
          tmpvar_21 += 3.141593;
        } else {
          tmpvar_21 = (tmpvar_21 - 3.141593);
        };
      };
    } else {
      tmpvar_21 = (sign(lightLocalDir_18.z) * 1.570796);
    };
    highp float tmpvar_24;
    tmpvar_24 = (-(tmpvar_21) * 57.29578);
    flipInYAxis_17 = bool(0);
    if ((tmpvar_24 > 0.0)) {
      flipInYAxis_17 = bool(1);
    };
    highp float tmpvar_25;
    tmpvar_25 = clamp (abs((tmpvar_24 / 180.0)), 0.0001, 0.9999);
    if (flipInYAxis_17) {
      texcoord_15 = ((_glesMultiTexCoord0.xy * vec2(-1.0, 1.0)) + vec2(1.0, 0.0));
    };
    highp vec3 tmpvar_26;
    tmpvar_26.xy = texcoord_15;
    tmpvar_26.z = tmpvar_25;
    tmpvar_16 = tmpvar_26;
  };
  if (bool(_UsingDitherAlpha)) {
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_16;
  xlv_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _ShadowFeather;
uniform mediump float _UsingDitherAlpha;
uniform sampler2D _FaceMap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  mediump float diffuseThreshold_1;
  mediump vec4 col_2;
  mediump vec3 lightmap_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMap, xlv_TEXCOORD0).xyz;
  lightmap_3 = tmpvar_5;
  lowp float tmpvar_6;
  tmpvar_6 = texture2D (_FaceMap, xlv_TEXCOORD5.xy).w;
  diffuseThreshold_1 = tmpvar_6;
  mediump float lightingThreshold_7;
  lightingThreshold_7 = xlv_TEXCOORD5.z;
  mediump float tmpvar_8;
  tmpvar_8 = max ((lightingThreshold_7 - _ShadowFeather), 0.0001);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((diffuseThreshold_1 - tmpvar_8) / (
    min ((lightingThreshold_7 + _ShadowFeather), 0.9999)
   - tmpvar_8)), 0.0, 1.0);
  col_2.xyz = (mix (_ShadowColor, vec3(1.0, 1.0, 1.0), vec3((
    (tmpvar_9 * (tmpvar_9 * (3.0 - (2.0 * tmpvar_9))))
   * lightmap_3.y))) * ((tmpvar_4 * _Color) * _EnvColor).xyz);
  col_2.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_10;
    scrpos_10 = xlv_TEXCOORD2;
    mediump float a_11;
    a_11 = xlv_TEXCOORD2.z;
    if ((a_11 < 0.95)) {
      scrpos_10.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_11 = (a_11 * 17.0);
      highp float tmpvar_12;
      tmpvar_12 = (scrpos_10.y / 4.0);
      highp float tmpvar_13;
      tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
      highp float tmpvar_14;
      if ((tmpvar_12 >= 0.0)) {
        tmpvar_14 = tmpvar_13;
      } else {
        tmpvar_14 = -(tmpvar_13);
      };
      highp float tmpvar_15;
      tmpvar_15 = (scrpos_10.x / 4.0);
      highp float tmpvar_16;
      tmpvar_16 = (fract(abs(tmpvar_15)) * 4.0);
      highp float tmpvar_17;
      if ((tmpvar_15 >= 0.0)) {
        tmpvar_17 = tmpvar_16;
      } else {
        tmpvar_17 = -(tmpvar_16);
      };
      highp float x_18;
      x_18 = ((a_11 - _DITHERMATRIX[
        int(tmpvar_14)
      ][
        int(tmpvar_17)
      ]) - 0.01);
      if ((x_18 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_FACEMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_4 = o_9;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  tmpvar_6 = normalize((_glesNormal * tmpvar_12));
  highp vec3 tmpvar_13;
  tmpvar_13 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_13;
  highp vec3 lightWorldDir_14;
  lightWorldDir_14 = lightDir_1;
  highp vec2 texcoord_15;
  texcoord_15 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_16;
  bool flipInYAxis_17;
  highp vec3 lightLocalDir_18;
  highp float tmpvar_19;
  tmpvar_19 = sqrt(dot (lightWorldDir_14, lightWorldDir_14));
  if ((tmpvar_19 < 0.9)) {
    tmpvar_16 = vec3(0.0, 1.0, 0.0);
  } else {
    highp mat3 tmpvar_20;
    tmpvar_20[0] = unity_WorldToObject[0].xyz;
    tmpvar_20[1] = unity_WorldToObject[1].xyz;
    tmpvar_20[2] = unity_WorldToObject[2].xyz;
    lightLocalDir_18 = (mat3(1.0, 0.0, 0.0, 0.0, 0.98481, -0.17365, 0.0, 0.17365, 0.98481) * (tmpvar_20 * lightWorldDir_14));
    highp float tmpvar_21;
    highp float tmpvar_22;
    tmpvar_22 = (min (abs(
      (lightLocalDir_18.z / lightLocalDir_18.y)
    ), 1.0) / max (abs(
      (lightLocalDir_18.z / lightLocalDir_18.y)
    ), 1.0));
    highp float tmpvar_23;
    tmpvar_23 = (tmpvar_22 * tmpvar_22);
    tmpvar_23 = (((
      ((((
        ((((-0.01213232 * tmpvar_23) + 0.05368138) * tmpvar_23) - 0.1173503)
       * tmpvar_23) + 0.1938925) * tmpvar_23) - 0.3326756)
     * tmpvar_23) + 0.9999793) * tmpvar_22);
    tmpvar_23 = (tmpvar_23 + (float(
      (abs((lightLocalDir_18.z / lightLocalDir_18.y)) > 1.0)
    ) * (
      (tmpvar_23 * -2.0)
     + 1.570796)));
    tmpvar_21 = (tmpvar_23 * sign((lightLocalDir_18.z / lightLocalDir_18.y)));
    if ((abs(lightLocalDir_18.y) > (1e-08 * abs(lightLocalDir_18.z)))) {
      if ((lightLocalDir_18.y < 0.0)) {
        if ((lightLocalDir_18.z >= 0.0)) {
          tmpvar_21 += 3.141593;
        } else {
          tmpvar_21 = (tmpvar_21 - 3.141593);
        };
      };
    } else {
      tmpvar_21 = (sign(lightLocalDir_18.z) * 1.570796);
    };
    highp float tmpvar_24;
    tmpvar_24 = (-(tmpvar_21) * 57.29578);
    flipInYAxis_17 = bool(0);
    if ((tmpvar_24 > 0.0)) {
      flipInYAxis_17 = bool(1);
    };
    highp float tmpvar_25;
    tmpvar_25 = clamp (abs((tmpvar_24 / 180.0)), 0.0001, 0.9999);
    if (flipInYAxis_17) {
      texcoord_15 = ((_glesMultiTexCoord0.xy * vec2(-1.0, 1.0)) + vec2(1.0, 0.0));
    };
    highp vec3 tmpvar_26;
    tmpvar_26.xy = texcoord_15;
    tmpvar_26.z = tmpvar_25;
    tmpvar_16 = tmpvar_26;
  };
  if (bool(_UsingDitherAlpha)) {
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_16;
  xlv_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _ShadowFeather;
uniform mediump float _UsingDitherAlpha;
uniform sampler2D _FaceMap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  mediump float diffuseThreshold_1;
  mediump vec4 col_2;
  mediump vec3 lightmap_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMap, xlv_TEXCOORD0).xyz;
  lightmap_3 = tmpvar_5;
  lowp float tmpvar_6;
  tmpvar_6 = texture2D (_FaceMap, xlv_TEXCOORD5.xy).w;
  diffuseThreshold_1 = tmpvar_6;
  mediump float lightingThreshold_7;
  lightingThreshold_7 = xlv_TEXCOORD5.z;
  mediump float tmpvar_8;
  tmpvar_8 = max ((lightingThreshold_7 - _ShadowFeather), 0.0001);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((diffuseThreshold_1 - tmpvar_8) / (
    min ((lightingThreshold_7 + _ShadowFeather), 0.9999)
   - tmpvar_8)), 0.0, 1.0);
  col_2.xyz = (mix (_ShadowColor, vec3(1.0, 1.0, 1.0), vec3((
    (tmpvar_9 * (tmpvar_9 * (3.0 - (2.0 * tmpvar_9))))
   * lightmap_3.y))) * ((tmpvar_4 * _Color) * _EnvColor).xyz);
  col_2.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_10;
    scrpos_10 = xlv_TEXCOORD2;
    mediump float a_11;
    a_11 = xlv_TEXCOORD2.z;
    if ((a_11 < 0.95)) {
      scrpos_10.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_11 = (a_11 * 17.0);
      highp float tmpvar_12;
      tmpvar_12 = (scrpos_10.y / 4.0);
      highp float tmpvar_13;
      tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
      highp float tmpvar_14;
      if ((tmpvar_12 >= 0.0)) {
        tmpvar_14 = tmpvar_13;
      } else {
        tmpvar_14 = -(tmpvar_13);
      };
      highp float tmpvar_15;
      tmpvar_15 = (scrpos_10.x / 4.0);
      highp float tmpvar_16;
      tmpvar_16 = (fract(abs(tmpvar_15)) * 4.0);
      highp float tmpvar_17;
      if ((tmpvar_15 >= 0.0)) {
        tmpvar_17 = tmpvar_16;
      } else {
        tmpvar_17 = -(tmpvar_16);
      };
      highp float x_18;
      x_18 = ((a_11 - _DITHERMATRIX[
        int(tmpvar_14)
      ][
        int(tmpvar_17)
      ]) - 0.01);
      if ((x_18 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_FACEMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_4 = o_9;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  tmpvar_6 = normalize((_glesNormal * tmpvar_12));
  highp vec3 tmpvar_13;
  tmpvar_13 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_13;
  highp vec3 lightWorldDir_14;
  lightWorldDir_14 = lightDir_1;
  highp vec2 texcoord_15;
  texcoord_15 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_16;
  bool flipInYAxis_17;
  highp vec3 lightLocalDir_18;
  highp float tmpvar_19;
  tmpvar_19 = sqrt(dot (lightWorldDir_14, lightWorldDir_14));
  if ((tmpvar_19 < 0.9)) {
    tmpvar_16 = vec3(0.0, 1.0, 0.0);
  } else {
    highp mat3 tmpvar_20;
    tmpvar_20[0] = unity_WorldToObject[0].xyz;
    tmpvar_20[1] = unity_WorldToObject[1].xyz;
    tmpvar_20[2] = unity_WorldToObject[2].xyz;
    lightLocalDir_18 = (mat3(1.0, 0.0, 0.0, 0.0, 0.98481, -0.17365, 0.0, 0.17365, 0.98481) * (tmpvar_20 * lightWorldDir_14));
    highp float tmpvar_21;
    highp float tmpvar_22;
    tmpvar_22 = (min (abs(
      (lightLocalDir_18.z / lightLocalDir_18.y)
    ), 1.0) / max (abs(
      (lightLocalDir_18.z / lightLocalDir_18.y)
    ), 1.0));
    highp float tmpvar_23;
    tmpvar_23 = (tmpvar_22 * tmpvar_22);
    tmpvar_23 = (((
      ((((
        ((((-0.01213232 * tmpvar_23) + 0.05368138) * tmpvar_23) - 0.1173503)
       * tmpvar_23) + 0.1938925) * tmpvar_23) - 0.3326756)
     * tmpvar_23) + 0.9999793) * tmpvar_22);
    tmpvar_23 = (tmpvar_23 + (float(
      (abs((lightLocalDir_18.z / lightLocalDir_18.y)) > 1.0)
    ) * (
      (tmpvar_23 * -2.0)
     + 1.570796)));
    tmpvar_21 = (tmpvar_23 * sign((lightLocalDir_18.z / lightLocalDir_18.y)));
    if ((abs(lightLocalDir_18.y) > (1e-08 * abs(lightLocalDir_18.z)))) {
      if ((lightLocalDir_18.y < 0.0)) {
        if ((lightLocalDir_18.z >= 0.0)) {
          tmpvar_21 += 3.141593;
        } else {
          tmpvar_21 = (tmpvar_21 - 3.141593);
        };
      };
    } else {
      tmpvar_21 = (sign(lightLocalDir_18.z) * 1.570796);
    };
    highp float tmpvar_24;
    tmpvar_24 = (-(tmpvar_21) * 57.29578);
    flipInYAxis_17 = bool(0);
    if ((tmpvar_24 > 0.0)) {
      flipInYAxis_17 = bool(1);
    };
    highp float tmpvar_25;
    tmpvar_25 = clamp (abs((tmpvar_24 / 180.0)), 0.0001, 0.9999);
    if (flipInYAxis_17) {
      texcoord_15 = ((_glesMultiTexCoord0.xy * vec2(-1.0, 1.0)) + vec2(1.0, 0.0));
    };
    highp vec3 tmpvar_26;
    tmpvar_26.xy = texcoord_15;
    tmpvar_26.z = tmpvar_25;
    tmpvar_16 = tmpvar_26;
  };
  if (bool(_UsingDitherAlpha)) {
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_16;
  xlv_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _ShadowFeather;
uniform mediump float _UsingDitherAlpha;
uniform sampler2D _FaceMap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  mediump float diffuseThreshold_1;
  mediump vec4 col_2;
  mediump vec3 lightmap_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMap, xlv_TEXCOORD0).xyz;
  lightmap_3 = tmpvar_5;
  lowp float tmpvar_6;
  tmpvar_6 = texture2D (_FaceMap, xlv_TEXCOORD5.xy).w;
  diffuseThreshold_1 = tmpvar_6;
  mediump float lightingThreshold_7;
  lightingThreshold_7 = xlv_TEXCOORD5.z;
  mediump float tmpvar_8;
  tmpvar_8 = max ((lightingThreshold_7 - _ShadowFeather), 0.0001);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((diffuseThreshold_1 - tmpvar_8) / (
    min ((lightingThreshold_7 + _ShadowFeather), 0.9999)
   - tmpvar_8)), 0.0, 1.0);
  col_2.xyz = (mix (_ShadowColor, vec3(1.0, 1.0, 1.0), vec3((
    (tmpvar_9 * (tmpvar_9 * (3.0 - (2.0 * tmpvar_9))))
   * lightmap_3.y))) * ((tmpvar_4 * _Color) * _EnvColor).xyz);
  col_2.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_10;
    scrpos_10 = xlv_TEXCOORD2;
    mediump float a_11;
    a_11 = xlv_TEXCOORD2.z;
    if ((a_11 < 0.95)) {
      scrpos_10.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_11 = (a_11 * 17.0);
      highp float tmpvar_12;
      tmpvar_12 = (scrpos_10.y / 4.0);
      highp float tmpvar_13;
      tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
      highp float tmpvar_14;
      if ((tmpvar_12 >= 0.0)) {
        tmpvar_14 = tmpvar_13;
      } else {
        tmpvar_14 = -(tmpvar_13);
      };
      highp float tmpvar_15;
      tmpvar_15 = (scrpos_10.x / 4.0);
      highp float tmpvar_16;
      tmpvar_16 = (fract(abs(tmpvar_15)) * 4.0);
      highp float tmpvar_17;
      if ((tmpvar_15 >= 0.0)) {
        tmpvar_17 = tmpvar_16;
      } else {
        tmpvar_17 = -(tmpvar_16);
      };
      highp float x_18;
      x_18 = ((a_11 - _DITHERMATRIX[
        int(tmpvar_14)
      ][
        int(tmpvar_17)
      ]) - 0.01);
      if ((x_18 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "_FACEMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_4 = o_10;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  tmpvar_6 = normalize((_glesNormal * tmpvar_13));
  highp vec3 tmpvar_14;
  tmpvar_14 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_14;
  highp vec3 lightWorldDir_15;
  lightWorldDir_15 = lightDir_1;
  highp vec2 texcoord_16;
  texcoord_16 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_17;
  bool flipInYAxis_18;
  highp vec3 lightLocalDir_19;
  highp float tmpvar_20;
  tmpvar_20 = sqrt(dot (lightWorldDir_15, lightWorldDir_15));
  if ((tmpvar_20 < 0.9)) {
    tmpvar_17 = vec3(0.0, 1.0, 0.0);
  } else {
    highp mat3 tmpvar_21;
    tmpvar_21[0] = unity_WorldToObject[0].xyz;
    tmpvar_21[1] = unity_WorldToObject[1].xyz;
    tmpvar_21[2] = unity_WorldToObject[2].xyz;
    lightLocalDir_19 = (mat3(1.0, 0.0, 0.0, 0.0, 0.98481, -0.17365, 0.0, 0.17365, 0.98481) * (tmpvar_21 * lightWorldDir_15));
    highp float tmpvar_22;
    highp float tmpvar_23;
    tmpvar_23 = (min (abs(
      (lightLocalDir_19.z / lightLocalDir_19.y)
    ), 1.0) / max (abs(
      (lightLocalDir_19.z / lightLocalDir_19.y)
    ), 1.0));
    highp float tmpvar_24;
    tmpvar_24 = (tmpvar_23 * tmpvar_23);
    tmpvar_24 = (((
      ((((
        ((((-0.01213232 * tmpvar_24) + 0.05368138) * tmpvar_24) - 0.1173503)
       * tmpvar_24) + 0.1938925) * tmpvar_24) - 0.3326756)
     * tmpvar_24) + 0.9999793) * tmpvar_23);
    tmpvar_24 = (tmpvar_24 + (float(
      (abs((lightLocalDir_19.z / lightLocalDir_19.y)) > 1.0)
    ) * (
      (tmpvar_24 * -2.0)
     + 1.570796)));
    tmpvar_22 = (tmpvar_24 * sign((lightLocalDir_19.z / lightLocalDir_19.y)));
    if ((abs(lightLocalDir_19.y) > (1e-08 * abs(lightLocalDir_19.z)))) {
      if ((lightLocalDir_19.y < 0.0)) {
        if ((lightLocalDir_19.z >= 0.0)) {
          tmpvar_22 += 3.141593;
        } else {
          tmpvar_22 = (tmpvar_22 - 3.141593);
        };
      };
    } else {
      tmpvar_22 = (sign(lightLocalDir_19.z) * 1.570796);
    };
    highp float tmpvar_25;
    tmpvar_25 = (-(tmpvar_22) * 57.29578);
    flipInYAxis_18 = bool(0);
    if ((tmpvar_25 > 0.0)) {
      flipInYAxis_18 = bool(1);
    };
    highp float tmpvar_26;
    tmpvar_26 = clamp (abs((tmpvar_25 / 180.0)), 0.0001, 0.9999);
    if (flipInYAxis_18) {
      texcoord_16 = ((_glesMultiTexCoord0.xy * vec2(-1.0, 1.0)) + vec2(1.0, 0.0));
    };
    highp vec3 tmpvar_27;
    tmpvar_27.xy = texcoord_16;
    tmpvar_27.z = tmpvar_26;
    tmpvar_17 = tmpvar_27;
  };
  mediump vec3 tmpvar_28;
  highp vec3 lightColor0_29;
  lightColor0_29 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_30;
  lightColor1_30 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_31;
  lightColor2_31 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_32;
  lightColor3_32 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_33;
  lightAttenSq_33 = unity_4LightAtten0;
  highp vec3 col_34;
  highp vec4 ndotl_35;
  highp vec4 lengthSq_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_38;
  tmpvar_38 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_39;
  tmpvar_39 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_36 = (tmpvar_37 * tmpvar_37);
  lengthSq_36 = (lengthSq_36 + (tmpvar_38 * tmpvar_38));
  lengthSq_36 = (lengthSq_36 + (tmpvar_39 * tmpvar_39));
  highp vec4 tmpvar_40;
  tmpvar_40 = max (lengthSq_36, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_36 = tmpvar_40;
  ndotl_35 = (tmpvar_37 * tmpvar_6.x);
  ndotl_35 = (ndotl_35 + (tmpvar_38 * tmpvar_6.y));
  ndotl_35 = (ndotl_35 + (tmpvar_39 * tmpvar_6.z));
  highp vec4 tmpvar_41;
  tmpvar_41 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_35 * inversesqrt(tmpvar_40)));
  ndotl_35 = tmpvar_41;
  highp vec4 tmpvar_42;
  tmpvar_42 = (tmpvar_41 * (1.0/((1.0 + 
    (tmpvar_40 * lightAttenSq_33)
  ))));
  col_34 = (lightColor0_29 * tmpvar_42.x);
  col_34 = (col_34 + (lightColor1_30 * tmpvar_42.y));
  col_34 = (col_34 + (lightColor2_31 * tmpvar_42.z));
  col_34 = (col_34 + (lightColor3_32 * tmpvar_42.w));
  tmpvar_28 = col_34;
  tmpvar_7.xyz = tmpvar_28;
  if (bool(_UsingDitherAlpha)) {
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_17;
  xlv_TEXCOORD6 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _ShadowFeather;
uniform mediump float _UsingDitherAlpha;
uniform sampler2D _FaceMap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump float diffuseThreshold_1;
  mediump vec4 col_2;
  mediump vec3 lightmap_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMap, xlv_TEXCOORD0).xyz;
  lightmap_3 = tmpvar_5;
  lowp float tmpvar_6;
  tmpvar_6 = texture2D (_FaceMap, xlv_TEXCOORD5.xy).w;
  diffuseThreshold_1 = tmpvar_6;
  mediump float lightingThreshold_7;
  lightingThreshold_7 = xlv_TEXCOORD5.z;
  mediump float tmpvar_8;
  tmpvar_8 = max ((lightingThreshold_7 - _ShadowFeather), 0.0001);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((diffuseThreshold_1 - tmpvar_8) / (
    min ((lightingThreshold_7 + _ShadowFeather), 0.9999)
   - tmpvar_8)), 0.0, 1.0);
  col_2.xyz = ((mix (_ShadowColor, vec3(1.0, 1.0, 1.0), vec3(
    ((tmpvar_9 * (tmpvar_9 * (3.0 - 
      (2.0 * tmpvar_9)
    ))) * lightmap_3.y)
  )) * (
    (tmpvar_4 * _Color)
   * _EnvColor).xyz) * (vec3(1.0, 1.0, 1.0) + xlv_TEXCOORD6.xyz));
  col_2.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_10;
    scrpos_10 = xlv_TEXCOORD2;
    mediump float a_11;
    a_11 = xlv_TEXCOORD2.z;
    if ((a_11 < 0.95)) {
      scrpos_10.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_11 = (a_11 * 17.0);
      highp float tmpvar_12;
      tmpvar_12 = (scrpos_10.y / 4.0);
      highp float tmpvar_13;
      tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
      highp float tmpvar_14;
      if ((tmpvar_12 >= 0.0)) {
        tmpvar_14 = tmpvar_13;
      } else {
        tmpvar_14 = -(tmpvar_13);
      };
      highp float tmpvar_15;
      tmpvar_15 = (scrpos_10.x / 4.0);
      highp float tmpvar_16;
      tmpvar_16 = (fract(abs(tmpvar_15)) * 4.0);
      highp float tmpvar_17;
      if ((tmpvar_15 >= 0.0)) {
        tmpvar_17 = tmpvar_16;
      } else {
        tmpvar_17 = -(tmpvar_16);
      };
      highp float x_18;
      x_18 = ((a_11 - _DITHERMATRIX[
        int(tmpvar_14)
      ][
        int(tmpvar_17)
      ]) - 0.01);
      if ((x_18 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "_FACEMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_4 = o_10;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  tmpvar_6 = normalize((_glesNormal * tmpvar_13));
  highp vec3 tmpvar_14;
  tmpvar_14 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_14;
  highp vec3 lightWorldDir_15;
  lightWorldDir_15 = lightDir_1;
  highp vec2 texcoord_16;
  texcoord_16 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_17;
  bool flipInYAxis_18;
  highp vec3 lightLocalDir_19;
  highp float tmpvar_20;
  tmpvar_20 = sqrt(dot (lightWorldDir_15, lightWorldDir_15));
  if ((tmpvar_20 < 0.9)) {
    tmpvar_17 = vec3(0.0, 1.0, 0.0);
  } else {
    highp mat3 tmpvar_21;
    tmpvar_21[0] = unity_WorldToObject[0].xyz;
    tmpvar_21[1] = unity_WorldToObject[1].xyz;
    tmpvar_21[2] = unity_WorldToObject[2].xyz;
    lightLocalDir_19 = (mat3(1.0, 0.0, 0.0, 0.0, 0.98481, -0.17365, 0.0, 0.17365, 0.98481) * (tmpvar_21 * lightWorldDir_15));
    highp float tmpvar_22;
    highp float tmpvar_23;
    tmpvar_23 = (min (abs(
      (lightLocalDir_19.z / lightLocalDir_19.y)
    ), 1.0) / max (abs(
      (lightLocalDir_19.z / lightLocalDir_19.y)
    ), 1.0));
    highp float tmpvar_24;
    tmpvar_24 = (tmpvar_23 * tmpvar_23);
    tmpvar_24 = (((
      ((((
        ((((-0.01213232 * tmpvar_24) + 0.05368138) * tmpvar_24) - 0.1173503)
       * tmpvar_24) + 0.1938925) * tmpvar_24) - 0.3326756)
     * tmpvar_24) + 0.9999793) * tmpvar_23);
    tmpvar_24 = (tmpvar_24 + (float(
      (abs((lightLocalDir_19.z / lightLocalDir_19.y)) > 1.0)
    ) * (
      (tmpvar_24 * -2.0)
     + 1.570796)));
    tmpvar_22 = (tmpvar_24 * sign((lightLocalDir_19.z / lightLocalDir_19.y)));
    if ((abs(lightLocalDir_19.y) > (1e-08 * abs(lightLocalDir_19.z)))) {
      if ((lightLocalDir_19.y < 0.0)) {
        if ((lightLocalDir_19.z >= 0.0)) {
          tmpvar_22 += 3.141593;
        } else {
          tmpvar_22 = (tmpvar_22 - 3.141593);
        };
      };
    } else {
      tmpvar_22 = (sign(lightLocalDir_19.z) * 1.570796);
    };
    highp float tmpvar_25;
    tmpvar_25 = (-(tmpvar_22) * 57.29578);
    flipInYAxis_18 = bool(0);
    if ((tmpvar_25 > 0.0)) {
      flipInYAxis_18 = bool(1);
    };
    highp float tmpvar_26;
    tmpvar_26 = clamp (abs((tmpvar_25 / 180.0)), 0.0001, 0.9999);
    if (flipInYAxis_18) {
      texcoord_16 = ((_glesMultiTexCoord0.xy * vec2(-1.0, 1.0)) + vec2(1.0, 0.0));
    };
    highp vec3 tmpvar_27;
    tmpvar_27.xy = texcoord_16;
    tmpvar_27.z = tmpvar_26;
    tmpvar_17 = tmpvar_27;
  };
  mediump vec3 tmpvar_28;
  highp vec3 lightColor0_29;
  lightColor0_29 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_30;
  lightColor1_30 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_31;
  lightColor2_31 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_32;
  lightColor3_32 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_33;
  lightAttenSq_33 = unity_4LightAtten0;
  highp vec3 col_34;
  highp vec4 ndotl_35;
  highp vec4 lengthSq_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_38;
  tmpvar_38 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_39;
  tmpvar_39 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_36 = (tmpvar_37 * tmpvar_37);
  lengthSq_36 = (lengthSq_36 + (tmpvar_38 * tmpvar_38));
  lengthSq_36 = (lengthSq_36 + (tmpvar_39 * tmpvar_39));
  highp vec4 tmpvar_40;
  tmpvar_40 = max (lengthSq_36, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_36 = tmpvar_40;
  ndotl_35 = (tmpvar_37 * tmpvar_6.x);
  ndotl_35 = (ndotl_35 + (tmpvar_38 * tmpvar_6.y));
  ndotl_35 = (ndotl_35 + (tmpvar_39 * tmpvar_6.z));
  highp vec4 tmpvar_41;
  tmpvar_41 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_35 * inversesqrt(tmpvar_40)));
  ndotl_35 = tmpvar_41;
  highp vec4 tmpvar_42;
  tmpvar_42 = (tmpvar_41 * (1.0/((1.0 + 
    (tmpvar_40 * lightAttenSq_33)
  ))));
  col_34 = (lightColor0_29 * tmpvar_42.x);
  col_34 = (col_34 + (lightColor1_30 * tmpvar_42.y));
  col_34 = (col_34 + (lightColor2_31 * tmpvar_42.z));
  col_34 = (col_34 + (lightColor3_32 * tmpvar_42.w));
  tmpvar_28 = col_34;
  tmpvar_7.xyz = tmpvar_28;
  if (bool(_UsingDitherAlpha)) {
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_17;
  xlv_TEXCOORD6 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _ShadowFeather;
uniform mediump float _UsingDitherAlpha;
uniform sampler2D _FaceMap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump float diffuseThreshold_1;
  mediump vec4 col_2;
  mediump vec3 lightmap_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMap, xlv_TEXCOORD0).xyz;
  lightmap_3 = tmpvar_5;
  lowp float tmpvar_6;
  tmpvar_6 = texture2D (_FaceMap, xlv_TEXCOORD5.xy).w;
  diffuseThreshold_1 = tmpvar_6;
  mediump float lightingThreshold_7;
  lightingThreshold_7 = xlv_TEXCOORD5.z;
  mediump float tmpvar_8;
  tmpvar_8 = max ((lightingThreshold_7 - _ShadowFeather), 0.0001);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((diffuseThreshold_1 - tmpvar_8) / (
    min ((lightingThreshold_7 + _ShadowFeather), 0.9999)
   - tmpvar_8)), 0.0, 1.0);
  col_2.xyz = ((mix (_ShadowColor, vec3(1.0, 1.0, 1.0), vec3(
    ((tmpvar_9 * (tmpvar_9 * (3.0 - 
      (2.0 * tmpvar_9)
    ))) * lightmap_3.y)
  )) * (
    (tmpvar_4 * _Color)
   * _EnvColor).xyz) * (vec3(1.0, 1.0, 1.0) + xlv_TEXCOORD6.xyz));
  col_2.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_10;
    scrpos_10 = xlv_TEXCOORD2;
    mediump float a_11;
    a_11 = xlv_TEXCOORD2.z;
    if ((a_11 < 0.95)) {
      scrpos_10.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_11 = (a_11 * 17.0);
      highp float tmpvar_12;
      tmpvar_12 = (scrpos_10.y / 4.0);
      highp float tmpvar_13;
      tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
      highp float tmpvar_14;
      if ((tmpvar_12 >= 0.0)) {
        tmpvar_14 = tmpvar_13;
      } else {
        tmpvar_14 = -(tmpvar_13);
      };
      highp float tmpvar_15;
      tmpvar_15 = (scrpos_10.x / 4.0);
      highp float tmpvar_16;
      tmpvar_16 = (fract(abs(tmpvar_15)) * 4.0);
      highp float tmpvar_17;
      if ((tmpvar_15 >= 0.0)) {
        tmpvar_17 = tmpvar_16;
      } else {
        tmpvar_17 = -(tmpvar_16);
      };
      highp float x_18;
      x_18 = ((a_11 - _DITHERMATRIX[
        int(tmpvar_14)
      ][
        int(tmpvar_17)
      ]) - 0.01);
      if ((x_18 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "_FACEMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_4 = o_10;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  tmpvar_6 = normalize((_glesNormal * tmpvar_13));
  highp vec3 tmpvar_14;
  tmpvar_14 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_14;
  highp vec3 lightWorldDir_15;
  lightWorldDir_15 = lightDir_1;
  highp vec2 texcoord_16;
  texcoord_16 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_17;
  bool flipInYAxis_18;
  highp vec3 lightLocalDir_19;
  highp float tmpvar_20;
  tmpvar_20 = sqrt(dot (lightWorldDir_15, lightWorldDir_15));
  if ((tmpvar_20 < 0.9)) {
    tmpvar_17 = vec3(0.0, 1.0, 0.0);
  } else {
    highp mat3 tmpvar_21;
    tmpvar_21[0] = unity_WorldToObject[0].xyz;
    tmpvar_21[1] = unity_WorldToObject[1].xyz;
    tmpvar_21[2] = unity_WorldToObject[2].xyz;
    lightLocalDir_19 = (mat3(1.0, 0.0, 0.0, 0.0, 0.98481, -0.17365, 0.0, 0.17365, 0.98481) * (tmpvar_21 * lightWorldDir_15));
    highp float tmpvar_22;
    highp float tmpvar_23;
    tmpvar_23 = (min (abs(
      (lightLocalDir_19.z / lightLocalDir_19.y)
    ), 1.0) / max (abs(
      (lightLocalDir_19.z / lightLocalDir_19.y)
    ), 1.0));
    highp float tmpvar_24;
    tmpvar_24 = (tmpvar_23 * tmpvar_23);
    tmpvar_24 = (((
      ((((
        ((((-0.01213232 * tmpvar_24) + 0.05368138) * tmpvar_24) - 0.1173503)
       * tmpvar_24) + 0.1938925) * tmpvar_24) - 0.3326756)
     * tmpvar_24) + 0.9999793) * tmpvar_23);
    tmpvar_24 = (tmpvar_24 + (float(
      (abs((lightLocalDir_19.z / lightLocalDir_19.y)) > 1.0)
    ) * (
      (tmpvar_24 * -2.0)
     + 1.570796)));
    tmpvar_22 = (tmpvar_24 * sign((lightLocalDir_19.z / lightLocalDir_19.y)));
    if ((abs(lightLocalDir_19.y) > (1e-08 * abs(lightLocalDir_19.z)))) {
      if ((lightLocalDir_19.y < 0.0)) {
        if ((lightLocalDir_19.z >= 0.0)) {
          tmpvar_22 += 3.141593;
        } else {
          tmpvar_22 = (tmpvar_22 - 3.141593);
        };
      };
    } else {
      tmpvar_22 = (sign(lightLocalDir_19.z) * 1.570796);
    };
    highp float tmpvar_25;
    tmpvar_25 = (-(tmpvar_22) * 57.29578);
    flipInYAxis_18 = bool(0);
    if ((tmpvar_25 > 0.0)) {
      flipInYAxis_18 = bool(1);
    };
    highp float tmpvar_26;
    tmpvar_26 = clamp (abs((tmpvar_25 / 180.0)), 0.0001, 0.9999);
    if (flipInYAxis_18) {
      texcoord_16 = ((_glesMultiTexCoord0.xy * vec2(-1.0, 1.0)) + vec2(1.0, 0.0));
    };
    highp vec3 tmpvar_27;
    tmpvar_27.xy = texcoord_16;
    tmpvar_27.z = tmpvar_26;
    tmpvar_17 = tmpvar_27;
  };
  mediump vec3 tmpvar_28;
  highp vec3 lightColor0_29;
  lightColor0_29 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_30;
  lightColor1_30 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_31;
  lightColor2_31 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_32;
  lightColor3_32 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_33;
  lightAttenSq_33 = unity_4LightAtten0;
  highp vec3 col_34;
  highp vec4 ndotl_35;
  highp vec4 lengthSq_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_38;
  tmpvar_38 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_39;
  tmpvar_39 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_36 = (tmpvar_37 * tmpvar_37);
  lengthSq_36 = (lengthSq_36 + (tmpvar_38 * tmpvar_38));
  lengthSq_36 = (lengthSq_36 + (tmpvar_39 * tmpvar_39));
  highp vec4 tmpvar_40;
  tmpvar_40 = max (lengthSq_36, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_36 = tmpvar_40;
  ndotl_35 = (tmpvar_37 * tmpvar_6.x);
  ndotl_35 = (ndotl_35 + (tmpvar_38 * tmpvar_6.y));
  ndotl_35 = (ndotl_35 + (tmpvar_39 * tmpvar_6.z));
  highp vec4 tmpvar_41;
  tmpvar_41 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_35 * inversesqrt(tmpvar_40)));
  ndotl_35 = tmpvar_41;
  highp vec4 tmpvar_42;
  tmpvar_42 = (tmpvar_41 * (1.0/((1.0 + 
    (tmpvar_40 * lightAttenSq_33)
  ))));
  col_34 = (lightColor0_29 * tmpvar_42.x);
  col_34 = (col_34 + (lightColor1_30 * tmpvar_42.y));
  col_34 = (col_34 + (lightColor2_31 * tmpvar_42.z));
  col_34 = (col_34 + (lightColor3_32 * tmpvar_42.w));
  tmpvar_28 = col_34;
  tmpvar_7.xyz = tmpvar_28;
  if (bool(_UsingDitherAlpha)) {
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_17;
  xlv_TEXCOORD6 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _ShadowFeather;
uniform mediump float _UsingDitherAlpha;
uniform sampler2D _FaceMap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump float diffuseThreshold_1;
  mediump vec4 col_2;
  mediump vec3 lightmap_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMap, xlv_TEXCOORD0).xyz;
  lightmap_3 = tmpvar_5;
  lowp float tmpvar_6;
  tmpvar_6 = texture2D (_FaceMap, xlv_TEXCOORD5.xy).w;
  diffuseThreshold_1 = tmpvar_6;
  mediump float lightingThreshold_7;
  lightingThreshold_7 = xlv_TEXCOORD5.z;
  mediump float tmpvar_8;
  tmpvar_8 = max ((lightingThreshold_7 - _ShadowFeather), 0.0001);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((diffuseThreshold_1 - tmpvar_8) / (
    min ((lightingThreshold_7 + _ShadowFeather), 0.9999)
   - tmpvar_8)), 0.0, 1.0);
  col_2.xyz = ((mix (_ShadowColor, vec3(1.0, 1.0, 1.0), vec3(
    ((tmpvar_9 * (tmpvar_9 * (3.0 - 
      (2.0 * tmpvar_9)
    ))) * lightmap_3.y)
  )) * (
    (tmpvar_4 * _Color)
   * _EnvColor).xyz) * (vec3(1.0, 1.0, 1.0) + xlv_TEXCOORD6.xyz));
  col_2.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_10;
    scrpos_10 = xlv_TEXCOORD2;
    mediump float a_11;
    a_11 = xlv_TEXCOORD2.z;
    if ((a_11 < 0.95)) {
      scrpos_10.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_11 = (a_11 * 17.0);
      highp float tmpvar_12;
      tmpvar_12 = (scrpos_10.y / 4.0);
      highp float tmpvar_13;
      tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
      highp float tmpvar_14;
      if ((tmpvar_12 >= 0.0)) {
        tmpvar_14 = tmpvar_13;
      } else {
        tmpvar_14 = -(tmpvar_13);
      };
      highp float tmpvar_15;
      tmpvar_15 = (scrpos_10.x / 4.0);
      highp float tmpvar_16;
      tmpvar_16 = (fract(abs(tmpvar_15)) * 4.0);
      highp float tmpvar_17;
      if ((tmpvar_15 >= 0.0)) {
        tmpvar_17 = tmpvar_16;
      } else {
        tmpvar_17 = -(tmpvar_16);
      };
      highp float x_18;
      x_18 = ((a_11 - _DITHERMATRIX[
        int(tmpvar_14)
      ][
        int(tmpvar_17)
      ]) - 0.01);
      if ((x_18 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_FACEMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_4 = o_9;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  tmpvar_6 = normalize((_glesNormal * tmpvar_12));
  highp vec3 tmpvar_13;
  tmpvar_13 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_13;
  highp vec3 lightWorldDir_14;
  lightWorldDir_14 = lightDir_1;
  highp vec2 texcoord_15;
  texcoord_15 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_16;
  bool flipInYAxis_17;
  highp vec3 lightLocalDir_18;
  highp float tmpvar_19;
  tmpvar_19 = sqrt(dot (lightWorldDir_14, lightWorldDir_14));
  if ((tmpvar_19 < 0.9)) {
    tmpvar_16 = vec3(0.0, 1.0, 0.0);
  } else {
    highp mat3 tmpvar_20;
    tmpvar_20[0] = unity_WorldToObject[0].xyz;
    tmpvar_20[1] = unity_WorldToObject[1].xyz;
    tmpvar_20[2] = unity_WorldToObject[2].xyz;
    lightLocalDir_18 = (mat3(1.0, 0.0, 0.0, 0.0, 0.98481, -0.17365, 0.0, 0.17365, 0.98481) * (tmpvar_20 * lightWorldDir_14));
    highp float tmpvar_21;
    highp float tmpvar_22;
    tmpvar_22 = (min (abs(
      (lightLocalDir_18.z / lightLocalDir_18.y)
    ), 1.0) / max (abs(
      (lightLocalDir_18.z / lightLocalDir_18.y)
    ), 1.0));
    highp float tmpvar_23;
    tmpvar_23 = (tmpvar_22 * tmpvar_22);
    tmpvar_23 = (((
      ((((
        ((((-0.01213232 * tmpvar_23) + 0.05368138) * tmpvar_23) - 0.1173503)
       * tmpvar_23) + 0.1938925) * tmpvar_23) - 0.3326756)
     * tmpvar_23) + 0.9999793) * tmpvar_22);
    tmpvar_23 = (tmpvar_23 + (float(
      (abs((lightLocalDir_18.z / lightLocalDir_18.y)) > 1.0)
    ) * (
      (tmpvar_23 * -2.0)
     + 1.570796)));
    tmpvar_21 = (tmpvar_23 * sign((lightLocalDir_18.z / lightLocalDir_18.y)));
    if ((abs(lightLocalDir_18.y) > (1e-08 * abs(lightLocalDir_18.z)))) {
      if ((lightLocalDir_18.y < 0.0)) {
        if ((lightLocalDir_18.z >= 0.0)) {
          tmpvar_21 += 3.141593;
        } else {
          tmpvar_21 = (tmpvar_21 - 3.141593);
        };
      };
    } else {
      tmpvar_21 = (sign(lightLocalDir_18.z) * 1.570796);
    };
    highp float tmpvar_24;
    tmpvar_24 = (-(tmpvar_21) * 57.29578);
    flipInYAxis_17 = bool(0);
    if ((tmpvar_24 > 0.0)) {
      flipInYAxis_17 = bool(1);
    };
    highp float tmpvar_25;
    tmpvar_25 = clamp (abs((tmpvar_24 / 180.0)), 0.0001, 0.9999);
    if (flipInYAxis_17) {
      texcoord_15 = ((_glesMultiTexCoord0.xy * vec2(-1.0, 1.0)) + vec2(1.0, 0.0));
    };
    highp vec3 tmpvar_26;
    tmpvar_26.xy = texcoord_15;
    tmpvar_26.z = tmpvar_25;
    tmpvar_16 = tmpvar_26;
  };
  if (bool(_UsingDitherAlpha)) {
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_16;
  xlv_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _ShadowFeather;
uniform mediump float _UsingDitherAlpha;
uniform sampler2D _FaceMap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  mediump float diffuseThreshold_1;
  mediump vec4 col_2;
  mediump vec3 lightmap_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_5;
  tmpvar_5 = ((tmpvar_4 * _Color) * _EnvColor);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMap, xlv_TEXCOORD0).xyz;
  lightmap_3 = tmpvar_6;
  highp vec2 screenCoord_7;
  screenCoord_7 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_8;
  shadow_8 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_7);
    shadow_8 = tmpvar_9.x;
  };
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_FaceMap, xlv_TEXCOORD5.xy).w;
  diffuseThreshold_1 = tmpvar_10;
  mediump float lightingThreshold_11;
  lightingThreshold_11 = xlv_TEXCOORD5.z;
  mediump float tmpvar_12;
  tmpvar_12 = max ((lightingThreshold_11 - _ShadowFeather), 0.0001);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((diffuseThreshold_1 - tmpvar_12) / (
    min ((lightingThreshold_11 + _ShadowFeather), 0.9999)
   - tmpvar_12)), 0.0, 1.0);
  col_2.xyz = (mix (_ShadowColor, vec3(1.0, 1.0, 1.0), vec3((
    (tmpvar_13 * (tmpvar_13 * (3.0 - (2.0 * tmpvar_13))))
   * 
    (lightmap_3.y * shadow_8)
  ))) * tmpvar_5.xyz);
  col_2.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_14;
    scrpos_14 = xlv_TEXCOORD2;
    mediump float a_15;
    a_15 = xlv_TEXCOORD2.z;
    if ((a_15 < 0.95)) {
      scrpos_14.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_15 = (a_15 * 17.0);
      highp float tmpvar_16;
      tmpvar_16 = (scrpos_14.y / 4.0);
      highp float tmpvar_17;
      tmpvar_17 = (fract(abs(tmpvar_16)) * 4.0);
      highp float tmpvar_18;
      if ((tmpvar_16 >= 0.0)) {
        tmpvar_18 = tmpvar_17;
      } else {
        tmpvar_18 = -(tmpvar_17);
      };
      highp float tmpvar_19;
      tmpvar_19 = (scrpos_14.x / 4.0);
      highp float tmpvar_20;
      tmpvar_20 = (fract(abs(tmpvar_19)) * 4.0);
      highp float tmpvar_21;
      if ((tmpvar_19 >= 0.0)) {
        tmpvar_21 = tmpvar_20;
      } else {
        tmpvar_21 = -(tmpvar_20);
      };
      highp float x_22;
      x_22 = ((a_15 - _DITHERMATRIX[
        int(tmpvar_18)
      ][
        int(tmpvar_21)
      ]) - 0.01);
      if ((x_22 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_FACEMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_4 = o_9;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  tmpvar_6 = normalize((_glesNormal * tmpvar_12));
  highp vec3 tmpvar_13;
  tmpvar_13 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_13;
  highp vec3 lightWorldDir_14;
  lightWorldDir_14 = lightDir_1;
  highp vec2 texcoord_15;
  texcoord_15 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_16;
  bool flipInYAxis_17;
  highp vec3 lightLocalDir_18;
  highp float tmpvar_19;
  tmpvar_19 = sqrt(dot (lightWorldDir_14, lightWorldDir_14));
  if ((tmpvar_19 < 0.9)) {
    tmpvar_16 = vec3(0.0, 1.0, 0.0);
  } else {
    highp mat3 tmpvar_20;
    tmpvar_20[0] = unity_WorldToObject[0].xyz;
    tmpvar_20[1] = unity_WorldToObject[1].xyz;
    tmpvar_20[2] = unity_WorldToObject[2].xyz;
    lightLocalDir_18 = (mat3(1.0, 0.0, 0.0, 0.0, 0.98481, -0.17365, 0.0, 0.17365, 0.98481) * (tmpvar_20 * lightWorldDir_14));
    highp float tmpvar_21;
    highp float tmpvar_22;
    tmpvar_22 = (min (abs(
      (lightLocalDir_18.z / lightLocalDir_18.y)
    ), 1.0) / max (abs(
      (lightLocalDir_18.z / lightLocalDir_18.y)
    ), 1.0));
    highp float tmpvar_23;
    tmpvar_23 = (tmpvar_22 * tmpvar_22);
    tmpvar_23 = (((
      ((((
        ((((-0.01213232 * tmpvar_23) + 0.05368138) * tmpvar_23) - 0.1173503)
       * tmpvar_23) + 0.1938925) * tmpvar_23) - 0.3326756)
     * tmpvar_23) + 0.9999793) * tmpvar_22);
    tmpvar_23 = (tmpvar_23 + (float(
      (abs((lightLocalDir_18.z / lightLocalDir_18.y)) > 1.0)
    ) * (
      (tmpvar_23 * -2.0)
     + 1.570796)));
    tmpvar_21 = (tmpvar_23 * sign((lightLocalDir_18.z / lightLocalDir_18.y)));
    if ((abs(lightLocalDir_18.y) > (1e-08 * abs(lightLocalDir_18.z)))) {
      if ((lightLocalDir_18.y < 0.0)) {
        if ((lightLocalDir_18.z >= 0.0)) {
          tmpvar_21 += 3.141593;
        } else {
          tmpvar_21 = (tmpvar_21 - 3.141593);
        };
      };
    } else {
      tmpvar_21 = (sign(lightLocalDir_18.z) * 1.570796);
    };
    highp float tmpvar_24;
    tmpvar_24 = (-(tmpvar_21) * 57.29578);
    flipInYAxis_17 = bool(0);
    if ((tmpvar_24 > 0.0)) {
      flipInYAxis_17 = bool(1);
    };
    highp float tmpvar_25;
    tmpvar_25 = clamp (abs((tmpvar_24 / 180.0)), 0.0001, 0.9999);
    if (flipInYAxis_17) {
      texcoord_15 = ((_glesMultiTexCoord0.xy * vec2(-1.0, 1.0)) + vec2(1.0, 0.0));
    };
    highp vec3 tmpvar_26;
    tmpvar_26.xy = texcoord_15;
    tmpvar_26.z = tmpvar_25;
    tmpvar_16 = tmpvar_26;
  };
  if (bool(_UsingDitherAlpha)) {
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_16;
  xlv_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _ShadowFeather;
uniform mediump float _UsingDitherAlpha;
uniform sampler2D _FaceMap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  mediump float diffuseThreshold_1;
  mediump vec4 col_2;
  mediump vec3 lightmap_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_5;
  tmpvar_5 = ((tmpvar_4 * _Color) * _EnvColor);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMap, xlv_TEXCOORD0).xyz;
  lightmap_3 = tmpvar_6;
  highp vec2 screenCoord_7;
  screenCoord_7 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_8;
  shadow_8 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_7);
    shadow_8 = tmpvar_9.x;
  };
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_FaceMap, xlv_TEXCOORD5.xy).w;
  diffuseThreshold_1 = tmpvar_10;
  mediump float lightingThreshold_11;
  lightingThreshold_11 = xlv_TEXCOORD5.z;
  mediump float tmpvar_12;
  tmpvar_12 = max ((lightingThreshold_11 - _ShadowFeather), 0.0001);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((diffuseThreshold_1 - tmpvar_12) / (
    min ((lightingThreshold_11 + _ShadowFeather), 0.9999)
   - tmpvar_12)), 0.0, 1.0);
  col_2.xyz = (mix (_ShadowColor, vec3(1.0, 1.0, 1.0), vec3((
    (tmpvar_13 * (tmpvar_13 * (3.0 - (2.0 * tmpvar_13))))
   * 
    (lightmap_3.y * shadow_8)
  ))) * tmpvar_5.xyz);
  col_2.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_14;
    scrpos_14 = xlv_TEXCOORD2;
    mediump float a_15;
    a_15 = xlv_TEXCOORD2.z;
    if ((a_15 < 0.95)) {
      scrpos_14.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_15 = (a_15 * 17.0);
      highp float tmpvar_16;
      tmpvar_16 = (scrpos_14.y / 4.0);
      highp float tmpvar_17;
      tmpvar_17 = (fract(abs(tmpvar_16)) * 4.0);
      highp float tmpvar_18;
      if ((tmpvar_16 >= 0.0)) {
        tmpvar_18 = tmpvar_17;
      } else {
        tmpvar_18 = -(tmpvar_17);
      };
      highp float tmpvar_19;
      tmpvar_19 = (scrpos_14.x / 4.0);
      highp float tmpvar_20;
      tmpvar_20 = (fract(abs(tmpvar_19)) * 4.0);
      highp float tmpvar_21;
      if ((tmpvar_19 >= 0.0)) {
        tmpvar_21 = tmpvar_20;
      } else {
        tmpvar_21 = -(tmpvar_20);
      };
      highp float x_22;
      x_22 = ((a_15 - _DITHERMATRIX[
        int(tmpvar_18)
      ][
        int(tmpvar_21)
      ]) - 0.01);
      if ((x_22 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_FACEMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_4 = o_9;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  tmpvar_6 = normalize((_glesNormal * tmpvar_12));
  highp vec3 tmpvar_13;
  tmpvar_13 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_13;
  highp vec3 lightWorldDir_14;
  lightWorldDir_14 = lightDir_1;
  highp vec2 texcoord_15;
  texcoord_15 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_16;
  bool flipInYAxis_17;
  highp vec3 lightLocalDir_18;
  highp float tmpvar_19;
  tmpvar_19 = sqrt(dot (lightWorldDir_14, lightWorldDir_14));
  if ((tmpvar_19 < 0.9)) {
    tmpvar_16 = vec3(0.0, 1.0, 0.0);
  } else {
    highp mat3 tmpvar_20;
    tmpvar_20[0] = unity_WorldToObject[0].xyz;
    tmpvar_20[1] = unity_WorldToObject[1].xyz;
    tmpvar_20[2] = unity_WorldToObject[2].xyz;
    lightLocalDir_18 = (mat3(1.0, 0.0, 0.0, 0.0, 0.98481, -0.17365, 0.0, 0.17365, 0.98481) * (tmpvar_20 * lightWorldDir_14));
    highp float tmpvar_21;
    highp float tmpvar_22;
    tmpvar_22 = (min (abs(
      (lightLocalDir_18.z / lightLocalDir_18.y)
    ), 1.0) / max (abs(
      (lightLocalDir_18.z / lightLocalDir_18.y)
    ), 1.0));
    highp float tmpvar_23;
    tmpvar_23 = (tmpvar_22 * tmpvar_22);
    tmpvar_23 = (((
      ((((
        ((((-0.01213232 * tmpvar_23) + 0.05368138) * tmpvar_23) - 0.1173503)
       * tmpvar_23) + 0.1938925) * tmpvar_23) - 0.3326756)
     * tmpvar_23) + 0.9999793) * tmpvar_22);
    tmpvar_23 = (tmpvar_23 + (float(
      (abs((lightLocalDir_18.z / lightLocalDir_18.y)) > 1.0)
    ) * (
      (tmpvar_23 * -2.0)
     + 1.570796)));
    tmpvar_21 = (tmpvar_23 * sign((lightLocalDir_18.z / lightLocalDir_18.y)));
    if ((abs(lightLocalDir_18.y) > (1e-08 * abs(lightLocalDir_18.z)))) {
      if ((lightLocalDir_18.y < 0.0)) {
        if ((lightLocalDir_18.z >= 0.0)) {
          tmpvar_21 += 3.141593;
        } else {
          tmpvar_21 = (tmpvar_21 - 3.141593);
        };
      };
    } else {
      tmpvar_21 = (sign(lightLocalDir_18.z) * 1.570796);
    };
    highp float tmpvar_24;
    tmpvar_24 = (-(tmpvar_21) * 57.29578);
    flipInYAxis_17 = bool(0);
    if ((tmpvar_24 > 0.0)) {
      flipInYAxis_17 = bool(1);
    };
    highp float tmpvar_25;
    tmpvar_25 = clamp (abs((tmpvar_24 / 180.0)), 0.0001, 0.9999);
    if (flipInYAxis_17) {
      texcoord_15 = ((_glesMultiTexCoord0.xy * vec2(-1.0, 1.0)) + vec2(1.0, 0.0));
    };
    highp vec3 tmpvar_26;
    tmpvar_26.xy = texcoord_15;
    tmpvar_26.z = tmpvar_25;
    tmpvar_16 = tmpvar_26;
  };
  if (bool(_UsingDitherAlpha)) {
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_16;
  xlv_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _ShadowFeather;
uniform mediump float _UsingDitherAlpha;
uniform sampler2D _FaceMap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  mediump float diffuseThreshold_1;
  mediump vec4 col_2;
  mediump vec3 lightmap_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_5;
  tmpvar_5 = ((tmpvar_4 * _Color) * _EnvColor);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMap, xlv_TEXCOORD0).xyz;
  lightmap_3 = tmpvar_6;
  highp vec2 screenCoord_7;
  screenCoord_7 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_8;
  shadow_8 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_7);
    shadow_8 = tmpvar_9.x;
  };
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_FaceMap, xlv_TEXCOORD5.xy).w;
  diffuseThreshold_1 = tmpvar_10;
  mediump float lightingThreshold_11;
  lightingThreshold_11 = xlv_TEXCOORD5.z;
  mediump float tmpvar_12;
  tmpvar_12 = max ((lightingThreshold_11 - _ShadowFeather), 0.0001);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((diffuseThreshold_1 - tmpvar_12) / (
    min ((lightingThreshold_11 + _ShadowFeather), 0.9999)
   - tmpvar_12)), 0.0, 1.0);
  col_2.xyz = (mix (_ShadowColor, vec3(1.0, 1.0, 1.0), vec3((
    (tmpvar_13 * (tmpvar_13 * (3.0 - (2.0 * tmpvar_13))))
   * 
    (lightmap_3.y * shadow_8)
  ))) * tmpvar_5.xyz);
  col_2.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_14;
    scrpos_14 = xlv_TEXCOORD2;
    mediump float a_15;
    a_15 = xlv_TEXCOORD2.z;
    if ((a_15 < 0.95)) {
      scrpos_14.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_15 = (a_15 * 17.0);
      highp float tmpvar_16;
      tmpvar_16 = (scrpos_14.y / 4.0);
      highp float tmpvar_17;
      tmpvar_17 = (fract(abs(tmpvar_16)) * 4.0);
      highp float tmpvar_18;
      if ((tmpvar_16 >= 0.0)) {
        tmpvar_18 = tmpvar_17;
      } else {
        tmpvar_18 = -(tmpvar_17);
      };
      highp float tmpvar_19;
      tmpvar_19 = (scrpos_14.x / 4.0);
      highp float tmpvar_20;
      tmpvar_20 = (fract(abs(tmpvar_19)) * 4.0);
      highp float tmpvar_21;
      if ((tmpvar_19 >= 0.0)) {
        tmpvar_21 = tmpvar_20;
      } else {
        tmpvar_21 = -(tmpvar_20);
      };
      highp float x_22;
      x_22 = ((a_15 - _DITHERMATRIX[
        int(tmpvar_18)
      ][
        int(tmpvar_21)
      ]) - 0.01);
      if ((x_22 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_FACEMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_4 = o_10;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  tmpvar_6 = normalize((_glesNormal * tmpvar_13));
  highp vec3 tmpvar_14;
  tmpvar_14 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_14;
  highp vec3 lightWorldDir_15;
  lightWorldDir_15 = lightDir_1;
  highp vec2 texcoord_16;
  texcoord_16 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_17;
  bool flipInYAxis_18;
  highp vec3 lightLocalDir_19;
  highp float tmpvar_20;
  tmpvar_20 = sqrt(dot (lightWorldDir_15, lightWorldDir_15));
  if ((tmpvar_20 < 0.9)) {
    tmpvar_17 = vec3(0.0, 1.0, 0.0);
  } else {
    highp mat3 tmpvar_21;
    tmpvar_21[0] = unity_WorldToObject[0].xyz;
    tmpvar_21[1] = unity_WorldToObject[1].xyz;
    tmpvar_21[2] = unity_WorldToObject[2].xyz;
    lightLocalDir_19 = (mat3(1.0, 0.0, 0.0, 0.0, 0.98481, -0.17365, 0.0, 0.17365, 0.98481) * (tmpvar_21 * lightWorldDir_15));
    highp float tmpvar_22;
    highp float tmpvar_23;
    tmpvar_23 = (min (abs(
      (lightLocalDir_19.z / lightLocalDir_19.y)
    ), 1.0) / max (abs(
      (lightLocalDir_19.z / lightLocalDir_19.y)
    ), 1.0));
    highp float tmpvar_24;
    tmpvar_24 = (tmpvar_23 * tmpvar_23);
    tmpvar_24 = (((
      ((((
        ((((-0.01213232 * tmpvar_24) + 0.05368138) * tmpvar_24) - 0.1173503)
       * tmpvar_24) + 0.1938925) * tmpvar_24) - 0.3326756)
     * tmpvar_24) + 0.9999793) * tmpvar_23);
    tmpvar_24 = (tmpvar_24 + (float(
      (abs((lightLocalDir_19.z / lightLocalDir_19.y)) > 1.0)
    ) * (
      (tmpvar_24 * -2.0)
     + 1.570796)));
    tmpvar_22 = (tmpvar_24 * sign((lightLocalDir_19.z / lightLocalDir_19.y)));
    if ((abs(lightLocalDir_19.y) > (1e-08 * abs(lightLocalDir_19.z)))) {
      if ((lightLocalDir_19.y < 0.0)) {
        if ((lightLocalDir_19.z >= 0.0)) {
          tmpvar_22 += 3.141593;
        } else {
          tmpvar_22 = (tmpvar_22 - 3.141593);
        };
      };
    } else {
      tmpvar_22 = (sign(lightLocalDir_19.z) * 1.570796);
    };
    highp float tmpvar_25;
    tmpvar_25 = (-(tmpvar_22) * 57.29578);
    flipInYAxis_18 = bool(0);
    if ((tmpvar_25 > 0.0)) {
      flipInYAxis_18 = bool(1);
    };
    highp float tmpvar_26;
    tmpvar_26 = clamp (abs((tmpvar_25 / 180.0)), 0.0001, 0.9999);
    if (flipInYAxis_18) {
      texcoord_16 = ((_glesMultiTexCoord0.xy * vec2(-1.0, 1.0)) + vec2(1.0, 0.0));
    };
    highp vec3 tmpvar_27;
    tmpvar_27.xy = texcoord_16;
    tmpvar_27.z = tmpvar_26;
    tmpvar_17 = tmpvar_27;
  };
  mediump vec3 tmpvar_28;
  highp vec3 lightColor0_29;
  lightColor0_29 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_30;
  lightColor1_30 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_31;
  lightColor2_31 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_32;
  lightColor3_32 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_33;
  lightAttenSq_33 = unity_4LightAtten0;
  highp vec3 col_34;
  highp vec4 ndotl_35;
  highp vec4 lengthSq_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_38;
  tmpvar_38 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_39;
  tmpvar_39 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_36 = (tmpvar_37 * tmpvar_37);
  lengthSq_36 = (lengthSq_36 + (tmpvar_38 * tmpvar_38));
  lengthSq_36 = (lengthSq_36 + (tmpvar_39 * tmpvar_39));
  highp vec4 tmpvar_40;
  tmpvar_40 = max (lengthSq_36, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_36 = tmpvar_40;
  ndotl_35 = (tmpvar_37 * tmpvar_6.x);
  ndotl_35 = (ndotl_35 + (tmpvar_38 * tmpvar_6.y));
  ndotl_35 = (ndotl_35 + (tmpvar_39 * tmpvar_6.z));
  highp vec4 tmpvar_41;
  tmpvar_41 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_35 * inversesqrt(tmpvar_40)));
  ndotl_35 = tmpvar_41;
  highp vec4 tmpvar_42;
  tmpvar_42 = (tmpvar_41 * (1.0/((1.0 + 
    (tmpvar_40 * lightAttenSq_33)
  ))));
  col_34 = (lightColor0_29 * tmpvar_42.x);
  col_34 = (col_34 + (lightColor1_30 * tmpvar_42.y));
  col_34 = (col_34 + (lightColor2_31 * tmpvar_42.z));
  col_34 = (col_34 + (lightColor3_32 * tmpvar_42.w));
  tmpvar_28 = col_34;
  tmpvar_7.xyz = tmpvar_28;
  if (bool(_UsingDitherAlpha)) {
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_17;
  xlv_TEXCOORD6 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _ShadowFeather;
uniform mediump float _UsingDitherAlpha;
uniform sampler2D _FaceMap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump float diffuseThreshold_1;
  mediump vec4 col_2;
  mediump vec3 lightColor_3;
  mediump vec3 lightmap_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_6;
  tmpvar_6 = ((tmpvar_5 * _Color) * _EnvColor);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_LightMap, xlv_TEXCOORD0).xyz;
  lightmap_4 = tmpvar_7;
  lightColor_3 = (vec3(1.0, 1.0, 1.0) + xlv_TEXCOORD6.xyz);
  highp vec2 screenCoord_8;
  screenCoord_8 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_9;
  shadow_9 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_10;
    tmpvar_10 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_8);
    shadow_9 = tmpvar_10.x;
  };
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_FaceMap, xlv_TEXCOORD5.xy).w;
  diffuseThreshold_1 = tmpvar_11;
  mediump float lightingThreshold_12;
  lightingThreshold_12 = xlv_TEXCOORD5.z;
  mediump float tmpvar_13;
  tmpvar_13 = max ((lightingThreshold_12 - _ShadowFeather), 0.0001);
  mediump float tmpvar_14;
  tmpvar_14 = clamp (((diffuseThreshold_1 - tmpvar_13) / (
    min ((lightingThreshold_12 + _ShadowFeather), 0.9999)
   - tmpvar_13)), 0.0, 1.0);
  col_2.xyz = ((mix (_ShadowColor, vec3(1.0, 1.0, 1.0), vec3(
    ((tmpvar_14 * (tmpvar_14 * (3.0 - 
      (2.0 * tmpvar_14)
    ))) * (lightmap_4.y * shadow_9))
  )) * tmpvar_6.xyz) * lightColor_3);
  col_2.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_15;
    scrpos_15 = xlv_TEXCOORD2;
    mediump float a_16;
    a_16 = xlv_TEXCOORD2.z;
    if ((a_16 < 0.95)) {
      scrpos_15.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_16 = (a_16 * 17.0);
      highp float tmpvar_17;
      tmpvar_17 = (scrpos_15.y / 4.0);
      highp float tmpvar_18;
      tmpvar_18 = (fract(abs(tmpvar_17)) * 4.0);
      highp float tmpvar_19;
      if ((tmpvar_17 >= 0.0)) {
        tmpvar_19 = tmpvar_18;
      } else {
        tmpvar_19 = -(tmpvar_18);
      };
      highp float tmpvar_20;
      tmpvar_20 = (scrpos_15.x / 4.0);
      highp float tmpvar_21;
      tmpvar_21 = (fract(abs(tmpvar_20)) * 4.0);
      highp float tmpvar_22;
      if ((tmpvar_20 >= 0.0)) {
        tmpvar_22 = tmpvar_21;
      } else {
        tmpvar_22 = -(tmpvar_21);
      };
      highp float x_23;
      x_23 = ((a_16 - _DITHERMATRIX[
        int(tmpvar_19)
      ][
        int(tmpvar_22)
      ]) - 0.01);
      if ((x_23 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_FACEMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_4 = o_10;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  tmpvar_6 = normalize((_glesNormal * tmpvar_13));
  highp vec3 tmpvar_14;
  tmpvar_14 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_14;
  highp vec3 lightWorldDir_15;
  lightWorldDir_15 = lightDir_1;
  highp vec2 texcoord_16;
  texcoord_16 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_17;
  bool flipInYAxis_18;
  highp vec3 lightLocalDir_19;
  highp float tmpvar_20;
  tmpvar_20 = sqrt(dot (lightWorldDir_15, lightWorldDir_15));
  if ((tmpvar_20 < 0.9)) {
    tmpvar_17 = vec3(0.0, 1.0, 0.0);
  } else {
    highp mat3 tmpvar_21;
    tmpvar_21[0] = unity_WorldToObject[0].xyz;
    tmpvar_21[1] = unity_WorldToObject[1].xyz;
    tmpvar_21[2] = unity_WorldToObject[2].xyz;
    lightLocalDir_19 = (mat3(1.0, 0.0, 0.0, 0.0, 0.98481, -0.17365, 0.0, 0.17365, 0.98481) * (tmpvar_21 * lightWorldDir_15));
    highp float tmpvar_22;
    highp float tmpvar_23;
    tmpvar_23 = (min (abs(
      (lightLocalDir_19.z / lightLocalDir_19.y)
    ), 1.0) / max (abs(
      (lightLocalDir_19.z / lightLocalDir_19.y)
    ), 1.0));
    highp float tmpvar_24;
    tmpvar_24 = (tmpvar_23 * tmpvar_23);
    tmpvar_24 = (((
      ((((
        ((((-0.01213232 * tmpvar_24) + 0.05368138) * tmpvar_24) - 0.1173503)
       * tmpvar_24) + 0.1938925) * tmpvar_24) - 0.3326756)
     * tmpvar_24) + 0.9999793) * tmpvar_23);
    tmpvar_24 = (tmpvar_24 + (float(
      (abs((lightLocalDir_19.z / lightLocalDir_19.y)) > 1.0)
    ) * (
      (tmpvar_24 * -2.0)
     + 1.570796)));
    tmpvar_22 = (tmpvar_24 * sign((lightLocalDir_19.z / lightLocalDir_19.y)));
    if ((abs(lightLocalDir_19.y) > (1e-08 * abs(lightLocalDir_19.z)))) {
      if ((lightLocalDir_19.y < 0.0)) {
        if ((lightLocalDir_19.z >= 0.0)) {
          tmpvar_22 += 3.141593;
        } else {
          tmpvar_22 = (tmpvar_22 - 3.141593);
        };
      };
    } else {
      tmpvar_22 = (sign(lightLocalDir_19.z) * 1.570796);
    };
    highp float tmpvar_25;
    tmpvar_25 = (-(tmpvar_22) * 57.29578);
    flipInYAxis_18 = bool(0);
    if ((tmpvar_25 > 0.0)) {
      flipInYAxis_18 = bool(1);
    };
    highp float tmpvar_26;
    tmpvar_26 = clamp (abs((tmpvar_25 / 180.0)), 0.0001, 0.9999);
    if (flipInYAxis_18) {
      texcoord_16 = ((_glesMultiTexCoord0.xy * vec2(-1.0, 1.0)) + vec2(1.0, 0.0));
    };
    highp vec3 tmpvar_27;
    tmpvar_27.xy = texcoord_16;
    tmpvar_27.z = tmpvar_26;
    tmpvar_17 = tmpvar_27;
  };
  mediump vec3 tmpvar_28;
  highp vec3 lightColor0_29;
  lightColor0_29 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_30;
  lightColor1_30 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_31;
  lightColor2_31 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_32;
  lightColor3_32 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_33;
  lightAttenSq_33 = unity_4LightAtten0;
  highp vec3 col_34;
  highp vec4 ndotl_35;
  highp vec4 lengthSq_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_38;
  tmpvar_38 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_39;
  tmpvar_39 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_36 = (tmpvar_37 * tmpvar_37);
  lengthSq_36 = (lengthSq_36 + (tmpvar_38 * tmpvar_38));
  lengthSq_36 = (lengthSq_36 + (tmpvar_39 * tmpvar_39));
  highp vec4 tmpvar_40;
  tmpvar_40 = max (lengthSq_36, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_36 = tmpvar_40;
  ndotl_35 = (tmpvar_37 * tmpvar_6.x);
  ndotl_35 = (ndotl_35 + (tmpvar_38 * tmpvar_6.y));
  ndotl_35 = (ndotl_35 + (tmpvar_39 * tmpvar_6.z));
  highp vec4 tmpvar_41;
  tmpvar_41 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_35 * inversesqrt(tmpvar_40)));
  ndotl_35 = tmpvar_41;
  highp vec4 tmpvar_42;
  tmpvar_42 = (tmpvar_41 * (1.0/((1.0 + 
    (tmpvar_40 * lightAttenSq_33)
  ))));
  col_34 = (lightColor0_29 * tmpvar_42.x);
  col_34 = (col_34 + (lightColor1_30 * tmpvar_42.y));
  col_34 = (col_34 + (lightColor2_31 * tmpvar_42.z));
  col_34 = (col_34 + (lightColor3_32 * tmpvar_42.w));
  tmpvar_28 = col_34;
  tmpvar_7.xyz = tmpvar_28;
  if (bool(_UsingDitherAlpha)) {
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_17;
  xlv_TEXCOORD6 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _ShadowFeather;
uniform mediump float _UsingDitherAlpha;
uniform sampler2D _FaceMap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump float diffuseThreshold_1;
  mediump vec4 col_2;
  mediump vec3 lightColor_3;
  mediump vec3 lightmap_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_6;
  tmpvar_6 = ((tmpvar_5 * _Color) * _EnvColor);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_LightMap, xlv_TEXCOORD0).xyz;
  lightmap_4 = tmpvar_7;
  lightColor_3 = (vec3(1.0, 1.0, 1.0) + xlv_TEXCOORD6.xyz);
  highp vec2 screenCoord_8;
  screenCoord_8 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_9;
  shadow_9 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_10;
    tmpvar_10 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_8);
    shadow_9 = tmpvar_10.x;
  };
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_FaceMap, xlv_TEXCOORD5.xy).w;
  diffuseThreshold_1 = tmpvar_11;
  mediump float lightingThreshold_12;
  lightingThreshold_12 = xlv_TEXCOORD5.z;
  mediump float tmpvar_13;
  tmpvar_13 = max ((lightingThreshold_12 - _ShadowFeather), 0.0001);
  mediump float tmpvar_14;
  tmpvar_14 = clamp (((diffuseThreshold_1 - tmpvar_13) / (
    min ((lightingThreshold_12 + _ShadowFeather), 0.9999)
   - tmpvar_13)), 0.0, 1.0);
  col_2.xyz = ((mix (_ShadowColor, vec3(1.0, 1.0, 1.0), vec3(
    ((tmpvar_14 * (tmpvar_14 * (3.0 - 
      (2.0 * tmpvar_14)
    ))) * (lightmap_4.y * shadow_9))
  )) * tmpvar_6.xyz) * lightColor_3);
  col_2.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_15;
    scrpos_15 = xlv_TEXCOORD2;
    mediump float a_16;
    a_16 = xlv_TEXCOORD2.z;
    if ((a_16 < 0.95)) {
      scrpos_15.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_16 = (a_16 * 17.0);
      highp float tmpvar_17;
      tmpvar_17 = (scrpos_15.y / 4.0);
      highp float tmpvar_18;
      tmpvar_18 = (fract(abs(tmpvar_17)) * 4.0);
      highp float tmpvar_19;
      if ((tmpvar_17 >= 0.0)) {
        tmpvar_19 = tmpvar_18;
      } else {
        tmpvar_19 = -(tmpvar_18);
      };
      highp float tmpvar_20;
      tmpvar_20 = (scrpos_15.x / 4.0);
      highp float tmpvar_21;
      tmpvar_21 = (fract(abs(tmpvar_20)) * 4.0);
      highp float tmpvar_22;
      if ((tmpvar_20 >= 0.0)) {
        tmpvar_22 = tmpvar_21;
      } else {
        tmpvar_22 = -(tmpvar_21);
      };
      highp float x_23;
      x_23 = ((a_16 - _DITHERMATRIX[
        int(tmpvar_19)
      ][
        int(tmpvar_22)
      ]) - 0.01);
      if ((x_23 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_FACEMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump vec4 _CustomLightDir;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 lightDir_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_4 = o_10;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  tmpvar_6 = normalize((_glesNormal * tmpvar_13));
  highp vec3 tmpvar_14;
  tmpvar_14 = mix (_WorldSpaceLightPos0.xyz, _CustomLightDir.xyz, _CustomLightDir.www);
  lightDir_1 = tmpvar_14;
  highp vec3 lightWorldDir_15;
  lightWorldDir_15 = lightDir_1;
  highp vec2 texcoord_16;
  texcoord_16 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_17;
  bool flipInYAxis_18;
  highp vec3 lightLocalDir_19;
  highp float tmpvar_20;
  tmpvar_20 = sqrt(dot (lightWorldDir_15, lightWorldDir_15));
  if ((tmpvar_20 < 0.9)) {
    tmpvar_17 = vec3(0.0, 1.0, 0.0);
  } else {
    highp mat3 tmpvar_21;
    tmpvar_21[0] = unity_WorldToObject[0].xyz;
    tmpvar_21[1] = unity_WorldToObject[1].xyz;
    tmpvar_21[2] = unity_WorldToObject[2].xyz;
    lightLocalDir_19 = (mat3(1.0, 0.0, 0.0, 0.0, 0.98481, -0.17365, 0.0, 0.17365, 0.98481) * (tmpvar_21 * lightWorldDir_15));
    highp float tmpvar_22;
    highp float tmpvar_23;
    tmpvar_23 = (min (abs(
      (lightLocalDir_19.z / lightLocalDir_19.y)
    ), 1.0) / max (abs(
      (lightLocalDir_19.z / lightLocalDir_19.y)
    ), 1.0));
    highp float tmpvar_24;
    tmpvar_24 = (tmpvar_23 * tmpvar_23);
    tmpvar_24 = (((
      ((((
        ((((-0.01213232 * tmpvar_24) + 0.05368138) * tmpvar_24) - 0.1173503)
       * tmpvar_24) + 0.1938925) * tmpvar_24) - 0.3326756)
     * tmpvar_24) + 0.9999793) * tmpvar_23);
    tmpvar_24 = (tmpvar_24 + (float(
      (abs((lightLocalDir_19.z / lightLocalDir_19.y)) > 1.0)
    ) * (
      (tmpvar_24 * -2.0)
     + 1.570796)));
    tmpvar_22 = (tmpvar_24 * sign((lightLocalDir_19.z / lightLocalDir_19.y)));
    if ((abs(lightLocalDir_19.y) > (1e-08 * abs(lightLocalDir_19.z)))) {
      if ((lightLocalDir_19.y < 0.0)) {
        if ((lightLocalDir_19.z >= 0.0)) {
          tmpvar_22 += 3.141593;
        } else {
          tmpvar_22 = (tmpvar_22 - 3.141593);
        };
      };
    } else {
      tmpvar_22 = (sign(lightLocalDir_19.z) * 1.570796);
    };
    highp float tmpvar_25;
    tmpvar_25 = (-(tmpvar_22) * 57.29578);
    flipInYAxis_18 = bool(0);
    if ((tmpvar_25 > 0.0)) {
      flipInYAxis_18 = bool(1);
    };
    highp float tmpvar_26;
    tmpvar_26 = clamp (abs((tmpvar_25 / 180.0)), 0.0001, 0.9999);
    if (flipInYAxis_18) {
      texcoord_16 = ((_glesMultiTexCoord0.xy * vec2(-1.0, 1.0)) + vec2(1.0, 0.0));
    };
    highp vec3 tmpvar_27;
    tmpvar_27.xy = texcoord_16;
    tmpvar_27.z = tmpvar_26;
    tmpvar_17 = tmpvar_27;
  };
  mediump vec3 tmpvar_28;
  highp vec3 lightColor0_29;
  lightColor0_29 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_30;
  lightColor1_30 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_31;
  lightColor2_31 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_32;
  lightColor3_32 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_33;
  lightAttenSq_33 = unity_4LightAtten0;
  highp vec3 col_34;
  highp vec4 ndotl_35;
  highp vec4 lengthSq_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_38;
  tmpvar_38 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_39;
  tmpvar_39 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_36 = (tmpvar_37 * tmpvar_37);
  lengthSq_36 = (lengthSq_36 + (tmpvar_38 * tmpvar_38));
  lengthSq_36 = (lengthSq_36 + (tmpvar_39 * tmpvar_39));
  highp vec4 tmpvar_40;
  tmpvar_40 = max (lengthSq_36, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_36 = tmpvar_40;
  ndotl_35 = (tmpvar_37 * tmpvar_6.x);
  ndotl_35 = (ndotl_35 + (tmpvar_38 * tmpvar_6.y));
  ndotl_35 = (ndotl_35 + (tmpvar_39 * tmpvar_6.z));
  highp vec4 tmpvar_41;
  tmpvar_41 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_35 * inversesqrt(tmpvar_40)));
  ndotl_35 = tmpvar_41;
  highp vec4 tmpvar_42;
  tmpvar_42 = (tmpvar_41 * (1.0/((1.0 + 
    (tmpvar_40 * lightAttenSq_33)
  ))));
  col_34 = (lightColor0_29 * tmpvar_42.x);
  col_34 = (col_34 + (lightColor1_30 * tmpvar_42.y));
  col_34 = (col_34 + (lightColor2_31 * tmpvar_42.z));
  col_34 = (col_34 + (lightColor3_32 * tmpvar_42.w));
  tmpvar_28 = col_34;
  tmpvar_7.xyz = tmpvar_28;
  if (bool(_UsingDitherAlpha)) {
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_17;
  xlv_TEXCOORD6 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _ShadowFeather;
uniform mediump float _UsingDitherAlpha;
uniform sampler2D _FaceMap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump float diffuseThreshold_1;
  mediump vec4 col_2;
  mediump vec3 lightColor_3;
  mediump vec3 lightmap_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_6;
  tmpvar_6 = ((tmpvar_5 * _Color) * _EnvColor);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_LightMap, xlv_TEXCOORD0).xyz;
  lightmap_4 = tmpvar_7;
  lightColor_3 = (vec3(1.0, 1.0, 1.0) + xlv_TEXCOORD6.xyz);
  highp vec2 screenCoord_8;
  screenCoord_8 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_9;
  shadow_9 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_10;
    tmpvar_10 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_8);
    shadow_9 = tmpvar_10.x;
  };
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_FaceMap, xlv_TEXCOORD5.xy).w;
  diffuseThreshold_1 = tmpvar_11;
  mediump float lightingThreshold_12;
  lightingThreshold_12 = xlv_TEXCOORD5.z;
  mediump float tmpvar_13;
  tmpvar_13 = max ((lightingThreshold_12 - _ShadowFeather), 0.0001);
  mediump float tmpvar_14;
  tmpvar_14 = clamp (((diffuseThreshold_1 - tmpvar_13) / (
    min ((lightingThreshold_12 + _ShadowFeather), 0.9999)
   - tmpvar_13)), 0.0, 1.0);
  col_2.xyz = ((mix (_ShadowColor, vec3(1.0, 1.0, 1.0), vec3(
    ((tmpvar_14 * (tmpvar_14 * (3.0 - 
      (2.0 * tmpvar_14)
    ))) * (lightmap_4.y * shadow_9))
  )) * tmpvar_6.xyz) * lightColor_3);
  col_2.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_15;
    scrpos_15 = xlv_TEXCOORD2;
    mediump float a_16;
    a_16 = xlv_TEXCOORD2.z;
    if ((a_16 < 0.95)) {
      scrpos_15.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_16 = (a_16 * 17.0);
      highp float tmpvar_17;
      tmpvar_17 = (scrpos_15.y / 4.0);
      highp float tmpvar_18;
      tmpvar_18 = (fract(abs(tmpvar_17)) * 4.0);
      highp float tmpvar_19;
      if ((tmpvar_17 >= 0.0)) {
        tmpvar_19 = tmpvar_18;
      } else {
        tmpvar_19 = -(tmpvar_18);
      };
      highp float tmpvar_20;
      tmpvar_20 = (scrpos_15.x / 4.0);
      highp float tmpvar_21;
      tmpvar_21 = (fract(abs(tmpvar_20)) * 4.0);
      highp float tmpvar_22;
      if ((tmpvar_20 >= 0.0)) {
        tmpvar_22 = tmpvar_21;
      } else {
        tmpvar_22 = -(tmpvar_21);
      };
      highp float x_23;
      x_23 = ((a_16 - _DITHERMATRIX[
        int(tmpvar_19)
      ][
        int(tmpvar_22)
      ]) - 0.01);
      if ((x_23 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_2;
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
Keywords { "VERTEXLIGHT_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_FACEMAP_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_FACEMAP_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_FACEMAP_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "_FACEMAP_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "_FACEMAP_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "_FACEMAP_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_FACEMAP_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_FACEMAP_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_FACEMAP_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_FACEMAP_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_FACEMAP_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_FACEMAP_ON" }
""
}
}
}
 UsePass "Hidden/miHoYo/DLC/Common/Shared/PREDEPTH"
}
CustomEditor "MoleMoleEditor.CharacterAvatarFaceShaderGUI"
}