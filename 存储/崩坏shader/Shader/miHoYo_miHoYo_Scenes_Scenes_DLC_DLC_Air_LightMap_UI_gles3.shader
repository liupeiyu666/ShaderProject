//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_DLC/DLC_Air_LightMap_UI" {
Properties {
_LightMapIntensity ("Light Map Intensity", Float) = 1
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Color Tex (RGB)", 2D) = "white" { }
_ShadowTex ("LightMap (RGB)", 2D) = "grey" { }
_FogTune ("Fog Tune", Range(0, 1)) = 1
_Culling ("Culling (0: Off, 1: Front, 2: Back)", Float) = 2
_ShadowIntegration ("Shadow Integration", Range(0, 1)) = 0.2
[Toggle(LUMINANCE)] _Luminance ("Luminance", Float) = 0
_LumiFactor ("Luminance Factor", Float) = 0
}
SubShader {
 Tags { "DrawDepth" = "FrontFace" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "BASE"
  Tags { "DrawDepth" = "FrontFace" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  ZTest Off
  Cull Off
  GpuProgramID 13986
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat4;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat4.x * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.x = u_xlat1.x * _FogTune;
        u_xlat1.x = u_xlat1.x * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat1.x = max(u_xlat7, u_xlat1.x);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.y * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat7 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat7 = max(u_xlat7, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat7);
        u_xlat4.x = u_xlat1.y * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat7, u_xlat4.x);
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat4;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat4.x * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.x = u_xlat1.x * _FogTune;
        u_xlat1.x = u_xlat1.x * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat1.x = max(u_xlat7, u_xlat1.x);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.y * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat7 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat7 = max(u_xlat7, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat7);
        u_xlat4.x = u_xlat1.y * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat7, u_xlat4.x);
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat4;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat4.x * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.x = u_xlat1.x * _FogTune;
        u_xlat1.x = u_xlat1.x * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat1.x = max(u_xlat7, u_xlat1.x);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.y * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat7 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat7 = max(u_xlat7, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat7);
        u_xlat4.x = u_xlat1.y * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat7, u_xlat4.x);
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat4;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat4.x * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.x = u_xlat1.x * _FogTune;
        u_xlat1.x = u_xlat1.x * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat1.x = max(u_xlat7, u_xlat1.x);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.y * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat7 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat7 = max(u_xlat7, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat7);
        u_xlat4.x = u_xlat1.y * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat7, u_xlat4.x);
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat0.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat4;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat4.x * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.x = u_xlat1.x * _FogTune;
        u_xlat1.x = u_xlat1.x * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat1.x = max(u_xlat7, u_xlat1.x);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.y * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat7 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat7 = max(u_xlat7, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat7);
        u_xlat4.x = u_xlat1.y * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat7, u_xlat4.x);
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat0.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat4;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat4.x * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.x = u_xlat1.x * _FogTune;
        u_xlat1.x = u_xlat1.x * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat1.x = max(u_xlat7, u_xlat1.x);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.y * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat7 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat7 = max(u_xlat7, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat7);
        u_xlat4.x = u_xlat1.y * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat7, u_xlat4.x);
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat0.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat4;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat4.x * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.x = u_xlat1.x * _FogTune;
        u_xlat1.x = u_xlat1.x * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat1.x = max(u_xlat7, u_xlat1.x);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.y * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat7 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat7 = max(u_xlat7, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat7);
        u_xlat4.x = u_xlat1.y * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat7, u_xlat4.x);
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat4;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat4.x * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.x = u_xlat1.x * _FogTune;
        u_xlat1.x = u_xlat1.x * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat1.x = max(u_xlat7, u_xlat1.x);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.y * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat7 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat7 = max(u_xlat7, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat7);
        u_xlat4.x = u_xlat1.y * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat7, u_xlat4.x);
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat4;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat4.x * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.x = u_xlat1.x * _FogTune;
        u_xlat1.x = u_xlat1.x * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat1.x = max(u_xlat7, u_xlat1.x);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.y * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat7 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat7 = max(u_xlat7, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat7);
        u_xlat4.x = u_xlat1.y * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat7, u_xlat4.x);
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat4;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat4.x * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.x = u_xlat1.x * _FogTune;
        u_xlat1.x = u_xlat1.x * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat1.x = max(u_xlat7, u_xlat1.x);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.y * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat7 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat7 = max(u_xlat7, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat7);
        u_xlat4.x = u_xlat1.y * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat7, u_xlat4.x);
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat0.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat4;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat4.x * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.x = u_xlat1.x * _FogTune;
        u_xlat1.x = u_xlat1.x * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat1.x = max(u_xlat7, u_xlat1.x);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.y * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat7 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat7 = max(u_xlat7, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat7);
        u_xlat4.x = u_xlat1.y * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat7, u_xlat4.x);
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat0.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat4;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat4.x * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.x = u_xlat1.x * _FogTune;
        u_xlat1.x = u_xlat1.x * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat1.x = max(u_xlat7, u_xlat1.x);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.y * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat7 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat7 = max(u_xlat7, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat7);
        u_xlat4.x = u_xlat1.y * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat7, u_xlat4.x);
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat0.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_8;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat17;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat10.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat10.x = u_xlat10.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat10.xxx * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat10.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat0.x>=u_xlat10.x);
#else
    u_xlatb10 = u_xlat0.x>=u_xlat10.x;
#endif
    u_xlat15 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat17 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat17;
    u_xlat17 = u_xlat15 * _HeigtFogColDelta.w;
    u_xlat10.x = (u_xlatb10) ? u_xlat17 : u_xlat15;
    u_xlat10.x = log2(u_xlat10.x);
    u_xlat10.x = u_xlat10.x * _Mihoyo_FogColor.w;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = min(u_xlat10.x, _HeigtFogColBase.w);
    u_xlat2.xyz = u_xlat10.xxx * u_xlat2.xyz;
    u_xlat15 = u_xlat5 * -1.44269502;
    u_xlat10.y = exp2(u_xlat15);
    u_xlat10.xy = (-u_xlat10.xy) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat10.y / u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.00999999978<abs(u_xlat5));
#else
    u_xlatb5 = 0.00999999978<abs(u_xlat5);
#endif
    u_xlat16_3 = (u_xlatb5) ? u_xlat15 : 1.0;
    u_xlat5 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat5 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_8 = (-u_xlat0.x) + 2.0;
    u_xlat16_8 = u_xlat0.x * u_xlat16_8;
    u_xlat0.x = u_xlat16_8 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat5 = (-u_xlat0.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz;
    u_xlat3.w = u_xlat5 * u_xlat10.x;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_COLOR1 = u_xlat3;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_8;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat17;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat10.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat10.x = u_xlat10.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat10.xxx * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat10.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat0.x>=u_xlat10.x);
#else
    u_xlatb10 = u_xlat0.x>=u_xlat10.x;
#endif
    u_xlat15 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat17 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat17;
    u_xlat17 = u_xlat15 * _HeigtFogColDelta.w;
    u_xlat10.x = (u_xlatb10) ? u_xlat17 : u_xlat15;
    u_xlat10.x = log2(u_xlat10.x);
    u_xlat10.x = u_xlat10.x * _Mihoyo_FogColor.w;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = min(u_xlat10.x, _HeigtFogColBase.w);
    u_xlat2.xyz = u_xlat10.xxx * u_xlat2.xyz;
    u_xlat15 = u_xlat5 * -1.44269502;
    u_xlat10.y = exp2(u_xlat15);
    u_xlat10.xy = (-u_xlat10.xy) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat10.y / u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.00999999978<abs(u_xlat5));
#else
    u_xlatb5 = 0.00999999978<abs(u_xlat5);
#endif
    u_xlat16_3 = (u_xlatb5) ? u_xlat15 : 1.0;
    u_xlat5 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat5 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_8 = (-u_xlat0.x) + 2.0;
    u_xlat16_8 = u_xlat0.x * u_xlat16_8;
    u_xlat0.x = u_xlat16_8 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat5 = (-u_xlat0.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz;
    u_xlat3.w = u_xlat5 * u_xlat10.x;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_COLOR1 = u_xlat3;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_8;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat17;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat10.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat10.x = u_xlat10.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat10.xxx * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat10.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat0.x>=u_xlat10.x);
#else
    u_xlatb10 = u_xlat0.x>=u_xlat10.x;
#endif
    u_xlat15 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat17 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat17;
    u_xlat17 = u_xlat15 * _HeigtFogColDelta.w;
    u_xlat10.x = (u_xlatb10) ? u_xlat17 : u_xlat15;
    u_xlat10.x = log2(u_xlat10.x);
    u_xlat10.x = u_xlat10.x * _Mihoyo_FogColor.w;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = min(u_xlat10.x, _HeigtFogColBase.w);
    u_xlat2.xyz = u_xlat10.xxx * u_xlat2.xyz;
    u_xlat15 = u_xlat5 * -1.44269502;
    u_xlat10.y = exp2(u_xlat15);
    u_xlat10.xy = (-u_xlat10.xy) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat10.y / u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.00999999978<abs(u_xlat5));
#else
    u_xlatb5 = 0.00999999978<abs(u_xlat5);
#endif
    u_xlat16_3 = (u_xlatb5) ? u_xlat15 : 1.0;
    u_xlat5 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat5 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_8 = (-u_xlat0.x) + 2.0;
    u_xlat16_8 = u_xlat0.x * u_xlat16_8;
    u_xlat0.x = u_xlat16_8 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat5 = (-u_xlat0.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz;
    u_xlat3.w = u_xlat5 * u_xlat10.x;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_COLOR1 = u_xlat3;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_8;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat17;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat10.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat10.x = u_xlat10.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat10.xxx * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat10.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat0.x>=u_xlat10.x);
#else
    u_xlatb10 = u_xlat0.x>=u_xlat10.x;
#endif
    u_xlat15 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat17 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat17;
    u_xlat17 = u_xlat15 * _HeigtFogColDelta.w;
    u_xlat10.x = (u_xlatb10) ? u_xlat17 : u_xlat15;
    u_xlat10.x = log2(u_xlat10.x);
    u_xlat10.x = u_xlat10.x * _Mihoyo_FogColor.w;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = min(u_xlat10.x, _HeigtFogColBase.w);
    u_xlat2.xyz = u_xlat10.xxx * u_xlat2.xyz;
    u_xlat15 = u_xlat5 * -1.44269502;
    u_xlat10.y = exp2(u_xlat15);
    u_xlat10.xy = (-u_xlat10.xy) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat10.y / u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.00999999978<abs(u_xlat5));
#else
    u_xlatb5 = 0.00999999978<abs(u_xlat5);
#endif
    u_xlat16_3 = (u_xlatb5) ? u_xlat15 : 1.0;
    u_xlat5 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat5 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_8 = (-u_xlat0.x) + 2.0;
    u_xlat16_8 = u_xlat0.x * u_xlat16_8;
    u_xlat0.x = u_xlat16_8 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat5 = (-u_xlat0.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz;
    u_xlat3.w = u_xlat5 * u_xlat10.x;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_COLOR1 = u_xlat3;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_8;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat17;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat10.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat10.x = u_xlat10.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat10.xxx * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat10.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat0.x>=u_xlat10.x);
#else
    u_xlatb10 = u_xlat0.x>=u_xlat10.x;
#endif
    u_xlat15 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat17 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat17;
    u_xlat17 = u_xlat15 * _HeigtFogColDelta.w;
    u_xlat10.x = (u_xlatb10) ? u_xlat17 : u_xlat15;
    u_xlat10.x = log2(u_xlat10.x);
    u_xlat10.x = u_xlat10.x * _Mihoyo_FogColor.w;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = min(u_xlat10.x, _HeigtFogColBase.w);
    u_xlat2.xyz = u_xlat10.xxx * u_xlat2.xyz;
    u_xlat15 = u_xlat5 * -1.44269502;
    u_xlat10.y = exp2(u_xlat15);
    u_xlat10.xy = (-u_xlat10.xy) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat10.y / u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.00999999978<abs(u_xlat5));
#else
    u_xlatb5 = 0.00999999978<abs(u_xlat5);
#endif
    u_xlat16_3 = (u_xlatb5) ? u_xlat15 : 1.0;
    u_xlat5 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat5 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_8 = (-u_xlat0.x) + 2.0;
    u_xlat16_8 = u_xlat0.x * u_xlat16_8;
    u_xlat0.x = u_xlat16_8 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat5 = (-u_xlat0.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz;
    u_xlat3.w = u_xlat5 * u_xlat10.x;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_COLOR1 = u_xlat3;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_8;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat17;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat10.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat10.x = u_xlat10.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat10.xxx * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat10.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat0.x>=u_xlat10.x);
#else
    u_xlatb10 = u_xlat0.x>=u_xlat10.x;
#endif
    u_xlat15 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat17 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat17;
    u_xlat17 = u_xlat15 * _HeigtFogColDelta.w;
    u_xlat10.x = (u_xlatb10) ? u_xlat17 : u_xlat15;
    u_xlat10.x = log2(u_xlat10.x);
    u_xlat10.x = u_xlat10.x * _Mihoyo_FogColor.w;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = min(u_xlat10.x, _HeigtFogColBase.w);
    u_xlat2.xyz = u_xlat10.xxx * u_xlat2.xyz;
    u_xlat15 = u_xlat5 * -1.44269502;
    u_xlat10.y = exp2(u_xlat15);
    u_xlat10.xy = (-u_xlat10.xy) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat10.y / u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.00999999978<abs(u_xlat5));
#else
    u_xlatb5 = 0.00999999978<abs(u_xlat5);
#endif
    u_xlat16_3 = (u_xlatb5) ? u_xlat15 : 1.0;
    u_xlat5 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat5 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_8 = (-u_xlat0.x) + 2.0;
    u_xlat16_8 = u_xlat0.x * u_xlat16_8;
    u_xlat0.x = u_xlat16_8 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat5 = (-u_xlat0.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz;
    u_xlat3.w = u_xlat5 * u_xlat10.x;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_COLOR1 = u_xlat3;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
bool u_xlatb4;
mediump float u_xlat16_5;
vec3 u_xlat6;
mediump float u_xlat16_9;
vec3 u_xlat10;
mediump float u_xlat16_11;
float u_xlat12;
bool u_xlatb12;
float u_xlat18;
float u_xlat20;
bool u_xlatb20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat18) + 2.0;
    u_xlat16_3 = u_xlat18 * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat6.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat18 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat18 = u_xlat18 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat18 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat20 = (-u_xlat18) + 2.0;
    u_xlat18 = u_xlat18 * u_xlat20;
    u_xlat20 = u_xlat18 * _HeigtFogColDelta3.w;
    u_xlat4.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=u_xlat4.x);
#else
    u_xlatb4 = u_xlat0.x>=u_xlat4.x;
#endif
    u_xlat18 = (u_xlatb4) ? u_xlat20 : u_xlat18;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _Mihoyo_FogColor3.w;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = min(u_xlat18, _HeigtFogColBase3.w);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat20 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat12 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat10.x = u_xlat20 * -1.44269502;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = (-u_xlat10.x) + 1.0;
    u_xlat10.x = u_xlat10.x / u_xlat20;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(0.00999999978<abs(u_xlat20));
#else
    u_xlatb20 = 0.00999999978<abs(u_xlat20);
#endif
    u_xlat16_3 = (u_xlatb20) ? u_xlat10.x : 1.0;
    u_xlat20 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat20 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat20 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat16_9 = (-u_xlat20) + 2.0;
    u_xlat16_9 = u_xlat20 * u_xlat16_9;
    u_xlat20 = u_xlat16_9 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat20 = u_xlat20 + 1.0;
    u_xlat16_3 = u_xlat20 * u_xlat16_3;
    u_xlat20 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat10.x = (-u_xlat20) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat10.xxx;
    u_xlat3.w = u_xlat18 * u_xlat10.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat20) + u_xlat2.xyz;
    u_xlat16_5 = (-u_xlat6.x) + 2.0;
    u_xlat16_5 = u_xlat6.x * u_xlat16_5;
    u_xlat2.xyz = vec3(u_xlat16_5) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat10.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat6.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat6.x = u_xlat6.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat6.xxx * u_xlat10.xyz + u_xlat2.xyz;
    u_xlat6.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat18 = (-u_xlat6.x) + 2.0;
    u_xlat6.x = u_xlat18 * u_xlat6.x;
    u_xlat18 = u_xlat6.x * _HeigtFogColDelta2.w;
    u_xlat6.x = (u_xlatb4) ? u_xlat18 : u_xlat6.x;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _Mihoyo_FogColor2.w;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat6.x = min(u_xlat6.x, _HeigtFogColBase2.w);
    u_xlat2.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat18 = u_xlat12 * -1.44269502;
    u_xlat6.z = exp2(u_xlat18);
    u_xlat6.xz = (-u_xlat6.xz) + vec2(1.0, 1.0);
    u_xlat18 = u_xlat6.z / u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.00999999978<abs(u_xlat12));
#else
    u_xlatb12 = 0.00999999978<abs(u_xlat12);
#endif
    u_xlat16_5 = (u_xlatb12) ? u_xlat18 : 1.0;
    u_xlat12 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat12 * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_11 = (-u_xlat0.x) + 2.0;
    u_xlat16_11 = u_xlat0.x * u_xlat16_11;
    u_xlat0.x = u_xlat16_11 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_5 = u_xlat0.x * u_xlat16_5;
    u_xlat0.x = min(u_xlat16_5, _HeigtFogColBase2.w);
    u_xlat12 = (-u_xlat0.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat4.w = u_xlat12 * u_xlat6.x;
    u_xlat4.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0 = u_xlat3 + (-u_xlat4);
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat4;
    vs_COLOR1 = u_xlat0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
bool u_xlatb4;
mediump float u_xlat16_5;
vec3 u_xlat6;
mediump float u_xlat16_9;
vec3 u_xlat10;
mediump float u_xlat16_11;
float u_xlat12;
bool u_xlatb12;
float u_xlat18;
float u_xlat20;
bool u_xlatb20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat18) + 2.0;
    u_xlat16_3 = u_xlat18 * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat6.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat18 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat18 = u_xlat18 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat18 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat20 = (-u_xlat18) + 2.0;
    u_xlat18 = u_xlat18 * u_xlat20;
    u_xlat20 = u_xlat18 * _HeigtFogColDelta3.w;
    u_xlat4.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=u_xlat4.x);
#else
    u_xlatb4 = u_xlat0.x>=u_xlat4.x;
#endif
    u_xlat18 = (u_xlatb4) ? u_xlat20 : u_xlat18;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _Mihoyo_FogColor3.w;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = min(u_xlat18, _HeigtFogColBase3.w);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat20 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat12 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat10.x = u_xlat20 * -1.44269502;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = (-u_xlat10.x) + 1.0;
    u_xlat10.x = u_xlat10.x / u_xlat20;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(0.00999999978<abs(u_xlat20));
#else
    u_xlatb20 = 0.00999999978<abs(u_xlat20);
#endif
    u_xlat16_3 = (u_xlatb20) ? u_xlat10.x : 1.0;
    u_xlat20 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat20 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat20 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat16_9 = (-u_xlat20) + 2.0;
    u_xlat16_9 = u_xlat20 * u_xlat16_9;
    u_xlat20 = u_xlat16_9 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat20 = u_xlat20 + 1.0;
    u_xlat16_3 = u_xlat20 * u_xlat16_3;
    u_xlat20 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat10.x = (-u_xlat20) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat10.xxx;
    u_xlat3.w = u_xlat18 * u_xlat10.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat20) + u_xlat2.xyz;
    u_xlat16_5 = (-u_xlat6.x) + 2.0;
    u_xlat16_5 = u_xlat6.x * u_xlat16_5;
    u_xlat2.xyz = vec3(u_xlat16_5) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat10.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat6.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat6.x = u_xlat6.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat6.xxx * u_xlat10.xyz + u_xlat2.xyz;
    u_xlat6.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat18 = (-u_xlat6.x) + 2.0;
    u_xlat6.x = u_xlat18 * u_xlat6.x;
    u_xlat18 = u_xlat6.x * _HeigtFogColDelta2.w;
    u_xlat6.x = (u_xlatb4) ? u_xlat18 : u_xlat6.x;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _Mihoyo_FogColor2.w;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat6.x = min(u_xlat6.x, _HeigtFogColBase2.w);
    u_xlat2.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat18 = u_xlat12 * -1.44269502;
    u_xlat6.z = exp2(u_xlat18);
    u_xlat6.xz = (-u_xlat6.xz) + vec2(1.0, 1.0);
    u_xlat18 = u_xlat6.z / u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.00999999978<abs(u_xlat12));
#else
    u_xlatb12 = 0.00999999978<abs(u_xlat12);
#endif
    u_xlat16_5 = (u_xlatb12) ? u_xlat18 : 1.0;
    u_xlat12 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat12 * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_11 = (-u_xlat0.x) + 2.0;
    u_xlat16_11 = u_xlat0.x * u_xlat16_11;
    u_xlat0.x = u_xlat16_11 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_5 = u_xlat0.x * u_xlat16_5;
    u_xlat0.x = min(u_xlat16_5, _HeigtFogColBase2.w);
    u_xlat12 = (-u_xlat0.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat4.w = u_xlat12 * u_xlat6.x;
    u_xlat4.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0 = u_xlat3 + (-u_xlat4);
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat4;
    vs_COLOR1 = u_xlat0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
bool u_xlatb4;
mediump float u_xlat16_5;
vec3 u_xlat6;
mediump float u_xlat16_9;
vec3 u_xlat10;
mediump float u_xlat16_11;
float u_xlat12;
bool u_xlatb12;
float u_xlat18;
float u_xlat20;
bool u_xlatb20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat18) + 2.0;
    u_xlat16_3 = u_xlat18 * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat6.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat18 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat18 = u_xlat18 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat18 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat20 = (-u_xlat18) + 2.0;
    u_xlat18 = u_xlat18 * u_xlat20;
    u_xlat20 = u_xlat18 * _HeigtFogColDelta3.w;
    u_xlat4.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=u_xlat4.x);
#else
    u_xlatb4 = u_xlat0.x>=u_xlat4.x;
#endif
    u_xlat18 = (u_xlatb4) ? u_xlat20 : u_xlat18;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _Mihoyo_FogColor3.w;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = min(u_xlat18, _HeigtFogColBase3.w);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat20 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat12 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat10.x = u_xlat20 * -1.44269502;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = (-u_xlat10.x) + 1.0;
    u_xlat10.x = u_xlat10.x / u_xlat20;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(0.00999999978<abs(u_xlat20));
#else
    u_xlatb20 = 0.00999999978<abs(u_xlat20);
#endif
    u_xlat16_3 = (u_xlatb20) ? u_xlat10.x : 1.0;
    u_xlat20 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat20 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat20 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat16_9 = (-u_xlat20) + 2.0;
    u_xlat16_9 = u_xlat20 * u_xlat16_9;
    u_xlat20 = u_xlat16_9 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat20 = u_xlat20 + 1.0;
    u_xlat16_3 = u_xlat20 * u_xlat16_3;
    u_xlat20 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat10.x = (-u_xlat20) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat10.xxx;
    u_xlat3.w = u_xlat18 * u_xlat10.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat20) + u_xlat2.xyz;
    u_xlat16_5 = (-u_xlat6.x) + 2.0;
    u_xlat16_5 = u_xlat6.x * u_xlat16_5;
    u_xlat2.xyz = vec3(u_xlat16_5) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat10.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat6.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat6.x = u_xlat6.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat6.xxx * u_xlat10.xyz + u_xlat2.xyz;
    u_xlat6.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat18 = (-u_xlat6.x) + 2.0;
    u_xlat6.x = u_xlat18 * u_xlat6.x;
    u_xlat18 = u_xlat6.x * _HeigtFogColDelta2.w;
    u_xlat6.x = (u_xlatb4) ? u_xlat18 : u_xlat6.x;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _Mihoyo_FogColor2.w;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat6.x = min(u_xlat6.x, _HeigtFogColBase2.w);
    u_xlat2.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat18 = u_xlat12 * -1.44269502;
    u_xlat6.z = exp2(u_xlat18);
    u_xlat6.xz = (-u_xlat6.xz) + vec2(1.0, 1.0);
    u_xlat18 = u_xlat6.z / u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.00999999978<abs(u_xlat12));
#else
    u_xlatb12 = 0.00999999978<abs(u_xlat12);
#endif
    u_xlat16_5 = (u_xlatb12) ? u_xlat18 : 1.0;
    u_xlat12 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat12 * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_11 = (-u_xlat0.x) + 2.0;
    u_xlat16_11 = u_xlat0.x * u_xlat16_11;
    u_xlat0.x = u_xlat16_11 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_5 = u_xlat0.x * u_xlat16_5;
    u_xlat0.x = min(u_xlat16_5, _HeigtFogColBase2.w);
    u_xlat12 = (-u_xlat0.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat4.w = u_xlat12 * u_xlat6.x;
    u_xlat4.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0 = u_xlat3 + (-u_xlat4);
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat4;
    vs_COLOR1 = u_xlat0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
bool u_xlatb4;
mediump float u_xlat16_5;
vec3 u_xlat6;
mediump float u_xlat16_9;
vec3 u_xlat10;
mediump float u_xlat16_11;
float u_xlat12;
bool u_xlatb12;
float u_xlat18;
float u_xlat20;
bool u_xlatb20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat18) + 2.0;
    u_xlat16_3 = u_xlat18 * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat6.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat18 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat18 = u_xlat18 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat18 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat20 = (-u_xlat18) + 2.0;
    u_xlat18 = u_xlat18 * u_xlat20;
    u_xlat20 = u_xlat18 * _HeigtFogColDelta3.w;
    u_xlat4.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=u_xlat4.x);
#else
    u_xlatb4 = u_xlat0.x>=u_xlat4.x;
#endif
    u_xlat18 = (u_xlatb4) ? u_xlat20 : u_xlat18;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _Mihoyo_FogColor3.w;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = min(u_xlat18, _HeigtFogColBase3.w);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat20 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat12 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat10.x = u_xlat20 * -1.44269502;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = (-u_xlat10.x) + 1.0;
    u_xlat10.x = u_xlat10.x / u_xlat20;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(0.00999999978<abs(u_xlat20));
#else
    u_xlatb20 = 0.00999999978<abs(u_xlat20);
#endif
    u_xlat16_3 = (u_xlatb20) ? u_xlat10.x : 1.0;
    u_xlat20 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat20 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat20 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat16_9 = (-u_xlat20) + 2.0;
    u_xlat16_9 = u_xlat20 * u_xlat16_9;
    u_xlat20 = u_xlat16_9 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat20 = u_xlat20 + 1.0;
    u_xlat16_3 = u_xlat20 * u_xlat16_3;
    u_xlat20 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat10.x = (-u_xlat20) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat10.xxx;
    u_xlat3.w = u_xlat18 * u_xlat10.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat20) + u_xlat2.xyz;
    u_xlat16_5 = (-u_xlat6.x) + 2.0;
    u_xlat16_5 = u_xlat6.x * u_xlat16_5;
    u_xlat2.xyz = vec3(u_xlat16_5) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat10.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat6.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat6.x = u_xlat6.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat6.xxx * u_xlat10.xyz + u_xlat2.xyz;
    u_xlat6.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat18 = (-u_xlat6.x) + 2.0;
    u_xlat6.x = u_xlat18 * u_xlat6.x;
    u_xlat18 = u_xlat6.x * _HeigtFogColDelta2.w;
    u_xlat6.x = (u_xlatb4) ? u_xlat18 : u_xlat6.x;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _Mihoyo_FogColor2.w;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat6.x = min(u_xlat6.x, _HeigtFogColBase2.w);
    u_xlat2.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat18 = u_xlat12 * -1.44269502;
    u_xlat6.z = exp2(u_xlat18);
    u_xlat6.xz = (-u_xlat6.xz) + vec2(1.0, 1.0);
    u_xlat18 = u_xlat6.z / u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.00999999978<abs(u_xlat12));
#else
    u_xlatb12 = 0.00999999978<abs(u_xlat12);
#endif
    u_xlat16_5 = (u_xlatb12) ? u_xlat18 : 1.0;
    u_xlat12 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat12 * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_11 = (-u_xlat0.x) + 2.0;
    u_xlat16_11 = u_xlat0.x * u_xlat16_11;
    u_xlat0.x = u_xlat16_11 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_5 = u_xlat0.x * u_xlat16_5;
    u_xlat0.x = min(u_xlat16_5, _HeigtFogColBase2.w);
    u_xlat12 = (-u_xlat0.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat4.w = u_xlat12 * u_xlat6.x;
    u_xlat4.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0 = u_xlat3 + (-u_xlat4);
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat4;
    vs_COLOR1 = u_xlat0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
bool u_xlatb4;
mediump float u_xlat16_5;
vec3 u_xlat6;
mediump float u_xlat16_9;
vec3 u_xlat10;
mediump float u_xlat16_11;
float u_xlat12;
bool u_xlatb12;
float u_xlat18;
float u_xlat20;
bool u_xlatb20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat18) + 2.0;
    u_xlat16_3 = u_xlat18 * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat6.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat18 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat18 = u_xlat18 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat18 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat20 = (-u_xlat18) + 2.0;
    u_xlat18 = u_xlat18 * u_xlat20;
    u_xlat20 = u_xlat18 * _HeigtFogColDelta3.w;
    u_xlat4.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=u_xlat4.x);
#else
    u_xlatb4 = u_xlat0.x>=u_xlat4.x;
#endif
    u_xlat18 = (u_xlatb4) ? u_xlat20 : u_xlat18;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _Mihoyo_FogColor3.w;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = min(u_xlat18, _HeigtFogColBase3.w);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat20 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat12 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat10.x = u_xlat20 * -1.44269502;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = (-u_xlat10.x) + 1.0;
    u_xlat10.x = u_xlat10.x / u_xlat20;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(0.00999999978<abs(u_xlat20));
#else
    u_xlatb20 = 0.00999999978<abs(u_xlat20);
#endif
    u_xlat16_3 = (u_xlatb20) ? u_xlat10.x : 1.0;
    u_xlat20 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat20 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat20 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat16_9 = (-u_xlat20) + 2.0;
    u_xlat16_9 = u_xlat20 * u_xlat16_9;
    u_xlat20 = u_xlat16_9 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat20 = u_xlat20 + 1.0;
    u_xlat16_3 = u_xlat20 * u_xlat16_3;
    u_xlat20 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat10.x = (-u_xlat20) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat10.xxx;
    u_xlat3.w = u_xlat18 * u_xlat10.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat20) + u_xlat2.xyz;
    u_xlat16_5 = (-u_xlat6.x) + 2.0;
    u_xlat16_5 = u_xlat6.x * u_xlat16_5;
    u_xlat2.xyz = vec3(u_xlat16_5) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat10.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat6.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat6.x = u_xlat6.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat6.xxx * u_xlat10.xyz + u_xlat2.xyz;
    u_xlat6.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat18 = (-u_xlat6.x) + 2.0;
    u_xlat6.x = u_xlat18 * u_xlat6.x;
    u_xlat18 = u_xlat6.x * _HeigtFogColDelta2.w;
    u_xlat6.x = (u_xlatb4) ? u_xlat18 : u_xlat6.x;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _Mihoyo_FogColor2.w;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat6.x = min(u_xlat6.x, _HeigtFogColBase2.w);
    u_xlat2.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat18 = u_xlat12 * -1.44269502;
    u_xlat6.z = exp2(u_xlat18);
    u_xlat6.xz = (-u_xlat6.xz) + vec2(1.0, 1.0);
    u_xlat18 = u_xlat6.z / u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.00999999978<abs(u_xlat12));
#else
    u_xlatb12 = 0.00999999978<abs(u_xlat12);
#endif
    u_xlat16_5 = (u_xlatb12) ? u_xlat18 : 1.0;
    u_xlat12 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat12 * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_11 = (-u_xlat0.x) + 2.0;
    u_xlat16_11 = u_xlat0.x * u_xlat16_11;
    u_xlat0.x = u_xlat16_11 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_5 = u_xlat0.x * u_xlat16_5;
    u_xlat0.x = min(u_xlat16_5, _HeigtFogColBase2.w);
    u_xlat12 = (-u_xlat0.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat4.w = u_xlat12 * u_xlat6.x;
    u_xlat4.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0 = u_xlat3 + (-u_xlat4);
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat4;
    vs_COLOR1 = u_xlat0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
bool u_xlatb4;
mediump float u_xlat16_5;
vec3 u_xlat6;
mediump float u_xlat16_9;
vec3 u_xlat10;
mediump float u_xlat16_11;
float u_xlat12;
bool u_xlatb12;
float u_xlat18;
float u_xlat20;
bool u_xlatb20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat18) + 2.0;
    u_xlat16_3 = u_xlat18 * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat6.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat18 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat18 = u_xlat18 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat18 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat20 = (-u_xlat18) + 2.0;
    u_xlat18 = u_xlat18 * u_xlat20;
    u_xlat20 = u_xlat18 * _HeigtFogColDelta3.w;
    u_xlat4.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=u_xlat4.x);
#else
    u_xlatb4 = u_xlat0.x>=u_xlat4.x;
#endif
    u_xlat18 = (u_xlatb4) ? u_xlat20 : u_xlat18;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _Mihoyo_FogColor3.w;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = min(u_xlat18, _HeigtFogColBase3.w);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat20 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat12 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat10.x = u_xlat20 * -1.44269502;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = (-u_xlat10.x) + 1.0;
    u_xlat10.x = u_xlat10.x / u_xlat20;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(0.00999999978<abs(u_xlat20));
#else
    u_xlatb20 = 0.00999999978<abs(u_xlat20);
#endif
    u_xlat16_3 = (u_xlatb20) ? u_xlat10.x : 1.0;
    u_xlat20 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat20 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat20 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat16_9 = (-u_xlat20) + 2.0;
    u_xlat16_9 = u_xlat20 * u_xlat16_9;
    u_xlat20 = u_xlat16_9 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat20 = u_xlat20 + 1.0;
    u_xlat16_3 = u_xlat20 * u_xlat16_3;
    u_xlat20 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat10.x = (-u_xlat20) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat10.xxx;
    u_xlat3.w = u_xlat18 * u_xlat10.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat20) + u_xlat2.xyz;
    u_xlat16_5 = (-u_xlat6.x) + 2.0;
    u_xlat16_5 = u_xlat6.x * u_xlat16_5;
    u_xlat2.xyz = vec3(u_xlat16_5) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat10.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat6.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat6.x = u_xlat6.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat6.xxx * u_xlat10.xyz + u_xlat2.xyz;
    u_xlat6.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat18 = (-u_xlat6.x) + 2.0;
    u_xlat6.x = u_xlat18 * u_xlat6.x;
    u_xlat18 = u_xlat6.x * _HeigtFogColDelta2.w;
    u_xlat6.x = (u_xlatb4) ? u_xlat18 : u_xlat6.x;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _Mihoyo_FogColor2.w;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat6.x = min(u_xlat6.x, _HeigtFogColBase2.w);
    u_xlat2.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat18 = u_xlat12 * -1.44269502;
    u_xlat6.z = exp2(u_xlat18);
    u_xlat6.xz = (-u_xlat6.xz) + vec2(1.0, 1.0);
    u_xlat18 = u_xlat6.z / u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.00999999978<abs(u_xlat12));
#else
    u_xlatb12 = 0.00999999978<abs(u_xlat12);
#endif
    u_xlat16_5 = (u_xlatb12) ? u_xlat18 : 1.0;
    u_xlat12 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat12 * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_11 = (-u_xlat0.x) + 2.0;
    u_xlat16_11 = u_xlat0.x * u_xlat16_11;
    u_xlat0.x = u_xlat16_11 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_5 = u_xlat0.x * u_xlat16_5;
    u_xlat0.x = min(u_xlat16_5, _HeigtFogColBase2.w);
    u_xlat12 = (-u_xlat0.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat4.w = u_xlat12 * u_xlat6.x;
    u_xlat4.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0 = u_xlat3 + (-u_xlat4);
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat4;
    vs_COLOR1 = u_xlat0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat16_2.xxx + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat12 = u_xlat2.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat2.x);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat2.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat6);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2.xy = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x + (-_UWFogDistStart);
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.xy = u_xlat2.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat2.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD3.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
bool u_xlatb8;
bool u_xlatb12;
void main()
{
    u_xlat0.x = (-vs_TEXCOORD3.z) + _WaterPlaneHeight;
    u_xlat4.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat0.x = u_xlat0.x / u_xlat4.x;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat4.x = (-u_xlat0.x) * _UWHeightRatio + 1.0;
    u_xlat4.x = u_xlat4.x * vs_TEXCOORD3.y;
    u_xlat4.x = max(u_xlat4.x, _UWCriticalRange);
    u_xlat4.x = min(u_xlat4.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.99000001<vs_TEXCOORD3.y);
#else
    u_xlatb8 = 0.99000001<vs_TEXCOORD3.y;
#endif
    u_xlat16_1 = (u_xlatb8) ? u_xlat4.x : vs_TEXCOORD3.y;
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_2.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_4.xyz * u_xlat10_2.xyz;
    u_xlat4.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat4.xyz = vs_TEXCOORD3.xxx * u_xlat4.xyz + _UWFogColorFar.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + (-u_xlat4.xyz);
    u_xlat3.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat4.xyz = vec3(u_xlat16_1) * u_xlat2.xyz + u_xlat4.xyz;
    u_xlat2.x = u_xlat0.x * _UWFogColorHLIntensity;
    u_xlat0.x = (-_UWHeightFogDensity) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat0.x * _UWHeightFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWHeightFogEffectStart);
    u_xlat0.x = min(u_xlat0.x, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat6.xyz + _UWFogColorLow.xyz;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD3.z<_WaterPlaneHeight);
#else
    u_xlatb12 = vs_TEXCOORD3.z<_WaterPlaneHeight;
#endif
    SV_Target0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyz : u_xlat3.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat12 = u_xlat2.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat2.x);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat2.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat6);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2.xy = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x + (-_UWFogDistStart);
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.xy = u_xlat2.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat2.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD3.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
bool u_xlatb8;
bool u_xlatb12;
void main()
{
    u_xlat0.x = (-vs_TEXCOORD3.z) + _WaterPlaneHeight;
    u_xlat4.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat0.x = u_xlat0.x / u_xlat4.x;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat4.x = (-u_xlat0.x) * _UWHeightRatio + 1.0;
    u_xlat4.x = u_xlat4.x * vs_TEXCOORD3.y;
    u_xlat4.x = max(u_xlat4.x, _UWCriticalRange);
    u_xlat4.x = min(u_xlat4.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.99000001<vs_TEXCOORD3.y);
#else
    u_xlatb8 = 0.99000001<vs_TEXCOORD3.y;
#endif
    u_xlat16_1 = (u_xlatb8) ? u_xlat4.x : vs_TEXCOORD3.y;
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_2.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_4.xyz * u_xlat10_2.xyz;
    u_xlat4.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat4.xyz = vs_TEXCOORD3.xxx * u_xlat4.xyz + _UWFogColorFar.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + (-u_xlat4.xyz);
    u_xlat3.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat4.xyz = vec3(u_xlat16_1) * u_xlat2.xyz + u_xlat4.xyz;
    u_xlat2.x = u_xlat0.x * _UWFogColorHLIntensity;
    u_xlat0.x = (-_UWHeightFogDensity) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat0.x * _UWHeightFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWHeightFogEffectStart);
    u_xlat0.x = min(u_xlat0.x, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat6.xyz + _UWFogColorLow.xyz;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD3.z<_WaterPlaneHeight);
#else
    u_xlatb12 = vs_TEXCOORD3.z<_WaterPlaneHeight;
#endif
    SV_Target0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyz : u_xlat3.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat12 = u_xlat2.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat2.x);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat2.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat6);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2.xy = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x + (-_UWFogDistStart);
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.xy = u_xlat2.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat2.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD3.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
bool u_xlatb8;
bool u_xlatb12;
void main()
{
    u_xlat0.x = (-vs_TEXCOORD3.z) + _WaterPlaneHeight;
    u_xlat4.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat0.x = u_xlat0.x / u_xlat4.x;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat4.x = (-u_xlat0.x) * _UWHeightRatio + 1.0;
    u_xlat4.x = u_xlat4.x * vs_TEXCOORD3.y;
    u_xlat4.x = max(u_xlat4.x, _UWCriticalRange);
    u_xlat4.x = min(u_xlat4.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.99000001<vs_TEXCOORD3.y);
#else
    u_xlatb8 = 0.99000001<vs_TEXCOORD3.y;
#endif
    u_xlat16_1 = (u_xlatb8) ? u_xlat4.x : vs_TEXCOORD3.y;
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_2.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_4.xyz * u_xlat10_2.xyz;
    u_xlat4.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat4.xyz = vs_TEXCOORD3.xxx * u_xlat4.xyz + _UWFogColorFar.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + (-u_xlat4.xyz);
    u_xlat3.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat4.xyz = vec3(u_xlat16_1) * u_xlat2.xyz + u_xlat4.xyz;
    u_xlat2.x = u_xlat0.x * _UWFogColorHLIntensity;
    u_xlat0.x = (-_UWHeightFogDensity) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat0.x * _UWHeightFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWHeightFogEffectStart);
    u_xlat0.x = min(u_xlat0.x, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat6.xyz + _UWFogColorLow.xyz;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD3.z<_WaterPlaneHeight);
#else
    u_xlatb12 = vs_TEXCOORD3.z<_WaterPlaneHeight;
#endif
    SV_Target0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyz : u_xlat3.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat12 = u_xlat2.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat2.x);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat2.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat6);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2.xy = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x + (-_UWFogDistStart);
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.xy = u_xlat2.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat2.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD3.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
bool u_xlatb8;
bool u_xlatb12;
void main()
{
    u_xlat0.x = (-vs_TEXCOORD3.z) + _WaterPlaneHeight;
    u_xlat4.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat0.x = u_xlat0.x / u_xlat4.x;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat4.x = (-u_xlat0.x) * _UWHeightRatio + 1.0;
    u_xlat4.x = u_xlat4.x * vs_TEXCOORD3.y;
    u_xlat4.x = max(u_xlat4.x, _UWCriticalRange);
    u_xlat4.x = min(u_xlat4.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.99000001<vs_TEXCOORD3.y);
#else
    u_xlatb8 = 0.99000001<vs_TEXCOORD3.y;
#endif
    u_xlat16_1.x = (u_xlatb8) ? u_xlat4.x : vs_TEXCOORD3.y;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_2.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_4.xyz * u_xlat10_2.xyz;
    u_xlat4.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat4.xyz = vs_TEXCOORD3.xxx * u_xlat4.xyz + _UWFogColorFar.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + (-u_xlat4.xyz);
    u_xlat3.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat4.xyz = u_xlat16_1.xxx * u_xlat2.xyz + u_xlat4.xyz;
    u_xlat2.x = u_xlat0.x * _UWFogColorHLIntensity;
    u_xlat0.x = (-_UWHeightFogDensity) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat0.x * _UWHeightFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWHeightFogEffectStart);
    u_xlat0.x = min(u_xlat0.x, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat6.xyz + _UWFogColorLow.xyz;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD3.z<_WaterPlaneHeight);
#else
    u_xlatb12 = vs_TEXCOORD3.z<_WaterPlaneHeight;
#endif
    u_xlat16_1.xyz = (bool(u_xlatb12)) ? u_xlat0.xyz : u_xlat3.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat12 = u_xlat2.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat2.x);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat2.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat6);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2.xy = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x + (-_UWFogDistStart);
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.xy = u_xlat2.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat2.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD3.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
bool u_xlatb8;
bool u_xlatb12;
void main()
{
    u_xlat0.x = (-vs_TEXCOORD3.z) + _WaterPlaneHeight;
    u_xlat4.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat0.x = u_xlat0.x / u_xlat4.x;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat4.x = (-u_xlat0.x) * _UWHeightRatio + 1.0;
    u_xlat4.x = u_xlat4.x * vs_TEXCOORD3.y;
    u_xlat4.x = max(u_xlat4.x, _UWCriticalRange);
    u_xlat4.x = min(u_xlat4.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.99000001<vs_TEXCOORD3.y);
#else
    u_xlatb8 = 0.99000001<vs_TEXCOORD3.y;
#endif
    u_xlat16_1.x = (u_xlatb8) ? u_xlat4.x : vs_TEXCOORD3.y;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_2.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_4.xyz * u_xlat10_2.xyz;
    u_xlat4.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat4.xyz = vs_TEXCOORD3.xxx * u_xlat4.xyz + _UWFogColorFar.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + (-u_xlat4.xyz);
    u_xlat3.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat4.xyz = u_xlat16_1.xxx * u_xlat2.xyz + u_xlat4.xyz;
    u_xlat2.x = u_xlat0.x * _UWFogColorHLIntensity;
    u_xlat0.x = (-_UWHeightFogDensity) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat0.x * _UWHeightFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWHeightFogEffectStart);
    u_xlat0.x = min(u_xlat0.x, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat6.xyz + _UWFogColorLow.xyz;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD3.z<_WaterPlaneHeight);
#else
    u_xlatb12 = vs_TEXCOORD3.z<_WaterPlaneHeight;
#endif
    u_xlat16_1.xyz = (bool(u_xlatb12)) ? u_xlat0.xyz : u_xlat3.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat12 = u_xlat2.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat2.x);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat2.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat6);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2.xy = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x + (-_UWFogDistStart);
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.xy = u_xlat2.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat2.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD3.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
bool u_xlatb8;
bool u_xlatb12;
void main()
{
    u_xlat0.x = (-vs_TEXCOORD3.z) + _WaterPlaneHeight;
    u_xlat4.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat0.x = u_xlat0.x / u_xlat4.x;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat4.x = (-u_xlat0.x) * _UWHeightRatio + 1.0;
    u_xlat4.x = u_xlat4.x * vs_TEXCOORD3.y;
    u_xlat4.x = max(u_xlat4.x, _UWCriticalRange);
    u_xlat4.x = min(u_xlat4.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.99000001<vs_TEXCOORD3.y);
#else
    u_xlatb8 = 0.99000001<vs_TEXCOORD3.y;
#endif
    u_xlat16_1.x = (u_xlatb8) ? u_xlat4.x : vs_TEXCOORD3.y;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_2.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_4.xyz * u_xlat10_2.xyz;
    u_xlat4.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat4.xyz = vs_TEXCOORD3.xxx * u_xlat4.xyz + _UWFogColorFar.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + (-u_xlat4.xyz);
    u_xlat3.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat4.xyz = u_xlat16_1.xxx * u_xlat2.xyz + u_xlat4.xyz;
    u_xlat2.x = u_xlat0.x * _UWFogColorHLIntensity;
    u_xlat0.x = (-_UWHeightFogDensity) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat0.x * _UWHeightFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWHeightFogEffectStart);
    u_xlat0.x = min(u_xlat0.x, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat6.xyz + _UWFogColorLow.xyz;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD3.z<_WaterPlaneHeight);
#else
    u_xlatb12 = vs_TEXCOORD3.z<_WaterPlaneHeight;
#endif
    u_xlat16_1.xyz = (bool(u_xlatb12)) ? u_xlat0.xyz : u_xlat3.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat12 = u_xlat2.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat2.x);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat2.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat6);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2.xy = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x + (-_UWFogDistStart);
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.xy = u_xlat2.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat2.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD3.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
bool u_xlatb8;
bool u_xlatb12;
void main()
{
    u_xlat0.x = (-vs_TEXCOORD3.z) + _WaterPlaneHeight;
    u_xlat4.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat0.x = u_xlat0.x / u_xlat4.x;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat4.x = (-u_xlat0.x) * _UWHeightRatio + 1.0;
    u_xlat4.x = u_xlat4.x * vs_TEXCOORD3.y;
    u_xlat4.x = max(u_xlat4.x, _UWCriticalRange);
    u_xlat4.x = min(u_xlat4.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.99000001<vs_TEXCOORD3.y);
#else
    u_xlatb8 = 0.99000001<vs_TEXCOORD3.y;
#endif
    u_xlat16_1 = (u_xlatb8) ? u_xlat4.x : vs_TEXCOORD3.y;
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_2.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_4.xyz * u_xlat10_2.xyz;
    u_xlat4.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat4.xyz = vs_TEXCOORD3.xxx * u_xlat4.xyz + _UWFogColorFar.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + (-u_xlat4.xyz);
    u_xlat3.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat4.xyz = vec3(u_xlat16_1) * u_xlat2.xyz + u_xlat4.xyz;
    u_xlat2.x = u_xlat0.x * _UWFogColorHLIntensity;
    u_xlat0.x = (-_UWHeightFogDensity) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat0.x * _UWHeightFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWHeightFogEffectStart);
    u_xlat0.x = min(u_xlat0.x, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat6.xyz + _UWFogColorLow.xyz;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD3.z<_WaterPlaneHeight);
#else
    u_xlatb12 = vs_TEXCOORD3.z<_WaterPlaneHeight;
#endif
    SV_Target0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyz : u_xlat3.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat12 = u_xlat2.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat2.x);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat2.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat6);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2.xy = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x + (-_UWFogDistStart);
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.xy = u_xlat2.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat2.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD3.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
bool u_xlatb8;
bool u_xlatb12;
void main()
{
    u_xlat0.x = (-vs_TEXCOORD3.z) + _WaterPlaneHeight;
    u_xlat4.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat0.x = u_xlat0.x / u_xlat4.x;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat4.x = (-u_xlat0.x) * _UWHeightRatio + 1.0;
    u_xlat4.x = u_xlat4.x * vs_TEXCOORD3.y;
    u_xlat4.x = max(u_xlat4.x, _UWCriticalRange);
    u_xlat4.x = min(u_xlat4.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.99000001<vs_TEXCOORD3.y);
#else
    u_xlatb8 = 0.99000001<vs_TEXCOORD3.y;
#endif
    u_xlat16_1 = (u_xlatb8) ? u_xlat4.x : vs_TEXCOORD3.y;
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_2.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_4.xyz * u_xlat10_2.xyz;
    u_xlat4.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat4.xyz = vs_TEXCOORD3.xxx * u_xlat4.xyz + _UWFogColorFar.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + (-u_xlat4.xyz);
    u_xlat3.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat4.xyz = vec3(u_xlat16_1) * u_xlat2.xyz + u_xlat4.xyz;
    u_xlat2.x = u_xlat0.x * _UWFogColorHLIntensity;
    u_xlat0.x = (-_UWHeightFogDensity) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat0.x * _UWHeightFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWHeightFogEffectStart);
    u_xlat0.x = min(u_xlat0.x, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat6.xyz + _UWFogColorLow.xyz;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD3.z<_WaterPlaneHeight);
#else
    u_xlatb12 = vs_TEXCOORD3.z<_WaterPlaneHeight;
#endif
    SV_Target0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyz : u_xlat3.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat12 = u_xlat2.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat2.x);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat2.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat6);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2.xy = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x + (-_UWFogDistStart);
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.xy = u_xlat2.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat2.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD3.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
bool u_xlatb8;
bool u_xlatb12;
void main()
{
    u_xlat0.x = (-vs_TEXCOORD3.z) + _WaterPlaneHeight;
    u_xlat4.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat0.x = u_xlat0.x / u_xlat4.x;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat4.x = (-u_xlat0.x) * _UWHeightRatio + 1.0;
    u_xlat4.x = u_xlat4.x * vs_TEXCOORD3.y;
    u_xlat4.x = max(u_xlat4.x, _UWCriticalRange);
    u_xlat4.x = min(u_xlat4.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.99000001<vs_TEXCOORD3.y);
#else
    u_xlatb8 = 0.99000001<vs_TEXCOORD3.y;
#endif
    u_xlat16_1 = (u_xlatb8) ? u_xlat4.x : vs_TEXCOORD3.y;
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_2.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_4.xyz * u_xlat10_2.xyz;
    u_xlat4.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat4.xyz = vs_TEXCOORD3.xxx * u_xlat4.xyz + _UWFogColorFar.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + (-u_xlat4.xyz);
    u_xlat3.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat4.xyz = vec3(u_xlat16_1) * u_xlat2.xyz + u_xlat4.xyz;
    u_xlat2.x = u_xlat0.x * _UWFogColorHLIntensity;
    u_xlat0.x = (-_UWHeightFogDensity) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat0.x * _UWHeightFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWHeightFogEffectStart);
    u_xlat0.x = min(u_xlat0.x, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat6.xyz + _UWFogColorLow.xyz;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD3.z<_WaterPlaneHeight);
#else
    u_xlatb12 = vs_TEXCOORD3.z<_WaterPlaneHeight;
#endif
    SV_Target0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyz : u_xlat3.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat12 = u_xlat2.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat2.x);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat2.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat6);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2.xy = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x + (-_UWFogDistStart);
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.xy = u_xlat2.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat2.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD3.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
bool u_xlatb8;
bool u_xlatb12;
void main()
{
    u_xlat0.x = (-vs_TEXCOORD3.z) + _WaterPlaneHeight;
    u_xlat4.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat0.x = u_xlat0.x / u_xlat4.x;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat4.x = (-u_xlat0.x) * _UWHeightRatio + 1.0;
    u_xlat4.x = u_xlat4.x * vs_TEXCOORD3.y;
    u_xlat4.x = max(u_xlat4.x, _UWCriticalRange);
    u_xlat4.x = min(u_xlat4.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.99000001<vs_TEXCOORD3.y);
#else
    u_xlatb8 = 0.99000001<vs_TEXCOORD3.y;
#endif
    u_xlat16_1.x = (u_xlatb8) ? u_xlat4.x : vs_TEXCOORD3.y;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_2.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_4.xyz * u_xlat10_2.xyz;
    u_xlat4.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat4.xyz = vs_TEXCOORD3.xxx * u_xlat4.xyz + _UWFogColorFar.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + (-u_xlat4.xyz);
    u_xlat3.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat4.xyz = u_xlat16_1.xxx * u_xlat2.xyz + u_xlat4.xyz;
    u_xlat2.x = u_xlat0.x * _UWFogColorHLIntensity;
    u_xlat0.x = (-_UWHeightFogDensity) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat0.x * _UWHeightFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWHeightFogEffectStart);
    u_xlat0.x = min(u_xlat0.x, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat6.xyz + _UWFogColorLow.xyz;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD3.z<_WaterPlaneHeight);
#else
    u_xlatb12 = vs_TEXCOORD3.z<_WaterPlaneHeight;
#endif
    u_xlat16_1.xyz = (bool(u_xlatb12)) ? u_xlat0.xyz : u_xlat3.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat12 = u_xlat2.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat2.x);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat2.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat6);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2.xy = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x + (-_UWFogDistStart);
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.xy = u_xlat2.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat2.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD3.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
bool u_xlatb8;
bool u_xlatb12;
void main()
{
    u_xlat0.x = (-vs_TEXCOORD3.z) + _WaterPlaneHeight;
    u_xlat4.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat0.x = u_xlat0.x / u_xlat4.x;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat4.x = (-u_xlat0.x) * _UWHeightRatio + 1.0;
    u_xlat4.x = u_xlat4.x * vs_TEXCOORD3.y;
    u_xlat4.x = max(u_xlat4.x, _UWCriticalRange);
    u_xlat4.x = min(u_xlat4.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.99000001<vs_TEXCOORD3.y);
#else
    u_xlatb8 = 0.99000001<vs_TEXCOORD3.y;
#endif
    u_xlat16_1.x = (u_xlatb8) ? u_xlat4.x : vs_TEXCOORD3.y;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_2.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_4.xyz * u_xlat10_2.xyz;
    u_xlat4.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat4.xyz = vs_TEXCOORD3.xxx * u_xlat4.xyz + _UWFogColorFar.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + (-u_xlat4.xyz);
    u_xlat3.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat4.xyz = u_xlat16_1.xxx * u_xlat2.xyz + u_xlat4.xyz;
    u_xlat2.x = u_xlat0.x * _UWFogColorHLIntensity;
    u_xlat0.x = (-_UWHeightFogDensity) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat0.x * _UWHeightFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWHeightFogEffectStart);
    u_xlat0.x = min(u_xlat0.x, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat6.xyz + _UWFogColorLow.xyz;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD3.z<_WaterPlaneHeight);
#else
    u_xlatb12 = vs_TEXCOORD3.z<_WaterPlaneHeight;
#endif
    u_xlat16_1.xyz = (bool(u_xlatb12)) ? u_xlat0.xyz : u_xlat3.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat12 = u_xlat2.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat2.x);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat2.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat6);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2.xy = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x + (-_UWFogDistStart);
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.xy = u_xlat2.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat2.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD3.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
bool u_xlatb8;
bool u_xlatb12;
void main()
{
    u_xlat0.x = (-vs_TEXCOORD3.z) + _WaterPlaneHeight;
    u_xlat4.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat0.x = u_xlat0.x / u_xlat4.x;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat4.x = (-u_xlat0.x) * _UWHeightRatio + 1.0;
    u_xlat4.x = u_xlat4.x * vs_TEXCOORD3.y;
    u_xlat4.x = max(u_xlat4.x, _UWCriticalRange);
    u_xlat4.x = min(u_xlat4.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.99000001<vs_TEXCOORD3.y);
#else
    u_xlatb8 = 0.99000001<vs_TEXCOORD3.y;
#endif
    u_xlat16_1.x = (u_xlatb8) ? u_xlat4.x : vs_TEXCOORD3.y;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_2.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_4.xyz * u_xlat10_2.xyz;
    u_xlat4.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat4.xyz = vs_TEXCOORD3.xxx * u_xlat4.xyz + _UWFogColorFar.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + (-u_xlat4.xyz);
    u_xlat3.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat4.xyz = u_xlat16_1.xxx * u_xlat2.xyz + u_xlat4.xyz;
    u_xlat2.x = u_xlat0.x * _UWFogColorHLIntensity;
    u_xlat0.x = (-_UWHeightFogDensity) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat0.x * _UWHeightFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWHeightFogEffectStart);
    u_xlat0.x = min(u_xlat0.x, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat6.xyz + _UWFogColorLow.xyz;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD3.z<_WaterPlaneHeight);
#else
    u_xlatb12 = vs_TEXCOORD3.z<_WaterPlaneHeight;
#endif
    u_xlat16_1.xyz = (bool(u_xlatb12)) ? u_xlat0.xyz : u_xlat3.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
vec2 u_xlat16;
float u_xlat20;
float u_xlat22;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat2.x = u_xlat0.w * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat2.x) + 2.0;
    u_xlat16_3 = u_xlat2.x * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
    u_xlat20 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat20 = sqrt(u_xlat20);
    u_xlat22 = u_xlat20 + (-_HeigtFogRamp.w);
    u_xlat22 = u_xlat22 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat4.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat20>=u_xlat4.x);
#else
    u_xlatb4 = u_xlat20>=u_xlat4.x;
#endif
    u_xlat10 = u_xlat20 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat16.x = (-u_xlat10) + 2.0;
    u_xlat10 = u_xlat16.x * u_xlat10;
    u_xlat16.x = u_xlat10 * _HeigtFogColDelta.w;
    u_xlat4.x = (u_xlatb4) ? u_xlat16.x : u_xlat10;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _Mihoyo_FogColor.w;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, _HeigtFogColBase.w);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat10 = u_xlat5.y * _HeigtFogParams.x;
    u_xlat16.x = dot(u_xlat5.xz, u_xlat5.xz);
    u_xlat16.x = sqrt(u_xlat16.x);
    u_xlat16.x = u_xlat16.x + (-_UWFogDistStart);
    u_xlat16.x = max(u_xlat16.x, 0.0);
    u_xlat16.xy = u_xlat16.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat16.xy = u_xlat16.xy * (-u_xlat16.xy);
    u_xlat16.xy = u_xlat16.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat16.xy);
    u_xlat16.x = u_xlat10 * -1.44269502;
    u_xlat4.z = exp2(u_xlat16.x);
    u_xlat4.xz = (-u_xlat4.xz) + vec2(1.0, 1.0);
    u_xlat16.x = u_xlat4.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_3 = (u_xlatb10) ? u_xlat16.x : 1.0;
    u_xlat10 = u_xlat20 * _HeigtFogParams.y;
    u_xlat20 = u_xlat20 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat16_3 * u_xlat10;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_9 = (-u_xlat20) + 2.0;
    u_xlat16_9 = u_xlat20 * u_xlat16_9;
    u_xlat20 = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat20 = u_xlat20 + 1.0;
    u_xlat16_3 = u_xlat20 * u_xlat16_3;
    u_xlat20 = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat10 = (-u_xlat20) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat10);
    u_xlat3.w = u_xlat10 * u_xlat4.x;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat20) + u_xlat2.xyz;
    vs_COLOR1 = u_xlat3;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD3.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
bool u_xlatb8;
bool u_xlatb12;
void main()
{
    u_xlat0.x = (-vs_TEXCOORD3.z) + _WaterPlaneHeight;
    u_xlat4.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat0.x = u_xlat0.x / u_xlat4.x;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat4.x = (-u_xlat0.x) * _UWHeightRatio + 1.0;
    u_xlat4.x = u_xlat4.x * vs_TEXCOORD3.y;
    u_xlat4.x = max(u_xlat4.x, _UWCriticalRange);
    u_xlat4.x = min(u_xlat4.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.99000001<vs_TEXCOORD3.y);
#else
    u_xlatb8 = 0.99000001<vs_TEXCOORD3.y;
#endif
    u_xlat16_1 = (u_xlatb8) ? u_xlat4.x : vs_TEXCOORD3.y;
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_2.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_4.xyz * u_xlat10_2.xyz;
    u_xlat4.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat4.xyz = vs_TEXCOORD3.xxx * u_xlat4.xyz + _UWFogColorFar.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + (-u_xlat4.xyz);
    u_xlat3.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat4.xyz = vec3(u_xlat16_1) * u_xlat2.xyz + u_xlat4.xyz;
    u_xlat2.x = u_xlat0.x * _UWFogColorHLIntensity;
    u_xlat0.x = (-_UWHeightFogDensity) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat0.x * _UWHeightFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWHeightFogEffectStart);
    u_xlat0.x = min(u_xlat0.x, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat6.xyz + _UWFogColorLow.xyz;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD3.z<_WaterPlaneHeight);
#else
    u_xlatb12 = vs_TEXCOORD3.z<_WaterPlaneHeight;
#endif
    SV_Target0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyz : u_xlat3.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
vec2 u_xlat16;
float u_xlat20;
float u_xlat22;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat2.x = u_xlat0.w * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat2.x) + 2.0;
    u_xlat16_3 = u_xlat2.x * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
    u_xlat20 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat20 = sqrt(u_xlat20);
    u_xlat22 = u_xlat20 + (-_HeigtFogRamp.w);
    u_xlat22 = u_xlat22 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat4.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat20>=u_xlat4.x);
#else
    u_xlatb4 = u_xlat20>=u_xlat4.x;
#endif
    u_xlat10 = u_xlat20 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat16.x = (-u_xlat10) + 2.0;
    u_xlat10 = u_xlat16.x * u_xlat10;
    u_xlat16.x = u_xlat10 * _HeigtFogColDelta.w;
    u_xlat4.x = (u_xlatb4) ? u_xlat16.x : u_xlat10;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _Mihoyo_FogColor.w;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, _HeigtFogColBase.w);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat10 = u_xlat5.y * _HeigtFogParams.x;
    u_xlat16.x = dot(u_xlat5.xz, u_xlat5.xz);
    u_xlat16.x = sqrt(u_xlat16.x);
    u_xlat16.x = u_xlat16.x + (-_UWFogDistStart);
    u_xlat16.x = max(u_xlat16.x, 0.0);
    u_xlat16.xy = u_xlat16.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat16.xy = u_xlat16.xy * (-u_xlat16.xy);
    u_xlat16.xy = u_xlat16.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat16.xy);
    u_xlat16.x = u_xlat10 * -1.44269502;
    u_xlat4.z = exp2(u_xlat16.x);
    u_xlat4.xz = (-u_xlat4.xz) + vec2(1.0, 1.0);
    u_xlat16.x = u_xlat4.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_3 = (u_xlatb10) ? u_xlat16.x : 1.0;
    u_xlat10 = u_xlat20 * _HeigtFogParams.y;
    u_xlat20 = u_xlat20 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat16_3 * u_xlat10;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_9 = (-u_xlat20) + 2.0;
    u_xlat16_9 = u_xlat20 * u_xlat16_9;
    u_xlat20 = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat20 = u_xlat20 + 1.0;
    u_xlat16_3 = u_xlat20 * u_xlat16_3;
    u_xlat20 = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat10 = (-u_xlat20) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat10);
    u_xlat3.w = u_xlat10 * u_xlat4.x;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat20) + u_xlat2.xyz;
    vs_COLOR1 = u_xlat3;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD3.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
bool u_xlatb8;
bool u_xlatb12;
void main()
{
    u_xlat0.x = (-vs_TEXCOORD3.z) + _WaterPlaneHeight;
    u_xlat4.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat0.x = u_xlat0.x / u_xlat4.x;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat4.x = (-u_xlat0.x) * _UWHeightRatio + 1.0;
    u_xlat4.x = u_xlat4.x * vs_TEXCOORD3.y;
    u_xlat4.x = max(u_xlat4.x, _UWCriticalRange);
    u_xlat4.x = min(u_xlat4.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.99000001<vs_TEXCOORD3.y);
#else
    u_xlatb8 = 0.99000001<vs_TEXCOORD3.y;
#endif
    u_xlat16_1 = (u_xlatb8) ? u_xlat4.x : vs_TEXCOORD3.y;
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_2.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_4.xyz * u_xlat10_2.xyz;
    u_xlat4.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat4.xyz = vs_TEXCOORD3.xxx * u_xlat4.xyz + _UWFogColorFar.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + (-u_xlat4.xyz);
    u_xlat3.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat4.xyz = vec3(u_xlat16_1) * u_xlat2.xyz + u_xlat4.xyz;
    u_xlat2.x = u_xlat0.x * _UWFogColorHLIntensity;
    u_xlat0.x = (-_UWHeightFogDensity) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat0.x * _UWHeightFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWHeightFogEffectStart);
    u_xlat0.x = min(u_xlat0.x, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat6.xyz + _UWFogColorLow.xyz;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD3.z<_WaterPlaneHeight);
#else
    u_xlatb12 = vs_TEXCOORD3.z<_WaterPlaneHeight;
#endif
    SV_Target0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyz : u_xlat3.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
vec2 u_xlat16;
float u_xlat20;
float u_xlat22;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat2.x = u_xlat0.w * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat2.x) + 2.0;
    u_xlat16_3 = u_xlat2.x * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
    u_xlat20 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat20 = sqrt(u_xlat20);
    u_xlat22 = u_xlat20 + (-_HeigtFogRamp.w);
    u_xlat22 = u_xlat22 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat4.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat20>=u_xlat4.x);
#else
    u_xlatb4 = u_xlat20>=u_xlat4.x;
#endif
    u_xlat10 = u_xlat20 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat16.x = (-u_xlat10) + 2.0;
    u_xlat10 = u_xlat16.x * u_xlat10;
    u_xlat16.x = u_xlat10 * _HeigtFogColDelta.w;
    u_xlat4.x = (u_xlatb4) ? u_xlat16.x : u_xlat10;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _Mihoyo_FogColor.w;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, _HeigtFogColBase.w);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat10 = u_xlat5.y * _HeigtFogParams.x;
    u_xlat16.x = dot(u_xlat5.xz, u_xlat5.xz);
    u_xlat16.x = sqrt(u_xlat16.x);
    u_xlat16.x = u_xlat16.x + (-_UWFogDistStart);
    u_xlat16.x = max(u_xlat16.x, 0.0);
    u_xlat16.xy = u_xlat16.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat16.xy = u_xlat16.xy * (-u_xlat16.xy);
    u_xlat16.xy = u_xlat16.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat16.xy);
    u_xlat16.x = u_xlat10 * -1.44269502;
    u_xlat4.z = exp2(u_xlat16.x);
    u_xlat4.xz = (-u_xlat4.xz) + vec2(1.0, 1.0);
    u_xlat16.x = u_xlat4.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_3 = (u_xlatb10) ? u_xlat16.x : 1.0;
    u_xlat10 = u_xlat20 * _HeigtFogParams.y;
    u_xlat20 = u_xlat20 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat16_3 * u_xlat10;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_9 = (-u_xlat20) + 2.0;
    u_xlat16_9 = u_xlat20 * u_xlat16_9;
    u_xlat20 = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat20 = u_xlat20 + 1.0;
    u_xlat16_3 = u_xlat20 * u_xlat16_3;
    u_xlat20 = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat10 = (-u_xlat20) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat10);
    u_xlat3.w = u_xlat10 * u_xlat4.x;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat20) + u_xlat2.xyz;
    vs_COLOR1 = u_xlat3;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD3.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
bool u_xlatb8;
bool u_xlatb12;
void main()
{
    u_xlat0.x = (-vs_TEXCOORD3.z) + _WaterPlaneHeight;
    u_xlat4.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat0.x = u_xlat0.x / u_xlat4.x;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat4.x = (-u_xlat0.x) * _UWHeightRatio + 1.0;
    u_xlat4.x = u_xlat4.x * vs_TEXCOORD3.y;
    u_xlat4.x = max(u_xlat4.x, _UWCriticalRange);
    u_xlat4.x = min(u_xlat4.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.99000001<vs_TEXCOORD3.y);
#else
    u_xlatb8 = 0.99000001<vs_TEXCOORD3.y;
#endif
    u_xlat16_1 = (u_xlatb8) ? u_xlat4.x : vs_TEXCOORD3.y;
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_2.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_4.xyz * u_xlat10_2.xyz;
    u_xlat4.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat4.xyz = vs_TEXCOORD3.xxx * u_xlat4.xyz + _UWFogColorFar.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + (-u_xlat4.xyz);
    u_xlat3.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat4.xyz = vec3(u_xlat16_1) * u_xlat2.xyz + u_xlat4.xyz;
    u_xlat2.x = u_xlat0.x * _UWFogColorHLIntensity;
    u_xlat0.x = (-_UWHeightFogDensity) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat0.x * _UWHeightFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWHeightFogEffectStart);
    u_xlat0.x = min(u_xlat0.x, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat6.xyz + _UWFogColorLow.xyz;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD3.z<_WaterPlaneHeight);
#else
    u_xlatb12 = vs_TEXCOORD3.z<_WaterPlaneHeight;
#endif
    SV_Target0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyz : u_xlat3.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
vec2 u_xlat16;
float u_xlat20;
float u_xlat22;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat2.x = u_xlat0.w * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat2.x) + 2.0;
    u_xlat16_3 = u_xlat2.x * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
    u_xlat20 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat20 = sqrt(u_xlat20);
    u_xlat22 = u_xlat20 + (-_HeigtFogRamp.w);
    u_xlat22 = u_xlat22 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat4.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat20>=u_xlat4.x);
#else
    u_xlatb4 = u_xlat20>=u_xlat4.x;
#endif
    u_xlat10 = u_xlat20 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat16.x = (-u_xlat10) + 2.0;
    u_xlat10 = u_xlat16.x * u_xlat10;
    u_xlat16.x = u_xlat10 * _HeigtFogColDelta.w;
    u_xlat4.x = (u_xlatb4) ? u_xlat16.x : u_xlat10;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _Mihoyo_FogColor.w;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, _HeigtFogColBase.w);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat10 = u_xlat5.y * _HeigtFogParams.x;
    u_xlat16.x = dot(u_xlat5.xz, u_xlat5.xz);
    u_xlat16.x = sqrt(u_xlat16.x);
    u_xlat16.x = u_xlat16.x + (-_UWFogDistStart);
    u_xlat16.x = max(u_xlat16.x, 0.0);
    u_xlat16.xy = u_xlat16.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat16.xy = u_xlat16.xy * (-u_xlat16.xy);
    u_xlat16.xy = u_xlat16.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat16.xy);
    u_xlat16.x = u_xlat10 * -1.44269502;
    u_xlat4.z = exp2(u_xlat16.x);
    u_xlat4.xz = (-u_xlat4.xz) + vec2(1.0, 1.0);
    u_xlat16.x = u_xlat4.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_3 = (u_xlatb10) ? u_xlat16.x : 1.0;
    u_xlat10 = u_xlat20 * _HeigtFogParams.y;
    u_xlat20 = u_xlat20 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat16_3 * u_xlat10;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_9 = (-u_xlat20) + 2.0;
    u_xlat16_9 = u_xlat20 * u_xlat16_9;
    u_xlat20 = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat20 = u_xlat20 + 1.0;
    u_xlat16_3 = u_xlat20 * u_xlat16_3;
    u_xlat20 = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat10 = (-u_xlat20) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat10);
    u_xlat3.w = u_xlat10 * u_xlat4.x;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat20) + u_xlat2.xyz;
    vs_COLOR1 = u_xlat3;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD3.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
bool u_xlatb8;
bool u_xlatb12;
void main()
{
    u_xlat0.x = (-vs_TEXCOORD3.z) + _WaterPlaneHeight;
    u_xlat4.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat0.x = u_xlat0.x / u_xlat4.x;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat4.x = (-u_xlat0.x) * _UWHeightRatio + 1.0;
    u_xlat4.x = u_xlat4.x * vs_TEXCOORD3.y;
    u_xlat4.x = max(u_xlat4.x, _UWCriticalRange);
    u_xlat4.x = min(u_xlat4.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.99000001<vs_TEXCOORD3.y);
#else
    u_xlatb8 = 0.99000001<vs_TEXCOORD3.y;
#endif
    u_xlat16_1.x = (u_xlatb8) ? u_xlat4.x : vs_TEXCOORD3.y;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_2.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_4.xyz * u_xlat10_2.xyz;
    u_xlat4.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat4.xyz = vs_TEXCOORD3.xxx * u_xlat4.xyz + _UWFogColorFar.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + (-u_xlat4.xyz);
    u_xlat3.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat4.xyz = u_xlat16_1.xxx * u_xlat2.xyz + u_xlat4.xyz;
    u_xlat2.x = u_xlat0.x * _UWFogColorHLIntensity;
    u_xlat0.x = (-_UWHeightFogDensity) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat0.x * _UWHeightFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWHeightFogEffectStart);
    u_xlat0.x = min(u_xlat0.x, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat6.xyz + _UWFogColorLow.xyz;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD3.z<_WaterPlaneHeight);
#else
    u_xlatb12 = vs_TEXCOORD3.z<_WaterPlaneHeight;
#endif
    u_xlat16_1.xyz = (bool(u_xlatb12)) ? u_xlat0.xyz : u_xlat3.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
vec2 u_xlat16;
float u_xlat20;
float u_xlat22;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat2.x = u_xlat0.w * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat2.x) + 2.0;
    u_xlat16_3 = u_xlat2.x * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
    u_xlat20 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat20 = sqrt(u_xlat20);
    u_xlat22 = u_xlat20 + (-_HeigtFogRamp.w);
    u_xlat22 = u_xlat22 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat4.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat20>=u_xlat4.x);
#else
    u_xlatb4 = u_xlat20>=u_xlat4.x;
#endif
    u_xlat10 = u_xlat20 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat16.x = (-u_xlat10) + 2.0;
    u_xlat10 = u_xlat16.x * u_xlat10;
    u_xlat16.x = u_xlat10 * _HeigtFogColDelta.w;
    u_xlat4.x = (u_xlatb4) ? u_xlat16.x : u_xlat10;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _Mihoyo_FogColor.w;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, _HeigtFogColBase.w);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat10 = u_xlat5.y * _HeigtFogParams.x;
    u_xlat16.x = dot(u_xlat5.xz, u_xlat5.xz);
    u_xlat16.x = sqrt(u_xlat16.x);
    u_xlat16.x = u_xlat16.x + (-_UWFogDistStart);
    u_xlat16.x = max(u_xlat16.x, 0.0);
    u_xlat16.xy = u_xlat16.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat16.xy = u_xlat16.xy * (-u_xlat16.xy);
    u_xlat16.xy = u_xlat16.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat16.xy);
    u_xlat16.x = u_xlat10 * -1.44269502;
    u_xlat4.z = exp2(u_xlat16.x);
    u_xlat4.xz = (-u_xlat4.xz) + vec2(1.0, 1.0);
    u_xlat16.x = u_xlat4.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_3 = (u_xlatb10) ? u_xlat16.x : 1.0;
    u_xlat10 = u_xlat20 * _HeigtFogParams.y;
    u_xlat20 = u_xlat20 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat16_3 * u_xlat10;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_9 = (-u_xlat20) + 2.0;
    u_xlat16_9 = u_xlat20 * u_xlat16_9;
    u_xlat20 = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat20 = u_xlat20 + 1.0;
    u_xlat16_3 = u_xlat20 * u_xlat16_3;
    u_xlat20 = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat10 = (-u_xlat20) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat10);
    u_xlat3.w = u_xlat10 * u_xlat4.x;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat20) + u_xlat2.xyz;
    vs_COLOR1 = u_xlat3;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD3.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
bool u_xlatb8;
bool u_xlatb12;
void main()
{
    u_xlat0.x = (-vs_TEXCOORD3.z) + _WaterPlaneHeight;
    u_xlat4.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat0.x = u_xlat0.x / u_xlat4.x;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat4.x = (-u_xlat0.x) * _UWHeightRatio + 1.0;
    u_xlat4.x = u_xlat4.x * vs_TEXCOORD3.y;
    u_xlat4.x = max(u_xlat4.x, _UWCriticalRange);
    u_xlat4.x = min(u_xlat4.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.99000001<vs_TEXCOORD3.y);
#else
    u_xlatb8 = 0.99000001<vs_TEXCOORD3.y;
#endif
    u_xlat16_1.x = (u_xlatb8) ? u_xlat4.x : vs_TEXCOORD3.y;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_2.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_4.xyz * u_xlat10_2.xyz;
    u_xlat4.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat4.xyz = vs_TEXCOORD3.xxx * u_xlat4.xyz + _UWFogColorFar.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + (-u_xlat4.xyz);
    u_xlat3.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat4.xyz = u_xlat16_1.xxx * u_xlat2.xyz + u_xlat4.xyz;
    u_xlat2.x = u_xlat0.x * _UWFogColorHLIntensity;
    u_xlat0.x = (-_UWHeightFogDensity) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat0.x * _UWHeightFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWHeightFogEffectStart);
    u_xlat0.x = min(u_xlat0.x, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat6.xyz + _UWFogColorLow.xyz;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD3.z<_WaterPlaneHeight);
#else
    u_xlatb12 = vs_TEXCOORD3.z<_WaterPlaneHeight;
#endif
    u_xlat16_1.xyz = (bool(u_xlatb12)) ? u_xlat0.xyz : u_xlat3.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
vec2 u_xlat16;
float u_xlat20;
float u_xlat22;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat2.x = u_xlat0.w * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat2.x) + 2.0;
    u_xlat16_3 = u_xlat2.x * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
    u_xlat20 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat20 = sqrt(u_xlat20);
    u_xlat22 = u_xlat20 + (-_HeigtFogRamp.w);
    u_xlat22 = u_xlat22 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat4.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat20>=u_xlat4.x);
#else
    u_xlatb4 = u_xlat20>=u_xlat4.x;
#endif
    u_xlat10 = u_xlat20 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat16.x = (-u_xlat10) + 2.0;
    u_xlat10 = u_xlat16.x * u_xlat10;
    u_xlat16.x = u_xlat10 * _HeigtFogColDelta.w;
    u_xlat4.x = (u_xlatb4) ? u_xlat16.x : u_xlat10;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _Mihoyo_FogColor.w;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, _HeigtFogColBase.w);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat10 = u_xlat5.y * _HeigtFogParams.x;
    u_xlat16.x = dot(u_xlat5.xz, u_xlat5.xz);
    u_xlat16.x = sqrt(u_xlat16.x);
    u_xlat16.x = u_xlat16.x + (-_UWFogDistStart);
    u_xlat16.x = max(u_xlat16.x, 0.0);
    u_xlat16.xy = u_xlat16.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat16.xy = u_xlat16.xy * (-u_xlat16.xy);
    u_xlat16.xy = u_xlat16.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat16.xy);
    u_xlat16.x = u_xlat10 * -1.44269502;
    u_xlat4.z = exp2(u_xlat16.x);
    u_xlat4.xz = (-u_xlat4.xz) + vec2(1.0, 1.0);
    u_xlat16.x = u_xlat4.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_3 = (u_xlatb10) ? u_xlat16.x : 1.0;
    u_xlat10 = u_xlat20 * _HeigtFogParams.y;
    u_xlat20 = u_xlat20 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat16_3 * u_xlat10;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_9 = (-u_xlat20) + 2.0;
    u_xlat16_9 = u_xlat20 * u_xlat16_9;
    u_xlat20 = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat20 = u_xlat20 + 1.0;
    u_xlat16_3 = u_xlat20 * u_xlat16_3;
    u_xlat20 = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat10 = (-u_xlat20) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat10);
    u_xlat3.w = u_xlat10 * u_xlat4.x;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat20) + u_xlat2.xyz;
    vs_COLOR1 = u_xlat3;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD3.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
bool u_xlatb8;
bool u_xlatb12;
void main()
{
    u_xlat0.x = (-vs_TEXCOORD3.z) + _WaterPlaneHeight;
    u_xlat4.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat0.x = u_xlat0.x / u_xlat4.x;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat4.x = (-u_xlat0.x) * _UWHeightRatio + 1.0;
    u_xlat4.x = u_xlat4.x * vs_TEXCOORD3.y;
    u_xlat4.x = max(u_xlat4.x, _UWCriticalRange);
    u_xlat4.x = min(u_xlat4.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.99000001<vs_TEXCOORD3.y);
#else
    u_xlatb8 = 0.99000001<vs_TEXCOORD3.y;
#endif
    u_xlat16_1.x = (u_xlatb8) ? u_xlat4.x : vs_TEXCOORD3.y;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_2.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_4.xyz * u_xlat10_2.xyz;
    u_xlat4.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat4.xyz = vs_TEXCOORD3.xxx * u_xlat4.xyz + _UWFogColorFar.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + (-u_xlat4.xyz);
    u_xlat3.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat4.xyz = u_xlat16_1.xxx * u_xlat2.xyz + u_xlat4.xyz;
    u_xlat2.x = u_xlat0.x * _UWFogColorHLIntensity;
    u_xlat0.x = (-_UWHeightFogDensity) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat0.x * _UWHeightFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWHeightFogEffectStart);
    u_xlat0.x = min(u_xlat0.x, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat6.xyz + _UWFogColorLow.xyz;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD3.z<_WaterPlaneHeight);
#else
    u_xlatb12 = vs_TEXCOORD3.z<_WaterPlaneHeight;
#endif
    u_xlat16_1.xyz = (bool(u_xlatb12)) ? u_xlat0.xyz : u_xlat3.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
mediump float u_xlat16_10;
float u_xlat11;
bool u_xlatb11;
mediump float u_xlat16_13;
vec2 u_xlat18;
bool u_xlatb18;
float u_xlat23;
float u_xlat25;
float u_xlat26;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat2.x = u_xlat0.w * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat2.x) + 2.0;
    u_xlat16_3 = u_xlat2.x * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat5.xyz = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
    u_xlat23 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat23 = sqrt(u_xlat23);
    u_xlat25 = u_xlat23 + (-_HeigtFogRamp3.w);
    u_xlat25 = u_xlat25 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat25) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat4.x = u_xlat23 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat4.x) + 2.0;
    u_xlat4.x = u_xlat11 * u_xlat4.x;
    u_xlat11 = u_xlat4.x * _HeigtFogColDelta3.w;
    u_xlat18.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat23>=u_xlat18.x);
#else
    u_xlatb18 = u_xlat23>=u_xlat18.x;
#endif
    u_xlat4.x = (u_xlatb18) ? u_xlat11 : u_xlat4.x;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _Mihoyo_FogColor3.w;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, _HeigtFogColBase3.w);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat11 = u_xlat5.y * _HeigtFogParams3.x;
    u_xlat25 = u_xlat11 * -1.44269502;
    u_xlat4.w = exp2(u_xlat25);
    u_xlat4.xw = (-u_xlat4.xw) + vec2(1.0, 1.0);
    u_xlat25 = u_xlat4.w / u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat16_3 = (u_xlatb11) ? u_xlat25 : 1.0;
    u_xlat11 = u_xlat23 * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16_3 * u_xlat11;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat11 = u_xlat23 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat11) + 2.0;
    u_xlat16_10 = u_xlat16_10 * u_xlat11;
    u_xlat11 = u_xlat16_10 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat11 = u_xlat11 + 1.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat11;
    u_xlat11 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat25 = (-u_xlat11) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat25);
    u_xlat3.w = u_xlat25 * u_xlat4.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat11) + u_xlat2.xyz;
    u_xlat2.x = u_xlat0.w * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat2.x) + 2.0;
    u_xlat16_6 = u_xlat2.x * u_xlat16_6;
    u_xlat2.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat4.xyw = (-u_xlat2.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat26 = u_xlat23 + (-_HeigtFogRamp2.w);
    u_xlat26 = u_xlat26 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat26) * u_xlat4.xyw + u_xlat2.xyz;
    u_xlat4.x = u_xlat23 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat4.x) + 2.0;
    u_xlat4.x = u_xlat11 * u_xlat4.x;
    u_xlat11 = u_xlat4.x * _HeigtFogColDelta2.w;
    u_xlat4.x = (u_xlatb18) ? u_xlat11 : u_xlat4.x;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _Mihoyo_FogColor2.w;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, _HeigtFogColBase2.w);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat11 = u_xlat5.y * _HeigtFogParams2.x;
    u_xlat18.x = dot(u_xlat5.xz, u_xlat5.xz);
    u_xlat18.x = sqrt(u_xlat18.x);
    u_xlat18.x = u_xlat18.x + (-_UWFogDistStart);
    u_xlat18.x = max(u_xlat18.x, 0.0);
    u_xlat18.xy = u_xlat18.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat18.xy = u_xlat18.xy * (-u_xlat18.xy);
    u_xlat18.xy = u_xlat18.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat18.xy);
    u_xlat18.x = u_xlat11 * -1.44269502;
    u_xlat4.z = exp2(u_xlat18.x);
    u_xlat4.xz = (-u_xlat4.xz) + vec2(1.0, 1.0);
    u_xlat18.x = u_xlat4.z / u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat16_6 = (u_xlatb11) ? u_xlat18.x : 1.0;
    u_xlat11 = u_xlat23 * _HeigtFogParams2.y;
    u_xlat23 = u_xlat23 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat11 * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat23) + 2.0;
    u_xlat16_13 = u_xlat23 * u_xlat16_13;
    u_xlat23 = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat23 = u_xlat23 + 1.0;
    u_xlat16_6 = u_xlat23 * u_xlat16_6;
    u_xlat23 = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat11 = (-u_xlat23) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat11);
    u_xlat4.w = u_xlat11 * u_xlat4.x;
    u_xlat4.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat23) + u_xlat2.xyz;
    u_xlat2 = u_xlat3 + (-u_xlat4);
    u_xlat2 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat2 + u_xlat4;
    vs_COLOR1 = u_xlat2;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD3.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
bool u_xlatb8;
bool u_xlatb12;
void main()
{
    u_xlat0.x = (-vs_TEXCOORD3.z) + _WaterPlaneHeight;
    u_xlat4.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat0.x = u_xlat0.x / u_xlat4.x;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat4.x = (-u_xlat0.x) * _UWHeightRatio + 1.0;
    u_xlat4.x = u_xlat4.x * vs_TEXCOORD3.y;
    u_xlat4.x = max(u_xlat4.x, _UWCriticalRange);
    u_xlat4.x = min(u_xlat4.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.99000001<vs_TEXCOORD3.y);
#else
    u_xlatb8 = 0.99000001<vs_TEXCOORD3.y;
#endif
    u_xlat16_1 = (u_xlatb8) ? u_xlat4.x : vs_TEXCOORD3.y;
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_2.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_4.xyz * u_xlat10_2.xyz;
    u_xlat4.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat4.xyz = vs_TEXCOORD3.xxx * u_xlat4.xyz + _UWFogColorFar.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + (-u_xlat4.xyz);
    u_xlat3.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat4.xyz = vec3(u_xlat16_1) * u_xlat2.xyz + u_xlat4.xyz;
    u_xlat2.x = u_xlat0.x * _UWFogColorHLIntensity;
    u_xlat0.x = (-_UWHeightFogDensity) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat0.x * _UWHeightFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWHeightFogEffectStart);
    u_xlat0.x = min(u_xlat0.x, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat6.xyz + _UWFogColorLow.xyz;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD3.z<_WaterPlaneHeight);
#else
    u_xlatb12 = vs_TEXCOORD3.z<_WaterPlaneHeight;
#endif
    SV_Target0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyz : u_xlat3.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
mediump float u_xlat16_10;
float u_xlat11;
bool u_xlatb11;
mediump float u_xlat16_13;
vec2 u_xlat18;
bool u_xlatb18;
float u_xlat23;
float u_xlat25;
float u_xlat26;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat2.x = u_xlat0.w * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat2.x) + 2.0;
    u_xlat16_3 = u_xlat2.x * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat5.xyz = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
    u_xlat23 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat23 = sqrt(u_xlat23);
    u_xlat25 = u_xlat23 + (-_HeigtFogRamp3.w);
    u_xlat25 = u_xlat25 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat25) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat4.x = u_xlat23 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat4.x) + 2.0;
    u_xlat4.x = u_xlat11 * u_xlat4.x;
    u_xlat11 = u_xlat4.x * _HeigtFogColDelta3.w;
    u_xlat18.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat23>=u_xlat18.x);
#else
    u_xlatb18 = u_xlat23>=u_xlat18.x;
#endif
    u_xlat4.x = (u_xlatb18) ? u_xlat11 : u_xlat4.x;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _Mihoyo_FogColor3.w;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, _HeigtFogColBase3.w);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat11 = u_xlat5.y * _HeigtFogParams3.x;
    u_xlat25 = u_xlat11 * -1.44269502;
    u_xlat4.w = exp2(u_xlat25);
    u_xlat4.xw = (-u_xlat4.xw) + vec2(1.0, 1.0);
    u_xlat25 = u_xlat4.w / u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat16_3 = (u_xlatb11) ? u_xlat25 : 1.0;
    u_xlat11 = u_xlat23 * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16_3 * u_xlat11;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat11 = u_xlat23 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat11) + 2.0;
    u_xlat16_10 = u_xlat16_10 * u_xlat11;
    u_xlat11 = u_xlat16_10 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat11 = u_xlat11 + 1.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat11;
    u_xlat11 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat25 = (-u_xlat11) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat25);
    u_xlat3.w = u_xlat25 * u_xlat4.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat11) + u_xlat2.xyz;
    u_xlat2.x = u_xlat0.w * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat2.x) + 2.0;
    u_xlat16_6 = u_xlat2.x * u_xlat16_6;
    u_xlat2.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat4.xyw = (-u_xlat2.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat26 = u_xlat23 + (-_HeigtFogRamp2.w);
    u_xlat26 = u_xlat26 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat26) * u_xlat4.xyw + u_xlat2.xyz;
    u_xlat4.x = u_xlat23 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat4.x) + 2.0;
    u_xlat4.x = u_xlat11 * u_xlat4.x;
    u_xlat11 = u_xlat4.x * _HeigtFogColDelta2.w;
    u_xlat4.x = (u_xlatb18) ? u_xlat11 : u_xlat4.x;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _Mihoyo_FogColor2.w;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, _HeigtFogColBase2.w);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat11 = u_xlat5.y * _HeigtFogParams2.x;
    u_xlat18.x = dot(u_xlat5.xz, u_xlat5.xz);
    u_xlat18.x = sqrt(u_xlat18.x);
    u_xlat18.x = u_xlat18.x + (-_UWFogDistStart);
    u_xlat18.x = max(u_xlat18.x, 0.0);
    u_xlat18.xy = u_xlat18.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat18.xy = u_xlat18.xy * (-u_xlat18.xy);
    u_xlat18.xy = u_xlat18.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat18.xy);
    u_xlat18.x = u_xlat11 * -1.44269502;
    u_xlat4.z = exp2(u_xlat18.x);
    u_xlat4.xz = (-u_xlat4.xz) + vec2(1.0, 1.0);
    u_xlat18.x = u_xlat4.z / u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat16_6 = (u_xlatb11) ? u_xlat18.x : 1.0;
    u_xlat11 = u_xlat23 * _HeigtFogParams2.y;
    u_xlat23 = u_xlat23 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat11 * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat23) + 2.0;
    u_xlat16_13 = u_xlat23 * u_xlat16_13;
    u_xlat23 = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat23 = u_xlat23 + 1.0;
    u_xlat16_6 = u_xlat23 * u_xlat16_6;
    u_xlat23 = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat11 = (-u_xlat23) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat11);
    u_xlat4.w = u_xlat11 * u_xlat4.x;
    u_xlat4.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat23) + u_xlat2.xyz;
    u_xlat2 = u_xlat3 + (-u_xlat4);
    u_xlat2 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat2 + u_xlat4;
    vs_COLOR1 = u_xlat2;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD3.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
bool u_xlatb8;
bool u_xlatb12;
void main()
{
    u_xlat0.x = (-vs_TEXCOORD3.z) + _WaterPlaneHeight;
    u_xlat4.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat0.x = u_xlat0.x / u_xlat4.x;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat4.x = (-u_xlat0.x) * _UWHeightRatio + 1.0;
    u_xlat4.x = u_xlat4.x * vs_TEXCOORD3.y;
    u_xlat4.x = max(u_xlat4.x, _UWCriticalRange);
    u_xlat4.x = min(u_xlat4.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.99000001<vs_TEXCOORD3.y);
#else
    u_xlatb8 = 0.99000001<vs_TEXCOORD3.y;
#endif
    u_xlat16_1 = (u_xlatb8) ? u_xlat4.x : vs_TEXCOORD3.y;
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_2.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_4.xyz * u_xlat10_2.xyz;
    u_xlat4.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat4.xyz = vs_TEXCOORD3.xxx * u_xlat4.xyz + _UWFogColorFar.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + (-u_xlat4.xyz);
    u_xlat3.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat4.xyz = vec3(u_xlat16_1) * u_xlat2.xyz + u_xlat4.xyz;
    u_xlat2.x = u_xlat0.x * _UWFogColorHLIntensity;
    u_xlat0.x = (-_UWHeightFogDensity) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat0.x * _UWHeightFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWHeightFogEffectStart);
    u_xlat0.x = min(u_xlat0.x, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat6.xyz + _UWFogColorLow.xyz;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD3.z<_WaterPlaneHeight);
#else
    u_xlatb12 = vs_TEXCOORD3.z<_WaterPlaneHeight;
#endif
    SV_Target0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyz : u_xlat3.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
mediump float u_xlat16_10;
float u_xlat11;
bool u_xlatb11;
mediump float u_xlat16_13;
vec2 u_xlat18;
bool u_xlatb18;
float u_xlat23;
float u_xlat25;
float u_xlat26;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat2.x = u_xlat0.w * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat2.x) + 2.0;
    u_xlat16_3 = u_xlat2.x * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat5.xyz = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
    u_xlat23 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat23 = sqrt(u_xlat23);
    u_xlat25 = u_xlat23 + (-_HeigtFogRamp3.w);
    u_xlat25 = u_xlat25 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat25) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat4.x = u_xlat23 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat4.x) + 2.0;
    u_xlat4.x = u_xlat11 * u_xlat4.x;
    u_xlat11 = u_xlat4.x * _HeigtFogColDelta3.w;
    u_xlat18.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat23>=u_xlat18.x);
#else
    u_xlatb18 = u_xlat23>=u_xlat18.x;
#endif
    u_xlat4.x = (u_xlatb18) ? u_xlat11 : u_xlat4.x;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _Mihoyo_FogColor3.w;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, _HeigtFogColBase3.w);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat11 = u_xlat5.y * _HeigtFogParams3.x;
    u_xlat25 = u_xlat11 * -1.44269502;
    u_xlat4.w = exp2(u_xlat25);
    u_xlat4.xw = (-u_xlat4.xw) + vec2(1.0, 1.0);
    u_xlat25 = u_xlat4.w / u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat16_3 = (u_xlatb11) ? u_xlat25 : 1.0;
    u_xlat11 = u_xlat23 * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16_3 * u_xlat11;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat11 = u_xlat23 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat11) + 2.0;
    u_xlat16_10 = u_xlat16_10 * u_xlat11;
    u_xlat11 = u_xlat16_10 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat11 = u_xlat11 + 1.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat11;
    u_xlat11 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat25 = (-u_xlat11) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat25);
    u_xlat3.w = u_xlat25 * u_xlat4.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat11) + u_xlat2.xyz;
    u_xlat2.x = u_xlat0.w * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat2.x) + 2.0;
    u_xlat16_6 = u_xlat2.x * u_xlat16_6;
    u_xlat2.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat4.xyw = (-u_xlat2.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat26 = u_xlat23 + (-_HeigtFogRamp2.w);
    u_xlat26 = u_xlat26 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat26) * u_xlat4.xyw + u_xlat2.xyz;
    u_xlat4.x = u_xlat23 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat4.x) + 2.0;
    u_xlat4.x = u_xlat11 * u_xlat4.x;
    u_xlat11 = u_xlat4.x * _HeigtFogColDelta2.w;
    u_xlat4.x = (u_xlatb18) ? u_xlat11 : u_xlat4.x;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _Mihoyo_FogColor2.w;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, _HeigtFogColBase2.w);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat11 = u_xlat5.y * _HeigtFogParams2.x;
    u_xlat18.x = dot(u_xlat5.xz, u_xlat5.xz);
    u_xlat18.x = sqrt(u_xlat18.x);
    u_xlat18.x = u_xlat18.x + (-_UWFogDistStart);
    u_xlat18.x = max(u_xlat18.x, 0.0);
    u_xlat18.xy = u_xlat18.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat18.xy = u_xlat18.xy * (-u_xlat18.xy);
    u_xlat18.xy = u_xlat18.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat18.xy);
    u_xlat18.x = u_xlat11 * -1.44269502;
    u_xlat4.z = exp2(u_xlat18.x);
    u_xlat4.xz = (-u_xlat4.xz) + vec2(1.0, 1.0);
    u_xlat18.x = u_xlat4.z / u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat16_6 = (u_xlatb11) ? u_xlat18.x : 1.0;
    u_xlat11 = u_xlat23 * _HeigtFogParams2.y;
    u_xlat23 = u_xlat23 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat11 * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat23) + 2.0;
    u_xlat16_13 = u_xlat23 * u_xlat16_13;
    u_xlat23 = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat23 = u_xlat23 + 1.0;
    u_xlat16_6 = u_xlat23 * u_xlat16_6;
    u_xlat23 = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat11 = (-u_xlat23) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat11);
    u_xlat4.w = u_xlat11 * u_xlat4.x;
    u_xlat4.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat23) + u_xlat2.xyz;
    u_xlat2 = u_xlat3 + (-u_xlat4);
    u_xlat2 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat2 + u_xlat4;
    vs_COLOR1 = u_xlat2;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD3.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
bool u_xlatb8;
bool u_xlatb12;
void main()
{
    u_xlat0.x = (-vs_TEXCOORD3.z) + _WaterPlaneHeight;
    u_xlat4.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat0.x = u_xlat0.x / u_xlat4.x;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat4.x = (-u_xlat0.x) * _UWHeightRatio + 1.0;
    u_xlat4.x = u_xlat4.x * vs_TEXCOORD3.y;
    u_xlat4.x = max(u_xlat4.x, _UWCriticalRange);
    u_xlat4.x = min(u_xlat4.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.99000001<vs_TEXCOORD3.y);
#else
    u_xlatb8 = 0.99000001<vs_TEXCOORD3.y;
#endif
    u_xlat16_1 = (u_xlatb8) ? u_xlat4.x : vs_TEXCOORD3.y;
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_2.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_4.xyz * u_xlat10_2.xyz;
    u_xlat4.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat4.xyz = vs_TEXCOORD3.xxx * u_xlat4.xyz + _UWFogColorFar.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + (-u_xlat4.xyz);
    u_xlat3.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat4.xyz = vec3(u_xlat16_1) * u_xlat2.xyz + u_xlat4.xyz;
    u_xlat2.x = u_xlat0.x * _UWFogColorHLIntensity;
    u_xlat0.x = (-_UWHeightFogDensity) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat0.x * _UWHeightFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWHeightFogEffectStart);
    u_xlat0.x = min(u_xlat0.x, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat6.xyz + _UWFogColorLow.xyz;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD3.z<_WaterPlaneHeight);
#else
    u_xlatb12 = vs_TEXCOORD3.z<_WaterPlaneHeight;
#endif
    SV_Target0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyz : u_xlat3.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
mediump float u_xlat16_10;
float u_xlat11;
bool u_xlatb11;
mediump float u_xlat16_13;
vec2 u_xlat18;
bool u_xlatb18;
float u_xlat23;
float u_xlat25;
float u_xlat26;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat2.x = u_xlat0.w * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat2.x) + 2.0;
    u_xlat16_3 = u_xlat2.x * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat5.xyz = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
    u_xlat23 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat23 = sqrt(u_xlat23);
    u_xlat25 = u_xlat23 + (-_HeigtFogRamp3.w);
    u_xlat25 = u_xlat25 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat25) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat4.x = u_xlat23 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat4.x) + 2.0;
    u_xlat4.x = u_xlat11 * u_xlat4.x;
    u_xlat11 = u_xlat4.x * _HeigtFogColDelta3.w;
    u_xlat18.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat23>=u_xlat18.x);
#else
    u_xlatb18 = u_xlat23>=u_xlat18.x;
#endif
    u_xlat4.x = (u_xlatb18) ? u_xlat11 : u_xlat4.x;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _Mihoyo_FogColor3.w;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, _HeigtFogColBase3.w);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat11 = u_xlat5.y * _HeigtFogParams3.x;
    u_xlat25 = u_xlat11 * -1.44269502;
    u_xlat4.w = exp2(u_xlat25);
    u_xlat4.xw = (-u_xlat4.xw) + vec2(1.0, 1.0);
    u_xlat25 = u_xlat4.w / u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat16_3 = (u_xlatb11) ? u_xlat25 : 1.0;
    u_xlat11 = u_xlat23 * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16_3 * u_xlat11;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat11 = u_xlat23 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat11) + 2.0;
    u_xlat16_10 = u_xlat16_10 * u_xlat11;
    u_xlat11 = u_xlat16_10 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat11 = u_xlat11 + 1.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat11;
    u_xlat11 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat25 = (-u_xlat11) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat25);
    u_xlat3.w = u_xlat25 * u_xlat4.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat11) + u_xlat2.xyz;
    u_xlat2.x = u_xlat0.w * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat2.x) + 2.0;
    u_xlat16_6 = u_xlat2.x * u_xlat16_6;
    u_xlat2.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat4.xyw = (-u_xlat2.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat26 = u_xlat23 + (-_HeigtFogRamp2.w);
    u_xlat26 = u_xlat26 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat26) * u_xlat4.xyw + u_xlat2.xyz;
    u_xlat4.x = u_xlat23 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat4.x) + 2.0;
    u_xlat4.x = u_xlat11 * u_xlat4.x;
    u_xlat11 = u_xlat4.x * _HeigtFogColDelta2.w;
    u_xlat4.x = (u_xlatb18) ? u_xlat11 : u_xlat4.x;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _Mihoyo_FogColor2.w;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, _HeigtFogColBase2.w);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat11 = u_xlat5.y * _HeigtFogParams2.x;
    u_xlat18.x = dot(u_xlat5.xz, u_xlat5.xz);
    u_xlat18.x = sqrt(u_xlat18.x);
    u_xlat18.x = u_xlat18.x + (-_UWFogDistStart);
    u_xlat18.x = max(u_xlat18.x, 0.0);
    u_xlat18.xy = u_xlat18.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat18.xy = u_xlat18.xy * (-u_xlat18.xy);
    u_xlat18.xy = u_xlat18.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat18.xy);
    u_xlat18.x = u_xlat11 * -1.44269502;
    u_xlat4.z = exp2(u_xlat18.x);
    u_xlat4.xz = (-u_xlat4.xz) + vec2(1.0, 1.0);
    u_xlat18.x = u_xlat4.z / u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat16_6 = (u_xlatb11) ? u_xlat18.x : 1.0;
    u_xlat11 = u_xlat23 * _HeigtFogParams2.y;
    u_xlat23 = u_xlat23 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat11 * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat23) + 2.0;
    u_xlat16_13 = u_xlat23 * u_xlat16_13;
    u_xlat23 = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat23 = u_xlat23 + 1.0;
    u_xlat16_6 = u_xlat23 * u_xlat16_6;
    u_xlat23 = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat11 = (-u_xlat23) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat11);
    u_xlat4.w = u_xlat11 * u_xlat4.x;
    u_xlat4.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat23) + u_xlat2.xyz;
    u_xlat2 = u_xlat3 + (-u_xlat4);
    u_xlat2 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat2 + u_xlat4;
    vs_COLOR1 = u_xlat2;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD3.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
bool u_xlatb8;
bool u_xlatb12;
void main()
{
    u_xlat0.x = (-vs_TEXCOORD3.z) + _WaterPlaneHeight;
    u_xlat4.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat0.x = u_xlat0.x / u_xlat4.x;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat4.x = (-u_xlat0.x) * _UWHeightRatio + 1.0;
    u_xlat4.x = u_xlat4.x * vs_TEXCOORD3.y;
    u_xlat4.x = max(u_xlat4.x, _UWCriticalRange);
    u_xlat4.x = min(u_xlat4.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.99000001<vs_TEXCOORD3.y);
#else
    u_xlatb8 = 0.99000001<vs_TEXCOORD3.y;
#endif
    u_xlat16_1.x = (u_xlatb8) ? u_xlat4.x : vs_TEXCOORD3.y;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_2.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_4.xyz * u_xlat10_2.xyz;
    u_xlat4.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat4.xyz = vs_TEXCOORD3.xxx * u_xlat4.xyz + _UWFogColorFar.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + (-u_xlat4.xyz);
    u_xlat3.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat4.xyz = u_xlat16_1.xxx * u_xlat2.xyz + u_xlat4.xyz;
    u_xlat2.x = u_xlat0.x * _UWFogColorHLIntensity;
    u_xlat0.x = (-_UWHeightFogDensity) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat0.x * _UWHeightFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWHeightFogEffectStart);
    u_xlat0.x = min(u_xlat0.x, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat6.xyz + _UWFogColorLow.xyz;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD3.z<_WaterPlaneHeight);
#else
    u_xlatb12 = vs_TEXCOORD3.z<_WaterPlaneHeight;
#endif
    u_xlat16_1.xyz = (bool(u_xlatb12)) ? u_xlat0.xyz : u_xlat3.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
mediump float u_xlat16_10;
float u_xlat11;
bool u_xlatb11;
mediump float u_xlat16_13;
vec2 u_xlat18;
bool u_xlatb18;
float u_xlat23;
float u_xlat25;
float u_xlat26;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat2.x = u_xlat0.w * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat2.x) + 2.0;
    u_xlat16_3 = u_xlat2.x * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat5.xyz = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
    u_xlat23 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat23 = sqrt(u_xlat23);
    u_xlat25 = u_xlat23 + (-_HeigtFogRamp3.w);
    u_xlat25 = u_xlat25 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat25) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat4.x = u_xlat23 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat4.x) + 2.0;
    u_xlat4.x = u_xlat11 * u_xlat4.x;
    u_xlat11 = u_xlat4.x * _HeigtFogColDelta3.w;
    u_xlat18.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat23>=u_xlat18.x);
#else
    u_xlatb18 = u_xlat23>=u_xlat18.x;
#endif
    u_xlat4.x = (u_xlatb18) ? u_xlat11 : u_xlat4.x;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _Mihoyo_FogColor3.w;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, _HeigtFogColBase3.w);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat11 = u_xlat5.y * _HeigtFogParams3.x;
    u_xlat25 = u_xlat11 * -1.44269502;
    u_xlat4.w = exp2(u_xlat25);
    u_xlat4.xw = (-u_xlat4.xw) + vec2(1.0, 1.0);
    u_xlat25 = u_xlat4.w / u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat16_3 = (u_xlatb11) ? u_xlat25 : 1.0;
    u_xlat11 = u_xlat23 * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16_3 * u_xlat11;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat11 = u_xlat23 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat11) + 2.0;
    u_xlat16_10 = u_xlat16_10 * u_xlat11;
    u_xlat11 = u_xlat16_10 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat11 = u_xlat11 + 1.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat11;
    u_xlat11 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat25 = (-u_xlat11) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat25);
    u_xlat3.w = u_xlat25 * u_xlat4.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat11) + u_xlat2.xyz;
    u_xlat2.x = u_xlat0.w * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat2.x) + 2.0;
    u_xlat16_6 = u_xlat2.x * u_xlat16_6;
    u_xlat2.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat4.xyw = (-u_xlat2.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat26 = u_xlat23 + (-_HeigtFogRamp2.w);
    u_xlat26 = u_xlat26 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat26) * u_xlat4.xyw + u_xlat2.xyz;
    u_xlat4.x = u_xlat23 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat4.x) + 2.0;
    u_xlat4.x = u_xlat11 * u_xlat4.x;
    u_xlat11 = u_xlat4.x * _HeigtFogColDelta2.w;
    u_xlat4.x = (u_xlatb18) ? u_xlat11 : u_xlat4.x;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _Mihoyo_FogColor2.w;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, _HeigtFogColBase2.w);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat11 = u_xlat5.y * _HeigtFogParams2.x;
    u_xlat18.x = dot(u_xlat5.xz, u_xlat5.xz);
    u_xlat18.x = sqrt(u_xlat18.x);
    u_xlat18.x = u_xlat18.x + (-_UWFogDistStart);
    u_xlat18.x = max(u_xlat18.x, 0.0);
    u_xlat18.xy = u_xlat18.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat18.xy = u_xlat18.xy * (-u_xlat18.xy);
    u_xlat18.xy = u_xlat18.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat18.xy);
    u_xlat18.x = u_xlat11 * -1.44269502;
    u_xlat4.z = exp2(u_xlat18.x);
    u_xlat4.xz = (-u_xlat4.xz) + vec2(1.0, 1.0);
    u_xlat18.x = u_xlat4.z / u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat16_6 = (u_xlatb11) ? u_xlat18.x : 1.0;
    u_xlat11 = u_xlat23 * _HeigtFogParams2.y;
    u_xlat23 = u_xlat23 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat11 * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat23) + 2.0;
    u_xlat16_13 = u_xlat23 * u_xlat16_13;
    u_xlat23 = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat23 = u_xlat23 + 1.0;
    u_xlat16_6 = u_xlat23 * u_xlat16_6;
    u_xlat23 = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat11 = (-u_xlat23) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat11);
    u_xlat4.w = u_xlat11 * u_xlat4.x;
    u_xlat4.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat23) + u_xlat2.xyz;
    u_xlat2 = u_xlat3 + (-u_xlat4);
    u_xlat2 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat2 + u_xlat4;
    vs_COLOR1 = u_xlat2;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD3.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
bool u_xlatb8;
bool u_xlatb12;
void main()
{
    u_xlat0.x = (-vs_TEXCOORD3.z) + _WaterPlaneHeight;
    u_xlat4.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat0.x = u_xlat0.x / u_xlat4.x;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat4.x = (-u_xlat0.x) * _UWHeightRatio + 1.0;
    u_xlat4.x = u_xlat4.x * vs_TEXCOORD3.y;
    u_xlat4.x = max(u_xlat4.x, _UWCriticalRange);
    u_xlat4.x = min(u_xlat4.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.99000001<vs_TEXCOORD3.y);
#else
    u_xlatb8 = 0.99000001<vs_TEXCOORD3.y;
#endif
    u_xlat16_1.x = (u_xlatb8) ? u_xlat4.x : vs_TEXCOORD3.y;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_2.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_4.xyz * u_xlat10_2.xyz;
    u_xlat4.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat4.xyz = vs_TEXCOORD3.xxx * u_xlat4.xyz + _UWFogColorFar.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + (-u_xlat4.xyz);
    u_xlat3.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat4.xyz = u_xlat16_1.xxx * u_xlat2.xyz + u_xlat4.xyz;
    u_xlat2.x = u_xlat0.x * _UWFogColorHLIntensity;
    u_xlat0.x = (-_UWHeightFogDensity) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat0.x * _UWHeightFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWHeightFogEffectStart);
    u_xlat0.x = min(u_xlat0.x, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat6.xyz + _UWFogColorLow.xyz;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD3.z<_WaterPlaneHeight);
#else
    u_xlatb12 = vs_TEXCOORD3.z<_WaterPlaneHeight;
#endif
    u_xlat16_1.xyz = (bool(u_xlatb12)) ? u_xlat0.xyz : u_xlat3.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
mediump float u_xlat16_10;
float u_xlat11;
bool u_xlatb11;
mediump float u_xlat16_13;
vec2 u_xlat18;
bool u_xlatb18;
float u_xlat23;
float u_xlat25;
float u_xlat26;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat2.x = u_xlat0.w * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat2.x) + 2.0;
    u_xlat16_3 = u_xlat2.x * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat5.xyz = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
    u_xlat23 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat23 = sqrt(u_xlat23);
    u_xlat25 = u_xlat23 + (-_HeigtFogRamp3.w);
    u_xlat25 = u_xlat25 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat25) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat4.x = u_xlat23 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat4.x) + 2.0;
    u_xlat4.x = u_xlat11 * u_xlat4.x;
    u_xlat11 = u_xlat4.x * _HeigtFogColDelta3.w;
    u_xlat18.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat23>=u_xlat18.x);
#else
    u_xlatb18 = u_xlat23>=u_xlat18.x;
#endif
    u_xlat4.x = (u_xlatb18) ? u_xlat11 : u_xlat4.x;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _Mihoyo_FogColor3.w;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, _HeigtFogColBase3.w);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat11 = u_xlat5.y * _HeigtFogParams3.x;
    u_xlat25 = u_xlat11 * -1.44269502;
    u_xlat4.w = exp2(u_xlat25);
    u_xlat4.xw = (-u_xlat4.xw) + vec2(1.0, 1.0);
    u_xlat25 = u_xlat4.w / u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat16_3 = (u_xlatb11) ? u_xlat25 : 1.0;
    u_xlat11 = u_xlat23 * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16_3 * u_xlat11;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat11 = u_xlat23 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat11) + 2.0;
    u_xlat16_10 = u_xlat16_10 * u_xlat11;
    u_xlat11 = u_xlat16_10 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat11 = u_xlat11 + 1.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat11;
    u_xlat11 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat25 = (-u_xlat11) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat25);
    u_xlat3.w = u_xlat25 * u_xlat4.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat11) + u_xlat2.xyz;
    u_xlat2.x = u_xlat0.w * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat2.x) + 2.0;
    u_xlat16_6 = u_xlat2.x * u_xlat16_6;
    u_xlat2.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat4.xyw = (-u_xlat2.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat26 = u_xlat23 + (-_HeigtFogRamp2.w);
    u_xlat26 = u_xlat26 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat26) * u_xlat4.xyw + u_xlat2.xyz;
    u_xlat4.x = u_xlat23 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat4.x) + 2.0;
    u_xlat4.x = u_xlat11 * u_xlat4.x;
    u_xlat11 = u_xlat4.x * _HeigtFogColDelta2.w;
    u_xlat4.x = (u_xlatb18) ? u_xlat11 : u_xlat4.x;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _Mihoyo_FogColor2.w;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, _HeigtFogColBase2.w);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat11 = u_xlat5.y * _HeigtFogParams2.x;
    u_xlat18.x = dot(u_xlat5.xz, u_xlat5.xz);
    u_xlat18.x = sqrt(u_xlat18.x);
    u_xlat18.x = u_xlat18.x + (-_UWFogDistStart);
    u_xlat18.x = max(u_xlat18.x, 0.0);
    u_xlat18.xy = u_xlat18.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat18.xy = u_xlat18.xy * (-u_xlat18.xy);
    u_xlat18.xy = u_xlat18.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat18.xy);
    u_xlat18.x = u_xlat11 * -1.44269502;
    u_xlat4.z = exp2(u_xlat18.x);
    u_xlat4.xz = (-u_xlat4.xz) + vec2(1.0, 1.0);
    u_xlat18.x = u_xlat4.z / u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat16_6 = (u_xlatb11) ? u_xlat18.x : 1.0;
    u_xlat11 = u_xlat23 * _HeigtFogParams2.y;
    u_xlat23 = u_xlat23 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat11 * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat23) + 2.0;
    u_xlat16_13 = u_xlat23 * u_xlat16_13;
    u_xlat23 = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat23 = u_xlat23 + 1.0;
    u_xlat16_6 = u_xlat23 * u_xlat16_6;
    u_xlat23 = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat11 = (-u_xlat23) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat11);
    u_xlat4.w = u_xlat11 * u_xlat4.x;
    u_xlat4.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat23) + u_xlat2.xyz;
    u_xlat2 = u_xlat3 + (-u_xlat4);
    u_xlat2 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat2 + u_xlat4;
    vs_COLOR1 = u_xlat2;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD3.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
bool u_xlatb8;
bool u_xlatb12;
void main()
{
    u_xlat0.x = (-vs_TEXCOORD3.z) + _WaterPlaneHeight;
    u_xlat4.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat0.x = u_xlat0.x / u_xlat4.x;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat4.x = (-u_xlat0.x) * _UWHeightRatio + 1.0;
    u_xlat4.x = u_xlat4.x * vs_TEXCOORD3.y;
    u_xlat4.x = max(u_xlat4.x, _UWCriticalRange);
    u_xlat4.x = min(u_xlat4.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.99000001<vs_TEXCOORD3.y);
#else
    u_xlatb8 = 0.99000001<vs_TEXCOORD3.y;
#endif
    u_xlat16_1.x = (u_xlatb8) ? u_xlat4.x : vs_TEXCOORD3.y;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat10_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_2.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_4.xyz * u_xlat10_2.xyz;
    u_xlat4.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat4.xyz = vs_TEXCOORD3.xxx * u_xlat4.xyz + _UWFogColorFar.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + (-u_xlat4.xyz);
    u_xlat3.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat4.xyz = u_xlat16_1.xxx * u_xlat2.xyz + u_xlat4.xyz;
    u_xlat2.x = u_xlat0.x * _UWFogColorHLIntensity;
    u_xlat0.x = (-_UWHeightFogDensity) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat0.x * _UWHeightFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWHeightFogEffectStart);
    u_xlat0.x = min(u_xlat0.x, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat6.xyz + _UWFogColorLow.xyz;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD3.z<_WaterPlaneHeight);
#else
    u_xlatb12 = vs_TEXCOORD3.z<_WaterPlaneHeight;
#endif
    u_xlat16_1.xyz = (bool(u_xlatb12)) ? u_xlat0.xyz : u_xlat3.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat4;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat4.x * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.x = u_xlat1.x * _FogTune;
        u_xlat1.x = u_xlat1.x * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat1.x = max(u_xlat7, u_xlat1.x);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.y * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat7 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat7 = max(u_xlat7, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat7);
        u_xlat4.x = u_xlat1.y * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat7, u_xlat4.x);
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _ReceiveDynamicShadow;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _ShadowIntegration;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_12;
bool u_xlatb12;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb12 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb12){
        u_xlat2.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_12 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_3.x = u_xlat10_12;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-_ShadowIntegration) * u_xlat16_3.x + 1.0;
    u_xlat16_7.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_3.xyz = (-u_xlat16_3.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat4;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat4.x * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.x = u_xlat1.x * _FogTune;
        u_xlat1.x = u_xlat1.x * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat1.x = max(u_xlat7, u_xlat1.x);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.y * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat7 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat7 = max(u_xlat7, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat7);
        u_xlat4.x = u_xlat1.y * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat7, u_xlat4.x);
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _ReceiveDynamicShadow;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _ShadowIntegration;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_12;
bool u_xlatb12;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb12 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb12){
        u_xlat2.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_12 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_3.x = u_xlat10_12;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-_ShadowIntegration) * u_xlat16_3.x + 1.0;
    u_xlat16_7.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_3.xyz = (-u_xlat16_3.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat4;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat4.x * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.x = u_xlat1.x * _FogTune;
        u_xlat1.x = u_xlat1.x * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat1.x = max(u_xlat7, u_xlat1.x);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.y * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat7 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat7 = max(u_xlat7, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat7);
        u_xlat4.x = u_xlat1.y * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat7, u_xlat4.x);
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _ReceiveDynamicShadow;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _ShadowIntegration;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_12;
bool u_xlatb12;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb12 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb12){
        u_xlat2.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_12 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_3.x = u_xlat10_12;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-_ShadowIntegration) * u_xlat16_3.x + 1.0;
    u_xlat16_7.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_3.xyz = (-u_xlat16_3.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat4;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat4.x * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.x = u_xlat1.x * _FogTune;
        u_xlat1.x = u_xlat1.x * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat1.x = max(u_xlat7, u_xlat1.x);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.y * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat7 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat7 = max(u_xlat7, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat7);
        u_xlat4.x = u_xlat1.y * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat7, u_xlat4.x);
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _ReceiveDynamicShadow;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_12;
bool u_xlatb12;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb12 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb12){
        u_xlat2.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_12 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_3.x = u_xlat10_12;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-_ShadowIntegration) * u_xlat16_3.x + 1.0;
    u_xlat16_7.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_3.xyz = (-u_xlat16_3.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    u_xlat16_3.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat4;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat4.x * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.x = u_xlat1.x * _FogTune;
        u_xlat1.x = u_xlat1.x * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat1.x = max(u_xlat7, u_xlat1.x);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.y * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat7 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat7 = max(u_xlat7, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat7);
        u_xlat4.x = u_xlat1.y * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat7, u_xlat4.x);
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _ReceiveDynamicShadow;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_12;
bool u_xlatb12;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb12 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb12){
        u_xlat2.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_12 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_3.x = u_xlat10_12;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-_ShadowIntegration) * u_xlat16_3.x + 1.0;
    u_xlat16_7.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_3.xyz = (-u_xlat16_3.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    u_xlat16_3.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat4;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat4.x * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.x = u_xlat1.x * _FogTune;
        u_xlat1.x = u_xlat1.x * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat1.x = max(u_xlat7, u_xlat1.x);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.y * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat7 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat7 = max(u_xlat7, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat7);
        u_xlat4.x = u_xlat1.y * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat7, u_xlat4.x);
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _ReceiveDynamicShadow;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_12;
bool u_xlatb12;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb12 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb12){
        u_xlat2.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_12 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_3.x = u_xlat10_12;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-_ShadowIntegration) * u_xlat16_3.x + 1.0;
    u_xlat16_7.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_3.xyz = (-u_xlat16_3.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    u_xlat16_3.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat4;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat4.x * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.x = u_xlat1.x * _FogTune;
        u_xlat1.x = u_xlat1.x * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat1.x = max(u_xlat7, u_xlat1.x);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.y * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat7 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat7 = max(u_xlat7, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat7);
        u_xlat4.x = u_xlat1.y * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat7, u_xlat4.x);
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _ReceiveDynamicShadow;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _ShadowIntegration;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_12;
bool u_xlatb12;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb12 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb12){
        u_xlat2.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_12 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_3.x = u_xlat10_12;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-_ShadowIntegration) * u_xlat16_3.x + 1.0;
    u_xlat16_7.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_3.xyz = (-u_xlat16_3.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat4;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat4.x * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.x = u_xlat1.x * _FogTune;
        u_xlat1.x = u_xlat1.x * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat1.x = max(u_xlat7, u_xlat1.x);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.y * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat7 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat7 = max(u_xlat7, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat7);
        u_xlat4.x = u_xlat1.y * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat7, u_xlat4.x);
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _ReceiveDynamicShadow;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _ShadowIntegration;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_12;
bool u_xlatb12;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb12 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb12){
        u_xlat2.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_12 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_3.x = u_xlat10_12;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-_ShadowIntegration) * u_xlat16_3.x + 1.0;
    u_xlat16_7.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_3.xyz = (-u_xlat16_3.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat4;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat4.x * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.x = u_xlat1.x * _FogTune;
        u_xlat1.x = u_xlat1.x * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat1.x = max(u_xlat7, u_xlat1.x);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.y * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat7 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat7 = max(u_xlat7, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat7);
        u_xlat4.x = u_xlat1.y * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat7, u_xlat4.x);
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _ReceiveDynamicShadow;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _ShadowIntegration;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_12;
bool u_xlatb12;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb12 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb12){
        u_xlat2.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_12 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_3.x = u_xlat10_12;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-_ShadowIntegration) * u_xlat16_3.x + 1.0;
    u_xlat16_7.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_3.xyz = (-u_xlat16_3.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat4;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat4.x * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.x = u_xlat1.x * _FogTune;
        u_xlat1.x = u_xlat1.x * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat1.x = max(u_xlat7, u_xlat1.x);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.y * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat7 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat7 = max(u_xlat7, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat7);
        u_xlat4.x = u_xlat1.y * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat7, u_xlat4.x);
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _ReceiveDynamicShadow;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_12;
bool u_xlatb12;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb12 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb12){
        u_xlat2.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_12 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_3.x = u_xlat10_12;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-_ShadowIntegration) * u_xlat16_3.x + 1.0;
    u_xlat16_7.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_3.xyz = (-u_xlat16_3.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    u_xlat16_3.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat4;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat4.x * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.x = u_xlat1.x * _FogTune;
        u_xlat1.x = u_xlat1.x * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat1.x = max(u_xlat7, u_xlat1.x);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.y * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat7 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat7 = max(u_xlat7, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat7);
        u_xlat4.x = u_xlat1.y * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat7, u_xlat4.x);
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _ReceiveDynamicShadow;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_12;
bool u_xlatb12;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb12 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb12){
        u_xlat2.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_12 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_3.x = u_xlat10_12;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-_ShadowIntegration) * u_xlat16_3.x + 1.0;
    u_xlat16_7.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_3.xyz = (-u_xlat16_3.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    u_xlat16_3.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat4;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat4.x * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.x = u_xlat1.x * _FogTune;
        u_xlat1.x = u_xlat1.x * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat1.x = max(u_xlat7, u_xlat1.x);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.y * 1.44269502;
        u_xlat1.x = exp2(u_xlat1.x);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat7 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat7 = max(u_xlat7, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat7);
        u_xlat4.x = u_xlat1.y * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat7, u_xlat4.x);
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _ReceiveDynamicShadow;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_12;
bool u_xlatb12;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb12 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb12){
        u_xlat2.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_12 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_3.x = u_xlat10_12;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-_ShadowIntegration) * u_xlat16_3.x + 1.0;
    u_xlat16_7.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_3.xyz = (-u_xlat16_3.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    u_xlat16_3.xyz = vs_COLOR1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_8;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat17;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat10.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat10.x = u_xlat10.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat10.xxx * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat10.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat0.x>=u_xlat10.x);
#else
    u_xlatb10 = u_xlat0.x>=u_xlat10.x;
#endif
    u_xlat15 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat17 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat17;
    u_xlat17 = u_xlat15 * _HeigtFogColDelta.w;
    u_xlat10.x = (u_xlatb10) ? u_xlat17 : u_xlat15;
    u_xlat10.x = log2(u_xlat10.x);
    u_xlat10.x = u_xlat10.x * _Mihoyo_FogColor.w;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = min(u_xlat10.x, _HeigtFogColBase.w);
    u_xlat2.xyz = u_xlat10.xxx * u_xlat2.xyz;
    u_xlat15 = u_xlat5 * -1.44269502;
    u_xlat10.y = exp2(u_xlat15);
    u_xlat10.xy = (-u_xlat10.xy) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat10.y / u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.00999999978<abs(u_xlat5));
#else
    u_xlatb5 = 0.00999999978<abs(u_xlat5);
#endif
    u_xlat16_3 = (u_xlatb5) ? u_xlat15 : 1.0;
    u_xlat5 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat5 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_8 = (-u_xlat0.x) + 2.0;
    u_xlat16_8 = u_xlat0.x * u_xlat16_8;
    u_xlat0.x = u_xlat16_8 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat5 = (-u_xlat0.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz;
    u_xlat3.w = u_xlat5 * u_xlat10.x;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_COLOR1 = u_xlat3;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _ReceiveDynamicShadow;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _ShadowIntegration;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_12;
bool u_xlatb12;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb12 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb12){
        u_xlat2.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_12 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_3.x = u_xlat10_12;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-_ShadowIntegration) * u_xlat16_3.x + 1.0;
    u_xlat16_7.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_3.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_8;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat17;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat10.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat10.x = u_xlat10.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat10.xxx * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat10.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat0.x>=u_xlat10.x);
#else
    u_xlatb10 = u_xlat0.x>=u_xlat10.x;
#endif
    u_xlat15 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat17 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat17;
    u_xlat17 = u_xlat15 * _HeigtFogColDelta.w;
    u_xlat10.x = (u_xlatb10) ? u_xlat17 : u_xlat15;
    u_xlat10.x = log2(u_xlat10.x);
    u_xlat10.x = u_xlat10.x * _Mihoyo_FogColor.w;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = min(u_xlat10.x, _HeigtFogColBase.w);
    u_xlat2.xyz = u_xlat10.xxx * u_xlat2.xyz;
    u_xlat15 = u_xlat5 * -1.44269502;
    u_xlat10.y = exp2(u_xlat15);
    u_xlat10.xy = (-u_xlat10.xy) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat10.y / u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.00999999978<abs(u_xlat5));
#else
    u_xlatb5 = 0.00999999978<abs(u_xlat5);
#endif
    u_xlat16_3 = (u_xlatb5) ? u_xlat15 : 1.0;
    u_xlat5 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat5 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_8 = (-u_xlat0.x) + 2.0;
    u_xlat16_8 = u_xlat0.x * u_xlat16_8;
    u_xlat0.x = u_xlat16_8 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat5 = (-u_xlat0.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz;
    u_xlat3.w = u_xlat5 * u_xlat10.x;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_COLOR1 = u_xlat3;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _ReceiveDynamicShadow;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _ShadowIntegration;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_12;
bool u_xlatb12;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb12 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb12){
        u_xlat2.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_12 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_3.x = u_xlat10_12;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-_ShadowIntegration) * u_xlat16_3.x + 1.0;
    u_xlat16_7.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_3.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_8;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat17;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat10.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat10.x = u_xlat10.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat10.xxx * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat10.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat0.x>=u_xlat10.x);
#else
    u_xlatb10 = u_xlat0.x>=u_xlat10.x;
#endif
    u_xlat15 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat17 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat17;
    u_xlat17 = u_xlat15 * _HeigtFogColDelta.w;
    u_xlat10.x = (u_xlatb10) ? u_xlat17 : u_xlat15;
    u_xlat10.x = log2(u_xlat10.x);
    u_xlat10.x = u_xlat10.x * _Mihoyo_FogColor.w;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = min(u_xlat10.x, _HeigtFogColBase.w);
    u_xlat2.xyz = u_xlat10.xxx * u_xlat2.xyz;
    u_xlat15 = u_xlat5 * -1.44269502;
    u_xlat10.y = exp2(u_xlat15);
    u_xlat10.xy = (-u_xlat10.xy) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat10.y / u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.00999999978<abs(u_xlat5));
#else
    u_xlatb5 = 0.00999999978<abs(u_xlat5);
#endif
    u_xlat16_3 = (u_xlatb5) ? u_xlat15 : 1.0;
    u_xlat5 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat5 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_8 = (-u_xlat0.x) + 2.0;
    u_xlat16_8 = u_xlat0.x * u_xlat16_8;
    u_xlat0.x = u_xlat16_8 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat5 = (-u_xlat0.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz;
    u_xlat3.w = u_xlat5 * u_xlat10.x;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_COLOR1 = u_xlat3;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _ReceiveDynamicShadow;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _ShadowIntegration;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_12;
bool u_xlatb12;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb12 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb12){
        u_xlat2.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_12 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_3.x = u_xlat10_12;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-_ShadowIntegration) * u_xlat16_3.x + 1.0;
    u_xlat16_7.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_3.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_8;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat17;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat10.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat10.x = u_xlat10.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat10.xxx * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat10.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat0.x>=u_xlat10.x);
#else
    u_xlatb10 = u_xlat0.x>=u_xlat10.x;
#endif
    u_xlat15 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat17 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat17;
    u_xlat17 = u_xlat15 * _HeigtFogColDelta.w;
    u_xlat10.x = (u_xlatb10) ? u_xlat17 : u_xlat15;
    u_xlat10.x = log2(u_xlat10.x);
    u_xlat10.x = u_xlat10.x * _Mihoyo_FogColor.w;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = min(u_xlat10.x, _HeigtFogColBase.w);
    u_xlat2.xyz = u_xlat10.xxx * u_xlat2.xyz;
    u_xlat15 = u_xlat5 * -1.44269502;
    u_xlat10.y = exp2(u_xlat15);
    u_xlat10.xy = (-u_xlat10.xy) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat10.y / u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.00999999978<abs(u_xlat5));
#else
    u_xlatb5 = 0.00999999978<abs(u_xlat5);
#endif
    u_xlat16_3 = (u_xlatb5) ? u_xlat15 : 1.0;
    u_xlat5 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat5 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_8 = (-u_xlat0.x) + 2.0;
    u_xlat16_8 = u_xlat0.x * u_xlat16_8;
    u_xlat0.x = u_xlat16_8 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat5 = (-u_xlat0.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz;
    u_xlat3.w = u_xlat5 * u_xlat10.x;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_COLOR1 = u_xlat3;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _ReceiveDynamicShadow;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_12;
bool u_xlatb12;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb12 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb12){
        u_xlat2.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_12 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_3.x = u_xlat10_12;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-_ShadowIntegration) * u_xlat16_3.x + 1.0;
    u_xlat16_7.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xxx + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_8;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat17;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat10.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat10.x = u_xlat10.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat10.xxx * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat10.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat0.x>=u_xlat10.x);
#else
    u_xlatb10 = u_xlat0.x>=u_xlat10.x;
#endif
    u_xlat15 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat17 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat17;
    u_xlat17 = u_xlat15 * _HeigtFogColDelta.w;
    u_xlat10.x = (u_xlatb10) ? u_xlat17 : u_xlat15;
    u_xlat10.x = log2(u_xlat10.x);
    u_xlat10.x = u_xlat10.x * _Mihoyo_FogColor.w;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = min(u_xlat10.x, _HeigtFogColBase.w);
    u_xlat2.xyz = u_xlat10.xxx * u_xlat2.xyz;
    u_xlat15 = u_xlat5 * -1.44269502;
    u_xlat10.y = exp2(u_xlat15);
    u_xlat10.xy = (-u_xlat10.xy) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat10.y / u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.00999999978<abs(u_xlat5));
#else
    u_xlatb5 = 0.00999999978<abs(u_xlat5);
#endif
    u_xlat16_3 = (u_xlatb5) ? u_xlat15 : 1.0;
    u_xlat5 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat5 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_8 = (-u_xlat0.x) + 2.0;
    u_xlat16_8 = u_xlat0.x * u_xlat16_8;
    u_xlat0.x = u_xlat16_8 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat5 = (-u_xlat0.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz;
    u_xlat3.w = u_xlat5 * u_xlat10.x;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_COLOR1 = u_xlat3;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _ReceiveDynamicShadow;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_12;
bool u_xlatb12;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb12 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb12){
        u_xlat2.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_12 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_3.x = u_xlat10_12;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-_ShadowIntegration) * u_xlat16_3.x + 1.0;
    u_xlat16_7.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xxx + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_8;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat17;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat10.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat10.x = u_xlat10.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat10.xxx * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat10.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat0.x>=u_xlat10.x);
#else
    u_xlatb10 = u_xlat0.x>=u_xlat10.x;
#endif
    u_xlat15 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat17 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat17;
    u_xlat17 = u_xlat15 * _HeigtFogColDelta.w;
    u_xlat10.x = (u_xlatb10) ? u_xlat17 : u_xlat15;
    u_xlat10.x = log2(u_xlat10.x);
    u_xlat10.x = u_xlat10.x * _Mihoyo_FogColor.w;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = min(u_xlat10.x, _HeigtFogColBase.w);
    u_xlat2.xyz = u_xlat10.xxx * u_xlat2.xyz;
    u_xlat15 = u_xlat5 * -1.44269502;
    u_xlat10.y = exp2(u_xlat15);
    u_xlat10.xy = (-u_xlat10.xy) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat10.y / u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.00999999978<abs(u_xlat5));
#else
    u_xlatb5 = 0.00999999978<abs(u_xlat5);
#endif
    u_xlat16_3 = (u_xlatb5) ? u_xlat15 : 1.0;
    u_xlat5 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat5 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_8 = (-u_xlat0.x) + 2.0;
    u_xlat16_8 = u_xlat0.x * u_xlat16_8;
    u_xlat0.x = u_xlat16_8 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat5 = (-u_xlat0.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz;
    u_xlat3.w = u_xlat5 * u_xlat10.x;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat2.xyz;
    vs_COLOR1 = u_xlat3;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _ReceiveDynamicShadow;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_12;
bool u_xlatb12;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb12 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb12){
        u_xlat2.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_12 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_3.x = u_xlat10_12;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-_ShadowIntegration) * u_xlat16_3.x + 1.0;
    u_xlat16_7.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xxx + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
bool u_xlatb4;
mediump float u_xlat16_5;
vec3 u_xlat6;
mediump float u_xlat16_9;
vec3 u_xlat10;
mediump float u_xlat16_11;
float u_xlat12;
bool u_xlatb12;
float u_xlat18;
float u_xlat20;
bool u_xlatb20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat18) + 2.0;
    u_xlat16_3 = u_xlat18 * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat6.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat18 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat18 = u_xlat18 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat18 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat20 = (-u_xlat18) + 2.0;
    u_xlat18 = u_xlat18 * u_xlat20;
    u_xlat20 = u_xlat18 * _HeigtFogColDelta3.w;
    u_xlat4.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=u_xlat4.x);
#else
    u_xlatb4 = u_xlat0.x>=u_xlat4.x;
#endif
    u_xlat18 = (u_xlatb4) ? u_xlat20 : u_xlat18;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _Mihoyo_FogColor3.w;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = min(u_xlat18, _HeigtFogColBase3.w);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat20 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat12 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat10.x = u_xlat20 * -1.44269502;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = (-u_xlat10.x) + 1.0;
    u_xlat10.x = u_xlat10.x / u_xlat20;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(0.00999999978<abs(u_xlat20));
#else
    u_xlatb20 = 0.00999999978<abs(u_xlat20);
#endif
    u_xlat16_3 = (u_xlatb20) ? u_xlat10.x : 1.0;
    u_xlat20 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat20 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat20 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat16_9 = (-u_xlat20) + 2.0;
    u_xlat16_9 = u_xlat20 * u_xlat16_9;
    u_xlat20 = u_xlat16_9 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat20 = u_xlat20 + 1.0;
    u_xlat16_3 = u_xlat20 * u_xlat16_3;
    u_xlat20 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat10.x = (-u_xlat20) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat10.xxx;
    u_xlat3.w = u_xlat18 * u_xlat10.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat20) + u_xlat2.xyz;
    u_xlat16_5 = (-u_xlat6.x) + 2.0;
    u_xlat16_5 = u_xlat6.x * u_xlat16_5;
    u_xlat2.xyz = vec3(u_xlat16_5) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat10.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat6.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat6.x = u_xlat6.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat6.xxx * u_xlat10.xyz + u_xlat2.xyz;
    u_xlat6.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat18 = (-u_xlat6.x) + 2.0;
    u_xlat6.x = u_xlat18 * u_xlat6.x;
    u_xlat18 = u_xlat6.x * _HeigtFogColDelta2.w;
    u_xlat6.x = (u_xlatb4) ? u_xlat18 : u_xlat6.x;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _Mihoyo_FogColor2.w;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat6.x = min(u_xlat6.x, _HeigtFogColBase2.w);
    u_xlat2.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat18 = u_xlat12 * -1.44269502;
    u_xlat6.z = exp2(u_xlat18);
    u_xlat6.xz = (-u_xlat6.xz) + vec2(1.0, 1.0);
    u_xlat18 = u_xlat6.z / u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.00999999978<abs(u_xlat12));
#else
    u_xlatb12 = 0.00999999978<abs(u_xlat12);
#endif
    u_xlat16_5 = (u_xlatb12) ? u_xlat18 : 1.0;
    u_xlat12 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat12 * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_11 = (-u_xlat0.x) + 2.0;
    u_xlat16_11 = u_xlat0.x * u_xlat16_11;
    u_xlat0.x = u_xlat16_11 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_5 = u_xlat0.x * u_xlat16_5;
    u_xlat0.x = min(u_xlat16_5, _HeigtFogColBase2.w);
    u_xlat12 = (-u_xlat0.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat4.w = u_xlat12 * u_xlat6.x;
    u_xlat4.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0 = u_xlat3 + (-u_xlat4);
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat4;
    vs_COLOR1 = u_xlat0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _ReceiveDynamicShadow;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _ShadowIntegration;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_12;
bool u_xlatb12;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb12 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb12){
        u_xlat2.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_12 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_3.x = u_xlat10_12;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-_ShadowIntegration) * u_xlat16_3.x + 1.0;
    u_xlat16_7.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_3.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
bool u_xlatb4;
mediump float u_xlat16_5;
vec3 u_xlat6;
mediump float u_xlat16_9;
vec3 u_xlat10;
mediump float u_xlat16_11;
float u_xlat12;
bool u_xlatb12;
float u_xlat18;
float u_xlat20;
bool u_xlatb20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat18) + 2.0;
    u_xlat16_3 = u_xlat18 * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat6.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat18 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat18 = u_xlat18 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat18 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat20 = (-u_xlat18) + 2.0;
    u_xlat18 = u_xlat18 * u_xlat20;
    u_xlat20 = u_xlat18 * _HeigtFogColDelta3.w;
    u_xlat4.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=u_xlat4.x);
#else
    u_xlatb4 = u_xlat0.x>=u_xlat4.x;
#endif
    u_xlat18 = (u_xlatb4) ? u_xlat20 : u_xlat18;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _Mihoyo_FogColor3.w;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = min(u_xlat18, _HeigtFogColBase3.w);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat20 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat12 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat10.x = u_xlat20 * -1.44269502;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = (-u_xlat10.x) + 1.0;
    u_xlat10.x = u_xlat10.x / u_xlat20;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(0.00999999978<abs(u_xlat20));
#else
    u_xlatb20 = 0.00999999978<abs(u_xlat20);
#endif
    u_xlat16_3 = (u_xlatb20) ? u_xlat10.x : 1.0;
    u_xlat20 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat20 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat20 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat16_9 = (-u_xlat20) + 2.0;
    u_xlat16_9 = u_xlat20 * u_xlat16_9;
    u_xlat20 = u_xlat16_9 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat20 = u_xlat20 + 1.0;
    u_xlat16_3 = u_xlat20 * u_xlat16_3;
    u_xlat20 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat10.x = (-u_xlat20) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat10.xxx;
    u_xlat3.w = u_xlat18 * u_xlat10.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat20) + u_xlat2.xyz;
    u_xlat16_5 = (-u_xlat6.x) + 2.0;
    u_xlat16_5 = u_xlat6.x * u_xlat16_5;
    u_xlat2.xyz = vec3(u_xlat16_5) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat10.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat6.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat6.x = u_xlat6.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat6.xxx * u_xlat10.xyz + u_xlat2.xyz;
    u_xlat6.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat18 = (-u_xlat6.x) + 2.0;
    u_xlat6.x = u_xlat18 * u_xlat6.x;
    u_xlat18 = u_xlat6.x * _HeigtFogColDelta2.w;
    u_xlat6.x = (u_xlatb4) ? u_xlat18 : u_xlat6.x;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _Mihoyo_FogColor2.w;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat6.x = min(u_xlat6.x, _HeigtFogColBase2.w);
    u_xlat2.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat18 = u_xlat12 * -1.44269502;
    u_xlat6.z = exp2(u_xlat18);
    u_xlat6.xz = (-u_xlat6.xz) + vec2(1.0, 1.0);
    u_xlat18 = u_xlat6.z / u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.00999999978<abs(u_xlat12));
#else
    u_xlatb12 = 0.00999999978<abs(u_xlat12);
#endif
    u_xlat16_5 = (u_xlatb12) ? u_xlat18 : 1.0;
    u_xlat12 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat12 * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_11 = (-u_xlat0.x) + 2.0;
    u_xlat16_11 = u_xlat0.x * u_xlat16_11;
    u_xlat0.x = u_xlat16_11 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_5 = u_xlat0.x * u_xlat16_5;
    u_xlat0.x = min(u_xlat16_5, _HeigtFogColBase2.w);
    u_xlat12 = (-u_xlat0.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat4.w = u_xlat12 * u_xlat6.x;
    u_xlat4.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0 = u_xlat3 + (-u_xlat4);
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat4;
    vs_COLOR1 = u_xlat0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _ReceiveDynamicShadow;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _ShadowIntegration;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_12;
bool u_xlatb12;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb12 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb12){
        u_xlat2.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_12 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_3.x = u_xlat10_12;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-_ShadowIntegration) * u_xlat16_3.x + 1.0;
    u_xlat16_7.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_3.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
bool u_xlatb4;
mediump float u_xlat16_5;
vec3 u_xlat6;
mediump float u_xlat16_9;
vec3 u_xlat10;
mediump float u_xlat16_11;
float u_xlat12;
bool u_xlatb12;
float u_xlat18;
float u_xlat20;
bool u_xlatb20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat18) + 2.0;
    u_xlat16_3 = u_xlat18 * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat6.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat18 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat18 = u_xlat18 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat18 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat20 = (-u_xlat18) + 2.0;
    u_xlat18 = u_xlat18 * u_xlat20;
    u_xlat20 = u_xlat18 * _HeigtFogColDelta3.w;
    u_xlat4.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=u_xlat4.x);
#else
    u_xlatb4 = u_xlat0.x>=u_xlat4.x;
#endif
    u_xlat18 = (u_xlatb4) ? u_xlat20 : u_xlat18;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _Mihoyo_FogColor3.w;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = min(u_xlat18, _HeigtFogColBase3.w);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat20 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat12 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat10.x = u_xlat20 * -1.44269502;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = (-u_xlat10.x) + 1.0;
    u_xlat10.x = u_xlat10.x / u_xlat20;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(0.00999999978<abs(u_xlat20));
#else
    u_xlatb20 = 0.00999999978<abs(u_xlat20);
#endif
    u_xlat16_3 = (u_xlatb20) ? u_xlat10.x : 1.0;
    u_xlat20 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat20 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat20 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat16_9 = (-u_xlat20) + 2.0;
    u_xlat16_9 = u_xlat20 * u_xlat16_9;
    u_xlat20 = u_xlat16_9 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat20 = u_xlat20 + 1.0;
    u_xlat16_3 = u_xlat20 * u_xlat16_3;
    u_xlat20 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat10.x = (-u_xlat20) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat10.xxx;
    u_xlat3.w = u_xlat18 * u_xlat10.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat20) + u_xlat2.xyz;
    u_xlat16_5 = (-u_xlat6.x) + 2.0;
    u_xlat16_5 = u_xlat6.x * u_xlat16_5;
    u_xlat2.xyz = vec3(u_xlat16_5) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat10.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat6.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat6.x = u_xlat6.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat6.xxx * u_xlat10.xyz + u_xlat2.xyz;
    u_xlat6.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat18 = (-u_xlat6.x) + 2.0;
    u_xlat6.x = u_xlat18 * u_xlat6.x;
    u_xlat18 = u_xlat6.x * _HeigtFogColDelta2.w;
    u_xlat6.x = (u_xlatb4) ? u_xlat18 : u_xlat6.x;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _Mihoyo_FogColor2.w;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat6.x = min(u_xlat6.x, _HeigtFogColBase2.w);
    u_xlat2.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat18 = u_xlat12 * -1.44269502;
    u_xlat6.z = exp2(u_xlat18);
    u_xlat6.xz = (-u_xlat6.xz) + vec2(1.0, 1.0);
    u_xlat18 = u_xlat6.z / u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.00999999978<abs(u_xlat12));
#else
    u_xlatb12 = 0.00999999978<abs(u_xlat12);
#endif
    u_xlat16_5 = (u_xlatb12) ? u_xlat18 : 1.0;
    u_xlat12 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat12 * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_11 = (-u_xlat0.x) + 2.0;
    u_xlat16_11 = u_xlat0.x * u_xlat16_11;
    u_xlat0.x = u_xlat16_11 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_5 = u_xlat0.x * u_xlat16_5;
    u_xlat0.x = min(u_xlat16_5, _HeigtFogColBase2.w);
    u_xlat12 = (-u_xlat0.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat4.w = u_xlat12 * u_xlat6.x;
    u_xlat4.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0 = u_xlat3 + (-u_xlat4);
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat4;
    vs_COLOR1 = u_xlat0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _ReceiveDynamicShadow;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _ShadowIntegration;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_12;
bool u_xlatb12;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb12 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb12){
        u_xlat2.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_12 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_3.x = u_xlat10_12;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-_ShadowIntegration) * u_xlat16_3.x + 1.0;
    u_xlat16_7.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_3.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
bool u_xlatb4;
mediump float u_xlat16_5;
vec3 u_xlat6;
mediump float u_xlat16_9;
vec3 u_xlat10;
mediump float u_xlat16_11;
float u_xlat12;
bool u_xlatb12;
float u_xlat18;
float u_xlat20;
bool u_xlatb20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat18) + 2.0;
    u_xlat16_3 = u_xlat18 * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat6.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat18 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat18 = u_xlat18 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat18 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat20 = (-u_xlat18) + 2.0;
    u_xlat18 = u_xlat18 * u_xlat20;
    u_xlat20 = u_xlat18 * _HeigtFogColDelta3.w;
    u_xlat4.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=u_xlat4.x);
#else
    u_xlatb4 = u_xlat0.x>=u_xlat4.x;
#endif
    u_xlat18 = (u_xlatb4) ? u_xlat20 : u_xlat18;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _Mihoyo_FogColor3.w;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = min(u_xlat18, _HeigtFogColBase3.w);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat20 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat12 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat10.x = u_xlat20 * -1.44269502;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = (-u_xlat10.x) + 1.0;
    u_xlat10.x = u_xlat10.x / u_xlat20;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(0.00999999978<abs(u_xlat20));
#else
    u_xlatb20 = 0.00999999978<abs(u_xlat20);
#endif
    u_xlat16_3 = (u_xlatb20) ? u_xlat10.x : 1.0;
    u_xlat20 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat20 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat20 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat16_9 = (-u_xlat20) + 2.0;
    u_xlat16_9 = u_xlat20 * u_xlat16_9;
    u_xlat20 = u_xlat16_9 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat20 = u_xlat20 + 1.0;
    u_xlat16_3 = u_xlat20 * u_xlat16_3;
    u_xlat20 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat10.x = (-u_xlat20) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat10.xxx;
    u_xlat3.w = u_xlat18 * u_xlat10.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat20) + u_xlat2.xyz;
    u_xlat16_5 = (-u_xlat6.x) + 2.0;
    u_xlat16_5 = u_xlat6.x * u_xlat16_5;
    u_xlat2.xyz = vec3(u_xlat16_5) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat10.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat6.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat6.x = u_xlat6.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat6.xxx * u_xlat10.xyz + u_xlat2.xyz;
    u_xlat6.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat18 = (-u_xlat6.x) + 2.0;
    u_xlat6.x = u_xlat18 * u_xlat6.x;
    u_xlat18 = u_xlat6.x * _HeigtFogColDelta2.w;
    u_xlat6.x = (u_xlatb4) ? u_xlat18 : u_xlat6.x;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _Mihoyo_FogColor2.w;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat6.x = min(u_xlat6.x, _HeigtFogColBase2.w);
    u_xlat2.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat18 = u_xlat12 * -1.44269502;
    u_xlat6.z = exp2(u_xlat18);
    u_xlat6.xz = (-u_xlat6.xz) + vec2(1.0, 1.0);
    u_xlat18 = u_xlat6.z / u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.00999999978<abs(u_xlat12));
#else
    u_xlatb12 = 0.00999999978<abs(u_xlat12);
#endif
    u_xlat16_5 = (u_xlatb12) ? u_xlat18 : 1.0;
    u_xlat12 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat12 * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_11 = (-u_xlat0.x) + 2.0;
    u_xlat16_11 = u_xlat0.x * u_xlat16_11;
    u_xlat0.x = u_xlat16_11 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_5 = u_xlat0.x * u_xlat16_5;
    u_xlat0.x = min(u_xlat16_5, _HeigtFogColBase2.w);
    u_xlat12 = (-u_xlat0.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat4.w = u_xlat12 * u_xlat6.x;
    u_xlat4.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0 = u_xlat3 + (-u_xlat4);
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat4;
    vs_COLOR1 = u_xlat0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _ReceiveDynamicShadow;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_12;
bool u_xlatb12;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb12 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb12){
        u_xlat2.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_12 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_3.x = u_xlat10_12;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-_ShadowIntegration) * u_xlat16_3.x + 1.0;
    u_xlat16_7.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xxx + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
bool u_xlatb4;
mediump float u_xlat16_5;
vec3 u_xlat6;
mediump float u_xlat16_9;
vec3 u_xlat10;
mediump float u_xlat16_11;
float u_xlat12;
bool u_xlatb12;
float u_xlat18;
float u_xlat20;
bool u_xlatb20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat18) + 2.0;
    u_xlat16_3 = u_xlat18 * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat6.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat18 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat18 = u_xlat18 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat18 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat20 = (-u_xlat18) + 2.0;
    u_xlat18 = u_xlat18 * u_xlat20;
    u_xlat20 = u_xlat18 * _HeigtFogColDelta3.w;
    u_xlat4.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=u_xlat4.x);
#else
    u_xlatb4 = u_xlat0.x>=u_xlat4.x;
#endif
    u_xlat18 = (u_xlatb4) ? u_xlat20 : u_xlat18;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _Mihoyo_FogColor3.w;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = min(u_xlat18, _HeigtFogColBase3.w);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat20 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat12 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat10.x = u_xlat20 * -1.44269502;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = (-u_xlat10.x) + 1.0;
    u_xlat10.x = u_xlat10.x / u_xlat20;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(0.00999999978<abs(u_xlat20));
#else
    u_xlatb20 = 0.00999999978<abs(u_xlat20);
#endif
    u_xlat16_3 = (u_xlatb20) ? u_xlat10.x : 1.0;
    u_xlat20 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat20 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat20 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat16_9 = (-u_xlat20) + 2.0;
    u_xlat16_9 = u_xlat20 * u_xlat16_9;
    u_xlat20 = u_xlat16_9 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat20 = u_xlat20 + 1.0;
    u_xlat16_3 = u_xlat20 * u_xlat16_3;
    u_xlat20 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat10.x = (-u_xlat20) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat10.xxx;
    u_xlat3.w = u_xlat18 * u_xlat10.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat20) + u_xlat2.xyz;
    u_xlat16_5 = (-u_xlat6.x) + 2.0;
    u_xlat16_5 = u_xlat6.x * u_xlat16_5;
    u_xlat2.xyz = vec3(u_xlat16_5) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat10.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat6.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat6.x = u_xlat6.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat6.xxx * u_xlat10.xyz + u_xlat2.xyz;
    u_xlat6.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat18 = (-u_xlat6.x) + 2.0;
    u_xlat6.x = u_xlat18 * u_xlat6.x;
    u_xlat18 = u_xlat6.x * _HeigtFogColDelta2.w;
    u_xlat6.x = (u_xlatb4) ? u_xlat18 : u_xlat6.x;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _Mihoyo_FogColor2.w;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat6.x = min(u_xlat6.x, _HeigtFogColBase2.w);
    u_xlat2.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat18 = u_xlat12 * -1.44269502;
    u_xlat6.z = exp2(u_xlat18);
    u_xlat6.xz = (-u_xlat6.xz) + vec2(1.0, 1.0);
    u_xlat18 = u_xlat6.z / u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.00999999978<abs(u_xlat12));
#else
    u_xlatb12 = 0.00999999978<abs(u_xlat12);
#endif
    u_xlat16_5 = (u_xlatb12) ? u_xlat18 : 1.0;
    u_xlat12 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat12 * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_11 = (-u_xlat0.x) + 2.0;
    u_xlat16_11 = u_xlat0.x * u_xlat16_11;
    u_xlat0.x = u_xlat16_11 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_5 = u_xlat0.x * u_xlat16_5;
    u_xlat0.x = min(u_xlat16_5, _HeigtFogColBase2.w);
    u_xlat12 = (-u_xlat0.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat4.w = u_xlat12 * u_xlat6.x;
    u_xlat4.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0 = u_xlat3 + (-u_xlat4);
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat4;
    vs_COLOR1 = u_xlat0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _ReceiveDynamicShadow;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_12;
bool u_xlatb12;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb12 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb12){
        u_xlat2.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_12 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_3.x = u_xlat10_12;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-_ShadowIntegration) * u_xlat16_3.x + 1.0;
    u_xlat16_7.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xxx + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
bool u_xlatb4;
mediump float u_xlat16_5;
vec3 u_xlat6;
mediump float u_xlat16_9;
vec3 u_xlat10;
mediump float u_xlat16_11;
float u_xlat12;
bool u_xlatb12;
float u_xlat18;
float u_xlat20;
bool u_xlatb20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat18) + 2.0;
    u_xlat16_3 = u_xlat18 * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat6.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat18 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat18 = u_xlat18 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat18 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat20 = (-u_xlat18) + 2.0;
    u_xlat18 = u_xlat18 * u_xlat20;
    u_xlat20 = u_xlat18 * _HeigtFogColDelta3.w;
    u_xlat4.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=u_xlat4.x);
#else
    u_xlatb4 = u_xlat0.x>=u_xlat4.x;
#endif
    u_xlat18 = (u_xlatb4) ? u_xlat20 : u_xlat18;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _Mihoyo_FogColor3.w;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = min(u_xlat18, _HeigtFogColBase3.w);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat20 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat12 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat10.x = u_xlat20 * -1.44269502;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = (-u_xlat10.x) + 1.0;
    u_xlat10.x = u_xlat10.x / u_xlat20;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(0.00999999978<abs(u_xlat20));
#else
    u_xlatb20 = 0.00999999978<abs(u_xlat20);
#endif
    u_xlat16_3 = (u_xlatb20) ? u_xlat10.x : 1.0;
    u_xlat20 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat20 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat20 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat16_9 = (-u_xlat20) + 2.0;
    u_xlat16_9 = u_xlat20 * u_xlat16_9;
    u_xlat20 = u_xlat16_9 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat20 = u_xlat20 + 1.0;
    u_xlat16_3 = u_xlat20 * u_xlat16_3;
    u_xlat20 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat10.x = (-u_xlat20) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat10.xxx;
    u_xlat3.w = u_xlat18 * u_xlat10.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat20) + u_xlat2.xyz;
    u_xlat16_5 = (-u_xlat6.x) + 2.0;
    u_xlat16_5 = u_xlat6.x * u_xlat16_5;
    u_xlat2.xyz = vec3(u_xlat16_5) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat10.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat6.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat6.x = u_xlat6.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat6.xxx * u_xlat10.xyz + u_xlat2.xyz;
    u_xlat6.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat18 = (-u_xlat6.x) + 2.0;
    u_xlat6.x = u_xlat18 * u_xlat6.x;
    u_xlat18 = u_xlat6.x * _HeigtFogColDelta2.w;
    u_xlat6.x = (u_xlatb4) ? u_xlat18 : u_xlat6.x;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _Mihoyo_FogColor2.w;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat6.x = min(u_xlat6.x, _HeigtFogColBase2.w);
    u_xlat2.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat18 = u_xlat12 * -1.44269502;
    u_xlat6.z = exp2(u_xlat18);
    u_xlat6.xz = (-u_xlat6.xz) + vec2(1.0, 1.0);
    u_xlat18 = u_xlat6.z / u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.00999999978<abs(u_xlat12));
#else
    u_xlatb12 = 0.00999999978<abs(u_xlat12);
#endif
    u_xlat16_5 = (u_xlatb12) ? u_xlat18 : 1.0;
    u_xlat12 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat12 * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_11 = (-u_xlat0.x) + 2.0;
    u_xlat16_11 = u_xlat0.x * u_xlat16_11;
    u_xlat0.x = u_xlat16_11 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_5 = u_xlat0.x * u_xlat16_5;
    u_xlat0.x = min(u_xlat16_5, _HeigtFogColBase2.w);
    u_xlat12 = (-u_xlat0.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat4.w = u_xlat12 * u_xlat6.x;
    u_xlat4.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0 = u_xlat3 + (-u_xlat4);
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat4;
    vs_COLOR1 = u_xlat0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _ReceiveDynamicShadow;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_12;
bool u_xlatb12;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb12 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb12){
        u_xlat2.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_12 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_3.x = u_xlat10_12;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-_ShadowIntegration) * u_xlat16_3.x + 1.0;
    u_xlat16_7.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_3.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xxx + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat12 = u_xlat2.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat2.x);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat2.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat6);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2.xy = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x + (-_UWFogDistStart);
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.xy = u_xlat2.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat2.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD3.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _ShadowIntegration;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
bool u_xlatb9;
lowp float u_xlat10_12;
bool u_xlatb12;
mediump float u_xlat16_15;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb12 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb12){
        u_xlat2.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_12 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_3.x = u_xlat10_12;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-_ShadowIntegration) * u_xlat16_3.x + 1.0;
    u_xlat16_7.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD3.z<_WaterPlaneHeight);
#else
    u_xlatb12 = vs_TEXCOORD3.z<_WaterPlaneHeight;
#endif
    u_xlat1.x = (-vs_TEXCOORD3.z) + _WaterPlaneHeight;
    u_xlat5 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat1.x = u_xlat1.x / u_xlat5;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat2.x = u_xlat1.x * _UWFogColorHLIntensity;
    u_xlat5 = (-_UWHeightFogDensity) * u_xlat1.x + 1.0;
    u_xlat5 = u_xlat5 * _UWHeightFogEffectLimit;
    u_xlat5 = max(u_xlat5, _UWHeightFogEffectStart);
    u_xlat5 = min(u_xlat5, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.99000001<vs_TEXCOORD3.y);
#else
    u_xlatb9 = 0.99000001<vs_TEXCOORD3.y;
#endif
    u_xlat1.x = (-u_xlat1.x) * _UWHeightRatio + 1.0;
    u_xlat1.x = u_xlat1.x * vs_TEXCOORD3.y;
    u_xlat1.x = max(u_xlat1.x, _UWCriticalRange);
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat16_15 = (u_xlatb9) ? u_xlat1.x : vs_TEXCOORD3.y;
    u_xlat16_15 = (-u_xlat16_15) + 1.0;
    u_xlat1.xzw = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat1.xzw = vs_TEXCOORD3.xxx * u_xlat1.xzw + _UWFogColorFar.xyz;
    u_xlat6.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + (-u_xlat1.xzw);
    u_xlat1.xzw = vec3(u_xlat16_15) * u_xlat6.xyz + u_xlat1.xzw;
    u_xlat6.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat6.xyz + _UWFogColorLow.xyz;
    u_xlat1.xzw = u_xlat1.xzw + (-u_xlat2.xyz);
    u_xlat1.xyz = vec3(u_xlat5) * u_xlat1.xzw + u_xlat2.xyz;
    SV_Target0.xyz = (bool(u_xlatb12)) ? u_xlat1.xyz : u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat12 = u_xlat2.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat2.x);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat2.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat6);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2.xy = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x + (-_UWFogDistStart);
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.xy = u_xlat2.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat2.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD3.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _ShadowIntegration;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
bool u_xlatb9;
lowp float u_xlat10_12;
bool u_xlatb12;
mediump float u_xlat16_15;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb12 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb12){
        u_xlat2.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_12 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_3.x = u_xlat10_12;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-_ShadowIntegration) * u_xlat16_3.x + 1.0;
    u_xlat16_7.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD3.z<_WaterPlaneHeight);
#else
    u_xlatb12 = vs_TEXCOORD3.z<_WaterPlaneHeight;
#endif
    u_xlat1.x = (-vs_TEXCOORD3.z) + _WaterPlaneHeight;
    u_xlat5 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat1.x = u_xlat1.x / u_xlat5;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat2.x = u_xlat1.x * _UWFogColorHLIntensity;
    u_xlat5 = (-_UWHeightFogDensity) * u_xlat1.x + 1.0;
    u_xlat5 = u_xlat5 * _UWHeightFogEffectLimit;
    u_xlat5 = max(u_xlat5, _UWHeightFogEffectStart);
    u_xlat5 = min(u_xlat5, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.99000001<vs_TEXCOORD3.y);
#else
    u_xlatb9 = 0.99000001<vs_TEXCOORD3.y;
#endif
    u_xlat1.x = (-u_xlat1.x) * _UWHeightRatio + 1.0;
    u_xlat1.x = u_xlat1.x * vs_TEXCOORD3.y;
    u_xlat1.x = max(u_xlat1.x, _UWCriticalRange);
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat16_15 = (u_xlatb9) ? u_xlat1.x : vs_TEXCOORD3.y;
    u_xlat16_15 = (-u_xlat16_15) + 1.0;
    u_xlat1.xzw = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat1.xzw = vs_TEXCOORD3.xxx * u_xlat1.xzw + _UWFogColorFar.xyz;
    u_xlat6.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + (-u_xlat1.xzw);
    u_xlat1.xzw = vec3(u_xlat16_15) * u_xlat6.xyz + u_xlat1.xzw;
    u_xlat6.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat6.xyz + _UWFogColorLow.xyz;
    u_xlat1.xzw = u_xlat1.xzw + (-u_xlat2.xyz);
    u_xlat1.xyz = vec3(u_xlat5) * u_xlat1.xzw + u_xlat2.xyz;
    SV_Target0.xyz = (bool(u_xlatb12)) ? u_xlat1.xyz : u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat12 = u_xlat2.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat2.x);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat2.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat6);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2.xy = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x + (-_UWFogDistStart);
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.xy = u_xlat2.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat2.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD3.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _ShadowIntegration;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
bool u_xlatb9;
lowp float u_xlat10_12;
bool u_xlatb12;
mediump float u_xlat16_15;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb12 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb12){
        u_xlat2.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_12 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_3.x = u_xlat10_12;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-_ShadowIntegration) * u_xlat16_3.x + 1.0;
    u_xlat16_7.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD3.z<_WaterPlaneHeight);
#else
    u_xlatb12 = vs_TEXCOORD3.z<_WaterPlaneHeight;
#endif
    u_xlat1.x = (-vs_TEXCOORD3.z) + _WaterPlaneHeight;
    u_xlat5 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat1.x = u_xlat1.x / u_xlat5;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat2.x = u_xlat1.x * _UWFogColorHLIntensity;
    u_xlat5 = (-_UWHeightFogDensity) * u_xlat1.x + 1.0;
    u_xlat5 = u_xlat5 * _UWHeightFogEffectLimit;
    u_xlat5 = max(u_xlat5, _UWHeightFogEffectStart);
    u_xlat5 = min(u_xlat5, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.99000001<vs_TEXCOORD3.y);
#else
    u_xlatb9 = 0.99000001<vs_TEXCOORD3.y;
#endif
    u_xlat1.x = (-u_xlat1.x) * _UWHeightRatio + 1.0;
    u_xlat1.x = u_xlat1.x * vs_TEXCOORD3.y;
    u_xlat1.x = max(u_xlat1.x, _UWCriticalRange);
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat16_15 = (u_xlatb9) ? u_xlat1.x : vs_TEXCOORD3.y;
    u_xlat16_15 = (-u_xlat16_15) + 1.0;
    u_xlat1.xzw = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat1.xzw = vs_TEXCOORD3.xxx * u_xlat1.xzw + _UWFogColorFar.xyz;
    u_xlat6.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + (-u_xlat1.xzw);
    u_xlat1.xzw = vec3(u_xlat16_15) * u_xlat6.xyz + u_xlat1.xzw;
    u_xlat6.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat6.xyz + _UWFogColorLow.xyz;
    u_xlat1.xzw = u_xlat1.xzw + (-u_xlat2.xyz);
    u_xlat1.xyz = vec3(u_xlat5) * u_xlat1.xzw + u_xlat2.xyz;
    SV_Target0.xyz = (bool(u_xlatb12)) ? u_xlat1.xyz : u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat12 = u_xlat2.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat2.x);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat2.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat6);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2.xy = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x + (-_UWFogDistStart);
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.xy = u_xlat2.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat2.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD3.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
bool u_xlatb9;
lowp float u_xlat10_12;
bool u_xlatb12;
mediump float u_xlat16_15;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb12 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb12){
        u_xlat2.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_12 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_3.x = u_xlat10_12;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-_ShadowIntegration) * u_xlat16_3.x + 1.0;
    u_xlat16_7.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD3.z<_WaterPlaneHeight);
#else
    u_xlatb12 = vs_TEXCOORD3.z<_WaterPlaneHeight;
#endif
    u_xlat1.x = (-vs_TEXCOORD3.z) + _WaterPlaneHeight;
    u_xlat5 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat1.x = u_xlat1.x / u_xlat5;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat2.x = u_xlat1.x * _UWFogColorHLIntensity;
    u_xlat5 = (-_UWHeightFogDensity) * u_xlat1.x + 1.0;
    u_xlat5 = u_xlat5 * _UWHeightFogEffectLimit;
    u_xlat5 = max(u_xlat5, _UWHeightFogEffectStart);
    u_xlat5 = min(u_xlat5, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.99000001<vs_TEXCOORD3.y);
#else
    u_xlatb9 = 0.99000001<vs_TEXCOORD3.y;
#endif
    u_xlat1.x = (-u_xlat1.x) * _UWHeightRatio + 1.0;
    u_xlat1.x = u_xlat1.x * vs_TEXCOORD3.y;
    u_xlat1.x = max(u_xlat1.x, _UWCriticalRange);
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat16_15 = (u_xlatb9) ? u_xlat1.x : vs_TEXCOORD3.y;
    u_xlat16_15 = (-u_xlat16_15) + 1.0;
    u_xlat1.xzw = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat1.xzw = vs_TEXCOORD3.xxx * u_xlat1.xzw + _UWFogColorFar.xyz;
    u_xlat6.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + (-u_xlat1.xzw);
    u_xlat1.xzw = vec3(u_xlat16_15) * u_xlat6.xyz + u_xlat1.xzw;
    u_xlat6.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat6.xyz + _UWFogColorLow.xyz;
    u_xlat1.xzw = u_xlat1.xzw + (-u_xlat2.xyz);
    u_xlat1.xyz = vec3(u_xlat5) * u_xlat1.xzw + u_xlat2.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb12)) ? u_xlat1.xyz : u_xlat0.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat12 = u_xlat2.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat2.x);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat2.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat6);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2.xy = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x + (-_UWFogDistStart);
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.xy = u_xlat2.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat2.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD3.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
bool u_xlatb9;
lowp float u_xlat10_12;
bool u_xlatb12;
mediump float u_xlat16_15;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb12 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb12){
        u_xlat2.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_12 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_3.x = u_xlat10_12;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-_ShadowIntegration) * u_xlat16_3.x + 1.0;
    u_xlat16_7.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD3.z<_WaterPlaneHeight);
#else
    u_xlatb12 = vs_TEXCOORD3.z<_WaterPlaneHeight;
#endif
    u_xlat1.x = (-vs_TEXCOORD3.z) + _WaterPlaneHeight;
    u_xlat5 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat1.x = u_xlat1.x / u_xlat5;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat2.x = u_xlat1.x * _UWFogColorHLIntensity;
    u_xlat5 = (-_UWHeightFogDensity) * u_xlat1.x + 1.0;
    u_xlat5 = u_xlat5 * _UWHeightFogEffectLimit;
    u_xlat5 = max(u_xlat5, _UWHeightFogEffectStart);
    u_xlat5 = min(u_xlat5, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.99000001<vs_TEXCOORD3.y);
#else
    u_xlatb9 = 0.99000001<vs_TEXCOORD3.y;
#endif
    u_xlat1.x = (-u_xlat1.x) * _UWHeightRatio + 1.0;
    u_xlat1.x = u_xlat1.x * vs_TEXCOORD3.y;
    u_xlat1.x = max(u_xlat1.x, _UWCriticalRange);
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat16_15 = (u_xlatb9) ? u_xlat1.x : vs_TEXCOORD3.y;
    u_xlat16_15 = (-u_xlat16_15) + 1.0;
    u_xlat1.xzw = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat1.xzw = vs_TEXCOORD3.xxx * u_xlat1.xzw + _UWFogColorFar.xyz;
    u_xlat6.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + (-u_xlat1.xzw);
    u_xlat1.xzw = vec3(u_xlat16_15) * u_xlat6.xyz + u_xlat1.xzw;
    u_xlat6.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat6.xyz + _UWFogColorLow.xyz;
    u_xlat1.xzw = u_xlat1.xzw + (-u_xlat2.xyz);
    u_xlat1.xyz = vec3(u_xlat5) * u_xlat1.xzw + u_xlat2.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb12)) ? u_xlat1.xyz : u_xlat0.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat12 = u_xlat2.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat2.x);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat2.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat6);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2.xy = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x + (-_UWFogDistStart);
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.xy = u_xlat2.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat2.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD3.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
bool u_xlatb9;
lowp float u_xlat10_12;
bool u_xlatb12;
mediump float u_xlat16_15;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb12 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb12){
        u_xlat2.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_12 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_3.x = u_xlat10_12;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-_ShadowIntegration) * u_xlat16_3.x + 1.0;
    u_xlat16_7.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD3.z<_WaterPlaneHeight);
#else
    u_xlatb12 = vs_TEXCOORD3.z<_WaterPlaneHeight;
#endif
    u_xlat1.x = (-vs_TEXCOORD3.z) + _WaterPlaneHeight;
    u_xlat5 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat1.x = u_xlat1.x / u_xlat5;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat2.x = u_xlat1.x * _UWFogColorHLIntensity;
    u_xlat5 = (-_UWHeightFogDensity) * u_xlat1.x + 1.0;
    u_xlat5 = u_xlat5 * _UWHeightFogEffectLimit;
    u_xlat5 = max(u_xlat5, _UWHeightFogEffectStart);
    u_xlat5 = min(u_xlat5, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.99000001<vs_TEXCOORD3.y);
#else
    u_xlatb9 = 0.99000001<vs_TEXCOORD3.y;
#endif
    u_xlat1.x = (-u_xlat1.x) * _UWHeightRatio + 1.0;
    u_xlat1.x = u_xlat1.x * vs_TEXCOORD3.y;
    u_xlat1.x = max(u_xlat1.x, _UWCriticalRange);
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat16_15 = (u_xlatb9) ? u_xlat1.x : vs_TEXCOORD3.y;
    u_xlat16_15 = (-u_xlat16_15) + 1.0;
    u_xlat1.xzw = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat1.xzw = vs_TEXCOORD3.xxx * u_xlat1.xzw + _UWFogColorFar.xyz;
    u_xlat6.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + (-u_xlat1.xzw);
    u_xlat1.xzw = vec3(u_xlat16_15) * u_xlat6.xyz + u_xlat1.xzw;
    u_xlat6.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat6.xyz + _UWFogColorLow.xyz;
    u_xlat1.xzw = u_xlat1.xzw + (-u_xlat2.xyz);
    u_xlat1.xyz = vec3(u_xlat5) * u_xlat1.xzw + u_xlat2.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb12)) ? u_xlat1.xyz : u_xlat0.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat12 = u_xlat2.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat2.x);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat2.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat6);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2.xy = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x + (-_UWFogDistStart);
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.xy = u_xlat2.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat2.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD3.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _ShadowIntegration;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
bool u_xlatb9;
lowp float u_xlat10_12;
bool u_xlatb12;
mediump float u_xlat16_15;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb12 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb12){
        u_xlat2.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_12 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_3.x = u_xlat10_12;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-_ShadowIntegration) * u_xlat16_3.x + 1.0;
    u_xlat16_7.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD3.z<_WaterPlaneHeight);
#else
    u_xlatb12 = vs_TEXCOORD3.z<_WaterPlaneHeight;
#endif
    u_xlat1.x = (-vs_TEXCOORD3.z) + _WaterPlaneHeight;
    u_xlat5 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat1.x = u_xlat1.x / u_xlat5;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat2.x = u_xlat1.x * _UWFogColorHLIntensity;
    u_xlat5 = (-_UWHeightFogDensity) * u_xlat1.x + 1.0;
    u_xlat5 = u_xlat5 * _UWHeightFogEffectLimit;
    u_xlat5 = max(u_xlat5, _UWHeightFogEffectStart);
    u_xlat5 = min(u_xlat5, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.99000001<vs_TEXCOORD3.y);
#else
    u_xlatb9 = 0.99000001<vs_TEXCOORD3.y;
#endif
    u_xlat1.x = (-u_xlat1.x) * _UWHeightRatio + 1.0;
    u_xlat1.x = u_xlat1.x * vs_TEXCOORD3.y;
    u_xlat1.x = max(u_xlat1.x, _UWCriticalRange);
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat16_15 = (u_xlatb9) ? u_xlat1.x : vs_TEXCOORD3.y;
    u_xlat16_15 = (-u_xlat16_15) + 1.0;
    u_xlat1.xzw = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat1.xzw = vs_TEXCOORD3.xxx * u_xlat1.xzw + _UWFogColorFar.xyz;
    u_xlat6.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + (-u_xlat1.xzw);
    u_xlat1.xzw = vec3(u_xlat16_15) * u_xlat6.xyz + u_xlat1.xzw;
    u_xlat6.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat6.xyz + _UWFogColorLow.xyz;
    u_xlat1.xzw = u_xlat1.xzw + (-u_xlat2.xyz);
    u_xlat1.xyz = vec3(u_xlat5) * u_xlat1.xzw + u_xlat2.xyz;
    SV_Target0.xyz = (bool(u_xlatb12)) ? u_xlat1.xyz : u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat12 = u_xlat2.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat2.x);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat2.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat6);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2.xy = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x + (-_UWFogDistStart);
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.xy = u_xlat2.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat2.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD3.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _ShadowIntegration;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
bool u_xlatb9;
lowp float u_xlat10_12;
bool u_xlatb12;
mediump float u_xlat16_15;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb12 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb12){
        u_xlat2.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_12 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_3.x = u_xlat10_12;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-_ShadowIntegration) * u_xlat16_3.x + 1.0;
    u_xlat16_7.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD3.z<_WaterPlaneHeight);
#else
    u_xlatb12 = vs_TEXCOORD3.z<_WaterPlaneHeight;
#endif
    u_xlat1.x = (-vs_TEXCOORD3.z) + _WaterPlaneHeight;
    u_xlat5 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat1.x = u_xlat1.x / u_xlat5;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat2.x = u_xlat1.x * _UWFogColorHLIntensity;
    u_xlat5 = (-_UWHeightFogDensity) * u_xlat1.x + 1.0;
    u_xlat5 = u_xlat5 * _UWHeightFogEffectLimit;
    u_xlat5 = max(u_xlat5, _UWHeightFogEffectStart);
    u_xlat5 = min(u_xlat5, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.99000001<vs_TEXCOORD3.y);
#else
    u_xlatb9 = 0.99000001<vs_TEXCOORD3.y;
#endif
    u_xlat1.x = (-u_xlat1.x) * _UWHeightRatio + 1.0;
    u_xlat1.x = u_xlat1.x * vs_TEXCOORD3.y;
    u_xlat1.x = max(u_xlat1.x, _UWCriticalRange);
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat16_15 = (u_xlatb9) ? u_xlat1.x : vs_TEXCOORD3.y;
    u_xlat16_15 = (-u_xlat16_15) + 1.0;
    u_xlat1.xzw = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat1.xzw = vs_TEXCOORD3.xxx * u_xlat1.xzw + _UWFogColorFar.xyz;
    u_xlat6.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + (-u_xlat1.xzw);
    u_xlat1.xzw = vec3(u_xlat16_15) * u_xlat6.xyz + u_xlat1.xzw;
    u_xlat6.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat6.xyz + _UWFogColorLow.xyz;
    u_xlat1.xzw = u_xlat1.xzw + (-u_xlat2.xyz);
    u_xlat1.xyz = vec3(u_xlat5) * u_xlat1.xzw + u_xlat2.xyz;
    SV_Target0.xyz = (bool(u_xlatb12)) ? u_xlat1.xyz : u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat12 = u_xlat2.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat2.x);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat2.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat6);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2.xy = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x + (-_UWFogDistStart);
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.xy = u_xlat2.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat2.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD3.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _ShadowIntegration;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
bool u_xlatb9;
lowp float u_xlat10_12;
bool u_xlatb12;
mediump float u_xlat16_15;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb12 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb12){
        u_xlat2.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_12 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_3.x = u_xlat10_12;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-_ShadowIntegration) * u_xlat16_3.x + 1.0;
    u_xlat16_7.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD3.z<_WaterPlaneHeight);
#else
    u_xlatb12 = vs_TEXCOORD3.z<_WaterPlaneHeight;
#endif
    u_xlat1.x = (-vs_TEXCOORD3.z) + _WaterPlaneHeight;
    u_xlat5 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat1.x = u_xlat1.x / u_xlat5;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat2.x = u_xlat1.x * _UWFogColorHLIntensity;
    u_xlat5 = (-_UWHeightFogDensity) * u_xlat1.x + 1.0;
    u_xlat5 = u_xlat5 * _UWHeightFogEffectLimit;
    u_xlat5 = max(u_xlat5, _UWHeightFogEffectStart);
    u_xlat5 = min(u_xlat5, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.99000001<vs_TEXCOORD3.y);
#else
    u_xlatb9 = 0.99000001<vs_TEXCOORD3.y;
#endif
    u_xlat1.x = (-u_xlat1.x) * _UWHeightRatio + 1.0;
    u_xlat1.x = u_xlat1.x * vs_TEXCOORD3.y;
    u_xlat1.x = max(u_xlat1.x, _UWCriticalRange);
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat16_15 = (u_xlatb9) ? u_xlat1.x : vs_TEXCOORD3.y;
    u_xlat16_15 = (-u_xlat16_15) + 1.0;
    u_xlat1.xzw = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat1.xzw = vs_TEXCOORD3.xxx * u_xlat1.xzw + _UWFogColorFar.xyz;
    u_xlat6.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + (-u_xlat1.xzw);
    u_xlat1.xzw = vec3(u_xlat16_15) * u_xlat6.xyz + u_xlat1.xzw;
    u_xlat6.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat6.xyz + _UWFogColorLow.xyz;
    u_xlat1.xzw = u_xlat1.xzw + (-u_xlat2.xyz);
    u_xlat1.xyz = vec3(u_xlat5) * u_xlat1.xzw + u_xlat2.xyz;
    SV_Target0.xyz = (bool(u_xlatb12)) ? u_xlat1.xyz : u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat12 = u_xlat2.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat2.x);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat2.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat6);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2.xy = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x + (-_UWFogDistStart);
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.xy = u_xlat2.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat2.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD3.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
bool u_xlatb9;
lowp float u_xlat10_12;
bool u_xlatb12;
mediump float u_xlat16_15;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb12 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb12){
        u_xlat2.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_12 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_3.x = u_xlat10_12;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-_ShadowIntegration) * u_xlat16_3.x + 1.0;
    u_xlat16_7.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD3.z<_WaterPlaneHeight);
#else
    u_xlatb12 = vs_TEXCOORD3.z<_WaterPlaneHeight;
#endif
    u_xlat1.x = (-vs_TEXCOORD3.z) + _WaterPlaneHeight;
    u_xlat5 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat1.x = u_xlat1.x / u_xlat5;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat2.x = u_xlat1.x * _UWFogColorHLIntensity;
    u_xlat5 = (-_UWHeightFogDensity) * u_xlat1.x + 1.0;
    u_xlat5 = u_xlat5 * _UWHeightFogEffectLimit;
    u_xlat5 = max(u_xlat5, _UWHeightFogEffectStart);
    u_xlat5 = min(u_xlat5, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.99000001<vs_TEXCOORD3.y);
#else
    u_xlatb9 = 0.99000001<vs_TEXCOORD3.y;
#endif
    u_xlat1.x = (-u_xlat1.x) * _UWHeightRatio + 1.0;
    u_xlat1.x = u_xlat1.x * vs_TEXCOORD3.y;
    u_xlat1.x = max(u_xlat1.x, _UWCriticalRange);
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat16_15 = (u_xlatb9) ? u_xlat1.x : vs_TEXCOORD3.y;
    u_xlat16_15 = (-u_xlat16_15) + 1.0;
    u_xlat1.xzw = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat1.xzw = vs_TEXCOORD3.xxx * u_xlat1.xzw + _UWFogColorFar.xyz;
    u_xlat6.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + (-u_xlat1.xzw);
    u_xlat1.xzw = vec3(u_xlat16_15) * u_xlat6.xyz + u_xlat1.xzw;
    u_xlat6.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat6.xyz + _UWFogColorLow.xyz;
    u_xlat1.xzw = u_xlat1.xzw + (-u_xlat2.xyz);
    u_xlat1.xyz = vec3(u_xlat5) * u_xlat1.xzw + u_xlat2.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb12)) ? u_xlat1.xyz : u_xlat0.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat12 = u_xlat2.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat2.x);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat2.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat6);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2.xy = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x + (-_UWFogDistStart);
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.xy = u_xlat2.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat2.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD3.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
bool u_xlatb9;
lowp float u_xlat10_12;
bool u_xlatb12;
mediump float u_xlat16_15;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb12 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb12){
        u_xlat2.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_12 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_3.x = u_xlat10_12;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-_ShadowIntegration) * u_xlat16_3.x + 1.0;
    u_xlat16_7.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD3.z<_WaterPlaneHeight);
#else
    u_xlatb12 = vs_TEXCOORD3.z<_WaterPlaneHeight;
#endif
    u_xlat1.x = (-vs_TEXCOORD3.z) + _WaterPlaneHeight;
    u_xlat5 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat1.x = u_xlat1.x / u_xlat5;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat2.x = u_xlat1.x * _UWFogColorHLIntensity;
    u_xlat5 = (-_UWHeightFogDensity) * u_xlat1.x + 1.0;
    u_xlat5 = u_xlat5 * _UWHeightFogEffectLimit;
    u_xlat5 = max(u_xlat5, _UWHeightFogEffectStart);
    u_xlat5 = min(u_xlat5, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.99000001<vs_TEXCOORD3.y);
#else
    u_xlatb9 = 0.99000001<vs_TEXCOORD3.y;
#endif
    u_xlat1.x = (-u_xlat1.x) * _UWHeightRatio + 1.0;
    u_xlat1.x = u_xlat1.x * vs_TEXCOORD3.y;
    u_xlat1.x = max(u_xlat1.x, _UWCriticalRange);
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat16_15 = (u_xlatb9) ? u_xlat1.x : vs_TEXCOORD3.y;
    u_xlat16_15 = (-u_xlat16_15) + 1.0;
    u_xlat1.xzw = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat1.xzw = vs_TEXCOORD3.xxx * u_xlat1.xzw + _UWFogColorFar.xyz;
    u_xlat6.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + (-u_xlat1.xzw);
    u_xlat1.xzw = vec3(u_xlat16_15) * u_xlat6.xyz + u_xlat1.xzw;
    u_xlat6.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat6.xyz + _UWFogColorLow.xyz;
    u_xlat1.xzw = u_xlat1.xzw + (-u_xlat2.xyz);
    u_xlat1.xyz = vec3(u_xlat5) * u_xlat1.xzw + u_xlat2.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb12)) ? u_xlat1.xyz : u_xlat0.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat12 = u_xlat2.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat2.x);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat2.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat6);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2.xy = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x + (-_UWFogDistStart);
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.xy = u_xlat2.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat2.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD3.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
bool u_xlatb9;
lowp float u_xlat10_12;
bool u_xlatb12;
mediump float u_xlat16_15;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb12 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb12){
        u_xlat2.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_12 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_3.x = u_xlat10_12;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-_ShadowIntegration) * u_xlat16_3.x + 1.0;
    u_xlat16_7.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD3.z<_WaterPlaneHeight);
#else
    u_xlatb12 = vs_TEXCOORD3.z<_WaterPlaneHeight;
#endif
    u_xlat1.x = (-vs_TEXCOORD3.z) + _WaterPlaneHeight;
    u_xlat5 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat1.x = u_xlat1.x / u_xlat5;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat2.x = u_xlat1.x * _UWFogColorHLIntensity;
    u_xlat5 = (-_UWHeightFogDensity) * u_xlat1.x + 1.0;
    u_xlat5 = u_xlat5 * _UWHeightFogEffectLimit;
    u_xlat5 = max(u_xlat5, _UWHeightFogEffectStart);
    u_xlat5 = min(u_xlat5, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.99000001<vs_TEXCOORD3.y);
#else
    u_xlatb9 = 0.99000001<vs_TEXCOORD3.y;
#endif
    u_xlat1.x = (-u_xlat1.x) * _UWHeightRatio + 1.0;
    u_xlat1.x = u_xlat1.x * vs_TEXCOORD3.y;
    u_xlat1.x = max(u_xlat1.x, _UWCriticalRange);
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat16_15 = (u_xlatb9) ? u_xlat1.x : vs_TEXCOORD3.y;
    u_xlat16_15 = (-u_xlat16_15) + 1.0;
    u_xlat1.xzw = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat1.xzw = vs_TEXCOORD3.xxx * u_xlat1.xzw + _UWFogColorFar.xyz;
    u_xlat6.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + (-u_xlat1.xzw);
    u_xlat1.xzw = vec3(u_xlat16_15) * u_xlat6.xyz + u_xlat1.xzw;
    u_xlat6.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat6.xyz + _UWFogColorLow.xyz;
    u_xlat1.xzw = u_xlat1.xzw + (-u_xlat2.xyz);
    u_xlat1.xyz = vec3(u_xlat5) * u_xlat1.xzw + u_xlat2.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb12)) ? u_xlat1.xyz : u_xlat0.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
vec2 u_xlat16;
float u_xlat20;
float u_xlat22;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat2.x = u_xlat0.w * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat2.x) + 2.0;
    u_xlat16_3 = u_xlat2.x * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
    u_xlat20 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat20 = sqrt(u_xlat20);
    u_xlat22 = u_xlat20 + (-_HeigtFogRamp.w);
    u_xlat22 = u_xlat22 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat4.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat20>=u_xlat4.x);
#else
    u_xlatb4 = u_xlat20>=u_xlat4.x;
#endif
    u_xlat10 = u_xlat20 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat16.x = (-u_xlat10) + 2.0;
    u_xlat10 = u_xlat16.x * u_xlat10;
    u_xlat16.x = u_xlat10 * _HeigtFogColDelta.w;
    u_xlat4.x = (u_xlatb4) ? u_xlat16.x : u_xlat10;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _Mihoyo_FogColor.w;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, _HeigtFogColBase.w);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat10 = u_xlat5.y * _HeigtFogParams.x;
    u_xlat16.x = dot(u_xlat5.xz, u_xlat5.xz);
    u_xlat16.x = sqrt(u_xlat16.x);
    u_xlat16.x = u_xlat16.x + (-_UWFogDistStart);
    u_xlat16.x = max(u_xlat16.x, 0.0);
    u_xlat16.xy = u_xlat16.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat16.xy = u_xlat16.xy * (-u_xlat16.xy);
    u_xlat16.xy = u_xlat16.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat16.xy);
    u_xlat16.x = u_xlat10 * -1.44269502;
    u_xlat4.z = exp2(u_xlat16.x);
    u_xlat4.xz = (-u_xlat4.xz) + vec2(1.0, 1.0);
    u_xlat16.x = u_xlat4.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_3 = (u_xlatb10) ? u_xlat16.x : 1.0;
    u_xlat10 = u_xlat20 * _HeigtFogParams.y;
    u_xlat20 = u_xlat20 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat16_3 * u_xlat10;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_9 = (-u_xlat20) + 2.0;
    u_xlat16_9 = u_xlat20 * u_xlat16_9;
    u_xlat20 = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat20 = u_xlat20 + 1.0;
    u_xlat16_3 = u_xlat20 * u_xlat16_3;
    u_xlat20 = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat10 = (-u_xlat20) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat10);
    u_xlat3.w = u_xlat10 * u_xlat4.x;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat20) + u_xlat2.xyz;
    vs_COLOR1 = u_xlat3;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD3.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _ShadowIntegration;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
bool u_xlatb9;
lowp float u_xlat10_12;
bool u_xlatb12;
mediump float u_xlat16_15;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb12 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb12){
        u_xlat2.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_12 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_3.x = u_xlat10_12;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-_ShadowIntegration) * u_xlat16_3.x + 1.0;
    u_xlat16_7.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD3.z<_WaterPlaneHeight);
#else
    u_xlatb12 = vs_TEXCOORD3.z<_WaterPlaneHeight;
#endif
    u_xlat1.x = (-vs_TEXCOORD3.z) + _WaterPlaneHeight;
    u_xlat5 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat1.x = u_xlat1.x / u_xlat5;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat2.x = u_xlat1.x * _UWFogColorHLIntensity;
    u_xlat5 = (-_UWHeightFogDensity) * u_xlat1.x + 1.0;
    u_xlat5 = u_xlat5 * _UWHeightFogEffectLimit;
    u_xlat5 = max(u_xlat5, _UWHeightFogEffectStart);
    u_xlat5 = min(u_xlat5, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.99000001<vs_TEXCOORD3.y);
#else
    u_xlatb9 = 0.99000001<vs_TEXCOORD3.y;
#endif
    u_xlat1.x = (-u_xlat1.x) * _UWHeightRatio + 1.0;
    u_xlat1.x = u_xlat1.x * vs_TEXCOORD3.y;
    u_xlat1.x = max(u_xlat1.x, _UWCriticalRange);
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat16_15 = (u_xlatb9) ? u_xlat1.x : vs_TEXCOORD3.y;
    u_xlat16_15 = (-u_xlat16_15) + 1.0;
    u_xlat1.xzw = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat1.xzw = vs_TEXCOORD3.xxx * u_xlat1.xzw + _UWFogColorFar.xyz;
    u_xlat6.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + (-u_xlat1.xzw);
    u_xlat1.xzw = vec3(u_xlat16_15) * u_xlat6.xyz + u_xlat1.xzw;
    u_xlat6.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat6.xyz + _UWFogColorLow.xyz;
    u_xlat1.xzw = u_xlat1.xzw + (-u_xlat2.xyz);
    u_xlat1.xyz = vec3(u_xlat5) * u_xlat1.xzw + u_xlat2.xyz;
    SV_Target0.xyz = (bool(u_xlatb12)) ? u_xlat1.xyz : u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
vec2 u_xlat16;
float u_xlat20;
float u_xlat22;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat2.x = u_xlat0.w * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat2.x) + 2.0;
    u_xlat16_3 = u_xlat2.x * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
    u_xlat20 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat20 = sqrt(u_xlat20);
    u_xlat22 = u_xlat20 + (-_HeigtFogRamp.w);
    u_xlat22 = u_xlat22 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat4.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat20>=u_xlat4.x);
#else
    u_xlatb4 = u_xlat20>=u_xlat4.x;
#endif
    u_xlat10 = u_xlat20 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat16.x = (-u_xlat10) + 2.0;
    u_xlat10 = u_xlat16.x * u_xlat10;
    u_xlat16.x = u_xlat10 * _HeigtFogColDelta.w;
    u_xlat4.x = (u_xlatb4) ? u_xlat16.x : u_xlat10;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _Mihoyo_FogColor.w;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, _HeigtFogColBase.w);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat10 = u_xlat5.y * _HeigtFogParams.x;
    u_xlat16.x = dot(u_xlat5.xz, u_xlat5.xz);
    u_xlat16.x = sqrt(u_xlat16.x);
    u_xlat16.x = u_xlat16.x + (-_UWFogDistStart);
    u_xlat16.x = max(u_xlat16.x, 0.0);
    u_xlat16.xy = u_xlat16.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat16.xy = u_xlat16.xy * (-u_xlat16.xy);
    u_xlat16.xy = u_xlat16.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat16.xy);
    u_xlat16.x = u_xlat10 * -1.44269502;
    u_xlat4.z = exp2(u_xlat16.x);
    u_xlat4.xz = (-u_xlat4.xz) + vec2(1.0, 1.0);
    u_xlat16.x = u_xlat4.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_3 = (u_xlatb10) ? u_xlat16.x : 1.0;
    u_xlat10 = u_xlat20 * _HeigtFogParams.y;
    u_xlat20 = u_xlat20 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat16_3 * u_xlat10;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_9 = (-u_xlat20) + 2.0;
    u_xlat16_9 = u_xlat20 * u_xlat16_9;
    u_xlat20 = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat20 = u_xlat20 + 1.0;
    u_xlat16_3 = u_xlat20 * u_xlat16_3;
    u_xlat20 = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat10 = (-u_xlat20) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat10);
    u_xlat3.w = u_xlat10 * u_xlat4.x;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat20) + u_xlat2.xyz;
    vs_COLOR1 = u_xlat3;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD3.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _ShadowIntegration;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
bool u_xlatb9;
lowp float u_xlat10_12;
bool u_xlatb12;
mediump float u_xlat16_15;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb12 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb12){
        u_xlat2.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_12 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_3.x = u_xlat10_12;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-_ShadowIntegration) * u_xlat16_3.x + 1.0;
    u_xlat16_7.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD3.z<_WaterPlaneHeight);
#else
    u_xlatb12 = vs_TEXCOORD3.z<_WaterPlaneHeight;
#endif
    u_xlat1.x = (-vs_TEXCOORD3.z) + _WaterPlaneHeight;
    u_xlat5 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat1.x = u_xlat1.x / u_xlat5;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat2.x = u_xlat1.x * _UWFogColorHLIntensity;
    u_xlat5 = (-_UWHeightFogDensity) * u_xlat1.x + 1.0;
    u_xlat5 = u_xlat5 * _UWHeightFogEffectLimit;
    u_xlat5 = max(u_xlat5, _UWHeightFogEffectStart);
    u_xlat5 = min(u_xlat5, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.99000001<vs_TEXCOORD3.y);
#else
    u_xlatb9 = 0.99000001<vs_TEXCOORD3.y;
#endif
    u_xlat1.x = (-u_xlat1.x) * _UWHeightRatio + 1.0;
    u_xlat1.x = u_xlat1.x * vs_TEXCOORD3.y;
    u_xlat1.x = max(u_xlat1.x, _UWCriticalRange);
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat16_15 = (u_xlatb9) ? u_xlat1.x : vs_TEXCOORD3.y;
    u_xlat16_15 = (-u_xlat16_15) + 1.0;
    u_xlat1.xzw = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat1.xzw = vs_TEXCOORD3.xxx * u_xlat1.xzw + _UWFogColorFar.xyz;
    u_xlat6.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + (-u_xlat1.xzw);
    u_xlat1.xzw = vec3(u_xlat16_15) * u_xlat6.xyz + u_xlat1.xzw;
    u_xlat6.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat6.xyz + _UWFogColorLow.xyz;
    u_xlat1.xzw = u_xlat1.xzw + (-u_xlat2.xyz);
    u_xlat1.xyz = vec3(u_xlat5) * u_xlat1.xzw + u_xlat2.xyz;
    SV_Target0.xyz = (bool(u_xlatb12)) ? u_xlat1.xyz : u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
vec2 u_xlat16;
float u_xlat20;
float u_xlat22;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat2.x = u_xlat0.w * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat2.x) + 2.0;
    u_xlat16_3 = u_xlat2.x * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
    u_xlat20 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat20 = sqrt(u_xlat20);
    u_xlat22 = u_xlat20 + (-_HeigtFogRamp.w);
    u_xlat22 = u_xlat22 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat4.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat20>=u_xlat4.x);
#else
    u_xlatb4 = u_xlat20>=u_xlat4.x;
#endif
    u_xlat10 = u_xlat20 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat16.x = (-u_xlat10) + 2.0;
    u_xlat10 = u_xlat16.x * u_xlat10;
    u_xlat16.x = u_xlat10 * _HeigtFogColDelta.w;
    u_xlat4.x = (u_xlatb4) ? u_xlat16.x : u_xlat10;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _Mihoyo_FogColor.w;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, _HeigtFogColBase.w);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat10 = u_xlat5.y * _HeigtFogParams.x;
    u_xlat16.x = dot(u_xlat5.xz, u_xlat5.xz);
    u_xlat16.x = sqrt(u_xlat16.x);
    u_xlat16.x = u_xlat16.x + (-_UWFogDistStart);
    u_xlat16.x = max(u_xlat16.x, 0.0);
    u_xlat16.xy = u_xlat16.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat16.xy = u_xlat16.xy * (-u_xlat16.xy);
    u_xlat16.xy = u_xlat16.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat16.xy);
    u_xlat16.x = u_xlat10 * -1.44269502;
    u_xlat4.z = exp2(u_xlat16.x);
    u_xlat4.xz = (-u_xlat4.xz) + vec2(1.0, 1.0);
    u_xlat16.x = u_xlat4.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_3 = (u_xlatb10) ? u_xlat16.x : 1.0;
    u_xlat10 = u_xlat20 * _HeigtFogParams.y;
    u_xlat20 = u_xlat20 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat16_3 * u_xlat10;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_9 = (-u_xlat20) + 2.0;
    u_xlat16_9 = u_xlat20 * u_xlat16_9;
    u_xlat20 = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat20 = u_xlat20 + 1.0;
    u_xlat16_3 = u_xlat20 * u_xlat16_3;
    u_xlat20 = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat10 = (-u_xlat20) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat10);
    u_xlat3.w = u_xlat10 * u_xlat4.x;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat20) + u_xlat2.xyz;
    vs_COLOR1 = u_xlat3;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD3.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _ShadowIntegration;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
bool u_xlatb9;
lowp float u_xlat10_12;
bool u_xlatb12;
mediump float u_xlat16_15;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb12 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb12){
        u_xlat2.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_12 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_3.x = u_xlat10_12;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-_ShadowIntegration) * u_xlat16_3.x + 1.0;
    u_xlat16_7.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD3.z<_WaterPlaneHeight);
#else
    u_xlatb12 = vs_TEXCOORD3.z<_WaterPlaneHeight;
#endif
    u_xlat1.x = (-vs_TEXCOORD3.z) + _WaterPlaneHeight;
    u_xlat5 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat1.x = u_xlat1.x / u_xlat5;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat2.x = u_xlat1.x * _UWFogColorHLIntensity;
    u_xlat5 = (-_UWHeightFogDensity) * u_xlat1.x + 1.0;
    u_xlat5 = u_xlat5 * _UWHeightFogEffectLimit;
    u_xlat5 = max(u_xlat5, _UWHeightFogEffectStart);
    u_xlat5 = min(u_xlat5, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.99000001<vs_TEXCOORD3.y);
#else
    u_xlatb9 = 0.99000001<vs_TEXCOORD3.y;
#endif
    u_xlat1.x = (-u_xlat1.x) * _UWHeightRatio + 1.0;
    u_xlat1.x = u_xlat1.x * vs_TEXCOORD3.y;
    u_xlat1.x = max(u_xlat1.x, _UWCriticalRange);
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat16_15 = (u_xlatb9) ? u_xlat1.x : vs_TEXCOORD3.y;
    u_xlat16_15 = (-u_xlat16_15) + 1.0;
    u_xlat1.xzw = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat1.xzw = vs_TEXCOORD3.xxx * u_xlat1.xzw + _UWFogColorFar.xyz;
    u_xlat6.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + (-u_xlat1.xzw);
    u_xlat1.xzw = vec3(u_xlat16_15) * u_xlat6.xyz + u_xlat1.xzw;
    u_xlat6.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat6.xyz + _UWFogColorLow.xyz;
    u_xlat1.xzw = u_xlat1.xzw + (-u_xlat2.xyz);
    u_xlat1.xyz = vec3(u_xlat5) * u_xlat1.xzw + u_xlat2.xyz;
    SV_Target0.xyz = (bool(u_xlatb12)) ? u_xlat1.xyz : u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
vec2 u_xlat16;
float u_xlat20;
float u_xlat22;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat2.x = u_xlat0.w * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat2.x) + 2.0;
    u_xlat16_3 = u_xlat2.x * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
    u_xlat20 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat20 = sqrt(u_xlat20);
    u_xlat22 = u_xlat20 + (-_HeigtFogRamp.w);
    u_xlat22 = u_xlat22 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat4.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat20>=u_xlat4.x);
#else
    u_xlatb4 = u_xlat20>=u_xlat4.x;
#endif
    u_xlat10 = u_xlat20 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat16.x = (-u_xlat10) + 2.0;
    u_xlat10 = u_xlat16.x * u_xlat10;
    u_xlat16.x = u_xlat10 * _HeigtFogColDelta.w;
    u_xlat4.x = (u_xlatb4) ? u_xlat16.x : u_xlat10;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _Mihoyo_FogColor.w;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, _HeigtFogColBase.w);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat10 = u_xlat5.y * _HeigtFogParams.x;
    u_xlat16.x = dot(u_xlat5.xz, u_xlat5.xz);
    u_xlat16.x = sqrt(u_xlat16.x);
    u_xlat16.x = u_xlat16.x + (-_UWFogDistStart);
    u_xlat16.x = max(u_xlat16.x, 0.0);
    u_xlat16.xy = u_xlat16.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat16.xy = u_xlat16.xy * (-u_xlat16.xy);
    u_xlat16.xy = u_xlat16.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat16.xy);
    u_xlat16.x = u_xlat10 * -1.44269502;
    u_xlat4.z = exp2(u_xlat16.x);
    u_xlat4.xz = (-u_xlat4.xz) + vec2(1.0, 1.0);
    u_xlat16.x = u_xlat4.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_3 = (u_xlatb10) ? u_xlat16.x : 1.0;
    u_xlat10 = u_xlat20 * _HeigtFogParams.y;
    u_xlat20 = u_xlat20 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat16_3 * u_xlat10;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_9 = (-u_xlat20) + 2.0;
    u_xlat16_9 = u_xlat20 * u_xlat16_9;
    u_xlat20 = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat20 = u_xlat20 + 1.0;
    u_xlat16_3 = u_xlat20 * u_xlat16_3;
    u_xlat20 = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat10 = (-u_xlat20) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat10);
    u_xlat3.w = u_xlat10 * u_xlat4.x;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat20) + u_xlat2.xyz;
    vs_COLOR1 = u_xlat3;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD3.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
bool u_xlatb9;
lowp float u_xlat10_12;
bool u_xlatb12;
mediump float u_xlat16_15;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb12 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb12){
        u_xlat2.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_12 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_3.x = u_xlat10_12;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-_ShadowIntegration) * u_xlat16_3.x + 1.0;
    u_xlat16_7.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD3.z<_WaterPlaneHeight);
#else
    u_xlatb12 = vs_TEXCOORD3.z<_WaterPlaneHeight;
#endif
    u_xlat1.x = (-vs_TEXCOORD3.z) + _WaterPlaneHeight;
    u_xlat5 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat1.x = u_xlat1.x / u_xlat5;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat2.x = u_xlat1.x * _UWFogColorHLIntensity;
    u_xlat5 = (-_UWHeightFogDensity) * u_xlat1.x + 1.0;
    u_xlat5 = u_xlat5 * _UWHeightFogEffectLimit;
    u_xlat5 = max(u_xlat5, _UWHeightFogEffectStart);
    u_xlat5 = min(u_xlat5, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.99000001<vs_TEXCOORD3.y);
#else
    u_xlatb9 = 0.99000001<vs_TEXCOORD3.y;
#endif
    u_xlat1.x = (-u_xlat1.x) * _UWHeightRatio + 1.0;
    u_xlat1.x = u_xlat1.x * vs_TEXCOORD3.y;
    u_xlat1.x = max(u_xlat1.x, _UWCriticalRange);
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat16_15 = (u_xlatb9) ? u_xlat1.x : vs_TEXCOORD3.y;
    u_xlat16_15 = (-u_xlat16_15) + 1.0;
    u_xlat1.xzw = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat1.xzw = vs_TEXCOORD3.xxx * u_xlat1.xzw + _UWFogColorFar.xyz;
    u_xlat6.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + (-u_xlat1.xzw);
    u_xlat1.xzw = vec3(u_xlat16_15) * u_xlat6.xyz + u_xlat1.xzw;
    u_xlat6.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat6.xyz + _UWFogColorLow.xyz;
    u_xlat1.xzw = u_xlat1.xzw + (-u_xlat2.xyz);
    u_xlat1.xyz = vec3(u_xlat5) * u_xlat1.xzw + u_xlat2.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb12)) ? u_xlat1.xyz : u_xlat0.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
vec2 u_xlat16;
float u_xlat20;
float u_xlat22;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat2.x = u_xlat0.w * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat2.x) + 2.0;
    u_xlat16_3 = u_xlat2.x * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
    u_xlat20 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat20 = sqrt(u_xlat20);
    u_xlat22 = u_xlat20 + (-_HeigtFogRamp.w);
    u_xlat22 = u_xlat22 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat4.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat20>=u_xlat4.x);
#else
    u_xlatb4 = u_xlat20>=u_xlat4.x;
#endif
    u_xlat10 = u_xlat20 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat16.x = (-u_xlat10) + 2.0;
    u_xlat10 = u_xlat16.x * u_xlat10;
    u_xlat16.x = u_xlat10 * _HeigtFogColDelta.w;
    u_xlat4.x = (u_xlatb4) ? u_xlat16.x : u_xlat10;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _Mihoyo_FogColor.w;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, _HeigtFogColBase.w);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat10 = u_xlat5.y * _HeigtFogParams.x;
    u_xlat16.x = dot(u_xlat5.xz, u_xlat5.xz);
    u_xlat16.x = sqrt(u_xlat16.x);
    u_xlat16.x = u_xlat16.x + (-_UWFogDistStart);
    u_xlat16.x = max(u_xlat16.x, 0.0);
    u_xlat16.xy = u_xlat16.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat16.xy = u_xlat16.xy * (-u_xlat16.xy);
    u_xlat16.xy = u_xlat16.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat16.xy);
    u_xlat16.x = u_xlat10 * -1.44269502;
    u_xlat4.z = exp2(u_xlat16.x);
    u_xlat4.xz = (-u_xlat4.xz) + vec2(1.0, 1.0);
    u_xlat16.x = u_xlat4.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_3 = (u_xlatb10) ? u_xlat16.x : 1.0;
    u_xlat10 = u_xlat20 * _HeigtFogParams.y;
    u_xlat20 = u_xlat20 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat16_3 * u_xlat10;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_9 = (-u_xlat20) + 2.0;
    u_xlat16_9 = u_xlat20 * u_xlat16_9;
    u_xlat20 = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat20 = u_xlat20 + 1.0;
    u_xlat16_3 = u_xlat20 * u_xlat16_3;
    u_xlat20 = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat10 = (-u_xlat20) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat10);
    u_xlat3.w = u_xlat10 * u_xlat4.x;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat20) + u_xlat2.xyz;
    vs_COLOR1 = u_xlat3;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD3.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
bool u_xlatb9;
lowp float u_xlat10_12;
bool u_xlatb12;
mediump float u_xlat16_15;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb12 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb12){
        u_xlat2.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_12 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_3.x = u_xlat10_12;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-_ShadowIntegration) * u_xlat16_3.x + 1.0;
    u_xlat16_7.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD3.z<_WaterPlaneHeight);
#else
    u_xlatb12 = vs_TEXCOORD3.z<_WaterPlaneHeight;
#endif
    u_xlat1.x = (-vs_TEXCOORD3.z) + _WaterPlaneHeight;
    u_xlat5 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat1.x = u_xlat1.x / u_xlat5;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat2.x = u_xlat1.x * _UWFogColorHLIntensity;
    u_xlat5 = (-_UWHeightFogDensity) * u_xlat1.x + 1.0;
    u_xlat5 = u_xlat5 * _UWHeightFogEffectLimit;
    u_xlat5 = max(u_xlat5, _UWHeightFogEffectStart);
    u_xlat5 = min(u_xlat5, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.99000001<vs_TEXCOORD3.y);
#else
    u_xlatb9 = 0.99000001<vs_TEXCOORD3.y;
#endif
    u_xlat1.x = (-u_xlat1.x) * _UWHeightRatio + 1.0;
    u_xlat1.x = u_xlat1.x * vs_TEXCOORD3.y;
    u_xlat1.x = max(u_xlat1.x, _UWCriticalRange);
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat16_15 = (u_xlatb9) ? u_xlat1.x : vs_TEXCOORD3.y;
    u_xlat16_15 = (-u_xlat16_15) + 1.0;
    u_xlat1.xzw = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat1.xzw = vs_TEXCOORD3.xxx * u_xlat1.xzw + _UWFogColorFar.xyz;
    u_xlat6.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + (-u_xlat1.xzw);
    u_xlat1.xzw = vec3(u_xlat16_15) * u_xlat6.xyz + u_xlat1.xzw;
    u_xlat6.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat6.xyz + _UWFogColorLow.xyz;
    u_xlat1.xzw = u_xlat1.xzw + (-u_xlat2.xyz);
    u_xlat1.xyz = vec3(u_xlat5) * u_xlat1.xzw + u_xlat2.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb12)) ? u_xlat1.xyz : u_xlat0.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
vec2 u_xlat16;
float u_xlat20;
float u_xlat22;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat2.x = u_xlat0.w * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat2.x) + 2.0;
    u_xlat16_3 = u_xlat2.x * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
    u_xlat20 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat20 = sqrt(u_xlat20);
    u_xlat22 = u_xlat20 + (-_HeigtFogRamp.w);
    u_xlat22 = u_xlat22 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat4.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat20>=u_xlat4.x);
#else
    u_xlatb4 = u_xlat20>=u_xlat4.x;
#endif
    u_xlat10 = u_xlat20 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat16.x = (-u_xlat10) + 2.0;
    u_xlat10 = u_xlat16.x * u_xlat10;
    u_xlat16.x = u_xlat10 * _HeigtFogColDelta.w;
    u_xlat4.x = (u_xlatb4) ? u_xlat16.x : u_xlat10;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _Mihoyo_FogColor.w;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, _HeigtFogColBase.w);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat10 = u_xlat5.y * _HeigtFogParams.x;
    u_xlat16.x = dot(u_xlat5.xz, u_xlat5.xz);
    u_xlat16.x = sqrt(u_xlat16.x);
    u_xlat16.x = u_xlat16.x + (-_UWFogDistStart);
    u_xlat16.x = max(u_xlat16.x, 0.0);
    u_xlat16.xy = u_xlat16.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat16.xy = u_xlat16.xy * (-u_xlat16.xy);
    u_xlat16.xy = u_xlat16.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat16.xy);
    u_xlat16.x = u_xlat10 * -1.44269502;
    u_xlat4.z = exp2(u_xlat16.x);
    u_xlat4.xz = (-u_xlat4.xz) + vec2(1.0, 1.0);
    u_xlat16.x = u_xlat4.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_3 = (u_xlatb10) ? u_xlat16.x : 1.0;
    u_xlat10 = u_xlat20 * _HeigtFogParams.y;
    u_xlat20 = u_xlat20 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat16_3 * u_xlat10;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_9 = (-u_xlat20) + 2.0;
    u_xlat16_9 = u_xlat20 * u_xlat16_9;
    u_xlat20 = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat20 = u_xlat20 + 1.0;
    u_xlat16_3 = u_xlat20 * u_xlat16_3;
    u_xlat20 = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat10 = (-u_xlat20) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat10);
    u_xlat3.w = u_xlat10 * u_xlat4.x;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat20) + u_xlat2.xyz;
    vs_COLOR1 = u_xlat3;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD3.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
bool u_xlatb9;
lowp float u_xlat10_12;
bool u_xlatb12;
mediump float u_xlat16_15;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb12 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb12){
        u_xlat2.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_12 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_3.x = u_xlat10_12;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-_ShadowIntegration) * u_xlat16_3.x + 1.0;
    u_xlat16_7.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD3.z<_WaterPlaneHeight);
#else
    u_xlatb12 = vs_TEXCOORD3.z<_WaterPlaneHeight;
#endif
    u_xlat1.x = (-vs_TEXCOORD3.z) + _WaterPlaneHeight;
    u_xlat5 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat1.x = u_xlat1.x / u_xlat5;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat2.x = u_xlat1.x * _UWFogColorHLIntensity;
    u_xlat5 = (-_UWHeightFogDensity) * u_xlat1.x + 1.0;
    u_xlat5 = u_xlat5 * _UWHeightFogEffectLimit;
    u_xlat5 = max(u_xlat5, _UWHeightFogEffectStart);
    u_xlat5 = min(u_xlat5, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.99000001<vs_TEXCOORD3.y);
#else
    u_xlatb9 = 0.99000001<vs_TEXCOORD3.y;
#endif
    u_xlat1.x = (-u_xlat1.x) * _UWHeightRatio + 1.0;
    u_xlat1.x = u_xlat1.x * vs_TEXCOORD3.y;
    u_xlat1.x = max(u_xlat1.x, _UWCriticalRange);
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat16_15 = (u_xlatb9) ? u_xlat1.x : vs_TEXCOORD3.y;
    u_xlat16_15 = (-u_xlat16_15) + 1.0;
    u_xlat1.xzw = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat1.xzw = vs_TEXCOORD3.xxx * u_xlat1.xzw + _UWFogColorFar.xyz;
    u_xlat6.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + (-u_xlat1.xzw);
    u_xlat1.xzw = vec3(u_xlat16_15) * u_xlat6.xyz + u_xlat1.xzw;
    u_xlat6.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat6.xyz + _UWFogColorLow.xyz;
    u_xlat1.xzw = u_xlat1.xzw + (-u_xlat2.xyz);
    u_xlat1.xyz = vec3(u_xlat5) * u_xlat1.xzw + u_xlat2.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb12)) ? u_xlat1.xyz : u_xlat0.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
mediump float u_xlat16_10;
float u_xlat11;
bool u_xlatb11;
mediump float u_xlat16_13;
vec2 u_xlat18;
bool u_xlatb18;
float u_xlat23;
float u_xlat25;
float u_xlat26;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat2.x = u_xlat0.w * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat2.x) + 2.0;
    u_xlat16_3 = u_xlat2.x * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat5.xyz = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
    u_xlat23 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat23 = sqrt(u_xlat23);
    u_xlat25 = u_xlat23 + (-_HeigtFogRamp3.w);
    u_xlat25 = u_xlat25 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat25) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat4.x = u_xlat23 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat4.x) + 2.0;
    u_xlat4.x = u_xlat11 * u_xlat4.x;
    u_xlat11 = u_xlat4.x * _HeigtFogColDelta3.w;
    u_xlat18.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat23>=u_xlat18.x);
#else
    u_xlatb18 = u_xlat23>=u_xlat18.x;
#endif
    u_xlat4.x = (u_xlatb18) ? u_xlat11 : u_xlat4.x;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _Mihoyo_FogColor3.w;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, _HeigtFogColBase3.w);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat11 = u_xlat5.y * _HeigtFogParams3.x;
    u_xlat25 = u_xlat11 * -1.44269502;
    u_xlat4.w = exp2(u_xlat25);
    u_xlat4.xw = (-u_xlat4.xw) + vec2(1.0, 1.0);
    u_xlat25 = u_xlat4.w / u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat16_3 = (u_xlatb11) ? u_xlat25 : 1.0;
    u_xlat11 = u_xlat23 * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16_3 * u_xlat11;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat11 = u_xlat23 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat11) + 2.0;
    u_xlat16_10 = u_xlat16_10 * u_xlat11;
    u_xlat11 = u_xlat16_10 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat11 = u_xlat11 + 1.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat11;
    u_xlat11 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat25 = (-u_xlat11) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat25);
    u_xlat3.w = u_xlat25 * u_xlat4.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat11) + u_xlat2.xyz;
    u_xlat2.x = u_xlat0.w * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat2.x) + 2.0;
    u_xlat16_6 = u_xlat2.x * u_xlat16_6;
    u_xlat2.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat4.xyw = (-u_xlat2.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat26 = u_xlat23 + (-_HeigtFogRamp2.w);
    u_xlat26 = u_xlat26 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat26) * u_xlat4.xyw + u_xlat2.xyz;
    u_xlat4.x = u_xlat23 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat4.x) + 2.0;
    u_xlat4.x = u_xlat11 * u_xlat4.x;
    u_xlat11 = u_xlat4.x * _HeigtFogColDelta2.w;
    u_xlat4.x = (u_xlatb18) ? u_xlat11 : u_xlat4.x;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _Mihoyo_FogColor2.w;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, _HeigtFogColBase2.w);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat11 = u_xlat5.y * _HeigtFogParams2.x;
    u_xlat18.x = dot(u_xlat5.xz, u_xlat5.xz);
    u_xlat18.x = sqrt(u_xlat18.x);
    u_xlat18.x = u_xlat18.x + (-_UWFogDistStart);
    u_xlat18.x = max(u_xlat18.x, 0.0);
    u_xlat18.xy = u_xlat18.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat18.xy = u_xlat18.xy * (-u_xlat18.xy);
    u_xlat18.xy = u_xlat18.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat18.xy);
    u_xlat18.x = u_xlat11 * -1.44269502;
    u_xlat4.z = exp2(u_xlat18.x);
    u_xlat4.xz = (-u_xlat4.xz) + vec2(1.0, 1.0);
    u_xlat18.x = u_xlat4.z / u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat16_6 = (u_xlatb11) ? u_xlat18.x : 1.0;
    u_xlat11 = u_xlat23 * _HeigtFogParams2.y;
    u_xlat23 = u_xlat23 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat11 * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat23) + 2.0;
    u_xlat16_13 = u_xlat23 * u_xlat16_13;
    u_xlat23 = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat23 = u_xlat23 + 1.0;
    u_xlat16_6 = u_xlat23 * u_xlat16_6;
    u_xlat23 = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat11 = (-u_xlat23) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat11);
    u_xlat4.w = u_xlat11 * u_xlat4.x;
    u_xlat4.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat23) + u_xlat2.xyz;
    u_xlat2 = u_xlat3 + (-u_xlat4);
    u_xlat2 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat2 + u_xlat4;
    vs_COLOR1 = u_xlat2;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD3.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _ShadowIntegration;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
bool u_xlatb9;
lowp float u_xlat10_12;
bool u_xlatb12;
mediump float u_xlat16_15;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb12 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb12){
        u_xlat2.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_12 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_3.x = u_xlat10_12;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-_ShadowIntegration) * u_xlat16_3.x + 1.0;
    u_xlat16_7.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD3.z<_WaterPlaneHeight);
#else
    u_xlatb12 = vs_TEXCOORD3.z<_WaterPlaneHeight;
#endif
    u_xlat1.x = (-vs_TEXCOORD3.z) + _WaterPlaneHeight;
    u_xlat5 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat1.x = u_xlat1.x / u_xlat5;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat2.x = u_xlat1.x * _UWFogColorHLIntensity;
    u_xlat5 = (-_UWHeightFogDensity) * u_xlat1.x + 1.0;
    u_xlat5 = u_xlat5 * _UWHeightFogEffectLimit;
    u_xlat5 = max(u_xlat5, _UWHeightFogEffectStart);
    u_xlat5 = min(u_xlat5, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.99000001<vs_TEXCOORD3.y);
#else
    u_xlatb9 = 0.99000001<vs_TEXCOORD3.y;
#endif
    u_xlat1.x = (-u_xlat1.x) * _UWHeightRatio + 1.0;
    u_xlat1.x = u_xlat1.x * vs_TEXCOORD3.y;
    u_xlat1.x = max(u_xlat1.x, _UWCriticalRange);
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat16_15 = (u_xlatb9) ? u_xlat1.x : vs_TEXCOORD3.y;
    u_xlat16_15 = (-u_xlat16_15) + 1.0;
    u_xlat1.xzw = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat1.xzw = vs_TEXCOORD3.xxx * u_xlat1.xzw + _UWFogColorFar.xyz;
    u_xlat6.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + (-u_xlat1.xzw);
    u_xlat1.xzw = vec3(u_xlat16_15) * u_xlat6.xyz + u_xlat1.xzw;
    u_xlat6.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat6.xyz + _UWFogColorLow.xyz;
    u_xlat1.xzw = u_xlat1.xzw + (-u_xlat2.xyz);
    u_xlat1.xyz = vec3(u_xlat5) * u_xlat1.xzw + u_xlat2.xyz;
    SV_Target0.xyz = (bool(u_xlatb12)) ? u_xlat1.xyz : u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
mediump float u_xlat16_10;
float u_xlat11;
bool u_xlatb11;
mediump float u_xlat16_13;
vec2 u_xlat18;
bool u_xlatb18;
float u_xlat23;
float u_xlat25;
float u_xlat26;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat2.x = u_xlat0.w * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat2.x) + 2.0;
    u_xlat16_3 = u_xlat2.x * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat5.xyz = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
    u_xlat23 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat23 = sqrt(u_xlat23);
    u_xlat25 = u_xlat23 + (-_HeigtFogRamp3.w);
    u_xlat25 = u_xlat25 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat25) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat4.x = u_xlat23 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat4.x) + 2.0;
    u_xlat4.x = u_xlat11 * u_xlat4.x;
    u_xlat11 = u_xlat4.x * _HeigtFogColDelta3.w;
    u_xlat18.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat23>=u_xlat18.x);
#else
    u_xlatb18 = u_xlat23>=u_xlat18.x;
#endif
    u_xlat4.x = (u_xlatb18) ? u_xlat11 : u_xlat4.x;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _Mihoyo_FogColor3.w;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, _HeigtFogColBase3.w);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat11 = u_xlat5.y * _HeigtFogParams3.x;
    u_xlat25 = u_xlat11 * -1.44269502;
    u_xlat4.w = exp2(u_xlat25);
    u_xlat4.xw = (-u_xlat4.xw) + vec2(1.0, 1.0);
    u_xlat25 = u_xlat4.w / u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat16_3 = (u_xlatb11) ? u_xlat25 : 1.0;
    u_xlat11 = u_xlat23 * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16_3 * u_xlat11;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat11 = u_xlat23 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat11) + 2.0;
    u_xlat16_10 = u_xlat16_10 * u_xlat11;
    u_xlat11 = u_xlat16_10 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat11 = u_xlat11 + 1.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat11;
    u_xlat11 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat25 = (-u_xlat11) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat25);
    u_xlat3.w = u_xlat25 * u_xlat4.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat11) + u_xlat2.xyz;
    u_xlat2.x = u_xlat0.w * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat2.x) + 2.0;
    u_xlat16_6 = u_xlat2.x * u_xlat16_6;
    u_xlat2.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat4.xyw = (-u_xlat2.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat26 = u_xlat23 + (-_HeigtFogRamp2.w);
    u_xlat26 = u_xlat26 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat26) * u_xlat4.xyw + u_xlat2.xyz;
    u_xlat4.x = u_xlat23 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat4.x) + 2.0;
    u_xlat4.x = u_xlat11 * u_xlat4.x;
    u_xlat11 = u_xlat4.x * _HeigtFogColDelta2.w;
    u_xlat4.x = (u_xlatb18) ? u_xlat11 : u_xlat4.x;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _Mihoyo_FogColor2.w;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, _HeigtFogColBase2.w);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat11 = u_xlat5.y * _HeigtFogParams2.x;
    u_xlat18.x = dot(u_xlat5.xz, u_xlat5.xz);
    u_xlat18.x = sqrt(u_xlat18.x);
    u_xlat18.x = u_xlat18.x + (-_UWFogDistStart);
    u_xlat18.x = max(u_xlat18.x, 0.0);
    u_xlat18.xy = u_xlat18.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat18.xy = u_xlat18.xy * (-u_xlat18.xy);
    u_xlat18.xy = u_xlat18.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat18.xy);
    u_xlat18.x = u_xlat11 * -1.44269502;
    u_xlat4.z = exp2(u_xlat18.x);
    u_xlat4.xz = (-u_xlat4.xz) + vec2(1.0, 1.0);
    u_xlat18.x = u_xlat4.z / u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat16_6 = (u_xlatb11) ? u_xlat18.x : 1.0;
    u_xlat11 = u_xlat23 * _HeigtFogParams2.y;
    u_xlat23 = u_xlat23 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat11 * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat23) + 2.0;
    u_xlat16_13 = u_xlat23 * u_xlat16_13;
    u_xlat23 = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat23 = u_xlat23 + 1.0;
    u_xlat16_6 = u_xlat23 * u_xlat16_6;
    u_xlat23 = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat11 = (-u_xlat23) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat11);
    u_xlat4.w = u_xlat11 * u_xlat4.x;
    u_xlat4.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat23) + u_xlat2.xyz;
    u_xlat2 = u_xlat3 + (-u_xlat4);
    u_xlat2 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat2 + u_xlat4;
    vs_COLOR1 = u_xlat2;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD3.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _ShadowIntegration;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
bool u_xlatb9;
lowp float u_xlat10_12;
bool u_xlatb12;
mediump float u_xlat16_15;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb12 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb12){
        u_xlat2.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_12 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_3.x = u_xlat10_12;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-_ShadowIntegration) * u_xlat16_3.x + 1.0;
    u_xlat16_7.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD3.z<_WaterPlaneHeight);
#else
    u_xlatb12 = vs_TEXCOORD3.z<_WaterPlaneHeight;
#endif
    u_xlat1.x = (-vs_TEXCOORD3.z) + _WaterPlaneHeight;
    u_xlat5 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat1.x = u_xlat1.x / u_xlat5;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat2.x = u_xlat1.x * _UWFogColorHLIntensity;
    u_xlat5 = (-_UWHeightFogDensity) * u_xlat1.x + 1.0;
    u_xlat5 = u_xlat5 * _UWHeightFogEffectLimit;
    u_xlat5 = max(u_xlat5, _UWHeightFogEffectStart);
    u_xlat5 = min(u_xlat5, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.99000001<vs_TEXCOORD3.y);
#else
    u_xlatb9 = 0.99000001<vs_TEXCOORD3.y;
#endif
    u_xlat1.x = (-u_xlat1.x) * _UWHeightRatio + 1.0;
    u_xlat1.x = u_xlat1.x * vs_TEXCOORD3.y;
    u_xlat1.x = max(u_xlat1.x, _UWCriticalRange);
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat16_15 = (u_xlatb9) ? u_xlat1.x : vs_TEXCOORD3.y;
    u_xlat16_15 = (-u_xlat16_15) + 1.0;
    u_xlat1.xzw = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat1.xzw = vs_TEXCOORD3.xxx * u_xlat1.xzw + _UWFogColorFar.xyz;
    u_xlat6.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + (-u_xlat1.xzw);
    u_xlat1.xzw = vec3(u_xlat16_15) * u_xlat6.xyz + u_xlat1.xzw;
    u_xlat6.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat6.xyz + _UWFogColorLow.xyz;
    u_xlat1.xzw = u_xlat1.xzw + (-u_xlat2.xyz);
    u_xlat1.xyz = vec3(u_xlat5) * u_xlat1.xzw + u_xlat2.xyz;
    SV_Target0.xyz = (bool(u_xlatb12)) ? u_xlat1.xyz : u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
mediump float u_xlat16_10;
float u_xlat11;
bool u_xlatb11;
mediump float u_xlat16_13;
vec2 u_xlat18;
bool u_xlatb18;
float u_xlat23;
float u_xlat25;
float u_xlat26;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat2.x = u_xlat0.w * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat2.x) + 2.0;
    u_xlat16_3 = u_xlat2.x * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat5.xyz = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
    u_xlat23 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat23 = sqrt(u_xlat23);
    u_xlat25 = u_xlat23 + (-_HeigtFogRamp3.w);
    u_xlat25 = u_xlat25 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat25) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat4.x = u_xlat23 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat4.x) + 2.0;
    u_xlat4.x = u_xlat11 * u_xlat4.x;
    u_xlat11 = u_xlat4.x * _HeigtFogColDelta3.w;
    u_xlat18.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat23>=u_xlat18.x);
#else
    u_xlatb18 = u_xlat23>=u_xlat18.x;
#endif
    u_xlat4.x = (u_xlatb18) ? u_xlat11 : u_xlat4.x;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _Mihoyo_FogColor3.w;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, _HeigtFogColBase3.w);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat11 = u_xlat5.y * _HeigtFogParams3.x;
    u_xlat25 = u_xlat11 * -1.44269502;
    u_xlat4.w = exp2(u_xlat25);
    u_xlat4.xw = (-u_xlat4.xw) + vec2(1.0, 1.0);
    u_xlat25 = u_xlat4.w / u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat16_3 = (u_xlatb11) ? u_xlat25 : 1.0;
    u_xlat11 = u_xlat23 * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16_3 * u_xlat11;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat11 = u_xlat23 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat11) + 2.0;
    u_xlat16_10 = u_xlat16_10 * u_xlat11;
    u_xlat11 = u_xlat16_10 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat11 = u_xlat11 + 1.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat11;
    u_xlat11 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat25 = (-u_xlat11) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat25);
    u_xlat3.w = u_xlat25 * u_xlat4.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat11) + u_xlat2.xyz;
    u_xlat2.x = u_xlat0.w * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat2.x) + 2.0;
    u_xlat16_6 = u_xlat2.x * u_xlat16_6;
    u_xlat2.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat4.xyw = (-u_xlat2.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat26 = u_xlat23 + (-_HeigtFogRamp2.w);
    u_xlat26 = u_xlat26 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat26) * u_xlat4.xyw + u_xlat2.xyz;
    u_xlat4.x = u_xlat23 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat4.x) + 2.0;
    u_xlat4.x = u_xlat11 * u_xlat4.x;
    u_xlat11 = u_xlat4.x * _HeigtFogColDelta2.w;
    u_xlat4.x = (u_xlatb18) ? u_xlat11 : u_xlat4.x;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _Mihoyo_FogColor2.w;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, _HeigtFogColBase2.w);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat11 = u_xlat5.y * _HeigtFogParams2.x;
    u_xlat18.x = dot(u_xlat5.xz, u_xlat5.xz);
    u_xlat18.x = sqrt(u_xlat18.x);
    u_xlat18.x = u_xlat18.x + (-_UWFogDistStart);
    u_xlat18.x = max(u_xlat18.x, 0.0);
    u_xlat18.xy = u_xlat18.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat18.xy = u_xlat18.xy * (-u_xlat18.xy);
    u_xlat18.xy = u_xlat18.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat18.xy);
    u_xlat18.x = u_xlat11 * -1.44269502;
    u_xlat4.z = exp2(u_xlat18.x);
    u_xlat4.xz = (-u_xlat4.xz) + vec2(1.0, 1.0);
    u_xlat18.x = u_xlat4.z / u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat16_6 = (u_xlatb11) ? u_xlat18.x : 1.0;
    u_xlat11 = u_xlat23 * _HeigtFogParams2.y;
    u_xlat23 = u_xlat23 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat11 * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat23) + 2.0;
    u_xlat16_13 = u_xlat23 * u_xlat16_13;
    u_xlat23 = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat23 = u_xlat23 + 1.0;
    u_xlat16_6 = u_xlat23 * u_xlat16_6;
    u_xlat23 = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat11 = (-u_xlat23) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat11);
    u_xlat4.w = u_xlat11 * u_xlat4.x;
    u_xlat4.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat23) + u_xlat2.xyz;
    u_xlat2 = u_xlat3 + (-u_xlat4);
    u_xlat2 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat2 + u_xlat4;
    vs_COLOR1 = u_xlat2;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD3.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _ShadowIntegration;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
bool u_xlatb9;
lowp float u_xlat10_12;
bool u_xlatb12;
mediump float u_xlat16_15;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb12 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb12){
        u_xlat2.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_12 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_3.x = u_xlat10_12;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-_ShadowIntegration) * u_xlat16_3.x + 1.0;
    u_xlat16_7.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD3.z<_WaterPlaneHeight);
#else
    u_xlatb12 = vs_TEXCOORD3.z<_WaterPlaneHeight;
#endif
    u_xlat1.x = (-vs_TEXCOORD3.z) + _WaterPlaneHeight;
    u_xlat5 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat1.x = u_xlat1.x / u_xlat5;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat2.x = u_xlat1.x * _UWFogColorHLIntensity;
    u_xlat5 = (-_UWHeightFogDensity) * u_xlat1.x + 1.0;
    u_xlat5 = u_xlat5 * _UWHeightFogEffectLimit;
    u_xlat5 = max(u_xlat5, _UWHeightFogEffectStart);
    u_xlat5 = min(u_xlat5, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.99000001<vs_TEXCOORD3.y);
#else
    u_xlatb9 = 0.99000001<vs_TEXCOORD3.y;
#endif
    u_xlat1.x = (-u_xlat1.x) * _UWHeightRatio + 1.0;
    u_xlat1.x = u_xlat1.x * vs_TEXCOORD3.y;
    u_xlat1.x = max(u_xlat1.x, _UWCriticalRange);
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat16_15 = (u_xlatb9) ? u_xlat1.x : vs_TEXCOORD3.y;
    u_xlat16_15 = (-u_xlat16_15) + 1.0;
    u_xlat1.xzw = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat1.xzw = vs_TEXCOORD3.xxx * u_xlat1.xzw + _UWFogColorFar.xyz;
    u_xlat6.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + (-u_xlat1.xzw);
    u_xlat1.xzw = vec3(u_xlat16_15) * u_xlat6.xyz + u_xlat1.xzw;
    u_xlat6.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat6.xyz + _UWFogColorLow.xyz;
    u_xlat1.xzw = u_xlat1.xzw + (-u_xlat2.xyz);
    u_xlat1.xyz = vec3(u_xlat5) * u_xlat1.xzw + u_xlat2.xyz;
    SV_Target0.xyz = (bool(u_xlatb12)) ? u_xlat1.xyz : u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
mediump float u_xlat16_10;
float u_xlat11;
bool u_xlatb11;
mediump float u_xlat16_13;
vec2 u_xlat18;
bool u_xlatb18;
float u_xlat23;
float u_xlat25;
float u_xlat26;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat2.x = u_xlat0.w * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat2.x) + 2.0;
    u_xlat16_3 = u_xlat2.x * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat5.xyz = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
    u_xlat23 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat23 = sqrt(u_xlat23);
    u_xlat25 = u_xlat23 + (-_HeigtFogRamp3.w);
    u_xlat25 = u_xlat25 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat25) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat4.x = u_xlat23 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat4.x) + 2.0;
    u_xlat4.x = u_xlat11 * u_xlat4.x;
    u_xlat11 = u_xlat4.x * _HeigtFogColDelta3.w;
    u_xlat18.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat23>=u_xlat18.x);
#else
    u_xlatb18 = u_xlat23>=u_xlat18.x;
#endif
    u_xlat4.x = (u_xlatb18) ? u_xlat11 : u_xlat4.x;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _Mihoyo_FogColor3.w;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, _HeigtFogColBase3.w);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat11 = u_xlat5.y * _HeigtFogParams3.x;
    u_xlat25 = u_xlat11 * -1.44269502;
    u_xlat4.w = exp2(u_xlat25);
    u_xlat4.xw = (-u_xlat4.xw) + vec2(1.0, 1.0);
    u_xlat25 = u_xlat4.w / u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat16_3 = (u_xlatb11) ? u_xlat25 : 1.0;
    u_xlat11 = u_xlat23 * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16_3 * u_xlat11;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat11 = u_xlat23 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat11) + 2.0;
    u_xlat16_10 = u_xlat16_10 * u_xlat11;
    u_xlat11 = u_xlat16_10 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat11 = u_xlat11 + 1.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat11;
    u_xlat11 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat25 = (-u_xlat11) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat25);
    u_xlat3.w = u_xlat25 * u_xlat4.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat11) + u_xlat2.xyz;
    u_xlat2.x = u_xlat0.w * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat2.x) + 2.0;
    u_xlat16_6 = u_xlat2.x * u_xlat16_6;
    u_xlat2.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat4.xyw = (-u_xlat2.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat26 = u_xlat23 + (-_HeigtFogRamp2.w);
    u_xlat26 = u_xlat26 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat26) * u_xlat4.xyw + u_xlat2.xyz;
    u_xlat4.x = u_xlat23 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat4.x) + 2.0;
    u_xlat4.x = u_xlat11 * u_xlat4.x;
    u_xlat11 = u_xlat4.x * _HeigtFogColDelta2.w;
    u_xlat4.x = (u_xlatb18) ? u_xlat11 : u_xlat4.x;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _Mihoyo_FogColor2.w;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, _HeigtFogColBase2.w);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat11 = u_xlat5.y * _HeigtFogParams2.x;
    u_xlat18.x = dot(u_xlat5.xz, u_xlat5.xz);
    u_xlat18.x = sqrt(u_xlat18.x);
    u_xlat18.x = u_xlat18.x + (-_UWFogDistStart);
    u_xlat18.x = max(u_xlat18.x, 0.0);
    u_xlat18.xy = u_xlat18.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat18.xy = u_xlat18.xy * (-u_xlat18.xy);
    u_xlat18.xy = u_xlat18.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat18.xy);
    u_xlat18.x = u_xlat11 * -1.44269502;
    u_xlat4.z = exp2(u_xlat18.x);
    u_xlat4.xz = (-u_xlat4.xz) + vec2(1.0, 1.0);
    u_xlat18.x = u_xlat4.z / u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat16_6 = (u_xlatb11) ? u_xlat18.x : 1.0;
    u_xlat11 = u_xlat23 * _HeigtFogParams2.y;
    u_xlat23 = u_xlat23 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat11 * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat23) + 2.0;
    u_xlat16_13 = u_xlat23 * u_xlat16_13;
    u_xlat23 = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat23 = u_xlat23 + 1.0;
    u_xlat16_6 = u_xlat23 * u_xlat16_6;
    u_xlat23 = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat11 = (-u_xlat23) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat11);
    u_xlat4.w = u_xlat11 * u_xlat4.x;
    u_xlat4.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat23) + u_xlat2.xyz;
    u_xlat2 = u_xlat3 + (-u_xlat4);
    u_xlat2 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat2 + u_xlat4;
    vs_COLOR1 = u_xlat2;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD3.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
bool u_xlatb9;
lowp float u_xlat10_12;
bool u_xlatb12;
mediump float u_xlat16_15;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb12 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb12){
        u_xlat2.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_12 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_3.x = u_xlat10_12;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-_ShadowIntegration) * u_xlat16_3.x + 1.0;
    u_xlat16_7.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD3.z<_WaterPlaneHeight);
#else
    u_xlatb12 = vs_TEXCOORD3.z<_WaterPlaneHeight;
#endif
    u_xlat1.x = (-vs_TEXCOORD3.z) + _WaterPlaneHeight;
    u_xlat5 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat1.x = u_xlat1.x / u_xlat5;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat2.x = u_xlat1.x * _UWFogColorHLIntensity;
    u_xlat5 = (-_UWHeightFogDensity) * u_xlat1.x + 1.0;
    u_xlat5 = u_xlat5 * _UWHeightFogEffectLimit;
    u_xlat5 = max(u_xlat5, _UWHeightFogEffectStart);
    u_xlat5 = min(u_xlat5, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.99000001<vs_TEXCOORD3.y);
#else
    u_xlatb9 = 0.99000001<vs_TEXCOORD3.y;
#endif
    u_xlat1.x = (-u_xlat1.x) * _UWHeightRatio + 1.0;
    u_xlat1.x = u_xlat1.x * vs_TEXCOORD3.y;
    u_xlat1.x = max(u_xlat1.x, _UWCriticalRange);
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat16_15 = (u_xlatb9) ? u_xlat1.x : vs_TEXCOORD3.y;
    u_xlat16_15 = (-u_xlat16_15) + 1.0;
    u_xlat1.xzw = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat1.xzw = vs_TEXCOORD3.xxx * u_xlat1.xzw + _UWFogColorFar.xyz;
    u_xlat6.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + (-u_xlat1.xzw);
    u_xlat1.xzw = vec3(u_xlat16_15) * u_xlat6.xyz + u_xlat1.xzw;
    u_xlat6.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat6.xyz + _UWFogColorLow.xyz;
    u_xlat1.xzw = u_xlat1.xzw + (-u_xlat2.xyz);
    u_xlat1.xyz = vec3(u_xlat5) * u_xlat1.xzw + u_xlat2.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb12)) ? u_xlat1.xyz : u_xlat0.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
mediump float u_xlat16_10;
float u_xlat11;
bool u_xlatb11;
mediump float u_xlat16_13;
vec2 u_xlat18;
bool u_xlatb18;
float u_xlat23;
float u_xlat25;
float u_xlat26;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat2.x = u_xlat0.w * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat2.x) + 2.0;
    u_xlat16_3 = u_xlat2.x * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat5.xyz = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
    u_xlat23 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat23 = sqrt(u_xlat23);
    u_xlat25 = u_xlat23 + (-_HeigtFogRamp3.w);
    u_xlat25 = u_xlat25 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat25) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat4.x = u_xlat23 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat4.x) + 2.0;
    u_xlat4.x = u_xlat11 * u_xlat4.x;
    u_xlat11 = u_xlat4.x * _HeigtFogColDelta3.w;
    u_xlat18.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat23>=u_xlat18.x);
#else
    u_xlatb18 = u_xlat23>=u_xlat18.x;
#endif
    u_xlat4.x = (u_xlatb18) ? u_xlat11 : u_xlat4.x;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _Mihoyo_FogColor3.w;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, _HeigtFogColBase3.w);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat11 = u_xlat5.y * _HeigtFogParams3.x;
    u_xlat25 = u_xlat11 * -1.44269502;
    u_xlat4.w = exp2(u_xlat25);
    u_xlat4.xw = (-u_xlat4.xw) + vec2(1.0, 1.0);
    u_xlat25 = u_xlat4.w / u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat16_3 = (u_xlatb11) ? u_xlat25 : 1.0;
    u_xlat11 = u_xlat23 * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16_3 * u_xlat11;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat11 = u_xlat23 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat11) + 2.0;
    u_xlat16_10 = u_xlat16_10 * u_xlat11;
    u_xlat11 = u_xlat16_10 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat11 = u_xlat11 + 1.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat11;
    u_xlat11 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat25 = (-u_xlat11) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat25);
    u_xlat3.w = u_xlat25 * u_xlat4.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat11) + u_xlat2.xyz;
    u_xlat2.x = u_xlat0.w * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat2.x) + 2.0;
    u_xlat16_6 = u_xlat2.x * u_xlat16_6;
    u_xlat2.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat4.xyw = (-u_xlat2.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat26 = u_xlat23 + (-_HeigtFogRamp2.w);
    u_xlat26 = u_xlat26 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat26) * u_xlat4.xyw + u_xlat2.xyz;
    u_xlat4.x = u_xlat23 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat4.x) + 2.0;
    u_xlat4.x = u_xlat11 * u_xlat4.x;
    u_xlat11 = u_xlat4.x * _HeigtFogColDelta2.w;
    u_xlat4.x = (u_xlatb18) ? u_xlat11 : u_xlat4.x;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _Mihoyo_FogColor2.w;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, _HeigtFogColBase2.w);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat11 = u_xlat5.y * _HeigtFogParams2.x;
    u_xlat18.x = dot(u_xlat5.xz, u_xlat5.xz);
    u_xlat18.x = sqrt(u_xlat18.x);
    u_xlat18.x = u_xlat18.x + (-_UWFogDistStart);
    u_xlat18.x = max(u_xlat18.x, 0.0);
    u_xlat18.xy = u_xlat18.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat18.xy = u_xlat18.xy * (-u_xlat18.xy);
    u_xlat18.xy = u_xlat18.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat18.xy);
    u_xlat18.x = u_xlat11 * -1.44269502;
    u_xlat4.z = exp2(u_xlat18.x);
    u_xlat4.xz = (-u_xlat4.xz) + vec2(1.0, 1.0);
    u_xlat18.x = u_xlat4.z / u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat16_6 = (u_xlatb11) ? u_xlat18.x : 1.0;
    u_xlat11 = u_xlat23 * _HeigtFogParams2.y;
    u_xlat23 = u_xlat23 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat11 * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat23) + 2.0;
    u_xlat16_13 = u_xlat23 * u_xlat16_13;
    u_xlat23 = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat23 = u_xlat23 + 1.0;
    u_xlat16_6 = u_xlat23 * u_xlat16_6;
    u_xlat23 = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat11 = (-u_xlat23) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat11);
    u_xlat4.w = u_xlat11 * u_xlat4.x;
    u_xlat4.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat23) + u_xlat2.xyz;
    u_xlat2 = u_xlat3 + (-u_xlat4);
    u_xlat2 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat2 + u_xlat4;
    vs_COLOR1 = u_xlat2;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD3.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
bool u_xlatb9;
lowp float u_xlat10_12;
bool u_xlatb12;
mediump float u_xlat16_15;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb12 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb12){
        u_xlat2.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_12 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_3.x = u_xlat10_12;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-_ShadowIntegration) * u_xlat16_3.x + 1.0;
    u_xlat16_7.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD3.z<_WaterPlaneHeight);
#else
    u_xlatb12 = vs_TEXCOORD3.z<_WaterPlaneHeight;
#endif
    u_xlat1.x = (-vs_TEXCOORD3.z) + _WaterPlaneHeight;
    u_xlat5 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat1.x = u_xlat1.x / u_xlat5;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat2.x = u_xlat1.x * _UWFogColorHLIntensity;
    u_xlat5 = (-_UWHeightFogDensity) * u_xlat1.x + 1.0;
    u_xlat5 = u_xlat5 * _UWHeightFogEffectLimit;
    u_xlat5 = max(u_xlat5, _UWHeightFogEffectStart);
    u_xlat5 = min(u_xlat5, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.99000001<vs_TEXCOORD3.y);
#else
    u_xlatb9 = 0.99000001<vs_TEXCOORD3.y;
#endif
    u_xlat1.x = (-u_xlat1.x) * _UWHeightRatio + 1.0;
    u_xlat1.x = u_xlat1.x * vs_TEXCOORD3.y;
    u_xlat1.x = max(u_xlat1.x, _UWCriticalRange);
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat16_15 = (u_xlatb9) ? u_xlat1.x : vs_TEXCOORD3.y;
    u_xlat16_15 = (-u_xlat16_15) + 1.0;
    u_xlat1.xzw = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat1.xzw = vs_TEXCOORD3.xxx * u_xlat1.xzw + _UWFogColorFar.xyz;
    u_xlat6.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + (-u_xlat1.xzw);
    u_xlat1.xzw = vec3(u_xlat16_15) * u_xlat6.xyz + u_xlat1.xzw;
    u_xlat6.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat6.xyz + _UWFogColorLow.xyz;
    u_xlat1.xzw = u_xlat1.xzw + (-u_xlat2.xyz);
    u_xlat1.xyz = vec3(u_xlat5) * u_xlat1.xzw + u_xlat2.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb12)) ? u_xlat1.xyz : u_xlat0.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
mediump float u_xlat16_10;
float u_xlat11;
bool u_xlatb11;
mediump float u_xlat16_13;
vec2 u_xlat18;
bool u_xlatb18;
float u_xlat23;
float u_xlat25;
float u_xlat26;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat2.x = u_xlat0.w * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat2.x) + 2.0;
    u_xlat16_3 = u_xlat2.x * u_xlat16_3;
    u_xlat2.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat5.xyz = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
    u_xlat23 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat23 = sqrt(u_xlat23);
    u_xlat25 = u_xlat23 + (-_HeigtFogRamp3.w);
    u_xlat25 = u_xlat25 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat25) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat4.x = u_xlat23 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat4.x) + 2.0;
    u_xlat4.x = u_xlat11 * u_xlat4.x;
    u_xlat11 = u_xlat4.x * _HeigtFogColDelta3.w;
    u_xlat18.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat23>=u_xlat18.x);
#else
    u_xlatb18 = u_xlat23>=u_xlat18.x;
#endif
    u_xlat4.x = (u_xlatb18) ? u_xlat11 : u_xlat4.x;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _Mihoyo_FogColor3.w;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, _HeigtFogColBase3.w);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat11 = u_xlat5.y * _HeigtFogParams3.x;
    u_xlat25 = u_xlat11 * -1.44269502;
    u_xlat4.w = exp2(u_xlat25);
    u_xlat4.xw = (-u_xlat4.xw) + vec2(1.0, 1.0);
    u_xlat25 = u_xlat4.w / u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat16_3 = (u_xlatb11) ? u_xlat25 : 1.0;
    u_xlat11 = u_xlat23 * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16_3 * u_xlat11;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat11 = u_xlat23 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat11) + 2.0;
    u_xlat16_10 = u_xlat16_10 * u_xlat11;
    u_xlat11 = u_xlat16_10 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat11 = u_xlat11 + 1.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat11;
    u_xlat11 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat25 = (-u_xlat11) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat25);
    u_xlat3.w = u_xlat25 * u_xlat4.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat11) + u_xlat2.xyz;
    u_xlat2.x = u_xlat0.w * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat2.x) + 2.0;
    u_xlat16_6 = u_xlat2.x * u_xlat16_6;
    u_xlat2.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat4.xyw = (-u_xlat2.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat26 = u_xlat23 + (-_HeigtFogRamp2.w);
    u_xlat26 = u_xlat26 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat26) * u_xlat4.xyw + u_xlat2.xyz;
    u_xlat4.x = u_xlat23 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat4.x) + 2.0;
    u_xlat4.x = u_xlat11 * u_xlat4.x;
    u_xlat11 = u_xlat4.x * _HeigtFogColDelta2.w;
    u_xlat4.x = (u_xlatb18) ? u_xlat11 : u_xlat4.x;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _Mihoyo_FogColor2.w;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, _HeigtFogColBase2.w);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx;
    u_xlat11 = u_xlat5.y * _HeigtFogParams2.x;
    u_xlat18.x = dot(u_xlat5.xz, u_xlat5.xz);
    u_xlat18.x = sqrt(u_xlat18.x);
    u_xlat18.x = u_xlat18.x + (-_UWFogDistStart);
    u_xlat18.x = max(u_xlat18.x, 0.0);
    u_xlat18.xy = u_xlat18.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat18.xy = u_xlat18.xy * (-u_xlat18.xy);
    u_xlat18.xy = u_xlat18.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat18.xy);
    u_xlat18.x = u_xlat11 * -1.44269502;
    u_xlat4.z = exp2(u_xlat18.x);
    u_xlat4.xz = (-u_xlat4.xz) + vec2(1.0, 1.0);
    u_xlat18.x = u_xlat4.z / u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat16_6 = (u_xlatb11) ? u_xlat18.x : 1.0;
    u_xlat11 = u_xlat23 * _HeigtFogParams2.y;
    u_xlat23 = u_xlat23 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat11 * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat23) + 2.0;
    u_xlat16_13 = u_xlat23 * u_xlat16_13;
    u_xlat23 = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat23 = u_xlat23 + 1.0;
    u_xlat16_6 = u_xlat23 * u_xlat16_6;
    u_xlat23 = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat11 = (-u_xlat23) + 1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat11);
    u_xlat4.w = u_xlat11 * u_xlat4.x;
    u_xlat4.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat23) + u_xlat2.xyz;
    u_xlat2 = u_xlat3 + (-u_xlat4);
    u_xlat2 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat2 + u_xlat4;
    vs_COLOR1 = u_xlat2;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD3.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
bool u_xlatb9;
lowp float u_xlat10_12;
bool u_xlatb12;
mediump float u_xlat16_15;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD1.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb12 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb12){
        u_xlat2.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_12 = texture(_DynamicSceneShadowVolumeBuffer, u_xlat2.xy).x;
        u_xlat16_3.x = u_xlat10_12;
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = (-_ShadowIntegration) * u_xlat16_3.x + 1.0;
    u_xlat16_7.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD3.z<_WaterPlaneHeight);
#else
    u_xlatb12 = vs_TEXCOORD3.z<_WaterPlaneHeight;
#endif
    u_xlat1.x = (-vs_TEXCOORD3.z) + _WaterPlaneHeight;
    u_xlat5 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat1.x = u_xlat1.x / u_xlat5;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat2.x = u_xlat1.x * _UWFogColorHLIntensity;
    u_xlat5 = (-_UWHeightFogDensity) * u_xlat1.x + 1.0;
    u_xlat5 = u_xlat5 * _UWHeightFogEffectLimit;
    u_xlat5 = max(u_xlat5, _UWHeightFogEffectStart);
    u_xlat5 = min(u_xlat5, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.99000001<vs_TEXCOORD3.y);
#else
    u_xlatb9 = 0.99000001<vs_TEXCOORD3.y;
#endif
    u_xlat1.x = (-u_xlat1.x) * _UWHeightRatio + 1.0;
    u_xlat1.x = u_xlat1.x * vs_TEXCOORD3.y;
    u_xlat1.x = max(u_xlat1.x, _UWCriticalRange);
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat16_15 = (u_xlatb9) ? u_xlat1.x : vs_TEXCOORD3.y;
    u_xlat16_15 = (-u_xlat16_15) + 1.0;
    u_xlat1.xzw = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat1.xzw = vs_TEXCOORD3.xxx * u_xlat1.xzw + _UWFogColorFar.xyz;
    u_xlat6.xyz = u_xlat16_3.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + (-u_xlat1.xzw);
    u_xlat1.xzw = vec3(u_xlat16_15) * u_xlat6.xyz + u_xlat1.xzw;
    u_xlat6.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat6.xyz + _UWFogColorLow.xyz;
    u_xlat1.xzw = u_xlat1.xzw + (-u_xlat2.xyz);
    u_xlat1.xyz = vec3(u_xlat5) * u_xlat1.xzw + u_xlat2.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb12)) ? u_xlat1.xyz : u_xlat0.xyz;
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _BloomFactor;
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
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
}
}
 UsePass "Hidden/miHoYo/DLC/Common/Shared/PREDEPTH"
}
}