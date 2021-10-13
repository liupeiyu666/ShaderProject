//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_NewHome/Lightmap" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_Opaqueness ("Opaqueness", Range(0, 1)) = 1
_LightMapIntensity ("Light Map Intensity", Float) = 1
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Color Tex (RGB)", 2D) = "white" { }
_ShadowTex ("LightMap (RGB)", 2D) = "grey" { }
_FogTune ("Fog Tune", Range(0, 1)) = 1
_Culling ("Culling (0: Off, 1: Front, 2: Back)", Float) = 2
}
SubShader {
 LOD 200
 Tags { "DrawDepth" = "FrontFace" "OutlineType" = "None" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "BASE"
  LOD 200
  Tags { "DrawDepth" = "FrontFace" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "None" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 44282
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_1.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat10_0.www) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_0.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * vec3(_LightMapIntensity);
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_1.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat10_0.www) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_0.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * vec3(_LightMapIntensity);
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_1.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat10_0.www) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_0.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * vec3(_LightMapIntensity);
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_1.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat10_0.www) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_0.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * vec3(_LightMapIntensity);
    u_xlat9 = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat2.xyz = (-u_xlat16_1.xyz) * vec3(_LightMapIntensity) + vec3(u_xlat9);
    u_xlat0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_1.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat10_0.www) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_0.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * vec3(_LightMapIntensity);
    u_xlat9 = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat2.xyz = (-u_xlat16_1.xyz) * vec3(_LightMapIntensity) + vec3(u_xlat9);
    u_xlat0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_1.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat10_0.www) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_0.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * vec3(_LightMapIntensity);
    u_xlat9 = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat2.xyz = (-u_xlat16_1.xyz) * vec3(_LightMapIntensity) + vec3(u_xlat9);
    u_xlat0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
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
}