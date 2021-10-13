//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/Main Menu Glitter" {
Properties {
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Base (RGB) Trans (A)", 2D) = "white" { }
_GlitterTex ("Glitter Tex (R: Ocean Glitter, G: Ground Lighting Mask)", 2D) = "white" { }
_ReflectionTex ("Reflection Tex (RGB)", 2D) = "white" { }
_CarLightingTex ("Car Lighting Tex", 2D) = "white" { }
_ReflectionShift ("Reflection Shift (A)", 2D) = "black" { }
_NoiseTex ("Noise Tex (A)", 2D) = "white" { }
[Header(Ocean Glitter)] _OceanScintillationScaleLayer1 ("Glitter Scintillation Scale Layer 1", Range(0, 50)) = 5
_OceanScintillationSpeedLayer1 ("Glitter Scintillation Speed Layer 1", Range(0, 1)) = 0.3
_OceanScintillationScaleLayer2 ("Glitter Scintillation Scale Layer 2", Range(0, 50)) = 5
_OceanScintillationSpeedLayer2 ("Glitter Scintillation Speed Layer 2", Range(0, 1)) = 0.3
_OceanGlitterDensity ("Glitter Density", Range(0, 1)) = 0.5
_OceanGlitterBrightness ("Glitter Brightness", Range(0, 10)) = 1
_OceanGlitterColor ("Glitter Color", Color) = (1,1,1,1)
[Header(Building Lighting)] _BuildingLightingScintillationScaleLayer1 ("Lighting Scintillation Scale Layer 1", Range(0, 50)) = 5
_BuildingLightingScintillationSpeedLayer1 ("Lighting Scintillation Speed Layer 1", Range(0, 1)) = 0.3
_BuildingLightingScintillationScaleLayer2 ("Lighting Scintillation Scale Layer 2", Range(0, 50)) = 5
_BuildingLightingScintillationSpeedLayer2 ("Lighting Scintillation Speed Layer 2", Range(0, 1)) = 0.3
_BuildingLightingBrightness ("Lighting Brightness", Range(0, 5)) = 1
[Header(Car Lighting)] _CarLeftMovingSpeed ("Car Left Moving Speed", Range(0, 0.5)) = 0.1
_CarRightMovingSpeed ("Car Right Moving Speed", Range(0, 0.5)) = 0.1
_CarLightingBrightness ("Car Brightness", Range(0, 5)) = 1
[Header(Reflection)] _ReflectionBoundaryRatio ("Reflection Boundary Ratio", Range(-0.5, 0.5)) = 0
_ReflectionDistortion ("Reflection Distortion", Range(0, 1)) = 0.1
_ReflectionBrightness ("Reflection Brightness", Range(0, 5)) = 1
_ReflectionScintillation ("Reflection Scintillation", Range(0, 0.3)) = 0.1
_GroundLightingReflectionTex ("Ground Lighting ReflectionTex (RGB)", 2D) = "black" { }
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  LOD 200
  Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 11138
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _ReflectionShift_ST;
uniform 	mediump float _OceanScintillationScaleLayer1;
uniform 	mediump float _OceanScintillationSpeedLayer1;
uniform 	mediump float _OceanScintillationScaleLayer2;
uniform 	mediump float _OceanScintillationSpeedLayer2;
uniform 	mediump float _ReflectionScintillation;
uniform 	float _ReflectionBoundaryRatio;
uniform 	vec2 _GameTime;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0 = vec4(float(_OceanScintillationSpeedLayer1) * float(_GameTime.y), float(_OceanScintillationSpeedLayer1) * float(_GameTime.y), float(_OceanScintillationSpeedLayer2) * float(_GameTime.y), float(_OceanScintillationSpeedLayer2) * float(_GameTime.y));
    u_xlat0 = u_xlat0 * vec4(0.400000006, 0.200000003, 0.200000003, 0.400000006);
    vs_TEXCOORD1 = in_TEXCOORD0.xyxy * vec4(_OceanScintillationScaleLayer1, _OceanScintillationScaleLayer1, _OceanScintillationScaleLayer2, _OceanScintillationScaleLayer2) + u_xlat0;
    u_xlat0.x = _ReflectionBoundaryRatio + _ReflectionBoundaryRatio;
    u_xlat4.y = in_TEXCOORD0.y * -1.0 + (-u_xlat0.x);
    u_xlat4.x = in_TEXCOORD0.x;
    vs_TEXCOORD2.zw = u_xlat4.xy + vec2(0.0, 1.0);
    u_xlat0.x = _ReflectionScintillation * _GameTime.xxyx.y;
    u_xlat0.xy = u_xlat0.xx * vec2(0.200000003, 0.400000006);
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _ReflectionShift_ST.xy + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _OceanGlitterDensity;
uniform 	mediump float _OceanGlitterBrightness;
uniform 	mediump vec3 _OceanGlitterColor;
uniform 	mediump float _ReflectionDistortion;
uniform 	mediump float _ReflectionBrightness;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _GroundLightingReflectionTex;
uniform lowp sampler2D _ReflectionShift;
uniform lowp sampler2D _ReflectionTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
lowp vec3 u_xlat10_3;
mediump float u_xlat16_4;
lowp vec3 u_xlat10_4;
vec2 u_xlat10;
lowp float u_xlat10_12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(10.0, 10.0);
    u_xlat10_0.x = texture(_NoiseTex, u_xlat0.xy).w;
    u_xlat16_0.x = u_xlat10_0.x + (-_OceanGlitterDensity);
    u_xlat16_4 = (-_OceanGlitterDensity) + 1.0;
    u_xlat16_4 = float(1.0) / u_xlat16_4;
    u_xlat16_0.x = u_xlat16_4 * u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat16_0.x * -2.0 + 3.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_4;
    u_xlat10_4.x = texture(_GlitterTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1.xyz = u_xlat10_4.xxx * _OceanGlitterColor.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_OceanGlitterBrightness, _OceanGlitterBrightness, _OceanGlitterBrightness));
    u_xlat16_1.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat10_0.x = texture(_NoiseTex, vs_TEXCOORD1.xy).w;
    u_xlat10_4.x = texture(_NoiseTex, vs_TEXCOORD1.zw).w;
    u_xlat16_0.x = u_xlat10_4.x * u_xlat10_0.x;
    u_xlat16_0.x = u_xlat16_0.x * 3.0;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xxx + u_xlat10_4.xyz;
    u_xlat10_0.xyz = texture(_GroundLightingReflectionTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + u_xlat16_1.xyz;
    u_xlat10_12 = texture(_ReflectionShift, vs_TEXCOORD2.xy).w;
    u_xlat16_1.x = _ReflectionDistortion * 0.5;
    u_xlat2.x = u_xlat10_12 * _ReflectionDistortion + (-u_xlat16_1.x);
    u_xlat2.y = 0.0;
    u_xlat10.xy = u_xlat2.xy + vs_TEXCOORD0.xy;
    u_xlat2.xy = vec2(u_xlat2.x + vs_TEXCOORD2.z, u_xlat2.y + vs_TEXCOORD2.w);
    u_xlat10_3.xyz = texture(_GroundLightingReflectionTex, u_xlat2.xy).xyz;
    u_xlat10_2.xyz = texture(_ReflectionTex, u_xlat10.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_3.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(_ReflectionBrightness) + u_xlat16_0.xyz;
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
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _ReflectionShift_ST;
uniform 	mediump float _OceanScintillationScaleLayer1;
uniform 	mediump float _OceanScintillationSpeedLayer1;
uniform 	mediump float _OceanScintillationScaleLayer2;
uniform 	mediump float _OceanScintillationSpeedLayer2;
uniform 	mediump float _ReflectionScintillation;
uniform 	float _ReflectionBoundaryRatio;
uniform 	vec2 _GameTime;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0 = vec4(float(_OceanScintillationSpeedLayer1) * float(_GameTime.y), float(_OceanScintillationSpeedLayer1) * float(_GameTime.y), float(_OceanScintillationSpeedLayer2) * float(_GameTime.y), float(_OceanScintillationSpeedLayer2) * float(_GameTime.y));
    u_xlat0 = u_xlat0 * vec4(0.400000006, 0.200000003, 0.200000003, 0.400000006);
    vs_TEXCOORD1 = in_TEXCOORD0.xyxy * vec4(_OceanScintillationScaleLayer1, _OceanScintillationScaleLayer1, _OceanScintillationScaleLayer2, _OceanScintillationScaleLayer2) + u_xlat0;
    u_xlat0.x = _ReflectionBoundaryRatio + _ReflectionBoundaryRatio;
    u_xlat4.y = in_TEXCOORD0.y * -1.0 + (-u_xlat0.x);
    u_xlat4.x = in_TEXCOORD0.x;
    vs_TEXCOORD2.zw = u_xlat4.xy + vec2(0.0, 1.0);
    u_xlat0.x = _ReflectionScintillation * _GameTime.xxyx.y;
    u_xlat0.xy = u_xlat0.xx * vec2(0.200000003, 0.400000006);
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _ReflectionShift_ST.xy + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _OceanGlitterDensity;
uniform 	mediump float _OceanGlitterBrightness;
uniform 	mediump vec3 _OceanGlitterColor;
uniform 	mediump float _ReflectionDistortion;
uniform 	mediump float _ReflectionBrightness;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _GroundLightingReflectionTex;
uniform lowp sampler2D _ReflectionShift;
uniform lowp sampler2D _ReflectionTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
lowp vec3 u_xlat10_3;
mediump float u_xlat16_4;
lowp vec3 u_xlat10_4;
vec2 u_xlat10;
lowp float u_xlat10_12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(10.0, 10.0);
    u_xlat10_0.x = texture(_NoiseTex, u_xlat0.xy).w;
    u_xlat16_0.x = u_xlat10_0.x + (-_OceanGlitterDensity);
    u_xlat16_4 = (-_OceanGlitterDensity) + 1.0;
    u_xlat16_4 = float(1.0) / u_xlat16_4;
    u_xlat16_0.x = u_xlat16_4 * u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat16_0.x * -2.0 + 3.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_4;
    u_xlat10_4.x = texture(_GlitterTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1.xyz = u_xlat10_4.xxx * _OceanGlitterColor.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_OceanGlitterBrightness, _OceanGlitterBrightness, _OceanGlitterBrightness));
    u_xlat16_1.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat10_0.x = texture(_NoiseTex, vs_TEXCOORD1.xy).w;
    u_xlat10_4.x = texture(_NoiseTex, vs_TEXCOORD1.zw).w;
    u_xlat16_0.x = u_xlat10_4.x * u_xlat10_0.x;
    u_xlat16_0.x = u_xlat16_0.x * 3.0;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xxx + u_xlat10_4.xyz;
    u_xlat10_0.xyz = texture(_GroundLightingReflectionTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + u_xlat16_1.xyz;
    u_xlat10_12 = texture(_ReflectionShift, vs_TEXCOORD2.xy).w;
    u_xlat16_1.x = _ReflectionDistortion * 0.5;
    u_xlat2.x = u_xlat10_12 * _ReflectionDistortion + (-u_xlat16_1.x);
    u_xlat2.y = 0.0;
    u_xlat10.xy = u_xlat2.xy + vs_TEXCOORD0.xy;
    u_xlat2.xy = vec2(u_xlat2.x + vs_TEXCOORD2.z, u_xlat2.y + vs_TEXCOORD2.w);
    u_xlat10_3.xyz = texture(_GroundLightingReflectionTex, u_xlat2.xy).xyz;
    u_xlat10_2.xyz = texture(_ReflectionTex, u_xlat10.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_3.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(_ReflectionBrightness) + u_xlat16_0.xyz;
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
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _ReflectionShift_ST;
uniform 	mediump float _OceanScintillationScaleLayer1;
uniform 	mediump float _OceanScintillationSpeedLayer1;
uniform 	mediump float _OceanScintillationScaleLayer2;
uniform 	mediump float _OceanScintillationSpeedLayer2;
uniform 	mediump float _ReflectionScintillation;
uniform 	float _ReflectionBoundaryRatio;
uniform 	vec2 _GameTime;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0 = vec4(float(_OceanScintillationSpeedLayer1) * float(_GameTime.y), float(_OceanScintillationSpeedLayer1) * float(_GameTime.y), float(_OceanScintillationSpeedLayer2) * float(_GameTime.y), float(_OceanScintillationSpeedLayer2) * float(_GameTime.y));
    u_xlat0 = u_xlat0 * vec4(0.400000006, 0.200000003, 0.200000003, 0.400000006);
    vs_TEXCOORD1 = in_TEXCOORD0.xyxy * vec4(_OceanScintillationScaleLayer1, _OceanScintillationScaleLayer1, _OceanScintillationScaleLayer2, _OceanScintillationScaleLayer2) + u_xlat0;
    u_xlat0.x = _ReflectionBoundaryRatio + _ReflectionBoundaryRatio;
    u_xlat4.y = in_TEXCOORD0.y * -1.0 + (-u_xlat0.x);
    u_xlat4.x = in_TEXCOORD0.x;
    vs_TEXCOORD2.zw = u_xlat4.xy + vec2(0.0, 1.0);
    u_xlat0.x = _ReflectionScintillation * _GameTime.xxyx.y;
    u_xlat0.xy = u_xlat0.xx * vec2(0.200000003, 0.400000006);
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _ReflectionShift_ST.xy + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _OceanGlitterDensity;
uniform 	mediump float _OceanGlitterBrightness;
uniform 	mediump vec3 _OceanGlitterColor;
uniform 	mediump float _ReflectionDistortion;
uniform 	mediump float _ReflectionBrightness;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _GroundLightingReflectionTex;
uniform lowp sampler2D _ReflectionShift;
uniform lowp sampler2D _ReflectionTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
lowp vec3 u_xlat10_3;
mediump float u_xlat16_4;
lowp vec3 u_xlat10_4;
vec2 u_xlat10;
lowp float u_xlat10_12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(10.0, 10.0);
    u_xlat10_0.x = texture(_NoiseTex, u_xlat0.xy).w;
    u_xlat16_0.x = u_xlat10_0.x + (-_OceanGlitterDensity);
    u_xlat16_4 = (-_OceanGlitterDensity) + 1.0;
    u_xlat16_4 = float(1.0) / u_xlat16_4;
    u_xlat16_0.x = u_xlat16_4 * u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat16_0.x * -2.0 + 3.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_4;
    u_xlat10_4.x = texture(_GlitterTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1.xyz = u_xlat10_4.xxx * _OceanGlitterColor.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_OceanGlitterBrightness, _OceanGlitterBrightness, _OceanGlitterBrightness));
    u_xlat16_1.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat10_0.x = texture(_NoiseTex, vs_TEXCOORD1.xy).w;
    u_xlat10_4.x = texture(_NoiseTex, vs_TEXCOORD1.zw).w;
    u_xlat16_0.x = u_xlat10_4.x * u_xlat10_0.x;
    u_xlat16_0.x = u_xlat16_0.x * 3.0;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xxx + u_xlat10_4.xyz;
    u_xlat10_0.xyz = texture(_GroundLightingReflectionTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + u_xlat16_1.xyz;
    u_xlat10_12 = texture(_ReflectionShift, vs_TEXCOORD2.xy).w;
    u_xlat16_1.x = _ReflectionDistortion * 0.5;
    u_xlat2.x = u_xlat10_12 * _ReflectionDistortion + (-u_xlat16_1.x);
    u_xlat2.y = 0.0;
    u_xlat10.xy = u_xlat2.xy + vs_TEXCOORD0.xy;
    u_xlat2.xy = vec2(u_xlat2.x + vs_TEXCOORD2.z, u_xlat2.y + vs_TEXCOORD2.w);
    u_xlat10_3.xyz = texture(_GroundLightingReflectionTex, u_xlat2.xy).xyz;
    u_xlat10_2.xyz = texture(_ReflectionTex, u_xlat10.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_3.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(_ReflectionBrightness) + u_xlat16_0.xyz;
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
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _ReflectionShift_ST;
uniform 	mediump float _OceanScintillationScaleLayer1;
uniform 	mediump float _OceanScintillationSpeedLayer1;
uniform 	mediump float _OceanScintillationScaleLayer2;
uniform 	mediump float _OceanScintillationSpeedLayer2;
uniform 	mediump float _ReflectionScintillation;
uniform 	float _ReflectionBoundaryRatio;
uniform 	vec2 _GameTime;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0 = vec4(float(_OceanScintillationSpeedLayer1) * float(_GameTime.y), float(_OceanScintillationSpeedLayer1) * float(_GameTime.y), float(_OceanScintillationSpeedLayer2) * float(_GameTime.y), float(_OceanScintillationSpeedLayer2) * float(_GameTime.y));
    u_xlat0 = u_xlat0 * vec4(0.400000006, 0.200000003, 0.200000003, 0.400000006);
    vs_TEXCOORD1 = in_TEXCOORD0.xyxy * vec4(_OceanScintillationScaleLayer1, _OceanScintillationScaleLayer1, _OceanScintillationScaleLayer2, _OceanScintillationScaleLayer2) + u_xlat0;
    u_xlat0.x = _ReflectionBoundaryRatio + _ReflectionBoundaryRatio;
    u_xlat4.y = in_TEXCOORD0.y * -1.0 + (-u_xlat0.x);
    u_xlat4.x = in_TEXCOORD0.x;
    vs_TEXCOORD2.zw = u_xlat4.xy + vec2(0.0, 1.0);
    u_xlat0.x = _ReflectionScintillation * _GameTime.xxyx.y;
    u_xlat0.xy = u_xlat0.xx * vec2(0.200000003, 0.400000006);
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _ReflectionShift_ST.xy + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _OceanGlitterDensity;
uniform 	mediump float _OceanGlitterBrightness;
uniform 	mediump vec3 _OceanGlitterColor;
uniform 	mediump float _ReflectionDistortion;
uniform 	mediump float _ReflectionBrightness;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _GroundLightingReflectionTex;
uniform lowp sampler2D _ReflectionShift;
uniform lowp sampler2D _ReflectionTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
lowp vec3 u_xlat10_3;
mediump float u_xlat16_4;
lowp vec3 u_xlat10_4;
vec2 u_xlat10;
lowp float u_xlat10_12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(10.0, 10.0);
    u_xlat10_0.x = texture(_NoiseTex, u_xlat0.xy).w;
    u_xlat16_0.x = u_xlat10_0.x + (-_OceanGlitterDensity);
    u_xlat16_4 = (-_OceanGlitterDensity) + 1.0;
    u_xlat16_4 = float(1.0) / u_xlat16_4;
    u_xlat16_0.x = u_xlat16_4 * u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat16_0.x * -2.0 + 3.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_4;
    u_xlat10_4.x = texture(_GlitterTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1.xyz = u_xlat10_4.xxx * _OceanGlitterColor.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_OceanGlitterBrightness, _OceanGlitterBrightness, _OceanGlitterBrightness));
    u_xlat16_1.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat10_0.x = texture(_NoiseTex, vs_TEXCOORD1.xy).w;
    u_xlat10_4.x = texture(_NoiseTex, vs_TEXCOORD1.zw).w;
    u_xlat16_0.x = u_xlat10_4.x * u_xlat10_0.x;
    u_xlat16_0.x = u_xlat16_0.x * 3.0;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xxx + u_xlat10_4.xyz;
    u_xlat10_0.xyz = texture(_GroundLightingReflectionTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + u_xlat16_1.xyz;
    u_xlat10_12 = texture(_ReflectionShift, vs_TEXCOORD2.xy).w;
    u_xlat16_1.x = _ReflectionDistortion * 0.5;
    u_xlat2.x = u_xlat10_12 * _ReflectionDistortion + (-u_xlat16_1.x);
    u_xlat2.y = 0.0;
    u_xlat10.xy = u_xlat2.xy + vs_TEXCOORD0.xy;
    u_xlat2.xy = vec2(u_xlat2.x + vs_TEXCOORD2.z, u_xlat2.y + vs_TEXCOORD2.w);
    u_xlat10_3.xyz = texture(_GroundLightingReflectionTex, u_xlat2.xy).xyz;
    u_xlat10_2.xyz = texture(_ReflectionTex, u_xlat10.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_3.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_ReflectionBrightness) + u_xlat16_0.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
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
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _ReflectionShift_ST;
uniform 	mediump float _OceanScintillationScaleLayer1;
uniform 	mediump float _OceanScintillationSpeedLayer1;
uniform 	mediump float _OceanScintillationScaleLayer2;
uniform 	mediump float _OceanScintillationSpeedLayer2;
uniform 	mediump float _ReflectionScintillation;
uniform 	float _ReflectionBoundaryRatio;
uniform 	vec2 _GameTime;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0 = vec4(float(_OceanScintillationSpeedLayer1) * float(_GameTime.y), float(_OceanScintillationSpeedLayer1) * float(_GameTime.y), float(_OceanScintillationSpeedLayer2) * float(_GameTime.y), float(_OceanScintillationSpeedLayer2) * float(_GameTime.y));
    u_xlat0 = u_xlat0 * vec4(0.400000006, 0.200000003, 0.200000003, 0.400000006);
    vs_TEXCOORD1 = in_TEXCOORD0.xyxy * vec4(_OceanScintillationScaleLayer1, _OceanScintillationScaleLayer1, _OceanScintillationScaleLayer2, _OceanScintillationScaleLayer2) + u_xlat0;
    u_xlat0.x = _ReflectionBoundaryRatio + _ReflectionBoundaryRatio;
    u_xlat4.y = in_TEXCOORD0.y * -1.0 + (-u_xlat0.x);
    u_xlat4.x = in_TEXCOORD0.x;
    vs_TEXCOORD2.zw = u_xlat4.xy + vec2(0.0, 1.0);
    u_xlat0.x = _ReflectionScintillation * _GameTime.xxyx.y;
    u_xlat0.xy = u_xlat0.xx * vec2(0.200000003, 0.400000006);
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _ReflectionShift_ST.xy + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _OceanGlitterDensity;
uniform 	mediump float _OceanGlitterBrightness;
uniform 	mediump vec3 _OceanGlitterColor;
uniform 	mediump float _ReflectionDistortion;
uniform 	mediump float _ReflectionBrightness;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _GroundLightingReflectionTex;
uniform lowp sampler2D _ReflectionShift;
uniform lowp sampler2D _ReflectionTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
lowp vec3 u_xlat10_3;
mediump float u_xlat16_4;
lowp vec3 u_xlat10_4;
vec2 u_xlat10;
lowp float u_xlat10_12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(10.0, 10.0);
    u_xlat10_0.x = texture(_NoiseTex, u_xlat0.xy).w;
    u_xlat16_0.x = u_xlat10_0.x + (-_OceanGlitterDensity);
    u_xlat16_4 = (-_OceanGlitterDensity) + 1.0;
    u_xlat16_4 = float(1.0) / u_xlat16_4;
    u_xlat16_0.x = u_xlat16_4 * u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat16_0.x * -2.0 + 3.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_4;
    u_xlat10_4.x = texture(_GlitterTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1.xyz = u_xlat10_4.xxx * _OceanGlitterColor.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_OceanGlitterBrightness, _OceanGlitterBrightness, _OceanGlitterBrightness));
    u_xlat16_1.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat10_0.x = texture(_NoiseTex, vs_TEXCOORD1.xy).w;
    u_xlat10_4.x = texture(_NoiseTex, vs_TEXCOORD1.zw).w;
    u_xlat16_0.x = u_xlat10_4.x * u_xlat10_0.x;
    u_xlat16_0.x = u_xlat16_0.x * 3.0;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xxx + u_xlat10_4.xyz;
    u_xlat10_0.xyz = texture(_GroundLightingReflectionTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + u_xlat16_1.xyz;
    u_xlat10_12 = texture(_ReflectionShift, vs_TEXCOORD2.xy).w;
    u_xlat16_1.x = _ReflectionDistortion * 0.5;
    u_xlat2.x = u_xlat10_12 * _ReflectionDistortion + (-u_xlat16_1.x);
    u_xlat2.y = 0.0;
    u_xlat10.xy = u_xlat2.xy + vs_TEXCOORD0.xy;
    u_xlat2.xy = vec2(u_xlat2.x + vs_TEXCOORD2.z, u_xlat2.y + vs_TEXCOORD2.w);
    u_xlat10_3.xyz = texture(_GroundLightingReflectionTex, u_xlat2.xy).xyz;
    u_xlat10_2.xyz = texture(_ReflectionTex, u_xlat10.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_3.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_ReflectionBrightness) + u_xlat16_0.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
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
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _ReflectionShift_ST;
uniform 	mediump float _OceanScintillationScaleLayer1;
uniform 	mediump float _OceanScintillationSpeedLayer1;
uniform 	mediump float _OceanScintillationScaleLayer2;
uniform 	mediump float _OceanScintillationSpeedLayer2;
uniform 	mediump float _ReflectionScintillation;
uniform 	float _ReflectionBoundaryRatio;
uniform 	vec2 _GameTime;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0 = vec4(float(_OceanScintillationSpeedLayer1) * float(_GameTime.y), float(_OceanScintillationSpeedLayer1) * float(_GameTime.y), float(_OceanScintillationSpeedLayer2) * float(_GameTime.y), float(_OceanScintillationSpeedLayer2) * float(_GameTime.y));
    u_xlat0 = u_xlat0 * vec4(0.400000006, 0.200000003, 0.200000003, 0.400000006);
    vs_TEXCOORD1 = in_TEXCOORD0.xyxy * vec4(_OceanScintillationScaleLayer1, _OceanScintillationScaleLayer1, _OceanScintillationScaleLayer2, _OceanScintillationScaleLayer2) + u_xlat0;
    u_xlat0.x = _ReflectionBoundaryRatio + _ReflectionBoundaryRatio;
    u_xlat4.y = in_TEXCOORD0.y * -1.0 + (-u_xlat0.x);
    u_xlat4.x = in_TEXCOORD0.x;
    vs_TEXCOORD2.zw = u_xlat4.xy + vec2(0.0, 1.0);
    u_xlat0.x = _ReflectionScintillation * _GameTime.xxyx.y;
    u_xlat0.xy = u_xlat0.xx * vec2(0.200000003, 0.400000006);
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _ReflectionShift_ST.xy + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _OceanGlitterDensity;
uniform 	mediump float _OceanGlitterBrightness;
uniform 	mediump vec3 _OceanGlitterColor;
uniform 	mediump float _ReflectionDistortion;
uniform 	mediump float _ReflectionBrightness;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _GroundLightingReflectionTex;
uniform lowp sampler2D _ReflectionShift;
uniform lowp sampler2D _ReflectionTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
lowp vec3 u_xlat10_3;
mediump float u_xlat16_4;
lowp vec3 u_xlat10_4;
vec2 u_xlat10;
lowp float u_xlat10_12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(10.0, 10.0);
    u_xlat10_0.x = texture(_NoiseTex, u_xlat0.xy).w;
    u_xlat16_0.x = u_xlat10_0.x + (-_OceanGlitterDensity);
    u_xlat16_4 = (-_OceanGlitterDensity) + 1.0;
    u_xlat16_4 = float(1.0) / u_xlat16_4;
    u_xlat16_0.x = u_xlat16_4 * u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat16_0.x * -2.0 + 3.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_4;
    u_xlat10_4.x = texture(_GlitterTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1.xyz = u_xlat10_4.xxx * _OceanGlitterColor.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_OceanGlitterBrightness, _OceanGlitterBrightness, _OceanGlitterBrightness));
    u_xlat16_1.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat10_0.x = texture(_NoiseTex, vs_TEXCOORD1.xy).w;
    u_xlat10_4.x = texture(_NoiseTex, vs_TEXCOORD1.zw).w;
    u_xlat16_0.x = u_xlat10_4.x * u_xlat10_0.x;
    u_xlat16_0.x = u_xlat16_0.x * 3.0;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xxx + u_xlat10_4.xyz;
    u_xlat10_0.xyz = texture(_GroundLightingReflectionTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + u_xlat16_1.xyz;
    u_xlat10_12 = texture(_ReflectionShift, vs_TEXCOORD2.xy).w;
    u_xlat16_1.x = _ReflectionDistortion * 0.5;
    u_xlat2.x = u_xlat10_12 * _ReflectionDistortion + (-u_xlat16_1.x);
    u_xlat2.y = 0.0;
    u_xlat10.xy = u_xlat2.xy + vs_TEXCOORD0.xy;
    u_xlat2.xy = vec2(u_xlat2.x + vs_TEXCOORD2.z, u_xlat2.y + vs_TEXCOORD2.w);
    u_xlat10_3.xyz = texture(_GroundLightingReflectionTex, u_xlat2.xy).xyz;
    u_xlat10_2.xyz = texture(_ReflectionTex, u_xlat10.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_3.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_ReflectionBrightness) + u_xlat16_0.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
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