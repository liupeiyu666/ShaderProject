//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Special/Hidden/DebugVertexDensity" {
Properties {
}
SubShader {
 Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  GpuProgramID 18178
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 310 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _IsGrassForDebug;
in highp vec4 in_POSITION0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xyz = in_POSITION0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlatb2 = 0.5<_IsGrassForDebug;
    gl_Position = (bool(u_xlatb2)) ? u_xlat1 : u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

precision highp int;
layout(location = 0) out highp vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.075000003, 0.0, 1.0);
    return;
}

#endif
#ifdef GEOMETRY
#version 310 es
#extension GL_ARB_geometry_shader : enable
#extension GL_OES_geometry_shader : enable
#extension GL_EXT_geometry_shader : enable

uniform 	vec4 _ScreenParams;
vec2 u_xlat0;
vec2 u_xlat1;
int u_xlati4;
vec2 u_xlat5;
bool u_xlatb6;
layout(triangles) in;
layout(triangle_strip) out;
layout(max_vertices = 18) out;
void main()
{
    u_xlat0.xy = _ScreenParams.zw + vec2(-1.0, -1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(3.0, 3.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<3 ; u_xlati_loop_1++)
    {
        u_xlat1.xy = (-u_xlat0.xy) * gl_in[u_xlati_loop_1].gl_Position.ww + gl_in[u_xlati_loop_1].gl_Position.xy;
        gl_Position.xy = u_xlat1.xy;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        EmitVertex();
        u_xlat5.xy = u_xlat0.xy * gl_in[u_xlati_loop_1].gl_Position.ww + gl_in[u_xlati_loop_1].gl_Position.xy;
        gl_Position.x = u_xlat1.x;
        gl_Position.y = u_xlat5.y;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        EmitVertex();
        gl_Position.xy = u_xlat5.xy;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        EmitVertex();
        gl_Position.xy = u_xlat1.xy;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        EmitVertex();
        gl_Position.xy = u_xlat5.xy;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        EmitVertex();
        gl_Position.x = u_xlat5.x;
        gl_Position.y = u_xlat1.y;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        EmitVertex();
        EndPrimitive();
    }
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 310 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _IsGrassForDebug;
in highp vec4 in_POSITION0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xyz = in_POSITION0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlatb2 = 0.5<_IsGrassForDebug;
    gl_Position = (bool(u_xlatb2)) ? u_xlat1 : u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

precision highp int;
layout(location = 0) out highp vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.075000003, 0.0, 1.0);
    return;
}

#endif
#ifdef GEOMETRY
#version 310 es
#extension GL_ARB_geometry_shader : enable
#extension GL_OES_geometry_shader : enable
#extension GL_EXT_geometry_shader : enable

uniform 	vec4 _ScreenParams;
vec2 u_xlat0;
vec2 u_xlat1;
int u_xlati4;
vec2 u_xlat5;
bool u_xlatb6;
layout(triangles) in;
layout(triangle_strip) out;
layout(max_vertices = 18) out;
void main()
{
    u_xlat0.xy = _ScreenParams.zw + vec2(-1.0, -1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(3.0, 3.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<3 ; u_xlati_loop_1++)
    {
        u_xlat1.xy = (-u_xlat0.xy) * gl_in[u_xlati_loop_1].gl_Position.ww + gl_in[u_xlati_loop_1].gl_Position.xy;
        gl_Position.xy = u_xlat1.xy;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        EmitVertex();
        u_xlat5.xy = u_xlat0.xy * gl_in[u_xlati_loop_1].gl_Position.ww + gl_in[u_xlati_loop_1].gl_Position.xy;
        gl_Position.x = u_xlat1.x;
        gl_Position.y = u_xlat5.y;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        EmitVertex();
        gl_Position.xy = u_xlat5.xy;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        EmitVertex();
        gl_Position.xy = u_xlat1.xy;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        EmitVertex();
        gl_Position.xy = u_xlat5.xy;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        EmitVertex();
        gl_Position.x = u_xlat5.x;
        gl_Position.y = u_xlat1.y;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        EmitVertex();
        EndPrimitive();
    }
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 310 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _IsGrassForDebug;
in highp vec4 in_POSITION0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xyz = in_POSITION0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlatb2 = 0.5<_IsGrassForDebug;
    gl_Position = (bool(u_xlatb2)) ? u_xlat1 : u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

precision highp int;
layout(location = 0) out highp vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.075000003, 0.0, 1.0);
    return;
}

#endif
#ifdef GEOMETRY
#version 310 es
#extension GL_ARB_geometry_shader : enable
#extension GL_OES_geometry_shader : enable
#extension GL_EXT_geometry_shader : enable

uniform 	vec4 _ScreenParams;
vec2 u_xlat0;
vec2 u_xlat1;
int u_xlati4;
vec2 u_xlat5;
bool u_xlatb6;
layout(triangles) in;
layout(triangle_strip) out;
layout(max_vertices = 18) out;
void main()
{
    u_xlat0.xy = _ScreenParams.zw + vec2(-1.0, -1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(3.0, 3.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<3 ; u_xlati_loop_1++)
    {
        u_xlat1.xy = (-u_xlat0.xy) * gl_in[u_xlati_loop_1].gl_Position.ww + gl_in[u_xlati_loop_1].gl_Position.xy;
        gl_Position.xy = u_xlat1.xy;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        EmitVertex();
        u_xlat5.xy = u_xlat0.xy * gl_in[u_xlati_loop_1].gl_Position.ww + gl_in[u_xlati_loop_1].gl_Position.xy;
        gl_Position.x = u_xlat1.x;
        gl_Position.y = u_xlat5.y;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        EmitVertex();
        gl_Position.xy = u_xlat5.xy;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        EmitVertex();
        gl_Position.xy = u_xlat1.xy;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        EmitVertex();
        gl_Position.xy = u_xlat5.xy;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        EmitVertex();
        gl_Position.x = u_xlat5.x;
        gl_Position.y = u_xlat1.y;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        EmitVertex();
        EndPrimitive();
    }
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" }
"#ifdef VERTEX
#version 310 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _IsGrassForDebug;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec3 u_xlat2;
int u_xlati2;
bool u_xlatb2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlatb2 = 0.5<_IsGrassForDebug;
    if(u_xlatb2){
        u_xlati2 = u_xlati0 << 3;
        u_xlat2.xyz = in_POSITION0.xyz + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
        u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
        gl_Position = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
    } else {
        u_xlati0 = u_xlati0 << 3;
        u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
        u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
        u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
        u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
        u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
        gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    //ENDIF
    }
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

precision highp int;
layout(location = 0) out highp vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.075000003, 0.0, 1.0);
    return;
}

#endif
#ifdef GEOMETRY
#version 310 es
#extension GL_ARB_geometry_shader : enable
#extension GL_OES_geometry_shader : enable
#extension GL_EXT_geometry_shader : enable

uniform 	vec4 _ScreenParams;
flat in highp uint vs_SV_InstanceID0 [3];
vec2 u_xlat0;
vec2 u_xlat1;
int u_xlati4;
vec2 u_xlat5;
bool u_xlatb6;
layout(triangles) in;
layout(triangle_strip) out;
out highp uint gs_SV_InstanceID0;
layout(max_vertices = 18) out;
void main()
{
    u_xlat0.xy = _ScreenParams.zw + vec2(-1.0, -1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(3.0, 3.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<3 ; u_xlati_loop_1++)
    {
        u_xlat1.xy = (-u_xlat0.xy) * gl_in[u_xlati_loop_1].gl_Position.ww + gl_in[u_xlati_loop_1].gl_Position.xy;
        gl_Position.xy = u_xlat1.xy;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        gs_SV_InstanceID0 = 0u;
        EmitVertex();
        u_xlat5.xy = u_xlat0.xy * gl_in[u_xlati_loop_1].gl_Position.ww + gl_in[u_xlati_loop_1].gl_Position.xy;
        gl_Position.x = u_xlat1.x;
        gl_Position.y = u_xlat5.y;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        gs_SV_InstanceID0 = 0u;
        EmitVertex();
        gl_Position.xy = u_xlat5.xy;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        gs_SV_InstanceID0 = 0u;
        EmitVertex();
        gl_Position.xy = u_xlat1.xy;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        gs_SV_InstanceID0 = 0u;
        EmitVertex();
        gl_Position.xy = u_xlat5.xy;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        gs_SV_InstanceID0 = 0u;
        EmitVertex();
        gl_Position.x = u_xlat5.x;
        gl_Position.y = u_xlat1.y;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        gs_SV_InstanceID0 = 0u;
        EmitVertex();
        EndPrimitive();
    }
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" }
"#ifdef VERTEX
#version 310 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _IsGrassForDebug;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec3 u_xlat2;
int u_xlati2;
bool u_xlatb2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlatb2 = 0.5<_IsGrassForDebug;
    if(u_xlatb2){
        u_xlati2 = u_xlati0 << 3;
        u_xlat2.xyz = in_POSITION0.xyz + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
        u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
        gl_Position = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
    } else {
        u_xlati0 = u_xlati0 << 3;
        u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
        u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
        u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
        u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
        u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
        gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    //ENDIF
    }
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

precision highp int;
layout(location = 0) out highp vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.075000003, 0.0, 1.0);
    return;
}

#endif
#ifdef GEOMETRY
#version 310 es
#extension GL_ARB_geometry_shader : enable
#extension GL_OES_geometry_shader : enable
#extension GL_EXT_geometry_shader : enable

uniform 	vec4 _ScreenParams;
flat in highp uint vs_SV_InstanceID0 [3];
vec2 u_xlat0;
vec2 u_xlat1;
int u_xlati4;
vec2 u_xlat5;
bool u_xlatb6;
layout(triangles) in;
layout(triangle_strip) out;
out highp uint gs_SV_InstanceID0;
layout(max_vertices = 18) out;
void main()
{
    u_xlat0.xy = _ScreenParams.zw + vec2(-1.0, -1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(3.0, 3.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<3 ; u_xlati_loop_1++)
    {
        u_xlat1.xy = (-u_xlat0.xy) * gl_in[u_xlati_loop_1].gl_Position.ww + gl_in[u_xlati_loop_1].gl_Position.xy;
        gl_Position.xy = u_xlat1.xy;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        gs_SV_InstanceID0 = 0u;
        EmitVertex();
        u_xlat5.xy = u_xlat0.xy * gl_in[u_xlati_loop_1].gl_Position.ww + gl_in[u_xlati_loop_1].gl_Position.xy;
        gl_Position.x = u_xlat1.x;
        gl_Position.y = u_xlat5.y;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        gs_SV_InstanceID0 = 0u;
        EmitVertex();
        gl_Position.xy = u_xlat5.xy;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        gs_SV_InstanceID0 = 0u;
        EmitVertex();
        gl_Position.xy = u_xlat1.xy;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        gs_SV_InstanceID0 = 0u;
        EmitVertex();
        gl_Position.xy = u_xlat5.xy;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        gs_SV_InstanceID0 = 0u;
        EmitVertex();
        gl_Position.x = u_xlat5.x;
        gl_Position.y = u_xlat1.y;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        gs_SV_InstanceID0 = 0u;
        EmitVertex();
        EndPrimitive();
    }
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" }
"#ifdef VERTEX
#version 310 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _IsGrassForDebug;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec3 u_xlat2;
int u_xlati2;
bool u_xlatb2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlatb2 = 0.5<_IsGrassForDebug;
    if(u_xlatb2){
        u_xlati2 = u_xlati0 << 3;
        u_xlat2.xyz = in_POSITION0.xyz + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
        u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
        gl_Position = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
    } else {
        u_xlati0 = u_xlati0 << 3;
        u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
        u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
        u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
        u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
        u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
        gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    //ENDIF
    }
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

precision highp int;
layout(location = 0) out highp vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.075000003, 0.0, 1.0);
    return;
}

#endif
#ifdef GEOMETRY
#version 310 es
#extension GL_ARB_geometry_shader : enable
#extension GL_OES_geometry_shader : enable
#extension GL_EXT_geometry_shader : enable

uniform 	vec4 _ScreenParams;
flat in highp uint vs_SV_InstanceID0 [3];
vec2 u_xlat0;
vec2 u_xlat1;
int u_xlati4;
vec2 u_xlat5;
bool u_xlatb6;
layout(triangles) in;
layout(triangle_strip) out;
out highp uint gs_SV_InstanceID0;
layout(max_vertices = 18) out;
void main()
{
    u_xlat0.xy = _ScreenParams.zw + vec2(-1.0, -1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(3.0, 3.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<3 ; u_xlati_loop_1++)
    {
        u_xlat1.xy = (-u_xlat0.xy) * gl_in[u_xlati_loop_1].gl_Position.ww + gl_in[u_xlati_loop_1].gl_Position.xy;
        gl_Position.xy = u_xlat1.xy;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        gs_SV_InstanceID0 = 0u;
        EmitVertex();
        u_xlat5.xy = u_xlat0.xy * gl_in[u_xlati_loop_1].gl_Position.ww + gl_in[u_xlati_loop_1].gl_Position.xy;
        gl_Position.x = u_xlat1.x;
        gl_Position.y = u_xlat5.y;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        gs_SV_InstanceID0 = 0u;
        EmitVertex();
        gl_Position.xy = u_xlat5.xy;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        gs_SV_InstanceID0 = 0u;
        EmitVertex();
        gl_Position.xy = u_xlat1.xy;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        gs_SV_InstanceID0 = 0u;
        EmitVertex();
        gl_Position.xy = u_xlat5.xy;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        gs_SV_InstanceID0 = 0u;
        EmitVertex();
        gl_Position.x = u_xlat5.x;
        gl_Position.y = u_xlat1.y;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        gs_SV_InstanceID0 = 0u;
        EmitVertex();
        EndPrimitive();
    }
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USE_TERRAIN_VERTEXTEXTURE" }
"#ifdef VERTEX
#version 310 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _IsGrassForDebug;
in highp vec4 in_POSITION0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xyz = in_POSITION0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlatb2 = 0.5<_IsGrassForDebug;
    gl_Position = (bool(u_xlatb2)) ? u_xlat1 : u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

precision highp int;
layout(location = 0) out highp vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.075000003, 0.0, 1.0);
    return;
}

#endif
#ifdef GEOMETRY
#version 310 es
#extension GL_ARB_geometry_shader : enable
#extension GL_OES_geometry_shader : enable
#extension GL_EXT_geometry_shader : enable

uniform 	vec4 _ScreenParams;
vec2 u_xlat0;
vec2 u_xlat1;
int u_xlati4;
vec2 u_xlat5;
bool u_xlatb6;
layout(triangles) in;
layout(triangle_strip) out;
layout(max_vertices = 18) out;
void main()
{
    u_xlat0.xy = _ScreenParams.zw + vec2(-1.0, -1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(3.0, 3.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<3 ; u_xlati_loop_1++)
    {
        u_xlat1.xy = (-u_xlat0.xy) * gl_in[u_xlati_loop_1].gl_Position.ww + gl_in[u_xlati_loop_1].gl_Position.xy;
        gl_Position.xy = u_xlat1.xy;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        EmitVertex();
        u_xlat5.xy = u_xlat0.xy * gl_in[u_xlati_loop_1].gl_Position.ww + gl_in[u_xlati_loop_1].gl_Position.xy;
        gl_Position.x = u_xlat1.x;
        gl_Position.y = u_xlat5.y;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        EmitVertex();
        gl_Position.xy = u_xlat5.xy;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        EmitVertex();
        gl_Position.xy = u_xlat1.xy;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        EmitVertex();
        gl_Position.xy = u_xlat5.xy;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        EmitVertex();
        gl_Position.x = u_xlat5.x;
        gl_Position.y = u_xlat1.y;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        EmitVertex();
        EndPrimitive();
    }
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USE_TERRAIN_VERTEXTEXTURE" }
"#ifdef VERTEX
#version 310 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _IsGrassForDebug;
in highp vec4 in_POSITION0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xyz = in_POSITION0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlatb2 = 0.5<_IsGrassForDebug;
    gl_Position = (bool(u_xlatb2)) ? u_xlat1 : u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

precision highp int;
layout(location = 0) out highp vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.075000003, 0.0, 1.0);
    return;
}

#endif
#ifdef GEOMETRY
#version 310 es
#extension GL_ARB_geometry_shader : enable
#extension GL_OES_geometry_shader : enable
#extension GL_EXT_geometry_shader : enable

uniform 	vec4 _ScreenParams;
vec2 u_xlat0;
vec2 u_xlat1;
int u_xlati4;
vec2 u_xlat5;
bool u_xlatb6;
layout(triangles) in;
layout(triangle_strip) out;
layout(max_vertices = 18) out;
void main()
{
    u_xlat0.xy = _ScreenParams.zw + vec2(-1.0, -1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(3.0, 3.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<3 ; u_xlati_loop_1++)
    {
        u_xlat1.xy = (-u_xlat0.xy) * gl_in[u_xlati_loop_1].gl_Position.ww + gl_in[u_xlati_loop_1].gl_Position.xy;
        gl_Position.xy = u_xlat1.xy;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        EmitVertex();
        u_xlat5.xy = u_xlat0.xy * gl_in[u_xlati_loop_1].gl_Position.ww + gl_in[u_xlati_loop_1].gl_Position.xy;
        gl_Position.x = u_xlat1.x;
        gl_Position.y = u_xlat5.y;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        EmitVertex();
        gl_Position.xy = u_xlat5.xy;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        EmitVertex();
        gl_Position.xy = u_xlat1.xy;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        EmitVertex();
        gl_Position.xy = u_xlat5.xy;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        EmitVertex();
        gl_Position.x = u_xlat5.x;
        gl_Position.y = u_xlat1.y;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        EmitVertex();
        EndPrimitive();
    }
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USE_TERRAIN_VERTEXTEXTURE" }
"#ifdef VERTEX
#version 310 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _IsGrassForDebug;
in highp vec4 in_POSITION0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xyz = in_POSITION0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlatb2 = 0.5<_IsGrassForDebug;
    gl_Position = (bool(u_xlatb2)) ? u_xlat1 : u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

precision highp int;
layout(location = 0) out highp vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.075000003, 0.0, 1.0);
    return;
}

#endif
#ifdef GEOMETRY
#version 310 es
#extension GL_ARB_geometry_shader : enable
#extension GL_OES_geometry_shader : enable
#extension GL_EXT_geometry_shader : enable

uniform 	vec4 _ScreenParams;
vec2 u_xlat0;
vec2 u_xlat1;
int u_xlati4;
vec2 u_xlat5;
bool u_xlatb6;
layout(triangles) in;
layout(triangle_strip) out;
layout(max_vertices = 18) out;
void main()
{
    u_xlat0.xy = _ScreenParams.zw + vec2(-1.0, -1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(3.0, 3.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<3 ; u_xlati_loop_1++)
    {
        u_xlat1.xy = (-u_xlat0.xy) * gl_in[u_xlati_loop_1].gl_Position.ww + gl_in[u_xlati_loop_1].gl_Position.xy;
        gl_Position.xy = u_xlat1.xy;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        EmitVertex();
        u_xlat5.xy = u_xlat0.xy * gl_in[u_xlati_loop_1].gl_Position.ww + gl_in[u_xlati_loop_1].gl_Position.xy;
        gl_Position.x = u_xlat1.x;
        gl_Position.y = u_xlat5.y;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        EmitVertex();
        gl_Position.xy = u_xlat5.xy;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        EmitVertex();
        gl_Position.xy = u_xlat1.xy;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        EmitVertex();
        gl_Position.xy = u_xlat5.xy;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        EmitVertex();
        gl_Position.x = u_xlat5.x;
        gl_Position.y = u_xlat1.y;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        EmitVertex();
        EndPrimitive();
    }
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" "_USE_TERRAIN_VERTEXTEXTURE" }
"#ifdef VERTEX
#version 310 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _IsGrassForDebug;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec3 u_xlat2;
int u_xlati2;
bool u_xlatb2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlatb2 = 0.5<_IsGrassForDebug;
    if(u_xlatb2){
        u_xlati2 = u_xlati0 << 3;
        u_xlat2.xyz = in_POSITION0.xyz + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
        u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
        gl_Position = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
    } else {
        u_xlati0 = u_xlati0 << 3;
        u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
        u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
        u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
        u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
        u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
        gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    //ENDIF
    }
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

precision highp int;
layout(location = 0) out highp vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.075000003, 0.0, 1.0);
    return;
}

#endif
#ifdef GEOMETRY
#version 310 es
#extension GL_ARB_geometry_shader : enable
#extension GL_OES_geometry_shader : enable
#extension GL_EXT_geometry_shader : enable

uniform 	vec4 _ScreenParams;
flat in highp uint vs_SV_InstanceID0 [3];
vec2 u_xlat0;
vec2 u_xlat1;
int u_xlati4;
vec2 u_xlat5;
bool u_xlatb6;
layout(triangles) in;
layout(triangle_strip) out;
out highp uint gs_SV_InstanceID0;
layout(max_vertices = 18) out;
void main()
{
    u_xlat0.xy = _ScreenParams.zw + vec2(-1.0, -1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(3.0, 3.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<3 ; u_xlati_loop_1++)
    {
        u_xlat1.xy = (-u_xlat0.xy) * gl_in[u_xlati_loop_1].gl_Position.ww + gl_in[u_xlati_loop_1].gl_Position.xy;
        gl_Position.xy = u_xlat1.xy;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        gs_SV_InstanceID0 = 0u;
        EmitVertex();
        u_xlat5.xy = u_xlat0.xy * gl_in[u_xlati_loop_1].gl_Position.ww + gl_in[u_xlati_loop_1].gl_Position.xy;
        gl_Position.x = u_xlat1.x;
        gl_Position.y = u_xlat5.y;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        gs_SV_InstanceID0 = 0u;
        EmitVertex();
        gl_Position.xy = u_xlat5.xy;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        gs_SV_InstanceID0 = 0u;
        EmitVertex();
        gl_Position.xy = u_xlat1.xy;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        gs_SV_InstanceID0 = 0u;
        EmitVertex();
        gl_Position.xy = u_xlat5.xy;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        gs_SV_InstanceID0 = 0u;
        EmitVertex();
        gl_Position.x = u_xlat5.x;
        gl_Position.y = u_xlat1.y;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        gs_SV_InstanceID0 = 0u;
        EmitVertex();
        EndPrimitive();
    }
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" "_USE_TERRAIN_VERTEXTEXTURE" }
"#ifdef VERTEX
#version 310 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _IsGrassForDebug;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec3 u_xlat2;
int u_xlati2;
bool u_xlatb2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlatb2 = 0.5<_IsGrassForDebug;
    if(u_xlatb2){
        u_xlati2 = u_xlati0 << 3;
        u_xlat2.xyz = in_POSITION0.xyz + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
        u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
        gl_Position = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
    } else {
        u_xlati0 = u_xlati0 << 3;
        u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
        u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
        u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
        u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
        u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
        gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    //ENDIF
    }
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

precision highp int;
layout(location = 0) out highp vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.075000003, 0.0, 1.0);
    return;
}

#endif
#ifdef GEOMETRY
#version 310 es
#extension GL_ARB_geometry_shader : enable
#extension GL_OES_geometry_shader : enable
#extension GL_EXT_geometry_shader : enable

uniform 	vec4 _ScreenParams;
flat in highp uint vs_SV_InstanceID0 [3];
vec2 u_xlat0;
vec2 u_xlat1;
int u_xlati4;
vec2 u_xlat5;
bool u_xlatb6;
layout(triangles) in;
layout(triangle_strip) out;
out highp uint gs_SV_InstanceID0;
layout(max_vertices = 18) out;
void main()
{
    u_xlat0.xy = _ScreenParams.zw + vec2(-1.0, -1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(3.0, 3.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<3 ; u_xlati_loop_1++)
    {
        u_xlat1.xy = (-u_xlat0.xy) * gl_in[u_xlati_loop_1].gl_Position.ww + gl_in[u_xlati_loop_1].gl_Position.xy;
        gl_Position.xy = u_xlat1.xy;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        gs_SV_InstanceID0 = 0u;
        EmitVertex();
        u_xlat5.xy = u_xlat0.xy * gl_in[u_xlati_loop_1].gl_Position.ww + gl_in[u_xlati_loop_1].gl_Position.xy;
        gl_Position.x = u_xlat1.x;
        gl_Position.y = u_xlat5.y;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        gs_SV_InstanceID0 = 0u;
        EmitVertex();
        gl_Position.xy = u_xlat5.xy;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        gs_SV_InstanceID0 = 0u;
        EmitVertex();
        gl_Position.xy = u_xlat1.xy;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        gs_SV_InstanceID0 = 0u;
        EmitVertex();
        gl_Position.xy = u_xlat5.xy;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        gs_SV_InstanceID0 = 0u;
        EmitVertex();
        gl_Position.x = u_xlat5.x;
        gl_Position.y = u_xlat1.y;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        gs_SV_InstanceID0 = 0u;
        EmitVertex();
        EndPrimitive();
    }
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" "_USE_TERRAIN_VERTEXTEXTURE" }
"#ifdef VERTEX
#version 310 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _IsGrassForDebug;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec3 u_xlat2;
int u_xlati2;
bool u_xlatb2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlatb2 = 0.5<_IsGrassForDebug;
    if(u_xlatb2){
        u_xlati2 = u_xlati0 << 3;
        u_xlat2.xyz = in_POSITION0.xyz + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
        u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
        gl_Position = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
    } else {
        u_xlati0 = u_xlati0 << 3;
        u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
        u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
        u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
        u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
        u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
        gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    //ENDIF
    }
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

precision highp int;
layout(location = 0) out highp vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.075000003, 0.0, 1.0);
    return;
}

#endif
#ifdef GEOMETRY
#version 310 es
#extension GL_ARB_geometry_shader : enable
#extension GL_OES_geometry_shader : enable
#extension GL_EXT_geometry_shader : enable

uniform 	vec4 _ScreenParams;
flat in highp uint vs_SV_InstanceID0 [3];
vec2 u_xlat0;
vec2 u_xlat1;
int u_xlati4;
vec2 u_xlat5;
bool u_xlatb6;
layout(triangles) in;
layout(triangle_strip) out;
out highp uint gs_SV_InstanceID0;
layout(max_vertices = 18) out;
void main()
{
    u_xlat0.xy = _ScreenParams.zw + vec2(-1.0, -1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(3.0, 3.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<3 ; u_xlati_loop_1++)
    {
        u_xlat1.xy = (-u_xlat0.xy) * gl_in[u_xlati_loop_1].gl_Position.ww + gl_in[u_xlati_loop_1].gl_Position.xy;
        gl_Position.xy = u_xlat1.xy;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        gs_SV_InstanceID0 = 0u;
        EmitVertex();
        u_xlat5.xy = u_xlat0.xy * gl_in[u_xlati_loop_1].gl_Position.ww + gl_in[u_xlati_loop_1].gl_Position.xy;
        gl_Position.x = u_xlat1.x;
        gl_Position.y = u_xlat5.y;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        gs_SV_InstanceID0 = 0u;
        EmitVertex();
        gl_Position.xy = u_xlat5.xy;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        gs_SV_InstanceID0 = 0u;
        EmitVertex();
        gl_Position.xy = u_xlat1.xy;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        gs_SV_InstanceID0 = 0u;
        EmitVertex();
        gl_Position.xy = u_xlat5.xy;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        gs_SV_InstanceID0 = 0u;
        EmitVertex();
        gl_Position.x = u_xlat5.x;
        gl_Position.y = u_xlat1.y;
        gl_Position.zw = gl_in[u_xlati_loop_1].gl_Position.zw;
        gs_SV_InstanceID0 = 0u;
        EmitVertex();
        EndPrimitive();
    }
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
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USE_TERRAIN_VERTEXTEXTURE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USE_TERRAIN_VERTEXTEXTURE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USE_TERRAIN_VERTEXTEXTURE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" "_USE_TERRAIN_VERTEXTEXTURE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" "_USE_TERRAIN_VERTEXTEXTURE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" "_USE_TERRAIN_VERTEXTEXTURE" }
""
}
}
Program "gp" {
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
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USE_TERRAIN_VERTEXTEXTURE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USE_TERRAIN_VERTEXTEXTURE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USE_TERRAIN_VERTEXTEXTURE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" "_USE_TERRAIN_VERTEXTEXTURE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" "_USE_TERRAIN_VERTEXTEXTURE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" "_USE_TERRAIN_VERTEXTEXTURE" }
""
}
}
}
}
SubShader {
 Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  GpuProgramID 93376
}
}
}