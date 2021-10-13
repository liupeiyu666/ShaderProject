//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Particles/Particle_FakeLighting" {
Properties {
[Toggle] _NormalMapToggle ("NormalMapToggle", Float) = 0
_NormalMap ("NormalMap", 2D) = "bump" { }
_NormaTexlScale ("NormaTexlScale", Range(0, 20)) = 1
_WorldNormalScale ("WorldNormalScale", Range(0, 50)) = 1
_LightingScale ("LightingScale", Range(-1, 1)) = 0
_LightColor ("LightColor", Color) = (1,1,1,0)
_DarkColor ("DarkColor", Color) = (0,0,0,0)
_ColorBrightness ("ColorBrightness", Float) = 1
_BaseTex ("BaseTex", 2D) = "white" { }
[Toggle] _MatcapToggle ("MatcapToggle", Float) = 0
_Matcap ("Matcap", 2D) = "white" { }
_MatcapSize ("MatcapSize", Range(0, 2)) = 1
_Matcap_Light ("Matcap_Light", Float) = 1
_DayColor ("DayColor", Color) = (1,1,1,1)
_texcoord ("", 2D) = "white" { }
__dirty ("", Float) = 1
[Header(Cull Mode)] [Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
[Header(Blend Mode)] [Enum(UnityEngine.Rendering.BlendMode)] _SrcBlendMode ("Src Blend Mode", Float) = 1
[Enum(UnityEngine.Rendering.BlendMode)] _DstBlendMode ("Dst Blend Mode", Float) = 0
[Enum(UnityEngine.Rendering.BlendOp)] _BlendOP ("BlendOp Mode", Float) = 0
[Header(Depth Mode)] [Enum(Off, 0, On, 1)] _Zwrite ("ZWrite Mode", Float) = 1
[Enum(UnityEngine.Rendering.CompareFunction)] _Ztest ("ZTest Mode", Float) = 4
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
 Pass {
  Name "FORWARD"
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "LIGHTMODE" = "FORWARDBASE" "PreviewType" = "Plane" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 26734
Program "vp" {
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    vs_TEXCOORD1.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat2.z;
    vs_TEXCOORD1.z = u_xlat1.y;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD2.z = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	float _ColorBrightness;
uniform 	float _MatcapToggle;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	float _NormalMapToggle;
uniform 	float _NormaTexlScale;
uniform 	float _LightingScale;
uniform 	float _WorldNormalScale;
uniform 	vec4 _BaseTex_ST;
uniform 	float _MatcapSize;
uniform 	float _Matcap_Light;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _Matcap;
uniform highp sampler2D unity_NHxRoughness;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_4;
mediump vec3 u_xlat16_5;
vec2 u_xlat6;
mediump vec3 u_xlat16_7;
float u_xlat8;
mediump float u_xlat16_8;
vec3 u_xlat11;
float u_xlat24;
mediump float u_xlat16_24;
bool u_xlatb24;
float u_xlat25;
float u_xlat26;
mediump float u_xlat16_29;
mediump float u_xlat16_31;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_24 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_24 = inversesqrt(u_xlat16_24);
    u_xlat16_1.xyz = vec3(u_xlat16_24) * _WorldSpaceLightPos0.xyz;
    u_xlat2.x = vs_TEXCOORD1.z;
    u_xlat2.y = vs_TEXCOORD2.z;
    u_xlat2.z = vs_TEXCOORD3.z;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(_NormalMapToggle==1.0);
#else
    u_xlatb24 = _NormalMapToggle==1.0;
#endif
    if(u_xlatb24){
        u_xlat10_3.xyz = texture(_NormalMap, vs_TEXCOORD0.xy).xyz;
        u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_4.xy = u_xlat16_4.xy * vec2(vec2(_NormaTexlScale, _NormaTexlScale));
        u_xlat16_5.x = dot(vs_TEXCOORD1.xyz, u_xlat16_4.xyz);
        u_xlat16_5.y = dot(vs_TEXCOORD2.xyz, u_xlat16_4.xyz);
        u_xlat16_5.z = dot(vs_TEXCOORD3.xyz, u_xlat16_4.xyz);
        u_xlat16_4.x = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
        u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
        u_xlat16_4.xyz = u_xlat16_4.xxx * u_xlat16_5.xyz;
        u_xlat4.xyz = u_xlat16_4.xyz;
    } else {
        u_xlat4.xyz = u_xlat2.xyz;
    //ENDIF
    }
    u_xlat3.xyz = u_xlat4.xyz + vec3(vec3(_LightingScale, _LightingScale, _LightingScale));
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_WorldNormalScale, _WorldNormalScale, _WorldNormalScale));
    u_xlat24 = dot(u_xlat16_1.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat1.xyz + _DarkColor.xyz;
    u_xlat6.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat10_4 = texture(_BaseTex, u_xlat6.xy);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat10_4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(_MatcapToggle==1.0);
#else
    u_xlatb24 = _MatcapToggle==1.0;
#endif
    if(u_xlatb24){
        u_xlat11.xz = u_xlat3.yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
        u_xlat3.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat3.xx + u_xlat11.xz;
        u_xlat3.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat3.zz + u_xlat3.xy;
        u_xlat3.xy = u_xlat3.xy * vec2(_MatcapSize) + vec2(1.0, 1.0);
        u_xlat3.xy = u_xlat3.xy * vec2(0.5, 0.5);
        u_xlat10_3.xyz = texture(_Matcap, u_xlat3.xy).xyz;
        u_xlat1.xyz = u_xlat10_3.xyz * vec3(vec3(_Matcap_Light, _Matcap_Light, _Matcap_Light)) + u_xlat1.xyz;
    //ENDIF
    }
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    u_xlat24 = vs_COLOR0.w * _DayColor.w;
    u_xlat24 = u_xlat10_4.w * u_xlat24;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat16_5.x = dot((-u_xlat0.xyz), u_xlat2.xyz);
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_5.x;
    u_xlat16_5.xyz = u_xlat2.xyz * (-u_xlat16_5.xxx) + (-u_xlat0.xyz);
    u_xlat10_3 = textureLod(unity_SpecCube0, u_xlat16_5.xyz, 6.0);
    u_xlat16_5.x = u_xlat10_3.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_3.xyz * u_xlat16_5.xxx;
    u_xlat25 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat26 = u_xlat25 + u_xlat25;
    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat26)) + u_xlat0.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat25 = u_xlat25;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_29 = (-u_xlat25) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_8 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_8 = u_xlat16_29 * u_xlat16_8;
    u_xlat3.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_0 = u_xlat16_29 * u_xlat16_8;
    u_xlat3.y = 1.0;
    u_xlat8 = texture(unity_NHxRoughness, u_xlat3.xy).w;
    u_xlat16_29 = u_xlat8 * 3.53466082;
    u_xlat16_7.xyz = u_xlat2.xxx * _LightColor0.xyz;
    u_xlat16_31 = u_xlat16_0 * -2.98023224e-08 + 0.220916301;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_31);
    u_xlat16_5.xyz = vec3(u_xlat16_29) * u_xlat16_7.xyz + u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat1.xyz * _DayColor.xyz + u_xlat16_5.xyz;
    SV_Target0.w = u_xlat24;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    vs_TEXCOORD1.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat2.z;
    vs_TEXCOORD1.z = u_xlat1.y;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD2.z = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	float _ColorBrightness;
uniform 	float _MatcapToggle;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	float _NormalMapToggle;
uniform 	float _NormaTexlScale;
uniform 	float _LightingScale;
uniform 	float _WorldNormalScale;
uniform 	vec4 _BaseTex_ST;
uniform 	float _MatcapSize;
uniform 	float _Matcap_Light;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _Matcap;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec4 u_xlat10_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec2 u_xlat7;
vec3 u_xlat12;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_25;
bool u_xlatb25;
mediump float u_xlat16_30;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_25 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_25 = inversesqrt(u_xlat16_25);
    u_xlat16_2.xyz = vec3(u_xlat16_25) * _WorldSpaceLightPos0.xyz;
    u_xlat3.x = vs_TEXCOORD1.z;
    u_xlat3.y = vs_TEXCOORD2.z;
    u_xlat3.z = vs_TEXCOORD3.z;
    u_xlat25 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat3.xyz = vec3(u_xlat25) * u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb25 = !!(_NormalMapToggle==1.0);
#else
    u_xlatb25 = _NormalMapToggle==1.0;
#endif
    if(u_xlatb25){
        u_xlat10_4.xyz = texture(_NormalMap, vs_TEXCOORD0.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_5.xy = u_xlat16_5.xy * vec2(vec2(_NormaTexlScale, _NormaTexlScale));
        u_xlat16_6.x = dot(vs_TEXCOORD1.xyz, u_xlat16_5.xyz);
        u_xlat16_6.y = dot(vs_TEXCOORD2.xyz, u_xlat16_5.xyz);
        u_xlat16_6.z = dot(vs_TEXCOORD3.xyz, u_xlat16_5.xyz);
        u_xlat16_5.x = dot(u_xlat16_6.xyz, u_xlat16_6.xyz);
        u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
        u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_6.xyz;
        u_xlat5.xyz = u_xlat16_5.xyz;
    } else {
        u_xlat5.xyz = u_xlat3.xyz;
    //ENDIF
    }
    u_xlat4.xyz = u_xlat5.xyz + vec3(vec3(_LightingScale, _LightingScale, _LightingScale));
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_WorldNormalScale, _WorldNormalScale, _WorldNormalScale));
    u_xlat25 = dot(u_xlat16_2.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat2.xyz = vec3(u_xlat25) * u_xlat2.xyz + _DarkColor.xyz;
    u_xlat7.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat10_5 = texture(_BaseTex, u_xlat7.xy);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat10_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb25 = !!(_MatcapToggle==1.0);
#else
    u_xlatb25 = _MatcapToggle==1.0;
#endif
    if(u_xlatb25){
        u_xlat12.xz = u_xlat4.yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
        u_xlat4.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat4.xx + u_xlat12.xz;
        u_xlat4.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat4.zz + u_xlat4.xy;
        u_xlat4.xy = u_xlat4.xy * vec2(_MatcapSize) + vec2(1.0, 1.0);
        u_xlat4.xy = u_xlat4.xy * vec2(0.5, 0.5);
        u_xlat10_4.xyz = texture(_Matcap, u_xlat4.xy).xyz;
        u_xlat2.xyz = u_xlat10_4.xyz * vec3(vec3(_Matcap_Light, _Matcap_Light, _Matcap_Light)) + u_xlat2.xyz;
    //ENDIF
    }
    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorBrightness);
    u_xlat2.xyz = u_xlat2.xyz * vs_COLOR0.xyz;
    u_xlat25 = vs_COLOR0.w * _DayColor.w;
    u_xlat25 = u_xlat10_5.w * u_xlat25;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat16_6.x = dot((-u_xlat1.xyz), u_xlat3.xyz);
    u_xlat16_6.x = u_xlat16_6.x + u_xlat16_6.x;
    u_xlat16_6.xyz = u_xlat3.xyz * (-u_xlat16_6.xxx) + (-u_xlat1.xyz);
    u_xlat10_4 = textureLod(unity_SpecCube0, u_xlat16_6.xyz, 6.0);
    u_xlat16_6.x = u_xlat10_4.w + -1.0;
    u_xlat16_6.x = unity_SpecCube0_HDR.w * u_xlat16_6.x + 1.0;
    u_xlat16_6.x = u_xlat16_6.x * unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat10_4.xyz * u_xlat16_6.xxx;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = max(u_xlat24, 0.00100000005);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = max(u_xlat0.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * 2.50002503;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = u_xlat0.x * 0.220916301;
    u_xlat0.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(0.720000029, 0.720000029, 0.720000029);
    u_xlat16_30 = (-u_xlat1.x) + 1.0;
    u_xlat16_30 = u_xlat16_30 * u_xlat16_30;
    u_xlat16_30 = u_xlat16_30 * u_xlat16_30;
    u_xlat16_30 = u_xlat16_30 * -2.98023224e-08 + 0.220916301;
    u_xlat16_6.xyz = vec3(u_xlat16_30) * u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat2.xyz * _DayColor.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat25;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    vs_TEXCOORD1.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat2.z;
    vs_TEXCOORD1.z = u_xlat1.y;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD2.z = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	float _ColorBrightness;
uniform 	float _MatcapToggle;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	float _NormalMapToggle;
uniform 	float _NormaTexlScale;
uniform 	float _LightingScale;
uniform 	float _WorldNormalScale;
uniform 	vec4 _BaseTex_ST;
uniform 	float _MatcapSize;
uniform 	float _Matcap_Light;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _Matcap;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec4 u_xlat10_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec2 u_xlat7;
vec3 u_xlat12;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_25;
bool u_xlatb25;
mediump float u_xlat16_30;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_25 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_25 = inversesqrt(u_xlat16_25);
    u_xlat16_2.xyz = vec3(u_xlat16_25) * _WorldSpaceLightPos0.xyz;
    u_xlat3.x = vs_TEXCOORD1.z;
    u_xlat3.y = vs_TEXCOORD2.z;
    u_xlat3.z = vs_TEXCOORD3.z;
    u_xlat25 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat3.xyz = vec3(u_xlat25) * u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb25 = !!(_NormalMapToggle==1.0);
#else
    u_xlatb25 = _NormalMapToggle==1.0;
#endif
    if(u_xlatb25){
        u_xlat10_4.xyz = texture(_NormalMap, vs_TEXCOORD0.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_5.xy = u_xlat16_5.xy * vec2(vec2(_NormaTexlScale, _NormaTexlScale));
        u_xlat16_6.x = dot(vs_TEXCOORD1.xyz, u_xlat16_5.xyz);
        u_xlat16_6.y = dot(vs_TEXCOORD2.xyz, u_xlat16_5.xyz);
        u_xlat16_6.z = dot(vs_TEXCOORD3.xyz, u_xlat16_5.xyz);
        u_xlat16_5.x = dot(u_xlat16_6.xyz, u_xlat16_6.xyz);
        u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
        u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_6.xyz;
        u_xlat5.xyz = u_xlat16_5.xyz;
    } else {
        u_xlat5.xyz = u_xlat3.xyz;
    //ENDIF
    }
    u_xlat4.xyz = u_xlat5.xyz + vec3(vec3(_LightingScale, _LightingScale, _LightingScale));
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_WorldNormalScale, _WorldNormalScale, _WorldNormalScale));
    u_xlat25 = dot(u_xlat16_2.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat2.xyz = vec3(u_xlat25) * u_xlat2.xyz + _DarkColor.xyz;
    u_xlat7.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat10_5 = texture(_BaseTex, u_xlat7.xy);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat10_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb25 = !!(_MatcapToggle==1.0);
#else
    u_xlatb25 = _MatcapToggle==1.0;
#endif
    if(u_xlatb25){
        u_xlat12.xz = u_xlat4.yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
        u_xlat4.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat4.xx + u_xlat12.xz;
        u_xlat4.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat4.zz + u_xlat4.xy;
        u_xlat4.xy = u_xlat4.xy * vec2(_MatcapSize) + vec2(1.0, 1.0);
        u_xlat4.xy = u_xlat4.xy * vec2(0.5, 0.5);
        u_xlat10_4.xyz = texture(_Matcap, u_xlat4.xy).xyz;
        u_xlat2.xyz = u_xlat10_4.xyz * vec3(vec3(_Matcap_Light, _Matcap_Light, _Matcap_Light)) + u_xlat2.xyz;
    //ENDIF
    }
    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorBrightness);
    u_xlat2.xyz = u_xlat2.xyz * vs_COLOR0.xyz;
    u_xlat25 = vs_COLOR0.w * _DayColor.w;
    u_xlat25 = u_xlat10_5.w * u_xlat25;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat16_6.x = dot((-u_xlat1.xyz), u_xlat3.xyz);
    u_xlat16_6.x = u_xlat16_6.x + u_xlat16_6.x;
    u_xlat16_6.xyz = u_xlat3.xyz * (-u_xlat16_6.xxx) + (-u_xlat1.xyz);
    u_xlat10_4 = textureLod(unity_SpecCube0, u_xlat16_6.xyz, 6.0);
    u_xlat16_6.x = u_xlat10_4.w + -1.0;
    u_xlat16_6.x = unity_SpecCube0_HDR.w * u_xlat16_6.x + 1.0;
    u_xlat16_6.x = u_xlat16_6.x * unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat10_4.xyz * u_xlat16_6.xxx;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = max(u_xlat24, 0.00100000005);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = max(u_xlat0.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * 2.50002503;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = u_xlat0.x * 0.220916301;
    u_xlat0.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(0.720000029, 0.720000029, 0.720000029);
    u_xlat16_30 = (-u_xlat1.x) + 1.0;
    u_xlat16_30 = u_xlat16_30 * u_xlat16_30;
    u_xlat16_30 = u_xlat16_30 * u_xlat16_30;
    u_xlat16_30 = u_xlat16_30 * -2.98023224e-08 + 0.220916301;
    u_xlat16_6.xyz = vec3(u_xlat16_30) * u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat2.xyz * _DayColor.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat25;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    vs_TEXCOORD1.w = u_xlat0.x;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD1.x = u_xlat1.z;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = u_xlat2.ywx * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.z = u_xlat2.x;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat1.y;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_TEXCOORD2.z = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat2.w;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_4 = u_xlat2.y * u_xlat2.y;
    u_xlat16_4 = u_xlat2.x * u_xlat2.x + (-u_xlat16_4);
    u_xlat16_0 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_4) + u_xlat16_5.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	float _ColorBrightness;
uniform 	float _MatcapToggle;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	float _NormalMapToggle;
uniform 	float _NormaTexlScale;
uniform 	float _LightingScale;
uniform 	float _WorldNormalScale;
uniform 	vec4 _BaseTex_ST;
uniform 	float _MatcapSize;
uniform 	float _Matcap_Light;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _Matcap;
uniform highp sampler2D unity_NHxRoughness;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_4;
mediump vec3 u_xlat16_5;
vec2 u_xlat6;
mediump vec3 u_xlat16_7;
float u_xlat8;
mediump float u_xlat16_8;
vec3 u_xlat11;
float u_xlat24;
mediump float u_xlat16_24;
bool u_xlatb24;
float u_xlat25;
float u_xlat26;
mediump float u_xlat16_29;
mediump float u_xlat16_31;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_24 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_24 = inversesqrt(u_xlat16_24);
    u_xlat16_1.xyz = vec3(u_xlat16_24) * _WorldSpaceLightPos0.xyz;
    u_xlat2.x = vs_TEXCOORD1.z;
    u_xlat2.y = vs_TEXCOORD2.z;
    u_xlat2.z = vs_TEXCOORD3.z;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(_NormalMapToggle==1.0);
#else
    u_xlatb24 = _NormalMapToggle==1.0;
#endif
    if(u_xlatb24){
        u_xlat10_3.xyz = texture(_NormalMap, vs_TEXCOORD0.xy).xyz;
        u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_4.xy = u_xlat16_4.xy * vec2(vec2(_NormaTexlScale, _NormaTexlScale));
        u_xlat16_5.x = dot(vs_TEXCOORD1.xyz, u_xlat16_4.xyz);
        u_xlat16_5.y = dot(vs_TEXCOORD2.xyz, u_xlat16_4.xyz);
        u_xlat16_5.z = dot(vs_TEXCOORD3.xyz, u_xlat16_4.xyz);
        u_xlat16_4.x = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
        u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
        u_xlat16_4.xyz = u_xlat16_4.xxx * u_xlat16_5.xyz;
        u_xlat4.xyz = u_xlat16_4.xyz;
    } else {
        u_xlat4.xyz = u_xlat2.xyz;
    //ENDIF
    }
    u_xlat3.xyz = u_xlat4.xyz + vec3(vec3(_LightingScale, _LightingScale, _LightingScale));
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_WorldNormalScale, _WorldNormalScale, _WorldNormalScale));
    u_xlat24 = dot(u_xlat16_1.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat1.xyz + _DarkColor.xyz;
    u_xlat6.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat10_4 = texture(_BaseTex, u_xlat6.xy);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat10_4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(_MatcapToggle==1.0);
#else
    u_xlatb24 = _MatcapToggle==1.0;
#endif
    if(u_xlatb24){
        u_xlat11.xz = u_xlat3.yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
        u_xlat3.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat3.xx + u_xlat11.xz;
        u_xlat3.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat3.zz + u_xlat3.xy;
        u_xlat3.xy = u_xlat3.xy * vec2(_MatcapSize) + vec2(1.0, 1.0);
        u_xlat3.xy = u_xlat3.xy * vec2(0.5, 0.5);
        u_xlat10_3.xyz = texture(_Matcap, u_xlat3.xy).xyz;
        u_xlat1.xyz = u_xlat10_3.xyz * vec3(vec3(_Matcap_Light, _Matcap_Light, _Matcap_Light)) + u_xlat1.xyz;
    //ENDIF
    }
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    u_xlat24 = vs_COLOR0.w * _DayColor.w;
    u_xlat24 = u_xlat10_4.w * u_xlat24;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat16_5.x = dot((-u_xlat0.xyz), u_xlat2.xyz);
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_5.x;
    u_xlat16_5.xyz = u_xlat2.xyz * (-u_xlat16_5.xxx) + (-u_xlat0.xyz);
    u_xlat10_3 = textureLod(unity_SpecCube0, u_xlat16_5.xyz, 6.0);
    u_xlat16_5.x = u_xlat10_3.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_3.xyz * u_xlat16_5.xxx;
    u_xlat25 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat26 = u_xlat25 + u_xlat25;
    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat26)) + u_xlat0.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat25 = u_xlat25;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_29 = (-u_xlat25) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_8 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_8 = u_xlat16_29 * u_xlat16_8;
    u_xlat3.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_0 = u_xlat16_29 * u_xlat16_8;
    u_xlat3.y = 1.0;
    u_xlat8 = texture(unity_NHxRoughness, u_xlat3.xy).w;
    u_xlat16_29 = u_xlat8 * 3.53466082;
    u_xlat16_7.xyz = u_xlat2.xxx * _LightColor0.xyz;
    u_xlat16_31 = u_xlat16_0 * -2.98023224e-08 + 0.220916301;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_31);
    u_xlat16_5.xyz = vec3(u_xlat16_29) * u_xlat16_7.xyz + u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat1.xyz * _DayColor.xyz + u_xlat16_5.xyz;
    SV_Target0.w = u_xlat24;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    vs_TEXCOORD1.w = u_xlat0.x;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD1.x = u_xlat1.z;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = u_xlat2.ywx * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.z = u_xlat2.x;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat1.y;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_TEXCOORD2.z = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat2.w;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_4 = u_xlat2.y * u_xlat2.y;
    u_xlat16_4 = u_xlat2.x * u_xlat2.x + (-u_xlat16_4);
    u_xlat16_0 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_4) + u_xlat16_5.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	float _ColorBrightness;
uniform 	float _MatcapToggle;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	float _NormalMapToggle;
uniform 	float _NormaTexlScale;
uniform 	float _LightingScale;
uniform 	float _WorldNormalScale;
uniform 	vec4 _BaseTex_ST;
uniform 	float _MatcapSize;
uniform 	float _Matcap_Light;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _Matcap;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec4 u_xlat10_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec2 u_xlat7;
vec3 u_xlat12;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_25;
bool u_xlatb25;
mediump float u_xlat16_30;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_25 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_25 = inversesqrt(u_xlat16_25);
    u_xlat16_2.xyz = vec3(u_xlat16_25) * _WorldSpaceLightPos0.xyz;
    u_xlat3.x = vs_TEXCOORD1.z;
    u_xlat3.y = vs_TEXCOORD2.z;
    u_xlat3.z = vs_TEXCOORD3.z;
    u_xlat25 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat3.xyz = vec3(u_xlat25) * u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb25 = !!(_NormalMapToggle==1.0);
#else
    u_xlatb25 = _NormalMapToggle==1.0;
#endif
    if(u_xlatb25){
        u_xlat10_4.xyz = texture(_NormalMap, vs_TEXCOORD0.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_5.xy = u_xlat16_5.xy * vec2(vec2(_NormaTexlScale, _NormaTexlScale));
        u_xlat16_6.x = dot(vs_TEXCOORD1.xyz, u_xlat16_5.xyz);
        u_xlat16_6.y = dot(vs_TEXCOORD2.xyz, u_xlat16_5.xyz);
        u_xlat16_6.z = dot(vs_TEXCOORD3.xyz, u_xlat16_5.xyz);
        u_xlat16_5.x = dot(u_xlat16_6.xyz, u_xlat16_6.xyz);
        u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
        u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_6.xyz;
        u_xlat5.xyz = u_xlat16_5.xyz;
    } else {
        u_xlat5.xyz = u_xlat3.xyz;
    //ENDIF
    }
    u_xlat4.xyz = u_xlat5.xyz + vec3(vec3(_LightingScale, _LightingScale, _LightingScale));
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_WorldNormalScale, _WorldNormalScale, _WorldNormalScale));
    u_xlat25 = dot(u_xlat16_2.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat2.xyz = vec3(u_xlat25) * u_xlat2.xyz + _DarkColor.xyz;
    u_xlat7.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat10_5 = texture(_BaseTex, u_xlat7.xy);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat10_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb25 = !!(_MatcapToggle==1.0);
#else
    u_xlatb25 = _MatcapToggle==1.0;
#endif
    if(u_xlatb25){
        u_xlat12.xz = u_xlat4.yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
        u_xlat4.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat4.xx + u_xlat12.xz;
        u_xlat4.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat4.zz + u_xlat4.xy;
        u_xlat4.xy = u_xlat4.xy * vec2(_MatcapSize) + vec2(1.0, 1.0);
        u_xlat4.xy = u_xlat4.xy * vec2(0.5, 0.5);
        u_xlat10_4.xyz = texture(_Matcap, u_xlat4.xy).xyz;
        u_xlat2.xyz = u_xlat10_4.xyz * vec3(vec3(_Matcap_Light, _Matcap_Light, _Matcap_Light)) + u_xlat2.xyz;
    //ENDIF
    }
    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorBrightness);
    u_xlat2.xyz = u_xlat2.xyz * vs_COLOR0.xyz;
    u_xlat25 = vs_COLOR0.w * _DayColor.w;
    u_xlat25 = u_xlat10_5.w * u_xlat25;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat16_6.x = dot((-u_xlat1.xyz), u_xlat3.xyz);
    u_xlat16_6.x = u_xlat16_6.x + u_xlat16_6.x;
    u_xlat16_6.xyz = u_xlat3.xyz * (-u_xlat16_6.xxx) + (-u_xlat1.xyz);
    u_xlat10_4 = textureLod(unity_SpecCube0, u_xlat16_6.xyz, 6.0);
    u_xlat16_6.x = u_xlat10_4.w + -1.0;
    u_xlat16_6.x = unity_SpecCube0_HDR.w * u_xlat16_6.x + 1.0;
    u_xlat16_6.x = u_xlat16_6.x * unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat10_4.xyz * u_xlat16_6.xxx;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = max(u_xlat24, 0.00100000005);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = max(u_xlat0.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * 2.50002503;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = u_xlat0.x * 0.220916301;
    u_xlat0.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(0.720000029, 0.720000029, 0.720000029);
    u_xlat16_30 = (-u_xlat1.x) + 1.0;
    u_xlat16_30 = u_xlat16_30 * u_xlat16_30;
    u_xlat16_30 = u_xlat16_30 * u_xlat16_30;
    u_xlat16_30 = u_xlat16_30 * -2.98023224e-08 + 0.220916301;
    u_xlat16_6.xyz = vec3(u_xlat16_30) * u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat2.xyz * _DayColor.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat25;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    vs_TEXCOORD1.w = u_xlat0.x;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD1.x = u_xlat1.z;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = u_xlat2.ywx * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.z = u_xlat2.x;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat1.y;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_TEXCOORD2.z = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat2.w;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_4 = u_xlat2.y * u_xlat2.y;
    u_xlat16_4 = u_xlat2.x * u_xlat2.x + (-u_xlat16_4);
    u_xlat16_0 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_4) + u_xlat16_5.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	float _ColorBrightness;
uniform 	float _MatcapToggle;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	float _NormalMapToggle;
uniform 	float _NormaTexlScale;
uniform 	float _LightingScale;
uniform 	float _WorldNormalScale;
uniform 	vec4 _BaseTex_ST;
uniform 	float _MatcapSize;
uniform 	float _Matcap_Light;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _Matcap;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec4 u_xlat10_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec2 u_xlat7;
vec3 u_xlat12;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_25;
bool u_xlatb25;
mediump float u_xlat16_30;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_25 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_25 = inversesqrt(u_xlat16_25);
    u_xlat16_2.xyz = vec3(u_xlat16_25) * _WorldSpaceLightPos0.xyz;
    u_xlat3.x = vs_TEXCOORD1.z;
    u_xlat3.y = vs_TEXCOORD2.z;
    u_xlat3.z = vs_TEXCOORD3.z;
    u_xlat25 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat3.xyz = vec3(u_xlat25) * u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb25 = !!(_NormalMapToggle==1.0);
#else
    u_xlatb25 = _NormalMapToggle==1.0;
#endif
    if(u_xlatb25){
        u_xlat10_4.xyz = texture(_NormalMap, vs_TEXCOORD0.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_5.xy = u_xlat16_5.xy * vec2(vec2(_NormaTexlScale, _NormaTexlScale));
        u_xlat16_6.x = dot(vs_TEXCOORD1.xyz, u_xlat16_5.xyz);
        u_xlat16_6.y = dot(vs_TEXCOORD2.xyz, u_xlat16_5.xyz);
        u_xlat16_6.z = dot(vs_TEXCOORD3.xyz, u_xlat16_5.xyz);
        u_xlat16_5.x = dot(u_xlat16_6.xyz, u_xlat16_6.xyz);
        u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
        u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_6.xyz;
        u_xlat5.xyz = u_xlat16_5.xyz;
    } else {
        u_xlat5.xyz = u_xlat3.xyz;
    //ENDIF
    }
    u_xlat4.xyz = u_xlat5.xyz + vec3(vec3(_LightingScale, _LightingScale, _LightingScale));
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_WorldNormalScale, _WorldNormalScale, _WorldNormalScale));
    u_xlat25 = dot(u_xlat16_2.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat2.xyz = vec3(u_xlat25) * u_xlat2.xyz + _DarkColor.xyz;
    u_xlat7.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat10_5 = texture(_BaseTex, u_xlat7.xy);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat10_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb25 = !!(_MatcapToggle==1.0);
#else
    u_xlatb25 = _MatcapToggle==1.0;
#endif
    if(u_xlatb25){
        u_xlat12.xz = u_xlat4.yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
        u_xlat4.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat4.xx + u_xlat12.xz;
        u_xlat4.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat4.zz + u_xlat4.xy;
        u_xlat4.xy = u_xlat4.xy * vec2(_MatcapSize) + vec2(1.0, 1.0);
        u_xlat4.xy = u_xlat4.xy * vec2(0.5, 0.5);
        u_xlat10_4.xyz = texture(_Matcap, u_xlat4.xy).xyz;
        u_xlat2.xyz = u_xlat10_4.xyz * vec3(vec3(_Matcap_Light, _Matcap_Light, _Matcap_Light)) + u_xlat2.xyz;
    //ENDIF
    }
    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorBrightness);
    u_xlat2.xyz = u_xlat2.xyz * vs_COLOR0.xyz;
    u_xlat25 = vs_COLOR0.w * _DayColor.w;
    u_xlat25 = u_xlat10_5.w * u_xlat25;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat16_6.x = dot((-u_xlat1.xyz), u_xlat3.xyz);
    u_xlat16_6.x = u_xlat16_6.x + u_xlat16_6.x;
    u_xlat16_6.xyz = u_xlat3.xyz * (-u_xlat16_6.xxx) + (-u_xlat1.xyz);
    u_xlat10_4 = textureLod(unity_SpecCube0, u_xlat16_6.xyz, 6.0);
    u_xlat16_6.x = u_xlat10_4.w + -1.0;
    u_xlat16_6.x = unity_SpecCube0_HDR.w * u_xlat16_6.x + 1.0;
    u_xlat16_6.x = u_xlat16_6.x * unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat10_4.xyz * u_xlat16_6.xxx;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = max(u_xlat24, 0.00100000005);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = max(u_xlat0.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * 2.50002503;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = u_xlat0.x * 0.220916301;
    u_xlat0.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(0.720000029, 0.720000029, 0.720000029);
    u_xlat16_30 = (-u_xlat1.x) + 1.0;
    u_xlat16_30 = u_xlat16_30 * u_xlat16_30;
    u_xlat16_30 = u_xlat16_30 * u_xlat16_30;
    u_xlat16_30 = u_xlat16_30 * -2.98023224e-08 + 0.220916301;
    u_xlat16_6.xyz = vec3(u_xlat16_30) * u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat2.xyz * _DayColor.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat25;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat13;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat2.xyz = vec3(u_xlat0) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat0) * u_xlat3.xyz;
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat2.z;
    vs_TEXCOORD1.z = u_xlat1.y;
    vs_TEXCOORD1.w = u_xlat4.x;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD2.z = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD2.w = u_xlat4.y;
    vs_TEXCOORD3.w = u_xlat4.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	float _ColorBrightness;
uniform 	float _MatcapToggle;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	float _NormalMapToggle;
uniform 	float _NormaTexlScale;
uniform 	float _LightingScale;
uniform 	float _WorldNormalScale;
uniform 	vec4 _BaseTex_ST;
uniform 	float _MatcapSize;
uniform 	float _Matcap_Light;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _Matcap;
uniform highp sampler2D unity_NHxRoughness;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_4;
mediump vec3 u_xlat16_5;
vec2 u_xlat6;
mediump vec3 u_xlat16_7;
float u_xlat8;
mediump float u_xlat16_8;
vec3 u_xlat11;
float u_xlat24;
mediump float u_xlat16_24;
bool u_xlatb24;
float u_xlat25;
float u_xlat26;
mediump float u_xlat16_29;
mediump float u_xlat16_31;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_24 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_24 = inversesqrt(u_xlat16_24);
    u_xlat16_1.xyz = vec3(u_xlat16_24) * _WorldSpaceLightPos0.xyz;
    u_xlat2.x = vs_TEXCOORD1.z;
    u_xlat2.y = vs_TEXCOORD2.z;
    u_xlat2.z = vs_TEXCOORD3.z;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(_NormalMapToggle==1.0);
#else
    u_xlatb24 = _NormalMapToggle==1.0;
#endif
    if(u_xlatb24){
        u_xlat10_3.xyz = texture(_NormalMap, vs_TEXCOORD0.xy).xyz;
        u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_4.xy = u_xlat16_4.xy * vec2(vec2(_NormaTexlScale, _NormaTexlScale));
        u_xlat16_5.x = dot(vs_TEXCOORD1.xyz, u_xlat16_4.xyz);
        u_xlat16_5.y = dot(vs_TEXCOORD2.xyz, u_xlat16_4.xyz);
        u_xlat16_5.z = dot(vs_TEXCOORD3.xyz, u_xlat16_4.xyz);
        u_xlat16_4.x = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
        u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
        u_xlat16_4.xyz = u_xlat16_4.xxx * u_xlat16_5.xyz;
        u_xlat4.xyz = u_xlat16_4.xyz;
    } else {
        u_xlat4.xyz = u_xlat2.xyz;
    //ENDIF
    }
    u_xlat3.xyz = u_xlat4.xyz + vec3(vec3(_LightingScale, _LightingScale, _LightingScale));
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_WorldNormalScale, _WorldNormalScale, _WorldNormalScale));
    u_xlat24 = dot(u_xlat16_1.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat1.xyz + _DarkColor.xyz;
    u_xlat6.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat10_4 = texture(_BaseTex, u_xlat6.xy);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat10_4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(_MatcapToggle==1.0);
#else
    u_xlatb24 = _MatcapToggle==1.0;
#endif
    if(u_xlatb24){
        u_xlat11.xz = u_xlat3.yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
        u_xlat3.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat3.xx + u_xlat11.xz;
        u_xlat3.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat3.zz + u_xlat3.xy;
        u_xlat3.xy = u_xlat3.xy * vec2(_MatcapSize) + vec2(1.0, 1.0);
        u_xlat3.xy = u_xlat3.xy * vec2(0.5, 0.5);
        u_xlat10_3.xyz = texture(_Matcap, u_xlat3.xy).xyz;
        u_xlat1.xyz = u_xlat10_3.xyz * vec3(vec3(_Matcap_Light, _Matcap_Light, _Matcap_Light)) + u_xlat1.xyz;
    //ENDIF
    }
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    u_xlat24 = vs_COLOR0.w * _DayColor.w;
    u_xlat24 = u_xlat10_4.w * u_xlat24;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat16_5.x = dot((-u_xlat0.xyz), u_xlat2.xyz);
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_5.x;
    u_xlat16_5.xyz = u_xlat2.xyz * (-u_xlat16_5.xxx) + (-u_xlat0.xyz);
    u_xlat10_3 = textureLod(unity_SpecCube0, u_xlat16_5.xyz, 6.0);
    u_xlat16_5.x = u_xlat10_3.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_3.xyz * u_xlat16_5.xxx;
    u_xlat25 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat26 = u_xlat25 + u_xlat25;
    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat26)) + u_xlat0.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat25 = u_xlat25;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_29 = (-u_xlat25) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_8 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_8 = u_xlat16_29 * u_xlat16_8;
    u_xlat3.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_0 = u_xlat16_29 * u_xlat16_8;
    u_xlat3.y = 1.0;
    u_xlat8 = texture(unity_NHxRoughness, u_xlat3.xy).w;
    u_xlat16_29 = u_xlat8 * 3.53466082;
    u_xlat16_7.xyz = u_xlat2.xxx * _LightColor0.xyz;
    u_xlat16_31 = u_xlat16_0 * -2.98023224e-08 + 0.220916301;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_31);
    u_xlat16_5.xyz = vec3(u_xlat16_29) * u_xlat16_7.xyz + u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat1.xyz * _DayColor.xyz + u_xlat16_5.xyz;
    SV_Target0.w = u_xlat24;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat13;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat2.xyz = vec3(u_xlat0) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat0) * u_xlat3.xyz;
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat2.z;
    vs_TEXCOORD1.z = u_xlat1.y;
    vs_TEXCOORD1.w = u_xlat4.x;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD2.z = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD2.w = u_xlat4.y;
    vs_TEXCOORD3.w = u_xlat4.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	float _ColorBrightness;
uniform 	float _MatcapToggle;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	float _NormalMapToggle;
uniform 	float _NormaTexlScale;
uniform 	float _LightingScale;
uniform 	float _WorldNormalScale;
uniform 	vec4 _BaseTex_ST;
uniform 	float _MatcapSize;
uniform 	float _Matcap_Light;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _Matcap;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec4 u_xlat10_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec2 u_xlat7;
vec3 u_xlat12;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_25;
bool u_xlatb25;
mediump float u_xlat16_30;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_25 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_25 = inversesqrt(u_xlat16_25);
    u_xlat16_2.xyz = vec3(u_xlat16_25) * _WorldSpaceLightPos0.xyz;
    u_xlat3.x = vs_TEXCOORD1.z;
    u_xlat3.y = vs_TEXCOORD2.z;
    u_xlat3.z = vs_TEXCOORD3.z;
    u_xlat25 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat3.xyz = vec3(u_xlat25) * u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb25 = !!(_NormalMapToggle==1.0);
#else
    u_xlatb25 = _NormalMapToggle==1.0;
#endif
    if(u_xlatb25){
        u_xlat10_4.xyz = texture(_NormalMap, vs_TEXCOORD0.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_5.xy = u_xlat16_5.xy * vec2(vec2(_NormaTexlScale, _NormaTexlScale));
        u_xlat16_6.x = dot(vs_TEXCOORD1.xyz, u_xlat16_5.xyz);
        u_xlat16_6.y = dot(vs_TEXCOORD2.xyz, u_xlat16_5.xyz);
        u_xlat16_6.z = dot(vs_TEXCOORD3.xyz, u_xlat16_5.xyz);
        u_xlat16_5.x = dot(u_xlat16_6.xyz, u_xlat16_6.xyz);
        u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
        u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_6.xyz;
        u_xlat5.xyz = u_xlat16_5.xyz;
    } else {
        u_xlat5.xyz = u_xlat3.xyz;
    //ENDIF
    }
    u_xlat4.xyz = u_xlat5.xyz + vec3(vec3(_LightingScale, _LightingScale, _LightingScale));
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_WorldNormalScale, _WorldNormalScale, _WorldNormalScale));
    u_xlat25 = dot(u_xlat16_2.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat2.xyz = vec3(u_xlat25) * u_xlat2.xyz + _DarkColor.xyz;
    u_xlat7.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat10_5 = texture(_BaseTex, u_xlat7.xy);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat10_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb25 = !!(_MatcapToggle==1.0);
#else
    u_xlatb25 = _MatcapToggle==1.0;
#endif
    if(u_xlatb25){
        u_xlat12.xz = u_xlat4.yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
        u_xlat4.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat4.xx + u_xlat12.xz;
        u_xlat4.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat4.zz + u_xlat4.xy;
        u_xlat4.xy = u_xlat4.xy * vec2(_MatcapSize) + vec2(1.0, 1.0);
        u_xlat4.xy = u_xlat4.xy * vec2(0.5, 0.5);
        u_xlat10_4.xyz = texture(_Matcap, u_xlat4.xy).xyz;
        u_xlat2.xyz = u_xlat10_4.xyz * vec3(vec3(_Matcap_Light, _Matcap_Light, _Matcap_Light)) + u_xlat2.xyz;
    //ENDIF
    }
    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorBrightness);
    u_xlat2.xyz = u_xlat2.xyz * vs_COLOR0.xyz;
    u_xlat25 = vs_COLOR0.w * _DayColor.w;
    u_xlat25 = u_xlat10_5.w * u_xlat25;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat16_6.x = dot((-u_xlat1.xyz), u_xlat3.xyz);
    u_xlat16_6.x = u_xlat16_6.x + u_xlat16_6.x;
    u_xlat16_6.xyz = u_xlat3.xyz * (-u_xlat16_6.xxx) + (-u_xlat1.xyz);
    u_xlat10_4 = textureLod(unity_SpecCube0, u_xlat16_6.xyz, 6.0);
    u_xlat16_6.x = u_xlat10_4.w + -1.0;
    u_xlat16_6.x = unity_SpecCube0_HDR.w * u_xlat16_6.x + 1.0;
    u_xlat16_6.x = u_xlat16_6.x * unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat10_4.xyz * u_xlat16_6.xxx;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = max(u_xlat24, 0.00100000005);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = max(u_xlat0.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * 2.50002503;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = u_xlat0.x * 0.220916301;
    u_xlat0.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(0.720000029, 0.720000029, 0.720000029);
    u_xlat16_30 = (-u_xlat1.x) + 1.0;
    u_xlat16_30 = u_xlat16_30 * u_xlat16_30;
    u_xlat16_30 = u_xlat16_30 * u_xlat16_30;
    u_xlat16_30 = u_xlat16_30 * -2.98023224e-08 + 0.220916301;
    u_xlat16_6.xyz = vec3(u_xlat16_30) * u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat2.xyz * _DayColor.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat25;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat13;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat2.xyz = vec3(u_xlat0) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat0) * u_xlat3.xyz;
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat2.z;
    vs_TEXCOORD1.z = u_xlat1.y;
    vs_TEXCOORD1.w = u_xlat4.x;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD2.z = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD2.w = u_xlat4.y;
    vs_TEXCOORD3.w = u_xlat4.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	float _ColorBrightness;
uniform 	float _MatcapToggle;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	float _NormalMapToggle;
uniform 	float _NormaTexlScale;
uniform 	float _LightingScale;
uniform 	float _WorldNormalScale;
uniform 	vec4 _BaseTex_ST;
uniform 	float _MatcapSize;
uniform 	float _Matcap_Light;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _Matcap;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec4 u_xlat10_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec2 u_xlat7;
vec3 u_xlat12;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_25;
bool u_xlatb25;
mediump float u_xlat16_30;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_25 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_25 = inversesqrt(u_xlat16_25);
    u_xlat16_2.xyz = vec3(u_xlat16_25) * _WorldSpaceLightPos0.xyz;
    u_xlat3.x = vs_TEXCOORD1.z;
    u_xlat3.y = vs_TEXCOORD2.z;
    u_xlat3.z = vs_TEXCOORD3.z;
    u_xlat25 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat3.xyz = vec3(u_xlat25) * u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb25 = !!(_NormalMapToggle==1.0);
#else
    u_xlatb25 = _NormalMapToggle==1.0;
#endif
    if(u_xlatb25){
        u_xlat10_4.xyz = texture(_NormalMap, vs_TEXCOORD0.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_5.xy = u_xlat16_5.xy * vec2(vec2(_NormaTexlScale, _NormaTexlScale));
        u_xlat16_6.x = dot(vs_TEXCOORD1.xyz, u_xlat16_5.xyz);
        u_xlat16_6.y = dot(vs_TEXCOORD2.xyz, u_xlat16_5.xyz);
        u_xlat16_6.z = dot(vs_TEXCOORD3.xyz, u_xlat16_5.xyz);
        u_xlat16_5.x = dot(u_xlat16_6.xyz, u_xlat16_6.xyz);
        u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
        u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_6.xyz;
        u_xlat5.xyz = u_xlat16_5.xyz;
    } else {
        u_xlat5.xyz = u_xlat3.xyz;
    //ENDIF
    }
    u_xlat4.xyz = u_xlat5.xyz + vec3(vec3(_LightingScale, _LightingScale, _LightingScale));
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_WorldNormalScale, _WorldNormalScale, _WorldNormalScale));
    u_xlat25 = dot(u_xlat16_2.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat2.xyz = vec3(u_xlat25) * u_xlat2.xyz + _DarkColor.xyz;
    u_xlat7.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat10_5 = texture(_BaseTex, u_xlat7.xy);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat10_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb25 = !!(_MatcapToggle==1.0);
#else
    u_xlatb25 = _MatcapToggle==1.0;
#endif
    if(u_xlatb25){
        u_xlat12.xz = u_xlat4.yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
        u_xlat4.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat4.xx + u_xlat12.xz;
        u_xlat4.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat4.zz + u_xlat4.xy;
        u_xlat4.xy = u_xlat4.xy * vec2(_MatcapSize) + vec2(1.0, 1.0);
        u_xlat4.xy = u_xlat4.xy * vec2(0.5, 0.5);
        u_xlat10_4.xyz = texture(_Matcap, u_xlat4.xy).xyz;
        u_xlat2.xyz = u_xlat10_4.xyz * vec3(vec3(_Matcap_Light, _Matcap_Light, _Matcap_Light)) + u_xlat2.xyz;
    //ENDIF
    }
    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorBrightness);
    u_xlat2.xyz = u_xlat2.xyz * vs_COLOR0.xyz;
    u_xlat25 = vs_COLOR0.w * _DayColor.w;
    u_xlat25 = u_xlat10_5.w * u_xlat25;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat16_6.x = dot((-u_xlat1.xyz), u_xlat3.xyz);
    u_xlat16_6.x = u_xlat16_6.x + u_xlat16_6.x;
    u_xlat16_6.xyz = u_xlat3.xyz * (-u_xlat16_6.xxx) + (-u_xlat1.xyz);
    u_xlat10_4 = textureLod(unity_SpecCube0, u_xlat16_6.xyz, 6.0);
    u_xlat16_6.x = u_xlat10_4.w + -1.0;
    u_xlat16_6.x = unity_SpecCube0_HDR.w * u_xlat16_6.x + 1.0;
    u_xlat16_6.x = u_xlat16_6.x * unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat10_4.xyz * u_xlat16_6.xxx;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = max(u_xlat24, 0.00100000005);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = max(u_xlat0.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * 2.50002503;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = u_xlat0.x * 0.220916301;
    u_xlat0.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(0.720000029, 0.720000029, 0.720000029);
    u_xlat16_30 = (-u_xlat1.x) + 1.0;
    u_xlat16_30 = u_xlat16_30 * u_xlat16_30;
    u_xlat16_30 = u_xlat16_30 * u_xlat16_30;
    u_xlat16_30 = u_xlat16_30 * -2.98023224e-08 + 0.220916301;
    u_xlat16_6.xyz = vec3(u_xlat16_30) * u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat2.xyz * _DayColor.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat25;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD4;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
mediump vec4 u_xlat16_0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat19;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat2 = vec4(u_xlat0) * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = u_xlat2.ywx * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat0) * u_xlat3.xyz;
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat1.z;
    vs_TEXCOORD1.z = u_xlat2.x;
    vs_TEXCOORD1.w = u_xlat6.x;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat1.y;
    vs_TEXCOORD2.w = u_xlat6.y;
    vs_TEXCOORD3.w = u_xlat6.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_TEXCOORD2.z = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat2.w;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_4 = u_xlat2.y * u_xlat2.y;
    u_xlat16_4 = u_xlat2.x * u_xlat2.x + (-u_xlat16_4);
    u_xlat16_0 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_4) + u_xlat16_5.xyz;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	float _ColorBrightness;
uniform 	float _MatcapToggle;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	float _NormalMapToggle;
uniform 	float _NormaTexlScale;
uniform 	float _LightingScale;
uniform 	float _WorldNormalScale;
uniform 	vec4 _BaseTex_ST;
uniform 	float _MatcapSize;
uniform 	float _Matcap_Light;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _Matcap;
uniform highp sampler2D unity_NHxRoughness;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_4;
mediump vec3 u_xlat16_5;
vec2 u_xlat6;
mediump vec3 u_xlat16_7;
float u_xlat8;
mediump float u_xlat16_8;
vec3 u_xlat11;
float u_xlat24;
mediump float u_xlat16_24;
bool u_xlatb24;
float u_xlat25;
float u_xlat26;
mediump float u_xlat16_29;
mediump float u_xlat16_31;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_24 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_24 = inversesqrt(u_xlat16_24);
    u_xlat16_1.xyz = vec3(u_xlat16_24) * _WorldSpaceLightPos0.xyz;
    u_xlat2.x = vs_TEXCOORD1.z;
    u_xlat2.y = vs_TEXCOORD2.z;
    u_xlat2.z = vs_TEXCOORD3.z;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(_NormalMapToggle==1.0);
#else
    u_xlatb24 = _NormalMapToggle==1.0;
#endif
    if(u_xlatb24){
        u_xlat10_3.xyz = texture(_NormalMap, vs_TEXCOORD0.xy).xyz;
        u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_4.xy = u_xlat16_4.xy * vec2(vec2(_NormaTexlScale, _NormaTexlScale));
        u_xlat16_5.x = dot(vs_TEXCOORD1.xyz, u_xlat16_4.xyz);
        u_xlat16_5.y = dot(vs_TEXCOORD2.xyz, u_xlat16_4.xyz);
        u_xlat16_5.z = dot(vs_TEXCOORD3.xyz, u_xlat16_4.xyz);
        u_xlat16_4.x = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
        u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
        u_xlat16_4.xyz = u_xlat16_4.xxx * u_xlat16_5.xyz;
        u_xlat4.xyz = u_xlat16_4.xyz;
    } else {
        u_xlat4.xyz = u_xlat2.xyz;
    //ENDIF
    }
    u_xlat3.xyz = u_xlat4.xyz + vec3(vec3(_LightingScale, _LightingScale, _LightingScale));
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_WorldNormalScale, _WorldNormalScale, _WorldNormalScale));
    u_xlat24 = dot(u_xlat16_1.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat1.xyz + _DarkColor.xyz;
    u_xlat6.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat10_4 = texture(_BaseTex, u_xlat6.xy);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat10_4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(_MatcapToggle==1.0);
#else
    u_xlatb24 = _MatcapToggle==1.0;
#endif
    if(u_xlatb24){
        u_xlat11.xz = u_xlat3.yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
        u_xlat3.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat3.xx + u_xlat11.xz;
        u_xlat3.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat3.zz + u_xlat3.xy;
        u_xlat3.xy = u_xlat3.xy * vec2(_MatcapSize) + vec2(1.0, 1.0);
        u_xlat3.xy = u_xlat3.xy * vec2(0.5, 0.5);
        u_xlat10_3.xyz = texture(_Matcap, u_xlat3.xy).xyz;
        u_xlat1.xyz = u_xlat10_3.xyz * vec3(vec3(_Matcap_Light, _Matcap_Light, _Matcap_Light)) + u_xlat1.xyz;
    //ENDIF
    }
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    u_xlat24 = vs_COLOR0.w * _DayColor.w;
    u_xlat24 = u_xlat10_4.w * u_xlat24;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat16_5.x = dot((-u_xlat0.xyz), u_xlat2.xyz);
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_5.x;
    u_xlat16_5.xyz = u_xlat2.xyz * (-u_xlat16_5.xxx) + (-u_xlat0.xyz);
    u_xlat10_3 = textureLod(unity_SpecCube0, u_xlat16_5.xyz, 6.0);
    u_xlat16_5.x = u_xlat10_3.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_3.xyz * u_xlat16_5.xxx;
    u_xlat25 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat26 = u_xlat25 + u_xlat25;
    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat26)) + u_xlat0.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat25 = u_xlat25;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_29 = (-u_xlat25) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_8 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_8 = u_xlat16_29 * u_xlat16_8;
    u_xlat3.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_0 = u_xlat16_29 * u_xlat16_8;
    u_xlat3.y = 1.0;
    u_xlat8 = texture(unity_NHxRoughness, u_xlat3.xy).w;
    u_xlat16_29 = u_xlat8 * 3.53466082;
    u_xlat16_7.xyz = u_xlat2.xxx * _LightColor0.xyz;
    u_xlat16_31 = u_xlat16_0 * -2.98023224e-08 + 0.220916301;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_31);
    u_xlat16_5.xyz = vec3(u_xlat16_29) * u_xlat16_7.xyz + u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat1.xyz * _DayColor.xyz + u_xlat16_5.xyz;
    SV_Target0.w = u_xlat24;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD4;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
mediump vec4 u_xlat16_0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat19;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat2 = vec4(u_xlat0) * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = u_xlat2.ywx * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat0) * u_xlat3.xyz;
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat1.z;
    vs_TEXCOORD1.z = u_xlat2.x;
    vs_TEXCOORD1.w = u_xlat6.x;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat1.y;
    vs_TEXCOORD2.w = u_xlat6.y;
    vs_TEXCOORD3.w = u_xlat6.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_TEXCOORD2.z = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat2.w;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_4 = u_xlat2.y * u_xlat2.y;
    u_xlat16_4 = u_xlat2.x * u_xlat2.x + (-u_xlat16_4);
    u_xlat16_0 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_4) + u_xlat16_5.xyz;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	float _ColorBrightness;
uniform 	float _MatcapToggle;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	float _NormalMapToggle;
uniform 	float _NormaTexlScale;
uniform 	float _LightingScale;
uniform 	float _WorldNormalScale;
uniform 	vec4 _BaseTex_ST;
uniform 	float _MatcapSize;
uniform 	float _Matcap_Light;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _Matcap;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec4 u_xlat10_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec2 u_xlat7;
vec3 u_xlat12;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_25;
bool u_xlatb25;
mediump float u_xlat16_30;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_25 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_25 = inversesqrt(u_xlat16_25);
    u_xlat16_2.xyz = vec3(u_xlat16_25) * _WorldSpaceLightPos0.xyz;
    u_xlat3.x = vs_TEXCOORD1.z;
    u_xlat3.y = vs_TEXCOORD2.z;
    u_xlat3.z = vs_TEXCOORD3.z;
    u_xlat25 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat3.xyz = vec3(u_xlat25) * u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb25 = !!(_NormalMapToggle==1.0);
#else
    u_xlatb25 = _NormalMapToggle==1.0;
#endif
    if(u_xlatb25){
        u_xlat10_4.xyz = texture(_NormalMap, vs_TEXCOORD0.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_5.xy = u_xlat16_5.xy * vec2(vec2(_NormaTexlScale, _NormaTexlScale));
        u_xlat16_6.x = dot(vs_TEXCOORD1.xyz, u_xlat16_5.xyz);
        u_xlat16_6.y = dot(vs_TEXCOORD2.xyz, u_xlat16_5.xyz);
        u_xlat16_6.z = dot(vs_TEXCOORD3.xyz, u_xlat16_5.xyz);
        u_xlat16_5.x = dot(u_xlat16_6.xyz, u_xlat16_6.xyz);
        u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
        u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_6.xyz;
        u_xlat5.xyz = u_xlat16_5.xyz;
    } else {
        u_xlat5.xyz = u_xlat3.xyz;
    //ENDIF
    }
    u_xlat4.xyz = u_xlat5.xyz + vec3(vec3(_LightingScale, _LightingScale, _LightingScale));
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_WorldNormalScale, _WorldNormalScale, _WorldNormalScale));
    u_xlat25 = dot(u_xlat16_2.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat2.xyz = vec3(u_xlat25) * u_xlat2.xyz + _DarkColor.xyz;
    u_xlat7.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat10_5 = texture(_BaseTex, u_xlat7.xy);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat10_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb25 = !!(_MatcapToggle==1.0);
#else
    u_xlatb25 = _MatcapToggle==1.0;
#endif
    if(u_xlatb25){
        u_xlat12.xz = u_xlat4.yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
        u_xlat4.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat4.xx + u_xlat12.xz;
        u_xlat4.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat4.zz + u_xlat4.xy;
        u_xlat4.xy = u_xlat4.xy * vec2(_MatcapSize) + vec2(1.0, 1.0);
        u_xlat4.xy = u_xlat4.xy * vec2(0.5, 0.5);
        u_xlat10_4.xyz = texture(_Matcap, u_xlat4.xy).xyz;
        u_xlat2.xyz = u_xlat10_4.xyz * vec3(vec3(_Matcap_Light, _Matcap_Light, _Matcap_Light)) + u_xlat2.xyz;
    //ENDIF
    }
    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorBrightness);
    u_xlat2.xyz = u_xlat2.xyz * vs_COLOR0.xyz;
    u_xlat25 = vs_COLOR0.w * _DayColor.w;
    u_xlat25 = u_xlat10_5.w * u_xlat25;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat16_6.x = dot((-u_xlat1.xyz), u_xlat3.xyz);
    u_xlat16_6.x = u_xlat16_6.x + u_xlat16_6.x;
    u_xlat16_6.xyz = u_xlat3.xyz * (-u_xlat16_6.xxx) + (-u_xlat1.xyz);
    u_xlat10_4 = textureLod(unity_SpecCube0, u_xlat16_6.xyz, 6.0);
    u_xlat16_6.x = u_xlat10_4.w + -1.0;
    u_xlat16_6.x = unity_SpecCube0_HDR.w * u_xlat16_6.x + 1.0;
    u_xlat16_6.x = u_xlat16_6.x * unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat10_4.xyz * u_xlat16_6.xxx;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = max(u_xlat24, 0.00100000005);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = max(u_xlat0.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * 2.50002503;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = u_xlat0.x * 0.220916301;
    u_xlat0.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(0.720000029, 0.720000029, 0.720000029);
    u_xlat16_30 = (-u_xlat1.x) + 1.0;
    u_xlat16_30 = u_xlat16_30 * u_xlat16_30;
    u_xlat16_30 = u_xlat16_30 * u_xlat16_30;
    u_xlat16_30 = u_xlat16_30 * -2.98023224e-08 + 0.220916301;
    u_xlat16_6.xyz = vec3(u_xlat16_30) * u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat2.xyz * _DayColor.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat25;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD4;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
mediump vec4 u_xlat16_0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat19;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat2 = vec4(u_xlat0) * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = u_xlat2.ywx * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat0) * u_xlat3.xyz;
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat1.z;
    vs_TEXCOORD1.z = u_xlat2.x;
    vs_TEXCOORD1.w = u_xlat6.x;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat1.y;
    vs_TEXCOORD2.w = u_xlat6.y;
    vs_TEXCOORD3.w = u_xlat6.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_TEXCOORD2.z = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat2.w;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_4 = u_xlat2.y * u_xlat2.y;
    u_xlat16_4 = u_xlat2.x * u_xlat2.x + (-u_xlat16_4);
    u_xlat16_0 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_4) + u_xlat16_5.xyz;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	float _ColorBrightness;
uniform 	float _MatcapToggle;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	float _NormalMapToggle;
uniform 	float _NormaTexlScale;
uniform 	float _LightingScale;
uniform 	float _WorldNormalScale;
uniform 	vec4 _BaseTex_ST;
uniform 	float _MatcapSize;
uniform 	float _Matcap_Light;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _Matcap;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec4 u_xlat10_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec2 u_xlat7;
vec3 u_xlat12;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_25;
bool u_xlatb25;
mediump float u_xlat16_30;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_25 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_25 = inversesqrt(u_xlat16_25);
    u_xlat16_2.xyz = vec3(u_xlat16_25) * _WorldSpaceLightPos0.xyz;
    u_xlat3.x = vs_TEXCOORD1.z;
    u_xlat3.y = vs_TEXCOORD2.z;
    u_xlat3.z = vs_TEXCOORD3.z;
    u_xlat25 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat3.xyz = vec3(u_xlat25) * u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb25 = !!(_NormalMapToggle==1.0);
#else
    u_xlatb25 = _NormalMapToggle==1.0;
#endif
    if(u_xlatb25){
        u_xlat10_4.xyz = texture(_NormalMap, vs_TEXCOORD0.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_5.xy = u_xlat16_5.xy * vec2(vec2(_NormaTexlScale, _NormaTexlScale));
        u_xlat16_6.x = dot(vs_TEXCOORD1.xyz, u_xlat16_5.xyz);
        u_xlat16_6.y = dot(vs_TEXCOORD2.xyz, u_xlat16_5.xyz);
        u_xlat16_6.z = dot(vs_TEXCOORD3.xyz, u_xlat16_5.xyz);
        u_xlat16_5.x = dot(u_xlat16_6.xyz, u_xlat16_6.xyz);
        u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
        u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_6.xyz;
        u_xlat5.xyz = u_xlat16_5.xyz;
    } else {
        u_xlat5.xyz = u_xlat3.xyz;
    //ENDIF
    }
    u_xlat4.xyz = u_xlat5.xyz + vec3(vec3(_LightingScale, _LightingScale, _LightingScale));
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_WorldNormalScale, _WorldNormalScale, _WorldNormalScale));
    u_xlat25 = dot(u_xlat16_2.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat2.xyz = vec3(u_xlat25) * u_xlat2.xyz + _DarkColor.xyz;
    u_xlat7.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat10_5 = texture(_BaseTex, u_xlat7.xy);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat10_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb25 = !!(_MatcapToggle==1.0);
#else
    u_xlatb25 = _MatcapToggle==1.0;
#endif
    if(u_xlatb25){
        u_xlat12.xz = u_xlat4.yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
        u_xlat4.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat4.xx + u_xlat12.xz;
        u_xlat4.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat4.zz + u_xlat4.xy;
        u_xlat4.xy = u_xlat4.xy * vec2(_MatcapSize) + vec2(1.0, 1.0);
        u_xlat4.xy = u_xlat4.xy * vec2(0.5, 0.5);
        u_xlat10_4.xyz = texture(_Matcap, u_xlat4.xy).xyz;
        u_xlat2.xyz = u_xlat10_4.xyz * vec3(vec3(_Matcap_Light, _Matcap_Light, _Matcap_Light)) + u_xlat2.xyz;
    //ENDIF
    }
    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorBrightness);
    u_xlat2.xyz = u_xlat2.xyz * vs_COLOR0.xyz;
    u_xlat25 = vs_COLOR0.w * _DayColor.w;
    u_xlat25 = u_xlat10_5.w * u_xlat25;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat16_6.x = dot((-u_xlat1.xyz), u_xlat3.xyz);
    u_xlat16_6.x = u_xlat16_6.x + u_xlat16_6.x;
    u_xlat16_6.xyz = u_xlat3.xyz * (-u_xlat16_6.xxx) + (-u_xlat1.xyz);
    u_xlat10_4 = textureLod(unity_SpecCube0, u_xlat16_6.xyz, 6.0);
    u_xlat16_6.x = u_xlat10_4.w + -1.0;
    u_xlat16_6.x = unity_SpecCube0_HDR.w * u_xlat16_6.x + 1.0;
    u_xlat16_6.x = u_xlat16_6.x * unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat10_4.xyz * u_xlat16_6.xxx;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = max(u_xlat24, 0.00100000005);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = max(u_xlat0.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * 2.50002503;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = u_xlat0.x * 0.220916301;
    u_xlat0.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(0.720000029, 0.720000029, 0.720000029);
    u_xlat16_30 = (-u_xlat1.x) + 1.0;
    u_xlat16_30 = u_xlat16_30 * u_xlat16_30;
    u_xlat16_30 = u_xlat16_30 * u_xlat16_30;
    u_xlat16_30 = u_xlat16_30 * -2.98023224e-08 + 0.220916301;
    u_xlat16_6.xyz = vec3(u_xlat16_30) * u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat2.xyz * _DayColor.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat25;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "INSTANCING_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "INSTANCING_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "INSTANCING_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "INSTANCING_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "INSTANCING_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "INSTANCING_ON" }
""
}
}
}
 Pass {
  Name "DEFERRED"
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "LIGHTMODE" = "DEFERRED" "PreviewType" = "Plane" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 130914
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    vs_TEXCOORD1.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat2.z;
    vs_TEXCOORD1.z = u_xlat1.y;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD2.z = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _ColorBrightness;
uniform 	float _MatcapToggle;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	float _NormalMapToggle;
uniform 	float _NormaTexlScale;
uniform 	float _LightingScale;
uniform 	float _WorldNormalScale;
uniform 	vec4 _BaseTex_ST;
uniform 	float _MatcapSize;
uniform 	float _Matcap_Light;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _Matcap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec3 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
lowp vec3 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat8;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat0.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat1.x = vs_TEXCOORD1.z;
    u_xlat1.y = vs_TEXCOORD2.z;
    u_xlat1.z = vs_TEXCOORD3.z;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_NormalMapToggle==1.0);
#else
    u_xlatb18 = _NormalMapToggle==1.0;
#endif
    if(u_xlatb18){
        u_xlat10_2.xyz = texture(_NormalMap, vs_TEXCOORD0.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormaTexlScale, _NormaTexlScale));
        u_xlat16_4.x = dot(vs_TEXCOORD1.xyz, u_xlat16_3.xyz);
        u_xlat16_4.y = dot(vs_TEXCOORD2.xyz, u_xlat16_3.xyz);
        u_xlat16_4.z = dot(vs_TEXCOORD3.xyz, u_xlat16_3.xyz);
        u_xlat16_3.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
        u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
        u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz;
        u_xlat3.xyz = u_xlat16_3.xyz;
    } else {
        u_xlat3.xyz = u_xlat1.xyz;
    //ENDIF
    }
    u_xlat2.xyz = u_xlat3.xyz + vec3(vec3(_LightingScale, _LightingScale, _LightingScale));
    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_WorldNormalScale, _WorldNormalScale, _WorldNormalScale));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz + _DarkColor.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat10_5.xyz = texture(_BaseTex, u_xlat5.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_MatcapToggle==1.0);
#else
    u_xlatb18 = _MatcapToggle==1.0;
#endif
    if(u_xlatb18){
        u_xlat8.xz = u_xlat2.yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
        u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat2.xx + u_xlat8.xz;
        u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat2.zz + u_xlat2.xy;
        u_xlat2.xy = u_xlat2.xy * vec2(_MatcapSize) + vec2(1.0, 1.0);
        u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5);
        u_xlat10_2.xyz = texture(_Matcap, u_xlat2.xy).xyz;
        u_xlat0.xyz = u_xlat10_2.xyz * vec3(vec3(_Matcap_Light, _Matcap_Light, _Matcap_Light)) + u_xlat0.xyz;
    //ENDIF
    }
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target3.xyz = exp2((-u_xlat0.xyz));
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
    SV_Target1 = vec4(0.220916301, 0.220916301, 0.220916301, 0.0);
    SV_Target2.xyz = u_xlat1.xyz;
    SV_Target2.w = 1.0;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    vs_TEXCOORD1.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat2.z;
    vs_TEXCOORD1.z = u_xlat1.y;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD2.z = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _ColorBrightness;
uniform 	float _MatcapToggle;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	float _NormalMapToggle;
uniform 	float _NormaTexlScale;
uniform 	float _LightingScale;
uniform 	float _WorldNormalScale;
uniform 	vec4 _BaseTex_ST;
uniform 	float _MatcapSize;
uniform 	float _Matcap_Light;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _Matcap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec3 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
lowp vec3 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat8;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat0.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat1.x = vs_TEXCOORD1.z;
    u_xlat1.y = vs_TEXCOORD2.z;
    u_xlat1.z = vs_TEXCOORD3.z;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_NormalMapToggle==1.0);
#else
    u_xlatb18 = _NormalMapToggle==1.0;
#endif
    if(u_xlatb18){
        u_xlat10_2.xyz = texture(_NormalMap, vs_TEXCOORD0.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormaTexlScale, _NormaTexlScale));
        u_xlat16_4.x = dot(vs_TEXCOORD1.xyz, u_xlat16_3.xyz);
        u_xlat16_4.y = dot(vs_TEXCOORD2.xyz, u_xlat16_3.xyz);
        u_xlat16_4.z = dot(vs_TEXCOORD3.xyz, u_xlat16_3.xyz);
        u_xlat16_3.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
        u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
        u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz;
        u_xlat3.xyz = u_xlat16_3.xyz;
    } else {
        u_xlat3.xyz = u_xlat1.xyz;
    //ENDIF
    }
    u_xlat2.xyz = u_xlat3.xyz + vec3(vec3(_LightingScale, _LightingScale, _LightingScale));
    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_WorldNormalScale, _WorldNormalScale, _WorldNormalScale));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz + _DarkColor.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat10_5.xyz = texture(_BaseTex, u_xlat5.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_MatcapToggle==1.0);
#else
    u_xlatb18 = _MatcapToggle==1.0;
#endif
    if(u_xlatb18){
        u_xlat8.xz = u_xlat2.yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
        u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat2.xx + u_xlat8.xz;
        u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat2.zz + u_xlat2.xy;
        u_xlat2.xy = u_xlat2.xy * vec2(_MatcapSize) + vec2(1.0, 1.0);
        u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5);
        u_xlat10_2.xyz = texture(_Matcap, u_xlat2.xy).xyz;
        u_xlat0.xyz = u_xlat10_2.xyz * vec3(vec3(_Matcap_Light, _Matcap_Light, _Matcap_Light)) + u_xlat0.xyz;
    //ENDIF
    }
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target3.xyz = exp2((-u_xlat0.xyz));
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
    SV_Target1 = vec4(0.220916301, 0.220916301, 0.220916301, 0.0);
    SV_Target2.xyz = u_xlat1.xyz;
    SV_Target2.w = 1.0;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    vs_TEXCOORD1.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat2.z;
    vs_TEXCOORD1.z = u_xlat1.y;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD2.z = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _ColorBrightness;
uniform 	float _MatcapToggle;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	float _NormalMapToggle;
uniform 	float _NormaTexlScale;
uniform 	float _LightingScale;
uniform 	float _WorldNormalScale;
uniform 	vec4 _BaseTex_ST;
uniform 	float _MatcapSize;
uniform 	float _Matcap_Light;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _Matcap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec3 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
lowp vec3 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat8;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat0.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat1.x = vs_TEXCOORD1.z;
    u_xlat1.y = vs_TEXCOORD2.z;
    u_xlat1.z = vs_TEXCOORD3.z;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_NormalMapToggle==1.0);
#else
    u_xlatb18 = _NormalMapToggle==1.0;
#endif
    if(u_xlatb18){
        u_xlat10_2.xyz = texture(_NormalMap, vs_TEXCOORD0.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormaTexlScale, _NormaTexlScale));
        u_xlat16_4.x = dot(vs_TEXCOORD1.xyz, u_xlat16_3.xyz);
        u_xlat16_4.y = dot(vs_TEXCOORD2.xyz, u_xlat16_3.xyz);
        u_xlat16_4.z = dot(vs_TEXCOORD3.xyz, u_xlat16_3.xyz);
        u_xlat16_3.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
        u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
        u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz;
        u_xlat3.xyz = u_xlat16_3.xyz;
    } else {
        u_xlat3.xyz = u_xlat1.xyz;
    //ENDIF
    }
    u_xlat2.xyz = u_xlat3.xyz + vec3(vec3(_LightingScale, _LightingScale, _LightingScale));
    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_WorldNormalScale, _WorldNormalScale, _WorldNormalScale));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz + _DarkColor.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat10_5.xyz = texture(_BaseTex, u_xlat5.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_MatcapToggle==1.0);
#else
    u_xlatb18 = _MatcapToggle==1.0;
#endif
    if(u_xlatb18){
        u_xlat8.xz = u_xlat2.yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
        u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat2.xx + u_xlat8.xz;
        u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat2.zz + u_xlat2.xy;
        u_xlat2.xy = u_xlat2.xy * vec2(_MatcapSize) + vec2(1.0, 1.0);
        u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5);
        u_xlat10_2.xyz = texture(_Matcap, u_xlat2.xy).xyz;
        u_xlat0.xyz = u_xlat10_2.xyz * vec3(vec3(_Matcap_Light, _Matcap_Light, _Matcap_Light)) + u_xlat0.xyz;
    //ENDIF
    }
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target3.xyz = exp2((-u_xlat0.xyz));
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
    SV_Target1 = vec4(0.220916301, 0.220916301, 0.220916301, 0.0);
    SV_Target2.xyz = u_xlat1.xyz;
    SV_Target2.w = 1.0;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    vs_TEXCOORD1.w = u_xlat0.x;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD1.x = u_xlat1.z;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = u_xlat2.ywx * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.z = u_xlat2.x;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat1.y;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_TEXCOORD2.z = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat2.w;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_4 = u_xlat2.y * u_xlat2.y;
    u_xlat16_4 = u_xlat2.x * u_xlat2.x + (-u_xlat16_4);
    u_xlat16_0 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD6.xyz = unity_SHC.xyz * vec3(u_xlat16_4) + u_xlat16_5.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _ColorBrightness;
uniform 	float _MatcapToggle;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	float _NormalMapToggle;
uniform 	float _NormaTexlScale;
uniform 	float _LightingScale;
uniform 	float _WorldNormalScale;
uniform 	vec4 _BaseTex_ST;
uniform 	float _MatcapSize;
uniform 	float _Matcap_Light;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _Matcap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec3 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
lowp vec3 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat8;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat0.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat1.x = vs_TEXCOORD1.z;
    u_xlat1.y = vs_TEXCOORD2.z;
    u_xlat1.z = vs_TEXCOORD3.z;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_NormalMapToggle==1.0);
#else
    u_xlatb18 = _NormalMapToggle==1.0;
#endif
    if(u_xlatb18){
        u_xlat10_2.xyz = texture(_NormalMap, vs_TEXCOORD0.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormaTexlScale, _NormaTexlScale));
        u_xlat16_4.x = dot(vs_TEXCOORD1.xyz, u_xlat16_3.xyz);
        u_xlat16_4.y = dot(vs_TEXCOORD2.xyz, u_xlat16_3.xyz);
        u_xlat16_4.z = dot(vs_TEXCOORD3.xyz, u_xlat16_3.xyz);
        u_xlat16_3.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
        u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
        u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz;
        u_xlat3.xyz = u_xlat16_3.xyz;
    } else {
        u_xlat3.xyz = u_xlat1.xyz;
    //ENDIF
    }
    u_xlat2.xyz = u_xlat3.xyz + vec3(vec3(_LightingScale, _LightingScale, _LightingScale));
    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_WorldNormalScale, _WorldNormalScale, _WorldNormalScale));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz + _DarkColor.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat10_5.xyz = texture(_BaseTex, u_xlat5.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_MatcapToggle==1.0);
#else
    u_xlatb18 = _MatcapToggle==1.0;
#endif
    if(u_xlatb18){
        u_xlat8.xz = u_xlat2.yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
        u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat2.xx + u_xlat8.xz;
        u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat2.zz + u_xlat2.xy;
        u_xlat2.xy = u_xlat2.xy * vec2(_MatcapSize) + vec2(1.0, 1.0);
        u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5);
        u_xlat10_2.xyz = texture(_Matcap, u_xlat2.xy).xyz;
        u_xlat0.xyz = u_xlat10_2.xyz * vec3(vec3(_Matcap_Light, _Matcap_Light, _Matcap_Light)) + u_xlat0.xyz;
    //ENDIF
    }
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target3.xyz = exp2((-u_xlat0.xyz));
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
    SV_Target1 = vec4(0.220916301, 0.220916301, 0.220916301, 0.0);
    SV_Target2.xyz = u_xlat1.xyz;
    SV_Target2.w = 1.0;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    vs_TEXCOORD1.w = u_xlat0.x;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD1.x = u_xlat1.z;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = u_xlat2.ywx * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.z = u_xlat2.x;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat1.y;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_TEXCOORD2.z = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat2.w;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_4 = u_xlat2.y * u_xlat2.y;
    u_xlat16_4 = u_xlat2.x * u_xlat2.x + (-u_xlat16_4);
    u_xlat16_0 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD6.xyz = unity_SHC.xyz * vec3(u_xlat16_4) + u_xlat16_5.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _ColorBrightness;
uniform 	float _MatcapToggle;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	float _NormalMapToggle;
uniform 	float _NormaTexlScale;
uniform 	float _LightingScale;
uniform 	float _WorldNormalScale;
uniform 	vec4 _BaseTex_ST;
uniform 	float _MatcapSize;
uniform 	float _Matcap_Light;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _Matcap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec3 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
lowp vec3 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat8;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat0.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat1.x = vs_TEXCOORD1.z;
    u_xlat1.y = vs_TEXCOORD2.z;
    u_xlat1.z = vs_TEXCOORD3.z;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_NormalMapToggle==1.0);
#else
    u_xlatb18 = _NormalMapToggle==1.0;
#endif
    if(u_xlatb18){
        u_xlat10_2.xyz = texture(_NormalMap, vs_TEXCOORD0.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormaTexlScale, _NormaTexlScale));
        u_xlat16_4.x = dot(vs_TEXCOORD1.xyz, u_xlat16_3.xyz);
        u_xlat16_4.y = dot(vs_TEXCOORD2.xyz, u_xlat16_3.xyz);
        u_xlat16_4.z = dot(vs_TEXCOORD3.xyz, u_xlat16_3.xyz);
        u_xlat16_3.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
        u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
        u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz;
        u_xlat3.xyz = u_xlat16_3.xyz;
    } else {
        u_xlat3.xyz = u_xlat1.xyz;
    //ENDIF
    }
    u_xlat2.xyz = u_xlat3.xyz + vec3(vec3(_LightingScale, _LightingScale, _LightingScale));
    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_WorldNormalScale, _WorldNormalScale, _WorldNormalScale));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz + _DarkColor.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat10_5.xyz = texture(_BaseTex, u_xlat5.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_MatcapToggle==1.0);
#else
    u_xlatb18 = _MatcapToggle==1.0;
#endif
    if(u_xlatb18){
        u_xlat8.xz = u_xlat2.yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
        u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat2.xx + u_xlat8.xz;
        u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat2.zz + u_xlat2.xy;
        u_xlat2.xy = u_xlat2.xy * vec2(_MatcapSize) + vec2(1.0, 1.0);
        u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5);
        u_xlat10_2.xyz = texture(_Matcap, u_xlat2.xy).xyz;
        u_xlat0.xyz = u_xlat10_2.xyz * vec3(vec3(_Matcap_Light, _Matcap_Light, _Matcap_Light)) + u_xlat0.xyz;
    //ENDIF
    }
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target3.xyz = exp2((-u_xlat0.xyz));
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
    SV_Target1 = vec4(0.220916301, 0.220916301, 0.220916301, 0.0);
    SV_Target2.xyz = u_xlat1.xyz;
    SV_Target2.w = 1.0;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    vs_TEXCOORD1.w = u_xlat0.x;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD1.x = u_xlat1.z;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = u_xlat2.ywx * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.z = u_xlat2.x;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat1.y;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_TEXCOORD2.z = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat2.w;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_4 = u_xlat2.y * u_xlat2.y;
    u_xlat16_4 = u_xlat2.x * u_xlat2.x + (-u_xlat16_4);
    u_xlat16_0 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD6.xyz = unity_SHC.xyz * vec3(u_xlat16_4) + u_xlat16_5.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _ColorBrightness;
uniform 	float _MatcapToggle;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	float _NormalMapToggle;
uniform 	float _NormaTexlScale;
uniform 	float _LightingScale;
uniform 	float _WorldNormalScale;
uniform 	vec4 _BaseTex_ST;
uniform 	float _MatcapSize;
uniform 	float _Matcap_Light;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _Matcap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec3 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
lowp vec3 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat8;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat0.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat1.x = vs_TEXCOORD1.z;
    u_xlat1.y = vs_TEXCOORD2.z;
    u_xlat1.z = vs_TEXCOORD3.z;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_NormalMapToggle==1.0);
#else
    u_xlatb18 = _NormalMapToggle==1.0;
#endif
    if(u_xlatb18){
        u_xlat10_2.xyz = texture(_NormalMap, vs_TEXCOORD0.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormaTexlScale, _NormaTexlScale));
        u_xlat16_4.x = dot(vs_TEXCOORD1.xyz, u_xlat16_3.xyz);
        u_xlat16_4.y = dot(vs_TEXCOORD2.xyz, u_xlat16_3.xyz);
        u_xlat16_4.z = dot(vs_TEXCOORD3.xyz, u_xlat16_3.xyz);
        u_xlat16_3.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
        u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
        u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz;
        u_xlat3.xyz = u_xlat16_3.xyz;
    } else {
        u_xlat3.xyz = u_xlat1.xyz;
    //ENDIF
    }
    u_xlat2.xyz = u_xlat3.xyz + vec3(vec3(_LightingScale, _LightingScale, _LightingScale));
    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_WorldNormalScale, _WorldNormalScale, _WorldNormalScale));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz + _DarkColor.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat10_5.xyz = texture(_BaseTex, u_xlat5.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_MatcapToggle==1.0);
#else
    u_xlatb18 = _MatcapToggle==1.0;
#endif
    if(u_xlatb18){
        u_xlat8.xz = u_xlat2.yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
        u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat2.xx + u_xlat8.xz;
        u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat2.zz + u_xlat2.xy;
        u_xlat2.xy = u_xlat2.xy * vec2(_MatcapSize) + vec2(1.0, 1.0);
        u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5);
        u_xlat10_2.xyz = texture(_Matcap, u_xlat2.xy).xyz;
        u_xlat0.xyz = u_xlat10_2.xyz * vec3(vec3(_Matcap_Light, _Matcap_Light, _Matcap_Light)) + u_xlat0.xyz;
    //ENDIF
    }
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target3.xyz = exp2((-u_xlat0.xyz));
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
    SV_Target1 = vec4(0.220916301, 0.220916301, 0.220916301, 0.0);
    SV_Target2.xyz = u_xlat1.xyz;
    SV_Target2.w = 1.0;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    vs_TEXCOORD1.w = u_xlat0.x;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD1.x = u_xlat1.z;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = u_xlat2.ywx * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.z = u_xlat2.x;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat1.y;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_TEXCOORD2.z = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat2.w;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_4 = u_xlat2.y * u_xlat2.y;
    u_xlat16_4 = u_xlat2.x * u_xlat2.x + (-u_xlat16_4);
    u_xlat16_0 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD6.xyz = unity_SHC.xyz * vec3(u_xlat16_4) + u_xlat16_5.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _ColorBrightness;
uniform 	float _MatcapToggle;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	float _NormalMapToggle;
uniform 	float _NormaTexlScale;
uniform 	float _LightingScale;
uniform 	float _WorldNormalScale;
uniform 	vec4 _BaseTex_ST;
uniform 	float _MatcapSize;
uniform 	float _Matcap_Light;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _Matcap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec3 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
lowp vec3 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat8;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat0.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat1.x = vs_TEXCOORD1.z;
    u_xlat1.y = vs_TEXCOORD2.z;
    u_xlat1.z = vs_TEXCOORD3.z;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_NormalMapToggle==1.0);
#else
    u_xlatb18 = _NormalMapToggle==1.0;
#endif
    if(u_xlatb18){
        u_xlat10_2.xyz = texture(_NormalMap, vs_TEXCOORD0.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormaTexlScale, _NormaTexlScale));
        u_xlat16_4.x = dot(vs_TEXCOORD1.xyz, u_xlat16_3.xyz);
        u_xlat16_4.y = dot(vs_TEXCOORD2.xyz, u_xlat16_3.xyz);
        u_xlat16_4.z = dot(vs_TEXCOORD3.xyz, u_xlat16_3.xyz);
        u_xlat16_3.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
        u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
        u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz;
        u_xlat3.xyz = u_xlat16_3.xyz;
    } else {
        u_xlat3.xyz = u_xlat1.xyz;
    //ENDIF
    }
    u_xlat2.xyz = u_xlat3.xyz + vec3(vec3(_LightingScale, _LightingScale, _LightingScale));
    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_WorldNormalScale, _WorldNormalScale, _WorldNormalScale));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz + _DarkColor.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat10_5.xyz = texture(_BaseTex, u_xlat5.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_MatcapToggle==1.0);
#else
    u_xlatb18 = _MatcapToggle==1.0;
#endif
    if(u_xlatb18){
        u_xlat8.xz = u_xlat2.yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
        u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat2.xx + u_xlat8.xz;
        u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat2.zz + u_xlat2.xy;
        u_xlat2.xy = u_xlat2.xy * vec2(_MatcapSize) + vec2(1.0, 1.0);
        u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5);
        u_xlat10_2.xyz = texture(_Matcap, u_xlat2.xy).xyz;
        u_xlat0.xyz = u_xlat10_2.xyz * vec3(vec3(_Matcap_Light, _Matcap_Light, _Matcap_Light)) + u_xlat0.xyz;
    //ENDIF
    }
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
    SV_Target1 = vec4(0.220916301, 0.220916301, 0.220916301, 0.0);
    SV_Target2.xyz = u_xlat1.xyz;
    SV_Target2.w = 1.0;
    SV_Target3.xyz = u_xlat0.xyz;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    vs_TEXCOORD1.w = u_xlat0.x;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD1.x = u_xlat1.z;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = u_xlat2.ywx * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.z = u_xlat2.x;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat1.y;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_TEXCOORD2.z = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat2.w;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_4 = u_xlat2.y * u_xlat2.y;
    u_xlat16_4 = u_xlat2.x * u_xlat2.x + (-u_xlat16_4);
    u_xlat16_0 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD6.xyz = unity_SHC.xyz * vec3(u_xlat16_4) + u_xlat16_5.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _ColorBrightness;
uniform 	float _MatcapToggle;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	float _NormalMapToggle;
uniform 	float _NormaTexlScale;
uniform 	float _LightingScale;
uniform 	float _WorldNormalScale;
uniform 	vec4 _BaseTex_ST;
uniform 	float _MatcapSize;
uniform 	float _Matcap_Light;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _Matcap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec3 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
lowp vec3 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat8;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat0.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat1.x = vs_TEXCOORD1.z;
    u_xlat1.y = vs_TEXCOORD2.z;
    u_xlat1.z = vs_TEXCOORD3.z;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_NormalMapToggle==1.0);
#else
    u_xlatb18 = _NormalMapToggle==1.0;
#endif
    if(u_xlatb18){
        u_xlat10_2.xyz = texture(_NormalMap, vs_TEXCOORD0.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormaTexlScale, _NormaTexlScale));
        u_xlat16_4.x = dot(vs_TEXCOORD1.xyz, u_xlat16_3.xyz);
        u_xlat16_4.y = dot(vs_TEXCOORD2.xyz, u_xlat16_3.xyz);
        u_xlat16_4.z = dot(vs_TEXCOORD3.xyz, u_xlat16_3.xyz);
        u_xlat16_3.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
        u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
        u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz;
        u_xlat3.xyz = u_xlat16_3.xyz;
    } else {
        u_xlat3.xyz = u_xlat1.xyz;
    //ENDIF
    }
    u_xlat2.xyz = u_xlat3.xyz + vec3(vec3(_LightingScale, _LightingScale, _LightingScale));
    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_WorldNormalScale, _WorldNormalScale, _WorldNormalScale));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz + _DarkColor.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat10_5.xyz = texture(_BaseTex, u_xlat5.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_MatcapToggle==1.0);
#else
    u_xlatb18 = _MatcapToggle==1.0;
#endif
    if(u_xlatb18){
        u_xlat8.xz = u_xlat2.yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
        u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat2.xx + u_xlat8.xz;
        u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat2.zz + u_xlat2.xy;
        u_xlat2.xy = u_xlat2.xy * vec2(_MatcapSize) + vec2(1.0, 1.0);
        u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5);
        u_xlat10_2.xyz = texture(_Matcap, u_xlat2.xy).xyz;
        u_xlat0.xyz = u_xlat10_2.xyz * vec3(vec3(_Matcap_Light, _Matcap_Light, _Matcap_Light)) + u_xlat0.xyz;
    //ENDIF
    }
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
    SV_Target1 = vec4(0.220916301, 0.220916301, 0.220916301, 0.0);
    SV_Target2.xyz = u_xlat1.xyz;
    SV_Target2.w = 1.0;
    SV_Target3.xyz = u_xlat0.xyz;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    vs_TEXCOORD1.w = u_xlat0.x;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD1.x = u_xlat1.z;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = u_xlat2.ywx * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.z = u_xlat2.x;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat1.y;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_TEXCOORD2.z = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat2.w;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_4 = u_xlat2.y * u_xlat2.y;
    u_xlat16_4 = u_xlat2.x * u_xlat2.x + (-u_xlat16_4);
    u_xlat16_0 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD6.xyz = unity_SHC.xyz * vec3(u_xlat16_4) + u_xlat16_5.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _ColorBrightness;
uniform 	float _MatcapToggle;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	float _NormalMapToggle;
uniform 	float _NormaTexlScale;
uniform 	float _LightingScale;
uniform 	float _WorldNormalScale;
uniform 	vec4 _BaseTex_ST;
uniform 	float _MatcapSize;
uniform 	float _Matcap_Light;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _Matcap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec3 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
lowp vec3 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat8;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat0.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat1.x = vs_TEXCOORD1.z;
    u_xlat1.y = vs_TEXCOORD2.z;
    u_xlat1.z = vs_TEXCOORD3.z;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_NormalMapToggle==1.0);
#else
    u_xlatb18 = _NormalMapToggle==1.0;
#endif
    if(u_xlatb18){
        u_xlat10_2.xyz = texture(_NormalMap, vs_TEXCOORD0.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormaTexlScale, _NormaTexlScale));
        u_xlat16_4.x = dot(vs_TEXCOORD1.xyz, u_xlat16_3.xyz);
        u_xlat16_4.y = dot(vs_TEXCOORD2.xyz, u_xlat16_3.xyz);
        u_xlat16_4.z = dot(vs_TEXCOORD3.xyz, u_xlat16_3.xyz);
        u_xlat16_3.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
        u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
        u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz;
        u_xlat3.xyz = u_xlat16_3.xyz;
    } else {
        u_xlat3.xyz = u_xlat1.xyz;
    //ENDIF
    }
    u_xlat2.xyz = u_xlat3.xyz + vec3(vec3(_LightingScale, _LightingScale, _LightingScale));
    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_WorldNormalScale, _WorldNormalScale, _WorldNormalScale));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz + _DarkColor.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat10_5.xyz = texture(_BaseTex, u_xlat5.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_MatcapToggle==1.0);
#else
    u_xlatb18 = _MatcapToggle==1.0;
#endif
    if(u_xlatb18){
        u_xlat8.xz = u_xlat2.yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
        u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat2.xx + u_xlat8.xz;
        u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat2.zz + u_xlat2.xy;
        u_xlat2.xy = u_xlat2.xy * vec2(_MatcapSize) + vec2(1.0, 1.0);
        u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5);
        u_xlat10_2.xyz = texture(_Matcap, u_xlat2.xy).xyz;
        u_xlat0.xyz = u_xlat10_2.xyz * vec3(vec3(_Matcap_Light, _Matcap_Light, _Matcap_Light)) + u_xlat0.xyz;
    //ENDIF
    }
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
    SV_Target1 = vec4(0.220916301, 0.220916301, 0.220916301, 0.0);
    SV_Target2.xyz = u_xlat1.xyz;
    SV_Target2.w = 1.0;
    SV_Target3.xyz = u_xlat0.xyz;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat13;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat2.xyz = vec3(u_xlat0) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat0) * u_xlat3.xyz;
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat2.z;
    vs_TEXCOORD1.z = u_xlat1.y;
    vs_TEXCOORD1.w = u_xlat4.x;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD2.z = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD2.w = u_xlat4.y;
    vs_TEXCOORD3.w = u_xlat4.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _ColorBrightness;
uniform 	float _MatcapToggle;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	float _NormalMapToggle;
uniform 	float _NormaTexlScale;
uniform 	float _LightingScale;
uniform 	float _WorldNormalScale;
uniform 	vec4 _BaseTex_ST;
uniform 	float _MatcapSize;
uniform 	float _Matcap_Light;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _Matcap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec3 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
lowp vec3 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat8;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat0.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat1.x = vs_TEXCOORD1.z;
    u_xlat1.y = vs_TEXCOORD2.z;
    u_xlat1.z = vs_TEXCOORD3.z;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_NormalMapToggle==1.0);
#else
    u_xlatb18 = _NormalMapToggle==1.0;
#endif
    if(u_xlatb18){
        u_xlat10_2.xyz = texture(_NormalMap, vs_TEXCOORD0.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormaTexlScale, _NormaTexlScale));
        u_xlat16_4.x = dot(vs_TEXCOORD1.xyz, u_xlat16_3.xyz);
        u_xlat16_4.y = dot(vs_TEXCOORD2.xyz, u_xlat16_3.xyz);
        u_xlat16_4.z = dot(vs_TEXCOORD3.xyz, u_xlat16_3.xyz);
        u_xlat16_3.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
        u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
        u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz;
        u_xlat3.xyz = u_xlat16_3.xyz;
    } else {
        u_xlat3.xyz = u_xlat1.xyz;
    //ENDIF
    }
    u_xlat2.xyz = u_xlat3.xyz + vec3(vec3(_LightingScale, _LightingScale, _LightingScale));
    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_WorldNormalScale, _WorldNormalScale, _WorldNormalScale));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz + _DarkColor.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat10_5.xyz = texture(_BaseTex, u_xlat5.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_MatcapToggle==1.0);
#else
    u_xlatb18 = _MatcapToggle==1.0;
#endif
    if(u_xlatb18){
        u_xlat8.xz = u_xlat2.yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
        u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat2.xx + u_xlat8.xz;
        u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat2.zz + u_xlat2.xy;
        u_xlat2.xy = u_xlat2.xy * vec2(_MatcapSize) + vec2(1.0, 1.0);
        u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5);
        u_xlat10_2.xyz = texture(_Matcap, u_xlat2.xy).xyz;
        u_xlat0.xyz = u_xlat10_2.xyz * vec3(vec3(_Matcap_Light, _Matcap_Light, _Matcap_Light)) + u_xlat0.xyz;
    //ENDIF
    }
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target3.xyz = exp2((-u_xlat0.xyz));
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
    SV_Target1 = vec4(0.220916301, 0.220916301, 0.220916301, 0.0);
    SV_Target2.xyz = u_xlat1.xyz;
    SV_Target2.w = 1.0;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat13;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat2.xyz = vec3(u_xlat0) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat0) * u_xlat3.xyz;
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat2.z;
    vs_TEXCOORD1.z = u_xlat1.y;
    vs_TEXCOORD1.w = u_xlat4.x;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD2.z = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD2.w = u_xlat4.y;
    vs_TEXCOORD3.w = u_xlat4.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _ColorBrightness;
uniform 	float _MatcapToggle;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	float _NormalMapToggle;
uniform 	float _NormaTexlScale;
uniform 	float _LightingScale;
uniform 	float _WorldNormalScale;
uniform 	vec4 _BaseTex_ST;
uniform 	float _MatcapSize;
uniform 	float _Matcap_Light;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _Matcap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec3 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
lowp vec3 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat8;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat0.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat1.x = vs_TEXCOORD1.z;
    u_xlat1.y = vs_TEXCOORD2.z;
    u_xlat1.z = vs_TEXCOORD3.z;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_NormalMapToggle==1.0);
#else
    u_xlatb18 = _NormalMapToggle==1.0;
#endif
    if(u_xlatb18){
        u_xlat10_2.xyz = texture(_NormalMap, vs_TEXCOORD0.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormaTexlScale, _NormaTexlScale));
        u_xlat16_4.x = dot(vs_TEXCOORD1.xyz, u_xlat16_3.xyz);
        u_xlat16_4.y = dot(vs_TEXCOORD2.xyz, u_xlat16_3.xyz);
        u_xlat16_4.z = dot(vs_TEXCOORD3.xyz, u_xlat16_3.xyz);
        u_xlat16_3.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
        u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
        u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz;
        u_xlat3.xyz = u_xlat16_3.xyz;
    } else {
        u_xlat3.xyz = u_xlat1.xyz;
    //ENDIF
    }
    u_xlat2.xyz = u_xlat3.xyz + vec3(vec3(_LightingScale, _LightingScale, _LightingScale));
    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_WorldNormalScale, _WorldNormalScale, _WorldNormalScale));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz + _DarkColor.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat10_5.xyz = texture(_BaseTex, u_xlat5.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_MatcapToggle==1.0);
#else
    u_xlatb18 = _MatcapToggle==1.0;
#endif
    if(u_xlatb18){
        u_xlat8.xz = u_xlat2.yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
        u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat2.xx + u_xlat8.xz;
        u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat2.zz + u_xlat2.xy;
        u_xlat2.xy = u_xlat2.xy * vec2(_MatcapSize) + vec2(1.0, 1.0);
        u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5);
        u_xlat10_2.xyz = texture(_Matcap, u_xlat2.xy).xyz;
        u_xlat0.xyz = u_xlat10_2.xyz * vec3(vec3(_Matcap_Light, _Matcap_Light, _Matcap_Light)) + u_xlat0.xyz;
    //ENDIF
    }
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target3.xyz = exp2((-u_xlat0.xyz));
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
    SV_Target1 = vec4(0.220916301, 0.220916301, 0.220916301, 0.0);
    SV_Target2.xyz = u_xlat1.xyz;
    SV_Target2.w = 1.0;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat13;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat2.xyz = vec3(u_xlat0) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat0) * u_xlat3.xyz;
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat2.z;
    vs_TEXCOORD1.z = u_xlat1.y;
    vs_TEXCOORD1.w = u_xlat4.x;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD2.z = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD2.w = u_xlat4.y;
    vs_TEXCOORD3.w = u_xlat4.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _ColorBrightness;
uniform 	float _MatcapToggle;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	float _NormalMapToggle;
uniform 	float _NormaTexlScale;
uniform 	float _LightingScale;
uniform 	float _WorldNormalScale;
uniform 	vec4 _BaseTex_ST;
uniform 	float _MatcapSize;
uniform 	float _Matcap_Light;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _Matcap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec3 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
lowp vec3 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat8;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat0.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat1.x = vs_TEXCOORD1.z;
    u_xlat1.y = vs_TEXCOORD2.z;
    u_xlat1.z = vs_TEXCOORD3.z;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_NormalMapToggle==1.0);
#else
    u_xlatb18 = _NormalMapToggle==1.0;
#endif
    if(u_xlatb18){
        u_xlat10_2.xyz = texture(_NormalMap, vs_TEXCOORD0.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormaTexlScale, _NormaTexlScale));
        u_xlat16_4.x = dot(vs_TEXCOORD1.xyz, u_xlat16_3.xyz);
        u_xlat16_4.y = dot(vs_TEXCOORD2.xyz, u_xlat16_3.xyz);
        u_xlat16_4.z = dot(vs_TEXCOORD3.xyz, u_xlat16_3.xyz);
        u_xlat16_3.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
        u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
        u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz;
        u_xlat3.xyz = u_xlat16_3.xyz;
    } else {
        u_xlat3.xyz = u_xlat1.xyz;
    //ENDIF
    }
    u_xlat2.xyz = u_xlat3.xyz + vec3(vec3(_LightingScale, _LightingScale, _LightingScale));
    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_WorldNormalScale, _WorldNormalScale, _WorldNormalScale));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz + _DarkColor.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat10_5.xyz = texture(_BaseTex, u_xlat5.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_MatcapToggle==1.0);
#else
    u_xlatb18 = _MatcapToggle==1.0;
#endif
    if(u_xlatb18){
        u_xlat8.xz = u_xlat2.yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
        u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat2.xx + u_xlat8.xz;
        u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat2.zz + u_xlat2.xy;
        u_xlat2.xy = u_xlat2.xy * vec2(_MatcapSize) + vec2(1.0, 1.0);
        u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5);
        u_xlat10_2.xyz = texture(_Matcap, u_xlat2.xy).xyz;
        u_xlat0.xyz = u_xlat10_2.xyz * vec3(vec3(_Matcap_Light, _Matcap_Light, _Matcap_Light)) + u_xlat0.xyz;
    //ENDIF
    }
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target3.xyz = exp2((-u_xlat0.xyz));
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
    SV_Target1 = vec4(0.220916301, 0.220916301, 0.220916301, 0.0);
    SV_Target2.xyz = u_xlat1.xyz;
    SV_Target2.w = 1.0;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTPROBE_SH" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
mediump vec4 u_xlat16_0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat19;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat2 = vec4(u_xlat0) * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = u_xlat2.ywx * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat0) * u_xlat3.xyz;
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat1.z;
    vs_TEXCOORD1.z = u_xlat2.x;
    vs_TEXCOORD1.w = u_xlat6.x;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat1.y;
    vs_TEXCOORD2.w = u_xlat6.y;
    vs_TEXCOORD3.w = u_xlat6.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_TEXCOORD2.z = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat2.w;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_4 = u_xlat2.y * u_xlat2.y;
    u_xlat16_4 = u_xlat2.x * u_xlat2.x + (-u_xlat16_4);
    u_xlat16_0 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD6.xyz = unity_SHC.xyz * vec3(u_xlat16_4) + u_xlat16_5.xyz;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _ColorBrightness;
uniform 	float _MatcapToggle;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	float _NormalMapToggle;
uniform 	float _NormaTexlScale;
uniform 	float _LightingScale;
uniform 	float _WorldNormalScale;
uniform 	vec4 _BaseTex_ST;
uniform 	float _MatcapSize;
uniform 	float _Matcap_Light;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _Matcap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec3 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
lowp vec3 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat8;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat0.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat1.x = vs_TEXCOORD1.z;
    u_xlat1.y = vs_TEXCOORD2.z;
    u_xlat1.z = vs_TEXCOORD3.z;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_NormalMapToggle==1.0);
#else
    u_xlatb18 = _NormalMapToggle==1.0;
#endif
    if(u_xlatb18){
        u_xlat10_2.xyz = texture(_NormalMap, vs_TEXCOORD0.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormaTexlScale, _NormaTexlScale));
        u_xlat16_4.x = dot(vs_TEXCOORD1.xyz, u_xlat16_3.xyz);
        u_xlat16_4.y = dot(vs_TEXCOORD2.xyz, u_xlat16_3.xyz);
        u_xlat16_4.z = dot(vs_TEXCOORD3.xyz, u_xlat16_3.xyz);
        u_xlat16_3.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
        u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
        u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz;
        u_xlat3.xyz = u_xlat16_3.xyz;
    } else {
        u_xlat3.xyz = u_xlat1.xyz;
    //ENDIF
    }
    u_xlat2.xyz = u_xlat3.xyz + vec3(vec3(_LightingScale, _LightingScale, _LightingScale));
    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_WorldNormalScale, _WorldNormalScale, _WorldNormalScale));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz + _DarkColor.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat10_5.xyz = texture(_BaseTex, u_xlat5.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_MatcapToggle==1.0);
#else
    u_xlatb18 = _MatcapToggle==1.0;
#endif
    if(u_xlatb18){
        u_xlat8.xz = u_xlat2.yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
        u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat2.xx + u_xlat8.xz;
        u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat2.zz + u_xlat2.xy;
        u_xlat2.xy = u_xlat2.xy * vec2(_MatcapSize) + vec2(1.0, 1.0);
        u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5);
        u_xlat10_2.xyz = texture(_Matcap, u_xlat2.xy).xyz;
        u_xlat0.xyz = u_xlat10_2.xyz * vec3(vec3(_Matcap_Light, _Matcap_Light, _Matcap_Light)) + u_xlat0.xyz;
    //ENDIF
    }
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target3.xyz = exp2((-u_xlat0.xyz));
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
    SV_Target1 = vec4(0.220916301, 0.220916301, 0.220916301, 0.0);
    SV_Target2.xyz = u_xlat1.xyz;
    SV_Target2.w = 1.0;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTPROBE_SH" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
mediump vec4 u_xlat16_0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat19;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat2 = vec4(u_xlat0) * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = u_xlat2.ywx * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat0) * u_xlat3.xyz;
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat1.z;
    vs_TEXCOORD1.z = u_xlat2.x;
    vs_TEXCOORD1.w = u_xlat6.x;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat1.y;
    vs_TEXCOORD2.w = u_xlat6.y;
    vs_TEXCOORD3.w = u_xlat6.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_TEXCOORD2.z = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat2.w;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_4 = u_xlat2.y * u_xlat2.y;
    u_xlat16_4 = u_xlat2.x * u_xlat2.x + (-u_xlat16_4);
    u_xlat16_0 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD6.xyz = unity_SHC.xyz * vec3(u_xlat16_4) + u_xlat16_5.xyz;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _ColorBrightness;
uniform 	float _MatcapToggle;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	float _NormalMapToggle;
uniform 	float _NormaTexlScale;
uniform 	float _LightingScale;
uniform 	float _WorldNormalScale;
uniform 	vec4 _BaseTex_ST;
uniform 	float _MatcapSize;
uniform 	float _Matcap_Light;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _Matcap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec3 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
lowp vec3 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat8;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat0.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat1.x = vs_TEXCOORD1.z;
    u_xlat1.y = vs_TEXCOORD2.z;
    u_xlat1.z = vs_TEXCOORD3.z;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_NormalMapToggle==1.0);
#else
    u_xlatb18 = _NormalMapToggle==1.0;
#endif
    if(u_xlatb18){
        u_xlat10_2.xyz = texture(_NormalMap, vs_TEXCOORD0.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormaTexlScale, _NormaTexlScale));
        u_xlat16_4.x = dot(vs_TEXCOORD1.xyz, u_xlat16_3.xyz);
        u_xlat16_4.y = dot(vs_TEXCOORD2.xyz, u_xlat16_3.xyz);
        u_xlat16_4.z = dot(vs_TEXCOORD3.xyz, u_xlat16_3.xyz);
        u_xlat16_3.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
        u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
        u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz;
        u_xlat3.xyz = u_xlat16_3.xyz;
    } else {
        u_xlat3.xyz = u_xlat1.xyz;
    //ENDIF
    }
    u_xlat2.xyz = u_xlat3.xyz + vec3(vec3(_LightingScale, _LightingScale, _LightingScale));
    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_WorldNormalScale, _WorldNormalScale, _WorldNormalScale));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz + _DarkColor.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat10_5.xyz = texture(_BaseTex, u_xlat5.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_MatcapToggle==1.0);
#else
    u_xlatb18 = _MatcapToggle==1.0;
#endif
    if(u_xlatb18){
        u_xlat8.xz = u_xlat2.yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
        u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat2.xx + u_xlat8.xz;
        u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat2.zz + u_xlat2.xy;
        u_xlat2.xy = u_xlat2.xy * vec2(_MatcapSize) + vec2(1.0, 1.0);
        u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5);
        u_xlat10_2.xyz = texture(_Matcap, u_xlat2.xy).xyz;
        u_xlat0.xyz = u_xlat10_2.xyz * vec3(vec3(_Matcap_Light, _Matcap_Light, _Matcap_Light)) + u_xlat0.xyz;
    //ENDIF
    }
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target3.xyz = exp2((-u_xlat0.xyz));
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
    SV_Target1 = vec4(0.220916301, 0.220916301, 0.220916301, 0.0);
    SV_Target2.xyz = u_xlat1.xyz;
    SV_Target2.w = 1.0;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTPROBE_SH" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
mediump vec4 u_xlat16_0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat19;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat2 = vec4(u_xlat0) * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = u_xlat2.ywx * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat0) * u_xlat3.xyz;
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat1.z;
    vs_TEXCOORD1.z = u_xlat2.x;
    vs_TEXCOORD1.w = u_xlat6.x;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat1.y;
    vs_TEXCOORD2.w = u_xlat6.y;
    vs_TEXCOORD3.w = u_xlat6.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_TEXCOORD2.z = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat2.w;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_4 = u_xlat2.y * u_xlat2.y;
    u_xlat16_4 = u_xlat2.x * u_xlat2.x + (-u_xlat16_4);
    u_xlat16_0 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD6.xyz = unity_SHC.xyz * vec3(u_xlat16_4) + u_xlat16_5.xyz;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _ColorBrightness;
uniform 	float _MatcapToggle;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	float _NormalMapToggle;
uniform 	float _NormaTexlScale;
uniform 	float _LightingScale;
uniform 	float _WorldNormalScale;
uniform 	vec4 _BaseTex_ST;
uniform 	float _MatcapSize;
uniform 	float _Matcap_Light;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _Matcap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec3 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
lowp vec3 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat8;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat0.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat1.x = vs_TEXCOORD1.z;
    u_xlat1.y = vs_TEXCOORD2.z;
    u_xlat1.z = vs_TEXCOORD3.z;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_NormalMapToggle==1.0);
#else
    u_xlatb18 = _NormalMapToggle==1.0;
#endif
    if(u_xlatb18){
        u_xlat10_2.xyz = texture(_NormalMap, vs_TEXCOORD0.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormaTexlScale, _NormaTexlScale));
        u_xlat16_4.x = dot(vs_TEXCOORD1.xyz, u_xlat16_3.xyz);
        u_xlat16_4.y = dot(vs_TEXCOORD2.xyz, u_xlat16_3.xyz);
        u_xlat16_4.z = dot(vs_TEXCOORD3.xyz, u_xlat16_3.xyz);
        u_xlat16_3.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
        u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
        u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz;
        u_xlat3.xyz = u_xlat16_3.xyz;
    } else {
        u_xlat3.xyz = u_xlat1.xyz;
    //ENDIF
    }
    u_xlat2.xyz = u_xlat3.xyz + vec3(vec3(_LightingScale, _LightingScale, _LightingScale));
    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_WorldNormalScale, _WorldNormalScale, _WorldNormalScale));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz + _DarkColor.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat10_5.xyz = texture(_BaseTex, u_xlat5.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_MatcapToggle==1.0);
#else
    u_xlatb18 = _MatcapToggle==1.0;
#endif
    if(u_xlatb18){
        u_xlat8.xz = u_xlat2.yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
        u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat2.xx + u_xlat8.xz;
        u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat2.zz + u_xlat2.xy;
        u_xlat2.xy = u_xlat2.xy * vec2(_MatcapSize) + vec2(1.0, 1.0);
        u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5);
        u_xlat10_2.xyz = texture(_Matcap, u_xlat2.xy).xyz;
        u_xlat0.xyz = u_xlat10_2.xyz * vec3(vec3(_Matcap_Light, _Matcap_Light, _Matcap_Light)) + u_xlat0.xyz;
    //ENDIF
    }
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target3.xyz = exp2((-u_xlat0.xyz));
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
    SV_Target1 = vec4(0.220916301, 0.220916301, 0.220916301, 0.0);
    SV_Target2.xyz = u_xlat1.xyz;
    SV_Target2.w = 1.0;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
mediump vec4 u_xlat16_0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat19;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat2 = vec4(u_xlat0) * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = u_xlat2.ywx * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat0) * u_xlat3.xyz;
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat1.z;
    vs_TEXCOORD1.z = u_xlat2.x;
    vs_TEXCOORD1.w = u_xlat6.x;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat1.y;
    vs_TEXCOORD2.w = u_xlat6.y;
    vs_TEXCOORD3.w = u_xlat6.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_TEXCOORD2.z = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat2.w;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_4 = u_xlat2.y * u_xlat2.y;
    u_xlat16_4 = u_xlat2.x * u_xlat2.x + (-u_xlat16_4);
    u_xlat16_0 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD6.xyz = unity_SHC.xyz * vec3(u_xlat16_4) + u_xlat16_5.xyz;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _ColorBrightness;
uniform 	float _MatcapToggle;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	float _NormalMapToggle;
uniform 	float _NormaTexlScale;
uniform 	float _LightingScale;
uniform 	float _WorldNormalScale;
uniform 	vec4 _BaseTex_ST;
uniform 	float _MatcapSize;
uniform 	float _Matcap_Light;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _Matcap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec3 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
lowp vec3 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat8;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat0.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat1.x = vs_TEXCOORD1.z;
    u_xlat1.y = vs_TEXCOORD2.z;
    u_xlat1.z = vs_TEXCOORD3.z;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_NormalMapToggle==1.0);
#else
    u_xlatb18 = _NormalMapToggle==1.0;
#endif
    if(u_xlatb18){
        u_xlat10_2.xyz = texture(_NormalMap, vs_TEXCOORD0.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormaTexlScale, _NormaTexlScale));
        u_xlat16_4.x = dot(vs_TEXCOORD1.xyz, u_xlat16_3.xyz);
        u_xlat16_4.y = dot(vs_TEXCOORD2.xyz, u_xlat16_3.xyz);
        u_xlat16_4.z = dot(vs_TEXCOORD3.xyz, u_xlat16_3.xyz);
        u_xlat16_3.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
        u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
        u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz;
        u_xlat3.xyz = u_xlat16_3.xyz;
    } else {
        u_xlat3.xyz = u_xlat1.xyz;
    //ENDIF
    }
    u_xlat2.xyz = u_xlat3.xyz + vec3(vec3(_LightingScale, _LightingScale, _LightingScale));
    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_WorldNormalScale, _WorldNormalScale, _WorldNormalScale));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz + _DarkColor.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat10_5.xyz = texture(_BaseTex, u_xlat5.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_MatcapToggle==1.0);
#else
    u_xlatb18 = _MatcapToggle==1.0;
#endif
    if(u_xlatb18){
        u_xlat8.xz = u_xlat2.yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
        u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat2.xx + u_xlat8.xz;
        u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat2.zz + u_xlat2.xy;
        u_xlat2.xy = u_xlat2.xy * vec2(_MatcapSize) + vec2(1.0, 1.0);
        u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5);
        u_xlat10_2.xyz = texture(_Matcap, u_xlat2.xy).xyz;
        u_xlat0.xyz = u_xlat10_2.xyz * vec3(vec3(_Matcap_Light, _Matcap_Light, _Matcap_Light)) + u_xlat0.xyz;
    //ENDIF
    }
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
    SV_Target1 = vec4(0.220916301, 0.220916301, 0.220916301, 0.0);
    SV_Target2.xyz = u_xlat1.xyz;
    SV_Target2.w = 1.0;
    SV_Target3.xyz = u_xlat0.xyz;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
mediump vec4 u_xlat16_0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat19;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat2 = vec4(u_xlat0) * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = u_xlat2.ywx * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat0) * u_xlat3.xyz;
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat1.z;
    vs_TEXCOORD1.z = u_xlat2.x;
    vs_TEXCOORD1.w = u_xlat6.x;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat1.y;
    vs_TEXCOORD2.w = u_xlat6.y;
    vs_TEXCOORD3.w = u_xlat6.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_TEXCOORD2.z = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat2.w;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_4 = u_xlat2.y * u_xlat2.y;
    u_xlat16_4 = u_xlat2.x * u_xlat2.x + (-u_xlat16_4);
    u_xlat16_0 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD6.xyz = unity_SHC.xyz * vec3(u_xlat16_4) + u_xlat16_5.xyz;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _ColorBrightness;
uniform 	float _MatcapToggle;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	float _NormalMapToggle;
uniform 	float _NormaTexlScale;
uniform 	float _LightingScale;
uniform 	float _WorldNormalScale;
uniform 	vec4 _BaseTex_ST;
uniform 	float _MatcapSize;
uniform 	float _Matcap_Light;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _Matcap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec3 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
lowp vec3 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat8;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat0.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat1.x = vs_TEXCOORD1.z;
    u_xlat1.y = vs_TEXCOORD2.z;
    u_xlat1.z = vs_TEXCOORD3.z;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_NormalMapToggle==1.0);
#else
    u_xlatb18 = _NormalMapToggle==1.0;
#endif
    if(u_xlatb18){
        u_xlat10_2.xyz = texture(_NormalMap, vs_TEXCOORD0.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormaTexlScale, _NormaTexlScale));
        u_xlat16_4.x = dot(vs_TEXCOORD1.xyz, u_xlat16_3.xyz);
        u_xlat16_4.y = dot(vs_TEXCOORD2.xyz, u_xlat16_3.xyz);
        u_xlat16_4.z = dot(vs_TEXCOORD3.xyz, u_xlat16_3.xyz);
        u_xlat16_3.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
        u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
        u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz;
        u_xlat3.xyz = u_xlat16_3.xyz;
    } else {
        u_xlat3.xyz = u_xlat1.xyz;
    //ENDIF
    }
    u_xlat2.xyz = u_xlat3.xyz + vec3(vec3(_LightingScale, _LightingScale, _LightingScale));
    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_WorldNormalScale, _WorldNormalScale, _WorldNormalScale));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz + _DarkColor.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat10_5.xyz = texture(_BaseTex, u_xlat5.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_MatcapToggle==1.0);
#else
    u_xlatb18 = _MatcapToggle==1.0;
#endif
    if(u_xlatb18){
        u_xlat8.xz = u_xlat2.yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
        u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat2.xx + u_xlat8.xz;
        u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat2.zz + u_xlat2.xy;
        u_xlat2.xy = u_xlat2.xy * vec2(_MatcapSize) + vec2(1.0, 1.0);
        u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5);
        u_xlat10_2.xyz = texture(_Matcap, u_xlat2.xy).xyz;
        u_xlat0.xyz = u_xlat10_2.xyz * vec3(vec3(_Matcap_Light, _Matcap_Light, _Matcap_Light)) + u_xlat0.xyz;
    //ENDIF
    }
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
    SV_Target1 = vec4(0.220916301, 0.220916301, 0.220916301, 0.0);
    SV_Target2.xyz = u_xlat1.xyz;
    SV_Target2.w = 1.0;
    SV_Target3.xyz = u_xlat0.xyz;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
mediump vec4 u_xlat16_0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat19;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat2 = vec4(u_xlat0) * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = u_xlat2.ywx * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat0) * u_xlat3.xyz;
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat1.z;
    vs_TEXCOORD1.z = u_xlat2.x;
    vs_TEXCOORD1.w = u_xlat6.x;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat1.y;
    vs_TEXCOORD2.w = u_xlat6.y;
    vs_TEXCOORD3.w = u_xlat6.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_TEXCOORD2.z = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat2.w;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_4 = u_xlat2.y * u_xlat2.y;
    u_xlat16_4 = u_xlat2.x * u_xlat2.x + (-u_xlat16_4);
    u_xlat16_0 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD6.xyz = unity_SHC.xyz * vec3(u_xlat16_4) + u_xlat16_5.xyz;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _ColorBrightness;
uniform 	float _MatcapToggle;
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	float _NormalMapToggle;
uniform 	float _NormaTexlScale;
uniform 	float _LightingScale;
uniform 	float _WorldNormalScale;
uniform 	vec4 _BaseTex_ST;
uniform 	float _MatcapSize;
uniform 	float _Matcap_Light;
uniform 	vec4 _DayColor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _Matcap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec3 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
lowp vec3 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat8;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat0.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat1.x = vs_TEXCOORD1.z;
    u_xlat1.y = vs_TEXCOORD2.z;
    u_xlat1.z = vs_TEXCOORD3.z;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_NormalMapToggle==1.0);
#else
    u_xlatb18 = _NormalMapToggle==1.0;
#endif
    if(u_xlatb18){
        u_xlat10_2.xyz = texture(_NormalMap, vs_TEXCOORD0.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_3.xy = u_xlat16_3.xy * vec2(vec2(_NormaTexlScale, _NormaTexlScale));
        u_xlat16_4.x = dot(vs_TEXCOORD1.xyz, u_xlat16_3.xyz);
        u_xlat16_4.y = dot(vs_TEXCOORD2.xyz, u_xlat16_3.xyz);
        u_xlat16_4.z = dot(vs_TEXCOORD3.xyz, u_xlat16_3.xyz);
        u_xlat16_3.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
        u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
        u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz;
        u_xlat3.xyz = u_xlat16_3.xyz;
    } else {
        u_xlat3.xyz = u_xlat1.xyz;
    //ENDIF
    }
    u_xlat2.xyz = u_xlat3.xyz + vec3(vec3(_LightingScale, _LightingScale, _LightingScale));
    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_WorldNormalScale, _WorldNormalScale, _WorldNormalScale));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz + _DarkColor.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat10_5.xyz = texture(_BaseTex, u_xlat5.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(_MatcapToggle==1.0);
#else
    u_xlatb18 = _MatcapToggle==1.0;
#endif
    if(u_xlatb18){
        u_xlat8.xz = u_xlat2.yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
        u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat2.xx + u_xlat8.xz;
        u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat2.zz + u_xlat2.xy;
        u_xlat2.xy = u_xlat2.xy * vec2(_MatcapSize) + vec2(1.0, 1.0);
        u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5);
        u_xlat10_2.xyz = texture(_Matcap, u_xlat2.xy).xyz;
        u_xlat0.xyz = u_xlat10_2.xyz * vec3(vec3(_Matcap_Light, _Matcap_Light, _Matcap_Light)) + u_xlat0.xyz;
    //ENDIF
    }
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
    SV_Target1 = vec4(0.220916301, 0.220916301, 0.220916301, 0.0);
    SV_Target2.xyz = u_xlat1.xyz;
    SV_Target2.w = 1.0;
    SV_Target3.xyz = u_xlat0.xyz;
    SV_Target3.w = 1.0;
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
Keywords { "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTPROBE_SH" "INSTANCING_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTPROBE_SH" "INSTANCING_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTPROBE_SH" "INSTANCING_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" "INSTANCING_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" "INSTANCING_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" "INSTANCING_ON" }
""
}
}
}
}
CustomEditor "MiHoYoASEMaterialInspector"
}