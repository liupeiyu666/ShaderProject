//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_ParticleNew/FlipBook_New" {
Properties {
_MainTex ("MainTex", 2D) = "white" { }
[Enum(G,0,A,1)] _MainTexAlphaChannelToggle ("MainTexAlphaChannelToggle", Float) = 0
[Enum(Off, 0, On, 1)] _ZWrite ("ZWrite", Float) = 0
_MainColor ("MainColor", Color) = (0,0.8734226,1,0)
_mainUV ("mainUV", Vector) = (1,4,0,0)
_TimeCt ("TimeCt", Float) = 7.69
_Rotate ("Rotate", Float) = 1.57
_LightIntensity ("LightIntensity", Float) = 1
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 15535
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
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec2 _mainUV;
uniform 	float _TimeCt;
uniform 	float _Rotate;
uniform 	vec4 _MainColor;
uniform 	float _LightIntensity;
uniform 	mediump float _MainTexAlphaChannelToggle;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec2 u_xlat1;
float u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
vec2 u_xlat10;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.z * 5.0;
    u_xlat0.x = _Time.y * _TimeCt + u_xlat0.x;
    u_xlat5 = _mainUV.x * _mainUV.y + -1.0;
    u_xlat5 = min(u_xlat5, 4.0);
    u_xlat0.x = u_xlat5 + u_xlat0.x;
    u_xlat1.x = _mainUV.y * _mainUV.x;
    u_xlat0.x = u_xlat0.x / u_xlat1.x;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x) + 1.0;
    u_xlat1.y = _mainUV.y;
    u_xlat0.xy = u_xlat0.xy * u_xlat1.xy;
    u_xlat0.xy = floor(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy / _mainUV.xy;
    u_xlat10.xy = vs_TEXCOORD0.xy / _mainUV.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat10.xy;
    u_xlat1.x = sin(_Rotate);
    u_xlat2 = cos(_Rotate);
    u_xlat3.z = u_xlat1.x;
    u_xlat3.y = u_xlat2;
    u_xlat3.x = (-u_xlat1.x);
    u_xlat1.y = dot(u_xlat0.xy, u_xlat3.xy);
    u_xlat1.x = dot(u_xlat0.xy, u_xlat3.yz);
    u_xlat10_0 = texture(_MainTex, u_xlat1.xy);
    u_xlat1.xy = u_xlat10_0.xw * vs_COLOR0.ww;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_LightIntensity);
    u_xlat0.xyz = u_xlat0.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    u_xlatb0.xy = equal(vec4(vec4(_MainTexAlphaChannelToggle, _MainTexAlphaChannelToggle, _MainTexAlphaChannelToggle, _MainTexAlphaChannelToggle)), vec4(0.0, 1.0, 0.0, 0.0)).xy;
    u_xlat16_4 = (u_xlatb0.y) ? u_xlat1.y : 0.0;
    SV_Target0.w = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_4;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec2 _mainUV;
uniform 	float _TimeCt;
uniform 	float _Rotate;
uniform 	vec4 _MainColor;
uniform 	float _LightIntensity;
uniform 	mediump float _MainTexAlphaChannelToggle;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec2 u_xlat1;
float u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
vec2 u_xlat10;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.z * 5.0;
    u_xlat0.x = _Time.y * _TimeCt + u_xlat0.x;
    u_xlat5 = _mainUV.x * _mainUV.y + -1.0;
    u_xlat5 = min(u_xlat5, 4.0);
    u_xlat0.x = u_xlat5 + u_xlat0.x;
    u_xlat1.x = _mainUV.y * _mainUV.x;
    u_xlat0.x = u_xlat0.x / u_xlat1.x;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x) + 1.0;
    u_xlat1.y = _mainUV.y;
    u_xlat0.xy = u_xlat0.xy * u_xlat1.xy;
    u_xlat0.xy = floor(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy / _mainUV.xy;
    u_xlat10.xy = vs_TEXCOORD0.xy / _mainUV.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat10.xy;
    u_xlat1.x = sin(_Rotate);
    u_xlat2 = cos(_Rotate);
    u_xlat3.z = u_xlat1.x;
    u_xlat3.y = u_xlat2;
    u_xlat3.x = (-u_xlat1.x);
    u_xlat1.y = dot(u_xlat0.xy, u_xlat3.xy);
    u_xlat1.x = dot(u_xlat0.xy, u_xlat3.yz);
    u_xlat10_0 = texture(_MainTex, u_xlat1.xy);
    u_xlat1.xy = u_xlat10_0.xw * vs_COLOR0.ww;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_LightIntensity);
    u_xlat0.xyz = u_xlat0.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    u_xlatb0.xy = equal(vec4(vec4(_MainTexAlphaChannelToggle, _MainTexAlphaChannelToggle, _MainTexAlphaChannelToggle, _MainTexAlphaChannelToggle)), vec4(0.0, 1.0, 0.0, 0.0)).xy;
    u_xlat16_4 = (u_xlatb0.y) ? u_xlat1.y : 0.0;
    SV_Target0.w = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_4;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec2 _mainUV;
uniform 	float _TimeCt;
uniform 	float _Rotate;
uniform 	vec4 _MainColor;
uniform 	float _LightIntensity;
uniform 	mediump float _MainTexAlphaChannelToggle;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec2 u_xlat1;
float u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
vec2 u_xlat10;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.z * 5.0;
    u_xlat0.x = _Time.y * _TimeCt + u_xlat0.x;
    u_xlat5 = _mainUV.x * _mainUV.y + -1.0;
    u_xlat5 = min(u_xlat5, 4.0);
    u_xlat0.x = u_xlat5 + u_xlat0.x;
    u_xlat1.x = _mainUV.y * _mainUV.x;
    u_xlat0.x = u_xlat0.x / u_xlat1.x;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x) + 1.0;
    u_xlat1.y = _mainUV.y;
    u_xlat0.xy = u_xlat0.xy * u_xlat1.xy;
    u_xlat0.xy = floor(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy / _mainUV.xy;
    u_xlat10.xy = vs_TEXCOORD0.xy / _mainUV.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat10.xy;
    u_xlat1.x = sin(_Rotate);
    u_xlat2 = cos(_Rotate);
    u_xlat3.z = u_xlat1.x;
    u_xlat3.y = u_xlat2;
    u_xlat3.x = (-u_xlat1.x);
    u_xlat1.y = dot(u_xlat0.xy, u_xlat3.xy);
    u_xlat1.x = dot(u_xlat0.xy, u_xlat3.yz);
    u_xlat10_0 = texture(_MainTex, u_xlat1.xy);
    u_xlat1.xy = u_xlat10_0.xw * vs_COLOR0.ww;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_LightIntensity);
    u_xlat0.xyz = u_xlat0.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    u_xlatb0.xy = equal(vec4(vec4(_MainTexAlphaChannelToggle, _MainTexAlphaChannelToggle, _MainTexAlphaChannelToggle, _MainTexAlphaChannelToggle)), vec4(0.0, 1.0, 0.0, 0.0)).xy;
    u_xlat16_4 = (u_xlatb0.y) ? u_xlat1.y : 0.0;
    SV_Target0.w = (u_xlatb0.x) ? u_xlat1.x : u_xlat16_4;
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
Keywords { "LUMINANCE" }
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
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec2 _mainUV;
uniform 	float _TimeCt;
uniform 	float _Rotate;
uniform 	vec4 _MainColor;
uniform 	float _LightIntensity;
uniform 	mediump float _LumiFactor;
uniform 	mediump float _MainTexAlphaChannelToggle;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
vec2 u_xlat10;
bvec2 u_xlatb10;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.z * 5.0;
    u_xlat0.x = _Time.y * _TimeCt + u_xlat0.x;
    u_xlat5 = _mainUV.x * _mainUV.y + -1.0;
    u_xlat5 = min(u_xlat5, 4.0);
    u_xlat0.x = u_xlat5 + u_xlat0.x;
    u_xlat1.x = _mainUV.y * _mainUV.x;
    u_xlat0.x = u_xlat0.x / u_xlat1.x;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x) + 1.0;
    u_xlat1.y = _mainUV.y;
    u_xlat0.xy = u_xlat0.xy * u_xlat1.xy;
    u_xlat0.xy = floor(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy / _mainUV.xy;
    u_xlat10.xy = vs_TEXCOORD0.xy / _mainUV.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat10.xy;
    u_xlat1.x = sin(_Rotate);
    u_xlat2.x = cos(_Rotate);
    u_xlat3.z = u_xlat1.x;
    u_xlat3.y = u_xlat2.x;
    u_xlat3.x = (-u_xlat1.x);
    u_xlat1.y = dot(u_xlat0.xy, u_xlat3.xy);
    u_xlat1.x = dot(u_xlat0.xy, u_xlat3.yz);
    u_xlat10_0 = texture(_MainTex, u_xlat1.xy);
    u_xlat1.xyz = u_xlat10_0.xyz * vec3(_LightIntensity);
    u_xlat0.xy = u_xlat10_0.xw * vs_COLOR0.ww;
    u_xlat1.xyz = u_xlat1.xyz * _MainColor.xyz;
    u_xlat2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    u_xlat10.x = dot(u_xlat2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat1.xyz = (-u_xlat1.xyz) * vs_COLOR0.xyz + u_xlat10.xxx;
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    u_xlatb10.xy = equal(vec4(vec4(_MainTexAlphaChannelToggle, _MainTexAlphaChannelToggle, _MainTexAlphaChannelToggle, _MainTexAlphaChannelToggle)), vec4(0.0, 1.0, 0.0, 1.0)).xy;
    u_xlat16_4 = (u_xlatb10.y) ? u_xlat0.y : 0.0;
    SV_Target0.w = (u_xlatb10.x) ? u_xlat0.x : u_xlat16_4;
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
Keywords { "LUMINANCE" }
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
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec2 _mainUV;
uniform 	float _TimeCt;
uniform 	float _Rotate;
uniform 	vec4 _MainColor;
uniform 	float _LightIntensity;
uniform 	mediump float _LumiFactor;
uniform 	mediump float _MainTexAlphaChannelToggle;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
vec2 u_xlat10;
bvec2 u_xlatb10;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.z * 5.0;
    u_xlat0.x = _Time.y * _TimeCt + u_xlat0.x;
    u_xlat5 = _mainUV.x * _mainUV.y + -1.0;
    u_xlat5 = min(u_xlat5, 4.0);
    u_xlat0.x = u_xlat5 + u_xlat0.x;
    u_xlat1.x = _mainUV.y * _mainUV.x;
    u_xlat0.x = u_xlat0.x / u_xlat1.x;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x) + 1.0;
    u_xlat1.y = _mainUV.y;
    u_xlat0.xy = u_xlat0.xy * u_xlat1.xy;
    u_xlat0.xy = floor(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy / _mainUV.xy;
    u_xlat10.xy = vs_TEXCOORD0.xy / _mainUV.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat10.xy;
    u_xlat1.x = sin(_Rotate);
    u_xlat2.x = cos(_Rotate);
    u_xlat3.z = u_xlat1.x;
    u_xlat3.y = u_xlat2.x;
    u_xlat3.x = (-u_xlat1.x);
    u_xlat1.y = dot(u_xlat0.xy, u_xlat3.xy);
    u_xlat1.x = dot(u_xlat0.xy, u_xlat3.yz);
    u_xlat10_0 = texture(_MainTex, u_xlat1.xy);
    u_xlat1.xyz = u_xlat10_0.xyz * vec3(_LightIntensity);
    u_xlat0.xy = u_xlat10_0.xw * vs_COLOR0.ww;
    u_xlat1.xyz = u_xlat1.xyz * _MainColor.xyz;
    u_xlat2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    u_xlat10.x = dot(u_xlat2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat1.xyz = (-u_xlat1.xyz) * vs_COLOR0.xyz + u_xlat10.xxx;
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    u_xlatb10.xy = equal(vec4(vec4(_MainTexAlphaChannelToggle, _MainTexAlphaChannelToggle, _MainTexAlphaChannelToggle, _MainTexAlphaChannelToggle)), vec4(0.0, 1.0, 0.0, 1.0)).xy;
    u_xlat16_4 = (u_xlatb10.y) ? u_xlat0.y : 0.0;
    SV_Target0.w = (u_xlatb10.x) ? u_xlat0.x : u_xlat16_4;
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
Keywords { "LUMINANCE" }
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
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec2 _mainUV;
uniform 	float _TimeCt;
uniform 	float _Rotate;
uniform 	vec4 _MainColor;
uniform 	float _LightIntensity;
uniform 	mediump float _LumiFactor;
uniform 	mediump float _MainTexAlphaChannelToggle;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
vec2 u_xlat10;
bvec2 u_xlatb10;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.z * 5.0;
    u_xlat0.x = _Time.y * _TimeCt + u_xlat0.x;
    u_xlat5 = _mainUV.x * _mainUV.y + -1.0;
    u_xlat5 = min(u_xlat5, 4.0);
    u_xlat0.x = u_xlat5 + u_xlat0.x;
    u_xlat1.x = _mainUV.y * _mainUV.x;
    u_xlat0.x = u_xlat0.x / u_xlat1.x;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x) + 1.0;
    u_xlat1.y = _mainUV.y;
    u_xlat0.xy = u_xlat0.xy * u_xlat1.xy;
    u_xlat0.xy = floor(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy / _mainUV.xy;
    u_xlat10.xy = vs_TEXCOORD0.xy / _mainUV.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat10.xy;
    u_xlat1.x = sin(_Rotate);
    u_xlat2.x = cos(_Rotate);
    u_xlat3.z = u_xlat1.x;
    u_xlat3.y = u_xlat2.x;
    u_xlat3.x = (-u_xlat1.x);
    u_xlat1.y = dot(u_xlat0.xy, u_xlat3.xy);
    u_xlat1.x = dot(u_xlat0.xy, u_xlat3.yz);
    u_xlat10_0 = texture(_MainTex, u_xlat1.xy);
    u_xlat1.xyz = u_xlat10_0.xyz * vec3(_LightIntensity);
    u_xlat0.xy = u_xlat10_0.xw * vs_COLOR0.ww;
    u_xlat1.xyz = u_xlat1.xyz * _MainColor.xyz;
    u_xlat2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    u_xlat10.x = dot(u_xlat2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat1.xyz = (-u_xlat1.xyz) * vs_COLOR0.xyz + u_xlat10.xxx;
    u_xlat1.xyz = vec3(_LumiFactor) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    u_xlatb10.xy = equal(vec4(vec4(_MainTexAlphaChannelToggle, _MainTexAlphaChannelToggle, _MainTexAlphaChannelToggle, _MainTexAlphaChannelToggle)), vec4(0.0, 1.0, 0.0, 1.0)).xy;
    u_xlat16_4 = (u_xlatb10.y) ? u_xlat0.y : 0.0;
    SV_Target0.w = (u_xlatb10.x) ? u_xlat0.x : u_xlat16_4;
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
Fallback "Diffuse"
CustomEditor "MoleMole.ParticleShaderEditorBase"
}