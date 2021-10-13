//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Battlehub/RTHandles/VertexColorBillboard" {
Properties {
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 14196
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat0.xyz;
    u_xlat6 = dot(hlslcc_mtx4x4unity_ObjectToWorld[0], hlslcc_mtx4x4unity_ObjectToWorld[0]);
    u_xlat6 = sqrt(u_xlat6);
    u_xlat1.x = u_xlat6 * in_POSITION0.x;
    u_xlat6 = dot(hlslcc_mtx4x4unity_ObjectToWorld[1], hlslcc_mtx4x4unity_ObjectToWorld[1]);
    u_xlat6 = sqrt(u_xlat6);
    u_xlat1.y = u_xlat6 * in_POSITION0.y;
    u_xlat1.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = u_xlat0 + hlslcc_mtx4x4glstate_matrix_projection[3];
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
in highp vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
void main()
{
    SV_Target0 = vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat0.xyz;
    u_xlat6 = dot(hlslcc_mtx4x4unity_ObjectToWorld[0], hlslcc_mtx4x4unity_ObjectToWorld[0]);
    u_xlat6 = sqrt(u_xlat6);
    u_xlat1.x = u_xlat6 * in_POSITION0.x;
    u_xlat6 = dot(hlslcc_mtx4x4unity_ObjectToWorld[1], hlslcc_mtx4x4unity_ObjectToWorld[1]);
    u_xlat6 = sqrt(u_xlat6);
    u_xlat1.y = u_xlat6 * in_POSITION0.y;
    u_xlat1.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = u_xlat0 + hlslcc_mtx4x4glstate_matrix_projection[3];
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
in highp vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
void main()
{
    SV_Target0 = vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat0.xyz;
    u_xlat6 = dot(hlslcc_mtx4x4unity_ObjectToWorld[0], hlslcc_mtx4x4unity_ObjectToWorld[0]);
    u_xlat6 = sqrt(u_xlat6);
    u_xlat1.x = u_xlat6 * in_POSITION0.x;
    u_xlat6 = dot(hlslcc_mtx4x4unity_ObjectToWorld[1], hlslcc_mtx4x4unity_ObjectToWorld[1]);
    u_xlat6 = sqrt(u_xlat6);
    u_xlat1.y = u_xlat6 * in_POSITION0.y;
    u_xlat1.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = u_xlat0 + hlslcc_mtx4x4glstate_matrix_projection[3];
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
in highp vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
void main()
{
    SV_Target0 = vs_COLOR0;
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