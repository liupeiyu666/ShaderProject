//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Special/Effect_Trail/Channel Mix2" {
Properties {
_TintColor0 ("Tint Color0", Color) = (0.5,0.5,0.5,0.5)
_TintColor1 ("Tint Color1", Color) = (0.5,0.5,0.5,0.5)
_TintColor2 ("Tint Color2", Color) = (0.5,0.5,0.5,0.5)
_MainTex ("Particle Texture", 2D) = "white" { }
_Timer ("_Timer", Range(0, 1)) = 0
_AppearTime ("Appear Time", Range(0, 1)) = 0
_VanishTime ("Vanish Time", Range(0, 1)) = 0
_AlphaOverLife ("Alpha Over Life", Vector) = (0.197,0.815,0,0)
_CamForward ("Camera Forward", Vector) = (0,0,1,0)
_IsUseCamForward ("Is Use Camera Forward", Range(0, 1)) = 1
_BloomFactor ("Bloom Factor", Float) = 1
_EmissionScaler ("Emission Scaler", Range(0, 50)) = 1
[Toggle(_EndMoveX_ON)] _EndMoveX ("EndMoveX", Float) = 1
[Toggle(_EndMoveY_ON)] _EndMoveY ("EndMoveY", Float) = 1
[Toggle(DISTORTION)] _Distortion ("Distortion", Float) = 0
_DTTex ("Distortion Tex", 2D) = "gray" { }
_DTIntensity ("Distortion Intensity", Range(0, 10)) = 5
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 65218
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _Timer;
uniform 	float _AppearTime;
uniform 	float _VanishTime;
uniform 	vec2 _AlphaOverLife;
uniform 	vec3 _CamForward;
uniform 	float _IsUseCamForward;
uniform 	vec4 hlslcc_mtx4x4_SizeOverLife[4];
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
out highp float vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat2;
int u_xlati2;
bool u_xlatb2;
float u_xlat4;
float u_xlat6;
int u_xlati6;
void main()
{
    u_xlat0.xyz = in_NORMAL0.zxy * _CamForward.yzx;
    u_xlat0.xyz = in_NORMAL0.yzx * _CamForward.zxy + (-u_xlat0.xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat6 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat6 = sqrt(u_xlat6);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6);
    u_xlat6 = (-_IsUseCamForward) + 1.5;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati6 = int(u_xlat6);
    u_xlat0.xyz = (int(u_xlati6) != 0) ? in_NORMAL0.xyz : u_xlat0.xyz;
    u_xlat6 = (-hlslcc_mtx4x4_SizeOverLife[1].x) + hlslcc_mtx4x4_SizeOverLife[2].x;
    u_xlat6 = u_xlat6 * 0.498999953 + hlslcc_mtx4x4_SizeOverLife[1].x;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6) + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_Timer);
#else
    u_xlatb0 = 0.5<_Timer;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(1.0>=_Timer);
#else
    u_xlatb2 = 1.0>=_Timer;
#endif
    u_xlatb0 = u_xlatb2 && u_xlatb0;
    u_xlat2 = in_TEXCOORD0.x / _AppearTime;
    u_xlat0.x = (u_xlatb0) ? in_TEXCOORD0.x : u_xlat2;
    u_xlat0.y = in_TEXCOORD0.y;
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = vec2(vec2(_VanishTime, _VanishTime)) + vec2(0.99000001, 1.0);
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat0.x = (u_xlati0 != 0) ? u_xlat0.y : _AppearTime;
    vs_TEXCOORD2 = u_xlat0.x + (-in_TEXCOORD0.x);
    vs_TEXCOORD1 = 0.100000001;
    u_xlat0.x = _Timer + (-_AlphaOverLife.x);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat2 = _Timer / _AlphaOverLife.x;
    u_xlat0.x = (u_xlati0 != 0) ? 1.0 : u_xlat2;
    u_xlat2 = (-_Timer) + _AlphaOverLife.y;
    u_xlat2 = u_xlat2 + 1.0;
    u_xlat2 = floor(u_xlat2);
    u_xlat2 = max(u_xlat2, 0.0);
    u_xlati2 = int(u_xlat2);
    u_xlat4 = (-_Timer) + 1.0;
    u_xlat6 = (-_AlphaOverLife.y) + 1.0;
    u_xlat4 = u_xlat4 / u_xlat6;
    u_xlat0.x = (u_xlati2 != 0) ? u_xlat0.x : u_xlat4;
    vs_COLOR0.w = u_xlat0.x;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor0;
uniform 	mediump vec4 _TintColor1;
uniform 	mediump vec4 _TintColor2;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
in highp float vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp vec3 u_xlat10_0;
int u_xlati0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_10;
void main()
{
    u_xlat0 = vs_TEXCOORD1 + 0.999000013;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD1) + 1.99900007;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = vs_TEXCOORD2 + 0.999000013;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = vs_TEXCOORD0.x + 1.99900007;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.x) + 3.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = vs_TEXCOORD0.y + 0.999000013;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.y) + 3.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = (-_TintColor0.xyz) + _TintColor1.xyz;
    u_xlat16_1.xyz = u_xlat10_0.xxx * u_xlat16_1.xyz + _TintColor0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _TintColor2.xyz;
    u_xlat16_1.xyz = u_xlat10_0.yyy * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_10 = _EmissionScaler + _EmissionScaler;
    u_xlat16_2.xyz = vec3(u_xlat16_10) * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    SV_Target0.w = u_xlat10_0.z * vs_COLOR0.w;
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
uniform 	vec4 _MainTex_ST;
uniform 	float _Timer;
uniform 	float _AppearTime;
uniform 	float _VanishTime;
uniform 	vec2 _AlphaOverLife;
uniform 	vec3 _CamForward;
uniform 	float _IsUseCamForward;
uniform 	vec4 hlslcc_mtx4x4_SizeOverLife[4];
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
out highp float vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat2;
int u_xlati2;
bool u_xlatb2;
float u_xlat4;
float u_xlat6;
int u_xlati6;
void main()
{
    u_xlat0.xyz = in_NORMAL0.zxy * _CamForward.yzx;
    u_xlat0.xyz = in_NORMAL0.yzx * _CamForward.zxy + (-u_xlat0.xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat6 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat6 = sqrt(u_xlat6);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6);
    u_xlat6 = (-_IsUseCamForward) + 1.5;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati6 = int(u_xlat6);
    u_xlat0.xyz = (int(u_xlati6) != 0) ? in_NORMAL0.xyz : u_xlat0.xyz;
    u_xlat6 = (-hlslcc_mtx4x4_SizeOverLife[1].x) + hlslcc_mtx4x4_SizeOverLife[2].x;
    u_xlat6 = u_xlat6 * 0.498999953 + hlslcc_mtx4x4_SizeOverLife[1].x;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6) + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_Timer);
#else
    u_xlatb0 = 0.5<_Timer;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(1.0>=_Timer);
#else
    u_xlatb2 = 1.0>=_Timer;
#endif
    u_xlatb0 = u_xlatb2 && u_xlatb0;
    u_xlat2 = in_TEXCOORD0.x / _AppearTime;
    u_xlat0.x = (u_xlatb0) ? in_TEXCOORD0.x : u_xlat2;
    u_xlat0.y = in_TEXCOORD0.y;
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = vec2(vec2(_VanishTime, _VanishTime)) + vec2(0.99000001, 1.0);
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat0.x = (u_xlati0 != 0) ? u_xlat0.y : _AppearTime;
    vs_TEXCOORD2 = u_xlat0.x + (-in_TEXCOORD0.x);
    vs_TEXCOORD1 = 0.100000001;
    u_xlat0.x = _Timer + (-_AlphaOverLife.x);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat2 = _Timer / _AlphaOverLife.x;
    u_xlat0.x = (u_xlati0 != 0) ? 1.0 : u_xlat2;
    u_xlat2 = (-_Timer) + _AlphaOverLife.y;
    u_xlat2 = u_xlat2 + 1.0;
    u_xlat2 = floor(u_xlat2);
    u_xlat2 = max(u_xlat2, 0.0);
    u_xlati2 = int(u_xlat2);
    u_xlat4 = (-_Timer) + 1.0;
    u_xlat6 = (-_AlphaOverLife.y) + 1.0;
    u_xlat4 = u_xlat4 / u_xlat6;
    u_xlat0.x = (u_xlati2 != 0) ? u_xlat0.x : u_xlat4;
    vs_COLOR0.w = u_xlat0.x;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor0;
uniform 	mediump vec4 _TintColor1;
uniform 	mediump vec4 _TintColor2;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
in highp float vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp vec3 u_xlat10_0;
int u_xlati0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_10;
void main()
{
    u_xlat0 = vs_TEXCOORD1 + 0.999000013;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD1) + 1.99900007;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = vs_TEXCOORD2 + 0.999000013;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = vs_TEXCOORD0.x + 1.99900007;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.x) + 3.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = vs_TEXCOORD0.y + 0.999000013;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.y) + 3.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = (-_TintColor0.xyz) + _TintColor1.xyz;
    u_xlat16_1.xyz = u_xlat10_0.xxx * u_xlat16_1.xyz + _TintColor0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _TintColor2.xyz;
    u_xlat16_1.xyz = u_xlat10_0.yyy * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_10 = _EmissionScaler + _EmissionScaler;
    u_xlat16_2.xyz = vec3(u_xlat16_10) * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    SV_Target0.w = u_xlat10_0.z * vs_COLOR0.w;
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
uniform 	vec4 _MainTex_ST;
uniform 	float _Timer;
uniform 	float _AppearTime;
uniform 	float _VanishTime;
uniform 	vec2 _AlphaOverLife;
uniform 	vec3 _CamForward;
uniform 	float _IsUseCamForward;
uniform 	vec4 hlslcc_mtx4x4_SizeOverLife[4];
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
out highp float vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat2;
int u_xlati2;
bool u_xlatb2;
float u_xlat4;
float u_xlat6;
int u_xlati6;
void main()
{
    u_xlat0.xyz = in_NORMAL0.zxy * _CamForward.yzx;
    u_xlat0.xyz = in_NORMAL0.yzx * _CamForward.zxy + (-u_xlat0.xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat6 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat6 = sqrt(u_xlat6);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6);
    u_xlat6 = (-_IsUseCamForward) + 1.5;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati6 = int(u_xlat6);
    u_xlat0.xyz = (int(u_xlati6) != 0) ? in_NORMAL0.xyz : u_xlat0.xyz;
    u_xlat6 = (-hlslcc_mtx4x4_SizeOverLife[1].x) + hlslcc_mtx4x4_SizeOverLife[2].x;
    u_xlat6 = u_xlat6 * 0.498999953 + hlslcc_mtx4x4_SizeOverLife[1].x;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6) + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_Timer);
#else
    u_xlatb0 = 0.5<_Timer;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(1.0>=_Timer);
#else
    u_xlatb2 = 1.0>=_Timer;
#endif
    u_xlatb0 = u_xlatb2 && u_xlatb0;
    u_xlat2 = in_TEXCOORD0.x / _AppearTime;
    u_xlat0.x = (u_xlatb0) ? in_TEXCOORD0.x : u_xlat2;
    u_xlat0.y = in_TEXCOORD0.y;
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = vec2(vec2(_VanishTime, _VanishTime)) + vec2(0.99000001, 1.0);
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat0.x = (u_xlati0 != 0) ? u_xlat0.y : _AppearTime;
    vs_TEXCOORD2 = u_xlat0.x + (-in_TEXCOORD0.x);
    vs_TEXCOORD1 = 0.100000001;
    u_xlat0.x = _Timer + (-_AlphaOverLife.x);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat2 = _Timer / _AlphaOverLife.x;
    u_xlat0.x = (u_xlati0 != 0) ? 1.0 : u_xlat2;
    u_xlat2 = (-_Timer) + _AlphaOverLife.y;
    u_xlat2 = u_xlat2 + 1.0;
    u_xlat2 = floor(u_xlat2);
    u_xlat2 = max(u_xlat2, 0.0);
    u_xlati2 = int(u_xlat2);
    u_xlat4 = (-_Timer) + 1.0;
    u_xlat6 = (-_AlphaOverLife.y) + 1.0;
    u_xlat4 = u_xlat4 / u_xlat6;
    u_xlat0.x = (u_xlati2 != 0) ? u_xlat0.x : u_xlat4;
    vs_COLOR0.w = u_xlat0.x;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor0;
uniform 	mediump vec4 _TintColor1;
uniform 	mediump vec4 _TintColor2;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
in highp float vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp vec3 u_xlat10_0;
int u_xlati0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_10;
void main()
{
    u_xlat0 = vs_TEXCOORD1 + 0.999000013;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD1) + 1.99900007;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = vs_TEXCOORD2 + 0.999000013;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = vs_TEXCOORD0.x + 1.99900007;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.x) + 3.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = vs_TEXCOORD0.y + 0.999000013;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.y) + 3.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = (-_TintColor0.xyz) + _TintColor1.xyz;
    u_xlat16_1.xyz = u_xlat10_0.xxx * u_xlat16_1.xyz + _TintColor0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _TintColor2.xyz;
    u_xlat16_1.xyz = u_xlat10_0.yyy * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_10 = _EmissionScaler + _EmissionScaler;
    u_xlat16_2.xyz = vec3(u_xlat16_10) * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    SV_Target0.w = u_xlat10_0.z * vs_COLOR0.w;
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
SubProgram "gles3 hw_tier00 " {
Keywords { "_EndMoveY_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _Timer;
uniform 	float _AppearTime;
uniform 	float _VanishTime;
uniform 	vec2 _AlphaOverLife;
uniform 	vec3 _CamForward;
uniform 	float _IsUseCamForward;
uniform 	vec4 hlslcc_mtx4x4_SizeOverLife[4];
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
out highp float vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat2;
int u_xlati2;
bool u_xlatb2;
float u_xlat4;
float u_xlat6;
int u_xlati6;
void main()
{
    u_xlat0.xyz = in_NORMAL0.zxy * _CamForward.yzx;
    u_xlat0.xyz = in_NORMAL0.yzx * _CamForward.zxy + (-u_xlat0.xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat6 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat6 = sqrt(u_xlat6);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6);
    u_xlat6 = (-_IsUseCamForward) + 1.5;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati6 = int(u_xlat6);
    u_xlat0.xyz = (int(u_xlati6) != 0) ? in_NORMAL0.xyz : u_xlat0.xyz;
    u_xlat6 = (-hlslcc_mtx4x4_SizeOverLife[1].x) + hlslcc_mtx4x4_SizeOverLife[2].x;
    u_xlat6 = u_xlat6 * 0.498999953 + hlslcc_mtx4x4_SizeOverLife[1].x;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6) + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_Timer);
#else
    u_xlatb0 = 0.5<_Timer;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(1.0>=_Timer);
#else
    u_xlatb2 = 1.0>=_Timer;
#endif
    u_xlatb0 = u_xlatb2 && u_xlatb0;
    u_xlat2 = in_TEXCOORD0.y + _Timer;
    u_xlat1.y = u_xlat2 + 0.5;
    u_xlat1.z = in_TEXCOORD0.x / _AppearTime;
    u_xlat1.xw = in_TEXCOORD0.xy;
    u_xlat0.xy = (bool(u_xlatb0)) ? u_xlat1.xy : u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = vec2(vec2(_VanishTime, _VanishTime)) + vec2(0.99000001, 1.0);
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat0.x = (u_xlati0 != 0) ? u_xlat0.y : _AppearTime;
    vs_TEXCOORD2 = u_xlat0.x + (-in_TEXCOORD0.x);
    vs_TEXCOORD1 = 0.100000001;
    u_xlat0.x = _Timer + (-_AlphaOverLife.x);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat2 = _Timer / _AlphaOverLife.x;
    u_xlat0.x = (u_xlati0 != 0) ? 1.0 : u_xlat2;
    u_xlat2 = (-_Timer) + _AlphaOverLife.y;
    u_xlat2 = u_xlat2 + 1.0;
    u_xlat2 = floor(u_xlat2);
    u_xlat2 = max(u_xlat2, 0.0);
    u_xlati2 = int(u_xlat2);
    u_xlat4 = (-_Timer) + 1.0;
    u_xlat6 = (-_AlphaOverLife.y) + 1.0;
    u_xlat4 = u_xlat4 / u_xlat6;
    u_xlat0.x = (u_xlati2 != 0) ? u_xlat0.x : u_xlat4;
    vs_COLOR0.w = u_xlat0.x;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor0;
uniform 	mediump vec4 _TintColor1;
uniform 	mediump vec4 _TintColor2;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
in highp float vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp vec3 u_xlat10_0;
int u_xlati0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_10;
void main()
{
    u_xlat0 = vs_TEXCOORD1 + 0.999000013;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD1) + 1.99900007;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = vs_TEXCOORD2 + 0.999000013;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = vs_TEXCOORD0.x + 1.99900007;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.x) + 3.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = vs_TEXCOORD0.y + 0.999000013;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.y) + 3.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = (-_TintColor0.xyz) + _TintColor1.xyz;
    u_xlat16_1.xyz = u_xlat10_0.xxx * u_xlat16_1.xyz + _TintColor0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _TintColor2.xyz;
    u_xlat16_1.xyz = u_xlat10_0.yyy * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_10 = _EmissionScaler + _EmissionScaler;
    u_xlat16_2.xyz = vec3(u_xlat16_10) * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    SV_Target0.w = u_xlat10_0.z * vs_COLOR0.w;
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
Keywords { "_EndMoveY_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _Timer;
uniform 	float _AppearTime;
uniform 	float _VanishTime;
uniform 	vec2 _AlphaOverLife;
uniform 	vec3 _CamForward;
uniform 	float _IsUseCamForward;
uniform 	vec4 hlslcc_mtx4x4_SizeOverLife[4];
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
out highp float vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat2;
int u_xlati2;
bool u_xlatb2;
float u_xlat4;
float u_xlat6;
int u_xlati6;
void main()
{
    u_xlat0.xyz = in_NORMAL0.zxy * _CamForward.yzx;
    u_xlat0.xyz = in_NORMAL0.yzx * _CamForward.zxy + (-u_xlat0.xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat6 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat6 = sqrt(u_xlat6);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6);
    u_xlat6 = (-_IsUseCamForward) + 1.5;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati6 = int(u_xlat6);
    u_xlat0.xyz = (int(u_xlati6) != 0) ? in_NORMAL0.xyz : u_xlat0.xyz;
    u_xlat6 = (-hlslcc_mtx4x4_SizeOverLife[1].x) + hlslcc_mtx4x4_SizeOverLife[2].x;
    u_xlat6 = u_xlat6 * 0.498999953 + hlslcc_mtx4x4_SizeOverLife[1].x;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6) + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_Timer);
#else
    u_xlatb0 = 0.5<_Timer;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(1.0>=_Timer);
#else
    u_xlatb2 = 1.0>=_Timer;
#endif
    u_xlatb0 = u_xlatb2 && u_xlatb0;
    u_xlat2 = in_TEXCOORD0.y + _Timer;
    u_xlat1.y = u_xlat2 + 0.5;
    u_xlat1.z = in_TEXCOORD0.x / _AppearTime;
    u_xlat1.xw = in_TEXCOORD0.xy;
    u_xlat0.xy = (bool(u_xlatb0)) ? u_xlat1.xy : u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = vec2(vec2(_VanishTime, _VanishTime)) + vec2(0.99000001, 1.0);
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat0.x = (u_xlati0 != 0) ? u_xlat0.y : _AppearTime;
    vs_TEXCOORD2 = u_xlat0.x + (-in_TEXCOORD0.x);
    vs_TEXCOORD1 = 0.100000001;
    u_xlat0.x = _Timer + (-_AlphaOverLife.x);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat2 = _Timer / _AlphaOverLife.x;
    u_xlat0.x = (u_xlati0 != 0) ? 1.0 : u_xlat2;
    u_xlat2 = (-_Timer) + _AlphaOverLife.y;
    u_xlat2 = u_xlat2 + 1.0;
    u_xlat2 = floor(u_xlat2);
    u_xlat2 = max(u_xlat2, 0.0);
    u_xlati2 = int(u_xlat2);
    u_xlat4 = (-_Timer) + 1.0;
    u_xlat6 = (-_AlphaOverLife.y) + 1.0;
    u_xlat4 = u_xlat4 / u_xlat6;
    u_xlat0.x = (u_xlati2 != 0) ? u_xlat0.x : u_xlat4;
    vs_COLOR0.w = u_xlat0.x;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor0;
uniform 	mediump vec4 _TintColor1;
uniform 	mediump vec4 _TintColor2;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
in highp float vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp vec3 u_xlat10_0;
int u_xlati0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_10;
void main()
{
    u_xlat0 = vs_TEXCOORD1 + 0.999000013;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD1) + 1.99900007;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = vs_TEXCOORD2 + 0.999000013;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = vs_TEXCOORD0.x + 1.99900007;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.x) + 3.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = vs_TEXCOORD0.y + 0.999000013;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.y) + 3.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = (-_TintColor0.xyz) + _TintColor1.xyz;
    u_xlat16_1.xyz = u_xlat10_0.xxx * u_xlat16_1.xyz + _TintColor0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _TintColor2.xyz;
    u_xlat16_1.xyz = u_xlat10_0.yyy * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_10 = _EmissionScaler + _EmissionScaler;
    u_xlat16_2.xyz = vec3(u_xlat16_10) * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    SV_Target0.w = u_xlat10_0.z * vs_COLOR0.w;
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
Keywords { "_EndMoveY_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _Timer;
uniform 	float _AppearTime;
uniform 	float _VanishTime;
uniform 	vec2 _AlphaOverLife;
uniform 	vec3 _CamForward;
uniform 	float _IsUseCamForward;
uniform 	vec4 hlslcc_mtx4x4_SizeOverLife[4];
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
out highp float vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat2;
int u_xlati2;
bool u_xlatb2;
float u_xlat4;
float u_xlat6;
int u_xlati6;
void main()
{
    u_xlat0.xyz = in_NORMAL0.zxy * _CamForward.yzx;
    u_xlat0.xyz = in_NORMAL0.yzx * _CamForward.zxy + (-u_xlat0.xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat6 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat6 = sqrt(u_xlat6);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6);
    u_xlat6 = (-_IsUseCamForward) + 1.5;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati6 = int(u_xlat6);
    u_xlat0.xyz = (int(u_xlati6) != 0) ? in_NORMAL0.xyz : u_xlat0.xyz;
    u_xlat6 = (-hlslcc_mtx4x4_SizeOverLife[1].x) + hlslcc_mtx4x4_SizeOverLife[2].x;
    u_xlat6 = u_xlat6 * 0.498999953 + hlslcc_mtx4x4_SizeOverLife[1].x;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6) + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_Timer);
#else
    u_xlatb0 = 0.5<_Timer;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(1.0>=_Timer);
#else
    u_xlatb2 = 1.0>=_Timer;
#endif
    u_xlatb0 = u_xlatb2 && u_xlatb0;
    u_xlat2 = in_TEXCOORD0.y + _Timer;
    u_xlat1.y = u_xlat2 + 0.5;
    u_xlat1.z = in_TEXCOORD0.x / _AppearTime;
    u_xlat1.xw = in_TEXCOORD0.xy;
    u_xlat0.xy = (bool(u_xlatb0)) ? u_xlat1.xy : u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = vec2(vec2(_VanishTime, _VanishTime)) + vec2(0.99000001, 1.0);
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat0.x = (u_xlati0 != 0) ? u_xlat0.y : _AppearTime;
    vs_TEXCOORD2 = u_xlat0.x + (-in_TEXCOORD0.x);
    vs_TEXCOORD1 = 0.100000001;
    u_xlat0.x = _Timer + (-_AlphaOverLife.x);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat2 = _Timer / _AlphaOverLife.x;
    u_xlat0.x = (u_xlati0 != 0) ? 1.0 : u_xlat2;
    u_xlat2 = (-_Timer) + _AlphaOverLife.y;
    u_xlat2 = u_xlat2 + 1.0;
    u_xlat2 = floor(u_xlat2);
    u_xlat2 = max(u_xlat2, 0.0);
    u_xlati2 = int(u_xlat2);
    u_xlat4 = (-_Timer) + 1.0;
    u_xlat6 = (-_AlphaOverLife.y) + 1.0;
    u_xlat4 = u_xlat4 / u_xlat6;
    u_xlat0.x = (u_xlati2 != 0) ? u_xlat0.x : u_xlat4;
    vs_COLOR0.w = u_xlat0.x;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor0;
uniform 	mediump vec4 _TintColor1;
uniform 	mediump vec4 _TintColor2;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
in highp float vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp vec3 u_xlat10_0;
int u_xlati0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_10;
void main()
{
    u_xlat0 = vs_TEXCOORD1 + 0.999000013;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD1) + 1.99900007;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = vs_TEXCOORD2 + 0.999000013;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = vs_TEXCOORD0.x + 1.99900007;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.x) + 3.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = vs_TEXCOORD0.y + 0.999000013;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.y) + 3.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = (-_TintColor0.xyz) + _TintColor1.xyz;
    u_xlat16_1.xyz = u_xlat10_0.xxx * u_xlat16_1.xyz + _TintColor0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _TintColor2.xyz;
    u_xlat16_1.xyz = u_xlat10_0.yyy * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_10 = _EmissionScaler + _EmissionScaler;
    u_xlat16_2.xyz = vec3(u_xlat16_10) * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    SV_Target0.w = u_xlat10_0.z * vs_COLOR0.w;
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
SubProgram "gles3 hw_tier00 " {
Keywords { "_EndMoveX_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _Timer;
uniform 	float _AppearTime;
uniform 	float _VanishTime;
uniform 	vec2 _AlphaOverLife;
uniform 	vec3 _CamForward;
uniform 	float _IsUseCamForward;
uniform 	vec4 hlslcc_mtx4x4_SizeOverLife[4];
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
out highp float vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat2;
int u_xlati2;
float u_xlat4;
bool u_xlatb4;
float u_xlat6;
int u_xlati6;
void main()
{
    u_xlat0.xyz = in_NORMAL0.zxy * _CamForward.yzx;
    u_xlat0.xyz = in_NORMAL0.yzx * _CamForward.zxy + (-u_xlat0.xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat6 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat6 = sqrt(u_xlat6);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6);
    u_xlat6 = (-_IsUseCamForward) + 1.5;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati6 = int(u_xlat6);
    u_xlat0.xyz = (int(u_xlati6) != 0) ? in_NORMAL0.xyz : u_xlat0.xyz;
    u_xlat6 = (-hlslcc_mtx4x4_SizeOverLife[1].x) + hlslcc_mtx4x4_SizeOverLife[2].x;
    u_xlat6 = u_xlat6 * 0.498999953 + hlslcc_mtx4x4_SizeOverLife[1].x;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6) + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.xyz = vec3(_VanishTime, _VanishTime, _Timer) + vec3(0.99000001, 1.0, 0.5);
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat0.x = (u_xlati0 != 0) ? u_xlat0.y : _AppearTime;
    u_xlat2 = (-u_xlat0.z) + in_TEXCOORD0.x;
    vs_TEXCOORD2 = u_xlat0.x + (-in_TEXCOORD0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_Timer);
#else
    u_xlatb0 = 0.5<_Timer;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(1.0>=_Timer);
#else
    u_xlatb4 = 1.0>=_Timer;
#endif
    u_xlatb0 = u_xlatb4 && u_xlatb0;
    u_xlat4 = in_TEXCOORD0.x / _AppearTime;
    u_xlat0.x = (u_xlatb0) ? u_xlat2 : u_xlat4;
    u_xlat0.y = in_TEXCOORD0.y;
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = 0.100000001;
    u_xlat0.x = _Timer + (-_AlphaOverLife.x);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat2 = _Timer / _AlphaOverLife.x;
    u_xlat0.x = (u_xlati0 != 0) ? 1.0 : u_xlat2;
    u_xlat2 = (-_Timer) + _AlphaOverLife.y;
    u_xlat2 = u_xlat2 + 1.0;
    u_xlat2 = floor(u_xlat2);
    u_xlat2 = max(u_xlat2, 0.0);
    u_xlati2 = int(u_xlat2);
    u_xlat4 = (-_Timer) + 1.0;
    u_xlat6 = (-_AlphaOverLife.y) + 1.0;
    u_xlat4 = u_xlat4 / u_xlat6;
    u_xlat0.x = (u_xlati2 != 0) ? u_xlat0.x : u_xlat4;
    vs_COLOR0.w = u_xlat0.x;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor0;
uniform 	mediump vec4 _TintColor1;
uniform 	mediump vec4 _TintColor2;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
in highp float vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp vec3 u_xlat10_0;
int u_xlati0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_10;
void main()
{
    u_xlat0 = vs_TEXCOORD1 + 0.999000013;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD1) + 1.99900007;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = vs_TEXCOORD2 + 0.999000013;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = vs_TEXCOORD0.x + 1.99900007;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.x) + 3.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = vs_TEXCOORD0.y + 0.999000013;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.y) + 3.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = (-_TintColor0.xyz) + _TintColor1.xyz;
    u_xlat16_1.xyz = u_xlat10_0.xxx * u_xlat16_1.xyz + _TintColor0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _TintColor2.xyz;
    u_xlat16_1.xyz = u_xlat10_0.yyy * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_10 = _EmissionScaler + _EmissionScaler;
    u_xlat16_2.xyz = vec3(u_xlat16_10) * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    SV_Target0.w = u_xlat10_0.z * vs_COLOR0.w;
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
Keywords { "_EndMoveX_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _Timer;
uniform 	float _AppearTime;
uniform 	float _VanishTime;
uniform 	vec2 _AlphaOverLife;
uniform 	vec3 _CamForward;
uniform 	float _IsUseCamForward;
uniform 	vec4 hlslcc_mtx4x4_SizeOverLife[4];
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
out highp float vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat2;
int u_xlati2;
float u_xlat4;
bool u_xlatb4;
float u_xlat6;
int u_xlati6;
void main()
{
    u_xlat0.xyz = in_NORMAL0.zxy * _CamForward.yzx;
    u_xlat0.xyz = in_NORMAL0.yzx * _CamForward.zxy + (-u_xlat0.xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat6 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat6 = sqrt(u_xlat6);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6);
    u_xlat6 = (-_IsUseCamForward) + 1.5;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati6 = int(u_xlat6);
    u_xlat0.xyz = (int(u_xlati6) != 0) ? in_NORMAL0.xyz : u_xlat0.xyz;
    u_xlat6 = (-hlslcc_mtx4x4_SizeOverLife[1].x) + hlslcc_mtx4x4_SizeOverLife[2].x;
    u_xlat6 = u_xlat6 * 0.498999953 + hlslcc_mtx4x4_SizeOverLife[1].x;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6) + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.xyz = vec3(_VanishTime, _VanishTime, _Timer) + vec3(0.99000001, 1.0, 0.5);
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat0.x = (u_xlati0 != 0) ? u_xlat0.y : _AppearTime;
    u_xlat2 = (-u_xlat0.z) + in_TEXCOORD0.x;
    vs_TEXCOORD2 = u_xlat0.x + (-in_TEXCOORD0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_Timer);
#else
    u_xlatb0 = 0.5<_Timer;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(1.0>=_Timer);
#else
    u_xlatb4 = 1.0>=_Timer;
#endif
    u_xlatb0 = u_xlatb4 && u_xlatb0;
    u_xlat4 = in_TEXCOORD0.x / _AppearTime;
    u_xlat0.x = (u_xlatb0) ? u_xlat2 : u_xlat4;
    u_xlat0.y = in_TEXCOORD0.y;
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = 0.100000001;
    u_xlat0.x = _Timer + (-_AlphaOverLife.x);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat2 = _Timer / _AlphaOverLife.x;
    u_xlat0.x = (u_xlati0 != 0) ? 1.0 : u_xlat2;
    u_xlat2 = (-_Timer) + _AlphaOverLife.y;
    u_xlat2 = u_xlat2 + 1.0;
    u_xlat2 = floor(u_xlat2);
    u_xlat2 = max(u_xlat2, 0.0);
    u_xlati2 = int(u_xlat2);
    u_xlat4 = (-_Timer) + 1.0;
    u_xlat6 = (-_AlphaOverLife.y) + 1.0;
    u_xlat4 = u_xlat4 / u_xlat6;
    u_xlat0.x = (u_xlati2 != 0) ? u_xlat0.x : u_xlat4;
    vs_COLOR0.w = u_xlat0.x;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor0;
uniform 	mediump vec4 _TintColor1;
uniform 	mediump vec4 _TintColor2;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
in highp float vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp vec3 u_xlat10_0;
int u_xlati0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_10;
void main()
{
    u_xlat0 = vs_TEXCOORD1 + 0.999000013;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD1) + 1.99900007;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = vs_TEXCOORD2 + 0.999000013;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = vs_TEXCOORD0.x + 1.99900007;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.x) + 3.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = vs_TEXCOORD0.y + 0.999000013;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.y) + 3.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = (-_TintColor0.xyz) + _TintColor1.xyz;
    u_xlat16_1.xyz = u_xlat10_0.xxx * u_xlat16_1.xyz + _TintColor0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _TintColor2.xyz;
    u_xlat16_1.xyz = u_xlat10_0.yyy * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_10 = _EmissionScaler + _EmissionScaler;
    u_xlat16_2.xyz = vec3(u_xlat16_10) * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    SV_Target0.w = u_xlat10_0.z * vs_COLOR0.w;
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
Keywords { "_EndMoveX_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _Timer;
uniform 	float _AppearTime;
uniform 	float _VanishTime;
uniform 	vec2 _AlphaOverLife;
uniform 	vec3 _CamForward;
uniform 	float _IsUseCamForward;
uniform 	vec4 hlslcc_mtx4x4_SizeOverLife[4];
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
out highp float vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat2;
int u_xlati2;
float u_xlat4;
bool u_xlatb4;
float u_xlat6;
int u_xlati6;
void main()
{
    u_xlat0.xyz = in_NORMAL0.zxy * _CamForward.yzx;
    u_xlat0.xyz = in_NORMAL0.yzx * _CamForward.zxy + (-u_xlat0.xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat6 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat6 = sqrt(u_xlat6);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6);
    u_xlat6 = (-_IsUseCamForward) + 1.5;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati6 = int(u_xlat6);
    u_xlat0.xyz = (int(u_xlati6) != 0) ? in_NORMAL0.xyz : u_xlat0.xyz;
    u_xlat6 = (-hlslcc_mtx4x4_SizeOverLife[1].x) + hlslcc_mtx4x4_SizeOverLife[2].x;
    u_xlat6 = u_xlat6 * 0.498999953 + hlslcc_mtx4x4_SizeOverLife[1].x;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6) + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.xyz = vec3(_VanishTime, _VanishTime, _Timer) + vec3(0.99000001, 1.0, 0.5);
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat0.x = (u_xlati0 != 0) ? u_xlat0.y : _AppearTime;
    u_xlat2 = (-u_xlat0.z) + in_TEXCOORD0.x;
    vs_TEXCOORD2 = u_xlat0.x + (-in_TEXCOORD0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_Timer);
#else
    u_xlatb0 = 0.5<_Timer;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(1.0>=_Timer);
#else
    u_xlatb4 = 1.0>=_Timer;
#endif
    u_xlatb0 = u_xlatb4 && u_xlatb0;
    u_xlat4 = in_TEXCOORD0.x / _AppearTime;
    u_xlat0.x = (u_xlatb0) ? u_xlat2 : u_xlat4;
    u_xlat0.y = in_TEXCOORD0.y;
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = 0.100000001;
    u_xlat0.x = _Timer + (-_AlphaOverLife.x);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat2 = _Timer / _AlphaOverLife.x;
    u_xlat0.x = (u_xlati0 != 0) ? 1.0 : u_xlat2;
    u_xlat2 = (-_Timer) + _AlphaOverLife.y;
    u_xlat2 = u_xlat2 + 1.0;
    u_xlat2 = floor(u_xlat2);
    u_xlat2 = max(u_xlat2, 0.0);
    u_xlati2 = int(u_xlat2);
    u_xlat4 = (-_Timer) + 1.0;
    u_xlat6 = (-_AlphaOverLife.y) + 1.0;
    u_xlat4 = u_xlat4 / u_xlat6;
    u_xlat0.x = (u_xlati2 != 0) ? u_xlat0.x : u_xlat4;
    vs_COLOR0.w = u_xlat0.x;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor0;
uniform 	mediump vec4 _TintColor1;
uniform 	mediump vec4 _TintColor2;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
in highp float vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp vec3 u_xlat10_0;
int u_xlati0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_10;
void main()
{
    u_xlat0 = vs_TEXCOORD1 + 0.999000013;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD1) + 1.99900007;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = vs_TEXCOORD2 + 0.999000013;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = vs_TEXCOORD0.x + 1.99900007;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.x) + 3.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = vs_TEXCOORD0.y + 0.999000013;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.y) + 3.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = (-_TintColor0.xyz) + _TintColor1.xyz;
    u_xlat16_1.xyz = u_xlat10_0.xxx * u_xlat16_1.xyz + _TintColor0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _TintColor2.xyz;
    u_xlat16_1.xyz = u_xlat10_0.yyy * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_10 = _EmissionScaler + _EmissionScaler;
    u_xlat16_2.xyz = vec3(u_xlat16_10) * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    SV_Target0.w = u_xlat10_0.z * vs_COLOR0.w;
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
SubProgram "gles3 hw_tier00 " {
Keywords { "_EndMoveX_ON" "_EndMoveY_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _Timer;
uniform 	float _AppearTime;
uniform 	float _VanishTime;
uniform 	vec2 _AlphaOverLife;
uniform 	vec3 _CamForward;
uniform 	float _IsUseCamForward;
uniform 	vec4 hlslcc_mtx4x4_SizeOverLife[4];
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
out highp float vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
vec2 u_xlat2;
vec3 u_xlat3;
int u_xlati3;
bool u_xlatb3;
float u_xlat6;
float u_xlat9;
int u_xlati9;
void main()
{
    u_xlat0.xyz = in_NORMAL0.zxy * _CamForward.yzx;
    u_xlat0.xyz = in_NORMAL0.yzx * _CamForward.zxy + (-u_xlat0.xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat9 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat9 = sqrt(u_xlat9);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9);
    u_xlat9 = (-_IsUseCamForward) + 1.5;
    u_xlat9 = floor(u_xlat9);
    u_xlat9 = max(u_xlat9, 0.0);
    u_xlati9 = int(u_xlat9);
    u_xlat0.xyz = (int(u_xlati9) != 0) ? in_NORMAL0.xyz : u_xlat0.xyz;
    u_xlat9 = (-hlslcc_mtx4x4_SizeOverLife[1].x) + hlslcc_mtx4x4_SizeOverLife[2].x;
    u_xlat9 = u_xlat9 * 0.498999953 + hlslcc_mtx4x4_SizeOverLife[1].x;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_Timer);
#else
    u_xlatb0 = 0.5<_Timer;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(1.0>=_Timer);
#else
    u_xlatb3 = 1.0>=_Timer;
#endif
    u_xlatb0 = u_xlatb3 && u_xlatb0;
    u_xlat1.x = in_TEXCOORD0.x / _AppearTime;
    u_xlat1.y = in_TEXCOORD0.y;
    u_xlat3.xyz = vec3(_VanishTime, _VanishTime, _Timer) + vec3(0.99000001, 1.0, 0.5);
    u_xlat2.x = (-u_xlat3.z) + in_TEXCOORD0.x;
    u_xlat2.y = u_xlat3.z + in_TEXCOORD0.y;
    u_xlat0.xw = (bool(u_xlatb0)) ? u_xlat2.xy : u_xlat1.xy;
    vs_TEXCOORD0.xy = u_xlat0.xw * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = floor(u_xlat3.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat0.x = (u_xlati0 != 0) ? u_xlat3.y : _AppearTime;
    vs_TEXCOORD2 = u_xlat0.x + (-in_TEXCOORD0.x);
    vs_TEXCOORD1 = 0.100000001;
    u_xlat0.x = _Timer + (-_AlphaOverLife.x);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat3.x = _Timer / _AlphaOverLife.x;
    u_xlat0.x = (u_xlati0 != 0) ? 1.0 : u_xlat3.x;
    u_xlat3.x = (-_Timer) + _AlphaOverLife.y;
    u_xlat3.x = u_xlat3.x + 1.0;
    u_xlat3.x = floor(u_xlat3.x);
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlati3 = int(u_xlat3.x);
    u_xlat6 = (-_Timer) + 1.0;
    u_xlat9 = (-_AlphaOverLife.y) + 1.0;
    u_xlat6 = u_xlat6 / u_xlat9;
    u_xlat0.x = (u_xlati3 != 0) ? u_xlat0.x : u_xlat6;
    vs_COLOR0.w = u_xlat0.x;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor0;
uniform 	mediump vec4 _TintColor1;
uniform 	mediump vec4 _TintColor2;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
in highp float vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp vec3 u_xlat10_0;
int u_xlati0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_10;
void main()
{
    u_xlat0 = vs_TEXCOORD1 + 0.999000013;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD1) + 1.99900007;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = vs_TEXCOORD2 + 0.999000013;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = vs_TEXCOORD0.x + 1.99900007;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.x) + 3.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = vs_TEXCOORD0.y + 0.999000013;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.y) + 3.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = (-_TintColor0.xyz) + _TintColor1.xyz;
    u_xlat16_1.xyz = u_xlat10_0.xxx * u_xlat16_1.xyz + _TintColor0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _TintColor2.xyz;
    u_xlat16_1.xyz = u_xlat10_0.yyy * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_10 = _EmissionScaler + _EmissionScaler;
    u_xlat16_2.xyz = vec3(u_xlat16_10) * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    SV_Target0.w = u_xlat10_0.z * vs_COLOR0.w;
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
Keywords { "_EndMoveX_ON" "_EndMoveY_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _Timer;
uniform 	float _AppearTime;
uniform 	float _VanishTime;
uniform 	vec2 _AlphaOverLife;
uniform 	vec3 _CamForward;
uniform 	float _IsUseCamForward;
uniform 	vec4 hlslcc_mtx4x4_SizeOverLife[4];
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
out highp float vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
vec2 u_xlat2;
vec3 u_xlat3;
int u_xlati3;
bool u_xlatb3;
float u_xlat6;
float u_xlat9;
int u_xlati9;
void main()
{
    u_xlat0.xyz = in_NORMAL0.zxy * _CamForward.yzx;
    u_xlat0.xyz = in_NORMAL0.yzx * _CamForward.zxy + (-u_xlat0.xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat9 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat9 = sqrt(u_xlat9);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9);
    u_xlat9 = (-_IsUseCamForward) + 1.5;
    u_xlat9 = floor(u_xlat9);
    u_xlat9 = max(u_xlat9, 0.0);
    u_xlati9 = int(u_xlat9);
    u_xlat0.xyz = (int(u_xlati9) != 0) ? in_NORMAL0.xyz : u_xlat0.xyz;
    u_xlat9 = (-hlslcc_mtx4x4_SizeOverLife[1].x) + hlslcc_mtx4x4_SizeOverLife[2].x;
    u_xlat9 = u_xlat9 * 0.498999953 + hlslcc_mtx4x4_SizeOverLife[1].x;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_Timer);
#else
    u_xlatb0 = 0.5<_Timer;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(1.0>=_Timer);
#else
    u_xlatb3 = 1.0>=_Timer;
#endif
    u_xlatb0 = u_xlatb3 && u_xlatb0;
    u_xlat1.x = in_TEXCOORD0.x / _AppearTime;
    u_xlat1.y = in_TEXCOORD0.y;
    u_xlat3.xyz = vec3(_VanishTime, _VanishTime, _Timer) + vec3(0.99000001, 1.0, 0.5);
    u_xlat2.x = (-u_xlat3.z) + in_TEXCOORD0.x;
    u_xlat2.y = u_xlat3.z + in_TEXCOORD0.y;
    u_xlat0.xw = (bool(u_xlatb0)) ? u_xlat2.xy : u_xlat1.xy;
    vs_TEXCOORD0.xy = u_xlat0.xw * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = floor(u_xlat3.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat0.x = (u_xlati0 != 0) ? u_xlat3.y : _AppearTime;
    vs_TEXCOORD2 = u_xlat0.x + (-in_TEXCOORD0.x);
    vs_TEXCOORD1 = 0.100000001;
    u_xlat0.x = _Timer + (-_AlphaOverLife.x);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat3.x = _Timer / _AlphaOverLife.x;
    u_xlat0.x = (u_xlati0 != 0) ? 1.0 : u_xlat3.x;
    u_xlat3.x = (-_Timer) + _AlphaOverLife.y;
    u_xlat3.x = u_xlat3.x + 1.0;
    u_xlat3.x = floor(u_xlat3.x);
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlati3 = int(u_xlat3.x);
    u_xlat6 = (-_Timer) + 1.0;
    u_xlat9 = (-_AlphaOverLife.y) + 1.0;
    u_xlat6 = u_xlat6 / u_xlat9;
    u_xlat0.x = (u_xlati3 != 0) ? u_xlat0.x : u_xlat6;
    vs_COLOR0.w = u_xlat0.x;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor0;
uniform 	mediump vec4 _TintColor1;
uniform 	mediump vec4 _TintColor2;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
in highp float vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp vec3 u_xlat10_0;
int u_xlati0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_10;
void main()
{
    u_xlat0 = vs_TEXCOORD1 + 0.999000013;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD1) + 1.99900007;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = vs_TEXCOORD2 + 0.999000013;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = vs_TEXCOORD0.x + 1.99900007;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.x) + 3.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = vs_TEXCOORD0.y + 0.999000013;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.y) + 3.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = (-_TintColor0.xyz) + _TintColor1.xyz;
    u_xlat16_1.xyz = u_xlat10_0.xxx * u_xlat16_1.xyz + _TintColor0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _TintColor2.xyz;
    u_xlat16_1.xyz = u_xlat10_0.yyy * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_10 = _EmissionScaler + _EmissionScaler;
    u_xlat16_2.xyz = vec3(u_xlat16_10) * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    SV_Target0.w = u_xlat10_0.z * vs_COLOR0.w;
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
Keywords { "_EndMoveX_ON" "_EndMoveY_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _Timer;
uniform 	float _AppearTime;
uniform 	float _VanishTime;
uniform 	vec2 _AlphaOverLife;
uniform 	vec3 _CamForward;
uniform 	float _IsUseCamForward;
uniform 	vec4 hlslcc_mtx4x4_SizeOverLife[4];
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
out highp float vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
vec2 u_xlat2;
vec3 u_xlat3;
int u_xlati3;
bool u_xlatb3;
float u_xlat6;
float u_xlat9;
int u_xlati9;
void main()
{
    u_xlat0.xyz = in_NORMAL0.zxy * _CamForward.yzx;
    u_xlat0.xyz = in_NORMAL0.yzx * _CamForward.zxy + (-u_xlat0.xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat9 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat9 = sqrt(u_xlat9);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9);
    u_xlat9 = (-_IsUseCamForward) + 1.5;
    u_xlat9 = floor(u_xlat9);
    u_xlat9 = max(u_xlat9, 0.0);
    u_xlati9 = int(u_xlat9);
    u_xlat0.xyz = (int(u_xlati9) != 0) ? in_NORMAL0.xyz : u_xlat0.xyz;
    u_xlat9 = (-hlslcc_mtx4x4_SizeOverLife[1].x) + hlslcc_mtx4x4_SizeOverLife[2].x;
    u_xlat9 = u_xlat9 * 0.498999953 + hlslcc_mtx4x4_SizeOverLife[1].x;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_Timer);
#else
    u_xlatb0 = 0.5<_Timer;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(1.0>=_Timer);
#else
    u_xlatb3 = 1.0>=_Timer;
#endif
    u_xlatb0 = u_xlatb3 && u_xlatb0;
    u_xlat1.x = in_TEXCOORD0.x / _AppearTime;
    u_xlat1.y = in_TEXCOORD0.y;
    u_xlat3.xyz = vec3(_VanishTime, _VanishTime, _Timer) + vec3(0.99000001, 1.0, 0.5);
    u_xlat2.x = (-u_xlat3.z) + in_TEXCOORD0.x;
    u_xlat2.y = u_xlat3.z + in_TEXCOORD0.y;
    u_xlat0.xw = (bool(u_xlatb0)) ? u_xlat2.xy : u_xlat1.xy;
    vs_TEXCOORD0.xy = u_xlat0.xw * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = floor(u_xlat3.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat0.x = (u_xlati0 != 0) ? u_xlat3.y : _AppearTime;
    vs_TEXCOORD2 = u_xlat0.x + (-in_TEXCOORD0.x);
    vs_TEXCOORD1 = 0.100000001;
    u_xlat0.x = _Timer + (-_AlphaOverLife.x);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat3.x = _Timer / _AlphaOverLife.x;
    u_xlat0.x = (u_xlati0 != 0) ? 1.0 : u_xlat3.x;
    u_xlat3.x = (-_Timer) + _AlphaOverLife.y;
    u_xlat3.x = u_xlat3.x + 1.0;
    u_xlat3.x = floor(u_xlat3.x);
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlati3 = int(u_xlat3.x);
    u_xlat6 = (-_Timer) + 1.0;
    u_xlat9 = (-_AlphaOverLife.y) + 1.0;
    u_xlat6 = u_xlat6 / u_xlat9;
    u_xlat0.x = (u_xlati3 != 0) ? u_xlat0.x : u_xlat6;
    vs_COLOR0.w = u_xlat0.x;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor0;
uniform 	mediump vec4 _TintColor1;
uniform 	mediump vec4 _TintColor2;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
in highp float vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp vec3 u_xlat10_0;
int u_xlati0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_10;
void main()
{
    u_xlat0 = vs_TEXCOORD1 + 0.999000013;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD1) + 1.99900007;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = vs_TEXCOORD2 + 0.999000013;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = vs_TEXCOORD0.x + 1.99900007;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.x) + 3.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = vs_TEXCOORD0.y + 0.999000013;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.y) + 3.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = (-_TintColor0.xyz) + _TintColor1.xyz;
    u_xlat16_1.xyz = u_xlat10_0.xxx * u_xlat16_1.xyz + _TintColor0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _TintColor2.xyz;
    u_xlat16_1.xyz = u_xlat10_0.yyy * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_10 = _EmissionScaler + _EmissionScaler;
    u_xlat16_2.xyz = vec3(u_xlat16_10) * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    SV_Target0.w = u_xlat10_0.z * vs_COLOR0.w;
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
SubProgram "gles3 hw_tier00 " {
Keywords { "_EndMoveY_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_EndMoveY_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_EndMoveY_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_EndMoveX_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_EndMoveX_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_EndMoveX_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_EndMoveX_ON" "_EndMoveY_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_EndMoveX_ON" "_EndMoveY_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_EndMoveX_ON" "_EndMoveY_ON" }
""
}
}
}
}
CustomEditor "MoleMole.TrailShaderEditorBase"
}