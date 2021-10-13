//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/MainMenu/DownSample_Composition" {
Properties {
}
SubShader {
 LOD 200
 Pass {
  LOD 200
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 20987
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _FarTex;
uniform lowp sampler2D _NearTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0.xyz = texture(_FarTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1 = texture(_NearTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = (-u_xlat10_0.xyz) + u_xlat10_1.xyz;
    SV_Target0.xyz = u_xlat10_1.www * u_xlat16_2.xyz + u_xlat10_0.xyz;
    SV_Target0.w = u_xlat10_1.w;
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

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _FarTex;
uniform lowp sampler2D _NearTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0.xyz = texture(_FarTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1 = texture(_NearTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = (-u_xlat10_0.xyz) + u_xlat10_1.xyz;
    SV_Target0.xyz = u_xlat10_1.www * u_xlat16_2.xyz + u_xlat10_0.xyz;
    SV_Target0.w = u_xlat10_1.w;
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

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _FarTex;
uniform lowp sampler2D _NearTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0.xyz = texture(_FarTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1 = texture(_NearTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = (-u_xlat10_0.xyz) + u_xlat10_1.xyz;
    SV_Target0.xyz = u_xlat10_1.www * u_xlat16_2.xyz + u_xlat10_0.xyz;
    SV_Target0.w = u_xlat10_1.w;
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
 Pass {
  LOD 200
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 74029
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec2 twoTexelSize;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
highp  vec4 phase0_Output0_1;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
highp  vec4 phase0_Output0_2;
out highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
mediump vec2 u_xlat16_8;
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
    u_xlat16_2.x = twoTexelSize.x;
    u_xlat16_2.x = u_xlat16_2.x + in_TEXCOORD0.x;
    u_xlat16_2.zw = in_TEXCOORD0.xy;
    phase0_Output0_1 = u_xlat16_2.zwxw;
    u_xlat16_8.x = 0.0;
    u_xlat16_8.y = twoTexelSize.y;
    u_xlat16_0.zw = u_xlat16_8.xy + in_TEXCOORD0.xy;
    u_xlat16_0.xy = in_TEXCOORD0.xy + twoTexelSize.xy;
    phase0_Output0_2 = u_xlat16_0;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
vs_TEXCOORD2 = phase0_Output0_2.xy;
vs_TEXCOORD3 = phase0_Output0_2.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _FarTex;
uniform lowp sampler2D _NearTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat10_0.xyz = texture(_FarTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(0.25, 0.25, 0.25);
    u_xlat10_1.xyz = texture(_FarTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_1.xyz * vec3(0.25, 0.25, 0.25) + u_xlat16_0.xyz;
    u_xlat10_1.xyz = texture(_FarTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_1.xyz * vec3(0.25, 0.25, 0.25) + u_xlat16_0.xyz;
    u_xlat10_1.xyz = texture(_FarTex, vs_TEXCOORD3.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_1.xyz * vec3(0.25, 0.25, 0.25) + u_xlat16_0.xyz;
    u_xlat10_1 = texture(_NearTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat10_1 * vec4(0.25, 0.25, 0.25, 0.25);
    u_xlat10_2 = texture(_NearTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_2 * vec4(0.25, 0.25, 0.25, 0.25) + u_xlat16_1;
    u_xlat10_2 = texture(_NearTex, vs_TEXCOORD2.xy);
    u_xlat16_1 = u_xlat10_2 * vec4(0.25, 0.25, 0.25, 0.25) + u_xlat16_1;
    u_xlat10_2 = texture(_NearTex, vs_TEXCOORD3.xy);
    u_xlat16_1 = u_xlat10_2 * vec4(0.25, 0.25, 0.25, 0.25) + u_xlat16_1;
    u_xlat16_3.xyz = (-u_xlat16_0.xyz) + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.www * u_xlat16_3.xyz + u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_1.w;
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
uniform 	mediump vec2 twoTexelSize;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
highp  vec4 phase0_Output0_1;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
highp  vec4 phase0_Output0_2;
out highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
mediump vec2 u_xlat16_8;
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
    u_xlat16_2.x = twoTexelSize.x;
    u_xlat16_2.x = u_xlat16_2.x + in_TEXCOORD0.x;
    u_xlat16_2.zw = in_TEXCOORD0.xy;
    phase0_Output0_1 = u_xlat16_2.zwxw;
    u_xlat16_8.x = 0.0;
    u_xlat16_8.y = twoTexelSize.y;
    u_xlat16_0.zw = u_xlat16_8.xy + in_TEXCOORD0.xy;
    u_xlat16_0.xy = in_TEXCOORD0.xy + twoTexelSize.xy;
    phase0_Output0_2 = u_xlat16_0;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
vs_TEXCOORD2 = phase0_Output0_2.xy;
vs_TEXCOORD3 = phase0_Output0_2.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _FarTex;
uniform lowp sampler2D _NearTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat10_0.xyz = texture(_FarTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(0.25, 0.25, 0.25);
    u_xlat10_1.xyz = texture(_FarTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_1.xyz * vec3(0.25, 0.25, 0.25) + u_xlat16_0.xyz;
    u_xlat10_1.xyz = texture(_FarTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_1.xyz * vec3(0.25, 0.25, 0.25) + u_xlat16_0.xyz;
    u_xlat10_1.xyz = texture(_FarTex, vs_TEXCOORD3.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_1.xyz * vec3(0.25, 0.25, 0.25) + u_xlat16_0.xyz;
    u_xlat10_1 = texture(_NearTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat10_1 * vec4(0.25, 0.25, 0.25, 0.25);
    u_xlat10_2 = texture(_NearTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_2 * vec4(0.25, 0.25, 0.25, 0.25) + u_xlat16_1;
    u_xlat10_2 = texture(_NearTex, vs_TEXCOORD2.xy);
    u_xlat16_1 = u_xlat10_2 * vec4(0.25, 0.25, 0.25, 0.25) + u_xlat16_1;
    u_xlat10_2 = texture(_NearTex, vs_TEXCOORD3.xy);
    u_xlat16_1 = u_xlat10_2 * vec4(0.25, 0.25, 0.25, 0.25) + u_xlat16_1;
    u_xlat16_3.xyz = (-u_xlat16_0.xyz) + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.www * u_xlat16_3.xyz + u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_1.w;
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
uniform 	mediump vec2 twoTexelSize;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
highp  vec4 phase0_Output0_1;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
highp  vec4 phase0_Output0_2;
out highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
mediump vec2 u_xlat16_8;
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
    u_xlat16_2.x = twoTexelSize.x;
    u_xlat16_2.x = u_xlat16_2.x + in_TEXCOORD0.x;
    u_xlat16_2.zw = in_TEXCOORD0.xy;
    phase0_Output0_1 = u_xlat16_2.zwxw;
    u_xlat16_8.x = 0.0;
    u_xlat16_8.y = twoTexelSize.y;
    u_xlat16_0.zw = u_xlat16_8.xy + in_TEXCOORD0.xy;
    u_xlat16_0.xy = in_TEXCOORD0.xy + twoTexelSize.xy;
    phase0_Output0_2 = u_xlat16_0;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
vs_TEXCOORD2 = phase0_Output0_2.xy;
vs_TEXCOORD3 = phase0_Output0_2.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _FarTex;
uniform lowp sampler2D _NearTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat10_0.xyz = texture(_FarTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(0.25, 0.25, 0.25);
    u_xlat10_1.xyz = texture(_FarTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_1.xyz * vec3(0.25, 0.25, 0.25) + u_xlat16_0.xyz;
    u_xlat10_1.xyz = texture(_FarTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_1.xyz * vec3(0.25, 0.25, 0.25) + u_xlat16_0.xyz;
    u_xlat10_1.xyz = texture(_FarTex, vs_TEXCOORD3.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_1.xyz * vec3(0.25, 0.25, 0.25) + u_xlat16_0.xyz;
    u_xlat10_1 = texture(_NearTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat10_1 * vec4(0.25, 0.25, 0.25, 0.25);
    u_xlat10_2 = texture(_NearTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_2 * vec4(0.25, 0.25, 0.25, 0.25) + u_xlat16_1;
    u_xlat10_2 = texture(_NearTex, vs_TEXCOORD2.xy);
    u_xlat16_1 = u_xlat10_2 * vec4(0.25, 0.25, 0.25, 0.25) + u_xlat16_1;
    u_xlat10_2 = texture(_NearTex, vs_TEXCOORD3.xy);
    u_xlat16_1 = u_xlat10_2 * vec4(0.25, 0.25, 0.25, 0.25) + u_xlat16_1;
    u_xlat16_3.xyz = (-u_xlat16_0.xyz) + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.www * u_xlat16_3.xyz + u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_1.w;
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