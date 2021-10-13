//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Special/MainMenu/Near" {
Properties {
_MainColor ("Main Color", Color) = (1,1,1,1)
_Scale ("Scale Compared to Maya", Float) = 0.01
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Main Tex (RGB)", 2D) = "white" { }
_NormalMap ("Normal Map", 2D) = "green" { }
_BrushedNormalMap ("Brushed Normal Map", 2D) = "green" { }
_ReflectionMap ("Reflection Map", 2D) = "white" { }
_PointLightPos ("Point Light Position", Vector) = (0,0,0,1)
_PointLightParams ("Point Light Parameters", Vector) = (1,1,1,1)
_PointLightColor ("Point Light Color", Color) = (1,1,1,1)
_Shininess ("Shininess", Float) = 2
_FresnelParams ("Fresnel Parameters", Vector) = (5,1,0,0)
_OutlineWidth ("Outline Width", Range(0, 1)) = 0.1
_OutlineColor ("Outline Color", Color) = (0,0,0,1)
_Reflectivity ("Reflectivity", Range(0, 1)) = 0.5
_EnvMapOffsetX ("Environment Map Offset X", Range(-0.5, 0.5)) = 0
_EnvMapOffsetY ("Environment Map Offset Y", Range(-0.5, 0.5)) = 0
_BrushScale ("Brush Scale", Range(0, 1)) = 1
_BrushUVScale ("Brush UV Scale", Range(0, 2)) = 1
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  ZTest Less
  GpuProgramID 49649
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD3;
out mediump float vs_COLOR1;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_11;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD4.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat0.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat16_2.xxx;
    u_xlat16_11 = dot(u_xlat16_2.xyz, _WorldSpaceLightPos0.xyz);
    vs_TEXCOORD3.xyz = u_xlat16_2.xyz;
    u_xlat0.x = u_xlat16_11 * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _FresnelParams;
uniform 	mediump float _Reflectivity;
uniform 	mediump float _EnvMapOffsetX;
uniform 	mediump float _EnvMapOffsetY;
uniform 	mediump float _BrushScale;
uniform 	mediump float _BrushUVScale;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _BrushedNormalMap;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _miHoYo_NearEnvMap;
uniform lowp sampler2D _miHoYo_FarEnvMap;
uniform lowp sampler2D _ReflectionMap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec2 u_xlat16_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_7;
mediump vec2 u_xlat16_13;
float u_xlat20;
void main()
{
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat0.xy = vec2(vs_TEXCOORD1.x * _BrushUVScale, vs_TEXCOORD1.y * _BrushUVScale);
    u_xlat10_0.xy = texture(_BrushedNormalMap, u_xlat0.xy).xy;
    u_xlat16_13.xy = u_xlat10_0.yx * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_0.xy = u_xlat16_13.yx * vec2(vec2(_BrushScale, _BrushScale)) + u_xlat16_1.xy;
    u_xlat16_1.x = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.z = sqrt(u_xlat16_1.x);
    u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat20 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat2.xyz = vec3(u_xlat20) * u_xlat2.xyz;
    u_xlat16_0.w = (-u_xlat16_0.x);
    u_xlat20 = dot(u_xlat2.zyx, u_xlat16_0.yzw);
    u_xlat16_3.xyz = u_xlat16_0.xzy * vec3(-1.0, 1.0, 1.0);
    u_xlat20 = u_xlat20 + u_xlat20;
    u_xlat4.xyz = u_xlat16_3.xyz * (-vec3(u_xlat20)) + u_xlat2.xyz;
    u_xlat16_1.x = dot(u_xlat2.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.y;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x + _FresnelParams.z;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat4.xyz;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat20 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat4.x = u_xlat20 * hlslcc_mtx4x4unity_CameraProjection[0].x;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat20 = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat4.y = u_xlat20 * hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat2.xy = u_xlat4.xy / u_xlat2.xx;
    u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat4.x = u_xlat2.x + (-_EnvMapOffsetX);
    u_xlat4.y = u_xlat2.y + _EnvMapOffsetY;
    u_xlat2.xy = (-u_xlat4.xy) + vec2(1.0, 1.0);
    u_xlat10_0 = texture(_miHoYo_FarEnvMap, u_xlat2.xy);
    u_xlat2.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat2.xy = u_xlat16_13.xy * vec2(vec2(_BrushScale, _BrushScale)) + u_xlat2.xy;
    u_xlat2.z = u_xlat2.x + 0.00300000003;
    u_xlat10_2 = texture(_miHoYo_NearEnvMap, u_xlat2.zy);
    u_xlat16_3 = (-u_xlat10_0) + u_xlat10_2;
    u_xlat16_0 = u_xlat10_2.wwww * u_xlat16_3 + u_xlat10_0;
    u_xlat10_2.x = texture(_ReflectionMap, vs_TEXCOORD0.xy).x;
    u_xlat16_7.x = u_xlat10_2.x * _Reflectivity;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_7.x;
    u_xlat16_7.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    SV_Target0.w = u_xlat16_0.w * u_xlat16_1.x + _BloomFactor;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_2.xyz * _MainColor.xyz + u_xlat16_7.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD3;
out mediump float vs_COLOR1;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_11;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD4.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat0.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat16_2.xxx;
    u_xlat16_11 = dot(u_xlat16_2.xyz, _WorldSpaceLightPos0.xyz);
    vs_TEXCOORD3.xyz = u_xlat16_2.xyz;
    u_xlat0.x = u_xlat16_11 * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _FresnelParams;
uniform 	mediump float _Reflectivity;
uniform 	mediump float _EnvMapOffsetX;
uniform 	mediump float _EnvMapOffsetY;
uniform 	mediump float _BrushScale;
uniform 	mediump float _BrushUVScale;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _BrushedNormalMap;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _miHoYo_NearEnvMap;
uniform lowp sampler2D _miHoYo_FarEnvMap;
uniform lowp sampler2D _ReflectionMap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec2 u_xlat16_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_7;
mediump vec2 u_xlat16_13;
float u_xlat20;
void main()
{
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat0.xy = vec2(vs_TEXCOORD1.x * _BrushUVScale, vs_TEXCOORD1.y * _BrushUVScale);
    u_xlat10_0.xy = texture(_BrushedNormalMap, u_xlat0.xy).xy;
    u_xlat16_13.xy = u_xlat10_0.yx * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_0.xy = u_xlat16_13.yx * vec2(vec2(_BrushScale, _BrushScale)) + u_xlat16_1.xy;
    u_xlat16_1.x = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.z = sqrt(u_xlat16_1.x);
    u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat20 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat2.xyz = vec3(u_xlat20) * u_xlat2.xyz;
    u_xlat16_0.w = (-u_xlat16_0.x);
    u_xlat20 = dot(u_xlat2.zyx, u_xlat16_0.yzw);
    u_xlat16_3.xyz = u_xlat16_0.xzy * vec3(-1.0, 1.0, 1.0);
    u_xlat20 = u_xlat20 + u_xlat20;
    u_xlat4.xyz = u_xlat16_3.xyz * (-vec3(u_xlat20)) + u_xlat2.xyz;
    u_xlat16_1.x = dot(u_xlat2.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.y;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x + _FresnelParams.z;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat4.xyz;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat20 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat4.x = u_xlat20 * hlslcc_mtx4x4unity_CameraProjection[0].x;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat20 = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat4.y = u_xlat20 * hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat2.xy = u_xlat4.xy / u_xlat2.xx;
    u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat4.x = u_xlat2.x + (-_EnvMapOffsetX);
    u_xlat4.y = u_xlat2.y + _EnvMapOffsetY;
    u_xlat2.xy = (-u_xlat4.xy) + vec2(1.0, 1.0);
    u_xlat10_0 = texture(_miHoYo_FarEnvMap, u_xlat2.xy);
    u_xlat2.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat2.xy = u_xlat16_13.xy * vec2(vec2(_BrushScale, _BrushScale)) + u_xlat2.xy;
    u_xlat2.z = u_xlat2.x + 0.00300000003;
    u_xlat10_2 = texture(_miHoYo_NearEnvMap, u_xlat2.zy);
    u_xlat16_3 = (-u_xlat10_0) + u_xlat10_2;
    u_xlat16_0 = u_xlat10_2.wwww * u_xlat16_3 + u_xlat10_0;
    u_xlat10_2.x = texture(_ReflectionMap, vs_TEXCOORD0.xy).x;
    u_xlat16_7.x = u_xlat10_2.x * _Reflectivity;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_7.x;
    u_xlat16_7.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    SV_Target0.w = u_xlat16_0.w * u_xlat16_1.x + _BloomFactor;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_2.xyz * _MainColor.xyz + u_xlat16_7.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD3;
out mediump float vs_COLOR1;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_11;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD4.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat0.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat16_2.xxx;
    u_xlat16_11 = dot(u_xlat16_2.xyz, _WorldSpaceLightPos0.xyz);
    vs_TEXCOORD3.xyz = u_xlat16_2.xyz;
    u_xlat0.x = u_xlat16_11 * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _FresnelParams;
uniform 	mediump float _Reflectivity;
uniform 	mediump float _EnvMapOffsetX;
uniform 	mediump float _EnvMapOffsetY;
uniform 	mediump float _BrushScale;
uniform 	mediump float _BrushUVScale;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _BrushedNormalMap;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _miHoYo_NearEnvMap;
uniform lowp sampler2D _miHoYo_FarEnvMap;
uniform lowp sampler2D _ReflectionMap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec2 u_xlat16_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_7;
mediump vec2 u_xlat16_13;
float u_xlat20;
void main()
{
    u_xlat10_0.xy = texture(_NormalMap, vs_TEXCOORD0.xy).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat0.xy = vec2(vs_TEXCOORD1.x * _BrushUVScale, vs_TEXCOORD1.y * _BrushUVScale);
    u_xlat10_0.xy = texture(_BrushedNormalMap, u_xlat0.xy).xy;
    u_xlat16_13.xy = u_xlat10_0.yx * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_0.xy = u_xlat16_13.yx * vec2(vec2(_BrushScale, _BrushScale)) + u_xlat16_1.xy;
    u_xlat16_1.x = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.z = sqrt(u_xlat16_1.x);
    u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat20 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat2.xyz = vec3(u_xlat20) * u_xlat2.xyz;
    u_xlat16_0.w = (-u_xlat16_0.x);
    u_xlat20 = dot(u_xlat2.zyx, u_xlat16_0.yzw);
    u_xlat16_3.xyz = u_xlat16_0.xzy * vec3(-1.0, 1.0, 1.0);
    u_xlat20 = u_xlat20 + u_xlat20;
    u_xlat4.xyz = u_xlat16_3.xyz * (-vec3(u_xlat20)) + u_xlat2.xyz;
    u_xlat16_1.x = dot(u_xlat2.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.y;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x + _FresnelParams.z;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat4.xyz;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat20 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat4.x = u_xlat20 * hlslcc_mtx4x4unity_CameraProjection[0].x;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat20 = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat4.y = u_xlat20 * hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat2.xy = u_xlat4.xy / u_xlat2.xx;
    u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat4.x = u_xlat2.x + (-_EnvMapOffsetX);
    u_xlat4.y = u_xlat2.y + _EnvMapOffsetY;
    u_xlat2.xy = (-u_xlat4.xy) + vec2(1.0, 1.0);
    u_xlat10_0 = texture(_miHoYo_FarEnvMap, u_xlat2.xy);
    u_xlat2.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat2.xy = u_xlat16_13.xy * vec2(vec2(_BrushScale, _BrushScale)) + u_xlat2.xy;
    u_xlat2.z = u_xlat2.x + 0.00300000003;
    u_xlat10_2 = texture(_miHoYo_NearEnvMap, u_xlat2.zy);
    u_xlat16_3 = (-u_xlat10_0) + u_xlat10_2;
    u_xlat16_0 = u_xlat10_2.wwww * u_xlat16_3 + u_xlat10_0;
    u_xlat10_2.x = texture(_ReflectionMap, vs_TEXCOORD0.xy).x;
    u_xlat16_7.x = u_xlat10_2.x * _Reflectivity;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_7.x;
    u_xlat16_7.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    SV_Target0.w = u_xlat16_0.w * u_xlat16_1.x + _BloomFactor;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_2.xyz * _MainColor.xyz + u_xlat16_7.xyz;
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
  Name "SIMPLE_NORMAL"
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Front
  GpuProgramID 127183
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
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec4 in_NORMAL0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
bool u_xlatb8;
mediump float u_xlat16_11;
void main()
{
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat0;
    u_xlat1.xy = u_xlat0.xy * in_NORMAL0.yy;
    u_xlat0 = u_xlat0 * in_POSITION0.yyyy;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat2;
    u_xlat1.xy = u_xlat2.xy * in_NORMAL0.xx + u_xlat1.xy;
    u_xlat0 = u_xlat2 * in_POSITION0.xxxx + u_xlat0;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat2;
    u_xlat1.xy = u_xlat2.xy * in_NORMAL0.zz + u_xlat1.xy;
    u_xlat0 = u_xlat2 * in_POSITION0.zzzz + u_xlat0;
    u_xlat1.z = 0.00999999978;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xy = u_xlat1.xy * u_xlat16_3.xx;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat1;
    u_xlat0 = u_xlat1 * in_POSITION0.wwww + u_xlat0;
    u_xlat1 = u_xlat0 / u_xlat0.wwww;
    u_xlat0.x = (-u_xlat0.z) + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x + (-_FadeOffset);
    u_xlat0.x = u_xlat0.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    vs_COLOR0.w = u_xlat0.x;
    u_xlat0.x = (-u_xlat1.z) / hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat16_11 = u_xlat0.x / _Scale;
    u_xlat0.x = inversesqrt(u_xlat16_11);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat16_11 = _OutlineWidth * _Scale;
    u_xlat16_11 = u_xlat0.x * u_xlat16_11;
    u_xlat0.xy = u_xlat16_3.xy * vec2(u_xlat16_11) + u_xlat1.xy;
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
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
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
    u_xlat0.x = vs_COLOR0.w + 0.99000001;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    if((u_xlati0)==0){discard;}
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
    SV_Target0.w = vs_COLOR0.w;
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
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec4 in_NORMAL0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
bool u_xlatb8;
mediump float u_xlat16_11;
void main()
{
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat0;
    u_xlat1.xy = u_xlat0.xy * in_NORMAL0.yy;
    u_xlat0 = u_xlat0 * in_POSITION0.yyyy;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat2;
    u_xlat1.xy = u_xlat2.xy * in_NORMAL0.xx + u_xlat1.xy;
    u_xlat0 = u_xlat2 * in_POSITION0.xxxx + u_xlat0;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat2;
    u_xlat1.xy = u_xlat2.xy * in_NORMAL0.zz + u_xlat1.xy;
    u_xlat0 = u_xlat2 * in_POSITION0.zzzz + u_xlat0;
    u_xlat1.z = 0.00999999978;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xy = u_xlat1.xy * u_xlat16_3.xx;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat1;
    u_xlat0 = u_xlat1 * in_POSITION0.wwww + u_xlat0;
    u_xlat1 = u_xlat0 / u_xlat0.wwww;
    u_xlat0.x = (-u_xlat0.z) + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x + (-_FadeOffset);
    u_xlat0.x = u_xlat0.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    vs_COLOR0.w = u_xlat0.x;
    u_xlat0.x = (-u_xlat1.z) / hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat16_11 = u_xlat0.x / _Scale;
    u_xlat0.x = inversesqrt(u_xlat16_11);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat16_11 = _OutlineWidth * _Scale;
    u_xlat16_11 = u_xlat0.x * u_xlat16_11;
    u_xlat0.xy = u_xlat16_3.xy * vec2(u_xlat16_11) + u_xlat1.xy;
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
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
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
    u_xlat0.x = vs_COLOR0.w + 0.99000001;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    if((u_xlati0)==0){discard;}
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
    SV_Target0.w = vs_COLOR0.w;
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
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec4 in_NORMAL0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
bool u_xlatb8;
mediump float u_xlat16_11;
void main()
{
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat0;
    u_xlat1.xy = u_xlat0.xy * in_NORMAL0.yy;
    u_xlat0 = u_xlat0 * in_POSITION0.yyyy;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat2;
    u_xlat1.xy = u_xlat2.xy * in_NORMAL0.xx + u_xlat1.xy;
    u_xlat0 = u_xlat2 * in_POSITION0.xxxx + u_xlat0;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat2;
    u_xlat1.xy = u_xlat2.xy * in_NORMAL0.zz + u_xlat1.xy;
    u_xlat0 = u_xlat2 * in_POSITION0.zzzz + u_xlat0;
    u_xlat1.z = 0.00999999978;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xy = u_xlat1.xy * u_xlat16_3.xx;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat1;
    u_xlat0 = u_xlat1 * in_POSITION0.wwww + u_xlat0;
    u_xlat1 = u_xlat0 / u_xlat0.wwww;
    u_xlat0.x = (-u_xlat0.z) + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x + (-_FadeOffset);
    u_xlat0.x = u_xlat0.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    vs_COLOR0.w = u_xlat0.x;
    u_xlat0.x = (-u_xlat1.z) / hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat16_11 = u_xlat0.x / _Scale;
    u_xlat0.x = inversesqrt(u_xlat16_11);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat16_11 = _OutlineWidth * _Scale;
    u_xlat16_11 = u_xlat0.x * u_xlat16_11;
    u_xlat0.xy = u_xlat16_3.xy * vec2(u_xlat16_11) + u_xlat1.xy;
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
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
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
    u_xlat0.x = vs_COLOR0.w + 0.99000001;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    if((u_xlati0)==0){discard;}
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
    SV_Target0.w = vs_COLOR0.w;
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
}
Fallback "Diffuse"
}