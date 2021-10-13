//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_NewHome/Hologram" {
Properties {
[ToolTip] _Brightness ("Brightness", Range(0.1, 6)) = 3
_Alpha ("Alpha", Range(0, 1)) = 1
_MainTex ("MainTexture", 2D) = "white" { }
_MainColor ("MainColor", Color) = (1,1,1,1)
_RimColor ("Rim Color", Color) = (1,1,1,1)
_RimPower ("Rim Power", Range(0.1, 10)) = 5
_ScanTiling ("Scan Tiling", Range(0.01, 1000)) = 0.05
_ScanSpeed ("Scan Speed", Range(-2, 2)) = 1
_GlowTiling ("Glow Tiling", Range(0.01, 1)) = 0.05
_GlowSpeed ("Glow Speed", Range(-10, 10)) = 1
_FlickerTex ("Flicker Control Texture", 2D) = "white" { }
_FlickerSpeed ("Flicker Speed", Range(0.01, 100)) = 1
_Fold ("__fld", Float) = 1
}
SubShader {
 LOD 100
 Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Off
  GpuProgramID 21811
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_NORMAL0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xy = vec2(u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z, u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].w);
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[0].zw * u_xlat0.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].zw * u_xlat0.zz + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[3].zw * u_xlat0.ww + u_xlat1.xy;
    vs_TEXCOORD3 = u_xlat1.x / u_xlat1.y;
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
uniform 	float _Alpha;
uniform 	float _ScanTiling;
uniform 	float _ScanSpeed;
uniform 	float _GlowTiling;
uniform 	float _GlowSpeed;
uniform 	float _FlickerSpeed;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _FlickerTex;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_NORMAL0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_2;
float u_xlat3;
float u_xlat6;
lowp float u_xlat10_9;
void main()
{
    u_xlat0 = vs_TEXCOORD1.y * _ScanTiling;
    u_xlat0 = u_xlat0 / vs_TEXCOORD3;
    u_xlat0 = _Time.w * _ScanSpeed + u_xlat0;
    u_xlat0 = fract(u_xlat0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5>=u_xlat0);
#else
    u_xlatb0 = 0.5>=u_xlat0;
#endif
    u_xlat0 = u_xlatb0 ? 0.649999976 : float(0.0);
    u_xlat3 = dot(vs_TEXCOORD2.xyz, vs_NORMAL0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat0 = u_xlat3 + u_xlat0;
    u_xlat3 = log2(u_xlat3);
    u_xlat3 = u_xlat3 * _RimPower;
    u_xlat3 = exp2(u_xlat3);
    u_xlat1.xyz = _Time.xxy * vec3(_GlowSpeed, _FlickerSpeed, _FlickerSpeed);
    u_xlat6 = vs_TEXCOORD1.y * _GlowTiling + (-u_xlat1.x);
    u_xlat10_9 = texture(_FlickerTex, u_xlat1.yz).x;
    u_xlat6 = fract(u_xlat6);
    u_xlat0 = u_xlat6 + u_xlat0;
    u_xlat6 = u_xlat6 * 0.349999994;
    u_xlat1.xyz = vec3(u_xlat6) * _MainColor.xyz;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat6 = u_xlat10_2.w * _Alpha;
    u_xlat1.xyz = u_xlat10_2.xyz * _MainColor.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _RimColor.xyz * vec3(u_xlat3) + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    SV_Target0.xyz = u_xlat1.xyz;
    u_xlat0 = u_xlat0 * u_xlat6;
    SV_Target0.w = u_xlat10_9 * u_xlat0;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_NORMAL0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xy = vec2(u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z, u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].w);
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[0].zw * u_xlat0.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].zw * u_xlat0.zz + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[3].zw * u_xlat0.ww + u_xlat1.xy;
    vs_TEXCOORD3 = u_xlat1.x / u_xlat1.y;
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
uniform 	float _Alpha;
uniform 	float _ScanTiling;
uniform 	float _ScanSpeed;
uniform 	float _GlowTiling;
uniform 	float _GlowSpeed;
uniform 	float _FlickerSpeed;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _FlickerTex;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_NORMAL0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_2;
float u_xlat3;
float u_xlat6;
lowp float u_xlat10_9;
void main()
{
    u_xlat0 = vs_TEXCOORD1.y * _ScanTiling;
    u_xlat0 = u_xlat0 / vs_TEXCOORD3;
    u_xlat0 = _Time.w * _ScanSpeed + u_xlat0;
    u_xlat0 = fract(u_xlat0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5>=u_xlat0);
#else
    u_xlatb0 = 0.5>=u_xlat0;
#endif
    u_xlat0 = u_xlatb0 ? 0.649999976 : float(0.0);
    u_xlat3 = dot(vs_TEXCOORD2.xyz, vs_NORMAL0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat0 = u_xlat3 + u_xlat0;
    u_xlat3 = log2(u_xlat3);
    u_xlat3 = u_xlat3 * _RimPower;
    u_xlat3 = exp2(u_xlat3);
    u_xlat1.xyz = _Time.xxy * vec3(_GlowSpeed, _FlickerSpeed, _FlickerSpeed);
    u_xlat6 = vs_TEXCOORD1.y * _GlowTiling + (-u_xlat1.x);
    u_xlat10_9 = texture(_FlickerTex, u_xlat1.yz).x;
    u_xlat6 = fract(u_xlat6);
    u_xlat0 = u_xlat6 + u_xlat0;
    u_xlat6 = u_xlat6 * 0.349999994;
    u_xlat1.xyz = vec3(u_xlat6) * _MainColor.xyz;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat6 = u_xlat10_2.w * _Alpha;
    u_xlat1.xyz = u_xlat10_2.xyz * _MainColor.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _RimColor.xyz * vec3(u_xlat3) + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    SV_Target0.xyz = u_xlat1.xyz;
    u_xlat0 = u_xlat0 * u_xlat6;
    SV_Target0.w = u_xlat10_9 * u_xlat0;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_NORMAL0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xy = vec2(u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z, u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].w);
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[0].zw * u_xlat0.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].zw * u_xlat0.zz + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[3].zw * u_xlat0.ww + u_xlat1.xy;
    vs_TEXCOORD3 = u_xlat1.x / u_xlat1.y;
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
uniform 	float _Alpha;
uniform 	float _ScanTiling;
uniform 	float _ScanSpeed;
uniform 	float _GlowTiling;
uniform 	float _GlowSpeed;
uniform 	float _FlickerSpeed;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _FlickerTex;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_NORMAL0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_2;
float u_xlat3;
float u_xlat6;
lowp float u_xlat10_9;
void main()
{
    u_xlat0 = vs_TEXCOORD1.y * _ScanTiling;
    u_xlat0 = u_xlat0 / vs_TEXCOORD3;
    u_xlat0 = _Time.w * _ScanSpeed + u_xlat0;
    u_xlat0 = fract(u_xlat0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5>=u_xlat0);
#else
    u_xlatb0 = 0.5>=u_xlat0;
#endif
    u_xlat0 = u_xlatb0 ? 0.649999976 : float(0.0);
    u_xlat3 = dot(vs_TEXCOORD2.xyz, vs_NORMAL0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat0 = u_xlat3 + u_xlat0;
    u_xlat3 = log2(u_xlat3);
    u_xlat3 = u_xlat3 * _RimPower;
    u_xlat3 = exp2(u_xlat3);
    u_xlat1.xyz = _Time.xxy * vec3(_GlowSpeed, _FlickerSpeed, _FlickerSpeed);
    u_xlat6 = vs_TEXCOORD1.y * _GlowTiling + (-u_xlat1.x);
    u_xlat10_9 = texture(_FlickerTex, u_xlat1.yz).x;
    u_xlat6 = fract(u_xlat6);
    u_xlat0 = u_xlat6 + u_xlat0;
    u_xlat6 = u_xlat6 * 0.349999994;
    u_xlat1.xyz = vec3(u_xlat6) * _MainColor.xyz;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat6 = u_xlat10_2.w * _Alpha;
    u_xlat1.xyz = u_xlat10_2.xyz * _MainColor.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _RimColor.xyz * vec3(u_xlat3) + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    SV_Target0.xyz = u_xlat1.xyz;
    u_xlat0 = u_xlat0 * u_xlat6;
    SV_Target0.w = u_xlat10_9 * u_xlat0;
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
}
}