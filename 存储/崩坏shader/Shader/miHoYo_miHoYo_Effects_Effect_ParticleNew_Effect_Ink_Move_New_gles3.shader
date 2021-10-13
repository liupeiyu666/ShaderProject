//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_ParticleNew/Effect_Ink_Move_New" {
Properties {
_MainColor ("MainColor", Color) = (1,1,1,0)
_MainIntensity ("MainIntensity", Float) = 1
_EdgeColor ("EdgeColor", Color) = (0.1391652,0.3868571,0.7279412,0)
_EdgeColorIntensity ("EdgeColorIntensity", Float) = 1
_MainTexture ("MainTexture", 2D) = "white" { }
_mainTexSpeed ("mainTexSpeed", Vector) = (0,0,0,0)
_NoiseTex ("NoiseTex", 2D) = "white" { }
_NoiseIntensity ("NoiseIntensity", Float) = 0
_NoiseSpeed ("NoiseSpeed", Vector) = (0,0,0,0)
_NoiseTex02 ("NoiseTex02", 2D) = "white" { }
_Noise02Speed ("Noise02Speed", Vector) = (0,0,0,0)
_Noise02Intensity ("Noise02Intensity", Float) = 0
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 52452
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
uniform 	vec2 _mainTexSpeed;
uniform 	vec4 _MainTexture_ST;
uniform 	vec2 _NoiseSpeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseIntensity;
uniform 	vec2 _Noise02Speed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02Intensity;
uniform 	vec4 _MainColor;
uniform 	float _MainIntensity;
uniform 	vec4 _EdgeColor;
uniform 	float _EdgeColorIntensity;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat4;
lowp float u_xlat10_4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseSpeed.xy + u_xlat0.xy;
    u_xlat10_0.x = texture(_NoiseTex, u_xlat0.xy).x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat2.xy = _Time.yy * _mainTexSpeed.xy + u_xlat2.xy;
    u_xlat0.xy = u_xlat10_0.xx * vec2(_NoiseIntensity) + u_xlat2.xy;
    u_xlat4.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat4.xy = _Time.yy * vec2(_Noise02Speed.x, _Noise02Speed.y) + u_xlat4.xy;
    u_xlat10_4 = texture(_NoiseTex02, u_xlat4.xy).x;
    u_xlat0.xy = vec2(u_xlat10_4) * vec2(_Noise02Intensity) + u_xlat0.xy;
    u_xlat10_0 = texture(_MainTexture, u_xlat0.xy);
    u_xlat1.xyz = u_xlat10_0.www * _EdgeColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_EdgeColorIntensity);
    u_xlat2.xyz = u_xlat10_0.xyz * _MainColor.xyz;
    SV_Target0.w = u_xlat10_0.x * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat2.xyz * vec3(_MainIntensity) + u_xlat1.xyz;
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
uniform 	vec2 _mainTexSpeed;
uniform 	vec4 _MainTexture_ST;
uniform 	vec2 _NoiseSpeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseIntensity;
uniform 	vec2 _Noise02Speed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02Intensity;
uniform 	vec4 _MainColor;
uniform 	float _MainIntensity;
uniform 	vec4 _EdgeColor;
uniform 	float _EdgeColorIntensity;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat4;
lowp float u_xlat10_4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseSpeed.xy + u_xlat0.xy;
    u_xlat10_0.x = texture(_NoiseTex, u_xlat0.xy).x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat2.xy = _Time.yy * _mainTexSpeed.xy + u_xlat2.xy;
    u_xlat0.xy = u_xlat10_0.xx * vec2(_NoiseIntensity) + u_xlat2.xy;
    u_xlat4.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat4.xy = _Time.yy * vec2(_Noise02Speed.x, _Noise02Speed.y) + u_xlat4.xy;
    u_xlat10_4 = texture(_NoiseTex02, u_xlat4.xy).x;
    u_xlat0.xy = vec2(u_xlat10_4) * vec2(_Noise02Intensity) + u_xlat0.xy;
    u_xlat10_0 = texture(_MainTexture, u_xlat0.xy);
    u_xlat1.xyz = u_xlat10_0.www * _EdgeColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_EdgeColorIntensity);
    u_xlat2.xyz = u_xlat10_0.xyz * _MainColor.xyz;
    SV_Target0.w = u_xlat10_0.x * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat2.xyz * vec3(_MainIntensity) + u_xlat1.xyz;
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
uniform 	vec2 _mainTexSpeed;
uniform 	vec4 _MainTexture_ST;
uniform 	vec2 _NoiseSpeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseIntensity;
uniform 	vec2 _Noise02Speed;
uniform 	vec4 _NoiseTex02_ST;
uniform 	float _Noise02Intensity;
uniform 	vec4 _MainColor;
uniform 	float _MainIntensity;
uniform 	vec4 _EdgeColor;
uniform 	float _EdgeColorIntensity;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat4;
lowp float u_xlat10_4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NoiseSpeed.xy + u_xlat0.xy;
    u_xlat10_0.x = texture(_NoiseTex, u_xlat0.xy).x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
    u_xlat2.xy = _Time.yy * _mainTexSpeed.xy + u_xlat2.xy;
    u_xlat0.xy = u_xlat10_0.xx * vec2(_NoiseIntensity) + u_xlat2.xy;
    u_xlat4.xy = vs_TEXCOORD0.xy * _NoiseTex02_ST.xy + _NoiseTex02_ST.zw;
    u_xlat4.xy = _Time.yy * vec2(_Noise02Speed.x, _Noise02Speed.y) + u_xlat4.xy;
    u_xlat10_4 = texture(_NoiseTex02, u_xlat4.xy).x;
    u_xlat0.xy = vec2(u_xlat10_4) * vec2(_Noise02Intensity) + u_xlat0.xy;
    u_xlat10_0 = texture(_MainTexture, u_xlat0.xy);
    u_xlat1.xyz = u_xlat10_0.www * _EdgeColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_EdgeColorIntensity);
    u_xlat2.xyz = u_xlat10_0.xyz * _MainColor.xyz;
    SV_Target0.w = u_xlat10_0.x * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat2.xyz * vec3(_MainIntensity) + u_xlat1.xyz;
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