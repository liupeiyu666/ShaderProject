//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_ParticleNew/Effect_AirWall_New" {
Properties {
_MainTex ("MainTex", 2D) = "white" { }
_UvTilling ("UvTilling", Vector) = (200,25,0,0)
_MainIntensity ("MainIntensity", Float) = 1
_MainColor ("MainColor", Color) = (0,0,0,0)
_BackIntensity ("BackIntensity", Float) = 1
_BackColor ("BackColor", Color) = (0,0,0,0)
_Range ("Range", Range(-10, 0)) = -2.6
_RangeWidth ("RangeWidth", Range(0, 10)) = 5
_UVTexture ("UVTexture", 2D) = "white" { }
_Position ("Position", Vector) = (0.2,0.39,0,0)
_AirWallPosition ("AirWallPosition", Vector) = (0,0,0,0)
_Distance ("Distance", Float) = 0
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 6411
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
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
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD3 = in_POSITION0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec3 _Position;
uniform 	float _UpOffset;
uniform 	vec3 _AirWallPosition;
uniform 	vec2 _UvTilling;
uniform 	float _Range;
uniform 	float _RangeWidth;
uniform 	vec4 _MainColor;
uniform 	float _MainIntensity;
uniform 	vec4 _BackColor;
uniform 	float _BackIntensity;
uniform 	float _Distance;
uniform lowp sampler2D _UVTexture;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec2 u_xlat16_2;
float u_xlat6;
vec2 u_xlat7;
lowp vec2 u_xlat10_7;
float u_xlat9;
void main()
{
    u_xlat0 = vs_TEXCOORD3.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vs_TEXCOORD3.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * vs_TEXCOORD3.zzzz + u_xlat0;
    u_xlat0.xyz = (-u_xlat0.xyz) + _Position.xyz;
    u_xlat0.w = (-u_xlat0.w);
    u_xlat0 = (-_Position.yyyy) * vec4(vec4(_UpOffset, _UpOffset, _UpOffset, _UpOffset)) + u_xlat0;
    u_xlat1.xyz = (-_AirWallPosition.xyz);
    u_xlat1.w = -0.0;
    u_xlat0 = u_xlat0 + u_xlat1;
    u_xlat6 = dot(u_xlat0, u_xlat0);
    u_xlat6 = sqrt(u_xlat6);
    u_xlat6 = (-u_xlat6) * _Distance + 1.0;
    u_xlat6 = u_xlat6 + (-_Range);
    u_xlat9 = float(1.0) / _RangeWidth;
    u_xlat6 = u_xlat9 * u_xlat6;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat9 = u_xlat6 * -2.0 + 3.0;
    u_xlat6 = u_xlat6 * u_xlat6;
    u_xlat6 = u_xlat6 * u_xlat9;
    u_xlat6 = min(u_xlat6, 1.0);
    u_xlat1.xy = vs_TEXCOORD0.xy * _UvTilling.xy;
    u_xlat10_7.xy = texture(_UVTexture, u_xlat1.xy).xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat1.xy = texture(_UVTexture, u_xlat1.xy).xy;
    u_xlatb1.xy = greaterThanEqual(vec4(0.5, 0.5, 0.0, 0.0), u_xlat1.yxyy).xy;
    u_xlat1.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb1.xy));
    u_xlat16_2.xy = (-u_xlat10_7.xy) + vec2(0.5, 0.5);
    u_xlat7.xy = vec2(u_xlat6) * u_xlat16_2.xy + u_xlat10_7.xy;
    u_xlat10_7.xy = texture(_MainTex, u_xlat7.xy).xy;
    u_xlat9 = (-u_xlat1.x) * u_xlat1.y + 1.0;
    u_xlat1.x = u_xlat1.y * u_xlat1.x;
    u_xlat9 = u_xlat10_7.y * u_xlat9;
    u_xlat9 = u_xlat1.x * u_xlat10_7.x + u_xlat9;
    u_xlat6 = u_xlat6 * u_xlat9;
    u_xlat0.x = 0.0;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD1.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy).z;
    SV_Target0.w = u_xlat6 * u_xlat10_0;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = _MainColor.xyz * vec3(_MainIntensity);
    u_xlat1.xyz = _BackColor.xyz * vec3(_BackIntensity);
    u_xlat0.xyz = (uint((gl_FrontFacing ? 0xffffffffu : uint(0))) != uint(0u)) ? u_xlat0.xyz : u_xlat1.xyz;
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
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
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
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD3 = in_POSITION0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec3 _Position;
uniform 	float _UpOffset;
uniform 	vec3 _AirWallPosition;
uniform 	vec2 _UvTilling;
uniform 	float _Range;
uniform 	float _RangeWidth;
uniform 	vec4 _MainColor;
uniform 	float _MainIntensity;
uniform 	vec4 _BackColor;
uniform 	float _BackIntensity;
uniform 	float _Distance;
uniform lowp sampler2D _UVTexture;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec2 u_xlat16_2;
float u_xlat6;
vec2 u_xlat7;
lowp vec2 u_xlat10_7;
float u_xlat9;
void main()
{
    u_xlat0 = vs_TEXCOORD3.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vs_TEXCOORD3.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * vs_TEXCOORD3.zzzz + u_xlat0;
    u_xlat0.xyz = (-u_xlat0.xyz) + _Position.xyz;
    u_xlat0.w = (-u_xlat0.w);
    u_xlat0 = (-_Position.yyyy) * vec4(vec4(_UpOffset, _UpOffset, _UpOffset, _UpOffset)) + u_xlat0;
    u_xlat1.xyz = (-_AirWallPosition.xyz);
    u_xlat1.w = -0.0;
    u_xlat0 = u_xlat0 + u_xlat1;
    u_xlat6 = dot(u_xlat0, u_xlat0);
    u_xlat6 = sqrt(u_xlat6);
    u_xlat6 = (-u_xlat6) * _Distance + 1.0;
    u_xlat6 = u_xlat6 + (-_Range);
    u_xlat9 = float(1.0) / _RangeWidth;
    u_xlat6 = u_xlat9 * u_xlat6;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat9 = u_xlat6 * -2.0 + 3.0;
    u_xlat6 = u_xlat6 * u_xlat6;
    u_xlat6 = u_xlat6 * u_xlat9;
    u_xlat6 = min(u_xlat6, 1.0);
    u_xlat1.xy = vs_TEXCOORD0.xy * _UvTilling.xy;
    u_xlat10_7.xy = texture(_UVTexture, u_xlat1.xy).xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat1.xy = texture(_UVTexture, u_xlat1.xy).xy;
    u_xlatb1.xy = greaterThanEqual(vec4(0.5, 0.5, 0.0, 0.0), u_xlat1.yxyy).xy;
    u_xlat1.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb1.xy));
    u_xlat16_2.xy = (-u_xlat10_7.xy) + vec2(0.5, 0.5);
    u_xlat7.xy = vec2(u_xlat6) * u_xlat16_2.xy + u_xlat10_7.xy;
    u_xlat10_7.xy = texture(_MainTex, u_xlat7.xy).xy;
    u_xlat9 = (-u_xlat1.x) * u_xlat1.y + 1.0;
    u_xlat1.x = u_xlat1.y * u_xlat1.x;
    u_xlat9 = u_xlat10_7.y * u_xlat9;
    u_xlat9 = u_xlat1.x * u_xlat10_7.x + u_xlat9;
    u_xlat6 = u_xlat6 * u_xlat9;
    u_xlat0.x = 0.0;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD1.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy).z;
    SV_Target0.w = u_xlat6 * u_xlat10_0;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = _MainColor.xyz * vec3(_MainIntensity);
    u_xlat1.xyz = _BackColor.xyz * vec3(_BackIntensity);
    u_xlat0.xyz = (uint((gl_FrontFacing ? 0xffffffffu : uint(0))) != uint(0u)) ? u_xlat0.xyz : u_xlat1.xyz;
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
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
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
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD3 = in_POSITION0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec3 _Position;
uniform 	float _UpOffset;
uniform 	vec3 _AirWallPosition;
uniform 	vec2 _UvTilling;
uniform 	float _Range;
uniform 	float _RangeWidth;
uniform 	vec4 _MainColor;
uniform 	float _MainIntensity;
uniform 	vec4 _BackColor;
uniform 	float _BackIntensity;
uniform 	float _Distance;
uniform lowp sampler2D _UVTexture;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec2 u_xlat16_2;
float u_xlat6;
vec2 u_xlat7;
lowp vec2 u_xlat10_7;
float u_xlat9;
void main()
{
    u_xlat0 = vs_TEXCOORD3.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vs_TEXCOORD3.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * vs_TEXCOORD3.zzzz + u_xlat0;
    u_xlat0.xyz = (-u_xlat0.xyz) + _Position.xyz;
    u_xlat0.w = (-u_xlat0.w);
    u_xlat0 = (-_Position.yyyy) * vec4(vec4(_UpOffset, _UpOffset, _UpOffset, _UpOffset)) + u_xlat0;
    u_xlat1.xyz = (-_AirWallPosition.xyz);
    u_xlat1.w = -0.0;
    u_xlat0 = u_xlat0 + u_xlat1;
    u_xlat6 = dot(u_xlat0, u_xlat0);
    u_xlat6 = sqrt(u_xlat6);
    u_xlat6 = (-u_xlat6) * _Distance + 1.0;
    u_xlat6 = u_xlat6 + (-_Range);
    u_xlat9 = float(1.0) / _RangeWidth;
    u_xlat6 = u_xlat9 * u_xlat6;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat9 = u_xlat6 * -2.0 + 3.0;
    u_xlat6 = u_xlat6 * u_xlat6;
    u_xlat6 = u_xlat6 * u_xlat9;
    u_xlat6 = min(u_xlat6, 1.0);
    u_xlat1.xy = vs_TEXCOORD0.xy * _UvTilling.xy;
    u_xlat10_7.xy = texture(_UVTexture, u_xlat1.xy).xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat1.xy = texture(_UVTexture, u_xlat1.xy).xy;
    u_xlatb1.xy = greaterThanEqual(vec4(0.5, 0.5, 0.0, 0.0), u_xlat1.yxyy).xy;
    u_xlat1.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb1.xy));
    u_xlat16_2.xy = (-u_xlat10_7.xy) + vec2(0.5, 0.5);
    u_xlat7.xy = vec2(u_xlat6) * u_xlat16_2.xy + u_xlat10_7.xy;
    u_xlat10_7.xy = texture(_MainTex, u_xlat7.xy).xy;
    u_xlat9 = (-u_xlat1.x) * u_xlat1.y + 1.0;
    u_xlat1.x = u_xlat1.y * u_xlat1.x;
    u_xlat9 = u_xlat10_7.y * u_xlat9;
    u_xlat9 = u_xlat1.x * u_xlat10_7.x + u_xlat9;
    u_xlat6 = u_xlat6 * u_xlat9;
    u_xlat0.x = 0.0;
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD1.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy).z;
    SV_Target0.w = u_xlat6 * u_xlat10_0;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = _MainColor.xyz * vec3(_MainIntensity);
    u_xlat1.xyz = _BackColor.xyz * vec3(_BackIntensity);
    u_xlat0.xyz = (uint((gl_FrontFacing ? 0xffffffffu : uint(0))) != uint(0u)) ? u_xlat0.xyz : u_xlat1.xyz;
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
Fallback "Diffuse"
CustomEditor "MoleMole.ParticleShaderEditorBase"
}