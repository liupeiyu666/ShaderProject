//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_DLC/DLCSKLHOutBallV1" {
Properties {
_Color0 ("Color 0", Color) = (0.754717,0.754717,0.754717,0)
_Color1 ("Color 1", Color) = (0.754717,0.754717,0.754717,0)
_depthFade ("depthFade", Vector) = (0,0,0,0)
_Color2 ("Color 2", Color) = (0,0,0,0)
_opacity ("opacity", Float) = 0
_depth ("depth", Float) = 0
_TextureSample0 ("Texture Sample 0", 2D) = "white" { }
_fadeColor ("fadeColor", Color) = (0,0,0,0)
_texcoord ("", 2D) = "white" { }
__dirty ("", Float) = 1
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
 Pass {
  Name "FORWARD"
  Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 42976
Program "vp" {
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec2 _depthFade;
uniform 	mediump float _depth;
uniform 	mediump vec4 _Color1;
uniform 	mediump vec4 _Color0;
uniform 	vec4 _TextureSample0_ST;
uniform 	mediump vec4 _fadeColor;
uniform 	mediump float _opacity;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _TextureSample0;
uniform highp sampler2D unity_NHxRoughness;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
lowp float u_xlat10_6;
mediump float u_xlat16_12;
float u_xlat18;
mediump float u_xlat16_20;
float u_xlat21;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat10_1 = textureLod(unity_SpecCube0, u_xlat16_1.xyz, 6.0);
    u_xlat16_2.x = u_xlat10_1.w + -1.0;
    u_xlat16_2.x = unity_SpecCube0_HDR.w * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat10_1.xyz * u_xlat16_2.xxx;
    u_xlat18 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = vec3(u_xlat18) * vs_TEXCOORD1.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat21 = u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 + u_xlat18;
    u_xlat0.xyz = u_xlat3.xyz * (-vec3(u_xlat18)) + u_xlat0.xyz;
    u_xlat18 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat18) * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_20 = (-u_xlat21) + 1.0;
    u_xlat16_12 = u_xlat16_20 * u_xlat16_20;
    u_xlat16_12 = u_xlat16_20 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_20 * u_xlat16_12;
    u_xlat16_20 = u_xlat16_12 * -2.98023224e-08 + 0.220916301;
    u_xlat16_2.xyz = vec3(u_xlat16_20) * u_xlat16_2.xyz;
    u_xlat0.y = 1.0;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat0.xy).w;
    u_xlat16_20 = u_xlat0.x * 3.53466082;
    u_xlat16_5.xyz = _Color2.xyz * vec3(0.779083729, 0.779083729, 0.779083729) + vec3(u_xlat16_20);
    u_xlat16_2.xyz = u_xlat16_5.xyz * u_xlat16_4.xyz + u_xlat16_2.xyz;
    u_xlat0.xyz = vs_TEXCOORD3.zxy / vs_TEXCOORD3.www;
    u_xlat10_6 = texture(_CustomDepthTexture, u_xlat0.yz).x;
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat6.x = _ZBufferParams.z * u_xlat10_6 + _ZBufferParams.w;
    u_xlat6.x = float(1.0) / u_xlat6.x;
    u_xlat0.x = (-u_xlat0.x) + u_xlat6.x;
    u_xlat0.x = u_xlat0.x / _depthFade.y;
    u_xlat6.x = abs(u_xlat0.x) + 2.6400001;
    u_xlat0.x = abs(u_xlat0.x) + _depth;
    u_xlat0.x = u_xlat0.x + 2.6400001;
    u_xlat0.x = u_xlat0.x * -0.222717166 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat6.x * -0.222717166 + 1.0;
    u_xlat6.x = max(u_xlat6.x, 0.0);
    u_xlat6.xyz = u_xlat6.xxx * _Color0.xyz;
    u_xlat3.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
    u_xlat10_3.xyz = texture(_TextureSample0, u_xlat3.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_3.xyz * _fadeColor.xyz;
    u_xlat6.xyz = u_xlat6.xyz * u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _Color1.xyz + u_xlat6.xyz;
    SV_Target0.xyz = u_xlat0.xyz + u_xlat16_2.xyz;
    SV_Target0.w = _opacity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec2 _depthFade;
uniform 	mediump float _depth;
uniform 	mediump vec4 _Color1;
uniform 	mediump vec4 _Color0;
uniform 	vec4 _TextureSample0_ST;
uniform 	mediump vec4 _fadeColor;
uniform 	mediump float _opacity;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _TextureSample0;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
lowp vec3 u_xlat10_4;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_18;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat1.xyz);
    u_xlat10_2 = textureLod(unity_SpecCube0, u_xlat16_2.xyz, 6.0);
    u_xlat16_3.x = u_xlat10_2.w + -1.0;
    u_xlat16_3.x = unity_SpecCube0_HDR.w * u_xlat16_3.x + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * unity_SpecCube0_HDR.x;
    u_xlat16_3.xyz = u_xlat10_2.xyz * u_xlat16_3.xxx;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.720000029, 0.720000029, 0.720000029);
    u_xlat15 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * vs_TEXCOORD1.xyz;
    u_xlat15 = dot(u_xlat4.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_18 = (-u_xlat15) + 1.0;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_18 = u_xlat16_18 * -2.98023224e-08 + 0.220916301;
    u_xlat16_3.xyz = vec3(u_xlat16_18) * u_xlat16_3.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = max(u_xlat15, 0.00100000005);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = max(u_xlat0.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * 2.50002503;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = u_xlat0.x * 0.220916301;
    u_xlat0.xyz = _Color2.xyz * vec3(0.779083729, 0.779083729, 0.779083729) + u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx + u_xlat16_3.xyz;
    u_xlat1.xyz = vs_TEXCOORD3.zxy / vs_TEXCOORD3.www;
    u_xlat10_15 = texture(_CustomDepthTexture, u_xlat1.yz).x;
    u_xlat1.x = u_xlat1.x * 0.5 + 0.5;
    u_xlat1.x = _ZBufferParams.z * u_xlat1.x + _ZBufferParams.w;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat15 = _ZBufferParams.z * u_xlat10_15 + _ZBufferParams.w;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = (-u_xlat1.x) + u_xlat15;
    u_xlat15 = u_xlat15 / _depthFade.y;
    u_xlat1.x = abs(u_xlat15) + 2.6400001;
    u_xlat15 = abs(u_xlat15) + _depth;
    u_xlat15 = u_xlat15 + 2.6400001;
    u_xlat15 = u_xlat15 * -0.222717166 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x * -0.222717166 + 1.0;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.xyz = u_xlat1.xxx * _Color0.xyz;
    u_xlat4.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
    u_xlat10_4.xyz = texture(_TextureSample0, u_xlat4.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_4.xyz * _fadeColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat16_4.xyz;
    u_xlat1.xyz = vec3(u_xlat15) * _Color1.xyz + u_xlat1.xyz;
    SV_Target0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    SV_Target0.w = _opacity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec2 _depthFade;
uniform 	mediump float _depth;
uniform 	mediump vec4 _Color1;
uniform 	mediump vec4 _Color0;
uniform 	vec4 _TextureSample0_ST;
uniform 	mediump vec4 _fadeColor;
uniform 	mediump float _opacity;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _TextureSample0;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
lowp vec3 u_xlat10_4;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_18;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat1.xyz);
    u_xlat10_2 = textureLod(unity_SpecCube0, u_xlat16_2.xyz, 6.0);
    u_xlat16_3.x = u_xlat10_2.w + -1.0;
    u_xlat16_3.x = unity_SpecCube0_HDR.w * u_xlat16_3.x + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * unity_SpecCube0_HDR.x;
    u_xlat16_3.xyz = u_xlat10_2.xyz * u_xlat16_3.xxx;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.720000029, 0.720000029, 0.720000029);
    u_xlat15 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * vs_TEXCOORD1.xyz;
    u_xlat15 = dot(u_xlat4.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_18 = (-u_xlat15) + 1.0;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_18 = u_xlat16_18 * -2.98023224e-08 + 0.220916301;
    u_xlat16_3.xyz = vec3(u_xlat16_18) * u_xlat16_3.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = max(u_xlat15, 0.00100000005);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = max(u_xlat0.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * 2.50002503;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = u_xlat0.x * 0.220916301;
    u_xlat0.xyz = _Color2.xyz * vec3(0.779083729, 0.779083729, 0.779083729) + u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx + u_xlat16_3.xyz;
    u_xlat1.xyz = vs_TEXCOORD3.zxy / vs_TEXCOORD3.www;
    u_xlat10_15 = texture(_CustomDepthTexture, u_xlat1.yz).x;
    u_xlat1.x = u_xlat1.x * 0.5 + 0.5;
    u_xlat1.x = _ZBufferParams.z * u_xlat1.x + _ZBufferParams.w;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat15 = _ZBufferParams.z * u_xlat10_15 + _ZBufferParams.w;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = (-u_xlat1.x) + u_xlat15;
    u_xlat15 = u_xlat15 / _depthFade.y;
    u_xlat1.x = abs(u_xlat15) + 2.6400001;
    u_xlat15 = abs(u_xlat15) + _depth;
    u_xlat15 = u_xlat15 + 2.6400001;
    u_xlat15 = u_xlat15 * -0.222717166 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x * -0.222717166 + 1.0;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.xyz = u_xlat1.xxx * _Color0.xyz;
    u_xlat4.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
    u_xlat10_4.xyz = texture(_TextureSample0, u_xlat4.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_4.xyz * _fadeColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat16_4.xyz;
    u_xlat1.xyz = vec3(u_xlat15) * _Color1.xyz + u_xlat1.xyz;
    SV_Target0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    SV_Target0.w = _opacity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat16_3 = u_xlat1.y * u_xlat1.y;
    u_xlat16_3 = u_xlat1.x * u_xlat1.x + (-u_xlat16_3);
    u_xlat16_0 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec2 _depthFade;
uniform 	mediump float _depth;
uniform 	mediump vec4 _Color1;
uniform 	mediump vec4 _Color0;
uniform 	vec4 _TextureSample0_ST;
uniform 	mediump vec4 _fadeColor;
uniform 	mediump float _opacity;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _TextureSample0;
uniform highp sampler2D unity_NHxRoughness;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
lowp float u_xlat10_7;
float u_xlat21;
mediump float u_xlat16_21;
float u_xlat23;
mediump float u_xlat16_24;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD4.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat2.xyz);
    u_xlat10_1 = textureLod(unity_SpecCube0, u_xlat16_1.xyz, 6.0);
    u_xlat16_3.x = u_xlat10_1.w + -1.0;
    u_xlat16_3.x = unity_SpecCube0_HDR.w * u_xlat16_3.x + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * unity_SpecCube0_HDR.x;
    u_xlat16_3.xyz = u_xlat10_1.xyz * u_xlat16_3.xxx;
    u_xlat21 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = vec3(u_xlat21) * vs_TEXCOORD1.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat23 = u_xlat21;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat2.xyz = u_xlat4.xyz * (-vec3(u_xlat21)) + u_xlat2.xyz;
    u_xlat21 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat21) * _LightColor0.xyz;
    u_xlat21 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat21 = u_xlat21 * u_xlat21;
    u_xlat2.x = u_xlat21 * u_xlat21;
    u_xlat16_24 = (-u_xlat23) + 1.0;
    u_xlat16_21 = u_xlat16_24 * u_xlat16_24;
    u_xlat16_21 = u_xlat16_24 * u_xlat16_21;
    u_xlat16_21 = u_xlat16_24 * u_xlat16_21;
    u_xlat16_24 = u_xlat16_21 * -2.98023224e-08 + 0.220916301;
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_6.xyz = _Color2.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_6.xyz + u_xlat16_3.xyz;
    u_xlat2.y = 1.0;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat2.xy).w;
    u_xlat16_6.xyz = u_xlat0.xxx * vec3(3.53466082, 3.53466082, 3.53466082) + u_xlat16_6.xyz;
    u_xlat16_3.xyz = u_xlat16_6.xyz * u_xlat16_5.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = vs_TEXCOORD3.zxy / vs_TEXCOORD3.www;
    u_xlat10_7 = texture(_CustomDepthTexture, u_xlat0.yz).x;
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat7.x = _ZBufferParams.z * u_xlat10_7 + _ZBufferParams.w;
    u_xlat7.x = float(1.0) / u_xlat7.x;
    u_xlat0.x = (-u_xlat0.x) + u_xlat7.x;
    u_xlat0.x = u_xlat0.x / _depthFade.y;
    u_xlat7.x = abs(u_xlat0.x) + 2.6400001;
    u_xlat0.x = abs(u_xlat0.x) + _depth;
    u_xlat0.x = u_xlat0.x + 2.6400001;
    u_xlat0.x = u_xlat0.x * -0.222717166 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat7.x * -0.222717166 + 1.0;
    u_xlat7.x = max(u_xlat7.x, 0.0);
    u_xlat7.xyz = u_xlat7.xxx * _Color0.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
    u_xlat10_2.xyz = texture(_TextureSample0, u_xlat2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_2.xyz * _fadeColor.xyz;
    u_xlat7.xyz = u_xlat7.xyz * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _Color1.xyz + u_xlat7.xyz;
    SV_Target0.xyz = u_xlat0.xyz + u_xlat16_3.xyz;
    SV_Target0.w = _opacity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat16_3 = u_xlat1.y * u_xlat1.y;
    u_xlat16_3 = u_xlat1.x * u_xlat1.x + (-u_xlat16_3);
    u_xlat16_0 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec2 _depthFade;
uniform 	mediump float _depth;
uniform 	mediump vec4 _Color1;
uniform 	mediump vec4 _Color0;
uniform 	vec4 _TextureSample0_ST;
uniform 	mediump vec4 _fadeColor;
uniform 	mediump float _opacity;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _TextureSample0;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_6;
float u_xlat15;
lowp float u_xlat10_15;
float u_xlat18;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD4.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = _Color2.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = u_xlat0.xyz * vec3(u_xlat15) + _WorldSpaceLightPos0.xyz;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = max(u_xlat15, 0.00100000005);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat15 = dot(_WorldSpaceLightPos0.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat15 = max(u_xlat15, 0.319999993);
    u_xlat15 = u_xlat15 * 2.50002503;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = u_xlat15 + -9.99999975e-05;
    u_xlat3.xyz = vec3(u_xlat15) * vec3(0.220916301, 0.220916301, 0.220916301) + u_xlat16_1.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _LightColor0.xyz;
    u_xlat15 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * vs_TEXCOORD1.xyz;
    u_xlat15 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat18 = dot(u_xlat4.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-u_xlat18) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * -2.98023224e-08 + 0.220916301;
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat15) + u_xlat16_2.xyz;
    u_xlat16_6.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_6.x = u_xlat16_6.x + u_xlat16_6.x;
    u_xlat16_6.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_6.xxx) + (-u_xlat0.xyz);
    u_xlat10_0 = textureLod(unity_SpecCube0, u_xlat16_6.xyz, 6.0);
    u_xlat16_6.x = u_xlat10_0.w + -1.0;
    u_xlat16_6.x = unity_SpecCube0_HDR.w * u_xlat16_6.x + 1.0;
    u_xlat16_6.x = u_xlat16_6.x * unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat10_0.xyz * u_xlat16_6.xxx;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(0.720000029, 0.720000029, 0.720000029);
    u_xlat0.xyz = u_xlat16_6.xyz * u_xlat16_1.xxx + u_xlat3.xyz;
    u_xlat3.xyz = vs_TEXCOORD3.zxy / vs_TEXCOORD3.www;
    u_xlat10_15 = texture(_CustomDepthTexture, u_xlat3.yz).x;
    u_xlat3.x = u_xlat3.x * 0.5 + 0.5;
    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat15 = _ZBufferParams.z * u_xlat10_15 + _ZBufferParams.w;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = (-u_xlat3.x) + u_xlat15;
    u_xlat15 = u_xlat15 / _depthFade.y;
    u_xlat3.x = abs(u_xlat15) + 2.6400001;
    u_xlat15 = abs(u_xlat15) + _depth;
    u_xlat15 = u_xlat15 + 2.6400001;
    u_xlat15 = u_xlat15 * -0.222717166 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x * -0.222717166 + 1.0;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.xyz = u_xlat3.xxx * _Color0.xyz;
    u_xlat4.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
    u_xlat10_4.xyz = texture(_TextureSample0, u_xlat4.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_4.xyz * _fadeColor.xyz;
    u_xlat3.xyz = u_xlat3.xyz * u_xlat16_4.xyz;
    u_xlat3.xyz = vec3(u_xlat15) * _Color1.xyz + u_xlat3.xyz;
    SV_Target0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    SV_Target0.w = _opacity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat16_3 = u_xlat1.y * u_xlat1.y;
    u_xlat16_3 = u_xlat1.x * u_xlat1.x + (-u_xlat16_3);
    u_xlat16_0 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec2 _depthFade;
uniform 	mediump float _depth;
uniform 	mediump vec4 _Color1;
uniform 	mediump vec4 _Color0;
uniform 	vec4 _TextureSample0_ST;
uniform 	mediump vec4 _fadeColor;
uniform 	mediump float _opacity;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _TextureSample0;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_6;
float u_xlat15;
lowp float u_xlat10_15;
float u_xlat18;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD4.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = _Color2.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = u_xlat0.xyz * vec3(u_xlat15) + _WorldSpaceLightPos0.xyz;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = max(u_xlat15, 0.00100000005);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat15 = dot(_WorldSpaceLightPos0.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat15 = max(u_xlat15, 0.319999993);
    u_xlat15 = u_xlat15 * 2.50002503;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = u_xlat15 + -9.99999975e-05;
    u_xlat3.xyz = vec3(u_xlat15) * vec3(0.220916301, 0.220916301, 0.220916301) + u_xlat16_1.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _LightColor0.xyz;
    u_xlat15 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * vs_TEXCOORD1.xyz;
    u_xlat15 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat18 = dot(u_xlat4.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-u_xlat18) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * -2.98023224e-08 + 0.220916301;
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat15) + u_xlat16_2.xyz;
    u_xlat16_6.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_6.x = u_xlat16_6.x + u_xlat16_6.x;
    u_xlat16_6.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_6.xxx) + (-u_xlat0.xyz);
    u_xlat10_0 = textureLod(unity_SpecCube0, u_xlat16_6.xyz, 6.0);
    u_xlat16_6.x = u_xlat10_0.w + -1.0;
    u_xlat16_6.x = unity_SpecCube0_HDR.w * u_xlat16_6.x + 1.0;
    u_xlat16_6.x = u_xlat16_6.x * unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat10_0.xyz * u_xlat16_6.xxx;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(0.720000029, 0.720000029, 0.720000029);
    u_xlat0.xyz = u_xlat16_6.xyz * u_xlat16_1.xxx + u_xlat3.xyz;
    u_xlat3.xyz = vs_TEXCOORD3.zxy / vs_TEXCOORD3.www;
    u_xlat10_15 = texture(_CustomDepthTexture, u_xlat3.yz).x;
    u_xlat3.x = u_xlat3.x * 0.5 + 0.5;
    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat15 = _ZBufferParams.z * u_xlat10_15 + _ZBufferParams.w;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = (-u_xlat3.x) + u_xlat15;
    u_xlat15 = u_xlat15 / _depthFade.y;
    u_xlat3.x = abs(u_xlat15) + 2.6400001;
    u_xlat15 = abs(u_xlat15) + _depth;
    u_xlat15 = u_xlat15 + 2.6400001;
    u_xlat15 = u_xlat15 * -0.222717166 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x * -0.222717166 + 1.0;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.xyz = u_xlat3.xxx * _Color0.xyz;
    u_xlat4.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
    u_xlat10_4.xyz = texture(_TextureSample0, u_xlat4.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_4.xyz * _fadeColor.xyz;
    u_xlat3.xyz = u_xlat3.xyz * u_xlat16_4.xyz;
    u_xlat3.xyz = vec3(u_xlat15) * _Color1.xyz + u_xlat3.xyz;
    SV_Target0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    SV_Target0.w = _opacity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    vs_TEXCOORD1.xyz = u_xlat2.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat21 = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat21 * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat1 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat4 = u_xlat2.yyyy * u_xlat3;
    u_xlat3 = u_xlat3 * u_xlat3;
    u_xlat3 = u_xlat1 * u_xlat1 + u_xlat3;
    u_xlat1 = u_xlat1 * u_xlat2.xxxx + u_xlat4;
    u_xlat1 = u_xlat0 * u_xlat2.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat3 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat3;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_5.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_5.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_5.x);
    u_xlat16_2 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz * u_xlat1.xyz + u_xlat16_5.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec2 _depthFade;
uniform 	mediump float _depth;
uniform 	mediump vec4 _Color1;
uniform 	mediump vec4 _Color0;
uniform 	vec4 _TextureSample0_ST;
uniform 	mediump vec4 _fadeColor;
uniform 	mediump float _opacity;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _TextureSample0;
uniform highp sampler2D unity_NHxRoughness;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
lowp float u_xlat10_7;
float u_xlat21;
mediump float u_xlat16_21;
float u_xlat23;
mediump float u_xlat16_24;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD4.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat2.xyz);
    u_xlat10_1 = textureLod(unity_SpecCube0, u_xlat16_1.xyz, 6.0);
    u_xlat16_3.x = u_xlat10_1.w + -1.0;
    u_xlat16_3.x = unity_SpecCube0_HDR.w * u_xlat16_3.x + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * unity_SpecCube0_HDR.x;
    u_xlat16_3.xyz = u_xlat10_1.xyz * u_xlat16_3.xxx;
    u_xlat21 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = vec3(u_xlat21) * vs_TEXCOORD1.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat23 = u_xlat21;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat2.xyz = u_xlat4.xyz * (-vec3(u_xlat21)) + u_xlat2.xyz;
    u_xlat21 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat21) * _LightColor0.xyz;
    u_xlat21 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat21 = u_xlat21 * u_xlat21;
    u_xlat2.x = u_xlat21 * u_xlat21;
    u_xlat16_24 = (-u_xlat23) + 1.0;
    u_xlat16_21 = u_xlat16_24 * u_xlat16_24;
    u_xlat16_21 = u_xlat16_24 * u_xlat16_21;
    u_xlat16_21 = u_xlat16_24 * u_xlat16_21;
    u_xlat16_24 = u_xlat16_21 * -2.98023224e-08 + 0.220916301;
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_6.xyz = _Color2.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_6.xyz + u_xlat16_3.xyz;
    u_xlat2.y = 1.0;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat2.xy).w;
    u_xlat16_6.xyz = u_xlat0.xxx * vec3(3.53466082, 3.53466082, 3.53466082) + u_xlat16_6.xyz;
    u_xlat16_3.xyz = u_xlat16_6.xyz * u_xlat16_5.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = vs_TEXCOORD3.zxy / vs_TEXCOORD3.www;
    u_xlat10_7 = texture(_CustomDepthTexture, u_xlat0.yz).x;
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat7.x = _ZBufferParams.z * u_xlat10_7 + _ZBufferParams.w;
    u_xlat7.x = float(1.0) / u_xlat7.x;
    u_xlat0.x = (-u_xlat0.x) + u_xlat7.x;
    u_xlat0.x = u_xlat0.x / _depthFade.y;
    u_xlat7.x = abs(u_xlat0.x) + 2.6400001;
    u_xlat0.x = abs(u_xlat0.x) + _depth;
    u_xlat0.x = u_xlat0.x + 2.6400001;
    u_xlat0.x = u_xlat0.x * -0.222717166 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat7.x * -0.222717166 + 1.0;
    u_xlat7.x = max(u_xlat7.x, 0.0);
    u_xlat7.xyz = u_xlat7.xxx * _Color0.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
    u_xlat10_2.xyz = texture(_TextureSample0, u_xlat2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_2.xyz * _fadeColor.xyz;
    u_xlat7.xyz = u_xlat7.xyz * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _Color1.xyz + u_xlat7.xyz;
    SV_Target0.xyz = u_xlat0.xyz + u_xlat16_3.xyz;
    SV_Target0.w = _opacity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    vs_TEXCOORD1.xyz = u_xlat2.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat21 = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat21 * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat1 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat4 = u_xlat2.yyyy * u_xlat3;
    u_xlat3 = u_xlat3 * u_xlat3;
    u_xlat3 = u_xlat1 * u_xlat1 + u_xlat3;
    u_xlat1 = u_xlat1 * u_xlat2.xxxx + u_xlat4;
    u_xlat1 = u_xlat0 * u_xlat2.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat3 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat3;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_5.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_5.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_5.x);
    u_xlat16_2 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz * u_xlat1.xyz + u_xlat16_5.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec2 _depthFade;
uniform 	mediump float _depth;
uniform 	mediump vec4 _Color1;
uniform 	mediump vec4 _Color0;
uniform 	vec4 _TextureSample0_ST;
uniform 	mediump vec4 _fadeColor;
uniform 	mediump float _opacity;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _TextureSample0;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_6;
float u_xlat15;
lowp float u_xlat10_15;
float u_xlat18;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD4.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = _Color2.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = u_xlat0.xyz * vec3(u_xlat15) + _WorldSpaceLightPos0.xyz;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = max(u_xlat15, 0.00100000005);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat15 = dot(_WorldSpaceLightPos0.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat15 = max(u_xlat15, 0.319999993);
    u_xlat15 = u_xlat15 * 2.50002503;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = u_xlat15 + -9.99999975e-05;
    u_xlat3.xyz = vec3(u_xlat15) * vec3(0.220916301, 0.220916301, 0.220916301) + u_xlat16_1.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _LightColor0.xyz;
    u_xlat15 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * vs_TEXCOORD1.xyz;
    u_xlat15 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat18 = dot(u_xlat4.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-u_xlat18) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * -2.98023224e-08 + 0.220916301;
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat15) + u_xlat16_2.xyz;
    u_xlat16_6.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_6.x = u_xlat16_6.x + u_xlat16_6.x;
    u_xlat16_6.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_6.xxx) + (-u_xlat0.xyz);
    u_xlat10_0 = textureLod(unity_SpecCube0, u_xlat16_6.xyz, 6.0);
    u_xlat16_6.x = u_xlat10_0.w + -1.0;
    u_xlat16_6.x = unity_SpecCube0_HDR.w * u_xlat16_6.x + 1.0;
    u_xlat16_6.x = u_xlat16_6.x * unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat10_0.xyz * u_xlat16_6.xxx;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(0.720000029, 0.720000029, 0.720000029);
    u_xlat0.xyz = u_xlat16_6.xyz * u_xlat16_1.xxx + u_xlat3.xyz;
    u_xlat3.xyz = vs_TEXCOORD3.zxy / vs_TEXCOORD3.www;
    u_xlat10_15 = texture(_CustomDepthTexture, u_xlat3.yz).x;
    u_xlat3.x = u_xlat3.x * 0.5 + 0.5;
    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat15 = _ZBufferParams.z * u_xlat10_15 + _ZBufferParams.w;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = (-u_xlat3.x) + u_xlat15;
    u_xlat15 = u_xlat15 / _depthFade.y;
    u_xlat3.x = abs(u_xlat15) + 2.6400001;
    u_xlat15 = abs(u_xlat15) + _depth;
    u_xlat15 = u_xlat15 + 2.6400001;
    u_xlat15 = u_xlat15 * -0.222717166 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x * -0.222717166 + 1.0;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.xyz = u_xlat3.xxx * _Color0.xyz;
    u_xlat4.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
    u_xlat10_4.xyz = texture(_TextureSample0, u_xlat4.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_4.xyz * _fadeColor.xyz;
    u_xlat3.xyz = u_xlat3.xyz * u_xlat16_4.xyz;
    u_xlat3.xyz = vec3(u_xlat15) * _Color1.xyz + u_xlat3.xyz;
    SV_Target0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    SV_Target0.w = _opacity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    vs_TEXCOORD1.xyz = u_xlat2.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat21 = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat21 * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat1 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat4 = u_xlat2.yyyy * u_xlat3;
    u_xlat3 = u_xlat3 * u_xlat3;
    u_xlat3 = u_xlat1 * u_xlat1 + u_xlat3;
    u_xlat1 = u_xlat1 * u_xlat2.xxxx + u_xlat4;
    u_xlat1 = u_xlat0 * u_xlat2.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat3 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat3;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_5.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_5.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_5.x);
    u_xlat16_2 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz * u_xlat1.xyz + u_xlat16_5.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec2 _depthFade;
uniform 	mediump float _depth;
uniform 	mediump vec4 _Color1;
uniform 	mediump vec4 _Color0;
uniform 	vec4 _TextureSample0_ST;
uniform 	mediump vec4 _fadeColor;
uniform 	mediump float _opacity;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _TextureSample0;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_6;
float u_xlat15;
lowp float u_xlat10_15;
float u_xlat18;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD4.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = _Color2.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = u_xlat0.xyz * vec3(u_xlat15) + _WorldSpaceLightPos0.xyz;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = max(u_xlat15, 0.00100000005);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat15 = dot(_WorldSpaceLightPos0.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat15 = max(u_xlat15, 0.319999993);
    u_xlat15 = u_xlat15 * 2.50002503;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = u_xlat15 + -9.99999975e-05;
    u_xlat3.xyz = vec3(u_xlat15) * vec3(0.220916301, 0.220916301, 0.220916301) + u_xlat16_1.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _LightColor0.xyz;
    u_xlat15 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * vs_TEXCOORD1.xyz;
    u_xlat15 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat18 = dot(u_xlat4.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-u_xlat18) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * -2.98023224e-08 + 0.220916301;
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat15) + u_xlat16_2.xyz;
    u_xlat16_6.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_6.x = u_xlat16_6.x + u_xlat16_6.x;
    u_xlat16_6.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_6.xxx) + (-u_xlat0.xyz);
    u_xlat10_0 = textureLod(unity_SpecCube0, u_xlat16_6.xyz, 6.0);
    u_xlat16_6.x = u_xlat10_0.w + -1.0;
    u_xlat16_6.x = unity_SpecCube0_HDR.w * u_xlat16_6.x + 1.0;
    u_xlat16_6.x = u_xlat16_6.x * unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat10_0.xyz * u_xlat16_6.xxx;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(0.720000029, 0.720000029, 0.720000029);
    u_xlat0.xyz = u_xlat16_6.xyz * u_xlat16_1.xxx + u_xlat3.xyz;
    u_xlat3.xyz = vs_TEXCOORD3.zxy / vs_TEXCOORD3.www;
    u_xlat10_15 = texture(_CustomDepthTexture, u_xlat3.yz).x;
    u_xlat3.x = u_xlat3.x * 0.5 + 0.5;
    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat15 = _ZBufferParams.z * u_xlat10_15 + _ZBufferParams.w;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = (-u_xlat3.x) + u_xlat15;
    u_xlat15 = u_xlat15 / _depthFade.y;
    u_xlat3.x = abs(u_xlat15) + 2.6400001;
    u_xlat15 = abs(u_xlat15) + _depth;
    u_xlat15 = u_xlat15 + 2.6400001;
    u_xlat15 = u_xlat15 * -0.222717166 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x * -0.222717166 + 1.0;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.xyz = u_xlat3.xxx * _Color0.xyz;
    u_xlat4.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
    u_xlat10_4.xyz = texture(_TextureSample0, u_xlat4.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_4.xyz * _fadeColor.xyz;
    u_xlat3.xyz = u_xlat3.xyz * u_xlat16_4.xyz;
    u_xlat3.xyz = vec3(u_xlat15) * _Color1.xyz + u_xlat3.xyz;
    SV_Target0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    SV_Target0.w = _opacity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec2 _depthFade;
uniform 	mediump float _depth;
uniform 	mediump vec4 _Color1;
uniform 	mediump vec4 _Color0;
uniform 	vec4 _TextureSample0_ST;
uniform 	mediump vec4 _fadeColor;
uniform 	mediump float _opacity;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _TextureSample0;
uniform highp sampler2D unity_NHxRoughness;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
lowp float u_xlat10_6;
mediump float u_xlat16_12;
float u_xlat18;
mediump float u_xlat16_20;
float u_xlat21;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat10_1 = textureLod(unity_SpecCube0, u_xlat16_1.xyz, 6.0);
    u_xlat16_2.x = u_xlat10_1.w + -1.0;
    u_xlat16_2.x = unity_SpecCube0_HDR.w * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat10_1.xyz * u_xlat16_2.xxx;
    u_xlat18 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = vec3(u_xlat18) * vs_TEXCOORD1.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat21 = u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 + u_xlat18;
    u_xlat0.xyz = u_xlat3.xyz * (-vec3(u_xlat18)) + u_xlat0.xyz;
    u_xlat18 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat18) * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_20 = (-u_xlat21) + 1.0;
    u_xlat16_12 = u_xlat16_20 * u_xlat16_20;
    u_xlat16_12 = u_xlat16_20 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_20 * u_xlat16_12;
    u_xlat16_20 = u_xlat16_12 * -2.98023224e-08 + 0.220916301;
    u_xlat16_2.xyz = vec3(u_xlat16_20) * u_xlat16_2.xyz;
    u_xlat0.y = 1.0;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat0.xy).w;
    u_xlat16_20 = u_xlat0.x * 3.53466082;
    u_xlat16_5.xyz = _Color2.xyz * vec3(0.779083729, 0.779083729, 0.779083729) + vec3(u_xlat16_20);
    u_xlat16_2.xyz = u_xlat16_5.xyz * u_xlat16_4.xyz + u_xlat16_2.xyz;
    u_xlat0.xyz = vs_TEXCOORD3.zxy / vs_TEXCOORD3.www;
    u_xlat10_6 = texture(_CustomDepthTexture, u_xlat0.yz).x;
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat6.x = _ZBufferParams.z * u_xlat10_6 + _ZBufferParams.w;
    u_xlat6.x = float(1.0) / u_xlat6.x;
    u_xlat0.x = (-u_xlat0.x) + u_xlat6.x;
    u_xlat0.x = u_xlat0.x / _depthFade.y;
    u_xlat6.x = abs(u_xlat0.x) + 2.6400001;
    u_xlat0.x = abs(u_xlat0.x) + _depth;
    u_xlat0.x = u_xlat0.x + 2.6400001;
    u_xlat0.x = u_xlat0.x * -0.222717166 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat6.x * -0.222717166 + 1.0;
    u_xlat6.x = max(u_xlat6.x, 0.0);
    u_xlat6.xyz = u_xlat6.xxx * _Color0.xyz;
    u_xlat3.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
    u_xlat10_3.xyz = texture(_TextureSample0, u_xlat3.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_3.xyz * _fadeColor.xyz;
    u_xlat6.xyz = u_xlat6.xyz * u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _Color1.xyz + u_xlat6.xyz;
    SV_Target0.xyz = u_xlat0.xyz + u_xlat16_2.xyz;
    SV_Target0.w = _opacity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec2 _depthFade;
uniform 	mediump float _depth;
uniform 	mediump vec4 _Color1;
uniform 	mediump vec4 _Color0;
uniform 	vec4 _TextureSample0_ST;
uniform 	mediump vec4 _fadeColor;
uniform 	mediump float _opacity;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _TextureSample0;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
lowp vec3 u_xlat10_4;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_18;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat1.xyz);
    u_xlat10_2 = textureLod(unity_SpecCube0, u_xlat16_2.xyz, 6.0);
    u_xlat16_3.x = u_xlat10_2.w + -1.0;
    u_xlat16_3.x = unity_SpecCube0_HDR.w * u_xlat16_3.x + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * unity_SpecCube0_HDR.x;
    u_xlat16_3.xyz = u_xlat10_2.xyz * u_xlat16_3.xxx;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.720000029, 0.720000029, 0.720000029);
    u_xlat15 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * vs_TEXCOORD1.xyz;
    u_xlat15 = dot(u_xlat4.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_18 = (-u_xlat15) + 1.0;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_18 = u_xlat16_18 * -2.98023224e-08 + 0.220916301;
    u_xlat16_3.xyz = vec3(u_xlat16_18) * u_xlat16_3.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = max(u_xlat15, 0.00100000005);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = max(u_xlat0.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * 2.50002503;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = u_xlat0.x * 0.220916301;
    u_xlat0.xyz = _Color2.xyz * vec3(0.779083729, 0.779083729, 0.779083729) + u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx + u_xlat16_3.xyz;
    u_xlat1.xyz = vs_TEXCOORD3.zxy / vs_TEXCOORD3.www;
    u_xlat10_15 = texture(_CustomDepthTexture, u_xlat1.yz).x;
    u_xlat1.x = u_xlat1.x * 0.5 + 0.5;
    u_xlat1.x = _ZBufferParams.z * u_xlat1.x + _ZBufferParams.w;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat15 = _ZBufferParams.z * u_xlat10_15 + _ZBufferParams.w;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = (-u_xlat1.x) + u_xlat15;
    u_xlat15 = u_xlat15 / _depthFade.y;
    u_xlat1.x = abs(u_xlat15) + 2.6400001;
    u_xlat15 = abs(u_xlat15) + _depth;
    u_xlat15 = u_xlat15 + 2.6400001;
    u_xlat15 = u_xlat15 * -0.222717166 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x * -0.222717166 + 1.0;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.xyz = u_xlat1.xxx * _Color0.xyz;
    u_xlat4.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
    u_xlat10_4.xyz = texture(_TextureSample0, u_xlat4.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_4.xyz * _fadeColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat16_4.xyz;
    u_xlat1.xyz = vec3(u_xlat15) * _Color1.xyz + u_xlat1.xyz;
    SV_Target0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    SV_Target0.w = _opacity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec2 _depthFade;
uniform 	mediump float _depth;
uniform 	mediump vec4 _Color1;
uniform 	mediump vec4 _Color0;
uniform 	vec4 _TextureSample0_ST;
uniform 	mediump vec4 _fadeColor;
uniform 	mediump float _opacity;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _TextureSample0;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
lowp vec3 u_xlat10_4;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_18;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat1.xyz);
    u_xlat10_2 = textureLod(unity_SpecCube0, u_xlat16_2.xyz, 6.0);
    u_xlat16_3.x = u_xlat10_2.w + -1.0;
    u_xlat16_3.x = unity_SpecCube0_HDR.w * u_xlat16_3.x + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * unity_SpecCube0_HDR.x;
    u_xlat16_3.xyz = u_xlat10_2.xyz * u_xlat16_3.xxx;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.720000029, 0.720000029, 0.720000029);
    u_xlat15 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * vs_TEXCOORD1.xyz;
    u_xlat15 = dot(u_xlat4.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_18 = (-u_xlat15) + 1.0;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_18 = u_xlat16_18 * -2.98023224e-08 + 0.220916301;
    u_xlat16_3.xyz = vec3(u_xlat16_18) * u_xlat16_3.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = max(u_xlat15, 0.00100000005);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = max(u_xlat0.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * 2.50002503;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = u_xlat0.x * 0.220916301;
    u_xlat0.xyz = _Color2.xyz * vec3(0.779083729, 0.779083729, 0.779083729) + u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx + u_xlat16_3.xyz;
    u_xlat1.xyz = vs_TEXCOORD3.zxy / vs_TEXCOORD3.www;
    u_xlat10_15 = texture(_CustomDepthTexture, u_xlat1.yz).x;
    u_xlat1.x = u_xlat1.x * 0.5 + 0.5;
    u_xlat1.x = _ZBufferParams.z * u_xlat1.x + _ZBufferParams.w;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat15 = _ZBufferParams.z * u_xlat10_15 + _ZBufferParams.w;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = (-u_xlat1.x) + u_xlat15;
    u_xlat15 = u_xlat15 / _depthFade.y;
    u_xlat1.x = abs(u_xlat15) + 2.6400001;
    u_xlat15 = abs(u_xlat15) + _depth;
    u_xlat15 = u_xlat15 + 2.6400001;
    u_xlat15 = u_xlat15 * -0.222717166 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x * -0.222717166 + 1.0;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.xyz = u_xlat1.xxx * _Color0.xyz;
    u_xlat4.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
    u_xlat10_4.xyz = texture(_TextureSample0, u_xlat4.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_4.xyz * _fadeColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat16_4.xyz;
    u_xlat1.xyz = vec3(u_xlat15) * _Color1.xyz + u_xlat1.xyz;
    SV_Target0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    SV_Target0.w = _opacity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat16_3 = u_xlat0.y * u_xlat0.y;
    u_xlat16_3 = u_xlat0.x * u_xlat0.x + (-u_xlat16_3);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec2 _depthFade;
uniform 	mediump float _depth;
uniform 	mediump vec4 _Color1;
uniform 	mediump vec4 _Color0;
uniform 	vec4 _TextureSample0_ST;
uniform 	mediump vec4 _fadeColor;
uniform 	mediump float _opacity;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _TextureSample0;
uniform highp sampler2D unity_NHxRoughness;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
lowp float u_xlat10_7;
float u_xlat21;
mediump float u_xlat16_21;
float u_xlat23;
mediump float u_xlat16_24;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD4.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat2.xyz);
    u_xlat10_1 = textureLod(unity_SpecCube0, u_xlat16_1.xyz, 6.0);
    u_xlat16_3.x = u_xlat10_1.w + -1.0;
    u_xlat16_3.x = unity_SpecCube0_HDR.w * u_xlat16_3.x + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * unity_SpecCube0_HDR.x;
    u_xlat16_3.xyz = u_xlat10_1.xyz * u_xlat16_3.xxx;
    u_xlat21 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = vec3(u_xlat21) * vs_TEXCOORD1.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat23 = u_xlat21;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat2.xyz = u_xlat4.xyz * (-vec3(u_xlat21)) + u_xlat2.xyz;
    u_xlat21 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat21) * _LightColor0.xyz;
    u_xlat21 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat21 = u_xlat21 * u_xlat21;
    u_xlat2.x = u_xlat21 * u_xlat21;
    u_xlat16_24 = (-u_xlat23) + 1.0;
    u_xlat16_21 = u_xlat16_24 * u_xlat16_24;
    u_xlat16_21 = u_xlat16_24 * u_xlat16_21;
    u_xlat16_21 = u_xlat16_24 * u_xlat16_21;
    u_xlat16_24 = u_xlat16_21 * -2.98023224e-08 + 0.220916301;
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_6.xyz = _Color2.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_6.xyz + u_xlat16_3.xyz;
    u_xlat2.y = 1.0;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat2.xy).w;
    u_xlat16_6.xyz = u_xlat0.xxx * vec3(3.53466082, 3.53466082, 3.53466082) + u_xlat16_6.xyz;
    u_xlat16_3.xyz = u_xlat16_6.xyz * u_xlat16_5.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = vs_TEXCOORD3.zxy / vs_TEXCOORD3.www;
    u_xlat10_7 = texture(_CustomDepthTexture, u_xlat0.yz).x;
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat7.x = _ZBufferParams.z * u_xlat10_7 + _ZBufferParams.w;
    u_xlat7.x = float(1.0) / u_xlat7.x;
    u_xlat0.x = (-u_xlat0.x) + u_xlat7.x;
    u_xlat0.x = u_xlat0.x / _depthFade.y;
    u_xlat7.x = abs(u_xlat0.x) + 2.6400001;
    u_xlat0.x = abs(u_xlat0.x) + _depth;
    u_xlat0.x = u_xlat0.x + 2.6400001;
    u_xlat0.x = u_xlat0.x * -0.222717166 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat7.x * -0.222717166 + 1.0;
    u_xlat7.x = max(u_xlat7.x, 0.0);
    u_xlat7.xyz = u_xlat7.xxx * _Color0.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
    u_xlat10_2.xyz = texture(_TextureSample0, u_xlat2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_2.xyz * _fadeColor.xyz;
    u_xlat7.xyz = u_xlat7.xyz * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _Color1.xyz + u_xlat7.xyz;
    SV_Target0.xyz = u_xlat0.xyz + u_xlat16_3.xyz;
    SV_Target0.w = _opacity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat16_3 = u_xlat0.y * u_xlat0.y;
    u_xlat16_3 = u_xlat0.x * u_xlat0.x + (-u_xlat16_3);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec2 _depthFade;
uniform 	mediump float _depth;
uniform 	mediump vec4 _Color1;
uniform 	mediump vec4 _Color0;
uniform 	vec4 _TextureSample0_ST;
uniform 	mediump vec4 _fadeColor;
uniform 	mediump float _opacity;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _TextureSample0;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_6;
float u_xlat15;
lowp float u_xlat10_15;
float u_xlat18;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD4.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = _Color2.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = u_xlat0.xyz * vec3(u_xlat15) + _WorldSpaceLightPos0.xyz;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = max(u_xlat15, 0.00100000005);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat15 = dot(_WorldSpaceLightPos0.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat15 = max(u_xlat15, 0.319999993);
    u_xlat15 = u_xlat15 * 2.50002503;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = u_xlat15 + -9.99999975e-05;
    u_xlat3.xyz = vec3(u_xlat15) * vec3(0.220916301, 0.220916301, 0.220916301) + u_xlat16_1.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _LightColor0.xyz;
    u_xlat15 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * vs_TEXCOORD1.xyz;
    u_xlat15 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat18 = dot(u_xlat4.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-u_xlat18) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * -2.98023224e-08 + 0.220916301;
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat15) + u_xlat16_2.xyz;
    u_xlat16_6.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_6.x = u_xlat16_6.x + u_xlat16_6.x;
    u_xlat16_6.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_6.xxx) + (-u_xlat0.xyz);
    u_xlat10_0 = textureLod(unity_SpecCube0, u_xlat16_6.xyz, 6.0);
    u_xlat16_6.x = u_xlat10_0.w + -1.0;
    u_xlat16_6.x = unity_SpecCube0_HDR.w * u_xlat16_6.x + 1.0;
    u_xlat16_6.x = u_xlat16_6.x * unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat10_0.xyz * u_xlat16_6.xxx;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(0.720000029, 0.720000029, 0.720000029);
    u_xlat0.xyz = u_xlat16_6.xyz * u_xlat16_1.xxx + u_xlat3.xyz;
    u_xlat3.xyz = vs_TEXCOORD3.zxy / vs_TEXCOORD3.www;
    u_xlat10_15 = texture(_CustomDepthTexture, u_xlat3.yz).x;
    u_xlat3.x = u_xlat3.x * 0.5 + 0.5;
    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat15 = _ZBufferParams.z * u_xlat10_15 + _ZBufferParams.w;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = (-u_xlat3.x) + u_xlat15;
    u_xlat15 = u_xlat15 / _depthFade.y;
    u_xlat3.x = abs(u_xlat15) + 2.6400001;
    u_xlat15 = abs(u_xlat15) + _depth;
    u_xlat15 = u_xlat15 + 2.6400001;
    u_xlat15 = u_xlat15 * -0.222717166 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x * -0.222717166 + 1.0;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.xyz = u_xlat3.xxx * _Color0.xyz;
    u_xlat4.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
    u_xlat10_4.xyz = texture(_TextureSample0, u_xlat4.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_4.xyz * _fadeColor.xyz;
    u_xlat3.xyz = u_xlat3.xyz * u_xlat16_4.xyz;
    u_xlat3.xyz = vec3(u_xlat15) * _Color1.xyz + u_xlat3.xyz;
    SV_Target0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    SV_Target0.w = _opacity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat16_3 = u_xlat0.y * u_xlat0.y;
    u_xlat16_3 = u_xlat0.x * u_xlat0.x + (-u_xlat16_3);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec2 _depthFade;
uniform 	mediump float _depth;
uniform 	mediump vec4 _Color1;
uniform 	mediump vec4 _Color0;
uniform 	vec4 _TextureSample0_ST;
uniform 	mediump vec4 _fadeColor;
uniform 	mediump float _opacity;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _TextureSample0;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_6;
float u_xlat15;
lowp float u_xlat10_15;
float u_xlat18;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD4.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = _Color2.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = u_xlat0.xyz * vec3(u_xlat15) + _WorldSpaceLightPos0.xyz;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = max(u_xlat15, 0.00100000005);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat15 = dot(_WorldSpaceLightPos0.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat15 = max(u_xlat15, 0.319999993);
    u_xlat15 = u_xlat15 * 2.50002503;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = u_xlat15 + -9.99999975e-05;
    u_xlat3.xyz = vec3(u_xlat15) * vec3(0.220916301, 0.220916301, 0.220916301) + u_xlat16_1.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _LightColor0.xyz;
    u_xlat15 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * vs_TEXCOORD1.xyz;
    u_xlat15 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat18 = dot(u_xlat4.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-u_xlat18) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * -2.98023224e-08 + 0.220916301;
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat15) + u_xlat16_2.xyz;
    u_xlat16_6.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_6.x = u_xlat16_6.x + u_xlat16_6.x;
    u_xlat16_6.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_6.xxx) + (-u_xlat0.xyz);
    u_xlat10_0 = textureLod(unity_SpecCube0, u_xlat16_6.xyz, 6.0);
    u_xlat16_6.x = u_xlat10_0.w + -1.0;
    u_xlat16_6.x = unity_SpecCube0_HDR.w * u_xlat16_6.x + 1.0;
    u_xlat16_6.x = u_xlat16_6.x * unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat10_0.xyz * u_xlat16_6.xxx;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(0.720000029, 0.720000029, 0.720000029);
    u_xlat0.xyz = u_xlat16_6.xyz * u_xlat16_1.xxx + u_xlat3.xyz;
    u_xlat3.xyz = vs_TEXCOORD3.zxy / vs_TEXCOORD3.www;
    u_xlat10_15 = texture(_CustomDepthTexture, u_xlat3.yz).x;
    u_xlat3.x = u_xlat3.x * 0.5 + 0.5;
    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat15 = _ZBufferParams.z * u_xlat10_15 + _ZBufferParams.w;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = (-u_xlat3.x) + u_xlat15;
    u_xlat15 = u_xlat15 / _depthFade.y;
    u_xlat3.x = abs(u_xlat15) + 2.6400001;
    u_xlat15 = abs(u_xlat15) + _depth;
    u_xlat15 = u_xlat15 + 2.6400001;
    u_xlat15 = u_xlat15 * -0.222717166 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x * -0.222717166 + 1.0;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.xyz = u_xlat3.xxx * _Color0.xyz;
    u_xlat4.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
    u_xlat10_4.xyz = texture(_TextureSample0, u_xlat4.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_4.xyz * _fadeColor.xyz;
    u_xlat3.xyz = u_xlat3.xyz * u_xlat16_4.xyz;
    u_xlat3.xyz = vec3(u_xlat15) * _Color1.xyz + u_xlat3.xyz;
    SV_Target0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    SV_Target0.w = _opacity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.xyz = u_xlat2.xyz;
    vs_TEXCOORD2.xyz = u_xlat7.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat0.x * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat1 = (-u_xlat7.xxxx) + unity_4LightPosX0;
    u_xlat3 = (-u_xlat7.yyyy) + unity_4LightPosY0;
    u_xlat0 = (-u_xlat7.zzzz) + unity_4LightPosZ0;
    u_xlat4 = u_xlat2.yyyy * u_xlat3;
    u_xlat3 = u_xlat3 * u_xlat3;
    u_xlat3 = u_xlat1 * u_xlat1 + u_xlat3;
    u_xlat1 = u_xlat1 * u_xlat2.xxxx + u_xlat4;
    u_xlat1 = u_xlat0 * u_xlat2.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat3 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat3;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_5.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_5.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_5.x);
    u_xlat16_2 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz * u_xlat1.xyz + u_xlat16_5.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec2 _depthFade;
uniform 	mediump float _depth;
uniform 	mediump vec4 _Color1;
uniform 	mediump vec4 _Color0;
uniform 	vec4 _TextureSample0_ST;
uniform 	mediump vec4 _fadeColor;
uniform 	mediump float _opacity;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _TextureSample0;
uniform highp sampler2D unity_NHxRoughness;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
lowp float u_xlat10_7;
float u_xlat21;
mediump float u_xlat16_21;
float u_xlat23;
mediump float u_xlat16_24;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD4.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat2.xyz);
    u_xlat10_1 = textureLod(unity_SpecCube0, u_xlat16_1.xyz, 6.0);
    u_xlat16_3.x = u_xlat10_1.w + -1.0;
    u_xlat16_3.x = unity_SpecCube0_HDR.w * u_xlat16_3.x + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * unity_SpecCube0_HDR.x;
    u_xlat16_3.xyz = u_xlat10_1.xyz * u_xlat16_3.xxx;
    u_xlat21 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = vec3(u_xlat21) * vs_TEXCOORD1.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat4.xyz);
    u_xlat23 = u_xlat21;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat2.xyz = u_xlat4.xyz * (-vec3(u_xlat21)) + u_xlat2.xyz;
    u_xlat21 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat21) * _LightColor0.xyz;
    u_xlat21 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat21 = u_xlat21 * u_xlat21;
    u_xlat2.x = u_xlat21 * u_xlat21;
    u_xlat16_24 = (-u_xlat23) + 1.0;
    u_xlat16_21 = u_xlat16_24 * u_xlat16_24;
    u_xlat16_21 = u_xlat16_24 * u_xlat16_21;
    u_xlat16_21 = u_xlat16_24 * u_xlat16_21;
    u_xlat16_24 = u_xlat16_21 * -2.98023224e-08 + 0.220916301;
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_6.xyz = _Color2.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_6.xyz + u_xlat16_3.xyz;
    u_xlat2.y = 1.0;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat2.xy).w;
    u_xlat16_6.xyz = u_xlat0.xxx * vec3(3.53466082, 3.53466082, 3.53466082) + u_xlat16_6.xyz;
    u_xlat16_3.xyz = u_xlat16_6.xyz * u_xlat16_5.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = vs_TEXCOORD3.zxy / vs_TEXCOORD3.www;
    u_xlat10_7 = texture(_CustomDepthTexture, u_xlat0.yz).x;
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat7.x = _ZBufferParams.z * u_xlat10_7 + _ZBufferParams.w;
    u_xlat7.x = float(1.0) / u_xlat7.x;
    u_xlat0.x = (-u_xlat0.x) + u_xlat7.x;
    u_xlat0.x = u_xlat0.x / _depthFade.y;
    u_xlat7.x = abs(u_xlat0.x) + 2.6400001;
    u_xlat0.x = abs(u_xlat0.x) + _depth;
    u_xlat0.x = u_xlat0.x + 2.6400001;
    u_xlat0.x = u_xlat0.x * -0.222717166 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat7.x * -0.222717166 + 1.0;
    u_xlat7.x = max(u_xlat7.x, 0.0);
    u_xlat7.xyz = u_xlat7.xxx * _Color0.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
    u_xlat10_2.xyz = texture(_TextureSample0, u_xlat2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_2.xyz * _fadeColor.xyz;
    u_xlat7.xyz = u_xlat7.xyz * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _Color1.xyz + u_xlat7.xyz;
    SV_Target0.xyz = u_xlat0.xyz + u_xlat16_3.xyz;
    SV_Target0.w = _opacity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.xyz = u_xlat2.xyz;
    vs_TEXCOORD2.xyz = u_xlat7.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat0.x * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat1 = (-u_xlat7.xxxx) + unity_4LightPosX0;
    u_xlat3 = (-u_xlat7.yyyy) + unity_4LightPosY0;
    u_xlat0 = (-u_xlat7.zzzz) + unity_4LightPosZ0;
    u_xlat4 = u_xlat2.yyyy * u_xlat3;
    u_xlat3 = u_xlat3 * u_xlat3;
    u_xlat3 = u_xlat1 * u_xlat1 + u_xlat3;
    u_xlat1 = u_xlat1 * u_xlat2.xxxx + u_xlat4;
    u_xlat1 = u_xlat0 * u_xlat2.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat3 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat3;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_5.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_5.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_5.x);
    u_xlat16_2 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz * u_xlat1.xyz + u_xlat16_5.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec2 _depthFade;
uniform 	mediump float _depth;
uniform 	mediump vec4 _Color1;
uniform 	mediump vec4 _Color0;
uniform 	vec4 _TextureSample0_ST;
uniform 	mediump vec4 _fadeColor;
uniform 	mediump float _opacity;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _TextureSample0;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_6;
float u_xlat15;
lowp float u_xlat10_15;
float u_xlat18;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD4.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = _Color2.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = u_xlat0.xyz * vec3(u_xlat15) + _WorldSpaceLightPos0.xyz;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = max(u_xlat15, 0.00100000005);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat15 = dot(_WorldSpaceLightPos0.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat15 = max(u_xlat15, 0.319999993);
    u_xlat15 = u_xlat15 * 2.50002503;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = u_xlat15 + -9.99999975e-05;
    u_xlat3.xyz = vec3(u_xlat15) * vec3(0.220916301, 0.220916301, 0.220916301) + u_xlat16_1.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _LightColor0.xyz;
    u_xlat15 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * vs_TEXCOORD1.xyz;
    u_xlat15 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat18 = dot(u_xlat4.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-u_xlat18) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * -2.98023224e-08 + 0.220916301;
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat15) + u_xlat16_2.xyz;
    u_xlat16_6.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_6.x = u_xlat16_6.x + u_xlat16_6.x;
    u_xlat16_6.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_6.xxx) + (-u_xlat0.xyz);
    u_xlat10_0 = textureLod(unity_SpecCube0, u_xlat16_6.xyz, 6.0);
    u_xlat16_6.x = u_xlat10_0.w + -1.0;
    u_xlat16_6.x = unity_SpecCube0_HDR.w * u_xlat16_6.x + 1.0;
    u_xlat16_6.x = u_xlat16_6.x * unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat10_0.xyz * u_xlat16_6.xxx;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(0.720000029, 0.720000029, 0.720000029);
    u_xlat0.xyz = u_xlat16_6.xyz * u_xlat16_1.xxx + u_xlat3.xyz;
    u_xlat3.xyz = vs_TEXCOORD3.zxy / vs_TEXCOORD3.www;
    u_xlat10_15 = texture(_CustomDepthTexture, u_xlat3.yz).x;
    u_xlat3.x = u_xlat3.x * 0.5 + 0.5;
    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat15 = _ZBufferParams.z * u_xlat10_15 + _ZBufferParams.w;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = (-u_xlat3.x) + u_xlat15;
    u_xlat15 = u_xlat15 / _depthFade.y;
    u_xlat3.x = abs(u_xlat15) + 2.6400001;
    u_xlat15 = abs(u_xlat15) + _depth;
    u_xlat15 = u_xlat15 + 2.6400001;
    u_xlat15 = u_xlat15 * -0.222717166 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x * -0.222717166 + 1.0;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.xyz = u_xlat3.xxx * _Color0.xyz;
    u_xlat4.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
    u_xlat10_4.xyz = texture(_TextureSample0, u_xlat4.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_4.xyz * _fadeColor.xyz;
    u_xlat3.xyz = u_xlat3.xyz * u_xlat16_4.xyz;
    u_xlat3.xyz = vec3(u_xlat15) * _Color1.xyz + u_xlat3.xyz;
    SV_Target0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    SV_Target0.w = _opacity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.xyz = u_xlat2.xyz;
    vs_TEXCOORD2.xyz = u_xlat7.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat0.x * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat1 = (-u_xlat7.xxxx) + unity_4LightPosX0;
    u_xlat3 = (-u_xlat7.yyyy) + unity_4LightPosY0;
    u_xlat0 = (-u_xlat7.zzzz) + unity_4LightPosZ0;
    u_xlat4 = u_xlat2.yyyy * u_xlat3;
    u_xlat3 = u_xlat3 * u_xlat3;
    u_xlat3 = u_xlat1 * u_xlat1 + u_xlat3;
    u_xlat1 = u_xlat1 * u_xlat2.xxxx + u_xlat4;
    u_xlat1 = u_xlat0 * u_xlat2.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat3 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat3;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_5.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_5.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_5.x);
    u_xlat16_2 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz * u_xlat1.xyz + u_xlat16_5.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec2 _depthFade;
uniform 	mediump float _depth;
uniform 	mediump vec4 _Color1;
uniform 	mediump vec4 _Color0;
uniform 	vec4 _TextureSample0_ST;
uniform 	mediump vec4 _fadeColor;
uniform 	mediump float _opacity;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _TextureSample0;
uniform lowp samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_6;
float u_xlat15;
lowp float u_xlat10_15;
float u_xlat18;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD4.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = _Color2.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = u_xlat0.xyz * vec3(u_xlat15) + _WorldSpaceLightPos0.xyz;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = max(u_xlat15, 0.00100000005);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat15 = dot(_WorldSpaceLightPos0.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat15 = max(u_xlat15, 0.319999993);
    u_xlat15 = u_xlat15 * 2.50002503;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = u_xlat15 + -9.99999975e-05;
    u_xlat3.xyz = vec3(u_xlat15) * vec3(0.220916301, 0.220916301, 0.220916301) + u_xlat16_1.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _LightColor0.xyz;
    u_xlat15 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * vs_TEXCOORD1.xyz;
    u_xlat15 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat18 = dot(u_xlat4.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-u_xlat18) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * -2.98023224e-08 + 0.220916301;
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat15) + u_xlat16_2.xyz;
    u_xlat16_6.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_6.x = u_xlat16_6.x + u_xlat16_6.x;
    u_xlat16_6.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_6.xxx) + (-u_xlat0.xyz);
    u_xlat10_0 = textureLod(unity_SpecCube0, u_xlat16_6.xyz, 6.0);
    u_xlat16_6.x = u_xlat10_0.w + -1.0;
    u_xlat16_6.x = unity_SpecCube0_HDR.w * u_xlat16_6.x + 1.0;
    u_xlat16_6.x = u_xlat16_6.x * unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat10_0.xyz * u_xlat16_6.xxx;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(0.720000029, 0.720000029, 0.720000029);
    u_xlat0.xyz = u_xlat16_6.xyz * u_xlat16_1.xxx + u_xlat3.xyz;
    u_xlat3.xyz = vs_TEXCOORD3.zxy / vs_TEXCOORD3.www;
    u_xlat10_15 = texture(_CustomDepthTexture, u_xlat3.yz).x;
    u_xlat3.x = u_xlat3.x * 0.5 + 0.5;
    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat15 = _ZBufferParams.z * u_xlat10_15 + _ZBufferParams.w;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = (-u_xlat3.x) + u_xlat15;
    u_xlat15 = u_xlat15 / _depthFade.y;
    u_xlat3.x = abs(u_xlat15) + 2.6400001;
    u_xlat15 = abs(u_xlat15) + _depth;
    u_xlat15 = u_xlat15 + 2.6400001;
    u_xlat15 = u_xlat15 * -0.222717166 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x * -0.222717166 + 1.0;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.xyz = u_xlat3.xxx * _Color0.xyz;
    u_xlat4.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
    u_xlat10_4.xyz = texture(_TextureSample0, u_xlat4.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_4.xyz * _fadeColor.xyz;
    u_xlat3.xyz = u_xlat3.xyz * u_xlat16_4.xyz;
    u_xlat3.xyz = vec3(u_xlat15) * _Color1.xyz + u_xlat3.xyz;
    SV_Target0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    SV_Target0.w = _opacity;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "INSTANCING_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "INSTANCING_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "INSTANCING_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "INSTANCING_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "INSTANCING_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "INSTANCING_ON" }
""
}
}
}
 Pass {
  Name "FORWARD"
  Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "LIGHTMODE" = "FORWARDADD" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 120218
Program "vp" {
SubProgram "gles3 " {
Keywords { "POINT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD0.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	mediump vec4 _Color2;
uniform 	mediump float _opacity;
uniform highp sampler2D _LightTexture0;
uniform highp sampler2D unity_NHxRoughness;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
float u_xlat15;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * vs_TEXCOORD0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat1.xyz * (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat5 = dot(u_xlat1.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat1.y = 1.0;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat1.xy).w;
    u_xlat16_3.x = u_xlat0.x * 3.53466082;
    u_xlat16_3.xyz = _Color2.xyz * vec3(0.779083729, 0.779083729, 0.779083729) + u_xlat16_3.xxx;
    u_xlat0.xzw = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat0.xzw = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat0.xzw;
    u_xlat0.xzw = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = texture(_LightTexture0, u_xlat0.xx).w;
    u_xlat16_4.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat16_4.xyz = vec3(u_xlat5) * u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    SV_Target0.w = _opacity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "POINT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD0.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	mediump vec4 _Color2;
uniform 	mediump float _opacity;
uniform highp sampler2D _LightTexture0;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat12;
float u_xlat13;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + u_xlat1.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = max(u_xlat12, 0.00100000005);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = max(u_xlat0.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * 2.50002503;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = u_xlat0.x * 0.220916301;
    u_xlat0.xyz = _Color2.xyz * vec3(0.779083729, 0.779083729, 0.779083729) + u_xlat0.xxx;
    u_xlat2.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = texture(_LightTexture0, vec2(u_xlat12)).w;
    u_xlat16_3.xyz = vec3(u_xlat12) * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    u_xlat12 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * vs_TEXCOORD0.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _opacity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "POINT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD0.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	mediump vec4 _Color2;
uniform 	mediump float _opacity;
uniform highp sampler2D _LightTexture0;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat12;
float u_xlat13;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + u_xlat1.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = max(u_xlat12, 0.00100000005);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = max(u_xlat0.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * 2.50002503;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = u_xlat0.x * 0.220916301;
    u_xlat0.xyz = _Color2.xyz * vec3(0.779083729, 0.779083729, 0.779083729) + u_xlat0.xxx;
    u_xlat2.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = texture(_LightTexture0, vec2(u_xlat12)).w;
    u_xlat16_3.xyz = vec3(u_xlat12) * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    u_xlat12 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * vs_TEXCOORD0.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _opacity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD0.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color2;
uniform 	mediump float _opacity;
uniform highp sampler2D unity_NHxRoughness;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
mediump float u_xlat16_14;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat12 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD0.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat1.xyz * (-vec3(u_xlat12)) + u_xlat0.xyz;
    u_xlat12 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat12) * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.y = 1.0;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat0.xy).w;
    u_xlat16_14 = u_xlat0.x * 3.53466082;
    u_xlat16_3.xyz = _Color2.xyz * vec3(0.779083729, 0.779083729, 0.779083729) + vec3(u_xlat16_14);
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _opacity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD0.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color2;
uniform 	mediump float _opacity;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6) + _WorldSpaceLightPos0.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = max(u_xlat6, 0.00100000005);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = max(u_xlat0.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * 2.50002503;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = u_xlat0.x * 0.220916301;
    u_xlat0.xyz = _Color2.xyz * vec3(0.779083729, 0.779083729, 0.779083729) + u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat6 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD0.xyz;
    u_xlat6 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _opacity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD0.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color2;
uniform 	mediump float _opacity;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6) + _WorldSpaceLightPos0.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = max(u_xlat6, 0.00100000005);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = max(u_xlat0.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * 2.50002503;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = u_xlat0.x * 0.220916301;
    u_xlat0.xyz = _Color2.xyz * vec3(0.779083729, 0.779083729, 0.779083729) + u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat6 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD0.xyz;
    u_xlat6 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _opacity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SPOT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD0.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	mediump vec4 _Color2;
uniform 	mediump float _opacity;
uniform highp sampler2D _LightTexture0;
uniform highp sampler2D _LightTextureB0;
uniform highp sampler2D unity_NHxRoughness;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
bool u_xlatb10;
float u_xlat15;
mediump float u_xlat16_18;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * vs_TEXCOORD0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat1.xyz * (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat5 = dot(u_xlat1.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat1.y = 1.0;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat1.xy).w;
    u_xlat16_3.x = u_xlat0.x * 3.53466082;
    u_xlat16_3.xyz = _Color2.xyz * vec3(0.779083729, 0.779083729, 0.779083729) + u_xlat16_3.xxx;
    u_xlat1 = vs_TEXCOORD1.yyyy * hlslcc_mtx4x4unity_WorldToLight[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToLight[0] * vs_TEXCOORD1.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToLight[2] * vs_TEXCOORD1.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_WorldToLight[3];
    u_xlat0.xz = u_xlat1.xy / u_xlat1.ww;
    u_xlat0.xz = u_xlat0.xz + vec2(0.5, 0.5);
    u_xlat0.x = texture(_LightTexture0, u_xlat0.xz).w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<u_xlat1.z);
#else
    u_xlatb10 = 0.0<u_xlat1.z;
#endif
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = texture(_LightTextureB0, vec2(u_xlat15)).w;
    u_xlat16_18 = (u_xlatb10) ? 1.0 : 0.0;
    u_xlat16_18 = u_xlat0.x * u_xlat16_18;
    u_xlat16_18 = u_xlat15 * u_xlat16_18;
    u_xlat16_4.xyz = vec3(u_xlat16_18) * _LightColor0.xyz;
    u_xlat16_4.xyz = vec3(u_xlat5) * u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    SV_Target0.w = _opacity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPOT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD0.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	mediump vec4 _Color2;
uniform 	mediump float _opacity;
uniform highp sampler2D _LightTexture0;
uniform highp sampler2D _LightTextureB0;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
float u_xlat12;
float u_xlat13;
void main()
{
    u_xlat0 = vs_TEXCOORD1.yyyy * hlslcc_mtx4x4unity_WorldToLight[1];
    u_xlat0 = hlslcc_mtx4x4unity_WorldToLight[0] * vs_TEXCOORD1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToLight[2] * vs_TEXCOORD1.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToLight[3];
    u_xlat1.xy = u_xlat0.xy / u_xlat0.ww;
    u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
    u_xlat12 = texture(_LightTexture0, u_xlat1.xy).w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.0<u_xlat0.z);
#else
    u_xlatb1 = 0.0<u_xlat0.z;
#endif
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = texture(_LightTextureB0, u_xlat0.xx).w;
    u_xlat16_2.x = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat16_2.x = u_xlat12 * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + u_xlat1.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = max(u_xlat12, 0.00100000005);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = max(u_xlat0.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * 2.50002503;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = u_xlat0.x * 0.220916301;
    u_xlat0.xyz = _Color2.xyz * vec3(0.779083729, 0.779083729, 0.779083729) + u_xlat0.xxx;
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat0.xyz;
    u_xlat12 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * vs_TEXCOORD0.xyz;
    u_xlat12 = dot(u_xlat3.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _opacity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPOT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD0.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	mediump vec4 _Color2;
uniform 	mediump float _opacity;
uniform highp sampler2D _LightTexture0;
uniform highp sampler2D _LightTextureB0;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
float u_xlat12;
float u_xlat13;
void main()
{
    u_xlat0 = vs_TEXCOORD1.yyyy * hlslcc_mtx4x4unity_WorldToLight[1];
    u_xlat0 = hlslcc_mtx4x4unity_WorldToLight[0] * vs_TEXCOORD1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToLight[2] * vs_TEXCOORD1.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToLight[3];
    u_xlat1.xy = u_xlat0.xy / u_xlat0.ww;
    u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
    u_xlat12 = texture(_LightTexture0, u_xlat1.xy).w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.0<u_xlat0.z);
#else
    u_xlatb1 = 0.0<u_xlat0.z;
#endif
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = texture(_LightTextureB0, u_xlat0.xx).w;
    u_xlat16_2.x = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat16_2.x = u_xlat12 * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + u_xlat1.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = max(u_xlat12, 0.00100000005);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = max(u_xlat0.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * 2.50002503;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = u_xlat0.x * 0.220916301;
    u_xlat0.xyz = _Color2.xyz * vec3(0.779083729, 0.779083729, 0.779083729) + u_xlat0.xxx;
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat0.xyz;
    u_xlat12 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * vs_TEXCOORD0.xyz;
    u_xlat12 = dot(u_xlat3.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _opacity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "POINT_COOKIE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD0.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	mediump vec4 _Color2;
uniform 	mediump float _opacity;
uniform highp sampler2D _LightTextureB0;
uniform highp samplerCube _LightTexture0;
uniform highp sampler2D unity_NHxRoughness;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
float u_xlat10;
float u_xlat15;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * vs_TEXCOORD0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat1.xyz * (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat5 = dot(u_xlat1.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat1.y = 1.0;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat1.xy).w;
    u_xlat16_3.x = u_xlat0.x * 3.53466082;
    u_xlat16_3.xyz = _Color2.xyz * vec3(0.779083729, 0.779083729, 0.779083729) + u_xlat16_3.xxx;
    u_xlat0.xzw = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat0.xzw = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat0.xzw;
    u_xlat0.xzw = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
    u_xlat1.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = texture(_LightTexture0, u_xlat0.xzw).w;
    u_xlat10 = texture(_LightTextureB0, u_xlat1.xx).w;
    u_xlat0.x = u_xlat0.x * u_xlat10;
    u_xlat16_4.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat16_4.xyz = vec3(u_xlat5) * u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    SV_Target0.w = _opacity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "POINT_COOKIE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD0.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	mediump vec4 _Color2;
uniform 	mediump float _opacity;
uniform highp sampler2D _LightTextureB0;
uniform highp samplerCube _LightTexture0;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
float u_xlat12;
float u_xlat14;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = texture(_LightTexture0, u_xlat0.xyz).w;
    u_xlat4 = texture(_LightTextureB0, vec2(u_xlat12)).w;
    u_xlat0.x = u_xlat0.x * u_xlat4;
    u_xlat16_1.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + u_xlat2.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = max(u_xlat12, 0.00100000005);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = max(u_xlat0.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * 2.50002503;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = u_xlat0.x * 0.220916301;
    u_xlat0.xyz = _Color2.xyz * vec3(0.779083729, 0.779083729, 0.779083729) + u_xlat0.xxx;
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xyz;
    u_xlat12 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * vs_TEXCOORD0.xyz;
    u_xlat12 = dot(u_xlat3.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _opacity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "POINT_COOKIE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD0.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	mediump vec4 _Color2;
uniform 	mediump float _opacity;
uniform highp sampler2D _LightTextureB0;
uniform highp samplerCube _LightTexture0;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
float u_xlat12;
float u_xlat14;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = texture(_LightTexture0, u_xlat0.xyz).w;
    u_xlat4 = texture(_LightTextureB0, vec2(u_xlat12)).w;
    u_xlat0.x = u_xlat0.x * u_xlat4;
    u_xlat16_1.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + u_xlat2.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = max(u_xlat12, 0.00100000005);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = max(u_xlat0.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * 2.50002503;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = u_xlat0.x * 0.220916301;
    u_xlat0.xyz = _Color2.xyz * vec3(0.779083729, 0.779083729, 0.779083729) + u_xlat0.xxx;
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xyz;
    u_xlat12 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * vs_TEXCOORD0.xyz;
    u_xlat12 = dot(u_xlat3.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _opacity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD0.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	mediump vec4 _Color2;
uniform 	mediump float _opacity;
uniform highp sampler2D _LightTexture0;
uniform highp sampler2D unity_NHxRoughness;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat12 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD0.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat1.xyz * (-vec3(u_xlat12)) + u_xlat0.xyz;
    u_xlat12 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.y = 1.0;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat0.xy).w;
    u_xlat16_2.x = u_xlat0.x * 3.53466082;
    u_xlat16_2.xyz = _Color2.xyz * vec3(0.779083729, 0.779083729, 0.779083729) + u_xlat16_2.xxx;
    u_xlat0.xy = vs_TEXCOORD1.yy * hlslcc_mtx4x4unity_WorldToLight[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[0].xy * vs_TEXCOORD1.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[2].xy * vs_TEXCOORD1.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToLight[3].xy;
    u_xlat0.x = texture(_LightTexture0, u_xlat0.xy).w;
    u_xlat16_3.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat16_3.xyz = vec3(u_xlat12) * u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _opacity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD0.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	mediump vec4 _Color2;
uniform 	mediump float _opacity;
uniform highp sampler2D _LightTexture0;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9) + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = max(u_xlat9, 0.00100000005);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = max(u_xlat0.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * 2.50002503;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = u_xlat0.x * 0.220916301;
    u_xlat0.xyz = _Color2.xyz * vec3(0.779083729, 0.779083729, 0.779083729) + u_xlat0.xxx;
    u_xlat1.xy = vs_TEXCOORD1.yy * hlslcc_mtx4x4unity_WorldToLight[1].xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToLight[0].xy * vs_TEXCOORD1.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToLight[2].xy * vs_TEXCOORD1.zz + u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy + hlslcc_mtx4x4unity_WorldToLight[3].xy;
    u_xlat9 = texture(_LightTexture0, u_xlat1.xy).w;
    u_xlat16_2.xyz = vec3(u_xlat9) * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_2.xyz;
    u_xlat9 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD0.xyz;
    u_xlat9 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _opacity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD0.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	mediump vec4 _Color2;
uniform 	mediump float _opacity;
uniform highp sampler2D _LightTexture0;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9) + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = max(u_xlat9, 0.00100000005);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = max(u_xlat0.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * 2.50002503;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = u_xlat0.x * 0.220916301;
    u_xlat0.xyz = _Color2.xyz * vec3(0.779083729, 0.779083729, 0.779083729) + u_xlat0.xxx;
    u_xlat1.xy = vs_TEXCOORD1.yy * hlslcc_mtx4x4unity_WorldToLight[1].xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToLight[0].xy * vs_TEXCOORD1.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToLight[2].xy * vs_TEXCOORD1.zz + u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy + hlslcc_mtx4x4unity_WorldToLight[3].xy;
    u_xlat9 = texture(_LightTexture0, u_xlat1.xy).w;
    u_xlat16_2.xyz = vec3(u_xlat9) * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_2.xyz;
    u_xlat9 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD0.xyz;
    u_xlat9 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _opacity;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "POINT" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "POINT" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "POINT" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPOT" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPOT" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPOT" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "POINT_COOKIE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "POINT_COOKIE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "POINT_COOKIE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL_COOKIE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" }
""
}
}
}
 Pass {
  Name "META"
  Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "LIGHTMODE" = "META" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 136478
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	bvec4 unity_MetaVertexControl;
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb6;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<in_POSITION0.z);
#else
    u_xlatb0 = 0.0<in_POSITION0.z;
#endif
    u_xlat0.z = u_xlatb0 ? 9.99999975e-05 : float(0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat0.xyz = (unity_MetaVertexControl.x) ? u_xlat0.xyz : in_POSITION0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.0<u_xlat0.z);
#else
    u_xlatb6 = 0.0<u_xlat0.z;
#endif
    u_xlat1.z = u_xlatb6 ? 9.99999975e-05 : float(0.0);
    u_xlat1.xy = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
    u_xlat0.xyz = (unity_MetaVertexControl.y) ? u_xlat1.xyz : u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat0.x * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec2 _depthFade;
uniform 	mediump float _depth;
uniform 	mediump vec4 _Color1;
uniform 	mediump vec4 _Color0;
uniform 	vec4 _TextureSample0_ST;
uniform 	mediump vec4 _fadeColor;
uniform 	bvec4 unity_MetaFragmentControl;
uniform 	float unity_OneOverOutputBoost;
uniform 	float unity_MaxOutputValue;
uniform 	float unity_UseLinearSpace;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _TextureSample0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp float u_xlat10_2;
mediump vec3 u_xlat16_3;
bool u_xlatb6;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD2.zxy / vs_TEXCOORD2.www;
    u_xlat10_2 = texture(_CustomDepthTexture, u_xlat0.yz).x;
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat2.x = _ZBufferParams.z * u_xlat10_2 + _ZBufferParams.w;
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat0.x = (-u_xlat0.x) + u_xlat2.x;
    u_xlat0.x = u_xlat0.x / _depthFade.y;
    u_xlat2.x = abs(u_xlat0.x) + 2.6400001;
    u_xlat0.x = abs(u_xlat0.x) + _depth;
    u_xlat0.x = u_xlat0.x + 2.6400001;
    u_xlat0.x = u_xlat0.x * -0.222717166 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x * -0.222717166 + 1.0;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.xyz = u_xlat2.xxx * _Color0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
    u_xlat10_1.xyz = texture(_TextureSample0, u_xlat1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz * _fadeColor.xyz;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _Color1.xyz + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_UseLinearSpace));
#else
    u_xlatb6 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_UseLinearSpace);
#endif
    u_xlat16_0.xyz = (bool(u_xlatb6)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat1.x = unity_OneOverOutputBoost;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = log2(_Color2.xyz);
    u_xlat1.xyz = u_xlat16_3.xyz * u_xlat1.xxx;
    u_xlat1.xyz = exp2(u_xlat1.xyz);
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(unity_MaxOutputValue, unity_MaxOutputValue, unity_MaxOutputValue)));
    u_xlat16_1.xyz = (unity_MetaFragmentControl.x) ? u_xlat1.xyz : vec3(0.0, 0.0, 0.0);
    u_xlat16_1.w = (unity_MetaFragmentControl.x) ? 1.0 : 0.0;
    u_xlat16_0.w = 1.0;
    SV_Target0 = (unity_MetaFragmentControl.y) ? u_xlat16_0 : u_xlat16_1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	bvec4 unity_MetaVertexControl;
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb6;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<in_POSITION0.z);
#else
    u_xlatb0 = 0.0<in_POSITION0.z;
#endif
    u_xlat0.z = u_xlatb0 ? 9.99999975e-05 : float(0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat0.xyz = (unity_MetaVertexControl.x) ? u_xlat0.xyz : in_POSITION0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.0<u_xlat0.z);
#else
    u_xlatb6 = 0.0<u_xlat0.z;
#endif
    u_xlat1.z = u_xlatb6 ? 9.99999975e-05 : float(0.0);
    u_xlat1.xy = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
    u_xlat0.xyz = (unity_MetaVertexControl.y) ? u_xlat1.xyz : u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat0.x * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec2 _depthFade;
uniform 	mediump float _depth;
uniform 	mediump vec4 _Color1;
uniform 	mediump vec4 _Color0;
uniform 	vec4 _TextureSample0_ST;
uniform 	mediump vec4 _fadeColor;
uniform 	bvec4 unity_MetaFragmentControl;
uniform 	float unity_OneOverOutputBoost;
uniform 	float unity_MaxOutputValue;
uniform 	float unity_UseLinearSpace;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _TextureSample0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp float u_xlat10_2;
mediump vec3 u_xlat16_3;
bool u_xlatb6;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD2.zxy / vs_TEXCOORD2.www;
    u_xlat10_2 = texture(_CustomDepthTexture, u_xlat0.yz).x;
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat2.x = _ZBufferParams.z * u_xlat10_2 + _ZBufferParams.w;
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat0.x = (-u_xlat0.x) + u_xlat2.x;
    u_xlat0.x = u_xlat0.x / _depthFade.y;
    u_xlat2.x = abs(u_xlat0.x) + 2.6400001;
    u_xlat0.x = abs(u_xlat0.x) + _depth;
    u_xlat0.x = u_xlat0.x + 2.6400001;
    u_xlat0.x = u_xlat0.x * -0.222717166 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x * -0.222717166 + 1.0;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.xyz = u_xlat2.xxx * _Color0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
    u_xlat10_1.xyz = texture(_TextureSample0, u_xlat1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz * _fadeColor.xyz;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _Color1.xyz + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_UseLinearSpace));
#else
    u_xlatb6 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_UseLinearSpace);
#endif
    u_xlat16_0.xyz = (bool(u_xlatb6)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat1.x = unity_OneOverOutputBoost;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = log2(_Color2.xyz);
    u_xlat1.xyz = u_xlat16_3.xyz * u_xlat1.xxx;
    u_xlat1.xyz = exp2(u_xlat1.xyz);
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(unity_MaxOutputValue, unity_MaxOutputValue, unity_MaxOutputValue)));
    u_xlat16_1.xyz = (unity_MetaFragmentControl.x) ? u_xlat1.xyz : vec3(0.0, 0.0, 0.0);
    u_xlat16_1.w = (unity_MetaFragmentControl.x) ? 1.0 : 0.0;
    u_xlat16_0.w = 1.0;
    SV_Target0 = (unity_MetaFragmentControl.y) ? u_xlat16_0 : u_xlat16_1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	bvec4 unity_MetaVertexControl;
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb6;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<in_POSITION0.z);
#else
    u_xlatb0 = 0.0<in_POSITION0.z;
#endif
    u_xlat0.z = u_xlatb0 ? 9.99999975e-05 : float(0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat0.xyz = (unity_MetaVertexControl.x) ? u_xlat0.xyz : in_POSITION0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.0<u_xlat0.z);
#else
    u_xlatb6 = 0.0<u_xlat0.z;
#endif
    u_xlat1.z = u_xlatb6 ? 9.99999975e-05 : float(0.0);
    u_xlat1.xy = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
    u_xlat0.xyz = (unity_MetaVertexControl.y) ? u_xlat1.xyz : u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat0.x * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec2 _depthFade;
uniform 	mediump float _depth;
uniform 	mediump vec4 _Color1;
uniform 	mediump vec4 _Color0;
uniform 	vec4 _TextureSample0_ST;
uniform 	mediump vec4 _fadeColor;
uniform 	bvec4 unity_MetaFragmentControl;
uniform 	float unity_OneOverOutputBoost;
uniform 	float unity_MaxOutputValue;
uniform 	float unity_UseLinearSpace;
uniform lowp sampler2D _CustomDepthTexture;
uniform lowp sampler2D _TextureSample0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp float u_xlat10_2;
mediump vec3 u_xlat16_3;
bool u_xlatb6;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD2.zxy / vs_TEXCOORD2.www;
    u_xlat10_2 = texture(_CustomDepthTexture, u_xlat0.yz).x;
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat2.x = _ZBufferParams.z * u_xlat10_2 + _ZBufferParams.w;
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat0.x = (-u_xlat0.x) + u_xlat2.x;
    u_xlat0.x = u_xlat0.x / _depthFade.y;
    u_xlat2.x = abs(u_xlat0.x) + 2.6400001;
    u_xlat0.x = abs(u_xlat0.x) + _depth;
    u_xlat0.x = u_xlat0.x + 2.6400001;
    u_xlat0.x = u_xlat0.x * -0.222717166 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x * -0.222717166 + 1.0;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.xyz = u_xlat2.xxx * _Color0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
    u_xlat10_1.xyz = texture(_TextureSample0, u_xlat1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz * _fadeColor.xyz;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _Color1.xyz + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_UseLinearSpace));
#else
    u_xlatb6 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_UseLinearSpace);
#endif
    u_xlat16_0.xyz = (bool(u_xlatb6)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat1.x = unity_OneOverOutputBoost;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = log2(_Color2.xyz);
    u_xlat1.xyz = u_xlat16_3.xyz * u_xlat1.xxx;
    u_xlat1.xyz = exp2(u_xlat1.xyz);
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(unity_MaxOutputValue, unity_MaxOutputValue, unity_MaxOutputValue)));
    u_xlat16_1.xyz = (unity_MetaFragmentControl.x) ? u_xlat1.xyz : vec3(0.0, 0.0, 0.0);
    u_xlat16_1.w = (unity_MetaFragmentControl.x) ? 1.0 : 0.0;
    u_xlat16_0.w = 1.0;
    SV_Target0 = (unity_MetaFragmentControl.y) ? u_xlat16_0 : u_xlat16_1;
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
CustomEditor "ASEMaterialInspector"
}