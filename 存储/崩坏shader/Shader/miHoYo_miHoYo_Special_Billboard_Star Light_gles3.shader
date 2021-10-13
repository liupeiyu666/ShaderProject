//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Special/Billboard/Star Light" {
Properties {
_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
_MainTex ("Particle Texture", 2D) = "white" { }
_SizeScaleX ("Size Scale X", Float) = 1
_SizeScaleY ("Size Scale Y", Float) = 1
_BloomFactor ("Bloom Factor", Float) = 1
_EmissionScaler ("Emission Scaler", Range(0, 50)) = 1
_CullBack ("Cull back (0: off, 1: on)", Float) = 0
_BloomMultColor ("Bloom intensity varies with color (0: off, 1: on)", Float) = 0
_PolygonOffsetFactor ("Polygon Offset Factor", Float) = 1
_PolygonOffsetUnit ("Polygon Offset Unit", Float) = -1000
_RotateSpeed ("Rotate Speed", Float) = 1
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 39770
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _RotateSpeed;
uniform 	mediump float _CullBack;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
vec3 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
int u_xlati5;
float u_xlat6;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
void main()
{
    u_xlat0.xz = hlslcc_mtx4x4unity_ObjectToWorld[0].xy;
    u_xlat0.yw = hlslcc_mtx4x4unity_ObjectToWorld[1].xy;
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat0.xy = vec2(u_xlat0.z + u_xlat0.x, u_xlat0.w + u_xlat0.y);
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat0.xy = u_xlat1.xy * u_xlat1.xy + u_xlat0.xy;
    u_xlat0.xy = sqrt(u_xlat0.xy);
    u_xlat8.xy = in_POSITION0.xy;
    u_xlat0.xy = u_xlat0.xy * u_xlat8.xy;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat1;
    u_xlat8.x = dot(u_xlat1, u_xlat1);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat8.x = u_xlat8.x * u_xlat1.x;
    u_xlat12 = abs(u_xlat8.x) * -0.0187292993 + 0.0742610022;
    u_xlat12 = u_xlat12 * abs(u_xlat8.x) + -0.212114394;
    u_xlat12 = u_xlat12 * abs(u_xlat8.x) + 1.57072878;
    u_xlat2.x = -abs(u_xlat8.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat8.x<(-u_xlat8.x));
#else
    u_xlatb8 = u_xlat8.x<(-u_xlat8.x);
#endif
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat6 = u_xlat12 * u_xlat2.x;
    u_xlat6 = u_xlat6 * -2.0 + 3.14159274;
    u_xlat8.x = u_xlatb8 ? u_xlat6 : float(0.0);
    u_xlat8.x = u_xlat12 * u_xlat2.x + u_xlat8.x;
    u_xlat8.x = (-u_xlat8.x) + 1.57079637;
    u_xlat8.x = u_xlat8.x * _RotateSpeed;
    u_xlat2.x = sin(u_xlat8.x);
    u_xlat3.x = cos(u_xlat8.x);
    u_xlat8.xy = u_xlat0.xy * u_xlat3.xx;
    u_xlat3.x = u_xlat0.y * u_xlat2.x + u_xlat8.x;
    u_xlat3.y = u_xlat0.x * (-u_xlat2.x) + u_xlat8.y;
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    u_xlat0 = u_xlat1 + (-u_xlat3);
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat3.xyz;
    u_xlat3.xyz = u_xlat1.yyy * u_xlat3.xyz;
    u_xlat1.xyw = u_xlat2.xyz * u_xlat1.xxx + u_xlat3.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat1.x = dot(in_NORMAL0.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    { bool cond = 0.0<(-u_xlat1.x); u_xlati5 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
#else
    u_xlati5 = int((0.0<(-u_xlat1.x)) ? 0xFFFFFFFFu : uint(0u));
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = (-u_xlat1.x)<0.0; u_xlati1 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
#else
    u_xlati1 = int(((-u_xlat1.x)<0.0) ? 0xFFFFFFFFu : uint(0u));
#endif
    u_xlati1 = (-u_xlati5) + u_xlati1;
    u_xlat1.x = float(u_xlati1);
    u_xlat1 = u_xlat0 * u_xlat1.xxxx;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_CullBack));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_CullBack);
#endif
    u_xlat0 = (bool(u_xlatb2)) ? u_xlat1 : u_xlat0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_1;
mediump float u_xlat16_2;
void main()
{
    u_xlat16_0 = _TintColor + _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1;
    u_xlat16_2 = u_xlat16_0.w * _EmissionScaler;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_2);
    SV_Target0.w = u_xlat16_0.w;
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

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _RotateSpeed;
uniform 	mediump float _CullBack;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
vec3 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
int u_xlati5;
float u_xlat6;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
void main()
{
    u_xlat0.xz = hlslcc_mtx4x4unity_ObjectToWorld[0].xy;
    u_xlat0.yw = hlslcc_mtx4x4unity_ObjectToWorld[1].xy;
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat0.xy = vec2(u_xlat0.z + u_xlat0.x, u_xlat0.w + u_xlat0.y);
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat0.xy = u_xlat1.xy * u_xlat1.xy + u_xlat0.xy;
    u_xlat0.xy = sqrt(u_xlat0.xy);
    u_xlat8.xy = in_POSITION0.xy;
    u_xlat0.xy = u_xlat0.xy * u_xlat8.xy;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat1;
    u_xlat8.x = dot(u_xlat1, u_xlat1);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat8.x = u_xlat8.x * u_xlat1.x;
    u_xlat12 = abs(u_xlat8.x) * -0.0187292993 + 0.0742610022;
    u_xlat12 = u_xlat12 * abs(u_xlat8.x) + -0.212114394;
    u_xlat12 = u_xlat12 * abs(u_xlat8.x) + 1.57072878;
    u_xlat2.x = -abs(u_xlat8.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat8.x<(-u_xlat8.x));
#else
    u_xlatb8 = u_xlat8.x<(-u_xlat8.x);
#endif
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat6 = u_xlat12 * u_xlat2.x;
    u_xlat6 = u_xlat6 * -2.0 + 3.14159274;
    u_xlat8.x = u_xlatb8 ? u_xlat6 : float(0.0);
    u_xlat8.x = u_xlat12 * u_xlat2.x + u_xlat8.x;
    u_xlat8.x = (-u_xlat8.x) + 1.57079637;
    u_xlat8.x = u_xlat8.x * _RotateSpeed;
    u_xlat2.x = sin(u_xlat8.x);
    u_xlat3.x = cos(u_xlat8.x);
    u_xlat8.xy = u_xlat0.xy * u_xlat3.xx;
    u_xlat3.x = u_xlat0.y * u_xlat2.x + u_xlat8.x;
    u_xlat3.y = u_xlat0.x * (-u_xlat2.x) + u_xlat8.y;
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    u_xlat0 = u_xlat1 + (-u_xlat3);
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat3.xyz;
    u_xlat3.xyz = u_xlat1.yyy * u_xlat3.xyz;
    u_xlat1.xyw = u_xlat2.xyz * u_xlat1.xxx + u_xlat3.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat1.x = dot(in_NORMAL0.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    { bool cond = 0.0<(-u_xlat1.x); u_xlati5 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
#else
    u_xlati5 = int((0.0<(-u_xlat1.x)) ? 0xFFFFFFFFu : uint(0u));
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = (-u_xlat1.x)<0.0; u_xlati1 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
#else
    u_xlati1 = int(((-u_xlat1.x)<0.0) ? 0xFFFFFFFFu : uint(0u));
#endif
    u_xlati1 = (-u_xlati5) + u_xlati1;
    u_xlat1.x = float(u_xlati1);
    u_xlat1 = u_xlat0 * u_xlat1.xxxx;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_CullBack));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_CullBack);
#endif
    u_xlat0 = (bool(u_xlatb2)) ? u_xlat1 : u_xlat0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_1;
mediump float u_xlat16_2;
void main()
{
    u_xlat16_0 = _TintColor + _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1;
    u_xlat16_2 = u_xlat16_0.w * _EmissionScaler;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_2);
    SV_Target0.w = u_xlat16_0.w;
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

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _RotateSpeed;
uniform 	mediump float _CullBack;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
vec3 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
int u_xlati5;
float u_xlat6;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
void main()
{
    u_xlat0.xz = hlslcc_mtx4x4unity_ObjectToWorld[0].xy;
    u_xlat0.yw = hlslcc_mtx4x4unity_ObjectToWorld[1].xy;
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat0.xy = vec2(u_xlat0.z + u_xlat0.x, u_xlat0.w + u_xlat0.y);
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat0.xy = u_xlat1.xy * u_xlat1.xy + u_xlat0.xy;
    u_xlat0.xy = sqrt(u_xlat0.xy);
    u_xlat8.xy = in_POSITION0.xy;
    u_xlat0.xy = u_xlat0.xy * u_xlat8.xy;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat1;
    u_xlat8.x = dot(u_xlat1, u_xlat1);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat8.x = u_xlat8.x * u_xlat1.x;
    u_xlat12 = abs(u_xlat8.x) * -0.0187292993 + 0.0742610022;
    u_xlat12 = u_xlat12 * abs(u_xlat8.x) + -0.212114394;
    u_xlat12 = u_xlat12 * abs(u_xlat8.x) + 1.57072878;
    u_xlat2.x = -abs(u_xlat8.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat8.x<(-u_xlat8.x));
#else
    u_xlatb8 = u_xlat8.x<(-u_xlat8.x);
#endif
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat6 = u_xlat12 * u_xlat2.x;
    u_xlat6 = u_xlat6 * -2.0 + 3.14159274;
    u_xlat8.x = u_xlatb8 ? u_xlat6 : float(0.0);
    u_xlat8.x = u_xlat12 * u_xlat2.x + u_xlat8.x;
    u_xlat8.x = (-u_xlat8.x) + 1.57079637;
    u_xlat8.x = u_xlat8.x * _RotateSpeed;
    u_xlat2.x = sin(u_xlat8.x);
    u_xlat3.x = cos(u_xlat8.x);
    u_xlat8.xy = u_xlat0.xy * u_xlat3.xx;
    u_xlat3.x = u_xlat0.y * u_xlat2.x + u_xlat8.x;
    u_xlat3.y = u_xlat0.x * (-u_xlat2.x) + u_xlat8.y;
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    u_xlat0 = u_xlat1 + (-u_xlat3);
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat3.xyz;
    u_xlat3.xyz = u_xlat1.yyy * u_xlat3.xyz;
    u_xlat1.xyw = u_xlat2.xyz * u_xlat1.xxx + u_xlat3.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat1.x = dot(in_NORMAL0.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    { bool cond = 0.0<(-u_xlat1.x); u_xlati5 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
#else
    u_xlati5 = int((0.0<(-u_xlat1.x)) ? 0xFFFFFFFFu : uint(0u));
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = (-u_xlat1.x)<0.0; u_xlati1 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
#else
    u_xlati1 = int(((-u_xlat1.x)<0.0) ? 0xFFFFFFFFu : uint(0u));
#endif
    u_xlati1 = (-u_xlati5) + u_xlati1;
    u_xlat1.x = float(u_xlati1);
    u_xlat1 = u_xlat0 * u_xlat1.xxxx;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_CullBack));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_CullBack);
#endif
    u_xlat0 = (bool(u_xlatb2)) ? u_xlat1 : u_xlat0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_1;
mediump float u_xlat16_2;
void main()
{
    u_xlat16_0 = _TintColor + _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1;
    u_xlat16_2 = u_xlat16_0.w * _EmissionScaler;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_2);
    SV_Target0.w = u_xlat16_0.w;
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
  Name "CONSTANT_MAX"
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 75173
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _RotateSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec2 u_xlat4;
float u_xlat7;
float u_xlat10;
void main()
{
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat0;
    u_xlat1.x = dot(u_xlat0, u_xlat0);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.x = u_xlat0.x * u_xlat1.x;
    u_xlat4.x = abs(u_xlat1.x) * -0.0187292993 + 0.0742610022;
    u_xlat4.x = u_xlat4.x * abs(u_xlat1.x) + -0.212114394;
    u_xlat4.x = u_xlat4.x * abs(u_xlat1.x) + 1.57072878;
    u_xlat7 = -abs(u_xlat1.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<(-u_xlat1.x));
#else
    u_xlatb1 = u_xlat1.x<(-u_xlat1.x);
#endif
    u_xlat7 = sqrt(u_xlat7);
    u_xlat10 = u_xlat7 * u_xlat4.x;
    u_xlat10 = u_xlat10 * -2.0 + 3.14159274;
    u_xlat1.x = u_xlatb1 ? u_xlat10 : float(0.0);
    u_xlat1.x = u_xlat4.x * u_xlat7 + u_xlat1.x;
    u_xlat1.x = (-u_xlat1.x) + 1.57079637;
    u_xlat1.x = u_xlat1.x * _RotateSpeed;
    u_xlat2.x = cos(u_xlat1.x);
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat4.xy = u_xlat2.xx * in_POSITION0.xy;
    u_xlat2.x = in_POSITION0.y * u_xlat1.x + u_xlat4.x;
    u_xlat2.y = in_POSITION0.x * (-u_xlat1.x) + u_xlat4.y;
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat0 = u_xlat0 + (-u_xlat2);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _BloomMultColor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
float u_xlat6;
int u_xlati6;
bool u_xlatb6;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat6 = u_xlat10_0.w + 0.99000001;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati6 = int(u_xlat6);
    if((u_xlati6)==0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_BloomMultColor));
#else
    u_xlatb6 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_BloomMultColor);
#endif
    u_xlat16_1 = u_xlat10_0.y + u_xlat10_0.x;
    u_xlat16_1 = u_xlat10_0.z + u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * 0.333333343;
    u_xlat16_1 = u_xlat16_1 * _BloomFactor;
    SV_Target0.w = (u_xlatb6) ? u_xlat16_1 : _BloomFactor;
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
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _RotateSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec2 u_xlat4;
float u_xlat7;
float u_xlat10;
void main()
{
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat0;
    u_xlat1.x = dot(u_xlat0, u_xlat0);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.x = u_xlat0.x * u_xlat1.x;
    u_xlat4.x = abs(u_xlat1.x) * -0.0187292993 + 0.0742610022;
    u_xlat4.x = u_xlat4.x * abs(u_xlat1.x) + -0.212114394;
    u_xlat4.x = u_xlat4.x * abs(u_xlat1.x) + 1.57072878;
    u_xlat7 = -abs(u_xlat1.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<(-u_xlat1.x));
#else
    u_xlatb1 = u_xlat1.x<(-u_xlat1.x);
#endif
    u_xlat7 = sqrt(u_xlat7);
    u_xlat10 = u_xlat7 * u_xlat4.x;
    u_xlat10 = u_xlat10 * -2.0 + 3.14159274;
    u_xlat1.x = u_xlatb1 ? u_xlat10 : float(0.0);
    u_xlat1.x = u_xlat4.x * u_xlat7 + u_xlat1.x;
    u_xlat1.x = (-u_xlat1.x) + 1.57079637;
    u_xlat1.x = u_xlat1.x * _RotateSpeed;
    u_xlat2.x = cos(u_xlat1.x);
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat4.xy = u_xlat2.xx * in_POSITION0.xy;
    u_xlat2.x = in_POSITION0.y * u_xlat1.x + u_xlat4.x;
    u_xlat2.y = in_POSITION0.x * (-u_xlat1.x) + u_xlat4.y;
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat0 = u_xlat0 + (-u_xlat2);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _BloomMultColor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
float u_xlat6;
int u_xlati6;
bool u_xlatb6;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat6 = u_xlat10_0.w + 0.99000001;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati6 = int(u_xlat6);
    if((u_xlati6)==0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_BloomMultColor));
#else
    u_xlatb6 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_BloomMultColor);
#endif
    u_xlat16_1 = u_xlat10_0.y + u_xlat10_0.x;
    u_xlat16_1 = u_xlat10_0.z + u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * 0.333333343;
    u_xlat16_1 = u_xlat16_1 * _BloomFactor;
    SV_Target0.w = (u_xlatb6) ? u_xlat16_1 : _BloomFactor;
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
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _RotateSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec2 u_xlat4;
float u_xlat7;
float u_xlat10;
void main()
{
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat0;
    u_xlat1.x = dot(u_xlat0, u_xlat0);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.x = u_xlat0.x * u_xlat1.x;
    u_xlat4.x = abs(u_xlat1.x) * -0.0187292993 + 0.0742610022;
    u_xlat4.x = u_xlat4.x * abs(u_xlat1.x) + -0.212114394;
    u_xlat4.x = u_xlat4.x * abs(u_xlat1.x) + 1.57072878;
    u_xlat7 = -abs(u_xlat1.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<(-u_xlat1.x));
#else
    u_xlatb1 = u_xlat1.x<(-u_xlat1.x);
#endif
    u_xlat7 = sqrt(u_xlat7);
    u_xlat10 = u_xlat7 * u_xlat4.x;
    u_xlat10 = u_xlat10 * -2.0 + 3.14159274;
    u_xlat1.x = u_xlatb1 ? u_xlat10 : float(0.0);
    u_xlat1.x = u_xlat4.x * u_xlat7 + u_xlat1.x;
    u_xlat1.x = (-u_xlat1.x) + 1.57079637;
    u_xlat1.x = u_xlat1.x * _RotateSpeed;
    u_xlat2.x = cos(u_xlat1.x);
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat4.xy = u_xlat2.xx * in_POSITION0.xy;
    u_xlat2.x = in_POSITION0.y * u_xlat1.x + u_xlat4.x;
    u_xlat2.y = in_POSITION0.x * (-u_xlat1.x) + u_xlat4.y;
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat0 = u_xlat0 + (-u_xlat2);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _BloomMultColor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
float u_xlat6;
int u_xlati6;
bool u_xlatb6;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat6 = u_xlat10_0.w + 0.99000001;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati6 = int(u_xlat6);
    if((u_xlati6)==0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_BloomMultColor));
#else
    u_xlatb6 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_BloomMultColor);
#endif
    u_xlat16_1 = u_xlat10_0.y + u_xlat10_0.x;
    u_xlat16_1 = u_xlat10_0.z + u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * 0.333333343;
    u_xlat16_1 = u_xlat16_1 * _BloomFactor;
    SV_Target0.w = (u_xlatb6) ? u_xlat16_1 : _BloomFactor;
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
Fallback "Diffuse"
}