//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_ParticleNew/Effect_AreaRadialBlur_New" {
Properties {
_fSampleDist ("SampleDist", Float) = 1
_fSampleStrength ("SampleStrength", Float) = 2.2
_MaskTex ("MaskTex", 2D) = "white" { }
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 35337
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _BeforeAlphaTexture_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _BeforeAlphaTexture_ST.xy + _BeforeAlphaTexture_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD2 = in_TEXCOORD1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
float ImmCB_0_0_0[6];
uniform 	float _fSampleDist;
uniform 	float _fSampleStrength;
uniform 	vec4 _MaskTex_ST;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _BeforeAlphaTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_2;
vec4 u_xlat3;
lowp vec4 u_xlat10_4;
vec2 u_xlat10;
lowp float u_xlat10_10;
vec2 u_xlat11;
bool u_xlatb11;
float u_xlat15;
int u_xlati15;
void main()
{
	ImmCB_0_0_0[0] = -0.0500000007;
	ImmCB_0_0_0[1] = -0.0299999993;
	ImmCB_0_0_0[2] = -0.00999999978;
	ImmCB_0_0_0[3] = 0.00999999978;
	ImmCB_0_0_0[4] = 0.0299999993;
	ImmCB_0_0_0[5] = 0.0500000007;
    u_xlat0.xy = (-vs_TEXCOORD0.xy) + vec2(0.5, 0.5);
    u_xlat10.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat0.xy = u_xlat10.xx * u_xlat0.xy;
    u_xlat10.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_10 = texture(_MaskTex, u_xlat10.xy).x;
    u_xlat15 = vs_TEXCOORD2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat10.x = u_xlat15 * u_xlat10_10;
    u_xlat1.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat10_2 = texture(_BeforeAlphaTexture, u_xlat1.xy);
    u_xlat3 = u_xlat10_2;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<6 ; u_xlati_loop_1++)
    {
        u_xlat11.xy = u_xlat0.xy * ImmCB_0_0_0[u_xlati_loop_1];
        u_xlat11.xy = u_xlat11.xy * vec2(_fSampleDist) + u_xlat1.xy;
        u_xlat10_4 = texture(_BeforeAlphaTexture, u_xlat11.xy);
        u_xlat3 = u_xlat3 + u_xlat10_4;
    }
    u_xlat0.x = _fSampleStrength;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat1 = u_xlat3 * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149) + (-u_xlat10_2);
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat10_2;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _BeforeAlphaTexture_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _BeforeAlphaTexture_ST.xy + _BeforeAlphaTexture_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD2 = in_TEXCOORD1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
float ImmCB_0_0_0[6];
uniform 	float _fSampleDist;
uniform 	float _fSampleStrength;
uniform 	vec4 _MaskTex_ST;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _BeforeAlphaTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_2;
vec4 u_xlat3;
lowp vec4 u_xlat10_4;
vec2 u_xlat10;
lowp float u_xlat10_10;
vec2 u_xlat11;
bool u_xlatb11;
float u_xlat15;
int u_xlati15;
void main()
{
	ImmCB_0_0_0[0] = -0.0500000007;
	ImmCB_0_0_0[1] = -0.0299999993;
	ImmCB_0_0_0[2] = -0.00999999978;
	ImmCB_0_0_0[3] = 0.00999999978;
	ImmCB_0_0_0[4] = 0.0299999993;
	ImmCB_0_0_0[5] = 0.0500000007;
    u_xlat0.xy = (-vs_TEXCOORD0.xy) + vec2(0.5, 0.5);
    u_xlat10.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat0.xy = u_xlat10.xx * u_xlat0.xy;
    u_xlat10.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_10 = texture(_MaskTex, u_xlat10.xy).x;
    u_xlat15 = vs_TEXCOORD2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat10.x = u_xlat15 * u_xlat10_10;
    u_xlat1.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat10_2 = texture(_BeforeAlphaTexture, u_xlat1.xy);
    u_xlat3 = u_xlat10_2;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<6 ; u_xlati_loop_1++)
    {
        u_xlat11.xy = u_xlat0.xy * ImmCB_0_0_0[u_xlati_loop_1];
        u_xlat11.xy = u_xlat11.xy * vec2(_fSampleDist) + u_xlat1.xy;
        u_xlat10_4 = texture(_BeforeAlphaTexture, u_xlat11.xy);
        u_xlat3 = u_xlat3 + u_xlat10_4;
    }
    u_xlat0.x = _fSampleStrength;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat1 = u_xlat3 * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149) + (-u_xlat10_2);
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat10_2;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _BeforeAlphaTexture_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _BeforeAlphaTexture_ST.xy + _BeforeAlphaTexture_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD2 = in_TEXCOORD1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
float ImmCB_0_0_0[6];
uniform 	float _fSampleDist;
uniform 	float _fSampleStrength;
uniform 	vec4 _MaskTex_ST;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _BeforeAlphaTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_2;
vec4 u_xlat3;
lowp vec4 u_xlat10_4;
vec2 u_xlat10;
lowp float u_xlat10_10;
vec2 u_xlat11;
bool u_xlatb11;
float u_xlat15;
int u_xlati15;
void main()
{
	ImmCB_0_0_0[0] = -0.0500000007;
	ImmCB_0_0_0[1] = -0.0299999993;
	ImmCB_0_0_0[2] = -0.00999999978;
	ImmCB_0_0_0[3] = 0.00999999978;
	ImmCB_0_0_0[4] = 0.0299999993;
	ImmCB_0_0_0[5] = 0.0500000007;
    u_xlat0.xy = (-vs_TEXCOORD0.xy) + vec2(0.5, 0.5);
    u_xlat10.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat0.xy = u_xlat10.xx * u_xlat0.xy;
    u_xlat10.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_10 = texture(_MaskTex, u_xlat10.xy).x;
    u_xlat15 = vs_TEXCOORD2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat10.x = u_xlat15 * u_xlat10_10;
    u_xlat1.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat10_2 = texture(_BeforeAlphaTexture, u_xlat1.xy);
    u_xlat3 = u_xlat10_2;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<6 ; u_xlati_loop_1++)
    {
        u_xlat11.xy = u_xlat0.xy * ImmCB_0_0_0[u_xlati_loop_1];
        u_xlat11.xy = u_xlat11.xy * vec2(_fSampleDist) + u_xlat1.xy;
        u_xlat10_4 = texture(_BeforeAlphaTexture, u_xlat11.xy);
        u_xlat3 = u_xlat3 + u_xlat10_4;
    }
    u_xlat0.x = _fSampleStrength;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat1 = u_xlat3 * vec4(0.142857149, 0.142857149, 0.142857149, 0.142857149) + (-u_xlat10_2);
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat10_2;
    SV_Target0 = u_xlat0;
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