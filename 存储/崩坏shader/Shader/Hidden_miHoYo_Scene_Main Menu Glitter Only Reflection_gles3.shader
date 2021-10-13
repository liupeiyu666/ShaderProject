//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/miHoYo/Scene/Main Menu Glitter Only Reflection" {
Properties {
}
SubShader {
 LOD 200
 Pass {
  LOD 200
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 24690
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _BuildingLightingScintillationScaleLayer1;
uniform 	mediump float _BuildingLightingScintillationSpeedLayer1;
uniform 	mediump float _BuildingLightingScintillationScaleLayer2;
uniform 	mediump float _BuildingLightingScintillationSpeedLayer2;
uniform 	mediump float _CarLeftMovingSpeed;
uniform 	mediump float _CarRightMovingSpeed;
uniform 	vec2 _GameTime;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat1 = vec4(_BuildingLightingScintillationSpeedLayer1, _BuildingLightingScintillationSpeedLayer1, _BuildingLightingScintillationSpeedLayer2, _BuildingLightingScintillationSpeedLayer2) * _GameTime.yyyy;
    u_xlat1 = u_xlat1 * vec4(0.400000006, 0.200000003, 0.200000003, 0.400000006);
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * vec2(vec2(_BuildingLightingScintillationScaleLayer1, _BuildingLightingScintillationScaleLayer1)) + u_xlat1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * vec2(vec2(_BuildingLightingScintillationScaleLayer2, _BuildingLightingScintillationScaleLayer2)) + u_xlat1.zw;
    u_xlat1.x = _CarLeftMovingSpeed * _GameTime.x;
    u_xlat1.y = 0.0;
    vs_TEXCOORD2.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat4.x = _CarRightMovingSpeed * (-_GameTime.x);
    u_xlat4.y = 0.0;
    vs_TEXCOORD2.zw = u_xlat4.xy + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BuildingLightingBrightness;
uniform 	mediump float _CarLightingBrightness;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _CarLightingTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec3 u_xlat10_4;
lowp float u_xlat10_12;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_12 = texture(_GlitterTex, vs_TEXCOORD0.xy).y;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(u_xlat10_12);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_BuildingLightingBrightness, _BuildingLightingBrightness, _BuildingLightingBrightness));
    u_xlat10_0.x = texture(_NoiseTex, vs_TEXCOORD1.xy).w;
    u_xlat16_1.xyz = u_xlat10_0.xxx * u_xlat16_1.xyz;
    u_xlat10_4.x = texture(_NoiseTex, vs_TEXCOORD1.zw).w;
    u_xlat16_1.xyz = u_xlat10_4.xxx * u_xlat16_1.xyz;
    u_xlat10_4.xyz = texture(_CarLightingTex, vs_TEXCOORD2.xy).xyz;
    u_xlat10_2.xyz = texture(_CarLightingTex, vs_TEXCOORD2.zw).xyz;
    u_xlat16_4.xyz = u_xlat10_4.xyz + u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(vec3(_CarLightingBrightness, _CarLightingBrightness, _CarLightingBrightness));
    u_xlat16_3.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(3.0, 3.0, 3.0) + u_xlat16_3.xyz;
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
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _BuildingLightingScintillationScaleLayer1;
uniform 	mediump float _BuildingLightingScintillationSpeedLayer1;
uniform 	mediump float _BuildingLightingScintillationScaleLayer2;
uniform 	mediump float _BuildingLightingScintillationSpeedLayer2;
uniform 	mediump float _CarLeftMovingSpeed;
uniform 	mediump float _CarRightMovingSpeed;
uniform 	vec2 _GameTime;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat1 = vec4(_BuildingLightingScintillationSpeedLayer1, _BuildingLightingScintillationSpeedLayer1, _BuildingLightingScintillationSpeedLayer2, _BuildingLightingScintillationSpeedLayer2) * _GameTime.yyyy;
    u_xlat1 = u_xlat1 * vec4(0.400000006, 0.200000003, 0.200000003, 0.400000006);
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * vec2(vec2(_BuildingLightingScintillationScaleLayer1, _BuildingLightingScintillationScaleLayer1)) + u_xlat1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * vec2(vec2(_BuildingLightingScintillationScaleLayer2, _BuildingLightingScintillationScaleLayer2)) + u_xlat1.zw;
    u_xlat1.x = _CarLeftMovingSpeed * _GameTime.x;
    u_xlat1.y = 0.0;
    vs_TEXCOORD2.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat4.x = _CarRightMovingSpeed * (-_GameTime.x);
    u_xlat4.y = 0.0;
    vs_TEXCOORD2.zw = u_xlat4.xy + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BuildingLightingBrightness;
uniform 	mediump float _CarLightingBrightness;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _CarLightingTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec3 u_xlat10_4;
lowp float u_xlat10_12;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_12 = texture(_GlitterTex, vs_TEXCOORD0.xy).y;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(u_xlat10_12);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_BuildingLightingBrightness, _BuildingLightingBrightness, _BuildingLightingBrightness));
    u_xlat10_0.x = texture(_NoiseTex, vs_TEXCOORD1.xy).w;
    u_xlat16_1.xyz = u_xlat10_0.xxx * u_xlat16_1.xyz;
    u_xlat10_4.x = texture(_NoiseTex, vs_TEXCOORD1.zw).w;
    u_xlat16_1.xyz = u_xlat10_4.xxx * u_xlat16_1.xyz;
    u_xlat10_4.xyz = texture(_CarLightingTex, vs_TEXCOORD2.xy).xyz;
    u_xlat10_2.xyz = texture(_CarLightingTex, vs_TEXCOORD2.zw).xyz;
    u_xlat16_4.xyz = u_xlat10_4.xyz + u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(vec3(_CarLightingBrightness, _CarLightingBrightness, _CarLightingBrightness));
    u_xlat16_3.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(3.0, 3.0, 3.0) + u_xlat16_3.xyz;
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
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _BuildingLightingScintillationScaleLayer1;
uniform 	mediump float _BuildingLightingScintillationSpeedLayer1;
uniform 	mediump float _BuildingLightingScintillationScaleLayer2;
uniform 	mediump float _BuildingLightingScintillationSpeedLayer2;
uniform 	mediump float _CarLeftMovingSpeed;
uniform 	mediump float _CarRightMovingSpeed;
uniform 	vec2 _GameTime;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat1 = vec4(_BuildingLightingScintillationSpeedLayer1, _BuildingLightingScintillationSpeedLayer1, _BuildingLightingScintillationSpeedLayer2, _BuildingLightingScintillationSpeedLayer2) * _GameTime.yyyy;
    u_xlat1 = u_xlat1 * vec4(0.400000006, 0.200000003, 0.200000003, 0.400000006);
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * vec2(vec2(_BuildingLightingScintillationScaleLayer1, _BuildingLightingScintillationScaleLayer1)) + u_xlat1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * vec2(vec2(_BuildingLightingScintillationScaleLayer2, _BuildingLightingScintillationScaleLayer2)) + u_xlat1.zw;
    u_xlat1.x = _CarLeftMovingSpeed * _GameTime.x;
    u_xlat1.y = 0.0;
    vs_TEXCOORD2.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat4.x = _CarRightMovingSpeed * (-_GameTime.x);
    u_xlat4.y = 0.0;
    vs_TEXCOORD2.zw = u_xlat4.xy + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BuildingLightingBrightness;
uniform 	mediump float _CarLightingBrightness;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _CarLightingTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec3 u_xlat10_4;
lowp float u_xlat10_12;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_12 = texture(_GlitterTex, vs_TEXCOORD0.xy).y;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(u_xlat10_12);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_BuildingLightingBrightness, _BuildingLightingBrightness, _BuildingLightingBrightness));
    u_xlat10_0.x = texture(_NoiseTex, vs_TEXCOORD1.xy).w;
    u_xlat16_1.xyz = u_xlat10_0.xxx * u_xlat16_1.xyz;
    u_xlat10_4.x = texture(_NoiseTex, vs_TEXCOORD1.zw).w;
    u_xlat16_1.xyz = u_xlat10_4.xxx * u_xlat16_1.xyz;
    u_xlat10_4.xyz = texture(_CarLightingTex, vs_TEXCOORD2.xy).xyz;
    u_xlat10_2.xyz = texture(_CarLightingTex, vs_TEXCOORD2.zw).xyz;
    u_xlat16_4.xyz = u_xlat10_4.xyz + u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(vec3(_CarLightingBrightness, _CarLightingBrightness, _CarLightingBrightness));
    u_xlat16_3.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(3.0, 3.0, 3.0) + u_xlat16_3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _BuildingLightingScintillationScaleLayer1;
uniform 	mediump float _BuildingLightingScintillationSpeedLayer1;
uniform 	mediump float _BuildingLightingScintillationScaleLayer2;
uniform 	mediump float _BuildingLightingScintillationSpeedLayer2;
uniform 	mediump float _CarLeftMovingSpeed;
uniform 	mediump float _CarRightMovingSpeed;
uniform 	vec2 _GameTime;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat1 = vec4(_BuildingLightingScintillationSpeedLayer1, _BuildingLightingScintillationSpeedLayer1, _BuildingLightingScintillationSpeedLayer2, _BuildingLightingScintillationSpeedLayer2) * _GameTime.yyyy;
    u_xlat1 = u_xlat1 * vec4(0.400000006, 0.200000003, 0.200000003, 0.400000006);
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * vec2(vec2(_BuildingLightingScintillationScaleLayer1, _BuildingLightingScintillationScaleLayer1)) + u_xlat1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * vec2(vec2(_BuildingLightingScintillationScaleLayer2, _BuildingLightingScintillationScaleLayer2)) + u_xlat1.zw;
    u_xlat1.x = _CarLeftMovingSpeed * _GameTime.x;
    u_xlat1.y = 0.0;
    vs_TEXCOORD2.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat4.x = _CarRightMovingSpeed * (-_GameTime.x);
    u_xlat4.y = 0.0;
    vs_TEXCOORD2.zw = u_xlat4.xy + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BuildingLightingBrightness;
uniform 	mediump float _CarLightingBrightness;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _CarLightingTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec3 u_xlat10_4;
lowp float u_xlat10_12;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_12 = texture(_GlitterTex, vs_TEXCOORD0.xy).y;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(u_xlat10_12);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_BuildingLightingBrightness, _BuildingLightingBrightness, _BuildingLightingBrightness));
    u_xlat10_0.x = texture(_NoiseTex, vs_TEXCOORD1.xy).w;
    u_xlat16_1.xyz = u_xlat10_0.xxx * u_xlat16_1.xyz;
    u_xlat10_4.x = texture(_NoiseTex, vs_TEXCOORD1.zw).w;
    u_xlat16_1.xyz = u_xlat10_4.xxx * u_xlat16_1.xyz;
    u_xlat10_4.xyz = texture(_CarLightingTex, vs_TEXCOORD2.xy).xyz;
    u_xlat10_2.xyz = texture(_CarLightingTex, vs_TEXCOORD2.zw).xyz;
    u_xlat16_4.xyz = u_xlat10_4.xyz + u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(vec3(_CarLightingBrightness, _CarLightingBrightness, _CarLightingBrightness));
    u_xlat16_3.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(3.0, 3.0, 3.0) + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _BuildingLightingScintillationScaleLayer1;
uniform 	mediump float _BuildingLightingScintillationSpeedLayer1;
uniform 	mediump float _BuildingLightingScintillationScaleLayer2;
uniform 	mediump float _BuildingLightingScintillationSpeedLayer2;
uniform 	mediump float _CarLeftMovingSpeed;
uniform 	mediump float _CarRightMovingSpeed;
uniform 	vec2 _GameTime;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat1 = vec4(_BuildingLightingScintillationSpeedLayer1, _BuildingLightingScintillationSpeedLayer1, _BuildingLightingScintillationSpeedLayer2, _BuildingLightingScintillationSpeedLayer2) * _GameTime.yyyy;
    u_xlat1 = u_xlat1 * vec4(0.400000006, 0.200000003, 0.200000003, 0.400000006);
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * vec2(vec2(_BuildingLightingScintillationScaleLayer1, _BuildingLightingScintillationScaleLayer1)) + u_xlat1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * vec2(vec2(_BuildingLightingScintillationScaleLayer2, _BuildingLightingScintillationScaleLayer2)) + u_xlat1.zw;
    u_xlat1.x = _CarLeftMovingSpeed * _GameTime.x;
    u_xlat1.y = 0.0;
    vs_TEXCOORD2.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat4.x = _CarRightMovingSpeed * (-_GameTime.x);
    u_xlat4.y = 0.0;
    vs_TEXCOORD2.zw = u_xlat4.xy + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BuildingLightingBrightness;
uniform 	mediump float _CarLightingBrightness;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _CarLightingTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec3 u_xlat10_4;
lowp float u_xlat10_12;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_12 = texture(_GlitterTex, vs_TEXCOORD0.xy).y;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(u_xlat10_12);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_BuildingLightingBrightness, _BuildingLightingBrightness, _BuildingLightingBrightness));
    u_xlat10_0.x = texture(_NoiseTex, vs_TEXCOORD1.xy).w;
    u_xlat16_1.xyz = u_xlat10_0.xxx * u_xlat16_1.xyz;
    u_xlat10_4.x = texture(_NoiseTex, vs_TEXCOORD1.zw).w;
    u_xlat16_1.xyz = u_xlat10_4.xxx * u_xlat16_1.xyz;
    u_xlat10_4.xyz = texture(_CarLightingTex, vs_TEXCOORD2.xy).xyz;
    u_xlat10_2.xyz = texture(_CarLightingTex, vs_TEXCOORD2.zw).xyz;
    u_xlat16_4.xyz = u_xlat10_4.xyz + u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(vec3(_CarLightingBrightness, _CarLightingBrightness, _CarLightingBrightness));
    u_xlat16_3.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(3.0, 3.0, 3.0) + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _BuildingLightingScintillationScaleLayer1;
uniform 	mediump float _BuildingLightingScintillationSpeedLayer1;
uniform 	mediump float _BuildingLightingScintillationScaleLayer2;
uniform 	mediump float _BuildingLightingScintillationSpeedLayer2;
uniform 	mediump float _CarLeftMovingSpeed;
uniform 	mediump float _CarRightMovingSpeed;
uniform 	vec2 _GameTime;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat1 = vec4(_BuildingLightingScintillationSpeedLayer1, _BuildingLightingScintillationSpeedLayer1, _BuildingLightingScintillationSpeedLayer2, _BuildingLightingScintillationSpeedLayer2) * _GameTime.yyyy;
    u_xlat1 = u_xlat1 * vec4(0.400000006, 0.200000003, 0.200000003, 0.400000006);
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * vec2(vec2(_BuildingLightingScintillationScaleLayer1, _BuildingLightingScintillationScaleLayer1)) + u_xlat1.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * vec2(vec2(_BuildingLightingScintillationScaleLayer2, _BuildingLightingScintillationScaleLayer2)) + u_xlat1.zw;
    u_xlat1.x = _CarLeftMovingSpeed * _GameTime.x;
    u_xlat1.y = 0.0;
    vs_TEXCOORD2.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat4.x = _CarRightMovingSpeed * (-_GameTime.x);
    u_xlat4.y = 0.0;
    vs_TEXCOORD2.zw = u_xlat4.xy + u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BuildingLightingBrightness;
uniform 	mediump float _CarLightingBrightness;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _GlitterTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _CarLightingTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec3 u_xlat10_4;
lowp float u_xlat10_12;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_12 = texture(_GlitterTex, vs_TEXCOORD0.xy).y;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(u_xlat10_12);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_BuildingLightingBrightness, _BuildingLightingBrightness, _BuildingLightingBrightness));
    u_xlat10_0.x = texture(_NoiseTex, vs_TEXCOORD1.xy).w;
    u_xlat16_1.xyz = u_xlat10_0.xxx * u_xlat16_1.xyz;
    u_xlat10_4.x = texture(_NoiseTex, vs_TEXCOORD1.zw).w;
    u_xlat16_1.xyz = u_xlat10_4.xxx * u_xlat16_1.xyz;
    u_xlat10_4.xyz = texture(_CarLightingTex, vs_TEXCOORD2.xy).xyz;
    u_xlat10_2.xyz = texture(_CarLightingTex, vs_TEXCOORD2.zw).xyz;
    u_xlat16_4.xyz = u_xlat10_4.xyz + u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(vec3(_CarLightingBrightness, _CarLightingBrightness, _CarLightingBrightness));
    u_xlat16_3.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(3.0, 3.0, 3.0) + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
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