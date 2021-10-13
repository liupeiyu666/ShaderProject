//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Character/Character_Avatar/Avatar_Crystal_Outline" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_EnvColor ("Env Color", Color) = (1,1,1,1)
_Scale ("Scale Compared to Maya", Float) = 0.01
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Main Tex", 2D) = "white" { }
_RefractTex ("Refraction Texture", Cube) = "" { }
_BumpTex ("Bump Tex", 2D) = "gray" { }
_BumpScaler ("Bump Scaler", Range(0, 10)) = 1
_Opaqueness ("Opaqueness", Range(0, 1)) = 1
_Emission ("Emission", Range(1, 20)) = 1
_ReflectionStrength ("Reflection Strength", Range(0, 2)) = 1
_OutlineWidth ("Outline Width", Range(0, 100)) = 0.2
_OutlineColor ("Outline Color", Color) = (0,0,0,1)
_MaxOutlineZOffset ("Max Outline Z Offset", Range(0, 100)) = 1
_OutlineCamStart ("Outline Camera Adjustment Start Distance", Range(0, 10000)) = 1000
_FadeDistance ("Fade Start Distance", Range(0.1, 10)) = 0.5
_FadeOffset ("Fade Start Offset", Range(0, 10)) = 1
[Toggle(USINGDITHERALPAH)] _UsingDitherAlpha ("UsingDitherAlpha", Float) = 0
_DitherAlpha ("Dither Alpha Value", Range(0, 1)) = 1
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "OutlineType" = "None" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "None" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Front
  GpuProgramID 47835
Program "vp" {
SubProgram "gles " {
"#version 100

#ifdef VERTEX
#ifndef SHADER_TARGET
    #define SHADER_TARGET 25
#endif
#ifndef UNITY_NO_DXT5nm
    #define UNITY_NO_DXT5nm 1
#endif
#ifndef UNITY_NO_RGBM
    #define UNITY_NO_RGBM 1
#endif
#ifndef UNITY_ENABLE_REFLECTION_BUFFERS
    #define UNITY_ENABLE_REFLECTION_BUFFERS 1
#endif
#ifndef UNITY_FRAMEBUFFER_FETCH_AVAILABLE
    #define UNITY_FRAMEBUFFER_FETCH_AVAILABLE 1
#endif
#ifndef UNITY_NO_CUBEMAP_ARRAY
    #define UNITY_NO_CUBEMAP_ARRAY 1
#endif
#ifndef UNITY_NO_SCREENSPACE_SHADOWS
    #define UNITY_NO_SCREENSPACE_SHADOWS 1
#endif
#ifndef UNITY_PBS_USE_BRDF3
    #define UNITY_PBS_USE_BRDF3 1
#endif
#ifndef UNITY_NO_FULL_STANDARD_SHADER
    #define UNITY_NO_FULL_STANDARD_SHADER 1
#endif
#ifndef SHADER_API_MOBILE
    #define SHADER_API_MOBILE 1
#endif
#ifndef UNITY_HARDWARE_TIER1
    #define UNITY_HARDWARE_TIER1 1
#endif
#ifndef UNITY_COLORSPACE_GAMMA
    #define UNITY_COLORSPACE_GAMMA 1
#endif
#ifndef UNITY_LIGHTMAP_DLDR_ENCODING
    #define UNITY_LIGHTMAP_DLDR_ENCODING 1
#endif
#ifndef UNITY_VERSION
    #define UNITY_VERSION 201758
#endif
#ifndef SHADER_STAGE_VERTEX
    #define SHADER_STAGE_VERTEX 1
#endif
#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
#define gl_Vertex _glesVertex
attribute vec4 _glesVertex;
#define gl_Normal _glesNormal
attribute vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
attribute vec4 _glesMultiTexCoord0;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
mat3 xll_constructMat3_mf4x4( mat4 m) {
  return mat3( vec3( m[0]), vec3( m[1]), vec3( m[2]));
}
#line 447
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 756
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 749
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 73
struct v2f {
    highp vec4 pos;
    highp vec2 uv_main;
    highp vec2 uv_bump;
    highp vec3 viewDir;
    highp vec3 T;
    highp vec3 B;
    highp vec3 N;
    mediump vec2 param;
    highp vec4 scrpos;
};
#line 66
struct input {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec2 uv_main;
};
#line 40
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
#line 46
uniform highp vec3 _WorldSpaceCameraPos;
#line 53
uniform highp vec4 _ProjectionParams;
#line 59
uniform highp vec4 _ScreenParams;
#line 71
uniform highp vec4 _ZBufferParams;
#line 77
uniform highp vec4 unity_OrthoParams;
#line 82
uniform highp vec4 unity_CameraWorldClipPlanes[6];
#line 88
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 unity_WorldToCamera;
uniform highp mat4 unity_CameraToWorld;
#line 104
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
#line 108
uniform highp vec4 _LightProjectionParams;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
#line 112
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
#line 118
uniform highp vec4 unity_LightPosition[8];
#line 123
uniform mediump vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
#line 127
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
#line 131
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
#line 136
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform lowp vec4 unity_ProbesOcclusion;
#line 141
uniform mediump vec3 unity_LightColor0;
uniform mediump vec3 unity_LightColor1;
uniform mediump vec3 unity_LightColor2;
uniform mediump vec3 unity_LightColor3;
#line 148
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 152
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 161
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_LODFade;
uniform highp vec4 unity_WorldTransformParams;
#line 202
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 210
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
#line 214
uniform lowp vec4 unity_IndirectSpecColor;
uniform highp mat4 glstate_matrix_projection;
#line 218
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp int unity_StereoEyeIndex;
#line 224
uniform lowp vec4 unity_ShadowColor;
#line 231
uniform lowp vec4 unity_FogColor;
#line 236
uniform highp vec4 unity_FogParams;
#line 244
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_LightmapInd;
#line 258
uniform sampler2D unity_DynamicLightmap;
uniform sampler2D unity_DynamicDirectionality;
uniform sampler2D unity_DynamicNormal;
#line 263
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
#line 271
uniform samplerCube unity_SpecCube0;
uniform samplerCube unity_SpecCube1;
#line 275
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
#line 280
uniform highp vec4 unity_SpecCube1_BoxMax;
uniform highp vec4 unity_SpecCube1_BoxMin;
uniform highp vec4 unity_SpecCube1_ProbePosition;
uniform mediump vec4 unity_SpecCube1_HDR;
#line 320
highp mat4 unity_MatrixMVP;
highp mat4 unity_MatrixMV;
highp mat4 unity_MatrixTMV;
highp mat4 unity_MatrixITMV;
#line 9
#line 14
#line 84
#line 93
#line 103
#line 112
#line 124
#line 135
#line 141
#line 147
#line 151
#line 157
#line 163
#line 169
#line 175
#line 186
#line 201
#line 208
#line 223
#line 230
#line 237
#line 255
#line 291
#line 320
#line 326
#line 339
#line 357
#line 373
#line 427
#line 453
#line 464
#line 473
#line 480
#line 485
#line 502
#line 522
#line 537
#line 543
#line 554
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 unity_DynamicLightmap_HDR;
#line 568
#line 578
#line 593
#line 602
#line 609
#line 618
#line 626
#line 635
#line 654
#line 660
#line 670
#line 680
#line 691
#line 696
#line 702
#line 707
#line 764
#line 770
#line 785
#line 816
#line 830
#line 834
#line 840
#line 849
#line 859
#line 885
#line 891
#line 8
#line 17
#line 29
#line 50
#line 91
#line 102
#line 114
#line 127
#line 133
#line 188
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
#line 202
#line 234
uniform highp mat4 _DITHERMATRIX;
#line 259
#line 91
uniform sampler2D _BumpTex;
uniform highp vec4 _BumpTex_ST;
uniform mediump vec4 _Color;
#line 95
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform samplerCube _RefractTex;
uniform mediump float _ReflectionStrength;
#line 99
uniform mediump float _Emission;
uniform mediump float _BumpScaler;
uniform mediump float _Opaqueness;
#line 103
uniform highp float _BloomFactor;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
#line 107
#line 785
highp vec4 ComputeNonStereoScreenPos( in highp vec4 pos ) {
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    #line 789
    return o;
}
#line 792
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 793
    highp vec4 o = ComputeNonStereoScreenPos( pos);
    #line 797
    return o;
}
#line 9
highp vec4 UnityObjectToClipPos( in highp vec3 pos ) {
    return (unity_MatrixVP * (unity_ObjectToWorld * vec4( pos, 1.0)));
}
#line 14
highp vec4 UnityObjectToClipPos( in highp vec4 pos ) {
    return UnityObjectToClipPos( pos.xyz);
}
#line 175
highp vec3 UnityObjectToWorldNormal( in highp vec3 norm ) {
    #line 181
    return normalize((norm * xll_constructMat3_mf4x4( unity_WorldToObject)));
}
#line 107
v2f vertBump( in input i ) {
    v2f o = v2f(vec4(0.0, 0.0, 0.0, 0.0), vec2(0.0, 0.0), vec2(0.0, 0.0), vec3(0.0, 0.0, 0.0), vec3(0.0, 0.0, 0.0), vec3(0.0, 0.0, 0.0), vec3(0.0, 0.0, 0.0), vec2(0.0, 0.0), vec4(0.0, 0.0, 0.0, 0.0));
    o.uv_main = i.uv_main;
    #line 111
    o.uv_bump = ((i.uv_main.xy * _BumpTex_ST.xy) + _BumpTex_ST.zw);
    mediump float alpha = 1.0;
    o.param.y = (alpha * _Opaqueness);
    #line 116
    highp vec4 objPos = (unity_ObjectToWorld * i.vertex);
    o.viewDir = normalize((_WorldSpaceCameraPos.xyz - objPos.xyz));
    o.pos = UnityObjectToClipPos( i.vertex);
    #line 120
    o.N = (-UnityObjectToWorldNormal( i.normal));
    o.T = vec3( o.N.y, (-o.N.x), 0.0);
    o.T = normalize(o.T);
    o.B = cross( o.N, o.T);
    #line 124
    o.B = normalize(o.B);
    if (bool(_UsingDitherAlpha)){
        #line 128
        o.scrpos = ComputeScreenPos( o.pos);
        o.scrpos.z = _DitherAlpha;
    }
    #line 132
    return o;
}
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main() {
unity_MatrixMVP = (unity_MatrixVP * unity_ObjectToWorld);
unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
unity_MatrixTMV = xll_transpose_mf4x4(unity_MatrixMV);
unity_MatrixITMV = xll_transpose_mf4x4((unity_WorldToObject * unity_MatrixInvV));
    v2f xl_retval;
    input xlt_i;
    xlt_i.vertex = vec4(gl_Vertex);
    xlt_i.normal = vec3(gl_Normal);
    xlt_i.uv_main = vec2(gl_MultiTexCoord0);
    xl_retval = vertBump( xlt_i);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec2(xl_retval.uv_main);
    xlv_TEXCOORD1 = vec2(xl_retval.uv_bump);
    xlv_TEXCOORD2 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD3 = vec3(xl_retval.T);
    xlv_TEXCOORD4 = vec3(xl_retval.B);
    xlv_TEXCOORD5 = vec3(xl_retval.N);
    xlv_COLOR1 = vec2(xl_retval.param);
    xlv_TEXCOORD6 = vec4(xl_retval.scrpos);
}
/* HLSL2GLSL - NOTE: GLSL optimization failed
(67,8): error: illegal use of reserved word `input'
(67,8): error: syntax error, unexpected ERROR_TOK, expecting IDENTIFIER or TYPE_IDENTIFIER or NEW_IDENTIFIER or '{'
*/

#endif
#ifdef FRAGMENT
#ifndef SHADER_TARGET
    #define SHADER_TARGET 25
#endif
#ifndef UNITY_NO_DXT5nm
    #define UNITY_NO_DXT5nm 1
#endif
#ifndef UNITY_NO_RGBM
    #define UNITY_NO_RGBM 1
#endif
#ifndef UNITY_ENABLE_REFLECTION_BUFFERS
    #define UNITY_ENABLE_REFLECTION_BUFFERS 1
#endif
#ifndef UNITY_FRAMEBUFFER_FETCH_AVAILABLE
    #define UNITY_FRAMEBUFFER_FETCH_AVAILABLE 1
#endif
#ifndef UNITY_NO_CUBEMAP_ARRAY
    #define UNITY_NO_CUBEMAP_ARRAY 1
#endif
#ifndef UNITY_NO_SCREENSPACE_SHADOWS
    #define UNITY_NO_SCREENSPACE_SHADOWS 1
#endif
#ifndef UNITY_PBS_USE_BRDF3
    #define UNITY_PBS_USE_BRDF3 1
#endif
#ifndef UNITY_NO_FULL_STANDARD_SHADER
    #define UNITY_NO_FULL_STANDARD_SHADER 1
#endif
#ifndef SHADER_API_MOBILE
    #define SHADER_API_MOBILE 1
#endif
#ifndef UNITY_HARDWARE_TIER1
    #define UNITY_HARDWARE_TIER1 1
#endif
#ifndef UNITY_COLORSPACE_GAMMA
    #define UNITY_COLORSPACE_GAMMA 1
#endif
#ifndef UNITY_LIGHTMAP_DLDR_ENCODING
    #define UNITY_LIGHTMAP_DLDR_ENCODING 1
#endif
#ifndef UNITY_VERSION
    #define UNITY_VERSION 201758
#endif
#ifndef SHADER_STAGE_VERTEX
    #define SHADER_STAGE_VERTEX 1
#endif
#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
float xll_mod_f_f( float x, float y ) {
  float d = x / y;
  float f = fract (abs(d)) * y;
  return d >= 0.0 ? f : -f;
}
vec2 xll_mod_vf2_vf2( vec2 x, vec2 y ) {
  vec2 d = x / y;
  vec2 f = fract (abs(d)) * y;
  return vec2 (d.x >= 0.0 ? f.x : -f.x, d.y >= 0.0 ? f.y : -f.y);
}
vec3 xll_mod_vf3_vf3( vec3 x, vec3 y ) {
  vec3 d = x / y;
  vec3 f = fract (abs(d)) * y;
  return vec3 (d.x >= 0.0 ? f.x : -f.x, d.y >= 0.0 ? f.y : -f.y, d.z >= 0.0 ? f.z : -f.z);
}
vec4 xll_mod_vf4_vf4( vec4 x, vec4 y ) {
  vec4 d = x / y;
  vec4 f = fract (abs(d)) * y;
  return vec4 (d.x >= 0.0 ? f.x : -f.x, d.y >= 0.0 ? f.y : -f.y, d.z >= 0.0 ? f.z : -f.z, d.w >= 0.0 ? f.w : -f.w);
}
void xll_clip_f(float x) {
  if ( x<0.0 ) discard;
}
void xll_clip_vf2(vec2 x) {
  if (any(lessThan(x,vec2(0.0)))) discard;
}
void xll_clip_vf3(vec3 x) {
  if (any(lessThan(x,vec3(0.0)))) discard;
}
void xll_clip_vf4(vec4 x) {
  if (any(lessThan(x,vec4(0.0)))) discard;
}
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 447
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 756
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 749
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 73
struct v2f {
    highp vec4 pos;
    highp vec2 uv_main;
    highp vec2 uv_bump;
    highp vec3 viewDir;
    highp vec3 T;
    highp vec3 B;
    highp vec3 N;
    mediump vec2 param;
    highp vec4 scrpos;
};
#line 66
struct input {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec2 uv_main;
};
#line 40
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
#line 46
uniform highp vec3 _WorldSpaceCameraPos;
#line 53
uniform highp vec4 _ProjectionParams;
#line 59
uniform highp vec4 _ScreenParams;
#line 71
uniform highp vec4 _ZBufferParams;
#line 77
uniform highp vec4 unity_OrthoParams;
#line 82
uniform highp vec4 unity_CameraWorldClipPlanes[6];
#line 88
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 unity_WorldToCamera;
uniform highp mat4 unity_CameraToWorld;
#line 104
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
#line 108
uniform highp vec4 _LightProjectionParams;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
#line 112
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
#line 118
uniform highp vec4 unity_LightPosition[8];
#line 123
uniform mediump vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
#line 127
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
#line 131
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
#line 136
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform lowp vec4 unity_ProbesOcclusion;
#line 141
uniform mediump vec3 unity_LightColor0;
uniform mediump vec3 unity_LightColor1;
uniform mediump vec3 unity_LightColor2;
uniform mediump vec3 unity_LightColor3;
#line 148
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 152
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 161
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_LODFade;
uniform highp vec4 unity_WorldTransformParams;
#line 202
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 210
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
#line 214
uniform lowp vec4 unity_IndirectSpecColor;
uniform highp mat4 glstate_matrix_projection;
#line 218
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp int unity_StereoEyeIndex;
#line 224
uniform lowp vec4 unity_ShadowColor;
#line 231
uniform lowp vec4 unity_FogColor;
#line 236
uniform highp vec4 unity_FogParams;
#line 244
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_LightmapInd;
#line 258
uniform sampler2D unity_DynamicLightmap;
uniform sampler2D unity_DynamicDirectionality;
uniform sampler2D unity_DynamicNormal;
#line 263
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
#line 271
uniform samplerCube unity_SpecCube0;
uniform samplerCube unity_SpecCube1;
#line 275
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
#line 280
uniform highp vec4 unity_SpecCube1_BoxMax;
uniform highp vec4 unity_SpecCube1_BoxMin;
uniform highp vec4 unity_SpecCube1_ProbePosition;
uniform mediump vec4 unity_SpecCube1_HDR;
#line 320
highp mat4 unity_MatrixMVP;
highp mat4 unity_MatrixMV;
highp mat4 unity_MatrixTMV;
highp mat4 unity_MatrixITMV;
#line 9
#line 14
#line 84
#line 93
#line 103
#line 112
#line 124
#line 135
#line 141
#line 147
#line 151
#line 157
#line 163
#line 169
#line 175
#line 186
#line 201
#line 208
#line 223
#line 230
#line 237
#line 255
#line 291
#line 320
#line 326
#line 339
#line 357
#line 373
#line 427
#line 453
#line 464
#line 473
#line 480
#line 485
#line 502
#line 522
#line 537
#line 543
#line 554
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 unity_DynamicLightmap_HDR;
#line 568
#line 578
#line 593
#line 602
#line 609
#line 618
#line 626
#line 635
#line 654
#line 660
#line 670
#line 680
#line 691
#line 696
#line 702
#line 707
#line 764
#line 770
#line 785
#line 816
#line 830
#line 834
#line 840
#line 849
#line 859
#line 885
#line 891
#line 8
#line 17
#line 29
#line 50
#line 91
#line 102
#line 114
#line 127
#line 133
#line 188
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
#line 202
#line 234
uniform highp mat4 _DITHERMATRIX;
#line 259
#line 91
uniform sampler2D _BumpTex;
uniform highp vec4 _BumpTex_ST;
uniform mediump vec4 _Color;
#line 95
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform samplerCube _RefractTex;
uniform mediump float _ReflectionStrength;
#line 99
uniform mediump float _Emission;
uniform mediump float _BumpScaler;
uniform mediump float _Opaqueness;
#line 103
uniform highp float _BloomFactor;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
#line 107
#line 235
void dither_clip( in highp vec4 scrpos, in mediump float a ) {
    if ((a < 0.95)){
        #line 239
        scrpos.xy = ((scrpos.xy / scrpos.w) * _ScreenParams.xy);
        a *= 17.0;
        highp float curA = _DITHERMATRIX[int(xll_mod_f_f( scrpos.y, 4.0))][int(xll_mod_f_f( scrpos.x, 4.0))];
        xll_clip_f(((a - curA) - 0.01));
    }
    #line 244
    return ;
}
#line 135
mediump vec4 fragBump( in v2f i ) {
    #line 137
    mediump vec4 outColor = vec4( 0.0);
    mediump vec3 baseTexColor = ((texture2D( _MainTex, i.uv_main.xy).xyz * _Color.xyz) * vec3( _EnvColor));
    #line 142
    highp vec3 bumpVector = (texture2D( _BumpTex, i.uv_bump.xy).xyz - vec3( 0.5, 0.5, 0.0));
    bumpVector.xy *= _BumpScaler;
    bumpVector = normalize(bumpVector);
    #line 146
    highp vec3 N = (((i.T * bumpVector.x) + (i.B * bumpVector.y)) + (i.N * bumpVector.z));
    highp vec3 V = normalize(i.viewDir);
    highp vec3 uv_refract = (-reflect( V, N));
    mediump vec3 refraction = (textureCube( _RefractTex, uv_refract).xyz * baseTexColor);
    #line 150
    mediump vec3 multiplier = ((vec3( 1.0, 1.0, 1.0) * _ReflectionStrength) + _Emission);
    outColor.xyz = (refraction.xyz * multiplier.xyz);
    outColor.w = i.param.y;
    #line 154
    if (bool(_UsingDitherAlpha)){
        dither_clip( i.scrpos, i.scrpos.z);
    }
    #line 158
    outColor.w = xll_saturate_f(outColor.w);
    return outColor;
}
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main() {
unity_MatrixMVP = (unity_MatrixVP * unity_ObjectToWorld);
unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
unity_MatrixTMV = xll_transpose_mf4x4(unity_MatrixMV);
unity_MatrixITMV = xll_transpose_mf4x4((unity_WorldToObject * unity_MatrixInvV));
    mediump vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.uv_main = vec2(xlv_TEXCOORD0);
    xlt_i.uv_bump = vec2(xlv_TEXCOORD1);
    xlt_i.viewDir = vec3(xlv_TEXCOORD2);
    xlt_i.T = vec3(xlv_TEXCOORD3);
    xlt_i.B = vec3(xlv_TEXCOORD4);
    xlt_i.N = vec3(xlv_TEXCOORD5);
    xlt_i.param = vec2(xlv_COLOR1);
    xlt_i.scrpos = vec4(xlv_TEXCOORD6);
    xl_retval = fragBump( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}
/* HLSL2GLSL - NOTE: GLSL optimization failed
(67,8): error: illegal use of reserved word `input'
(67,8): error: syntax error, unexpected ERROR_TOK, expecting IDENTIFIER or TYPE_IDENTIFIER or NEW_IDENTIFIER or '{'
*/

#endif
"
}
SubProgram "gles " {
"#version 100

#ifdef VERTEX
#ifndef SHADER_TARGET
    #define SHADER_TARGET 25
#endif
#ifndef UNITY_NO_DXT5nm
    #define UNITY_NO_DXT5nm 1
#endif
#ifndef UNITY_NO_RGBM
    #define UNITY_NO_RGBM 1
#endif
#ifndef UNITY_ENABLE_REFLECTION_BUFFERS
    #define UNITY_ENABLE_REFLECTION_BUFFERS 1
#endif
#ifndef UNITY_FRAMEBUFFER_FETCH_AVAILABLE
    #define UNITY_FRAMEBUFFER_FETCH_AVAILABLE 1
#endif
#ifndef UNITY_NO_CUBEMAP_ARRAY
    #define UNITY_NO_CUBEMAP_ARRAY 1
#endif
#ifndef UNITY_NO_SCREENSPACE_SHADOWS
    #define UNITY_NO_SCREENSPACE_SHADOWS 1
#endif
#ifndef UNITY_PBS_USE_BRDF2
    #define UNITY_PBS_USE_BRDF2 1
#endif
#ifndef SHADER_API_MOBILE
    #define SHADER_API_MOBILE 1
#endif
#ifndef UNITY_HARDWARE_TIER2
    #define UNITY_HARDWARE_TIER2 1
#endif
#ifndef UNITY_COLORSPACE_GAMMA
    #define UNITY_COLORSPACE_GAMMA 1
#endif
#ifndef UNITY_LIGHTMAP_DLDR_ENCODING
    #define UNITY_LIGHTMAP_DLDR_ENCODING 1
#endif
#ifndef UNITY_VERSION
    #define UNITY_VERSION 201758
#endif
#ifndef SHADER_STAGE_VERTEX
    #define SHADER_STAGE_VERTEX 1
#endif
#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
#define gl_Vertex _glesVertex
attribute vec4 _glesVertex;
#define gl_Normal _glesNormal
attribute vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
attribute vec4 _glesMultiTexCoord0;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
mat3 xll_constructMat3_mf4x4( mat4 m) {
  return mat3( vec3( m[0]), vec3( m[1]), vec3( m[2]));
}
#line 447
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 756
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 749
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 73
struct v2f {
    highp vec4 pos;
    highp vec2 uv_main;
    highp vec2 uv_bump;
    highp vec3 viewDir;
    highp vec3 T;
    highp vec3 B;
    highp vec3 N;
    mediump vec2 param;
    highp vec4 scrpos;
};
#line 66
struct input {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec2 uv_main;
};
#line 40
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
#line 46
uniform highp vec3 _WorldSpaceCameraPos;
#line 53
uniform highp vec4 _ProjectionParams;
#line 59
uniform highp vec4 _ScreenParams;
#line 71
uniform highp vec4 _ZBufferParams;
#line 77
uniform highp vec4 unity_OrthoParams;
#line 82
uniform highp vec4 unity_CameraWorldClipPlanes[6];
#line 88
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 unity_WorldToCamera;
uniform highp mat4 unity_CameraToWorld;
#line 104
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
#line 108
uniform highp vec4 _LightProjectionParams;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
#line 112
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
#line 118
uniform highp vec4 unity_LightPosition[8];
#line 123
uniform mediump vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
#line 127
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
#line 131
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
#line 136
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform lowp vec4 unity_ProbesOcclusion;
#line 141
uniform mediump vec3 unity_LightColor0;
uniform mediump vec3 unity_LightColor1;
uniform mediump vec3 unity_LightColor2;
uniform mediump vec3 unity_LightColor3;
#line 148
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 152
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 161
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_LODFade;
uniform highp vec4 unity_WorldTransformParams;
#line 202
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 210
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
#line 214
uniform lowp vec4 unity_IndirectSpecColor;
uniform highp mat4 glstate_matrix_projection;
#line 218
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp int unity_StereoEyeIndex;
#line 224
uniform lowp vec4 unity_ShadowColor;
#line 231
uniform lowp vec4 unity_FogColor;
#line 236
uniform highp vec4 unity_FogParams;
#line 244
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_LightmapInd;
#line 258
uniform sampler2D unity_DynamicLightmap;
uniform sampler2D unity_DynamicDirectionality;
uniform sampler2D unity_DynamicNormal;
#line 263
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
#line 271
uniform samplerCube unity_SpecCube0;
uniform samplerCube unity_SpecCube1;
#line 275
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
#line 280
uniform highp vec4 unity_SpecCube1_BoxMax;
uniform highp vec4 unity_SpecCube1_BoxMin;
uniform highp vec4 unity_SpecCube1_ProbePosition;
uniform mediump vec4 unity_SpecCube1_HDR;
#line 320
highp mat4 unity_MatrixMVP;
highp mat4 unity_MatrixMV;
highp mat4 unity_MatrixTMV;
highp mat4 unity_MatrixITMV;
#line 9
#line 14
#line 84
#line 93
#line 103
#line 112
#line 124
#line 135
#line 141
#line 147
#line 151
#line 157
#line 163
#line 169
#line 175
#line 186
#line 201
#line 208
#line 223
#line 230
#line 237
#line 255
#line 291
#line 320
#line 326
#line 339
#line 357
#line 373
#line 427
#line 453
#line 464
#line 473
#line 480
#line 485
#line 502
#line 522
#line 537
#line 543
#line 554
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 unity_DynamicLightmap_HDR;
#line 568
#line 578
#line 593
#line 602
#line 609
#line 618
#line 626
#line 635
#line 654
#line 660
#line 670
#line 680
#line 691
#line 696
#line 702
#line 707
#line 764
#line 770
#line 785
#line 816
#line 830
#line 834
#line 840
#line 849
#line 859
#line 885
#line 891
#line 8
#line 17
#line 29
#line 50
#line 91
#line 102
#line 114
#line 127
#line 133
#line 188
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
#line 202
#line 234
uniform highp mat4 _DITHERMATRIX;
#line 259
#line 91
uniform sampler2D _BumpTex;
uniform highp vec4 _BumpTex_ST;
uniform mediump vec4 _Color;
#line 95
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform samplerCube _RefractTex;
uniform mediump float _ReflectionStrength;
#line 99
uniform mediump float _Emission;
uniform mediump float _BumpScaler;
uniform mediump float _Opaqueness;
#line 103
uniform highp float _BloomFactor;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
#line 107
#line 785
highp vec4 ComputeNonStereoScreenPos( in highp vec4 pos ) {
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    #line 789
    return o;
}
#line 792
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 793
    highp vec4 o = ComputeNonStereoScreenPos( pos);
    #line 797
    return o;
}
#line 9
highp vec4 UnityObjectToClipPos( in highp vec3 pos ) {
    return (unity_MatrixVP * (unity_ObjectToWorld * vec4( pos, 1.0)));
}
#line 14
highp vec4 UnityObjectToClipPos( in highp vec4 pos ) {
    return UnityObjectToClipPos( pos.xyz);
}
#line 175
highp vec3 UnityObjectToWorldNormal( in highp vec3 norm ) {
    #line 181
    return normalize((norm * xll_constructMat3_mf4x4( unity_WorldToObject)));
}
#line 107
v2f vertBump( in input i ) {
    v2f o = v2f(vec4(0.0, 0.0, 0.0, 0.0), vec2(0.0, 0.0), vec2(0.0, 0.0), vec3(0.0, 0.0, 0.0), vec3(0.0, 0.0, 0.0), vec3(0.0, 0.0, 0.0), vec3(0.0, 0.0, 0.0), vec2(0.0, 0.0), vec4(0.0, 0.0, 0.0, 0.0));
    o.uv_main = i.uv_main;
    #line 111
    o.uv_bump = ((i.uv_main.xy * _BumpTex_ST.xy) + _BumpTex_ST.zw);
    mediump float alpha = 1.0;
    o.param.y = (alpha * _Opaqueness);
    #line 116
    highp vec4 objPos = (unity_ObjectToWorld * i.vertex);
    o.viewDir = normalize((_WorldSpaceCameraPos.xyz - objPos.xyz));
    o.pos = UnityObjectToClipPos( i.vertex);
    #line 120
    o.N = (-UnityObjectToWorldNormal( i.normal));
    o.T = vec3( o.N.y, (-o.N.x), 0.0);
    o.T = normalize(o.T);
    o.B = cross( o.N, o.T);
    #line 124
    o.B = normalize(o.B);
    if (bool(_UsingDitherAlpha)){
        #line 128
        o.scrpos = ComputeScreenPos( o.pos);
        o.scrpos.z = _DitherAlpha;
    }
    #line 132
    return o;
}
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main() {
unity_MatrixMVP = (unity_MatrixVP * unity_ObjectToWorld);
unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
unity_MatrixTMV = xll_transpose_mf4x4(unity_MatrixMV);
unity_MatrixITMV = xll_transpose_mf4x4((unity_WorldToObject * unity_MatrixInvV));
    v2f xl_retval;
    input xlt_i;
    xlt_i.vertex = vec4(gl_Vertex);
    xlt_i.normal = vec3(gl_Normal);
    xlt_i.uv_main = vec2(gl_MultiTexCoord0);
    xl_retval = vertBump( xlt_i);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec2(xl_retval.uv_main);
    xlv_TEXCOORD1 = vec2(xl_retval.uv_bump);
    xlv_TEXCOORD2 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD3 = vec3(xl_retval.T);
    xlv_TEXCOORD4 = vec3(xl_retval.B);
    xlv_TEXCOORD5 = vec3(xl_retval.N);
    xlv_COLOR1 = vec2(xl_retval.param);
    xlv_TEXCOORD6 = vec4(xl_retval.scrpos);
}
/* HLSL2GLSL - NOTE: GLSL optimization failed
(67,8): error: illegal use of reserved word `input'
(67,8): error: syntax error, unexpected ERROR_TOK, expecting IDENTIFIER or TYPE_IDENTIFIER or NEW_IDENTIFIER or '{'
*/

#endif
#ifdef FRAGMENT
#ifndef SHADER_TARGET
    #define SHADER_TARGET 25
#endif
#ifndef UNITY_NO_DXT5nm
    #define UNITY_NO_DXT5nm 1
#endif
#ifndef UNITY_NO_RGBM
    #define UNITY_NO_RGBM 1
#endif
#ifndef UNITY_ENABLE_REFLECTION_BUFFERS
    #define UNITY_ENABLE_REFLECTION_BUFFERS 1
#endif
#ifndef UNITY_FRAMEBUFFER_FETCH_AVAILABLE
    #define UNITY_FRAMEBUFFER_FETCH_AVAILABLE 1
#endif
#ifndef UNITY_NO_CUBEMAP_ARRAY
    #define UNITY_NO_CUBEMAP_ARRAY 1
#endif
#ifndef UNITY_NO_SCREENSPACE_SHADOWS
    #define UNITY_NO_SCREENSPACE_SHADOWS 1
#endif
#ifndef UNITY_PBS_USE_BRDF2
    #define UNITY_PBS_USE_BRDF2 1
#endif
#ifndef SHADER_API_MOBILE
    #define SHADER_API_MOBILE 1
#endif
#ifndef UNITY_HARDWARE_TIER2
    #define UNITY_HARDWARE_TIER2 1
#endif
#ifndef UNITY_COLORSPACE_GAMMA
    #define UNITY_COLORSPACE_GAMMA 1
#endif
#ifndef UNITY_LIGHTMAP_DLDR_ENCODING
    #define UNITY_LIGHTMAP_DLDR_ENCODING 1
#endif
#ifndef UNITY_VERSION
    #define UNITY_VERSION 201758
#endif
#ifndef SHADER_STAGE_VERTEX
    #define SHADER_STAGE_VERTEX 1
#endif
#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
float xll_mod_f_f( float x, float y ) {
  float d = x / y;
  float f = fract (abs(d)) * y;
  return d >= 0.0 ? f : -f;
}
vec2 xll_mod_vf2_vf2( vec2 x, vec2 y ) {
  vec2 d = x / y;
  vec2 f = fract (abs(d)) * y;
  return vec2 (d.x >= 0.0 ? f.x : -f.x, d.y >= 0.0 ? f.y : -f.y);
}
vec3 xll_mod_vf3_vf3( vec3 x, vec3 y ) {
  vec3 d = x / y;
  vec3 f = fract (abs(d)) * y;
  return vec3 (d.x >= 0.0 ? f.x : -f.x, d.y >= 0.0 ? f.y : -f.y, d.z >= 0.0 ? f.z : -f.z);
}
vec4 xll_mod_vf4_vf4( vec4 x, vec4 y ) {
  vec4 d = x / y;
  vec4 f = fract (abs(d)) * y;
  return vec4 (d.x >= 0.0 ? f.x : -f.x, d.y >= 0.0 ? f.y : -f.y, d.z >= 0.0 ? f.z : -f.z, d.w >= 0.0 ? f.w : -f.w);
}
void xll_clip_f(float x) {
  if ( x<0.0 ) discard;
}
void xll_clip_vf2(vec2 x) {
  if (any(lessThan(x,vec2(0.0)))) discard;
}
void xll_clip_vf3(vec3 x) {
  if (any(lessThan(x,vec3(0.0)))) discard;
}
void xll_clip_vf4(vec4 x) {
  if (any(lessThan(x,vec4(0.0)))) discard;
}
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 447
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 756
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 749
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 73
struct v2f {
    highp vec4 pos;
    highp vec2 uv_main;
    highp vec2 uv_bump;
    highp vec3 viewDir;
    highp vec3 T;
    highp vec3 B;
    highp vec3 N;
    mediump vec2 param;
    highp vec4 scrpos;
};
#line 66
struct input {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec2 uv_main;
};
#line 40
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
#line 46
uniform highp vec3 _WorldSpaceCameraPos;
#line 53
uniform highp vec4 _ProjectionParams;
#line 59
uniform highp vec4 _ScreenParams;
#line 71
uniform highp vec4 _ZBufferParams;
#line 77
uniform highp vec4 unity_OrthoParams;
#line 82
uniform highp vec4 unity_CameraWorldClipPlanes[6];
#line 88
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 unity_WorldToCamera;
uniform highp mat4 unity_CameraToWorld;
#line 104
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
#line 108
uniform highp vec4 _LightProjectionParams;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
#line 112
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
#line 118
uniform highp vec4 unity_LightPosition[8];
#line 123
uniform mediump vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
#line 127
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
#line 131
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
#line 136
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform lowp vec4 unity_ProbesOcclusion;
#line 141
uniform mediump vec3 unity_LightColor0;
uniform mediump vec3 unity_LightColor1;
uniform mediump vec3 unity_LightColor2;
uniform mediump vec3 unity_LightColor3;
#line 148
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 152
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 161
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_LODFade;
uniform highp vec4 unity_WorldTransformParams;
#line 202
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 210
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
#line 214
uniform lowp vec4 unity_IndirectSpecColor;
uniform highp mat4 glstate_matrix_projection;
#line 218
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp int unity_StereoEyeIndex;
#line 224
uniform lowp vec4 unity_ShadowColor;
#line 231
uniform lowp vec4 unity_FogColor;
#line 236
uniform highp vec4 unity_FogParams;
#line 244
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_LightmapInd;
#line 258
uniform sampler2D unity_DynamicLightmap;
uniform sampler2D unity_DynamicDirectionality;
uniform sampler2D unity_DynamicNormal;
#line 263
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
#line 271
uniform samplerCube unity_SpecCube0;
uniform samplerCube unity_SpecCube1;
#line 275
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
#line 280
uniform highp vec4 unity_SpecCube1_BoxMax;
uniform highp vec4 unity_SpecCube1_BoxMin;
uniform highp vec4 unity_SpecCube1_ProbePosition;
uniform mediump vec4 unity_SpecCube1_HDR;
#line 320
highp mat4 unity_MatrixMVP;
highp mat4 unity_MatrixMV;
highp mat4 unity_MatrixTMV;
highp mat4 unity_MatrixITMV;
#line 9
#line 14
#line 84
#line 93
#line 103
#line 112
#line 124
#line 135
#line 141
#line 147
#line 151
#line 157
#line 163
#line 169
#line 175
#line 186
#line 201
#line 208
#line 223
#line 230
#line 237
#line 255
#line 291
#line 320
#line 326
#line 339
#line 357
#line 373
#line 427
#line 453
#line 464
#line 473
#line 480
#line 485
#line 502
#line 522
#line 537
#line 543
#line 554
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 unity_DynamicLightmap_HDR;
#line 568
#line 578
#line 593
#line 602
#line 609
#line 618
#line 626
#line 635
#line 654
#line 660
#line 670
#line 680
#line 691
#line 696
#line 702
#line 707
#line 764
#line 770
#line 785
#line 816
#line 830
#line 834
#line 840
#line 849
#line 859
#line 885
#line 891
#line 8
#line 17
#line 29
#line 50
#line 91
#line 102
#line 114
#line 127
#line 133
#line 188
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
#line 202
#line 234
uniform highp mat4 _DITHERMATRIX;
#line 259
#line 91
uniform sampler2D _BumpTex;
uniform highp vec4 _BumpTex_ST;
uniform mediump vec4 _Color;
#line 95
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform samplerCube _RefractTex;
uniform mediump float _ReflectionStrength;
#line 99
uniform mediump float _Emission;
uniform mediump float _BumpScaler;
uniform mediump float _Opaqueness;
#line 103
uniform highp float _BloomFactor;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
#line 107
#line 235
void dither_clip( in highp vec4 scrpos, in mediump float a ) {
    if ((a < 0.95)){
        #line 239
        scrpos.xy = ((scrpos.xy / scrpos.w) * _ScreenParams.xy);
        a *= 17.0;
        highp float curA = _DITHERMATRIX[int(xll_mod_f_f( scrpos.y, 4.0))][int(xll_mod_f_f( scrpos.x, 4.0))];
        xll_clip_f(((a - curA) - 0.01));
    }
    #line 244
    return ;
}
#line 135
mediump vec4 fragBump( in v2f i ) {
    #line 137
    mediump vec4 outColor = vec4( 0.0);
    mediump vec3 baseTexColor = ((texture2D( _MainTex, i.uv_main.xy).xyz * _Color.xyz) * vec3( _EnvColor));
    #line 142
    highp vec3 bumpVector = (texture2D( _BumpTex, i.uv_bump.xy).xyz - vec3( 0.5, 0.5, 0.0));
    bumpVector.xy *= _BumpScaler;
    bumpVector = normalize(bumpVector);
    #line 146
    highp vec3 N = (((i.T * bumpVector.x) + (i.B * bumpVector.y)) + (i.N * bumpVector.z));
    highp vec3 V = normalize(i.viewDir);
    highp vec3 uv_refract = (-reflect( V, N));
    mediump vec3 refraction = (textureCube( _RefractTex, uv_refract).xyz * baseTexColor);
    #line 150
    mediump vec3 multiplier = ((vec3( 1.0, 1.0, 1.0) * _ReflectionStrength) + _Emission);
    outColor.xyz = (refraction.xyz * multiplier.xyz);
    outColor.w = i.param.y;
    #line 154
    if (bool(_UsingDitherAlpha)){
        dither_clip( i.scrpos, i.scrpos.z);
    }
    #line 158
    outColor.w = xll_saturate_f(outColor.w);
    return outColor;
}
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main() {
unity_MatrixMVP = (unity_MatrixVP * unity_ObjectToWorld);
unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
unity_MatrixTMV = xll_transpose_mf4x4(unity_MatrixMV);
unity_MatrixITMV = xll_transpose_mf4x4((unity_WorldToObject * unity_MatrixInvV));
    mediump vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.uv_main = vec2(xlv_TEXCOORD0);
    xlt_i.uv_bump = vec2(xlv_TEXCOORD1);
    xlt_i.viewDir = vec3(xlv_TEXCOORD2);
    xlt_i.T = vec3(xlv_TEXCOORD3);
    xlt_i.B = vec3(xlv_TEXCOORD4);
    xlt_i.N = vec3(xlv_TEXCOORD5);
    xlt_i.param = vec2(xlv_COLOR1);
    xlt_i.scrpos = vec4(xlv_TEXCOORD6);
    xl_retval = fragBump( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}
/* HLSL2GLSL - NOTE: GLSL optimization failed
(67,8): error: illegal use of reserved word `input'
(67,8): error: syntax error, unexpected ERROR_TOK, expecting IDENTIFIER or TYPE_IDENTIFIER or NEW_IDENTIFIER or '{'
*/

#endif
"
}
SubProgram "gles " {
"#version 100

#ifdef VERTEX
#ifndef SHADER_TARGET
    #define SHADER_TARGET 25
#endif
#ifndef UNITY_NO_DXT5nm
    #define UNITY_NO_DXT5nm 1
#endif
#ifndef UNITY_NO_RGBM
    #define UNITY_NO_RGBM 1
#endif
#ifndef UNITY_ENABLE_REFLECTION_BUFFERS
    #define UNITY_ENABLE_REFLECTION_BUFFERS 1
#endif
#ifndef UNITY_FRAMEBUFFER_FETCH_AVAILABLE
    #define UNITY_FRAMEBUFFER_FETCH_AVAILABLE 1
#endif
#ifndef UNITY_NO_CUBEMAP_ARRAY
    #define UNITY_NO_CUBEMAP_ARRAY 1
#endif
#ifndef UNITY_NO_SCREENSPACE_SHADOWS
    #define UNITY_NO_SCREENSPACE_SHADOWS 1
#endif
#ifndef UNITY_PBS_USE_BRDF2
    #define UNITY_PBS_USE_BRDF2 1
#endif
#ifndef SHADER_API_MOBILE
    #define SHADER_API_MOBILE 1
#endif
#ifndef UNITY_HARDWARE_TIER3
    #define UNITY_HARDWARE_TIER3 1
#endif
#ifndef UNITY_COLORSPACE_GAMMA
    #define UNITY_COLORSPACE_GAMMA 1
#endif
#ifndef UNITY_LIGHTMAP_DLDR_ENCODING
    #define UNITY_LIGHTMAP_DLDR_ENCODING 1
#endif
#ifndef UNITY_VERSION
    #define UNITY_VERSION 201758
#endif
#ifndef SHADER_STAGE_VERTEX
    #define SHADER_STAGE_VERTEX 1
#endif
#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
#define gl_Vertex _glesVertex
attribute vec4 _glesVertex;
#define gl_Normal _glesNormal
attribute vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
attribute vec4 _glesMultiTexCoord0;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
mat3 xll_constructMat3_mf4x4( mat4 m) {
  return mat3( vec3( m[0]), vec3( m[1]), vec3( m[2]));
}
#line 447
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 756
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 749
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 73
struct v2f {
    highp vec4 pos;
    highp vec2 uv_main;
    highp vec2 uv_bump;
    highp vec3 viewDir;
    highp vec3 T;
    highp vec3 B;
    highp vec3 N;
    mediump vec2 param;
    highp vec4 scrpos;
};
#line 66
struct input {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec2 uv_main;
};
#line 40
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
#line 46
uniform highp vec3 _WorldSpaceCameraPos;
#line 53
uniform highp vec4 _ProjectionParams;
#line 59
uniform highp vec4 _ScreenParams;
#line 71
uniform highp vec4 _ZBufferParams;
#line 77
uniform highp vec4 unity_OrthoParams;
#line 82
uniform highp vec4 unity_CameraWorldClipPlanes[6];
#line 88
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 unity_WorldToCamera;
uniform highp mat4 unity_CameraToWorld;
#line 104
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
#line 108
uniform highp vec4 _LightProjectionParams;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
#line 112
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
#line 118
uniform highp vec4 unity_LightPosition[8];
#line 123
uniform mediump vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
#line 127
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
#line 131
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
#line 136
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform lowp vec4 unity_ProbesOcclusion;
#line 141
uniform mediump vec3 unity_LightColor0;
uniform mediump vec3 unity_LightColor1;
uniform mediump vec3 unity_LightColor2;
uniform mediump vec3 unity_LightColor3;
#line 148
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 152
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 161
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_LODFade;
uniform highp vec4 unity_WorldTransformParams;
#line 202
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 210
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
#line 214
uniform lowp vec4 unity_IndirectSpecColor;
uniform highp mat4 glstate_matrix_projection;
#line 218
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp int unity_StereoEyeIndex;
#line 224
uniform lowp vec4 unity_ShadowColor;
#line 231
uniform lowp vec4 unity_FogColor;
#line 236
uniform highp vec4 unity_FogParams;
#line 244
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_LightmapInd;
#line 258
uniform sampler2D unity_DynamicLightmap;
uniform sampler2D unity_DynamicDirectionality;
uniform sampler2D unity_DynamicNormal;
#line 263
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
#line 271
uniform samplerCube unity_SpecCube0;
uniform samplerCube unity_SpecCube1;
#line 275
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
#line 280
uniform highp vec4 unity_SpecCube1_BoxMax;
uniform highp vec4 unity_SpecCube1_BoxMin;
uniform highp vec4 unity_SpecCube1_ProbePosition;
uniform mediump vec4 unity_SpecCube1_HDR;
#line 320
highp mat4 unity_MatrixMVP;
highp mat4 unity_MatrixMV;
highp mat4 unity_MatrixTMV;
highp mat4 unity_MatrixITMV;
#line 9
#line 14
#line 84
#line 93
#line 103
#line 112
#line 124
#line 135
#line 141
#line 147
#line 151
#line 157
#line 163
#line 169
#line 175
#line 186
#line 201
#line 208
#line 223
#line 230
#line 237
#line 255
#line 291
#line 320
#line 326
#line 339
#line 357
#line 373
#line 427
#line 453
#line 464
#line 473
#line 480
#line 485
#line 502
#line 522
#line 537
#line 543
#line 554
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 unity_DynamicLightmap_HDR;
#line 568
#line 578
#line 593
#line 602
#line 609
#line 618
#line 626
#line 635
#line 654
#line 660
#line 670
#line 680
#line 691
#line 696
#line 702
#line 707
#line 764
#line 770
#line 785
#line 816
#line 830
#line 834
#line 840
#line 849
#line 859
#line 885
#line 891
#line 8
#line 17
#line 29
#line 50
#line 91
#line 102
#line 114
#line 127
#line 133
#line 188
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
#line 202
#line 234
uniform highp mat4 _DITHERMATRIX;
#line 259
#line 91
uniform sampler2D _BumpTex;
uniform highp vec4 _BumpTex_ST;
uniform mediump vec4 _Color;
#line 95
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform samplerCube _RefractTex;
uniform mediump float _ReflectionStrength;
#line 99
uniform mediump float _Emission;
uniform mediump float _BumpScaler;
uniform mediump float _Opaqueness;
#line 103
uniform highp float _BloomFactor;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
#line 107
#line 785
highp vec4 ComputeNonStereoScreenPos( in highp vec4 pos ) {
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    #line 789
    return o;
}
#line 792
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 793
    highp vec4 o = ComputeNonStereoScreenPos( pos);
    #line 797
    return o;
}
#line 9
highp vec4 UnityObjectToClipPos( in highp vec3 pos ) {
    return (unity_MatrixVP * (unity_ObjectToWorld * vec4( pos, 1.0)));
}
#line 14
highp vec4 UnityObjectToClipPos( in highp vec4 pos ) {
    return UnityObjectToClipPos( pos.xyz);
}
#line 175
highp vec3 UnityObjectToWorldNormal( in highp vec3 norm ) {
    #line 181
    return normalize((norm * xll_constructMat3_mf4x4( unity_WorldToObject)));
}
#line 107
v2f vertBump( in input i ) {
    v2f o = v2f(vec4(0.0, 0.0, 0.0, 0.0), vec2(0.0, 0.0), vec2(0.0, 0.0), vec3(0.0, 0.0, 0.0), vec3(0.0, 0.0, 0.0), vec3(0.0, 0.0, 0.0), vec3(0.0, 0.0, 0.0), vec2(0.0, 0.0), vec4(0.0, 0.0, 0.0, 0.0));
    o.uv_main = i.uv_main;
    #line 111
    o.uv_bump = ((i.uv_main.xy * _BumpTex_ST.xy) + _BumpTex_ST.zw);
    mediump float alpha = 1.0;
    o.param.y = (alpha * _Opaqueness);
    #line 116
    highp vec4 objPos = (unity_ObjectToWorld * i.vertex);
    o.viewDir = normalize((_WorldSpaceCameraPos.xyz - objPos.xyz));
    o.pos = UnityObjectToClipPos( i.vertex);
    #line 120
    o.N = (-UnityObjectToWorldNormal( i.normal));
    o.T = vec3( o.N.y, (-o.N.x), 0.0);
    o.T = normalize(o.T);
    o.B = cross( o.N, o.T);
    #line 124
    o.B = normalize(o.B);
    if (bool(_UsingDitherAlpha)){
        #line 128
        o.scrpos = ComputeScreenPos( o.pos);
        o.scrpos.z = _DitherAlpha;
    }
    #line 132
    return o;
}
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main() {
unity_MatrixMVP = (unity_MatrixVP * unity_ObjectToWorld);
unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
unity_MatrixTMV = xll_transpose_mf4x4(unity_MatrixMV);
unity_MatrixITMV = xll_transpose_mf4x4((unity_WorldToObject * unity_MatrixInvV));
    v2f xl_retval;
    input xlt_i;
    xlt_i.vertex = vec4(gl_Vertex);
    xlt_i.normal = vec3(gl_Normal);
    xlt_i.uv_main = vec2(gl_MultiTexCoord0);
    xl_retval = vertBump( xlt_i);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec2(xl_retval.uv_main);
    xlv_TEXCOORD1 = vec2(xl_retval.uv_bump);
    xlv_TEXCOORD2 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD3 = vec3(xl_retval.T);
    xlv_TEXCOORD4 = vec3(xl_retval.B);
    xlv_TEXCOORD5 = vec3(xl_retval.N);
    xlv_COLOR1 = vec2(xl_retval.param);
    xlv_TEXCOORD6 = vec4(xl_retval.scrpos);
}
/* HLSL2GLSL - NOTE: GLSL optimization failed
(67,8): error: illegal use of reserved word `input'
(67,8): error: syntax error, unexpected ERROR_TOK, expecting IDENTIFIER or TYPE_IDENTIFIER or NEW_IDENTIFIER or '{'
*/

#endif
#ifdef FRAGMENT
#ifndef SHADER_TARGET
    #define SHADER_TARGET 25
#endif
#ifndef UNITY_NO_DXT5nm
    #define UNITY_NO_DXT5nm 1
#endif
#ifndef UNITY_NO_RGBM
    #define UNITY_NO_RGBM 1
#endif
#ifndef UNITY_ENABLE_REFLECTION_BUFFERS
    #define UNITY_ENABLE_REFLECTION_BUFFERS 1
#endif
#ifndef UNITY_FRAMEBUFFER_FETCH_AVAILABLE
    #define UNITY_FRAMEBUFFER_FETCH_AVAILABLE 1
#endif
#ifndef UNITY_NO_CUBEMAP_ARRAY
    #define UNITY_NO_CUBEMAP_ARRAY 1
#endif
#ifndef UNITY_NO_SCREENSPACE_SHADOWS
    #define UNITY_NO_SCREENSPACE_SHADOWS 1
#endif
#ifndef UNITY_PBS_USE_BRDF2
    #define UNITY_PBS_USE_BRDF2 1
#endif
#ifndef SHADER_API_MOBILE
    #define SHADER_API_MOBILE 1
#endif
#ifndef UNITY_HARDWARE_TIER3
    #define UNITY_HARDWARE_TIER3 1
#endif
#ifndef UNITY_COLORSPACE_GAMMA
    #define UNITY_COLORSPACE_GAMMA 1
#endif
#ifndef UNITY_LIGHTMAP_DLDR_ENCODING
    #define UNITY_LIGHTMAP_DLDR_ENCODING 1
#endif
#ifndef UNITY_VERSION
    #define UNITY_VERSION 201758
#endif
#ifndef SHADER_STAGE_VERTEX
    #define SHADER_STAGE_VERTEX 1
#endif
#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
float xll_mod_f_f( float x, float y ) {
  float d = x / y;
  float f = fract (abs(d)) * y;
  return d >= 0.0 ? f : -f;
}
vec2 xll_mod_vf2_vf2( vec2 x, vec2 y ) {
  vec2 d = x / y;
  vec2 f = fract (abs(d)) * y;
  return vec2 (d.x >= 0.0 ? f.x : -f.x, d.y >= 0.0 ? f.y : -f.y);
}
vec3 xll_mod_vf3_vf3( vec3 x, vec3 y ) {
  vec3 d = x / y;
  vec3 f = fract (abs(d)) * y;
  return vec3 (d.x >= 0.0 ? f.x : -f.x, d.y >= 0.0 ? f.y : -f.y, d.z >= 0.0 ? f.z : -f.z);
}
vec4 xll_mod_vf4_vf4( vec4 x, vec4 y ) {
  vec4 d = x / y;
  vec4 f = fract (abs(d)) * y;
  return vec4 (d.x >= 0.0 ? f.x : -f.x, d.y >= 0.0 ? f.y : -f.y, d.z >= 0.0 ? f.z : -f.z, d.w >= 0.0 ? f.w : -f.w);
}
void xll_clip_f(float x) {
  if ( x<0.0 ) discard;
}
void xll_clip_vf2(vec2 x) {
  if (any(lessThan(x,vec2(0.0)))) discard;
}
void xll_clip_vf3(vec3 x) {
  if (any(lessThan(x,vec3(0.0)))) discard;
}
void xll_clip_vf4(vec4 x) {
  if (any(lessThan(x,vec4(0.0)))) discard;
}
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 447
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 756
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 749
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 73
struct v2f {
    highp vec4 pos;
    highp vec2 uv_main;
    highp vec2 uv_bump;
    highp vec3 viewDir;
    highp vec3 T;
    highp vec3 B;
    highp vec3 N;
    mediump vec2 param;
    highp vec4 scrpos;
};
#line 66
struct input {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec2 uv_main;
};
#line 40
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
#line 46
uniform highp vec3 _WorldSpaceCameraPos;
#line 53
uniform highp vec4 _ProjectionParams;
#line 59
uniform highp vec4 _ScreenParams;
#line 71
uniform highp vec4 _ZBufferParams;
#line 77
uniform highp vec4 unity_OrthoParams;
#line 82
uniform highp vec4 unity_CameraWorldClipPlanes[6];
#line 88
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 unity_WorldToCamera;
uniform highp mat4 unity_CameraToWorld;
#line 104
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
#line 108
uniform highp vec4 _LightProjectionParams;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
#line 112
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
#line 118
uniform highp vec4 unity_LightPosition[8];
#line 123
uniform mediump vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
#line 127
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
#line 131
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
#line 136
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform lowp vec4 unity_ProbesOcclusion;
#line 141
uniform mediump vec3 unity_LightColor0;
uniform mediump vec3 unity_LightColor1;
uniform mediump vec3 unity_LightColor2;
uniform mediump vec3 unity_LightColor3;
#line 148
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 152
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 161
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_LODFade;
uniform highp vec4 unity_WorldTransformParams;
#line 202
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 210
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
#line 214
uniform lowp vec4 unity_IndirectSpecColor;
uniform highp mat4 glstate_matrix_projection;
#line 218
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp int unity_StereoEyeIndex;
#line 224
uniform lowp vec4 unity_ShadowColor;
#line 231
uniform lowp vec4 unity_FogColor;
#line 236
uniform highp vec4 unity_FogParams;
#line 244
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_LightmapInd;
#line 258
uniform sampler2D unity_DynamicLightmap;
uniform sampler2D unity_DynamicDirectionality;
uniform sampler2D unity_DynamicNormal;
#line 263
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
#line 271
uniform samplerCube unity_SpecCube0;
uniform samplerCube unity_SpecCube1;
#line 275
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
#line 280
uniform highp vec4 unity_SpecCube1_BoxMax;
uniform highp vec4 unity_SpecCube1_BoxMin;
uniform highp vec4 unity_SpecCube1_ProbePosition;
uniform mediump vec4 unity_SpecCube1_HDR;
#line 320
highp mat4 unity_MatrixMVP;
highp mat4 unity_MatrixMV;
highp mat4 unity_MatrixTMV;
highp mat4 unity_MatrixITMV;
#line 9
#line 14
#line 84
#line 93
#line 103
#line 112
#line 124
#line 135
#line 141
#line 147
#line 151
#line 157
#line 163
#line 169
#line 175
#line 186
#line 201
#line 208
#line 223
#line 230
#line 237
#line 255
#line 291
#line 320
#line 326
#line 339
#line 357
#line 373
#line 427
#line 453
#line 464
#line 473
#line 480
#line 485
#line 502
#line 522
#line 537
#line 543
#line 554
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 unity_DynamicLightmap_HDR;
#line 568
#line 578
#line 593
#line 602
#line 609
#line 618
#line 626
#line 635
#line 654
#line 660
#line 670
#line 680
#line 691
#line 696
#line 702
#line 707
#line 764
#line 770
#line 785
#line 816
#line 830
#line 834
#line 840
#line 849
#line 859
#line 885
#line 891
#line 8
#line 17
#line 29
#line 50
#line 91
#line 102
#line 114
#line 127
#line 133
#line 188
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
#line 202
#line 234
uniform highp mat4 _DITHERMATRIX;
#line 259
#line 91
uniform sampler2D _BumpTex;
uniform highp vec4 _BumpTex_ST;
uniform mediump vec4 _Color;
#line 95
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform samplerCube _RefractTex;
uniform mediump float _ReflectionStrength;
#line 99
uniform mediump float _Emission;
uniform mediump float _BumpScaler;
uniform mediump float _Opaqueness;
#line 103
uniform highp float _BloomFactor;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
#line 107
#line 235
void dither_clip( in highp vec4 scrpos, in mediump float a ) {
    if ((a < 0.95)){
        #line 239
        scrpos.xy = ((scrpos.xy / scrpos.w) * _ScreenParams.xy);
        a *= 17.0;
        highp float curA = _DITHERMATRIX[int(xll_mod_f_f( scrpos.y, 4.0))][int(xll_mod_f_f( scrpos.x, 4.0))];
        xll_clip_f(((a - curA) - 0.01));
    }
    #line 244
    return ;
}
#line 135
mediump vec4 fragBump( in v2f i ) {
    #line 137
    mediump vec4 outColor = vec4( 0.0);
    mediump vec3 baseTexColor = ((texture2D( _MainTex, i.uv_main.xy).xyz * _Color.xyz) * vec3( _EnvColor));
    #line 142
    highp vec3 bumpVector = (texture2D( _BumpTex, i.uv_bump.xy).xyz - vec3( 0.5, 0.5, 0.0));
    bumpVector.xy *= _BumpScaler;
    bumpVector = normalize(bumpVector);
    #line 146
    highp vec3 N = (((i.T * bumpVector.x) + (i.B * bumpVector.y)) + (i.N * bumpVector.z));
    highp vec3 V = normalize(i.viewDir);
    highp vec3 uv_refract = (-reflect( V, N));
    mediump vec3 refraction = (textureCube( _RefractTex, uv_refract).xyz * baseTexColor);
    #line 150
    mediump vec3 multiplier = ((vec3( 1.0, 1.0, 1.0) * _ReflectionStrength) + _Emission);
    outColor.xyz = (refraction.xyz * multiplier.xyz);
    outColor.w = i.param.y;
    #line 154
    if (bool(_UsingDitherAlpha)){
        dither_clip( i.scrpos, i.scrpos.z);
    }
    #line 158
    outColor.w = xll_saturate_f(outColor.w);
    return outColor;
}
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main() {
unity_MatrixMVP = (unity_MatrixVP * unity_ObjectToWorld);
unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
unity_MatrixTMV = xll_transpose_mf4x4(unity_MatrixMV);
unity_MatrixITMV = xll_transpose_mf4x4((unity_WorldToObject * unity_MatrixInvV));
    mediump vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.uv_main = vec2(xlv_TEXCOORD0);
    xlt_i.uv_bump = vec2(xlv_TEXCOORD1);
    xlt_i.viewDir = vec3(xlv_TEXCOORD2);
    xlt_i.T = vec3(xlv_TEXCOORD3);
    xlt_i.B = vec3(xlv_TEXCOORD4);
    xlt_i.N = vec3(xlv_TEXCOORD5);
    xlt_i.param = vec2(xlv_COLOR1);
    xlt_i.scrpos = vec4(xlv_TEXCOORD6);
    xl_retval = fragBump( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}
/* HLSL2GLSL - NOTE: GLSL optimization failed
(67,8): error: illegal use of reserved word `input'
(67,8): error: syntax error, unexpected ERROR_TOK, expecting IDENTIFIER or TYPE_IDENTIFIER or NEW_IDENTIFIER or '{'
*/

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
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "None" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 100036
Program "vp" {
SubProgram "gles " {
"#version 100

#ifdef VERTEX
#ifndef SHADER_TARGET
    #define SHADER_TARGET 25
#endif
#ifndef UNITY_NO_DXT5nm
    #define UNITY_NO_DXT5nm 1
#endif
#ifndef UNITY_NO_RGBM
    #define UNITY_NO_RGBM 1
#endif
#ifndef UNITY_ENABLE_REFLECTION_BUFFERS
    #define UNITY_ENABLE_REFLECTION_BUFFERS 1
#endif
#ifndef UNITY_FRAMEBUFFER_FETCH_AVAILABLE
    #define UNITY_FRAMEBUFFER_FETCH_AVAILABLE 1
#endif
#ifndef UNITY_NO_CUBEMAP_ARRAY
    #define UNITY_NO_CUBEMAP_ARRAY 1
#endif
#ifndef UNITY_NO_SCREENSPACE_SHADOWS
    #define UNITY_NO_SCREENSPACE_SHADOWS 1
#endif
#ifndef UNITY_PBS_USE_BRDF3
    #define UNITY_PBS_USE_BRDF3 1
#endif
#ifndef UNITY_NO_FULL_STANDARD_SHADER
    #define UNITY_NO_FULL_STANDARD_SHADER 1
#endif
#ifndef SHADER_API_MOBILE
    #define SHADER_API_MOBILE 1
#endif
#ifndef UNITY_HARDWARE_TIER1
    #define UNITY_HARDWARE_TIER1 1
#endif
#ifndef UNITY_COLORSPACE_GAMMA
    #define UNITY_COLORSPACE_GAMMA 1
#endif
#ifndef UNITY_LIGHTMAP_DLDR_ENCODING
    #define UNITY_LIGHTMAP_DLDR_ENCODING 1
#endif
#ifndef UNITY_VERSION
    #define UNITY_VERSION 201758
#endif
#ifndef SHADER_STAGE_VERTEX
    #define SHADER_STAGE_VERTEX 1
#endif
#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
#define gl_Vertex _glesVertex
attribute vec4 _glesVertex;
#define gl_Normal _glesNormal
attribute vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
attribute vec4 _glesMultiTexCoord0;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
mat3 xll_constructMat3_mf4x4( mat4 m) {
  return mat3( vec3( m[0]), vec3( m[1]), vec3( m[2]));
}
#line 447
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 756
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 749
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 186
struct v2f {
    highp vec4 pos;
    highp vec2 uv_main;
    highp vec2 uv_bump;
    highp vec3 viewDir;
    highp vec3 T;
    highp vec3 B;
    highp vec3 N;
    mediump vec2 param;
    highp vec4 scrpos;
};
#line 179
struct input {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec2 uv_main;
};
#line 40
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
#line 46
uniform highp vec3 _WorldSpaceCameraPos;
#line 53
uniform highp vec4 _ProjectionParams;
#line 59
uniform highp vec4 _ScreenParams;
#line 71
uniform highp vec4 _ZBufferParams;
#line 77
uniform highp vec4 unity_OrthoParams;
#line 82
uniform highp vec4 unity_CameraWorldClipPlanes[6];
#line 88
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 unity_WorldToCamera;
uniform highp mat4 unity_CameraToWorld;
#line 104
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
#line 108
uniform highp vec4 _LightProjectionParams;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
#line 112
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
#line 118
uniform highp vec4 unity_LightPosition[8];
#line 123
uniform mediump vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
#line 127
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
#line 131
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
#line 136
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform lowp vec4 unity_ProbesOcclusion;
#line 141
uniform mediump vec3 unity_LightColor0;
uniform mediump vec3 unity_LightColor1;
uniform mediump vec3 unity_LightColor2;
uniform mediump vec3 unity_LightColor3;
#line 148
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 152
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 161
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_LODFade;
uniform highp vec4 unity_WorldTransformParams;
#line 202
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 210
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
#line 214
uniform lowp vec4 unity_IndirectSpecColor;
uniform highp mat4 glstate_matrix_projection;
#line 218
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp int unity_StereoEyeIndex;
#line 224
uniform lowp vec4 unity_ShadowColor;
#line 231
uniform lowp vec4 unity_FogColor;
#line 236
uniform highp vec4 unity_FogParams;
#line 244
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_LightmapInd;
#line 258
uniform sampler2D unity_DynamicLightmap;
uniform sampler2D unity_DynamicDirectionality;
uniform sampler2D unity_DynamicNormal;
#line 263
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
#line 271
uniform samplerCube unity_SpecCube0;
uniform samplerCube unity_SpecCube1;
#line 275
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
#line 280
uniform highp vec4 unity_SpecCube1_BoxMax;
uniform highp vec4 unity_SpecCube1_BoxMin;
uniform highp vec4 unity_SpecCube1_ProbePosition;
uniform mediump vec4 unity_SpecCube1_HDR;
#line 320
highp mat4 unity_MatrixMVP;
highp mat4 unity_MatrixMV;
highp mat4 unity_MatrixTMV;
highp mat4 unity_MatrixITMV;
#line 9
#line 14
#line 84
#line 93
#line 103
#line 112
#line 124
#line 135
#line 141
#line 147
#line 151
#line 157
#line 163
#line 169
#line 175
#line 186
#line 201
#line 208
#line 223
#line 230
#line 237
#line 255
#line 291
#line 320
#line 326
#line 339
#line 357
#line 373
#line 427
#line 453
#line 464
#line 473
#line 480
#line 485
#line 502
#line 522
#line 537
#line 543
#line 554
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 unity_DynamicLightmap_HDR;
#line 568
#line 578
#line 593
#line 602
#line 609
#line 618
#line 626
#line 635
#line 654
#line 660
#line 670
#line 680
#line 691
#line 696
#line 702
#line 707
#line 764
#line 770
#line 785
#line 816
#line 830
#line 834
#line 840
#line 849
#line 859
#line 885
#line 891
#line 8
#line 17
#line 29
#line 50
#line 91
#line 102
#line 114
#line 127
#line 133
#line 188
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
#line 202
#line 234
uniform highp mat4 _DITHERMATRIX;
#line 259
#line 203
uniform sampler2D _BumpTex;
uniform highp vec4 _BumpTex_ST;
uniform mediump vec4 _Color;
#line 207
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform samplerCube _RefractTex;
uniform mediump float _ReflectionStrength;
#line 211
uniform mediump float _Emission;
uniform mediump float _BumpScaler;
uniform mediump float _Opaqueness;
#line 215
uniform highp float _BloomFactor;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
#line 219
#line 785
highp vec4 ComputeNonStereoScreenPos( in highp vec4 pos ) {
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    #line 789
    return o;
}
#line 792
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 793
    highp vec4 o = ComputeNonStereoScreenPos( pos);
    #line 797
    return o;
}
#line 9
highp vec4 UnityObjectToClipPos( in highp vec3 pos ) {
    return (unity_MatrixVP * (unity_ObjectToWorld * vec4( pos, 1.0)));
}
#line 14
highp vec4 UnityObjectToClipPos( in highp vec4 pos ) {
    return UnityObjectToClipPos( pos.xyz);
}
#line 175
highp vec3 UnityObjectToWorldNormal( in highp vec3 norm ) {
    #line 181
    return normalize((norm * xll_constructMat3_mf4x4( unity_WorldToObject)));
}
#line 219
v2f vertBump( in input i ) {
    v2f o = v2f(vec4(0.0, 0.0, 0.0, 0.0), vec2(0.0, 0.0), vec2(0.0, 0.0), vec3(0.0, 0.0, 0.0), vec3(0.0, 0.0, 0.0), vec3(0.0, 0.0, 0.0), vec3(0.0, 0.0, 0.0), vec2(0.0, 0.0), vec4(0.0, 0.0, 0.0, 0.0));
    o.uv_main = i.uv_main;
    #line 223
    o.uv_bump = ((i.uv_main.xy * _BumpTex_ST.xy) + _BumpTex_ST.zw);
    mediump float alpha = 1.0;
    o.param.y = (alpha * _Opaqueness);
    #line 228
    highp vec4 objPos = (unity_ObjectToWorld * i.vertex);
    o.viewDir = normalize((_WorldSpaceCameraPos.xyz - objPos.xyz));
    o.pos = UnityObjectToClipPos( i.vertex);
    #line 232
    o.N = (-UnityObjectToWorldNormal( i.normal));
    o.T = vec3( o.N.y, (-o.N.x), 0.0);
    o.T = normalize(o.T);
    o.B = cross( o.N, o.T);
    #line 236
    o.B = normalize(o.B);
    if (bool(_UsingDitherAlpha)){
        #line 240
        o.scrpos = ComputeScreenPos( o.pos);
        o.scrpos.z = _DitherAlpha;
    }
    #line 244
    return o;
}
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main() {
unity_MatrixMVP = (unity_MatrixVP * unity_ObjectToWorld);
unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
unity_MatrixTMV = xll_transpose_mf4x4(unity_MatrixMV);
unity_MatrixITMV = xll_transpose_mf4x4((unity_WorldToObject * unity_MatrixInvV));
    v2f xl_retval;
    input xlt_i;
    xlt_i.vertex = vec4(gl_Vertex);
    xlt_i.normal = vec3(gl_Normal);
    xlt_i.uv_main = vec2(gl_MultiTexCoord0);
    xl_retval = vertBump( xlt_i);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec2(xl_retval.uv_main);
    xlv_TEXCOORD1 = vec2(xl_retval.uv_bump);
    xlv_TEXCOORD2 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD3 = vec3(xl_retval.T);
    xlv_TEXCOORD4 = vec3(xl_retval.B);
    xlv_TEXCOORD5 = vec3(xl_retval.N);
    xlv_COLOR1 = vec2(xl_retval.param);
    xlv_TEXCOORD6 = vec4(xl_retval.scrpos);
}
/* HLSL2GLSL - NOTE: GLSL optimization failed
(180,8): error: illegal use of reserved word `input'
(180,8): error: syntax error, unexpected ERROR_TOK, expecting IDENTIFIER or TYPE_IDENTIFIER or NEW_IDENTIFIER or '{'
*/

#endif
#ifdef FRAGMENT
#ifndef SHADER_TARGET
    #define SHADER_TARGET 25
#endif
#ifndef UNITY_NO_DXT5nm
    #define UNITY_NO_DXT5nm 1
#endif
#ifndef UNITY_NO_RGBM
    #define UNITY_NO_RGBM 1
#endif
#ifndef UNITY_ENABLE_REFLECTION_BUFFERS
    #define UNITY_ENABLE_REFLECTION_BUFFERS 1
#endif
#ifndef UNITY_FRAMEBUFFER_FETCH_AVAILABLE
    #define UNITY_FRAMEBUFFER_FETCH_AVAILABLE 1
#endif
#ifndef UNITY_NO_CUBEMAP_ARRAY
    #define UNITY_NO_CUBEMAP_ARRAY 1
#endif
#ifndef UNITY_NO_SCREENSPACE_SHADOWS
    #define UNITY_NO_SCREENSPACE_SHADOWS 1
#endif
#ifndef UNITY_PBS_USE_BRDF3
    #define UNITY_PBS_USE_BRDF3 1
#endif
#ifndef UNITY_NO_FULL_STANDARD_SHADER
    #define UNITY_NO_FULL_STANDARD_SHADER 1
#endif
#ifndef SHADER_API_MOBILE
    #define SHADER_API_MOBILE 1
#endif
#ifndef UNITY_HARDWARE_TIER1
    #define UNITY_HARDWARE_TIER1 1
#endif
#ifndef UNITY_COLORSPACE_GAMMA
    #define UNITY_COLORSPACE_GAMMA 1
#endif
#ifndef UNITY_LIGHTMAP_DLDR_ENCODING
    #define UNITY_LIGHTMAP_DLDR_ENCODING 1
#endif
#ifndef UNITY_VERSION
    #define UNITY_VERSION 201758
#endif
#ifndef SHADER_STAGE_VERTEX
    #define SHADER_STAGE_VERTEX 1
#endif
#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
float xll_mod_f_f( float x, float y ) {
  float d = x / y;
  float f = fract (abs(d)) * y;
  return d >= 0.0 ? f : -f;
}
vec2 xll_mod_vf2_vf2( vec2 x, vec2 y ) {
  vec2 d = x / y;
  vec2 f = fract (abs(d)) * y;
  return vec2 (d.x >= 0.0 ? f.x : -f.x, d.y >= 0.0 ? f.y : -f.y);
}
vec3 xll_mod_vf3_vf3( vec3 x, vec3 y ) {
  vec3 d = x / y;
  vec3 f = fract (abs(d)) * y;
  return vec3 (d.x >= 0.0 ? f.x : -f.x, d.y >= 0.0 ? f.y : -f.y, d.z >= 0.0 ? f.z : -f.z);
}
vec4 xll_mod_vf4_vf4( vec4 x, vec4 y ) {
  vec4 d = x / y;
  vec4 f = fract (abs(d)) * y;
  return vec4 (d.x >= 0.0 ? f.x : -f.x, d.y >= 0.0 ? f.y : -f.y, d.z >= 0.0 ? f.z : -f.z, d.w >= 0.0 ? f.w : -f.w);
}
void xll_clip_f(float x) {
  if ( x<0.0 ) discard;
}
void xll_clip_vf2(vec2 x) {
  if (any(lessThan(x,vec2(0.0)))) discard;
}
void xll_clip_vf3(vec3 x) {
  if (any(lessThan(x,vec3(0.0)))) discard;
}
void xll_clip_vf4(vec4 x) {
  if (any(lessThan(x,vec4(0.0)))) discard;
}
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 447
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 756
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 749
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 186
struct v2f {
    highp vec4 pos;
    highp vec2 uv_main;
    highp vec2 uv_bump;
    highp vec3 viewDir;
    highp vec3 T;
    highp vec3 B;
    highp vec3 N;
    mediump vec2 param;
    highp vec4 scrpos;
};
#line 179
struct input {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec2 uv_main;
};
#line 40
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
#line 46
uniform highp vec3 _WorldSpaceCameraPos;
#line 53
uniform highp vec4 _ProjectionParams;
#line 59
uniform highp vec4 _ScreenParams;
#line 71
uniform highp vec4 _ZBufferParams;
#line 77
uniform highp vec4 unity_OrthoParams;
#line 82
uniform highp vec4 unity_CameraWorldClipPlanes[6];
#line 88
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 unity_WorldToCamera;
uniform highp mat4 unity_CameraToWorld;
#line 104
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
#line 108
uniform highp vec4 _LightProjectionParams;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
#line 112
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
#line 118
uniform highp vec4 unity_LightPosition[8];
#line 123
uniform mediump vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
#line 127
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
#line 131
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
#line 136
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform lowp vec4 unity_ProbesOcclusion;
#line 141
uniform mediump vec3 unity_LightColor0;
uniform mediump vec3 unity_LightColor1;
uniform mediump vec3 unity_LightColor2;
uniform mediump vec3 unity_LightColor3;
#line 148
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 152
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 161
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_LODFade;
uniform highp vec4 unity_WorldTransformParams;
#line 202
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 210
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
#line 214
uniform lowp vec4 unity_IndirectSpecColor;
uniform highp mat4 glstate_matrix_projection;
#line 218
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp int unity_StereoEyeIndex;
#line 224
uniform lowp vec4 unity_ShadowColor;
#line 231
uniform lowp vec4 unity_FogColor;
#line 236
uniform highp vec4 unity_FogParams;
#line 244
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_LightmapInd;
#line 258
uniform sampler2D unity_DynamicLightmap;
uniform sampler2D unity_DynamicDirectionality;
uniform sampler2D unity_DynamicNormal;
#line 263
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
#line 271
uniform samplerCube unity_SpecCube0;
uniform samplerCube unity_SpecCube1;
#line 275
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
#line 280
uniform highp vec4 unity_SpecCube1_BoxMax;
uniform highp vec4 unity_SpecCube1_BoxMin;
uniform highp vec4 unity_SpecCube1_ProbePosition;
uniform mediump vec4 unity_SpecCube1_HDR;
#line 320
highp mat4 unity_MatrixMVP;
highp mat4 unity_MatrixMV;
highp mat4 unity_MatrixTMV;
highp mat4 unity_MatrixITMV;
#line 9
#line 14
#line 84
#line 93
#line 103
#line 112
#line 124
#line 135
#line 141
#line 147
#line 151
#line 157
#line 163
#line 169
#line 175
#line 186
#line 201
#line 208
#line 223
#line 230
#line 237
#line 255
#line 291
#line 320
#line 326
#line 339
#line 357
#line 373
#line 427
#line 453
#line 464
#line 473
#line 480
#line 485
#line 502
#line 522
#line 537
#line 543
#line 554
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 unity_DynamicLightmap_HDR;
#line 568
#line 578
#line 593
#line 602
#line 609
#line 618
#line 626
#line 635
#line 654
#line 660
#line 670
#line 680
#line 691
#line 696
#line 702
#line 707
#line 764
#line 770
#line 785
#line 816
#line 830
#line 834
#line 840
#line 849
#line 859
#line 885
#line 891
#line 8
#line 17
#line 29
#line 50
#line 91
#line 102
#line 114
#line 127
#line 133
#line 188
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
#line 202
#line 234
uniform highp mat4 _DITHERMATRIX;
#line 259
#line 203
uniform sampler2D _BumpTex;
uniform highp vec4 _BumpTex_ST;
uniform mediump vec4 _Color;
#line 207
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform samplerCube _RefractTex;
uniform mediump float _ReflectionStrength;
#line 211
uniform mediump float _Emission;
uniform mediump float _BumpScaler;
uniform mediump float _Opaqueness;
#line 215
uniform highp float _BloomFactor;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
#line 219
#line 235
void dither_clip( in highp vec4 scrpos, in mediump float a ) {
    if ((a < 0.95)){
        #line 239
        scrpos.xy = ((scrpos.xy / scrpos.w) * _ScreenParams.xy);
        a *= 17.0;
        highp float curA = _DITHERMATRIX[int(xll_mod_f_f( scrpos.y, 4.0))][int(xll_mod_f_f( scrpos.x, 4.0))];
        xll_clip_f(((a - curA) - 0.01));
    }
    #line 244
    return ;
}
#line 247
mediump vec4 fragBump( in v2f i ) {
    #line 249
    mediump vec4 outColor = vec4( 0.0);
    mediump vec3 baseTexColor = ((texture2D( _MainTex, i.uv_main.xy).xyz * _Color.xyz) * vec3( _EnvColor));
    #line 254
    highp vec3 bumpVector = (texture2D( _BumpTex, i.uv_bump.xy).xyz - vec3( 0.5, 0.5, 0.0));
    bumpVector.xy *= _BumpScaler;
    bumpVector = normalize(bumpVector);
    #line 258
    highp vec3 N = (((i.T * bumpVector.x) + (i.B * bumpVector.y)) + (i.N * bumpVector.z));
    highp vec3 V = normalize(i.viewDir);
    highp vec3 uv_refract = (-reflect( V, N));
    mediump vec3 refraction = (textureCube( _RefractTex, uv_refract).xyz * baseTexColor);
    #line 262
    mediump vec3 multiplier = ((vec3( 1.0, 1.0, 1.0) * _ReflectionStrength) + _Emission);
    outColor.xyz = (refraction.xyz * multiplier.xyz);
    outColor.w = i.param.y;
    #line 266
    if (bool(_UsingDitherAlpha)){
        dither_clip( i.scrpos, i.scrpos.z);
    }
    #line 270
    outColor.w = xll_saturate_f(outColor.w);
    return outColor;
}
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main() {
unity_MatrixMVP = (unity_MatrixVP * unity_ObjectToWorld);
unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
unity_MatrixTMV = xll_transpose_mf4x4(unity_MatrixMV);
unity_MatrixITMV = xll_transpose_mf4x4((unity_WorldToObject * unity_MatrixInvV));
    mediump vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.uv_main = vec2(xlv_TEXCOORD0);
    xlt_i.uv_bump = vec2(xlv_TEXCOORD1);
    xlt_i.viewDir = vec3(xlv_TEXCOORD2);
    xlt_i.T = vec3(xlv_TEXCOORD3);
    xlt_i.B = vec3(xlv_TEXCOORD4);
    xlt_i.N = vec3(xlv_TEXCOORD5);
    xlt_i.param = vec2(xlv_COLOR1);
    xlt_i.scrpos = vec4(xlv_TEXCOORD6);
    xl_retval = fragBump( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}
/* HLSL2GLSL - NOTE: GLSL optimization failed
(180,8): error: illegal use of reserved word `input'
(180,8): error: syntax error, unexpected ERROR_TOK, expecting IDENTIFIER or TYPE_IDENTIFIER or NEW_IDENTIFIER or '{'
*/

#endif
"
}
SubProgram "gles " {
"#version 100

#ifdef VERTEX
#ifndef SHADER_TARGET
    #define SHADER_TARGET 25
#endif
#ifndef UNITY_NO_DXT5nm
    #define UNITY_NO_DXT5nm 1
#endif
#ifndef UNITY_NO_RGBM
    #define UNITY_NO_RGBM 1
#endif
#ifndef UNITY_ENABLE_REFLECTION_BUFFERS
    #define UNITY_ENABLE_REFLECTION_BUFFERS 1
#endif
#ifndef UNITY_FRAMEBUFFER_FETCH_AVAILABLE
    #define UNITY_FRAMEBUFFER_FETCH_AVAILABLE 1
#endif
#ifndef UNITY_NO_CUBEMAP_ARRAY
    #define UNITY_NO_CUBEMAP_ARRAY 1
#endif
#ifndef UNITY_NO_SCREENSPACE_SHADOWS
    #define UNITY_NO_SCREENSPACE_SHADOWS 1
#endif
#ifndef UNITY_PBS_USE_BRDF2
    #define UNITY_PBS_USE_BRDF2 1
#endif
#ifndef SHADER_API_MOBILE
    #define SHADER_API_MOBILE 1
#endif
#ifndef UNITY_HARDWARE_TIER2
    #define UNITY_HARDWARE_TIER2 1
#endif
#ifndef UNITY_COLORSPACE_GAMMA
    #define UNITY_COLORSPACE_GAMMA 1
#endif
#ifndef UNITY_LIGHTMAP_DLDR_ENCODING
    #define UNITY_LIGHTMAP_DLDR_ENCODING 1
#endif
#ifndef UNITY_VERSION
    #define UNITY_VERSION 201758
#endif
#ifndef SHADER_STAGE_VERTEX
    #define SHADER_STAGE_VERTEX 1
#endif
#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
#define gl_Vertex _glesVertex
attribute vec4 _glesVertex;
#define gl_Normal _glesNormal
attribute vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
attribute vec4 _glesMultiTexCoord0;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
mat3 xll_constructMat3_mf4x4( mat4 m) {
  return mat3( vec3( m[0]), vec3( m[1]), vec3( m[2]));
}
#line 447
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 756
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 749
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 186
struct v2f {
    highp vec4 pos;
    highp vec2 uv_main;
    highp vec2 uv_bump;
    highp vec3 viewDir;
    highp vec3 T;
    highp vec3 B;
    highp vec3 N;
    mediump vec2 param;
    highp vec4 scrpos;
};
#line 179
struct input {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec2 uv_main;
};
#line 40
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
#line 46
uniform highp vec3 _WorldSpaceCameraPos;
#line 53
uniform highp vec4 _ProjectionParams;
#line 59
uniform highp vec4 _ScreenParams;
#line 71
uniform highp vec4 _ZBufferParams;
#line 77
uniform highp vec4 unity_OrthoParams;
#line 82
uniform highp vec4 unity_CameraWorldClipPlanes[6];
#line 88
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 unity_WorldToCamera;
uniform highp mat4 unity_CameraToWorld;
#line 104
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
#line 108
uniform highp vec4 _LightProjectionParams;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
#line 112
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
#line 118
uniform highp vec4 unity_LightPosition[8];
#line 123
uniform mediump vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
#line 127
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
#line 131
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
#line 136
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform lowp vec4 unity_ProbesOcclusion;
#line 141
uniform mediump vec3 unity_LightColor0;
uniform mediump vec3 unity_LightColor1;
uniform mediump vec3 unity_LightColor2;
uniform mediump vec3 unity_LightColor3;
#line 148
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 152
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 161
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_LODFade;
uniform highp vec4 unity_WorldTransformParams;
#line 202
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 210
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
#line 214
uniform lowp vec4 unity_IndirectSpecColor;
uniform highp mat4 glstate_matrix_projection;
#line 218
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp int unity_StereoEyeIndex;
#line 224
uniform lowp vec4 unity_ShadowColor;
#line 231
uniform lowp vec4 unity_FogColor;
#line 236
uniform highp vec4 unity_FogParams;
#line 244
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_LightmapInd;
#line 258
uniform sampler2D unity_DynamicLightmap;
uniform sampler2D unity_DynamicDirectionality;
uniform sampler2D unity_DynamicNormal;
#line 263
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
#line 271
uniform samplerCube unity_SpecCube0;
uniform samplerCube unity_SpecCube1;
#line 275
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
#line 280
uniform highp vec4 unity_SpecCube1_BoxMax;
uniform highp vec4 unity_SpecCube1_BoxMin;
uniform highp vec4 unity_SpecCube1_ProbePosition;
uniform mediump vec4 unity_SpecCube1_HDR;
#line 320
highp mat4 unity_MatrixMVP;
highp mat4 unity_MatrixMV;
highp mat4 unity_MatrixTMV;
highp mat4 unity_MatrixITMV;
#line 9
#line 14
#line 84
#line 93
#line 103
#line 112
#line 124
#line 135
#line 141
#line 147
#line 151
#line 157
#line 163
#line 169
#line 175
#line 186
#line 201
#line 208
#line 223
#line 230
#line 237
#line 255
#line 291
#line 320
#line 326
#line 339
#line 357
#line 373
#line 427
#line 453
#line 464
#line 473
#line 480
#line 485
#line 502
#line 522
#line 537
#line 543
#line 554
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 unity_DynamicLightmap_HDR;
#line 568
#line 578
#line 593
#line 602
#line 609
#line 618
#line 626
#line 635
#line 654
#line 660
#line 670
#line 680
#line 691
#line 696
#line 702
#line 707
#line 764
#line 770
#line 785
#line 816
#line 830
#line 834
#line 840
#line 849
#line 859
#line 885
#line 891
#line 8
#line 17
#line 29
#line 50
#line 91
#line 102
#line 114
#line 127
#line 133
#line 188
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
#line 202
#line 234
uniform highp mat4 _DITHERMATRIX;
#line 259
#line 203
uniform sampler2D _BumpTex;
uniform highp vec4 _BumpTex_ST;
uniform mediump vec4 _Color;
#line 207
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform samplerCube _RefractTex;
uniform mediump float _ReflectionStrength;
#line 211
uniform mediump float _Emission;
uniform mediump float _BumpScaler;
uniform mediump float _Opaqueness;
#line 215
uniform highp float _BloomFactor;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
#line 219
#line 785
highp vec4 ComputeNonStereoScreenPos( in highp vec4 pos ) {
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    #line 789
    return o;
}
#line 792
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 793
    highp vec4 o = ComputeNonStereoScreenPos( pos);
    #line 797
    return o;
}
#line 9
highp vec4 UnityObjectToClipPos( in highp vec3 pos ) {
    return (unity_MatrixVP * (unity_ObjectToWorld * vec4( pos, 1.0)));
}
#line 14
highp vec4 UnityObjectToClipPos( in highp vec4 pos ) {
    return UnityObjectToClipPos( pos.xyz);
}
#line 175
highp vec3 UnityObjectToWorldNormal( in highp vec3 norm ) {
    #line 181
    return normalize((norm * xll_constructMat3_mf4x4( unity_WorldToObject)));
}
#line 219
v2f vertBump( in input i ) {
    v2f o = v2f(vec4(0.0, 0.0, 0.0, 0.0), vec2(0.0, 0.0), vec2(0.0, 0.0), vec3(0.0, 0.0, 0.0), vec3(0.0, 0.0, 0.0), vec3(0.0, 0.0, 0.0), vec3(0.0, 0.0, 0.0), vec2(0.0, 0.0), vec4(0.0, 0.0, 0.0, 0.0));
    o.uv_main = i.uv_main;
    #line 223
    o.uv_bump = ((i.uv_main.xy * _BumpTex_ST.xy) + _BumpTex_ST.zw);
    mediump float alpha = 1.0;
    o.param.y = (alpha * _Opaqueness);
    #line 228
    highp vec4 objPos = (unity_ObjectToWorld * i.vertex);
    o.viewDir = normalize((_WorldSpaceCameraPos.xyz - objPos.xyz));
    o.pos = UnityObjectToClipPos( i.vertex);
    #line 232
    o.N = (-UnityObjectToWorldNormal( i.normal));
    o.T = vec3( o.N.y, (-o.N.x), 0.0);
    o.T = normalize(o.T);
    o.B = cross( o.N, o.T);
    #line 236
    o.B = normalize(o.B);
    if (bool(_UsingDitherAlpha)){
        #line 240
        o.scrpos = ComputeScreenPos( o.pos);
        o.scrpos.z = _DitherAlpha;
    }
    #line 244
    return o;
}
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main() {
unity_MatrixMVP = (unity_MatrixVP * unity_ObjectToWorld);
unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
unity_MatrixTMV = xll_transpose_mf4x4(unity_MatrixMV);
unity_MatrixITMV = xll_transpose_mf4x4((unity_WorldToObject * unity_MatrixInvV));
    v2f xl_retval;
    input xlt_i;
    xlt_i.vertex = vec4(gl_Vertex);
    xlt_i.normal = vec3(gl_Normal);
    xlt_i.uv_main = vec2(gl_MultiTexCoord0);
    xl_retval = vertBump( xlt_i);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec2(xl_retval.uv_main);
    xlv_TEXCOORD1 = vec2(xl_retval.uv_bump);
    xlv_TEXCOORD2 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD3 = vec3(xl_retval.T);
    xlv_TEXCOORD4 = vec3(xl_retval.B);
    xlv_TEXCOORD5 = vec3(xl_retval.N);
    xlv_COLOR1 = vec2(xl_retval.param);
    xlv_TEXCOORD6 = vec4(xl_retval.scrpos);
}
/* HLSL2GLSL - NOTE: GLSL optimization failed
(180,8): error: illegal use of reserved word `input'
(180,8): error: syntax error, unexpected ERROR_TOK, expecting IDENTIFIER or TYPE_IDENTIFIER or NEW_IDENTIFIER or '{'
*/

#endif
#ifdef FRAGMENT
#ifndef SHADER_TARGET
    #define SHADER_TARGET 25
#endif
#ifndef UNITY_NO_DXT5nm
    #define UNITY_NO_DXT5nm 1
#endif
#ifndef UNITY_NO_RGBM
    #define UNITY_NO_RGBM 1
#endif
#ifndef UNITY_ENABLE_REFLECTION_BUFFERS
    #define UNITY_ENABLE_REFLECTION_BUFFERS 1
#endif
#ifndef UNITY_FRAMEBUFFER_FETCH_AVAILABLE
    #define UNITY_FRAMEBUFFER_FETCH_AVAILABLE 1
#endif
#ifndef UNITY_NO_CUBEMAP_ARRAY
    #define UNITY_NO_CUBEMAP_ARRAY 1
#endif
#ifndef UNITY_NO_SCREENSPACE_SHADOWS
    #define UNITY_NO_SCREENSPACE_SHADOWS 1
#endif
#ifndef UNITY_PBS_USE_BRDF2
    #define UNITY_PBS_USE_BRDF2 1
#endif
#ifndef SHADER_API_MOBILE
    #define SHADER_API_MOBILE 1
#endif
#ifndef UNITY_HARDWARE_TIER2
    #define UNITY_HARDWARE_TIER2 1
#endif
#ifndef UNITY_COLORSPACE_GAMMA
    #define UNITY_COLORSPACE_GAMMA 1
#endif
#ifndef UNITY_LIGHTMAP_DLDR_ENCODING
    #define UNITY_LIGHTMAP_DLDR_ENCODING 1
#endif
#ifndef UNITY_VERSION
    #define UNITY_VERSION 201758
#endif
#ifndef SHADER_STAGE_VERTEX
    #define SHADER_STAGE_VERTEX 1
#endif
#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
float xll_mod_f_f( float x, float y ) {
  float d = x / y;
  float f = fract (abs(d)) * y;
  return d >= 0.0 ? f : -f;
}
vec2 xll_mod_vf2_vf2( vec2 x, vec2 y ) {
  vec2 d = x / y;
  vec2 f = fract (abs(d)) * y;
  return vec2 (d.x >= 0.0 ? f.x : -f.x, d.y >= 0.0 ? f.y : -f.y);
}
vec3 xll_mod_vf3_vf3( vec3 x, vec3 y ) {
  vec3 d = x / y;
  vec3 f = fract (abs(d)) * y;
  return vec3 (d.x >= 0.0 ? f.x : -f.x, d.y >= 0.0 ? f.y : -f.y, d.z >= 0.0 ? f.z : -f.z);
}
vec4 xll_mod_vf4_vf4( vec4 x, vec4 y ) {
  vec4 d = x / y;
  vec4 f = fract (abs(d)) * y;
  return vec4 (d.x >= 0.0 ? f.x : -f.x, d.y >= 0.0 ? f.y : -f.y, d.z >= 0.0 ? f.z : -f.z, d.w >= 0.0 ? f.w : -f.w);
}
void xll_clip_f(float x) {
  if ( x<0.0 ) discard;
}
void xll_clip_vf2(vec2 x) {
  if (any(lessThan(x,vec2(0.0)))) discard;
}
void xll_clip_vf3(vec3 x) {
  if (any(lessThan(x,vec3(0.0)))) discard;
}
void xll_clip_vf4(vec4 x) {
  if (any(lessThan(x,vec4(0.0)))) discard;
}
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 447
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 756
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 749
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 186
struct v2f {
    highp vec4 pos;
    highp vec2 uv_main;
    highp vec2 uv_bump;
    highp vec3 viewDir;
    highp vec3 T;
    highp vec3 B;
    highp vec3 N;
    mediump vec2 param;
    highp vec4 scrpos;
};
#line 179
struct input {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec2 uv_main;
};
#line 40
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
#line 46
uniform highp vec3 _WorldSpaceCameraPos;
#line 53
uniform highp vec4 _ProjectionParams;
#line 59
uniform highp vec4 _ScreenParams;
#line 71
uniform highp vec4 _ZBufferParams;
#line 77
uniform highp vec4 unity_OrthoParams;
#line 82
uniform highp vec4 unity_CameraWorldClipPlanes[6];
#line 88
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 unity_WorldToCamera;
uniform highp mat4 unity_CameraToWorld;
#line 104
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
#line 108
uniform highp vec4 _LightProjectionParams;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
#line 112
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
#line 118
uniform highp vec4 unity_LightPosition[8];
#line 123
uniform mediump vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
#line 127
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
#line 131
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
#line 136
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform lowp vec4 unity_ProbesOcclusion;
#line 141
uniform mediump vec3 unity_LightColor0;
uniform mediump vec3 unity_LightColor1;
uniform mediump vec3 unity_LightColor2;
uniform mediump vec3 unity_LightColor3;
#line 148
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 152
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 161
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_LODFade;
uniform highp vec4 unity_WorldTransformParams;
#line 202
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 210
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
#line 214
uniform lowp vec4 unity_IndirectSpecColor;
uniform highp mat4 glstate_matrix_projection;
#line 218
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp int unity_StereoEyeIndex;
#line 224
uniform lowp vec4 unity_ShadowColor;
#line 231
uniform lowp vec4 unity_FogColor;
#line 236
uniform highp vec4 unity_FogParams;
#line 244
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_LightmapInd;
#line 258
uniform sampler2D unity_DynamicLightmap;
uniform sampler2D unity_DynamicDirectionality;
uniform sampler2D unity_DynamicNormal;
#line 263
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
#line 271
uniform samplerCube unity_SpecCube0;
uniform samplerCube unity_SpecCube1;
#line 275
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
#line 280
uniform highp vec4 unity_SpecCube1_BoxMax;
uniform highp vec4 unity_SpecCube1_BoxMin;
uniform highp vec4 unity_SpecCube1_ProbePosition;
uniform mediump vec4 unity_SpecCube1_HDR;
#line 320
highp mat4 unity_MatrixMVP;
highp mat4 unity_MatrixMV;
highp mat4 unity_MatrixTMV;
highp mat4 unity_MatrixITMV;
#line 9
#line 14
#line 84
#line 93
#line 103
#line 112
#line 124
#line 135
#line 141
#line 147
#line 151
#line 157
#line 163
#line 169
#line 175
#line 186
#line 201
#line 208
#line 223
#line 230
#line 237
#line 255
#line 291
#line 320
#line 326
#line 339
#line 357
#line 373
#line 427
#line 453
#line 464
#line 473
#line 480
#line 485
#line 502
#line 522
#line 537
#line 543
#line 554
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 unity_DynamicLightmap_HDR;
#line 568
#line 578
#line 593
#line 602
#line 609
#line 618
#line 626
#line 635
#line 654
#line 660
#line 670
#line 680
#line 691
#line 696
#line 702
#line 707
#line 764
#line 770
#line 785
#line 816
#line 830
#line 834
#line 840
#line 849
#line 859
#line 885
#line 891
#line 8
#line 17
#line 29
#line 50
#line 91
#line 102
#line 114
#line 127
#line 133
#line 188
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
#line 202
#line 234
uniform highp mat4 _DITHERMATRIX;
#line 259
#line 203
uniform sampler2D _BumpTex;
uniform highp vec4 _BumpTex_ST;
uniform mediump vec4 _Color;
#line 207
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform samplerCube _RefractTex;
uniform mediump float _ReflectionStrength;
#line 211
uniform mediump float _Emission;
uniform mediump float _BumpScaler;
uniform mediump float _Opaqueness;
#line 215
uniform highp float _BloomFactor;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
#line 219
#line 235
void dither_clip( in highp vec4 scrpos, in mediump float a ) {
    if ((a < 0.95)){
        #line 239
        scrpos.xy = ((scrpos.xy / scrpos.w) * _ScreenParams.xy);
        a *= 17.0;
        highp float curA = _DITHERMATRIX[int(xll_mod_f_f( scrpos.y, 4.0))][int(xll_mod_f_f( scrpos.x, 4.0))];
        xll_clip_f(((a - curA) - 0.01));
    }
    #line 244
    return ;
}
#line 247
mediump vec4 fragBump( in v2f i ) {
    #line 249
    mediump vec4 outColor = vec4( 0.0);
    mediump vec3 baseTexColor = ((texture2D( _MainTex, i.uv_main.xy).xyz * _Color.xyz) * vec3( _EnvColor));
    #line 254
    highp vec3 bumpVector = (texture2D( _BumpTex, i.uv_bump.xy).xyz - vec3( 0.5, 0.5, 0.0));
    bumpVector.xy *= _BumpScaler;
    bumpVector = normalize(bumpVector);
    #line 258
    highp vec3 N = (((i.T * bumpVector.x) + (i.B * bumpVector.y)) + (i.N * bumpVector.z));
    highp vec3 V = normalize(i.viewDir);
    highp vec3 uv_refract = (-reflect( V, N));
    mediump vec3 refraction = (textureCube( _RefractTex, uv_refract).xyz * baseTexColor);
    #line 262
    mediump vec3 multiplier = ((vec3( 1.0, 1.0, 1.0) * _ReflectionStrength) + _Emission);
    outColor.xyz = (refraction.xyz * multiplier.xyz);
    outColor.w = i.param.y;
    #line 266
    if (bool(_UsingDitherAlpha)){
        dither_clip( i.scrpos, i.scrpos.z);
    }
    #line 270
    outColor.w = xll_saturate_f(outColor.w);
    return outColor;
}
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main() {
unity_MatrixMVP = (unity_MatrixVP * unity_ObjectToWorld);
unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
unity_MatrixTMV = xll_transpose_mf4x4(unity_MatrixMV);
unity_MatrixITMV = xll_transpose_mf4x4((unity_WorldToObject * unity_MatrixInvV));
    mediump vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.uv_main = vec2(xlv_TEXCOORD0);
    xlt_i.uv_bump = vec2(xlv_TEXCOORD1);
    xlt_i.viewDir = vec3(xlv_TEXCOORD2);
    xlt_i.T = vec3(xlv_TEXCOORD3);
    xlt_i.B = vec3(xlv_TEXCOORD4);
    xlt_i.N = vec3(xlv_TEXCOORD5);
    xlt_i.param = vec2(xlv_COLOR1);
    xlt_i.scrpos = vec4(xlv_TEXCOORD6);
    xl_retval = fragBump( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}
/* HLSL2GLSL - NOTE: GLSL optimization failed
(180,8): error: illegal use of reserved word `input'
(180,8): error: syntax error, unexpected ERROR_TOK, expecting IDENTIFIER or TYPE_IDENTIFIER or NEW_IDENTIFIER or '{'
*/

#endif
"
}
SubProgram "gles " {
"#version 100

#ifdef VERTEX
#ifndef SHADER_TARGET
    #define SHADER_TARGET 25
#endif
#ifndef UNITY_NO_DXT5nm
    #define UNITY_NO_DXT5nm 1
#endif
#ifndef UNITY_NO_RGBM
    #define UNITY_NO_RGBM 1
#endif
#ifndef UNITY_ENABLE_REFLECTION_BUFFERS
    #define UNITY_ENABLE_REFLECTION_BUFFERS 1
#endif
#ifndef UNITY_FRAMEBUFFER_FETCH_AVAILABLE
    #define UNITY_FRAMEBUFFER_FETCH_AVAILABLE 1
#endif
#ifndef UNITY_NO_CUBEMAP_ARRAY
    #define UNITY_NO_CUBEMAP_ARRAY 1
#endif
#ifndef UNITY_NO_SCREENSPACE_SHADOWS
    #define UNITY_NO_SCREENSPACE_SHADOWS 1
#endif
#ifndef UNITY_PBS_USE_BRDF2
    #define UNITY_PBS_USE_BRDF2 1
#endif
#ifndef SHADER_API_MOBILE
    #define SHADER_API_MOBILE 1
#endif
#ifndef UNITY_HARDWARE_TIER3
    #define UNITY_HARDWARE_TIER3 1
#endif
#ifndef UNITY_COLORSPACE_GAMMA
    #define UNITY_COLORSPACE_GAMMA 1
#endif
#ifndef UNITY_LIGHTMAP_DLDR_ENCODING
    #define UNITY_LIGHTMAP_DLDR_ENCODING 1
#endif
#ifndef UNITY_VERSION
    #define UNITY_VERSION 201758
#endif
#ifndef SHADER_STAGE_VERTEX
    #define SHADER_STAGE_VERTEX 1
#endif
#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
#define gl_Vertex _glesVertex
attribute vec4 _glesVertex;
#define gl_Normal _glesNormal
attribute vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
attribute vec4 _glesMultiTexCoord0;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
mat3 xll_constructMat3_mf4x4( mat4 m) {
  return mat3( vec3( m[0]), vec3( m[1]), vec3( m[2]));
}
#line 447
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 756
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 749
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 186
struct v2f {
    highp vec4 pos;
    highp vec2 uv_main;
    highp vec2 uv_bump;
    highp vec3 viewDir;
    highp vec3 T;
    highp vec3 B;
    highp vec3 N;
    mediump vec2 param;
    highp vec4 scrpos;
};
#line 179
struct input {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec2 uv_main;
};
#line 40
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
#line 46
uniform highp vec3 _WorldSpaceCameraPos;
#line 53
uniform highp vec4 _ProjectionParams;
#line 59
uniform highp vec4 _ScreenParams;
#line 71
uniform highp vec4 _ZBufferParams;
#line 77
uniform highp vec4 unity_OrthoParams;
#line 82
uniform highp vec4 unity_CameraWorldClipPlanes[6];
#line 88
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 unity_WorldToCamera;
uniform highp mat4 unity_CameraToWorld;
#line 104
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
#line 108
uniform highp vec4 _LightProjectionParams;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
#line 112
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
#line 118
uniform highp vec4 unity_LightPosition[8];
#line 123
uniform mediump vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
#line 127
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
#line 131
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
#line 136
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform lowp vec4 unity_ProbesOcclusion;
#line 141
uniform mediump vec3 unity_LightColor0;
uniform mediump vec3 unity_LightColor1;
uniform mediump vec3 unity_LightColor2;
uniform mediump vec3 unity_LightColor3;
#line 148
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 152
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 161
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_LODFade;
uniform highp vec4 unity_WorldTransformParams;
#line 202
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 210
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
#line 214
uniform lowp vec4 unity_IndirectSpecColor;
uniform highp mat4 glstate_matrix_projection;
#line 218
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp int unity_StereoEyeIndex;
#line 224
uniform lowp vec4 unity_ShadowColor;
#line 231
uniform lowp vec4 unity_FogColor;
#line 236
uniform highp vec4 unity_FogParams;
#line 244
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_LightmapInd;
#line 258
uniform sampler2D unity_DynamicLightmap;
uniform sampler2D unity_DynamicDirectionality;
uniform sampler2D unity_DynamicNormal;
#line 263
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
#line 271
uniform samplerCube unity_SpecCube0;
uniform samplerCube unity_SpecCube1;
#line 275
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
#line 280
uniform highp vec4 unity_SpecCube1_BoxMax;
uniform highp vec4 unity_SpecCube1_BoxMin;
uniform highp vec4 unity_SpecCube1_ProbePosition;
uniform mediump vec4 unity_SpecCube1_HDR;
#line 320
highp mat4 unity_MatrixMVP;
highp mat4 unity_MatrixMV;
highp mat4 unity_MatrixTMV;
highp mat4 unity_MatrixITMV;
#line 9
#line 14
#line 84
#line 93
#line 103
#line 112
#line 124
#line 135
#line 141
#line 147
#line 151
#line 157
#line 163
#line 169
#line 175
#line 186
#line 201
#line 208
#line 223
#line 230
#line 237
#line 255
#line 291
#line 320
#line 326
#line 339
#line 357
#line 373
#line 427
#line 453
#line 464
#line 473
#line 480
#line 485
#line 502
#line 522
#line 537
#line 543
#line 554
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 unity_DynamicLightmap_HDR;
#line 568
#line 578
#line 593
#line 602
#line 609
#line 618
#line 626
#line 635
#line 654
#line 660
#line 670
#line 680
#line 691
#line 696
#line 702
#line 707
#line 764
#line 770
#line 785
#line 816
#line 830
#line 834
#line 840
#line 849
#line 859
#line 885
#line 891
#line 8
#line 17
#line 29
#line 50
#line 91
#line 102
#line 114
#line 127
#line 133
#line 188
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
#line 202
#line 234
uniform highp mat4 _DITHERMATRIX;
#line 259
#line 203
uniform sampler2D _BumpTex;
uniform highp vec4 _BumpTex_ST;
uniform mediump vec4 _Color;
#line 207
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform samplerCube _RefractTex;
uniform mediump float _ReflectionStrength;
#line 211
uniform mediump float _Emission;
uniform mediump float _BumpScaler;
uniform mediump float _Opaqueness;
#line 215
uniform highp float _BloomFactor;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
#line 219
#line 785
highp vec4 ComputeNonStereoScreenPos( in highp vec4 pos ) {
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    #line 789
    return o;
}
#line 792
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 793
    highp vec4 o = ComputeNonStereoScreenPos( pos);
    #line 797
    return o;
}
#line 9
highp vec4 UnityObjectToClipPos( in highp vec3 pos ) {
    return (unity_MatrixVP * (unity_ObjectToWorld * vec4( pos, 1.0)));
}
#line 14
highp vec4 UnityObjectToClipPos( in highp vec4 pos ) {
    return UnityObjectToClipPos( pos.xyz);
}
#line 175
highp vec3 UnityObjectToWorldNormal( in highp vec3 norm ) {
    #line 181
    return normalize((norm * xll_constructMat3_mf4x4( unity_WorldToObject)));
}
#line 219
v2f vertBump( in input i ) {
    v2f o = v2f(vec4(0.0, 0.0, 0.0, 0.0), vec2(0.0, 0.0), vec2(0.0, 0.0), vec3(0.0, 0.0, 0.0), vec3(0.0, 0.0, 0.0), vec3(0.0, 0.0, 0.0), vec3(0.0, 0.0, 0.0), vec2(0.0, 0.0), vec4(0.0, 0.0, 0.0, 0.0));
    o.uv_main = i.uv_main;
    #line 223
    o.uv_bump = ((i.uv_main.xy * _BumpTex_ST.xy) + _BumpTex_ST.zw);
    mediump float alpha = 1.0;
    o.param.y = (alpha * _Opaqueness);
    #line 228
    highp vec4 objPos = (unity_ObjectToWorld * i.vertex);
    o.viewDir = normalize((_WorldSpaceCameraPos.xyz - objPos.xyz));
    o.pos = UnityObjectToClipPos( i.vertex);
    #line 232
    o.N = (-UnityObjectToWorldNormal( i.normal));
    o.T = vec3( o.N.y, (-o.N.x), 0.0);
    o.T = normalize(o.T);
    o.B = cross( o.N, o.T);
    #line 236
    o.B = normalize(o.B);
    if (bool(_UsingDitherAlpha)){
        #line 240
        o.scrpos = ComputeScreenPos( o.pos);
        o.scrpos.z = _DitherAlpha;
    }
    #line 244
    return o;
}
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main() {
unity_MatrixMVP = (unity_MatrixVP * unity_ObjectToWorld);
unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
unity_MatrixTMV = xll_transpose_mf4x4(unity_MatrixMV);
unity_MatrixITMV = xll_transpose_mf4x4((unity_WorldToObject * unity_MatrixInvV));
    v2f xl_retval;
    input xlt_i;
    xlt_i.vertex = vec4(gl_Vertex);
    xlt_i.normal = vec3(gl_Normal);
    xlt_i.uv_main = vec2(gl_MultiTexCoord0);
    xl_retval = vertBump( xlt_i);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec2(xl_retval.uv_main);
    xlv_TEXCOORD1 = vec2(xl_retval.uv_bump);
    xlv_TEXCOORD2 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD3 = vec3(xl_retval.T);
    xlv_TEXCOORD4 = vec3(xl_retval.B);
    xlv_TEXCOORD5 = vec3(xl_retval.N);
    xlv_COLOR1 = vec2(xl_retval.param);
    xlv_TEXCOORD6 = vec4(xl_retval.scrpos);
}
/* HLSL2GLSL - NOTE: GLSL optimization failed
(180,8): error: illegal use of reserved word `input'
(180,8): error: syntax error, unexpected ERROR_TOK, expecting IDENTIFIER or TYPE_IDENTIFIER or NEW_IDENTIFIER or '{'
*/

#endif
#ifdef FRAGMENT
#ifndef SHADER_TARGET
    #define SHADER_TARGET 25
#endif
#ifndef UNITY_NO_DXT5nm
    #define UNITY_NO_DXT5nm 1
#endif
#ifndef UNITY_NO_RGBM
    #define UNITY_NO_RGBM 1
#endif
#ifndef UNITY_ENABLE_REFLECTION_BUFFERS
    #define UNITY_ENABLE_REFLECTION_BUFFERS 1
#endif
#ifndef UNITY_FRAMEBUFFER_FETCH_AVAILABLE
    #define UNITY_FRAMEBUFFER_FETCH_AVAILABLE 1
#endif
#ifndef UNITY_NO_CUBEMAP_ARRAY
    #define UNITY_NO_CUBEMAP_ARRAY 1
#endif
#ifndef UNITY_NO_SCREENSPACE_SHADOWS
    #define UNITY_NO_SCREENSPACE_SHADOWS 1
#endif
#ifndef UNITY_PBS_USE_BRDF2
    #define UNITY_PBS_USE_BRDF2 1
#endif
#ifndef SHADER_API_MOBILE
    #define SHADER_API_MOBILE 1
#endif
#ifndef UNITY_HARDWARE_TIER3
    #define UNITY_HARDWARE_TIER3 1
#endif
#ifndef UNITY_COLORSPACE_GAMMA
    #define UNITY_COLORSPACE_GAMMA 1
#endif
#ifndef UNITY_LIGHTMAP_DLDR_ENCODING
    #define UNITY_LIGHTMAP_DLDR_ENCODING 1
#endif
#ifndef UNITY_VERSION
    #define UNITY_VERSION 201758
#endif
#ifndef SHADER_STAGE_VERTEX
    #define SHADER_STAGE_VERTEX 1
#endif
#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
float xll_mod_f_f( float x, float y ) {
  float d = x / y;
  float f = fract (abs(d)) * y;
  return d >= 0.0 ? f : -f;
}
vec2 xll_mod_vf2_vf2( vec2 x, vec2 y ) {
  vec2 d = x / y;
  vec2 f = fract (abs(d)) * y;
  return vec2 (d.x >= 0.0 ? f.x : -f.x, d.y >= 0.0 ? f.y : -f.y);
}
vec3 xll_mod_vf3_vf3( vec3 x, vec3 y ) {
  vec3 d = x / y;
  vec3 f = fract (abs(d)) * y;
  return vec3 (d.x >= 0.0 ? f.x : -f.x, d.y >= 0.0 ? f.y : -f.y, d.z >= 0.0 ? f.z : -f.z);
}
vec4 xll_mod_vf4_vf4( vec4 x, vec4 y ) {
  vec4 d = x / y;
  vec4 f = fract (abs(d)) * y;
  return vec4 (d.x >= 0.0 ? f.x : -f.x, d.y >= 0.0 ? f.y : -f.y, d.z >= 0.0 ? f.z : -f.z, d.w >= 0.0 ? f.w : -f.w);
}
void xll_clip_f(float x) {
  if ( x<0.0 ) discard;
}
void xll_clip_vf2(vec2 x) {
  if (any(lessThan(x,vec2(0.0)))) discard;
}
void xll_clip_vf3(vec3 x) {
  if (any(lessThan(x,vec3(0.0)))) discard;
}
void xll_clip_vf4(vec4 x) {
  if (any(lessThan(x,vec4(0.0)))) discard;
}
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 447
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 756
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 749
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 186
struct v2f {
    highp vec4 pos;
    highp vec2 uv_main;
    highp vec2 uv_bump;
    highp vec3 viewDir;
    highp vec3 T;
    highp vec3 B;
    highp vec3 N;
    mediump vec2 param;
    highp vec4 scrpos;
};
#line 179
struct input {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec2 uv_main;
};
#line 40
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
#line 46
uniform highp vec3 _WorldSpaceCameraPos;
#line 53
uniform highp vec4 _ProjectionParams;
#line 59
uniform highp vec4 _ScreenParams;
#line 71
uniform highp vec4 _ZBufferParams;
#line 77
uniform highp vec4 unity_OrthoParams;
#line 82
uniform highp vec4 unity_CameraWorldClipPlanes[6];
#line 88
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 unity_WorldToCamera;
uniform highp mat4 unity_CameraToWorld;
#line 104
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
#line 108
uniform highp vec4 _LightProjectionParams;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
#line 112
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
#line 118
uniform highp vec4 unity_LightPosition[8];
#line 123
uniform mediump vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
#line 127
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
#line 131
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
#line 136
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform lowp vec4 unity_ProbesOcclusion;
#line 141
uniform mediump vec3 unity_LightColor0;
uniform mediump vec3 unity_LightColor1;
uniform mediump vec3 unity_LightColor2;
uniform mediump vec3 unity_LightColor3;
#line 148
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 152
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 161
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_LODFade;
uniform highp vec4 unity_WorldTransformParams;
#line 202
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 210
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
#line 214
uniform lowp vec4 unity_IndirectSpecColor;
uniform highp mat4 glstate_matrix_projection;
#line 218
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp int unity_StereoEyeIndex;
#line 224
uniform lowp vec4 unity_ShadowColor;
#line 231
uniform lowp vec4 unity_FogColor;
#line 236
uniform highp vec4 unity_FogParams;
#line 244
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_LightmapInd;
#line 258
uniform sampler2D unity_DynamicLightmap;
uniform sampler2D unity_DynamicDirectionality;
uniform sampler2D unity_DynamicNormal;
#line 263
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
#line 271
uniform samplerCube unity_SpecCube0;
uniform samplerCube unity_SpecCube1;
#line 275
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
#line 280
uniform highp vec4 unity_SpecCube1_BoxMax;
uniform highp vec4 unity_SpecCube1_BoxMin;
uniform highp vec4 unity_SpecCube1_ProbePosition;
uniform mediump vec4 unity_SpecCube1_HDR;
#line 320
highp mat4 unity_MatrixMVP;
highp mat4 unity_MatrixMV;
highp mat4 unity_MatrixTMV;
highp mat4 unity_MatrixITMV;
#line 9
#line 14
#line 84
#line 93
#line 103
#line 112
#line 124
#line 135
#line 141
#line 147
#line 151
#line 157
#line 163
#line 169
#line 175
#line 186
#line 201
#line 208
#line 223
#line 230
#line 237
#line 255
#line 291
#line 320
#line 326
#line 339
#line 357
#line 373
#line 427
#line 453
#line 464
#line 473
#line 480
#line 485
#line 502
#line 522
#line 537
#line 543
#line 554
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 unity_DynamicLightmap_HDR;
#line 568
#line 578
#line 593
#line 602
#line 609
#line 618
#line 626
#line 635
#line 654
#line 660
#line 670
#line 680
#line 691
#line 696
#line 702
#line 707
#line 764
#line 770
#line 785
#line 816
#line 830
#line 834
#line 840
#line 849
#line 859
#line 885
#line 891
#line 8
#line 17
#line 29
#line 50
#line 91
#line 102
#line 114
#line 127
#line 133
#line 188
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
#line 202
#line 234
uniform highp mat4 _DITHERMATRIX;
#line 259
#line 203
uniform sampler2D _BumpTex;
uniform highp vec4 _BumpTex_ST;
uniform mediump vec4 _Color;
#line 207
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform samplerCube _RefractTex;
uniform mediump float _ReflectionStrength;
#line 211
uniform mediump float _Emission;
uniform mediump float _BumpScaler;
uniform mediump float _Opaqueness;
#line 215
uniform highp float _BloomFactor;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
#line 219
#line 235
void dither_clip( in highp vec4 scrpos, in mediump float a ) {
    if ((a < 0.95)){
        #line 239
        scrpos.xy = ((scrpos.xy / scrpos.w) * _ScreenParams.xy);
        a *= 17.0;
        highp float curA = _DITHERMATRIX[int(xll_mod_f_f( scrpos.y, 4.0))][int(xll_mod_f_f( scrpos.x, 4.0))];
        xll_clip_f(((a - curA) - 0.01));
    }
    #line 244
    return ;
}
#line 247
mediump vec4 fragBump( in v2f i ) {
    #line 249
    mediump vec4 outColor = vec4( 0.0);
    mediump vec3 baseTexColor = ((texture2D( _MainTex, i.uv_main.xy).xyz * _Color.xyz) * vec3( _EnvColor));
    #line 254
    highp vec3 bumpVector = (texture2D( _BumpTex, i.uv_bump.xy).xyz - vec3( 0.5, 0.5, 0.0));
    bumpVector.xy *= _BumpScaler;
    bumpVector = normalize(bumpVector);
    #line 258
    highp vec3 N = (((i.T * bumpVector.x) + (i.B * bumpVector.y)) + (i.N * bumpVector.z));
    highp vec3 V = normalize(i.viewDir);
    highp vec3 uv_refract = (-reflect( V, N));
    mediump vec3 refraction = (textureCube( _RefractTex, uv_refract).xyz * baseTexColor);
    #line 262
    mediump vec3 multiplier = ((vec3( 1.0, 1.0, 1.0) * _ReflectionStrength) + _Emission);
    outColor.xyz = (refraction.xyz * multiplier.xyz);
    outColor.w = i.param.y;
    #line 266
    if (bool(_UsingDitherAlpha)){
        dither_clip( i.scrpos, i.scrpos.z);
    }
    #line 270
    outColor.w = xll_saturate_f(outColor.w);
    return outColor;
}
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main() {
unity_MatrixMVP = (unity_MatrixVP * unity_ObjectToWorld);
unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
unity_MatrixTMV = xll_transpose_mf4x4(unity_MatrixMV);
unity_MatrixITMV = xll_transpose_mf4x4((unity_WorldToObject * unity_MatrixInvV));
    mediump vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.uv_main = vec2(xlv_TEXCOORD0);
    xlt_i.uv_bump = vec2(xlv_TEXCOORD1);
    xlt_i.viewDir = vec3(xlv_TEXCOORD2);
    xlt_i.T = vec3(xlv_TEXCOORD3);
    xlt_i.B = vec3(xlv_TEXCOORD4);
    xlt_i.N = vec3(xlv_TEXCOORD5);
    xlt_i.param = vec2(xlv_COLOR1);
    xlt_i.scrpos = vec4(xlv_TEXCOORD6);
    xl_retval = fragBump( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}
/* HLSL2GLSL - NOTE: GLSL optimization failed
(180,8): error: illegal use of reserved word `input'
(180,8): error: syntax error, unexpected ERROR_TOK, expecting IDENTIFIER or TYPE_IDENTIFIER or NEW_IDENTIFIER or '{'
*/

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
  Tags { "IGNOREPROJECTOR" = "true" "OutlineType" = "None" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Off
  GpuProgramID 189054
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform mediump float _BloomFactor;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform mediump float _BloomFactor;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform mediump float _BloomFactor;
void main ()
{
  mediump vec4 color_1;
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
  Name "COMPLEX"
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "None" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Front
  GpuProgramID 239294
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _MaxOutlineZOffset;
uniform mediump float _Scale;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec3 N_1;
  mediump float S_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_3 = (unity_MatrixMV * _glesVertex);
  tmpvar_3 = (tmpvar_3 / tmpvar_3.w);
  highp float tmpvar_6;
  tmpvar_6 = (-(tmpvar_3.z) / unity_CameraProjection[1].y);
  S_2 = tmpvar_6;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_MatrixMV[0].xyz;
  tmpvar_7[1] = unity_MatrixMV[1].xyz;
  tmpvar_7[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * _glesTANGENT.xyz);
  N_1.xy = tmpvar_8.xy;
  N_1.z = 0.01;
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(N_1);
  N_1 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = pow ((S_2 / _Scale), 0.5);
  S_2 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = ((_OutlineWidth * _Scale) * (_glesColor.w * tmpvar_10));
  tmpvar_3.xyz = (tmpvar_3.xyz + ((
    (normalize(tmpvar_3.xyz) * _MaxOutlineZOffset)
   * _Scale) * (_glesColor.z - 0.5)));
  tmpvar_3.xy = (tmpvar_3.xy + (tmpvar_9.xy * tmpvar_11));
  tmpvar_4.xyz = _OutlineColor.xyz;
  tmpvar_4.w = 1.0;
  tmpvar_3 = (glstate_matrix_projection * tmpvar_3);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_12;
    highp vec4 tmpvar_13;
    tmpvar_13 = (tmpvar_3 * 0.5);
    highp vec2 tmpvar_14;
    tmpvar_14.x = tmpvar_13.x;
    tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
    o_12.xy = (tmpvar_14 + tmpvar_13.w);
    o_12.zw = tmpvar_3.zw;
    tmpvar_5.xyw = o_12.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_3;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1.w = xlv_COLOR0.w;
  mediump float x_2;
  x_2 = (xlv_COLOR0.w - 0.01);
  if ((x_2 < 0.0)) {
    discard;
  };
  color_1.xyz = (xlv_COLOR0.xyz * _Color.xyz);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_3;
    scrpos_3 = xlv_TEXCOORD3;
    mediump float a_4;
    a_4 = xlv_TEXCOORD3.z;
    if ((a_4 < 0.95)) {
      scrpos_3.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_4 = (a_4 * 17.0);
      highp float tmpvar_5;
      tmpvar_5 = (scrpos_3.y / 4.0);
      highp float tmpvar_6;
      tmpvar_6 = (fract(abs(tmpvar_5)) * 4.0);
      highp float tmpvar_7;
      if ((tmpvar_5 >= 0.0)) {
        tmpvar_7 = tmpvar_6;
      } else {
        tmpvar_7 = -(tmpvar_6);
      };
      highp float tmpvar_8;
      tmpvar_8 = (scrpos_3.x / 4.0);
      highp float tmpvar_9;
      tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
      highp float tmpvar_10;
      if ((tmpvar_8 >= 0.0)) {
        tmpvar_10 = tmpvar_9;
      } else {
        tmpvar_10 = -(tmpvar_9);
      };
      highp float x_11;
      x_11 = ((a_4 - _DITHERMATRIX[
        int(tmpvar_7)
      ][
        int(tmpvar_10)
      ]) - 0.01);
      if ((x_11 < 0.0)) {
        discard;
      };
    };
  };
  color_1.w = clamp (xlv_COLOR0.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _MaxOutlineZOffset;
uniform mediump float _Scale;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec3 N_1;
  mediump float S_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_3 = (unity_MatrixMV * _glesVertex);
  tmpvar_3 = (tmpvar_3 / tmpvar_3.w);
  highp float tmpvar_6;
  tmpvar_6 = (-(tmpvar_3.z) / unity_CameraProjection[1].y);
  S_2 = tmpvar_6;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_MatrixMV[0].xyz;
  tmpvar_7[1] = unity_MatrixMV[1].xyz;
  tmpvar_7[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * _glesTANGENT.xyz);
  N_1.xy = tmpvar_8.xy;
  N_1.z = 0.01;
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(N_1);
  N_1 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = pow ((S_2 / _Scale), 0.5);
  S_2 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = ((_OutlineWidth * _Scale) * (_glesColor.w * tmpvar_10));
  tmpvar_3.xyz = (tmpvar_3.xyz + ((
    (normalize(tmpvar_3.xyz) * _MaxOutlineZOffset)
   * _Scale) * (_glesColor.z - 0.5)));
  tmpvar_3.xy = (tmpvar_3.xy + (tmpvar_9.xy * tmpvar_11));
  tmpvar_4.xyz = _OutlineColor.xyz;
  tmpvar_4.w = 1.0;
  tmpvar_3 = (glstate_matrix_projection * tmpvar_3);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_12;
    highp vec4 tmpvar_13;
    tmpvar_13 = (tmpvar_3 * 0.5);
    highp vec2 tmpvar_14;
    tmpvar_14.x = tmpvar_13.x;
    tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
    o_12.xy = (tmpvar_14 + tmpvar_13.w);
    o_12.zw = tmpvar_3.zw;
    tmpvar_5.xyw = o_12.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_3;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1.w = xlv_COLOR0.w;
  mediump float x_2;
  x_2 = (xlv_COLOR0.w - 0.01);
  if ((x_2 < 0.0)) {
    discard;
  };
  color_1.xyz = (xlv_COLOR0.xyz * _Color.xyz);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_3;
    scrpos_3 = xlv_TEXCOORD3;
    mediump float a_4;
    a_4 = xlv_TEXCOORD3.z;
    if ((a_4 < 0.95)) {
      scrpos_3.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_4 = (a_4 * 17.0);
      highp float tmpvar_5;
      tmpvar_5 = (scrpos_3.y / 4.0);
      highp float tmpvar_6;
      tmpvar_6 = (fract(abs(tmpvar_5)) * 4.0);
      highp float tmpvar_7;
      if ((tmpvar_5 >= 0.0)) {
        tmpvar_7 = tmpvar_6;
      } else {
        tmpvar_7 = -(tmpvar_6);
      };
      highp float tmpvar_8;
      tmpvar_8 = (scrpos_3.x / 4.0);
      highp float tmpvar_9;
      tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
      highp float tmpvar_10;
      if ((tmpvar_8 >= 0.0)) {
        tmpvar_10 = tmpvar_9;
      } else {
        tmpvar_10 = -(tmpvar_9);
      };
      highp float x_11;
      x_11 = ((a_4 - _DITHERMATRIX[
        int(tmpvar_7)
      ][
        int(tmpvar_10)
      ]) - 0.01);
      if ((x_11 < 0.0)) {
        discard;
      };
    };
  };
  color_1.w = clamp (xlv_COLOR0.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _MaxOutlineZOffset;
uniform mediump float _Scale;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec3 N_1;
  mediump float S_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_3 = (unity_MatrixMV * _glesVertex);
  tmpvar_3 = (tmpvar_3 / tmpvar_3.w);
  highp float tmpvar_6;
  tmpvar_6 = (-(tmpvar_3.z) / unity_CameraProjection[1].y);
  S_2 = tmpvar_6;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_MatrixMV[0].xyz;
  tmpvar_7[1] = unity_MatrixMV[1].xyz;
  tmpvar_7[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * _glesTANGENT.xyz);
  N_1.xy = tmpvar_8.xy;
  N_1.z = 0.01;
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(N_1);
  N_1 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = pow ((S_2 / _Scale), 0.5);
  S_2 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = ((_OutlineWidth * _Scale) * (_glesColor.w * tmpvar_10));
  tmpvar_3.xyz = (tmpvar_3.xyz + ((
    (normalize(tmpvar_3.xyz) * _MaxOutlineZOffset)
   * _Scale) * (_glesColor.z - 0.5)));
  tmpvar_3.xy = (tmpvar_3.xy + (tmpvar_9.xy * tmpvar_11));
  tmpvar_4.xyz = _OutlineColor.xyz;
  tmpvar_4.w = 1.0;
  tmpvar_3 = (glstate_matrix_projection * tmpvar_3);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_12;
    highp vec4 tmpvar_13;
    tmpvar_13 = (tmpvar_3 * 0.5);
    highp vec2 tmpvar_14;
    tmpvar_14.x = tmpvar_13.x;
    tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
    o_12.xy = (tmpvar_14 + tmpvar_13.w);
    o_12.zw = tmpvar_3.zw;
    tmpvar_5.xyw = o_12.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_3;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1.w = xlv_COLOR0.w;
  mediump float x_2;
  x_2 = (xlv_COLOR0.w - 0.01);
  if ((x_2 < 0.0)) {
    discard;
  };
  color_1.xyz = (xlv_COLOR0.xyz * _Color.xyz);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_3;
    scrpos_3 = xlv_TEXCOORD3;
    mediump float a_4;
    a_4 = xlv_TEXCOORD3.z;
    if ((a_4 < 0.95)) {
      scrpos_3.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_4 = (a_4 * 17.0);
      highp float tmpvar_5;
      tmpvar_5 = (scrpos_3.y / 4.0);
      highp float tmpvar_6;
      tmpvar_6 = (fract(abs(tmpvar_5)) * 4.0);
      highp float tmpvar_7;
      if ((tmpvar_5 >= 0.0)) {
        tmpvar_7 = tmpvar_6;
      } else {
        tmpvar_7 = -(tmpvar_6);
      };
      highp float tmpvar_8;
      tmpvar_8 = (scrpos_3.x / 4.0);
      highp float tmpvar_9;
      tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
      highp float tmpvar_10;
      if ((tmpvar_8 >= 0.0)) {
        tmpvar_10 = tmpvar_9;
      } else {
        tmpvar_10 = -(tmpvar_9);
      };
      highp float x_11;
      x_11 = ((a_4 - _DITHERMATRIX[
        int(tmpvar_7)
      ][
        int(tmpvar_10)
      ]) - 0.01);
      if ((x_11 < 0.0)) {
        discard;
      };
    };
  };
  color_1.w = clamp (xlv_COLOR0.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform highp vec4 _SPNoiseTex_ST;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _MaxOutlineZOffset;
uniform mediump float _Scale;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec3 N_1;
  mediump float S_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_3 = (unity_MatrixMV * _glesVertex);
  tmpvar_3 = (tmpvar_3 / tmpvar_3.w);
  highp float tmpvar_6;
  tmpvar_6 = (-(tmpvar_3.z) / unity_CameraProjection[1].y);
  S_2 = tmpvar_6;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_MatrixMV[0].xyz;
  tmpvar_7[1] = unity_MatrixMV[1].xyz;
  tmpvar_7[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * _glesTANGENT.xyz);
  N_1.xy = tmpvar_8.xy;
  N_1.z = 0.01;
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(N_1);
  N_1 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = pow ((S_2 / _Scale), 0.5);
  S_2 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = ((_OutlineWidth * _Scale) * (_glesColor.w * tmpvar_10));
  tmpvar_3.xyz = (tmpvar_3.xyz + ((
    (normalize(tmpvar_3.xyz) * _MaxOutlineZOffset)
   * _Scale) * (_glesColor.z - 0.5)));
  tmpvar_3.xy = (tmpvar_3.xy + (tmpvar_9.xy * tmpvar_11));
  tmpvar_4.xyz = _OutlineColor.xyz;
  tmpvar_4.w = 1.0;
  tmpvar_3 = (glstate_matrix_projection * tmpvar_3);
  highp vec2 spnoiseuv_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (_glesVertex * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (tmpvar_13.x + (tmpvar_13.z * tmpvar_13.z));
  tmpvar_14.y = ((tmpvar_13.y + (0.5 * tmpvar_13.z)) + ((0.5 * tmpvar_13.x) * tmpvar_13.x));
  spnoiseuv_12 = ((tmpvar_14 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_15;
    highp vec4 tmpvar_16;
    tmpvar_16 = (tmpvar_3 * 0.5);
    highp vec2 tmpvar_17;
    tmpvar_17.x = tmpvar_16.x;
    tmpvar_17.y = (tmpvar_16.y * _ProjectionParams.x);
    o_15.xy = (tmpvar_17 + tmpvar_16.w);
    o_15.zw = tmpvar_3.zw;
    tmpvar_5.xyw = o_15.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_3;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = spnoiseuv_12;
  xlv_TEXCOORD3 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPTransition;
uniform mediump vec4 _SPOutlineColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform highp float _UsingDitherAlpha;
highp float xlat_mutable_SPTransition;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1 = xlv_COLOR0;
  mediump float x_2;
  x_2 = (xlv_COLOR0.w - 0.01);
  if ((x_2 < 0.0)) {
    discard;
  };
  mediump float intensity_3;
  mediump vec4 outColor_4;
  outColor_4 = _SPOutlineColor;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_SPNoiseTex, xlv_TEXCOORD0);
  highp float tmpvar_6;
  tmpvar_6 = (((1.99 * tmpvar_5.x) * _SPNoiseScaler) - 1.0);
  intensity_3 = tmpvar_6;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_3 >= (1.7 * xlat_mutable_SPTransition))) {
    outColor_4 = xlv_COLOR0;
  };
  color_1.w = outColor_4.w;
  color_1.xyz = (outColor_4.xyz * _Color.xyz);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_7;
    scrpos_7 = xlv_TEXCOORD3;
    mediump float a_8;
    a_8 = xlv_TEXCOORD3.z;
    if ((a_8 < 0.95)) {
      scrpos_7.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_8 = (a_8 * 17.0);
      highp float tmpvar_9;
      tmpvar_9 = (scrpos_7.y / 4.0);
      highp float tmpvar_10;
      tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
      highp float tmpvar_11;
      if ((tmpvar_9 >= 0.0)) {
        tmpvar_11 = tmpvar_10;
      } else {
        tmpvar_11 = -(tmpvar_10);
      };
      highp float tmpvar_12;
      tmpvar_12 = (scrpos_7.x / 4.0);
      highp float tmpvar_13;
      tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
      highp float tmpvar_14;
      if ((tmpvar_12 >= 0.0)) {
        tmpvar_14 = tmpvar_13;
      } else {
        tmpvar_14 = -(tmpvar_13);
      };
      highp float x_15;
      x_15 = ((a_8 - _DITHERMATRIX[
        int(tmpvar_11)
      ][
        int(tmpvar_14)
      ]) - 0.01);
      if ((x_15 < 0.0)) {
        discard;
      };
    };
  };
  color_1.w = clamp (outColor_4.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform highp vec4 _SPNoiseTex_ST;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _MaxOutlineZOffset;
uniform mediump float _Scale;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec3 N_1;
  mediump float S_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_3 = (unity_MatrixMV * _glesVertex);
  tmpvar_3 = (tmpvar_3 / tmpvar_3.w);
  highp float tmpvar_6;
  tmpvar_6 = (-(tmpvar_3.z) / unity_CameraProjection[1].y);
  S_2 = tmpvar_6;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_MatrixMV[0].xyz;
  tmpvar_7[1] = unity_MatrixMV[1].xyz;
  tmpvar_7[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * _glesTANGENT.xyz);
  N_1.xy = tmpvar_8.xy;
  N_1.z = 0.01;
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(N_1);
  N_1 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = pow ((S_2 / _Scale), 0.5);
  S_2 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = ((_OutlineWidth * _Scale) * (_glesColor.w * tmpvar_10));
  tmpvar_3.xyz = (tmpvar_3.xyz + ((
    (normalize(tmpvar_3.xyz) * _MaxOutlineZOffset)
   * _Scale) * (_glesColor.z - 0.5)));
  tmpvar_3.xy = (tmpvar_3.xy + (tmpvar_9.xy * tmpvar_11));
  tmpvar_4.xyz = _OutlineColor.xyz;
  tmpvar_4.w = 1.0;
  tmpvar_3 = (glstate_matrix_projection * tmpvar_3);
  highp vec2 spnoiseuv_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (_glesVertex * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (tmpvar_13.x + (tmpvar_13.z * tmpvar_13.z));
  tmpvar_14.y = ((tmpvar_13.y + (0.5 * tmpvar_13.z)) + ((0.5 * tmpvar_13.x) * tmpvar_13.x));
  spnoiseuv_12 = ((tmpvar_14 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_15;
    highp vec4 tmpvar_16;
    tmpvar_16 = (tmpvar_3 * 0.5);
    highp vec2 tmpvar_17;
    tmpvar_17.x = tmpvar_16.x;
    tmpvar_17.y = (tmpvar_16.y * _ProjectionParams.x);
    o_15.xy = (tmpvar_17 + tmpvar_16.w);
    o_15.zw = tmpvar_3.zw;
    tmpvar_5.xyw = o_15.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_3;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = spnoiseuv_12;
  xlv_TEXCOORD3 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPTransition;
uniform mediump vec4 _SPOutlineColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform highp float _UsingDitherAlpha;
highp float xlat_mutable_SPTransition;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1 = xlv_COLOR0;
  mediump float x_2;
  x_2 = (xlv_COLOR0.w - 0.01);
  if ((x_2 < 0.0)) {
    discard;
  };
  mediump float intensity_3;
  mediump vec4 outColor_4;
  outColor_4 = _SPOutlineColor;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_SPNoiseTex, xlv_TEXCOORD0);
  highp float tmpvar_6;
  tmpvar_6 = (((1.99 * tmpvar_5.x) * _SPNoiseScaler) - 1.0);
  intensity_3 = tmpvar_6;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_3 >= (1.7 * xlat_mutable_SPTransition))) {
    outColor_4 = xlv_COLOR0;
  };
  color_1.w = outColor_4.w;
  color_1.xyz = (outColor_4.xyz * _Color.xyz);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_7;
    scrpos_7 = xlv_TEXCOORD3;
    mediump float a_8;
    a_8 = xlv_TEXCOORD3.z;
    if ((a_8 < 0.95)) {
      scrpos_7.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_8 = (a_8 * 17.0);
      highp float tmpvar_9;
      tmpvar_9 = (scrpos_7.y / 4.0);
      highp float tmpvar_10;
      tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
      highp float tmpvar_11;
      if ((tmpvar_9 >= 0.0)) {
        tmpvar_11 = tmpvar_10;
      } else {
        tmpvar_11 = -(tmpvar_10);
      };
      highp float tmpvar_12;
      tmpvar_12 = (scrpos_7.x / 4.0);
      highp float tmpvar_13;
      tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
      highp float tmpvar_14;
      if ((tmpvar_12 >= 0.0)) {
        tmpvar_14 = tmpvar_13;
      } else {
        tmpvar_14 = -(tmpvar_13);
      };
      highp float x_15;
      x_15 = ((a_8 - _DITHERMATRIX[
        int(tmpvar_11)
      ][
        int(tmpvar_14)
      ]) - 0.01);
      if ((x_15 < 0.0)) {
        discard;
      };
    };
  };
  color_1.w = clamp (outColor_4.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform highp vec4 _SPNoiseTex_ST;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _MaxOutlineZOffset;
uniform mediump float _Scale;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec3 N_1;
  mediump float S_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_3 = (unity_MatrixMV * _glesVertex);
  tmpvar_3 = (tmpvar_3 / tmpvar_3.w);
  highp float tmpvar_6;
  tmpvar_6 = (-(tmpvar_3.z) / unity_CameraProjection[1].y);
  S_2 = tmpvar_6;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_MatrixMV[0].xyz;
  tmpvar_7[1] = unity_MatrixMV[1].xyz;
  tmpvar_7[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * _glesTANGENT.xyz);
  N_1.xy = tmpvar_8.xy;
  N_1.z = 0.01;
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(N_1);
  N_1 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = pow ((S_2 / _Scale), 0.5);
  S_2 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = ((_OutlineWidth * _Scale) * (_glesColor.w * tmpvar_10));
  tmpvar_3.xyz = (tmpvar_3.xyz + ((
    (normalize(tmpvar_3.xyz) * _MaxOutlineZOffset)
   * _Scale) * (_glesColor.z - 0.5)));
  tmpvar_3.xy = (tmpvar_3.xy + (tmpvar_9.xy * tmpvar_11));
  tmpvar_4.xyz = _OutlineColor.xyz;
  tmpvar_4.w = 1.0;
  tmpvar_3 = (glstate_matrix_projection * tmpvar_3);
  highp vec2 spnoiseuv_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (_glesVertex * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (tmpvar_13.x + (tmpvar_13.z * tmpvar_13.z));
  tmpvar_14.y = ((tmpvar_13.y + (0.5 * tmpvar_13.z)) + ((0.5 * tmpvar_13.x) * tmpvar_13.x));
  spnoiseuv_12 = ((tmpvar_14 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_15;
    highp vec4 tmpvar_16;
    tmpvar_16 = (tmpvar_3 * 0.5);
    highp vec2 tmpvar_17;
    tmpvar_17.x = tmpvar_16.x;
    tmpvar_17.y = (tmpvar_16.y * _ProjectionParams.x);
    o_15.xy = (tmpvar_17 + tmpvar_16.w);
    o_15.zw = tmpvar_3.zw;
    tmpvar_5.xyw = o_15.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_3;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = spnoiseuv_12;
  xlv_TEXCOORD3 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPTransition;
uniform mediump vec4 _SPOutlineColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform highp float _UsingDitherAlpha;
highp float xlat_mutable_SPTransition;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1 = xlv_COLOR0;
  mediump float x_2;
  x_2 = (xlv_COLOR0.w - 0.01);
  if ((x_2 < 0.0)) {
    discard;
  };
  mediump float intensity_3;
  mediump vec4 outColor_4;
  outColor_4 = _SPOutlineColor;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_SPNoiseTex, xlv_TEXCOORD0);
  highp float tmpvar_6;
  tmpvar_6 = (((1.99 * tmpvar_5.x) * _SPNoiseScaler) - 1.0);
  intensity_3 = tmpvar_6;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_3 >= (1.7 * xlat_mutable_SPTransition))) {
    outColor_4 = xlv_COLOR0;
  };
  color_1.w = outColor_4.w;
  color_1.xyz = (outColor_4.xyz * _Color.xyz);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_7;
    scrpos_7 = xlv_TEXCOORD3;
    mediump float a_8;
    a_8 = xlv_TEXCOORD3.z;
    if ((a_8 < 0.95)) {
      scrpos_7.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_8 = (a_8 * 17.0);
      highp float tmpvar_9;
      tmpvar_9 = (scrpos_7.y / 4.0);
      highp float tmpvar_10;
      tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
      highp float tmpvar_11;
      if ((tmpvar_9 >= 0.0)) {
        tmpvar_11 = tmpvar_10;
      } else {
        tmpvar_11 = -(tmpvar_10);
      };
      highp float tmpvar_12;
      tmpvar_12 = (scrpos_7.x / 4.0);
      highp float tmpvar_13;
      tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
      highp float tmpvar_14;
      if ((tmpvar_12 >= 0.0)) {
        tmpvar_14 = tmpvar_13;
      } else {
        tmpvar_14 = -(tmpvar_13);
      };
      highp float x_15;
      x_15 = ((a_8 - _DITHERMATRIX[
        int(tmpvar_11)
      ][
        int(tmpvar_14)
      ]) - 0.01);
      if ((x_15 < 0.0)) {
        discard;
      };
    };
  };
  color_1.w = clamp (outColor_4.w, 0.0, 1.0);
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
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" }
""
}
}
}
}
CustomEditor "MoleMole.CharacterShaderEditorBase"
}