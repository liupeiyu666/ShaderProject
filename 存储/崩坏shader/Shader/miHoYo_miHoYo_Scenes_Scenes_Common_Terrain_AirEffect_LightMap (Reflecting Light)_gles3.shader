//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Common/Terrain_AirEffect_LightMap (Reflecting Light)" {
Properties {
_LightMapIntensity ("Light Map Intensity", Float) = 1
_BloomFactor ("Bloom Factor", Float) = 1
_Splat0Tex ("Splat0 Tex (RGB)", 2D) = "black" { }
_Splat1Tex ("Splat1 Tex (RGB)", 2D) = "black" { }
_Splat2Tex ("Splat2 Tex (RGB)", 2D) = "black" { }
_Splat3Tex ("Splat2 Tex (RGB)", 2D) = "black" { }
_ControlTex ("Control Tex (RGB)", 2D) = "white" { }
_ShadowTex ("LightMap (RGB)", 2D) = "grey" { }
_FogTune ("Fog Tune", Range(0, 1)) = 1
_Culling ("Culling (0: Off, 1: Front, 2: Back)", Float) = 2
[Toggle(USINGRIMGLOW)] _UsingRimGlow ("Using Rim Glow", Float) = 0
_RGColor ("Rim Glow Color", Color) = (1,1,1,1)
_RGShininess ("Rim Glow Shininess", Float) = 1
_RGScale ("Rim Glow Scale", Float) = 1
_RGBias ("Rim Glow Bias", Float) = 0
_RGRatio ("Rim Glow Ratio", Range(0, 1)) = 0.5
_RGBloomFactor ("Rim Glow Bloom Factor", Float) = 1
_RGControlTexRRatio ("Rim Glow R Channel Ratio Of Control Tex", Range(0, 1)) = 1
_RGControlTexGRatio ("Rim Glow G Channel Ratio Of Control Tex", Range(0, 1)) = 1
_RGControlTexBRatio ("Rim Glow B Channel Ratio Of Control Tex", Range(0, 1)) = 1
_RGControlTexARatio ("Rim Glow A Channel Ratio Of Control Tex", Range(0, 1)) = 1
_ReflectionTex ("Reflection", 2D) = "black" { }
_ReflectMaskTex ("Reflect Mask Tex(R)", 2D) = "white" { }
_ReflectionEmissionAdjust ("Reflection Emission Adjust", Float) = 1
_FresnelParams ("Fresnel Parameters", Vector) = (1,1,0,0)
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "BASE"
  LOD 200
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 5594
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
uniform 	mediump vec4 _ControlTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _ControlTex_ST.xy + _ControlTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    vs_TEXCOORD3.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat12 = u_xlat2.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat2.x);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat2.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat6);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD5.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xy = u_xlat2.zz + u_xlat2.xw;
    gl_Position = u_xlat1;
    u_xlat2.zw = u_xlat1.zw;
    vs_TEXCOORD7 = u_xlat2;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingRimGlow;
uniform 	float _RGControlTexRRatio;
uniform 	float _RGControlTexGRatio;
uniform 	float _RGControlTexBRatio;
uniform 	float _RGControlTexARatio;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _ControlTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
float u_xlat18;
bool u_xlatb19;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_2.xyz = u_xlat0.xxx * _RGColor.xyz;
    u_xlat16_20 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_20 = min(max(u_xlat16_20, 0.0), 1.0);
#else
    u_xlat16_20 = clamp(u_xlat16_20, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_20 * _RGRatio;
    u_xlat16_2.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat6.xyz = texture(_Splat0Tex, vs_TEXCOORD2.xy).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexRRatio, _RGControlTexRRatio, _RGControlTexRRatio)) + u_xlat6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow));
#else
    u_xlatb19 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow);
#endif
    u_xlat16_3.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat6.xyz = texture(_Splat1Tex, vs_TEXCOORD2.zw).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexGRatio, _RGControlTexGRatio, _RGControlTexGRatio)) + u_xlat6.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat10_5 = texture(_ControlTex, vs_TEXCOORD0.xy);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_5.yyy;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_5.xxx + u_xlat16_4.xyz;
    u_xlat6.xyz = texture(_Splat2Tex, vs_TEXCOORD3.xy).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexBRatio, _RGControlTexBRatio, _RGControlTexBRatio)) + u_xlat6.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat10_5.zzz + u_xlat16_3.xyz;
    u_xlat6.xyz = texture(_Splat3Tex, vs_TEXCOORD3.zw).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_RGControlTexARatio) + u_xlat6.xyz;
    u_xlat16_2.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat16_20 = (u_xlatb19) ? u_xlat0.x : 0.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_5.www + u_xlat16_3.xyz;
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_0.www) + u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat0.xyz;
    u_xlat0.x = (-_BloomFactor) + _RGBloomFactor;
    u_xlat0.x = u_xlat16_20 * u_xlat0.x + _BloomFactor;
    SV_Target0.w = u_xlat0.x;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
uniform 	mediump vec4 _ControlTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _ControlTex_ST.xy + _ControlTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    vs_TEXCOORD3.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat12 = u_xlat2.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat2.x);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat2.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat6);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD5.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xy = u_xlat2.zz + u_xlat2.xw;
    gl_Position = u_xlat1;
    u_xlat2.zw = u_xlat1.zw;
    vs_TEXCOORD7 = u_xlat2;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingRimGlow;
uniform 	float _RGControlTexRRatio;
uniform 	float _RGControlTexGRatio;
uniform 	float _RGControlTexBRatio;
uniform 	float _RGControlTexARatio;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _ControlTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
float u_xlat18;
bool u_xlatb19;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_2.xyz = u_xlat0.xxx * _RGColor.xyz;
    u_xlat16_20 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_20 = min(max(u_xlat16_20, 0.0), 1.0);
#else
    u_xlat16_20 = clamp(u_xlat16_20, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_20 * _RGRatio;
    u_xlat16_2.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat6.xyz = texture(_Splat0Tex, vs_TEXCOORD2.xy).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexRRatio, _RGControlTexRRatio, _RGControlTexRRatio)) + u_xlat6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow));
#else
    u_xlatb19 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow);
#endif
    u_xlat16_3.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat6.xyz = texture(_Splat1Tex, vs_TEXCOORD2.zw).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexGRatio, _RGControlTexGRatio, _RGControlTexGRatio)) + u_xlat6.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat10_5 = texture(_ControlTex, vs_TEXCOORD0.xy);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_5.yyy;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_5.xxx + u_xlat16_4.xyz;
    u_xlat6.xyz = texture(_Splat2Tex, vs_TEXCOORD3.xy).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexBRatio, _RGControlTexBRatio, _RGControlTexBRatio)) + u_xlat6.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat10_5.zzz + u_xlat16_3.xyz;
    u_xlat6.xyz = texture(_Splat3Tex, vs_TEXCOORD3.zw).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_RGControlTexARatio) + u_xlat6.xyz;
    u_xlat16_2.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat16_20 = (u_xlatb19) ? u_xlat0.x : 0.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_5.www + u_xlat16_3.xyz;
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_0.www) + u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat0.xyz;
    u_xlat0.x = (-_BloomFactor) + _RGBloomFactor;
    u_xlat0.x = u_xlat16_20 * u_xlat0.x + _BloomFactor;
    SV_Target0.w = u_xlat0.x;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
uniform 	mediump vec4 _ControlTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _ControlTex_ST.xy + _ControlTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    vs_TEXCOORD3.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat12 = u_xlat2.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat2.x);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat2.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat6);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD5.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xy = u_xlat2.zz + u_xlat2.xw;
    gl_Position = u_xlat1;
    u_xlat2.zw = u_xlat1.zw;
    vs_TEXCOORD7 = u_xlat2;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingRimGlow;
uniform 	float _RGControlTexRRatio;
uniform 	float _RGControlTexGRatio;
uniform 	float _RGControlTexBRatio;
uniform 	float _RGControlTexARatio;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _ControlTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
float u_xlat18;
bool u_xlatb19;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_2.xyz = u_xlat0.xxx * _RGColor.xyz;
    u_xlat16_20 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_20 = min(max(u_xlat16_20, 0.0), 1.0);
#else
    u_xlat16_20 = clamp(u_xlat16_20, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_20 * _RGRatio;
    u_xlat16_2.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat6.xyz = texture(_Splat0Tex, vs_TEXCOORD2.xy).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexRRatio, _RGControlTexRRatio, _RGControlTexRRatio)) + u_xlat6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow));
#else
    u_xlatb19 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow);
#endif
    u_xlat16_3.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat6.xyz = texture(_Splat1Tex, vs_TEXCOORD2.zw).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexGRatio, _RGControlTexGRatio, _RGControlTexGRatio)) + u_xlat6.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat10_5 = texture(_ControlTex, vs_TEXCOORD0.xy);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_5.yyy;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_5.xxx + u_xlat16_4.xyz;
    u_xlat6.xyz = texture(_Splat2Tex, vs_TEXCOORD3.xy).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexBRatio, _RGControlTexBRatio, _RGControlTexBRatio)) + u_xlat6.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat10_5.zzz + u_xlat16_3.xyz;
    u_xlat6.xyz = texture(_Splat3Tex, vs_TEXCOORD3.zw).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_RGControlTexARatio) + u_xlat6.xyz;
    u_xlat16_2.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat16_20 = (u_xlatb19) ? u_xlat0.x : 0.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_5.www + u_xlat16_3.xyz;
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_0.www) + u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat0.xyz;
    u_xlat0.x = (-_BloomFactor) + _RGBloomFactor;
    u_xlat0.x = u_xlat16_20 * u_xlat0.x + _BloomFactor;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
uniform 	mediump vec4 _ControlTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _ControlTex_ST.xy + _ControlTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    vs_TEXCOORD3.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat12 = u_xlat2.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat2.x);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat2.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat6);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD5.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xy = u_xlat2.zz + u_xlat2.xw;
    gl_Position = u_xlat1;
    u_xlat2.zw = u_xlat1.zw;
    vs_TEXCOORD7 = u_xlat2;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingRimGlow;
uniform 	float _RGControlTexRRatio;
uniform 	float _RGControlTexGRatio;
uniform 	float _RGControlTexBRatio;
uniform 	float _RGControlTexARatio;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _ControlTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
float u_xlat18;
bool u_xlatb19;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_2.xyz = u_xlat0.xxx * _RGColor.xyz;
    u_xlat16_20 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_20 = min(max(u_xlat16_20, 0.0), 1.0);
#else
    u_xlat16_20 = clamp(u_xlat16_20, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_20 * _RGRatio;
    u_xlat16_2.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat6.xyz = texture(_Splat0Tex, vs_TEXCOORD2.xy).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexRRatio, _RGControlTexRRatio, _RGControlTexRRatio)) + u_xlat6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow));
#else
    u_xlatb19 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow);
#endif
    u_xlat16_3.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat6.xyz = texture(_Splat1Tex, vs_TEXCOORD2.zw).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexGRatio, _RGControlTexGRatio, _RGControlTexGRatio)) + u_xlat6.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat10_5 = texture(_ControlTex, vs_TEXCOORD0.xy);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_5.yyy;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_5.xxx + u_xlat16_4.xyz;
    u_xlat6.xyz = texture(_Splat2Tex, vs_TEXCOORD3.xy).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexBRatio, _RGControlTexBRatio, _RGControlTexBRatio)) + u_xlat6.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat10_5.zzz + u_xlat16_3.xyz;
    u_xlat6.xyz = texture(_Splat3Tex, vs_TEXCOORD3.zw).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_RGControlTexARatio) + u_xlat6.xyz;
    u_xlat16_2.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat16_20 = (u_xlatb19) ? u_xlat0.x : 0.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_5.www + u_xlat16_3.xyz;
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_0.www) + u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat0.xyz;
    u_xlat0.x = (-_BloomFactor) + _RGBloomFactor;
    u_xlat0.x = u_xlat16_20 * u_xlat0.x + _BloomFactor;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
uniform 	mediump vec4 _ControlTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _ControlTex_ST.xy + _ControlTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    vs_TEXCOORD3.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat12 = u_xlat2.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat2.x);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat2.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat6);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD5.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xy = u_xlat2.zz + u_xlat2.xw;
    gl_Position = u_xlat1;
    u_xlat2.zw = u_xlat1.zw;
    vs_TEXCOORD7 = u_xlat2;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingRimGlow;
uniform 	float _RGControlTexRRatio;
uniform 	float _RGControlTexGRatio;
uniform 	float _RGControlTexBRatio;
uniform 	float _RGControlTexARatio;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _ControlTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
float u_xlat18;
bool u_xlatb19;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_2.xyz = u_xlat0.xxx * _RGColor.xyz;
    u_xlat16_20 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_20 = min(max(u_xlat16_20, 0.0), 1.0);
#else
    u_xlat16_20 = clamp(u_xlat16_20, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_20 * _RGRatio;
    u_xlat16_2.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat6.xyz = texture(_Splat0Tex, vs_TEXCOORD2.xy).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexRRatio, _RGControlTexRRatio, _RGControlTexRRatio)) + u_xlat6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow));
#else
    u_xlatb19 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow);
#endif
    u_xlat16_3.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat6.xyz = texture(_Splat1Tex, vs_TEXCOORD2.zw).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexGRatio, _RGControlTexGRatio, _RGControlTexGRatio)) + u_xlat6.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat10_5 = texture(_ControlTex, vs_TEXCOORD0.xy);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_5.yyy;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_5.xxx + u_xlat16_4.xyz;
    u_xlat6.xyz = texture(_Splat2Tex, vs_TEXCOORD3.xy).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexBRatio, _RGControlTexBRatio, _RGControlTexBRatio)) + u_xlat6.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat10_5.zzz + u_xlat16_3.xyz;
    u_xlat6.xyz = texture(_Splat3Tex, vs_TEXCOORD3.zw).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_RGControlTexARatio) + u_xlat6.xyz;
    u_xlat16_2.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat16_20 = (u_xlatb19) ? u_xlat0.x : 0.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_5.www + u_xlat16_3.xyz;
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_0.www) + u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat0.xyz;
    u_xlat0.x = (-_BloomFactor) + _RGBloomFactor;
    u_xlat0.x = u_xlat16_20 * u_xlat0.x + _BloomFactor;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
uniform 	mediump vec4 _ControlTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _ControlTex_ST.xy + _ControlTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    vs_TEXCOORD3.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat12 = u_xlat2.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat2.x);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat2.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat6);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD5.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xy = u_xlat2.zz + u_xlat2.xw;
    gl_Position = u_xlat1;
    u_xlat2.zw = u_xlat1.zw;
    vs_TEXCOORD7 = u_xlat2;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingRimGlow;
uniform 	float _RGControlTexRRatio;
uniform 	float _RGControlTexGRatio;
uniform 	float _RGControlTexBRatio;
uniform 	float _RGControlTexARatio;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _ControlTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
float u_xlat18;
bool u_xlatb19;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_2.xyz = u_xlat0.xxx * _RGColor.xyz;
    u_xlat16_20 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_20 = min(max(u_xlat16_20, 0.0), 1.0);
#else
    u_xlat16_20 = clamp(u_xlat16_20, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_20 * _RGRatio;
    u_xlat16_2.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat6.xyz = texture(_Splat0Tex, vs_TEXCOORD2.xy).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexRRatio, _RGControlTexRRatio, _RGControlTexRRatio)) + u_xlat6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow));
#else
    u_xlatb19 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow);
#endif
    u_xlat16_3.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat6.xyz = texture(_Splat1Tex, vs_TEXCOORD2.zw).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexGRatio, _RGControlTexGRatio, _RGControlTexGRatio)) + u_xlat6.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat10_5 = texture(_ControlTex, vs_TEXCOORD0.xy);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_5.yyy;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_5.xxx + u_xlat16_4.xyz;
    u_xlat6.xyz = texture(_Splat2Tex, vs_TEXCOORD3.xy).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexBRatio, _RGControlTexBRatio, _RGControlTexBRatio)) + u_xlat6.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat10_5.zzz + u_xlat16_3.xyz;
    u_xlat6.xyz = texture(_Splat3Tex, vs_TEXCOORD3.zw).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_RGControlTexARatio) + u_xlat6.xyz;
    u_xlat16_2.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat16_20 = (u_xlatb19) ? u_xlat0.x : 0.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_5.www + u_xlat16_3.xyz;
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_0.www) + u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat0.xyz;
    u_xlat0.x = (-_BloomFactor) + _RGBloomFactor;
    u_xlat0.x = u_xlat16_20 * u_xlat0.x + _BloomFactor;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
uniform 	mediump vec4 _ControlTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
mediump float u_xlat16_9;
float u_xlat10;
float u_xlat16;
float u_xlat18;
float u_xlat20;
bool u_xlatb20;
float u_xlat22;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _ControlTex_ST.xy + _ControlTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    vs_TEXCOORD3.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat18) + 2.0;
    u_xlat16_3 = u_xlat18 * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat20 = u_xlat5.y * _HeigtFogParams.x;
    u_xlat18 = sqrt(u_xlat18);
    u_xlat22 = u_xlat18 + (-_HeigtFogRamp.w);
    u_xlat22 = u_xlat22 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat4.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat18>=u_xlat4.x);
#else
    u_xlatb4 = u_xlat18>=u_xlat4.x;
#endif
    u_xlat10 = u_xlat18 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat10) + 2.0;
    u_xlat10 = u_xlat16 * u_xlat10;
    u_xlat16 = u_xlat10 * _HeigtFogColDelta.w;
    u_xlat4.x = (u_xlatb4) ? u_xlat16 : u_xlat10;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _Mihoyo_FogColor.w;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, _HeigtFogColBase.w);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat10 = u_xlat20 * -1.44269502;
    u_xlat4.y = exp2(u_xlat10);
    u_xlat4.xy = (-u_xlat4.xy) + vec2(1.0, 1.0);
    u_xlat10 = u_xlat4.y / u_xlat20;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(0.00999999978<abs(u_xlat20));
#else
    u_xlatb20 = 0.00999999978<abs(u_xlat20);
#endif
    u_xlat16_3 = (u_xlatb20) ? u_xlat10 : 1.0;
    u_xlat20 = u_xlat18 * _HeigtFogParams.y;
    u_xlat18 = u_xlat18 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat20 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_9 = (-u_xlat18) + 2.0;
    u_xlat16_9 = u_xlat18 * u_xlat16_9;
    u_xlat18 = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat18 = u_xlat18 + 1.0;
    u_xlat16_3 = u_xlat18 * u_xlat16_3;
    u_xlat18 = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat20 = (-u_xlat18) + 1.0;
    u_xlat2.xyz = vec3(u_xlat20) * u_xlat2.xyz;
    u_xlat3.w = u_xlat20 * u_xlat4.x;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat18) + u_xlat2.xyz;
    vs_COLOR1 = u_xlat3;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    vs_TEXCOORD4.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD5.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD7 = u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingRimGlow;
uniform 	float _RGControlTexRRatio;
uniform 	float _RGControlTexGRatio;
uniform 	float _RGControlTexBRatio;
uniform 	float _RGControlTexARatio;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _ControlTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
float u_xlat18;
bool u_xlatb19;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_2.xyz = u_xlat0.xxx * _RGColor.xyz;
    u_xlat16_20 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_20 = min(max(u_xlat16_20, 0.0), 1.0);
#else
    u_xlat16_20 = clamp(u_xlat16_20, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_20 * _RGRatio;
    u_xlat16_2.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat6.xyz = texture(_Splat0Tex, vs_TEXCOORD2.xy).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexRRatio, _RGControlTexRRatio, _RGControlTexRRatio)) + u_xlat6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow));
#else
    u_xlatb19 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow);
#endif
    u_xlat16_3.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat6.xyz = texture(_Splat1Tex, vs_TEXCOORD2.zw).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexGRatio, _RGControlTexGRatio, _RGControlTexGRatio)) + u_xlat6.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat10_5 = texture(_ControlTex, vs_TEXCOORD0.xy);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_5.yyy;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_5.xxx + u_xlat16_4.xyz;
    u_xlat6.xyz = texture(_Splat2Tex, vs_TEXCOORD3.xy).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexBRatio, _RGControlTexBRatio, _RGControlTexBRatio)) + u_xlat6.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat10_5.zzz + u_xlat16_3.xyz;
    u_xlat6.xyz = texture(_Splat3Tex, vs_TEXCOORD3.zw).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_RGControlTexARatio) + u_xlat6.xyz;
    u_xlat16_2.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat16_20 = (u_xlatb19) ? u_xlat0.x : 0.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_5.www + u_xlat16_3.xyz;
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_0.www) + u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    u_xlat0.x = (-_BloomFactor) + _RGBloomFactor;
    u_xlat0.x = u_xlat16_20 * u_xlat0.x + _BloomFactor;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
uniform 	mediump vec4 _ControlTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
mediump float u_xlat16_9;
float u_xlat10;
float u_xlat16;
float u_xlat18;
float u_xlat20;
bool u_xlatb20;
float u_xlat22;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _ControlTex_ST.xy + _ControlTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    vs_TEXCOORD3.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat18) + 2.0;
    u_xlat16_3 = u_xlat18 * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat20 = u_xlat5.y * _HeigtFogParams.x;
    u_xlat18 = sqrt(u_xlat18);
    u_xlat22 = u_xlat18 + (-_HeigtFogRamp.w);
    u_xlat22 = u_xlat22 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat4.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat18>=u_xlat4.x);
#else
    u_xlatb4 = u_xlat18>=u_xlat4.x;
#endif
    u_xlat10 = u_xlat18 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat10) + 2.0;
    u_xlat10 = u_xlat16 * u_xlat10;
    u_xlat16 = u_xlat10 * _HeigtFogColDelta.w;
    u_xlat4.x = (u_xlatb4) ? u_xlat16 : u_xlat10;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _Mihoyo_FogColor.w;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, _HeigtFogColBase.w);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat10 = u_xlat20 * -1.44269502;
    u_xlat4.y = exp2(u_xlat10);
    u_xlat4.xy = (-u_xlat4.xy) + vec2(1.0, 1.0);
    u_xlat10 = u_xlat4.y / u_xlat20;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(0.00999999978<abs(u_xlat20));
#else
    u_xlatb20 = 0.00999999978<abs(u_xlat20);
#endif
    u_xlat16_3 = (u_xlatb20) ? u_xlat10 : 1.0;
    u_xlat20 = u_xlat18 * _HeigtFogParams.y;
    u_xlat18 = u_xlat18 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat20 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_9 = (-u_xlat18) + 2.0;
    u_xlat16_9 = u_xlat18 * u_xlat16_9;
    u_xlat18 = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat18 = u_xlat18 + 1.0;
    u_xlat16_3 = u_xlat18 * u_xlat16_3;
    u_xlat18 = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat20 = (-u_xlat18) + 1.0;
    u_xlat2.xyz = vec3(u_xlat20) * u_xlat2.xyz;
    u_xlat3.w = u_xlat20 * u_xlat4.x;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat18) + u_xlat2.xyz;
    vs_COLOR1 = u_xlat3;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    vs_TEXCOORD4.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD5.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD7 = u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingRimGlow;
uniform 	float _RGControlTexRRatio;
uniform 	float _RGControlTexGRatio;
uniform 	float _RGControlTexBRatio;
uniform 	float _RGControlTexARatio;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _ControlTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
float u_xlat18;
bool u_xlatb19;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_2.xyz = u_xlat0.xxx * _RGColor.xyz;
    u_xlat16_20 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_20 = min(max(u_xlat16_20, 0.0), 1.0);
#else
    u_xlat16_20 = clamp(u_xlat16_20, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_20 * _RGRatio;
    u_xlat16_2.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat6.xyz = texture(_Splat0Tex, vs_TEXCOORD2.xy).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexRRatio, _RGControlTexRRatio, _RGControlTexRRatio)) + u_xlat6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow));
#else
    u_xlatb19 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow);
#endif
    u_xlat16_3.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat6.xyz = texture(_Splat1Tex, vs_TEXCOORD2.zw).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexGRatio, _RGControlTexGRatio, _RGControlTexGRatio)) + u_xlat6.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat10_5 = texture(_ControlTex, vs_TEXCOORD0.xy);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_5.yyy;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_5.xxx + u_xlat16_4.xyz;
    u_xlat6.xyz = texture(_Splat2Tex, vs_TEXCOORD3.xy).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexBRatio, _RGControlTexBRatio, _RGControlTexBRatio)) + u_xlat6.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat10_5.zzz + u_xlat16_3.xyz;
    u_xlat6.xyz = texture(_Splat3Tex, vs_TEXCOORD3.zw).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_RGControlTexARatio) + u_xlat6.xyz;
    u_xlat16_2.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat16_20 = (u_xlatb19) ? u_xlat0.x : 0.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_5.www + u_xlat16_3.xyz;
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_0.www) + u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    u_xlat0.x = (-_BloomFactor) + _RGBloomFactor;
    u_xlat0.x = u_xlat16_20 * u_xlat0.x + _BloomFactor;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
uniform 	mediump vec4 _ControlTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
mediump float u_xlat16_9;
float u_xlat10;
float u_xlat16;
float u_xlat18;
float u_xlat20;
bool u_xlatb20;
float u_xlat22;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _ControlTex_ST.xy + _ControlTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    vs_TEXCOORD3.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat18) + 2.0;
    u_xlat16_3 = u_xlat18 * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat20 = u_xlat5.y * _HeigtFogParams.x;
    u_xlat18 = sqrt(u_xlat18);
    u_xlat22 = u_xlat18 + (-_HeigtFogRamp.w);
    u_xlat22 = u_xlat22 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat4.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat18>=u_xlat4.x);
#else
    u_xlatb4 = u_xlat18>=u_xlat4.x;
#endif
    u_xlat10 = u_xlat18 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat10) + 2.0;
    u_xlat10 = u_xlat16 * u_xlat10;
    u_xlat16 = u_xlat10 * _HeigtFogColDelta.w;
    u_xlat4.x = (u_xlatb4) ? u_xlat16 : u_xlat10;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _Mihoyo_FogColor.w;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, _HeigtFogColBase.w);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat10 = u_xlat20 * -1.44269502;
    u_xlat4.y = exp2(u_xlat10);
    u_xlat4.xy = (-u_xlat4.xy) + vec2(1.0, 1.0);
    u_xlat10 = u_xlat4.y / u_xlat20;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(0.00999999978<abs(u_xlat20));
#else
    u_xlatb20 = 0.00999999978<abs(u_xlat20);
#endif
    u_xlat16_3 = (u_xlatb20) ? u_xlat10 : 1.0;
    u_xlat20 = u_xlat18 * _HeigtFogParams.y;
    u_xlat18 = u_xlat18 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat20 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_9 = (-u_xlat18) + 2.0;
    u_xlat16_9 = u_xlat18 * u_xlat16_9;
    u_xlat18 = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat18 = u_xlat18 + 1.0;
    u_xlat16_3 = u_xlat18 * u_xlat16_3;
    u_xlat18 = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat20 = (-u_xlat18) + 1.0;
    u_xlat2.xyz = vec3(u_xlat20) * u_xlat2.xyz;
    u_xlat3.w = u_xlat20 * u_xlat4.x;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat18) + u_xlat2.xyz;
    vs_COLOR1 = u_xlat3;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    vs_TEXCOORD4.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD5.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD7 = u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingRimGlow;
uniform 	float _RGControlTexRRatio;
uniform 	float _RGControlTexGRatio;
uniform 	float _RGControlTexBRatio;
uniform 	float _RGControlTexARatio;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _ControlTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
float u_xlat18;
bool u_xlatb19;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_2.xyz = u_xlat0.xxx * _RGColor.xyz;
    u_xlat16_20 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_20 = min(max(u_xlat16_20, 0.0), 1.0);
#else
    u_xlat16_20 = clamp(u_xlat16_20, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_20 * _RGRatio;
    u_xlat16_2.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat6.xyz = texture(_Splat0Tex, vs_TEXCOORD2.xy).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexRRatio, _RGControlTexRRatio, _RGControlTexRRatio)) + u_xlat6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow));
#else
    u_xlatb19 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow);
#endif
    u_xlat16_3.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat6.xyz = texture(_Splat1Tex, vs_TEXCOORD2.zw).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexGRatio, _RGControlTexGRatio, _RGControlTexGRatio)) + u_xlat6.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat10_5 = texture(_ControlTex, vs_TEXCOORD0.xy);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_5.yyy;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_5.xxx + u_xlat16_4.xyz;
    u_xlat6.xyz = texture(_Splat2Tex, vs_TEXCOORD3.xy).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexBRatio, _RGControlTexBRatio, _RGControlTexBRatio)) + u_xlat6.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat10_5.zzz + u_xlat16_3.xyz;
    u_xlat6.xyz = texture(_Splat3Tex, vs_TEXCOORD3.zw).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_RGControlTexARatio) + u_xlat6.xyz;
    u_xlat16_2.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat16_20 = (u_xlatb19) ? u_xlat0.x : 0.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_5.www + u_xlat16_3.xyz;
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_0.www) + u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    u_xlat0.x = (-_BloomFactor) + _RGBloomFactor;
    u_xlat0.x = u_xlat16_20 * u_xlat0.x + _BloomFactor;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
uniform 	mediump vec4 _ControlTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
mediump float u_xlat16_6;
mediump float u_xlat16_10;
float u_xlat11;
bool u_xlatb11;
mediump float u_xlat16_13;
float u_xlat18;
float u_xlat21;
float u_xlat23;
float u_xlat25;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _ControlTex_ST.xy + _ControlTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    vs_TEXCOORD3.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat21) + 2.0;
    u_xlat16_3 = u_xlat21 * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat5.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat23 = u_xlat21 + (-_HeigtFogRamp3.w);
    u_xlat23 = u_xlat23 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat23 = u_xlat21 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat4.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat4.x;
    u_xlat4.x = u_xlat23 * _HeigtFogColDelta3.w;
    u_xlat11 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(u_xlat21>=u_xlat11);
#else
    u_xlatb11 = u_xlat21>=u_xlat11;
#endif
    u_xlat23 = (u_xlatb11) ? u_xlat4.x : u_xlat23;
    u_xlat23 = log2(u_xlat23);
    u_xlat23 = u_xlat23 * _Mihoyo_FogColor3.w;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = min(u_xlat23, _HeigtFogColBase3.w);
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat2.xyz;
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat4.x = u_xlat5.y * _HeigtFogParams3.x;
    u_xlat18 = u_xlat5.y * _HeigtFogParams2.x;
    u_xlat25 = u_xlat4.x * -1.44269502;
    u_xlat25 = exp2(u_xlat25);
    u_xlat25 = (-u_xlat25) + 1.0;
    u_xlat25 = u_xlat25 / u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4.x));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4.x);
#endif
    u_xlat16_3 = (u_xlatb4) ? u_xlat25 : 1.0;
    u_xlat4.x = u_xlat21 * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16_3 * u_xlat4.x;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat4.x = u_xlat21 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat4.x) + 2.0;
    u_xlat16_10 = u_xlat16_10 * u_xlat4.x;
    u_xlat4.x = u_xlat16_10 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat4.x = u_xlat4.x + 1.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat4.x;
    u_xlat4.x = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat25 = (-u_xlat4.x) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat25);
    u_xlat3.w = u_xlat23 * u_xlat25;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * u_xlat4.xxx + u_xlat2.xyz;
    u_xlat2.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat2.x) + 2.0;
    u_xlat16_6 = u_xlat2.x * u_xlat16_6;
    u_xlat2.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat5.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat23 = u_xlat21 + (-_HeigtFogRamp2.w);
    u_xlat23 = u_xlat23 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat23 = u_xlat21 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat4.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat4.x;
    u_xlat4.x = u_xlat23 * _HeigtFogColDelta2.w;
    u_xlat23 = (u_xlatb11) ? u_xlat4.x : u_xlat23;
    u_xlat23 = log2(u_xlat23);
    u_xlat23 = u_xlat23 * _Mihoyo_FogColor2.w;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = min(u_xlat23, _HeigtFogColBase2.w);
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat2.xyz;
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat4.x = u_xlat18 * -1.44269502;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x / u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat18));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat18);
#endif
    u_xlat16_6 = (u_xlatb11) ? u_xlat4.x : 1.0;
    u_xlat4.x = u_xlat21 * _HeigtFogParams2.y;
    u_xlat21 = u_xlat21 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat4.x * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat21) + 2.0;
    u_xlat16_13 = u_xlat21 * u_xlat16_13;
    u_xlat21 = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_6 = u_xlat21 * u_xlat16_6;
    u_xlat21 = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat4.x = (-u_xlat21) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat4.w = u_xlat23 * u_xlat4.x;
    u_xlat4.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat21) + u_xlat2.xyz;
    u_xlat2 = u_xlat3 + (-u_xlat4);
    u_xlat2 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat2 + u_xlat4;
    vs_COLOR1 = u_xlat2;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    vs_TEXCOORD4.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD5.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD7 = u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingRimGlow;
uniform 	float _RGControlTexRRatio;
uniform 	float _RGControlTexGRatio;
uniform 	float _RGControlTexBRatio;
uniform 	float _RGControlTexARatio;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _ControlTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
float u_xlat18;
bool u_xlatb19;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_2.xyz = u_xlat0.xxx * _RGColor.xyz;
    u_xlat16_20 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_20 = min(max(u_xlat16_20, 0.0), 1.0);
#else
    u_xlat16_20 = clamp(u_xlat16_20, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_20 * _RGRatio;
    u_xlat16_2.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat6.xyz = texture(_Splat0Tex, vs_TEXCOORD2.xy).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexRRatio, _RGControlTexRRatio, _RGControlTexRRatio)) + u_xlat6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow));
#else
    u_xlatb19 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow);
#endif
    u_xlat16_3.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat6.xyz = texture(_Splat1Tex, vs_TEXCOORD2.zw).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexGRatio, _RGControlTexGRatio, _RGControlTexGRatio)) + u_xlat6.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat10_5 = texture(_ControlTex, vs_TEXCOORD0.xy);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_5.yyy;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_5.xxx + u_xlat16_4.xyz;
    u_xlat6.xyz = texture(_Splat2Tex, vs_TEXCOORD3.xy).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexBRatio, _RGControlTexBRatio, _RGControlTexBRatio)) + u_xlat6.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat10_5.zzz + u_xlat16_3.xyz;
    u_xlat6.xyz = texture(_Splat3Tex, vs_TEXCOORD3.zw).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_RGControlTexARatio) + u_xlat6.xyz;
    u_xlat16_2.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat16_20 = (u_xlatb19) ? u_xlat0.x : 0.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_5.www + u_xlat16_3.xyz;
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_0.www) + u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    u_xlat0.x = (-_BloomFactor) + _RGBloomFactor;
    u_xlat0.x = u_xlat16_20 * u_xlat0.x + _BloomFactor;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
uniform 	mediump vec4 _ControlTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
mediump float u_xlat16_6;
mediump float u_xlat16_10;
float u_xlat11;
bool u_xlatb11;
mediump float u_xlat16_13;
float u_xlat18;
float u_xlat21;
float u_xlat23;
float u_xlat25;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _ControlTex_ST.xy + _ControlTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    vs_TEXCOORD3.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat21) + 2.0;
    u_xlat16_3 = u_xlat21 * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat5.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat23 = u_xlat21 + (-_HeigtFogRamp3.w);
    u_xlat23 = u_xlat23 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat23 = u_xlat21 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat4.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat4.x;
    u_xlat4.x = u_xlat23 * _HeigtFogColDelta3.w;
    u_xlat11 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(u_xlat21>=u_xlat11);
#else
    u_xlatb11 = u_xlat21>=u_xlat11;
#endif
    u_xlat23 = (u_xlatb11) ? u_xlat4.x : u_xlat23;
    u_xlat23 = log2(u_xlat23);
    u_xlat23 = u_xlat23 * _Mihoyo_FogColor3.w;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = min(u_xlat23, _HeigtFogColBase3.w);
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat2.xyz;
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat4.x = u_xlat5.y * _HeigtFogParams3.x;
    u_xlat18 = u_xlat5.y * _HeigtFogParams2.x;
    u_xlat25 = u_xlat4.x * -1.44269502;
    u_xlat25 = exp2(u_xlat25);
    u_xlat25 = (-u_xlat25) + 1.0;
    u_xlat25 = u_xlat25 / u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4.x));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4.x);
#endif
    u_xlat16_3 = (u_xlatb4) ? u_xlat25 : 1.0;
    u_xlat4.x = u_xlat21 * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16_3 * u_xlat4.x;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat4.x = u_xlat21 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat4.x) + 2.0;
    u_xlat16_10 = u_xlat16_10 * u_xlat4.x;
    u_xlat4.x = u_xlat16_10 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat4.x = u_xlat4.x + 1.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat4.x;
    u_xlat4.x = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat25 = (-u_xlat4.x) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat25);
    u_xlat3.w = u_xlat23 * u_xlat25;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * u_xlat4.xxx + u_xlat2.xyz;
    u_xlat2.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat2.x) + 2.0;
    u_xlat16_6 = u_xlat2.x * u_xlat16_6;
    u_xlat2.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat5.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat23 = u_xlat21 + (-_HeigtFogRamp2.w);
    u_xlat23 = u_xlat23 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat23 = u_xlat21 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat4.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat4.x;
    u_xlat4.x = u_xlat23 * _HeigtFogColDelta2.w;
    u_xlat23 = (u_xlatb11) ? u_xlat4.x : u_xlat23;
    u_xlat23 = log2(u_xlat23);
    u_xlat23 = u_xlat23 * _Mihoyo_FogColor2.w;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = min(u_xlat23, _HeigtFogColBase2.w);
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat2.xyz;
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat4.x = u_xlat18 * -1.44269502;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x / u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat18));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat18);
#endif
    u_xlat16_6 = (u_xlatb11) ? u_xlat4.x : 1.0;
    u_xlat4.x = u_xlat21 * _HeigtFogParams2.y;
    u_xlat21 = u_xlat21 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat4.x * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat21) + 2.0;
    u_xlat16_13 = u_xlat21 * u_xlat16_13;
    u_xlat21 = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_6 = u_xlat21 * u_xlat16_6;
    u_xlat21 = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat4.x = (-u_xlat21) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat4.w = u_xlat23 * u_xlat4.x;
    u_xlat4.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat21) + u_xlat2.xyz;
    u_xlat2 = u_xlat3 + (-u_xlat4);
    u_xlat2 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat2 + u_xlat4;
    vs_COLOR1 = u_xlat2;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    vs_TEXCOORD4.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD5.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD7 = u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingRimGlow;
uniform 	float _RGControlTexRRatio;
uniform 	float _RGControlTexGRatio;
uniform 	float _RGControlTexBRatio;
uniform 	float _RGControlTexARatio;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _ControlTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
float u_xlat18;
bool u_xlatb19;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_2.xyz = u_xlat0.xxx * _RGColor.xyz;
    u_xlat16_20 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_20 = min(max(u_xlat16_20, 0.0), 1.0);
#else
    u_xlat16_20 = clamp(u_xlat16_20, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_20 * _RGRatio;
    u_xlat16_2.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat6.xyz = texture(_Splat0Tex, vs_TEXCOORD2.xy).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexRRatio, _RGControlTexRRatio, _RGControlTexRRatio)) + u_xlat6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow));
#else
    u_xlatb19 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow);
#endif
    u_xlat16_3.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat6.xyz = texture(_Splat1Tex, vs_TEXCOORD2.zw).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexGRatio, _RGControlTexGRatio, _RGControlTexGRatio)) + u_xlat6.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat10_5 = texture(_ControlTex, vs_TEXCOORD0.xy);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_5.yyy;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_5.xxx + u_xlat16_4.xyz;
    u_xlat6.xyz = texture(_Splat2Tex, vs_TEXCOORD3.xy).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexBRatio, _RGControlTexBRatio, _RGControlTexBRatio)) + u_xlat6.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat10_5.zzz + u_xlat16_3.xyz;
    u_xlat6.xyz = texture(_Splat3Tex, vs_TEXCOORD3.zw).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_RGControlTexARatio) + u_xlat6.xyz;
    u_xlat16_2.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat16_20 = (u_xlatb19) ? u_xlat0.x : 0.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_5.www + u_xlat16_3.xyz;
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_0.www) + u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    u_xlat0.x = (-_BloomFactor) + _RGBloomFactor;
    u_xlat0.x = u_xlat16_20 * u_xlat0.x + _BloomFactor;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
uniform 	mediump vec4 _ControlTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
mediump float u_xlat16_6;
mediump float u_xlat16_10;
float u_xlat11;
bool u_xlatb11;
mediump float u_xlat16_13;
float u_xlat18;
float u_xlat21;
float u_xlat23;
float u_xlat25;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _ControlTex_ST.xy + _ControlTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    vs_TEXCOORD3.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat21) + 2.0;
    u_xlat16_3 = u_xlat21 * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat5.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat23 = u_xlat21 + (-_HeigtFogRamp3.w);
    u_xlat23 = u_xlat23 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat23 = u_xlat21 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat4.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat4.x;
    u_xlat4.x = u_xlat23 * _HeigtFogColDelta3.w;
    u_xlat11 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(u_xlat21>=u_xlat11);
#else
    u_xlatb11 = u_xlat21>=u_xlat11;
#endif
    u_xlat23 = (u_xlatb11) ? u_xlat4.x : u_xlat23;
    u_xlat23 = log2(u_xlat23);
    u_xlat23 = u_xlat23 * _Mihoyo_FogColor3.w;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = min(u_xlat23, _HeigtFogColBase3.w);
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat2.xyz;
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat4.x = u_xlat5.y * _HeigtFogParams3.x;
    u_xlat18 = u_xlat5.y * _HeigtFogParams2.x;
    u_xlat25 = u_xlat4.x * -1.44269502;
    u_xlat25 = exp2(u_xlat25);
    u_xlat25 = (-u_xlat25) + 1.0;
    u_xlat25 = u_xlat25 / u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4.x));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4.x);
#endif
    u_xlat16_3 = (u_xlatb4) ? u_xlat25 : 1.0;
    u_xlat4.x = u_xlat21 * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16_3 * u_xlat4.x;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat4.x = u_xlat21 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat4.x) + 2.0;
    u_xlat16_10 = u_xlat16_10 * u_xlat4.x;
    u_xlat4.x = u_xlat16_10 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat4.x = u_xlat4.x + 1.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat4.x;
    u_xlat4.x = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat25 = (-u_xlat4.x) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat25);
    u_xlat3.w = u_xlat23 * u_xlat25;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * u_xlat4.xxx + u_xlat2.xyz;
    u_xlat2.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat2.x) + 2.0;
    u_xlat16_6 = u_xlat2.x * u_xlat16_6;
    u_xlat2.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat5.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat23 = u_xlat21 + (-_HeigtFogRamp2.w);
    u_xlat23 = u_xlat23 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat23 = u_xlat21 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat4.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat4.x;
    u_xlat4.x = u_xlat23 * _HeigtFogColDelta2.w;
    u_xlat23 = (u_xlatb11) ? u_xlat4.x : u_xlat23;
    u_xlat23 = log2(u_xlat23);
    u_xlat23 = u_xlat23 * _Mihoyo_FogColor2.w;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = min(u_xlat23, _HeigtFogColBase2.w);
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat2.xyz;
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat4.x = u_xlat18 * -1.44269502;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x / u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat18));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat18);
#endif
    u_xlat16_6 = (u_xlatb11) ? u_xlat4.x : 1.0;
    u_xlat4.x = u_xlat21 * _HeigtFogParams2.y;
    u_xlat21 = u_xlat21 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat4.x * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat21) + 2.0;
    u_xlat16_13 = u_xlat21 * u_xlat16_13;
    u_xlat21 = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_6 = u_xlat21 * u_xlat16_6;
    u_xlat21 = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat4.x = (-u_xlat21) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat4.w = u_xlat23 * u_xlat4.x;
    u_xlat4.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat21) + u_xlat2.xyz;
    u_xlat2 = u_xlat3 + (-u_xlat4);
    u_xlat2 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat2 + u_xlat4;
    vs_COLOR1 = u_xlat2;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    vs_TEXCOORD4.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD5.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD7 = u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingRimGlow;
uniform 	float _RGControlTexRRatio;
uniform 	float _RGControlTexGRatio;
uniform 	float _RGControlTexBRatio;
uniform 	float _RGControlTexARatio;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _ControlTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
float u_xlat18;
bool u_xlatb19;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_2.xyz = u_xlat0.xxx * _RGColor.xyz;
    u_xlat16_20 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_20 = min(max(u_xlat16_20, 0.0), 1.0);
#else
    u_xlat16_20 = clamp(u_xlat16_20, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_20 * _RGRatio;
    u_xlat16_2.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat6.xyz = texture(_Splat0Tex, vs_TEXCOORD2.xy).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexRRatio, _RGControlTexRRatio, _RGControlTexRRatio)) + u_xlat6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow));
#else
    u_xlatb19 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow);
#endif
    u_xlat16_3.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat6.xyz = texture(_Splat1Tex, vs_TEXCOORD2.zw).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexGRatio, _RGControlTexGRatio, _RGControlTexGRatio)) + u_xlat6.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat10_5 = texture(_ControlTex, vs_TEXCOORD0.xy);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_5.yyy;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_5.xxx + u_xlat16_4.xyz;
    u_xlat6.xyz = texture(_Splat2Tex, vs_TEXCOORD3.xy).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexBRatio, _RGControlTexBRatio, _RGControlTexBRatio)) + u_xlat6.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat10_5.zzz + u_xlat16_3.xyz;
    u_xlat6.xyz = texture(_Splat3Tex, vs_TEXCOORD3.zw).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_RGControlTexARatio) + u_xlat6.xyz;
    u_xlat16_2.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat16_20 = (u_xlatb19) ? u_xlat0.x : 0.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_5.www + u_xlat16_3.xyz;
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_0.www) + u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    u_xlat0.x = (-_BloomFactor) + _RGBloomFactor;
    u_xlat0.x = u_xlat16_20 * u_xlat0.x + _BloomFactor;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
uniform 	mediump vec4 _ControlTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _ControlTex_ST.xy + _ControlTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    vs_TEXCOORD3.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat12 = u_xlat2.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat2.x);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat2.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat6);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD5.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xy = u_xlat2.zz + u_xlat2.xw;
    gl_Position = u_xlat1;
    u_xlat2.zw = u_xlat1.zw;
    vs_TEXCOORD7 = u_xlat2;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingRimGlow;
uniform 	float _RGControlTexRRatio;
uniform 	float _RGControlTexGRatio;
uniform 	float _RGControlTexBRatio;
uniform 	float _RGControlTexARatio;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform 	mediump float _ReflectionEmissionAdjust;
uniform 	mediump vec4 _FresnelParams;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _ControlTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _ReflectMaskTex;
uniform lowp sampler2D _ReflectionTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat21;
mediump float u_xlat16_22;
bool u_xlatb23;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, vs_TEXCOORD4.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.y;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x + _FresnelParams.z;
    u_xlat16_8.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_8.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_0.xyz * vec3(_ReflectionEmissionAdjust);
    u_xlat10_0.x = texture(_ReflectMaskTex, vs_TEXCOORD1.xy).x;
    u_xlat16_8.xyz = u_xlat10_0.xxx * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_8.xyz;
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat21 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_3.xyz = u_xlat0.xxx * _RGColor.xyz;
    u_xlat16_22 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_22 * _RGRatio;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat7.xyz = texture(_Splat0Tex, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexRRatio, _RGControlTexRRatio, _RGControlTexRRatio)) + u_xlat7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow));
#else
    u_xlatb23 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow);
#endif
    u_xlat16_4.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat7.xyz = texture(_Splat1Tex, vs_TEXCOORD2.zw).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexGRatio, _RGControlTexGRatio, _RGControlTexGRatio)) + u_xlat7.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat10_6 = texture(_ControlTex, vs_TEXCOORD0.xy);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat10_6.yyy;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_6.xxx + u_xlat16_5.xyz;
    u_xlat7.xyz = texture(_Splat2Tex, vs_TEXCOORD3.xy).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexBRatio, _RGControlTexBRatio, _RGControlTexBRatio)) + u_xlat7.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat16_4.xyz = u_xlat16_5.xyz * u_xlat10_6.zzz + u_xlat16_4.xyz;
    u_xlat7.xyz = texture(_Splat3Tex, vs_TEXCOORD3.zw).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_RGControlTexARatio) + u_xlat7.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat16_22 = (u_xlatb23) ? u_xlat0.x : 0.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_6.www + u_xlat16_4.xyz;
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_4.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = (-u_xlat10_0.www) + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + u_xlat16_1.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat0.x = (-_BloomFactor) + _RGBloomFactor;
    u_xlat0.x = u_xlat16_22 * u_xlat0.x + _BloomFactor;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
uniform 	mediump vec4 _ControlTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _ControlTex_ST.xy + _ControlTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    vs_TEXCOORD3.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat12 = u_xlat2.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat2.x);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat2.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat6);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD5.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xy = u_xlat2.zz + u_xlat2.xw;
    gl_Position = u_xlat1;
    u_xlat2.zw = u_xlat1.zw;
    vs_TEXCOORD7 = u_xlat2;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingRimGlow;
uniform 	float _RGControlTexRRatio;
uniform 	float _RGControlTexGRatio;
uniform 	float _RGControlTexBRatio;
uniform 	float _RGControlTexARatio;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform 	mediump float _ReflectionEmissionAdjust;
uniform 	mediump vec4 _FresnelParams;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _ControlTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _ReflectMaskTex;
uniform lowp sampler2D _ReflectionTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat21;
mediump float u_xlat16_22;
bool u_xlatb23;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, vs_TEXCOORD4.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.y;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x + _FresnelParams.z;
    u_xlat16_8.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_8.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_0.xyz * vec3(_ReflectionEmissionAdjust);
    u_xlat10_0.x = texture(_ReflectMaskTex, vs_TEXCOORD1.xy).x;
    u_xlat16_8.xyz = u_xlat10_0.xxx * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_8.xyz;
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat21 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_3.xyz = u_xlat0.xxx * _RGColor.xyz;
    u_xlat16_22 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_22 * _RGRatio;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat7.xyz = texture(_Splat0Tex, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexRRatio, _RGControlTexRRatio, _RGControlTexRRatio)) + u_xlat7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow));
#else
    u_xlatb23 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow);
#endif
    u_xlat16_4.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat7.xyz = texture(_Splat1Tex, vs_TEXCOORD2.zw).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexGRatio, _RGControlTexGRatio, _RGControlTexGRatio)) + u_xlat7.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat10_6 = texture(_ControlTex, vs_TEXCOORD0.xy);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat10_6.yyy;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_6.xxx + u_xlat16_5.xyz;
    u_xlat7.xyz = texture(_Splat2Tex, vs_TEXCOORD3.xy).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexBRatio, _RGControlTexBRatio, _RGControlTexBRatio)) + u_xlat7.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat16_4.xyz = u_xlat16_5.xyz * u_xlat10_6.zzz + u_xlat16_4.xyz;
    u_xlat7.xyz = texture(_Splat3Tex, vs_TEXCOORD3.zw).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_RGControlTexARatio) + u_xlat7.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat16_22 = (u_xlatb23) ? u_xlat0.x : 0.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_6.www + u_xlat16_4.xyz;
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_4.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = (-u_xlat10_0.www) + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + u_xlat16_1.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat0.x = (-_BloomFactor) + _RGBloomFactor;
    u_xlat0.x = u_xlat16_22 * u_xlat0.x + _BloomFactor;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
uniform 	mediump vec4 _ControlTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _ControlTex_ST.xy + _ControlTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    vs_TEXCOORD3.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat12 = u_xlat2.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat2.x);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat2.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat6);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD5.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xy = u_xlat2.zz + u_xlat2.xw;
    gl_Position = u_xlat1;
    u_xlat2.zw = u_xlat1.zw;
    vs_TEXCOORD7 = u_xlat2;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingRimGlow;
uniform 	float _RGControlTexRRatio;
uniform 	float _RGControlTexGRatio;
uniform 	float _RGControlTexBRatio;
uniform 	float _RGControlTexARatio;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform 	mediump float _ReflectionEmissionAdjust;
uniform 	mediump vec4 _FresnelParams;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _ControlTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _ReflectMaskTex;
uniform lowp sampler2D _ReflectionTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat21;
mediump float u_xlat16_22;
bool u_xlatb23;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, vs_TEXCOORD4.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.y;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x + _FresnelParams.z;
    u_xlat16_8.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_8.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_0.xyz * vec3(_ReflectionEmissionAdjust);
    u_xlat10_0.x = texture(_ReflectMaskTex, vs_TEXCOORD1.xy).x;
    u_xlat16_8.xyz = u_xlat10_0.xxx * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_8.xyz;
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat21 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_3.xyz = u_xlat0.xxx * _RGColor.xyz;
    u_xlat16_22 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_22 * _RGRatio;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat7.xyz = texture(_Splat0Tex, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexRRatio, _RGControlTexRRatio, _RGControlTexRRatio)) + u_xlat7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow));
#else
    u_xlatb23 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow);
#endif
    u_xlat16_4.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat7.xyz = texture(_Splat1Tex, vs_TEXCOORD2.zw).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexGRatio, _RGControlTexGRatio, _RGControlTexGRatio)) + u_xlat7.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat10_6 = texture(_ControlTex, vs_TEXCOORD0.xy);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat10_6.yyy;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_6.xxx + u_xlat16_5.xyz;
    u_xlat7.xyz = texture(_Splat2Tex, vs_TEXCOORD3.xy).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexBRatio, _RGControlTexBRatio, _RGControlTexBRatio)) + u_xlat7.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat16_4.xyz = u_xlat16_5.xyz * u_xlat10_6.zzz + u_xlat16_4.xyz;
    u_xlat7.xyz = texture(_Splat3Tex, vs_TEXCOORD3.zw).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_RGControlTexARatio) + u_xlat7.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat16_22 = (u_xlatb23) ? u_xlat0.x : 0.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_6.www + u_xlat16_4.xyz;
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_4.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = (-u_xlat10_0.www) + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + u_xlat16_1.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat0.x = (-_BloomFactor) + _RGBloomFactor;
    u_xlat0.x = u_xlat16_22 * u_xlat0.x + _BloomFactor;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LERP" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
uniform 	mediump vec4 _ControlTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _ControlTex_ST.xy + _ControlTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    vs_TEXCOORD3.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat12 = u_xlat2.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat2.x);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat2.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat6);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD5.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xy = u_xlat2.zz + u_xlat2.xw;
    gl_Position = u_xlat1;
    u_xlat2.zw = u_xlat1.zw;
    vs_TEXCOORD7 = u_xlat2;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingRimGlow;
uniform 	float _RGControlTexRRatio;
uniform 	float _RGControlTexGRatio;
uniform 	float _RGControlTexBRatio;
uniform 	float _RGControlTexARatio;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform 	mediump float _ReflectionEmissionAdjust;
uniform 	mediump vec4 _FresnelParams;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _ControlTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _ReflectMaskTex;
uniform lowp sampler2D _ReflectionTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat21;
mediump float u_xlat16_22;
bool u_xlatb23;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, vs_TEXCOORD4.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.y;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x + _FresnelParams.z;
    u_xlat16_8.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_8.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_0.xyz * vec3(_ReflectionEmissionAdjust);
    u_xlat10_0.x = texture(_ReflectMaskTex, vs_TEXCOORD1.xy).x;
    u_xlat16_8.xyz = u_xlat10_0.xxx * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_8.xyz;
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat21 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_3.xyz = u_xlat0.xxx * _RGColor.xyz;
    u_xlat16_22 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_22 * _RGRatio;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat7.xyz = texture(_Splat0Tex, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexRRatio, _RGControlTexRRatio, _RGControlTexRRatio)) + u_xlat7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow));
#else
    u_xlatb23 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow);
#endif
    u_xlat16_4.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat7.xyz = texture(_Splat1Tex, vs_TEXCOORD2.zw).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexGRatio, _RGControlTexGRatio, _RGControlTexGRatio)) + u_xlat7.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat10_6 = texture(_ControlTex, vs_TEXCOORD0.xy);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat10_6.yyy;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_6.xxx + u_xlat16_5.xyz;
    u_xlat7.xyz = texture(_Splat2Tex, vs_TEXCOORD3.xy).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexBRatio, _RGControlTexBRatio, _RGControlTexBRatio)) + u_xlat7.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat16_4.xyz = u_xlat16_5.xyz * u_xlat10_6.zzz + u_xlat16_4.xyz;
    u_xlat7.xyz = texture(_Splat3Tex, vs_TEXCOORD3.zw).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_RGControlTexARatio) + u_xlat7.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat16_22 = (u_xlatb23) ? u_xlat0.x : 0.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_6.www + u_xlat16_4.xyz;
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_4.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = (-u_xlat10_0.www) + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + u_xlat16_1.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat0.x = (-_BloomFactor) + _RGBloomFactor;
    u_xlat0.x = u_xlat16_22 * u_xlat0.x + _BloomFactor;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LERP" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
uniform 	mediump vec4 _ControlTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _ControlTex_ST.xy + _ControlTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    vs_TEXCOORD3.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat12 = u_xlat2.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat2.x);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat2.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat6);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD5.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xy = u_xlat2.zz + u_xlat2.xw;
    gl_Position = u_xlat1;
    u_xlat2.zw = u_xlat1.zw;
    vs_TEXCOORD7 = u_xlat2;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingRimGlow;
uniform 	float _RGControlTexRRatio;
uniform 	float _RGControlTexGRatio;
uniform 	float _RGControlTexBRatio;
uniform 	float _RGControlTexARatio;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform 	mediump float _ReflectionEmissionAdjust;
uniform 	mediump vec4 _FresnelParams;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _ControlTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _ReflectMaskTex;
uniform lowp sampler2D _ReflectionTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat21;
mediump float u_xlat16_22;
bool u_xlatb23;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, vs_TEXCOORD4.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.y;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x + _FresnelParams.z;
    u_xlat16_8.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_8.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_0.xyz * vec3(_ReflectionEmissionAdjust);
    u_xlat10_0.x = texture(_ReflectMaskTex, vs_TEXCOORD1.xy).x;
    u_xlat16_8.xyz = u_xlat10_0.xxx * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_8.xyz;
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat21 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_3.xyz = u_xlat0.xxx * _RGColor.xyz;
    u_xlat16_22 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_22 * _RGRatio;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat7.xyz = texture(_Splat0Tex, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexRRatio, _RGControlTexRRatio, _RGControlTexRRatio)) + u_xlat7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow));
#else
    u_xlatb23 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow);
#endif
    u_xlat16_4.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat7.xyz = texture(_Splat1Tex, vs_TEXCOORD2.zw).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexGRatio, _RGControlTexGRatio, _RGControlTexGRatio)) + u_xlat7.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat10_6 = texture(_ControlTex, vs_TEXCOORD0.xy);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat10_6.yyy;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_6.xxx + u_xlat16_5.xyz;
    u_xlat7.xyz = texture(_Splat2Tex, vs_TEXCOORD3.xy).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexBRatio, _RGControlTexBRatio, _RGControlTexBRatio)) + u_xlat7.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat16_4.xyz = u_xlat16_5.xyz * u_xlat10_6.zzz + u_xlat16_4.xyz;
    u_xlat7.xyz = texture(_Splat3Tex, vs_TEXCOORD3.zw).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_RGControlTexARatio) + u_xlat7.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat16_22 = (u_xlatb23) ? u_xlat0.x : 0.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_6.www + u_xlat16_4.xyz;
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_4.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = (-u_xlat10_0.www) + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + u_xlat16_1.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat0.x = (-_BloomFactor) + _RGBloomFactor;
    u_xlat0.x = u_xlat16_22 * u_xlat0.x + _BloomFactor;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LERP" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
uniform 	mediump vec4 _ControlTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _ControlTex_ST.xy + _ControlTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    vs_TEXCOORD3.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat12 = u_xlat2.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat2.x);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat2.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat6);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD5.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xy = u_xlat2.zz + u_xlat2.xw;
    gl_Position = u_xlat1;
    u_xlat2.zw = u_xlat1.zw;
    vs_TEXCOORD7 = u_xlat2;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingRimGlow;
uniform 	float _RGControlTexRRatio;
uniform 	float _RGControlTexGRatio;
uniform 	float _RGControlTexBRatio;
uniform 	float _RGControlTexARatio;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform 	mediump float _ReflectionEmissionAdjust;
uniform 	mediump vec4 _FresnelParams;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _ControlTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _ReflectMaskTex;
uniform lowp sampler2D _ReflectionTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat21;
mediump float u_xlat16_22;
bool u_xlatb23;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, vs_TEXCOORD4.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.y;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x + _FresnelParams.z;
    u_xlat16_8.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_8.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_0.xyz * vec3(_ReflectionEmissionAdjust);
    u_xlat10_0.x = texture(_ReflectMaskTex, vs_TEXCOORD1.xy).x;
    u_xlat16_8.xyz = u_xlat10_0.xxx * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_8.xyz;
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat21 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_3.xyz = u_xlat0.xxx * _RGColor.xyz;
    u_xlat16_22 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_22 * _RGRatio;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat7.xyz = texture(_Splat0Tex, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexRRatio, _RGControlTexRRatio, _RGControlTexRRatio)) + u_xlat7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow));
#else
    u_xlatb23 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow);
#endif
    u_xlat16_4.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat7.xyz = texture(_Splat1Tex, vs_TEXCOORD2.zw).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexGRatio, _RGControlTexGRatio, _RGControlTexGRatio)) + u_xlat7.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat10_6 = texture(_ControlTex, vs_TEXCOORD0.xy);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat10_6.yyy;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_6.xxx + u_xlat16_5.xyz;
    u_xlat7.xyz = texture(_Splat2Tex, vs_TEXCOORD3.xy).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexBRatio, _RGControlTexBRatio, _RGControlTexBRatio)) + u_xlat7.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat16_4.xyz = u_xlat16_5.xyz * u_xlat10_6.zzz + u_xlat16_4.xyz;
    u_xlat7.xyz = texture(_Splat3Tex, vs_TEXCOORD3.zw).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_RGControlTexARatio) + u_xlat7.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat16_22 = (u_xlatb23) ? u_xlat0.x : 0.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_6.www + u_xlat16_4.xyz;
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_4.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = (-u_xlat10_0.www) + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + u_xlat16_1.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat0.x = (-_BloomFactor) + _RGBloomFactor;
    u_xlat0.x = u_xlat16_22 * u_xlat0.x + _BloomFactor;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
uniform 	mediump vec4 _ControlTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
mediump float u_xlat16_9;
float u_xlat10;
float u_xlat16;
float u_xlat18;
float u_xlat20;
bool u_xlatb20;
float u_xlat22;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _ControlTex_ST.xy + _ControlTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    vs_TEXCOORD3.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat18) + 2.0;
    u_xlat16_3 = u_xlat18 * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat20 = u_xlat5.y * _HeigtFogParams.x;
    u_xlat18 = sqrt(u_xlat18);
    u_xlat22 = u_xlat18 + (-_HeigtFogRamp.w);
    u_xlat22 = u_xlat22 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat4.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat18>=u_xlat4.x);
#else
    u_xlatb4 = u_xlat18>=u_xlat4.x;
#endif
    u_xlat10 = u_xlat18 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat10) + 2.0;
    u_xlat10 = u_xlat16 * u_xlat10;
    u_xlat16 = u_xlat10 * _HeigtFogColDelta.w;
    u_xlat4.x = (u_xlatb4) ? u_xlat16 : u_xlat10;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _Mihoyo_FogColor.w;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, _HeigtFogColBase.w);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat10 = u_xlat20 * -1.44269502;
    u_xlat4.y = exp2(u_xlat10);
    u_xlat4.xy = (-u_xlat4.xy) + vec2(1.0, 1.0);
    u_xlat10 = u_xlat4.y / u_xlat20;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(0.00999999978<abs(u_xlat20));
#else
    u_xlatb20 = 0.00999999978<abs(u_xlat20);
#endif
    u_xlat16_3 = (u_xlatb20) ? u_xlat10 : 1.0;
    u_xlat20 = u_xlat18 * _HeigtFogParams.y;
    u_xlat18 = u_xlat18 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat20 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_9 = (-u_xlat18) + 2.0;
    u_xlat16_9 = u_xlat18 * u_xlat16_9;
    u_xlat18 = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat18 = u_xlat18 + 1.0;
    u_xlat16_3 = u_xlat18 * u_xlat16_3;
    u_xlat18 = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat20 = (-u_xlat18) + 1.0;
    u_xlat2.xyz = vec3(u_xlat20) * u_xlat2.xyz;
    u_xlat3.w = u_xlat20 * u_xlat4.x;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat18) + u_xlat2.xyz;
    vs_COLOR1 = u_xlat3;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    vs_TEXCOORD4.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD5.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD7 = u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingRimGlow;
uniform 	float _RGControlTexRRatio;
uniform 	float _RGControlTexGRatio;
uniform 	float _RGControlTexBRatio;
uniform 	float _RGControlTexARatio;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform 	mediump float _ReflectionEmissionAdjust;
uniform 	mediump vec4 _FresnelParams;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _ControlTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _ReflectMaskTex;
uniform lowp sampler2D _ReflectionTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat21;
mediump float u_xlat16_22;
bool u_xlatb23;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, vs_TEXCOORD4.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.y;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x + _FresnelParams.z;
    u_xlat16_8.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_8.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_0.xyz * vec3(_ReflectionEmissionAdjust);
    u_xlat10_0.x = texture(_ReflectMaskTex, vs_TEXCOORD1.xy).x;
    u_xlat16_8.xyz = u_xlat10_0.xxx * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_8.xyz;
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat21 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_3.xyz = u_xlat0.xxx * _RGColor.xyz;
    u_xlat16_22 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_22 * _RGRatio;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat7.xyz = texture(_Splat0Tex, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexRRatio, _RGControlTexRRatio, _RGControlTexRRatio)) + u_xlat7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow));
#else
    u_xlatb23 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow);
#endif
    u_xlat16_4.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat7.xyz = texture(_Splat1Tex, vs_TEXCOORD2.zw).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexGRatio, _RGControlTexGRatio, _RGControlTexGRatio)) + u_xlat7.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat10_6 = texture(_ControlTex, vs_TEXCOORD0.xy);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat10_6.yyy;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_6.xxx + u_xlat16_5.xyz;
    u_xlat7.xyz = texture(_Splat2Tex, vs_TEXCOORD3.xy).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexBRatio, _RGControlTexBRatio, _RGControlTexBRatio)) + u_xlat7.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat16_4.xyz = u_xlat16_5.xyz * u_xlat10_6.zzz + u_xlat16_4.xyz;
    u_xlat7.xyz = texture(_Splat3Tex, vs_TEXCOORD3.zw).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_RGControlTexARatio) + u_xlat7.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat16_22 = (u_xlatb23) ? u_xlat0.x : 0.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_6.www + u_xlat16_4.xyz;
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_4.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = (-u_xlat10_0.www) + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + u_xlat16_1.xyz;
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_3.xxx + vs_COLOR1.xyz;
    u_xlat0.x = (-_BloomFactor) + _RGBloomFactor;
    u_xlat0.x = u_xlat16_22 * u_xlat0.x + _BloomFactor;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
uniform 	mediump vec4 _ControlTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
mediump float u_xlat16_9;
float u_xlat10;
float u_xlat16;
float u_xlat18;
float u_xlat20;
bool u_xlatb20;
float u_xlat22;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _ControlTex_ST.xy + _ControlTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    vs_TEXCOORD3.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat18) + 2.0;
    u_xlat16_3 = u_xlat18 * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat20 = u_xlat5.y * _HeigtFogParams.x;
    u_xlat18 = sqrt(u_xlat18);
    u_xlat22 = u_xlat18 + (-_HeigtFogRamp.w);
    u_xlat22 = u_xlat22 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat4.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat18>=u_xlat4.x);
#else
    u_xlatb4 = u_xlat18>=u_xlat4.x;
#endif
    u_xlat10 = u_xlat18 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat10) + 2.0;
    u_xlat10 = u_xlat16 * u_xlat10;
    u_xlat16 = u_xlat10 * _HeigtFogColDelta.w;
    u_xlat4.x = (u_xlatb4) ? u_xlat16 : u_xlat10;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _Mihoyo_FogColor.w;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, _HeigtFogColBase.w);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat10 = u_xlat20 * -1.44269502;
    u_xlat4.y = exp2(u_xlat10);
    u_xlat4.xy = (-u_xlat4.xy) + vec2(1.0, 1.0);
    u_xlat10 = u_xlat4.y / u_xlat20;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(0.00999999978<abs(u_xlat20));
#else
    u_xlatb20 = 0.00999999978<abs(u_xlat20);
#endif
    u_xlat16_3 = (u_xlatb20) ? u_xlat10 : 1.0;
    u_xlat20 = u_xlat18 * _HeigtFogParams.y;
    u_xlat18 = u_xlat18 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat20 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_9 = (-u_xlat18) + 2.0;
    u_xlat16_9 = u_xlat18 * u_xlat16_9;
    u_xlat18 = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat18 = u_xlat18 + 1.0;
    u_xlat16_3 = u_xlat18 * u_xlat16_3;
    u_xlat18 = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat20 = (-u_xlat18) + 1.0;
    u_xlat2.xyz = vec3(u_xlat20) * u_xlat2.xyz;
    u_xlat3.w = u_xlat20 * u_xlat4.x;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat18) + u_xlat2.xyz;
    vs_COLOR1 = u_xlat3;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    vs_TEXCOORD4.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD5.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD7 = u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingRimGlow;
uniform 	float _RGControlTexRRatio;
uniform 	float _RGControlTexGRatio;
uniform 	float _RGControlTexBRatio;
uniform 	float _RGControlTexARatio;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform 	mediump float _ReflectionEmissionAdjust;
uniform 	mediump vec4 _FresnelParams;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _ControlTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _ReflectMaskTex;
uniform lowp sampler2D _ReflectionTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat21;
mediump float u_xlat16_22;
bool u_xlatb23;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, vs_TEXCOORD4.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.y;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x + _FresnelParams.z;
    u_xlat16_8.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_8.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_0.xyz * vec3(_ReflectionEmissionAdjust);
    u_xlat10_0.x = texture(_ReflectMaskTex, vs_TEXCOORD1.xy).x;
    u_xlat16_8.xyz = u_xlat10_0.xxx * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_8.xyz;
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat21 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_3.xyz = u_xlat0.xxx * _RGColor.xyz;
    u_xlat16_22 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_22 * _RGRatio;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat7.xyz = texture(_Splat0Tex, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexRRatio, _RGControlTexRRatio, _RGControlTexRRatio)) + u_xlat7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow));
#else
    u_xlatb23 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow);
#endif
    u_xlat16_4.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat7.xyz = texture(_Splat1Tex, vs_TEXCOORD2.zw).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexGRatio, _RGControlTexGRatio, _RGControlTexGRatio)) + u_xlat7.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat10_6 = texture(_ControlTex, vs_TEXCOORD0.xy);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat10_6.yyy;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_6.xxx + u_xlat16_5.xyz;
    u_xlat7.xyz = texture(_Splat2Tex, vs_TEXCOORD3.xy).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexBRatio, _RGControlTexBRatio, _RGControlTexBRatio)) + u_xlat7.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat16_4.xyz = u_xlat16_5.xyz * u_xlat10_6.zzz + u_xlat16_4.xyz;
    u_xlat7.xyz = texture(_Splat3Tex, vs_TEXCOORD3.zw).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_RGControlTexARatio) + u_xlat7.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat16_22 = (u_xlatb23) ? u_xlat0.x : 0.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_6.www + u_xlat16_4.xyz;
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_4.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = (-u_xlat10_0.www) + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + u_xlat16_1.xyz;
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_3.xxx + vs_COLOR1.xyz;
    u_xlat0.x = (-_BloomFactor) + _RGBloomFactor;
    u_xlat0.x = u_xlat16_22 * u_xlat0.x + _BloomFactor;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
uniform 	mediump vec4 _ControlTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
mediump float u_xlat16_9;
float u_xlat10;
float u_xlat16;
float u_xlat18;
float u_xlat20;
bool u_xlatb20;
float u_xlat22;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _ControlTex_ST.xy + _ControlTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    vs_TEXCOORD3.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat18) + 2.0;
    u_xlat16_3 = u_xlat18 * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat20 = u_xlat5.y * _HeigtFogParams.x;
    u_xlat18 = sqrt(u_xlat18);
    u_xlat22 = u_xlat18 + (-_HeigtFogRamp.w);
    u_xlat22 = u_xlat22 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat4.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat18>=u_xlat4.x);
#else
    u_xlatb4 = u_xlat18>=u_xlat4.x;
#endif
    u_xlat10 = u_xlat18 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat10) + 2.0;
    u_xlat10 = u_xlat16 * u_xlat10;
    u_xlat16 = u_xlat10 * _HeigtFogColDelta.w;
    u_xlat4.x = (u_xlatb4) ? u_xlat16 : u_xlat10;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _Mihoyo_FogColor.w;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, _HeigtFogColBase.w);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat10 = u_xlat20 * -1.44269502;
    u_xlat4.y = exp2(u_xlat10);
    u_xlat4.xy = (-u_xlat4.xy) + vec2(1.0, 1.0);
    u_xlat10 = u_xlat4.y / u_xlat20;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(0.00999999978<abs(u_xlat20));
#else
    u_xlatb20 = 0.00999999978<abs(u_xlat20);
#endif
    u_xlat16_3 = (u_xlatb20) ? u_xlat10 : 1.0;
    u_xlat20 = u_xlat18 * _HeigtFogParams.y;
    u_xlat18 = u_xlat18 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat20 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_9 = (-u_xlat18) + 2.0;
    u_xlat16_9 = u_xlat18 * u_xlat16_9;
    u_xlat18 = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat18 = u_xlat18 + 1.0;
    u_xlat16_3 = u_xlat18 * u_xlat16_3;
    u_xlat18 = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat20 = (-u_xlat18) + 1.0;
    u_xlat2.xyz = vec3(u_xlat20) * u_xlat2.xyz;
    u_xlat3.w = u_xlat20 * u_xlat4.x;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat18) + u_xlat2.xyz;
    vs_COLOR1 = u_xlat3;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    vs_TEXCOORD4.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD5.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD7 = u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingRimGlow;
uniform 	float _RGControlTexRRatio;
uniform 	float _RGControlTexGRatio;
uniform 	float _RGControlTexBRatio;
uniform 	float _RGControlTexARatio;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform 	mediump float _ReflectionEmissionAdjust;
uniform 	mediump vec4 _FresnelParams;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _ControlTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _ReflectMaskTex;
uniform lowp sampler2D _ReflectionTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat21;
mediump float u_xlat16_22;
bool u_xlatb23;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, vs_TEXCOORD4.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.y;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x + _FresnelParams.z;
    u_xlat16_8.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_8.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_0.xyz * vec3(_ReflectionEmissionAdjust);
    u_xlat10_0.x = texture(_ReflectMaskTex, vs_TEXCOORD1.xy).x;
    u_xlat16_8.xyz = u_xlat10_0.xxx * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_8.xyz;
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat21 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_3.xyz = u_xlat0.xxx * _RGColor.xyz;
    u_xlat16_22 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_22 * _RGRatio;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat7.xyz = texture(_Splat0Tex, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexRRatio, _RGControlTexRRatio, _RGControlTexRRatio)) + u_xlat7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow));
#else
    u_xlatb23 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow);
#endif
    u_xlat16_4.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat7.xyz = texture(_Splat1Tex, vs_TEXCOORD2.zw).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexGRatio, _RGControlTexGRatio, _RGControlTexGRatio)) + u_xlat7.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat10_6 = texture(_ControlTex, vs_TEXCOORD0.xy);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat10_6.yyy;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_6.xxx + u_xlat16_5.xyz;
    u_xlat7.xyz = texture(_Splat2Tex, vs_TEXCOORD3.xy).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexBRatio, _RGControlTexBRatio, _RGControlTexBRatio)) + u_xlat7.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat16_4.xyz = u_xlat16_5.xyz * u_xlat10_6.zzz + u_xlat16_4.xyz;
    u_xlat7.xyz = texture(_Splat3Tex, vs_TEXCOORD3.zw).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_RGControlTexARatio) + u_xlat7.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat16_22 = (u_xlatb23) ? u_xlat0.x : 0.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_6.www + u_xlat16_4.xyz;
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_4.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = (-u_xlat10_0.www) + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + u_xlat16_1.xyz;
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_3.xxx + vs_COLOR1.xyz;
    u_xlat0.x = (-_BloomFactor) + _RGBloomFactor;
    u_xlat0.x = u_xlat16_22 * u_xlat0.x + _BloomFactor;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
uniform 	mediump vec4 _ControlTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
mediump float u_xlat16_6;
mediump float u_xlat16_10;
float u_xlat11;
bool u_xlatb11;
mediump float u_xlat16_13;
float u_xlat18;
float u_xlat21;
float u_xlat23;
float u_xlat25;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _ControlTex_ST.xy + _ControlTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    vs_TEXCOORD3.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat21) + 2.0;
    u_xlat16_3 = u_xlat21 * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat5.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat23 = u_xlat21 + (-_HeigtFogRamp3.w);
    u_xlat23 = u_xlat23 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat23 = u_xlat21 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat4.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat4.x;
    u_xlat4.x = u_xlat23 * _HeigtFogColDelta3.w;
    u_xlat11 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(u_xlat21>=u_xlat11);
#else
    u_xlatb11 = u_xlat21>=u_xlat11;
#endif
    u_xlat23 = (u_xlatb11) ? u_xlat4.x : u_xlat23;
    u_xlat23 = log2(u_xlat23);
    u_xlat23 = u_xlat23 * _Mihoyo_FogColor3.w;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = min(u_xlat23, _HeigtFogColBase3.w);
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat2.xyz;
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat4.x = u_xlat5.y * _HeigtFogParams3.x;
    u_xlat18 = u_xlat5.y * _HeigtFogParams2.x;
    u_xlat25 = u_xlat4.x * -1.44269502;
    u_xlat25 = exp2(u_xlat25);
    u_xlat25 = (-u_xlat25) + 1.0;
    u_xlat25 = u_xlat25 / u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4.x));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4.x);
#endif
    u_xlat16_3 = (u_xlatb4) ? u_xlat25 : 1.0;
    u_xlat4.x = u_xlat21 * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16_3 * u_xlat4.x;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat4.x = u_xlat21 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat4.x) + 2.0;
    u_xlat16_10 = u_xlat16_10 * u_xlat4.x;
    u_xlat4.x = u_xlat16_10 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat4.x = u_xlat4.x + 1.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat4.x;
    u_xlat4.x = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat25 = (-u_xlat4.x) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat25);
    u_xlat3.w = u_xlat23 * u_xlat25;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * u_xlat4.xxx + u_xlat2.xyz;
    u_xlat2.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat2.x) + 2.0;
    u_xlat16_6 = u_xlat2.x * u_xlat16_6;
    u_xlat2.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat5.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat23 = u_xlat21 + (-_HeigtFogRamp2.w);
    u_xlat23 = u_xlat23 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat23 = u_xlat21 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat4.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat4.x;
    u_xlat4.x = u_xlat23 * _HeigtFogColDelta2.w;
    u_xlat23 = (u_xlatb11) ? u_xlat4.x : u_xlat23;
    u_xlat23 = log2(u_xlat23);
    u_xlat23 = u_xlat23 * _Mihoyo_FogColor2.w;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = min(u_xlat23, _HeigtFogColBase2.w);
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat2.xyz;
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat4.x = u_xlat18 * -1.44269502;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x / u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat18));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat18);
#endif
    u_xlat16_6 = (u_xlatb11) ? u_xlat4.x : 1.0;
    u_xlat4.x = u_xlat21 * _HeigtFogParams2.y;
    u_xlat21 = u_xlat21 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat4.x * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat21) + 2.0;
    u_xlat16_13 = u_xlat21 * u_xlat16_13;
    u_xlat21 = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_6 = u_xlat21 * u_xlat16_6;
    u_xlat21 = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat4.x = (-u_xlat21) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat4.w = u_xlat23 * u_xlat4.x;
    u_xlat4.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat21) + u_xlat2.xyz;
    u_xlat2 = u_xlat3 + (-u_xlat4);
    u_xlat2 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat2 + u_xlat4;
    vs_COLOR1 = u_xlat2;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    vs_TEXCOORD4.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD5.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD7 = u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingRimGlow;
uniform 	float _RGControlTexRRatio;
uniform 	float _RGControlTexGRatio;
uniform 	float _RGControlTexBRatio;
uniform 	float _RGControlTexARatio;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform 	mediump float _ReflectionEmissionAdjust;
uniform 	mediump vec4 _FresnelParams;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _ControlTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _ReflectMaskTex;
uniform lowp sampler2D _ReflectionTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat21;
mediump float u_xlat16_22;
bool u_xlatb23;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, vs_TEXCOORD4.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.y;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x + _FresnelParams.z;
    u_xlat16_8.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_8.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_0.xyz * vec3(_ReflectionEmissionAdjust);
    u_xlat10_0.x = texture(_ReflectMaskTex, vs_TEXCOORD1.xy).x;
    u_xlat16_8.xyz = u_xlat10_0.xxx * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_8.xyz;
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat21 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_3.xyz = u_xlat0.xxx * _RGColor.xyz;
    u_xlat16_22 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_22 * _RGRatio;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat7.xyz = texture(_Splat0Tex, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexRRatio, _RGControlTexRRatio, _RGControlTexRRatio)) + u_xlat7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow));
#else
    u_xlatb23 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow);
#endif
    u_xlat16_4.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat7.xyz = texture(_Splat1Tex, vs_TEXCOORD2.zw).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexGRatio, _RGControlTexGRatio, _RGControlTexGRatio)) + u_xlat7.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat10_6 = texture(_ControlTex, vs_TEXCOORD0.xy);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat10_6.yyy;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_6.xxx + u_xlat16_5.xyz;
    u_xlat7.xyz = texture(_Splat2Tex, vs_TEXCOORD3.xy).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexBRatio, _RGControlTexBRatio, _RGControlTexBRatio)) + u_xlat7.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat16_4.xyz = u_xlat16_5.xyz * u_xlat10_6.zzz + u_xlat16_4.xyz;
    u_xlat7.xyz = texture(_Splat3Tex, vs_TEXCOORD3.zw).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_RGControlTexARatio) + u_xlat7.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat16_22 = (u_xlatb23) ? u_xlat0.x : 0.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_6.www + u_xlat16_4.xyz;
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_4.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = (-u_xlat10_0.www) + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + u_xlat16_1.xyz;
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_3.xxx + vs_COLOR1.xyz;
    u_xlat0.x = (-_BloomFactor) + _RGBloomFactor;
    u_xlat0.x = u_xlat16_22 * u_xlat0.x + _BloomFactor;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
uniform 	mediump vec4 _ControlTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
mediump float u_xlat16_6;
mediump float u_xlat16_10;
float u_xlat11;
bool u_xlatb11;
mediump float u_xlat16_13;
float u_xlat18;
float u_xlat21;
float u_xlat23;
float u_xlat25;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _ControlTex_ST.xy + _ControlTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    vs_TEXCOORD3.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat21) + 2.0;
    u_xlat16_3 = u_xlat21 * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat5.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat23 = u_xlat21 + (-_HeigtFogRamp3.w);
    u_xlat23 = u_xlat23 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat23 = u_xlat21 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat4.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat4.x;
    u_xlat4.x = u_xlat23 * _HeigtFogColDelta3.w;
    u_xlat11 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(u_xlat21>=u_xlat11);
#else
    u_xlatb11 = u_xlat21>=u_xlat11;
#endif
    u_xlat23 = (u_xlatb11) ? u_xlat4.x : u_xlat23;
    u_xlat23 = log2(u_xlat23);
    u_xlat23 = u_xlat23 * _Mihoyo_FogColor3.w;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = min(u_xlat23, _HeigtFogColBase3.w);
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat2.xyz;
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat4.x = u_xlat5.y * _HeigtFogParams3.x;
    u_xlat18 = u_xlat5.y * _HeigtFogParams2.x;
    u_xlat25 = u_xlat4.x * -1.44269502;
    u_xlat25 = exp2(u_xlat25);
    u_xlat25 = (-u_xlat25) + 1.0;
    u_xlat25 = u_xlat25 / u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4.x));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4.x);
#endif
    u_xlat16_3 = (u_xlatb4) ? u_xlat25 : 1.0;
    u_xlat4.x = u_xlat21 * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16_3 * u_xlat4.x;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat4.x = u_xlat21 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat4.x) + 2.0;
    u_xlat16_10 = u_xlat16_10 * u_xlat4.x;
    u_xlat4.x = u_xlat16_10 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat4.x = u_xlat4.x + 1.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat4.x;
    u_xlat4.x = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat25 = (-u_xlat4.x) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat25);
    u_xlat3.w = u_xlat23 * u_xlat25;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * u_xlat4.xxx + u_xlat2.xyz;
    u_xlat2.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat2.x) + 2.0;
    u_xlat16_6 = u_xlat2.x * u_xlat16_6;
    u_xlat2.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat5.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat23 = u_xlat21 + (-_HeigtFogRamp2.w);
    u_xlat23 = u_xlat23 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat23 = u_xlat21 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat4.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat4.x;
    u_xlat4.x = u_xlat23 * _HeigtFogColDelta2.w;
    u_xlat23 = (u_xlatb11) ? u_xlat4.x : u_xlat23;
    u_xlat23 = log2(u_xlat23);
    u_xlat23 = u_xlat23 * _Mihoyo_FogColor2.w;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = min(u_xlat23, _HeigtFogColBase2.w);
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat2.xyz;
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat4.x = u_xlat18 * -1.44269502;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x / u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat18));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat18);
#endif
    u_xlat16_6 = (u_xlatb11) ? u_xlat4.x : 1.0;
    u_xlat4.x = u_xlat21 * _HeigtFogParams2.y;
    u_xlat21 = u_xlat21 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat4.x * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat21) + 2.0;
    u_xlat16_13 = u_xlat21 * u_xlat16_13;
    u_xlat21 = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_6 = u_xlat21 * u_xlat16_6;
    u_xlat21 = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat4.x = (-u_xlat21) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat4.w = u_xlat23 * u_xlat4.x;
    u_xlat4.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat21) + u_xlat2.xyz;
    u_xlat2 = u_xlat3 + (-u_xlat4);
    u_xlat2 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat2 + u_xlat4;
    vs_COLOR1 = u_xlat2;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    vs_TEXCOORD4.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD5.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD7 = u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingRimGlow;
uniform 	float _RGControlTexRRatio;
uniform 	float _RGControlTexGRatio;
uniform 	float _RGControlTexBRatio;
uniform 	float _RGControlTexARatio;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform 	mediump float _ReflectionEmissionAdjust;
uniform 	mediump vec4 _FresnelParams;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _ControlTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _ReflectMaskTex;
uniform lowp sampler2D _ReflectionTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat21;
mediump float u_xlat16_22;
bool u_xlatb23;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, vs_TEXCOORD4.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.y;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x + _FresnelParams.z;
    u_xlat16_8.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_8.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_0.xyz * vec3(_ReflectionEmissionAdjust);
    u_xlat10_0.x = texture(_ReflectMaskTex, vs_TEXCOORD1.xy).x;
    u_xlat16_8.xyz = u_xlat10_0.xxx * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_8.xyz;
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat21 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_3.xyz = u_xlat0.xxx * _RGColor.xyz;
    u_xlat16_22 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_22 * _RGRatio;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat7.xyz = texture(_Splat0Tex, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexRRatio, _RGControlTexRRatio, _RGControlTexRRatio)) + u_xlat7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow));
#else
    u_xlatb23 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow);
#endif
    u_xlat16_4.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat7.xyz = texture(_Splat1Tex, vs_TEXCOORD2.zw).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexGRatio, _RGControlTexGRatio, _RGControlTexGRatio)) + u_xlat7.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat10_6 = texture(_ControlTex, vs_TEXCOORD0.xy);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat10_6.yyy;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_6.xxx + u_xlat16_5.xyz;
    u_xlat7.xyz = texture(_Splat2Tex, vs_TEXCOORD3.xy).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexBRatio, _RGControlTexBRatio, _RGControlTexBRatio)) + u_xlat7.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat16_4.xyz = u_xlat16_5.xyz * u_xlat10_6.zzz + u_xlat16_4.xyz;
    u_xlat7.xyz = texture(_Splat3Tex, vs_TEXCOORD3.zw).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_RGControlTexARatio) + u_xlat7.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat16_22 = (u_xlatb23) ? u_xlat0.x : 0.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_6.www + u_xlat16_4.xyz;
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_4.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = (-u_xlat10_0.www) + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + u_xlat16_1.xyz;
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_3.xxx + vs_COLOR1.xyz;
    u_xlat0.x = (-_BloomFactor) + _RGBloomFactor;
    u_xlat0.x = u_xlat16_22 * u_xlat0.x + _BloomFactor;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
uniform 	mediump vec4 _ControlTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
mediump float u_xlat16_6;
mediump float u_xlat16_10;
float u_xlat11;
bool u_xlatb11;
mediump float u_xlat16_13;
float u_xlat18;
float u_xlat21;
float u_xlat23;
float u_xlat25;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _ControlTex_ST.xy + _ControlTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    vs_TEXCOORD3.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat21) + 2.0;
    u_xlat16_3 = u_xlat21 * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat5.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat23 = u_xlat21 + (-_HeigtFogRamp3.w);
    u_xlat23 = u_xlat23 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat23 = u_xlat21 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat4.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat4.x;
    u_xlat4.x = u_xlat23 * _HeigtFogColDelta3.w;
    u_xlat11 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(u_xlat21>=u_xlat11);
#else
    u_xlatb11 = u_xlat21>=u_xlat11;
#endif
    u_xlat23 = (u_xlatb11) ? u_xlat4.x : u_xlat23;
    u_xlat23 = log2(u_xlat23);
    u_xlat23 = u_xlat23 * _Mihoyo_FogColor3.w;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = min(u_xlat23, _HeigtFogColBase3.w);
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat2.xyz;
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat4.x = u_xlat5.y * _HeigtFogParams3.x;
    u_xlat18 = u_xlat5.y * _HeigtFogParams2.x;
    u_xlat25 = u_xlat4.x * -1.44269502;
    u_xlat25 = exp2(u_xlat25);
    u_xlat25 = (-u_xlat25) + 1.0;
    u_xlat25 = u_xlat25 / u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4.x));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4.x);
#endif
    u_xlat16_3 = (u_xlatb4) ? u_xlat25 : 1.0;
    u_xlat4.x = u_xlat21 * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16_3 * u_xlat4.x;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat4.x = u_xlat21 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat4.x) + 2.0;
    u_xlat16_10 = u_xlat16_10 * u_xlat4.x;
    u_xlat4.x = u_xlat16_10 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat4.x = u_xlat4.x + 1.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat4.x;
    u_xlat4.x = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat25 = (-u_xlat4.x) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat25);
    u_xlat3.w = u_xlat23 * u_xlat25;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * u_xlat4.xxx + u_xlat2.xyz;
    u_xlat2.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat2.x) + 2.0;
    u_xlat16_6 = u_xlat2.x * u_xlat16_6;
    u_xlat2.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat5.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat23 = u_xlat21 + (-_HeigtFogRamp2.w);
    u_xlat23 = u_xlat23 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat23 = u_xlat21 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat4.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat4.x;
    u_xlat4.x = u_xlat23 * _HeigtFogColDelta2.w;
    u_xlat23 = (u_xlatb11) ? u_xlat4.x : u_xlat23;
    u_xlat23 = log2(u_xlat23);
    u_xlat23 = u_xlat23 * _Mihoyo_FogColor2.w;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = min(u_xlat23, _HeigtFogColBase2.w);
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat2.xyz;
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat4.x = u_xlat18 * -1.44269502;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x / u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat18));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat18);
#endif
    u_xlat16_6 = (u_xlatb11) ? u_xlat4.x : 1.0;
    u_xlat4.x = u_xlat21 * _HeigtFogParams2.y;
    u_xlat21 = u_xlat21 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat4.x * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat21) + 2.0;
    u_xlat16_13 = u_xlat21 * u_xlat16_13;
    u_xlat21 = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_6 = u_xlat21 * u_xlat16_6;
    u_xlat21 = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat4.x = (-u_xlat21) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat4.w = u_xlat23 * u_xlat4.x;
    u_xlat4.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat21) + u_xlat2.xyz;
    u_xlat2 = u_xlat3 + (-u_xlat4);
    u_xlat2 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat2 + u_xlat4;
    vs_COLOR1 = u_xlat2;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    vs_TEXCOORD4.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD5.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD7 = u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingRimGlow;
uniform 	float _RGControlTexRRatio;
uniform 	float _RGControlTexGRatio;
uniform 	float _RGControlTexBRatio;
uniform 	float _RGControlTexARatio;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform 	mediump float _ReflectionEmissionAdjust;
uniform 	mediump vec4 _FresnelParams;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _ControlTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _ReflectMaskTex;
uniform lowp sampler2D _ReflectionTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat21;
mediump float u_xlat16_22;
bool u_xlatb23;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, vs_TEXCOORD4.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.y;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x + _FresnelParams.z;
    u_xlat16_8.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_8.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_0.xyz * vec3(_ReflectionEmissionAdjust);
    u_xlat10_0.x = texture(_ReflectMaskTex, vs_TEXCOORD1.xy).x;
    u_xlat16_8.xyz = u_xlat10_0.xxx * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_8.xyz;
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat21 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_3.xyz = u_xlat0.xxx * _RGColor.xyz;
    u_xlat16_22 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_22 * _RGRatio;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat7.xyz = texture(_Splat0Tex, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexRRatio, _RGControlTexRRatio, _RGControlTexRRatio)) + u_xlat7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow));
#else
    u_xlatb23 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow);
#endif
    u_xlat16_4.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat7.xyz = texture(_Splat1Tex, vs_TEXCOORD2.zw).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexGRatio, _RGControlTexGRatio, _RGControlTexGRatio)) + u_xlat7.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat10_6 = texture(_ControlTex, vs_TEXCOORD0.xy);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat10_6.yyy;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_6.xxx + u_xlat16_5.xyz;
    u_xlat7.xyz = texture(_Splat2Tex, vs_TEXCOORD3.xy).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexBRatio, _RGControlTexBRatio, _RGControlTexBRatio)) + u_xlat7.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat16_4.xyz = u_xlat16_5.xyz * u_xlat10_6.zzz + u_xlat16_4.xyz;
    u_xlat7.xyz = texture(_Splat3Tex, vs_TEXCOORD3.zw).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_RGControlTexARatio) + u_xlat7.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat16_22 = (u_xlatb23) ? u_xlat0.x : 0.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_6.www + u_xlat16_4.xyz;
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_4.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = (-u_xlat10_0.www) + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + u_xlat16_1.xyz;
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_3.xxx + vs_COLOR1.xyz;
    u_xlat0.x = (-_BloomFactor) + _RGBloomFactor;
    u_xlat0.x = u_xlat16_22 * u_xlat0.x + _BloomFactor;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
uniform 	mediump vec4 _ControlTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _ControlTex_ST.xy + _ControlTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    vs_TEXCOORD3.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat12 = u_xlat2.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat2.x);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat2.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat6);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD5.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xy = u_xlat2.zz + u_xlat2.xw;
    gl_Position = u_xlat1;
    u_xlat2.zw = u_xlat1.zw;
    vs_TEXCOORD7 = u_xlat2;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingRimGlow;
uniform 	float _RGControlTexRRatio;
uniform 	float _RGControlTexGRatio;
uniform 	float _RGControlTexBRatio;
uniform 	float _RGControlTexARatio;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _ControlTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
float u_xlat18;
bool u_xlatb19;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_2.xyz = u_xlat0.xxx * _RGColor.xyz;
    u_xlat16_20 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_20 = min(max(u_xlat16_20, 0.0), 1.0);
#else
    u_xlat16_20 = clamp(u_xlat16_20, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_20 * _RGRatio;
    u_xlat16_2.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat6.xyz = texture(_Splat0Tex, vs_TEXCOORD2.xy).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexRRatio, _RGControlTexRRatio, _RGControlTexRRatio)) + u_xlat6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow));
#else
    u_xlatb19 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow);
#endif
    u_xlat16_3.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat6.xyz = texture(_Splat1Tex, vs_TEXCOORD2.zw).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexGRatio, _RGControlTexGRatio, _RGControlTexGRatio)) + u_xlat6.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat10_5 = texture(_ControlTex, vs_TEXCOORD0.xy);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_5.yyy;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_5.xxx + u_xlat16_4.xyz;
    u_xlat6.xyz = texture(_Splat2Tex, vs_TEXCOORD3.xy).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexBRatio, _RGControlTexBRatio, _RGControlTexBRatio)) + u_xlat6.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat10_5.zzz + u_xlat16_3.xyz;
    u_xlat6.xyz = texture(_Splat3Tex, vs_TEXCOORD3.zw).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_RGControlTexARatio) + u_xlat6.xyz;
    u_xlat16_2.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat16_20 = (u_xlatb19) ? u_xlat0.x : 0.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_5.www + u_xlat16_3.xyz;
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_0.www) + u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat0.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat1.x = (-_BloomFactor) + _RGBloomFactor;
    u_xlat0.w = u_xlat16_20 * u_xlat1.x + _BloomFactor;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
uniform 	mediump vec4 _ControlTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _ControlTex_ST.xy + _ControlTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    vs_TEXCOORD3.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat12 = u_xlat2.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat2.x);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat2.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat6);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD5.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xy = u_xlat2.zz + u_xlat2.xw;
    gl_Position = u_xlat1;
    u_xlat2.zw = u_xlat1.zw;
    vs_TEXCOORD7 = u_xlat2;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingRimGlow;
uniform 	float _RGControlTexRRatio;
uniform 	float _RGControlTexGRatio;
uniform 	float _RGControlTexBRatio;
uniform 	float _RGControlTexARatio;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _ControlTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
float u_xlat18;
bool u_xlatb19;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_2.xyz = u_xlat0.xxx * _RGColor.xyz;
    u_xlat16_20 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_20 = min(max(u_xlat16_20, 0.0), 1.0);
#else
    u_xlat16_20 = clamp(u_xlat16_20, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_20 * _RGRatio;
    u_xlat16_2.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat6.xyz = texture(_Splat0Tex, vs_TEXCOORD2.xy).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexRRatio, _RGControlTexRRatio, _RGControlTexRRatio)) + u_xlat6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow));
#else
    u_xlatb19 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow);
#endif
    u_xlat16_3.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat6.xyz = texture(_Splat1Tex, vs_TEXCOORD2.zw).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexGRatio, _RGControlTexGRatio, _RGControlTexGRatio)) + u_xlat6.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat10_5 = texture(_ControlTex, vs_TEXCOORD0.xy);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_5.yyy;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_5.xxx + u_xlat16_4.xyz;
    u_xlat6.xyz = texture(_Splat2Tex, vs_TEXCOORD3.xy).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexBRatio, _RGControlTexBRatio, _RGControlTexBRatio)) + u_xlat6.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat10_5.zzz + u_xlat16_3.xyz;
    u_xlat6.xyz = texture(_Splat3Tex, vs_TEXCOORD3.zw).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_RGControlTexARatio) + u_xlat6.xyz;
    u_xlat16_2.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat16_20 = (u_xlatb19) ? u_xlat0.x : 0.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_5.www + u_xlat16_3.xyz;
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_0.www) + u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat0.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat1.x = (-_BloomFactor) + _RGBloomFactor;
    u_xlat0.w = u_xlat16_20 * u_xlat1.x + _BloomFactor;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
uniform 	mediump vec4 _ControlTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _ControlTex_ST.xy + _ControlTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    vs_TEXCOORD3.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat12 = u_xlat2.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat2.x);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat2.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat6);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD5.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xy = u_xlat2.zz + u_xlat2.xw;
    gl_Position = u_xlat1;
    u_xlat2.zw = u_xlat1.zw;
    vs_TEXCOORD7 = u_xlat2;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingRimGlow;
uniform 	float _RGControlTexRRatio;
uniform 	float _RGControlTexGRatio;
uniform 	float _RGControlTexBRatio;
uniform 	float _RGControlTexARatio;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _ControlTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
float u_xlat18;
bool u_xlatb19;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_2.xyz = u_xlat0.xxx * _RGColor.xyz;
    u_xlat16_20 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_20 = min(max(u_xlat16_20, 0.0), 1.0);
#else
    u_xlat16_20 = clamp(u_xlat16_20, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_20 * _RGRatio;
    u_xlat16_2.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat6.xyz = texture(_Splat0Tex, vs_TEXCOORD2.xy).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexRRatio, _RGControlTexRRatio, _RGControlTexRRatio)) + u_xlat6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow));
#else
    u_xlatb19 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow);
#endif
    u_xlat16_3.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat6.xyz = texture(_Splat1Tex, vs_TEXCOORD2.zw).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexGRatio, _RGControlTexGRatio, _RGControlTexGRatio)) + u_xlat6.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat10_5 = texture(_ControlTex, vs_TEXCOORD0.xy);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_5.yyy;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_5.xxx + u_xlat16_4.xyz;
    u_xlat6.xyz = texture(_Splat2Tex, vs_TEXCOORD3.xy).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexBRatio, _RGControlTexBRatio, _RGControlTexBRatio)) + u_xlat6.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat10_5.zzz + u_xlat16_3.xyz;
    u_xlat6.xyz = texture(_Splat3Tex, vs_TEXCOORD3.zw).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_RGControlTexARatio) + u_xlat6.xyz;
    u_xlat16_2.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat16_20 = (u_xlatb19) ? u_xlat0.x : 0.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_5.www + u_xlat16_3.xyz;
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_0.www) + u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat0.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat1.x = (-_BloomFactor) + _RGBloomFactor;
    u_xlat0.w = u_xlat16_20 * u_xlat1.x + _BloomFactor;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
uniform 	mediump vec4 _ControlTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _ControlTex_ST.xy + _ControlTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    vs_TEXCOORD3.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat12 = u_xlat2.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat2.x);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat2.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat6);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD5.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xy = u_xlat2.zz + u_xlat2.xw;
    gl_Position = u_xlat1;
    u_xlat2.zw = u_xlat1.zw;
    vs_TEXCOORD7 = u_xlat2;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingRimGlow;
uniform 	float _RGControlTexRRatio;
uniform 	float _RGControlTexGRatio;
uniform 	float _RGControlTexBRatio;
uniform 	float _RGControlTexARatio;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _ControlTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
float u_xlat18;
bool u_xlatb19;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_2.xyz = u_xlat0.xxx * _RGColor.xyz;
    u_xlat16_20 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_20 = min(max(u_xlat16_20, 0.0), 1.0);
#else
    u_xlat16_20 = clamp(u_xlat16_20, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_20 * _RGRatio;
    u_xlat16_2.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat6.xyz = texture(_Splat0Tex, vs_TEXCOORD2.xy).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexRRatio, _RGControlTexRRatio, _RGControlTexRRatio)) + u_xlat6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow));
#else
    u_xlatb19 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow);
#endif
    u_xlat16_3.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat6.xyz = texture(_Splat1Tex, vs_TEXCOORD2.zw).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexGRatio, _RGControlTexGRatio, _RGControlTexGRatio)) + u_xlat6.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat10_5 = texture(_ControlTex, vs_TEXCOORD0.xy);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_5.yyy;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_5.xxx + u_xlat16_4.xyz;
    u_xlat6.xyz = texture(_Splat2Tex, vs_TEXCOORD3.xy).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexBRatio, _RGControlTexBRatio, _RGControlTexBRatio)) + u_xlat6.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat10_5.zzz + u_xlat16_3.xyz;
    u_xlat6.xyz = texture(_Splat3Tex, vs_TEXCOORD3.zw).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_RGControlTexARatio) + u_xlat6.xyz;
    u_xlat16_2.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat16_20 = (u_xlatb19) ? u_xlat0.x : 0.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_5.www + u_xlat16_3.xyz;
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_0.www) + u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat0.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat1.x = (-_BloomFactor) + _RGBloomFactor;
    u_xlat0.w = u_xlat16_20 * u_xlat1.x + _BloomFactor;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
uniform 	mediump vec4 _ControlTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _ControlTex_ST.xy + _ControlTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    vs_TEXCOORD3.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat12 = u_xlat2.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat2.x);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat2.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat6);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD5.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xy = u_xlat2.zz + u_xlat2.xw;
    gl_Position = u_xlat1;
    u_xlat2.zw = u_xlat1.zw;
    vs_TEXCOORD7 = u_xlat2;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingRimGlow;
uniform 	float _RGControlTexRRatio;
uniform 	float _RGControlTexGRatio;
uniform 	float _RGControlTexBRatio;
uniform 	float _RGControlTexARatio;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _ControlTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
float u_xlat18;
bool u_xlatb19;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_2.xyz = u_xlat0.xxx * _RGColor.xyz;
    u_xlat16_20 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_20 = min(max(u_xlat16_20, 0.0), 1.0);
#else
    u_xlat16_20 = clamp(u_xlat16_20, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_20 * _RGRatio;
    u_xlat16_2.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat6.xyz = texture(_Splat0Tex, vs_TEXCOORD2.xy).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexRRatio, _RGControlTexRRatio, _RGControlTexRRatio)) + u_xlat6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow));
#else
    u_xlatb19 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow);
#endif
    u_xlat16_3.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat6.xyz = texture(_Splat1Tex, vs_TEXCOORD2.zw).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexGRatio, _RGControlTexGRatio, _RGControlTexGRatio)) + u_xlat6.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat10_5 = texture(_ControlTex, vs_TEXCOORD0.xy);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_5.yyy;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_5.xxx + u_xlat16_4.xyz;
    u_xlat6.xyz = texture(_Splat2Tex, vs_TEXCOORD3.xy).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexBRatio, _RGControlTexBRatio, _RGControlTexBRatio)) + u_xlat6.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat10_5.zzz + u_xlat16_3.xyz;
    u_xlat6.xyz = texture(_Splat3Tex, vs_TEXCOORD3.zw).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_RGControlTexARatio) + u_xlat6.xyz;
    u_xlat16_2.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat16_20 = (u_xlatb19) ? u_xlat0.x : 0.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_5.www + u_xlat16_3.xyz;
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_0.www) + u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat0.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat1.x = (-_BloomFactor) + _RGBloomFactor;
    u_xlat0.w = u_xlat16_20 * u_xlat1.x + _BloomFactor;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
uniform 	mediump vec4 _ControlTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _ControlTex_ST.xy + _ControlTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    vs_TEXCOORD3.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat12 = u_xlat2.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat2.x);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat2.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat6);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD5.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xy = u_xlat2.zz + u_xlat2.xw;
    gl_Position = u_xlat1;
    u_xlat2.zw = u_xlat1.zw;
    vs_TEXCOORD7 = u_xlat2;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingRimGlow;
uniform 	float _RGControlTexRRatio;
uniform 	float _RGControlTexGRatio;
uniform 	float _RGControlTexBRatio;
uniform 	float _RGControlTexARatio;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _ControlTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
float u_xlat18;
bool u_xlatb19;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_2.xyz = u_xlat0.xxx * _RGColor.xyz;
    u_xlat16_20 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_20 = min(max(u_xlat16_20, 0.0), 1.0);
#else
    u_xlat16_20 = clamp(u_xlat16_20, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_20 * _RGRatio;
    u_xlat16_2.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat6.xyz = texture(_Splat0Tex, vs_TEXCOORD2.xy).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexRRatio, _RGControlTexRRatio, _RGControlTexRRatio)) + u_xlat6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow));
#else
    u_xlatb19 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow);
#endif
    u_xlat16_3.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat6.xyz = texture(_Splat1Tex, vs_TEXCOORD2.zw).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexGRatio, _RGControlTexGRatio, _RGControlTexGRatio)) + u_xlat6.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat10_5 = texture(_ControlTex, vs_TEXCOORD0.xy);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_5.yyy;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_5.xxx + u_xlat16_4.xyz;
    u_xlat6.xyz = texture(_Splat2Tex, vs_TEXCOORD3.xy).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexBRatio, _RGControlTexBRatio, _RGControlTexBRatio)) + u_xlat6.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat10_5.zzz + u_xlat16_3.xyz;
    u_xlat6.xyz = texture(_Splat3Tex, vs_TEXCOORD3.zw).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_RGControlTexARatio) + u_xlat6.xyz;
    u_xlat16_2.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat16_20 = (u_xlatb19) ? u_xlat0.x : 0.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_5.www + u_xlat16_3.xyz;
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_0.www) + u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat0.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat1.x = (-_BloomFactor) + _RGBloomFactor;
    u_xlat0.w = u_xlat16_20 * u_xlat1.x + _BloomFactor;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
uniform 	mediump vec4 _ControlTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
mediump float u_xlat16_9;
float u_xlat10;
float u_xlat16;
float u_xlat18;
float u_xlat20;
bool u_xlatb20;
float u_xlat22;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _ControlTex_ST.xy + _ControlTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    vs_TEXCOORD3.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat18) + 2.0;
    u_xlat16_3 = u_xlat18 * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat20 = u_xlat5.y * _HeigtFogParams.x;
    u_xlat18 = sqrt(u_xlat18);
    u_xlat22 = u_xlat18 + (-_HeigtFogRamp.w);
    u_xlat22 = u_xlat22 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat4.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat18>=u_xlat4.x);
#else
    u_xlatb4 = u_xlat18>=u_xlat4.x;
#endif
    u_xlat10 = u_xlat18 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat10) + 2.0;
    u_xlat10 = u_xlat16 * u_xlat10;
    u_xlat16 = u_xlat10 * _HeigtFogColDelta.w;
    u_xlat4.x = (u_xlatb4) ? u_xlat16 : u_xlat10;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _Mihoyo_FogColor.w;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, _HeigtFogColBase.w);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat10 = u_xlat20 * -1.44269502;
    u_xlat4.y = exp2(u_xlat10);
    u_xlat4.xy = (-u_xlat4.xy) + vec2(1.0, 1.0);
    u_xlat10 = u_xlat4.y / u_xlat20;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(0.00999999978<abs(u_xlat20));
#else
    u_xlatb20 = 0.00999999978<abs(u_xlat20);
#endif
    u_xlat16_3 = (u_xlatb20) ? u_xlat10 : 1.0;
    u_xlat20 = u_xlat18 * _HeigtFogParams.y;
    u_xlat18 = u_xlat18 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat20 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_9 = (-u_xlat18) + 2.0;
    u_xlat16_9 = u_xlat18 * u_xlat16_9;
    u_xlat18 = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat18 = u_xlat18 + 1.0;
    u_xlat16_3 = u_xlat18 * u_xlat16_3;
    u_xlat18 = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat20 = (-u_xlat18) + 1.0;
    u_xlat2.xyz = vec3(u_xlat20) * u_xlat2.xyz;
    u_xlat3.w = u_xlat20 * u_xlat4.x;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat18) + u_xlat2.xyz;
    vs_COLOR1 = u_xlat3;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    vs_TEXCOORD4.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD5.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD7 = u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingRimGlow;
uniform 	float _RGControlTexRRatio;
uniform 	float _RGControlTexGRatio;
uniform 	float _RGControlTexBRatio;
uniform 	float _RGControlTexARatio;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _ControlTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
float u_xlat18;
bool u_xlatb19;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_2.xyz = u_xlat0.xxx * _RGColor.xyz;
    u_xlat16_20 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_20 = min(max(u_xlat16_20, 0.0), 1.0);
#else
    u_xlat16_20 = clamp(u_xlat16_20, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_20 * _RGRatio;
    u_xlat16_2.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat6.xyz = texture(_Splat0Tex, vs_TEXCOORD2.xy).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexRRatio, _RGControlTexRRatio, _RGControlTexRRatio)) + u_xlat6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow));
#else
    u_xlatb19 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow);
#endif
    u_xlat16_3.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat6.xyz = texture(_Splat1Tex, vs_TEXCOORD2.zw).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexGRatio, _RGControlTexGRatio, _RGControlTexGRatio)) + u_xlat6.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat10_5 = texture(_ControlTex, vs_TEXCOORD0.xy);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_5.yyy;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_5.xxx + u_xlat16_4.xyz;
    u_xlat6.xyz = texture(_Splat2Tex, vs_TEXCOORD3.xy).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexBRatio, _RGControlTexBRatio, _RGControlTexBRatio)) + u_xlat6.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat10_5.zzz + u_xlat16_3.xyz;
    u_xlat6.xyz = texture(_Splat3Tex, vs_TEXCOORD3.zw).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_RGControlTexARatio) + u_xlat6.xyz;
    u_xlat16_2.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat16_20 = (u_xlatb19) ? u_xlat0.x : 0.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_5.www + u_xlat16_3.xyz;
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_0.www) + u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat1.x = (-_BloomFactor) + _RGBloomFactor;
    u_xlat0.w = u_xlat16_20 * u_xlat1.x + _BloomFactor;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
uniform 	mediump vec4 _ControlTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
mediump float u_xlat16_9;
float u_xlat10;
float u_xlat16;
float u_xlat18;
float u_xlat20;
bool u_xlatb20;
float u_xlat22;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _ControlTex_ST.xy + _ControlTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    vs_TEXCOORD3.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat18) + 2.0;
    u_xlat16_3 = u_xlat18 * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat20 = u_xlat5.y * _HeigtFogParams.x;
    u_xlat18 = sqrt(u_xlat18);
    u_xlat22 = u_xlat18 + (-_HeigtFogRamp.w);
    u_xlat22 = u_xlat22 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat4.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat18>=u_xlat4.x);
#else
    u_xlatb4 = u_xlat18>=u_xlat4.x;
#endif
    u_xlat10 = u_xlat18 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat10) + 2.0;
    u_xlat10 = u_xlat16 * u_xlat10;
    u_xlat16 = u_xlat10 * _HeigtFogColDelta.w;
    u_xlat4.x = (u_xlatb4) ? u_xlat16 : u_xlat10;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _Mihoyo_FogColor.w;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, _HeigtFogColBase.w);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat10 = u_xlat20 * -1.44269502;
    u_xlat4.y = exp2(u_xlat10);
    u_xlat4.xy = (-u_xlat4.xy) + vec2(1.0, 1.0);
    u_xlat10 = u_xlat4.y / u_xlat20;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(0.00999999978<abs(u_xlat20));
#else
    u_xlatb20 = 0.00999999978<abs(u_xlat20);
#endif
    u_xlat16_3 = (u_xlatb20) ? u_xlat10 : 1.0;
    u_xlat20 = u_xlat18 * _HeigtFogParams.y;
    u_xlat18 = u_xlat18 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat20 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_9 = (-u_xlat18) + 2.0;
    u_xlat16_9 = u_xlat18 * u_xlat16_9;
    u_xlat18 = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat18 = u_xlat18 + 1.0;
    u_xlat16_3 = u_xlat18 * u_xlat16_3;
    u_xlat18 = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat20 = (-u_xlat18) + 1.0;
    u_xlat2.xyz = vec3(u_xlat20) * u_xlat2.xyz;
    u_xlat3.w = u_xlat20 * u_xlat4.x;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat18) + u_xlat2.xyz;
    vs_COLOR1 = u_xlat3;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    vs_TEXCOORD4.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD5.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD7 = u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingRimGlow;
uniform 	float _RGControlTexRRatio;
uniform 	float _RGControlTexGRatio;
uniform 	float _RGControlTexBRatio;
uniform 	float _RGControlTexARatio;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _ControlTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
float u_xlat18;
bool u_xlatb19;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_2.xyz = u_xlat0.xxx * _RGColor.xyz;
    u_xlat16_20 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_20 = min(max(u_xlat16_20, 0.0), 1.0);
#else
    u_xlat16_20 = clamp(u_xlat16_20, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_20 * _RGRatio;
    u_xlat16_2.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat6.xyz = texture(_Splat0Tex, vs_TEXCOORD2.xy).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexRRatio, _RGControlTexRRatio, _RGControlTexRRatio)) + u_xlat6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow));
#else
    u_xlatb19 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow);
#endif
    u_xlat16_3.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat6.xyz = texture(_Splat1Tex, vs_TEXCOORD2.zw).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexGRatio, _RGControlTexGRatio, _RGControlTexGRatio)) + u_xlat6.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat10_5 = texture(_ControlTex, vs_TEXCOORD0.xy);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_5.yyy;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_5.xxx + u_xlat16_4.xyz;
    u_xlat6.xyz = texture(_Splat2Tex, vs_TEXCOORD3.xy).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexBRatio, _RGControlTexBRatio, _RGControlTexBRatio)) + u_xlat6.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat10_5.zzz + u_xlat16_3.xyz;
    u_xlat6.xyz = texture(_Splat3Tex, vs_TEXCOORD3.zw).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_RGControlTexARatio) + u_xlat6.xyz;
    u_xlat16_2.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat16_20 = (u_xlatb19) ? u_xlat0.x : 0.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_5.www + u_xlat16_3.xyz;
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_0.www) + u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat1.x = (-_BloomFactor) + _RGBloomFactor;
    u_xlat0.w = u_xlat16_20 * u_xlat1.x + _BloomFactor;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
uniform 	mediump vec4 _ControlTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
mediump float u_xlat16_9;
float u_xlat10;
float u_xlat16;
float u_xlat18;
float u_xlat20;
bool u_xlatb20;
float u_xlat22;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _ControlTex_ST.xy + _ControlTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    vs_TEXCOORD3.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat18) + 2.0;
    u_xlat16_3 = u_xlat18 * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat20 = u_xlat5.y * _HeigtFogParams.x;
    u_xlat18 = sqrt(u_xlat18);
    u_xlat22 = u_xlat18 + (-_HeigtFogRamp.w);
    u_xlat22 = u_xlat22 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat4.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat18>=u_xlat4.x);
#else
    u_xlatb4 = u_xlat18>=u_xlat4.x;
#endif
    u_xlat10 = u_xlat18 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat10) + 2.0;
    u_xlat10 = u_xlat16 * u_xlat10;
    u_xlat16 = u_xlat10 * _HeigtFogColDelta.w;
    u_xlat4.x = (u_xlatb4) ? u_xlat16 : u_xlat10;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _Mihoyo_FogColor.w;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, _HeigtFogColBase.w);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat10 = u_xlat20 * -1.44269502;
    u_xlat4.y = exp2(u_xlat10);
    u_xlat4.xy = (-u_xlat4.xy) + vec2(1.0, 1.0);
    u_xlat10 = u_xlat4.y / u_xlat20;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(0.00999999978<abs(u_xlat20));
#else
    u_xlatb20 = 0.00999999978<abs(u_xlat20);
#endif
    u_xlat16_3 = (u_xlatb20) ? u_xlat10 : 1.0;
    u_xlat20 = u_xlat18 * _HeigtFogParams.y;
    u_xlat18 = u_xlat18 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat20 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_9 = (-u_xlat18) + 2.0;
    u_xlat16_9 = u_xlat18 * u_xlat16_9;
    u_xlat18 = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat18 = u_xlat18 + 1.0;
    u_xlat16_3 = u_xlat18 * u_xlat16_3;
    u_xlat18 = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat20 = (-u_xlat18) + 1.0;
    u_xlat2.xyz = vec3(u_xlat20) * u_xlat2.xyz;
    u_xlat3.w = u_xlat20 * u_xlat4.x;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat18) + u_xlat2.xyz;
    vs_COLOR1 = u_xlat3;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    vs_TEXCOORD4.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD5.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD7 = u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingRimGlow;
uniform 	float _RGControlTexRRatio;
uniform 	float _RGControlTexGRatio;
uniform 	float _RGControlTexBRatio;
uniform 	float _RGControlTexARatio;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _ControlTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
float u_xlat18;
bool u_xlatb19;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_2.xyz = u_xlat0.xxx * _RGColor.xyz;
    u_xlat16_20 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_20 = min(max(u_xlat16_20, 0.0), 1.0);
#else
    u_xlat16_20 = clamp(u_xlat16_20, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_20 * _RGRatio;
    u_xlat16_2.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat6.xyz = texture(_Splat0Tex, vs_TEXCOORD2.xy).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexRRatio, _RGControlTexRRatio, _RGControlTexRRatio)) + u_xlat6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow));
#else
    u_xlatb19 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow);
#endif
    u_xlat16_3.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat6.xyz = texture(_Splat1Tex, vs_TEXCOORD2.zw).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexGRatio, _RGControlTexGRatio, _RGControlTexGRatio)) + u_xlat6.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat10_5 = texture(_ControlTex, vs_TEXCOORD0.xy);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_5.yyy;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_5.xxx + u_xlat16_4.xyz;
    u_xlat6.xyz = texture(_Splat2Tex, vs_TEXCOORD3.xy).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexBRatio, _RGControlTexBRatio, _RGControlTexBRatio)) + u_xlat6.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat10_5.zzz + u_xlat16_3.xyz;
    u_xlat6.xyz = texture(_Splat3Tex, vs_TEXCOORD3.zw).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_RGControlTexARatio) + u_xlat6.xyz;
    u_xlat16_2.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat16_20 = (u_xlatb19) ? u_xlat0.x : 0.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_5.www + u_xlat16_3.xyz;
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_0.www) + u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat1.x = (-_BloomFactor) + _RGBloomFactor;
    u_xlat0.w = u_xlat16_20 * u_xlat1.x + _BloomFactor;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
uniform 	mediump vec4 _ControlTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
mediump float u_xlat16_6;
mediump float u_xlat16_10;
float u_xlat11;
bool u_xlatb11;
mediump float u_xlat16_13;
float u_xlat18;
float u_xlat21;
float u_xlat23;
float u_xlat25;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _ControlTex_ST.xy + _ControlTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    vs_TEXCOORD3.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat21) + 2.0;
    u_xlat16_3 = u_xlat21 * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat5.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat23 = u_xlat21 + (-_HeigtFogRamp3.w);
    u_xlat23 = u_xlat23 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat23 = u_xlat21 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat4.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat4.x;
    u_xlat4.x = u_xlat23 * _HeigtFogColDelta3.w;
    u_xlat11 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(u_xlat21>=u_xlat11);
#else
    u_xlatb11 = u_xlat21>=u_xlat11;
#endif
    u_xlat23 = (u_xlatb11) ? u_xlat4.x : u_xlat23;
    u_xlat23 = log2(u_xlat23);
    u_xlat23 = u_xlat23 * _Mihoyo_FogColor3.w;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = min(u_xlat23, _HeigtFogColBase3.w);
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat2.xyz;
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat4.x = u_xlat5.y * _HeigtFogParams3.x;
    u_xlat18 = u_xlat5.y * _HeigtFogParams2.x;
    u_xlat25 = u_xlat4.x * -1.44269502;
    u_xlat25 = exp2(u_xlat25);
    u_xlat25 = (-u_xlat25) + 1.0;
    u_xlat25 = u_xlat25 / u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4.x));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4.x);
#endif
    u_xlat16_3 = (u_xlatb4) ? u_xlat25 : 1.0;
    u_xlat4.x = u_xlat21 * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16_3 * u_xlat4.x;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat4.x = u_xlat21 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat4.x) + 2.0;
    u_xlat16_10 = u_xlat16_10 * u_xlat4.x;
    u_xlat4.x = u_xlat16_10 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat4.x = u_xlat4.x + 1.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat4.x;
    u_xlat4.x = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat25 = (-u_xlat4.x) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat25);
    u_xlat3.w = u_xlat23 * u_xlat25;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * u_xlat4.xxx + u_xlat2.xyz;
    u_xlat2.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat2.x) + 2.0;
    u_xlat16_6 = u_xlat2.x * u_xlat16_6;
    u_xlat2.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat5.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat23 = u_xlat21 + (-_HeigtFogRamp2.w);
    u_xlat23 = u_xlat23 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat23 = u_xlat21 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat4.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat4.x;
    u_xlat4.x = u_xlat23 * _HeigtFogColDelta2.w;
    u_xlat23 = (u_xlatb11) ? u_xlat4.x : u_xlat23;
    u_xlat23 = log2(u_xlat23);
    u_xlat23 = u_xlat23 * _Mihoyo_FogColor2.w;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = min(u_xlat23, _HeigtFogColBase2.w);
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat2.xyz;
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat4.x = u_xlat18 * -1.44269502;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x / u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat18));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat18);
#endif
    u_xlat16_6 = (u_xlatb11) ? u_xlat4.x : 1.0;
    u_xlat4.x = u_xlat21 * _HeigtFogParams2.y;
    u_xlat21 = u_xlat21 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat4.x * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat21) + 2.0;
    u_xlat16_13 = u_xlat21 * u_xlat16_13;
    u_xlat21 = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_6 = u_xlat21 * u_xlat16_6;
    u_xlat21 = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat4.x = (-u_xlat21) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat4.w = u_xlat23 * u_xlat4.x;
    u_xlat4.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat21) + u_xlat2.xyz;
    u_xlat2 = u_xlat3 + (-u_xlat4);
    u_xlat2 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat2 + u_xlat4;
    vs_COLOR1 = u_xlat2;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    vs_TEXCOORD4.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD5.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD7 = u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingRimGlow;
uniform 	float _RGControlTexRRatio;
uniform 	float _RGControlTexGRatio;
uniform 	float _RGControlTexBRatio;
uniform 	float _RGControlTexARatio;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _ControlTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
float u_xlat18;
bool u_xlatb19;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_2.xyz = u_xlat0.xxx * _RGColor.xyz;
    u_xlat16_20 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_20 = min(max(u_xlat16_20, 0.0), 1.0);
#else
    u_xlat16_20 = clamp(u_xlat16_20, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_20 * _RGRatio;
    u_xlat16_2.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat6.xyz = texture(_Splat0Tex, vs_TEXCOORD2.xy).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexRRatio, _RGControlTexRRatio, _RGControlTexRRatio)) + u_xlat6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow));
#else
    u_xlatb19 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow);
#endif
    u_xlat16_3.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat6.xyz = texture(_Splat1Tex, vs_TEXCOORD2.zw).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexGRatio, _RGControlTexGRatio, _RGControlTexGRatio)) + u_xlat6.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat10_5 = texture(_ControlTex, vs_TEXCOORD0.xy);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_5.yyy;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_5.xxx + u_xlat16_4.xyz;
    u_xlat6.xyz = texture(_Splat2Tex, vs_TEXCOORD3.xy).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexBRatio, _RGControlTexBRatio, _RGControlTexBRatio)) + u_xlat6.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat10_5.zzz + u_xlat16_3.xyz;
    u_xlat6.xyz = texture(_Splat3Tex, vs_TEXCOORD3.zw).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_RGControlTexARatio) + u_xlat6.xyz;
    u_xlat16_2.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat16_20 = (u_xlatb19) ? u_xlat0.x : 0.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_5.www + u_xlat16_3.xyz;
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_0.www) + u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat1.x = (-_BloomFactor) + _RGBloomFactor;
    u_xlat0.w = u_xlat16_20 * u_xlat1.x + _BloomFactor;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
uniform 	mediump vec4 _ControlTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
mediump float u_xlat16_6;
mediump float u_xlat16_10;
float u_xlat11;
bool u_xlatb11;
mediump float u_xlat16_13;
float u_xlat18;
float u_xlat21;
float u_xlat23;
float u_xlat25;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _ControlTex_ST.xy + _ControlTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    vs_TEXCOORD3.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat21) + 2.0;
    u_xlat16_3 = u_xlat21 * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat5.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat23 = u_xlat21 + (-_HeigtFogRamp3.w);
    u_xlat23 = u_xlat23 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat23 = u_xlat21 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat4.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat4.x;
    u_xlat4.x = u_xlat23 * _HeigtFogColDelta3.w;
    u_xlat11 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(u_xlat21>=u_xlat11);
#else
    u_xlatb11 = u_xlat21>=u_xlat11;
#endif
    u_xlat23 = (u_xlatb11) ? u_xlat4.x : u_xlat23;
    u_xlat23 = log2(u_xlat23);
    u_xlat23 = u_xlat23 * _Mihoyo_FogColor3.w;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = min(u_xlat23, _HeigtFogColBase3.w);
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat2.xyz;
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat4.x = u_xlat5.y * _HeigtFogParams3.x;
    u_xlat18 = u_xlat5.y * _HeigtFogParams2.x;
    u_xlat25 = u_xlat4.x * -1.44269502;
    u_xlat25 = exp2(u_xlat25);
    u_xlat25 = (-u_xlat25) + 1.0;
    u_xlat25 = u_xlat25 / u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4.x));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4.x);
#endif
    u_xlat16_3 = (u_xlatb4) ? u_xlat25 : 1.0;
    u_xlat4.x = u_xlat21 * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16_3 * u_xlat4.x;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat4.x = u_xlat21 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat4.x) + 2.0;
    u_xlat16_10 = u_xlat16_10 * u_xlat4.x;
    u_xlat4.x = u_xlat16_10 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat4.x = u_xlat4.x + 1.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat4.x;
    u_xlat4.x = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat25 = (-u_xlat4.x) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat25);
    u_xlat3.w = u_xlat23 * u_xlat25;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * u_xlat4.xxx + u_xlat2.xyz;
    u_xlat2.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat2.x) + 2.0;
    u_xlat16_6 = u_xlat2.x * u_xlat16_6;
    u_xlat2.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat5.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat23 = u_xlat21 + (-_HeigtFogRamp2.w);
    u_xlat23 = u_xlat23 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat23 = u_xlat21 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat4.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat4.x;
    u_xlat4.x = u_xlat23 * _HeigtFogColDelta2.w;
    u_xlat23 = (u_xlatb11) ? u_xlat4.x : u_xlat23;
    u_xlat23 = log2(u_xlat23);
    u_xlat23 = u_xlat23 * _Mihoyo_FogColor2.w;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = min(u_xlat23, _HeigtFogColBase2.w);
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat2.xyz;
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat4.x = u_xlat18 * -1.44269502;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x / u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat18));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat18);
#endif
    u_xlat16_6 = (u_xlatb11) ? u_xlat4.x : 1.0;
    u_xlat4.x = u_xlat21 * _HeigtFogParams2.y;
    u_xlat21 = u_xlat21 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat4.x * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat21) + 2.0;
    u_xlat16_13 = u_xlat21 * u_xlat16_13;
    u_xlat21 = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_6 = u_xlat21 * u_xlat16_6;
    u_xlat21 = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat4.x = (-u_xlat21) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat4.w = u_xlat23 * u_xlat4.x;
    u_xlat4.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat21) + u_xlat2.xyz;
    u_xlat2 = u_xlat3 + (-u_xlat4);
    u_xlat2 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat2 + u_xlat4;
    vs_COLOR1 = u_xlat2;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    vs_TEXCOORD4.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD5.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD7 = u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingRimGlow;
uniform 	float _RGControlTexRRatio;
uniform 	float _RGControlTexGRatio;
uniform 	float _RGControlTexBRatio;
uniform 	float _RGControlTexARatio;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _ControlTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
float u_xlat18;
bool u_xlatb19;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_2.xyz = u_xlat0.xxx * _RGColor.xyz;
    u_xlat16_20 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_20 = min(max(u_xlat16_20, 0.0), 1.0);
#else
    u_xlat16_20 = clamp(u_xlat16_20, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_20 * _RGRatio;
    u_xlat16_2.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat6.xyz = texture(_Splat0Tex, vs_TEXCOORD2.xy).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexRRatio, _RGControlTexRRatio, _RGControlTexRRatio)) + u_xlat6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow));
#else
    u_xlatb19 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow);
#endif
    u_xlat16_3.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat6.xyz = texture(_Splat1Tex, vs_TEXCOORD2.zw).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexGRatio, _RGControlTexGRatio, _RGControlTexGRatio)) + u_xlat6.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat10_5 = texture(_ControlTex, vs_TEXCOORD0.xy);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_5.yyy;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_5.xxx + u_xlat16_4.xyz;
    u_xlat6.xyz = texture(_Splat2Tex, vs_TEXCOORD3.xy).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexBRatio, _RGControlTexBRatio, _RGControlTexBRatio)) + u_xlat6.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat10_5.zzz + u_xlat16_3.xyz;
    u_xlat6.xyz = texture(_Splat3Tex, vs_TEXCOORD3.zw).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_RGControlTexARatio) + u_xlat6.xyz;
    u_xlat16_2.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat16_20 = (u_xlatb19) ? u_xlat0.x : 0.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_5.www + u_xlat16_3.xyz;
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_0.www) + u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat1.x = (-_BloomFactor) + _RGBloomFactor;
    u_xlat0.w = u_xlat16_20 * u_xlat1.x + _BloomFactor;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
uniform 	mediump vec4 _ControlTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
mediump float u_xlat16_6;
mediump float u_xlat16_10;
float u_xlat11;
bool u_xlatb11;
mediump float u_xlat16_13;
float u_xlat18;
float u_xlat21;
float u_xlat23;
float u_xlat25;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _ControlTex_ST.xy + _ControlTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    vs_TEXCOORD3.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat21) + 2.0;
    u_xlat16_3 = u_xlat21 * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat5.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat23 = u_xlat21 + (-_HeigtFogRamp3.w);
    u_xlat23 = u_xlat23 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat23 = u_xlat21 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat4.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat4.x;
    u_xlat4.x = u_xlat23 * _HeigtFogColDelta3.w;
    u_xlat11 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(u_xlat21>=u_xlat11);
#else
    u_xlatb11 = u_xlat21>=u_xlat11;
#endif
    u_xlat23 = (u_xlatb11) ? u_xlat4.x : u_xlat23;
    u_xlat23 = log2(u_xlat23);
    u_xlat23 = u_xlat23 * _Mihoyo_FogColor3.w;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = min(u_xlat23, _HeigtFogColBase3.w);
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat2.xyz;
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat4.x = u_xlat5.y * _HeigtFogParams3.x;
    u_xlat18 = u_xlat5.y * _HeigtFogParams2.x;
    u_xlat25 = u_xlat4.x * -1.44269502;
    u_xlat25 = exp2(u_xlat25);
    u_xlat25 = (-u_xlat25) + 1.0;
    u_xlat25 = u_xlat25 / u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4.x));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4.x);
#endif
    u_xlat16_3 = (u_xlatb4) ? u_xlat25 : 1.0;
    u_xlat4.x = u_xlat21 * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16_3 * u_xlat4.x;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat4.x = u_xlat21 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat4.x) + 2.0;
    u_xlat16_10 = u_xlat16_10 * u_xlat4.x;
    u_xlat4.x = u_xlat16_10 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat4.x = u_xlat4.x + 1.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat4.x;
    u_xlat4.x = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat25 = (-u_xlat4.x) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat25);
    u_xlat3.w = u_xlat23 * u_xlat25;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * u_xlat4.xxx + u_xlat2.xyz;
    u_xlat2.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat2.x) + 2.0;
    u_xlat16_6 = u_xlat2.x * u_xlat16_6;
    u_xlat2.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat5.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat23 = u_xlat21 + (-_HeigtFogRamp2.w);
    u_xlat23 = u_xlat23 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat23 = u_xlat21 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat4.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat4.x;
    u_xlat4.x = u_xlat23 * _HeigtFogColDelta2.w;
    u_xlat23 = (u_xlatb11) ? u_xlat4.x : u_xlat23;
    u_xlat23 = log2(u_xlat23);
    u_xlat23 = u_xlat23 * _Mihoyo_FogColor2.w;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = min(u_xlat23, _HeigtFogColBase2.w);
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat2.xyz;
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat4.x = u_xlat18 * -1.44269502;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x / u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat18));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat18);
#endif
    u_xlat16_6 = (u_xlatb11) ? u_xlat4.x : 1.0;
    u_xlat4.x = u_xlat21 * _HeigtFogParams2.y;
    u_xlat21 = u_xlat21 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat4.x * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat21) + 2.0;
    u_xlat16_13 = u_xlat21 * u_xlat16_13;
    u_xlat21 = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_6 = u_xlat21 * u_xlat16_6;
    u_xlat21 = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat4.x = (-u_xlat21) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat4.w = u_xlat23 * u_xlat4.x;
    u_xlat4.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat21) + u_xlat2.xyz;
    u_xlat2 = u_xlat3 + (-u_xlat4);
    u_xlat2 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat2 + u_xlat4;
    vs_COLOR1 = u_xlat2;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    vs_TEXCOORD4.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD5.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD7 = u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingRimGlow;
uniform 	float _RGControlTexRRatio;
uniform 	float _RGControlTexGRatio;
uniform 	float _RGControlTexBRatio;
uniform 	float _RGControlTexARatio;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _ControlTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
float u_xlat18;
bool u_xlatb19;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_2.xyz = u_xlat0.xxx * _RGColor.xyz;
    u_xlat16_20 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_20 = min(max(u_xlat16_20, 0.0), 1.0);
#else
    u_xlat16_20 = clamp(u_xlat16_20, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_20 * _RGRatio;
    u_xlat16_2.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat6.xyz = texture(_Splat0Tex, vs_TEXCOORD2.xy).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexRRatio, _RGControlTexRRatio, _RGControlTexRRatio)) + u_xlat6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow));
#else
    u_xlatb19 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow);
#endif
    u_xlat16_3.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat6.xyz = texture(_Splat1Tex, vs_TEXCOORD2.zw).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexGRatio, _RGControlTexGRatio, _RGControlTexGRatio)) + u_xlat6.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat10_5 = texture(_ControlTex, vs_TEXCOORD0.xy);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_5.yyy;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_5.xxx + u_xlat16_4.xyz;
    u_xlat6.xyz = texture(_Splat2Tex, vs_TEXCOORD3.xy).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RGControlTexBRatio, _RGControlTexBRatio, _RGControlTexBRatio)) + u_xlat6.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat10_5.zzz + u_xlat16_3.xyz;
    u_xlat6.xyz = texture(_Splat3Tex, vs_TEXCOORD3.zw).xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_RGControlTexARatio) + u_xlat6.xyz;
    u_xlat16_2.xyz = (bool(u_xlatb19)) ? u_xlat1.xyz : u_xlat6.xyz;
    u_xlat16_20 = (u_xlatb19) ? u_xlat0.x : 0.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_5.www + u_xlat16_3.xyz;
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_3.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat10_0.www) + u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat1.x = (-_BloomFactor) + _RGBloomFactor;
    u_xlat0.w = u_xlat16_20 * u_xlat1.x + _BloomFactor;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
uniform 	mediump vec4 _ControlTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _ControlTex_ST.xy + _ControlTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    vs_TEXCOORD3.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat12 = u_xlat2.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat2.x);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat2.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat6);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD5.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xy = u_xlat2.zz + u_xlat2.xw;
    gl_Position = u_xlat1;
    u_xlat2.zw = u_xlat1.zw;
    vs_TEXCOORD7 = u_xlat2;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingRimGlow;
uniform 	float _RGControlTexRRatio;
uniform 	float _RGControlTexGRatio;
uniform 	float _RGControlTexBRatio;
uniform 	float _RGControlTexARatio;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform 	mediump float _ReflectionEmissionAdjust;
uniform 	mediump vec4 _FresnelParams;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _ControlTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _ReflectMaskTex;
uniform lowp sampler2D _ReflectionTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat21;
mediump float u_xlat16_22;
bool u_xlatb23;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, vs_TEXCOORD4.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.y;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x + _FresnelParams.z;
    u_xlat16_8.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_8.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_0.xyz * vec3(_ReflectionEmissionAdjust);
    u_xlat10_0.x = texture(_ReflectMaskTex, vs_TEXCOORD1.xy).x;
    u_xlat16_8.xyz = u_xlat10_0.xxx * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_8.xyz;
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat21 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_3.xyz = u_xlat0.xxx * _RGColor.xyz;
    u_xlat16_22 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_22 * _RGRatio;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat7.xyz = texture(_Splat0Tex, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexRRatio, _RGControlTexRRatio, _RGControlTexRRatio)) + u_xlat7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow));
#else
    u_xlatb23 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow);
#endif
    u_xlat16_4.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat7.xyz = texture(_Splat1Tex, vs_TEXCOORD2.zw).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexGRatio, _RGControlTexGRatio, _RGControlTexGRatio)) + u_xlat7.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat10_6 = texture(_ControlTex, vs_TEXCOORD0.xy);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat10_6.yyy;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_6.xxx + u_xlat16_5.xyz;
    u_xlat7.xyz = texture(_Splat2Tex, vs_TEXCOORD3.xy).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexBRatio, _RGControlTexBRatio, _RGControlTexBRatio)) + u_xlat7.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat16_4.xyz = u_xlat16_5.xyz * u_xlat10_6.zzz + u_xlat16_4.xyz;
    u_xlat7.xyz = texture(_Splat3Tex, vs_TEXCOORD3.zw).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_RGControlTexARatio) + u_xlat7.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat16_22 = (u_xlatb23) ? u_xlat0.x : 0.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_6.www + u_xlat16_4.xyz;
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_4.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = (-u_xlat10_0.www) + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + u_xlat16_1.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat2.x = (-_BloomFactor) + _RGBloomFactor;
    u_xlat0.w = u_xlat16_22 * u_xlat2.x + _BloomFactor;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
uniform 	mediump vec4 _ControlTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _ControlTex_ST.xy + _ControlTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    vs_TEXCOORD3.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat12 = u_xlat2.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat2.x);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat2.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat6);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD5.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xy = u_xlat2.zz + u_xlat2.xw;
    gl_Position = u_xlat1;
    u_xlat2.zw = u_xlat1.zw;
    vs_TEXCOORD7 = u_xlat2;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingRimGlow;
uniform 	float _RGControlTexRRatio;
uniform 	float _RGControlTexGRatio;
uniform 	float _RGControlTexBRatio;
uniform 	float _RGControlTexARatio;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform 	mediump float _ReflectionEmissionAdjust;
uniform 	mediump vec4 _FresnelParams;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _ControlTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _ReflectMaskTex;
uniform lowp sampler2D _ReflectionTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat21;
mediump float u_xlat16_22;
bool u_xlatb23;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, vs_TEXCOORD4.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.y;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x + _FresnelParams.z;
    u_xlat16_8.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_8.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_0.xyz * vec3(_ReflectionEmissionAdjust);
    u_xlat10_0.x = texture(_ReflectMaskTex, vs_TEXCOORD1.xy).x;
    u_xlat16_8.xyz = u_xlat10_0.xxx * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_8.xyz;
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat21 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_3.xyz = u_xlat0.xxx * _RGColor.xyz;
    u_xlat16_22 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_22 * _RGRatio;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat7.xyz = texture(_Splat0Tex, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexRRatio, _RGControlTexRRatio, _RGControlTexRRatio)) + u_xlat7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow));
#else
    u_xlatb23 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow);
#endif
    u_xlat16_4.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat7.xyz = texture(_Splat1Tex, vs_TEXCOORD2.zw).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexGRatio, _RGControlTexGRatio, _RGControlTexGRatio)) + u_xlat7.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat10_6 = texture(_ControlTex, vs_TEXCOORD0.xy);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat10_6.yyy;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_6.xxx + u_xlat16_5.xyz;
    u_xlat7.xyz = texture(_Splat2Tex, vs_TEXCOORD3.xy).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexBRatio, _RGControlTexBRatio, _RGControlTexBRatio)) + u_xlat7.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat16_4.xyz = u_xlat16_5.xyz * u_xlat10_6.zzz + u_xlat16_4.xyz;
    u_xlat7.xyz = texture(_Splat3Tex, vs_TEXCOORD3.zw).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_RGControlTexARatio) + u_xlat7.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat16_22 = (u_xlatb23) ? u_xlat0.x : 0.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_6.www + u_xlat16_4.xyz;
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_4.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = (-u_xlat10_0.www) + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + u_xlat16_1.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat2.x = (-_BloomFactor) + _RGBloomFactor;
    u_xlat0.w = u_xlat16_22 * u_xlat2.x + _BloomFactor;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
uniform 	mediump vec4 _ControlTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _ControlTex_ST.xy + _ControlTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    vs_TEXCOORD3.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat12 = u_xlat2.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat2.x);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat2.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat6);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD5.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xy = u_xlat2.zz + u_xlat2.xw;
    gl_Position = u_xlat1;
    u_xlat2.zw = u_xlat1.zw;
    vs_TEXCOORD7 = u_xlat2;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingRimGlow;
uniform 	float _RGControlTexRRatio;
uniform 	float _RGControlTexGRatio;
uniform 	float _RGControlTexBRatio;
uniform 	float _RGControlTexARatio;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform 	mediump float _ReflectionEmissionAdjust;
uniform 	mediump vec4 _FresnelParams;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _ControlTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _ReflectMaskTex;
uniform lowp sampler2D _ReflectionTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat21;
mediump float u_xlat16_22;
bool u_xlatb23;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, vs_TEXCOORD4.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.y;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x + _FresnelParams.z;
    u_xlat16_8.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_8.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_0.xyz * vec3(_ReflectionEmissionAdjust);
    u_xlat10_0.x = texture(_ReflectMaskTex, vs_TEXCOORD1.xy).x;
    u_xlat16_8.xyz = u_xlat10_0.xxx * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_8.xyz;
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat21 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_3.xyz = u_xlat0.xxx * _RGColor.xyz;
    u_xlat16_22 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_22 * _RGRatio;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat7.xyz = texture(_Splat0Tex, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexRRatio, _RGControlTexRRatio, _RGControlTexRRatio)) + u_xlat7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow));
#else
    u_xlatb23 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow);
#endif
    u_xlat16_4.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat7.xyz = texture(_Splat1Tex, vs_TEXCOORD2.zw).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexGRatio, _RGControlTexGRatio, _RGControlTexGRatio)) + u_xlat7.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat10_6 = texture(_ControlTex, vs_TEXCOORD0.xy);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat10_6.yyy;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_6.xxx + u_xlat16_5.xyz;
    u_xlat7.xyz = texture(_Splat2Tex, vs_TEXCOORD3.xy).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexBRatio, _RGControlTexBRatio, _RGControlTexBRatio)) + u_xlat7.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat16_4.xyz = u_xlat16_5.xyz * u_xlat10_6.zzz + u_xlat16_4.xyz;
    u_xlat7.xyz = texture(_Splat3Tex, vs_TEXCOORD3.zw).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_RGControlTexARatio) + u_xlat7.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat16_22 = (u_xlatb23) ? u_xlat0.x : 0.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_6.www + u_xlat16_4.xyz;
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_4.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = (-u_xlat10_0.www) + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + u_xlat16_1.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat2.x = (-_BloomFactor) + _RGBloomFactor;
    u_xlat0.w = u_xlat16_22 * u_xlat2.x + _BloomFactor;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
uniform 	mediump vec4 _ControlTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _ControlTex_ST.xy + _ControlTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    vs_TEXCOORD3.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat12 = u_xlat2.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat2.x);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat2.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat6);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD5.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xy = u_xlat2.zz + u_xlat2.xw;
    gl_Position = u_xlat1;
    u_xlat2.zw = u_xlat1.zw;
    vs_TEXCOORD7 = u_xlat2;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingRimGlow;
uniform 	float _RGControlTexRRatio;
uniform 	float _RGControlTexGRatio;
uniform 	float _RGControlTexBRatio;
uniform 	float _RGControlTexARatio;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform 	mediump float _ReflectionEmissionAdjust;
uniform 	mediump vec4 _FresnelParams;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _ControlTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _ReflectMaskTex;
uniform lowp sampler2D _ReflectionTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat21;
mediump float u_xlat16_22;
bool u_xlatb23;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, vs_TEXCOORD4.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.y;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x + _FresnelParams.z;
    u_xlat16_8.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_8.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_0.xyz * vec3(_ReflectionEmissionAdjust);
    u_xlat10_0.x = texture(_ReflectMaskTex, vs_TEXCOORD1.xy).x;
    u_xlat16_8.xyz = u_xlat10_0.xxx * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_8.xyz;
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat21 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_3.xyz = u_xlat0.xxx * _RGColor.xyz;
    u_xlat16_22 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_22 * _RGRatio;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat7.xyz = texture(_Splat0Tex, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexRRatio, _RGControlTexRRatio, _RGControlTexRRatio)) + u_xlat7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow));
#else
    u_xlatb23 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow);
#endif
    u_xlat16_4.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat7.xyz = texture(_Splat1Tex, vs_TEXCOORD2.zw).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexGRatio, _RGControlTexGRatio, _RGControlTexGRatio)) + u_xlat7.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat10_6 = texture(_ControlTex, vs_TEXCOORD0.xy);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat10_6.yyy;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_6.xxx + u_xlat16_5.xyz;
    u_xlat7.xyz = texture(_Splat2Tex, vs_TEXCOORD3.xy).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexBRatio, _RGControlTexBRatio, _RGControlTexBRatio)) + u_xlat7.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat16_4.xyz = u_xlat16_5.xyz * u_xlat10_6.zzz + u_xlat16_4.xyz;
    u_xlat7.xyz = texture(_Splat3Tex, vs_TEXCOORD3.zw).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_RGControlTexARatio) + u_xlat7.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat16_22 = (u_xlatb23) ? u_xlat0.x : 0.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_6.www + u_xlat16_4.xyz;
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_4.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = (-u_xlat10_0.www) + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + u_xlat16_1.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat2.x = (-_BloomFactor) + _RGBloomFactor;
    u_xlat0.w = u_xlat16_22 * u_xlat2.x + _BloomFactor;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
uniform 	mediump vec4 _ControlTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _ControlTex_ST.xy + _ControlTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    vs_TEXCOORD3.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat12 = u_xlat2.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat2.x);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat2.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat6);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD5.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xy = u_xlat2.zz + u_xlat2.xw;
    gl_Position = u_xlat1;
    u_xlat2.zw = u_xlat1.zw;
    vs_TEXCOORD7 = u_xlat2;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingRimGlow;
uniform 	float _RGControlTexRRatio;
uniform 	float _RGControlTexGRatio;
uniform 	float _RGControlTexBRatio;
uniform 	float _RGControlTexARatio;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform 	mediump float _ReflectionEmissionAdjust;
uniform 	mediump vec4 _FresnelParams;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _ControlTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _ReflectMaskTex;
uniform lowp sampler2D _ReflectionTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat21;
mediump float u_xlat16_22;
bool u_xlatb23;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, vs_TEXCOORD4.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.y;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x + _FresnelParams.z;
    u_xlat16_8.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_8.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_0.xyz * vec3(_ReflectionEmissionAdjust);
    u_xlat10_0.x = texture(_ReflectMaskTex, vs_TEXCOORD1.xy).x;
    u_xlat16_8.xyz = u_xlat10_0.xxx * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_8.xyz;
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat21 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_3.xyz = u_xlat0.xxx * _RGColor.xyz;
    u_xlat16_22 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_22 * _RGRatio;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat7.xyz = texture(_Splat0Tex, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexRRatio, _RGControlTexRRatio, _RGControlTexRRatio)) + u_xlat7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow));
#else
    u_xlatb23 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow);
#endif
    u_xlat16_4.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat7.xyz = texture(_Splat1Tex, vs_TEXCOORD2.zw).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexGRatio, _RGControlTexGRatio, _RGControlTexGRatio)) + u_xlat7.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat10_6 = texture(_ControlTex, vs_TEXCOORD0.xy);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat10_6.yyy;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_6.xxx + u_xlat16_5.xyz;
    u_xlat7.xyz = texture(_Splat2Tex, vs_TEXCOORD3.xy).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexBRatio, _RGControlTexBRatio, _RGControlTexBRatio)) + u_xlat7.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat16_4.xyz = u_xlat16_5.xyz * u_xlat10_6.zzz + u_xlat16_4.xyz;
    u_xlat7.xyz = texture(_Splat3Tex, vs_TEXCOORD3.zw).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_RGControlTexARatio) + u_xlat7.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat16_22 = (u_xlatb23) ? u_xlat0.x : 0.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_6.www + u_xlat16_4.xyz;
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_4.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = (-u_xlat10_0.www) + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + u_xlat16_1.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat2.x = (-_BloomFactor) + _RGBloomFactor;
    u_xlat0.w = u_xlat16_22 * u_xlat2.x + _BloomFactor;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
uniform 	mediump vec4 _ControlTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _ControlTex_ST.xy + _ControlTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    vs_TEXCOORD3.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat12 = u_xlat2.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat2.x);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat2.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat6);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD5.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xy = u_xlat2.zz + u_xlat2.xw;
    gl_Position = u_xlat1;
    u_xlat2.zw = u_xlat1.zw;
    vs_TEXCOORD7 = u_xlat2;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingRimGlow;
uniform 	float _RGControlTexRRatio;
uniform 	float _RGControlTexGRatio;
uniform 	float _RGControlTexBRatio;
uniform 	float _RGControlTexARatio;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform 	mediump float _ReflectionEmissionAdjust;
uniform 	mediump vec4 _FresnelParams;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _ControlTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _ReflectMaskTex;
uniform lowp sampler2D _ReflectionTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat21;
mediump float u_xlat16_22;
bool u_xlatb23;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, vs_TEXCOORD4.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.y;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x + _FresnelParams.z;
    u_xlat16_8.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_8.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_0.xyz * vec3(_ReflectionEmissionAdjust);
    u_xlat10_0.x = texture(_ReflectMaskTex, vs_TEXCOORD1.xy).x;
    u_xlat16_8.xyz = u_xlat10_0.xxx * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_8.xyz;
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat21 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_3.xyz = u_xlat0.xxx * _RGColor.xyz;
    u_xlat16_22 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_22 * _RGRatio;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat7.xyz = texture(_Splat0Tex, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexRRatio, _RGControlTexRRatio, _RGControlTexRRatio)) + u_xlat7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow));
#else
    u_xlatb23 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow);
#endif
    u_xlat16_4.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat7.xyz = texture(_Splat1Tex, vs_TEXCOORD2.zw).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexGRatio, _RGControlTexGRatio, _RGControlTexGRatio)) + u_xlat7.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat10_6 = texture(_ControlTex, vs_TEXCOORD0.xy);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat10_6.yyy;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_6.xxx + u_xlat16_5.xyz;
    u_xlat7.xyz = texture(_Splat2Tex, vs_TEXCOORD3.xy).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexBRatio, _RGControlTexBRatio, _RGControlTexBRatio)) + u_xlat7.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat16_4.xyz = u_xlat16_5.xyz * u_xlat10_6.zzz + u_xlat16_4.xyz;
    u_xlat7.xyz = texture(_Splat3Tex, vs_TEXCOORD3.zw).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_RGControlTexARatio) + u_xlat7.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat16_22 = (u_xlatb23) ? u_xlat0.x : 0.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_6.www + u_xlat16_4.xyz;
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_4.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = (-u_xlat10_0.www) + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + u_xlat16_1.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat2.x = (-_BloomFactor) + _RGBloomFactor;
    u_xlat0.w = u_xlat16_22 * u_xlat2.x + _BloomFactor;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
uniform 	mediump vec4 _ControlTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
mediump float u_xlat16_9;
float u_xlat10;
float u_xlat16;
float u_xlat18;
float u_xlat20;
bool u_xlatb20;
float u_xlat22;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _ControlTex_ST.xy + _ControlTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    vs_TEXCOORD3.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat18) + 2.0;
    u_xlat16_3 = u_xlat18 * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat20 = u_xlat5.y * _HeigtFogParams.x;
    u_xlat18 = sqrt(u_xlat18);
    u_xlat22 = u_xlat18 + (-_HeigtFogRamp.w);
    u_xlat22 = u_xlat22 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat4.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat18>=u_xlat4.x);
#else
    u_xlatb4 = u_xlat18>=u_xlat4.x;
#endif
    u_xlat10 = u_xlat18 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat10) + 2.0;
    u_xlat10 = u_xlat16 * u_xlat10;
    u_xlat16 = u_xlat10 * _HeigtFogColDelta.w;
    u_xlat4.x = (u_xlatb4) ? u_xlat16 : u_xlat10;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _Mihoyo_FogColor.w;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, _HeigtFogColBase.w);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat10 = u_xlat20 * -1.44269502;
    u_xlat4.y = exp2(u_xlat10);
    u_xlat4.xy = (-u_xlat4.xy) + vec2(1.0, 1.0);
    u_xlat10 = u_xlat4.y / u_xlat20;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(0.00999999978<abs(u_xlat20));
#else
    u_xlatb20 = 0.00999999978<abs(u_xlat20);
#endif
    u_xlat16_3 = (u_xlatb20) ? u_xlat10 : 1.0;
    u_xlat20 = u_xlat18 * _HeigtFogParams.y;
    u_xlat18 = u_xlat18 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat20 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_9 = (-u_xlat18) + 2.0;
    u_xlat16_9 = u_xlat18 * u_xlat16_9;
    u_xlat18 = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat18 = u_xlat18 + 1.0;
    u_xlat16_3 = u_xlat18 * u_xlat16_3;
    u_xlat18 = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat20 = (-u_xlat18) + 1.0;
    u_xlat2.xyz = vec3(u_xlat20) * u_xlat2.xyz;
    u_xlat3.w = u_xlat20 * u_xlat4.x;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat18) + u_xlat2.xyz;
    vs_COLOR1 = u_xlat3;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    vs_TEXCOORD4.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD5.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD7 = u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingRimGlow;
uniform 	float _RGControlTexRRatio;
uniform 	float _RGControlTexGRatio;
uniform 	float _RGControlTexBRatio;
uniform 	float _RGControlTexARatio;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform 	mediump float _ReflectionEmissionAdjust;
uniform 	mediump vec4 _FresnelParams;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _ControlTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _ReflectMaskTex;
uniform lowp sampler2D _ReflectionTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat21;
mediump float u_xlat16_22;
bool u_xlatb23;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, vs_TEXCOORD4.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.y;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x + _FresnelParams.z;
    u_xlat16_8.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_8.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_0.xyz * vec3(_ReflectionEmissionAdjust);
    u_xlat10_0.x = texture(_ReflectMaskTex, vs_TEXCOORD1.xy).x;
    u_xlat16_8.xyz = u_xlat10_0.xxx * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_8.xyz;
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat21 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_3.xyz = u_xlat0.xxx * _RGColor.xyz;
    u_xlat16_22 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_22 * _RGRatio;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat7.xyz = texture(_Splat0Tex, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexRRatio, _RGControlTexRRatio, _RGControlTexRRatio)) + u_xlat7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow));
#else
    u_xlatb23 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow);
#endif
    u_xlat16_4.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat7.xyz = texture(_Splat1Tex, vs_TEXCOORD2.zw).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexGRatio, _RGControlTexGRatio, _RGControlTexGRatio)) + u_xlat7.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat10_6 = texture(_ControlTex, vs_TEXCOORD0.xy);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat10_6.yyy;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_6.xxx + u_xlat16_5.xyz;
    u_xlat7.xyz = texture(_Splat2Tex, vs_TEXCOORD3.xy).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexBRatio, _RGControlTexBRatio, _RGControlTexBRatio)) + u_xlat7.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat16_4.xyz = u_xlat16_5.xyz * u_xlat10_6.zzz + u_xlat16_4.xyz;
    u_xlat7.xyz = texture(_Splat3Tex, vs_TEXCOORD3.zw).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_RGControlTexARatio) + u_xlat7.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat16_22 = (u_xlatb23) ? u_xlat0.x : 0.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_6.www + u_xlat16_4.xyz;
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_4.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = (-u_xlat10_0.www) + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + u_xlat16_1.xyz;
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_3.xxx + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat2.x = (-_BloomFactor) + _RGBloomFactor;
    u_xlat0.w = u_xlat16_22 * u_xlat2.x + _BloomFactor;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
uniform 	mediump vec4 _ControlTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
mediump float u_xlat16_9;
float u_xlat10;
float u_xlat16;
float u_xlat18;
float u_xlat20;
bool u_xlatb20;
float u_xlat22;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _ControlTex_ST.xy + _ControlTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    vs_TEXCOORD3.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat18) + 2.0;
    u_xlat16_3 = u_xlat18 * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat20 = u_xlat5.y * _HeigtFogParams.x;
    u_xlat18 = sqrt(u_xlat18);
    u_xlat22 = u_xlat18 + (-_HeigtFogRamp.w);
    u_xlat22 = u_xlat22 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat4.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat18>=u_xlat4.x);
#else
    u_xlatb4 = u_xlat18>=u_xlat4.x;
#endif
    u_xlat10 = u_xlat18 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat10) + 2.0;
    u_xlat10 = u_xlat16 * u_xlat10;
    u_xlat16 = u_xlat10 * _HeigtFogColDelta.w;
    u_xlat4.x = (u_xlatb4) ? u_xlat16 : u_xlat10;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _Mihoyo_FogColor.w;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, _HeigtFogColBase.w);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat10 = u_xlat20 * -1.44269502;
    u_xlat4.y = exp2(u_xlat10);
    u_xlat4.xy = (-u_xlat4.xy) + vec2(1.0, 1.0);
    u_xlat10 = u_xlat4.y / u_xlat20;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(0.00999999978<abs(u_xlat20));
#else
    u_xlatb20 = 0.00999999978<abs(u_xlat20);
#endif
    u_xlat16_3 = (u_xlatb20) ? u_xlat10 : 1.0;
    u_xlat20 = u_xlat18 * _HeigtFogParams.y;
    u_xlat18 = u_xlat18 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat20 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_9 = (-u_xlat18) + 2.0;
    u_xlat16_9 = u_xlat18 * u_xlat16_9;
    u_xlat18 = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat18 = u_xlat18 + 1.0;
    u_xlat16_3 = u_xlat18 * u_xlat16_3;
    u_xlat18 = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat20 = (-u_xlat18) + 1.0;
    u_xlat2.xyz = vec3(u_xlat20) * u_xlat2.xyz;
    u_xlat3.w = u_xlat20 * u_xlat4.x;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat18) + u_xlat2.xyz;
    vs_COLOR1 = u_xlat3;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    vs_TEXCOORD4.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD5.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD7 = u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingRimGlow;
uniform 	float _RGControlTexRRatio;
uniform 	float _RGControlTexGRatio;
uniform 	float _RGControlTexBRatio;
uniform 	float _RGControlTexARatio;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform 	mediump float _ReflectionEmissionAdjust;
uniform 	mediump vec4 _FresnelParams;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _ControlTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _ReflectMaskTex;
uniform lowp sampler2D _ReflectionTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat21;
mediump float u_xlat16_22;
bool u_xlatb23;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, vs_TEXCOORD4.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.y;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x + _FresnelParams.z;
    u_xlat16_8.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_8.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_0.xyz * vec3(_ReflectionEmissionAdjust);
    u_xlat10_0.x = texture(_ReflectMaskTex, vs_TEXCOORD1.xy).x;
    u_xlat16_8.xyz = u_xlat10_0.xxx * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_8.xyz;
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat21 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_3.xyz = u_xlat0.xxx * _RGColor.xyz;
    u_xlat16_22 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_22 * _RGRatio;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat7.xyz = texture(_Splat0Tex, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexRRatio, _RGControlTexRRatio, _RGControlTexRRatio)) + u_xlat7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow));
#else
    u_xlatb23 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow);
#endif
    u_xlat16_4.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat7.xyz = texture(_Splat1Tex, vs_TEXCOORD2.zw).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexGRatio, _RGControlTexGRatio, _RGControlTexGRatio)) + u_xlat7.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat10_6 = texture(_ControlTex, vs_TEXCOORD0.xy);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat10_6.yyy;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_6.xxx + u_xlat16_5.xyz;
    u_xlat7.xyz = texture(_Splat2Tex, vs_TEXCOORD3.xy).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexBRatio, _RGControlTexBRatio, _RGControlTexBRatio)) + u_xlat7.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat16_4.xyz = u_xlat16_5.xyz * u_xlat10_6.zzz + u_xlat16_4.xyz;
    u_xlat7.xyz = texture(_Splat3Tex, vs_TEXCOORD3.zw).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_RGControlTexARatio) + u_xlat7.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat16_22 = (u_xlatb23) ? u_xlat0.x : 0.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_6.www + u_xlat16_4.xyz;
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_4.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = (-u_xlat10_0.www) + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + u_xlat16_1.xyz;
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_3.xxx + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat2.x = (-_BloomFactor) + _RGBloomFactor;
    u_xlat0.w = u_xlat16_22 * u_xlat2.x + _BloomFactor;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
uniform 	mediump vec4 _ControlTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
mediump float u_xlat16_9;
float u_xlat10;
float u_xlat16;
float u_xlat18;
float u_xlat20;
bool u_xlatb20;
float u_xlat22;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _ControlTex_ST.xy + _ControlTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    vs_TEXCOORD3.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat18) + 2.0;
    u_xlat16_3 = u_xlat18 * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat20 = u_xlat5.y * _HeigtFogParams.x;
    u_xlat18 = sqrt(u_xlat18);
    u_xlat22 = u_xlat18 + (-_HeigtFogRamp.w);
    u_xlat22 = u_xlat22 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat4.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat18>=u_xlat4.x);
#else
    u_xlatb4 = u_xlat18>=u_xlat4.x;
#endif
    u_xlat10 = u_xlat18 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat10) + 2.0;
    u_xlat10 = u_xlat16 * u_xlat10;
    u_xlat16 = u_xlat10 * _HeigtFogColDelta.w;
    u_xlat4.x = (u_xlatb4) ? u_xlat16 : u_xlat10;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _Mihoyo_FogColor.w;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, _HeigtFogColBase.w);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat10 = u_xlat20 * -1.44269502;
    u_xlat4.y = exp2(u_xlat10);
    u_xlat4.xy = (-u_xlat4.xy) + vec2(1.0, 1.0);
    u_xlat10 = u_xlat4.y / u_xlat20;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(0.00999999978<abs(u_xlat20));
#else
    u_xlatb20 = 0.00999999978<abs(u_xlat20);
#endif
    u_xlat16_3 = (u_xlatb20) ? u_xlat10 : 1.0;
    u_xlat20 = u_xlat18 * _HeigtFogParams.y;
    u_xlat18 = u_xlat18 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat20 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_9 = (-u_xlat18) + 2.0;
    u_xlat16_9 = u_xlat18 * u_xlat16_9;
    u_xlat18 = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat18 = u_xlat18 + 1.0;
    u_xlat16_3 = u_xlat18 * u_xlat16_3;
    u_xlat18 = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat20 = (-u_xlat18) + 1.0;
    u_xlat2.xyz = vec3(u_xlat20) * u_xlat2.xyz;
    u_xlat3.w = u_xlat20 * u_xlat4.x;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat18) + u_xlat2.xyz;
    vs_COLOR1 = u_xlat3;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    vs_TEXCOORD4.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD5.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD7 = u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingRimGlow;
uniform 	float _RGControlTexRRatio;
uniform 	float _RGControlTexGRatio;
uniform 	float _RGControlTexBRatio;
uniform 	float _RGControlTexARatio;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform 	mediump float _ReflectionEmissionAdjust;
uniform 	mediump vec4 _FresnelParams;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _ControlTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _ReflectMaskTex;
uniform lowp sampler2D _ReflectionTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat21;
mediump float u_xlat16_22;
bool u_xlatb23;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, vs_TEXCOORD4.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.y;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x + _FresnelParams.z;
    u_xlat16_8.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_8.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_0.xyz * vec3(_ReflectionEmissionAdjust);
    u_xlat10_0.x = texture(_ReflectMaskTex, vs_TEXCOORD1.xy).x;
    u_xlat16_8.xyz = u_xlat10_0.xxx * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_8.xyz;
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat21 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_3.xyz = u_xlat0.xxx * _RGColor.xyz;
    u_xlat16_22 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_22 * _RGRatio;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat7.xyz = texture(_Splat0Tex, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexRRatio, _RGControlTexRRatio, _RGControlTexRRatio)) + u_xlat7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow));
#else
    u_xlatb23 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow);
#endif
    u_xlat16_4.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat7.xyz = texture(_Splat1Tex, vs_TEXCOORD2.zw).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexGRatio, _RGControlTexGRatio, _RGControlTexGRatio)) + u_xlat7.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat10_6 = texture(_ControlTex, vs_TEXCOORD0.xy);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat10_6.yyy;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_6.xxx + u_xlat16_5.xyz;
    u_xlat7.xyz = texture(_Splat2Tex, vs_TEXCOORD3.xy).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexBRatio, _RGControlTexBRatio, _RGControlTexBRatio)) + u_xlat7.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat16_4.xyz = u_xlat16_5.xyz * u_xlat10_6.zzz + u_xlat16_4.xyz;
    u_xlat7.xyz = texture(_Splat3Tex, vs_TEXCOORD3.zw).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_RGControlTexARatio) + u_xlat7.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat16_22 = (u_xlatb23) ? u_xlat0.x : 0.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_6.www + u_xlat16_4.xyz;
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_4.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = (-u_xlat10_0.www) + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + u_xlat16_1.xyz;
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_3.xxx + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat2.x = (-_BloomFactor) + _RGBloomFactor;
    u_xlat0.w = u_xlat16_22 * u_xlat2.x + _BloomFactor;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
uniform 	mediump vec4 _ControlTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
mediump float u_xlat16_6;
mediump float u_xlat16_10;
float u_xlat11;
bool u_xlatb11;
mediump float u_xlat16_13;
float u_xlat18;
float u_xlat21;
float u_xlat23;
float u_xlat25;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _ControlTex_ST.xy + _ControlTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    vs_TEXCOORD3.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat21) + 2.0;
    u_xlat16_3 = u_xlat21 * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat5.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat23 = u_xlat21 + (-_HeigtFogRamp3.w);
    u_xlat23 = u_xlat23 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat23 = u_xlat21 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat4.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat4.x;
    u_xlat4.x = u_xlat23 * _HeigtFogColDelta3.w;
    u_xlat11 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(u_xlat21>=u_xlat11);
#else
    u_xlatb11 = u_xlat21>=u_xlat11;
#endif
    u_xlat23 = (u_xlatb11) ? u_xlat4.x : u_xlat23;
    u_xlat23 = log2(u_xlat23);
    u_xlat23 = u_xlat23 * _Mihoyo_FogColor3.w;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = min(u_xlat23, _HeigtFogColBase3.w);
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat2.xyz;
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat4.x = u_xlat5.y * _HeigtFogParams3.x;
    u_xlat18 = u_xlat5.y * _HeigtFogParams2.x;
    u_xlat25 = u_xlat4.x * -1.44269502;
    u_xlat25 = exp2(u_xlat25);
    u_xlat25 = (-u_xlat25) + 1.0;
    u_xlat25 = u_xlat25 / u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4.x));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4.x);
#endif
    u_xlat16_3 = (u_xlatb4) ? u_xlat25 : 1.0;
    u_xlat4.x = u_xlat21 * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16_3 * u_xlat4.x;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat4.x = u_xlat21 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat4.x) + 2.0;
    u_xlat16_10 = u_xlat16_10 * u_xlat4.x;
    u_xlat4.x = u_xlat16_10 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat4.x = u_xlat4.x + 1.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat4.x;
    u_xlat4.x = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat25 = (-u_xlat4.x) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat25);
    u_xlat3.w = u_xlat23 * u_xlat25;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * u_xlat4.xxx + u_xlat2.xyz;
    u_xlat2.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat2.x) + 2.0;
    u_xlat16_6 = u_xlat2.x * u_xlat16_6;
    u_xlat2.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat5.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat23 = u_xlat21 + (-_HeigtFogRamp2.w);
    u_xlat23 = u_xlat23 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat23 = u_xlat21 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat4.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat4.x;
    u_xlat4.x = u_xlat23 * _HeigtFogColDelta2.w;
    u_xlat23 = (u_xlatb11) ? u_xlat4.x : u_xlat23;
    u_xlat23 = log2(u_xlat23);
    u_xlat23 = u_xlat23 * _Mihoyo_FogColor2.w;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = min(u_xlat23, _HeigtFogColBase2.w);
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat2.xyz;
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat4.x = u_xlat18 * -1.44269502;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x / u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat18));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat18);
#endif
    u_xlat16_6 = (u_xlatb11) ? u_xlat4.x : 1.0;
    u_xlat4.x = u_xlat21 * _HeigtFogParams2.y;
    u_xlat21 = u_xlat21 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat4.x * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat21) + 2.0;
    u_xlat16_13 = u_xlat21 * u_xlat16_13;
    u_xlat21 = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_6 = u_xlat21 * u_xlat16_6;
    u_xlat21 = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat4.x = (-u_xlat21) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat4.w = u_xlat23 * u_xlat4.x;
    u_xlat4.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat21) + u_xlat2.xyz;
    u_xlat2 = u_xlat3 + (-u_xlat4);
    u_xlat2 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat2 + u_xlat4;
    vs_COLOR1 = u_xlat2;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    vs_TEXCOORD4.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD5.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD7 = u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingRimGlow;
uniform 	float _RGControlTexRRatio;
uniform 	float _RGControlTexGRatio;
uniform 	float _RGControlTexBRatio;
uniform 	float _RGControlTexARatio;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform 	mediump float _ReflectionEmissionAdjust;
uniform 	mediump vec4 _FresnelParams;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _ControlTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _ReflectMaskTex;
uniform lowp sampler2D _ReflectionTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat21;
mediump float u_xlat16_22;
bool u_xlatb23;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, vs_TEXCOORD4.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.y;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x + _FresnelParams.z;
    u_xlat16_8.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_8.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_0.xyz * vec3(_ReflectionEmissionAdjust);
    u_xlat10_0.x = texture(_ReflectMaskTex, vs_TEXCOORD1.xy).x;
    u_xlat16_8.xyz = u_xlat10_0.xxx * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_8.xyz;
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat21 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_3.xyz = u_xlat0.xxx * _RGColor.xyz;
    u_xlat16_22 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_22 * _RGRatio;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat7.xyz = texture(_Splat0Tex, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexRRatio, _RGControlTexRRatio, _RGControlTexRRatio)) + u_xlat7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow));
#else
    u_xlatb23 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow);
#endif
    u_xlat16_4.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat7.xyz = texture(_Splat1Tex, vs_TEXCOORD2.zw).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexGRatio, _RGControlTexGRatio, _RGControlTexGRatio)) + u_xlat7.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat10_6 = texture(_ControlTex, vs_TEXCOORD0.xy);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat10_6.yyy;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_6.xxx + u_xlat16_5.xyz;
    u_xlat7.xyz = texture(_Splat2Tex, vs_TEXCOORD3.xy).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexBRatio, _RGControlTexBRatio, _RGControlTexBRatio)) + u_xlat7.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat16_4.xyz = u_xlat16_5.xyz * u_xlat10_6.zzz + u_xlat16_4.xyz;
    u_xlat7.xyz = texture(_Splat3Tex, vs_TEXCOORD3.zw).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_RGControlTexARatio) + u_xlat7.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat16_22 = (u_xlatb23) ? u_xlat0.x : 0.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_6.www + u_xlat16_4.xyz;
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_4.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = (-u_xlat10_0.www) + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + u_xlat16_1.xyz;
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_3.xxx + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat2.x = (-_BloomFactor) + _RGBloomFactor;
    u_xlat0.w = u_xlat16_22 * u_xlat2.x + _BloomFactor;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
uniform 	mediump vec4 _ControlTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
mediump float u_xlat16_6;
mediump float u_xlat16_10;
float u_xlat11;
bool u_xlatb11;
mediump float u_xlat16_13;
float u_xlat18;
float u_xlat21;
float u_xlat23;
float u_xlat25;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _ControlTex_ST.xy + _ControlTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    vs_TEXCOORD3.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat21) + 2.0;
    u_xlat16_3 = u_xlat21 * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat5.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat23 = u_xlat21 + (-_HeigtFogRamp3.w);
    u_xlat23 = u_xlat23 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat23 = u_xlat21 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat4.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat4.x;
    u_xlat4.x = u_xlat23 * _HeigtFogColDelta3.w;
    u_xlat11 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(u_xlat21>=u_xlat11);
#else
    u_xlatb11 = u_xlat21>=u_xlat11;
#endif
    u_xlat23 = (u_xlatb11) ? u_xlat4.x : u_xlat23;
    u_xlat23 = log2(u_xlat23);
    u_xlat23 = u_xlat23 * _Mihoyo_FogColor3.w;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = min(u_xlat23, _HeigtFogColBase3.w);
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat2.xyz;
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat4.x = u_xlat5.y * _HeigtFogParams3.x;
    u_xlat18 = u_xlat5.y * _HeigtFogParams2.x;
    u_xlat25 = u_xlat4.x * -1.44269502;
    u_xlat25 = exp2(u_xlat25);
    u_xlat25 = (-u_xlat25) + 1.0;
    u_xlat25 = u_xlat25 / u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4.x));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4.x);
#endif
    u_xlat16_3 = (u_xlatb4) ? u_xlat25 : 1.0;
    u_xlat4.x = u_xlat21 * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16_3 * u_xlat4.x;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat4.x = u_xlat21 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat4.x) + 2.0;
    u_xlat16_10 = u_xlat16_10 * u_xlat4.x;
    u_xlat4.x = u_xlat16_10 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat4.x = u_xlat4.x + 1.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat4.x;
    u_xlat4.x = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat25 = (-u_xlat4.x) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat25);
    u_xlat3.w = u_xlat23 * u_xlat25;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * u_xlat4.xxx + u_xlat2.xyz;
    u_xlat2.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat2.x) + 2.0;
    u_xlat16_6 = u_xlat2.x * u_xlat16_6;
    u_xlat2.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat5.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat23 = u_xlat21 + (-_HeigtFogRamp2.w);
    u_xlat23 = u_xlat23 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat23 = u_xlat21 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat4.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat4.x;
    u_xlat4.x = u_xlat23 * _HeigtFogColDelta2.w;
    u_xlat23 = (u_xlatb11) ? u_xlat4.x : u_xlat23;
    u_xlat23 = log2(u_xlat23);
    u_xlat23 = u_xlat23 * _Mihoyo_FogColor2.w;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = min(u_xlat23, _HeigtFogColBase2.w);
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat2.xyz;
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat4.x = u_xlat18 * -1.44269502;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x / u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat18));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat18);
#endif
    u_xlat16_6 = (u_xlatb11) ? u_xlat4.x : 1.0;
    u_xlat4.x = u_xlat21 * _HeigtFogParams2.y;
    u_xlat21 = u_xlat21 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat4.x * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat21) + 2.0;
    u_xlat16_13 = u_xlat21 * u_xlat16_13;
    u_xlat21 = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_6 = u_xlat21 * u_xlat16_6;
    u_xlat21 = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat4.x = (-u_xlat21) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat4.w = u_xlat23 * u_xlat4.x;
    u_xlat4.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat21) + u_xlat2.xyz;
    u_xlat2 = u_xlat3 + (-u_xlat4);
    u_xlat2 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat2 + u_xlat4;
    vs_COLOR1 = u_xlat2;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    vs_TEXCOORD4.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD5.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD7 = u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingRimGlow;
uniform 	float _RGControlTexRRatio;
uniform 	float _RGControlTexGRatio;
uniform 	float _RGControlTexBRatio;
uniform 	float _RGControlTexARatio;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform 	mediump float _ReflectionEmissionAdjust;
uniform 	mediump vec4 _FresnelParams;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _ControlTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _ReflectMaskTex;
uniform lowp sampler2D _ReflectionTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat21;
mediump float u_xlat16_22;
bool u_xlatb23;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, vs_TEXCOORD4.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.y;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x + _FresnelParams.z;
    u_xlat16_8.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_8.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_0.xyz * vec3(_ReflectionEmissionAdjust);
    u_xlat10_0.x = texture(_ReflectMaskTex, vs_TEXCOORD1.xy).x;
    u_xlat16_8.xyz = u_xlat10_0.xxx * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_8.xyz;
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat21 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_3.xyz = u_xlat0.xxx * _RGColor.xyz;
    u_xlat16_22 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_22 * _RGRatio;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat7.xyz = texture(_Splat0Tex, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexRRatio, _RGControlTexRRatio, _RGControlTexRRatio)) + u_xlat7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow));
#else
    u_xlatb23 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow);
#endif
    u_xlat16_4.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat7.xyz = texture(_Splat1Tex, vs_TEXCOORD2.zw).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexGRatio, _RGControlTexGRatio, _RGControlTexGRatio)) + u_xlat7.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat10_6 = texture(_ControlTex, vs_TEXCOORD0.xy);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat10_6.yyy;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_6.xxx + u_xlat16_5.xyz;
    u_xlat7.xyz = texture(_Splat2Tex, vs_TEXCOORD3.xy).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexBRatio, _RGControlTexBRatio, _RGControlTexBRatio)) + u_xlat7.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat16_4.xyz = u_xlat16_5.xyz * u_xlat10_6.zzz + u_xlat16_4.xyz;
    u_xlat7.xyz = texture(_Splat3Tex, vs_TEXCOORD3.zw).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_RGControlTexARatio) + u_xlat7.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat16_22 = (u_xlatb23) ? u_xlat0.x : 0.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_6.www + u_xlat16_4.xyz;
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_4.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = (-u_xlat10_0.www) + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + u_xlat16_1.xyz;
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_3.xxx + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat2.x = (-_BloomFactor) + _RGBloomFactor;
    u_xlat0.w = u_xlat16_22 * u_xlat2.x + _BloomFactor;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
uniform 	mediump vec4 _ControlTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
mediump float u_xlat16_6;
mediump float u_xlat16_10;
float u_xlat11;
bool u_xlatb11;
mediump float u_xlat16_13;
float u_xlat18;
float u_xlat21;
float u_xlat23;
float u_xlat25;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _ControlTex_ST.xy + _ControlTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    vs_TEXCOORD3.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat21) + 2.0;
    u_xlat16_3 = u_xlat21 * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat5.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat23 = u_xlat21 + (-_HeigtFogRamp3.w);
    u_xlat23 = u_xlat23 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat23 = u_xlat21 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat4.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat4.x;
    u_xlat4.x = u_xlat23 * _HeigtFogColDelta3.w;
    u_xlat11 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(u_xlat21>=u_xlat11);
#else
    u_xlatb11 = u_xlat21>=u_xlat11;
#endif
    u_xlat23 = (u_xlatb11) ? u_xlat4.x : u_xlat23;
    u_xlat23 = log2(u_xlat23);
    u_xlat23 = u_xlat23 * _Mihoyo_FogColor3.w;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = min(u_xlat23, _HeigtFogColBase3.w);
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat2.xyz;
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat4.x = u_xlat5.y * _HeigtFogParams3.x;
    u_xlat18 = u_xlat5.y * _HeigtFogParams2.x;
    u_xlat25 = u_xlat4.x * -1.44269502;
    u_xlat25 = exp2(u_xlat25);
    u_xlat25 = (-u_xlat25) + 1.0;
    u_xlat25 = u_xlat25 / u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4.x));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4.x);
#endif
    u_xlat16_3 = (u_xlatb4) ? u_xlat25 : 1.0;
    u_xlat4.x = u_xlat21 * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16_3 * u_xlat4.x;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat4.x = u_xlat21 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat4.x) + 2.0;
    u_xlat16_10 = u_xlat16_10 * u_xlat4.x;
    u_xlat4.x = u_xlat16_10 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat4.x = u_xlat4.x + 1.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat4.x;
    u_xlat4.x = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat25 = (-u_xlat4.x) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat25);
    u_xlat3.w = u_xlat23 * u_xlat25;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * u_xlat4.xxx + u_xlat2.xyz;
    u_xlat2.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat2.x) + 2.0;
    u_xlat16_6 = u_xlat2.x * u_xlat16_6;
    u_xlat2.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat5.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat23 = u_xlat21 + (-_HeigtFogRamp2.w);
    u_xlat23 = u_xlat23 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat23 = u_xlat21 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat4.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat4.x;
    u_xlat4.x = u_xlat23 * _HeigtFogColDelta2.w;
    u_xlat23 = (u_xlatb11) ? u_xlat4.x : u_xlat23;
    u_xlat23 = log2(u_xlat23);
    u_xlat23 = u_xlat23 * _Mihoyo_FogColor2.w;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = min(u_xlat23, _HeigtFogColBase2.w);
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat2.xyz;
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat4.x = u_xlat18 * -1.44269502;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x / u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat18));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat18);
#endif
    u_xlat16_6 = (u_xlatb11) ? u_xlat4.x : 1.0;
    u_xlat4.x = u_xlat21 * _HeigtFogParams2.y;
    u_xlat21 = u_xlat21 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat4.x * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat21) + 2.0;
    u_xlat16_13 = u_xlat21 * u_xlat16_13;
    u_xlat21 = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_6 = u_xlat21 * u_xlat16_6;
    u_xlat21 = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat4.x = (-u_xlat21) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat4.w = u_xlat23 * u_xlat4.x;
    u_xlat4.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat21) + u_xlat2.xyz;
    u_xlat2 = u_xlat3 + (-u_xlat4);
    u_xlat2 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat2 + u_xlat4;
    vs_COLOR1 = u_xlat2;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    vs_TEXCOORD4.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD5.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD7 = u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _UsingRimGlow;
uniform 	float _RGControlTexRRatio;
uniform 	float _RGControlTexGRatio;
uniform 	float _RGControlTexBRatio;
uniform 	float _RGControlTexARatio;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _RGBloomFactor;
uniform 	mediump float _ReflectionEmissionAdjust;
uniform 	mediump vec4 _FresnelParams;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _ControlTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _ReflectMaskTex;
uniform lowp sampler2D _ReflectionTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat21;
mediump float u_xlat16_22;
bool u_xlatb23;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, vs_TEXCOORD4.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.y;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x + _FresnelParams.z;
    u_xlat16_8.xy = vs_TEXCOORD7.xy / vs_TEXCOORD7.ww;
    u_xlat10_0.xyz = texture(_ReflectionTex, u_xlat16_8.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_0.xyz * vec3(_ReflectionEmissionAdjust);
    u_xlat10_0.x = texture(_ReflectMaskTex, vs_TEXCOORD1.xy).x;
    u_xlat16_8.xyz = u_xlat10_0.xxx * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_8.xyz;
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat21 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_3.xyz = u_xlat0.xxx * _RGColor.xyz;
    u_xlat16_22 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_22 * _RGRatio;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat7.xyz = texture(_Splat0Tex, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexRRatio, _RGControlTexRRatio, _RGControlTexRRatio)) + u_xlat7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow));
#else
    u_xlatb23 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingRimGlow);
#endif
    u_xlat16_4.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat7.xyz = texture(_Splat1Tex, vs_TEXCOORD2.zw).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexGRatio, _RGControlTexGRatio, _RGControlTexGRatio)) + u_xlat7.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat10_6 = texture(_ControlTex, vs_TEXCOORD0.xy);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat10_6.yyy;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_6.xxx + u_xlat16_5.xyz;
    u_xlat7.xyz = texture(_Splat2Tex, vs_TEXCOORD3.xy).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(vec3(_RGControlTexBRatio, _RGControlTexBRatio, _RGControlTexBRatio)) + u_xlat7.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat16_4.xyz = u_xlat16_5.xyz * u_xlat10_6.zzz + u_xlat16_4.xyz;
    u_xlat7.xyz = texture(_Splat3Tex, vs_TEXCOORD3.zw).xyz;
    u_xlat2.xyz = u_xlat16_3.xyz * vec3(_RGControlTexARatio) + u_xlat7.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb23)) ? u_xlat2.xyz : u_xlat7.xyz;
    u_xlat16_22 = (u_xlatb23) ? u_xlat0.x : 0.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_6.www + u_xlat16_4.xyz;
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_4.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = (-u_xlat10_0.www) + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + u_xlat16_1.xyz;
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_3.xxx + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat2.x = (-_BloomFactor) + _RGBloomFactor;
    u_xlat0.w = u_xlat16_22 * u_xlat2.x + _BloomFactor;
    SV_Target0 = u_xlat0;
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
Keywords { "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
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
Keywords { "FOG_LERP" "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LERP" "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LERP" "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
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
Keywords { "LUMINANCE" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
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
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
""
}
}
}
}
Fallback "Diffuse"
}