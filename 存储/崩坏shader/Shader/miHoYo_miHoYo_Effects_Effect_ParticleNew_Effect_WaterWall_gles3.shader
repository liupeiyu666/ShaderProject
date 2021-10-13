//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_ParticleNew/Effect_WaterWall" {
Properties {
_MainTex01 ("MainTex01", 2D) = "white" { }
_MainTex01Speed ("MainTex01Speed", Vector) = (0,0,0,0)
_MainTex01Tiling ("MainTex01Tiling", Vector) = (1,1,0,0)
_mainTex01Color ("mainTex01Color", Color) = (0.4056553,0.5742006,0.9044118,0)
_mainTex01DisTex ("mainTex01DisTex", 2D) = "white" { }
_mainTex01Dis ("mainTex01Dis", Float) = 0.13
_mainTex02 ("mainTex02", 2D) = "white" { }
_mainTex02Speed ("mainTex02Speed", Vector) = (0,0,0,0)
_mainTex02Tilling ("mainTex02Tilling", Vector) = (1,1,0,0)
_mainTex02Color ("mainTex02Color", Color) = (0.4056553,0.5742006,0.9044118,0)
_mainTex02Dis ("mainTex02Dis", Float) = 0.13
_mainTex02DisTex ("mainTex02DisTex", 2D) = "white" { }
_BgColor ("BgColor", Color) = (0.9338235,0.9269572,0.9269572,0)
_Opacity ("Opacity", Float) = 1
_mainTex2Intensity ("mainTex2Intensity", Float) = 1
_SpecularTex ("SpecularTex", 2D) = "white" { }
_SpecularIntensity ("SpecularIntensity", Float) = 1
_LightMap ("LightMap", 2D) = "white" { }
_LightMapColor ("LightMapColor", Color) = (1,1,1,0)
_LightMapIntensity ("LightMapIntensity", Float) = 1
_texcoord ("", 2D) = "white" { }
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 59923
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _mainTex01Color;
uniform 	vec2 _MainTex01Speed;
uniform 	vec2 _MainTex01Tiling;
uniform 	vec4 _mainTex01DisTex_ST;
uniform 	float _mainTex01Dis;
uniform 	vec4 _mainTex02Color;
uniform 	vec2 _mainTex02Speed;
uniform 	vec2 _mainTex02Tilling;
uniform 	vec4 _mainTex02DisTex_ST;
uniform 	float _mainTex02Dis;
uniform 	float _mainTex2Intensity;
uniform 	float _Opacity;
uniform 	vec4 _BgColor;
uniform 	float _SpecularIntensity;
uniform 	vec4 _LightMap_ST;
uniform 	vec4 _LightMapColor;
uniform 	float _LightMapIntensity;
uniform lowp sampler2D _mainTex01DisTex;
uniform lowp sampler2D _mainTex02DisTex;
uniform lowp sampler2D _MainTex01;
uniform lowp sampler2D _mainTex02;
uniform lowp sampler2D _SpecularTex;
uniform lowp sampler2D _LightMap;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat6;
lowp vec2 u_xlat10_6;
vec2 u_xlat7;
lowp vec2 u_xlat10_7;
void main()
{
    u_xlat0.xy = vec2(vs_TEXCOORD0.x * float(_mainTex02Tilling.x), vs_TEXCOORD0.y * float(_mainTex02Tilling.y));
    u_xlat0.xy = _Time.yy * _mainTex02Speed.xy + u_xlat0.xy;
    u_xlat6.xy = vs_TEXCOORD0.xy * _mainTex02DisTex_ST.xy + _mainTex02DisTex_ST.zw;
    u_xlat10_6.xy = texture(_mainTex02DisTex, u_xlat6.xy).xy;
    u_xlat0.xy = u_xlat10_6.xy * vec2(_mainTex02Dis) + u_xlat0.xy;
    u_xlat10_0.xyz = texture(_mainTex02, u_xlat0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _mainTex02Color.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_mainTex2Intensity, _mainTex2Intensity, _mainTex2Intensity));
    u_xlat1.xy = vec2(vs_TEXCOORD0.x * float(_MainTex01Tiling.x), vs_TEXCOORD0.y * float(_MainTex01Tiling.y));
    u_xlat1.xy = _Time.yy * _MainTex01Speed.xy + u_xlat1.xy;
    u_xlat7.xy = vs_TEXCOORD0.xy * _mainTex01DisTex_ST.xy + _mainTex01DisTex_ST.zw;
    u_xlat10_7.xy = texture(_mainTex01DisTex, u_xlat7.xy).xy;
    u_xlat1.xy = u_xlat10_7.xy * vec2(_mainTex01Dis) + u_xlat1.xy;
    u_xlat10_2.xyz = texture(_MainTex01, u_xlat1.xy).xyz;
    u_xlat10_1.xyz = texture(_SpecularTex, u_xlat1.xy).xyz;
    u_xlat0.xyz = _mainTex01Color.xyz * u_xlat10_2.xyz + u_xlat0.xyz;
    u_xlat3.xyz = u_xlat0.xyz + _BgColor.xyz;
    u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    SV_Target0.w = u_xlat0.x * _Opacity;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat10_1.xyz * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(_SpecularIntensity) + u_xlat3.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _LightMap_ST.xy + _LightMap_ST.zw;
    u_xlat10_1.xyz = texture(_LightMap, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * _LightMapColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(_LightMapIntensity) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _mainTex01Color;
uniform 	vec2 _MainTex01Speed;
uniform 	vec2 _MainTex01Tiling;
uniform 	vec4 _mainTex01DisTex_ST;
uniform 	float _mainTex01Dis;
uniform 	vec4 _mainTex02Color;
uniform 	vec2 _mainTex02Speed;
uniform 	vec2 _mainTex02Tilling;
uniform 	vec4 _mainTex02DisTex_ST;
uniform 	float _mainTex02Dis;
uniform 	float _mainTex2Intensity;
uniform 	float _Opacity;
uniform 	vec4 _BgColor;
uniform 	float _SpecularIntensity;
uniform 	vec4 _LightMap_ST;
uniform 	vec4 _LightMapColor;
uniform 	float _LightMapIntensity;
uniform lowp sampler2D _mainTex01DisTex;
uniform lowp sampler2D _mainTex02DisTex;
uniform lowp sampler2D _MainTex01;
uniform lowp sampler2D _mainTex02;
uniform lowp sampler2D _SpecularTex;
uniform lowp sampler2D _LightMap;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat6;
lowp vec2 u_xlat10_6;
vec2 u_xlat7;
lowp vec2 u_xlat10_7;
void main()
{
    u_xlat0.xy = vec2(vs_TEXCOORD0.x * float(_mainTex02Tilling.x), vs_TEXCOORD0.y * float(_mainTex02Tilling.y));
    u_xlat0.xy = _Time.yy * _mainTex02Speed.xy + u_xlat0.xy;
    u_xlat6.xy = vs_TEXCOORD0.xy * _mainTex02DisTex_ST.xy + _mainTex02DisTex_ST.zw;
    u_xlat10_6.xy = texture(_mainTex02DisTex, u_xlat6.xy).xy;
    u_xlat0.xy = u_xlat10_6.xy * vec2(_mainTex02Dis) + u_xlat0.xy;
    u_xlat10_0.xyz = texture(_mainTex02, u_xlat0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _mainTex02Color.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_mainTex2Intensity, _mainTex2Intensity, _mainTex2Intensity));
    u_xlat1.xy = vec2(vs_TEXCOORD0.x * float(_MainTex01Tiling.x), vs_TEXCOORD0.y * float(_MainTex01Tiling.y));
    u_xlat1.xy = _Time.yy * _MainTex01Speed.xy + u_xlat1.xy;
    u_xlat7.xy = vs_TEXCOORD0.xy * _mainTex01DisTex_ST.xy + _mainTex01DisTex_ST.zw;
    u_xlat10_7.xy = texture(_mainTex01DisTex, u_xlat7.xy).xy;
    u_xlat1.xy = u_xlat10_7.xy * vec2(_mainTex01Dis) + u_xlat1.xy;
    u_xlat10_2.xyz = texture(_MainTex01, u_xlat1.xy).xyz;
    u_xlat10_1.xyz = texture(_SpecularTex, u_xlat1.xy).xyz;
    u_xlat0.xyz = _mainTex01Color.xyz * u_xlat10_2.xyz + u_xlat0.xyz;
    u_xlat3.xyz = u_xlat0.xyz + _BgColor.xyz;
    u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    SV_Target0.w = u_xlat0.x * _Opacity;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat10_1.xyz * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(_SpecularIntensity) + u_xlat3.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _LightMap_ST.xy + _LightMap_ST.zw;
    u_xlat10_1.xyz = texture(_LightMap, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * _LightMapColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(_LightMapIntensity) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _mainTex01Color;
uniform 	vec2 _MainTex01Speed;
uniform 	vec2 _MainTex01Tiling;
uniform 	vec4 _mainTex01DisTex_ST;
uniform 	float _mainTex01Dis;
uniform 	vec4 _mainTex02Color;
uniform 	vec2 _mainTex02Speed;
uniform 	vec2 _mainTex02Tilling;
uniform 	vec4 _mainTex02DisTex_ST;
uniform 	float _mainTex02Dis;
uniform 	float _mainTex2Intensity;
uniform 	float _Opacity;
uniform 	vec4 _BgColor;
uniform 	float _SpecularIntensity;
uniform 	vec4 _LightMap_ST;
uniform 	vec4 _LightMapColor;
uniform 	float _LightMapIntensity;
uniform lowp sampler2D _mainTex01DisTex;
uniform lowp sampler2D _mainTex02DisTex;
uniform lowp sampler2D _MainTex01;
uniform lowp sampler2D _mainTex02;
uniform lowp sampler2D _SpecularTex;
uniform lowp sampler2D _LightMap;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat6;
lowp vec2 u_xlat10_6;
vec2 u_xlat7;
lowp vec2 u_xlat10_7;
void main()
{
    u_xlat0.xy = vec2(vs_TEXCOORD0.x * float(_mainTex02Tilling.x), vs_TEXCOORD0.y * float(_mainTex02Tilling.y));
    u_xlat0.xy = _Time.yy * _mainTex02Speed.xy + u_xlat0.xy;
    u_xlat6.xy = vs_TEXCOORD0.xy * _mainTex02DisTex_ST.xy + _mainTex02DisTex_ST.zw;
    u_xlat10_6.xy = texture(_mainTex02DisTex, u_xlat6.xy).xy;
    u_xlat0.xy = u_xlat10_6.xy * vec2(_mainTex02Dis) + u_xlat0.xy;
    u_xlat10_0.xyz = texture(_mainTex02, u_xlat0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _mainTex02Color.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_mainTex2Intensity, _mainTex2Intensity, _mainTex2Intensity));
    u_xlat1.xy = vec2(vs_TEXCOORD0.x * float(_MainTex01Tiling.x), vs_TEXCOORD0.y * float(_MainTex01Tiling.y));
    u_xlat1.xy = _Time.yy * _MainTex01Speed.xy + u_xlat1.xy;
    u_xlat7.xy = vs_TEXCOORD0.xy * _mainTex01DisTex_ST.xy + _mainTex01DisTex_ST.zw;
    u_xlat10_7.xy = texture(_mainTex01DisTex, u_xlat7.xy).xy;
    u_xlat1.xy = u_xlat10_7.xy * vec2(_mainTex01Dis) + u_xlat1.xy;
    u_xlat10_2.xyz = texture(_MainTex01, u_xlat1.xy).xyz;
    u_xlat10_1.xyz = texture(_SpecularTex, u_xlat1.xy).xyz;
    u_xlat0.xyz = _mainTex01Color.xyz * u_xlat10_2.xyz + u_xlat0.xyz;
    u_xlat3.xyz = u_xlat0.xyz + _BgColor.xyz;
    u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    SV_Target0.w = u_xlat0.x * _Opacity;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat10_1.xyz * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(_SpecularIntensity) + u_xlat3.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _LightMap_ST.xy + _LightMap_ST.zw;
    u_xlat10_1.xyz = texture(_LightMap, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * _LightMapColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(_LightMapIntensity) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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
CustomEditor "ASEMaterialInspector"
}