//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_ParticleNew/Effect_ElectricityNew" {
Properties {
_MainTexture ("MainTexture", 2D) = "white" { }
_MainIntensity ("MainIntensity", Float) = 0
_MainColor ("MainColor", Color) = (0,0,0,0)
_NoiseTex01 ("NoiseTex01", 2D) = "white" { }
_Noise1Tilling ("Noise1Tilling", Vector) = (0,0,0,0)
_Noise01Intensity ("Noise01Intensity", Float) = 0
_Noise01Speed01 ("Noise01Speed01", Vector) = (0,0,0,0)
_NoiseTex02 ("NoiseTex02", 2D) = "white" { }
_Noise2Tilling ("Noise2Tilling", Vector) = (0,0,0,0)
_Noise02Intensity ("Noise02Intensity", Float) = 0
_Noise02Speed01 ("Noise02Speed01", Vector) = (0,0,0,0)
_MaskTex ("MaskTex", 2D) = "white" { }
_texcoord ("", 2D) = "white" { }
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Off
  GpuProgramID 58569
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
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
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
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec2 _Noise01Speed01;
uniform 	vec2 _Noise1Tilling;
uniform 	float _Noise01Intensity;
uniform 	vec2 _Noise02Speed01;
uniform 	vec2 _Noise2Tilling;
uniform 	float _Noise02Intensity;
uniform 	vec4 _MainColor;
uniform 	float _MainIntensity;
uniform 	vec4 _MaskTex_ST;
uniform 	float _offsetTex01;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec2 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
vec2 u_xlat4;
lowp vec2 u_xlat10_4;
void main()
{
    u_xlat0.xy = vec2(vs_TEXCOORD0.x * float(_Noise1Tilling.x), vs_TEXCOORD0.y * float(_Noise1Tilling.y));
    u_xlat0.xy = _Time.yy * _Noise01Speed01.xy + u_xlat0.xy;
    u_xlat1.x = _offsetTex01;
    u_xlat1.y = 0.0;
    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat10_0.xy = texture(_NoiseTex01, u_xlat0.xy).xy;
    u_xlat4.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat10_0.xy * vec2(_Noise01Intensity) + u_xlat4.xy;
    u_xlat4.xy = vs_TEXCOORD0.xy * _Noise2Tilling.xy;
    u_xlat4.xy = _Time.yy * vec2(_Noise02Speed01.x, _Noise02Speed01.y) + u_xlat4.xy;
    u_xlat4.xy = u_xlat1.xy + u_xlat4.xy;
    u_xlat10_4.xy = texture(_NoiseTex02, u_xlat4.xy).xy;
    u_xlat0.xy = u_xlat10_4.xy * vec2(vec2(_Noise02Intensity, _Noise02Intensity)) + u_xlat0.xy;
    u_xlat10_0.xyz = texture(_MainTexture, u_xlat0.xy).xyz;
    u_xlat2.xyz = u_xlat10_0.xyz * _MainColor.xyz;
    SV_Target0.w = u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat2.xyz * vec3(_MainIntensity);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_1.xyz = texture(_MaskTex, u_xlat1.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xyz;
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
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
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
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec2 _Noise01Speed01;
uniform 	vec2 _Noise1Tilling;
uniform 	float _Noise01Intensity;
uniform 	vec2 _Noise02Speed01;
uniform 	vec2 _Noise2Tilling;
uniform 	float _Noise02Intensity;
uniform 	vec4 _MainColor;
uniform 	float _MainIntensity;
uniform 	vec4 _MaskTex_ST;
uniform 	float _offsetTex01;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec2 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
vec2 u_xlat4;
lowp vec2 u_xlat10_4;
void main()
{
    u_xlat0.xy = vec2(vs_TEXCOORD0.x * float(_Noise1Tilling.x), vs_TEXCOORD0.y * float(_Noise1Tilling.y));
    u_xlat0.xy = _Time.yy * _Noise01Speed01.xy + u_xlat0.xy;
    u_xlat1.x = _offsetTex01;
    u_xlat1.y = 0.0;
    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat10_0.xy = texture(_NoiseTex01, u_xlat0.xy).xy;
    u_xlat4.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat10_0.xy * vec2(_Noise01Intensity) + u_xlat4.xy;
    u_xlat4.xy = vs_TEXCOORD0.xy * _Noise2Tilling.xy;
    u_xlat4.xy = _Time.yy * vec2(_Noise02Speed01.x, _Noise02Speed01.y) + u_xlat4.xy;
    u_xlat4.xy = u_xlat1.xy + u_xlat4.xy;
    u_xlat10_4.xy = texture(_NoiseTex02, u_xlat4.xy).xy;
    u_xlat0.xy = u_xlat10_4.xy * vec2(vec2(_Noise02Intensity, _Noise02Intensity)) + u_xlat0.xy;
    u_xlat10_0.xyz = texture(_MainTexture, u_xlat0.xy).xyz;
    u_xlat2.xyz = u_xlat10_0.xyz * _MainColor.xyz;
    SV_Target0.w = u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat2.xyz * vec3(_MainIntensity);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_1.xyz = texture(_MaskTex, u_xlat1.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xyz;
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
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
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
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec2 _Noise01Speed01;
uniform 	vec2 _Noise1Tilling;
uniform 	float _Noise01Intensity;
uniform 	vec2 _Noise02Speed01;
uniform 	vec2 _Noise2Tilling;
uniform 	float _Noise02Intensity;
uniform 	vec4 _MainColor;
uniform 	float _MainIntensity;
uniform 	vec4 _MaskTex_ST;
uniform 	float _offsetTex01;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _NoiseTex02;
uniform lowp sampler2D _MainTexture;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec2 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
vec2 u_xlat4;
lowp vec2 u_xlat10_4;
void main()
{
    u_xlat0.xy = vec2(vs_TEXCOORD0.x * float(_Noise1Tilling.x), vs_TEXCOORD0.y * float(_Noise1Tilling.y));
    u_xlat0.xy = _Time.yy * _Noise01Speed01.xy + u_xlat0.xy;
    u_xlat1.x = _offsetTex01;
    u_xlat1.y = 0.0;
    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat10_0.xy = texture(_NoiseTex01, u_xlat0.xy).xy;
    u_xlat4.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat10_0.xy * vec2(_Noise01Intensity) + u_xlat4.xy;
    u_xlat4.xy = vs_TEXCOORD0.xy * _Noise2Tilling.xy;
    u_xlat4.xy = _Time.yy * vec2(_Noise02Speed01.x, _Noise02Speed01.y) + u_xlat4.xy;
    u_xlat4.xy = u_xlat1.xy + u_xlat4.xy;
    u_xlat10_4.xy = texture(_NoiseTex02, u_xlat4.xy).xy;
    u_xlat0.xy = u_xlat10_4.xy * vec2(vec2(_Noise02Intensity, _Noise02Intensity)) + u_xlat0.xy;
    u_xlat10_0.xyz = texture(_MainTexture, u_xlat0.xy).xyz;
    u_xlat2.xyz = u_xlat10_0.xyz * _MainColor.xyz;
    SV_Target0.w = u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat2.xyz * vec3(_MainIntensity);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_1.xyz = texture(_MaskTex, u_xlat1.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xyz;
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