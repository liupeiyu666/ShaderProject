//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Special/Shadow/Blur Shadow Tex" {
Properties {
_MainTex ("Base (RGB)", 2D) = "" { }
}
SubShader {
 LOD 200
 Pass {
  LOD 200
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 4591
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
uniform 	mediump vec2 _scaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0 = _scaler.xyxy * vec4(-0.0473649986, -0.0473649986, -0.0185460001, -0.0185460001) + vs_TEXCOORD0.xyxy;
    u_xlat10_1.xyz = texture(_MainTex, u_xlat0.zw).xyz;
    u_xlat10_0.xyz = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz * vec3(0.297576994, 0.297576994, 0.297576994);
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(0.00495600002, 0.00495600002, 0.00495600002) + u_xlat16_1.xyz;
    u_xlat1 = _scaler.xyxy * vec4(0.00593600003, 0.00593600003, 0.0324909985, 0.0324909985) + vs_TEXCOORD0.xyxy;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat1.xy).xyz;
    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.zw).xyz;
    u_xlat16_0.xyz = u_xlat10_2.xyz * vec3(0.636880994, 0.636880994, 0.636880994) + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat10_1.xyz * vec3(0.0604300015, 0.0604300015, 0.0604300015) + u_xlat16_0.xyz;
    u_xlat1.xy = _scaler.xy * vec2(0.0625, 0.0625) + vs_TEXCOORD0.xy;
    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_1.xyz * vec3(0.000155000002, 0.000155000002, 0.000155000002) + u_xlat16_0.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = 0.0;
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
uniform 	mediump vec2 _scaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0 = _scaler.xyxy * vec4(-0.0473649986, -0.0473649986, -0.0185460001, -0.0185460001) + vs_TEXCOORD0.xyxy;
    u_xlat10_1.xyz = texture(_MainTex, u_xlat0.zw).xyz;
    u_xlat10_0.xyz = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz * vec3(0.297576994, 0.297576994, 0.297576994);
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(0.00495600002, 0.00495600002, 0.00495600002) + u_xlat16_1.xyz;
    u_xlat1 = _scaler.xyxy * vec4(0.00593600003, 0.00593600003, 0.0324909985, 0.0324909985) + vs_TEXCOORD0.xyxy;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat1.xy).xyz;
    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.zw).xyz;
    u_xlat16_0.xyz = u_xlat10_2.xyz * vec3(0.636880994, 0.636880994, 0.636880994) + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat10_1.xyz * vec3(0.0604300015, 0.0604300015, 0.0604300015) + u_xlat16_0.xyz;
    u_xlat1.xy = _scaler.xy * vec2(0.0625, 0.0625) + vs_TEXCOORD0.xy;
    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_1.xyz * vec3(0.000155000002, 0.000155000002, 0.000155000002) + u_xlat16_0.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = 0.0;
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
uniform 	mediump vec2 _scaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat0 = _scaler.xyxy * vec4(-0.0473649986, -0.0473649986, -0.0185460001, -0.0185460001) + vs_TEXCOORD0.xyxy;
    u_xlat10_1.xyz = texture(_MainTex, u_xlat0.zw).xyz;
    u_xlat10_0.xyz = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz * vec3(0.297576994, 0.297576994, 0.297576994);
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(0.00495600002, 0.00495600002, 0.00495600002) + u_xlat16_1.xyz;
    u_xlat1 = _scaler.xyxy * vec4(0.00593600003, 0.00593600003, 0.0324909985, 0.0324909985) + vs_TEXCOORD0.xyxy;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat1.xy).xyz;
    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.zw).xyz;
    u_xlat16_0.xyz = u_xlat10_2.xyz * vec3(0.636880994, 0.636880994, 0.636880994) + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat10_1.xyz * vec3(0.0604300015, 0.0604300015, 0.0604300015) + u_xlat16_0.xyz;
    u_xlat1.xy = _scaler.xy * vec2(0.0625, 0.0625) + vs_TEXCOORD0.xy;
    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_1.xyz * vec3(0.000155000002, 0.000155000002, 0.000155000002) + u_xlat16_0.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = 0.0;
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