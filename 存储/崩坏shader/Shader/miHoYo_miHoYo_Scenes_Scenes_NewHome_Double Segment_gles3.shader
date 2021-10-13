//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_NewHome/Double Segment" {
Properties {
_CreaseColor ("Crease Color", Color) = (0,0,0,1)
_CreaseWidth ("Crease Width", Range(0, 100)) = 0.2
_DistancePower ("Distance Power", Range(-100, 100)) = 0.2
_VertexOffset ("Vertex Offset", Float) = 0.01
_EmissionScaler ("Emission Scaler", Range(0, 50)) = 1
_ConstEmission ("Const Emission", Float) = 1
_SinEmission ("Sin Emission", Float) = 1
_BlinkSpeed ("Blink Speed", Float) = 1
}
SubShader {
 LOD 100
 Tags { "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "RenderType" = "Transparent" }
  Cull Off
  GpuProgramID 58304
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump float _CreaseWidth;
uniform 	mediump float _DistancePower;
uniform 	mediump float _VertexOffset;
in highp vec3 in_POSITION0;
in highp vec4 in_TANGENT0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec2 u_xlat16_4;
mediump vec2 u_xlat16_5;
mediump vec2 u_xlat16_10;
vec2 u_xlat12;
void main()
{
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat0;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat1;
    u_xlat2.xyz = in_POSITION0.xyz + (-in_TANGENT0.xyz);
    u_xlat3 = u_xlat1 * u_xlat2.yyyy;
    u_xlat1 = u_xlat1 * in_POSITION0.yyyy;
    u_xlat1 = u_xlat0 * in_POSITION0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat3;
    u_xlat0 = u_xlat3 * u_xlat2.zzzz + u_xlat0;
    u_xlat1 = u_xlat3 * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat2;
    u_xlat0 = u_xlat0 + u_xlat2;
    u_xlat1 = u_xlat1 + u_xlat2;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4glstate_matrix_projection[1].xyw;
    u_xlat2.xyz = hlslcc_mtx4x4glstate_matrix_projection[0].xyw * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4glstate_matrix_projection[2].xyw * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4glstate_matrix_projection[3].xyw * u_xlat0.www + u_xlat2.xyz;
    u_xlat16_4.x = u_xlat0.z / u_xlat0.w;
    u_xlat16_10.xy = u_xlat2.xy / u_xlat2.zz;
    u_xlat0.xy = u_xlat16_10.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat1.wwww + u_xlat2;
    u_xlat16_10.x = u_xlat1.z / u_xlat1.w;
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_10.x;
    u_xlat16_4.x = u_xlat16_4.x * 0.5;
    u_xlat12.x = (-u_xlat16_4.x) / hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat16_4.x = log2(u_xlat12.x);
    u_xlat16_4.x = u_xlat16_4.x * _DistancePower;
    u_xlat16_4.x = exp2(u_xlat16_4.x);
    u_xlat16_10.xy = u_xlat2.xy / u_xlat2.ww;
    u_xlat12.xy = u_xlat16_10.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_10.xy = u_xlat12.xy * _ScreenParams.xy + (-u_xlat0.xy);
    u_xlat0.xy = u_xlat16_10.xy * in_TANGENT0.ww;
    u_xlat1.xz = (-u_xlat0.yy);
    u_xlat1.y = u_xlat0.x;
    u_xlat1.w = u_xlat1.y;
    u_xlat16_10.x = dot(u_xlat1.xy, u_xlat1.zw);
    u_xlat16_10.x = inversesqrt(u_xlat16_10.x);
    u_xlat16_5.x = (-u_xlat0.y) * u_xlat16_10.x;
    u_xlat16_5.y = u_xlat0.x * u_xlat16_10.x;
    u_xlat16_10.xy = u_xlat16_5.xy * vec2(_CreaseWidth);
    u_xlat16_4.xy = u_xlat16_4.xx * u_xlat16_10.xy;
    u_xlat0.xy = u_xlat16_4.xy / _ScreenParams.xy;
    u_xlat0.xy = u_xlat2.ww * u_xlat0.xy;
    u_xlat16_0.xy = u_xlat0.xy * vec2(2.0, 2.0);
    u_xlat16_0.z = float(0.0);
    u_xlat16_0.w = float(0.0);
    u_xlat16_0 = u_xlat16_0 + u_xlat2;
    gl_Position.z = u_xlat16_0.z + _VertexOffset;
    gl_Position.xyw = u_xlat16_0.xyw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD0.xy = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _CreaseColor;
uniform 	mediump float _BlinkSpeed;
uniform 	mediump float _ConstEmission;
uniform 	mediump float _SinEmission;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
void main()
{
    u_xlat0 = _Time.y * _BlinkSpeed;
    u_xlat0 = sin(u_xlat0);
    u_xlat0 = _SinEmission * abs(u_xlat0) + _ConstEmission;
    SV_Target0.xyz = vec3(u_xlat0) * _CreaseColor.xyz;
    SV_Target0.w = _CreaseColor.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump float _CreaseWidth;
uniform 	mediump float _DistancePower;
uniform 	mediump float _VertexOffset;
in highp vec3 in_POSITION0;
in highp vec4 in_TANGENT0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec2 u_xlat16_4;
mediump vec2 u_xlat16_5;
mediump vec2 u_xlat16_10;
vec2 u_xlat12;
void main()
{
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat0;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat1;
    u_xlat2.xyz = in_POSITION0.xyz + (-in_TANGENT0.xyz);
    u_xlat3 = u_xlat1 * u_xlat2.yyyy;
    u_xlat1 = u_xlat1 * in_POSITION0.yyyy;
    u_xlat1 = u_xlat0 * in_POSITION0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat3;
    u_xlat0 = u_xlat3 * u_xlat2.zzzz + u_xlat0;
    u_xlat1 = u_xlat3 * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat2;
    u_xlat0 = u_xlat0 + u_xlat2;
    u_xlat1 = u_xlat1 + u_xlat2;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4glstate_matrix_projection[1].xyw;
    u_xlat2.xyz = hlslcc_mtx4x4glstate_matrix_projection[0].xyw * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4glstate_matrix_projection[2].xyw * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4glstate_matrix_projection[3].xyw * u_xlat0.www + u_xlat2.xyz;
    u_xlat16_4.x = u_xlat0.z / u_xlat0.w;
    u_xlat16_10.xy = u_xlat2.xy / u_xlat2.zz;
    u_xlat0.xy = u_xlat16_10.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat1.wwww + u_xlat2;
    u_xlat16_10.x = u_xlat1.z / u_xlat1.w;
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_10.x;
    u_xlat16_4.x = u_xlat16_4.x * 0.5;
    u_xlat12.x = (-u_xlat16_4.x) / hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat16_4.x = log2(u_xlat12.x);
    u_xlat16_4.x = u_xlat16_4.x * _DistancePower;
    u_xlat16_4.x = exp2(u_xlat16_4.x);
    u_xlat16_10.xy = u_xlat2.xy / u_xlat2.ww;
    u_xlat12.xy = u_xlat16_10.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_10.xy = u_xlat12.xy * _ScreenParams.xy + (-u_xlat0.xy);
    u_xlat0.xy = u_xlat16_10.xy * in_TANGENT0.ww;
    u_xlat1.xz = (-u_xlat0.yy);
    u_xlat1.y = u_xlat0.x;
    u_xlat1.w = u_xlat1.y;
    u_xlat16_10.x = dot(u_xlat1.xy, u_xlat1.zw);
    u_xlat16_10.x = inversesqrt(u_xlat16_10.x);
    u_xlat16_5.x = (-u_xlat0.y) * u_xlat16_10.x;
    u_xlat16_5.y = u_xlat0.x * u_xlat16_10.x;
    u_xlat16_10.xy = u_xlat16_5.xy * vec2(_CreaseWidth);
    u_xlat16_4.xy = u_xlat16_4.xx * u_xlat16_10.xy;
    u_xlat0.xy = u_xlat16_4.xy / _ScreenParams.xy;
    u_xlat0.xy = u_xlat2.ww * u_xlat0.xy;
    u_xlat16_0.xy = u_xlat0.xy * vec2(2.0, 2.0);
    u_xlat16_0.z = float(0.0);
    u_xlat16_0.w = float(0.0);
    u_xlat16_0 = u_xlat16_0 + u_xlat2;
    gl_Position.z = u_xlat16_0.z + _VertexOffset;
    gl_Position.xyw = u_xlat16_0.xyw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD0.xy = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _CreaseColor;
uniform 	mediump float _BlinkSpeed;
uniform 	mediump float _ConstEmission;
uniform 	mediump float _SinEmission;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
void main()
{
    u_xlat0 = _Time.y * _BlinkSpeed;
    u_xlat0 = sin(u_xlat0);
    u_xlat0 = _SinEmission * abs(u_xlat0) + _ConstEmission;
    SV_Target0.xyz = vec3(u_xlat0) * _CreaseColor.xyz;
    SV_Target0.w = _CreaseColor.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump float _CreaseWidth;
uniform 	mediump float _DistancePower;
uniform 	mediump float _VertexOffset;
in highp vec3 in_POSITION0;
in highp vec4 in_TANGENT0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec2 u_xlat16_4;
mediump vec2 u_xlat16_5;
mediump vec2 u_xlat16_10;
vec2 u_xlat12;
void main()
{
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat0;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat1;
    u_xlat2.xyz = in_POSITION0.xyz + (-in_TANGENT0.xyz);
    u_xlat3 = u_xlat1 * u_xlat2.yyyy;
    u_xlat1 = u_xlat1 * in_POSITION0.yyyy;
    u_xlat1 = u_xlat0 * in_POSITION0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat3;
    u_xlat0 = u_xlat3 * u_xlat2.zzzz + u_xlat0;
    u_xlat1 = u_xlat3 * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat2;
    u_xlat0 = u_xlat0 + u_xlat2;
    u_xlat1 = u_xlat1 + u_xlat2;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4glstate_matrix_projection[1].xyw;
    u_xlat2.xyz = hlslcc_mtx4x4glstate_matrix_projection[0].xyw * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4glstate_matrix_projection[2].xyw * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4glstate_matrix_projection[3].xyw * u_xlat0.www + u_xlat2.xyz;
    u_xlat16_4.x = u_xlat0.z / u_xlat0.w;
    u_xlat16_10.xy = u_xlat2.xy / u_xlat2.zz;
    u_xlat0.xy = u_xlat16_10.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat1.wwww + u_xlat2;
    u_xlat16_10.x = u_xlat1.z / u_xlat1.w;
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_10.x;
    u_xlat16_4.x = u_xlat16_4.x * 0.5;
    u_xlat12.x = (-u_xlat16_4.x) / hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat16_4.x = log2(u_xlat12.x);
    u_xlat16_4.x = u_xlat16_4.x * _DistancePower;
    u_xlat16_4.x = exp2(u_xlat16_4.x);
    u_xlat16_10.xy = u_xlat2.xy / u_xlat2.ww;
    u_xlat12.xy = u_xlat16_10.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_10.xy = u_xlat12.xy * _ScreenParams.xy + (-u_xlat0.xy);
    u_xlat0.xy = u_xlat16_10.xy * in_TANGENT0.ww;
    u_xlat1.xz = (-u_xlat0.yy);
    u_xlat1.y = u_xlat0.x;
    u_xlat1.w = u_xlat1.y;
    u_xlat16_10.x = dot(u_xlat1.xy, u_xlat1.zw);
    u_xlat16_10.x = inversesqrt(u_xlat16_10.x);
    u_xlat16_5.x = (-u_xlat0.y) * u_xlat16_10.x;
    u_xlat16_5.y = u_xlat0.x * u_xlat16_10.x;
    u_xlat16_10.xy = u_xlat16_5.xy * vec2(_CreaseWidth);
    u_xlat16_4.xy = u_xlat16_4.xx * u_xlat16_10.xy;
    u_xlat0.xy = u_xlat16_4.xy / _ScreenParams.xy;
    u_xlat0.xy = u_xlat2.ww * u_xlat0.xy;
    u_xlat16_0.xy = u_xlat0.xy * vec2(2.0, 2.0);
    u_xlat16_0.z = float(0.0);
    u_xlat16_0.w = float(0.0);
    u_xlat16_0 = u_xlat16_0 + u_xlat2;
    gl_Position.z = u_xlat16_0.z + _VertexOffset;
    gl_Position.xyw = u_xlat16_0.xyw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD0.xy = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _CreaseColor;
uniform 	mediump float _BlinkSpeed;
uniform 	mediump float _ConstEmission;
uniform 	mediump float _SinEmission;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
void main()
{
    u_xlat0 = _Time.y * _BlinkSpeed;
    u_xlat0 = sin(u_xlat0);
    u_xlat0 = _SinEmission * abs(u_xlat0) + _ConstEmission;
    SV_Target0.xyz = vec3(u_xlat0) * _CreaseColor.xyz;
    SV_Target0.w = _CreaseColor.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump float _CreaseWidth;
uniform 	mediump float _DistancePower;
uniform 	mediump float _VertexOffset;
in highp vec3 in_POSITION0;
in highp vec4 in_TANGENT0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec2 u_xlat16_4;
mediump vec2 u_xlat16_5;
mediump vec2 u_xlat16_10;
vec2 u_xlat12;
void main()
{
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat0;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat1;
    u_xlat2.xyz = in_POSITION0.xyz + (-in_TANGENT0.xyz);
    u_xlat3 = u_xlat1 * u_xlat2.yyyy;
    u_xlat1 = u_xlat1 * in_POSITION0.yyyy;
    u_xlat1 = u_xlat0 * in_POSITION0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat3;
    u_xlat0 = u_xlat3 * u_xlat2.zzzz + u_xlat0;
    u_xlat1 = u_xlat3 * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat2;
    u_xlat0 = u_xlat0 + u_xlat2;
    u_xlat1 = u_xlat1 + u_xlat2;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4glstate_matrix_projection[1].xyw;
    u_xlat2.xyz = hlslcc_mtx4x4glstate_matrix_projection[0].xyw * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4glstate_matrix_projection[2].xyw * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4glstate_matrix_projection[3].xyw * u_xlat0.www + u_xlat2.xyz;
    u_xlat16_4.x = u_xlat0.z / u_xlat0.w;
    u_xlat16_10.xy = u_xlat2.xy / u_xlat2.zz;
    u_xlat0.xy = u_xlat16_10.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat1.wwww + u_xlat2;
    u_xlat16_10.x = u_xlat1.z / u_xlat1.w;
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_10.x;
    u_xlat16_4.x = u_xlat16_4.x * 0.5;
    u_xlat12.x = (-u_xlat16_4.x) / hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat16_4.x = log2(u_xlat12.x);
    u_xlat16_4.x = u_xlat16_4.x * _DistancePower;
    u_xlat16_4.x = exp2(u_xlat16_4.x);
    u_xlat16_10.xy = u_xlat2.xy / u_xlat2.ww;
    u_xlat12.xy = u_xlat16_10.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_10.xy = u_xlat12.xy * _ScreenParams.xy + (-u_xlat0.xy);
    u_xlat0.xy = u_xlat16_10.xy * in_TANGENT0.ww;
    u_xlat1.xz = (-u_xlat0.yy);
    u_xlat1.y = u_xlat0.x;
    u_xlat1.w = u_xlat1.y;
    u_xlat16_10.x = dot(u_xlat1.xy, u_xlat1.zw);
    u_xlat16_10.x = inversesqrt(u_xlat16_10.x);
    u_xlat16_5.x = (-u_xlat0.y) * u_xlat16_10.x;
    u_xlat16_5.y = u_xlat0.x * u_xlat16_10.x;
    u_xlat16_10.xy = u_xlat16_5.xy * vec2(_CreaseWidth);
    u_xlat16_4.xy = u_xlat16_4.xx * u_xlat16_10.xy;
    u_xlat0.xy = u_xlat16_4.xy / _ScreenParams.xy;
    u_xlat0.xy = u_xlat2.ww * u_xlat0.xy;
    u_xlat16_0.xy = u_xlat0.xy * vec2(2.0, 2.0);
    u_xlat16_0.z = float(0.0);
    u_xlat16_0.w = float(0.0);
    u_xlat16_0 = u_xlat16_0 + u_xlat2;
    gl_Position.z = u_xlat16_0.z + _VertexOffset;
    gl_Position.xyw = u_xlat16_0.xyw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD0.xy = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _CreaseColor;
uniform 	mediump float _BlinkSpeed;
uniform 	mediump float _ConstEmission;
uniform 	mediump float _SinEmission;
uniform 	mediump float _LumiFactor;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_2;
void main()
{
    u_xlat0.x = _Time.y * _BlinkSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = _SinEmission * abs(u_xlat0.x) + _ConstEmission;
    u_xlat16_1.xyz = u_xlat0.xxx * _CreaseColor.xyz;
    u_xlat16_2 = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat0.xyz = (-_CreaseColor.xyz) * u_xlat0.xxx + vec3(u_xlat16_2);
    u_xlat0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat0.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _CreaseColor.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump float _CreaseWidth;
uniform 	mediump float _DistancePower;
uniform 	mediump float _VertexOffset;
in highp vec3 in_POSITION0;
in highp vec4 in_TANGENT0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec2 u_xlat16_4;
mediump vec2 u_xlat16_5;
mediump vec2 u_xlat16_10;
vec2 u_xlat12;
void main()
{
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat0;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat1;
    u_xlat2.xyz = in_POSITION0.xyz + (-in_TANGENT0.xyz);
    u_xlat3 = u_xlat1 * u_xlat2.yyyy;
    u_xlat1 = u_xlat1 * in_POSITION0.yyyy;
    u_xlat1 = u_xlat0 * in_POSITION0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat3;
    u_xlat0 = u_xlat3 * u_xlat2.zzzz + u_xlat0;
    u_xlat1 = u_xlat3 * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat2;
    u_xlat0 = u_xlat0 + u_xlat2;
    u_xlat1 = u_xlat1 + u_xlat2;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4glstate_matrix_projection[1].xyw;
    u_xlat2.xyz = hlslcc_mtx4x4glstate_matrix_projection[0].xyw * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4glstate_matrix_projection[2].xyw * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4glstate_matrix_projection[3].xyw * u_xlat0.www + u_xlat2.xyz;
    u_xlat16_4.x = u_xlat0.z / u_xlat0.w;
    u_xlat16_10.xy = u_xlat2.xy / u_xlat2.zz;
    u_xlat0.xy = u_xlat16_10.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat1.wwww + u_xlat2;
    u_xlat16_10.x = u_xlat1.z / u_xlat1.w;
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_10.x;
    u_xlat16_4.x = u_xlat16_4.x * 0.5;
    u_xlat12.x = (-u_xlat16_4.x) / hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat16_4.x = log2(u_xlat12.x);
    u_xlat16_4.x = u_xlat16_4.x * _DistancePower;
    u_xlat16_4.x = exp2(u_xlat16_4.x);
    u_xlat16_10.xy = u_xlat2.xy / u_xlat2.ww;
    u_xlat12.xy = u_xlat16_10.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_10.xy = u_xlat12.xy * _ScreenParams.xy + (-u_xlat0.xy);
    u_xlat0.xy = u_xlat16_10.xy * in_TANGENT0.ww;
    u_xlat1.xz = (-u_xlat0.yy);
    u_xlat1.y = u_xlat0.x;
    u_xlat1.w = u_xlat1.y;
    u_xlat16_10.x = dot(u_xlat1.xy, u_xlat1.zw);
    u_xlat16_10.x = inversesqrt(u_xlat16_10.x);
    u_xlat16_5.x = (-u_xlat0.y) * u_xlat16_10.x;
    u_xlat16_5.y = u_xlat0.x * u_xlat16_10.x;
    u_xlat16_10.xy = u_xlat16_5.xy * vec2(_CreaseWidth);
    u_xlat16_4.xy = u_xlat16_4.xx * u_xlat16_10.xy;
    u_xlat0.xy = u_xlat16_4.xy / _ScreenParams.xy;
    u_xlat0.xy = u_xlat2.ww * u_xlat0.xy;
    u_xlat16_0.xy = u_xlat0.xy * vec2(2.0, 2.0);
    u_xlat16_0.z = float(0.0);
    u_xlat16_0.w = float(0.0);
    u_xlat16_0 = u_xlat16_0 + u_xlat2;
    gl_Position.z = u_xlat16_0.z + _VertexOffset;
    gl_Position.xyw = u_xlat16_0.xyw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD0.xy = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _CreaseColor;
uniform 	mediump float _BlinkSpeed;
uniform 	mediump float _ConstEmission;
uniform 	mediump float _SinEmission;
uniform 	mediump float _LumiFactor;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_2;
void main()
{
    u_xlat0.x = _Time.y * _BlinkSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = _SinEmission * abs(u_xlat0.x) + _ConstEmission;
    u_xlat16_1.xyz = u_xlat0.xxx * _CreaseColor.xyz;
    u_xlat16_2 = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat0.xyz = (-_CreaseColor.xyz) * u_xlat0.xxx + vec3(u_xlat16_2);
    u_xlat0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat0.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _CreaseColor.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump float _CreaseWidth;
uniform 	mediump float _DistancePower;
uniform 	mediump float _VertexOffset;
in highp vec3 in_POSITION0;
in highp vec4 in_TANGENT0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec2 u_xlat16_4;
mediump vec2 u_xlat16_5;
mediump vec2 u_xlat16_10;
vec2 u_xlat12;
void main()
{
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat0;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat1;
    u_xlat2.xyz = in_POSITION0.xyz + (-in_TANGENT0.xyz);
    u_xlat3 = u_xlat1 * u_xlat2.yyyy;
    u_xlat1 = u_xlat1 * in_POSITION0.yyyy;
    u_xlat1 = u_xlat0 * in_POSITION0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat3;
    u_xlat0 = u_xlat3 * u_xlat2.zzzz + u_xlat0;
    u_xlat1 = u_xlat3 * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat2;
    u_xlat0 = u_xlat0 + u_xlat2;
    u_xlat1 = u_xlat1 + u_xlat2;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4glstate_matrix_projection[1].xyw;
    u_xlat2.xyz = hlslcc_mtx4x4glstate_matrix_projection[0].xyw * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4glstate_matrix_projection[2].xyw * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4glstate_matrix_projection[3].xyw * u_xlat0.www + u_xlat2.xyz;
    u_xlat16_4.x = u_xlat0.z / u_xlat0.w;
    u_xlat16_10.xy = u_xlat2.xy / u_xlat2.zz;
    u_xlat0.xy = u_xlat16_10.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat1.wwww + u_xlat2;
    u_xlat16_10.x = u_xlat1.z / u_xlat1.w;
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_10.x;
    u_xlat16_4.x = u_xlat16_4.x * 0.5;
    u_xlat12.x = (-u_xlat16_4.x) / hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat16_4.x = log2(u_xlat12.x);
    u_xlat16_4.x = u_xlat16_4.x * _DistancePower;
    u_xlat16_4.x = exp2(u_xlat16_4.x);
    u_xlat16_10.xy = u_xlat2.xy / u_xlat2.ww;
    u_xlat12.xy = u_xlat16_10.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_10.xy = u_xlat12.xy * _ScreenParams.xy + (-u_xlat0.xy);
    u_xlat0.xy = u_xlat16_10.xy * in_TANGENT0.ww;
    u_xlat1.xz = (-u_xlat0.yy);
    u_xlat1.y = u_xlat0.x;
    u_xlat1.w = u_xlat1.y;
    u_xlat16_10.x = dot(u_xlat1.xy, u_xlat1.zw);
    u_xlat16_10.x = inversesqrt(u_xlat16_10.x);
    u_xlat16_5.x = (-u_xlat0.y) * u_xlat16_10.x;
    u_xlat16_5.y = u_xlat0.x * u_xlat16_10.x;
    u_xlat16_10.xy = u_xlat16_5.xy * vec2(_CreaseWidth);
    u_xlat16_4.xy = u_xlat16_4.xx * u_xlat16_10.xy;
    u_xlat0.xy = u_xlat16_4.xy / _ScreenParams.xy;
    u_xlat0.xy = u_xlat2.ww * u_xlat0.xy;
    u_xlat16_0.xy = u_xlat0.xy * vec2(2.0, 2.0);
    u_xlat16_0.z = float(0.0);
    u_xlat16_0.w = float(0.0);
    u_xlat16_0 = u_xlat16_0 + u_xlat2;
    gl_Position.z = u_xlat16_0.z + _VertexOffset;
    gl_Position.xyw = u_xlat16_0.xyw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD0.xy = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _CreaseColor;
uniform 	mediump float _BlinkSpeed;
uniform 	mediump float _ConstEmission;
uniform 	mediump float _SinEmission;
uniform 	mediump float _LumiFactor;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_2;
void main()
{
    u_xlat0.x = _Time.y * _BlinkSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = _SinEmission * abs(u_xlat0.x) + _ConstEmission;
    u_xlat16_1.xyz = u_xlat0.xxx * _CreaseColor.xyz;
    u_xlat16_2 = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat0.xyz = (-_CreaseColor.xyz) * u_xlat0.xxx + vec3(u_xlat16_2);
    u_xlat0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat0.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _CreaseColor.w;
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