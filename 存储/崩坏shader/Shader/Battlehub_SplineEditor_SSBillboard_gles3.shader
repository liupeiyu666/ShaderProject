//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Battlehub/SplineEditor/SSBillboard" {
Properties {
_Color ("Color", Color) = (0,0,0,1)
_Scale ("Scale", Float) = 1
_ZWrite ("ZWrite", Float) = 0
_ZTest ("ZTest", Float) = 0
_Cull ("Cull", Float) = 0
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Geometry+1" "RenderType" = "Opaque" }
 Pass {
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Geometry+1" "RenderType" = "Opaque" }
  ZTest Off
  ZWrite Off
  Cull Off
  Offset -1, -1
  GpuProgramID 17263
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _Scale;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat3;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat6 = u_xlat0.z * _Scale;
    u_xlat6 = u_xlat6 * 7.0;
    u_xlat6 = u_xlat6 / _ScreenParams.y;
    u_xlat1.x = unity_OrthoParams.y * _Scale;
    u_xlat1.x = u_xlat1.x * 7.0;
    u_xlat1.x = u_xlat1.x / _ScreenParams.y;
    u_xlat3 = float(1.0) / hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat1.x = (-u_xlat6) * u_xlat3 + u_xlat1.x;
    u_xlat6 = u_xlat6 * u_xlat3;
    u_xlat6 = unity_OrthoParams.w * u_xlat1.x + u_xlat6;
    u_xlat1.xy = vec2(u_xlat6) * in_TEXCOORD0.xy;
    u_xlat1.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = u_xlat0 + hlslcc_mtx4x4glstate_matrix_projection[3];
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
layout(location = 0) out highp vec4 SV_Target0;
void main()
{
    SV_Target0 = _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _Scale;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat3;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat6 = u_xlat0.z * _Scale;
    u_xlat6 = u_xlat6 * 7.0;
    u_xlat6 = u_xlat6 / _ScreenParams.y;
    u_xlat1.x = unity_OrthoParams.y * _Scale;
    u_xlat1.x = u_xlat1.x * 7.0;
    u_xlat1.x = u_xlat1.x / _ScreenParams.y;
    u_xlat3 = float(1.0) / hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat1.x = (-u_xlat6) * u_xlat3 + u_xlat1.x;
    u_xlat6 = u_xlat6 * u_xlat3;
    u_xlat6 = unity_OrthoParams.w * u_xlat1.x + u_xlat6;
    u_xlat1.xy = vec2(u_xlat6) * in_TEXCOORD0.xy;
    u_xlat1.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = u_xlat0 + hlslcc_mtx4x4glstate_matrix_projection[3];
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
layout(location = 0) out highp vec4 SV_Target0;
void main()
{
    SV_Target0 = _Color;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ScreenParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _Scale;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat3;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat6 = u_xlat0.z * _Scale;
    u_xlat6 = u_xlat6 * 7.0;
    u_xlat6 = u_xlat6 / _ScreenParams.y;
    u_xlat1.x = unity_OrthoParams.y * _Scale;
    u_xlat1.x = u_xlat1.x * 7.0;
    u_xlat1.x = u_xlat1.x / _ScreenParams.y;
    u_xlat3 = float(1.0) / hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat1.x = (-u_xlat6) * u_xlat3 + u_xlat1.x;
    u_xlat6 = u_xlat6 * u_xlat3;
    u_xlat6 = unity_OrthoParams.w * u_xlat1.x + u_xlat6;
    u_xlat1.xy = vec2(u_xlat6) * in_TEXCOORD0.xy;
    u_xlat1.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = u_xlat0 + hlslcc_mtx4x4glstate_matrix_projection[3];
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
layout(location = 0) out highp vec4 SV_Target0;
void main()
{
    SV_Target0 = _Color;
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