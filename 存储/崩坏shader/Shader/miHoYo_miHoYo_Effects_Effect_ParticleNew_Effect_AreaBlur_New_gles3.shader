//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_ParticleNew/Effect_AreaBlur_New" {
Properties {
_MainMaskTex ("MainMaskTex", 2D) = "white" { }
_MainMaskIntensity ("MainMaskIntensity", Float) = 1
_Color ("Main Color", Color) = (1,1,1,1)
_ColorIntensity ("ColorIntensity", Float) = 1
_Size ("Size", Range(0, 20)) = 1
_Offset ("Offset", Range(0, 0.1)) = 0.01
}
SubShader {
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "BACKBLURHOR"
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "ALWAYS" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 5972
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaskTex_ST;
uniform 	float _Offset;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0.xyz = in_NORMAL0.xyz * vec3(_Offset) + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = u_xlat0.xy * vec2(1.0, -1.0) + u_xlat0.ww;
    vs_TEXCOORD0.zw = u_xlat0.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainMaskTex_ST.xy + _MainMaskTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _BeforeAlphaTexture_TexelSize;
uniform 	float _MainMaskIntensity;
uniform 	float _Size;
uniform 	float _ColorIntensity;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainMaskTex;
uniform lowp sampler2D _BeforeAlphaTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec2 u_xlatb1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
mediump vec4 u_xlat16_4;
lowp vec4 u_xlat10_4;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
float u_xlat12;
void main()
{
    u_xlat0.x = _BeforeAlphaTexture_TexelSize.x * _Size;
    u_xlat6.xyz = u_xlat0.xxx * vec3(-3.0, -2.0, 3.0);
    u_xlatb1.xy = equal(vs_TEXCOORD0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy;
    u_xlatb1.x = u_xlatb1.y && u_xlatb1.x;
    u_xlat6.xyz = (u_xlatb1.x) ? vec3(0.0, 0.0, 0.0) : u_xlat6.xyz;
    u_xlat2.xyz = u_xlat6.xyz + vs_TEXCOORD0.xxx;
    u_xlat2.w = vs_TEXCOORD0.y;
    u_xlat3 = u_xlat2.xwyw / vs_TEXCOORD0.wwww;
    u_xlat6.xy = vec2(u_xlat2.z / vs_TEXCOORD0.w, u_xlat2.w / vs_TEXCOORD0.w);
    u_xlat10_2 = texture(_BeforeAlphaTexture, u_xlat6.xy);
    u_xlat10_4 = texture(_BeforeAlphaTexture, u_xlat3.zw);
    u_xlat10_3 = texture(_BeforeAlphaTexture, u_xlat3.xy);
    u_xlat16_4 = u_xlat10_4 * vec4(0.119999997, 0.119999997, 0.119999997, 0.119999997);
    u_xlat16_3 = u_xlat10_3 * vec4(0.0900000036, 0.0900000036, 0.0900000036, 0.0900000036) + u_xlat16_4;
    u_xlat6.x = (u_xlatb1.x) ? 0.0 : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.x = (u_xlatb1.x) ? 0.0 : u_xlat0.x;
    u_xlat12 = (u_xlatb1.x) ? 0.0 : 1.0;
    u_xlat1.x = u_xlat0.x + vs_TEXCOORD0.x;
    u_xlat4.x = u_xlat6.x + vs_TEXCOORD0.x;
    u_xlat4.yw = vs_TEXCOORD0.yy;
    u_xlat0.xy = u_xlat4.xy / vs_TEXCOORD0.ww;
    u_xlat10_5 = texture(_BeforeAlphaTexture, u_xlat0.xy);
    u_xlat16_3 = u_xlat10_5 * vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006) + u_xlat16_3;
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat10_5 = texture(_BeforeAlphaTexture, u_xlat0.xy);
    u_xlat16_3 = u_xlat10_5 * vec4(0.180000007, 0.180000007, 0.180000007, 0.180000007) + u_xlat16_3;
    u_xlat0.x = u_xlat12 * _BeforeAlphaTexture_TexelSize.x;
    u_xlat4.z = u_xlat0.x * _Size + vs_TEXCOORD0.x;
    u_xlat0.xy = vec2(u_xlat4.z / vs_TEXCOORD0.w, u_xlat4.w / vs_TEXCOORD0.w);
    u_xlat10_4 = texture(_BeforeAlphaTexture, u_xlat0.xy);
    u_xlat16_3 = u_xlat10_4 * vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006) + u_xlat16_3;
    u_xlat1.y = vs_TEXCOORD0.y;
    u_xlat0.xy = u_xlat1.xy / vs_TEXCOORD0.ww;
    u_xlat10_1 = texture(_BeforeAlphaTexture, u_xlat0.xy);
    u_xlat16_1 = u_xlat10_1 * vec4(0.119999997, 0.119999997, 0.119999997, 0.119999997) + u_xlat16_3;
    u_xlat16_1 = u_xlat10_2 * vec4(0.0900000036, 0.0900000036, 0.0900000036, 0.0900000036) + u_xlat16_1;
    u_xlat1 = u_xlat16_1 * _Color;
    u_xlat1 = u_xlat1 * vec4(vec4(_ColorIntensity, _ColorIntensity, _ColorIntensity, _ColorIntensity)) + (-u_xlat10_5);
    u_xlat10_2 = texture(_MainMaskTex, vs_TEXCOORD1.xy);
    u_xlat0 = vec4(u_xlat12) * u_xlat10_2;
    u_xlat0 = u_xlat0 * vec4(_MainMaskIntensity);
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 * u_xlat1 + u_xlat10_5;
    SV_Target0 = u_xlat0;
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
uniform 	vec4 _MainMaskTex_ST;
uniform 	float _Offset;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0.xyz = in_NORMAL0.xyz * vec3(_Offset) + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = u_xlat0.xy * vec2(1.0, -1.0) + u_xlat0.ww;
    vs_TEXCOORD0.zw = u_xlat0.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainMaskTex_ST.xy + _MainMaskTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _BeforeAlphaTexture_TexelSize;
uniform 	float _MainMaskIntensity;
uniform 	float _Size;
uniform 	float _ColorIntensity;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainMaskTex;
uniform lowp sampler2D _BeforeAlphaTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec2 u_xlatb1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
mediump vec4 u_xlat16_4;
lowp vec4 u_xlat10_4;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
float u_xlat12;
void main()
{
    u_xlat0.x = _BeforeAlphaTexture_TexelSize.x * _Size;
    u_xlat6.xyz = u_xlat0.xxx * vec3(-3.0, -2.0, 3.0);
    u_xlatb1.xy = equal(vs_TEXCOORD0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy;
    u_xlatb1.x = u_xlatb1.y && u_xlatb1.x;
    u_xlat6.xyz = (u_xlatb1.x) ? vec3(0.0, 0.0, 0.0) : u_xlat6.xyz;
    u_xlat2.xyz = u_xlat6.xyz + vs_TEXCOORD0.xxx;
    u_xlat2.w = vs_TEXCOORD0.y;
    u_xlat3 = u_xlat2.xwyw / vs_TEXCOORD0.wwww;
    u_xlat6.xy = vec2(u_xlat2.z / vs_TEXCOORD0.w, u_xlat2.w / vs_TEXCOORD0.w);
    u_xlat10_2 = texture(_BeforeAlphaTexture, u_xlat6.xy);
    u_xlat10_4 = texture(_BeforeAlphaTexture, u_xlat3.zw);
    u_xlat10_3 = texture(_BeforeAlphaTexture, u_xlat3.xy);
    u_xlat16_4 = u_xlat10_4 * vec4(0.119999997, 0.119999997, 0.119999997, 0.119999997);
    u_xlat16_3 = u_xlat10_3 * vec4(0.0900000036, 0.0900000036, 0.0900000036, 0.0900000036) + u_xlat16_4;
    u_xlat6.x = (u_xlatb1.x) ? 0.0 : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.x = (u_xlatb1.x) ? 0.0 : u_xlat0.x;
    u_xlat12 = (u_xlatb1.x) ? 0.0 : 1.0;
    u_xlat1.x = u_xlat0.x + vs_TEXCOORD0.x;
    u_xlat4.x = u_xlat6.x + vs_TEXCOORD0.x;
    u_xlat4.yw = vs_TEXCOORD0.yy;
    u_xlat0.xy = u_xlat4.xy / vs_TEXCOORD0.ww;
    u_xlat10_5 = texture(_BeforeAlphaTexture, u_xlat0.xy);
    u_xlat16_3 = u_xlat10_5 * vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006) + u_xlat16_3;
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat10_5 = texture(_BeforeAlphaTexture, u_xlat0.xy);
    u_xlat16_3 = u_xlat10_5 * vec4(0.180000007, 0.180000007, 0.180000007, 0.180000007) + u_xlat16_3;
    u_xlat0.x = u_xlat12 * _BeforeAlphaTexture_TexelSize.x;
    u_xlat4.z = u_xlat0.x * _Size + vs_TEXCOORD0.x;
    u_xlat0.xy = vec2(u_xlat4.z / vs_TEXCOORD0.w, u_xlat4.w / vs_TEXCOORD0.w);
    u_xlat10_4 = texture(_BeforeAlphaTexture, u_xlat0.xy);
    u_xlat16_3 = u_xlat10_4 * vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006) + u_xlat16_3;
    u_xlat1.y = vs_TEXCOORD0.y;
    u_xlat0.xy = u_xlat1.xy / vs_TEXCOORD0.ww;
    u_xlat10_1 = texture(_BeforeAlphaTexture, u_xlat0.xy);
    u_xlat16_1 = u_xlat10_1 * vec4(0.119999997, 0.119999997, 0.119999997, 0.119999997) + u_xlat16_3;
    u_xlat16_1 = u_xlat10_2 * vec4(0.0900000036, 0.0900000036, 0.0900000036, 0.0900000036) + u_xlat16_1;
    u_xlat1 = u_xlat16_1 * _Color;
    u_xlat1 = u_xlat1 * vec4(vec4(_ColorIntensity, _ColorIntensity, _ColorIntensity, _ColorIntensity)) + (-u_xlat10_5);
    u_xlat10_2 = texture(_MainMaskTex, vs_TEXCOORD1.xy);
    u_xlat0 = vec4(u_xlat12) * u_xlat10_2;
    u_xlat0 = u_xlat0 * vec4(_MainMaskIntensity);
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 * u_xlat1 + u_xlat10_5;
    SV_Target0 = u_xlat0;
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
uniform 	vec4 _MainMaskTex_ST;
uniform 	float _Offset;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0.xyz = in_NORMAL0.xyz * vec3(_Offset) + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = u_xlat0.xy * vec2(1.0, -1.0) + u_xlat0.ww;
    vs_TEXCOORD0.zw = u_xlat0.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainMaskTex_ST.xy + _MainMaskTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _BeforeAlphaTexture_TexelSize;
uniform 	float _MainMaskIntensity;
uniform 	float _Size;
uniform 	float _ColorIntensity;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainMaskTex;
uniform lowp sampler2D _BeforeAlphaTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec2 u_xlatb1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
mediump vec4 u_xlat16_4;
lowp vec4 u_xlat10_4;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
float u_xlat12;
void main()
{
    u_xlat0.x = _BeforeAlphaTexture_TexelSize.x * _Size;
    u_xlat6.xyz = u_xlat0.xxx * vec3(-3.0, -2.0, 3.0);
    u_xlatb1.xy = equal(vs_TEXCOORD0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy;
    u_xlatb1.x = u_xlatb1.y && u_xlatb1.x;
    u_xlat6.xyz = (u_xlatb1.x) ? vec3(0.0, 0.0, 0.0) : u_xlat6.xyz;
    u_xlat2.xyz = u_xlat6.xyz + vs_TEXCOORD0.xxx;
    u_xlat2.w = vs_TEXCOORD0.y;
    u_xlat3 = u_xlat2.xwyw / vs_TEXCOORD0.wwww;
    u_xlat6.xy = vec2(u_xlat2.z / vs_TEXCOORD0.w, u_xlat2.w / vs_TEXCOORD0.w);
    u_xlat10_2 = texture(_BeforeAlphaTexture, u_xlat6.xy);
    u_xlat10_4 = texture(_BeforeAlphaTexture, u_xlat3.zw);
    u_xlat10_3 = texture(_BeforeAlphaTexture, u_xlat3.xy);
    u_xlat16_4 = u_xlat10_4 * vec4(0.119999997, 0.119999997, 0.119999997, 0.119999997);
    u_xlat16_3 = u_xlat10_3 * vec4(0.0900000036, 0.0900000036, 0.0900000036, 0.0900000036) + u_xlat16_4;
    u_xlat6.x = (u_xlatb1.x) ? 0.0 : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.x = (u_xlatb1.x) ? 0.0 : u_xlat0.x;
    u_xlat12 = (u_xlatb1.x) ? 0.0 : 1.0;
    u_xlat1.x = u_xlat0.x + vs_TEXCOORD0.x;
    u_xlat4.x = u_xlat6.x + vs_TEXCOORD0.x;
    u_xlat4.yw = vs_TEXCOORD0.yy;
    u_xlat0.xy = u_xlat4.xy / vs_TEXCOORD0.ww;
    u_xlat10_5 = texture(_BeforeAlphaTexture, u_xlat0.xy);
    u_xlat16_3 = u_xlat10_5 * vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006) + u_xlat16_3;
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat10_5 = texture(_BeforeAlphaTexture, u_xlat0.xy);
    u_xlat16_3 = u_xlat10_5 * vec4(0.180000007, 0.180000007, 0.180000007, 0.180000007) + u_xlat16_3;
    u_xlat0.x = u_xlat12 * _BeforeAlphaTexture_TexelSize.x;
    u_xlat4.z = u_xlat0.x * _Size + vs_TEXCOORD0.x;
    u_xlat0.xy = vec2(u_xlat4.z / vs_TEXCOORD0.w, u_xlat4.w / vs_TEXCOORD0.w);
    u_xlat10_4 = texture(_BeforeAlphaTexture, u_xlat0.xy);
    u_xlat16_3 = u_xlat10_4 * vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006) + u_xlat16_3;
    u_xlat1.y = vs_TEXCOORD0.y;
    u_xlat0.xy = u_xlat1.xy / vs_TEXCOORD0.ww;
    u_xlat10_1 = texture(_BeforeAlphaTexture, u_xlat0.xy);
    u_xlat16_1 = u_xlat10_1 * vec4(0.119999997, 0.119999997, 0.119999997, 0.119999997) + u_xlat16_3;
    u_xlat16_1 = u_xlat10_2 * vec4(0.0900000036, 0.0900000036, 0.0900000036, 0.0900000036) + u_xlat16_1;
    u_xlat1 = u_xlat16_1 * _Color;
    u_xlat1 = u_xlat1 * vec4(vec4(_ColorIntensity, _ColorIntensity, _ColorIntensity, _ColorIntensity)) + (-u_xlat10_5);
    u_xlat10_2 = texture(_MainMaskTex, vs_TEXCOORD1.xy);
    u_xlat0 = vec4(u_xlat12) * u_xlat10_2;
    u_xlat0 = u_xlat0 * vec4(_MainMaskIntensity);
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 * u_xlat1 + u_xlat10_5;
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
 Pass {
  Name "BACKBLURVER"
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "ALWAYS" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 107430
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaskTex_ST;
uniform 	float _Offset;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
in highp vec4 in_NORMAL0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0.xyz = in_NORMAL0.xyz * vec3(vec3(_Offset, _Offset, _Offset)) + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = u_xlat0.xy * vec2(1.0, -1.0) + u_xlat0.ww;
    vs_TEXCOORD0.zw = u_xlat0.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainMaskTex_ST.xy + _MainMaskTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _BeforeAlphaTexture_TexelSize;
uniform 	float _Size;
uniform 	vec4 _Color;
uniform 	float _ColorIntensity;
uniform 	float _MainMaskIntensity;
uniform lowp sampler2D _MainMaskTex;
uniform lowp sampler2D _BeforeAlphaTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec2 u_xlatb1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
mediump vec4 u_xlat16_4;
lowp vec4 u_xlat10_4;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
float u_xlat12;
void main()
{
    u_xlat0.x = _BeforeAlphaTexture_TexelSize.y * _Size;
    u_xlat6.xyz = u_xlat0.xxx * vec3(-3.0, -2.0, 3.0);
    u_xlatb1.xy = equal(vs_TEXCOORD0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy;
    u_xlatb1.x = u_xlatb1.y && u_xlatb1.x;
    u_xlat6.xyz = (u_xlatb1.x) ? vec3(0.0, 0.0, 0.0) : u_xlat6.xyz;
    u_xlat2.xyz = u_xlat6.xyz + vs_TEXCOORD0.yyy;
    u_xlat2.w = vs_TEXCOORD0.x;
    u_xlat3 = u_xlat2.wxwy / vs_TEXCOORD0.wwww;
    u_xlat6.xy = vec2(u_xlat2.w / vs_TEXCOORD0.w, u_xlat2.z / vs_TEXCOORD0.w);
    u_xlat10_2 = texture(_BeforeAlphaTexture, u_xlat6.xy);
    u_xlat10_4 = texture(_BeforeAlphaTexture, u_xlat3.zw);
    u_xlat10_3 = texture(_BeforeAlphaTexture, u_xlat3.xy);
    u_xlat16_4 = u_xlat10_4 * vec4(0.119999997, 0.119999997, 0.119999997, 0.119999997);
    u_xlat16_3 = u_xlat10_3 * vec4(0.0900000036, 0.0900000036, 0.0900000036, 0.0900000036) + u_xlat16_4;
    u_xlat6.x = (u_xlatb1.x) ? 0.0 : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.x = (u_xlatb1.x) ? 0.0 : u_xlat0.x;
    u_xlat12 = (u_xlatb1.x) ? 0.0 : 1.0;
    u_xlat1.y = u_xlat0.x + vs_TEXCOORD0.y;
    u_xlat4.y = u_xlat6.x + vs_TEXCOORD0.y;
    u_xlat4.xz = vs_TEXCOORD0.xx;
    u_xlat0.xy = u_xlat4.xy / vs_TEXCOORD0.ww;
    u_xlat10_5 = texture(_BeforeAlphaTexture, u_xlat0.xy);
    u_xlat16_3 = u_xlat10_5 * vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006) + u_xlat16_3;
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat10_5 = texture(_BeforeAlphaTexture, u_xlat0.xy);
    u_xlat16_3 = u_xlat10_5 * vec4(0.180000007, 0.180000007, 0.180000007, 0.180000007) + u_xlat16_3;
    u_xlat0.x = u_xlat12 * _BeforeAlphaTexture_TexelSize.y;
    u_xlat4.w = u_xlat0.x * _Size + vs_TEXCOORD0.y;
    u_xlat0.xy = vec2(u_xlat4.z / vs_TEXCOORD0.w, u_xlat4.w / vs_TEXCOORD0.w);
    u_xlat10_4 = texture(_BeforeAlphaTexture, u_xlat0.xy);
    u_xlat16_3 = u_xlat10_4 * vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006) + u_xlat16_3;
    u_xlat1.x = vs_TEXCOORD0.x;
    u_xlat0.xy = u_xlat1.xy / vs_TEXCOORD0.ww;
    u_xlat10_1 = texture(_BeforeAlphaTexture, u_xlat0.xy);
    u_xlat16_1 = u_xlat10_1 * vec4(0.119999997, 0.119999997, 0.119999997, 0.119999997) + u_xlat16_3;
    u_xlat16_1 = u_xlat10_2 * vec4(0.0900000036, 0.0900000036, 0.0900000036, 0.0900000036) + u_xlat16_1;
    u_xlat1 = u_xlat16_1 * _Color;
    u_xlat1 = u_xlat1 * vec4(_ColorIntensity) + (-u_xlat10_5);
    u_xlat10_2 = texture(_MainMaskTex, vs_TEXCOORD1.xy);
    u_xlat0 = vec4(u_xlat12) * u_xlat10_2;
    u_xlat0 = u_xlat0 * vec4(_MainMaskIntensity);
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 * u_xlat1 + u_xlat10_5;
    SV_Target0 = u_xlat0;
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
uniform 	vec4 _MainMaskTex_ST;
uniform 	float _Offset;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
in highp vec4 in_NORMAL0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0.xyz = in_NORMAL0.xyz * vec3(vec3(_Offset, _Offset, _Offset)) + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = u_xlat0.xy * vec2(1.0, -1.0) + u_xlat0.ww;
    vs_TEXCOORD0.zw = u_xlat0.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainMaskTex_ST.xy + _MainMaskTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _BeforeAlphaTexture_TexelSize;
uniform 	float _Size;
uniform 	vec4 _Color;
uniform 	float _ColorIntensity;
uniform 	float _MainMaskIntensity;
uniform lowp sampler2D _MainMaskTex;
uniform lowp sampler2D _BeforeAlphaTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec2 u_xlatb1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
mediump vec4 u_xlat16_4;
lowp vec4 u_xlat10_4;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
float u_xlat12;
void main()
{
    u_xlat0.x = _BeforeAlphaTexture_TexelSize.y * _Size;
    u_xlat6.xyz = u_xlat0.xxx * vec3(-3.0, -2.0, 3.0);
    u_xlatb1.xy = equal(vs_TEXCOORD0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy;
    u_xlatb1.x = u_xlatb1.y && u_xlatb1.x;
    u_xlat6.xyz = (u_xlatb1.x) ? vec3(0.0, 0.0, 0.0) : u_xlat6.xyz;
    u_xlat2.xyz = u_xlat6.xyz + vs_TEXCOORD0.yyy;
    u_xlat2.w = vs_TEXCOORD0.x;
    u_xlat3 = u_xlat2.wxwy / vs_TEXCOORD0.wwww;
    u_xlat6.xy = vec2(u_xlat2.w / vs_TEXCOORD0.w, u_xlat2.z / vs_TEXCOORD0.w);
    u_xlat10_2 = texture(_BeforeAlphaTexture, u_xlat6.xy);
    u_xlat10_4 = texture(_BeforeAlphaTexture, u_xlat3.zw);
    u_xlat10_3 = texture(_BeforeAlphaTexture, u_xlat3.xy);
    u_xlat16_4 = u_xlat10_4 * vec4(0.119999997, 0.119999997, 0.119999997, 0.119999997);
    u_xlat16_3 = u_xlat10_3 * vec4(0.0900000036, 0.0900000036, 0.0900000036, 0.0900000036) + u_xlat16_4;
    u_xlat6.x = (u_xlatb1.x) ? 0.0 : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.x = (u_xlatb1.x) ? 0.0 : u_xlat0.x;
    u_xlat12 = (u_xlatb1.x) ? 0.0 : 1.0;
    u_xlat1.y = u_xlat0.x + vs_TEXCOORD0.y;
    u_xlat4.y = u_xlat6.x + vs_TEXCOORD0.y;
    u_xlat4.xz = vs_TEXCOORD0.xx;
    u_xlat0.xy = u_xlat4.xy / vs_TEXCOORD0.ww;
    u_xlat10_5 = texture(_BeforeAlphaTexture, u_xlat0.xy);
    u_xlat16_3 = u_xlat10_5 * vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006) + u_xlat16_3;
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat10_5 = texture(_BeforeAlphaTexture, u_xlat0.xy);
    u_xlat16_3 = u_xlat10_5 * vec4(0.180000007, 0.180000007, 0.180000007, 0.180000007) + u_xlat16_3;
    u_xlat0.x = u_xlat12 * _BeforeAlphaTexture_TexelSize.y;
    u_xlat4.w = u_xlat0.x * _Size + vs_TEXCOORD0.y;
    u_xlat0.xy = vec2(u_xlat4.z / vs_TEXCOORD0.w, u_xlat4.w / vs_TEXCOORD0.w);
    u_xlat10_4 = texture(_BeforeAlphaTexture, u_xlat0.xy);
    u_xlat16_3 = u_xlat10_4 * vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006) + u_xlat16_3;
    u_xlat1.x = vs_TEXCOORD0.x;
    u_xlat0.xy = u_xlat1.xy / vs_TEXCOORD0.ww;
    u_xlat10_1 = texture(_BeforeAlphaTexture, u_xlat0.xy);
    u_xlat16_1 = u_xlat10_1 * vec4(0.119999997, 0.119999997, 0.119999997, 0.119999997) + u_xlat16_3;
    u_xlat16_1 = u_xlat10_2 * vec4(0.0900000036, 0.0900000036, 0.0900000036, 0.0900000036) + u_xlat16_1;
    u_xlat1 = u_xlat16_1 * _Color;
    u_xlat1 = u_xlat1 * vec4(_ColorIntensity) + (-u_xlat10_5);
    u_xlat10_2 = texture(_MainMaskTex, vs_TEXCOORD1.xy);
    u_xlat0 = vec4(u_xlat12) * u_xlat10_2;
    u_xlat0 = u_xlat0 * vec4(_MainMaskIntensity);
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 * u_xlat1 + u_xlat10_5;
    SV_Target0 = u_xlat0;
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
uniform 	vec4 _MainMaskTex_ST;
uniform 	float _Offset;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
in highp vec4 in_NORMAL0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0.xyz = in_NORMAL0.xyz * vec3(vec3(_Offset, _Offset, _Offset)) + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = u_xlat0.xy * vec2(1.0, -1.0) + u_xlat0.ww;
    vs_TEXCOORD0.zw = u_xlat0.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainMaskTex_ST.xy + _MainMaskTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _BeforeAlphaTexture_TexelSize;
uniform 	float _Size;
uniform 	vec4 _Color;
uniform 	float _ColorIntensity;
uniform 	float _MainMaskIntensity;
uniform lowp sampler2D _MainMaskTex;
uniform lowp sampler2D _BeforeAlphaTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec2 u_xlatb1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
mediump vec4 u_xlat16_4;
lowp vec4 u_xlat10_4;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
float u_xlat12;
void main()
{
    u_xlat0.x = _BeforeAlphaTexture_TexelSize.y * _Size;
    u_xlat6.xyz = u_xlat0.xxx * vec3(-3.0, -2.0, 3.0);
    u_xlatb1.xy = equal(vs_TEXCOORD0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy;
    u_xlatb1.x = u_xlatb1.y && u_xlatb1.x;
    u_xlat6.xyz = (u_xlatb1.x) ? vec3(0.0, 0.0, 0.0) : u_xlat6.xyz;
    u_xlat2.xyz = u_xlat6.xyz + vs_TEXCOORD0.yyy;
    u_xlat2.w = vs_TEXCOORD0.x;
    u_xlat3 = u_xlat2.wxwy / vs_TEXCOORD0.wwww;
    u_xlat6.xy = vec2(u_xlat2.w / vs_TEXCOORD0.w, u_xlat2.z / vs_TEXCOORD0.w);
    u_xlat10_2 = texture(_BeforeAlphaTexture, u_xlat6.xy);
    u_xlat10_4 = texture(_BeforeAlphaTexture, u_xlat3.zw);
    u_xlat10_3 = texture(_BeforeAlphaTexture, u_xlat3.xy);
    u_xlat16_4 = u_xlat10_4 * vec4(0.119999997, 0.119999997, 0.119999997, 0.119999997);
    u_xlat16_3 = u_xlat10_3 * vec4(0.0900000036, 0.0900000036, 0.0900000036, 0.0900000036) + u_xlat16_4;
    u_xlat6.x = (u_xlatb1.x) ? 0.0 : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.x = (u_xlatb1.x) ? 0.0 : u_xlat0.x;
    u_xlat12 = (u_xlatb1.x) ? 0.0 : 1.0;
    u_xlat1.y = u_xlat0.x + vs_TEXCOORD0.y;
    u_xlat4.y = u_xlat6.x + vs_TEXCOORD0.y;
    u_xlat4.xz = vs_TEXCOORD0.xx;
    u_xlat0.xy = u_xlat4.xy / vs_TEXCOORD0.ww;
    u_xlat10_5 = texture(_BeforeAlphaTexture, u_xlat0.xy);
    u_xlat16_3 = u_xlat10_5 * vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006) + u_xlat16_3;
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat10_5 = texture(_BeforeAlphaTexture, u_xlat0.xy);
    u_xlat16_3 = u_xlat10_5 * vec4(0.180000007, 0.180000007, 0.180000007, 0.180000007) + u_xlat16_3;
    u_xlat0.x = u_xlat12 * _BeforeAlphaTexture_TexelSize.y;
    u_xlat4.w = u_xlat0.x * _Size + vs_TEXCOORD0.y;
    u_xlat0.xy = vec2(u_xlat4.z / vs_TEXCOORD0.w, u_xlat4.w / vs_TEXCOORD0.w);
    u_xlat10_4 = texture(_BeforeAlphaTexture, u_xlat0.xy);
    u_xlat16_3 = u_xlat10_4 * vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006) + u_xlat16_3;
    u_xlat1.x = vs_TEXCOORD0.x;
    u_xlat0.xy = u_xlat1.xy / vs_TEXCOORD0.ww;
    u_xlat10_1 = texture(_BeforeAlphaTexture, u_xlat0.xy);
    u_xlat16_1 = u_xlat10_1 * vec4(0.119999997, 0.119999997, 0.119999997, 0.119999997) + u_xlat16_3;
    u_xlat16_1 = u_xlat10_2 * vec4(0.0900000036, 0.0900000036, 0.0900000036, 0.0900000036) + u_xlat16_1;
    u_xlat1 = u_xlat16_1 * _Color;
    u_xlat1 = u_xlat1 * vec4(_ColorIntensity) + (-u_xlat10_5);
    u_xlat10_2 = texture(_MainMaskTex, vs_TEXCOORD1.xy);
    u_xlat0 = vec4(u_xlat12) * u_xlat10_2;
    u_xlat0 = u_xlat0 * vec4(_MainMaskIntensity);
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 * u_xlat1 + u_xlat10_5;
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