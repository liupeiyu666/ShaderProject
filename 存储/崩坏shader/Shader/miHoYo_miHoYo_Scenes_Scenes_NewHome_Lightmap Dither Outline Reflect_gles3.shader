//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_NewHome/Lightmap Dither Outline Reflect" {
Properties {
_LightMapIntensity ("Light Map Intensity", Float) = 1
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Color Tex (RGB)", 2D) = "white" { }
_ShadowTex ("LightMap (RGB)", 2D) = "grey" { }
_FogTune ("Fog Tune", Range(0, 1)) = 1
_ReflectionTex ("Reflection", 2D) = "white" { }
_ReflectionEmissionAdjust ("Reflection Emission Adjust", Float) = 1
_FresnelParams ("Fresnel Parameters", Vector) = (1,1,0,0)
[Toggle(USINGDITHERALPAH)] _UsingDitherAlpha ("UsingDitherAlpha", Float) = 0
_DitherAlpha ("Dither Alpha Value", Range(0, 1)) = 1
_Culling ("Culling (0: Off, 1: Front, 2: Back)", Float) = 2
_OutlineWidth ("Outline Width", Range(0, 100)) = 0.2
_OutlineColor ("Outline Color", Color) = (0,0,0,1)
_MaxOutlineZOffset ("Max Outline Z Offset", Range(0, 100)) = 1
_Color ("Main Color", Color) = (1,1,1,1)
_Scale ("Scale Compared to Maya", Float) = 0.01
_ClipPlane ("Clip Plane (Model Space)", Vector) = (0,0,0,0)
[Toggle] _UseCameraFade ("Use Camera Fade", Float) = 0
_FadeDistance ("Fade Start Distance", Range(0.1, 10)) = 0
_FadeOffset ("Fade Start Offset", Range(0, 10)) = 0
_VertexAlphaFactor ("Alpha From Vertex Factor (0: not use)", Range(0, 1)) = 0
_Opaqueness ("Opaqueness", Range(0, 1)) = 1
[Toggle(USINGDITHERALPAH)] _UsingDitherAlpha ("UsingDitherAlpha", Float) = 0
_DitherAlpha ("Dither Alpha Value", Range(0, 1)) = 1
}
SubShader {
 LOD 200
 Tags { "DrawDepth" = "FrontFace" "OutlineType" = "Complex" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "BASE"
  LOD 200
  Tags { "DrawDepth" = "FrontFace" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "Complex" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 49511
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
bvec2 u_xlatb6;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(_DitherAlpha<0.949999988);
#else
        u_xlatb0 = _DitherAlpha<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb6.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb6.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb6.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = _DitherAlpha * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_2.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = (-u_xlat10_1.www) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(_LightMapIntensity);
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
bvec2 u_xlatb6;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(_DitherAlpha<0.949999988);
#else
        u_xlatb0 = _DitherAlpha<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb6.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb6.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb6.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = _DitherAlpha * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_2.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = (-u_xlat10_1.www) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(_LightMapIntensity);
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
bvec2 u_xlatb6;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(_DitherAlpha<0.949999988);
#else
        u_xlatb0 = _DitherAlpha<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb6.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb6.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb6.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = _DitherAlpha * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_2.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = (-u_xlat10_1.www) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(_LightMapIntensity);
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
uniform 	vec4 _FresnelParams;
uniform 	mediump float _ReflectionEmissionAdjust;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _ReflectionTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_7;
vec2 u_xlat8;
int u_xlati8;
uvec2 u_xlatu8;
bool u_xlatb8;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb8){
#ifdef UNITY_ADRENO_ES3
        u_xlatb8 = !!(_DitherAlpha<0.949999988);
#else
        u_xlatb8 = _DitherAlpha<0.949999988;
#endif
        if(u_xlatb8){
            u_xlat8.xy = u_xlat0.yx * _ScreenParams.yx;
            u_xlat8.xy = u_xlat8.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat8.xyxx, (-u_xlat8.xyxx)).xy;
            u_xlat8.xy = fract(abs(u_xlat8.xy));
            u_xlat8.x = (u_xlatb1.x) ? u_xlat8.x : (-u_xlat8.x);
            u_xlat8.y = (u_xlatb1.y) ? u_xlat8.y : (-u_xlat8.y);
            u_xlat8.xy = u_xlat8.xy * vec2(4.0, 4.0);
            u_xlatu8.xy = uvec2(u_xlat8.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu8.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu8.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu8.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu8.y)]);
            u_xlat8.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu8.x)]);
            u_xlat8.x = _DitherAlpha * 17.0 + (-u_xlat8.x);
            u_xlat8.x = u_xlat8.x + 0.99000001;
            u_xlat8.x = floor(u_xlat8.x);
            u_xlat8.x = max(u_xlat8.x, 0.0);
            u_xlati8 = int(u_xlat8.x);
            if((u_xlati8)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_2.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_2.www) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * u_xlat16_3.xyz;
    u_xlat1.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat8.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat2.xyz = u_xlat8.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot(u_xlat2.xyz, vs_TEXCOORD4.xyz);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelParams.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelParams.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + _FresnelParams.z;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat0.xy).xyz;
    u_xlat16_7.xyz = u_xlat10_0.xyz * vec3(_ReflectionEmissionAdjust);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat10_1.www + (-u_xlat1.xyz);
    SV_Target0.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz + u_xlat1.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
uniform 	vec4 _FresnelParams;
uniform 	mediump float _ReflectionEmissionAdjust;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _ReflectionTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_7;
vec2 u_xlat8;
int u_xlati8;
uvec2 u_xlatu8;
bool u_xlatb8;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb8){
#ifdef UNITY_ADRENO_ES3
        u_xlatb8 = !!(_DitherAlpha<0.949999988);
#else
        u_xlatb8 = _DitherAlpha<0.949999988;
#endif
        if(u_xlatb8){
            u_xlat8.xy = u_xlat0.yx * _ScreenParams.yx;
            u_xlat8.xy = u_xlat8.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat8.xyxx, (-u_xlat8.xyxx)).xy;
            u_xlat8.xy = fract(abs(u_xlat8.xy));
            u_xlat8.x = (u_xlatb1.x) ? u_xlat8.x : (-u_xlat8.x);
            u_xlat8.y = (u_xlatb1.y) ? u_xlat8.y : (-u_xlat8.y);
            u_xlat8.xy = u_xlat8.xy * vec2(4.0, 4.0);
            u_xlatu8.xy = uvec2(u_xlat8.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu8.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu8.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu8.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu8.y)]);
            u_xlat8.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu8.x)]);
            u_xlat8.x = _DitherAlpha * 17.0 + (-u_xlat8.x);
            u_xlat8.x = u_xlat8.x + 0.99000001;
            u_xlat8.x = floor(u_xlat8.x);
            u_xlat8.x = max(u_xlat8.x, 0.0);
            u_xlati8 = int(u_xlat8.x);
            if((u_xlati8)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_2.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_2.www) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * u_xlat16_3.xyz;
    u_xlat1.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat8.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat2.xyz = u_xlat8.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot(u_xlat2.xyz, vs_TEXCOORD4.xyz);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelParams.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelParams.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + _FresnelParams.z;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat0.xy).xyz;
    u_xlat16_7.xyz = u_xlat10_0.xyz * vec3(_ReflectionEmissionAdjust);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat10_1.www + (-u_xlat1.xyz);
    SV_Target0.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz + u_xlat1.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
uniform 	vec4 _FresnelParams;
uniform 	mediump float _ReflectionEmissionAdjust;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _ReflectionTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_7;
vec2 u_xlat8;
int u_xlati8;
uvec2 u_xlatu8;
bool u_xlatb8;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb8){
#ifdef UNITY_ADRENO_ES3
        u_xlatb8 = !!(_DitherAlpha<0.949999988);
#else
        u_xlatb8 = _DitherAlpha<0.949999988;
#endif
        if(u_xlatb8){
            u_xlat8.xy = u_xlat0.yx * _ScreenParams.yx;
            u_xlat8.xy = u_xlat8.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat8.xyxx, (-u_xlat8.xyxx)).xy;
            u_xlat8.xy = fract(abs(u_xlat8.xy));
            u_xlat8.x = (u_xlatb1.x) ? u_xlat8.x : (-u_xlat8.x);
            u_xlat8.y = (u_xlatb1.y) ? u_xlat8.y : (-u_xlat8.y);
            u_xlat8.xy = u_xlat8.xy * vec2(4.0, 4.0);
            u_xlatu8.xy = uvec2(u_xlat8.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu8.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu8.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu8.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu8.y)]);
            u_xlat8.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu8.x)]);
            u_xlat8.x = _DitherAlpha * 17.0 + (-u_xlat8.x);
            u_xlat8.x = u_xlat8.x + 0.99000001;
            u_xlat8.x = floor(u_xlat8.x);
            u_xlat8.x = max(u_xlat8.x, 0.0);
            u_xlati8 = int(u_xlat8.x);
            if((u_xlati8)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_2.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_2.www) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * u_xlat16_3.xyz;
    u_xlat1.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat8.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat2.xyz = u_xlat8.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot(u_xlat2.xyz, vs_TEXCOORD4.xyz);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelParams.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelParams.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + _FresnelParams.z;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat0.xy).xyz;
    u_xlat16_7.xyz = u_xlat10_0.xyz * vec3(_ReflectionEmissionAdjust);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat10_1.www + (-u_xlat1.xyz);
    SV_Target0.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz + u_xlat1.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
bvec2 u_xlatb6;
float u_xlat9;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(_DitherAlpha<0.949999988);
#else
        u_xlatb0 = _DitherAlpha<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb6.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb6.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb6.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = _DitherAlpha * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_2.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = (-u_xlat10_1.www) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(_LightMapIntensity);
    u_xlat9 = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat1.xyz = (-u_xlat16_2.xyz) * vec3(_LightMapIntensity) + vec3(u_xlat9);
    u_xlat0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
bvec2 u_xlatb6;
float u_xlat9;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(_DitherAlpha<0.949999988);
#else
        u_xlatb0 = _DitherAlpha<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb6.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb6.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb6.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = _DitherAlpha * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_2.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = (-u_xlat10_1.www) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(_LightMapIntensity);
    u_xlat9 = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat1.xyz = (-u_xlat16_2.xyz) * vec3(_LightMapIntensity) + vec3(u_xlat9);
    u_xlat0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
bvec2 u_xlatb6;
float u_xlat9;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(_DitherAlpha<0.949999988);
#else
        u_xlatb0 = _DitherAlpha<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb6.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb6.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb6.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = _DitherAlpha * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_2.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = (-u_xlat10_1.www) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(_LightMapIntensity);
    u_xlat9 = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat1.xyz = (-u_xlat16_2.xyz) * vec3(_LightMapIntensity) + vec3(u_xlat9);
    u_xlat0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
uniform 	mediump float _LumiFactor;
uniform 	vec4 _FresnelParams;
uniform 	mediump float _ReflectionEmissionAdjust;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _ReflectionTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_7;
vec2 u_xlat8;
int u_xlati8;
uvec2 u_xlatu8;
bool u_xlatb8;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb8){
#ifdef UNITY_ADRENO_ES3
        u_xlatb8 = !!(_DitherAlpha<0.949999988);
#else
        u_xlatb8 = _DitherAlpha<0.949999988;
#endif
        if(u_xlatb8){
            u_xlat8.xy = u_xlat0.yx * _ScreenParams.yx;
            u_xlat8.xy = u_xlat8.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat8.xyxx, (-u_xlat8.xyxx)).xy;
            u_xlat8.xy = fract(abs(u_xlat8.xy));
            u_xlat8.x = (u_xlatb1.x) ? u_xlat8.x : (-u_xlat8.x);
            u_xlat8.y = (u_xlatb1.y) ? u_xlat8.y : (-u_xlat8.y);
            u_xlat8.xy = u_xlat8.xy * vec2(4.0, 4.0);
            u_xlatu8.xy = uvec2(u_xlat8.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu8.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu8.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu8.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu8.y)]);
            u_xlat8.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu8.x)]);
            u_xlat8.x = _DitherAlpha * 17.0 + (-u_xlat8.x);
            u_xlat8.x = u_xlat8.x + 0.99000001;
            u_xlat8.x = floor(u_xlat8.x);
            u_xlat8.x = max(u_xlat8.x, 0.0);
            u_xlati8 = int(u_xlat8.x);
            if((u_xlati8)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_2.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_2.www) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * u_xlat16_3.xyz;
    u_xlat1.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat8.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat2.xyz = u_xlat8.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot(u_xlat2.xyz, vs_TEXCOORD4.xyz);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelParams.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelParams.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + _FresnelParams.z;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat0.xy).xyz;
    u_xlat16_7.xyz = u_xlat10_0.xyz * vec3(_ReflectionEmissionAdjust);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat10_1.www + (-u_xlat1.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz + u_xlat1.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
uniform 	mediump float _LumiFactor;
uniform 	vec4 _FresnelParams;
uniform 	mediump float _ReflectionEmissionAdjust;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _ReflectionTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_7;
vec2 u_xlat8;
int u_xlati8;
uvec2 u_xlatu8;
bool u_xlatb8;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb8){
#ifdef UNITY_ADRENO_ES3
        u_xlatb8 = !!(_DitherAlpha<0.949999988);
#else
        u_xlatb8 = _DitherAlpha<0.949999988;
#endif
        if(u_xlatb8){
            u_xlat8.xy = u_xlat0.yx * _ScreenParams.yx;
            u_xlat8.xy = u_xlat8.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat8.xyxx, (-u_xlat8.xyxx)).xy;
            u_xlat8.xy = fract(abs(u_xlat8.xy));
            u_xlat8.x = (u_xlatb1.x) ? u_xlat8.x : (-u_xlat8.x);
            u_xlat8.y = (u_xlatb1.y) ? u_xlat8.y : (-u_xlat8.y);
            u_xlat8.xy = u_xlat8.xy * vec2(4.0, 4.0);
            u_xlatu8.xy = uvec2(u_xlat8.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu8.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu8.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu8.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu8.y)]);
            u_xlat8.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu8.x)]);
            u_xlat8.x = _DitherAlpha * 17.0 + (-u_xlat8.x);
            u_xlat8.x = u_xlat8.x + 0.99000001;
            u_xlat8.x = floor(u_xlat8.x);
            u_xlat8.x = max(u_xlat8.x, 0.0);
            u_xlati8 = int(u_xlat8.x);
            if((u_xlati8)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_2.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_2.www) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * u_xlat16_3.xyz;
    u_xlat1.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat8.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat2.xyz = u_xlat8.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot(u_xlat2.xyz, vs_TEXCOORD4.xyz);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelParams.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelParams.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + _FresnelParams.z;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat0.xy).xyz;
    u_xlat16_7.xyz = u_xlat10_0.xyz * vec3(_ReflectionEmissionAdjust);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat10_1.www + (-u_xlat1.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz + u_xlat1.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
uniform 	mediump float _LumiFactor;
uniform 	vec4 _FresnelParams;
uniform 	mediump float _ReflectionEmissionAdjust;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _ReflectionTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_7;
vec2 u_xlat8;
int u_xlati8;
uvec2 u_xlatu8;
bool u_xlatb8;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb8){
#ifdef UNITY_ADRENO_ES3
        u_xlatb8 = !!(_DitherAlpha<0.949999988);
#else
        u_xlatb8 = _DitherAlpha<0.949999988;
#endif
        if(u_xlatb8){
            u_xlat8.xy = u_xlat0.yx * _ScreenParams.yx;
            u_xlat8.xy = u_xlat8.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat8.xyxx, (-u_xlat8.xyxx)).xy;
            u_xlat8.xy = fract(abs(u_xlat8.xy));
            u_xlat8.x = (u_xlatb1.x) ? u_xlat8.x : (-u_xlat8.x);
            u_xlat8.y = (u_xlatb1.y) ? u_xlat8.y : (-u_xlat8.y);
            u_xlat8.xy = u_xlat8.xy * vec2(4.0, 4.0);
            u_xlatu8.xy = uvec2(u_xlat8.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu8.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu8.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu8.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu8.y)]);
            u_xlat8.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu8.x)]);
            u_xlat8.x = _DitherAlpha * 17.0 + (-u_xlat8.x);
            u_xlat8.x = u_xlat8.x + 0.99000001;
            u_xlat8.x = floor(u_xlat8.x);
            u_xlat8.x = max(u_xlat8.x, 0.0);
            u_xlati8 = int(u_xlat8.x);
            if((u_xlati8)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_2.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_2.www) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * u_xlat16_3.xyz;
    u_xlat1.xyz = u_xlat16_3.xyz * vec3(_LightMapIntensity);
    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat8.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat2.xyz = u_xlat8.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot(u_xlat2.xyz, vs_TEXCOORD4.xyz);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelParams.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelParams.y;
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + _FresnelParams.z;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat0.xy).xyz;
    u_xlat16_7.xyz = u_xlat10_0.xyz * vec3(_ReflectionEmissionAdjust);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat10_1.www + (-u_xlat1.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz + u_xlat1.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 hw_tier00 " {
""
}
SubProgram "gles3 hw_tier01 " {
""
}
SubProgram "gles3 hw_tier02 " {
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" }
""
}
}
}
 UsePass "miHoYo/miHoYo_Scenes/Scenes_NewHome/Texture Dither Outline/COMPLEX"
}
Fallback "Diffuse"
}