//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Character/Character_Prop/Prop_Matcap_Outline" {
Properties {
_Color ("Color", Color) = (1,1,1,1)
_Scale ("Scale Compared to Maya", Float) = 0.01
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Base (RGB)", 2D) = "white" { }
_MatCap ("MatCap (RGB)", 2D) = "white" { }
_MetalRef ("MetalRef", Range(0, 1)) = 0
_OutlineWidth ("Outline Width", Range(0, 100)) = 0.2
_OutlineColor ("Outline Color", Color) = (0,0,0,1)
}
SubShader {
 LOD 200
 Tags { "OutlineType" = "Simple" "RenderType" = "Opaque" }
 Pass {
  LOD 200
  Tags { "OutlineType" = "Simple" "RenderType" = "Opaque" }
  GpuProgramID 4887
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.zxy;
    u_xlat9 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * in_TANGENT0.yzx;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat0.y = dot(u_xlat0.xyz, (-u_xlat1.xyz));
    u_xlat0.x = dot(in_TANGENT0.xyz, (-u_xlat1.xyz));
    u_xlat0.z = dot(in_NORMAL0.xyz, (-u_xlat1.xyz));
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD2.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _MetalRef;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MatCap;
in highp vec2 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec2 u_xlat4;
float u_xlat6;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vs_TEXCOORD1.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * vs_TEXCOORD1.zzz + u_xlat0.xyz;
    u_xlat6 = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
    u_xlat6 = u_xlat6 + u_xlat6;
    u_xlat1.xyz = u_xlat0.xyz * (-vec3(u_xlat6)) + vs_TEXCOORD2.xyz;
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xy = u_xlat1.xy * u_xlat4.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat4.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _Color.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.zxy;
    u_xlat9 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * in_TANGENT0.yzx;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat0.y = dot(u_xlat0.xyz, (-u_xlat1.xyz));
    u_xlat0.x = dot(in_TANGENT0.xyz, (-u_xlat1.xyz));
    u_xlat0.z = dot(in_NORMAL0.xyz, (-u_xlat1.xyz));
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD2.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _MetalRef;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MatCap;
in highp vec2 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec2 u_xlat4;
float u_xlat6;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vs_TEXCOORD1.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * vs_TEXCOORD1.zzz + u_xlat0.xyz;
    u_xlat6 = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
    u_xlat6 = u_xlat6 + u_xlat6;
    u_xlat1.xyz = u_xlat0.xyz * (-vec3(u_xlat6)) + vs_TEXCOORD2.xyz;
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xy = u_xlat1.xy * u_xlat4.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat4.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _Color.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.zxy;
    u_xlat9 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * in_TANGENT0.yzx;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat1.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
    u_xlat0.y = dot(u_xlat0.xyz, (-u_xlat1.xyz));
    u_xlat0.x = dot(in_TANGENT0.xyz, (-u_xlat1.xyz));
    u_xlat0.z = dot(in_NORMAL0.xyz, (-u_xlat1.xyz));
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD2.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _MetalRef;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MatCap;
in highp vec2 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec2 u_xlat4;
float u_xlat6;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * vs_TEXCOORD1.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * vs_TEXCOORD1.zzz + u_xlat0.xyz;
    u_xlat6 = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
    u_xlat6 = u_xlat6 + u_xlat6;
    u_xlat1.xyz = u_xlat0.xyz * (-vec3(u_xlat6)) + vs_TEXCOORD2.xyz;
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xy = u_xlat1.xy * u_xlat4.xx + (-u_xlat0.xy);
    u_xlat0.xy = vec2(_MetalRef) * u_xlat4.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture(_MatCap, u_xlat0.xy).xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _Color.xyz;
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
}
}
 Pass {
  LOD 200
  Tags { "OutlineType" = "Simple" "RenderType" = "Opaque" }
  Cull Front
  GpuProgramID 94202
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump float _OutlineWidth;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump float _Scale;
uniform 	mediump float _VertexAlphaFactor;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
mediump float u_xlat16_7;
float u_xlat8;
mediump vec2 u_xlat16_15;
float u_xlat16;
bool u_xlatb16;
float u_xlat24;
void main()
{
    u_xlat0.x = _ClipPlane.w + -0.00999999978;
    u_xlat8 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat8;
    u_xlat8 = u_xlat8 + (-_ClipPlane.w);
    u_xlat1.xyz = (-vec3(u_xlat8)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat2;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat3;
    u_xlat8 = u_xlat3.z * in_POSITION0.y;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat4;
    u_xlat8 = u_xlat4.z * in_POSITION0.x + u_xlat8;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat5;
    u_xlat8 = u_xlat5.z * in_POSITION0.z + u_xlat8;
    u_xlat8 = u_xlat2.z * in_POSITION0.w + u_xlat8;
    u_xlat8 = (-u_xlat8) + (-_ProjectionParams.y);
    u_xlat8 = u_xlat8 + (-_FadeOffset);
    u_xlat8 = u_xlat8 / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat8 * _OutlineColor.w;
    u_xlat16 = in_COLOR0.w + -1.0;
    u_xlat16 = _VertexAlphaFactor * u_xlat16 + 1.0;
    u_xlat6.w = u_xlat16 * u_xlat8;
    u_xlat6.xyz = in_POSITION0.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = (int(u_xlati0) != 0) ? u_xlat6 : u_xlat1;
    u_xlat1 = u_xlat0.yyyy * u_xlat3;
    u_xlat3.xy = u_xlat3.xy * in_TANGENT0.yy;
    u_xlat3.xy = u_xlat4.xy * in_TANGENT0.xx + u_xlat3.xy;
    u_xlat1 = u_xlat4 * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = u_xlat5 * u_xlat0.zzzz + u_xlat1;
    u_xlat0.xy = u_xlat5.xy * in_TANGENT0.zz + u_xlat3.xy;
    vs_COLOR0.w = u_xlat0.w;
    u_xlat1 = u_xlat2 * in_POSITION0.wwww + u_xlat1;
    u_xlat1 = u_xlat1 / u_xlat1.wwww;
    u_xlat24 = (-u_xlat1.z) / hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat16_7 = u_xlat24 / _Scale;
    u_xlat24 = inversesqrt(u_xlat16_7);
    u_xlat24 = float(1.0) / u_xlat24;
    u_xlat16_7 = _OutlineWidth * _Scale;
    u_xlat16_7 = u_xlat24 * u_xlat16_7;
    u_xlat0.z = 0.00999999978;
    u_xlat16_15.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_15.x = inversesqrt(u_xlat16_15.x);
    u_xlat16_15.xy = u_xlat0.xy * u_xlat16_15.xx;
    u_xlat0.xy = u_xlat16_15.xy * vec2(u_xlat16_7) + u_xlat1.xy;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb16 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb16)));
    vs_TEXCOORD3.z = u_xlatb16 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _Opaqueness;
uniform 	float _UsingDitherAlpha;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb4;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb4.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb4.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb4.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD3.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    SV_Target0.xyz = vs_COLOR0.xyz * _Color.xyz;
    SV_Target0.w = vs_COLOR0.w * _Opaqueness;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump float _OutlineWidth;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump float _Scale;
uniform 	mediump float _VertexAlphaFactor;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
mediump float u_xlat16_7;
float u_xlat8;
mediump vec2 u_xlat16_15;
float u_xlat16;
bool u_xlatb16;
float u_xlat24;
void main()
{
    u_xlat0.x = _ClipPlane.w + -0.00999999978;
    u_xlat8 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat8;
    u_xlat8 = u_xlat8 + (-_ClipPlane.w);
    u_xlat1.xyz = (-vec3(u_xlat8)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat2;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat3;
    u_xlat8 = u_xlat3.z * in_POSITION0.y;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat4;
    u_xlat8 = u_xlat4.z * in_POSITION0.x + u_xlat8;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat5;
    u_xlat8 = u_xlat5.z * in_POSITION0.z + u_xlat8;
    u_xlat8 = u_xlat2.z * in_POSITION0.w + u_xlat8;
    u_xlat8 = (-u_xlat8) + (-_ProjectionParams.y);
    u_xlat8 = u_xlat8 + (-_FadeOffset);
    u_xlat8 = u_xlat8 / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat8 * _OutlineColor.w;
    u_xlat16 = in_COLOR0.w + -1.0;
    u_xlat16 = _VertexAlphaFactor * u_xlat16 + 1.0;
    u_xlat6.w = u_xlat16 * u_xlat8;
    u_xlat6.xyz = in_POSITION0.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = (int(u_xlati0) != 0) ? u_xlat6 : u_xlat1;
    u_xlat1 = u_xlat0.yyyy * u_xlat3;
    u_xlat3.xy = u_xlat3.xy * in_TANGENT0.yy;
    u_xlat3.xy = u_xlat4.xy * in_TANGENT0.xx + u_xlat3.xy;
    u_xlat1 = u_xlat4 * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = u_xlat5 * u_xlat0.zzzz + u_xlat1;
    u_xlat0.xy = u_xlat5.xy * in_TANGENT0.zz + u_xlat3.xy;
    vs_COLOR0.w = u_xlat0.w;
    u_xlat1 = u_xlat2 * in_POSITION0.wwww + u_xlat1;
    u_xlat1 = u_xlat1 / u_xlat1.wwww;
    u_xlat24 = (-u_xlat1.z) / hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat16_7 = u_xlat24 / _Scale;
    u_xlat24 = inversesqrt(u_xlat16_7);
    u_xlat24 = float(1.0) / u_xlat24;
    u_xlat16_7 = _OutlineWidth * _Scale;
    u_xlat16_7 = u_xlat24 * u_xlat16_7;
    u_xlat0.z = 0.00999999978;
    u_xlat16_15.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_15.x = inversesqrt(u_xlat16_15.x);
    u_xlat16_15.xy = u_xlat0.xy * u_xlat16_15.xx;
    u_xlat0.xy = u_xlat16_15.xy * vec2(u_xlat16_7) + u_xlat1.xy;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb16 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb16)));
    vs_TEXCOORD3.z = u_xlatb16 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _Opaqueness;
uniform 	float _UsingDitherAlpha;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb4;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb4.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb4.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb4.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD3.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    SV_Target0.xyz = vs_COLOR0.xyz * _Color.xyz;
    SV_Target0.w = vs_COLOR0.w * _Opaqueness;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump float _OutlineWidth;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump float _Scale;
uniform 	mediump float _VertexAlphaFactor;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
mediump float u_xlat16_7;
float u_xlat8;
mediump vec2 u_xlat16_15;
float u_xlat16;
bool u_xlatb16;
float u_xlat24;
void main()
{
    u_xlat0.x = _ClipPlane.w + -0.00999999978;
    u_xlat8 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat8;
    u_xlat8 = u_xlat8 + (-_ClipPlane.w);
    u_xlat1.xyz = (-vec3(u_xlat8)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat2;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat3;
    u_xlat8 = u_xlat3.z * in_POSITION0.y;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat4;
    u_xlat8 = u_xlat4.z * in_POSITION0.x + u_xlat8;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat5;
    u_xlat8 = u_xlat5.z * in_POSITION0.z + u_xlat8;
    u_xlat8 = u_xlat2.z * in_POSITION0.w + u_xlat8;
    u_xlat8 = (-u_xlat8) + (-_ProjectionParams.y);
    u_xlat8 = u_xlat8 + (-_FadeOffset);
    u_xlat8 = u_xlat8 / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat8 * _OutlineColor.w;
    u_xlat16 = in_COLOR0.w + -1.0;
    u_xlat16 = _VertexAlphaFactor * u_xlat16 + 1.0;
    u_xlat6.w = u_xlat16 * u_xlat8;
    u_xlat6.xyz = in_POSITION0.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = (int(u_xlati0) != 0) ? u_xlat6 : u_xlat1;
    u_xlat1 = u_xlat0.yyyy * u_xlat3;
    u_xlat3.xy = u_xlat3.xy * in_TANGENT0.yy;
    u_xlat3.xy = u_xlat4.xy * in_TANGENT0.xx + u_xlat3.xy;
    u_xlat1 = u_xlat4 * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = u_xlat5 * u_xlat0.zzzz + u_xlat1;
    u_xlat0.xy = u_xlat5.xy * in_TANGENT0.zz + u_xlat3.xy;
    vs_COLOR0.w = u_xlat0.w;
    u_xlat1 = u_xlat2 * in_POSITION0.wwww + u_xlat1;
    u_xlat1 = u_xlat1 / u_xlat1.wwww;
    u_xlat24 = (-u_xlat1.z) / hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat16_7 = u_xlat24 / _Scale;
    u_xlat24 = inversesqrt(u_xlat16_7);
    u_xlat24 = float(1.0) / u_xlat24;
    u_xlat16_7 = _OutlineWidth * _Scale;
    u_xlat16_7 = u_xlat24 * u_xlat16_7;
    u_xlat0.z = 0.00999999978;
    u_xlat16_15.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_15.x = inversesqrt(u_xlat16_15.x);
    u_xlat16_15.xy = u_xlat0.xy * u_xlat16_15.xx;
    u_xlat0.xy = u_xlat16_15.xy * vec2(u_xlat16_7) + u_xlat1.xy;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb16 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb16)));
    vs_TEXCOORD3.z = u_xlatb16 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _Opaqueness;
uniform 	float _UsingDitherAlpha;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb4;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb4.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb4.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb4.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD3.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    SV_Target0.xyz = vs_COLOR0.xyz * _Color.xyz;
    SV_Target0.w = vs_COLOR0.w * _Opaqueness;
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
Keywords { "SPECIAL_STATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 _SPNoiseTex_ST;
uniform 	mediump float _OutlineWidth;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump float _Scale;
uniform 	mediump float _VertexAlphaFactor;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
mediump float u_xlat16_7;
float u_xlat8;
mediump vec2 u_xlat16_15;
float u_xlat16;
bool u_xlatb16;
void main()
{
    u_xlat0.x = _ClipPlane.w + -0.00999999978;
    u_xlat8 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat8;
    u_xlat8 = u_xlat8 + (-_ClipPlane.w);
    u_xlat1.xyz = (-vec3(u_xlat8)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat2;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat3;
    u_xlat8 = u_xlat3.z * in_POSITION0.y;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat4;
    u_xlat8 = u_xlat4.z * in_POSITION0.x + u_xlat8;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat5;
    u_xlat8 = u_xlat5.z * in_POSITION0.z + u_xlat8;
    u_xlat8 = u_xlat2.z * in_POSITION0.w + u_xlat8;
    u_xlat8 = (-u_xlat8) + (-_ProjectionParams.y);
    u_xlat8 = u_xlat8 + (-_FadeOffset);
    u_xlat8 = u_xlat8 / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat8 * _OutlineColor.w;
    u_xlat16 = in_COLOR0.w + -1.0;
    u_xlat16 = _VertexAlphaFactor * u_xlat16 + 1.0;
    u_xlat6.w = u_xlat16 * u_xlat8;
    u_xlat6.xyz = in_POSITION0.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = (int(u_xlati0) != 0) ? u_xlat6 : u_xlat1;
    u_xlat1 = u_xlat0.yyyy * u_xlat3;
    u_xlat3.xy = u_xlat3.xy * in_TANGENT0.yy;
    u_xlat3.xy = u_xlat4.xy * in_TANGENT0.xx + u_xlat3.xy;
    u_xlat1 = u_xlat4 * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = u_xlat5 * u_xlat0.zzzz + u_xlat1;
    u_xlat3.xy = u_xlat5.xy * in_TANGENT0.zz + u_xlat3.xy;
    u_xlat1 = u_xlat2 * in_POSITION0.wwww + u_xlat1;
    u_xlat1 = u_xlat1 / u_xlat1.wwww;
    u_xlat2.x = (-u_xlat1.z) / hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat16_7 = u_xlat2.x / _Scale;
    u_xlat2.x = inversesqrt(u_xlat16_7);
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat16_7 = _OutlineWidth * _Scale;
    u_xlat16_7 = u_xlat2.x * u_xlat16_7;
    u_xlat3.z = 0.00999999978;
    u_xlat16_15.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_15.x = inversesqrt(u_xlat16_15.x);
    u_xlat16_15.xy = u_xlat3.xy * u_xlat16_15.xx;
    u_xlat1.xy = u_xlat16_15.xy * vec2(u_xlat16_7) + u_xlat1.xy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_COLOR0.w = u_xlat0.w;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    u_xlat2 = u_xlat0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat0.x = u_xlat0.x * u_xlat2.x;
    u_xlat8 = u_xlat2.w + u_xlat2.y;
    u_xlat2.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat2.y = u_xlat0.x * 0.25 + u_xlat8;
    vs_TEXCOORD0.xy = u_xlat2.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.zz + u_xlat0.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb16 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xy = mix(vec2(0.0, 0.0), u_xlat0.xy, vec2(bvec2(u_xlatb16)));
    vs_TEXCOORD3.w = u_xlatb16 ? u_xlat1.w : float(0.0);
    vs_TEXCOORD3.z = u_xlatb16 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	float _SPNoiseScaler;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPOutlineColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _Opaqueness;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _SPNoiseTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat2;
bvec2 u_xlatb4;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb4.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb4.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb4.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD3.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_SPNoiseTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 * _SPNoiseScaler;
    u_xlat0.x = u_xlat0.x * 1.99000001 + -1.0;
    u_xlat2 = _SPNoiseScaler * _SPTransition;
    u_xlat0.x = u_xlat2 * 1.70000005 + (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat16_0 = (int(u_xlati0) != 0) ? _SPOutlineColor : vs_COLOR0;
    SV_Target0.xyz = u_xlat16_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat16_0.w * _Opaqueness;
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
Keywords { "SPECIAL_STATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 _SPNoiseTex_ST;
uniform 	mediump float _OutlineWidth;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump float _Scale;
uniform 	mediump float _VertexAlphaFactor;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
mediump float u_xlat16_7;
float u_xlat8;
mediump vec2 u_xlat16_15;
float u_xlat16;
bool u_xlatb16;
void main()
{
    u_xlat0.x = _ClipPlane.w + -0.00999999978;
    u_xlat8 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat8;
    u_xlat8 = u_xlat8 + (-_ClipPlane.w);
    u_xlat1.xyz = (-vec3(u_xlat8)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat2;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat3;
    u_xlat8 = u_xlat3.z * in_POSITION0.y;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat4;
    u_xlat8 = u_xlat4.z * in_POSITION0.x + u_xlat8;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat5;
    u_xlat8 = u_xlat5.z * in_POSITION0.z + u_xlat8;
    u_xlat8 = u_xlat2.z * in_POSITION0.w + u_xlat8;
    u_xlat8 = (-u_xlat8) + (-_ProjectionParams.y);
    u_xlat8 = u_xlat8 + (-_FadeOffset);
    u_xlat8 = u_xlat8 / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat8 * _OutlineColor.w;
    u_xlat16 = in_COLOR0.w + -1.0;
    u_xlat16 = _VertexAlphaFactor * u_xlat16 + 1.0;
    u_xlat6.w = u_xlat16 * u_xlat8;
    u_xlat6.xyz = in_POSITION0.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = (int(u_xlati0) != 0) ? u_xlat6 : u_xlat1;
    u_xlat1 = u_xlat0.yyyy * u_xlat3;
    u_xlat3.xy = u_xlat3.xy * in_TANGENT0.yy;
    u_xlat3.xy = u_xlat4.xy * in_TANGENT0.xx + u_xlat3.xy;
    u_xlat1 = u_xlat4 * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = u_xlat5 * u_xlat0.zzzz + u_xlat1;
    u_xlat3.xy = u_xlat5.xy * in_TANGENT0.zz + u_xlat3.xy;
    u_xlat1 = u_xlat2 * in_POSITION0.wwww + u_xlat1;
    u_xlat1 = u_xlat1 / u_xlat1.wwww;
    u_xlat2.x = (-u_xlat1.z) / hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat16_7 = u_xlat2.x / _Scale;
    u_xlat2.x = inversesqrt(u_xlat16_7);
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat16_7 = _OutlineWidth * _Scale;
    u_xlat16_7 = u_xlat2.x * u_xlat16_7;
    u_xlat3.z = 0.00999999978;
    u_xlat16_15.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_15.x = inversesqrt(u_xlat16_15.x);
    u_xlat16_15.xy = u_xlat3.xy * u_xlat16_15.xx;
    u_xlat1.xy = u_xlat16_15.xy * vec2(u_xlat16_7) + u_xlat1.xy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_COLOR0.w = u_xlat0.w;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    u_xlat2 = u_xlat0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat0.x = u_xlat0.x * u_xlat2.x;
    u_xlat8 = u_xlat2.w + u_xlat2.y;
    u_xlat2.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat2.y = u_xlat0.x * 0.25 + u_xlat8;
    vs_TEXCOORD0.xy = u_xlat2.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.zz + u_xlat0.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb16 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xy = mix(vec2(0.0, 0.0), u_xlat0.xy, vec2(bvec2(u_xlatb16)));
    vs_TEXCOORD3.w = u_xlatb16 ? u_xlat1.w : float(0.0);
    vs_TEXCOORD3.z = u_xlatb16 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	float _SPNoiseScaler;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPOutlineColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _Opaqueness;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _SPNoiseTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat2;
bvec2 u_xlatb4;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb4.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb4.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb4.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD3.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_SPNoiseTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 * _SPNoiseScaler;
    u_xlat0.x = u_xlat0.x * 1.99000001 + -1.0;
    u_xlat2 = _SPNoiseScaler * _SPTransition;
    u_xlat0.x = u_xlat2 * 1.70000005 + (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat16_0 = (int(u_xlati0) != 0) ? _SPOutlineColor : vs_COLOR0;
    SV_Target0.xyz = u_xlat16_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat16_0.w * _Opaqueness;
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
Keywords { "SPECIAL_STATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 _SPNoiseTex_ST;
uniform 	mediump float _OutlineWidth;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump float _Scale;
uniform 	mediump float _VertexAlphaFactor;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
mediump float u_xlat16_7;
float u_xlat8;
mediump vec2 u_xlat16_15;
float u_xlat16;
bool u_xlatb16;
void main()
{
    u_xlat0.x = _ClipPlane.w + -0.00999999978;
    u_xlat8 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat8;
    u_xlat8 = u_xlat8 + (-_ClipPlane.w);
    u_xlat1.xyz = (-vec3(u_xlat8)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat2;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat3;
    u_xlat8 = u_xlat3.z * in_POSITION0.y;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat4;
    u_xlat8 = u_xlat4.z * in_POSITION0.x + u_xlat8;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat5;
    u_xlat8 = u_xlat5.z * in_POSITION0.z + u_xlat8;
    u_xlat8 = u_xlat2.z * in_POSITION0.w + u_xlat8;
    u_xlat8 = (-u_xlat8) + (-_ProjectionParams.y);
    u_xlat8 = u_xlat8 + (-_FadeOffset);
    u_xlat8 = u_xlat8 / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat8 * _OutlineColor.w;
    u_xlat16 = in_COLOR0.w + -1.0;
    u_xlat16 = _VertexAlphaFactor * u_xlat16 + 1.0;
    u_xlat6.w = u_xlat16 * u_xlat8;
    u_xlat6.xyz = in_POSITION0.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = (int(u_xlati0) != 0) ? u_xlat6 : u_xlat1;
    u_xlat1 = u_xlat0.yyyy * u_xlat3;
    u_xlat3.xy = u_xlat3.xy * in_TANGENT0.yy;
    u_xlat3.xy = u_xlat4.xy * in_TANGENT0.xx + u_xlat3.xy;
    u_xlat1 = u_xlat4 * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = u_xlat5 * u_xlat0.zzzz + u_xlat1;
    u_xlat3.xy = u_xlat5.xy * in_TANGENT0.zz + u_xlat3.xy;
    u_xlat1 = u_xlat2 * in_POSITION0.wwww + u_xlat1;
    u_xlat1 = u_xlat1 / u_xlat1.wwww;
    u_xlat2.x = (-u_xlat1.z) / hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat16_7 = u_xlat2.x / _Scale;
    u_xlat2.x = inversesqrt(u_xlat16_7);
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat16_7 = _OutlineWidth * _Scale;
    u_xlat16_7 = u_xlat2.x * u_xlat16_7;
    u_xlat3.z = 0.00999999978;
    u_xlat16_15.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_15.x = inversesqrt(u_xlat16_15.x);
    u_xlat16_15.xy = u_xlat3.xy * u_xlat16_15.xx;
    u_xlat1.xy = u_xlat16_15.xy * vec2(u_xlat16_7) + u_xlat1.xy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_COLOR0.w = u_xlat0.w;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    u_xlat2 = u_xlat0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat0.x = u_xlat0.x * u_xlat2.x;
    u_xlat8 = u_xlat2.w + u_xlat2.y;
    u_xlat2.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat2.y = u_xlat0.x * 0.25 + u_xlat8;
    vs_TEXCOORD0.xy = u_xlat2.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.zz + u_xlat0.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb16 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xy = mix(vec2(0.0, 0.0), u_xlat0.xy, vec2(bvec2(u_xlatb16)));
    vs_TEXCOORD3.w = u_xlatb16 ? u_xlat1.w : float(0.0);
    vs_TEXCOORD3.z = u_xlatb16 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	float _SPNoiseScaler;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPOutlineColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _Opaqueness;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _SPNoiseTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat2;
bvec2 u_xlatb4;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb4.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb4.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb4.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD3.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_SPNoiseTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 * _SPNoiseScaler;
    u_xlat0.x = u_xlat0.x * 1.99000001 + -1.0;
    u_xlat2 = _SPNoiseScaler * _SPTransition;
    u_xlat0.x = u_xlat2 * 1.70000005 + (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat16_0 = (int(u_xlati0) != 0) ? _SPOutlineColor : vs_COLOR0;
    SV_Target0.xyz = u_xlat16_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat16_0.w * _Opaqueness;
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
Keywords { "CLIP_PLANE_WORLD" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump float _OutlineWidth;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump float _Scale;
uniform 	mediump float _VertexAlphaFactor;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
mediump float u_xlat16_7;
vec3 u_xlat8;
mediump vec2 u_xlat16_15;
float u_xlat16;
bool u_xlatb16;
float u_xlat24;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(abs(_ClipPlane.w)<0.00100000005);
#else
    u_xlatb0 = abs(_ClipPlane.w)<0.00100000005;
#endif
    u_xlat8.xyz = _ClipPlane.www * _ClipPlane.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? vec3(0.0, 0.0, 0.0) : u_xlat8.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToObject[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToObject[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * _ClipPlane.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _ClipPlane.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _ClipPlane.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat8.x = dot(in_POSITION0.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat8.x;
    u_xlat1.xyz = (-u_xlat0.xxx) * u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat2;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat3;
    u_xlat8.x = u_xlat3.z * in_POSITION0.y;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat4;
    u_xlat8.x = u_xlat4.z * in_POSITION0.x + u_xlat8.x;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat5;
    u_xlat8.x = u_xlat5.z * in_POSITION0.z + u_xlat8.x;
    u_xlat8.x = u_xlat2.z * in_POSITION0.w + u_xlat8.x;
    u_xlat8.x = (-u_xlat8.x) + (-_ProjectionParams.y);
    u_xlat8.x = u_xlat8.x + (-_FadeOffset);
    u_xlat8.x = u_xlat8.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat8.x = u_xlat8.x * _OutlineColor.w;
    u_xlat16 = in_COLOR0.w + -1.0;
    u_xlat16 = _VertexAlphaFactor * u_xlat16 + 1.0;
    u_xlat6.w = u_xlat16 * u_xlat8.x;
    u_xlat6.xyz = in_POSITION0.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = (int(u_xlati0) != 0) ? u_xlat6 : u_xlat1;
    u_xlat1 = u_xlat0.yyyy * u_xlat3;
    u_xlat3.xy = u_xlat3.xy * in_TANGENT0.yy;
    u_xlat3.xy = u_xlat4.xy * in_TANGENT0.xx + u_xlat3.xy;
    u_xlat1 = u_xlat4 * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = u_xlat5 * u_xlat0.zzzz + u_xlat1;
    u_xlat0.xy = u_xlat5.xy * in_TANGENT0.zz + u_xlat3.xy;
    vs_COLOR0.w = u_xlat0.w;
    u_xlat1 = u_xlat2 * in_POSITION0.wwww + u_xlat1;
    u_xlat1 = u_xlat1 / u_xlat1.wwww;
    u_xlat24 = (-u_xlat1.z) / hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat16_7 = u_xlat24 / _Scale;
    u_xlat24 = inversesqrt(u_xlat16_7);
    u_xlat24 = float(1.0) / u_xlat24;
    u_xlat16_7 = _OutlineWidth * _Scale;
    u_xlat16_7 = u_xlat24 * u_xlat16_7;
    u_xlat0.z = 0.00999999978;
    u_xlat16_15.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_15.x = inversesqrt(u_xlat16_15.x);
    u_xlat16_15.xy = u_xlat0.xy * u_xlat16_15.xx;
    u_xlat0.xy = u_xlat16_15.xy * vec2(u_xlat16_7) + u_xlat1.xy;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb16 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb16)));
    vs_TEXCOORD3.z = u_xlatb16 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _Opaqueness;
uniform 	float _UsingDitherAlpha;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb4;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb4.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb4.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb4.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD3.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    SV_Target0.xyz = vs_COLOR0.xyz * _Color.xyz;
    SV_Target0.w = vs_COLOR0.w * _Opaqueness;
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
Keywords { "CLIP_PLANE_WORLD" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump float _OutlineWidth;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump float _Scale;
uniform 	mediump float _VertexAlphaFactor;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
mediump float u_xlat16_7;
vec3 u_xlat8;
mediump vec2 u_xlat16_15;
float u_xlat16;
bool u_xlatb16;
float u_xlat24;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(abs(_ClipPlane.w)<0.00100000005);
#else
    u_xlatb0 = abs(_ClipPlane.w)<0.00100000005;
#endif
    u_xlat8.xyz = _ClipPlane.www * _ClipPlane.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? vec3(0.0, 0.0, 0.0) : u_xlat8.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToObject[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToObject[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * _ClipPlane.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _ClipPlane.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _ClipPlane.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat8.x = dot(in_POSITION0.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat8.x;
    u_xlat1.xyz = (-u_xlat0.xxx) * u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat2;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat3;
    u_xlat8.x = u_xlat3.z * in_POSITION0.y;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat4;
    u_xlat8.x = u_xlat4.z * in_POSITION0.x + u_xlat8.x;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat5;
    u_xlat8.x = u_xlat5.z * in_POSITION0.z + u_xlat8.x;
    u_xlat8.x = u_xlat2.z * in_POSITION0.w + u_xlat8.x;
    u_xlat8.x = (-u_xlat8.x) + (-_ProjectionParams.y);
    u_xlat8.x = u_xlat8.x + (-_FadeOffset);
    u_xlat8.x = u_xlat8.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat8.x = u_xlat8.x * _OutlineColor.w;
    u_xlat16 = in_COLOR0.w + -1.0;
    u_xlat16 = _VertexAlphaFactor * u_xlat16 + 1.0;
    u_xlat6.w = u_xlat16 * u_xlat8.x;
    u_xlat6.xyz = in_POSITION0.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = (int(u_xlati0) != 0) ? u_xlat6 : u_xlat1;
    u_xlat1 = u_xlat0.yyyy * u_xlat3;
    u_xlat3.xy = u_xlat3.xy * in_TANGENT0.yy;
    u_xlat3.xy = u_xlat4.xy * in_TANGENT0.xx + u_xlat3.xy;
    u_xlat1 = u_xlat4 * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = u_xlat5 * u_xlat0.zzzz + u_xlat1;
    u_xlat0.xy = u_xlat5.xy * in_TANGENT0.zz + u_xlat3.xy;
    vs_COLOR0.w = u_xlat0.w;
    u_xlat1 = u_xlat2 * in_POSITION0.wwww + u_xlat1;
    u_xlat1 = u_xlat1 / u_xlat1.wwww;
    u_xlat24 = (-u_xlat1.z) / hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat16_7 = u_xlat24 / _Scale;
    u_xlat24 = inversesqrt(u_xlat16_7);
    u_xlat24 = float(1.0) / u_xlat24;
    u_xlat16_7 = _OutlineWidth * _Scale;
    u_xlat16_7 = u_xlat24 * u_xlat16_7;
    u_xlat0.z = 0.00999999978;
    u_xlat16_15.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_15.x = inversesqrt(u_xlat16_15.x);
    u_xlat16_15.xy = u_xlat0.xy * u_xlat16_15.xx;
    u_xlat0.xy = u_xlat16_15.xy * vec2(u_xlat16_7) + u_xlat1.xy;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb16 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb16)));
    vs_TEXCOORD3.z = u_xlatb16 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _Opaqueness;
uniform 	float _UsingDitherAlpha;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb4;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb4.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb4.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb4.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD3.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    SV_Target0.xyz = vs_COLOR0.xyz * _Color.xyz;
    SV_Target0.w = vs_COLOR0.w * _Opaqueness;
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
Keywords { "CLIP_PLANE_WORLD" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump float _OutlineWidth;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump float _Scale;
uniform 	mediump float _VertexAlphaFactor;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
mediump float u_xlat16_7;
vec3 u_xlat8;
mediump vec2 u_xlat16_15;
float u_xlat16;
bool u_xlatb16;
float u_xlat24;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(abs(_ClipPlane.w)<0.00100000005);
#else
    u_xlatb0 = abs(_ClipPlane.w)<0.00100000005;
#endif
    u_xlat8.xyz = _ClipPlane.www * _ClipPlane.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? vec3(0.0, 0.0, 0.0) : u_xlat8.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToObject[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToObject[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * _ClipPlane.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _ClipPlane.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _ClipPlane.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat8.x = dot(in_POSITION0.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat8.x;
    u_xlat1.xyz = (-u_xlat0.xxx) * u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat2;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat3;
    u_xlat8.x = u_xlat3.z * in_POSITION0.y;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat4;
    u_xlat8.x = u_xlat4.z * in_POSITION0.x + u_xlat8.x;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat5;
    u_xlat8.x = u_xlat5.z * in_POSITION0.z + u_xlat8.x;
    u_xlat8.x = u_xlat2.z * in_POSITION0.w + u_xlat8.x;
    u_xlat8.x = (-u_xlat8.x) + (-_ProjectionParams.y);
    u_xlat8.x = u_xlat8.x + (-_FadeOffset);
    u_xlat8.x = u_xlat8.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat8.x = u_xlat8.x * _OutlineColor.w;
    u_xlat16 = in_COLOR0.w + -1.0;
    u_xlat16 = _VertexAlphaFactor * u_xlat16 + 1.0;
    u_xlat6.w = u_xlat16 * u_xlat8.x;
    u_xlat6.xyz = in_POSITION0.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = (int(u_xlati0) != 0) ? u_xlat6 : u_xlat1;
    u_xlat1 = u_xlat0.yyyy * u_xlat3;
    u_xlat3.xy = u_xlat3.xy * in_TANGENT0.yy;
    u_xlat3.xy = u_xlat4.xy * in_TANGENT0.xx + u_xlat3.xy;
    u_xlat1 = u_xlat4 * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = u_xlat5 * u_xlat0.zzzz + u_xlat1;
    u_xlat0.xy = u_xlat5.xy * in_TANGENT0.zz + u_xlat3.xy;
    vs_COLOR0.w = u_xlat0.w;
    u_xlat1 = u_xlat2 * in_POSITION0.wwww + u_xlat1;
    u_xlat1 = u_xlat1 / u_xlat1.wwww;
    u_xlat24 = (-u_xlat1.z) / hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat16_7 = u_xlat24 / _Scale;
    u_xlat24 = inversesqrt(u_xlat16_7);
    u_xlat24 = float(1.0) / u_xlat24;
    u_xlat16_7 = _OutlineWidth * _Scale;
    u_xlat16_7 = u_xlat24 * u_xlat16_7;
    u_xlat0.z = 0.00999999978;
    u_xlat16_15.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_15.x = inversesqrt(u_xlat16_15.x);
    u_xlat16_15.xy = u_xlat0.xy * u_xlat16_15.xx;
    u_xlat0.xy = u_xlat16_15.xy * vec2(u_xlat16_7) + u_xlat1.xy;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb16 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb16)));
    vs_TEXCOORD3.z = u_xlatb16 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _Opaqueness;
uniform 	float _UsingDitherAlpha;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb4;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb4.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb4.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb4.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD3.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    SV_Target0.xyz = vs_COLOR0.xyz * _Color.xyz;
    SV_Target0.w = vs_COLOR0.w * _Opaqueness;
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
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 _SPNoiseTex_ST;
uniform 	mediump float _OutlineWidth;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump float _Scale;
uniform 	mediump float _VertexAlphaFactor;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
mediump float u_xlat16_7;
vec3 u_xlat8;
mediump vec2 u_xlat16_15;
float u_xlat16;
bool u_xlatb16;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(abs(_ClipPlane.w)<0.00100000005);
#else
    u_xlatb0 = abs(_ClipPlane.w)<0.00100000005;
#endif
    u_xlat8.xyz = _ClipPlane.www * _ClipPlane.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? vec3(0.0, 0.0, 0.0) : u_xlat8.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToObject[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToObject[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * _ClipPlane.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _ClipPlane.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _ClipPlane.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat8.x = dot(in_POSITION0.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat8.x;
    u_xlat1.xyz = (-u_xlat0.xxx) * u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat2;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat3;
    u_xlat8.x = u_xlat3.z * in_POSITION0.y;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat4;
    u_xlat8.x = u_xlat4.z * in_POSITION0.x + u_xlat8.x;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat5;
    u_xlat8.x = u_xlat5.z * in_POSITION0.z + u_xlat8.x;
    u_xlat8.x = u_xlat2.z * in_POSITION0.w + u_xlat8.x;
    u_xlat8.x = (-u_xlat8.x) + (-_ProjectionParams.y);
    u_xlat8.x = u_xlat8.x + (-_FadeOffset);
    u_xlat8.x = u_xlat8.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat8.x = u_xlat8.x * _OutlineColor.w;
    u_xlat16 = in_COLOR0.w + -1.0;
    u_xlat16 = _VertexAlphaFactor * u_xlat16 + 1.0;
    u_xlat6.w = u_xlat16 * u_xlat8.x;
    u_xlat6.xyz = in_POSITION0.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = (int(u_xlati0) != 0) ? u_xlat6 : u_xlat1;
    u_xlat1 = u_xlat0.yyyy * u_xlat3;
    u_xlat3.xy = u_xlat3.xy * in_TANGENT0.yy;
    u_xlat3.xy = u_xlat4.xy * in_TANGENT0.xx + u_xlat3.xy;
    u_xlat1 = u_xlat4 * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = u_xlat5 * u_xlat0.zzzz + u_xlat1;
    u_xlat3.xy = u_xlat5.xy * in_TANGENT0.zz + u_xlat3.xy;
    u_xlat1 = u_xlat2 * in_POSITION0.wwww + u_xlat1;
    u_xlat1 = u_xlat1 / u_xlat1.wwww;
    u_xlat2.x = (-u_xlat1.z) / hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat16_7 = u_xlat2.x / _Scale;
    u_xlat2.x = inversesqrt(u_xlat16_7);
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat16_7 = _OutlineWidth * _Scale;
    u_xlat16_7 = u_xlat2.x * u_xlat16_7;
    u_xlat3.z = 0.00999999978;
    u_xlat16_15.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_15.x = inversesqrt(u_xlat16_15.x);
    u_xlat16_15.xy = u_xlat3.xy * u_xlat16_15.xx;
    u_xlat1.xy = u_xlat16_15.xy * vec2(u_xlat16_7) + u_xlat1.xy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_COLOR0.w = u_xlat0.w;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    u_xlat2 = u_xlat0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat0.x = u_xlat0.x * u_xlat2.x;
    u_xlat8.x = u_xlat2.w + u_xlat2.y;
    u_xlat2.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat2.y = u_xlat0.x * 0.25 + u_xlat8.x;
    vs_TEXCOORD0.xy = u_xlat2.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.zz + u_xlat0.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb16 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xy = mix(vec2(0.0, 0.0), u_xlat0.xy, vec2(bvec2(u_xlatb16)));
    vs_TEXCOORD3.w = u_xlatb16 ? u_xlat1.w : float(0.0);
    vs_TEXCOORD3.z = u_xlatb16 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	float _SPNoiseScaler;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPOutlineColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _Opaqueness;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _SPNoiseTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat2;
bvec2 u_xlatb4;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb4.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb4.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb4.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD3.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_SPNoiseTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 * _SPNoiseScaler;
    u_xlat0.x = u_xlat0.x * 1.99000001 + -1.0;
    u_xlat2 = _SPNoiseScaler * _SPTransition;
    u_xlat0.x = u_xlat2 * 1.70000005 + (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat16_0 = (int(u_xlati0) != 0) ? _SPOutlineColor : vs_COLOR0;
    SV_Target0.xyz = u_xlat16_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat16_0.w * _Opaqueness;
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
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 _SPNoiseTex_ST;
uniform 	mediump float _OutlineWidth;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump float _Scale;
uniform 	mediump float _VertexAlphaFactor;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
mediump float u_xlat16_7;
vec3 u_xlat8;
mediump vec2 u_xlat16_15;
float u_xlat16;
bool u_xlatb16;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(abs(_ClipPlane.w)<0.00100000005);
#else
    u_xlatb0 = abs(_ClipPlane.w)<0.00100000005;
#endif
    u_xlat8.xyz = _ClipPlane.www * _ClipPlane.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? vec3(0.0, 0.0, 0.0) : u_xlat8.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToObject[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToObject[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * _ClipPlane.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _ClipPlane.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _ClipPlane.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat8.x = dot(in_POSITION0.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat8.x;
    u_xlat1.xyz = (-u_xlat0.xxx) * u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat2;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat3;
    u_xlat8.x = u_xlat3.z * in_POSITION0.y;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat4;
    u_xlat8.x = u_xlat4.z * in_POSITION0.x + u_xlat8.x;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat5;
    u_xlat8.x = u_xlat5.z * in_POSITION0.z + u_xlat8.x;
    u_xlat8.x = u_xlat2.z * in_POSITION0.w + u_xlat8.x;
    u_xlat8.x = (-u_xlat8.x) + (-_ProjectionParams.y);
    u_xlat8.x = u_xlat8.x + (-_FadeOffset);
    u_xlat8.x = u_xlat8.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat8.x = u_xlat8.x * _OutlineColor.w;
    u_xlat16 = in_COLOR0.w + -1.0;
    u_xlat16 = _VertexAlphaFactor * u_xlat16 + 1.0;
    u_xlat6.w = u_xlat16 * u_xlat8.x;
    u_xlat6.xyz = in_POSITION0.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = (int(u_xlati0) != 0) ? u_xlat6 : u_xlat1;
    u_xlat1 = u_xlat0.yyyy * u_xlat3;
    u_xlat3.xy = u_xlat3.xy * in_TANGENT0.yy;
    u_xlat3.xy = u_xlat4.xy * in_TANGENT0.xx + u_xlat3.xy;
    u_xlat1 = u_xlat4 * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = u_xlat5 * u_xlat0.zzzz + u_xlat1;
    u_xlat3.xy = u_xlat5.xy * in_TANGENT0.zz + u_xlat3.xy;
    u_xlat1 = u_xlat2 * in_POSITION0.wwww + u_xlat1;
    u_xlat1 = u_xlat1 / u_xlat1.wwww;
    u_xlat2.x = (-u_xlat1.z) / hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat16_7 = u_xlat2.x / _Scale;
    u_xlat2.x = inversesqrt(u_xlat16_7);
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat16_7 = _OutlineWidth * _Scale;
    u_xlat16_7 = u_xlat2.x * u_xlat16_7;
    u_xlat3.z = 0.00999999978;
    u_xlat16_15.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_15.x = inversesqrt(u_xlat16_15.x);
    u_xlat16_15.xy = u_xlat3.xy * u_xlat16_15.xx;
    u_xlat1.xy = u_xlat16_15.xy * vec2(u_xlat16_7) + u_xlat1.xy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_COLOR0.w = u_xlat0.w;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    u_xlat2 = u_xlat0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat0.x = u_xlat0.x * u_xlat2.x;
    u_xlat8.x = u_xlat2.w + u_xlat2.y;
    u_xlat2.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat2.y = u_xlat0.x * 0.25 + u_xlat8.x;
    vs_TEXCOORD0.xy = u_xlat2.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.zz + u_xlat0.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb16 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xy = mix(vec2(0.0, 0.0), u_xlat0.xy, vec2(bvec2(u_xlatb16)));
    vs_TEXCOORD3.w = u_xlatb16 ? u_xlat1.w : float(0.0);
    vs_TEXCOORD3.z = u_xlatb16 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	float _SPNoiseScaler;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPOutlineColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _Opaqueness;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _SPNoiseTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat2;
bvec2 u_xlatb4;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb4.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb4.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb4.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD3.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_SPNoiseTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 * _SPNoiseScaler;
    u_xlat0.x = u_xlat0.x * 1.99000001 + -1.0;
    u_xlat2 = _SPNoiseScaler * _SPTransition;
    u_xlat0.x = u_xlat2 * 1.70000005 + (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat16_0 = (int(u_xlati0) != 0) ? _SPOutlineColor : vs_COLOR0;
    SV_Target0.xyz = u_xlat16_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat16_0.w * _Opaqueness;
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
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 _SPNoiseTex_ST;
uniform 	mediump float _OutlineWidth;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump float _Scale;
uniform 	mediump float _VertexAlphaFactor;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
mediump float u_xlat16_7;
vec3 u_xlat8;
mediump vec2 u_xlat16_15;
float u_xlat16;
bool u_xlatb16;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(abs(_ClipPlane.w)<0.00100000005);
#else
    u_xlatb0 = abs(_ClipPlane.w)<0.00100000005;
#endif
    u_xlat8.xyz = _ClipPlane.www * _ClipPlane.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? vec3(0.0, 0.0, 0.0) : u_xlat8.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToObject[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToObject[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * _ClipPlane.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _ClipPlane.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _ClipPlane.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat8.x = dot(in_POSITION0.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat8.x;
    u_xlat1.xyz = (-u_xlat0.xxx) * u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat2;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat3;
    u_xlat8.x = u_xlat3.z * in_POSITION0.y;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat4;
    u_xlat8.x = u_xlat4.z * in_POSITION0.x + u_xlat8.x;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat5;
    u_xlat8.x = u_xlat5.z * in_POSITION0.z + u_xlat8.x;
    u_xlat8.x = u_xlat2.z * in_POSITION0.w + u_xlat8.x;
    u_xlat8.x = (-u_xlat8.x) + (-_ProjectionParams.y);
    u_xlat8.x = u_xlat8.x + (-_FadeOffset);
    u_xlat8.x = u_xlat8.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat8.x = u_xlat8.x * _OutlineColor.w;
    u_xlat16 = in_COLOR0.w + -1.0;
    u_xlat16 = _VertexAlphaFactor * u_xlat16 + 1.0;
    u_xlat6.w = u_xlat16 * u_xlat8.x;
    u_xlat6.xyz = in_POSITION0.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = (int(u_xlati0) != 0) ? u_xlat6 : u_xlat1;
    u_xlat1 = u_xlat0.yyyy * u_xlat3;
    u_xlat3.xy = u_xlat3.xy * in_TANGENT0.yy;
    u_xlat3.xy = u_xlat4.xy * in_TANGENT0.xx + u_xlat3.xy;
    u_xlat1 = u_xlat4 * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = u_xlat5 * u_xlat0.zzzz + u_xlat1;
    u_xlat3.xy = u_xlat5.xy * in_TANGENT0.zz + u_xlat3.xy;
    u_xlat1 = u_xlat2 * in_POSITION0.wwww + u_xlat1;
    u_xlat1 = u_xlat1 / u_xlat1.wwww;
    u_xlat2.x = (-u_xlat1.z) / hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat16_7 = u_xlat2.x / _Scale;
    u_xlat2.x = inversesqrt(u_xlat16_7);
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat16_7 = _OutlineWidth * _Scale;
    u_xlat16_7 = u_xlat2.x * u_xlat16_7;
    u_xlat3.z = 0.00999999978;
    u_xlat16_15.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_15.x = inversesqrt(u_xlat16_15.x);
    u_xlat16_15.xy = u_xlat3.xy * u_xlat16_15.xx;
    u_xlat1.xy = u_xlat16_15.xy * vec2(u_xlat16_7) + u_xlat1.xy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_COLOR0.w = u_xlat0.w;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    u_xlat2 = u_xlat0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat0.x = u_xlat0.x * u_xlat2.x;
    u_xlat8.x = u_xlat2.w + u_xlat2.y;
    u_xlat2.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat2.y = u_xlat0.x * 0.25 + u_xlat8.x;
    vs_TEXCOORD0.xy = u_xlat2.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.zz + u_xlat0.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb16 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xy = mix(vec2(0.0, 0.0), u_xlat0.xy, vec2(bvec2(u_xlatb16)));
    vs_TEXCOORD3.w = u_xlatb16 ? u_xlat1.w : float(0.0);
    vs_TEXCOORD3.z = u_xlatb16 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	float _SPNoiseScaler;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPOutlineColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _Opaqueness;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _SPNoiseTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat2;
bvec2 u_xlatb4;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb4.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb4.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb4.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD3.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_SPNoiseTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 * _SPNoiseScaler;
    u_xlat0.x = u_xlat0.x * 1.99000001 + -1.0;
    u_xlat2 = _SPNoiseScaler * _SPTransition;
    u_xlat0.x = u_xlat2 * 1.70000005 + (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat16_0 = (int(u_xlati0) != 0) ? _SPOutlineColor : vs_COLOR0;
    SV_Target0.xyz = u_xlat16_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat16_0.w * _Opaqueness;
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
SubProgram "gles3 hw_tier00 " {
Keywords { "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
""
}
}
}
}
Fallback "Diffuse"
}