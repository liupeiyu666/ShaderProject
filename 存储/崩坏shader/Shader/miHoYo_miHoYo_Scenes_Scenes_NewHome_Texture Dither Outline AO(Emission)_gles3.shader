//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_NewHome/Texture Dither Outline AO(Emission)" {
Properties {
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Base (RGB) Trans (A)", 2D) = "white" { }
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
_EmissionTintColor ("Emission Color", Color) = (1,1,1,1)
_EmissionScaler ("Emission Scaler", Range(1, 10)) = 1
_EmissionFactor ("Emission Factor (lerp factor between original and emission color)", Range(0, 1)) = 0
_EmissionFactorFromTexToggle ("Emission Factor From Tex Toggle", Range(0, 1)) = 0
_EmissionBloomFactor ("Emission Bloom Factor", Float) = 1
_Opaqueness ("Opaqueness", Range(0, 1)) = 1
[Toggle(USINGDITHERALPAH)] _UsingDitherAlpha ("UsingDitherAlpha", Float) = 0
_DitherAlpha ("Dither Alpha Value", Range(0, 1)) = 1
_AOColor ("AO Color (RGB) Intensity (A)", Color) = (0.2,0.2,0.2,1)
_AOTex ("AO Texture", 2D) = "white" { }
_AOMask ("AO Mask (X: Left, Y: Right, Z: Front, W: Back)", Vector) = (0,0,0,0)
[Toggle(ENABLE_REFLECTION)] _EnableReflection ("Enable Reflection", Float) = 0
_EnvTex ("Environment Texture (RGB)", Cube) = "grey" { }
_Reflectivity ("Reflectivity", Range(0, 5)) = 1
_CamDistRatio ("Camera Distance Ratio", Range(0, 1)) = 0.1
_CamHeightOffset ("Camera Height", Float) = 5
_CamRotate ("Camera Rotate", Range(-3.14159, 3.14159)) = 0
}
SubShader {
 LOD 100
 Tags { "DrawDepth" = "FrontFace" "IGNOREPROJECTOR" = "true" "OutlineType" = "Complex" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  LOD 100
  Tags { "DrawDepth" = "FrontFace" "IGNOREPROJECTOR" = "true" "OutlineType" = "Complex" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 31742
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _UsingDitherAlpha;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.zw = in_TEXCOORD1.xy;
    phase0_Output0_1 = u_xlat1;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb1 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2 = mix(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0, vec4(bvec4(u_xlatb1)));
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump float _BloomFactor;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	mediump vec4 _AOColor;
uniform 	mediump vec4 _AOMask;
uniform 	mediump vec4 _EmissionTintColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AOTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
bvec2 u_xlatb8;
mediump float u_xlat16_12;
mediump float u_xlat16_14;
mediump float u_xlat16_15;
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
            u_xlatb8.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb8.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.xyz * _EmissionTintColor.xyz;
    u_xlat16_12 = u_xlat10_0.w + (-_EmissionFactor);
    u_xlat16_12 = _EmissionFactorFromTexToggle * u_xlat16_12 + _EmissionFactor;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler) + (-u_xlat10_0.xyz);
    u_xlat16_2.xyz = vec3(u_xlat16_12) * u_xlat16_2.xyz + u_xlat10_0.xyz;
    u_xlat10_0 = texture(_AOTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = (-u_xlat10_0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1 = u_xlat16_1 * _AOMask;
    u_xlat16_14 = max(u_xlat16_1.w, u_xlat16_1.z);
    u_xlat16_14 = max(u_xlat16_1.y, u_xlat16_14);
    u_xlat16_14 = max(u_xlat16_1.x, u_xlat16_14);
    u_xlat16_3.x = max(u_xlat10_0.w, u_xlat10_0.z);
    u_xlat16_3.x = max(u_xlat10_0.y, u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat10_0.x, u_xlat16_3.x);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_14 = max(u_xlat16_14, u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_2.xyz * _AOColor.xyz;
    u_xlat16_14 = u_xlat16_14 * _AOColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_15 = (-u_xlat16_14) + 1.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_15);
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_14) + u_xlat16_2.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _UsingDitherAlpha;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.zw = in_TEXCOORD1.xy;
    phase0_Output0_1 = u_xlat1;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb1 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2 = mix(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0, vec4(bvec4(u_xlatb1)));
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump float _BloomFactor;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	mediump vec4 _AOColor;
uniform 	mediump vec4 _AOMask;
uniform 	mediump vec4 _EmissionTintColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AOTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
bvec2 u_xlatb8;
mediump float u_xlat16_12;
mediump float u_xlat16_14;
mediump float u_xlat16_15;
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
            u_xlatb8.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb8.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.xyz * _EmissionTintColor.xyz;
    u_xlat16_12 = u_xlat10_0.w + (-_EmissionFactor);
    u_xlat16_12 = _EmissionFactorFromTexToggle * u_xlat16_12 + _EmissionFactor;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler) + (-u_xlat10_0.xyz);
    u_xlat16_2.xyz = vec3(u_xlat16_12) * u_xlat16_2.xyz + u_xlat10_0.xyz;
    u_xlat10_0 = texture(_AOTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = (-u_xlat10_0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1 = u_xlat16_1 * _AOMask;
    u_xlat16_14 = max(u_xlat16_1.w, u_xlat16_1.z);
    u_xlat16_14 = max(u_xlat16_1.y, u_xlat16_14);
    u_xlat16_14 = max(u_xlat16_1.x, u_xlat16_14);
    u_xlat16_3.x = max(u_xlat10_0.w, u_xlat10_0.z);
    u_xlat16_3.x = max(u_xlat10_0.y, u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat10_0.x, u_xlat16_3.x);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_14 = max(u_xlat16_14, u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_2.xyz * _AOColor.xyz;
    u_xlat16_14 = u_xlat16_14 * _AOColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_15 = (-u_xlat16_14) + 1.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_15);
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_14) + u_xlat16_2.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _UsingDitherAlpha;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.zw = in_TEXCOORD1.xy;
    phase0_Output0_1 = u_xlat1;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb1 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2 = mix(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0, vec4(bvec4(u_xlatb1)));
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump float _BloomFactor;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	mediump vec4 _AOColor;
uniform 	mediump vec4 _AOMask;
uniform 	mediump vec4 _EmissionTintColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AOTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
bvec2 u_xlatb8;
mediump float u_xlat16_12;
mediump float u_xlat16_14;
mediump float u_xlat16_15;
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
            u_xlatb8.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb8.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.xyz * _EmissionTintColor.xyz;
    u_xlat16_12 = u_xlat10_0.w + (-_EmissionFactor);
    u_xlat16_12 = _EmissionFactorFromTexToggle * u_xlat16_12 + _EmissionFactor;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler) + (-u_xlat10_0.xyz);
    u_xlat16_2.xyz = vec3(u_xlat16_12) * u_xlat16_2.xyz + u_xlat10_0.xyz;
    u_xlat10_0 = texture(_AOTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = (-u_xlat10_0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1 = u_xlat16_1 * _AOMask;
    u_xlat16_14 = max(u_xlat16_1.w, u_xlat16_1.z);
    u_xlat16_14 = max(u_xlat16_1.y, u_xlat16_14);
    u_xlat16_14 = max(u_xlat16_1.x, u_xlat16_14);
    u_xlat16_3.x = max(u_xlat10_0.w, u_xlat10_0.z);
    u_xlat16_3.x = max(u_xlat10_0.y, u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat10_0.x, u_xlat16_3.x);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_14 = max(u_xlat16_14, u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_2.xyz * _AOColor.xyz;
    u_xlat16_14 = u_xlat16_14 * _AOColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_15 = (-u_xlat16_14) + 1.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_15);
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_14) + u_xlat16_2.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ENABLE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_4;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.zw = in_TEXCOORD1.xy;
    phase0_Output0_1 = u_xlat2;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2 = mix(vec4(0.0, 0.0, 0.0, 0.0), u_xlat1, vec4(bvec4(u_xlatb15)));
    vs_TEXCOORD3.xyz = in_NORMAL0.xyz;
    u_xlat1.xy = u_xlat0.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat1.xz = (-u_xlat1.xy) * vec2(vec2(_CamDistRatio, _CamDistRatio)) + u_xlat0.xz;
    u_xlat1.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat1.y = u_xlat0.y;
    u_xlat16_3 = sin(_CamRotate);
    u_xlat16_4.x = cos(_CamRotate);
    u_xlat2.x = (-u_xlat16_3);
    u_xlat16_4.y = u_xlat16_3;
    u_xlat1.x = dot(u_xlat16_4.xy, u_xlat0.xz);
    u_xlat2.y = u_xlat16_4.x;
    u_xlat1.z = dot(u_xlat2.xy, u_xlat0.xz);
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump float _BloomFactor;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	mediump vec4 _AOColor;
uniform 	mediump vec4 _AOMask;
uniform 	mediump float _Reflectivity;
uniform 	mediump vec4 _EmissionTintColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AOTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
bvec2 u_xlatb8;
mediump float u_xlat16_14;
mediump float u_xlat16_15;
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
            u_xlatb8.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb8.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.xyz * _EmissionTintColor.xyz;
    u_xlat16_1 = u_xlat10_0.w + (-_EmissionFactor);
    u_xlat16_1 = _EmissionFactorFromTexToggle * u_xlat16_1 + _EmissionFactor;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler) + (-u_xlat10_0.xyz);
    u_xlat16_2.xyz = vec3(u_xlat16_1) * u_xlat16_2.xyz + u_xlat10_0.xyz;
    u_xlat10_1 = texture(_AOTex, vs_TEXCOORD1.xy);
    u_xlat16_3 = (-u_xlat10_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3 = u_xlat16_3 * _AOMask;
    u_xlat16_14 = max(u_xlat16_3.w, u_xlat16_3.z);
    u_xlat16_14 = max(u_xlat16_14, u_xlat16_3.y);
    u_xlat16_14 = max(u_xlat16_14, u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat10_1.w, u_xlat10_1.z);
    u_xlat16_3.x = max(u_xlat10_1.y, u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat10_1.x, u_xlat16_3.x);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_14 = max(u_xlat16_14, u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_2.xyz * _AOColor.xyz;
    u_xlat16_14 = u_xlat16_14 * _AOColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_15 = (-u_xlat16_14) + 1.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_15);
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_14) + u_xlat16_2.xyz;
    u_xlat16_14 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_14 = u_xlat16_14 + u_xlat16_14;
    u_xlat16_3.xyz = vs_TEXCOORD3.xyz * (-vec3(u_xlat16_14)) + vs_TEXCOORD4.xyz;
    u_xlat10_0.xyz = texture(_EnvTex, u_xlat16_3.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.www * u_xlat10_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_Reflectivity, _Reflectivity, _Reflectivity)) + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ENABLE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_4;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.zw = in_TEXCOORD1.xy;
    phase0_Output0_1 = u_xlat2;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2 = mix(vec4(0.0, 0.0, 0.0, 0.0), u_xlat1, vec4(bvec4(u_xlatb15)));
    vs_TEXCOORD3.xyz = in_NORMAL0.xyz;
    u_xlat1.xy = u_xlat0.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat1.xz = (-u_xlat1.xy) * vec2(vec2(_CamDistRatio, _CamDistRatio)) + u_xlat0.xz;
    u_xlat1.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat1.y = u_xlat0.y;
    u_xlat16_3 = sin(_CamRotate);
    u_xlat16_4.x = cos(_CamRotate);
    u_xlat2.x = (-u_xlat16_3);
    u_xlat16_4.y = u_xlat16_3;
    u_xlat1.x = dot(u_xlat16_4.xy, u_xlat0.xz);
    u_xlat2.y = u_xlat16_4.x;
    u_xlat1.z = dot(u_xlat2.xy, u_xlat0.xz);
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump float _BloomFactor;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	mediump vec4 _AOColor;
uniform 	mediump vec4 _AOMask;
uniform 	mediump float _Reflectivity;
uniform 	mediump vec4 _EmissionTintColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AOTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
bvec2 u_xlatb8;
mediump float u_xlat16_14;
mediump float u_xlat16_15;
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
            u_xlatb8.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb8.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.xyz * _EmissionTintColor.xyz;
    u_xlat16_1 = u_xlat10_0.w + (-_EmissionFactor);
    u_xlat16_1 = _EmissionFactorFromTexToggle * u_xlat16_1 + _EmissionFactor;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler) + (-u_xlat10_0.xyz);
    u_xlat16_2.xyz = vec3(u_xlat16_1) * u_xlat16_2.xyz + u_xlat10_0.xyz;
    u_xlat10_1 = texture(_AOTex, vs_TEXCOORD1.xy);
    u_xlat16_3 = (-u_xlat10_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3 = u_xlat16_3 * _AOMask;
    u_xlat16_14 = max(u_xlat16_3.w, u_xlat16_3.z);
    u_xlat16_14 = max(u_xlat16_14, u_xlat16_3.y);
    u_xlat16_14 = max(u_xlat16_14, u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat10_1.w, u_xlat10_1.z);
    u_xlat16_3.x = max(u_xlat10_1.y, u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat10_1.x, u_xlat16_3.x);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_14 = max(u_xlat16_14, u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_2.xyz * _AOColor.xyz;
    u_xlat16_14 = u_xlat16_14 * _AOColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_15 = (-u_xlat16_14) + 1.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_15);
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_14) + u_xlat16_2.xyz;
    u_xlat16_14 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_14 = u_xlat16_14 + u_xlat16_14;
    u_xlat16_3.xyz = vs_TEXCOORD3.xyz * (-vec3(u_xlat16_14)) + vs_TEXCOORD4.xyz;
    u_xlat10_0.xyz = texture(_EnvTex, u_xlat16_3.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.www * u_xlat10_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_Reflectivity, _Reflectivity, _Reflectivity)) + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ENABLE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_4;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.zw = in_TEXCOORD1.xy;
    phase0_Output0_1 = u_xlat2;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2 = mix(vec4(0.0, 0.0, 0.0, 0.0), u_xlat1, vec4(bvec4(u_xlatb15)));
    vs_TEXCOORD3.xyz = in_NORMAL0.xyz;
    u_xlat1.xy = u_xlat0.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat1.xz = (-u_xlat1.xy) * vec2(vec2(_CamDistRatio, _CamDistRatio)) + u_xlat0.xz;
    u_xlat1.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat1.y = u_xlat0.y;
    u_xlat16_3 = sin(_CamRotate);
    u_xlat16_4.x = cos(_CamRotate);
    u_xlat2.x = (-u_xlat16_3);
    u_xlat16_4.y = u_xlat16_3;
    u_xlat1.x = dot(u_xlat16_4.xy, u_xlat0.xz);
    u_xlat2.y = u_xlat16_4.x;
    u_xlat1.z = dot(u_xlat2.xy, u_xlat0.xz);
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump float _BloomFactor;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	mediump vec4 _AOColor;
uniform 	mediump vec4 _AOMask;
uniform 	mediump float _Reflectivity;
uniform 	mediump vec4 _EmissionTintColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AOTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
bvec2 u_xlatb8;
mediump float u_xlat16_14;
mediump float u_xlat16_15;
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
            u_xlatb8.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb8.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.xyz * _EmissionTintColor.xyz;
    u_xlat16_1 = u_xlat10_0.w + (-_EmissionFactor);
    u_xlat16_1 = _EmissionFactorFromTexToggle * u_xlat16_1 + _EmissionFactor;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler) + (-u_xlat10_0.xyz);
    u_xlat16_2.xyz = vec3(u_xlat16_1) * u_xlat16_2.xyz + u_xlat10_0.xyz;
    u_xlat10_1 = texture(_AOTex, vs_TEXCOORD1.xy);
    u_xlat16_3 = (-u_xlat10_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3 = u_xlat16_3 * _AOMask;
    u_xlat16_14 = max(u_xlat16_3.w, u_xlat16_3.z);
    u_xlat16_14 = max(u_xlat16_14, u_xlat16_3.y);
    u_xlat16_14 = max(u_xlat16_14, u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat10_1.w, u_xlat10_1.z);
    u_xlat16_3.x = max(u_xlat10_1.y, u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat10_1.x, u_xlat16_3.x);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_14 = max(u_xlat16_14, u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_2.xyz * _AOColor.xyz;
    u_xlat16_14 = u_xlat16_14 * _AOColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_15 = (-u_xlat16_14) + 1.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_15);
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_14) + u_xlat16_2.xyz;
    u_xlat16_14 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_14 = u_xlat16_14 + u_xlat16_14;
    u_xlat16_3.xyz = vs_TEXCOORD3.xyz * (-vec3(u_xlat16_14)) + vs_TEXCOORD4.xyz;
    u_xlat10_0.xyz = texture(_EnvTex, u_xlat16_3.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.www * u_xlat10_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_Reflectivity, _Reflectivity, _Reflectivity)) + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _UsingDitherAlpha;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.zw = in_TEXCOORD1.xy;
    phase0_Output0_1 = u_xlat1;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb1 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2 = mix(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0, vec4(bvec4(u_xlatb1)));
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump float _BloomFactor;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	mediump vec4 _AOColor;
uniform 	mediump vec4 _AOMask;
uniform 	mediump float _LumiFactor;
uniform 	mediump vec4 _EmissionTintColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AOTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
bvec2 u_xlatb8;
mediump float u_xlat16_12;
mediump float u_xlat16_14;
mediump float u_xlat16_15;
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
            u_xlatb8.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb8.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.xyz * _EmissionTintColor.xyz;
    u_xlat16_12 = u_xlat10_0.w + (-_EmissionFactor);
    u_xlat16_12 = _EmissionFactorFromTexToggle * u_xlat16_12 + _EmissionFactor;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler) + (-u_xlat10_0.xyz);
    u_xlat16_2.xyz = vec3(u_xlat16_12) * u_xlat16_2.xyz + u_xlat10_0.xyz;
    u_xlat10_0 = texture(_AOTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = (-u_xlat10_0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1 = u_xlat16_1 * _AOMask;
    u_xlat16_14 = max(u_xlat16_1.w, u_xlat16_1.z);
    u_xlat16_14 = max(u_xlat16_1.y, u_xlat16_14);
    u_xlat16_14 = max(u_xlat16_1.x, u_xlat16_14);
    u_xlat16_3.x = max(u_xlat10_0.w, u_xlat10_0.z);
    u_xlat16_3.x = max(u_xlat10_0.y, u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat10_0.x, u_xlat16_3.x);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_14 = max(u_xlat16_14, u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_2.xyz * _AOColor.xyz;
    u_xlat16_14 = u_xlat16_14 * _AOColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_15 = (-u_xlat16_14) + 1.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_15);
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_14) + u_xlat16_2.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _UsingDitherAlpha;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.zw = in_TEXCOORD1.xy;
    phase0_Output0_1 = u_xlat1;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb1 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2 = mix(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0, vec4(bvec4(u_xlatb1)));
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump float _BloomFactor;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	mediump vec4 _AOColor;
uniform 	mediump vec4 _AOMask;
uniform 	mediump float _LumiFactor;
uniform 	mediump vec4 _EmissionTintColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AOTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
bvec2 u_xlatb8;
mediump float u_xlat16_12;
mediump float u_xlat16_14;
mediump float u_xlat16_15;
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
            u_xlatb8.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb8.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.xyz * _EmissionTintColor.xyz;
    u_xlat16_12 = u_xlat10_0.w + (-_EmissionFactor);
    u_xlat16_12 = _EmissionFactorFromTexToggle * u_xlat16_12 + _EmissionFactor;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler) + (-u_xlat10_0.xyz);
    u_xlat16_2.xyz = vec3(u_xlat16_12) * u_xlat16_2.xyz + u_xlat10_0.xyz;
    u_xlat10_0 = texture(_AOTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = (-u_xlat10_0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1 = u_xlat16_1 * _AOMask;
    u_xlat16_14 = max(u_xlat16_1.w, u_xlat16_1.z);
    u_xlat16_14 = max(u_xlat16_1.y, u_xlat16_14);
    u_xlat16_14 = max(u_xlat16_1.x, u_xlat16_14);
    u_xlat16_3.x = max(u_xlat10_0.w, u_xlat10_0.z);
    u_xlat16_3.x = max(u_xlat10_0.y, u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat10_0.x, u_xlat16_3.x);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_14 = max(u_xlat16_14, u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_2.xyz * _AOColor.xyz;
    u_xlat16_14 = u_xlat16_14 * _AOColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_15 = (-u_xlat16_14) + 1.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_15);
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_14) + u_xlat16_2.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _UsingDitherAlpha;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.zw = in_TEXCOORD1.xy;
    phase0_Output0_1 = u_xlat1;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb1 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2 = mix(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0, vec4(bvec4(u_xlatb1)));
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump float _BloomFactor;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	mediump vec4 _AOColor;
uniform 	mediump vec4 _AOMask;
uniform 	mediump float _LumiFactor;
uniform 	mediump vec4 _EmissionTintColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AOTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
bvec2 u_xlatb8;
mediump float u_xlat16_12;
mediump float u_xlat16_14;
mediump float u_xlat16_15;
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
            u_xlatb8.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb8.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.xyz * _EmissionTintColor.xyz;
    u_xlat16_12 = u_xlat10_0.w + (-_EmissionFactor);
    u_xlat16_12 = _EmissionFactorFromTexToggle * u_xlat16_12 + _EmissionFactor;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler) + (-u_xlat10_0.xyz);
    u_xlat16_2.xyz = vec3(u_xlat16_12) * u_xlat16_2.xyz + u_xlat10_0.xyz;
    u_xlat10_0 = texture(_AOTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = (-u_xlat10_0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1 = u_xlat16_1 * _AOMask;
    u_xlat16_14 = max(u_xlat16_1.w, u_xlat16_1.z);
    u_xlat16_14 = max(u_xlat16_1.y, u_xlat16_14);
    u_xlat16_14 = max(u_xlat16_1.x, u_xlat16_14);
    u_xlat16_3.x = max(u_xlat10_0.w, u_xlat10_0.z);
    u_xlat16_3.x = max(u_xlat10_0.y, u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat10_0.x, u_xlat16_3.x);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_14 = max(u_xlat16_14, u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_2.xyz * _AOColor.xyz;
    u_xlat16_14 = u_xlat16_14 * _AOColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_15 = (-u_xlat16_14) + 1.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_15);
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_14) + u_xlat16_2.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "ENABLE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_4;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.zw = in_TEXCOORD1.xy;
    phase0_Output0_1 = u_xlat2;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2 = mix(vec4(0.0, 0.0, 0.0, 0.0), u_xlat1, vec4(bvec4(u_xlatb15)));
    vs_TEXCOORD3.xyz = in_NORMAL0.xyz;
    u_xlat1.xy = u_xlat0.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat1.xz = (-u_xlat1.xy) * vec2(vec2(_CamDistRatio, _CamDistRatio)) + u_xlat0.xz;
    u_xlat1.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat1.y = u_xlat0.y;
    u_xlat16_3 = sin(_CamRotate);
    u_xlat16_4.x = cos(_CamRotate);
    u_xlat2.x = (-u_xlat16_3);
    u_xlat16_4.y = u_xlat16_3;
    u_xlat1.x = dot(u_xlat16_4.xy, u_xlat0.xz);
    u_xlat2.y = u_xlat16_4.x;
    u_xlat1.z = dot(u_xlat2.xy, u_xlat0.xz);
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump float _BloomFactor;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	mediump vec4 _AOColor;
uniform 	mediump vec4 _AOMask;
uniform 	mediump float _LumiFactor;
uniform 	mediump float _Reflectivity;
uniform 	mediump vec4 _EmissionTintColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AOTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
bvec2 u_xlatb8;
mediump float u_xlat16_12;
mediump float u_xlat16_14;
mediump float u_xlat16_15;
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
            u_xlatb8.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb8.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.xyz * _EmissionTintColor.xyz;
    u_xlat16_1.x = u_xlat10_0.w + (-_EmissionFactor);
    u_xlat16_1.x = _EmissionFactorFromTexToggle * u_xlat16_1.x + _EmissionFactor;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler) + (-u_xlat10_0.xyz);
    u_xlat16_2.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat10_0.xyz;
    u_xlat10_1 = texture(_AOTex, vs_TEXCOORD1.xy);
    u_xlat16_3 = (-u_xlat10_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3 = u_xlat16_3 * _AOMask;
    u_xlat16_14 = max(u_xlat16_3.w, u_xlat16_3.z);
    u_xlat16_14 = max(u_xlat16_14, u_xlat16_3.y);
    u_xlat16_14 = max(u_xlat16_14, u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat10_1.w, u_xlat10_1.z);
    u_xlat16_3.x = max(u_xlat10_1.y, u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat10_1.x, u_xlat16_3.x);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_14 = max(u_xlat16_14, u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_2.xyz * _AOColor.xyz;
    u_xlat16_14 = u_xlat16_14 * _AOColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_15 = (-u_xlat16_14) + 1.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_15);
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_14) + u_xlat16_2.xyz;
    u_xlat16_14 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_14 = u_xlat16_14 + u_xlat16_14;
    u_xlat16_3.xyz = vs_TEXCOORD3.xyz * (-vec3(u_xlat16_14)) + vs_TEXCOORD4.xyz;
    u_xlat10_0.xyz = texture(_EnvTex, u_xlat16_3.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.www * u_xlat10_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_Reflectivity, _Reflectivity, _Reflectivity)) + u_xlat16_2.xyz;
    u_xlat16_12 = dot(u_xlat16_0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_1.xyz = (-u_xlat16_0.xyz) + vec3(u_xlat16_12);
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_1.xyz + u_xlat16_0.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "ENABLE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_4;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.zw = in_TEXCOORD1.xy;
    phase0_Output0_1 = u_xlat2;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2 = mix(vec4(0.0, 0.0, 0.0, 0.0), u_xlat1, vec4(bvec4(u_xlatb15)));
    vs_TEXCOORD3.xyz = in_NORMAL0.xyz;
    u_xlat1.xy = u_xlat0.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat1.xz = (-u_xlat1.xy) * vec2(vec2(_CamDistRatio, _CamDistRatio)) + u_xlat0.xz;
    u_xlat1.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat1.y = u_xlat0.y;
    u_xlat16_3 = sin(_CamRotate);
    u_xlat16_4.x = cos(_CamRotate);
    u_xlat2.x = (-u_xlat16_3);
    u_xlat16_4.y = u_xlat16_3;
    u_xlat1.x = dot(u_xlat16_4.xy, u_xlat0.xz);
    u_xlat2.y = u_xlat16_4.x;
    u_xlat1.z = dot(u_xlat2.xy, u_xlat0.xz);
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump float _BloomFactor;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	mediump vec4 _AOColor;
uniform 	mediump vec4 _AOMask;
uniform 	mediump float _LumiFactor;
uniform 	mediump float _Reflectivity;
uniform 	mediump vec4 _EmissionTintColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AOTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
bvec2 u_xlatb8;
mediump float u_xlat16_12;
mediump float u_xlat16_14;
mediump float u_xlat16_15;
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
            u_xlatb8.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb8.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.xyz * _EmissionTintColor.xyz;
    u_xlat16_1.x = u_xlat10_0.w + (-_EmissionFactor);
    u_xlat16_1.x = _EmissionFactorFromTexToggle * u_xlat16_1.x + _EmissionFactor;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler) + (-u_xlat10_0.xyz);
    u_xlat16_2.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat10_0.xyz;
    u_xlat10_1 = texture(_AOTex, vs_TEXCOORD1.xy);
    u_xlat16_3 = (-u_xlat10_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3 = u_xlat16_3 * _AOMask;
    u_xlat16_14 = max(u_xlat16_3.w, u_xlat16_3.z);
    u_xlat16_14 = max(u_xlat16_14, u_xlat16_3.y);
    u_xlat16_14 = max(u_xlat16_14, u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat10_1.w, u_xlat10_1.z);
    u_xlat16_3.x = max(u_xlat10_1.y, u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat10_1.x, u_xlat16_3.x);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_14 = max(u_xlat16_14, u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_2.xyz * _AOColor.xyz;
    u_xlat16_14 = u_xlat16_14 * _AOColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_15 = (-u_xlat16_14) + 1.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_15);
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_14) + u_xlat16_2.xyz;
    u_xlat16_14 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_14 = u_xlat16_14 + u_xlat16_14;
    u_xlat16_3.xyz = vs_TEXCOORD3.xyz * (-vec3(u_xlat16_14)) + vs_TEXCOORD4.xyz;
    u_xlat10_0.xyz = texture(_EnvTex, u_xlat16_3.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.www * u_xlat10_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_Reflectivity, _Reflectivity, _Reflectivity)) + u_xlat16_2.xyz;
    u_xlat16_12 = dot(u_xlat16_0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_1.xyz = (-u_xlat16_0.xyz) + vec3(u_xlat16_12);
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_1.xyz + u_xlat16_0.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "ENABLE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec3 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_4;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.zw = in_TEXCOORD1.xy;
    phase0_Output0_1 = u_xlat2;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2 = mix(vec4(0.0, 0.0, 0.0, 0.0), u_xlat1, vec4(bvec4(u_xlatb15)));
    vs_TEXCOORD3.xyz = in_NORMAL0.xyz;
    u_xlat1.xy = u_xlat0.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat1.xz = (-u_xlat1.xy) * vec2(vec2(_CamDistRatio, _CamDistRatio)) + u_xlat0.xz;
    u_xlat1.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat1.y = u_xlat0.y;
    u_xlat16_3 = sin(_CamRotate);
    u_xlat16_4.x = cos(_CamRotate);
    u_xlat2.x = (-u_xlat16_3);
    u_xlat16_4.y = u_xlat16_3;
    u_xlat1.x = dot(u_xlat16_4.xy, u_xlat0.xz);
    u_xlat2.y = u_xlat16_4.x;
    u_xlat1.z = dot(u_xlat2.xy, u_xlat0.xz);
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump float _BloomFactor;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	mediump vec4 _AOColor;
uniform 	mediump vec4 _AOMask;
uniform 	mediump float _LumiFactor;
uniform 	mediump float _Reflectivity;
uniform 	mediump vec4 _EmissionTintColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AOTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
bvec2 u_xlatb8;
mediump float u_xlat16_12;
mediump float u_xlat16_14;
mediump float u_xlat16_15;
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
            u_xlatb8.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb8.y) ? u_xlat0.y : (-u_xlat0.y);
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
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.xyz * _EmissionTintColor.xyz;
    u_xlat16_1.x = u_xlat10_0.w + (-_EmissionFactor);
    u_xlat16_1.x = _EmissionFactorFromTexToggle * u_xlat16_1.x + _EmissionFactor;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler) + (-u_xlat10_0.xyz);
    u_xlat16_2.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat10_0.xyz;
    u_xlat10_1 = texture(_AOTex, vs_TEXCOORD1.xy);
    u_xlat16_3 = (-u_xlat10_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3 = u_xlat16_3 * _AOMask;
    u_xlat16_14 = max(u_xlat16_3.w, u_xlat16_3.z);
    u_xlat16_14 = max(u_xlat16_14, u_xlat16_3.y);
    u_xlat16_14 = max(u_xlat16_14, u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat10_1.w, u_xlat10_1.z);
    u_xlat16_3.x = max(u_xlat10_1.y, u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat10_1.x, u_xlat16_3.x);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_14 = max(u_xlat16_14, u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_2.xyz * _AOColor.xyz;
    u_xlat16_14 = u_xlat16_14 * _AOColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_15 = (-u_xlat16_14) + 1.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_15);
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_14) + u_xlat16_2.xyz;
    u_xlat16_14 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_14 = u_xlat16_14 + u_xlat16_14;
    u_xlat16_3.xyz = vs_TEXCOORD3.xyz * (-vec3(u_xlat16_14)) + vs_TEXCOORD4.xyz;
    u_xlat10_0.xyz = texture(_EnvTex, u_xlat16_3.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.www * u_xlat10_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_Reflectivity, _Reflectivity, _Reflectivity)) + u_xlat16_2.xyz;
    u_xlat16_12 = dot(u_xlat16_0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_1.xyz = (-u_xlat16_0.xyz) + vec3(u_xlat16_12);
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_1.xyz + u_xlat16_0.xyz;
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
Keywords { "ENABLE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ENABLE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ENABLE_REFLECTION" }
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
Keywords { "LUMINANCE" "ENABLE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "ENABLE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "ENABLE_REFLECTION" }
""
}
}
}
 Pass {
  Name "COMPLEX"
  LOD 100
  Tags { "DrawDepth" = "FrontFace" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "Complex" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Front
  GpuProgramID 66082
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump float _OutlineWidth;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump float _MaxOutlineZOffset;
uniform 	mediump float _Scale;
uniform 	mediump float _VertexAlphaFactor;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _UseCameraFade;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	mediump float _Opaqueness;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
int u_xlati4;
bool u_xlatb4;
float u_xlat8;
bool u_xlatb8;
mediump float u_xlat16_11;
void main()
{
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat0;
    u_xlat1.xy = u_xlat0.xy * in_TANGENT0.yy;
    u_xlat0 = u_xlat0 * in_POSITION0.yyyy;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat2;
    u_xlat1.xy = u_xlat2.xy * in_TANGENT0.xx + u_xlat1.xy;
    u_xlat0 = u_xlat2 * in_POSITION0.xxxx + u_xlat0;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat2;
    u_xlat1.xy = u_xlat2.xy * in_TANGENT0.zz + u_xlat1.xy;
    u_xlat0 = u_xlat2 * in_POSITION0.zzzz + u_xlat0;
    u_xlat1.z = 0.00999999978;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xy = u_xlat1.xy * u_xlat16_3.xx;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat1;
    u_xlat0 = u_xlat1 * in_POSITION0.wwww + u_xlat0;
    u_xlat1 = u_xlat0 / u_xlat0.wwww;
    u_xlat0.x = (-u_xlat0.z) + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x + (-_FadeOffset);
    u_xlat0.x = u_xlat0.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _OutlineColor.w;
    u_xlat4.x = (-u_xlat1.z) / hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat16_11 = u_xlat4.x / _Scale;
    u_xlat4.x = inversesqrt(u_xlat16_11);
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat16_11 = _OutlineWidth * _Scale;
    u_xlat16_11 = u_xlat16_11 * in_COLOR0.w;
    u_xlat16_11 = u_xlat4.x * u_xlat16_11;
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_MaxOutlineZOffset);
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_Scale, _Scale, _Scale));
    u_xlat2.xy = vec2(in_COLOR0.w + float(-1.0), in_COLOR0.z + float(-0.5));
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.yyy + u_xlat1.xyz;
    u_xlat1.x = _VertexAlphaFactor * u_xlat2.x + 1.0;
    u_xlat4.xy = u_xlat16_3.xy * vec2(u_xlat16_11) + u_xlat4.xy;
    u_xlat2 = u_xlat4.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat4.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat4.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb4 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_3.x = (u_xlatb4) ? u_xlat0.x : _OutlineColor.w;
    u_xlat16_3.x = u_xlat16_3.x * _Opaqueness;
    u_xlat0.x = u_xlat1.x * u_xlat16_3.x;
    u_xlat4.x = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat8 = _ClipPlane.w + -0.00999999978;
    u_xlat4.x = (-u_xlat8) + u_xlat4.x;
    u_xlat4.x = u_xlat4.x + 1.0;
    u_xlat4.x = floor(u_xlat4.x);
    u_xlat4.x = max(u_xlat4.x, 0.0);
    u_xlati4 = int(u_xlat4.x);
    u_xlat0.x = (u_xlati4 != 0) ? u_xlat0.x : 0.0;
    vs_COLOR0.w = u_xlat0.x;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.zz + u_xlat0.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xy = mix(vec2(0.0, 0.0), u_xlat0.xy, vec2(bvec2(u_xlatb8)));
    vs_TEXCOORD3.w = u_xlatb8 ? u_xlat2.w : float(0.0);
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	float _UsingDitherAlpha;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb4;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat0.x = vs_COLOR0.w + 0.99000001;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    if((u_xlati0)==0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb4.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb4.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb4.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD3.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    SV_Target0.xyz = vs_COLOR0.xyz * _Color.xyz;
    SV_Target0.w = vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump float _OutlineWidth;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump float _MaxOutlineZOffset;
uniform 	mediump float _Scale;
uniform 	mediump float _VertexAlphaFactor;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _UseCameraFade;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	mediump float _Opaqueness;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
int u_xlati4;
bool u_xlatb4;
float u_xlat8;
bool u_xlatb8;
mediump float u_xlat16_11;
void main()
{
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat0;
    u_xlat1.xy = u_xlat0.xy * in_TANGENT0.yy;
    u_xlat0 = u_xlat0 * in_POSITION0.yyyy;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat2;
    u_xlat1.xy = u_xlat2.xy * in_TANGENT0.xx + u_xlat1.xy;
    u_xlat0 = u_xlat2 * in_POSITION0.xxxx + u_xlat0;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat2;
    u_xlat1.xy = u_xlat2.xy * in_TANGENT0.zz + u_xlat1.xy;
    u_xlat0 = u_xlat2 * in_POSITION0.zzzz + u_xlat0;
    u_xlat1.z = 0.00999999978;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xy = u_xlat1.xy * u_xlat16_3.xx;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat1;
    u_xlat0 = u_xlat1 * in_POSITION0.wwww + u_xlat0;
    u_xlat1 = u_xlat0 / u_xlat0.wwww;
    u_xlat0.x = (-u_xlat0.z) + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x + (-_FadeOffset);
    u_xlat0.x = u_xlat0.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _OutlineColor.w;
    u_xlat4.x = (-u_xlat1.z) / hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat16_11 = u_xlat4.x / _Scale;
    u_xlat4.x = inversesqrt(u_xlat16_11);
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat16_11 = _OutlineWidth * _Scale;
    u_xlat16_11 = u_xlat16_11 * in_COLOR0.w;
    u_xlat16_11 = u_xlat4.x * u_xlat16_11;
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_MaxOutlineZOffset);
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_Scale, _Scale, _Scale));
    u_xlat2.xy = vec2(in_COLOR0.w + float(-1.0), in_COLOR0.z + float(-0.5));
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.yyy + u_xlat1.xyz;
    u_xlat1.x = _VertexAlphaFactor * u_xlat2.x + 1.0;
    u_xlat4.xy = u_xlat16_3.xy * vec2(u_xlat16_11) + u_xlat4.xy;
    u_xlat2 = u_xlat4.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat4.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat4.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb4 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_3.x = (u_xlatb4) ? u_xlat0.x : _OutlineColor.w;
    u_xlat16_3.x = u_xlat16_3.x * _Opaqueness;
    u_xlat0.x = u_xlat1.x * u_xlat16_3.x;
    u_xlat4.x = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat8 = _ClipPlane.w + -0.00999999978;
    u_xlat4.x = (-u_xlat8) + u_xlat4.x;
    u_xlat4.x = u_xlat4.x + 1.0;
    u_xlat4.x = floor(u_xlat4.x);
    u_xlat4.x = max(u_xlat4.x, 0.0);
    u_xlati4 = int(u_xlat4.x);
    u_xlat0.x = (u_xlati4 != 0) ? u_xlat0.x : 0.0;
    vs_COLOR0.w = u_xlat0.x;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.zz + u_xlat0.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xy = mix(vec2(0.0, 0.0), u_xlat0.xy, vec2(bvec2(u_xlatb8)));
    vs_TEXCOORD3.w = u_xlatb8 ? u_xlat2.w : float(0.0);
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	float _UsingDitherAlpha;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb4;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat0.x = vs_COLOR0.w + 0.99000001;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    if((u_xlati0)==0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb4.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb4.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb4.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD3.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    SV_Target0.xyz = vs_COLOR0.xyz * _Color.xyz;
    SV_Target0.w = vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump float _OutlineWidth;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump float _MaxOutlineZOffset;
uniform 	mediump float _Scale;
uniform 	mediump float _VertexAlphaFactor;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _UseCameraFade;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	mediump float _Opaqueness;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
int u_xlati4;
bool u_xlatb4;
float u_xlat8;
bool u_xlatb8;
mediump float u_xlat16_11;
void main()
{
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat0;
    u_xlat1.xy = u_xlat0.xy * in_TANGENT0.yy;
    u_xlat0 = u_xlat0 * in_POSITION0.yyyy;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat2;
    u_xlat1.xy = u_xlat2.xy * in_TANGENT0.xx + u_xlat1.xy;
    u_xlat0 = u_xlat2 * in_POSITION0.xxxx + u_xlat0;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat2;
    u_xlat1.xy = u_xlat2.xy * in_TANGENT0.zz + u_xlat1.xy;
    u_xlat0 = u_xlat2 * in_POSITION0.zzzz + u_xlat0;
    u_xlat1.z = 0.00999999978;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xy = u_xlat1.xy * u_xlat16_3.xx;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat1;
    u_xlat0 = u_xlat1 * in_POSITION0.wwww + u_xlat0;
    u_xlat1 = u_xlat0 / u_xlat0.wwww;
    u_xlat0.x = (-u_xlat0.z) + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x + (-_FadeOffset);
    u_xlat0.x = u_xlat0.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _OutlineColor.w;
    u_xlat4.x = (-u_xlat1.z) / hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat16_11 = u_xlat4.x / _Scale;
    u_xlat4.x = inversesqrt(u_xlat16_11);
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat16_11 = _OutlineWidth * _Scale;
    u_xlat16_11 = u_xlat16_11 * in_COLOR0.w;
    u_xlat16_11 = u_xlat4.x * u_xlat16_11;
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_MaxOutlineZOffset);
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_Scale, _Scale, _Scale));
    u_xlat2.xy = vec2(in_COLOR0.w + float(-1.0), in_COLOR0.z + float(-0.5));
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.yyy + u_xlat1.xyz;
    u_xlat1.x = _VertexAlphaFactor * u_xlat2.x + 1.0;
    u_xlat4.xy = u_xlat16_3.xy * vec2(u_xlat16_11) + u_xlat4.xy;
    u_xlat2 = u_xlat4.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat4.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat4.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb4 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_3.x = (u_xlatb4) ? u_xlat0.x : _OutlineColor.w;
    u_xlat16_3.x = u_xlat16_3.x * _Opaqueness;
    u_xlat0.x = u_xlat1.x * u_xlat16_3.x;
    u_xlat4.x = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat8 = _ClipPlane.w + -0.00999999978;
    u_xlat4.x = (-u_xlat8) + u_xlat4.x;
    u_xlat4.x = u_xlat4.x + 1.0;
    u_xlat4.x = floor(u_xlat4.x);
    u_xlat4.x = max(u_xlat4.x, 0.0);
    u_xlati4 = int(u_xlat4.x);
    u_xlat0.x = (u_xlati4 != 0) ? u_xlat0.x : 0.0;
    vs_COLOR0.w = u_xlat0.x;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.zz + u_xlat0.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xy = mix(vec2(0.0, 0.0), u_xlat0.xy, vec2(bvec2(u_xlatb8)));
    vs_TEXCOORD3.w = u_xlatb8 ? u_xlat2.w : float(0.0);
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	float _UsingDitherAlpha;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb4;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat0.x = vs_COLOR0.w + 0.99000001;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    if((u_xlati0)==0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb4.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb4.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb4.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD3.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    SV_Target0.xyz = vs_COLOR0.xyz * _Color.xyz;
    SV_Target0.w = vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
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
}
}
 Pass {
  LOD 100
  Tags { "DrawDepth" = "FrontFace" "IGNOREPROJECTOR" = "true" "OutlineType" = "Complex" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 140817
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _ClipPlane;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0.x = _ClipPlane.w + -0.00999999978;
    u_xlat3 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat3;
    u_xlat3 = u_xlat3 + (-_ClipPlane.w);
    u_xlat1.xyz = (-vec3(u_xlat3)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat2.xyz = in_POSITION0.xyz;
    u_xlat2.w = 1.0;
    u_xlat1.w = 0.0;
    u_xlat0 = (int(u_xlati0) != 0) ? u_xlat2 : u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD0.z = u_xlat0.w;
    u_xlat0 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform 	mediump float _EmissionBloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_0 = u_xlat10_0 + (-_EmissionFactor);
    u_xlat16_0 = _EmissionFactorFromTexToggle * u_xlat16_0 + _EmissionFactor;
    u_xlat16_1 = (-_BloomFactor) + _EmissionBloomFactor;
    u_xlat16_1 = u_xlat16_0 * u_xlat16_1 + _BloomFactor;
    u_xlat0 = u_xlat16_1 * vs_TEXCOORD0.z;
    SV_Target0.w = u_xlat0;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _ClipPlane;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0.x = _ClipPlane.w + -0.00999999978;
    u_xlat3 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat3;
    u_xlat3 = u_xlat3 + (-_ClipPlane.w);
    u_xlat1.xyz = (-vec3(u_xlat3)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat2.xyz = in_POSITION0.xyz;
    u_xlat2.w = 1.0;
    u_xlat1.w = 0.0;
    u_xlat0 = (int(u_xlati0) != 0) ? u_xlat2 : u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD0.z = u_xlat0.w;
    u_xlat0 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform 	mediump float _EmissionBloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_0 = u_xlat10_0 + (-_EmissionFactor);
    u_xlat16_0 = _EmissionFactorFromTexToggle * u_xlat16_0 + _EmissionFactor;
    u_xlat16_1 = (-_BloomFactor) + _EmissionBloomFactor;
    u_xlat16_1 = u_xlat16_0 * u_xlat16_1 + _BloomFactor;
    u_xlat0 = u_xlat16_1 * vs_TEXCOORD0.z;
    SV_Target0.w = u_xlat0;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _ClipPlane;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0.x = _ClipPlane.w + -0.00999999978;
    u_xlat3 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat3;
    u_xlat3 = u_xlat3 + (-_ClipPlane.w);
    u_xlat1.xyz = (-vec3(u_xlat3)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat2.xyz = in_POSITION0.xyz;
    u_xlat2.w = 1.0;
    u_xlat1.w = 0.0;
    u_xlat0 = (int(u_xlati0) != 0) ? u_xlat2 : u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD0.z = u_xlat0.w;
    u_xlat0 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform 	mediump float _EmissionBloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_0 = u_xlat10_0 + (-_EmissionFactor);
    u_xlat16_0 = _EmissionFactorFromTexToggle * u_xlat16_0 + _EmissionFactor;
    u_xlat16_1 = (-_BloomFactor) + _EmissionBloomFactor;
    u_xlat16_1 = u_xlat16_0 * u_xlat16_1 + _BloomFactor;
    u_xlat0 = u_xlat16_1 * vs_TEXCOORD0.z;
    SV_Target0.w = u_xlat0;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPECIAL_STATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _ClipPlane;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0.x = _ClipPlane.w + -0.00999999978;
    u_xlat3 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat3;
    u_xlat3 = u_xlat3 + (-_ClipPlane.w);
    u_xlat1.xyz = (-vec3(u_xlat3)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat2.xyz = in_POSITION0.xyz;
    u_xlat2.w = 1.0;
    u_xlat1.w = 0.0;
    u_xlat0 = (int(u_xlati0) != 0) ? u_xlat2 : u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.z = u_xlat0.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1 = u_xlat0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
    u_xlat3 = u_xlat1.w + u_xlat1.y;
    u_xlat1.x = u_xlat1.z * u_xlat1.z + u_xlat1.x;
    u_xlat1.y = u_xlat0.x * 0.25 + u_xlat3;
    vs_TEXCOORD1.xy = u_xlat1.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _SPNoiseScaler;
uniform 	float _SPTransition;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionBloomFactor;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform 	mediump float _EmissionBloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SPNoiseTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
vec2 u_xlat1;
mediump float u_xlat16_2;
vec3 u_xlat3;
ivec3 u_xlati3;
bvec2 u_xlatb3;
float u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
void main()
{
    u_xlat10_0 = texture(_SPNoiseTex, vs_TEXCOORD1.xy).x;
    u_xlat0 = u_xlat10_0 * _SPNoiseScaler;
    u_xlat0 = u_xlat0 * 1.99000001 + -1.0;
    u_xlat3.x = _SPNoiseScaler * _SPTransition;
    u_xlat6 = u_xlat3.x * 1.5 + (-u_xlat0);
    u_xlat6 = u_xlat6 + 1.0;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati3.y = int(u_xlat6);
    u_xlat1.xy = (-u_xlat3.xx) * vec2(1.70000005, 1.5) + vec2(u_xlat0);
    u_xlat0 = u_xlat3.x * 1.70000005 + (-u_xlat0);
    u_xlat0 = u_xlat0 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat3.xz = u_xlat1.xy + vec2(1.0, 1.0);
    u_xlat3.xz = floor(u_xlat3.xz);
    u_xlat3.xz = max(u_xlat3.xz, vec2(0.0, 0.0));
    u_xlati3.xz = ivec2(u_xlat3.xz);
    u_xlatb3.xy = equal(u_xlati3.xyxx, ivec4(0, 0, 0, 0)).xy;
    u_xlatb3.x = u_xlatb3.x && u_xlatb3.y;
    u_xlat10_6 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_6 = u_xlat10_6 + (-_EmissionFactor);
    u_xlat16_6 = _EmissionFactorFromTexToggle * u_xlat16_6 + _EmissionFactor;
    u_xlat16_2 = (-_BloomFactor) + _EmissionBloomFactor;
    u_xlat16_2 = u_xlat16_6 * u_xlat16_2 + _BloomFactor;
    u_xlat6 = u_xlat16_2 * vs_TEXCOORD0.z;
    u_xlat1.x = (-u_xlat16_2) * vs_TEXCOORD0.z + _SPTransitionBloomFactor;
    u_xlat0 = u_xlat0 * u_xlat1.x + u_xlat6;
    u_xlat16_2 = u_xlat6 * _SPOpaqueness;
    u_xlat16_2 = (u_xlati3.z != 0) ? u_xlat6 : u_xlat16_2;
    SV_Target0.w = (u_xlatb3.x) ? u_xlat0 : u_xlat16_2;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPECIAL_STATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _ClipPlane;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0.x = _ClipPlane.w + -0.00999999978;
    u_xlat3 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat3;
    u_xlat3 = u_xlat3 + (-_ClipPlane.w);
    u_xlat1.xyz = (-vec3(u_xlat3)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat2.xyz = in_POSITION0.xyz;
    u_xlat2.w = 1.0;
    u_xlat1.w = 0.0;
    u_xlat0 = (int(u_xlati0) != 0) ? u_xlat2 : u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.z = u_xlat0.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1 = u_xlat0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
    u_xlat3 = u_xlat1.w + u_xlat1.y;
    u_xlat1.x = u_xlat1.z * u_xlat1.z + u_xlat1.x;
    u_xlat1.y = u_xlat0.x * 0.25 + u_xlat3;
    vs_TEXCOORD1.xy = u_xlat1.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _SPNoiseScaler;
uniform 	float _SPTransition;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionBloomFactor;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform 	mediump float _EmissionBloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SPNoiseTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
vec2 u_xlat1;
mediump float u_xlat16_2;
vec3 u_xlat3;
ivec3 u_xlati3;
bvec2 u_xlatb3;
float u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
void main()
{
    u_xlat10_0 = texture(_SPNoiseTex, vs_TEXCOORD1.xy).x;
    u_xlat0 = u_xlat10_0 * _SPNoiseScaler;
    u_xlat0 = u_xlat0 * 1.99000001 + -1.0;
    u_xlat3.x = _SPNoiseScaler * _SPTransition;
    u_xlat6 = u_xlat3.x * 1.5 + (-u_xlat0);
    u_xlat6 = u_xlat6 + 1.0;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati3.y = int(u_xlat6);
    u_xlat1.xy = (-u_xlat3.xx) * vec2(1.70000005, 1.5) + vec2(u_xlat0);
    u_xlat0 = u_xlat3.x * 1.70000005 + (-u_xlat0);
    u_xlat0 = u_xlat0 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat3.xz = u_xlat1.xy + vec2(1.0, 1.0);
    u_xlat3.xz = floor(u_xlat3.xz);
    u_xlat3.xz = max(u_xlat3.xz, vec2(0.0, 0.0));
    u_xlati3.xz = ivec2(u_xlat3.xz);
    u_xlatb3.xy = equal(u_xlati3.xyxx, ivec4(0, 0, 0, 0)).xy;
    u_xlatb3.x = u_xlatb3.x && u_xlatb3.y;
    u_xlat10_6 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_6 = u_xlat10_6 + (-_EmissionFactor);
    u_xlat16_6 = _EmissionFactorFromTexToggle * u_xlat16_6 + _EmissionFactor;
    u_xlat16_2 = (-_BloomFactor) + _EmissionBloomFactor;
    u_xlat16_2 = u_xlat16_6 * u_xlat16_2 + _BloomFactor;
    u_xlat6 = u_xlat16_2 * vs_TEXCOORD0.z;
    u_xlat1.x = (-u_xlat16_2) * vs_TEXCOORD0.z + _SPTransitionBloomFactor;
    u_xlat0 = u_xlat0 * u_xlat1.x + u_xlat6;
    u_xlat16_2 = u_xlat6 * _SPOpaqueness;
    u_xlat16_2 = (u_xlati3.z != 0) ? u_xlat6 : u_xlat16_2;
    SV_Target0.w = (u_xlatb3.x) ? u_xlat0 : u_xlat16_2;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPECIAL_STATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _ClipPlane;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0.x = _ClipPlane.w + -0.00999999978;
    u_xlat3 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat3;
    u_xlat3 = u_xlat3 + (-_ClipPlane.w);
    u_xlat1.xyz = (-vec3(u_xlat3)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat2.xyz = in_POSITION0.xyz;
    u_xlat2.w = 1.0;
    u_xlat1.w = 0.0;
    u_xlat0 = (int(u_xlati0) != 0) ? u_xlat2 : u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.z = u_xlat0.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1 = u_xlat0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
    u_xlat3 = u_xlat1.w + u_xlat1.y;
    u_xlat1.x = u_xlat1.z * u_xlat1.z + u_xlat1.x;
    u_xlat1.y = u_xlat0.x * 0.25 + u_xlat3;
    vs_TEXCOORD1.xy = u_xlat1.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _SPNoiseScaler;
uniform 	float _SPTransition;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionBloomFactor;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform 	mediump float _EmissionBloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SPNoiseTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
vec2 u_xlat1;
mediump float u_xlat16_2;
vec3 u_xlat3;
ivec3 u_xlati3;
bvec2 u_xlatb3;
float u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
void main()
{
    u_xlat10_0 = texture(_SPNoiseTex, vs_TEXCOORD1.xy).x;
    u_xlat0 = u_xlat10_0 * _SPNoiseScaler;
    u_xlat0 = u_xlat0 * 1.99000001 + -1.0;
    u_xlat3.x = _SPNoiseScaler * _SPTransition;
    u_xlat6 = u_xlat3.x * 1.5 + (-u_xlat0);
    u_xlat6 = u_xlat6 + 1.0;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati3.y = int(u_xlat6);
    u_xlat1.xy = (-u_xlat3.xx) * vec2(1.70000005, 1.5) + vec2(u_xlat0);
    u_xlat0 = u_xlat3.x * 1.70000005 + (-u_xlat0);
    u_xlat0 = u_xlat0 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat3.xz = u_xlat1.xy + vec2(1.0, 1.0);
    u_xlat3.xz = floor(u_xlat3.xz);
    u_xlat3.xz = max(u_xlat3.xz, vec2(0.0, 0.0));
    u_xlati3.xz = ivec2(u_xlat3.xz);
    u_xlatb3.xy = equal(u_xlati3.xyxx, ivec4(0, 0, 0, 0)).xy;
    u_xlatb3.x = u_xlatb3.x && u_xlatb3.y;
    u_xlat10_6 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_6 = u_xlat10_6 + (-_EmissionFactor);
    u_xlat16_6 = _EmissionFactorFromTexToggle * u_xlat16_6 + _EmissionFactor;
    u_xlat16_2 = (-_BloomFactor) + _EmissionBloomFactor;
    u_xlat16_2 = u_xlat16_6 * u_xlat16_2 + _BloomFactor;
    u_xlat6 = u_xlat16_2 * vs_TEXCOORD0.z;
    u_xlat1.x = (-u_xlat16_2) * vs_TEXCOORD0.z + _SPTransitionBloomFactor;
    u_xlat0 = u_xlat0 * u_xlat1.x + u_xlat6;
    u_xlat16_2 = u_xlat6 * _SPOpaqueness;
    u_xlat16_2 = (u_xlati3.z != 0) ? u_xlat6 : u_xlat16_2;
    SV_Target0.w = (u_xlatb3.x) ? u_xlat0 : u_xlat16_2;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
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
Keywords { "SPECIAL_STATE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPECIAL_STATE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPECIAL_STATE" }
""
}
}
}
}
}