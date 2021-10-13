//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/Video_Hologram" {
Properties {
_Brightness ("Brightness", Range(0.1, 10)) = 3
_ScanBright ("Scan Bright", Range(0, 1)) = 0.1
_GlowBright ("Glow Bright", Range(0, 1)) = 0.1
_MainTex ("MainTexture", 2D) = "white" { }
_MainColor ("MainColor", Color) = (1,1,1,1)
_RimColor ("Rim Color", Color) = (1,1,1,1)
_RimPower ("Rim Power", Range(0.1, 10)) = 5
_ScanTiling ("Scan Tiling", Range(0.01, 1000)) = 0.05
_ScanSpeed ("Scan Speed", Range(-2, 2)) = 1
_GlowTiling ("Glow Tiling", Range(0.01, 1)) = 0.05
_GlowSpeed ("Glow Speed", Range(-10, 10)) = 1
_GlitchSpeed ("Glitch Speed", Range(0, 50)) = 1
_GlitchIntensity ("Glitch Intensity", Float) = 0
_FlickerTex ("Flicker Control Texture", 2D) = "white" { }
_FlickerSpeed ("Flicker Speed", Range(0, 100)) = 0
_Color ("Main Color", Color) = (1,1,1,1)
_VertexAlphaFactor ("Alpha From Vertex Factor (0: not use)", Range(0, 1)) = 0
_BloomFactor ("Bloom Factor", Float) = 1
_Opaqueness ("Opaqueness", Range(0, 1)) = 1
}
SubShader {
 LOD 200
 Tags { "OutlineType" = "None" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "OutlineType" = "None" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 49259
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _GlitchSpeed;
uniform 	float _GlitchIntensity;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_NORMAL0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0.x = _Time.y * _GlitchSpeed;
    u_xlat0.x = u_xlat0.x * 0.5;
    u_xlat0.x = sin(u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat0.x>=0.99000001);
#else
    u_xlatb0.x = u_xlat0.x>=0.99000001;
#endif
    u_xlat3 = _Time.y * 2.0 + in_POSITION0.y;
    u_xlat3 = sin(u_xlat3);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.y = !!(u_xlat3>=0.5);
#else
    u_xlatb0.y = u_xlat3>=0.5;
#endif
    u_xlat0.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xy));
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = _GlitchIntensity * u_xlat0.x + in_POSITION0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = u_xlat0;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD2.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_NORMAL0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _MainColor;
uniform 	vec4 _RimColor;
uniform 	float _RimPower;
uniform 	float _Brightness;
uniform 	float _ScanBright;
uniform 	float _GlowBright;
uniform 	float _ScanTiling;
uniform 	float _ScanSpeed;
uniform 	float _GlowTiling;
uniform 	float _GlowSpeed;
uniform 	float _FlickerSpeed;
uniform 	float _BloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _FlickerTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_NORMAL0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
lowp float u_xlat10_3;
float u_xlat6;
bool u_xlatb6;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_NORMAL0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RimPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * _RimColor.xyz;
    u_xlat6 = _Time.w * _ScanSpeed;
    u_xlat6 = vs_TEXCOORD1.y * _ScanTiling + u_xlat6;
    u_xlat6 = fract(u_xlat6);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.5>=u_xlat6);
#else
    u_xlatb6 = 0.5>=u_xlat6;
#endif
    u_xlat6 = u_xlatb6 ? 1.0 : float(0.0);
    u_xlat6 = u_xlat6 * _ScanBright;
    u_xlat1.xyz = vec3(_Time.x * float(_GlowSpeed), _Time.x * float(_FlickerSpeed), _Time.y * float(_FlickerSpeed));
    u_xlat1.x = vs_TEXCOORD1.y * _GlowTiling + (-u_xlat1.x);
    u_xlat10_3 = texture(_FlickerTex, u_xlat1.yz).x;
    SV_Target0.w = u_xlat10_3 * _BloomFactor;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat6 = u_xlat1.x * _GlowBright + u_xlat6;
    u_xlat0.xyz = vec3(u_xlat6) * _MainColor.xyz + u_xlat0.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat10_1.xyz * _MainColor.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _GlitchSpeed;
uniform 	float _GlitchIntensity;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_NORMAL0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0.x = _Time.y * _GlitchSpeed;
    u_xlat0.x = u_xlat0.x * 0.5;
    u_xlat0.x = sin(u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat0.x>=0.99000001);
#else
    u_xlatb0.x = u_xlat0.x>=0.99000001;
#endif
    u_xlat3 = _Time.y * 2.0 + in_POSITION0.y;
    u_xlat3 = sin(u_xlat3);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.y = !!(u_xlat3>=0.5);
#else
    u_xlatb0.y = u_xlat3>=0.5;
#endif
    u_xlat0.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xy));
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = _GlitchIntensity * u_xlat0.x + in_POSITION0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = u_xlat0;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD2.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_NORMAL0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _MainColor;
uniform 	vec4 _RimColor;
uniform 	float _RimPower;
uniform 	float _Brightness;
uniform 	float _ScanBright;
uniform 	float _GlowBright;
uniform 	float _ScanTiling;
uniform 	float _ScanSpeed;
uniform 	float _GlowTiling;
uniform 	float _GlowSpeed;
uniform 	float _FlickerSpeed;
uniform 	float _BloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _FlickerTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_NORMAL0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
lowp float u_xlat10_3;
float u_xlat6;
bool u_xlatb6;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_NORMAL0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RimPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * _RimColor.xyz;
    u_xlat6 = _Time.w * _ScanSpeed;
    u_xlat6 = vs_TEXCOORD1.y * _ScanTiling + u_xlat6;
    u_xlat6 = fract(u_xlat6);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.5>=u_xlat6);
#else
    u_xlatb6 = 0.5>=u_xlat6;
#endif
    u_xlat6 = u_xlatb6 ? 1.0 : float(0.0);
    u_xlat6 = u_xlat6 * _ScanBright;
    u_xlat1.xyz = vec3(_Time.x * float(_GlowSpeed), _Time.x * float(_FlickerSpeed), _Time.y * float(_FlickerSpeed));
    u_xlat1.x = vs_TEXCOORD1.y * _GlowTiling + (-u_xlat1.x);
    u_xlat10_3 = texture(_FlickerTex, u_xlat1.yz).x;
    SV_Target0.w = u_xlat10_3 * _BloomFactor;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat6 = u_xlat1.x * _GlowBright + u_xlat6;
    u_xlat0.xyz = vec3(u_xlat6) * _MainColor.xyz + u_xlat0.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat10_1.xyz * _MainColor.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _GlitchSpeed;
uniform 	float _GlitchIntensity;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_NORMAL0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0.x = _Time.y * _GlitchSpeed;
    u_xlat0.x = u_xlat0.x * 0.5;
    u_xlat0.x = sin(u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat0.x>=0.99000001);
#else
    u_xlatb0.x = u_xlat0.x>=0.99000001;
#endif
    u_xlat3 = _Time.y * 2.0 + in_POSITION0.y;
    u_xlat3 = sin(u_xlat3);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.y = !!(u_xlat3>=0.5);
#else
    u_xlatb0.y = u_xlat3>=0.5;
#endif
    u_xlat0.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xy));
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = _GlitchIntensity * u_xlat0.x + in_POSITION0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = u_xlat0;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD2.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_NORMAL0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _MainColor;
uniform 	vec4 _RimColor;
uniform 	float _RimPower;
uniform 	float _Brightness;
uniform 	float _ScanBright;
uniform 	float _GlowBright;
uniform 	float _ScanTiling;
uniform 	float _ScanSpeed;
uniform 	float _GlowTiling;
uniform 	float _GlowSpeed;
uniform 	float _FlickerSpeed;
uniform 	float _BloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _FlickerTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_NORMAL0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
lowp float u_xlat10_3;
float u_xlat6;
bool u_xlatb6;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_NORMAL0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RimPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * _RimColor.xyz;
    u_xlat6 = _Time.w * _ScanSpeed;
    u_xlat6 = vs_TEXCOORD1.y * _ScanTiling + u_xlat6;
    u_xlat6 = fract(u_xlat6);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.5>=u_xlat6);
#else
    u_xlatb6 = 0.5>=u_xlat6;
#endif
    u_xlat6 = u_xlatb6 ? 1.0 : float(0.0);
    u_xlat6 = u_xlat6 * _ScanBright;
    u_xlat1.xyz = vec3(_Time.x * float(_GlowSpeed), _Time.x * float(_FlickerSpeed), _Time.y * float(_FlickerSpeed));
    u_xlat1.x = vs_TEXCOORD1.y * _GlowTiling + (-u_xlat1.x);
    u_xlat10_3 = texture(_FlickerTex, u_xlat1.yz).x;
    SV_Target0.w = u_xlat10_3 * _BloomFactor;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat6 = u_xlat1.x * _GlowBright + u_xlat6;
    u_xlat0.xyz = vec3(u_xlat6) * _MainColor.xyz + u_xlat0.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat10_1.xyz * _MainColor.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _GlitchSpeed;
uniform 	float _GlitchIntensity;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_NORMAL0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0.x = _Time.y * _GlitchSpeed;
    u_xlat0.x = u_xlat0.x * 0.5;
    u_xlat0.x = sin(u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat0.x>=0.99000001);
#else
    u_xlatb0.x = u_xlat0.x>=0.99000001;
#endif
    u_xlat3 = _Time.y * 2.0 + in_POSITION0.y;
    u_xlat3 = sin(u_xlat3);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.y = !!(u_xlat3>=0.5);
#else
    u_xlatb0.y = u_xlat3>=0.5;
#endif
    u_xlat0.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xy));
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = _GlitchIntensity * u_xlat0.x + in_POSITION0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = u_xlat0;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD2.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_NORMAL0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _MainColor;
uniform 	vec4 _RimColor;
uniform 	float _RimPower;
uniform 	float _Brightness;
uniform 	float _ScanBright;
uniform 	float _GlowBright;
uniform 	float _ScanTiling;
uniform 	float _ScanSpeed;
uniform 	float _GlowTiling;
uniform 	float _GlowSpeed;
uniform 	float _FlickerSpeed;
uniform 	float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _FlickerTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_NORMAL0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
lowp float u_xlat10_3;
float u_xlat6;
bool u_xlatb6;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_NORMAL0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RimPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * _RimColor.xyz;
    u_xlat6 = _Time.w * _ScanSpeed;
    u_xlat6 = vs_TEXCOORD1.y * _ScanTiling + u_xlat6;
    u_xlat6 = fract(u_xlat6);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.5>=u_xlat6);
#else
    u_xlatb6 = 0.5>=u_xlat6;
#endif
    u_xlat6 = u_xlatb6 ? 1.0 : float(0.0);
    u_xlat6 = u_xlat6 * _ScanBright;
    u_xlat1.xyz = vec3(_Time.x * float(_GlowSpeed), _Time.x * float(_FlickerSpeed), _Time.y * float(_FlickerSpeed));
    u_xlat1.x = vs_TEXCOORD1.y * _GlowTiling + (-u_xlat1.x);
    u_xlat10_3 = texture(_FlickerTex, u_xlat1.yz).x;
    SV_Target0.w = u_xlat10_3 * _BloomFactor;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat6 = u_xlat1.x * _GlowBright + u_xlat6;
    u_xlat0.xyz = vec3(u_xlat6) * _MainColor.xyz + u_xlat0.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat10_1.xyz * _MainColor.xyz + u_xlat0.xyz;
    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    u_xlat6 = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(vec3(_Brightness, _Brightness, _Brightness)) + vec3(u_xlat6);
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat0.xyz + u_xlat1.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _GlitchSpeed;
uniform 	float _GlitchIntensity;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_NORMAL0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0.x = _Time.y * _GlitchSpeed;
    u_xlat0.x = u_xlat0.x * 0.5;
    u_xlat0.x = sin(u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat0.x>=0.99000001);
#else
    u_xlatb0.x = u_xlat0.x>=0.99000001;
#endif
    u_xlat3 = _Time.y * 2.0 + in_POSITION0.y;
    u_xlat3 = sin(u_xlat3);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.y = !!(u_xlat3>=0.5);
#else
    u_xlatb0.y = u_xlat3>=0.5;
#endif
    u_xlat0.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xy));
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = _GlitchIntensity * u_xlat0.x + in_POSITION0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = u_xlat0;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD2.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_NORMAL0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _MainColor;
uniform 	vec4 _RimColor;
uniform 	float _RimPower;
uniform 	float _Brightness;
uniform 	float _ScanBright;
uniform 	float _GlowBright;
uniform 	float _ScanTiling;
uniform 	float _ScanSpeed;
uniform 	float _GlowTiling;
uniform 	float _GlowSpeed;
uniform 	float _FlickerSpeed;
uniform 	float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _FlickerTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_NORMAL0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
lowp float u_xlat10_3;
float u_xlat6;
bool u_xlatb6;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_NORMAL0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RimPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * _RimColor.xyz;
    u_xlat6 = _Time.w * _ScanSpeed;
    u_xlat6 = vs_TEXCOORD1.y * _ScanTiling + u_xlat6;
    u_xlat6 = fract(u_xlat6);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.5>=u_xlat6);
#else
    u_xlatb6 = 0.5>=u_xlat6;
#endif
    u_xlat6 = u_xlatb6 ? 1.0 : float(0.0);
    u_xlat6 = u_xlat6 * _ScanBright;
    u_xlat1.xyz = vec3(_Time.x * float(_GlowSpeed), _Time.x * float(_FlickerSpeed), _Time.y * float(_FlickerSpeed));
    u_xlat1.x = vs_TEXCOORD1.y * _GlowTiling + (-u_xlat1.x);
    u_xlat10_3 = texture(_FlickerTex, u_xlat1.yz).x;
    SV_Target0.w = u_xlat10_3 * _BloomFactor;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat6 = u_xlat1.x * _GlowBright + u_xlat6;
    u_xlat0.xyz = vec3(u_xlat6) * _MainColor.xyz + u_xlat0.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat10_1.xyz * _MainColor.xyz + u_xlat0.xyz;
    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    u_xlat6 = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(vec3(_Brightness, _Brightness, _Brightness)) + vec3(u_xlat6);
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat0.xyz + u_xlat1.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _GlitchSpeed;
uniform 	float _GlitchIntensity;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_NORMAL0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0.x = _Time.y * _GlitchSpeed;
    u_xlat0.x = u_xlat0.x * 0.5;
    u_xlat0.x = sin(u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat0.x>=0.99000001);
#else
    u_xlatb0.x = u_xlat0.x>=0.99000001;
#endif
    u_xlat3 = _Time.y * 2.0 + in_POSITION0.y;
    u_xlat3 = sin(u_xlat3);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.y = !!(u_xlat3>=0.5);
#else
    u_xlatb0.y = u_xlat3>=0.5;
#endif
    u_xlat0.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xy));
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = _GlitchIntensity * u_xlat0.x + in_POSITION0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = u_xlat0;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD2.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_NORMAL0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _MainColor;
uniform 	vec4 _RimColor;
uniform 	float _RimPower;
uniform 	float _Brightness;
uniform 	float _ScanBright;
uniform 	float _GlowBright;
uniform 	float _ScanTiling;
uniform 	float _ScanSpeed;
uniform 	float _GlowTiling;
uniform 	float _GlowSpeed;
uniform 	float _FlickerSpeed;
uniform 	float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _FlickerTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_NORMAL0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
lowp float u_xlat10_3;
float u_xlat6;
bool u_xlatb6;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_NORMAL0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RimPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * _RimColor.xyz;
    u_xlat6 = _Time.w * _ScanSpeed;
    u_xlat6 = vs_TEXCOORD1.y * _ScanTiling + u_xlat6;
    u_xlat6 = fract(u_xlat6);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.5>=u_xlat6);
#else
    u_xlatb6 = 0.5>=u_xlat6;
#endif
    u_xlat6 = u_xlatb6 ? 1.0 : float(0.0);
    u_xlat6 = u_xlat6 * _ScanBright;
    u_xlat1.xyz = vec3(_Time.x * float(_GlowSpeed), _Time.x * float(_FlickerSpeed), _Time.y * float(_FlickerSpeed));
    u_xlat1.x = vs_TEXCOORD1.y * _GlowTiling + (-u_xlat1.x);
    u_xlat10_3 = texture(_FlickerTex, u_xlat1.yz).x;
    SV_Target0.w = u_xlat10_3 * _BloomFactor;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat6 = u_xlat1.x * _GlowBright + u_xlat6;
    u_xlat0.xyz = vec3(u_xlat6) * _MainColor.xyz + u_xlat0.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat10_1.xyz * _MainColor.xyz + u_xlat0.xyz;
    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    u_xlat6 = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(vec3(_Brightness, _Brightness, _Brightness)) + vec3(u_xlat6);
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat0.xyz + u_xlat1.xyz;
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
}
}
}
}