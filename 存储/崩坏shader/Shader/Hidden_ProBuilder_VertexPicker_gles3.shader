//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/ProBuilder/VertexPicker" {
Properties {
}
SubShader {
 LOD 200
 Tags { "DisableBatching" = "true" "IGNOREPROJECTOR" = "true" "ProBuilderPicker" = "VertexPass" "RenderType" = "Transparent" }
 Pass {
  Name "VERTICES"
  LOD 200
  Tags { "DisableBatching" = "true" "IGNOREPROJECTOR" = "true" "ProBuilderPicker" = "VertexPass" "RenderType" = "Transparent" }
  Cull Off
  Offset -1, -1
  GpuProgramID 47191
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
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
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.949999988, 0.949999988, 0.949999988);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4glstate_matrix_projection[3];
    u_xlat0.xy = u_xlat0.xy / u_xlat0.ww;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat1.xy = in_TEXCOORD1.xy * vec2(3.5, 3.5);
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy + u_xlat1.xy;
    u_xlat0.xy = u_xlat0.xy / _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat0.ww * u_xlat0.xy;
    gl_Position.xy = u_xlat0.xy + u_xlat0.xy;
    u_xlat0.x = (-hlslcc_mtx4x4glstate_matrix_projection[3].w) + 1.0;
    gl_Position.z = (-u_xlat0.x) * 9.99999975e-05 + u_xlat0.z;
    gl_Position.w = u_xlat0.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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

uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
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
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.949999988, 0.949999988, 0.949999988);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4glstate_matrix_projection[3];
    u_xlat0.xy = u_xlat0.xy / u_xlat0.ww;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat1.xy = in_TEXCOORD1.xy * vec2(3.5, 3.5);
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy + u_xlat1.xy;
    u_xlat0.xy = u_xlat0.xy / _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat0.ww * u_xlat0.xy;
    gl_Position.xy = u_xlat0.xy + u_xlat0.xy;
    u_xlat0.x = (-hlslcc_mtx4x4glstate_matrix_projection[3].w) + 1.0;
    gl_Position.z = (-u_xlat0.x) * 9.99999975e-05 + u_xlat0.z;
    gl_Position.w = u_xlat0.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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

uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
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
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.949999988, 0.949999988, 0.949999988);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4glstate_matrix_projection[3];
    u_xlat0.xy = u_xlat0.xy / u_xlat0.ww;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat1.xy = in_TEXCOORD1.xy * vec2(3.5, 3.5);
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy + u_xlat1.xy;
    u_xlat0.xy = u_xlat0.xy / _ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat0.ww * u_xlat0.xy;
    gl_Position.xy = u_xlat0.xy + u_xlat0.xy;
    u_xlat0.x = (-hlslcc_mtx4x4glstate_matrix_projection[3].w) + 1.0;
    gl_Position.z = (-u_xlat0.x) * 9.99999975e-05 + u_xlat0.z;
    gl_Position.w = u_xlat0.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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