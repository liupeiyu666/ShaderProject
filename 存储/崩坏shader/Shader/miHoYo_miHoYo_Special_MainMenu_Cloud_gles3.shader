//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Special/MainMenu/Cloud" {
Properties {
_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
_MainTex ("Particle Texture", 2D) = "white" { }
_TileSize ("Tile Size", Vector) = (1,1,0,1)
_EmitterWidth ("Emitter Width", Float) = 1
_AspectRatio ("Aspect Ratio", Float) = 1
_BrightColor ("Bright Color", Color) = (1,1,1,1)
_DarkColor ("Dark Color", Color) = (1,1,1,1)
_SecondDarkColor ("Second Dark Color", Color) = (1,1,1,1)
_RimColor ("Rim Color", Color) = (1,1,1,1)
_EmissionScaler ("Emission Scaler", Range(0, 50)) = 1
_FlashColor ("Flash Color", Color) = (1,1,1,1)
_FlashAttenFactors ("Flash Attenuation Factors", Vector) = (1,0,0,0)
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 20693
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec2 _TileSize;
uniform 	float _EmitterWidth;
uniform 	float _AspectRatio;
uniform 	vec4 _FlashPoint00;
uniform 	vec4 _FlashPoint01;
uniform 	vec4 _FlashPoint02;
uniform 	vec4 _FlashPoint03;
uniform 	vec4 _FlashPoint04;
uniform 	vec4 _FlashPoint05;
uniform 	vec4 _FlashAttenFactors;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump float vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec3 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat4;
float u_xlat5;
float u_xlat8;
float u_xlat9;
vec2 u_xlat10;
float u_xlat12;
float u_xlat13;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat1.xyz;
    u_xlat2.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10.xy = in_COLOR0.yx * vec2(_EmitterWidth, _TileSize.x);
    u_xlat3.x = u_xlat10.x / in_COLOR0.z;
    u_xlat12 = u_xlat10.y * _TileSize.y;
    u_xlat12 = trunc(u_xlat12);
    u_xlat3.y = u_xlat3.x * _AspectRatio;
    u_xlat2.xy = u_xlat2.xy * u_xlat3.xy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.yyy;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xxx + u_xlat1.xyz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat1 = u_xlat1 / u_xlat1.wwww;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat0.x = u_xlat12 * _TileSize.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb0 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = (u_xlatb0) ? _TileSize.x : (-_TileSize.x);
    u_xlat4 = float(1.0) / u_xlat0.x;
    u_xlat4 = u_xlat4 * u_xlat12;
    u_xlat8 = u_xlat12 / _TileSize.x;
    u_xlat2.y = floor(u_xlat8);
    u_xlat4 = fract(u_xlat4);
    u_xlat2.x = u_xlat4 * u_xlat0.x;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = u_xlat2.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy / _TileSize.xy;
    u_xlat2.xyz = (-u_xlat1.xyz) + _FlashPoint00.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = sqrt(u_xlat12);
    u_xlat13 = u_xlat13 * _FlashAttenFactors.y + _FlashAttenFactors.x;
    u_xlat12 = u_xlat12 * _FlashAttenFactors.z + u_xlat13;
    u_xlat12 = _FlashPoint00.w / u_xlat12;
    u_xlat2.xyz = (-u_xlat1.xyz) + _FlashPoint01.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat13);
    u_xlat2.x = u_xlat2.x * _FlashAttenFactors.y + _FlashAttenFactors.x;
    u_xlat13 = u_xlat13 * _FlashAttenFactors.z + u_xlat2.x;
    u_xlat13 = _FlashPoint01.w / u_xlat13;
    u_xlat12 = u_xlat12 + u_xlat13;
    u_xlat2.xyz = (-u_xlat1.xyz) + _FlashPoint02.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat13);
    u_xlat2.x = u_xlat2.x * _FlashAttenFactors.y + _FlashAttenFactors.x;
    u_xlat13 = u_xlat13 * _FlashAttenFactors.z + u_xlat2.x;
    u_xlat13 = _FlashPoint02.w / u_xlat13;
    u_xlat12 = u_xlat12 + u_xlat13;
    u_xlat2.xyz = (-u_xlat1.xyz) + _FlashPoint03.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat13);
    u_xlat2.x = u_xlat2.x * _FlashAttenFactors.y + _FlashAttenFactors.x;
    u_xlat13 = u_xlat13 * _FlashAttenFactors.z + u_xlat2.x;
    u_xlat13 = _FlashPoint03.w / u_xlat13;
    u_xlat12 = u_xlat12 + u_xlat13;
    u_xlat2.xyz = (-u_xlat1.xyz) + _FlashPoint04.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _FlashPoint05.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat5 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = sqrt(u_xlat5);
    u_xlat9 = u_xlat9 * _FlashAttenFactors.y + _FlashAttenFactors.x;
    u_xlat5 = u_xlat5 * _FlashAttenFactors.z + u_xlat9;
    u_xlat5 = _FlashPoint04.w / u_xlat5;
    u_xlat12 = u_xlat12 + u_xlat5;
    u_xlat5 = sqrt(u_xlat1.x);
    u_xlat5 = u_xlat5 * _FlashAttenFactors.y + _FlashAttenFactors.x;
    u_xlat1.x = u_xlat1.x * _FlashAttenFactors.z + u_xlat5;
    u_xlat1.x = _FlashPoint05.w / u_xlat1.x;
    u_xlat0.z = u_xlat12 + u_xlat1.x;
    phase0_Output0_1.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.z;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _BrightColor;
uniform 	mediump vec4 _DarkColor;
uniform 	mediump vec4 _SecondDarkColor;
uniform 	mediump vec4 _RimColor;
uniform 	mediump vec4 _FlashColor;
uniform 	mediump float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_9;
void main()
{
    u_xlat16_0.xyz = (-_BrightColor.xyz) + _DarkColor.xyz;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_9 = u_xlat10_1.x * _DarkColor.w;
    u_xlat16_0.xyz = vec3(u_xlat16_9) * u_xlat16_0.xyz + _BrightColor.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _SecondDarkColor.xyz;
    u_xlat16_9 = u_xlat10_1.y * _SecondDarkColor.w;
    u_xlat16_0.xyz = vec3(u_xlat16_9) * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _RimColor.xyz;
    u_xlat16_9 = u_xlat10_1.z * _RimColor.w;
    SV_Target0.w = u_xlat10_1.w * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_0.xyz = vec3(u_xlat16_9) * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = vec3(vs_TEXCOORD1) * _FlashColor.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(_EmissionScaler) + u_xlat16_2.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec2 _TileSize;
uniform 	float _EmitterWidth;
uniform 	float _AspectRatio;
uniform 	vec4 _FlashPoint00;
uniform 	vec4 _FlashPoint01;
uniform 	vec4 _FlashPoint02;
uniform 	vec4 _FlashPoint03;
uniform 	vec4 _FlashPoint04;
uniform 	vec4 _FlashPoint05;
uniform 	vec4 _FlashAttenFactors;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump float vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec3 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat4;
float u_xlat5;
float u_xlat8;
float u_xlat9;
vec2 u_xlat10;
float u_xlat12;
float u_xlat13;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat1.xyz;
    u_xlat2.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10.xy = in_COLOR0.yx * vec2(_EmitterWidth, _TileSize.x);
    u_xlat3.x = u_xlat10.x / in_COLOR0.z;
    u_xlat12 = u_xlat10.y * _TileSize.y;
    u_xlat12 = trunc(u_xlat12);
    u_xlat3.y = u_xlat3.x * _AspectRatio;
    u_xlat2.xy = u_xlat2.xy * u_xlat3.xy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.yyy;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xxx + u_xlat1.xyz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat1 = u_xlat1 / u_xlat1.wwww;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat0.x = u_xlat12 * _TileSize.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb0 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = (u_xlatb0) ? _TileSize.x : (-_TileSize.x);
    u_xlat4 = float(1.0) / u_xlat0.x;
    u_xlat4 = u_xlat4 * u_xlat12;
    u_xlat8 = u_xlat12 / _TileSize.x;
    u_xlat2.y = floor(u_xlat8);
    u_xlat4 = fract(u_xlat4);
    u_xlat2.x = u_xlat4 * u_xlat0.x;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = u_xlat2.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy / _TileSize.xy;
    u_xlat2.xyz = (-u_xlat1.xyz) + _FlashPoint00.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = sqrt(u_xlat12);
    u_xlat13 = u_xlat13 * _FlashAttenFactors.y + _FlashAttenFactors.x;
    u_xlat12 = u_xlat12 * _FlashAttenFactors.z + u_xlat13;
    u_xlat12 = _FlashPoint00.w / u_xlat12;
    u_xlat2.xyz = (-u_xlat1.xyz) + _FlashPoint01.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat13);
    u_xlat2.x = u_xlat2.x * _FlashAttenFactors.y + _FlashAttenFactors.x;
    u_xlat13 = u_xlat13 * _FlashAttenFactors.z + u_xlat2.x;
    u_xlat13 = _FlashPoint01.w / u_xlat13;
    u_xlat12 = u_xlat12 + u_xlat13;
    u_xlat2.xyz = (-u_xlat1.xyz) + _FlashPoint02.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat13);
    u_xlat2.x = u_xlat2.x * _FlashAttenFactors.y + _FlashAttenFactors.x;
    u_xlat13 = u_xlat13 * _FlashAttenFactors.z + u_xlat2.x;
    u_xlat13 = _FlashPoint02.w / u_xlat13;
    u_xlat12 = u_xlat12 + u_xlat13;
    u_xlat2.xyz = (-u_xlat1.xyz) + _FlashPoint03.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat13);
    u_xlat2.x = u_xlat2.x * _FlashAttenFactors.y + _FlashAttenFactors.x;
    u_xlat13 = u_xlat13 * _FlashAttenFactors.z + u_xlat2.x;
    u_xlat13 = _FlashPoint03.w / u_xlat13;
    u_xlat12 = u_xlat12 + u_xlat13;
    u_xlat2.xyz = (-u_xlat1.xyz) + _FlashPoint04.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _FlashPoint05.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat5 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = sqrt(u_xlat5);
    u_xlat9 = u_xlat9 * _FlashAttenFactors.y + _FlashAttenFactors.x;
    u_xlat5 = u_xlat5 * _FlashAttenFactors.z + u_xlat9;
    u_xlat5 = _FlashPoint04.w / u_xlat5;
    u_xlat12 = u_xlat12 + u_xlat5;
    u_xlat5 = sqrt(u_xlat1.x);
    u_xlat5 = u_xlat5 * _FlashAttenFactors.y + _FlashAttenFactors.x;
    u_xlat1.x = u_xlat1.x * _FlashAttenFactors.z + u_xlat5;
    u_xlat1.x = _FlashPoint05.w / u_xlat1.x;
    u_xlat0.z = u_xlat12 + u_xlat1.x;
    phase0_Output0_1.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.z;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _BrightColor;
uniform 	mediump vec4 _DarkColor;
uniform 	mediump vec4 _SecondDarkColor;
uniform 	mediump vec4 _RimColor;
uniform 	mediump vec4 _FlashColor;
uniform 	mediump float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_9;
void main()
{
    u_xlat16_0.xyz = (-_BrightColor.xyz) + _DarkColor.xyz;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_9 = u_xlat10_1.x * _DarkColor.w;
    u_xlat16_0.xyz = vec3(u_xlat16_9) * u_xlat16_0.xyz + _BrightColor.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _SecondDarkColor.xyz;
    u_xlat16_9 = u_xlat10_1.y * _SecondDarkColor.w;
    u_xlat16_0.xyz = vec3(u_xlat16_9) * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _RimColor.xyz;
    u_xlat16_9 = u_xlat10_1.z * _RimColor.w;
    SV_Target0.w = u_xlat10_1.w * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_0.xyz = vec3(u_xlat16_9) * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = vec3(vs_TEXCOORD1) * _FlashColor.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(_EmissionScaler) + u_xlat16_2.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec2 _TileSize;
uniform 	float _EmitterWidth;
uniform 	float _AspectRatio;
uniform 	vec4 _FlashPoint00;
uniform 	vec4 _FlashPoint01;
uniform 	vec4 _FlashPoint02;
uniform 	vec4 _FlashPoint03;
uniform 	vec4 _FlashPoint04;
uniform 	vec4 _FlashPoint05;
uniform 	vec4 _FlashAttenFactors;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump float vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec3 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat4;
float u_xlat5;
float u_xlat8;
float u_xlat9;
vec2 u_xlat10;
float u_xlat12;
float u_xlat13;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat1.xyz;
    u_xlat2.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10.xy = in_COLOR0.yx * vec2(_EmitterWidth, _TileSize.x);
    u_xlat3.x = u_xlat10.x / in_COLOR0.z;
    u_xlat12 = u_xlat10.y * _TileSize.y;
    u_xlat12 = trunc(u_xlat12);
    u_xlat3.y = u_xlat3.x * _AspectRatio;
    u_xlat2.xy = u_xlat2.xy * u_xlat3.xy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.yyy;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xxx + u_xlat1.xyz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat1 = u_xlat1 / u_xlat1.wwww;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat0.x = u_xlat12 * _TileSize.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb0 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = (u_xlatb0) ? _TileSize.x : (-_TileSize.x);
    u_xlat4 = float(1.0) / u_xlat0.x;
    u_xlat4 = u_xlat4 * u_xlat12;
    u_xlat8 = u_xlat12 / _TileSize.x;
    u_xlat2.y = floor(u_xlat8);
    u_xlat4 = fract(u_xlat4);
    u_xlat2.x = u_xlat4 * u_xlat0.x;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = u_xlat2.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy / _TileSize.xy;
    u_xlat2.xyz = (-u_xlat1.xyz) + _FlashPoint00.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = sqrt(u_xlat12);
    u_xlat13 = u_xlat13 * _FlashAttenFactors.y + _FlashAttenFactors.x;
    u_xlat12 = u_xlat12 * _FlashAttenFactors.z + u_xlat13;
    u_xlat12 = _FlashPoint00.w / u_xlat12;
    u_xlat2.xyz = (-u_xlat1.xyz) + _FlashPoint01.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat13);
    u_xlat2.x = u_xlat2.x * _FlashAttenFactors.y + _FlashAttenFactors.x;
    u_xlat13 = u_xlat13 * _FlashAttenFactors.z + u_xlat2.x;
    u_xlat13 = _FlashPoint01.w / u_xlat13;
    u_xlat12 = u_xlat12 + u_xlat13;
    u_xlat2.xyz = (-u_xlat1.xyz) + _FlashPoint02.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat13);
    u_xlat2.x = u_xlat2.x * _FlashAttenFactors.y + _FlashAttenFactors.x;
    u_xlat13 = u_xlat13 * _FlashAttenFactors.z + u_xlat2.x;
    u_xlat13 = _FlashPoint02.w / u_xlat13;
    u_xlat12 = u_xlat12 + u_xlat13;
    u_xlat2.xyz = (-u_xlat1.xyz) + _FlashPoint03.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat13);
    u_xlat2.x = u_xlat2.x * _FlashAttenFactors.y + _FlashAttenFactors.x;
    u_xlat13 = u_xlat13 * _FlashAttenFactors.z + u_xlat2.x;
    u_xlat13 = _FlashPoint03.w / u_xlat13;
    u_xlat12 = u_xlat12 + u_xlat13;
    u_xlat2.xyz = (-u_xlat1.xyz) + _FlashPoint04.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _FlashPoint05.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat5 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = sqrt(u_xlat5);
    u_xlat9 = u_xlat9 * _FlashAttenFactors.y + _FlashAttenFactors.x;
    u_xlat5 = u_xlat5 * _FlashAttenFactors.z + u_xlat9;
    u_xlat5 = _FlashPoint04.w / u_xlat5;
    u_xlat12 = u_xlat12 + u_xlat5;
    u_xlat5 = sqrt(u_xlat1.x);
    u_xlat5 = u_xlat5 * _FlashAttenFactors.y + _FlashAttenFactors.x;
    u_xlat1.x = u_xlat1.x * _FlashAttenFactors.z + u_xlat5;
    u_xlat1.x = _FlashPoint05.w / u_xlat1.x;
    u_xlat0.z = u_xlat12 + u_xlat1.x;
    phase0_Output0_1.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.z;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _BrightColor;
uniform 	mediump vec4 _DarkColor;
uniform 	mediump vec4 _SecondDarkColor;
uniform 	mediump vec4 _RimColor;
uniform 	mediump vec4 _FlashColor;
uniform 	mediump float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_9;
void main()
{
    u_xlat16_0.xyz = (-_BrightColor.xyz) + _DarkColor.xyz;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_9 = u_xlat10_1.x * _DarkColor.w;
    u_xlat16_0.xyz = vec3(u_xlat16_9) * u_xlat16_0.xyz + _BrightColor.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _SecondDarkColor.xyz;
    u_xlat16_9 = u_xlat10_1.y * _SecondDarkColor.w;
    u_xlat16_0.xyz = vec3(u_xlat16_9) * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _RimColor.xyz;
    u_xlat16_9 = u_xlat10_1.z * _RimColor.w;
    SV_Target0.w = u_xlat10_1.w * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_0.xyz = vec3(u_xlat16_9) * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = vec3(vs_TEXCOORD1) * _FlashColor.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(_EmissionScaler) + u_xlat16_2.xyz;
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