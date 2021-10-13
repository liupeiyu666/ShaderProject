//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "LineRendering/DoubleSegment" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_CreaseWidth ("Crease Width", Range(0, 100)) = 0.2
_DistancePower ("Distance Power", Range(-3, 3)) = -0.2
_CreaseColor ("Crease Color", Color) = (0,0,0,1)
_VertexOffset ("Vertex Offset", Float) = 0.01
}
SubShader {
 LOD 100
 Tags { "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "RenderType" = "Transparent" }
  Cull Off
  GpuProgramID 55345
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _CreaseWidth;
uniform 	float _DistancePower;
uniform 	float _VertexOffset;
in highp vec3 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec2 u_xlat8;
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
    u_xlat0.xyz = hlslcc_mtx4x4glstate_matrix_projection[2].xyw * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4glstate_matrix_projection[3].xyw * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xy = u_xlat0.xy / u_xlat0.zz;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat1.wwww + u_xlat2;
    u_xlat8.xy = u_xlat1.xy / u_xlat1.ww;
    u_xlat8.xy = u_xlat8.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat8.xy * _ScreenParams.xy + (-u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * in_TANGENT0.ww;
    u_xlat0.zw = (-u_xlat0.yy);
    u_xlat8.x = dot(u_xlat0.xz, u_xlat0.xw);
    u_xlat0.xy = u_xlat0.yx * vec2(-1.0, 1.0);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat0.xy = u_xlat8.xx * u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(_CreaseWidth);
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_DistancePower, _DistancePower));
    u_xlat0.xy = u_xlat0.xy / _ScreenParams.xy;
    u_xlat0.xy = u_xlat1.ww * u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0);
    u_xlat0.z = float(0.0);
    u_xlat0.w = float(0.0);
    u_xlat0 = u_xlat0 + u_xlat1;
    gl_Position.z = u_xlat0.z + _VertexOffset;
    gl_Position.xyw = u_xlat0.xyw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _CreaseColor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0.xyz = u_xlat0.xyz * _CreaseColor.xyz;
    SV_Target0 = u_xlat0;
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
uniform 	float _CreaseWidth;
uniform 	float _DistancePower;
uniform 	float _VertexOffset;
in highp vec3 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec2 u_xlat8;
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
    u_xlat0.xyz = hlslcc_mtx4x4glstate_matrix_projection[2].xyw * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4glstate_matrix_projection[3].xyw * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xy = u_xlat0.xy / u_xlat0.zz;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat1.wwww + u_xlat2;
    u_xlat8.xy = u_xlat1.xy / u_xlat1.ww;
    u_xlat8.xy = u_xlat8.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat8.xy * _ScreenParams.xy + (-u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * in_TANGENT0.ww;
    u_xlat0.zw = (-u_xlat0.yy);
    u_xlat8.x = dot(u_xlat0.xz, u_xlat0.xw);
    u_xlat0.xy = u_xlat0.yx * vec2(-1.0, 1.0);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat0.xy = u_xlat8.xx * u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(_CreaseWidth);
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_DistancePower, _DistancePower));
    u_xlat0.xy = u_xlat0.xy / _ScreenParams.xy;
    u_xlat0.xy = u_xlat1.ww * u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0);
    u_xlat0.z = float(0.0);
    u_xlat0.w = float(0.0);
    u_xlat0 = u_xlat0 + u_xlat1;
    gl_Position.z = u_xlat0.z + _VertexOffset;
    gl_Position.xyw = u_xlat0.xyw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _CreaseColor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0.xyz = u_xlat0.xyz * _CreaseColor.xyz;
    SV_Target0 = u_xlat0;
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
uniform 	float _CreaseWidth;
uniform 	float _DistancePower;
uniform 	float _VertexOffset;
in highp vec3 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec2 u_xlat8;
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
    u_xlat0.xyz = hlslcc_mtx4x4glstate_matrix_projection[2].xyw * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4glstate_matrix_projection[3].xyw * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xy = u_xlat0.xy / u_xlat0.zz;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat1.wwww + u_xlat2;
    u_xlat8.xy = u_xlat1.xy / u_xlat1.ww;
    u_xlat8.xy = u_xlat8.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat8.xy * _ScreenParams.xy + (-u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * in_TANGENT0.ww;
    u_xlat0.zw = (-u_xlat0.yy);
    u_xlat8.x = dot(u_xlat0.xz, u_xlat0.xw);
    u_xlat0.xy = u_xlat0.yx * vec2(-1.0, 1.0);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat0.xy = u_xlat8.xx * u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(_CreaseWidth);
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_DistancePower, _DistancePower));
    u_xlat0.xy = u_xlat0.xy / _ScreenParams.xy;
    u_xlat0.xy = u_xlat1.ww * u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0);
    u_xlat0.z = float(0.0);
    u_xlat0.w = float(0.0);
    u_xlat0 = u_xlat0 + u_xlat1;
    gl_Position.z = u_xlat0.z + _VertexOffset;
    gl_Position.xyw = u_xlat0.xyw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _CreaseColor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0.xyz = u_xlat0.xyz * _CreaseColor.xyz;
    SV_Target0 = u_xlat0;
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