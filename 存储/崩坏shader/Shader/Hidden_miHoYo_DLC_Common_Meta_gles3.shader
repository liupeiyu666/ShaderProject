//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/miHoYo/DLC/Common/Meta" {
Properties {
_EmissionMask ("Emission Mask", 2D) = "black" { }
[Enum(UV1st,0,UV2nd,1)] _UseSet ("UV Set", Float) = 1
_Emission ("Emission Color", Color) = (0,0,0,0.5)
_EmissionGIIntensity ("Emission GI Intensity", Range(0, 10)) = 2
}
SubShader {
 Tags { "PerformanceChecks" = "False" "RenderType" = "Opaque" }
 Pass {
  Name "META"
  Tags { "LIGHTMODE" = "META" "PerformanceChecks" = "False" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 22320
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	bvec4 unity_MetaVertexControl;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb6;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<in_POSITION0.z);
#else
    u_xlatb0 = 0.0<in_POSITION0.z;
#endif
    u_xlat0.z = u_xlatb0 ? 9.99999975e-05 : float(0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat0.xyz = (unity_MetaVertexControl.x) ? u_xlat0.xyz : in_POSITION0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.0<u_xlat0.z);
#else
    u_xlatb6 = 0.0<u_xlat0.z;
#endif
    u_xlat1.z = u_xlatb6 ? 9.99999975e-05 : float(0.0);
    u_xlat1.xy = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
    u_xlat0.xyz = (unity_MetaVertexControl.y) ? u_xlat1.xyz : u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform 	bvec4 unity_MetaFragmentControl;
uniform 	float unity_OneOverOutputBoost;
uniform 	float unity_MaxOutputValue;
uniform 	float unity_UseLinearSpace;
uniform 	mediump vec4 _Emission;
uniform 	float _EmissionGIIntensity;
uniform 	int _UseSet;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _EmissionMask;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec2 u_xlat3;
bool u_xlatb9;
float u_xlat11;
void main()
{
    u_xlat0.x = float(_UseSet);
    u_xlat3.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat3.xy + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_EmissionMask, u_xlat0.xy).x;
    u_xlat16_1.xyz = _Emission.www * _Emission.xyz;
    u_xlat16_1.xyz = vec3(u_xlat10_0) * u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * vec3(_EmissionGIIntensity);
    u_xlat2.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat2.xyz = u_xlat0.xyz * u_xlat2.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat2.xyz = u_xlat0.xyz * u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_UseLinearSpace));
#else
    u_xlatb9 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_UseLinearSpace);
#endif
    u_xlat16_0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_2.xyz = log2(u_xlat16_1.xyz);
    u_xlat11 = unity_OneOverOutputBoost;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat16_2.xyz * vec3(u_xlat11);
    u_xlat2.xyz = exp2(u_xlat2.xyz);
    u_xlat2.xyz = min(u_xlat2.xyz, vec3(vec3(unity_MaxOutputValue, unity_MaxOutputValue, unity_MaxOutputValue)));
    u_xlat16_1.xyz = (unity_MetaFragmentControl.x) ? u_xlat2.xyz : vec3(0.0, 0.0, 0.0);
    u_xlat16_1.w = (unity_MetaFragmentControl.x) ? 1.0 : 0.0;
    u_xlat16_0.w = 1.0;
    u_xlat16_0 = (unity_MetaFragmentControl.y) ? u_xlat16_0 : u_xlat16_1;
    SV_Target0 = u_xlat16_0;
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
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	bvec4 unity_MetaVertexControl;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb6;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<in_POSITION0.z);
#else
    u_xlatb0 = 0.0<in_POSITION0.z;
#endif
    u_xlat0.z = u_xlatb0 ? 9.99999975e-05 : float(0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat0.xyz = (unity_MetaVertexControl.x) ? u_xlat0.xyz : in_POSITION0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.0<u_xlat0.z);
#else
    u_xlatb6 = 0.0<u_xlat0.z;
#endif
    u_xlat1.z = u_xlatb6 ? 9.99999975e-05 : float(0.0);
    u_xlat1.xy = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
    u_xlat0.xyz = (unity_MetaVertexControl.y) ? u_xlat1.xyz : u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform 	bvec4 unity_MetaFragmentControl;
uniform 	float unity_OneOverOutputBoost;
uniform 	float unity_MaxOutputValue;
uniform 	float unity_UseLinearSpace;
uniform 	mediump vec4 _Emission;
uniform 	float _EmissionGIIntensity;
uniform 	int _UseSet;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _EmissionMask;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec2 u_xlat3;
bool u_xlatb9;
float u_xlat11;
void main()
{
    u_xlat0.x = float(_UseSet);
    u_xlat3.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat3.xy + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_EmissionMask, u_xlat0.xy).x;
    u_xlat16_1.xyz = _Emission.www * _Emission.xyz;
    u_xlat16_1.xyz = vec3(u_xlat10_0) * u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * vec3(_EmissionGIIntensity);
    u_xlat2.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat2.xyz = u_xlat0.xyz * u_xlat2.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat2.xyz = u_xlat0.xyz * u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_UseLinearSpace));
#else
    u_xlatb9 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_UseLinearSpace);
#endif
    u_xlat16_0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_2.xyz = log2(u_xlat16_1.xyz);
    u_xlat11 = unity_OneOverOutputBoost;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat16_2.xyz * vec3(u_xlat11);
    u_xlat2.xyz = exp2(u_xlat2.xyz);
    u_xlat2.xyz = min(u_xlat2.xyz, vec3(vec3(unity_MaxOutputValue, unity_MaxOutputValue, unity_MaxOutputValue)));
    u_xlat16_1.xyz = (unity_MetaFragmentControl.x) ? u_xlat2.xyz : vec3(0.0, 0.0, 0.0);
    u_xlat16_1.w = (unity_MetaFragmentControl.x) ? 1.0 : 0.0;
    u_xlat16_0.w = 1.0;
    u_xlat16_0 = (unity_MetaFragmentControl.y) ? u_xlat16_0 : u_xlat16_1;
    SV_Target0 = u_xlat16_0;
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
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	bvec4 unity_MetaVertexControl;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb6;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<in_POSITION0.z);
#else
    u_xlatb0 = 0.0<in_POSITION0.z;
#endif
    u_xlat0.z = u_xlatb0 ? 9.99999975e-05 : float(0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat0.xyz = (unity_MetaVertexControl.x) ? u_xlat0.xyz : in_POSITION0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.0<u_xlat0.z);
#else
    u_xlatb6 = 0.0<u_xlat0.z;
#endif
    u_xlat1.z = u_xlatb6 ? 9.99999975e-05 : float(0.0);
    u_xlat1.xy = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
    u_xlat0.xyz = (unity_MetaVertexControl.y) ? u_xlat1.xyz : u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform 	bvec4 unity_MetaFragmentControl;
uniform 	float unity_OneOverOutputBoost;
uniform 	float unity_MaxOutputValue;
uniform 	float unity_UseLinearSpace;
uniform 	mediump vec4 _Emission;
uniform 	float _EmissionGIIntensity;
uniform 	int _UseSet;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _EmissionMask;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec2 u_xlat3;
bool u_xlatb9;
float u_xlat11;
void main()
{
    u_xlat0.x = float(_UseSet);
    u_xlat3.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat3.xy + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_EmissionMask, u_xlat0.xy).x;
    u_xlat16_1.xyz = _Emission.www * _Emission.xyz;
    u_xlat16_1.xyz = vec3(u_xlat10_0) * u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * vec3(_EmissionGIIntensity);
    u_xlat2.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat2.xyz = u_xlat0.xyz * u_xlat2.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat2.xyz = u_xlat0.xyz * u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_UseLinearSpace));
#else
    u_xlatb9 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_UseLinearSpace);
#endif
    u_xlat16_0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_2.xyz = log2(u_xlat16_1.xyz);
    u_xlat11 = unity_OneOverOutputBoost;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat16_2.xyz * vec3(u_xlat11);
    u_xlat2.xyz = exp2(u_xlat2.xyz);
    u_xlat2.xyz = min(u_xlat2.xyz, vec3(vec3(unity_MaxOutputValue, unity_MaxOutputValue, unity_MaxOutputValue)));
    u_xlat16_1.xyz = (unity_MetaFragmentControl.x) ? u_xlat2.xyz : vec3(0.0, 0.0, 0.0);
    u_xlat16_1.w = (unity_MetaFragmentControl.x) ? 1.0 : 0.0;
    u_xlat16_0.w = 1.0;
    u_xlat16_0 = (unity_MetaFragmentControl.y) ? u_xlat16_0 : u_xlat16_1;
    SV_Target0 = u_xlat16_0;
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
  Name "META_ADD"
  Tags { "LIGHTMODE" = "META" "PerformanceChecks" = "False" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 130115
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	bvec4 unity_MetaVertexControl;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb6;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<in_POSITION0.z);
#else
    u_xlatb0 = 0.0<in_POSITION0.z;
#endif
    u_xlat0.z = u_xlatb0 ? 9.99999975e-05 : float(0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat0.xyz = (unity_MetaVertexControl.x) ? u_xlat0.xyz : in_POSITION0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.0<u_xlat0.z);
#else
    u_xlatb6 = 0.0<u_xlat0.z;
#endif
    u_xlat1.z = u_xlatb6 ? 9.99999975e-05 : float(0.0);
    u_xlat1.xy = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
    u_xlat0.xyz = (unity_MetaVertexControl.y) ? u_xlat1.xyz : u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform 	bvec4 unity_MetaFragmentControl;
uniform 	float unity_OneOverOutputBoost;
uniform 	float unity_MaxOutputValue;
uniform 	float unity_UseLinearSpace;
uniform 	mediump vec4 _Emission;
uniform 	float _EmissionGIIntensity;
uniform 	int _UseSet;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _EmissionMask;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec2 u_xlat5;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * _Color.xyz;
    u_xlat16_0.xyz = log2(u_xlat16_3.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * _Emission.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _Emission.www;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionGIIntensity);
    u_xlat4.xyz = u_xlat1.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat4.xyz = u_xlat1.xyz * u_xlat4.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat4.xyz = u_xlat1.xyz * u_xlat4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_UseLinearSpace));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_UseLinearSpace);
#endif
    u_xlat16_1.xyz = (bool(u_xlatb15)) ? u_xlat1.xyz : u_xlat4.xyz;
    u_xlat15 = unity_OneOverOutputBoost;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(u_xlat15);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(vec3(unity_MaxOutputValue, unity_MaxOutputValue, unity_MaxOutputValue)));
    u_xlat16_0.xyz = (unity_MetaFragmentControl.x) ? u_xlat0.xyz : vec3(0.0, 0.0, 0.0);
    u_xlat16_0.w = (unity_MetaFragmentControl.x) ? 1.0 : 0.0;
    u_xlat16_1.w = 1.0;
    u_xlat16_0 = (unity_MetaFragmentControl.y) ? u_xlat16_1 : u_xlat16_0;
    SV_Target0 = u_xlat16_0;
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
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	bvec4 unity_MetaVertexControl;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb6;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<in_POSITION0.z);
#else
    u_xlatb0 = 0.0<in_POSITION0.z;
#endif
    u_xlat0.z = u_xlatb0 ? 9.99999975e-05 : float(0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat0.xyz = (unity_MetaVertexControl.x) ? u_xlat0.xyz : in_POSITION0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.0<u_xlat0.z);
#else
    u_xlatb6 = 0.0<u_xlat0.z;
#endif
    u_xlat1.z = u_xlatb6 ? 9.99999975e-05 : float(0.0);
    u_xlat1.xy = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
    u_xlat0.xyz = (unity_MetaVertexControl.y) ? u_xlat1.xyz : u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform 	bvec4 unity_MetaFragmentControl;
uniform 	float unity_OneOverOutputBoost;
uniform 	float unity_MaxOutputValue;
uniform 	float unity_UseLinearSpace;
uniform 	mediump vec4 _Emission;
uniform 	float _EmissionGIIntensity;
uniform 	int _UseSet;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _EmissionMask;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec2 u_xlat5;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * _Color.xyz;
    u_xlat16_0.xyz = log2(u_xlat16_3.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * _Emission.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _Emission.www;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionGIIntensity);
    u_xlat4.xyz = u_xlat1.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat4.xyz = u_xlat1.xyz * u_xlat4.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat4.xyz = u_xlat1.xyz * u_xlat4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_UseLinearSpace));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_UseLinearSpace);
#endif
    u_xlat16_1.xyz = (bool(u_xlatb15)) ? u_xlat1.xyz : u_xlat4.xyz;
    u_xlat15 = unity_OneOverOutputBoost;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(u_xlat15);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(vec3(unity_MaxOutputValue, unity_MaxOutputValue, unity_MaxOutputValue)));
    u_xlat16_0.xyz = (unity_MetaFragmentControl.x) ? u_xlat0.xyz : vec3(0.0, 0.0, 0.0);
    u_xlat16_0.w = (unity_MetaFragmentControl.x) ? 1.0 : 0.0;
    u_xlat16_1.w = 1.0;
    u_xlat16_0 = (unity_MetaFragmentControl.y) ? u_xlat16_1 : u_xlat16_0;
    SV_Target0 = u_xlat16_0;
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
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	bvec4 unity_MetaVertexControl;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb6;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<in_POSITION0.z);
#else
    u_xlatb0 = 0.0<in_POSITION0.z;
#endif
    u_xlat0.z = u_xlatb0 ? 9.99999975e-05 : float(0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat0.xyz = (unity_MetaVertexControl.x) ? u_xlat0.xyz : in_POSITION0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.0<u_xlat0.z);
#else
    u_xlatb6 = 0.0<u_xlat0.z;
#endif
    u_xlat1.z = u_xlatb6 ? 9.99999975e-05 : float(0.0);
    u_xlat1.xy = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
    u_xlat0.xyz = (unity_MetaVertexControl.y) ? u_xlat1.xyz : u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform 	bvec4 unity_MetaFragmentControl;
uniform 	float unity_OneOverOutputBoost;
uniform 	float unity_MaxOutputValue;
uniform 	float unity_UseLinearSpace;
uniform 	mediump vec4 _Emission;
uniform 	float _EmissionGIIntensity;
uniform 	int _UseSet;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _EmissionMask;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec2 u_xlat5;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * _Color.xyz;
    u_xlat16_0.xyz = log2(u_xlat16_3.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * _Emission.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _Emission.www;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(_EmissionGIIntensity);
    u_xlat4.xyz = u_xlat1.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat4.xyz = u_xlat1.xyz * u_xlat4.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat4.xyz = u_xlat1.xyz * u_xlat4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_UseLinearSpace));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_UseLinearSpace);
#endif
    u_xlat16_1.xyz = (bool(u_xlatb15)) ? u_xlat1.xyz : u_xlat4.xyz;
    u_xlat15 = unity_OneOverOutputBoost;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(u_xlat15);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(vec3(unity_MaxOutputValue, unity_MaxOutputValue, unity_MaxOutputValue)));
    u_xlat16_0.xyz = (unity_MetaFragmentControl.x) ? u_xlat0.xyz : vec3(0.0, 0.0, 0.0);
    u_xlat16_0.w = (unity_MetaFragmentControl.x) ? 1.0 : 0.0;
    u_xlat16_1.w = 1.0;
    u_xlat16_0 = (unity_MetaFragmentControl.y) ? u_xlat16_1 : u_xlat16_0;
    SV_Target0 = u_xlat16_0;
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
}