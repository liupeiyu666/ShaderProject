//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_UI/Image Attribute Mesh Radar" {
Properties {
_MainColor ("MainColor", Color) = (0,0,0,0)
_MainTex ("MainTex", 2D) = "white" { }
_Attribute1 ("Attribute 1", Float) = 0.25
_Attribute2 ("Attribute 2", Float) = 0.25
_Attribute3 ("Attribute 3", Float) = 0.25
_Attribute4 ("Attribute 4", Float) = 0.25
_Attribute5 ("Attribute 5", Float) = 0.25
_Attribute6 ("Attribute 6", Float) = 0.25
_LengthCorrection ("LengthCorrection", Float) = 1
_StencilComp ("Stencil Comparison", Float) = 8
_Stencil ("Stencil ID", Float) = 0
_StencilOp ("Stencil Operation", Float) = 0
_StencilWriteMask ("Stencil Write Mask", Float) = 255
_StencilReadMask ("Stencil Read Mask", Float) = 255
_ColorMask ("Color Mask", Float) = 15
_texcoord ("", 2D) = "white" { }
}
SubShader {
 LOD 100
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 46871
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _Attribute1;
uniform 	float _Attribute2;
uniform 	float _Attribute3;
uniform 	float _Attribute4;
uniform 	float _Attribute5;
uniform 	float _Attribute6;
uniform 	float _LengthCorrection;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bvec3 u_xlatb0;
vec4 u_xlat1;
bvec3 u_xlatb1;
vec3 u_xlat2;
bvec3 u_xlatb2;
vec4 u_xlat3;
bvec3 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
void main()
{
    u_xlatb0.xyz = greaterThanEqual(in_COLOR0.xyzx, vec4(0.620000005, 0.620000005, 0.620000005, 0.0)).xyz;
    u_xlat1.xyz = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb0.xyz));
    u_xlat0.x = (u_xlatb0.x) ? float(-1.0) : float(-0.0);
    u_xlat0.y = (u_xlatb0.y) ? float(-1.0) : float(-0.0);
    u_xlat0.z = (u_xlatb0.z) ? float(-1.0) : float(-0.0);
    u_xlatb2.xyz = greaterThanEqual(in_COLOR0.xyzx, vec4(0.720000029, 0.720000029, 0.720000029, 0.0)).xyz;
    u_xlat3.x = (u_xlatb2.x) ? float(-1.0) : float(-0.0);
    u_xlat3.y = (u_xlatb2.y) ? float(-1.0) : float(-0.0);
    u_xlat3.z = (u_xlatb2.z) ? float(-1.0) : float(-0.0);
    u_xlat2.xyz = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb2.xyz));
    u_xlat1.xyz = u_xlat1.xyz + u_xlat3.xyz;
    u_xlatb3.xyz = greaterThanEqual(in_COLOR0.xyzx, vec4(0.819999993, 0.819999993, 0.819999993, 0.0)).xyz;
    u_xlat4.xyz = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb3.xyz));
    u_xlat3.x = (u_xlatb3.x) ? float(-1.0) : float(-0.0);
    u_xlat3.y = (u_xlatb3.y) ? float(-1.0) : float(-0.0);
    u_xlat3.z = (u_xlatb3.z) ? float(-1.0) : float(-0.0);
    u_xlat2.xyz = u_xlat2.xyz + u_xlat3.xyz;
    u_xlat3 = vec4(_Attribute1, _Attribute2, _Attribute3, _Attribute4) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat5.xyz = in_NORMAL0.xyz * vec3(vec3(_LengthCorrection, _LengthCorrection, _LengthCorrection));
    u_xlat6.xyz = u_xlat3.yyy * u_xlat5.xyz;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat6.xyz;
    u_xlat6.xyz = u_xlat3.xxx * u_xlat5.xyz;
    u_xlat2.xyz = u_xlat6.xyz * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat3.zzz * u_xlat5.xyz;
    u_xlat4.xyz = u_xlat3.www * u_xlat5.xyz;
    u_xlat1.xyz = u_xlat3.xyz * u_xlat1.xyz + u_xlat2.xyz;
    u_xlatb2.xyz = greaterThanEqual(in_COLOR0.xyzx, vec4(0.519999981, 0.519999981, 0.519999981, 0.0)).xyz;
    u_xlat3.xyz = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb2.xyz));
    u_xlat2.x = (u_xlatb2.x) ? float(-1.0) : float(-0.0);
    u_xlat2.y = (u_xlatb2.y) ? float(-1.0) : float(-0.0);
    u_xlat2.z = (u_xlatb2.z) ? float(-1.0) : float(-0.0);
    u_xlat0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat4.xyz * u_xlat0.xyz + u_xlat1.xyz;
    u_xlatb1.xyz = greaterThanEqual(in_COLOR0.xyzx, vec4(0.419999987, 0.419999987, 0.419999987, 0.0)).xyz;
    u_xlat3.xyz = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb1.xyz));
    u_xlat1.x = (u_xlatb1.x) ? float(-1.0) : float(-0.0);
    u_xlat1.y = (u_xlatb1.y) ? float(-1.0) : float(-0.0);
    u_xlat1.z = (u_xlatb1.z) ? float(-1.0) : float(-0.0);
    u_xlat2.xyz = u_xlat2.xyz + u_xlat3.xyz;
    u_xlat3.xy = vec2(_Attribute5, _Attribute6) + vec2(-1.0, -1.0);
    u_xlat3.xzw = u_xlat5.xyz * u_xlat3.xxx;
    u_xlat4.xyz = u_xlat5.xyz * u_xlat3.yyy;
    u_xlat0.xyz = u_xlat3.xzw * u_xlat2.xyz + u_xlat0.xyz;
    u_xlatb2.xyz = greaterThanEqual(in_COLOR0.xyzx, vec4(0.319999993, 0.319999993, 0.319999993, 0.0)).xyz;
    u_xlat2.xyz = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb2.xyz));
    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat4.xyz * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
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
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainColor;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_0.xyz = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _MainColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	float _Attribute1;
uniform 	float _Attribute2;
uniform 	float _Attribute3;
uniform 	float _Attribute4;
uniform 	float _Attribute5;
uniform 	float _Attribute6;
uniform 	float _LengthCorrection;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bvec3 u_xlatb0;
vec4 u_xlat1;
bvec3 u_xlatb1;
vec3 u_xlat2;
bvec3 u_xlatb2;
vec4 u_xlat3;
bvec3 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
void main()
{
    u_xlatb0.xyz = greaterThanEqual(in_COLOR0.xyzx, vec4(0.620000005, 0.620000005, 0.620000005, 0.0)).xyz;
    u_xlat1.xyz = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb0.xyz));
    u_xlat0.x = (u_xlatb0.x) ? float(-1.0) : float(-0.0);
    u_xlat0.y = (u_xlatb0.y) ? float(-1.0) : float(-0.0);
    u_xlat0.z = (u_xlatb0.z) ? float(-1.0) : float(-0.0);
    u_xlatb2.xyz = greaterThanEqual(in_COLOR0.xyzx, vec4(0.720000029, 0.720000029, 0.720000029, 0.0)).xyz;
    u_xlat3.x = (u_xlatb2.x) ? float(-1.0) : float(-0.0);
    u_xlat3.y = (u_xlatb2.y) ? float(-1.0) : float(-0.0);
    u_xlat3.z = (u_xlatb2.z) ? float(-1.0) : float(-0.0);
    u_xlat2.xyz = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb2.xyz));
    u_xlat1.xyz = u_xlat1.xyz + u_xlat3.xyz;
    u_xlatb3.xyz = greaterThanEqual(in_COLOR0.xyzx, vec4(0.819999993, 0.819999993, 0.819999993, 0.0)).xyz;
    u_xlat4.xyz = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb3.xyz));
    u_xlat3.x = (u_xlatb3.x) ? float(-1.0) : float(-0.0);
    u_xlat3.y = (u_xlatb3.y) ? float(-1.0) : float(-0.0);
    u_xlat3.z = (u_xlatb3.z) ? float(-1.0) : float(-0.0);
    u_xlat2.xyz = u_xlat2.xyz + u_xlat3.xyz;
    u_xlat3 = vec4(_Attribute1, _Attribute2, _Attribute3, _Attribute4) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat5.xyz = in_NORMAL0.xyz * vec3(vec3(_LengthCorrection, _LengthCorrection, _LengthCorrection));
    u_xlat6.xyz = u_xlat3.yyy * u_xlat5.xyz;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat6.xyz;
    u_xlat6.xyz = u_xlat3.xxx * u_xlat5.xyz;
    u_xlat2.xyz = u_xlat6.xyz * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat3.zzz * u_xlat5.xyz;
    u_xlat4.xyz = u_xlat3.www * u_xlat5.xyz;
    u_xlat1.xyz = u_xlat3.xyz * u_xlat1.xyz + u_xlat2.xyz;
    u_xlatb2.xyz = greaterThanEqual(in_COLOR0.xyzx, vec4(0.519999981, 0.519999981, 0.519999981, 0.0)).xyz;
    u_xlat3.xyz = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb2.xyz));
    u_xlat2.x = (u_xlatb2.x) ? float(-1.0) : float(-0.0);
    u_xlat2.y = (u_xlatb2.y) ? float(-1.0) : float(-0.0);
    u_xlat2.z = (u_xlatb2.z) ? float(-1.0) : float(-0.0);
    u_xlat0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat4.xyz * u_xlat0.xyz + u_xlat1.xyz;
    u_xlatb1.xyz = greaterThanEqual(in_COLOR0.xyzx, vec4(0.419999987, 0.419999987, 0.419999987, 0.0)).xyz;
    u_xlat3.xyz = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb1.xyz));
    u_xlat1.x = (u_xlatb1.x) ? float(-1.0) : float(-0.0);
    u_xlat1.y = (u_xlatb1.y) ? float(-1.0) : float(-0.0);
    u_xlat1.z = (u_xlatb1.z) ? float(-1.0) : float(-0.0);
    u_xlat2.xyz = u_xlat2.xyz + u_xlat3.xyz;
    u_xlat3.xy = vec2(_Attribute5, _Attribute6) + vec2(-1.0, -1.0);
    u_xlat3.xzw = u_xlat5.xyz * u_xlat3.xxx;
    u_xlat4.xyz = u_xlat5.xyz * u_xlat3.yyy;
    u_xlat0.xyz = u_xlat3.xzw * u_xlat2.xyz + u_xlat0.xyz;
    u_xlatb2.xyz = greaterThanEqual(in_COLOR0.xyzx, vec4(0.319999993, 0.319999993, 0.319999993, 0.0)).xyz;
    u_xlat2.xyz = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb2.xyz));
    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat4.xyz * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
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
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainColor;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_0.xyz = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _MainColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	float _Attribute1;
uniform 	float _Attribute2;
uniform 	float _Attribute3;
uniform 	float _Attribute4;
uniform 	float _Attribute5;
uniform 	float _Attribute6;
uniform 	float _LengthCorrection;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bvec3 u_xlatb0;
vec4 u_xlat1;
bvec3 u_xlatb1;
vec3 u_xlat2;
bvec3 u_xlatb2;
vec4 u_xlat3;
bvec3 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
void main()
{
    u_xlatb0.xyz = greaterThanEqual(in_COLOR0.xyzx, vec4(0.620000005, 0.620000005, 0.620000005, 0.0)).xyz;
    u_xlat1.xyz = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb0.xyz));
    u_xlat0.x = (u_xlatb0.x) ? float(-1.0) : float(-0.0);
    u_xlat0.y = (u_xlatb0.y) ? float(-1.0) : float(-0.0);
    u_xlat0.z = (u_xlatb0.z) ? float(-1.0) : float(-0.0);
    u_xlatb2.xyz = greaterThanEqual(in_COLOR0.xyzx, vec4(0.720000029, 0.720000029, 0.720000029, 0.0)).xyz;
    u_xlat3.x = (u_xlatb2.x) ? float(-1.0) : float(-0.0);
    u_xlat3.y = (u_xlatb2.y) ? float(-1.0) : float(-0.0);
    u_xlat3.z = (u_xlatb2.z) ? float(-1.0) : float(-0.0);
    u_xlat2.xyz = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb2.xyz));
    u_xlat1.xyz = u_xlat1.xyz + u_xlat3.xyz;
    u_xlatb3.xyz = greaterThanEqual(in_COLOR0.xyzx, vec4(0.819999993, 0.819999993, 0.819999993, 0.0)).xyz;
    u_xlat4.xyz = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb3.xyz));
    u_xlat3.x = (u_xlatb3.x) ? float(-1.0) : float(-0.0);
    u_xlat3.y = (u_xlatb3.y) ? float(-1.0) : float(-0.0);
    u_xlat3.z = (u_xlatb3.z) ? float(-1.0) : float(-0.0);
    u_xlat2.xyz = u_xlat2.xyz + u_xlat3.xyz;
    u_xlat3 = vec4(_Attribute1, _Attribute2, _Attribute3, _Attribute4) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat5.xyz = in_NORMAL0.xyz * vec3(vec3(_LengthCorrection, _LengthCorrection, _LengthCorrection));
    u_xlat6.xyz = u_xlat3.yyy * u_xlat5.xyz;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat6.xyz;
    u_xlat6.xyz = u_xlat3.xxx * u_xlat5.xyz;
    u_xlat2.xyz = u_xlat6.xyz * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat3.zzz * u_xlat5.xyz;
    u_xlat4.xyz = u_xlat3.www * u_xlat5.xyz;
    u_xlat1.xyz = u_xlat3.xyz * u_xlat1.xyz + u_xlat2.xyz;
    u_xlatb2.xyz = greaterThanEqual(in_COLOR0.xyzx, vec4(0.519999981, 0.519999981, 0.519999981, 0.0)).xyz;
    u_xlat3.xyz = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb2.xyz));
    u_xlat2.x = (u_xlatb2.x) ? float(-1.0) : float(-0.0);
    u_xlat2.y = (u_xlatb2.y) ? float(-1.0) : float(-0.0);
    u_xlat2.z = (u_xlatb2.z) ? float(-1.0) : float(-0.0);
    u_xlat0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat4.xyz * u_xlat0.xyz + u_xlat1.xyz;
    u_xlatb1.xyz = greaterThanEqual(in_COLOR0.xyzx, vec4(0.419999987, 0.419999987, 0.419999987, 0.0)).xyz;
    u_xlat3.xyz = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb1.xyz));
    u_xlat1.x = (u_xlatb1.x) ? float(-1.0) : float(-0.0);
    u_xlat1.y = (u_xlatb1.y) ? float(-1.0) : float(-0.0);
    u_xlat1.z = (u_xlatb1.z) ? float(-1.0) : float(-0.0);
    u_xlat2.xyz = u_xlat2.xyz + u_xlat3.xyz;
    u_xlat3.xy = vec2(_Attribute5, _Attribute6) + vec2(-1.0, -1.0);
    u_xlat3.xzw = u_xlat5.xyz * u_xlat3.xxx;
    u_xlat4.xyz = u_xlat5.xyz * u_xlat3.yyy;
    u_xlat0.xyz = u_xlat3.xzw * u_xlat2.xyz + u_xlat0.xyz;
    u_xlatb2.xyz = greaterThanEqual(in_COLOR0.xyzx, vec4(0.319999993, 0.319999993, 0.319999993, 0.0)).xyz;
    u_xlat2.xyz = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb2.xyz));
    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat4.xyz * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
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
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainColor;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_0.xyz = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _MainColor.xyz;
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
""
}
SubProgram "gles3 hw_tier01 " {
""
}
SubProgram "gles3 hw_tier02 " {
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "RECT_MASK" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "RECT_MASK" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "RECT_MASK" }
""
}
}
}
}
CustomEditor "ASEMaterialInspector"
}