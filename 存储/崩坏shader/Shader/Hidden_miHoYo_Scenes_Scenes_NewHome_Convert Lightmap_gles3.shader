//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/miHoYo_Scenes/Scenes_NewHome/Convert Lightmap" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
}
SubShader {
 LOD 200
 Pass {
  LOD 200
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 22447
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _LightmapOffsetScale;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _LightmapOffsetScale.xy + _LightmapOffsetScale.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat16_0 = vec4(u_xlat10_0) * unity_Lightmap_HDR.xxxx;
    SV_Target0 = u_xlat16_0;
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
uniform 	vec4 _LightmapOffsetScale;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _LightmapOffsetScale.xy + _LightmapOffsetScale.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat16_0 = vec4(u_xlat10_0) * unity_Lightmap_HDR.xxxx;
    SV_Target0 = u_xlat16_0;
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
uniform 	vec4 _LightmapOffsetScale;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _LightmapOffsetScale.xy + _LightmapOffsetScale.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat16_0 = vec4(u_xlat10_0) * unity_Lightmap_HDR.xxxx;
    SV_Target0 = u_xlat16_0;
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
  GpuProgramID 126099
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _MainTex_TexelSize;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec4 u_xlat3;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
vec4 u_xlat5;
lowp vec4 u_xlat10_5;
lowp vec4 u_xlat10_6;
lowp vec4 u_xlat10_7;
void main()
{
    u_xlat0.xz = (-_MainTex_TexelSize.xy) * vec2(2.0, 2.0) + vs_TEXCOORD0.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat0.xz);
    u_xlat0.yw = vs_TEXCOORD0.yx + (-_MainTex_TexelSize.yx);
    u_xlat10_2 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_2 = u_xlat10_2 * vec4(0.0150189996, 0.0150189996, 0.0150189996, 0.0150189996);
    u_xlat16_1 = u_xlat10_1 * vec4(0.00376500003, 0.00376500003, 0.00376500003, 0.00376500003) + u_xlat16_2;
    u_xlat2.y = vs_TEXCOORD0.y;
    u_xlat2.x = u_xlat0.x;
    u_xlat10_3 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_1 = u_xlat10_3 * vec4(0.0237920005, 0.0237920005, 0.0237920005, 0.0237920005) + u_xlat16_1;
    u_xlat2.zw = vs_TEXCOORD0.yx + _MainTex_TexelSize.yx;
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat4.z = u_xlat2.x;
    u_xlat16_1 = u_xlat10_3 * vec4(0.0150189996, 0.0150189996, 0.0150189996, 0.0150189996) + u_xlat16_1;
    u_xlat4.xy = _MainTex_TexelSize.yx * vec2(2.0, 2.0) + vs_TEXCOORD0.yx;
    u_xlat10_3 = texture(_MainTex, u_xlat4.zx);
    u_xlat16_1 = u_xlat10_3 * vec4(0.00376500003, 0.00376500003, 0.00376500003, 0.00376500003) + u_xlat16_1;
    u_xlat10_3 = texture(_MainTex, u_xlat0.wz);
    u_xlat5.y = u_xlat0.z;
    u_xlat16_1 = u_xlat10_3 * vec4(0.0150189996, 0.0150189996, 0.0150189996, 0.0150189996) + u_xlat16_1;
    u_xlat10_3 = texture(_MainTex, u_xlat0.wy);
    u_xlat16_1 = u_xlat10_3 * vec4(0.0599119999, 0.0599119999, 0.0599119999, 0.0599119999) + u_xlat16_1;
    u_xlat3.z = vs_TEXCOORD0.y;
    u_xlat3.x = u_xlat0.w;
    u_xlat10_6 = texture(_MainTex, u_xlat3.xz);
    u_xlat16_1 = u_xlat10_6 * vec4(0.0949070007, 0.0949070007, 0.0949070007, 0.0949070007) + u_xlat16_1;
    u_xlat3.w = u_xlat2.z;
    u_xlat10_6 = texture(_MainTex, u_xlat3.xw);
    u_xlat0.w = u_xlat3.w;
    u_xlat16_1 = u_xlat10_6 * vec4(0.0599119999, 0.0599119999, 0.0599119999, 0.0599119999) + u_xlat16_1;
    u_xlat3.y = u_xlat4.x;
    u_xlat10_6 = texture(_MainTex, u_xlat3.xy);
    u_xlat16_1 = u_xlat10_6 * vec4(0.0150189996, 0.0150189996, 0.0150189996, 0.0150189996) + u_xlat16_1;
    u_xlat5.x = vs_TEXCOORD0.x;
    u_xlat10_6 = texture(_MainTex, u_xlat5.xy);
    u_xlat16_1 = u_xlat10_6 * vec4(0.0237920005, 0.0237920005, 0.0237920005, 0.0237920005) + u_xlat16_1;
    u_xlat0.xz = vs_TEXCOORD0.xx;
    u_xlat10_6 = texture(_MainTex, u_xlat0.xy);
    u_xlat5.w = u_xlat0.y;
    u_xlat10_7 = texture(_MainTex, u_xlat0.zw);
    u_xlat16_1 = u_xlat10_6 * vec4(0.0949070007, 0.0949070007, 0.0949070007, 0.0949070007) + u_xlat16_1;
    u_xlat10_6 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_6 * vec4(0.150342003, 0.150342003, 0.150342003, 0.150342003) + u_xlat16_1;
    u_xlat16_1 = u_xlat10_7 * vec4(0.0949070007, 0.0949070007, 0.0949070007, 0.0949070007) + u_xlat16_1;
    u_xlat3.x = vs_TEXCOORD0.x;
    u_xlat10_6 = texture(_MainTex, u_xlat3.xy);
    u_xlat16_1 = u_xlat10_6 * vec4(0.0237920005, 0.0237920005, 0.0237920005, 0.0237920005) + u_xlat16_1;
    u_xlat5.z = u_xlat2.w;
    u_xlat10_6 = texture(_MainTex, u_xlat5.zy);
    u_xlat4.w = u_xlat5.y;
    u_xlat10_7 = texture(_MainTex, u_xlat4.yw);
    u_xlat16_1 = u_xlat10_6 * vec4(0.0150189996, 0.0150189996, 0.0150189996, 0.0150189996) + u_xlat16_1;
    u_xlat10_6 = texture(_MainTex, u_xlat5.zw);
    u_xlat0.y = u_xlat5.w;
    u_xlat3.z = u_xlat5.z;
    u_xlat10_3 = texture(_MainTex, u_xlat3.zy);
    u_xlat16_1 = u_xlat10_6 * vec4(0.0599119999, 0.0599119999, 0.0599119999, 0.0599119999) + u_xlat16_1;
    u_xlat10_5 = texture(_MainTex, u_xlat2.wy);
    u_xlat10_2 = texture(_MainTex, u_xlat2.wz);
    u_xlat16_1 = u_xlat10_5 * vec4(0.0949070007, 0.0949070007, 0.0949070007, 0.0949070007) + u_xlat16_1;
    u_xlat16_1 = u_xlat10_2 * vec4(0.0599119999, 0.0599119999, 0.0599119999, 0.0599119999) + u_xlat16_1;
    u_xlat16_1 = u_xlat10_3 * vec4(0.0150189996, 0.0150189996, 0.0150189996, 0.0150189996) + u_xlat16_1;
    u_xlat16_1 = u_xlat10_7 * vec4(0.00376500003, 0.00376500003, 0.00376500003, 0.00376500003) + u_xlat16_1;
    u_xlat0.x = u_xlat4.y;
    u_xlat10_2 = texture(_MainTex, u_xlat4.yx);
    u_xlat10_3 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = u_xlat10_3 * vec4(0.0150189996, 0.0150189996, 0.0150189996, 0.0150189996) + u_xlat16_1;
    u_xlat0.z = vs_TEXCOORD0.y;
    u_xlat10_3 = texture(_MainTex, u_xlat0.xz);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xw);
    u_xlat16_1 = u_xlat10_3 * vec4(0.0237920005, 0.0237920005, 0.0237920005, 0.0237920005) + u_xlat16_1;
    u_xlat16_0 = u_xlat10_0 * vec4(0.0150189996, 0.0150189996, 0.0150189996, 0.0150189996) + u_xlat16_1;
    SV_Target0 = u_xlat10_2 * vec4(0.00376500003, 0.00376500003, 0.00376500003, 0.00376500003) + u_xlat16_0;
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
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _MainTex_TexelSize;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec4 u_xlat3;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
vec4 u_xlat5;
lowp vec4 u_xlat10_5;
lowp vec4 u_xlat10_6;
lowp vec4 u_xlat10_7;
void main()
{
    u_xlat0.xz = (-_MainTex_TexelSize.xy) * vec2(2.0, 2.0) + vs_TEXCOORD0.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat0.xz);
    u_xlat0.yw = vs_TEXCOORD0.yx + (-_MainTex_TexelSize.yx);
    u_xlat10_2 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_2 = u_xlat10_2 * vec4(0.0150189996, 0.0150189996, 0.0150189996, 0.0150189996);
    u_xlat16_1 = u_xlat10_1 * vec4(0.00376500003, 0.00376500003, 0.00376500003, 0.00376500003) + u_xlat16_2;
    u_xlat2.y = vs_TEXCOORD0.y;
    u_xlat2.x = u_xlat0.x;
    u_xlat10_3 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_1 = u_xlat10_3 * vec4(0.0237920005, 0.0237920005, 0.0237920005, 0.0237920005) + u_xlat16_1;
    u_xlat2.zw = vs_TEXCOORD0.yx + _MainTex_TexelSize.yx;
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat4.z = u_xlat2.x;
    u_xlat16_1 = u_xlat10_3 * vec4(0.0150189996, 0.0150189996, 0.0150189996, 0.0150189996) + u_xlat16_1;
    u_xlat4.xy = _MainTex_TexelSize.yx * vec2(2.0, 2.0) + vs_TEXCOORD0.yx;
    u_xlat10_3 = texture(_MainTex, u_xlat4.zx);
    u_xlat16_1 = u_xlat10_3 * vec4(0.00376500003, 0.00376500003, 0.00376500003, 0.00376500003) + u_xlat16_1;
    u_xlat10_3 = texture(_MainTex, u_xlat0.wz);
    u_xlat5.y = u_xlat0.z;
    u_xlat16_1 = u_xlat10_3 * vec4(0.0150189996, 0.0150189996, 0.0150189996, 0.0150189996) + u_xlat16_1;
    u_xlat10_3 = texture(_MainTex, u_xlat0.wy);
    u_xlat16_1 = u_xlat10_3 * vec4(0.0599119999, 0.0599119999, 0.0599119999, 0.0599119999) + u_xlat16_1;
    u_xlat3.z = vs_TEXCOORD0.y;
    u_xlat3.x = u_xlat0.w;
    u_xlat10_6 = texture(_MainTex, u_xlat3.xz);
    u_xlat16_1 = u_xlat10_6 * vec4(0.0949070007, 0.0949070007, 0.0949070007, 0.0949070007) + u_xlat16_1;
    u_xlat3.w = u_xlat2.z;
    u_xlat10_6 = texture(_MainTex, u_xlat3.xw);
    u_xlat0.w = u_xlat3.w;
    u_xlat16_1 = u_xlat10_6 * vec4(0.0599119999, 0.0599119999, 0.0599119999, 0.0599119999) + u_xlat16_1;
    u_xlat3.y = u_xlat4.x;
    u_xlat10_6 = texture(_MainTex, u_xlat3.xy);
    u_xlat16_1 = u_xlat10_6 * vec4(0.0150189996, 0.0150189996, 0.0150189996, 0.0150189996) + u_xlat16_1;
    u_xlat5.x = vs_TEXCOORD0.x;
    u_xlat10_6 = texture(_MainTex, u_xlat5.xy);
    u_xlat16_1 = u_xlat10_6 * vec4(0.0237920005, 0.0237920005, 0.0237920005, 0.0237920005) + u_xlat16_1;
    u_xlat0.xz = vs_TEXCOORD0.xx;
    u_xlat10_6 = texture(_MainTex, u_xlat0.xy);
    u_xlat5.w = u_xlat0.y;
    u_xlat10_7 = texture(_MainTex, u_xlat0.zw);
    u_xlat16_1 = u_xlat10_6 * vec4(0.0949070007, 0.0949070007, 0.0949070007, 0.0949070007) + u_xlat16_1;
    u_xlat10_6 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_6 * vec4(0.150342003, 0.150342003, 0.150342003, 0.150342003) + u_xlat16_1;
    u_xlat16_1 = u_xlat10_7 * vec4(0.0949070007, 0.0949070007, 0.0949070007, 0.0949070007) + u_xlat16_1;
    u_xlat3.x = vs_TEXCOORD0.x;
    u_xlat10_6 = texture(_MainTex, u_xlat3.xy);
    u_xlat16_1 = u_xlat10_6 * vec4(0.0237920005, 0.0237920005, 0.0237920005, 0.0237920005) + u_xlat16_1;
    u_xlat5.z = u_xlat2.w;
    u_xlat10_6 = texture(_MainTex, u_xlat5.zy);
    u_xlat4.w = u_xlat5.y;
    u_xlat10_7 = texture(_MainTex, u_xlat4.yw);
    u_xlat16_1 = u_xlat10_6 * vec4(0.0150189996, 0.0150189996, 0.0150189996, 0.0150189996) + u_xlat16_1;
    u_xlat10_6 = texture(_MainTex, u_xlat5.zw);
    u_xlat0.y = u_xlat5.w;
    u_xlat3.z = u_xlat5.z;
    u_xlat10_3 = texture(_MainTex, u_xlat3.zy);
    u_xlat16_1 = u_xlat10_6 * vec4(0.0599119999, 0.0599119999, 0.0599119999, 0.0599119999) + u_xlat16_1;
    u_xlat10_5 = texture(_MainTex, u_xlat2.wy);
    u_xlat10_2 = texture(_MainTex, u_xlat2.wz);
    u_xlat16_1 = u_xlat10_5 * vec4(0.0949070007, 0.0949070007, 0.0949070007, 0.0949070007) + u_xlat16_1;
    u_xlat16_1 = u_xlat10_2 * vec4(0.0599119999, 0.0599119999, 0.0599119999, 0.0599119999) + u_xlat16_1;
    u_xlat16_1 = u_xlat10_3 * vec4(0.0150189996, 0.0150189996, 0.0150189996, 0.0150189996) + u_xlat16_1;
    u_xlat16_1 = u_xlat10_7 * vec4(0.00376500003, 0.00376500003, 0.00376500003, 0.00376500003) + u_xlat16_1;
    u_xlat0.x = u_xlat4.y;
    u_xlat10_2 = texture(_MainTex, u_xlat4.yx);
    u_xlat10_3 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = u_xlat10_3 * vec4(0.0150189996, 0.0150189996, 0.0150189996, 0.0150189996) + u_xlat16_1;
    u_xlat0.z = vs_TEXCOORD0.y;
    u_xlat10_3 = texture(_MainTex, u_xlat0.xz);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xw);
    u_xlat16_1 = u_xlat10_3 * vec4(0.0237920005, 0.0237920005, 0.0237920005, 0.0237920005) + u_xlat16_1;
    u_xlat16_0 = u_xlat10_0 * vec4(0.0150189996, 0.0150189996, 0.0150189996, 0.0150189996) + u_xlat16_1;
    SV_Target0 = u_xlat10_2 * vec4(0.00376500003, 0.00376500003, 0.00376500003, 0.00376500003) + u_xlat16_0;
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
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _MainTex_TexelSize;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec4 u_xlat3;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
vec4 u_xlat5;
lowp vec4 u_xlat10_5;
lowp vec4 u_xlat10_6;
lowp vec4 u_xlat10_7;
void main()
{
    u_xlat0.xz = (-_MainTex_TexelSize.xy) * vec2(2.0, 2.0) + vs_TEXCOORD0.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat0.xz);
    u_xlat0.yw = vs_TEXCOORD0.yx + (-_MainTex_TexelSize.yx);
    u_xlat10_2 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_2 = u_xlat10_2 * vec4(0.0150189996, 0.0150189996, 0.0150189996, 0.0150189996);
    u_xlat16_1 = u_xlat10_1 * vec4(0.00376500003, 0.00376500003, 0.00376500003, 0.00376500003) + u_xlat16_2;
    u_xlat2.y = vs_TEXCOORD0.y;
    u_xlat2.x = u_xlat0.x;
    u_xlat10_3 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_1 = u_xlat10_3 * vec4(0.0237920005, 0.0237920005, 0.0237920005, 0.0237920005) + u_xlat16_1;
    u_xlat2.zw = vs_TEXCOORD0.yx + _MainTex_TexelSize.yx;
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat4.z = u_xlat2.x;
    u_xlat16_1 = u_xlat10_3 * vec4(0.0150189996, 0.0150189996, 0.0150189996, 0.0150189996) + u_xlat16_1;
    u_xlat4.xy = _MainTex_TexelSize.yx * vec2(2.0, 2.0) + vs_TEXCOORD0.yx;
    u_xlat10_3 = texture(_MainTex, u_xlat4.zx);
    u_xlat16_1 = u_xlat10_3 * vec4(0.00376500003, 0.00376500003, 0.00376500003, 0.00376500003) + u_xlat16_1;
    u_xlat10_3 = texture(_MainTex, u_xlat0.wz);
    u_xlat5.y = u_xlat0.z;
    u_xlat16_1 = u_xlat10_3 * vec4(0.0150189996, 0.0150189996, 0.0150189996, 0.0150189996) + u_xlat16_1;
    u_xlat10_3 = texture(_MainTex, u_xlat0.wy);
    u_xlat16_1 = u_xlat10_3 * vec4(0.0599119999, 0.0599119999, 0.0599119999, 0.0599119999) + u_xlat16_1;
    u_xlat3.z = vs_TEXCOORD0.y;
    u_xlat3.x = u_xlat0.w;
    u_xlat10_6 = texture(_MainTex, u_xlat3.xz);
    u_xlat16_1 = u_xlat10_6 * vec4(0.0949070007, 0.0949070007, 0.0949070007, 0.0949070007) + u_xlat16_1;
    u_xlat3.w = u_xlat2.z;
    u_xlat10_6 = texture(_MainTex, u_xlat3.xw);
    u_xlat0.w = u_xlat3.w;
    u_xlat16_1 = u_xlat10_6 * vec4(0.0599119999, 0.0599119999, 0.0599119999, 0.0599119999) + u_xlat16_1;
    u_xlat3.y = u_xlat4.x;
    u_xlat10_6 = texture(_MainTex, u_xlat3.xy);
    u_xlat16_1 = u_xlat10_6 * vec4(0.0150189996, 0.0150189996, 0.0150189996, 0.0150189996) + u_xlat16_1;
    u_xlat5.x = vs_TEXCOORD0.x;
    u_xlat10_6 = texture(_MainTex, u_xlat5.xy);
    u_xlat16_1 = u_xlat10_6 * vec4(0.0237920005, 0.0237920005, 0.0237920005, 0.0237920005) + u_xlat16_1;
    u_xlat0.xz = vs_TEXCOORD0.xx;
    u_xlat10_6 = texture(_MainTex, u_xlat0.xy);
    u_xlat5.w = u_xlat0.y;
    u_xlat10_7 = texture(_MainTex, u_xlat0.zw);
    u_xlat16_1 = u_xlat10_6 * vec4(0.0949070007, 0.0949070007, 0.0949070007, 0.0949070007) + u_xlat16_1;
    u_xlat10_6 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_6 * vec4(0.150342003, 0.150342003, 0.150342003, 0.150342003) + u_xlat16_1;
    u_xlat16_1 = u_xlat10_7 * vec4(0.0949070007, 0.0949070007, 0.0949070007, 0.0949070007) + u_xlat16_1;
    u_xlat3.x = vs_TEXCOORD0.x;
    u_xlat10_6 = texture(_MainTex, u_xlat3.xy);
    u_xlat16_1 = u_xlat10_6 * vec4(0.0237920005, 0.0237920005, 0.0237920005, 0.0237920005) + u_xlat16_1;
    u_xlat5.z = u_xlat2.w;
    u_xlat10_6 = texture(_MainTex, u_xlat5.zy);
    u_xlat4.w = u_xlat5.y;
    u_xlat10_7 = texture(_MainTex, u_xlat4.yw);
    u_xlat16_1 = u_xlat10_6 * vec4(0.0150189996, 0.0150189996, 0.0150189996, 0.0150189996) + u_xlat16_1;
    u_xlat10_6 = texture(_MainTex, u_xlat5.zw);
    u_xlat0.y = u_xlat5.w;
    u_xlat3.z = u_xlat5.z;
    u_xlat10_3 = texture(_MainTex, u_xlat3.zy);
    u_xlat16_1 = u_xlat10_6 * vec4(0.0599119999, 0.0599119999, 0.0599119999, 0.0599119999) + u_xlat16_1;
    u_xlat10_5 = texture(_MainTex, u_xlat2.wy);
    u_xlat10_2 = texture(_MainTex, u_xlat2.wz);
    u_xlat16_1 = u_xlat10_5 * vec4(0.0949070007, 0.0949070007, 0.0949070007, 0.0949070007) + u_xlat16_1;
    u_xlat16_1 = u_xlat10_2 * vec4(0.0599119999, 0.0599119999, 0.0599119999, 0.0599119999) + u_xlat16_1;
    u_xlat16_1 = u_xlat10_3 * vec4(0.0150189996, 0.0150189996, 0.0150189996, 0.0150189996) + u_xlat16_1;
    u_xlat16_1 = u_xlat10_7 * vec4(0.00376500003, 0.00376500003, 0.00376500003, 0.00376500003) + u_xlat16_1;
    u_xlat0.x = u_xlat4.y;
    u_xlat10_2 = texture(_MainTex, u_xlat4.yx);
    u_xlat10_3 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = u_xlat10_3 * vec4(0.0150189996, 0.0150189996, 0.0150189996, 0.0150189996) + u_xlat16_1;
    u_xlat0.z = vs_TEXCOORD0.y;
    u_xlat10_3 = texture(_MainTex, u_xlat0.xz);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xw);
    u_xlat16_1 = u_xlat10_3 * vec4(0.0237920005, 0.0237920005, 0.0237920005, 0.0237920005) + u_xlat16_1;
    u_xlat16_0 = u_xlat10_0 * vec4(0.0150189996, 0.0150189996, 0.0150189996, 0.0150189996) + u_xlat16_1;
    SV_Target0 = u_xlat10_2 * vec4(0.00376500003, 0.00376500003, 0.00376500003, 0.00376500003) + u_xlat16_0;
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
  GpuProgramID 171451
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _EdgeMinColor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = (-_EdgeMinColor) + vec4(1.0, 1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat10_0 + u_xlat1;
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
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _EdgeMinColor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = (-_EdgeMinColor) + vec4(1.0, 1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat10_0 + u_xlat1;
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
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _EdgeMinColor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = (-_EdgeMinColor) + vec4(1.0, 1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat10_0 + u_xlat1;
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
  GpuProgramID 256047
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec4 _DitherTex_TexelSize;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DitherTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vec2(vs_TEXCOORD0.x * _MainTex_TexelSize.z, vs_TEXCOORD0.y * _MainTex_TexelSize.w);
    u_xlat0.xy = floor(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * _DitherTex_TexelSize.xy;
    u_xlat10_0 = texture(_DitherTex, u_xlat0.xy).w;
    u_xlat16_0 = u_xlat10_0 * 0.03125 + -0.0078125;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = vec4(u_xlat16_0) + u_xlat10_1;
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
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec4 _DitherTex_TexelSize;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DitherTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vec2(vs_TEXCOORD0.x * _MainTex_TexelSize.z, vs_TEXCOORD0.y * _MainTex_TexelSize.w);
    u_xlat0.xy = floor(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * _DitherTex_TexelSize.xy;
    u_xlat10_0 = texture(_DitherTex, u_xlat0.xy).w;
    u_xlat16_0 = u_xlat10_0 * 0.03125 + -0.0078125;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = vec4(u_xlat16_0) + u_xlat10_1;
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
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec4 _DitherTex_TexelSize;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DitherTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vec2(vs_TEXCOORD0.x * _MainTex_TexelSize.z, vs_TEXCOORD0.y * _MainTex_TexelSize.w);
    u_xlat0.xy = floor(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * _DitherTex_TexelSize.xy;
    u_xlat10_0 = texture(_DitherTex, u_xlat0.xy).w;
    u_xlat16_0 = u_xlat10_0 * 0.03125 + -0.0078125;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = vec4(u_xlat16_0) + u_xlat10_1;
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
  GpuProgramID 301231
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _PackMask;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AOTexPack;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
void main()
{
    u_xlat10_0 = texture(_AOTexPack, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 * _PackMask;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = (-_PackMask) + vec4(1.0, 1.0, 1.0, 1.0);
    SV_Target0 = u_xlat10_1 * u_xlat2 + u_xlat0;
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
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _PackMask;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AOTexPack;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
void main()
{
    u_xlat10_0 = texture(_AOTexPack, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 * _PackMask;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = (-_PackMask) + vec4(1.0, 1.0, 1.0, 1.0);
    SV_Target0 = u_xlat10_1 * u_xlat2 + u_xlat0;
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
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _PackMask;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AOTexPack;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
void main()
{
    u_xlat10_0 = texture(_AOTexPack, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 * _PackMask;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = (-_PackMask) + vec4(1.0, 1.0, 1.0, 1.0);
    SV_Target0 = u_xlat10_1 * u_xlat2 + u_xlat0;
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