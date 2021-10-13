//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Character/Character_Avatar/Avatar_Crystal_Spectrum_ThinFilm" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_EnvColor ("Env Color", Color) = (1,1,1,1)
_Scale ("Scale Compared to Maya", Float) = 0.01
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Main Tex", 2D) = "white" { }
_SpectrumTexture ("Spectrum Texture", 2D) = "white" { }
_BumpTex ("Bump Tex", 2D) = "grey" { }
_BumpScaler ("Bump Scaler", Range(0, 10)) = 1
_Opaqueness ("Opaqueness", Range(0, 1)) = 1
_MinAlpha ("Min Alpha", Range(0, 1)) = 0
_EmissionScaler ("Emission Scaler", Range(1, 20)) = 1
_EmissionScalerScalerWithoutHDR ("", Float) = 1
_SpectrumIntensity ("Spectrum Intensity", Range(0, 10)) = 1
_SpectrumRangeScaler ("Spectrum Range Scaler", Range(0, 10)) = 1
_SpectrumRangeOffset ("Spectrum Range Offset", Range(0, 1)) = 0
_SpectrumViewDistance ("Spectrum View Distance", Float) = 5
_SpectrumFresnel ("Spectrum Fresnel", Vector) = (1,1,0,0)
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
  GpuProgramID 33373
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
#line 82
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
#line 75
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
#line 99
uniform sampler2D _BumpTex;
uniform highp vec4 _BumpTex_ST;
uniform mediump vec4 _Color;
#line 103
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _SpectrumTexture;
uniform highp float _SpectrumIntensity;
#line 107
uniform highp float _SpectrumBumpScaler;
uniform highp float _SpectrumRangeScaler;
uniform highp float _SpectrumRangeOffset;
uniform highp float _SpectrumViewDistance;
#line 111
uniform mediump vec4 _SpectrumFresnel;
uniform mediump float _EmissionScaler;
uniform mediump float _ReflectionStrength;
#line 115
uniform mediump float _Emission;
uniform mediump float _BumpScaler;
uniform mediump float _Opaqueness;
uniform mediump float _MinAlpha;
#line 120
uniform highp float _BloomFactor;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
#line 124
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
#line 124
v2f vertBump( in input i ) {
    v2f o = v2f(vec4(0.0, 0.0, 0.0, 0.0), vec2(0.0, 0.0), vec2(0.0, 0.0), vec3(0.0, 0.0, 0.0), vec3(0.0, 0.0, 0.0), vec3(0.0, 0.0, 0.0), vec3(0.0, 0.0, 0.0), vec2(0.0, 0.0), vec4(0.0, 0.0, 0.0, 0.0));
    o.uv_main = i.uv_main;
    #line 128
    o.uv_bump = ((i.uv_main.xy * _BumpTex_ST.xy) + _BumpTex_ST.zw);
    mediump float alpha = 1.0;
    o.param.y = (alpha * _Opaqueness);
    #line 133
    highp vec4 objPos = (unity_ObjectToWorld * i.vertex);
    o.viewDir = normalize((_WorldSpaceCameraPos.xyz - objPos.xyz));
    o.pos = UnityObjectToClipPos( i.vertex);
    #line 137
    o.N = (-UnityObjectToWorldNormal( i.normal));
    o.T = vec3( o.N.y, (-o.N.x), 0.0);
    o.T = normalize(o.T);
    o.B = cross( o.N, o.T);
    #line 141
    o.B = normalize(o.B);
    if (bool(_UsingDitherAlpha)){
        #line 145
        o.scrpos = ComputeScreenPos( o.pos);
        o.scrpos.z = _DitherAlpha;
    }
    #line 149
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
(76,8): error: illegal use of reserved word `input'
(76,8): error: syntax error, unexpected ERROR_TOK, expecting IDENTIFIER or TYPE_IDENTIFIER or NEW_IDENTIFIER or '{'
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
#line 82
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
#line 75
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
#line 99
uniform sampler2D _BumpTex;
uniform highp vec4 _BumpTex_ST;
uniform mediump vec4 _Color;
#line 103
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _SpectrumTexture;
uniform highp float _SpectrumIntensity;
#line 107
uniform highp float _SpectrumBumpScaler;
uniform highp float _SpectrumRangeScaler;
uniform highp float _SpectrumRangeOffset;
uniform highp float _SpectrumViewDistance;
#line 111
uniform mediump vec4 _SpectrumFresnel;
uniform mediump float _EmissionScaler;
uniform mediump float _ReflectionStrength;
#line 115
uniform mediump float _Emission;
uniform mediump float _BumpScaler;
uniform mediump float _Opaqueness;
uniform mediump float _MinAlpha;
#line 120
uniform highp float _BloomFactor;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
#line 124
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
#line 152
highp float fresnel( in highp float cs, in highp float power, in highp float scale, in highp float bias ) {
    #line 154
    return (bias + (pow( clamp( (1.0 - cs), 0.0, 1.0), power) * scale));
}
#line 157
mediump vec4 fragBump( in v2f i ) {
    #line 159
    mediump vec4 outColor = vec4( 0.0);
    mediump vec3 baseTexColor = (texture2D( _MainTex, i.uv_main.xy).xyz * _Color.xyz);
    outColor.xyz = ((baseTexColor * _Color.xyz) * vec3( _EnvColor));
    #line 165
    highp vec3 bumpVector = (texture2D( _BumpTex, i.uv_bump.xy).xyz - vec3( 0.5, 0.5, 0.0));
    bumpVector.xy *= _BumpScaler;
    bumpVector = normalize(bumpVector);
    #line 170
    highp vec3 N = (((i.T * bumpVector.x) + (i.B * bumpVector.y)) + (i.N * bumpVector.z));
    highp vec3 V = normalize(i.viewDir);
    mediump float cs = abs(dot( N, V));
    mediump vec2 uv = vec2( ((acos(cs) * _SpectrumRangeScaler) + _SpectrumRangeOffset));
    #line 174
    mediump float f = fresnel( cs, _SpectrumFresnel.x, _SpectrumFresnel.y, _SpectrumFresnel.z);
    mediump vec3 SpectrumColor = vec3( ((texture2D( _SpectrumTexture, uv) * _SpectrumIntensity) * f));
    #line 178
    outColor.xyz = ((outColor.xyz + SpectrumColor) - (outColor.xyz * SpectrumColor));
    outColor.xyz *= _EmissionScaler;
    #line 182
    mediump float afresnel = fresnel( abs(dot( i.N, V)), _SpectrumFresnel.x, _SpectrumFresnel.y, _SpectrumFresnel.z);
    outColor.w = max( min( (((i.param.y * afresnel) * 0.5) * 3.0), 1.0), _MinAlpha);
    #line 186
    if (bool(_UsingDitherAlpha)){
        dither_clip( i.scrpos, i.scrpos.z);
    }
    #line 190
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
(76,8): error: illegal use of reserved word `input'
(76,8): error: syntax error, unexpected ERROR_TOK, expecting IDENTIFIER or TYPE_IDENTIFIER or NEW_IDENTIFIER or '{'
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
#line 82
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
#line 75
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
#line 99
uniform sampler2D _BumpTex;
uniform highp vec4 _BumpTex_ST;
uniform mediump vec4 _Color;
#line 103
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _SpectrumTexture;
uniform highp float _SpectrumIntensity;
#line 107
uniform highp float _SpectrumBumpScaler;
uniform highp float _SpectrumRangeScaler;
uniform highp float _SpectrumRangeOffset;
uniform highp float _SpectrumViewDistance;
#line 111
uniform mediump vec4 _SpectrumFresnel;
uniform mediump float _EmissionScaler;
uniform mediump float _ReflectionStrength;
#line 115
uniform mediump float _Emission;
uniform mediump float _BumpScaler;
uniform mediump float _Opaqueness;
uniform mediump float _MinAlpha;
#line 120
uniform highp float _BloomFactor;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
#line 124
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
#line 124
v2f vertBump( in input i ) {
    v2f o = v2f(vec4(0.0, 0.0, 0.0, 0.0), vec2(0.0, 0.0), vec2(0.0, 0.0), vec3(0.0, 0.0, 0.0), vec3(0.0, 0.0, 0.0), vec3(0.0, 0.0, 0.0), vec3(0.0, 0.0, 0.0), vec2(0.0, 0.0), vec4(0.0, 0.0, 0.0, 0.0));
    o.uv_main = i.uv_main;
    #line 128
    o.uv_bump = ((i.uv_main.xy * _BumpTex_ST.xy) + _BumpTex_ST.zw);
    mediump float alpha = 1.0;
    o.param.y = (alpha * _Opaqueness);
    #line 133
    highp vec4 objPos = (unity_ObjectToWorld * i.vertex);
    o.viewDir = normalize((_WorldSpaceCameraPos.xyz - objPos.xyz));
    o.pos = UnityObjectToClipPos( i.vertex);
    #line 137
    o.N = (-UnityObjectToWorldNormal( i.normal));
    o.T = vec3( o.N.y, (-o.N.x), 0.0);
    o.T = normalize(o.T);
    o.B = cross( o.N, o.T);
    #line 141
    o.B = normalize(o.B);
    if (bool(_UsingDitherAlpha)){
        #line 145
        o.scrpos = ComputeScreenPos( o.pos);
        o.scrpos.z = _DitherAlpha;
    }
    #line 149
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
(76,8): error: illegal use of reserved word `input'
(76,8): error: syntax error, unexpected ERROR_TOK, expecting IDENTIFIER or TYPE_IDENTIFIER or NEW_IDENTIFIER or '{'
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
#line 82
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
#line 75
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
#line 99
uniform sampler2D _BumpTex;
uniform highp vec4 _BumpTex_ST;
uniform mediump vec4 _Color;
#line 103
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _SpectrumTexture;
uniform highp float _SpectrumIntensity;
#line 107
uniform highp float _SpectrumBumpScaler;
uniform highp float _SpectrumRangeScaler;
uniform highp float _SpectrumRangeOffset;
uniform highp float _SpectrumViewDistance;
#line 111
uniform mediump vec4 _SpectrumFresnel;
uniform mediump float _EmissionScaler;
uniform mediump float _ReflectionStrength;
#line 115
uniform mediump float _Emission;
uniform mediump float _BumpScaler;
uniform mediump float _Opaqueness;
uniform mediump float _MinAlpha;
#line 120
uniform highp float _BloomFactor;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
#line 124
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
#line 152
highp float fresnel( in highp float cs, in highp float power, in highp float scale, in highp float bias ) {
    #line 154
    return (bias + (pow( clamp( (1.0 - cs), 0.0, 1.0), power) * scale));
}
#line 157
mediump vec4 fragBump( in v2f i ) {
    #line 159
    mediump vec4 outColor = vec4( 0.0);
    mediump vec3 baseTexColor = (texture2D( _MainTex, i.uv_main.xy).xyz * _Color.xyz);
    outColor.xyz = ((baseTexColor * _Color.xyz) * vec3( _EnvColor));
    #line 165
    highp vec3 bumpVector = (texture2D( _BumpTex, i.uv_bump.xy).xyz - vec3( 0.5, 0.5, 0.0));
    bumpVector.xy *= _BumpScaler;
    bumpVector = normalize(bumpVector);
    #line 170
    highp vec3 N = (((i.T * bumpVector.x) + (i.B * bumpVector.y)) + (i.N * bumpVector.z));
    highp vec3 V = normalize(i.viewDir);
    mediump float cs = abs(dot( N, V));
    mediump vec2 uv = vec2( ((acos(cs) * _SpectrumRangeScaler) + _SpectrumRangeOffset));
    #line 174
    mediump float f = fresnel( cs, _SpectrumFresnel.x, _SpectrumFresnel.y, _SpectrumFresnel.z);
    mediump vec3 SpectrumColor = vec3( ((texture2D( _SpectrumTexture, uv) * _SpectrumIntensity) * f));
    #line 178
    outColor.xyz = ((outColor.xyz + SpectrumColor) - (outColor.xyz * SpectrumColor));
    outColor.xyz *= _EmissionScaler;
    #line 182
    mediump float afresnel = fresnel( abs(dot( i.N, V)), _SpectrumFresnel.x, _SpectrumFresnel.y, _SpectrumFresnel.z);
    outColor.w = max( min( (((i.param.y * afresnel) * 0.5) * 3.0), 1.0), _MinAlpha);
    #line 186
    if (bool(_UsingDitherAlpha)){
        dither_clip( i.scrpos, i.scrpos.z);
    }
    #line 190
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
(76,8): error: illegal use of reserved word `input'
(76,8): error: syntax error, unexpected ERROR_TOK, expecting IDENTIFIER or TYPE_IDENTIFIER or NEW_IDENTIFIER or '{'
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
#line 82
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
#line 75
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
#line 99
uniform sampler2D _BumpTex;
uniform highp vec4 _BumpTex_ST;
uniform mediump vec4 _Color;
#line 103
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _SpectrumTexture;
uniform highp float _SpectrumIntensity;
#line 107
uniform highp float _SpectrumBumpScaler;
uniform highp float _SpectrumRangeScaler;
uniform highp float _SpectrumRangeOffset;
uniform highp float _SpectrumViewDistance;
#line 111
uniform mediump vec4 _SpectrumFresnel;
uniform mediump float _EmissionScaler;
uniform mediump float _ReflectionStrength;
#line 115
uniform mediump float _Emission;
uniform mediump float _BumpScaler;
uniform mediump float _Opaqueness;
uniform mediump float _MinAlpha;
#line 120
uniform highp float _BloomFactor;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
#line 124
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
#line 124
v2f vertBump( in input i ) {
    v2f o = v2f(vec4(0.0, 0.0, 0.0, 0.0), vec2(0.0, 0.0), vec2(0.0, 0.0), vec3(0.0, 0.0, 0.0), vec3(0.0, 0.0, 0.0), vec3(0.0, 0.0, 0.0), vec3(0.0, 0.0, 0.0), vec2(0.0, 0.0), vec4(0.0, 0.0, 0.0, 0.0));
    o.uv_main = i.uv_main;
    #line 128
    o.uv_bump = ((i.uv_main.xy * _BumpTex_ST.xy) + _BumpTex_ST.zw);
    mediump float alpha = 1.0;
    o.param.y = (alpha * _Opaqueness);
    #line 133
    highp vec4 objPos = (unity_ObjectToWorld * i.vertex);
    o.viewDir = normalize((_WorldSpaceCameraPos.xyz - objPos.xyz));
    o.pos = UnityObjectToClipPos( i.vertex);
    #line 137
    o.N = (-UnityObjectToWorldNormal( i.normal));
    o.T = vec3( o.N.y, (-o.N.x), 0.0);
    o.T = normalize(o.T);
    o.B = cross( o.N, o.T);
    #line 141
    o.B = normalize(o.B);
    if (bool(_UsingDitherAlpha)){
        #line 145
        o.scrpos = ComputeScreenPos( o.pos);
        o.scrpos.z = _DitherAlpha;
    }
    #line 149
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
(76,8): error: illegal use of reserved word `input'
(76,8): error: syntax error, unexpected ERROR_TOK, expecting IDENTIFIER or TYPE_IDENTIFIER or NEW_IDENTIFIER or '{'
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
#line 82
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
#line 75
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
#line 99
uniform sampler2D _BumpTex;
uniform highp vec4 _BumpTex_ST;
uniform mediump vec4 _Color;
#line 103
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _SpectrumTexture;
uniform highp float _SpectrumIntensity;
#line 107
uniform highp float _SpectrumBumpScaler;
uniform highp float _SpectrumRangeScaler;
uniform highp float _SpectrumRangeOffset;
uniform highp float _SpectrumViewDistance;
#line 111
uniform mediump vec4 _SpectrumFresnel;
uniform mediump float _EmissionScaler;
uniform mediump float _ReflectionStrength;
#line 115
uniform mediump float _Emission;
uniform mediump float _BumpScaler;
uniform mediump float _Opaqueness;
uniform mediump float _MinAlpha;
#line 120
uniform highp float _BloomFactor;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
#line 124
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
#line 152
highp float fresnel( in highp float cs, in highp float power, in highp float scale, in highp float bias ) {
    #line 154
    return (bias + (pow( clamp( (1.0 - cs), 0.0, 1.0), power) * scale));
}
#line 157
mediump vec4 fragBump( in v2f i ) {
    #line 159
    mediump vec4 outColor = vec4( 0.0);
    mediump vec3 baseTexColor = (texture2D( _MainTex, i.uv_main.xy).xyz * _Color.xyz);
    outColor.xyz = ((baseTexColor * _Color.xyz) * vec3( _EnvColor));
    #line 165
    highp vec3 bumpVector = (texture2D( _BumpTex, i.uv_bump.xy).xyz - vec3( 0.5, 0.5, 0.0));
    bumpVector.xy *= _BumpScaler;
    bumpVector = normalize(bumpVector);
    #line 170
    highp vec3 N = (((i.T * bumpVector.x) + (i.B * bumpVector.y)) + (i.N * bumpVector.z));
    highp vec3 V = normalize(i.viewDir);
    mediump float cs = abs(dot( N, V));
    mediump vec2 uv = vec2( ((acos(cs) * _SpectrumRangeScaler) + _SpectrumRangeOffset));
    #line 174
    mediump float f = fresnel( cs, _SpectrumFresnel.x, _SpectrumFresnel.y, _SpectrumFresnel.z);
    mediump vec3 SpectrumColor = vec3( ((texture2D( _SpectrumTexture, uv) * _SpectrumIntensity) * f));
    #line 178
    outColor.xyz = ((outColor.xyz + SpectrumColor) - (outColor.xyz * SpectrumColor));
    outColor.xyz *= _EmissionScaler;
    #line 182
    mediump float afresnel = fresnel( abs(dot( i.N, V)), _SpectrumFresnel.x, _SpectrumFresnel.y, _SpectrumFresnel.z);
    outColor.w = max( min( (((i.param.y * afresnel) * 0.5) * 3.0), 1.0), _MinAlpha);
    #line 186
    if (bool(_UsingDitherAlpha)){
        dither_clip( i.scrpos, i.scrpos.z);
    }
    #line 190
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
(76,8): error: illegal use of reserved word `input'
(76,8): error: syntax error, unexpected ERROR_TOK, expecting IDENTIFIER or TYPE_IDENTIFIER or NEW_IDENTIFIER or '{'
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
  GpuProgramID 66547
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
#line 218
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
#line 211
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
#line 235
uniform sampler2D _BumpTex;
uniform highp vec4 _BumpTex_ST;
uniform mediump vec4 _Color;
#line 239
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _SpectrumTexture;
uniform highp float _SpectrumIntensity;
#line 243
uniform highp float _SpectrumBumpScaler;
uniform highp float _SpectrumRangeScaler;
uniform highp float _SpectrumRangeOffset;
uniform highp float _SpectrumViewDistance;
#line 247
uniform mediump vec4 _SpectrumFresnel;
uniform mediump float _EmissionScaler;
uniform mediump float _ReflectionStrength;
#line 251
uniform mediump float _Emission;
uniform mediump float _BumpScaler;
uniform mediump float _Opaqueness;
uniform mediump float _MinAlpha;
#line 256
uniform highp float _BloomFactor;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
#line 260
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
#line 260
v2f vertBump( in input i ) {
    v2f o = v2f(vec4(0.0, 0.0, 0.0, 0.0), vec2(0.0, 0.0), vec2(0.0, 0.0), vec3(0.0, 0.0, 0.0), vec3(0.0, 0.0, 0.0), vec3(0.0, 0.0, 0.0), vec3(0.0, 0.0, 0.0), vec2(0.0, 0.0), vec4(0.0, 0.0, 0.0, 0.0));
    o.uv_main = i.uv_main;
    #line 264
    o.uv_bump = ((i.uv_main.xy * _BumpTex_ST.xy) + _BumpTex_ST.zw);
    mediump float alpha = 1.0;
    o.param.y = (alpha * _Opaqueness);
    #line 269
    highp vec4 objPos = (unity_ObjectToWorld * i.vertex);
    o.viewDir = normalize((_WorldSpaceCameraPos.xyz - objPos.xyz));
    o.pos = UnityObjectToClipPos( i.vertex);
    #line 273
    o.N = (-UnityObjectToWorldNormal( i.normal));
    o.T = vec3( o.N.y, (-o.N.x), 0.0);
    o.T = normalize(o.T);
    o.B = cross( o.N, o.T);
    #line 277
    o.B = normalize(o.B);
    if (bool(_UsingDitherAlpha)){
        #line 281
        o.scrpos = ComputeScreenPos( o.pos);
        o.scrpos.z = _DitherAlpha;
    }
    #line 286
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
(212,8): error: illegal use of reserved word `input'
(212,8): error: syntax error, unexpected ERROR_TOK, expecting IDENTIFIER or TYPE_IDENTIFIER or NEW_IDENTIFIER or '{'
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
#line 218
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
#line 211
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
#line 235
uniform sampler2D _BumpTex;
uniform highp vec4 _BumpTex_ST;
uniform mediump vec4 _Color;
#line 239
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _SpectrumTexture;
uniform highp float _SpectrumIntensity;
#line 243
uniform highp float _SpectrumBumpScaler;
uniform highp float _SpectrumRangeScaler;
uniform highp float _SpectrumRangeOffset;
uniform highp float _SpectrumViewDistance;
#line 247
uniform mediump vec4 _SpectrumFresnel;
uniform mediump float _EmissionScaler;
uniform mediump float _ReflectionStrength;
#line 251
uniform mediump float _Emission;
uniform mediump float _BumpScaler;
uniform mediump float _Opaqueness;
uniform mediump float _MinAlpha;
#line 256
uniform highp float _BloomFactor;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
#line 260
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
#line 289
highp float fresnel( in highp float cs, in highp float power, in highp float scale, in highp float bias ) {
    #line 291
    return (bias + (pow( clamp( (1.0 - cs), 0.0, 1.0), power) * scale));
}
#line 294
mediump vec4 fragBump( in v2f i ) {
    #line 296
    mediump vec4 outColor = vec4( 0.0);
    mediump vec3 baseTexColor = (texture2D( _MainTex, i.uv_main.xy).xyz * _Color.xyz);
    outColor.xyz = ((baseTexColor * _Color.xyz) * vec3( _EnvColor));
    #line 302
    highp vec3 bumpVector = (texture2D( _BumpTex, i.uv_bump.xy).xyz - vec3( 0.5, 0.5, 0.0));
    bumpVector.xy *= _BumpScaler;
    bumpVector = normalize(bumpVector);
    #line 307
    highp vec3 N = (((i.T * bumpVector.x) + (i.B * bumpVector.y)) + (i.N * bumpVector.z));
    highp vec3 V = normalize(i.viewDir);
    mediump float cs = abs(dot( N, V));
    #line 311
    mediump vec2 uv = vec2( ((acos(cs) * _SpectrumRangeScaler) + _SpectrumRangeOffset));
    mediump float f = fresnel( cs, _SpectrumFresnel.x, _SpectrumFresnel.y, _SpectrumFresnel.z);
    mediump vec3 SpectrumColor = vec3( ((texture2D( _SpectrumTexture, uv) * _SpectrumIntensity) * f));
    #line 315
    outColor.xyz = ((outColor.xyz + SpectrumColor) - (outColor.xyz * SpectrumColor));
    outColor.xyz *= _EmissionScaler;
    #line 319
    mediump float afresnel = fresnel( abs(dot( i.N, V)), _SpectrumFresnel.x, _SpectrumFresnel.y, _SpectrumFresnel.z);
    outColor.w = max( min( (((i.param.y * afresnel) * 0.5) * 3.0), 1.0), _MinAlpha);
    #line 323
    if (bool(_UsingDitherAlpha)){
        dither_clip( i.scrpos, i.scrpos.z);
    }
    #line 328
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
(212,8): error: illegal use of reserved word `input'
(212,8): error: syntax error, unexpected ERROR_TOK, expecting IDENTIFIER or TYPE_IDENTIFIER or NEW_IDENTIFIER or '{'
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
#line 218
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
#line 211
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
#line 235
uniform sampler2D _BumpTex;
uniform highp vec4 _BumpTex_ST;
uniform mediump vec4 _Color;
#line 239
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _SpectrumTexture;
uniform highp float _SpectrumIntensity;
#line 243
uniform highp float _SpectrumBumpScaler;
uniform highp float _SpectrumRangeScaler;
uniform highp float _SpectrumRangeOffset;
uniform highp float _SpectrumViewDistance;
#line 247
uniform mediump vec4 _SpectrumFresnel;
uniform mediump float _EmissionScaler;
uniform mediump float _ReflectionStrength;
#line 251
uniform mediump float _Emission;
uniform mediump float _BumpScaler;
uniform mediump float _Opaqueness;
uniform mediump float _MinAlpha;
#line 256
uniform highp float _BloomFactor;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
#line 260
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
#line 260
v2f vertBump( in input i ) {
    v2f o = v2f(vec4(0.0, 0.0, 0.0, 0.0), vec2(0.0, 0.0), vec2(0.0, 0.0), vec3(0.0, 0.0, 0.0), vec3(0.0, 0.0, 0.0), vec3(0.0, 0.0, 0.0), vec3(0.0, 0.0, 0.0), vec2(0.0, 0.0), vec4(0.0, 0.0, 0.0, 0.0));
    o.uv_main = i.uv_main;
    #line 264
    o.uv_bump = ((i.uv_main.xy * _BumpTex_ST.xy) + _BumpTex_ST.zw);
    mediump float alpha = 1.0;
    o.param.y = (alpha * _Opaqueness);
    #line 269
    highp vec4 objPos = (unity_ObjectToWorld * i.vertex);
    o.viewDir = normalize((_WorldSpaceCameraPos.xyz - objPos.xyz));
    o.pos = UnityObjectToClipPos( i.vertex);
    #line 273
    o.N = (-UnityObjectToWorldNormal( i.normal));
    o.T = vec3( o.N.y, (-o.N.x), 0.0);
    o.T = normalize(o.T);
    o.B = cross( o.N, o.T);
    #line 277
    o.B = normalize(o.B);
    if (bool(_UsingDitherAlpha)){
        #line 281
        o.scrpos = ComputeScreenPos( o.pos);
        o.scrpos.z = _DitherAlpha;
    }
    #line 286
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
(212,8): error: illegal use of reserved word `input'
(212,8): error: syntax error, unexpected ERROR_TOK, expecting IDENTIFIER or TYPE_IDENTIFIER or NEW_IDENTIFIER or '{'
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
#line 218
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
#line 211
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
#line 235
uniform sampler2D _BumpTex;
uniform highp vec4 _BumpTex_ST;
uniform mediump vec4 _Color;
#line 239
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _SpectrumTexture;
uniform highp float _SpectrumIntensity;
#line 243
uniform highp float _SpectrumBumpScaler;
uniform highp float _SpectrumRangeScaler;
uniform highp float _SpectrumRangeOffset;
uniform highp float _SpectrumViewDistance;
#line 247
uniform mediump vec4 _SpectrumFresnel;
uniform mediump float _EmissionScaler;
uniform mediump float _ReflectionStrength;
#line 251
uniform mediump float _Emission;
uniform mediump float _BumpScaler;
uniform mediump float _Opaqueness;
uniform mediump float _MinAlpha;
#line 256
uniform highp float _BloomFactor;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
#line 260
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
#line 289
highp float fresnel( in highp float cs, in highp float power, in highp float scale, in highp float bias ) {
    #line 291
    return (bias + (pow( clamp( (1.0 - cs), 0.0, 1.0), power) * scale));
}
#line 294
mediump vec4 fragBump( in v2f i ) {
    #line 296
    mediump vec4 outColor = vec4( 0.0);
    mediump vec3 baseTexColor = (texture2D( _MainTex, i.uv_main.xy).xyz * _Color.xyz);
    outColor.xyz = ((baseTexColor * _Color.xyz) * vec3( _EnvColor));
    #line 302
    highp vec3 bumpVector = (texture2D( _BumpTex, i.uv_bump.xy).xyz - vec3( 0.5, 0.5, 0.0));
    bumpVector.xy *= _BumpScaler;
    bumpVector = normalize(bumpVector);
    #line 307
    highp vec3 N = (((i.T * bumpVector.x) + (i.B * bumpVector.y)) + (i.N * bumpVector.z));
    highp vec3 V = normalize(i.viewDir);
    mediump float cs = abs(dot( N, V));
    #line 311
    mediump vec2 uv = vec2( ((acos(cs) * _SpectrumRangeScaler) + _SpectrumRangeOffset));
    mediump float f = fresnel( cs, _SpectrumFresnel.x, _SpectrumFresnel.y, _SpectrumFresnel.z);
    mediump vec3 SpectrumColor = vec3( ((texture2D( _SpectrumTexture, uv) * _SpectrumIntensity) * f));
    #line 315
    outColor.xyz = ((outColor.xyz + SpectrumColor) - (outColor.xyz * SpectrumColor));
    outColor.xyz *= _EmissionScaler;
    #line 319
    mediump float afresnel = fresnel( abs(dot( i.N, V)), _SpectrumFresnel.x, _SpectrumFresnel.y, _SpectrumFresnel.z);
    outColor.w = max( min( (((i.param.y * afresnel) * 0.5) * 3.0), 1.0), _MinAlpha);
    #line 323
    if (bool(_UsingDitherAlpha)){
        dither_clip( i.scrpos, i.scrpos.z);
    }
    #line 328
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
(212,8): error: illegal use of reserved word `input'
(212,8): error: syntax error, unexpected ERROR_TOK, expecting IDENTIFIER or TYPE_IDENTIFIER or NEW_IDENTIFIER or '{'
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
#line 218
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
#line 211
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
#line 235
uniform sampler2D _BumpTex;
uniform highp vec4 _BumpTex_ST;
uniform mediump vec4 _Color;
#line 239
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _SpectrumTexture;
uniform highp float _SpectrumIntensity;
#line 243
uniform highp float _SpectrumBumpScaler;
uniform highp float _SpectrumRangeScaler;
uniform highp float _SpectrumRangeOffset;
uniform highp float _SpectrumViewDistance;
#line 247
uniform mediump vec4 _SpectrumFresnel;
uniform mediump float _EmissionScaler;
uniform mediump float _ReflectionStrength;
#line 251
uniform mediump float _Emission;
uniform mediump float _BumpScaler;
uniform mediump float _Opaqueness;
uniform mediump float _MinAlpha;
#line 256
uniform highp float _BloomFactor;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
#line 260
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
#line 260
v2f vertBump( in input i ) {
    v2f o = v2f(vec4(0.0, 0.0, 0.0, 0.0), vec2(0.0, 0.0), vec2(0.0, 0.0), vec3(0.0, 0.0, 0.0), vec3(0.0, 0.0, 0.0), vec3(0.0, 0.0, 0.0), vec3(0.0, 0.0, 0.0), vec2(0.0, 0.0), vec4(0.0, 0.0, 0.0, 0.0));
    o.uv_main = i.uv_main;
    #line 264
    o.uv_bump = ((i.uv_main.xy * _BumpTex_ST.xy) + _BumpTex_ST.zw);
    mediump float alpha = 1.0;
    o.param.y = (alpha * _Opaqueness);
    #line 269
    highp vec4 objPos = (unity_ObjectToWorld * i.vertex);
    o.viewDir = normalize((_WorldSpaceCameraPos.xyz - objPos.xyz));
    o.pos = UnityObjectToClipPos( i.vertex);
    #line 273
    o.N = (-UnityObjectToWorldNormal( i.normal));
    o.T = vec3( o.N.y, (-o.N.x), 0.0);
    o.T = normalize(o.T);
    o.B = cross( o.N, o.T);
    #line 277
    o.B = normalize(o.B);
    if (bool(_UsingDitherAlpha)){
        #line 281
        o.scrpos = ComputeScreenPos( o.pos);
        o.scrpos.z = _DitherAlpha;
    }
    #line 286
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
(212,8): error: illegal use of reserved word `input'
(212,8): error: syntax error, unexpected ERROR_TOK, expecting IDENTIFIER or TYPE_IDENTIFIER or NEW_IDENTIFIER or '{'
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
#line 218
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
#line 211
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
#line 235
uniform sampler2D _BumpTex;
uniform highp vec4 _BumpTex_ST;
uniform mediump vec4 _Color;
#line 239
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _SpectrumTexture;
uniform highp float _SpectrumIntensity;
#line 243
uniform highp float _SpectrumBumpScaler;
uniform highp float _SpectrumRangeScaler;
uniform highp float _SpectrumRangeOffset;
uniform highp float _SpectrumViewDistance;
#line 247
uniform mediump vec4 _SpectrumFresnel;
uniform mediump float _EmissionScaler;
uniform mediump float _ReflectionStrength;
#line 251
uniform mediump float _Emission;
uniform mediump float _BumpScaler;
uniform mediump float _Opaqueness;
uniform mediump float _MinAlpha;
#line 256
uniform highp float _BloomFactor;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
#line 260
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
#line 289
highp float fresnel( in highp float cs, in highp float power, in highp float scale, in highp float bias ) {
    #line 291
    return (bias + (pow( clamp( (1.0 - cs), 0.0, 1.0), power) * scale));
}
#line 294
mediump vec4 fragBump( in v2f i ) {
    #line 296
    mediump vec4 outColor = vec4( 0.0);
    mediump vec3 baseTexColor = (texture2D( _MainTex, i.uv_main.xy).xyz * _Color.xyz);
    outColor.xyz = ((baseTexColor * _Color.xyz) * vec3( _EnvColor));
    #line 302
    highp vec3 bumpVector = (texture2D( _BumpTex, i.uv_bump.xy).xyz - vec3( 0.5, 0.5, 0.0));
    bumpVector.xy *= _BumpScaler;
    bumpVector = normalize(bumpVector);
    #line 307
    highp vec3 N = (((i.T * bumpVector.x) + (i.B * bumpVector.y)) + (i.N * bumpVector.z));
    highp vec3 V = normalize(i.viewDir);
    mediump float cs = abs(dot( N, V));
    #line 311
    mediump vec2 uv = vec2( ((acos(cs) * _SpectrumRangeScaler) + _SpectrumRangeOffset));
    mediump float f = fresnel( cs, _SpectrumFresnel.x, _SpectrumFresnel.y, _SpectrumFresnel.z);
    mediump vec3 SpectrumColor = vec3( ((texture2D( _SpectrumTexture, uv) * _SpectrumIntensity) * f));
    #line 315
    outColor.xyz = ((outColor.xyz + SpectrumColor) - (outColor.xyz * SpectrumColor));
    outColor.xyz *= _EmissionScaler;
    #line 319
    mediump float afresnel = fresnel( abs(dot( i.N, V)), _SpectrumFresnel.x, _SpectrumFresnel.y, _SpectrumFresnel.z);
    outColor.w = max( min( (((i.param.y * afresnel) * 0.5) * 3.0), 1.0), _MinAlpha);
    #line 323
    if (bool(_UsingDitherAlpha)){
        dither_clip( i.scrpos, i.scrpos.z);
    }
    #line 328
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
(212,8): error: illegal use of reserved word `input'
(212,8): error: syntax error, unexpected ERROR_TOK, expecting IDENTIFIER or TYPE_IDENTIFIER or NEW_IDENTIFIER or '{'
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
  GpuProgramID 142552
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
}
CustomEditor "MoleMole.CharacterShaderEditorBase"
}