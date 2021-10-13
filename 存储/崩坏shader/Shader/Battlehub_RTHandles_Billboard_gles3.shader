//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Battlehub/RTHandles/Billboard" {
Properties {
_Color ("Color", Color) = (1,1,1,1)
_MainTex ("Texture Image", 2D) = "white" { }
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+20" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+20" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 43438
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0 = in_TEXCOORD0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * _Color;
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
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0 = in_TEXCOORD0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * _Color;
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
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0 = in_TEXCOORD0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * _Color;
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