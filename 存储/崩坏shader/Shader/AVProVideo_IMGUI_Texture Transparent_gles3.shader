//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "AVProVideo/IMGUI/Texture Transparent" {
Properties {
_MainTex ("Texture", any) = "" { }
_ChromaTex ("Chroma", any) = "" { }
_VertScale ("Vertical Scale", Range(-1, 1)) = 1
[KeywordEnum(None, Top_Bottom, Left_Right)] AlphaPack ("Alpha Pack", Float) = 0
[Toggle(APPLY_GAMMA)] _ApplyGamma ("Apply Gamma", Float) = 0
[Toggle(USE_YPCBCR)] _UseYpCbCr ("Use YpCbCr", Float) = 0
}
SubShader {
 Tags { "ForceSupported" = "true" "RenderType" = "Overlay" }
 Pass {
  Tags { "ForceSupported" = "true" "RenderType" = "Overlay" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 59941
Program "vp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _VertScale;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat2;
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
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_VertScale<0.0);
#else
    u_xlatb0 = _VertScale<0.0;
#endif
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = (-u_xlat1.y) + 1.0;
    u_xlat1.z = (u_xlatb0) ? u_xlat2 : u_xlat1.y;
    vs_TEXCOORD0 = u_xlat1.xzxz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _VertScale;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat2;
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
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_VertScale<0.0);
#else
    u_xlatb0 = _VertScale<0.0;
#endif
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = (-u_xlat1.y) + 1.0;
    u_xlat1.z = (u_xlatb0) ? u_xlat2 : u_xlat1.y;
    vs_TEXCOORD0 = u_xlat1.xzxz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _VertScale;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat2;
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
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_VertScale<0.0);
#else
    u_xlatb0 = _VertScale<0.0;
#endif
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = (-u_xlat1.y) + 1.0;
    u_xlat1.z = (u_xlatb0) ? u_xlat2 : u_xlat1.y;
    vs_TEXCOORD0 = u_xlat1.xzxz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_NONE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _VertScale;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat2;
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
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_VertScale<0.0);
#else
    u_xlatb0 = _VertScale<0.0;
#endif
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = (-u_xlat1.y) + 1.0;
    u_xlat1.z = (u_xlatb0) ? u_xlat2 : u_xlat1.y;
    vs_TEXCOORD0 = u_xlat1.xzxz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat0.w = 1.0;
    SV_Target0 = u_xlat0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_NONE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _VertScale;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat2;
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
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_VertScale<0.0);
#else
    u_xlatb0 = _VertScale<0.0;
#endif
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = (-u_xlat1.y) + 1.0;
    u_xlat1.z = (u_xlatb0) ? u_xlat2 : u_xlat1.y;
    vs_TEXCOORD0 = u_xlat1.xzxz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat0.w = 1.0;
    SV_Target0 = u_xlat0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_NONE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _VertScale;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat2;
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
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_VertScale<0.0);
#else
    u_xlatb0 = _VertScale<0.0;
#endif
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = (-u_xlat1.y) + 1.0;
    u_xlat1.z = (u_xlatb0) ? u_xlat2 : u_xlat1.y;
    vs_TEXCOORD0 = u_xlat1.xzxz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat0.w = 1.0;
    SV_Target0 = u_xlat0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _VertScale;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat2;
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
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_VertScale<0.0);
#else
    u_xlatb0 = _VertScale<0.0;
#endif
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = (-u_xlat1.y) + 1.0;
    u_xlat1.z = (u_xlatb0) ? u_xlat2 : u_xlat1.y;
    vs_TEXCOORD0 = u_xlat1.xzxz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    SV_Target0 = u_xlat0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _VertScale;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat2;
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
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_VertScale<0.0);
#else
    u_xlatb0 = _VertScale<0.0;
#endif
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = (-u_xlat1.y) + 1.0;
    u_xlat1.z = (u_xlatb0) ? u_xlat2 : u_xlat1.y;
    vs_TEXCOORD0 = u_xlat1.xzxz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    SV_Target0 = u_xlat0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _VertScale;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat2;
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
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_VertScale<0.0);
#else
    u_xlatb0 = _VertScale<0.0;
#endif
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = (-u_xlat1.y) + 1.0;
    u_xlat1.z = (u_xlatb0) ? u_xlat2 : u_xlat1.y;
    vs_TEXCOORD0 = u_xlat1.xzxz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    SV_Target0 = u_xlat0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_NONE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _VertScale;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat2;
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
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_VertScale<0.0);
#else
    u_xlatb0 = _VertScale<0.0;
#endif
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = (-u_xlat1.y) + 1.0;
    u_xlat1.z = (u_xlatb0) ? u_xlat2 : u_xlat1.y;
    vs_TEXCOORD0 = u_xlat1.xzxz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.w = 1.0;
    SV_Target0 = u_xlat0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_NONE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _VertScale;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat2;
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
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_VertScale<0.0);
#else
    u_xlatb0 = _VertScale<0.0;
#endif
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = (-u_xlat1.y) + 1.0;
    u_xlat1.z = (u_xlatb0) ? u_xlat2 : u_xlat1.y;
    vs_TEXCOORD0 = u_xlat1.xzxz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.w = 1.0;
    SV_Target0 = u_xlat0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_NONE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _VertScale;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat2;
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
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_VertScale<0.0);
#else
    u_xlatb0 = _VertScale<0.0;
#endif
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = (-u_xlat1.y) + 1.0;
    u_xlat1.z = (u_xlatb0) ? u_xlat2 : u_xlat1.y;
    vs_TEXCOORD0 = u_xlat1.xzxz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.w = 1.0;
    SV_Target0 = u_xlat0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _VertScale;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
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
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_VertScale<0.0);
#else
    u_xlatb0 = _VertScale<0.0;
#endif
    u_xlat3.x = _MainTex_TexelSize.y * 1.5;
    u_xlat6 = _MainTex_TexelSize.y * -3.0 + 0.5;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.x = u_xlat1.y * u_xlat6 + u_xlat3.x;
    u_xlat2.yz = u_xlat2.xx + vec2(0.5, 0.5);
    u_xlat3.xy = (-u_xlat2.yx) + vec2(1.0, 1.0);
    u_xlat1.zw = (bool(u_xlatb0)) ? u_xlat3.xy : u_xlat2.zx;
    vs_TEXCOORD0 = u_xlat1.xzxw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1 = u_xlat10_0.y + u_xlat10_0.x;
    u_xlat16_1 = u_xlat10_0.z + u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * 0.333333343;
    SV_Target0.w = u_xlat16_1 * vs_COLOR0.w;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _VertScale;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
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
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_VertScale<0.0);
#else
    u_xlatb0 = _VertScale<0.0;
#endif
    u_xlat3.x = _MainTex_TexelSize.y * 1.5;
    u_xlat6 = _MainTex_TexelSize.y * -3.0 + 0.5;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.x = u_xlat1.y * u_xlat6 + u_xlat3.x;
    u_xlat2.yz = u_xlat2.xx + vec2(0.5, 0.5);
    u_xlat3.xy = (-u_xlat2.yx) + vec2(1.0, 1.0);
    u_xlat1.zw = (bool(u_xlatb0)) ? u_xlat3.xy : u_xlat2.zx;
    vs_TEXCOORD0 = u_xlat1.xzxw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1 = u_xlat10_0.y + u_xlat10_0.x;
    u_xlat16_1 = u_xlat10_0.z + u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * 0.333333343;
    SV_Target0.w = u_xlat16_1 * vs_COLOR0.w;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _VertScale;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
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
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_VertScale<0.0);
#else
    u_xlatb0 = _VertScale<0.0;
#endif
    u_xlat3.x = _MainTex_TexelSize.y * 1.5;
    u_xlat6 = _MainTex_TexelSize.y * -3.0 + 0.5;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.x = u_xlat1.y * u_xlat6 + u_xlat3.x;
    u_xlat2.yz = u_xlat2.xx + vec2(0.5, 0.5);
    u_xlat3.xy = (-u_xlat2.yx) + vec2(1.0, 1.0);
    u_xlat1.zw = (bool(u_xlatb0)) ? u_xlat3.xy : u_xlat2.zx;
    vs_TEXCOORD0 = u_xlat1.xzxw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1 = u_xlat10_0.y + u_xlat10_0.x;
    u_xlat16_1 = u_xlat10_0.z + u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * 0.333333343;
    SV_Target0.w = u_xlat16_1 * vs_COLOR0.w;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _VertScale;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
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
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_VertScale<0.0);
#else
    u_xlatb0 = _VertScale<0.0;
#endif
    u_xlat3.x = _MainTex_TexelSize.y * 1.5;
    u_xlat6 = _MainTex_TexelSize.y * -3.0 + 0.5;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.x = u_xlat1.y * u_xlat6 + u_xlat3.x;
    u_xlat2.yz = u_xlat2.xx + vec2(0.5, 0.5);
    u_xlat3.xy = (-u_xlat2.yx) + vec2(1.0, 1.0);
    u_xlat1.zw = (bool(u_xlatb0)) ? u_xlat3.xy : u_xlat2.zx;
    vs_TEXCOORD0 = u_xlat1.xzxw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.zw).x;
    u_xlat16_1 = u_xlat10_1 + -0.0625;
    u_xlat0.w = u_xlat16_1 * 1.16438353;
    SV_Target0 = u_xlat0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _VertScale;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
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
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_VertScale<0.0);
#else
    u_xlatb0 = _VertScale<0.0;
#endif
    u_xlat3.x = _MainTex_TexelSize.y * 1.5;
    u_xlat6 = _MainTex_TexelSize.y * -3.0 + 0.5;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.x = u_xlat1.y * u_xlat6 + u_xlat3.x;
    u_xlat2.yz = u_xlat2.xx + vec2(0.5, 0.5);
    u_xlat3.xy = (-u_xlat2.yx) + vec2(1.0, 1.0);
    u_xlat1.zw = (bool(u_xlatb0)) ? u_xlat3.xy : u_xlat2.zx;
    vs_TEXCOORD0 = u_xlat1.xzxw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.zw).x;
    u_xlat16_1 = u_xlat10_1 + -0.0625;
    u_xlat0.w = u_xlat16_1 * 1.16438353;
    SV_Target0 = u_xlat0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _VertScale;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
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
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_VertScale<0.0);
#else
    u_xlatb0 = _VertScale<0.0;
#endif
    u_xlat3.x = _MainTex_TexelSize.y * 1.5;
    u_xlat6 = _MainTex_TexelSize.y * -3.0 + 0.5;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.x = u_xlat1.y * u_xlat6 + u_xlat3.x;
    u_xlat2.yz = u_xlat2.xx + vec2(0.5, 0.5);
    u_xlat3.xy = (-u_xlat2.yx) + vec2(1.0, 1.0);
    u_xlat1.zw = (bool(u_xlatb0)) ? u_xlat3.xy : u_xlat2.zx;
    vs_TEXCOORD0 = u_xlat1.xzxw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.zw).x;
    u_xlat16_1 = u_xlat10_1 + -0.0625;
    u_xlat0.w = u_xlat16_1 * 1.16438353;
    SV_Target0 = u_xlat0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _VertScale;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
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
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_VertScale<0.0);
#else
    u_xlatb0 = _VertScale<0.0;
#endif
    u_xlat3.x = _MainTex_TexelSize.y * 1.5;
    u_xlat6 = _MainTex_TexelSize.y * -3.0 + 0.5;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.x = u_xlat1.y * u_xlat6 + u_xlat3.x;
    u_xlat2.yz = u_xlat2.xx + vec2(0.5, 0.5);
    u_xlat3.xy = (-u_xlat2.yx) + vec2(1.0, 1.0);
    u_xlat1.zw = (bool(u_xlatb0)) ? u_xlat3.xy : u_xlat2.zx;
    vs_TEXCOORD0 = u_xlat1.xzxw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_2;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_2 = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_2 = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_2;
    u_xlat16_2 = u_xlat16_2 * 0.333333343;
    SV_Target0.w = u_xlat16_2 * vs_COLOR0.w;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_0.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _VertScale;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
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
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_VertScale<0.0);
#else
    u_xlatb0 = _VertScale<0.0;
#endif
    u_xlat3.x = _MainTex_TexelSize.y * 1.5;
    u_xlat6 = _MainTex_TexelSize.y * -3.0 + 0.5;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.x = u_xlat1.y * u_xlat6 + u_xlat3.x;
    u_xlat2.yz = u_xlat2.xx + vec2(0.5, 0.5);
    u_xlat3.xy = (-u_xlat2.yx) + vec2(1.0, 1.0);
    u_xlat1.zw = (bool(u_xlatb0)) ? u_xlat3.xy : u_xlat2.zx;
    vs_TEXCOORD0 = u_xlat1.xzxw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_2;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_2 = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_2 = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_2;
    u_xlat16_2 = u_xlat16_2 * 0.333333343;
    SV_Target0.w = u_xlat16_2 * vs_COLOR0.w;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_0.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _VertScale;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
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
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_VertScale<0.0);
#else
    u_xlatb0 = _VertScale<0.0;
#endif
    u_xlat3.x = _MainTex_TexelSize.y * 1.5;
    u_xlat6 = _MainTex_TexelSize.y * -3.0 + 0.5;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.x = u_xlat1.y * u_xlat6 + u_xlat3.x;
    u_xlat2.yz = u_xlat2.xx + vec2(0.5, 0.5);
    u_xlat3.xy = (-u_xlat2.yx) + vec2(1.0, 1.0);
    u_xlat1.zw = (bool(u_xlatb0)) ? u_xlat3.xy : u_xlat2.zx;
    vs_TEXCOORD0 = u_xlat1.xzxw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_2;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_2 = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_2 = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_2;
    u_xlat16_2 = u_xlat16_2 * 0.333333343;
    SV_Target0.w = u_xlat16_2 * vs_COLOR0.w;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_0.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _VertScale;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
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
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_VertScale<0.0);
#else
    u_xlatb0 = _VertScale<0.0;
#endif
    u_xlat3.x = _MainTex_TexelSize.y * 1.5;
    u_xlat6 = _MainTex_TexelSize.y * -3.0 + 0.5;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.x = u_xlat1.y * u_xlat6 + u_xlat3.x;
    u_xlat2.yz = u_xlat2.xx + vec2(0.5, 0.5);
    u_xlat3.xy = (-u_xlat2.yx) + vec2(1.0, 1.0);
    u_xlat1.zw = (bool(u_xlatb0)) ? u_xlat3.xy : u_xlat2.zx;
    vs_TEXCOORD0 = u_xlat1.xzxw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.zw).x;
    u_xlat16_1 = u_xlat10_1 + -0.0625;
    u_xlat0.w = u_xlat16_1 * 1.16438353;
    SV_Target0 = u_xlat0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _VertScale;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
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
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_VertScale<0.0);
#else
    u_xlatb0 = _VertScale<0.0;
#endif
    u_xlat3.x = _MainTex_TexelSize.y * 1.5;
    u_xlat6 = _MainTex_TexelSize.y * -3.0 + 0.5;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.x = u_xlat1.y * u_xlat6 + u_xlat3.x;
    u_xlat2.yz = u_xlat2.xx + vec2(0.5, 0.5);
    u_xlat3.xy = (-u_xlat2.yx) + vec2(1.0, 1.0);
    u_xlat1.zw = (bool(u_xlatb0)) ? u_xlat3.xy : u_xlat2.zx;
    vs_TEXCOORD0 = u_xlat1.xzxw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.zw).x;
    u_xlat16_1 = u_xlat10_1 + -0.0625;
    u_xlat0.w = u_xlat16_1 * 1.16438353;
    SV_Target0 = u_xlat0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _VertScale;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
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
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_VertScale<0.0);
#else
    u_xlatb0 = _VertScale<0.0;
#endif
    u_xlat3.x = _MainTex_TexelSize.y * 1.5;
    u_xlat6 = _MainTex_TexelSize.y * -3.0 + 0.5;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.x = u_xlat1.y * u_xlat6 + u_xlat3.x;
    u_xlat2.yz = u_xlat2.xx + vec2(0.5, 0.5);
    u_xlat3.xy = (-u_xlat2.yx) + vec2(1.0, 1.0);
    u_xlat1.zw = (bool(u_xlatb0)) ? u_xlat3.xy : u_xlat2.zx;
    vs_TEXCOORD0 = u_xlat1.xzxw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.zw).x;
    u_xlat16_1 = u_xlat10_1 + -0.0625;
    u_xlat0.w = u_xlat16_1 * 1.16438353;
    SV_Target0 = u_xlat0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _VertScale;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
float u_xlat6;
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
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_VertScale<0.0);
#else
    u_xlatb0 = _VertScale<0.0;
#endif
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat6 = (-u_xlat2.y) + 1.0;
    vs_TEXCOORD0.yw = (bool(u_xlatb0)) ? vec2(u_xlat6) : u_xlat2.yy;
    u_xlat0.x = _MainTex_TexelSize.x * 1.5;
    u_xlat4 = _MainTex_TexelSize.x * -3.0 + 0.5;
    u_xlat0.x = u_xlat2.x * u_xlat4 + u_xlat0.x;
    vs_TEXCOORD0.z = u_xlat0.x + 0.5;
    vs_TEXCOORD0.x = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1 = u_xlat10_0.y + u_xlat10_0.x;
    u_xlat16_1 = u_xlat10_0.z + u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * 0.333333343;
    SV_Target0.w = u_xlat16_1 * vs_COLOR0.w;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _VertScale;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
float u_xlat6;
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
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_VertScale<0.0);
#else
    u_xlatb0 = _VertScale<0.0;
#endif
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat6 = (-u_xlat2.y) + 1.0;
    vs_TEXCOORD0.yw = (bool(u_xlatb0)) ? vec2(u_xlat6) : u_xlat2.yy;
    u_xlat0.x = _MainTex_TexelSize.x * 1.5;
    u_xlat4 = _MainTex_TexelSize.x * -3.0 + 0.5;
    u_xlat0.x = u_xlat2.x * u_xlat4 + u_xlat0.x;
    vs_TEXCOORD0.z = u_xlat0.x + 0.5;
    vs_TEXCOORD0.x = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1 = u_xlat10_0.y + u_xlat10_0.x;
    u_xlat16_1 = u_xlat10_0.z + u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * 0.333333343;
    SV_Target0.w = u_xlat16_1 * vs_COLOR0.w;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _VertScale;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
float u_xlat6;
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
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_VertScale<0.0);
#else
    u_xlatb0 = _VertScale<0.0;
#endif
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat6 = (-u_xlat2.y) + 1.0;
    vs_TEXCOORD0.yw = (bool(u_xlatb0)) ? vec2(u_xlat6) : u_xlat2.yy;
    u_xlat0.x = _MainTex_TexelSize.x * 1.5;
    u_xlat4 = _MainTex_TexelSize.x * -3.0 + 0.5;
    u_xlat0.x = u_xlat2.x * u_xlat4 + u_xlat0.x;
    vs_TEXCOORD0.z = u_xlat0.x + 0.5;
    vs_TEXCOORD0.x = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1 = u_xlat10_0.y + u_xlat10_0.x;
    u_xlat16_1 = u_xlat10_0.z + u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * 0.333333343;
    SV_Target0.w = u_xlat16_1 * vs_COLOR0.w;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _VertScale;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
float u_xlat6;
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
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_VertScale<0.0);
#else
    u_xlatb0 = _VertScale<0.0;
#endif
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat6 = (-u_xlat2.y) + 1.0;
    vs_TEXCOORD0.yw = (bool(u_xlatb0)) ? vec2(u_xlat6) : u_xlat2.yy;
    u_xlat0.x = _MainTex_TexelSize.x * 1.5;
    u_xlat4 = _MainTex_TexelSize.x * -3.0 + 0.5;
    u_xlat0.x = u_xlat2.x * u_xlat4 + u_xlat0.x;
    vs_TEXCOORD0.z = u_xlat0.x + 0.5;
    vs_TEXCOORD0.x = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.zw).x;
    u_xlat16_1 = u_xlat10_1 + -0.0625;
    u_xlat0.w = u_xlat16_1 * 1.16438353;
    SV_Target0 = u_xlat0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _VertScale;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
float u_xlat6;
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
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_VertScale<0.0);
#else
    u_xlatb0 = _VertScale<0.0;
#endif
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat6 = (-u_xlat2.y) + 1.0;
    vs_TEXCOORD0.yw = (bool(u_xlatb0)) ? vec2(u_xlat6) : u_xlat2.yy;
    u_xlat0.x = _MainTex_TexelSize.x * 1.5;
    u_xlat4 = _MainTex_TexelSize.x * -3.0 + 0.5;
    u_xlat0.x = u_xlat2.x * u_xlat4 + u_xlat0.x;
    vs_TEXCOORD0.z = u_xlat0.x + 0.5;
    vs_TEXCOORD0.x = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.zw).x;
    u_xlat16_1 = u_xlat10_1 + -0.0625;
    u_xlat0.w = u_xlat16_1 * 1.16438353;
    SV_Target0 = u_xlat0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _VertScale;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
float u_xlat6;
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
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_VertScale<0.0);
#else
    u_xlatb0 = _VertScale<0.0;
#endif
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat6 = (-u_xlat2.y) + 1.0;
    vs_TEXCOORD0.yw = (bool(u_xlatb0)) ? vec2(u_xlat6) : u_xlat2.yy;
    u_xlat0.x = _MainTex_TexelSize.x * 1.5;
    u_xlat4 = _MainTex_TexelSize.x * -3.0 + 0.5;
    u_xlat0.x = u_xlat2.x * u_xlat4 + u_xlat0.x;
    vs_TEXCOORD0.z = u_xlat0.x + 0.5;
    vs_TEXCOORD0.x = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.zw).x;
    u_xlat16_1 = u_xlat10_1 + -0.0625;
    u_xlat0.w = u_xlat16_1 * 1.16438353;
    SV_Target0 = u_xlat0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _VertScale;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
float u_xlat6;
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
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_VertScale<0.0);
#else
    u_xlatb0 = _VertScale<0.0;
#endif
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat6 = (-u_xlat2.y) + 1.0;
    vs_TEXCOORD0.yw = (bool(u_xlatb0)) ? vec2(u_xlat6) : u_xlat2.yy;
    u_xlat0.x = _MainTex_TexelSize.x * 1.5;
    u_xlat4 = _MainTex_TexelSize.x * -3.0 + 0.5;
    u_xlat0.x = u_xlat2.x * u_xlat4 + u_xlat0.x;
    vs_TEXCOORD0.z = u_xlat0.x + 0.5;
    vs_TEXCOORD0.x = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_2;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_2 = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_2 = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_2;
    u_xlat16_2 = u_xlat16_2 * 0.333333343;
    SV_Target0.w = u_xlat16_2 * vs_COLOR0.w;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_0.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _VertScale;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
float u_xlat6;
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
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_VertScale<0.0);
#else
    u_xlatb0 = _VertScale<0.0;
#endif
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat6 = (-u_xlat2.y) + 1.0;
    vs_TEXCOORD0.yw = (bool(u_xlatb0)) ? vec2(u_xlat6) : u_xlat2.yy;
    u_xlat0.x = _MainTex_TexelSize.x * 1.5;
    u_xlat4 = _MainTex_TexelSize.x * -3.0 + 0.5;
    u_xlat0.x = u_xlat2.x * u_xlat4 + u_xlat0.x;
    vs_TEXCOORD0.z = u_xlat0.x + 0.5;
    vs_TEXCOORD0.x = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_2;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_2 = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_2 = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_2;
    u_xlat16_2 = u_xlat16_2 * 0.333333343;
    SV_Target0.w = u_xlat16_2 * vs_COLOR0.w;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_0.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _VertScale;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
float u_xlat6;
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
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_VertScale<0.0);
#else
    u_xlatb0 = _VertScale<0.0;
#endif
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat6 = (-u_xlat2.y) + 1.0;
    vs_TEXCOORD0.yw = (bool(u_xlatb0)) ? vec2(u_xlat6) : u_xlat2.yy;
    u_xlat0.x = _MainTex_TexelSize.x * 1.5;
    u_xlat4 = _MainTex_TexelSize.x * -3.0 + 0.5;
    u_xlat0.x = u_xlat2.x * u_xlat4 + u_xlat0.x;
    vs_TEXCOORD0.z = u_xlat0.x + 0.5;
    vs_TEXCOORD0.x = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_2;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_2 = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_2 = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_2;
    u_xlat16_2 = u_xlat16_2 * 0.333333343;
    SV_Target0.w = u_xlat16_2 * vs_COLOR0.w;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_0.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _VertScale;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
float u_xlat6;
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
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_VertScale<0.0);
#else
    u_xlatb0 = _VertScale<0.0;
#endif
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat6 = (-u_xlat2.y) + 1.0;
    vs_TEXCOORD0.yw = (bool(u_xlatb0)) ? vec2(u_xlat6) : u_xlat2.yy;
    u_xlat0.x = _MainTex_TexelSize.x * 1.5;
    u_xlat4 = _MainTex_TexelSize.x * -3.0 + 0.5;
    u_xlat0.x = u_xlat2.x * u_xlat4 + u_xlat0.x;
    vs_TEXCOORD0.z = u_xlat0.x + 0.5;
    vs_TEXCOORD0.x = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.zw).x;
    u_xlat16_1 = u_xlat10_1 + -0.0625;
    u_xlat0.w = u_xlat16_1 * 1.16438353;
    SV_Target0 = u_xlat0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _VertScale;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
float u_xlat6;
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
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_VertScale<0.0);
#else
    u_xlatb0 = _VertScale<0.0;
#endif
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat6 = (-u_xlat2.y) + 1.0;
    vs_TEXCOORD0.yw = (bool(u_xlatb0)) ? vec2(u_xlat6) : u_xlat2.yy;
    u_xlat0.x = _MainTex_TexelSize.x * 1.5;
    u_xlat4 = _MainTex_TexelSize.x * -3.0 + 0.5;
    u_xlat0.x = u_xlat2.x * u_xlat4 + u_xlat0.x;
    vs_TEXCOORD0.z = u_xlat0.x + 0.5;
    vs_TEXCOORD0.x = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.zw).x;
    u_xlat16_1 = u_xlat10_1 + -0.0625;
    u_xlat0.w = u_xlat16_1 * 1.16438353;
    SV_Target0 = u_xlat0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _VertScale;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
float u_xlat6;
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
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_VertScale<0.0);
#else
    u_xlatb0 = _VertScale<0.0;
#endif
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat6 = (-u_xlat2.y) + 1.0;
    vs_TEXCOORD0.yw = (bool(u_xlatb0)) ? vec2(u_xlat6) : u_xlat2.yy;
    u_xlat0.x = _MainTex_TexelSize.x * 1.5;
    u_xlat4 = _MainTex_TexelSize.x * -3.0 + 0.5;
    u_xlat0.x = u_xlat2.x * u_xlat4 + u_xlat0.x;
    vs_TEXCOORD0.z = u_xlat0.x + 0.5;
    vs_TEXCOORD0.x = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_YpCbCrTransform[4];
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChromaTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
float u_xlat2;
lowp vec2 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 + hlslcc_mtx4x4_YpCbCrTransform[0].w;
    u_xlat10_2.xy = texture(_ChromaTex, vs_TEXCOORD0.xy).xy;
    u_xlat2 = u_xlat10_2.x + hlslcc_mtx4x4_YpCbCrTransform[1].w;
    u_xlat4 = u_xlat10_2.y + hlslcc_mtx4x4_YpCbCrTransform[2].w;
    u_xlat1.xyz = vec3(u_xlat2) * hlslcc_mtx4x4_YpCbCrTransform[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_YpCbCrTransform[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_YpCbCrTransform[2].xyz * vec3(u_xlat4) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.zw).x;
    u_xlat16_1 = u_xlat10_1 + -0.0625;
    u_xlat0.w = u_xlat16_1 * 1.16438353;
    SV_Target0 = u_xlat0 * vs_COLOR0;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_NONE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_NONE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_NONE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_NONE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_NONE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_NONE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" }
""
}
}
}
}
}