//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_NewCommon/Scene_Grass" {
Properties {
[MHYHeaderBox(Surface)] _AlphaClip ("Alpha Clip", Range(0, 1)) = 0.5
_MainTex ("Base (RGB)", 2D) = "white" { }
_TipsColor ("Main Color", Color) = (0.1,0.9,0.1,1)
_RootColor ("Root Color", Color) = (0.1,0.7,0.1,1)
_ColorShift ("Color Shift", Range(0, 1)) = 0.5
_EnableOutline ("Enable Outline", Float) = 1
_OutlineColor ("Outline Color", Color) = (1,1,1,1)
_OutlinePower ("Outline Power", Range(0, 1)) = 0.5
[MHYHeaderBox(Swaying)] _Amplitude ("Amplitude", Range(0, 1)) = 1
_Frequency ("Frequency", Range(20, 50)) = 25
_SwayMax ("Sway Max", Range(0, 0.1)) = 0.005
[MHYHeaderBox(Interaction)] _IntrRadius ("Intr Radius", Range(0, 5)) = 1
_IntrSensitivity ("Intr Sensitivity", Range(0, 10)) = 1
_IntrMaxWidth ("Intr Max Width", Range(0, 2)) = 0.1
[MHYHeaderBox(Noise Map)] _EnableNoiseMap ("Enable NoiseMap", Float) = 1
_NoiseMap ("Noise Map", 2D) = "gray" { }
}
SubShader {
 LOD 200
 Tags { "DisableBatching" = "true" "QUEUE" = "AlphaTest-1" "RenderType" = "Opaque" }
 Pass {
  LOD 200
  Tags { "DisableBatching" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "AlphaTest-1" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 27729
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int _EnableNoiseMap;
uniform 	vec4 _NoiseMap_ST;
uniform 	mediump float _ColorShift;
uniform 	mediump float _SwayMax;
uniform 	mediump float _Amplitude;
uniform 	mediump float _Frequency;
uniform 	mediump float _IntrRadius;
uniform 	mediump float _IntrMaxWidth;
uniform 	mediump float _IntrSensitivity;
uniform 	vec3 _Positions[4];
uniform 	float _PositionArray;
uniform lowp sampler2D _NoiseMap;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec3 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec2 u_xlat2;
vec4 u_xlat3;
int u_xlati3;
float u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat7;
bool u_xlatb7;
vec2 u_xlat10;
vec2 u_xlat11;
float u_xlat12;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat16_1 = in_COLOR0.x * _Amplitude;
    u_xlat16_5 = in_COLOR0.y * 6.28318977;
    u_xlat2.xy = u_xlat0.xz * vec2(0.318309993, 0.318309993) + vec2(u_xlat16_5);
    u_xlat2.xy = _Time.xx * vec2(vec2(_Frequency, _Frequency)) + u_xlat2.xy;
    u_xlat2.xy = sin(u_xlat2.xy);
    u_xlat2.xy = vec2(u_xlat16_1) * u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_SwayMax, _SwayMax)) + in_POSITION0.xz;
    u_xlat12 = in_POSITION0.y * _IntrSensitivity;
    u_xlat10.xy = u_xlat2.xy;
    u_xlati3 = 0;
    while(true){
        u_xlat7.x = float(u_xlati3);
#ifdef UNITY_ADRENO_ES3
        u_xlatb7 = !!(u_xlat7.x>=_PositionArray);
#else
        u_xlatb7 = u_xlat7.x>=_PositionArray;
#endif
        if(u_xlatb7){break;}
        u_xlat7.xyz = (-u_xlat0.xyz) + _Positions[u_xlati3].xyz;
        u_xlat7.x = dot(u_xlat7.xyz, u_xlat7.xyz);
        u_xlat7.x = sqrt(u_xlat7.x);
        u_xlat7.x = u_xlat7.x / _IntrRadius;
#ifdef UNITY_ADRENO_ES3
        u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
        u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
        u_xlat7.x = (-u_xlat7.x) + 1.0;
        u_xlat11.xy = u_xlat0.xz + (-_Positions[u_xlati3].xz);
        u_xlat7.xy = u_xlat7.xx * u_xlat11.xy;
        u_xlat7.xy = u_xlat7.xy * in_COLOR0.xx;
        u_xlat7.xy = max(u_xlat7.xy, (-vec2(vec2(_IntrMaxWidth, _IntrMaxWidth))));
        u_xlat7.xy = min(u_xlat7.xy, vec2(vec2(_IntrMaxWidth, _IntrMaxWidth)));
        u_xlat10.xy = vec2(u_xlat12) * u_xlat7.xy + u_xlat10.xy;
        u_xlati3 = u_xlati3 + 1;
    }
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat10.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat10.yyyy + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat3;
    if(_EnableNoiseMap != 0) {
        u_xlat0.xy = u_xlat0.xz + u_xlat10.xy;
        u_xlat0.xy = u_xlat0.xy * _NoiseMap_ST.xy + _NoiseMap_ST.zw;
        u_xlat0.xy = textureLod(_NoiseMap, u_xlat0.xy, 0.0).xy;
    //ENDIF
    }
    u_xlat0.xy = u_xlat0.xy * in_COLOR0.xx;
    u_xlat4 = u_xlat0.y * _ColorShift;
    u_xlat0.y = u_xlat4 * 2.4000001;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0.xy = u_xlat0.xy;
    vs_COLOR0.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _AlphaClip;
uniform 	mediump vec4 _TipsColor;
uniform 	mediump vec4 _RootColor;
uniform 	int _EnableOutline;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump float _OutlinePower;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_1;
vec3 u_xlat2;
bool u_xlatb2;
mediump float u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_6;
bool u_xlatb17;
void main()
{
    u_xlat0.w = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = u_xlat0.w + (-_AlphaClip);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat16_1<0.0);
#else
    u_xlatb2 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
    u_xlat16_1 = log2(u_xlat0.w);
    u_xlat16_1 = u_xlat16_1 * _OutlinePower;
    u_xlat16_1 = exp2(u_xlat16_1);
    u_xlat16_6.xyz = _TipsColor.xyz + (-_RootColor.xyz);
    u_xlat16_6.xyz = vs_COLOR0.yyy * u_xlat16_6.xyz + _RootColor.xyz;
    u_xlat16_3 = vs_COLOR0.x + -0.5;
    u_xlat16_3 = u_xlat16_3 * 0.5 + 1.0;
    u_xlat2.xyz = u_xlat16_6.xyz * vec3(u_xlat16_3);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.xyz = min(max(u_xlat2.xyz, 0.0), 1.0);
#else
    u_xlat2.xyz = clamp(u_xlat2.xyz, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat2.xyz + (-_OutlineColor.xyz);
    u_xlat4.xyz = vec3(u_xlat16_1) * u_xlat4.xyz + _OutlineColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(0<_EnableOutline);
#else
    u_xlatb17 = 0<_EnableOutline;
#endif
    u_xlat0.xyz = (bool(u_xlatb17)) ? u_xlat4.xyz : u_xlat2.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int _EnableNoiseMap;
uniform 	vec4 _NoiseMap_ST;
uniform 	mediump float _ColorShift;
uniform 	mediump float _SwayMax;
uniform 	mediump float _Amplitude;
uniform 	mediump float _Frequency;
uniform 	mediump float _IntrRadius;
uniform 	mediump float _IntrMaxWidth;
uniform 	mediump float _IntrSensitivity;
uniform 	vec3 _Positions[4];
uniform 	float _PositionArray;
uniform lowp sampler2D _NoiseMap;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec3 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec2 u_xlat2;
vec4 u_xlat3;
int u_xlati3;
float u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat7;
bool u_xlatb7;
vec2 u_xlat10;
vec2 u_xlat11;
float u_xlat12;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat16_1 = in_COLOR0.x * _Amplitude;
    u_xlat16_5 = in_COLOR0.y * 6.28318977;
    u_xlat2.xy = u_xlat0.xz * vec2(0.318309993, 0.318309993) + vec2(u_xlat16_5);
    u_xlat2.xy = _Time.xx * vec2(vec2(_Frequency, _Frequency)) + u_xlat2.xy;
    u_xlat2.xy = sin(u_xlat2.xy);
    u_xlat2.xy = vec2(u_xlat16_1) * u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_SwayMax, _SwayMax)) + in_POSITION0.xz;
    u_xlat12 = in_POSITION0.y * _IntrSensitivity;
    u_xlat10.xy = u_xlat2.xy;
    u_xlati3 = 0;
    while(true){
        u_xlat7.x = float(u_xlati3);
#ifdef UNITY_ADRENO_ES3
        u_xlatb7 = !!(u_xlat7.x>=_PositionArray);
#else
        u_xlatb7 = u_xlat7.x>=_PositionArray;
#endif
        if(u_xlatb7){break;}
        u_xlat7.xyz = (-u_xlat0.xyz) + _Positions[u_xlati3].xyz;
        u_xlat7.x = dot(u_xlat7.xyz, u_xlat7.xyz);
        u_xlat7.x = sqrt(u_xlat7.x);
        u_xlat7.x = u_xlat7.x / _IntrRadius;
#ifdef UNITY_ADRENO_ES3
        u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
        u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
        u_xlat7.x = (-u_xlat7.x) + 1.0;
        u_xlat11.xy = u_xlat0.xz + (-_Positions[u_xlati3].xz);
        u_xlat7.xy = u_xlat7.xx * u_xlat11.xy;
        u_xlat7.xy = u_xlat7.xy * in_COLOR0.xx;
        u_xlat7.xy = max(u_xlat7.xy, (-vec2(vec2(_IntrMaxWidth, _IntrMaxWidth))));
        u_xlat7.xy = min(u_xlat7.xy, vec2(vec2(_IntrMaxWidth, _IntrMaxWidth)));
        u_xlat10.xy = vec2(u_xlat12) * u_xlat7.xy + u_xlat10.xy;
        u_xlati3 = u_xlati3 + 1;
    }
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat10.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat10.yyyy + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat3;
    if(_EnableNoiseMap != 0) {
        u_xlat0.xy = u_xlat0.xz + u_xlat10.xy;
        u_xlat0.xy = u_xlat0.xy * _NoiseMap_ST.xy + _NoiseMap_ST.zw;
        u_xlat0.xy = textureLod(_NoiseMap, u_xlat0.xy, 0.0).xy;
    //ENDIF
    }
    u_xlat0.xy = u_xlat0.xy * in_COLOR0.xx;
    u_xlat4 = u_xlat0.y * _ColorShift;
    u_xlat0.y = u_xlat4 * 2.4000001;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0.xy = u_xlat0.xy;
    vs_COLOR0.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _AlphaClip;
uniform 	mediump vec4 _TipsColor;
uniform 	mediump vec4 _RootColor;
uniform 	int _EnableOutline;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump float _OutlinePower;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_1;
vec3 u_xlat2;
bool u_xlatb2;
mediump float u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_6;
bool u_xlatb17;
void main()
{
    u_xlat0.w = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = u_xlat0.w + (-_AlphaClip);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat16_1<0.0);
#else
    u_xlatb2 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
    u_xlat16_1 = log2(u_xlat0.w);
    u_xlat16_1 = u_xlat16_1 * _OutlinePower;
    u_xlat16_1 = exp2(u_xlat16_1);
    u_xlat16_6.xyz = _TipsColor.xyz + (-_RootColor.xyz);
    u_xlat16_6.xyz = vs_COLOR0.yyy * u_xlat16_6.xyz + _RootColor.xyz;
    u_xlat16_3 = vs_COLOR0.x + -0.5;
    u_xlat16_3 = u_xlat16_3 * 0.5 + 1.0;
    u_xlat2.xyz = u_xlat16_6.xyz * vec3(u_xlat16_3);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.xyz = min(max(u_xlat2.xyz, 0.0), 1.0);
#else
    u_xlat2.xyz = clamp(u_xlat2.xyz, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat2.xyz + (-_OutlineColor.xyz);
    u_xlat4.xyz = vec3(u_xlat16_1) * u_xlat4.xyz + _OutlineColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(0<_EnableOutline);
#else
    u_xlatb17 = 0<_EnableOutline;
#endif
    u_xlat0.xyz = (bool(u_xlatb17)) ? u_xlat4.xyz : u_xlat2.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int _EnableNoiseMap;
uniform 	vec4 _NoiseMap_ST;
uniform 	mediump float _ColorShift;
uniform 	mediump float _SwayMax;
uniform 	mediump float _Amplitude;
uniform 	mediump float _Frequency;
uniform 	mediump float _IntrRadius;
uniform 	mediump float _IntrMaxWidth;
uniform 	mediump float _IntrSensitivity;
uniform 	vec3 _Positions[4];
uniform 	float _PositionArray;
uniform lowp sampler2D _NoiseMap;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec3 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec2 u_xlat2;
vec4 u_xlat3;
int u_xlati3;
float u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat7;
bool u_xlatb7;
vec2 u_xlat10;
vec2 u_xlat11;
float u_xlat12;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat16_1 = in_COLOR0.x * _Amplitude;
    u_xlat16_5 = in_COLOR0.y * 6.28318977;
    u_xlat2.xy = u_xlat0.xz * vec2(0.318309993, 0.318309993) + vec2(u_xlat16_5);
    u_xlat2.xy = _Time.xx * vec2(vec2(_Frequency, _Frequency)) + u_xlat2.xy;
    u_xlat2.xy = sin(u_xlat2.xy);
    u_xlat2.xy = vec2(u_xlat16_1) * u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_SwayMax, _SwayMax)) + in_POSITION0.xz;
    u_xlat12 = in_POSITION0.y * _IntrSensitivity;
    u_xlat10.xy = u_xlat2.xy;
    u_xlati3 = 0;
    while(true){
        u_xlat7.x = float(u_xlati3);
#ifdef UNITY_ADRENO_ES3
        u_xlatb7 = !!(u_xlat7.x>=_PositionArray);
#else
        u_xlatb7 = u_xlat7.x>=_PositionArray;
#endif
        if(u_xlatb7){break;}
        u_xlat7.xyz = (-u_xlat0.xyz) + _Positions[u_xlati3].xyz;
        u_xlat7.x = dot(u_xlat7.xyz, u_xlat7.xyz);
        u_xlat7.x = sqrt(u_xlat7.x);
        u_xlat7.x = u_xlat7.x / _IntrRadius;
#ifdef UNITY_ADRENO_ES3
        u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
        u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
        u_xlat7.x = (-u_xlat7.x) + 1.0;
        u_xlat11.xy = u_xlat0.xz + (-_Positions[u_xlati3].xz);
        u_xlat7.xy = u_xlat7.xx * u_xlat11.xy;
        u_xlat7.xy = u_xlat7.xy * in_COLOR0.xx;
        u_xlat7.xy = max(u_xlat7.xy, (-vec2(vec2(_IntrMaxWidth, _IntrMaxWidth))));
        u_xlat7.xy = min(u_xlat7.xy, vec2(vec2(_IntrMaxWidth, _IntrMaxWidth)));
        u_xlat10.xy = vec2(u_xlat12) * u_xlat7.xy + u_xlat10.xy;
        u_xlati3 = u_xlati3 + 1;
    }
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat10.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat10.yyyy + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat3;
    if(_EnableNoiseMap != 0) {
        u_xlat0.xy = u_xlat0.xz + u_xlat10.xy;
        u_xlat0.xy = u_xlat0.xy * _NoiseMap_ST.xy + _NoiseMap_ST.zw;
        u_xlat0.xy = textureLod(_NoiseMap, u_xlat0.xy, 0.0).xy;
    //ENDIF
    }
    u_xlat0.xy = u_xlat0.xy * in_COLOR0.xx;
    u_xlat4 = u_xlat0.y * _ColorShift;
    u_xlat0.y = u_xlat4 * 2.4000001;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0.xy = u_xlat0.xy;
    vs_COLOR0.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _AlphaClip;
uniform 	mediump vec4 _TipsColor;
uniform 	mediump vec4 _RootColor;
uniform 	int _EnableOutline;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump float _OutlinePower;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_1;
vec3 u_xlat2;
bool u_xlatb2;
mediump float u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_6;
bool u_xlatb17;
void main()
{
    u_xlat0.w = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = u_xlat0.w + (-_AlphaClip);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat16_1<0.0);
#else
    u_xlatb2 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
    u_xlat16_1 = log2(u_xlat0.w);
    u_xlat16_1 = u_xlat16_1 * _OutlinePower;
    u_xlat16_1 = exp2(u_xlat16_1);
    u_xlat16_6.xyz = _TipsColor.xyz + (-_RootColor.xyz);
    u_xlat16_6.xyz = vs_COLOR0.yyy * u_xlat16_6.xyz + _RootColor.xyz;
    u_xlat16_3 = vs_COLOR0.x + -0.5;
    u_xlat16_3 = u_xlat16_3 * 0.5 + 1.0;
    u_xlat2.xyz = u_xlat16_6.xyz * vec3(u_xlat16_3);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.xyz = min(max(u_xlat2.xyz, 0.0), 1.0);
#else
    u_xlat2.xyz = clamp(u_xlat2.xyz, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat2.xyz + (-_OutlineColor.xyz);
    u_xlat4.xyz = vec3(u_xlat16_1) * u_xlat4.xyz + _OutlineColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(0<_EnableOutline);
#else
    u_xlatb17 = 0<_EnableOutline;
#endif
    u_xlat0.xyz = (bool(u_xlatb17)) ? u_xlat4.xyz : u_xlat2.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	int _EnableNoiseMap;
uniform 	vec4 _NoiseMap_ST;
uniform 	mediump float _ColorShift;
uniform 	mediump float _SwayMax;
uniform 	mediump float _Amplitude;
uniform 	mediump float _Frequency;
uniform 	mediump float _IntrRadius;
uniform 	mediump float _IntrMaxWidth;
uniform 	mediump float _IntrSensitivity;
uniform 	vec3 _Positions[4];
uniform 	float _PositionArray;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseMap;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
vec2 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
float u_xlat12;
vec2 u_xlat13;
bool u_xlatb13;
int u_xlati17;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat0.x = intBitsToFloat(u_xlati0 << 3);
    u_xlat5.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
    u_xlat0.yzw = unity_Builtins0Array[u_xlati0].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat5.xyz;
    u_xlat16_1 = in_COLOR0.x * _Amplitude;
    u_xlat16_6 = in_COLOR0.y * 6.28318977;
    u_xlat2.xy = u_xlat0.yw * vec2(0.318309993, 0.318309993) + vec2(u_xlat16_6);
    u_xlat2.xy = _Time.xx * vec2(vec2(_Frequency, _Frequency)) + u_xlat2.xy;
    u_xlat2.xy = sin(u_xlat2.xy);
    u_xlat2.xy = vec2(u_xlat16_1) * u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_SwayMax, _SwayMax)) + in_POSITION0.xz;
    u_xlat12 = in_POSITION0.y * _IntrSensitivity;
    u_xlat3.xy = u_xlat2.xy;
    u_xlati17 = 0;
    while(true){
        u_xlat13.x = float(u_xlati17);
#ifdef UNITY_ADRENO_ES3
        u_xlatb13 = !!(u_xlat13.x>=_PositionArray);
#else
        u_xlatb13 = u_xlat13.x>=_PositionArray;
#endif
        if(u_xlatb13){break;}
        u_xlat4.xyz = vec3((-u_xlat0.y) + _Positions[u_xlati17].x, (-u_xlat0.z) + _Positions[u_xlati17].y, (-u_xlat0.w) + _Positions[u_xlati17].z);
        u_xlat13.x = dot(u_xlat4.xyz, u_xlat4.xyz);
        u_xlat13.x = sqrt(u_xlat13.x);
        u_xlat13.x = u_xlat13.x / _IntrRadius;
#ifdef UNITY_ADRENO_ES3
        u_xlat13.x = min(max(u_xlat13.x, 0.0), 1.0);
#else
        u_xlat13.x = clamp(u_xlat13.x, 0.0, 1.0);
#endif
        u_xlat13.x = (-u_xlat13.x) + 1.0;
        u_xlat4.xy = vec2(u_xlat0.y + (-_Positions[u_xlati17].x), u_xlat0.w + (-_Positions[u_xlati17].z));
        u_xlat13.xy = u_xlat13.xx * u_xlat4.xy;
        u_xlat13.xy = u_xlat13.xy * in_COLOR0.xx;
        u_xlat13.xy = max(u_xlat13.xy, (-vec2(vec2(_IntrMaxWidth, _IntrMaxWidth))));
        u_xlat13.xy = min(u_xlat13.xy, vec2(vec2(_IntrMaxWidth, _IntrMaxWidth)));
        u_xlat3.xy = vec2(u_xlat12) * u_xlat13.xy + u_xlat3.xy;
        u_xlati17 = u_xlati17 + 1;
    }
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat3.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat3.yyyy + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati0].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    if(_EnableNoiseMap != 0) {
        u_xlat0.xy = vec2(u_xlat0.y + u_xlat3.x, u_xlat0.w + u_xlat3.y);
        u_xlat0.xy = u_xlat0.xy * _NoiseMap_ST.xy + _NoiseMap_ST.zw;
        u_xlat0.xy = textureLod(_NoiseMap, u_xlat0.xy, 0.0).xy;
    //ENDIF
    }
    u_xlat0.xy = u_xlat0.xy * in_COLOR0.xx;
    u_xlat5.x = u_xlat0.y * _ColorShift;
    u_xlat0.y = u_xlat5.x * 2.4000001;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0.xy = u_xlat0.xy;
    vs_COLOR0.zw = vec2(0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _AlphaClip;
uniform 	mediump vec4 _TipsColor;
uniform 	mediump vec4 _RootColor;
uniform 	int _EnableOutline;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump float _OutlinePower;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_1;
vec3 u_xlat2;
bool u_xlatb2;
mediump float u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_6;
bool u_xlatb17;
void main()
{
    u_xlat0.w = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = u_xlat0.w + (-_AlphaClip);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat16_1<0.0);
#else
    u_xlatb2 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
    u_xlat16_1 = log2(u_xlat0.w);
    u_xlat16_1 = u_xlat16_1 * _OutlinePower;
    u_xlat16_1 = exp2(u_xlat16_1);
    u_xlat16_6.xyz = _TipsColor.xyz + (-_RootColor.xyz);
    u_xlat16_6.xyz = vs_COLOR0.yyy * u_xlat16_6.xyz + _RootColor.xyz;
    u_xlat16_3 = vs_COLOR0.x + -0.5;
    u_xlat16_3 = u_xlat16_3 * 0.5 + 1.0;
    u_xlat2.xyz = u_xlat16_6.xyz * vec3(u_xlat16_3);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.xyz = min(max(u_xlat2.xyz, 0.0), 1.0);
#else
    u_xlat2.xyz = clamp(u_xlat2.xyz, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat2.xyz + (-_OutlineColor.xyz);
    u_xlat4.xyz = vec3(u_xlat16_1) * u_xlat4.xyz + _OutlineColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(0<_EnableOutline);
#else
    u_xlatb17 = 0<_EnableOutline;
#endif
    u_xlat0.xyz = (bool(u_xlatb17)) ? u_xlat4.xyz : u_xlat2.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	int _EnableNoiseMap;
uniform 	vec4 _NoiseMap_ST;
uniform 	mediump float _ColorShift;
uniform 	mediump float _SwayMax;
uniform 	mediump float _Amplitude;
uniform 	mediump float _Frequency;
uniform 	mediump float _IntrRadius;
uniform 	mediump float _IntrMaxWidth;
uniform 	mediump float _IntrSensitivity;
uniform 	vec3 _Positions[4];
uniform 	float _PositionArray;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseMap;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
vec2 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
float u_xlat12;
vec2 u_xlat13;
bool u_xlatb13;
int u_xlati17;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat0.x = intBitsToFloat(u_xlati0 << 3);
    u_xlat5.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
    u_xlat0.yzw = unity_Builtins0Array[u_xlati0].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat5.xyz;
    u_xlat16_1 = in_COLOR0.x * _Amplitude;
    u_xlat16_6 = in_COLOR0.y * 6.28318977;
    u_xlat2.xy = u_xlat0.yw * vec2(0.318309993, 0.318309993) + vec2(u_xlat16_6);
    u_xlat2.xy = _Time.xx * vec2(vec2(_Frequency, _Frequency)) + u_xlat2.xy;
    u_xlat2.xy = sin(u_xlat2.xy);
    u_xlat2.xy = vec2(u_xlat16_1) * u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_SwayMax, _SwayMax)) + in_POSITION0.xz;
    u_xlat12 = in_POSITION0.y * _IntrSensitivity;
    u_xlat3.xy = u_xlat2.xy;
    u_xlati17 = 0;
    while(true){
        u_xlat13.x = float(u_xlati17);
#ifdef UNITY_ADRENO_ES3
        u_xlatb13 = !!(u_xlat13.x>=_PositionArray);
#else
        u_xlatb13 = u_xlat13.x>=_PositionArray;
#endif
        if(u_xlatb13){break;}
        u_xlat4.xyz = vec3((-u_xlat0.y) + _Positions[u_xlati17].x, (-u_xlat0.z) + _Positions[u_xlati17].y, (-u_xlat0.w) + _Positions[u_xlati17].z);
        u_xlat13.x = dot(u_xlat4.xyz, u_xlat4.xyz);
        u_xlat13.x = sqrt(u_xlat13.x);
        u_xlat13.x = u_xlat13.x / _IntrRadius;
#ifdef UNITY_ADRENO_ES3
        u_xlat13.x = min(max(u_xlat13.x, 0.0), 1.0);
#else
        u_xlat13.x = clamp(u_xlat13.x, 0.0, 1.0);
#endif
        u_xlat13.x = (-u_xlat13.x) + 1.0;
        u_xlat4.xy = vec2(u_xlat0.y + (-_Positions[u_xlati17].x), u_xlat0.w + (-_Positions[u_xlati17].z));
        u_xlat13.xy = u_xlat13.xx * u_xlat4.xy;
        u_xlat13.xy = u_xlat13.xy * in_COLOR0.xx;
        u_xlat13.xy = max(u_xlat13.xy, (-vec2(vec2(_IntrMaxWidth, _IntrMaxWidth))));
        u_xlat13.xy = min(u_xlat13.xy, vec2(vec2(_IntrMaxWidth, _IntrMaxWidth)));
        u_xlat3.xy = vec2(u_xlat12) * u_xlat13.xy + u_xlat3.xy;
        u_xlati17 = u_xlati17 + 1;
    }
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat3.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat3.yyyy + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati0].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    if(_EnableNoiseMap != 0) {
        u_xlat0.xy = vec2(u_xlat0.y + u_xlat3.x, u_xlat0.w + u_xlat3.y);
        u_xlat0.xy = u_xlat0.xy * _NoiseMap_ST.xy + _NoiseMap_ST.zw;
        u_xlat0.xy = textureLod(_NoiseMap, u_xlat0.xy, 0.0).xy;
    //ENDIF
    }
    u_xlat0.xy = u_xlat0.xy * in_COLOR0.xx;
    u_xlat5.x = u_xlat0.y * _ColorShift;
    u_xlat0.y = u_xlat5.x * 2.4000001;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0.xy = u_xlat0.xy;
    vs_COLOR0.zw = vec2(0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _AlphaClip;
uniform 	mediump vec4 _TipsColor;
uniform 	mediump vec4 _RootColor;
uniform 	int _EnableOutline;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump float _OutlinePower;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_1;
vec3 u_xlat2;
bool u_xlatb2;
mediump float u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_6;
bool u_xlatb17;
void main()
{
    u_xlat0.w = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = u_xlat0.w + (-_AlphaClip);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat16_1<0.0);
#else
    u_xlatb2 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
    u_xlat16_1 = log2(u_xlat0.w);
    u_xlat16_1 = u_xlat16_1 * _OutlinePower;
    u_xlat16_1 = exp2(u_xlat16_1);
    u_xlat16_6.xyz = _TipsColor.xyz + (-_RootColor.xyz);
    u_xlat16_6.xyz = vs_COLOR0.yyy * u_xlat16_6.xyz + _RootColor.xyz;
    u_xlat16_3 = vs_COLOR0.x + -0.5;
    u_xlat16_3 = u_xlat16_3 * 0.5 + 1.0;
    u_xlat2.xyz = u_xlat16_6.xyz * vec3(u_xlat16_3);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.xyz = min(max(u_xlat2.xyz, 0.0), 1.0);
#else
    u_xlat2.xyz = clamp(u_xlat2.xyz, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat2.xyz + (-_OutlineColor.xyz);
    u_xlat4.xyz = vec3(u_xlat16_1) * u_xlat4.xyz + _OutlineColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(0<_EnableOutline);
#else
    u_xlatb17 = 0<_EnableOutline;
#endif
    u_xlat0.xyz = (bool(u_xlatb17)) ? u_xlat4.xyz : u_xlat2.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	int _EnableNoiseMap;
uniform 	vec4 _NoiseMap_ST;
uniform 	mediump float _ColorShift;
uniform 	mediump float _SwayMax;
uniform 	mediump float _Amplitude;
uniform 	mediump float _Frequency;
uniform 	mediump float _IntrRadius;
uniform 	mediump float _IntrMaxWidth;
uniform 	mediump float _IntrSensitivity;
uniform 	vec3 _Positions[4];
uniform 	float _PositionArray;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseMap;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
vec2 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
float u_xlat12;
vec2 u_xlat13;
bool u_xlatb13;
int u_xlati17;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat0.x = intBitsToFloat(u_xlati0 << 3);
    u_xlat5.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
    u_xlat0.yzw = unity_Builtins0Array[u_xlati0].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat5.xyz;
    u_xlat16_1 = in_COLOR0.x * _Amplitude;
    u_xlat16_6 = in_COLOR0.y * 6.28318977;
    u_xlat2.xy = u_xlat0.yw * vec2(0.318309993, 0.318309993) + vec2(u_xlat16_6);
    u_xlat2.xy = _Time.xx * vec2(vec2(_Frequency, _Frequency)) + u_xlat2.xy;
    u_xlat2.xy = sin(u_xlat2.xy);
    u_xlat2.xy = vec2(u_xlat16_1) * u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_SwayMax, _SwayMax)) + in_POSITION0.xz;
    u_xlat12 = in_POSITION0.y * _IntrSensitivity;
    u_xlat3.xy = u_xlat2.xy;
    u_xlati17 = 0;
    while(true){
        u_xlat13.x = float(u_xlati17);
#ifdef UNITY_ADRENO_ES3
        u_xlatb13 = !!(u_xlat13.x>=_PositionArray);
#else
        u_xlatb13 = u_xlat13.x>=_PositionArray;
#endif
        if(u_xlatb13){break;}
        u_xlat4.xyz = vec3((-u_xlat0.y) + _Positions[u_xlati17].x, (-u_xlat0.z) + _Positions[u_xlati17].y, (-u_xlat0.w) + _Positions[u_xlati17].z);
        u_xlat13.x = dot(u_xlat4.xyz, u_xlat4.xyz);
        u_xlat13.x = sqrt(u_xlat13.x);
        u_xlat13.x = u_xlat13.x / _IntrRadius;
#ifdef UNITY_ADRENO_ES3
        u_xlat13.x = min(max(u_xlat13.x, 0.0), 1.0);
#else
        u_xlat13.x = clamp(u_xlat13.x, 0.0, 1.0);
#endif
        u_xlat13.x = (-u_xlat13.x) + 1.0;
        u_xlat4.xy = vec2(u_xlat0.y + (-_Positions[u_xlati17].x), u_xlat0.w + (-_Positions[u_xlati17].z));
        u_xlat13.xy = u_xlat13.xx * u_xlat4.xy;
        u_xlat13.xy = u_xlat13.xy * in_COLOR0.xx;
        u_xlat13.xy = max(u_xlat13.xy, (-vec2(vec2(_IntrMaxWidth, _IntrMaxWidth))));
        u_xlat13.xy = min(u_xlat13.xy, vec2(vec2(_IntrMaxWidth, _IntrMaxWidth)));
        u_xlat3.xy = vec2(u_xlat12) * u_xlat13.xy + u_xlat3.xy;
        u_xlati17 = u_xlati17 + 1;
    }
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat3.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat3.yyyy + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati0].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    if(_EnableNoiseMap != 0) {
        u_xlat0.xy = vec2(u_xlat0.y + u_xlat3.x, u_xlat0.w + u_xlat3.y);
        u_xlat0.xy = u_xlat0.xy * _NoiseMap_ST.xy + _NoiseMap_ST.zw;
        u_xlat0.xy = textureLod(_NoiseMap, u_xlat0.xy, 0.0).xy;
    //ENDIF
    }
    u_xlat0.xy = u_xlat0.xy * in_COLOR0.xx;
    u_xlat5.x = u_xlat0.y * _ColorShift;
    u_xlat0.y = u_xlat5.x * 2.4000001;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0.xy = u_xlat0.xy;
    vs_COLOR0.zw = vec2(0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _AlphaClip;
uniform 	mediump vec4 _TipsColor;
uniform 	mediump vec4 _RootColor;
uniform 	int _EnableOutline;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump float _OutlinePower;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_1;
vec3 u_xlat2;
bool u_xlatb2;
mediump float u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_6;
bool u_xlatb17;
void main()
{
    u_xlat0.w = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_1 = u_xlat0.w + (-_AlphaClip);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat16_1<0.0);
#else
    u_xlatb2 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
    u_xlat16_1 = log2(u_xlat0.w);
    u_xlat16_1 = u_xlat16_1 * _OutlinePower;
    u_xlat16_1 = exp2(u_xlat16_1);
    u_xlat16_6.xyz = _TipsColor.xyz + (-_RootColor.xyz);
    u_xlat16_6.xyz = vs_COLOR0.yyy * u_xlat16_6.xyz + _RootColor.xyz;
    u_xlat16_3 = vs_COLOR0.x + -0.5;
    u_xlat16_3 = u_xlat16_3 * 0.5 + 1.0;
    u_xlat2.xyz = u_xlat16_6.xyz * vec3(u_xlat16_3);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.xyz = min(max(u_xlat2.xyz, 0.0), 1.0);
#else
    u_xlat2.xyz = clamp(u_xlat2.xyz, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat2.xyz + (-_OutlineColor.xyz);
    u_xlat4.xyz = vec3(u_xlat16_1) * u_xlat4.xyz + _OutlineColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(0<_EnableOutline);
#else
    u_xlatb17 = 0<_EnableOutline;
#endif
    u_xlat0.xyz = (bool(u_xlatb17)) ? u_xlat4.xyz : u_xlat2.xyz;
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
}
}
}
}