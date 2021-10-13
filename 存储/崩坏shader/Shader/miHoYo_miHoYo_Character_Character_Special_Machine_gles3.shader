//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Character/Character_Special/Machine" {
Properties {
_Scale ("Scale Compared to Maya", Float) = 0.01
_Color ("Main Color", Color) = (1,1,1,1)
_EnvColor ("Env Color", Color) = (1,1,1,1)
_Opaqueness ("Opaqueness", Range(0, 1)) = 1
_ZWrite ("Depth Write Switch (0: not write)", Range(0, 1)) = 1
_BloomFactor ("Bloom Factor", Float) = 0.25
_MainTex ("Main Tex (RGB)", 2D) = "white" { }
_Emission ("Emission Scaler", Range(1, 100)) = 0
[Toggle] _PartialEmission ("Partial Emission", Float) = 0
_PartialEmissionScaler ("Partial Emission Scaler", Range(1, 100)) = 1
_EmissionBloomFactor ("Emission Bloom Factor", Float) = 1
_LightSpecColor ("Light Specular Color", Color) = (1,1,1,1)
_LightArea ("Light Area Threshold", Range(0, 1)) = 0.51
_ShadowMultColor ("Shadow Multiply Color", Color) = (0.9,0.7,0.75,1)
_Shininess ("Specular Shininess", Range(0.1, 100)) = 10
_SpecMulti ("Specular Multiply Factor", Range(0, 1)) = 0.1
_OutlineWidth ("Outline Width", Range(0, 100)) = 0.2
_OutlineColor ("Outline Color", Color) = (0,0,0,1)
_MaxOutlineZOffset ("Max Outline Z Offset", Range(0, 100)) = 1
_OutlineCamStart ("Outline Camera Adjustment Start Distance", Range(0, 10000)) = 1000
_ClipPlane ("Clip Plane (Model Space)", Vector) = (0,0,0,0)
_FadeDistance ("Fade Start Distance", Range(0.1, 10)) = 0.5
_FadeOffset ("Fade Start Offset", Range(0, 10)) = 1
_SPTex ("SP Tex", 2D) = "white" { }
_SPNoiseTex ("SP Noise Tex", 2D) = "white" { }
_SPNoiseScaler ("SP Noise Scaler", Range(0, 10)) = 1
_SPIntensity ("SP Intensity", Range(0, 1)) = 0.5
_SPTransition ("SP Transition", Range(0, 1)) = 0
_SPTransitionColor ("SP Transition Color", Color) = (1,1,1,1)
_SPOutlineColor ("SP Outline Color", Color) = (1,1,1,1)
_SPTransitionEmissionScaler ("SP Transition Emission Scaler", Range(1, 100)) = 1
_SPTransitionBloomFactor ("SP Transition Bloom Factor", Float) = 1
[Toggle(RIM_GLOW)] _RimGlow ("Rim Glow", Float) = 0
_RGColor ("Rim Glow Color", Color) = (1,1,1,1)
_RGShininess ("Rim Glow Shininess", Float) = 1
_RGScale ("Rim Glow Scale", Float) = 1
_RGBias ("Rim Glow Bias", Float) = 0
_RGRatio ("Rim Glow Ratio", Range(0, 1)) = 0.5
_RGBloomFactor ("Rim Glow Bloom Factor", Float) = 1
[Toggle(OVERHEAT)] _Overheat ("Overheat", Float) = 0
_OverheatColor ("Overheat Color", Color) = (1,0,0,0)
_OverheatEmissionScaler ("Overheat Emission Scaler", Range(0, 100)) = 1
_OverheatIntensity ("Overheat Intensity", Range(0, 1)) = 0
_VertexAlphaFactor ("Alpha From Vertex Factor (0: not use)", Range(0, 1)) = 0
[Toggle(USINGDITHERALPAH)] _UsingDitherAlpha ("UsingDitherAlpha", Float) = 0
_DitherAlpha ("Dither Alpha Value", Range(0, 1)) = 1
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "OutlineType" = "Complex" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "Complex" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 59725
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Opaqueness;
uniform 	mediump float _Shininess;
uniform 	vec4 _ClipPlane;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD7;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_4;
mediump float u_xlat16_9;
float u_xlat11;
vec2 u_xlat12;
float u_xlat15;
int u_xlati15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat2.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    vs_TEXCOORD2.xyz = vec3(0.0, 0.0, 0.0);
    u_xlat15 = _ClipPlane.w + -0.00999999978;
    u_xlat11 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat15 = (-u_xlat15) + u_xlat11;
    u_xlat11 = u_xlat11 + (-_ClipPlane.w);
    u_xlat2.xyz = (-vec3(u_xlat11)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat15 = u_xlat15 + 1.0;
    u_xlat15 = floor(u_xlat15);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlati15 = int(u_xlat15);
    u_xlat3.xyz = in_POSITION0.xyz;
    u_xlat3.w = 1.0;
    u_xlat2.w = 0.0;
    u_xlat2 = (int(u_xlati15) != 0) ? u_xlat3 : u_xlat2;
    u_xlat3 = u_xlat2.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat15 = u_xlat2.x * u_xlat3.x;
    vs_COLOR1.y = u_xlat2.w * _Opaqueness;
    u_xlat11 = u_xlat3.w + u_xlat3.y;
    u_xlat12.x = u_xlat3.z * u_xlat3.z + u_xlat3.x;
    u_xlat12.y = u_xlat15 * 0.25 + u_xlat11;
    vs_TEXCOORD4.zw = u_xlat12.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD7.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat1.xyw, vec3(bvec3(u_xlatb15)));
    vs_TEXCOORD7.z = u_xlatb15 ? _DitherAlpha : float(0.0);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + _WorldSpaceLightPos0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat16_4 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_9 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat16_9 * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat0.x;
    u_xlat16_4 = max(u_xlat16_4, 0.00100000005);
    u_xlat16_4 = log2(u_xlat16_4);
    u_xlat16_4 = u_xlat16_4 * _Shininess;
    vs_COLOR1.z = exp2(u_xlat16_4);
    vs_COLOR1.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _Emission;
uniform 	mediump float _PartialEmission;
uniform 	mediump float _PartialEmissionScaler;
uniform 	mediump float _LightArea;
uniform 	mediump vec4 _ShadowMultColor;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
in mediump vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD7;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
int u_xlati1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
lowp float u_xlat10_4;
vec3 u_xlat5;
float u_xlat10;
bvec2 u_xlatb12;
vec2 u_xlat16;
ivec2 u_xlati16;
mediump float u_xlat16_20;
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
        u_xlatb0 = !!(vs_TEXCOORD7.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD7.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD7.yx / vs_TEXCOORD7.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb12.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb12.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb12.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD7.z * 17.0 + (-u_xlat0.x);
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
    u_xlat16_2.x = vs_COLOR1.x + (-_LightArea);
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlati1 = int(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat10_0.xyz * _ShadowMultColor.xyz;
    u_xlat16_2.xyz = (int(u_xlati1) != 0) ? u_xlat10_0.xyz : u_xlat16_2.xyz;
    u_xlat16_3.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vs_COLOR1.zzz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _EnvColor.xyz + u_xlat16_3.xyz;
    u_xlat16_20 = u_xlat10_0.w * _PartialEmission;
    u_xlat16_3.xyz = u_xlat10_0.xyz * vec3(vec3(_PartialEmissionScaler, _PartialEmissionScaler, _PartialEmissionScaler)) + (-u_xlat16_2.xyz);
    u_xlat16_0.xyz = vec3(u_xlat16_20) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat10_1 = texture(_SPTex, vs_TEXCOORD4.xy);
    u_xlat10_4 = texture(_SPNoiseTex, vs_TEXCOORD4.zw).x;
    u_xlat4 = u_xlat10_4 * _SPNoiseScaler;
    u_xlat4 = u_xlat4 * 1.99000001 + -1.0;
    u_xlat10 = _SPNoiseScaler * _SPTransition;
    u_xlat16.xy = vec2(u_xlat10) * vec2(1.70000005, 1.5) + (-vec2(u_xlat4));
    u_xlat16.xy = u_xlat16.xy + vec2(1.0, 1.0);
    u_xlat16.xy = floor(u_xlat16.xy);
    u_xlat16.xy = max(u_xlat16.xy, vec2(0.0, 0.0));
    u_xlati16.xy = ivec2(u_xlat16.xy);
    u_xlat4 = u_xlat10 * 1.70000005 + (-u_xlat4);
    u_xlat4 = u_xlat4 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
    u_xlat5.xyz = vec3(u_xlat4) * u_xlat5.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = (u_xlati16.y != 0) ? u_xlat10_1.xyz : u_xlat5.xyz;
    u_xlat4 = (u_xlati16.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_2.xyz = (u_xlati16.x != 0) ? u_xlat16_2.xyz : u_xlat10_1.xyz;
    u_xlat16_0.w = 1.0;
    u_xlat2.xyz = u_xlat16_2.xyz * _Color.xyz + (-u_xlat16_0.xyz);
    u_xlat2.w = (-u_xlat16_0.w) + u_xlat10_1.w;
    u_xlat0 = vec4(u_xlat4) * u_xlat2 + u_xlat16_0;
    SV_Target0.xyz = u_xlat0.xyz * vec3(vec3(_Emission, _Emission, _Emission));
    SV_Target0.w = u_xlat0.w * vs_COLOR1.y;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Opaqueness;
uniform 	mediump float _Shininess;
uniform 	vec4 _ClipPlane;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD7;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_4;
mediump float u_xlat16_9;
float u_xlat11;
vec2 u_xlat12;
float u_xlat15;
int u_xlati15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat2.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    vs_TEXCOORD2.xyz = vec3(0.0, 0.0, 0.0);
    u_xlat15 = _ClipPlane.w + -0.00999999978;
    u_xlat11 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat15 = (-u_xlat15) + u_xlat11;
    u_xlat11 = u_xlat11 + (-_ClipPlane.w);
    u_xlat2.xyz = (-vec3(u_xlat11)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat15 = u_xlat15 + 1.0;
    u_xlat15 = floor(u_xlat15);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlati15 = int(u_xlat15);
    u_xlat3.xyz = in_POSITION0.xyz;
    u_xlat3.w = 1.0;
    u_xlat2.w = 0.0;
    u_xlat2 = (int(u_xlati15) != 0) ? u_xlat3 : u_xlat2;
    u_xlat3 = u_xlat2.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat15 = u_xlat2.x * u_xlat3.x;
    vs_COLOR1.y = u_xlat2.w * _Opaqueness;
    u_xlat11 = u_xlat3.w + u_xlat3.y;
    u_xlat12.x = u_xlat3.z * u_xlat3.z + u_xlat3.x;
    u_xlat12.y = u_xlat15 * 0.25 + u_xlat11;
    vs_TEXCOORD4.zw = u_xlat12.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD7.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat1.xyw, vec3(bvec3(u_xlatb15)));
    vs_TEXCOORD7.z = u_xlatb15 ? _DitherAlpha : float(0.0);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + _WorldSpaceLightPos0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat16_4 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_9 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat16_9 * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat0.x;
    u_xlat16_4 = max(u_xlat16_4, 0.00100000005);
    u_xlat16_4 = log2(u_xlat16_4);
    u_xlat16_4 = u_xlat16_4 * _Shininess;
    vs_COLOR1.z = exp2(u_xlat16_4);
    vs_COLOR1.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _Emission;
uniform 	mediump float _PartialEmission;
uniform 	mediump float _PartialEmissionScaler;
uniform 	mediump float _LightArea;
uniform 	mediump vec4 _ShadowMultColor;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
in mediump vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD7;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
int u_xlati1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
lowp float u_xlat10_4;
vec3 u_xlat5;
float u_xlat10;
bvec2 u_xlatb12;
vec2 u_xlat16;
ivec2 u_xlati16;
mediump float u_xlat16_20;
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
        u_xlatb0 = !!(vs_TEXCOORD7.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD7.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD7.yx / vs_TEXCOORD7.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb12.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb12.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb12.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD7.z * 17.0 + (-u_xlat0.x);
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
    u_xlat16_2.x = vs_COLOR1.x + (-_LightArea);
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlati1 = int(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat10_0.xyz * _ShadowMultColor.xyz;
    u_xlat16_2.xyz = (int(u_xlati1) != 0) ? u_xlat10_0.xyz : u_xlat16_2.xyz;
    u_xlat16_3.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vs_COLOR1.zzz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _EnvColor.xyz + u_xlat16_3.xyz;
    u_xlat16_20 = u_xlat10_0.w * _PartialEmission;
    u_xlat16_3.xyz = u_xlat10_0.xyz * vec3(vec3(_PartialEmissionScaler, _PartialEmissionScaler, _PartialEmissionScaler)) + (-u_xlat16_2.xyz);
    u_xlat16_0.xyz = vec3(u_xlat16_20) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat10_1 = texture(_SPTex, vs_TEXCOORD4.xy);
    u_xlat10_4 = texture(_SPNoiseTex, vs_TEXCOORD4.zw).x;
    u_xlat4 = u_xlat10_4 * _SPNoiseScaler;
    u_xlat4 = u_xlat4 * 1.99000001 + -1.0;
    u_xlat10 = _SPNoiseScaler * _SPTransition;
    u_xlat16.xy = vec2(u_xlat10) * vec2(1.70000005, 1.5) + (-vec2(u_xlat4));
    u_xlat16.xy = u_xlat16.xy + vec2(1.0, 1.0);
    u_xlat16.xy = floor(u_xlat16.xy);
    u_xlat16.xy = max(u_xlat16.xy, vec2(0.0, 0.0));
    u_xlati16.xy = ivec2(u_xlat16.xy);
    u_xlat4 = u_xlat10 * 1.70000005 + (-u_xlat4);
    u_xlat4 = u_xlat4 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
    u_xlat5.xyz = vec3(u_xlat4) * u_xlat5.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = (u_xlati16.y != 0) ? u_xlat10_1.xyz : u_xlat5.xyz;
    u_xlat4 = (u_xlati16.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_2.xyz = (u_xlati16.x != 0) ? u_xlat16_2.xyz : u_xlat10_1.xyz;
    u_xlat16_0.w = 1.0;
    u_xlat2.xyz = u_xlat16_2.xyz * _Color.xyz + (-u_xlat16_0.xyz);
    u_xlat2.w = (-u_xlat16_0.w) + u_xlat10_1.w;
    u_xlat0 = vec4(u_xlat4) * u_xlat2 + u_xlat16_0;
    SV_Target0.xyz = u_xlat0.xyz * vec3(vec3(_Emission, _Emission, _Emission));
    SV_Target0.w = u_xlat0.w * vs_COLOR1.y;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Opaqueness;
uniform 	mediump float _Shininess;
uniform 	vec4 _ClipPlane;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD7;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_4;
mediump float u_xlat16_9;
float u_xlat11;
vec2 u_xlat12;
float u_xlat15;
int u_xlati15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat2.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    vs_TEXCOORD2.xyz = vec3(0.0, 0.0, 0.0);
    u_xlat15 = _ClipPlane.w + -0.00999999978;
    u_xlat11 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat15 = (-u_xlat15) + u_xlat11;
    u_xlat11 = u_xlat11 + (-_ClipPlane.w);
    u_xlat2.xyz = (-vec3(u_xlat11)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat15 = u_xlat15 + 1.0;
    u_xlat15 = floor(u_xlat15);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlati15 = int(u_xlat15);
    u_xlat3.xyz = in_POSITION0.xyz;
    u_xlat3.w = 1.0;
    u_xlat2.w = 0.0;
    u_xlat2 = (int(u_xlati15) != 0) ? u_xlat3 : u_xlat2;
    u_xlat3 = u_xlat2.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat15 = u_xlat2.x * u_xlat3.x;
    vs_COLOR1.y = u_xlat2.w * _Opaqueness;
    u_xlat11 = u_xlat3.w + u_xlat3.y;
    u_xlat12.x = u_xlat3.z * u_xlat3.z + u_xlat3.x;
    u_xlat12.y = u_xlat15 * 0.25 + u_xlat11;
    vs_TEXCOORD4.zw = u_xlat12.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD7.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat1.xyw, vec3(bvec3(u_xlatb15)));
    vs_TEXCOORD7.z = u_xlatb15 ? _DitherAlpha : float(0.0);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + _WorldSpaceLightPos0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat16_4 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_9 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat16_9 * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat0.x;
    u_xlat16_4 = max(u_xlat16_4, 0.00100000005);
    u_xlat16_4 = log2(u_xlat16_4);
    u_xlat16_4 = u_xlat16_4 * _Shininess;
    vs_COLOR1.z = exp2(u_xlat16_4);
    vs_COLOR1.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _Emission;
uniform 	mediump float _PartialEmission;
uniform 	mediump float _PartialEmissionScaler;
uniform 	mediump float _LightArea;
uniform 	mediump vec4 _ShadowMultColor;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
in mediump vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD7;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
int u_xlati1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
lowp float u_xlat10_4;
vec3 u_xlat5;
float u_xlat10;
bvec2 u_xlatb12;
vec2 u_xlat16;
ivec2 u_xlati16;
mediump float u_xlat16_20;
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
        u_xlatb0 = !!(vs_TEXCOORD7.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD7.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD7.yx / vs_TEXCOORD7.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb12.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb12.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb12.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD7.z * 17.0 + (-u_xlat0.x);
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
    u_xlat16_2.x = vs_COLOR1.x + (-_LightArea);
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlati1 = int(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat10_0.xyz * _ShadowMultColor.xyz;
    u_xlat16_2.xyz = (int(u_xlati1) != 0) ? u_xlat10_0.xyz : u_xlat16_2.xyz;
    u_xlat16_3.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vs_COLOR1.zzz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _EnvColor.xyz + u_xlat16_3.xyz;
    u_xlat16_20 = u_xlat10_0.w * _PartialEmission;
    u_xlat16_3.xyz = u_xlat10_0.xyz * vec3(vec3(_PartialEmissionScaler, _PartialEmissionScaler, _PartialEmissionScaler)) + (-u_xlat16_2.xyz);
    u_xlat16_0.xyz = vec3(u_xlat16_20) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat10_1 = texture(_SPTex, vs_TEXCOORD4.xy);
    u_xlat10_4 = texture(_SPNoiseTex, vs_TEXCOORD4.zw).x;
    u_xlat4 = u_xlat10_4 * _SPNoiseScaler;
    u_xlat4 = u_xlat4 * 1.99000001 + -1.0;
    u_xlat10 = _SPNoiseScaler * _SPTransition;
    u_xlat16.xy = vec2(u_xlat10) * vec2(1.70000005, 1.5) + (-vec2(u_xlat4));
    u_xlat16.xy = u_xlat16.xy + vec2(1.0, 1.0);
    u_xlat16.xy = floor(u_xlat16.xy);
    u_xlat16.xy = max(u_xlat16.xy, vec2(0.0, 0.0));
    u_xlati16.xy = ivec2(u_xlat16.xy);
    u_xlat4 = u_xlat10 * 1.70000005 + (-u_xlat4);
    u_xlat4 = u_xlat4 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
    u_xlat5.xyz = vec3(u_xlat4) * u_xlat5.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = (u_xlati16.y != 0) ? u_xlat10_1.xyz : u_xlat5.xyz;
    u_xlat4 = (u_xlati16.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_2.xyz = (u_xlati16.x != 0) ? u_xlat16_2.xyz : u_xlat10_1.xyz;
    u_xlat16_0.w = 1.0;
    u_xlat2.xyz = u_xlat16_2.xyz * _Color.xyz + (-u_xlat16_0.xyz);
    u_xlat2.w = (-u_xlat16_0.w) + u_xlat10_1.w;
    u_xlat0 = vec4(u_xlat4) * u_xlat2 + u_xlat16_0;
    SV_Target0.xyz = u_xlat0.xyz * vec3(vec3(_Emission, _Emission, _Emission));
    SV_Target0.w = u_xlat0.w * vs_COLOR1.y;
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
SubProgram "gles3 hw_tier00 " {
Keywords { "OVERHEAT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec3 _OverheatColor;
uniform 	mediump float _OverheatEmissionScaler;
uniform 	mediump float _OverheatIntensity;
uniform 	mediump float _Opaqueness;
uniform 	mediump float _Shininess;
uniform 	vec4 _ClipPlane;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec3 in_COLOR0;
out mediump vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD7;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_4;
mediump float u_xlat16_9;
float u_xlat11;
vec2 u_xlat12;
float u_xlat15;
int u_xlati15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat2.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    vs_TEXCOORD2.xyz = vec3(0.0, 0.0, 0.0);
    vs_TEXCOORD3.xyz = vec3(_OverheatColor.xxyz.y * _OverheatEmissionScaler, _OverheatColor.xxyz.z * _OverheatEmissionScaler, float(_OverheatColor.z) * _OverheatEmissionScaler);
    vs_TEXCOORD3.w = in_COLOR0.x * _OverheatIntensity;
    u_xlat15 = _ClipPlane.w + -0.00999999978;
    u_xlat11 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat15 = (-u_xlat15) + u_xlat11;
    u_xlat11 = u_xlat11 + (-_ClipPlane.w);
    u_xlat2.xyz = (-vec3(u_xlat11)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat15 = u_xlat15 + 1.0;
    u_xlat15 = floor(u_xlat15);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlati15 = int(u_xlat15);
    u_xlat3.xyz = in_POSITION0.xyz;
    u_xlat3.w = 1.0;
    u_xlat2.w = 0.0;
    u_xlat2 = (int(u_xlati15) != 0) ? u_xlat3 : u_xlat2;
    u_xlat3 = u_xlat2.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat15 = u_xlat2.x * u_xlat3.x;
    vs_COLOR1.y = u_xlat2.w * _Opaqueness;
    u_xlat11 = u_xlat3.w + u_xlat3.y;
    u_xlat12.x = u_xlat3.z * u_xlat3.z + u_xlat3.x;
    u_xlat12.y = u_xlat15 * 0.25 + u_xlat11;
    vs_TEXCOORD4.zw = u_xlat12.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD7.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat1.xyw, vec3(bvec3(u_xlatb15)));
    vs_TEXCOORD7.z = u_xlatb15 ? _DitherAlpha : float(0.0);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + _WorldSpaceLightPos0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat16_4 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_9 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat16_9 * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat0.x;
    u_xlat16_4 = max(u_xlat16_4, 0.00100000005);
    u_xlat16_4 = log2(u_xlat16_4);
    u_xlat16_4 = u_xlat16_4 * _Shininess;
    vs_COLOR1.z = exp2(u_xlat16_4);
    vs_COLOR1.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _Emission;
uniform 	mediump float _PartialEmission;
uniform 	mediump float _PartialEmissionScaler;
uniform 	mediump float _OverheatEmissionScaler;
uniform 	mediump float _LightArea;
uniform 	mediump vec4 _ShadowMultColor;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD7;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
int u_xlati1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat4;
lowp float u_xlat10_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat11;
bvec2 u_xlatb14;
vec2 u_xlat18;
ivec2 u_xlati18;
mediump float u_xlat16_23;
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
        u_xlatb0 = !!(vs_TEXCOORD7.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD7.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD7.yx / vs_TEXCOORD7.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb14.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb14.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb14.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD7.z * 17.0 + (-u_xlat0.x);
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
    u_xlat16_2.x = vs_COLOR1.x + (-_LightArea);
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlati1 = int(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat10_0.xyz * _ShadowMultColor.xyz;
    u_xlat16_2.xyz = (int(u_xlati1) != 0) ? u_xlat10_0.xyz : u_xlat16_2.xyz;
    u_xlat16_3.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vs_COLOR1.zzz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _EnvColor.xyz + u_xlat16_3.xyz;
    u_xlat16_23 = u_xlat10_0.w * _PartialEmission;
    u_xlat16_3.xyz = u_xlat10_0.xyz * vec3(vec3(_PartialEmissionScaler, _PartialEmissionScaler, _PartialEmissionScaler)) + (-u_xlat16_2.xyz);
    u_xlat16_0.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_2.x = _OverheatEmissionScaler + -1.0;
    u_xlat16_2.x = vs_TEXCOORD3.w * u_xlat16_2.x + 1.0;
    u_xlat10_1 = texture(_SPTex, vs_TEXCOORD4.xy);
    u_xlat10_4 = texture(_SPNoiseTex, vs_TEXCOORD4.zw).x;
    u_xlat4 = u_xlat10_4 * _SPNoiseScaler;
    u_xlat4 = u_xlat4 * 1.99000001 + -1.0;
    u_xlat11 = _SPNoiseScaler * _SPTransition;
    u_xlat18.xy = vec2(u_xlat11) * vec2(1.70000005, 1.5) + (-vec2(u_xlat4));
    u_xlat18.xy = u_xlat18.xy + vec2(1.0, 1.0);
    u_xlat18.xy = floor(u_xlat18.xy);
    u_xlat18.xy = max(u_xlat18.xy, vec2(0.0, 0.0));
    u_xlati18.xy = ivec2(u_xlat18.xy);
    u_xlat4 = u_xlat11 * 1.70000005 + (-u_xlat4);
    u_xlat4 = u_xlat4 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
    u_xlat5.xyz = vec3(u_xlat4) * u_xlat5.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat10_1.xyz;
    u_xlat16_2.xyz = (u_xlati18.y != 0) ? u_xlat16_2.xyz : u_xlat5.xyz;
    u_xlat4 = (u_xlati18.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_23 = 1.0;
    u_xlat16_23 = (u_xlati18.x != 0) ? u_xlat16_23 : 0.0;
    u_xlat16_2.xyz = (u_xlati18.x != 0) ? u_xlat16_2.xyz : u_xlat10_1.xyz;
    u_xlat16_0.w = 1.0;
    u_xlat3.xyz = (-u_xlat16_0.xyz) + u_xlat16_2.xyz;
    u_xlat3.w = (-u_xlat16_0.w) + u_xlat10_1.w;
    u_xlat0 = vec4(u_xlat4) * u_xlat3 + u_xlat16_0;
    u_xlat16_2.xyz = u_xlat0.xyz * vec3(vec3(_Emission, _Emission, _Emission));
    u_xlat16_6.xyz = (-u_xlat0.xyz) * vec3(vec3(_Emission, _Emission, _Emission)) + vs_TEXCOORD3.xyz;
    u_xlat16_2.xyz = vs_TEXCOORD3.www * u_xlat16_6.xyz + u_xlat16_2.xyz;
    u_xlat16_6.xyz = u_xlat0.xyz * vec3(vec3(_Emission, _Emission, _Emission)) + (-u_xlat16_2.xyz);
    SV_Target0.xyz = vec3(u_xlat16_23) * u_xlat16_6.xyz + u_xlat16_2.xyz;
    SV_Target0.w = u_xlat0.w * vs_COLOR1.y;
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
Keywords { "OVERHEAT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec3 _OverheatColor;
uniform 	mediump float _OverheatEmissionScaler;
uniform 	mediump float _OverheatIntensity;
uniform 	mediump float _Opaqueness;
uniform 	mediump float _Shininess;
uniform 	vec4 _ClipPlane;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec3 in_COLOR0;
out mediump vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD7;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_4;
mediump float u_xlat16_9;
float u_xlat11;
vec2 u_xlat12;
float u_xlat15;
int u_xlati15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat2.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    vs_TEXCOORD2.xyz = vec3(0.0, 0.0, 0.0);
    vs_TEXCOORD3.xyz = vec3(_OverheatColor.xxyz.y * _OverheatEmissionScaler, _OverheatColor.xxyz.z * _OverheatEmissionScaler, float(_OverheatColor.z) * _OverheatEmissionScaler);
    vs_TEXCOORD3.w = in_COLOR0.x * _OverheatIntensity;
    u_xlat15 = _ClipPlane.w + -0.00999999978;
    u_xlat11 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat15 = (-u_xlat15) + u_xlat11;
    u_xlat11 = u_xlat11 + (-_ClipPlane.w);
    u_xlat2.xyz = (-vec3(u_xlat11)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat15 = u_xlat15 + 1.0;
    u_xlat15 = floor(u_xlat15);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlati15 = int(u_xlat15);
    u_xlat3.xyz = in_POSITION0.xyz;
    u_xlat3.w = 1.0;
    u_xlat2.w = 0.0;
    u_xlat2 = (int(u_xlati15) != 0) ? u_xlat3 : u_xlat2;
    u_xlat3 = u_xlat2.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat15 = u_xlat2.x * u_xlat3.x;
    vs_COLOR1.y = u_xlat2.w * _Opaqueness;
    u_xlat11 = u_xlat3.w + u_xlat3.y;
    u_xlat12.x = u_xlat3.z * u_xlat3.z + u_xlat3.x;
    u_xlat12.y = u_xlat15 * 0.25 + u_xlat11;
    vs_TEXCOORD4.zw = u_xlat12.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD7.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat1.xyw, vec3(bvec3(u_xlatb15)));
    vs_TEXCOORD7.z = u_xlatb15 ? _DitherAlpha : float(0.0);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + _WorldSpaceLightPos0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat16_4 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_9 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat16_9 * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat0.x;
    u_xlat16_4 = max(u_xlat16_4, 0.00100000005);
    u_xlat16_4 = log2(u_xlat16_4);
    u_xlat16_4 = u_xlat16_4 * _Shininess;
    vs_COLOR1.z = exp2(u_xlat16_4);
    vs_COLOR1.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _Emission;
uniform 	mediump float _PartialEmission;
uniform 	mediump float _PartialEmissionScaler;
uniform 	mediump float _OverheatEmissionScaler;
uniform 	mediump float _LightArea;
uniform 	mediump vec4 _ShadowMultColor;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD7;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
int u_xlati1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat4;
lowp float u_xlat10_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat11;
bvec2 u_xlatb14;
vec2 u_xlat18;
ivec2 u_xlati18;
mediump float u_xlat16_23;
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
        u_xlatb0 = !!(vs_TEXCOORD7.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD7.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD7.yx / vs_TEXCOORD7.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb14.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb14.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb14.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD7.z * 17.0 + (-u_xlat0.x);
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
    u_xlat16_2.x = vs_COLOR1.x + (-_LightArea);
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlati1 = int(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat10_0.xyz * _ShadowMultColor.xyz;
    u_xlat16_2.xyz = (int(u_xlati1) != 0) ? u_xlat10_0.xyz : u_xlat16_2.xyz;
    u_xlat16_3.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vs_COLOR1.zzz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _EnvColor.xyz + u_xlat16_3.xyz;
    u_xlat16_23 = u_xlat10_0.w * _PartialEmission;
    u_xlat16_3.xyz = u_xlat10_0.xyz * vec3(vec3(_PartialEmissionScaler, _PartialEmissionScaler, _PartialEmissionScaler)) + (-u_xlat16_2.xyz);
    u_xlat16_0.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_2.x = _OverheatEmissionScaler + -1.0;
    u_xlat16_2.x = vs_TEXCOORD3.w * u_xlat16_2.x + 1.0;
    u_xlat10_1 = texture(_SPTex, vs_TEXCOORD4.xy);
    u_xlat10_4 = texture(_SPNoiseTex, vs_TEXCOORD4.zw).x;
    u_xlat4 = u_xlat10_4 * _SPNoiseScaler;
    u_xlat4 = u_xlat4 * 1.99000001 + -1.0;
    u_xlat11 = _SPNoiseScaler * _SPTransition;
    u_xlat18.xy = vec2(u_xlat11) * vec2(1.70000005, 1.5) + (-vec2(u_xlat4));
    u_xlat18.xy = u_xlat18.xy + vec2(1.0, 1.0);
    u_xlat18.xy = floor(u_xlat18.xy);
    u_xlat18.xy = max(u_xlat18.xy, vec2(0.0, 0.0));
    u_xlati18.xy = ivec2(u_xlat18.xy);
    u_xlat4 = u_xlat11 * 1.70000005 + (-u_xlat4);
    u_xlat4 = u_xlat4 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
    u_xlat5.xyz = vec3(u_xlat4) * u_xlat5.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat10_1.xyz;
    u_xlat16_2.xyz = (u_xlati18.y != 0) ? u_xlat16_2.xyz : u_xlat5.xyz;
    u_xlat4 = (u_xlati18.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_23 = 1.0;
    u_xlat16_23 = (u_xlati18.x != 0) ? u_xlat16_23 : 0.0;
    u_xlat16_2.xyz = (u_xlati18.x != 0) ? u_xlat16_2.xyz : u_xlat10_1.xyz;
    u_xlat16_0.w = 1.0;
    u_xlat3.xyz = (-u_xlat16_0.xyz) + u_xlat16_2.xyz;
    u_xlat3.w = (-u_xlat16_0.w) + u_xlat10_1.w;
    u_xlat0 = vec4(u_xlat4) * u_xlat3 + u_xlat16_0;
    u_xlat16_2.xyz = u_xlat0.xyz * vec3(vec3(_Emission, _Emission, _Emission));
    u_xlat16_6.xyz = (-u_xlat0.xyz) * vec3(vec3(_Emission, _Emission, _Emission)) + vs_TEXCOORD3.xyz;
    u_xlat16_2.xyz = vs_TEXCOORD3.www * u_xlat16_6.xyz + u_xlat16_2.xyz;
    u_xlat16_6.xyz = u_xlat0.xyz * vec3(vec3(_Emission, _Emission, _Emission)) + (-u_xlat16_2.xyz);
    SV_Target0.xyz = vec3(u_xlat16_23) * u_xlat16_6.xyz + u_xlat16_2.xyz;
    SV_Target0.w = u_xlat0.w * vs_COLOR1.y;
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
Keywords { "OVERHEAT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec3 _OverheatColor;
uniform 	mediump float _OverheatEmissionScaler;
uniform 	mediump float _OverheatIntensity;
uniform 	mediump float _Opaqueness;
uniform 	mediump float _Shininess;
uniform 	vec4 _ClipPlane;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec3 in_COLOR0;
out mediump vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD7;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_4;
mediump float u_xlat16_9;
float u_xlat11;
vec2 u_xlat12;
float u_xlat15;
int u_xlati15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat2.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    vs_TEXCOORD2.xyz = vec3(0.0, 0.0, 0.0);
    vs_TEXCOORD3.xyz = vec3(_OverheatColor.xxyz.y * _OverheatEmissionScaler, _OverheatColor.xxyz.z * _OverheatEmissionScaler, float(_OverheatColor.z) * _OverheatEmissionScaler);
    vs_TEXCOORD3.w = in_COLOR0.x * _OverheatIntensity;
    u_xlat15 = _ClipPlane.w + -0.00999999978;
    u_xlat11 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat15 = (-u_xlat15) + u_xlat11;
    u_xlat11 = u_xlat11 + (-_ClipPlane.w);
    u_xlat2.xyz = (-vec3(u_xlat11)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat15 = u_xlat15 + 1.0;
    u_xlat15 = floor(u_xlat15);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlati15 = int(u_xlat15);
    u_xlat3.xyz = in_POSITION0.xyz;
    u_xlat3.w = 1.0;
    u_xlat2.w = 0.0;
    u_xlat2 = (int(u_xlati15) != 0) ? u_xlat3 : u_xlat2;
    u_xlat3 = u_xlat2.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat15 = u_xlat2.x * u_xlat3.x;
    vs_COLOR1.y = u_xlat2.w * _Opaqueness;
    u_xlat11 = u_xlat3.w + u_xlat3.y;
    u_xlat12.x = u_xlat3.z * u_xlat3.z + u_xlat3.x;
    u_xlat12.y = u_xlat15 * 0.25 + u_xlat11;
    vs_TEXCOORD4.zw = u_xlat12.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD7.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat1.xyw, vec3(bvec3(u_xlatb15)));
    vs_TEXCOORD7.z = u_xlatb15 ? _DitherAlpha : float(0.0);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + _WorldSpaceLightPos0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat16_4 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_9 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat16_9 * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat0.x;
    u_xlat16_4 = max(u_xlat16_4, 0.00100000005);
    u_xlat16_4 = log2(u_xlat16_4);
    u_xlat16_4 = u_xlat16_4 * _Shininess;
    vs_COLOR1.z = exp2(u_xlat16_4);
    vs_COLOR1.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _Emission;
uniform 	mediump float _PartialEmission;
uniform 	mediump float _PartialEmissionScaler;
uniform 	mediump float _OverheatEmissionScaler;
uniform 	mediump float _LightArea;
uniform 	mediump vec4 _ShadowMultColor;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD7;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
int u_xlati1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat4;
lowp float u_xlat10_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat11;
bvec2 u_xlatb14;
vec2 u_xlat18;
ivec2 u_xlati18;
mediump float u_xlat16_23;
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
        u_xlatb0 = !!(vs_TEXCOORD7.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD7.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD7.yx / vs_TEXCOORD7.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb14.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb14.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb14.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD7.z * 17.0 + (-u_xlat0.x);
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
    u_xlat16_2.x = vs_COLOR1.x + (-_LightArea);
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlati1 = int(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat10_0.xyz * _ShadowMultColor.xyz;
    u_xlat16_2.xyz = (int(u_xlati1) != 0) ? u_xlat10_0.xyz : u_xlat16_2.xyz;
    u_xlat16_3.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vs_COLOR1.zzz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _EnvColor.xyz + u_xlat16_3.xyz;
    u_xlat16_23 = u_xlat10_0.w * _PartialEmission;
    u_xlat16_3.xyz = u_xlat10_0.xyz * vec3(vec3(_PartialEmissionScaler, _PartialEmissionScaler, _PartialEmissionScaler)) + (-u_xlat16_2.xyz);
    u_xlat16_0.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_2.x = _OverheatEmissionScaler + -1.0;
    u_xlat16_2.x = vs_TEXCOORD3.w * u_xlat16_2.x + 1.0;
    u_xlat10_1 = texture(_SPTex, vs_TEXCOORD4.xy);
    u_xlat10_4 = texture(_SPNoiseTex, vs_TEXCOORD4.zw).x;
    u_xlat4 = u_xlat10_4 * _SPNoiseScaler;
    u_xlat4 = u_xlat4 * 1.99000001 + -1.0;
    u_xlat11 = _SPNoiseScaler * _SPTransition;
    u_xlat18.xy = vec2(u_xlat11) * vec2(1.70000005, 1.5) + (-vec2(u_xlat4));
    u_xlat18.xy = u_xlat18.xy + vec2(1.0, 1.0);
    u_xlat18.xy = floor(u_xlat18.xy);
    u_xlat18.xy = max(u_xlat18.xy, vec2(0.0, 0.0));
    u_xlati18.xy = ivec2(u_xlat18.xy);
    u_xlat4 = u_xlat11 * 1.70000005 + (-u_xlat4);
    u_xlat4 = u_xlat4 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
    u_xlat5.xyz = vec3(u_xlat4) * u_xlat5.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat10_1.xyz;
    u_xlat16_2.xyz = (u_xlati18.y != 0) ? u_xlat16_2.xyz : u_xlat5.xyz;
    u_xlat4 = (u_xlati18.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_23 = 1.0;
    u_xlat16_23 = (u_xlati18.x != 0) ? u_xlat16_23 : 0.0;
    u_xlat16_2.xyz = (u_xlati18.x != 0) ? u_xlat16_2.xyz : u_xlat10_1.xyz;
    u_xlat16_0.w = 1.0;
    u_xlat3.xyz = (-u_xlat16_0.xyz) + u_xlat16_2.xyz;
    u_xlat3.w = (-u_xlat16_0.w) + u_xlat10_1.w;
    u_xlat0 = vec4(u_xlat4) * u_xlat3 + u_xlat16_0;
    u_xlat16_2.xyz = u_xlat0.xyz * vec3(vec3(_Emission, _Emission, _Emission));
    u_xlat16_6.xyz = (-u_xlat0.xyz) * vec3(vec3(_Emission, _Emission, _Emission)) + vs_TEXCOORD3.xyz;
    u_xlat16_2.xyz = vs_TEXCOORD3.www * u_xlat16_6.xyz + u_xlat16_2.xyz;
    u_xlat16_6.xyz = u_xlat0.xyz * vec3(vec3(_Emission, _Emission, _Emission)) + (-u_xlat16_2.xyz);
    SV_Target0.xyz = vec3(u_xlat16_23) * u_xlat16_6.xyz + u_xlat16_2.xyz;
    SV_Target0.w = u_xlat0.w * vs_COLOR1.y;
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
SubProgram "gles3 hw_tier00 " {
Keywords { "RIM_GLOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Opaqueness;
uniform 	mediump float _Shininess;
uniform 	vec4 _ClipPlane;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_4;
mediump float u_xlat16_9;
float u_xlat11;
vec2 u_xlat12;
float u_xlat15;
int u_xlati15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat2.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    vs_TEXCOORD2.xyz = vec3(0.0, 0.0, 0.0);
    u_xlat15 = _ClipPlane.w + -0.00999999978;
    u_xlat11 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat15 = (-u_xlat15) + u_xlat11;
    u_xlat11 = u_xlat11 + (-_ClipPlane.w);
    u_xlat2.xyz = (-vec3(u_xlat11)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat15 = u_xlat15 + 1.0;
    u_xlat15 = floor(u_xlat15);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlati15 = int(u_xlat15);
    u_xlat3.xyz = in_POSITION0.xyz;
    u_xlat3.w = 1.0;
    u_xlat2.w = 0.0;
    u_xlat2 = (int(u_xlati15) != 0) ? u_xlat3 : u_xlat2;
    u_xlat3 = u_xlat2.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat15 = u_xlat2.x * u_xlat3.x;
    vs_COLOR1.y = u_xlat2.w * _Opaqueness;
    u_xlat11 = u_xlat3.w + u_xlat3.y;
    u_xlat12.x = u_xlat3.z * u_xlat3.z + u_xlat3.x;
    u_xlat12.y = u_xlat15 * 0.25 + u_xlat11;
    vs_TEXCOORD4.zw = u_xlat12.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat15 * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat3.zz + u_xlat3.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD7.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat1.xyw, vec3(bvec3(u_xlatb15)));
    vs_TEXCOORD7.z = u_xlatb15 ? _DitherAlpha : float(0.0);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_4 = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat16_9 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat16_9 * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat0.x;
    u_xlat16_4 = max(u_xlat16_4, 0.00100000005);
    u_xlat16_4 = log2(u_xlat16_4);
    u_xlat16_4 = u_xlat16_4 * _Shininess;
    vs_COLOR1.z = exp2(u_xlat16_4);
    vs_COLOR1.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _Emission;
uniform 	mediump float _PartialEmission;
uniform 	mediump float _PartialEmissionScaler;
uniform 	mediump float _LightArea;
uniform 	mediump vec4 _ShadowMultColor;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
in mediump vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
int u_xlati1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
vec3 u_xlat5;
float u_xlat7;
float u_xlat10;
bvec2 u_xlatb12;
vec2 u_xlat16;
ivec2 u_xlati16;
float u_xlat19;
mediump float u_xlat16_20;
mediump float u_xlat16_21;
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
        u_xlatb0 = !!(vs_TEXCOORD7.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD7.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD7.yx / vs_TEXCOORD7.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb12.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb12.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb12.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD7.z * 17.0 + (-u_xlat0.x);
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
    u_xlat16_2.x = vs_COLOR1.x + (-_LightArea);
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlati1 = int(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat10_0.xyz * _ShadowMultColor.xyz;
    u_xlat16_2.xyz = (int(u_xlati1) != 0) ? u_xlat10_0.xyz : u_xlat16_2.xyz;
    u_xlat16_3.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vs_COLOR1.zzz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _EnvColor.xyz + u_xlat16_3.xyz;
    u_xlat16_20 = u_xlat10_0.w * _PartialEmission;
    u_xlat16_3.xyz = u_xlat10_0.xyz * vec3(vec3(_PartialEmissionScaler, _PartialEmissionScaler, _PartialEmissionScaler)) + (-u_xlat16_2.xyz);
    u_xlat16_0.xyz = vec3(u_xlat16_20) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat10_1 = texture(_SPTex, vs_TEXCOORD4.xy);
    u_xlat10_4 = texture(_SPNoiseTex, vs_TEXCOORD4.zw).x;
    u_xlat4.x = u_xlat10_4 * _SPNoiseScaler;
    u_xlat4.x = u_xlat4.x * 1.99000001 + -1.0;
    u_xlat10 = _SPNoiseScaler * _SPTransition;
    u_xlat16.xy = vec2(u_xlat10) * vec2(1.70000005, 1.5) + (-u_xlat4.xx);
    u_xlat16.xy = u_xlat16.xy + vec2(1.0, 1.0);
    u_xlat16.xy = floor(u_xlat16.xy);
    u_xlat16.xy = max(u_xlat16.xy, vec2(0.0, 0.0));
    u_xlati16.xy = ivec2(u_xlat16.xy);
    u_xlat4.x = u_xlat10 * 1.70000005 + (-u_xlat4.x);
    u_xlat4.x = u_xlat4.x * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
    u_xlat5.xyz = u_xlat4.xxx * u_xlat5.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = (u_xlati16.y != 0) ? u_xlat10_1.xyz : u_xlat5.xyz;
    u_xlat4.x = (u_xlati16.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_2.xyz = (u_xlati16.x != 0) ? u_xlat16_2.xyz : u_xlat10_1.xyz;
    u_xlat16_0.w = 1.0;
    u_xlat2.xyz = u_xlat16_2.xyz * _Color.xyz + (-u_xlat16_0.xyz);
    u_xlat2.w = (-u_xlat16_0.w) + u_xlat10_1.w;
    u_xlat0 = u_xlat4.xxxx * u_xlat2 + u_xlat16_0;
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(vec3(_Emission, _Emission, _Emission));
    SV_Target0.w = u_xlat0.w * vs_COLOR1.y;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat1.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD5.xyz;
    u_xlat19 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * vs_TEXCOORD6.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.00100005;
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGShininess;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGScale + _RGBias;
    u_xlat16_21 = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat7 = u_xlat16_21 * _RGRatio;
    u_xlat1.xzw = u_xlat1.xxx * _RGColor.xyz + (-u_xlat16_3.xyz);
    u_xlat1.xyz = vec3(u_xlat7) * u_xlat1.xzw + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "RIM_GLOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Opaqueness;
uniform 	mediump float _Shininess;
uniform 	vec4 _ClipPlane;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_4;
mediump float u_xlat16_9;
float u_xlat11;
vec2 u_xlat12;
float u_xlat15;
int u_xlati15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat2.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    vs_TEXCOORD2.xyz = vec3(0.0, 0.0, 0.0);
    u_xlat15 = _ClipPlane.w + -0.00999999978;
    u_xlat11 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat15 = (-u_xlat15) + u_xlat11;
    u_xlat11 = u_xlat11 + (-_ClipPlane.w);
    u_xlat2.xyz = (-vec3(u_xlat11)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat15 = u_xlat15 + 1.0;
    u_xlat15 = floor(u_xlat15);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlati15 = int(u_xlat15);
    u_xlat3.xyz = in_POSITION0.xyz;
    u_xlat3.w = 1.0;
    u_xlat2.w = 0.0;
    u_xlat2 = (int(u_xlati15) != 0) ? u_xlat3 : u_xlat2;
    u_xlat3 = u_xlat2.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat15 = u_xlat2.x * u_xlat3.x;
    vs_COLOR1.y = u_xlat2.w * _Opaqueness;
    u_xlat11 = u_xlat3.w + u_xlat3.y;
    u_xlat12.x = u_xlat3.z * u_xlat3.z + u_xlat3.x;
    u_xlat12.y = u_xlat15 * 0.25 + u_xlat11;
    vs_TEXCOORD4.zw = u_xlat12.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat15 * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat3.zz + u_xlat3.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD7.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat1.xyw, vec3(bvec3(u_xlatb15)));
    vs_TEXCOORD7.z = u_xlatb15 ? _DitherAlpha : float(0.0);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_4 = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat16_9 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat16_9 * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat0.x;
    u_xlat16_4 = max(u_xlat16_4, 0.00100000005);
    u_xlat16_4 = log2(u_xlat16_4);
    u_xlat16_4 = u_xlat16_4 * _Shininess;
    vs_COLOR1.z = exp2(u_xlat16_4);
    vs_COLOR1.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _Emission;
uniform 	mediump float _PartialEmission;
uniform 	mediump float _PartialEmissionScaler;
uniform 	mediump float _LightArea;
uniform 	mediump vec4 _ShadowMultColor;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
in mediump vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
int u_xlati1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
vec3 u_xlat5;
float u_xlat7;
float u_xlat10;
bvec2 u_xlatb12;
vec2 u_xlat16;
ivec2 u_xlati16;
float u_xlat19;
mediump float u_xlat16_20;
mediump float u_xlat16_21;
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
        u_xlatb0 = !!(vs_TEXCOORD7.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD7.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD7.yx / vs_TEXCOORD7.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb12.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb12.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb12.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD7.z * 17.0 + (-u_xlat0.x);
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
    u_xlat16_2.x = vs_COLOR1.x + (-_LightArea);
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlati1 = int(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat10_0.xyz * _ShadowMultColor.xyz;
    u_xlat16_2.xyz = (int(u_xlati1) != 0) ? u_xlat10_0.xyz : u_xlat16_2.xyz;
    u_xlat16_3.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vs_COLOR1.zzz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _EnvColor.xyz + u_xlat16_3.xyz;
    u_xlat16_20 = u_xlat10_0.w * _PartialEmission;
    u_xlat16_3.xyz = u_xlat10_0.xyz * vec3(vec3(_PartialEmissionScaler, _PartialEmissionScaler, _PartialEmissionScaler)) + (-u_xlat16_2.xyz);
    u_xlat16_0.xyz = vec3(u_xlat16_20) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat10_1 = texture(_SPTex, vs_TEXCOORD4.xy);
    u_xlat10_4 = texture(_SPNoiseTex, vs_TEXCOORD4.zw).x;
    u_xlat4.x = u_xlat10_4 * _SPNoiseScaler;
    u_xlat4.x = u_xlat4.x * 1.99000001 + -1.0;
    u_xlat10 = _SPNoiseScaler * _SPTransition;
    u_xlat16.xy = vec2(u_xlat10) * vec2(1.70000005, 1.5) + (-u_xlat4.xx);
    u_xlat16.xy = u_xlat16.xy + vec2(1.0, 1.0);
    u_xlat16.xy = floor(u_xlat16.xy);
    u_xlat16.xy = max(u_xlat16.xy, vec2(0.0, 0.0));
    u_xlati16.xy = ivec2(u_xlat16.xy);
    u_xlat4.x = u_xlat10 * 1.70000005 + (-u_xlat4.x);
    u_xlat4.x = u_xlat4.x * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
    u_xlat5.xyz = u_xlat4.xxx * u_xlat5.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = (u_xlati16.y != 0) ? u_xlat10_1.xyz : u_xlat5.xyz;
    u_xlat4.x = (u_xlati16.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_2.xyz = (u_xlati16.x != 0) ? u_xlat16_2.xyz : u_xlat10_1.xyz;
    u_xlat16_0.w = 1.0;
    u_xlat2.xyz = u_xlat16_2.xyz * _Color.xyz + (-u_xlat16_0.xyz);
    u_xlat2.w = (-u_xlat16_0.w) + u_xlat10_1.w;
    u_xlat0 = u_xlat4.xxxx * u_xlat2 + u_xlat16_0;
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(vec3(_Emission, _Emission, _Emission));
    SV_Target0.w = u_xlat0.w * vs_COLOR1.y;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat1.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD5.xyz;
    u_xlat19 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * vs_TEXCOORD6.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.00100005;
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGShininess;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGScale + _RGBias;
    u_xlat16_21 = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat7 = u_xlat16_21 * _RGRatio;
    u_xlat1.xzw = u_xlat1.xxx * _RGColor.xyz + (-u_xlat16_3.xyz);
    u_xlat1.xyz = vec3(u_xlat7) * u_xlat1.xzw + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "RIM_GLOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Opaqueness;
uniform 	mediump float _Shininess;
uniform 	vec4 _ClipPlane;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_4;
mediump float u_xlat16_9;
float u_xlat11;
vec2 u_xlat12;
float u_xlat15;
int u_xlati15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat2.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    vs_TEXCOORD2.xyz = vec3(0.0, 0.0, 0.0);
    u_xlat15 = _ClipPlane.w + -0.00999999978;
    u_xlat11 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat15 = (-u_xlat15) + u_xlat11;
    u_xlat11 = u_xlat11 + (-_ClipPlane.w);
    u_xlat2.xyz = (-vec3(u_xlat11)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat15 = u_xlat15 + 1.0;
    u_xlat15 = floor(u_xlat15);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlati15 = int(u_xlat15);
    u_xlat3.xyz = in_POSITION0.xyz;
    u_xlat3.w = 1.0;
    u_xlat2.w = 0.0;
    u_xlat2 = (int(u_xlati15) != 0) ? u_xlat3 : u_xlat2;
    u_xlat3 = u_xlat2.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat15 = u_xlat2.x * u_xlat3.x;
    vs_COLOR1.y = u_xlat2.w * _Opaqueness;
    u_xlat11 = u_xlat3.w + u_xlat3.y;
    u_xlat12.x = u_xlat3.z * u_xlat3.z + u_xlat3.x;
    u_xlat12.y = u_xlat15 * 0.25 + u_xlat11;
    vs_TEXCOORD4.zw = u_xlat12.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat15 * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat3.zz + u_xlat3.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD7.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat1.xyw, vec3(bvec3(u_xlatb15)));
    vs_TEXCOORD7.z = u_xlatb15 ? _DitherAlpha : float(0.0);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_4 = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat16_9 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat16_9 * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat0.x;
    u_xlat16_4 = max(u_xlat16_4, 0.00100000005);
    u_xlat16_4 = log2(u_xlat16_4);
    u_xlat16_4 = u_xlat16_4 * _Shininess;
    vs_COLOR1.z = exp2(u_xlat16_4);
    vs_COLOR1.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _Emission;
uniform 	mediump float _PartialEmission;
uniform 	mediump float _PartialEmissionScaler;
uniform 	mediump float _LightArea;
uniform 	mediump vec4 _ShadowMultColor;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
in mediump vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
int u_xlati1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
vec3 u_xlat5;
float u_xlat7;
float u_xlat10;
bvec2 u_xlatb12;
vec2 u_xlat16;
ivec2 u_xlati16;
float u_xlat19;
mediump float u_xlat16_20;
mediump float u_xlat16_21;
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
        u_xlatb0 = !!(vs_TEXCOORD7.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD7.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD7.yx / vs_TEXCOORD7.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb12.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb12.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb12.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD7.z * 17.0 + (-u_xlat0.x);
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
    u_xlat16_2.x = vs_COLOR1.x + (-_LightArea);
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlati1 = int(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat10_0.xyz * _ShadowMultColor.xyz;
    u_xlat16_2.xyz = (int(u_xlati1) != 0) ? u_xlat10_0.xyz : u_xlat16_2.xyz;
    u_xlat16_3.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vs_COLOR1.zzz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _EnvColor.xyz + u_xlat16_3.xyz;
    u_xlat16_20 = u_xlat10_0.w * _PartialEmission;
    u_xlat16_3.xyz = u_xlat10_0.xyz * vec3(vec3(_PartialEmissionScaler, _PartialEmissionScaler, _PartialEmissionScaler)) + (-u_xlat16_2.xyz);
    u_xlat16_0.xyz = vec3(u_xlat16_20) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat10_1 = texture(_SPTex, vs_TEXCOORD4.xy);
    u_xlat10_4 = texture(_SPNoiseTex, vs_TEXCOORD4.zw).x;
    u_xlat4.x = u_xlat10_4 * _SPNoiseScaler;
    u_xlat4.x = u_xlat4.x * 1.99000001 + -1.0;
    u_xlat10 = _SPNoiseScaler * _SPTransition;
    u_xlat16.xy = vec2(u_xlat10) * vec2(1.70000005, 1.5) + (-u_xlat4.xx);
    u_xlat16.xy = u_xlat16.xy + vec2(1.0, 1.0);
    u_xlat16.xy = floor(u_xlat16.xy);
    u_xlat16.xy = max(u_xlat16.xy, vec2(0.0, 0.0));
    u_xlati16.xy = ivec2(u_xlat16.xy);
    u_xlat4.x = u_xlat10 * 1.70000005 + (-u_xlat4.x);
    u_xlat4.x = u_xlat4.x * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
    u_xlat5.xyz = u_xlat4.xxx * u_xlat5.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = (u_xlati16.y != 0) ? u_xlat10_1.xyz : u_xlat5.xyz;
    u_xlat4.x = (u_xlati16.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_2.xyz = (u_xlati16.x != 0) ? u_xlat16_2.xyz : u_xlat10_1.xyz;
    u_xlat16_0.w = 1.0;
    u_xlat2.xyz = u_xlat16_2.xyz * _Color.xyz + (-u_xlat16_0.xyz);
    u_xlat2.w = (-u_xlat16_0.w) + u_xlat10_1.w;
    u_xlat0 = u_xlat4.xxxx * u_xlat2 + u_xlat16_0;
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(vec3(_Emission, _Emission, _Emission));
    SV_Target0.w = u_xlat0.w * vs_COLOR1.y;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat1.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD5.xyz;
    u_xlat19 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * vs_TEXCOORD6.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.00100005;
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGShininess;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGScale + _RGBias;
    u_xlat16_21 = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat7 = u_xlat16_21 * _RGRatio;
    u_xlat1.xzw = u_xlat1.xxx * _RGColor.xyz + (-u_xlat16_3.xyz);
    u_xlat1.xyz = vec3(u_xlat7) * u_xlat1.xzw + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "RIM_GLOW" "OVERHEAT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec3 _OverheatColor;
uniform 	mediump float _OverheatEmissionScaler;
uniform 	mediump float _OverheatIntensity;
uniform 	mediump float _Opaqueness;
uniform 	mediump float _Shininess;
uniform 	vec4 _ClipPlane;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec3 in_COLOR0;
out mediump vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_4;
mediump float u_xlat16_9;
float u_xlat11;
vec2 u_xlat12;
float u_xlat15;
int u_xlati15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat2.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    vs_TEXCOORD2.xyz = vec3(0.0, 0.0, 0.0);
    vs_TEXCOORD3.xyz = vec3(_OverheatColor.xxyz.y * _OverheatEmissionScaler, _OverheatColor.xxyz.z * _OverheatEmissionScaler, float(_OverheatColor.z) * _OverheatEmissionScaler);
    vs_TEXCOORD3.w = in_COLOR0.x * _OverheatIntensity;
    u_xlat15 = _ClipPlane.w + -0.00999999978;
    u_xlat11 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat15 = (-u_xlat15) + u_xlat11;
    u_xlat11 = u_xlat11 + (-_ClipPlane.w);
    u_xlat2.xyz = (-vec3(u_xlat11)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat15 = u_xlat15 + 1.0;
    u_xlat15 = floor(u_xlat15);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlati15 = int(u_xlat15);
    u_xlat3.xyz = in_POSITION0.xyz;
    u_xlat3.w = 1.0;
    u_xlat2.w = 0.0;
    u_xlat2 = (int(u_xlati15) != 0) ? u_xlat3 : u_xlat2;
    u_xlat3 = u_xlat2.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat15 = u_xlat2.x * u_xlat3.x;
    vs_COLOR1.y = u_xlat2.w * _Opaqueness;
    u_xlat11 = u_xlat3.w + u_xlat3.y;
    u_xlat12.x = u_xlat3.z * u_xlat3.z + u_xlat3.x;
    u_xlat12.y = u_xlat15 * 0.25 + u_xlat11;
    vs_TEXCOORD4.zw = u_xlat12.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat15 * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat3.zz + u_xlat3.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD7.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat1.xyw, vec3(bvec3(u_xlatb15)));
    vs_TEXCOORD7.z = u_xlatb15 ? _DitherAlpha : float(0.0);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_4 = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat16_9 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat16_9 * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat0.x;
    u_xlat16_4 = max(u_xlat16_4, 0.00100000005);
    u_xlat16_4 = log2(u_xlat16_4);
    u_xlat16_4 = u_xlat16_4 * _Shininess;
    vs_COLOR1.z = exp2(u_xlat16_4);
    vs_COLOR1.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _Emission;
uniform 	mediump float _PartialEmission;
uniform 	mediump float _PartialEmissionScaler;
uniform 	mediump float _OverheatEmissionScaler;
uniform 	mediump float _LightArea;
uniform 	mediump vec4 _ShadowMultColor;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
int u_xlati1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat8;
float u_xlat11;
bvec2 u_xlatb14;
vec2 u_xlat18;
ivec2 u_xlati18;
float u_xlat22;
mediump float u_xlat16_23;
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
        u_xlatb0 = !!(vs_TEXCOORD7.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD7.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD7.yx / vs_TEXCOORD7.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb14.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb14.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb14.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD7.z * 17.0 + (-u_xlat0.x);
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
    u_xlat16_2.x = vs_COLOR1.x + (-_LightArea);
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlati1 = int(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat10_0.xyz * _ShadowMultColor.xyz;
    u_xlat16_2.xyz = (int(u_xlati1) != 0) ? u_xlat10_0.xyz : u_xlat16_2.xyz;
    u_xlat16_3.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vs_COLOR1.zzz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _EnvColor.xyz + u_xlat16_3.xyz;
    u_xlat16_23 = u_xlat10_0.w * _PartialEmission;
    u_xlat16_3.xyz = u_xlat10_0.xyz * vec3(vec3(_PartialEmissionScaler, _PartialEmissionScaler, _PartialEmissionScaler)) + (-u_xlat16_2.xyz);
    u_xlat16_0.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_2.x = _OverheatEmissionScaler + -1.0;
    u_xlat16_2.x = vs_TEXCOORD3.w * u_xlat16_2.x + 1.0;
    u_xlat10_1 = texture(_SPTex, vs_TEXCOORD4.xy);
    u_xlat10_4 = texture(_SPNoiseTex, vs_TEXCOORD4.zw).x;
    u_xlat4.x = u_xlat10_4 * _SPNoiseScaler;
    u_xlat4.x = u_xlat4.x * 1.99000001 + -1.0;
    u_xlat11 = _SPNoiseScaler * _SPTransition;
    u_xlat18.xy = vec2(u_xlat11) * vec2(1.70000005, 1.5) + (-u_xlat4.xx);
    u_xlat18.xy = u_xlat18.xy + vec2(1.0, 1.0);
    u_xlat18.xy = floor(u_xlat18.xy);
    u_xlat18.xy = max(u_xlat18.xy, vec2(0.0, 0.0));
    u_xlati18.xy = ivec2(u_xlat18.xy);
    u_xlat4.x = u_xlat11 * 1.70000005 + (-u_xlat4.x);
    u_xlat4.x = u_xlat4.x * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
    u_xlat5.xyz = u_xlat4.xxx * u_xlat5.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat10_1.xyz;
    u_xlat16_2.xyz = (u_xlati18.y != 0) ? u_xlat16_2.xyz : u_xlat5.xyz;
    u_xlat4.x = (u_xlati18.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_23 = 1.0;
    u_xlat16_23 = (u_xlati18.x != 0) ? u_xlat16_23 : 0.0;
    u_xlat16_2.xyz = (u_xlati18.x != 0) ? u_xlat16_2.xyz : u_xlat10_1.xyz;
    u_xlat16_0.w = 1.0;
    u_xlat3.xyz = (-u_xlat16_0.xyz) + u_xlat16_2.xyz;
    u_xlat3.w = (-u_xlat16_0.w) + u_xlat10_1.w;
    u_xlat0 = u_xlat4.xxxx * u_xlat3 + u_xlat16_0;
    u_xlat16_2.xyz = u_xlat0.xyz * vec3(vec3(_Emission, _Emission, _Emission));
    u_xlat16_6.xyz = (-u_xlat0.xyz) * vec3(vec3(_Emission, _Emission, _Emission)) + vs_TEXCOORD3.xyz;
    u_xlat16_2.xyz = vs_TEXCOORD3.www * u_xlat16_6.xyz + u_xlat16_2.xyz;
    u_xlat16_6.xyz = u_xlat0.xyz * vec3(vec3(_Emission, _Emission, _Emission)) + (-u_xlat16_2.xyz);
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_6.xyz + u_xlat16_2.xyz;
    SV_Target0.w = u_xlat0.w * vs_COLOR1.y;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat1.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD5.xyz;
    u_xlat22 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * vs_TEXCOORD6.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.00100005;
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGShininess;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGScale + _RGBias;
    u_xlat16_23 = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat16_23 * _RGRatio;
    u_xlat1.xzw = u_xlat1.xxx * _RGColor.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xzw + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "RIM_GLOW" "OVERHEAT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec3 _OverheatColor;
uniform 	mediump float _OverheatEmissionScaler;
uniform 	mediump float _OverheatIntensity;
uniform 	mediump float _Opaqueness;
uniform 	mediump float _Shininess;
uniform 	vec4 _ClipPlane;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec3 in_COLOR0;
out mediump vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_4;
mediump float u_xlat16_9;
float u_xlat11;
vec2 u_xlat12;
float u_xlat15;
int u_xlati15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat2.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    vs_TEXCOORD2.xyz = vec3(0.0, 0.0, 0.0);
    vs_TEXCOORD3.xyz = vec3(_OverheatColor.xxyz.y * _OverheatEmissionScaler, _OverheatColor.xxyz.z * _OverheatEmissionScaler, float(_OverheatColor.z) * _OverheatEmissionScaler);
    vs_TEXCOORD3.w = in_COLOR0.x * _OverheatIntensity;
    u_xlat15 = _ClipPlane.w + -0.00999999978;
    u_xlat11 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat15 = (-u_xlat15) + u_xlat11;
    u_xlat11 = u_xlat11 + (-_ClipPlane.w);
    u_xlat2.xyz = (-vec3(u_xlat11)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat15 = u_xlat15 + 1.0;
    u_xlat15 = floor(u_xlat15);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlati15 = int(u_xlat15);
    u_xlat3.xyz = in_POSITION0.xyz;
    u_xlat3.w = 1.0;
    u_xlat2.w = 0.0;
    u_xlat2 = (int(u_xlati15) != 0) ? u_xlat3 : u_xlat2;
    u_xlat3 = u_xlat2.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat15 = u_xlat2.x * u_xlat3.x;
    vs_COLOR1.y = u_xlat2.w * _Opaqueness;
    u_xlat11 = u_xlat3.w + u_xlat3.y;
    u_xlat12.x = u_xlat3.z * u_xlat3.z + u_xlat3.x;
    u_xlat12.y = u_xlat15 * 0.25 + u_xlat11;
    vs_TEXCOORD4.zw = u_xlat12.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat15 * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat3.zz + u_xlat3.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD7.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat1.xyw, vec3(bvec3(u_xlatb15)));
    vs_TEXCOORD7.z = u_xlatb15 ? _DitherAlpha : float(0.0);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_4 = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat16_9 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat16_9 * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat0.x;
    u_xlat16_4 = max(u_xlat16_4, 0.00100000005);
    u_xlat16_4 = log2(u_xlat16_4);
    u_xlat16_4 = u_xlat16_4 * _Shininess;
    vs_COLOR1.z = exp2(u_xlat16_4);
    vs_COLOR1.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _Emission;
uniform 	mediump float _PartialEmission;
uniform 	mediump float _PartialEmissionScaler;
uniform 	mediump float _OverheatEmissionScaler;
uniform 	mediump float _LightArea;
uniform 	mediump vec4 _ShadowMultColor;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
int u_xlati1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat8;
float u_xlat11;
bvec2 u_xlatb14;
vec2 u_xlat18;
ivec2 u_xlati18;
float u_xlat22;
mediump float u_xlat16_23;
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
        u_xlatb0 = !!(vs_TEXCOORD7.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD7.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD7.yx / vs_TEXCOORD7.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb14.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb14.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb14.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD7.z * 17.0 + (-u_xlat0.x);
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
    u_xlat16_2.x = vs_COLOR1.x + (-_LightArea);
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlati1 = int(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat10_0.xyz * _ShadowMultColor.xyz;
    u_xlat16_2.xyz = (int(u_xlati1) != 0) ? u_xlat10_0.xyz : u_xlat16_2.xyz;
    u_xlat16_3.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vs_COLOR1.zzz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _EnvColor.xyz + u_xlat16_3.xyz;
    u_xlat16_23 = u_xlat10_0.w * _PartialEmission;
    u_xlat16_3.xyz = u_xlat10_0.xyz * vec3(vec3(_PartialEmissionScaler, _PartialEmissionScaler, _PartialEmissionScaler)) + (-u_xlat16_2.xyz);
    u_xlat16_0.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_2.x = _OverheatEmissionScaler + -1.0;
    u_xlat16_2.x = vs_TEXCOORD3.w * u_xlat16_2.x + 1.0;
    u_xlat10_1 = texture(_SPTex, vs_TEXCOORD4.xy);
    u_xlat10_4 = texture(_SPNoiseTex, vs_TEXCOORD4.zw).x;
    u_xlat4.x = u_xlat10_4 * _SPNoiseScaler;
    u_xlat4.x = u_xlat4.x * 1.99000001 + -1.0;
    u_xlat11 = _SPNoiseScaler * _SPTransition;
    u_xlat18.xy = vec2(u_xlat11) * vec2(1.70000005, 1.5) + (-u_xlat4.xx);
    u_xlat18.xy = u_xlat18.xy + vec2(1.0, 1.0);
    u_xlat18.xy = floor(u_xlat18.xy);
    u_xlat18.xy = max(u_xlat18.xy, vec2(0.0, 0.0));
    u_xlati18.xy = ivec2(u_xlat18.xy);
    u_xlat4.x = u_xlat11 * 1.70000005 + (-u_xlat4.x);
    u_xlat4.x = u_xlat4.x * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
    u_xlat5.xyz = u_xlat4.xxx * u_xlat5.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat10_1.xyz;
    u_xlat16_2.xyz = (u_xlati18.y != 0) ? u_xlat16_2.xyz : u_xlat5.xyz;
    u_xlat4.x = (u_xlati18.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_23 = 1.0;
    u_xlat16_23 = (u_xlati18.x != 0) ? u_xlat16_23 : 0.0;
    u_xlat16_2.xyz = (u_xlati18.x != 0) ? u_xlat16_2.xyz : u_xlat10_1.xyz;
    u_xlat16_0.w = 1.0;
    u_xlat3.xyz = (-u_xlat16_0.xyz) + u_xlat16_2.xyz;
    u_xlat3.w = (-u_xlat16_0.w) + u_xlat10_1.w;
    u_xlat0 = u_xlat4.xxxx * u_xlat3 + u_xlat16_0;
    u_xlat16_2.xyz = u_xlat0.xyz * vec3(vec3(_Emission, _Emission, _Emission));
    u_xlat16_6.xyz = (-u_xlat0.xyz) * vec3(vec3(_Emission, _Emission, _Emission)) + vs_TEXCOORD3.xyz;
    u_xlat16_2.xyz = vs_TEXCOORD3.www * u_xlat16_6.xyz + u_xlat16_2.xyz;
    u_xlat16_6.xyz = u_xlat0.xyz * vec3(vec3(_Emission, _Emission, _Emission)) + (-u_xlat16_2.xyz);
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_6.xyz + u_xlat16_2.xyz;
    SV_Target0.w = u_xlat0.w * vs_COLOR1.y;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat1.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD5.xyz;
    u_xlat22 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * vs_TEXCOORD6.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.00100005;
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGShininess;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGScale + _RGBias;
    u_xlat16_23 = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat16_23 * _RGRatio;
    u_xlat1.xzw = u_xlat1.xxx * _RGColor.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xzw + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "RIM_GLOW" "OVERHEAT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec3 _OverheatColor;
uniform 	mediump float _OverheatEmissionScaler;
uniform 	mediump float _OverheatIntensity;
uniform 	mediump float _Opaqueness;
uniform 	mediump float _Shininess;
uniform 	vec4 _ClipPlane;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec3 in_COLOR0;
out mediump vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_4;
mediump float u_xlat16_9;
float u_xlat11;
vec2 u_xlat12;
float u_xlat15;
int u_xlati15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat2.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    vs_TEXCOORD2.xyz = vec3(0.0, 0.0, 0.0);
    vs_TEXCOORD3.xyz = vec3(_OverheatColor.xxyz.y * _OverheatEmissionScaler, _OverheatColor.xxyz.z * _OverheatEmissionScaler, float(_OverheatColor.z) * _OverheatEmissionScaler);
    vs_TEXCOORD3.w = in_COLOR0.x * _OverheatIntensity;
    u_xlat15 = _ClipPlane.w + -0.00999999978;
    u_xlat11 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat15 = (-u_xlat15) + u_xlat11;
    u_xlat11 = u_xlat11 + (-_ClipPlane.w);
    u_xlat2.xyz = (-vec3(u_xlat11)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat15 = u_xlat15 + 1.0;
    u_xlat15 = floor(u_xlat15);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlati15 = int(u_xlat15);
    u_xlat3.xyz = in_POSITION0.xyz;
    u_xlat3.w = 1.0;
    u_xlat2.w = 0.0;
    u_xlat2 = (int(u_xlati15) != 0) ? u_xlat3 : u_xlat2;
    u_xlat3 = u_xlat2.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat15 = u_xlat2.x * u_xlat3.x;
    vs_COLOR1.y = u_xlat2.w * _Opaqueness;
    u_xlat11 = u_xlat3.w + u_xlat3.y;
    u_xlat12.x = u_xlat3.z * u_xlat3.z + u_xlat3.x;
    u_xlat12.y = u_xlat15 * 0.25 + u_xlat11;
    vs_TEXCOORD4.zw = u_xlat12.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat15 * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat3.zz + u_xlat3.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD7.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat1.xyw, vec3(bvec3(u_xlatb15)));
    vs_TEXCOORD7.z = u_xlatb15 ? _DitherAlpha : float(0.0);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_4 = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat16_9 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat16_9 * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat0.x;
    u_xlat16_4 = max(u_xlat16_4, 0.00100000005);
    u_xlat16_4 = log2(u_xlat16_4);
    u_xlat16_4 = u_xlat16_4 * _Shininess;
    vs_COLOR1.z = exp2(u_xlat16_4);
    vs_COLOR1.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _Emission;
uniform 	mediump float _PartialEmission;
uniform 	mediump float _PartialEmissionScaler;
uniform 	mediump float _OverheatEmissionScaler;
uniform 	mediump float _LightArea;
uniform 	mediump vec4 _ShadowMultColor;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
int u_xlati1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat8;
float u_xlat11;
bvec2 u_xlatb14;
vec2 u_xlat18;
ivec2 u_xlati18;
float u_xlat22;
mediump float u_xlat16_23;
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
        u_xlatb0 = !!(vs_TEXCOORD7.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD7.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD7.yx / vs_TEXCOORD7.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb14.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb14.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb14.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD7.z * 17.0 + (-u_xlat0.x);
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
    u_xlat16_2.x = vs_COLOR1.x + (-_LightArea);
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlati1 = int(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat10_0.xyz * _ShadowMultColor.xyz;
    u_xlat16_2.xyz = (int(u_xlati1) != 0) ? u_xlat10_0.xyz : u_xlat16_2.xyz;
    u_xlat16_3.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vs_COLOR1.zzz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _EnvColor.xyz + u_xlat16_3.xyz;
    u_xlat16_23 = u_xlat10_0.w * _PartialEmission;
    u_xlat16_3.xyz = u_xlat10_0.xyz * vec3(vec3(_PartialEmissionScaler, _PartialEmissionScaler, _PartialEmissionScaler)) + (-u_xlat16_2.xyz);
    u_xlat16_0.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_2.x = _OverheatEmissionScaler + -1.0;
    u_xlat16_2.x = vs_TEXCOORD3.w * u_xlat16_2.x + 1.0;
    u_xlat10_1 = texture(_SPTex, vs_TEXCOORD4.xy);
    u_xlat10_4 = texture(_SPNoiseTex, vs_TEXCOORD4.zw).x;
    u_xlat4.x = u_xlat10_4 * _SPNoiseScaler;
    u_xlat4.x = u_xlat4.x * 1.99000001 + -1.0;
    u_xlat11 = _SPNoiseScaler * _SPTransition;
    u_xlat18.xy = vec2(u_xlat11) * vec2(1.70000005, 1.5) + (-u_xlat4.xx);
    u_xlat18.xy = u_xlat18.xy + vec2(1.0, 1.0);
    u_xlat18.xy = floor(u_xlat18.xy);
    u_xlat18.xy = max(u_xlat18.xy, vec2(0.0, 0.0));
    u_xlati18.xy = ivec2(u_xlat18.xy);
    u_xlat4.x = u_xlat11 * 1.70000005 + (-u_xlat4.x);
    u_xlat4.x = u_xlat4.x * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
    u_xlat5.xyz = u_xlat4.xxx * u_xlat5.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat10_1.xyz;
    u_xlat16_2.xyz = (u_xlati18.y != 0) ? u_xlat16_2.xyz : u_xlat5.xyz;
    u_xlat4.x = (u_xlati18.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_23 = 1.0;
    u_xlat16_23 = (u_xlati18.x != 0) ? u_xlat16_23 : 0.0;
    u_xlat16_2.xyz = (u_xlati18.x != 0) ? u_xlat16_2.xyz : u_xlat10_1.xyz;
    u_xlat16_0.w = 1.0;
    u_xlat3.xyz = (-u_xlat16_0.xyz) + u_xlat16_2.xyz;
    u_xlat3.w = (-u_xlat16_0.w) + u_xlat10_1.w;
    u_xlat0 = u_xlat4.xxxx * u_xlat3 + u_xlat16_0;
    u_xlat16_2.xyz = u_xlat0.xyz * vec3(vec3(_Emission, _Emission, _Emission));
    u_xlat16_6.xyz = (-u_xlat0.xyz) * vec3(vec3(_Emission, _Emission, _Emission)) + vs_TEXCOORD3.xyz;
    u_xlat16_2.xyz = vs_TEXCOORD3.www * u_xlat16_6.xyz + u_xlat16_2.xyz;
    u_xlat16_6.xyz = u_xlat0.xyz * vec3(vec3(_Emission, _Emission, _Emission)) + (-u_xlat16_2.xyz);
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_6.xyz + u_xlat16_2.xyz;
    SV_Target0.w = u_xlat0.w * vs_COLOR1.y;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat1.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD5.xyz;
    u_xlat22 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * vs_TEXCOORD6.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.00100005;
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGShininess;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGScale + _RGBias;
    u_xlat16_23 = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat16_23 * _RGRatio;
    u_xlat1.xzw = u_xlat1.xxx * _RGColor.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xzw + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
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
Keywords { "OVERHEAT" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "OVERHEAT" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "OVERHEAT" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "RIM_GLOW" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "RIM_GLOW" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "RIM_GLOW" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "RIM_GLOW" "OVERHEAT" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "RIM_GLOW" "OVERHEAT" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "RIM_GLOW" "OVERHEAT" }
""
}
}
}
 Pass {
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "OutlineType" = "Complex" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Front
  GpuProgramID 82327
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 _SPNoiseTex_ST;
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
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
float u_xlat5;
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
    u_xlat0.w = u_xlat1.x * u_xlat16_3.x;
    u_xlat1.x = _ClipPlane.w + -0.00999999978;
    u_xlat5 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat1.x = (-u_xlat1.x) + u_xlat5;
    u_xlat5 = u_xlat5 + (-_ClipPlane.w);
    u_xlat3.xyz = (-vec3(u_xlat5)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlati1 = int(u_xlat1.x);
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat3.w = 0.0;
    u_xlat0 = (int(u_xlati1) != 0) ? u_xlat0 : u_xlat3;
    vs_COLOR0.w = u_xlat0.w;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    u_xlat1 = u_xlat0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
    u_xlat4.x = u_xlat1.w + u_xlat1.y;
    u_xlat1.x = u_xlat1.z * u_xlat1.z + u_xlat1.x;
    u_xlat1.y = u_xlat0.x * 0.25 + u_xlat4.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
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
uniform 	float _SPNoiseScaler;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPOutlineColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _Opaqueness;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _SPNoiseTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat2;
bvec2 u_xlatb4;
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
    u_xlat10_0 = texture(_SPNoiseTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 * _SPNoiseScaler;
    u_xlat0.x = u_xlat0.x * 1.99000001 + -1.0;
    u_xlat2 = _SPNoiseScaler * _SPTransition;
    u_xlat0.x = u_xlat2 * 1.70000005 + (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat16_0 = (int(u_xlati0) != 0) ? _SPOutlineColor : vs_COLOR0;
    SV_Target0.xyz = u_xlat16_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat16_0.w * _Opaqueness;
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
uniform 	vec4 _SPNoiseTex_ST;
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
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
float u_xlat5;
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
    u_xlat0.w = u_xlat1.x * u_xlat16_3.x;
    u_xlat1.x = _ClipPlane.w + -0.00999999978;
    u_xlat5 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat1.x = (-u_xlat1.x) + u_xlat5;
    u_xlat5 = u_xlat5 + (-_ClipPlane.w);
    u_xlat3.xyz = (-vec3(u_xlat5)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlati1 = int(u_xlat1.x);
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat3.w = 0.0;
    u_xlat0 = (int(u_xlati1) != 0) ? u_xlat0 : u_xlat3;
    vs_COLOR0.w = u_xlat0.w;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    u_xlat1 = u_xlat0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
    u_xlat4.x = u_xlat1.w + u_xlat1.y;
    u_xlat1.x = u_xlat1.z * u_xlat1.z + u_xlat1.x;
    u_xlat1.y = u_xlat0.x * 0.25 + u_xlat4.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
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
uniform 	float _SPNoiseScaler;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPOutlineColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _Opaqueness;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _SPNoiseTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat2;
bvec2 u_xlatb4;
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
    u_xlat10_0 = texture(_SPNoiseTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 * _SPNoiseScaler;
    u_xlat0.x = u_xlat0.x * 1.99000001 + -1.0;
    u_xlat2 = _SPNoiseScaler * _SPTransition;
    u_xlat0.x = u_xlat2 * 1.70000005 + (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat16_0 = (int(u_xlati0) != 0) ? _SPOutlineColor : vs_COLOR0;
    SV_Target0.xyz = u_xlat16_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat16_0.w * _Opaqueness;
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
uniform 	vec4 _SPNoiseTex_ST;
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
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
float u_xlat5;
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
    u_xlat0.w = u_xlat1.x * u_xlat16_3.x;
    u_xlat1.x = _ClipPlane.w + -0.00999999978;
    u_xlat5 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat1.x = (-u_xlat1.x) + u_xlat5;
    u_xlat5 = u_xlat5 + (-_ClipPlane.w);
    u_xlat3.xyz = (-vec3(u_xlat5)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlati1 = int(u_xlat1.x);
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat3.w = 0.0;
    u_xlat0 = (int(u_xlati1) != 0) ? u_xlat0 : u_xlat3;
    vs_COLOR0.w = u_xlat0.w;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    u_xlat1 = u_xlat0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
    u_xlat4.x = u_xlat1.w + u_xlat1.y;
    u_xlat1.x = u_xlat1.z * u_xlat1.z + u_xlat1.x;
    u_xlat1.y = u_xlat0.x * 0.25 + u_xlat4.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
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
uniform 	float _SPNoiseScaler;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPOutlineColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _Opaqueness;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _SPNoiseTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat2;
bvec2 u_xlatb4;
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
    u_xlat10_0 = texture(_SPNoiseTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 * _SPNoiseScaler;
    u_xlat0.x = u_xlat0.x * 1.99000001 + -1.0;
    u_xlat2 = _SPNoiseScaler * _SPTransition;
    u_xlat0.x = u_xlat2 * 1.70000005 + (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat16_0 = (int(u_xlati0) != 0) ? _SPOutlineColor : vs_COLOR0;
    SV_Target0.xyz = u_xlat16_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat16_0.w * _Opaqueness;
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
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "OutlineType" = "Complex" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 149407
Program "vp" {
SubProgram "gles3 hw_tier00 " {
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
    u_xlat16_2 = (-_BloomFactor) + _EmissionBloomFactor;
    u_xlat16_2 = u_xlat10_6 * u_xlat16_2 + _BloomFactor;
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
    u_xlat16_2 = (-_BloomFactor) + _EmissionBloomFactor;
    u_xlat16_2 = u_xlat10_6 * u_xlat16_2 + _BloomFactor;
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
    u_xlat16_2 = (-_BloomFactor) + _EmissionBloomFactor;
    u_xlat16_2 = u_xlat10_6 * u_xlat16_2 + _BloomFactor;
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
}
}
}
CustomEditor "MoleMole.CharacterMachineShaderEditor"
}