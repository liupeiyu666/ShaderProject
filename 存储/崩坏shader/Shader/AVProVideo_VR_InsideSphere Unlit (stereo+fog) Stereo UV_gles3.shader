//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "AVProVideo/VR/InsideSphere Unlit (stereo+fog) Stereo UV" {
Properties {
_MainTex ("Texture", 2D) = "black" { }
[Toggle(STEREO_DEBUG)] _StereoDebug ("Stereo Debug Tinting", Float) = 0
[Toggle(APPLY_GAMMA)] _ApplyGamma ("Apply Gamma", Float) = 0
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Background" "RenderType" = "Opaque" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Background" "RenderType" = "Opaque" }
  Cull Front
  GpuProgramID 48119
Program "vp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "STEREO_DEBUG_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat3.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x<u_xlat0.y;
#endif
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.z = (-u_xlat1.x) + 1.0;
    u_xlat2.xy = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.z = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD0.xy = (bool(u_xlatb0)) ? u_xlat1.zy : u_xlat2.zy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "STEREO_DEBUG_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat3.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x<u_xlat0.y;
#endif
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.z = (-u_xlat1.x) + 1.0;
    u_xlat2.xy = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.z = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD0.xy = (bool(u_xlatb0)) ? u_xlat1.zy : u_xlat2.zy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "STEREO_DEBUG_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat3.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x<u_xlat0.y;
#endif
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.z = (-u_xlat1.x) + 1.0;
    u_xlat2.xy = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.z = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD0.xy = (bool(u_xlatb0)) ? u_xlat1.zy : u_xlat2.zy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "STEREO_DEBUG_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat3.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x<u_xlat0.y;
#endif
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.z = (-u_xlat1.x) + 1.0;
    u_xlat2.xy = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.z = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD0.xy = (bool(u_xlatb0)) ? u_xlat1.zy : u_xlat2.zy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_0.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "STEREO_DEBUG_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat3.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x<u_xlat0.y;
#endif
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.z = (-u_xlat1.x) + 1.0;
    u_xlat2.xy = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.z = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD0.xy = (bool(u_xlatb0)) ? u_xlat1.zy : u_xlat2.zy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_0.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "STEREO_DEBUG_OFF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat3.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x<u_xlat0.y;
#endif
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.z = (-u_xlat1.x) + 1.0;
    u_xlat2.xy = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.z = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD0.xy = (bool(u_xlatb0)) ? u_xlat1.zy : u_xlat2.zy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_0.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "STEREO_DEBUG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat3.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x<u_xlat0.y;
#endif
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.z = (-u_xlat1.x) + 1.0;
    u_xlat2.xy = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.z = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD0.xy = (bool(u_xlatb0)) ? u_xlat1.zy : u_xlat2.zy;
    vs_COLOR0 = vec4(1.0, 1.0, 1.0, 1.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "STEREO_DEBUG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat3.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x<u_xlat0.y;
#endif
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.z = (-u_xlat1.x) + 1.0;
    u_xlat2.xy = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.z = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD0.xy = (bool(u_xlatb0)) ? u_xlat1.zy : u_xlat2.zy;
    vs_COLOR0 = vec4(1.0, 1.0, 1.0, 1.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "STEREO_DEBUG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat3.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x<u_xlat0.y;
#endif
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.z = (-u_xlat1.x) + 1.0;
    u_xlat2.xy = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.z = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD0.xy = (bool(u_xlatb0)) ? u_xlat1.zy : u_xlat2.zy;
    vs_COLOR0 = vec4(1.0, 1.0, 1.0, 1.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "STEREO_DEBUG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat3.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x<u_xlat0.y;
#endif
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.z = (-u_xlat1.x) + 1.0;
    u_xlat2.xy = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.z = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD0.xy = (bool(u_xlatb0)) ? u_xlat1.zy : u_xlat2.zy;
    vs_COLOR0 = vec4(1.0, 1.0, 1.0, 1.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_0.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "STEREO_DEBUG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat3.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x<u_xlat0.y;
#endif
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.z = (-u_xlat1.x) + 1.0;
    u_xlat2.xy = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.z = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD0.xy = (bool(u_xlatb0)) ? u_xlat1.zy : u_xlat2.zy;
    vs_COLOR0 = vec4(1.0, 1.0, 1.0, 1.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_0.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "STEREO_DEBUG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _cameraPosition;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
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
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat1.xyz = u_xlat0.xyz + _cameraPosition.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _cameraPosition.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat3.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<u_xlat0.y);
#else
    u_xlatb0 = u_xlat0.x<u_xlat0.y;
#endif
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.z = (-u_xlat1.x) + 1.0;
    u_xlat2.xy = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.z = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD0.xy = (bool(u_xlatb0)) ? u_xlat1.zy : u_xlat2.zy;
    vs_COLOR0 = vec4(1.0, 1.0, 1.0, 1.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_0.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "STEREO_DEBUG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "STEREO_DEBUG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "STEREO_DEBUG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "APPLY_GAMMA" "STEREO_DEBUG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "APPLY_GAMMA" "STEREO_DEBUG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "APPLY_GAMMA" "STEREO_DEBUG" }
""
}
}
}
}
}