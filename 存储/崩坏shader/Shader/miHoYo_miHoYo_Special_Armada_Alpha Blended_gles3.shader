//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Special/Armada/Alpha Blended" {
Properties {
_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
_MainTex ("Main Texture", 2D) = "white" { }
_TransparentTex ("Transparent Texture", 2D) = "white" { }
_TransparentScaler ("Transparent Scaler", Range(0, 1)) = 1
_BloomFactor ("Bloom Factor", Float) = 1
_EmissionScaler ("Emission Scaler", Range(0, 50)) = 1
[Toggle] _PerspectiveDeformation ("Perspective Deformation", Float) = 0
_Vanishpoint ("Vanishpoint Position (Local Space)", Vector) = (0,0,10000,0)
_InvariantPlaneZ ("Invariant Plane Z Position (Local Space)", Float) = 0
_ScaleInZ ("Scale In Z", Range(0.01, 2)) = 1
}
SubShader {
 Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 48934
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _PerspectiveDeformation;
uniform 	vec3 _Vanishpoint;
uniform 	float _InvariantPlaneZ;
uniform 	float _ScaleInZ;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = (-_Vanishpoint.z) + _InvariantPlaneZ;
    u_xlat2.xyz = in_POSITION0.xyz + (-_Vanishpoint.xyz);
    u_xlat0.x = u_xlat2.z / u_xlat0.x;
    u_xlat2.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat0.xyz = u_xlat2.xyz + _Vanishpoint.xyz;
    u_xlat4 = u_xlat0.z + (-_InvariantPlaneZ);
    u_xlat0.w = u_xlat4 * _ScaleInZ + _InvariantPlaneZ;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_PerspectiveDeformation));
#else
    u_xlatb4 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_PerspectiveDeformation);
#endif
    u_xlat0.xyz = (bool(u_xlatb4)) ? u_xlat0.xyw : in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _TransparentScaler;
uniform 	mediump float _EmissionScaler;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _TransparentTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp float u_xlat10_0;
lowp vec4 u_xlat10_1;
mediump float u_xlat16_2;
void main()
{
    u_xlat16_0.xyz = _TintColor.xyz + _TintColor.xyz;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xyz;
    u_xlat16_2 = _EmissionScaler + -1.0;
    u_xlat16_2 = u_xlat10_1.w * u_xlat16_2 + 1.0;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_2);
    u_xlat10_0 = texture(_TransparentTex, vs_TEXCOORD0.xy).x;
    SV_Target0.w = u_xlat10_0 * _TransparentScaler;
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
uniform 	mediump float _PerspectiveDeformation;
uniform 	vec3 _Vanishpoint;
uniform 	float _InvariantPlaneZ;
uniform 	float _ScaleInZ;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = (-_Vanishpoint.z) + _InvariantPlaneZ;
    u_xlat2.xyz = in_POSITION0.xyz + (-_Vanishpoint.xyz);
    u_xlat0.x = u_xlat2.z / u_xlat0.x;
    u_xlat2.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat0.xyz = u_xlat2.xyz + _Vanishpoint.xyz;
    u_xlat4 = u_xlat0.z + (-_InvariantPlaneZ);
    u_xlat0.w = u_xlat4 * _ScaleInZ + _InvariantPlaneZ;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_PerspectiveDeformation));
#else
    u_xlatb4 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_PerspectiveDeformation);
#endif
    u_xlat0.xyz = (bool(u_xlatb4)) ? u_xlat0.xyw : in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _TransparentScaler;
uniform 	mediump float _EmissionScaler;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _TransparentTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp float u_xlat10_0;
lowp vec4 u_xlat10_1;
mediump float u_xlat16_2;
void main()
{
    u_xlat16_0.xyz = _TintColor.xyz + _TintColor.xyz;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xyz;
    u_xlat16_2 = _EmissionScaler + -1.0;
    u_xlat16_2 = u_xlat10_1.w * u_xlat16_2 + 1.0;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_2);
    u_xlat10_0 = texture(_TransparentTex, vs_TEXCOORD0.xy).x;
    SV_Target0.w = u_xlat10_0 * _TransparentScaler;
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
uniform 	mediump float _PerspectiveDeformation;
uniform 	vec3 _Vanishpoint;
uniform 	float _InvariantPlaneZ;
uniform 	float _ScaleInZ;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = (-_Vanishpoint.z) + _InvariantPlaneZ;
    u_xlat2.xyz = in_POSITION0.xyz + (-_Vanishpoint.xyz);
    u_xlat0.x = u_xlat2.z / u_xlat0.x;
    u_xlat2.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat0.xyz = u_xlat2.xyz + _Vanishpoint.xyz;
    u_xlat4 = u_xlat0.z + (-_InvariantPlaneZ);
    u_xlat0.w = u_xlat4 * _ScaleInZ + _InvariantPlaneZ;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_PerspectiveDeformation));
#else
    u_xlatb4 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_PerspectiveDeformation);
#endif
    u_xlat0.xyz = (bool(u_xlatb4)) ? u_xlat0.xyw : in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _TransparentScaler;
uniform 	mediump float _EmissionScaler;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _TransparentTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp float u_xlat10_0;
lowp vec4 u_xlat10_1;
mediump float u_xlat16_2;
void main()
{
    u_xlat16_0.xyz = _TintColor.xyz + _TintColor.xyz;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xyz;
    u_xlat16_2 = _EmissionScaler + -1.0;
    u_xlat16_2 = u_xlat10_1.w * u_xlat16_2 + 1.0;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_2);
    u_xlat10_0 = texture(_TransparentTex, vs_TEXCOORD0.xy).x;
    SV_Target0.w = u_xlat10_0 * _TransparentScaler;
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
}
}
 Pass {
  Name "CONSTANT_REPLACE_NOCUTOFF"
  Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 87894
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _PerspectiveDeformation;
uniform 	vec3 _Vanishpoint;
uniform 	float _InvariantPlaneZ;
uniform 	float _ScaleInZ;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = (-_Vanishpoint.z) + _InvariantPlaneZ;
    u_xlat2.xyz = in_POSITION0.xyz + (-_Vanishpoint.xyz);
    u_xlat0.x = u_xlat2.z / u_xlat0.x;
    u_xlat2.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat0.xyz = u_xlat2.xyz + _Vanishpoint.xyz;
    u_xlat4 = u_xlat0.z + (-_InvariantPlaneZ);
    u_xlat0.w = u_xlat4 * _ScaleInZ + _InvariantPlaneZ;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_PerspectiveDeformation));
#else
    u_xlatb4 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_PerspectiveDeformation);
#endif
    u_xlat0.xyz = (bool(u_xlatb4)) ? u_xlat0.xyw : in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2.xy = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_0 = u_xlat10_0 * _BloomFactor;
    SV_Target0.w = u_xlat16_0;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	mediump float _PerspectiveDeformation;
uniform 	vec3 _Vanishpoint;
uniform 	float _InvariantPlaneZ;
uniform 	float _ScaleInZ;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = (-_Vanishpoint.z) + _InvariantPlaneZ;
    u_xlat2.xyz = in_POSITION0.xyz + (-_Vanishpoint.xyz);
    u_xlat0.x = u_xlat2.z / u_xlat0.x;
    u_xlat2.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat0.xyz = u_xlat2.xyz + _Vanishpoint.xyz;
    u_xlat4 = u_xlat0.z + (-_InvariantPlaneZ);
    u_xlat0.w = u_xlat4 * _ScaleInZ + _InvariantPlaneZ;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_PerspectiveDeformation));
#else
    u_xlatb4 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_PerspectiveDeformation);
#endif
    u_xlat0.xyz = (bool(u_xlatb4)) ? u_xlat0.xyw : in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2.xy = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_0 = u_xlat10_0 * _BloomFactor;
    SV_Target0.w = u_xlat16_0;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	mediump float _PerspectiveDeformation;
uniform 	vec3 _Vanishpoint;
uniform 	float _InvariantPlaneZ;
uniform 	float _ScaleInZ;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = (-_Vanishpoint.z) + _InvariantPlaneZ;
    u_xlat2.xyz = in_POSITION0.xyz + (-_Vanishpoint.xyz);
    u_xlat0.x = u_xlat2.z / u_xlat0.x;
    u_xlat2.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat0.xyz = u_xlat2.xyz + _Vanishpoint.xyz;
    u_xlat4 = u_xlat0.z + (-_InvariantPlaneZ);
    u_xlat0.w = u_xlat4 * _ScaleInZ + _InvariantPlaneZ;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_PerspectiveDeformation));
#else
    u_xlatb4 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_PerspectiveDeformation);
#endif
    u_xlat0.xyz = (bool(u_xlatb4)) ? u_xlat0.xyw : in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2.xy = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_0 = u_xlat10_0 * _BloomFactor;
    SV_Target0.w = u_xlat16_0;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPECIAL_STATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _PerspectiveDeformation;
uniform 	vec3 _Vanishpoint;
uniform 	float _InvariantPlaneZ;
uniform 	float _ScaleInZ;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = (-_Vanishpoint.z) + _InvariantPlaneZ;
    u_xlat2.xyz = in_POSITION0.xyz + (-_Vanishpoint.xyz);
    u_xlat0.x = u_xlat2.z / u_xlat0.x;
    u_xlat2.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat0.xyz = u_xlat2.xyz + _Vanishpoint.xyz;
    u_xlat4 = u_xlat0.z + (-_InvariantPlaneZ);
    u_xlat0.w = u_xlat4 * _ScaleInZ + _InvariantPlaneZ;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_PerspectiveDeformation));
#else
    u_xlatb4 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_PerspectiveDeformation);
#endif
    u_xlat0.xyz = (bool(u_xlatb4)) ? u_xlat0.xyw : in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = vec2(0.0, 0.0);
    vs_TEXCOORD2.xy = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _SPNoiseScaler;
uniform 	float _SPTransition;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionBloomFactor;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SPNoiseTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
vec2 u_xlat1;
mediump float u_xlat16_2;
vec3 u_xlat3;
ivec3 u_xlati3;
bvec2 u_xlatb3;
float u_xlat6;
lowp float u_xlat10_6;
void main()
{
    u_xlat10_0 = texture(_SPNoiseTex, vs_TEXCOORD1.xy).x;
    u_xlat0 = u_xlat10_0 * _SPNoiseScaler;
    u_xlat0 = u_xlat0 * 1.99000001 + -1.0;
    u_xlat3.x = _SPNoiseScaler * _SPTransition;
    u_xlat6 = u_xlat3.x * 1.5 + (-u_xlat0);
    u_xlat6 = u_xlat6 + 1.0;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati3.y = int(u_xlat6);
    u_xlat1.xy = (-u_xlat3.xx) * vec2(1.70000005, 1.5) + vec2(u_xlat0);
    u_xlat0 = u_xlat3.x * 1.70000005 + (-u_xlat0);
    u_xlat0 = u_xlat0 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat3.xz = u_xlat1.xy + vec2(1.0, 1.0);
    u_xlat3.xz = floor(u_xlat3.xz);
    u_xlat3.xz = max(u_xlat3.xz, vec2(0.0, 0.0));
    u_xlati3.xz = ivec2(u_xlat3.xz);
    u_xlatb3.xy = equal(u_xlati3.xyxx, ivec4(0, 0, 0, 0)).xy;
    u_xlatb3.x = u_xlatb3.x && u_xlatb3.y;
    u_xlat10_6 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat1.x = u_xlat10_6 * _BloomFactor;
    u_xlat6 = (-_BloomFactor) * u_xlat10_6 + _SPTransitionBloomFactor;
    u_xlat0 = u_xlat0 * u_xlat6 + u_xlat1.x;
    u_xlat16_2 = u_xlat1.x * _SPOpaqueness;
    u_xlat16_2 = (u_xlati3.z != 0) ? u_xlat1.x : u_xlat16_2;
    SV_Target0.w = (u_xlatb3.x) ? u_xlat0 : u_xlat16_2;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPECIAL_STATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _PerspectiveDeformation;
uniform 	vec3 _Vanishpoint;
uniform 	float _InvariantPlaneZ;
uniform 	float _ScaleInZ;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = (-_Vanishpoint.z) + _InvariantPlaneZ;
    u_xlat2.xyz = in_POSITION0.xyz + (-_Vanishpoint.xyz);
    u_xlat0.x = u_xlat2.z / u_xlat0.x;
    u_xlat2.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat0.xyz = u_xlat2.xyz + _Vanishpoint.xyz;
    u_xlat4 = u_xlat0.z + (-_InvariantPlaneZ);
    u_xlat0.w = u_xlat4 * _ScaleInZ + _InvariantPlaneZ;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_PerspectiveDeformation));
#else
    u_xlatb4 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_PerspectiveDeformation);
#endif
    u_xlat0.xyz = (bool(u_xlatb4)) ? u_xlat0.xyw : in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = vec2(0.0, 0.0);
    vs_TEXCOORD2.xy = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _SPNoiseScaler;
uniform 	float _SPTransition;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionBloomFactor;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SPNoiseTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
vec2 u_xlat1;
mediump float u_xlat16_2;
vec3 u_xlat3;
ivec3 u_xlati3;
bvec2 u_xlatb3;
float u_xlat6;
lowp float u_xlat10_6;
void main()
{
    u_xlat10_0 = texture(_SPNoiseTex, vs_TEXCOORD1.xy).x;
    u_xlat0 = u_xlat10_0 * _SPNoiseScaler;
    u_xlat0 = u_xlat0 * 1.99000001 + -1.0;
    u_xlat3.x = _SPNoiseScaler * _SPTransition;
    u_xlat6 = u_xlat3.x * 1.5 + (-u_xlat0);
    u_xlat6 = u_xlat6 + 1.0;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati3.y = int(u_xlat6);
    u_xlat1.xy = (-u_xlat3.xx) * vec2(1.70000005, 1.5) + vec2(u_xlat0);
    u_xlat0 = u_xlat3.x * 1.70000005 + (-u_xlat0);
    u_xlat0 = u_xlat0 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat3.xz = u_xlat1.xy + vec2(1.0, 1.0);
    u_xlat3.xz = floor(u_xlat3.xz);
    u_xlat3.xz = max(u_xlat3.xz, vec2(0.0, 0.0));
    u_xlati3.xz = ivec2(u_xlat3.xz);
    u_xlatb3.xy = equal(u_xlati3.xyxx, ivec4(0, 0, 0, 0)).xy;
    u_xlatb3.x = u_xlatb3.x && u_xlatb3.y;
    u_xlat10_6 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat1.x = u_xlat10_6 * _BloomFactor;
    u_xlat6 = (-_BloomFactor) * u_xlat10_6 + _SPTransitionBloomFactor;
    u_xlat0 = u_xlat0 * u_xlat6 + u_xlat1.x;
    u_xlat16_2 = u_xlat1.x * _SPOpaqueness;
    u_xlat16_2 = (u_xlati3.z != 0) ? u_xlat1.x : u_xlat16_2;
    SV_Target0.w = (u_xlatb3.x) ? u_xlat0 : u_xlat16_2;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPECIAL_STATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _PerspectiveDeformation;
uniform 	vec3 _Vanishpoint;
uniform 	float _InvariantPlaneZ;
uniform 	float _ScaleInZ;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = (-_Vanishpoint.z) + _InvariantPlaneZ;
    u_xlat2.xyz = in_POSITION0.xyz + (-_Vanishpoint.xyz);
    u_xlat0.x = u_xlat2.z / u_xlat0.x;
    u_xlat2.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat0.xyz = u_xlat2.xyz + _Vanishpoint.xyz;
    u_xlat4 = u_xlat0.z + (-_InvariantPlaneZ);
    u_xlat0.w = u_xlat4 * _ScaleInZ + _InvariantPlaneZ;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_PerspectiveDeformation));
#else
    u_xlatb4 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_PerspectiveDeformation);
#endif
    u_xlat0.xyz = (bool(u_xlatb4)) ? u_xlat0.xyw : in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = vec2(0.0, 0.0);
    vs_TEXCOORD2.xy = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _SPNoiseScaler;
uniform 	float _SPTransition;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionBloomFactor;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SPNoiseTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
vec2 u_xlat1;
mediump float u_xlat16_2;
vec3 u_xlat3;
ivec3 u_xlati3;
bvec2 u_xlatb3;
float u_xlat6;
lowp float u_xlat10_6;
void main()
{
    u_xlat10_0 = texture(_SPNoiseTex, vs_TEXCOORD1.xy).x;
    u_xlat0 = u_xlat10_0 * _SPNoiseScaler;
    u_xlat0 = u_xlat0 * 1.99000001 + -1.0;
    u_xlat3.x = _SPNoiseScaler * _SPTransition;
    u_xlat6 = u_xlat3.x * 1.5 + (-u_xlat0);
    u_xlat6 = u_xlat6 + 1.0;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati3.y = int(u_xlat6);
    u_xlat1.xy = (-u_xlat3.xx) * vec2(1.70000005, 1.5) + vec2(u_xlat0);
    u_xlat0 = u_xlat3.x * 1.70000005 + (-u_xlat0);
    u_xlat0 = u_xlat0 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat3.xz = u_xlat1.xy + vec2(1.0, 1.0);
    u_xlat3.xz = floor(u_xlat3.xz);
    u_xlat3.xz = max(u_xlat3.xz, vec2(0.0, 0.0));
    u_xlati3.xz = ivec2(u_xlat3.xz);
    u_xlatb3.xy = equal(u_xlati3.xyxx, ivec4(0, 0, 0, 0)).xy;
    u_xlatb3.x = u_xlatb3.x && u_xlatb3.y;
    u_xlat10_6 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat1.x = u_xlat10_6 * _BloomFactor;
    u_xlat6 = (-_BloomFactor) * u_xlat10_6 + _SPTransitionBloomFactor;
    u_xlat0 = u_xlat0 * u_xlat6 + u_xlat1.x;
    u_xlat16_2 = u_xlat1.x * _SPOpaqueness;
    u_xlat16_2 = (u_xlati3.z != 0) ? u_xlat1.x : u_xlat16_2;
    SV_Target0.w = (u_xlatb3.x) ? u_xlat0 : u_xlat16_2;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
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
Keywords { "SPECIAL_STATE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPECIAL_STATE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPECIAL_STATE" }
""
}
}
}
}
Fallback "Diffuse"
}