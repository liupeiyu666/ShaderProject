//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Common/Bamboo Leaf (Wind)" {
Properties {
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Base (RGB) Trans (A)", 2D) = "white" { }
_Cutoff ("Alpha cutoff", Range(0, 1)) = 0.5
_Culling ("Culling (0: Off, 1: Front, 2: Back)", Float) = 2
_WindDirection ("Wind Direction", Vector) = (1,0,0,0)
_BendIntensity ("Bend InTensity", Range(0, 1)) = 0
_BendSpeed ("Bend Speed", Range(0, 1)) = 0
_BendVariance ("Bend Variance", Float) = 1
_BendDelayScale ("Bend Delay Scale", Float) = 1
_SideBend ("Side Bend", Range(0, 10)) = 0
_Gust ("Gust", Float) = 1
_GlobalSpeed ("Global Speed", Range(0, 1)) = 1
}
SubShader {
 LOD 100
 Tags { "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
 Pass {
  LOD 100
  Tags { "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
  Cull Off
  GpuProgramID 20948
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
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
uniform 	vec4 _miHoYo_Wind;
uniform 	vec4 _miHoYo_WindParams1;
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _WindDirection;
uniform 	float _BendIntensity;
uniform 	float _BendSpeed;
uniform 	float _BendVariance;
uniform 	float _SideBend;
uniform 	float _Gust;
uniform 	float _GlobalSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TANGENT0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat6;
vec2 u_xlat12;
bool u_xlatb12;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.xyz = in_TANGENT0.xyz * in_TEXCOORD1.yyy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + in_POSITION0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y));
#else
    u_xlatb18 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y);
#endif
    u_xlat1.xyz = (bool(u_xlatb18)) ? _WindDirection.xyz : _miHoYo_Wind.xyz;
    u_xlat2 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat2;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat3.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat3.w = sqrt(u_xlat18);
    u_xlat0.x = dot(u_xlat0.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat0.x = u_xlat0.x * _BendVariance;
    u_xlat6.x = _miHoYo_WindParams1.z + -1.0;
    u_xlat6.x = _GlobalSpeed * u_xlat6.x + 1.0;
    u_xlat12.x = _miHoYo_WindParams1.w * _GlobalSpeed;
    u_xlat6.x = _miHoYo_Wind.w * u_xlat6.x + u_xlat12.x;
    u_xlat0.x = u_xlat6.x * _BendSpeed + u_xlat0.x;
    u_xlat4 = u_xlat0.xxxx * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat5 = abs(u_xlat4) * abs(u_xlat4);
    u_xlat4 = -abs(u_xlat4) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat4 = u_xlat5 * u_xlat4 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat6.x = dot(u_xlat4, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat6.x = _miHoYo_WindParams1.x * _Gust + u_xlat6.x;
    u_xlat12.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat4.xyz = u_xlat12.xxx * u_xlat1.xyz;
    u_xlat4.xyz = u_xlat6.xxx * u_xlat4.xyz;
    u_xlat6.xyz = vec3(u_xlat18) * u_xlat4.xyz;
    u_xlat6.xyz = u_xlat6.xyz * vec3(vec3(_BendIntensity, _BendIntensity, _BendIntensity));
    u_xlat6.xyz = u_xlat6.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat2.xyz;
    u_xlat0.x = u_xlat0.x + -0.5;
    u_xlat4 = u_xlat0.xxxx * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat5 = abs(u_xlat4) * abs(u_xlat4);
    u_xlat4 = -abs(u_xlat4) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat4 = u_xlat5 * u_xlat4 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat3.z = dot(u_xlat4, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat1.w = (-u_xlat1.z);
    u_xlat3.xy = u_xlat1.zx * vec2(-1.0, 1.0);
    u_xlat0.x = dot(u_xlat1.wx, u_xlat3.xy);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat3.xzy;
    u_xlat1.xyz = vec3(u_xlat3.z * u_xlat1.x, u_xlat3.w * u_xlat1.y, u_xlat3.z * u_xlat1.z);
    u_xlat2.xz = u_xlat3.ww;
    u_xlat2.y = _BendIntensity;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xz = u_xlat1.xz * vec2(vec2(_BendIntensity, _BendIntensity));
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_SideBend, _SideBend, _SideBend));
    u_xlat0.xyz = u_xlat1.xyz * vec3(0.00999999978, 0.0, 0.00999999978) + u_xlat6.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat12.x = sqrt(u_xlat12.x);
        u_xlat12.x = u_xlat12.x + (-_FogStartDistance);
        u_xlat12.x = max(u_xlat12.x, 0.0);
        u_xlat12.xy = u_xlat12.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat12.xy = u_xlat12.xy * (-u_xlat12.xy);
        u_xlat12.xy = u_xlat12.xy * vec2(1.44269502, 1.44269502);
        u_xlat12.xy = exp2(u_xlat12.xy);
        u_xlat12.x = (-u_xlat12.x) + 1.0;
        u_xlat12.x = u_xlat12.x * _FogEffectLimit;
        u_xlat12.x = max(u_xlat12.x, _FogEffectStart);
        u_xlat1.w = min(u_xlat12.x, _FogEffectLimit);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat12.yyy * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat12.x = sqrt(u_xlat12.x);
        u_xlat12.x = u_xlat12.x + (-_FogStartDistance);
        u_xlat12.x = max(u_xlat12.x, 0.0);
        u_xlat12.xy = u_xlat12.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat12.xy = u_xlat12.xy * vec2(500.0, 1000.0);
        u_xlat1.x = (-_FogStartDistance) + _FogEndDistance;
        u_xlat1.x = max(u_xlat1.x, 0.100000001);
        u_xlat12.xy = u_xlat12.yx / u_xlat1.xx;
        u_xlat18 = u_xlat12.y * _FogEffectLimit;
        u_xlat18 = max(u_xlat18, _FogEffectStart);
        u_xlat1.w = min(u_xlat18, _FogEffectLimit);
        u_xlat12.x = u_xlat12.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
        u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
        u_xlat12.x = (-u_xlat12.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat12.xxx * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    //ENDIF
    }
    vs_COLOR0.xyz = in_COLOR0.xyz;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD1.xyz = in_TANGENT0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Cutoff;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
int u_xlati6;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = floor(u_xlat16_1.x);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlati6 = int(u_xlat16_1.x);
    if((u_xlati6)==0){discard;}
    u_xlat16_1.xyz = (-u_xlat10_0.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat10_0.xyz;
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
uniform 	vec4 _miHoYo_Wind;
uniform 	vec4 _miHoYo_WindParams1;
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _WindDirection;
uniform 	float _BendIntensity;
uniform 	float _BendSpeed;
uniform 	float _BendVariance;
uniform 	float _SideBend;
uniform 	float _Gust;
uniform 	float _GlobalSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TANGENT0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat6;
vec2 u_xlat12;
bool u_xlatb12;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.xyz = in_TANGENT0.xyz * in_TEXCOORD1.yyy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + in_POSITION0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y));
#else
    u_xlatb18 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y);
#endif
    u_xlat1.xyz = (bool(u_xlatb18)) ? _WindDirection.xyz : _miHoYo_Wind.xyz;
    u_xlat2 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat2;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat3.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat3.w = sqrt(u_xlat18);
    u_xlat0.x = dot(u_xlat0.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat0.x = u_xlat0.x * _BendVariance;
    u_xlat6.x = _miHoYo_WindParams1.z + -1.0;
    u_xlat6.x = _GlobalSpeed * u_xlat6.x + 1.0;
    u_xlat12.x = _miHoYo_WindParams1.w * _GlobalSpeed;
    u_xlat6.x = _miHoYo_Wind.w * u_xlat6.x + u_xlat12.x;
    u_xlat0.x = u_xlat6.x * _BendSpeed + u_xlat0.x;
    u_xlat4 = u_xlat0.xxxx * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat5 = abs(u_xlat4) * abs(u_xlat4);
    u_xlat4 = -abs(u_xlat4) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat4 = u_xlat5 * u_xlat4 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat6.x = dot(u_xlat4, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat6.x = _miHoYo_WindParams1.x * _Gust + u_xlat6.x;
    u_xlat12.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat4.xyz = u_xlat12.xxx * u_xlat1.xyz;
    u_xlat4.xyz = u_xlat6.xxx * u_xlat4.xyz;
    u_xlat6.xyz = vec3(u_xlat18) * u_xlat4.xyz;
    u_xlat6.xyz = u_xlat6.xyz * vec3(vec3(_BendIntensity, _BendIntensity, _BendIntensity));
    u_xlat6.xyz = u_xlat6.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat2.xyz;
    u_xlat0.x = u_xlat0.x + -0.5;
    u_xlat4 = u_xlat0.xxxx * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat5 = abs(u_xlat4) * abs(u_xlat4);
    u_xlat4 = -abs(u_xlat4) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat4 = u_xlat5 * u_xlat4 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat3.z = dot(u_xlat4, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat1.w = (-u_xlat1.z);
    u_xlat3.xy = u_xlat1.zx * vec2(-1.0, 1.0);
    u_xlat0.x = dot(u_xlat1.wx, u_xlat3.xy);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat3.xzy;
    u_xlat1.xyz = vec3(u_xlat3.z * u_xlat1.x, u_xlat3.w * u_xlat1.y, u_xlat3.z * u_xlat1.z);
    u_xlat2.xz = u_xlat3.ww;
    u_xlat2.y = _BendIntensity;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xz = u_xlat1.xz * vec2(vec2(_BendIntensity, _BendIntensity));
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_SideBend, _SideBend, _SideBend));
    u_xlat0.xyz = u_xlat1.xyz * vec3(0.00999999978, 0.0, 0.00999999978) + u_xlat6.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat12.x = sqrt(u_xlat12.x);
        u_xlat12.x = u_xlat12.x + (-_FogStartDistance);
        u_xlat12.x = max(u_xlat12.x, 0.0);
        u_xlat12.xy = u_xlat12.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat12.xy = u_xlat12.xy * (-u_xlat12.xy);
        u_xlat12.xy = u_xlat12.xy * vec2(1.44269502, 1.44269502);
        u_xlat12.xy = exp2(u_xlat12.xy);
        u_xlat12.x = (-u_xlat12.x) + 1.0;
        u_xlat12.x = u_xlat12.x * _FogEffectLimit;
        u_xlat12.x = max(u_xlat12.x, _FogEffectStart);
        u_xlat1.w = min(u_xlat12.x, _FogEffectLimit);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat12.yyy * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat12.x = sqrt(u_xlat12.x);
        u_xlat12.x = u_xlat12.x + (-_FogStartDistance);
        u_xlat12.x = max(u_xlat12.x, 0.0);
        u_xlat12.xy = u_xlat12.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat12.xy = u_xlat12.xy * vec2(500.0, 1000.0);
        u_xlat1.x = (-_FogStartDistance) + _FogEndDistance;
        u_xlat1.x = max(u_xlat1.x, 0.100000001);
        u_xlat12.xy = u_xlat12.yx / u_xlat1.xx;
        u_xlat18 = u_xlat12.y * _FogEffectLimit;
        u_xlat18 = max(u_xlat18, _FogEffectStart);
        u_xlat1.w = min(u_xlat18, _FogEffectLimit);
        u_xlat12.x = u_xlat12.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
        u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
        u_xlat12.x = (-u_xlat12.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat12.xxx * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    //ENDIF
    }
    vs_COLOR0.xyz = in_COLOR0.xyz;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD1.xyz = in_TANGENT0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Cutoff;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
int u_xlati6;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = floor(u_xlat16_1.x);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlati6 = int(u_xlat16_1.x);
    if((u_xlati6)==0){discard;}
    u_xlat16_1.xyz = (-u_xlat10_0.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat10_0.xyz;
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
uniform 	vec4 _miHoYo_Wind;
uniform 	vec4 _miHoYo_WindParams1;
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _WindDirection;
uniform 	float _BendIntensity;
uniform 	float _BendSpeed;
uniform 	float _BendVariance;
uniform 	float _SideBend;
uniform 	float _Gust;
uniform 	float _GlobalSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TANGENT0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat6;
vec2 u_xlat12;
bool u_xlatb12;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.xyz = in_TANGENT0.xyz * in_TEXCOORD1.yyy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + in_POSITION0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y));
#else
    u_xlatb18 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y);
#endif
    u_xlat1.xyz = (bool(u_xlatb18)) ? _WindDirection.xyz : _miHoYo_Wind.xyz;
    u_xlat2 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat2;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat3.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat3.w = sqrt(u_xlat18);
    u_xlat0.x = dot(u_xlat0.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat0.x = u_xlat0.x * _BendVariance;
    u_xlat6.x = _miHoYo_WindParams1.z + -1.0;
    u_xlat6.x = _GlobalSpeed * u_xlat6.x + 1.0;
    u_xlat12.x = _miHoYo_WindParams1.w * _GlobalSpeed;
    u_xlat6.x = _miHoYo_Wind.w * u_xlat6.x + u_xlat12.x;
    u_xlat0.x = u_xlat6.x * _BendSpeed + u_xlat0.x;
    u_xlat4 = u_xlat0.xxxx * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat5 = abs(u_xlat4) * abs(u_xlat4);
    u_xlat4 = -abs(u_xlat4) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat4 = u_xlat5 * u_xlat4 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat6.x = dot(u_xlat4, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat6.x = _miHoYo_WindParams1.x * _Gust + u_xlat6.x;
    u_xlat12.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat4.xyz = u_xlat12.xxx * u_xlat1.xyz;
    u_xlat4.xyz = u_xlat6.xxx * u_xlat4.xyz;
    u_xlat6.xyz = vec3(u_xlat18) * u_xlat4.xyz;
    u_xlat6.xyz = u_xlat6.xyz * vec3(vec3(_BendIntensity, _BendIntensity, _BendIntensity));
    u_xlat6.xyz = u_xlat6.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat2.xyz;
    u_xlat0.x = u_xlat0.x + -0.5;
    u_xlat4 = u_xlat0.xxxx * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat5 = abs(u_xlat4) * abs(u_xlat4);
    u_xlat4 = -abs(u_xlat4) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat4 = u_xlat5 * u_xlat4 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat3.z = dot(u_xlat4, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat1.w = (-u_xlat1.z);
    u_xlat3.xy = u_xlat1.zx * vec2(-1.0, 1.0);
    u_xlat0.x = dot(u_xlat1.wx, u_xlat3.xy);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat3.xzy;
    u_xlat1.xyz = vec3(u_xlat3.z * u_xlat1.x, u_xlat3.w * u_xlat1.y, u_xlat3.z * u_xlat1.z);
    u_xlat2.xz = u_xlat3.ww;
    u_xlat2.y = _BendIntensity;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xz = u_xlat1.xz * vec2(vec2(_BendIntensity, _BendIntensity));
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_SideBend, _SideBend, _SideBend));
    u_xlat0.xyz = u_xlat1.xyz * vec3(0.00999999978, 0.0, 0.00999999978) + u_xlat6.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat12.x = sqrt(u_xlat12.x);
        u_xlat12.x = u_xlat12.x + (-_FogStartDistance);
        u_xlat12.x = max(u_xlat12.x, 0.0);
        u_xlat12.xy = u_xlat12.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat12.xy = u_xlat12.xy * (-u_xlat12.xy);
        u_xlat12.xy = u_xlat12.xy * vec2(1.44269502, 1.44269502);
        u_xlat12.xy = exp2(u_xlat12.xy);
        u_xlat12.x = (-u_xlat12.x) + 1.0;
        u_xlat12.x = u_xlat12.x * _FogEffectLimit;
        u_xlat12.x = max(u_xlat12.x, _FogEffectStart);
        u_xlat1.w = min(u_xlat12.x, _FogEffectLimit);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat12.yyy * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat12.x = sqrt(u_xlat12.x);
        u_xlat12.x = u_xlat12.x + (-_FogStartDistance);
        u_xlat12.x = max(u_xlat12.x, 0.0);
        u_xlat12.xy = u_xlat12.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat12.xy = u_xlat12.xy * vec2(500.0, 1000.0);
        u_xlat1.x = (-_FogStartDistance) + _FogEndDistance;
        u_xlat1.x = max(u_xlat1.x, 0.100000001);
        u_xlat12.xy = u_xlat12.yx / u_xlat1.xx;
        u_xlat18 = u_xlat12.y * _FogEffectLimit;
        u_xlat18 = max(u_xlat18, _FogEffectStart);
        u_xlat1.w = min(u_xlat18, _FogEffectLimit);
        u_xlat12.x = u_xlat12.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
        u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
        u_xlat12.x = (-u_xlat12.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat12.xxx * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    //ENDIF
    }
    vs_COLOR0.xyz = in_COLOR0.xyz;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD1.xyz = in_TANGENT0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Cutoff;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
int u_xlati6;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = floor(u_xlat16_1.x);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlati6 = int(u_xlat16_1.x);
    if((u_xlati6)==0){discard;}
    u_xlat16_1.xyz = (-u_xlat10_0.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat10_0.xyz;
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
uniform 	vec4 _miHoYo_Wind;
uniform 	vec4 _miHoYo_WindParams1;
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _WindDirection;
uniform 	float _BendIntensity;
uniform 	float _BendSpeed;
uniform 	float _BendVariance;
uniform 	float _SideBend;
uniform 	float _Gust;
uniform 	float _GlobalSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TANGENT0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat6;
vec2 u_xlat12;
bool u_xlatb12;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.xyz = in_TANGENT0.xyz * in_TEXCOORD1.yyy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + in_POSITION0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y));
#else
    u_xlatb18 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y);
#endif
    u_xlat1.xyz = (bool(u_xlatb18)) ? _WindDirection.xyz : _miHoYo_Wind.xyz;
    u_xlat2 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat2;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat3.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat3.w = sqrt(u_xlat18);
    u_xlat0.x = dot(u_xlat0.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat0.x = u_xlat0.x * _BendVariance;
    u_xlat6.x = _miHoYo_WindParams1.z + -1.0;
    u_xlat6.x = _GlobalSpeed * u_xlat6.x + 1.0;
    u_xlat12.x = _miHoYo_WindParams1.w * _GlobalSpeed;
    u_xlat6.x = _miHoYo_Wind.w * u_xlat6.x + u_xlat12.x;
    u_xlat0.x = u_xlat6.x * _BendSpeed + u_xlat0.x;
    u_xlat4 = u_xlat0.xxxx * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat5 = abs(u_xlat4) * abs(u_xlat4);
    u_xlat4 = -abs(u_xlat4) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat4 = u_xlat5 * u_xlat4 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat6.x = dot(u_xlat4, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat6.x = _miHoYo_WindParams1.x * _Gust + u_xlat6.x;
    u_xlat12.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat4.xyz = u_xlat12.xxx * u_xlat1.xyz;
    u_xlat4.xyz = u_xlat6.xxx * u_xlat4.xyz;
    u_xlat6.xyz = vec3(u_xlat18) * u_xlat4.xyz;
    u_xlat6.xyz = u_xlat6.xyz * vec3(vec3(_BendIntensity, _BendIntensity, _BendIntensity));
    u_xlat6.xyz = u_xlat6.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat2.xyz;
    u_xlat0.x = u_xlat0.x + -0.5;
    u_xlat4 = u_xlat0.xxxx * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat5 = abs(u_xlat4) * abs(u_xlat4);
    u_xlat4 = -abs(u_xlat4) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat4 = u_xlat5 * u_xlat4 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat3.z = dot(u_xlat4, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat1.w = (-u_xlat1.z);
    u_xlat3.xy = u_xlat1.zx * vec2(-1.0, 1.0);
    u_xlat0.x = dot(u_xlat1.wx, u_xlat3.xy);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat3.xzy;
    u_xlat1.xyz = vec3(u_xlat3.z * u_xlat1.x, u_xlat3.w * u_xlat1.y, u_xlat3.z * u_xlat1.z);
    u_xlat2.xz = u_xlat3.ww;
    u_xlat2.y = _BendIntensity;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xz = u_xlat1.xz * vec2(vec2(_BendIntensity, _BendIntensity));
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_SideBend, _SideBend, _SideBend));
    u_xlat0.xyz = u_xlat1.xyz * vec3(0.00999999978, 0.0, 0.00999999978) + u_xlat6.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat12.x = sqrt(u_xlat12.x);
        u_xlat12.x = u_xlat12.x + (-_FogStartDistance);
        u_xlat12.x = max(u_xlat12.x, 0.0);
        u_xlat12.xy = u_xlat12.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat12.xy = u_xlat12.xy * (-u_xlat12.xy);
        u_xlat12.xy = u_xlat12.xy * vec2(1.44269502, 1.44269502);
        u_xlat12.xy = exp2(u_xlat12.xy);
        u_xlat12.x = (-u_xlat12.x) + 1.0;
        u_xlat12.x = u_xlat12.x * _FogEffectLimit;
        u_xlat12.x = max(u_xlat12.x, _FogEffectStart);
        u_xlat1.w = min(u_xlat12.x, _FogEffectLimit);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat12.yyy * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat12.x = sqrt(u_xlat12.x);
        u_xlat12.x = u_xlat12.x + (-_FogStartDistance);
        u_xlat12.x = max(u_xlat12.x, 0.0);
        u_xlat12.xy = u_xlat12.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat12.xy = u_xlat12.xy * vec2(500.0, 1000.0);
        u_xlat1.x = (-_FogStartDistance) + _FogEndDistance;
        u_xlat1.x = max(u_xlat1.x, 0.100000001);
        u_xlat12.xy = u_xlat12.yx / u_xlat1.xx;
        u_xlat18 = u_xlat12.y * _FogEffectLimit;
        u_xlat18 = max(u_xlat18, _FogEffectStart);
        u_xlat1.w = min(u_xlat18, _FogEffectLimit);
        u_xlat12.x = u_xlat12.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
        u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
        u_xlat12.x = (-u_xlat12.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat12.xxx * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    //ENDIF
    }
    vs_COLOR0.xyz = in_COLOR0.xyz;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD1.xyz = in_TANGENT0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Cutoff;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
int u_xlati6;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = floor(u_xlat16_1.x);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlati6 = int(u_xlat16_1.x);
    if((u_xlati6)==0){discard;}
    u_xlat16_1.xyz = (-u_xlat10_0.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat10_0.xyz;
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
uniform 	vec4 _miHoYo_Wind;
uniform 	vec4 _miHoYo_WindParams1;
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _WindDirection;
uniform 	float _BendIntensity;
uniform 	float _BendSpeed;
uniform 	float _BendVariance;
uniform 	float _SideBend;
uniform 	float _Gust;
uniform 	float _GlobalSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TANGENT0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat6;
vec2 u_xlat12;
bool u_xlatb12;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.xyz = in_TANGENT0.xyz * in_TEXCOORD1.yyy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + in_POSITION0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y));
#else
    u_xlatb18 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y);
#endif
    u_xlat1.xyz = (bool(u_xlatb18)) ? _WindDirection.xyz : _miHoYo_Wind.xyz;
    u_xlat2 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat2;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat3.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat3.w = sqrt(u_xlat18);
    u_xlat0.x = dot(u_xlat0.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat0.x = u_xlat0.x * _BendVariance;
    u_xlat6.x = _miHoYo_WindParams1.z + -1.0;
    u_xlat6.x = _GlobalSpeed * u_xlat6.x + 1.0;
    u_xlat12.x = _miHoYo_WindParams1.w * _GlobalSpeed;
    u_xlat6.x = _miHoYo_Wind.w * u_xlat6.x + u_xlat12.x;
    u_xlat0.x = u_xlat6.x * _BendSpeed + u_xlat0.x;
    u_xlat4 = u_xlat0.xxxx * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat5 = abs(u_xlat4) * abs(u_xlat4);
    u_xlat4 = -abs(u_xlat4) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat4 = u_xlat5 * u_xlat4 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat6.x = dot(u_xlat4, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat6.x = _miHoYo_WindParams1.x * _Gust + u_xlat6.x;
    u_xlat12.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat4.xyz = u_xlat12.xxx * u_xlat1.xyz;
    u_xlat4.xyz = u_xlat6.xxx * u_xlat4.xyz;
    u_xlat6.xyz = vec3(u_xlat18) * u_xlat4.xyz;
    u_xlat6.xyz = u_xlat6.xyz * vec3(vec3(_BendIntensity, _BendIntensity, _BendIntensity));
    u_xlat6.xyz = u_xlat6.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat2.xyz;
    u_xlat0.x = u_xlat0.x + -0.5;
    u_xlat4 = u_xlat0.xxxx * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat5 = abs(u_xlat4) * abs(u_xlat4);
    u_xlat4 = -abs(u_xlat4) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat4 = u_xlat5 * u_xlat4 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat3.z = dot(u_xlat4, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat1.w = (-u_xlat1.z);
    u_xlat3.xy = u_xlat1.zx * vec2(-1.0, 1.0);
    u_xlat0.x = dot(u_xlat1.wx, u_xlat3.xy);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat3.xzy;
    u_xlat1.xyz = vec3(u_xlat3.z * u_xlat1.x, u_xlat3.w * u_xlat1.y, u_xlat3.z * u_xlat1.z);
    u_xlat2.xz = u_xlat3.ww;
    u_xlat2.y = _BendIntensity;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xz = u_xlat1.xz * vec2(vec2(_BendIntensity, _BendIntensity));
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_SideBend, _SideBend, _SideBend));
    u_xlat0.xyz = u_xlat1.xyz * vec3(0.00999999978, 0.0, 0.00999999978) + u_xlat6.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat12.x = sqrt(u_xlat12.x);
        u_xlat12.x = u_xlat12.x + (-_FogStartDistance);
        u_xlat12.x = max(u_xlat12.x, 0.0);
        u_xlat12.xy = u_xlat12.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat12.xy = u_xlat12.xy * (-u_xlat12.xy);
        u_xlat12.xy = u_xlat12.xy * vec2(1.44269502, 1.44269502);
        u_xlat12.xy = exp2(u_xlat12.xy);
        u_xlat12.x = (-u_xlat12.x) + 1.0;
        u_xlat12.x = u_xlat12.x * _FogEffectLimit;
        u_xlat12.x = max(u_xlat12.x, _FogEffectStart);
        u_xlat1.w = min(u_xlat12.x, _FogEffectLimit);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat12.yyy * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat12.x = sqrt(u_xlat12.x);
        u_xlat12.x = u_xlat12.x + (-_FogStartDistance);
        u_xlat12.x = max(u_xlat12.x, 0.0);
        u_xlat12.xy = u_xlat12.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat12.xy = u_xlat12.xy * vec2(500.0, 1000.0);
        u_xlat1.x = (-_FogStartDistance) + _FogEndDistance;
        u_xlat1.x = max(u_xlat1.x, 0.100000001);
        u_xlat12.xy = u_xlat12.yx / u_xlat1.xx;
        u_xlat18 = u_xlat12.y * _FogEffectLimit;
        u_xlat18 = max(u_xlat18, _FogEffectStart);
        u_xlat1.w = min(u_xlat18, _FogEffectLimit);
        u_xlat12.x = u_xlat12.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
        u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
        u_xlat12.x = (-u_xlat12.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat12.xxx * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    //ENDIF
    }
    vs_COLOR0.xyz = in_COLOR0.xyz;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD1.xyz = in_TANGENT0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Cutoff;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
int u_xlati6;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = floor(u_xlat16_1.x);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlati6 = int(u_xlat16_1.x);
    if((u_xlati6)==0){discard;}
    u_xlat16_1.xyz = (-u_xlat10_0.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat10_0.xyz;
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
uniform 	vec4 _miHoYo_Wind;
uniform 	vec4 _miHoYo_WindParams1;
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _WindDirection;
uniform 	float _BendIntensity;
uniform 	float _BendSpeed;
uniform 	float _BendVariance;
uniform 	float _SideBend;
uniform 	float _Gust;
uniform 	float _GlobalSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TANGENT0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat6;
vec2 u_xlat12;
bool u_xlatb12;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.xyz = in_TANGENT0.xyz * in_TEXCOORD1.yyy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + in_POSITION0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y));
#else
    u_xlatb18 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y);
#endif
    u_xlat1.xyz = (bool(u_xlatb18)) ? _WindDirection.xyz : _miHoYo_Wind.xyz;
    u_xlat2 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat2;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat3.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat3.w = sqrt(u_xlat18);
    u_xlat0.x = dot(u_xlat0.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat0.x = u_xlat0.x * _BendVariance;
    u_xlat6.x = _miHoYo_WindParams1.z + -1.0;
    u_xlat6.x = _GlobalSpeed * u_xlat6.x + 1.0;
    u_xlat12.x = _miHoYo_WindParams1.w * _GlobalSpeed;
    u_xlat6.x = _miHoYo_Wind.w * u_xlat6.x + u_xlat12.x;
    u_xlat0.x = u_xlat6.x * _BendSpeed + u_xlat0.x;
    u_xlat4 = u_xlat0.xxxx * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat5 = abs(u_xlat4) * abs(u_xlat4);
    u_xlat4 = -abs(u_xlat4) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat4 = u_xlat5 * u_xlat4 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat6.x = dot(u_xlat4, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat6.x = _miHoYo_WindParams1.x * _Gust + u_xlat6.x;
    u_xlat12.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat4.xyz = u_xlat12.xxx * u_xlat1.xyz;
    u_xlat4.xyz = u_xlat6.xxx * u_xlat4.xyz;
    u_xlat6.xyz = vec3(u_xlat18) * u_xlat4.xyz;
    u_xlat6.xyz = u_xlat6.xyz * vec3(vec3(_BendIntensity, _BendIntensity, _BendIntensity));
    u_xlat6.xyz = u_xlat6.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat2.xyz;
    u_xlat0.x = u_xlat0.x + -0.5;
    u_xlat4 = u_xlat0.xxxx * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat5 = abs(u_xlat4) * abs(u_xlat4);
    u_xlat4 = -abs(u_xlat4) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat4 = u_xlat5 * u_xlat4 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat3.z = dot(u_xlat4, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat1.w = (-u_xlat1.z);
    u_xlat3.xy = u_xlat1.zx * vec2(-1.0, 1.0);
    u_xlat0.x = dot(u_xlat1.wx, u_xlat3.xy);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat3.xzy;
    u_xlat1.xyz = vec3(u_xlat3.z * u_xlat1.x, u_xlat3.w * u_xlat1.y, u_xlat3.z * u_xlat1.z);
    u_xlat2.xz = u_xlat3.ww;
    u_xlat2.y = _BendIntensity;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xz = u_xlat1.xz * vec2(vec2(_BendIntensity, _BendIntensity));
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_SideBend, _SideBend, _SideBend));
    u_xlat0.xyz = u_xlat1.xyz * vec3(0.00999999978, 0.0, 0.00999999978) + u_xlat6.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat12.x = sqrt(u_xlat12.x);
        u_xlat12.x = u_xlat12.x + (-_FogStartDistance);
        u_xlat12.x = max(u_xlat12.x, 0.0);
        u_xlat12.xy = u_xlat12.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat12.xy = u_xlat12.xy * (-u_xlat12.xy);
        u_xlat12.xy = u_xlat12.xy * vec2(1.44269502, 1.44269502);
        u_xlat12.xy = exp2(u_xlat12.xy);
        u_xlat12.x = (-u_xlat12.x) + 1.0;
        u_xlat12.x = u_xlat12.x * _FogEffectLimit;
        u_xlat12.x = max(u_xlat12.x, _FogEffectStart);
        u_xlat1.w = min(u_xlat12.x, _FogEffectLimit);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat12.yyy * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat12.x = sqrt(u_xlat12.x);
        u_xlat12.x = u_xlat12.x + (-_FogStartDistance);
        u_xlat12.x = max(u_xlat12.x, 0.0);
        u_xlat12.xy = u_xlat12.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat12.xy = u_xlat12.xy * vec2(500.0, 1000.0);
        u_xlat1.x = (-_FogStartDistance) + _FogEndDistance;
        u_xlat1.x = max(u_xlat1.x, 0.100000001);
        u_xlat12.xy = u_xlat12.yx / u_xlat1.xx;
        u_xlat18 = u_xlat12.y * _FogEffectLimit;
        u_xlat18 = max(u_xlat18, _FogEffectStart);
        u_xlat1.w = min(u_xlat18, _FogEffectLimit);
        u_xlat12.x = u_xlat12.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
        u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
        u_xlat12.x = (-u_xlat12.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat12.xxx * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    //ENDIF
    }
    vs_COLOR0.xyz = in_COLOR0.xyz;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD1.xyz = in_TANGENT0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Cutoff;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
int u_xlati6;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = floor(u_xlat16_1.x);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlati6 = int(u_xlat16_1.x);
    if((u_xlati6)==0){discard;}
    u_xlat16_1.xyz = (-u_xlat10_0.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat10_0.xyz;
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
uniform 	vec4 _miHoYo_Wind;
uniform 	vec4 _miHoYo_WindParams1;
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _WindDirection;
uniform 	float _BendIntensity;
uniform 	float _BendSpeed;
uniform 	float _BendVariance;
uniform 	float _SideBend;
uniform 	float _Gust;
uniform 	float _GlobalSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TANGENT0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec4 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
bool u_xlatb7;
mediump float u_xlat16_13;
vec2 u_xlat14;
bool u_xlatb14;
float u_xlat21;
float u_xlat22;
void main()
{
    u_xlat0.x = _miHoYo_WindParams1.z + -1.0;
    u_xlat0.x = _GlobalSpeed * u_xlat0.x + 1.0;
    u_xlat7.x = _miHoYo_WindParams1.w * _GlobalSpeed;
    u_xlat0.x = _miHoYo_Wind.w * u_xlat0.x + u_xlat7.x;
    u_xlat7.xyz = in_TANGENT0.xyz * in_TEXCOORD1.yyy;
    u_xlat7.xyz = u_xlat7.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat7.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat7.xxx + u_xlat1.xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat7.zzz + u_xlat1.xyz;
    u_xlat7.xyz = u_xlat7.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.x = dot(u_xlat7.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat1.x = u_xlat1.x * _BendVariance;
    u_xlat0.x = u_xlat0.x * _BendSpeed + u_xlat1.x;
    u_xlat1.x = u_xlat0.x + -0.5;
    u_xlat2 = u_xlat0.xxxx * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat2 = fract(u_xlat2);
    u_xlat2 = u_xlat2 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat2 = fract(u_xlat2);
    u_xlat2 = u_xlat2 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = u_xlat1.xxxx * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat1 = fract(u_xlat1);
    u_xlat1 = u_xlat1 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat1 = fract(u_xlat1);
    u_xlat1 = u_xlat1 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat3 = abs(u_xlat1) * abs(u_xlat1);
    u_xlat1 = -abs(u_xlat1) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat1 = u_xlat3 * u_xlat1 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat1.z = dot(u_xlat1, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y);
#endif
    u_xlat3.xyz = (bool(u_xlatb0)) ? _WindDirection.xyz : _miHoYo_Wind.xyz;
    u_xlat3.w = (-u_xlat3.z);
    u_xlat1.xy = u_xlat3.zx * vec2(-1.0, 1.0);
    u_xlat0.x = dot(u_xlat3.wx, u_xlat1.xy);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat4.xyz = u_xlat0.xxx * u_xlat1.xzy;
    u_xlat5 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat5;
    u_xlat0.xyz = (-u_xlat7.xyz) + u_xlat5.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.w = sqrt(u_xlat0.x);
    u_xlat7.xyz = vec3(u_xlat1.z * u_xlat4.x, u_xlat1.w * u_xlat4.y, u_xlat1.z * u_xlat4.z);
    u_xlat1.xz = u_xlat1.ww;
    u_xlat1.y = _BendIntensity;
    u_xlat7.xyz = u_xlat7.xyz * u_xlat1.xyz;
    u_xlat7.xz = u_xlat7.xz * vec2(vec2(_BendIntensity, _BendIntensity));
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SideBend, _SideBend, _SideBend));
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3 = abs(u_xlat2) * abs(u_xlat2);
    u_xlat2 = -abs(u_xlat2) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat2 = u_xlat3 * u_xlat2 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat22 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat22 = _miHoYo_WindParams1.x * _Gust + u_xlat22;
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_BendIntensity, _BendIntensity, _BendIntensity));
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat5.xyz;
    u_xlat0.xyz = u_xlat7.xyz * vec3(0.00999999978, 0.0, 0.00999999978) + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat5.wwww + u_xlat0;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    u_xlat0.x = u_xlat5.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_6 = (-u_xlat0.x) + 2.0;
    u_xlat16_6 = u_xlat0.x * u_xlat16_6;
    u_xlat1.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat7.x = u_xlat7.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat14.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat14.x = u_xlat14.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat14.x = min(max(u_xlat14.x, 0.0), 1.0);
#else
    u_xlat14.x = clamp(u_xlat14.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat14.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat14.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(u_xlat0.x>=u_xlat14.x);
#else
    u_xlatb14 = u_xlat0.x>=u_xlat14.x;
#endif
    u_xlat21 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat22 = (-u_xlat21) + 2.0;
    u_xlat21 = u_xlat21 * u_xlat22;
    u_xlat22 = u_xlat21 * _HeigtFogColDelta.w;
    u_xlat14.x = (u_xlatb14) ? u_xlat22 : u_xlat21;
    u_xlat14.x = log2(u_xlat14.x);
    u_xlat14.x = u_xlat14.x * _Mihoyo_FogColor.w;
    u_xlat14.x = exp2(u_xlat14.x);
    u_xlat14.x = min(u_xlat14.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat14.xxx * u_xlat1.xyz;
    u_xlat21 = u_xlat7.x * -1.44269502;
    u_xlat14.y = exp2(u_xlat21);
    u_xlat14.xy = (-u_xlat14.xy) + vec2(1.0, 1.0);
    u_xlat21 = u_xlat14.y / u_xlat7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.00999999978<abs(u_xlat7.x));
#else
    u_xlatb7 = 0.00999999978<abs(u_xlat7.x);
#endif
    u_xlat16_6 = (u_xlatb7) ? u_xlat21 : 1.0;
    u_xlat7.x = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat7.x * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat0.x) + 2.0;
    u_xlat16_13 = u_xlat0.x * u_xlat16_13;
    u_xlat0.x = u_xlat16_13 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_6 = u_xlat0.x * u_xlat16_6;
    u_xlat0.x = min(u_xlat16_6, _HeigtFogColBase.w);
    u_xlat7.x = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat2.w = u_xlat7.x * u_xlat14.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    vs_TEXCOORD1.xyz = in_TANGENT0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Cutoff;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
int u_xlati6;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = floor(u_xlat16_1.x);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlati6 = int(u_xlat16_1.x);
    if((u_xlati6)==0){discard;}
    u_xlat16_1.xyz = (-u_xlat10_0.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat10_0.xyz;
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
uniform 	vec4 _miHoYo_Wind;
uniform 	vec4 _miHoYo_WindParams1;
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _WindDirection;
uniform 	float _BendIntensity;
uniform 	float _BendSpeed;
uniform 	float _BendVariance;
uniform 	float _SideBend;
uniform 	float _Gust;
uniform 	float _GlobalSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TANGENT0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec4 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
bool u_xlatb7;
mediump float u_xlat16_13;
vec2 u_xlat14;
bool u_xlatb14;
float u_xlat21;
float u_xlat22;
void main()
{
    u_xlat0.x = _miHoYo_WindParams1.z + -1.0;
    u_xlat0.x = _GlobalSpeed * u_xlat0.x + 1.0;
    u_xlat7.x = _miHoYo_WindParams1.w * _GlobalSpeed;
    u_xlat0.x = _miHoYo_Wind.w * u_xlat0.x + u_xlat7.x;
    u_xlat7.xyz = in_TANGENT0.xyz * in_TEXCOORD1.yyy;
    u_xlat7.xyz = u_xlat7.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat7.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat7.xxx + u_xlat1.xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat7.zzz + u_xlat1.xyz;
    u_xlat7.xyz = u_xlat7.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.x = dot(u_xlat7.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat1.x = u_xlat1.x * _BendVariance;
    u_xlat0.x = u_xlat0.x * _BendSpeed + u_xlat1.x;
    u_xlat1.x = u_xlat0.x + -0.5;
    u_xlat2 = u_xlat0.xxxx * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat2 = fract(u_xlat2);
    u_xlat2 = u_xlat2 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat2 = fract(u_xlat2);
    u_xlat2 = u_xlat2 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = u_xlat1.xxxx * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat1 = fract(u_xlat1);
    u_xlat1 = u_xlat1 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat1 = fract(u_xlat1);
    u_xlat1 = u_xlat1 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat3 = abs(u_xlat1) * abs(u_xlat1);
    u_xlat1 = -abs(u_xlat1) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat1 = u_xlat3 * u_xlat1 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat1.z = dot(u_xlat1, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y);
#endif
    u_xlat3.xyz = (bool(u_xlatb0)) ? _WindDirection.xyz : _miHoYo_Wind.xyz;
    u_xlat3.w = (-u_xlat3.z);
    u_xlat1.xy = u_xlat3.zx * vec2(-1.0, 1.0);
    u_xlat0.x = dot(u_xlat3.wx, u_xlat1.xy);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat4.xyz = u_xlat0.xxx * u_xlat1.xzy;
    u_xlat5 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat5;
    u_xlat0.xyz = (-u_xlat7.xyz) + u_xlat5.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.w = sqrt(u_xlat0.x);
    u_xlat7.xyz = vec3(u_xlat1.z * u_xlat4.x, u_xlat1.w * u_xlat4.y, u_xlat1.z * u_xlat4.z);
    u_xlat1.xz = u_xlat1.ww;
    u_xlat1.y = _BendIntensity;
    u_xlat7.xyz = u_xlat7.xyz * u_xlat1.xyz;
    u_xlat7.xz = u_xlat7.xz * vec2(vec2(_BendIntensity, _BendIntensity));
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SideBend, _SideBend, _SideBend));
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3 = abs(u_xlat2) * abs(u_xlat2);
    u_xlat2 = -abs(u_xlat2) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat2 = u_xlat3 * u_xlat2 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat22 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat22 = _miHoYo_WindParams1.x * _Gust + u_xlat22;
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_BendIntensity, _BendIntensity, _BendIntensity));
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat5.xyz;
    u_xlat0.xyz = u_xlat7.xyz * vec3(0.00999999978, 0.0, 0.00999999978) + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat5.wwww + u_xlat0;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    u_xlat0.x = u_xlat5.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_6 = (-u_xlat0.x) + 2.0;
    u_xlat16_6 = u_xlat0.x * u_xlat16_6;
    u_xlat1.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat7.x = u_xlat7.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat14.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat14.x = u_xlat14.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat14.x = min(max(u_xlat14.x, 0.0), 1.0);
#else
    u_xlat14.x = clamp(u_xlat14.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat14.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat14.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(u_xlat0.x>=u_xlat14.x);
#else
    u_xlatb14 = u_xlat0.x>=u_xlat14.x;
#endif
    u_xlat21 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat22 = (-u_xlat21) + 2.0;
    u_xlat21 = u_xlat21 * u_xlat22;
    u_xlat22 = u_xlat21 * _HeigtFogColDelta.w;
    u_xlat14.x = (u_xlatb14) ? u_xlat22 : u_xlat21;
    u_xlat14.x = log2(u_xlat14.x);
    u_xlat14.x = u_xlat14.x * _Mihoyo_FogColor.w;
    u_xlat14.x = exp2(u_xlat14.x);
    u_xlat14.x = min(u_xlat14.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat14.xxx * u_xlat1.xyz;
    u_xlat21 = u_xlat7.x * -1.44269502;
    u_xlat14.y = exp2(u_xlat21);
    u_xlat14.xy = (-u_xlat14.xy) + vec2(1.0, 1.0);
    u_xlat21 = u_xlat14.y / u_xlat7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.00999999978<abs(u_xlat7.x));
#else
    u_xlatb7 = 0.00999999978<abs(u_xlat7.x);
#endif
    u_xlat16_6 = (u_xlatb7) ? u_xlat21 : 1.0;
    u_xlat7.x = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat7.x * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat0.x) + 2.0;
    u_xlat16_13 = u_xlat0.x * u_xlat16_13;
    u_xlat0.x = u_xlat16_13 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_6 = u_xlat0.x * u_xlat16_6;
    u_xlat0.x = min(u_xlat16_6, _HeigtFogColBase.w);
    u_xlat7.x = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat2.w = u_xlat7.x * u_xlat14.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    vs_TEXCOORD1.xyz = in_TANGENT0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Cutoff;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
int u_xlati6;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = floor(u_xlat16_1.x);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlati6 = int(u_xlat16_1.x);
    if((u_xlati6)==0){discard;}
    u_xlat16_1.xyz = (-u_xlat10_0.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat10_0.xyz;
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
uniform 	vec4 _miHoYo_Wind;
uniform 	vec4 _miHoYo_WindParams1;
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _WindDirection;
uniform 	float _BendIntensity;
uniform 	float _BendSpeed;
uniform 	float _BendVariance;
uniform 	float _SideBend;
uniform 	float _Gust;
uniform 	float _GlobalSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TANGENT0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec4 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
bool u_xlatb7;
mediump float u_xlat16_13;
vec2 u_xlat14;
bool u_xlatb14;
float u_xlat21;
float u_xlat22;
void main()
{
    u_xlat0.x = _miHoYo_WindParams1.z + -1.0;
    u_xlat0.x = _GlobalSpeed * u_xlat0.x + 1.0;
    u_xlat7.x = _miHoYo_WindParams1.w * _GlobalSpeed;
    u_xlat0.x = _miHoYo_Wind.w * u_xlat0.x + u_xlat7.x;
    u_xlat7.xyz = in_TANGENT0.xyz * in_TEXCOORD1.yyy;
    u_xlat7.xyz = u_xlat7.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat7.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat7.xxx + u_xlat1.xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat7.zzz + u_xlat1.xyz;
    u_xlat7.xyz = u_xlat7.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.x = dot(u_xlat7.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat1.x = u_xlat1.x * _BendVariance;
    u_xlat0.x = u_xlat0.x * _BendSpeed + u_xlat1.x;
    u_xlat1.x = u_xlat0.x + -0.5;
    u_xlat2 = u_xlat0.xxxx * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat2 = fract(u_xlat2);
    u_xlat2 = u_xlat2 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat2 = fract(u_xlat2);
    u_xlat2 = u_xlat2 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = u_xlat1.xxxx * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat1 = fract(u_xlat1);
    u_xlat1 = u_xlat1 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat1 = fract(u_xlat1);
    u_xlat1 = u_xlat1 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat3 = abs(u_xlat1) * abs(u_xlat1);
    u_xlat1 = -abs(u_xlat1) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat1 = u_xlat3 * u_xlat1 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat1.z = dot(u_xlat1, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y);
#endif
    u_xlat3.xyz = (bool(u_xlatb0)) ? _WindDirection.xyz : _miHoYo_Wind.xyz;
    u_xlat3.w = (-u_xlat3.z);
    u_xlat1.xy = u_xlat3.zx * vec2(-1.0, 1.0);
    u_xlat0.x = dot(u_xlat3.wx, u_xlat1.xy);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat4.xyz = u_xlat0.xxx * u_xlat1.xzy;
    u_xlat5 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat5;
    u_xlat0.xyz = (-u_xlat7.xyz) + u_xlat5.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.w = sqrt(u_xlat0.x);
    u_xlat7.xyz = vec3(u_xlat1.z * u_xlat4.x, u_xlat1.w * u_xlat4.y, u_xlat1.z * u_xlat4.z);
    u_xlat1.xz = u_xlat1.ww;
    u_xlat1.y = _BendIntensity;
    u_xlat7.xyz = u_xlat7.xyz * u_xlat1.xyz;
    u_xlat7.xz = u_xlat7.xz * vec2(vec2(_BendIntensity, _BendIntensity));
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SideBend, _SideBend, _SideBend));
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3 = abs(u_xlat2) * abs(u_xlat2);
    u_xlat2 = -abs(u_xlat2) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat2 = u_xlat3 * u_xlat2 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat22 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat22 = _miHoYo_WindParams1.x * _Gust + u_xlat22;
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_BendIntensity, _BendIntensity, _BendIntensity));
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat5.xyz;
    u_xlat0.xyz = u_xlat7.xyz * vec3(0.00999999978, 0.0, 0.00999999978) + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat5.wwww + u_xlat0;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    u_xlat0.x = u_xlat5.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_6 = (-u_xlat0.x) + 2.0;
    u_xlat16_6 = u_xlat0.x * u_xlat16_6;
    u_xlat1.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat7.x = u_xlat7.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat14.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat14.x = u_xlat14.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat14.x = min(max(u_xlat14.x, 0.0), 1.0);
#else
    u_xlat14.x = clamp(u_xlat14.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat14.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat14.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(u_xlat0.x>=u_xlat14.x);
#else
    u_xlatb14 = u_xlat0.x>=u_xlat14.x;
#endif
    u_xlat21 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat22 = (-u_xlat21) + 2.0;
    u_xlat21 = u_xlat21 * u_xlat22;
    u_xlat22 = u_xlat21 * _HeigtFogColDelta.w;
    u_xlat14.x = (u_xlatb14) ? u_xlat22 : u_xlat21;
    u_xlat14.x = log2(u_xlat14.x);
    u_xlat14.x = u_xlat14.x * _Mihoyo_FogColor.w;
    u_xlat14.x = exp2(u_xlat14.x);
    u_xlat14.x = min(u_xlat14.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat14.xxx * u_xlat1.xyz;
    u_xlat21 = u_xlat7.x * -1.44269502;
    u_xlat14.y = exp2(u_xlat21);
    u_xlat14.xy = (-u_xlat14.xy) + vec2(1.0, 1.0);
    u_xlat21 = u_xlat14.y / u_xlat7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.00999999978<abs(u_xlat7.x));
#else
    u_xlatb7 = 0.00999999978<abs(u_xlat7.x);
#endif
    u_xlat16_6 = (u_xlatb7) ? u_xlat21 : 1.0;
    u_xlat7.x = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat7.x * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat0.x) + 2.0;
    u_xlat16_13 = u_xlat0.x * u_xlat16_13;
    u_xlat0.x = u_xlat16_13 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_6 = u_xlat0.x * u_xlat16_6;
    u_xlat0.x = min(u_xlat16_6, _HeigtFogColBase.w);
    u_xlat7.x = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat2.w = u_xlat7.x * u_xlat14.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    vs_TEXCOORD1.xyz = in_TANGENT0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Cutoff;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
int u_xlati6;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = floor(u_xlat16_1.x);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlati6 = int(u_xlat16_1.x);
    if((u_xlati6)==0){discard;}
    u_xlat16_1.xyz = (-u_xlat10_0.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat10_0.xyz;
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
uniform 	vec4 _miHoYo_Wind;
uniform 	vec4 _miHoYo_WindParams1;
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _WindDirection;
uniform 	float _BendIntensity;
uniform 	float _BendSpeed;
uniform 	float _BendVariance;
uniform 	float _SideBend;
uniform 	float _Gust;
uniform 	float _GlobalSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TANGENT0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec4 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
float u_xlat8;
bool u_xlatb8;
vec3 u_xlat9;
mediump float u_xlat16_13;
float u_xlat15;
bool u_xlatb15;
float u_xlat21;
float u_xlat22;
void main()
{
    u_xlat0.x = _miHoYo_WindParams1.z + -1.0;
    u_xlat0.x = _GlobalSpeed * u_xlat0.x + 1.0;
    u_xlat7.x = _miHoYo_WindParams1.w * _GlobalSpeed;
    u_xlat0.x = _miHoYo_Wind.w * u_xlat0.x + u_xlat7.x;
    u_xlat7.xyz = in_TANGENT0.xyz * in_TEXCOORD1.yyy;
    u_xlat7.xyz = u_xlat7.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat7.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat7.xxx + u_xlat1.xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat7.zzz + u_xlat1.xyz;
    u_xlat7.xyz = u_xlat7.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.x = dot(u_xlat7.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat1.x = u_xlat1.x * _BendVariance;
    u_xlat0.x = u_xlat0.x * _BendSpeed + u_xlat1.x;
    u_xlat1.x = u_xlat0.x + -0.5;
    u_xlat2 = u_xlat0.xxxx * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat2 = fract(u_xlat2);
    u_xlat2 = u_xlat2 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat2 = fract(u_xlat2);
    u_xlat2 = u_xlat2 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = u_xlat1.xxxx * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat1 = fract(u_xlat1);
    u_xlat1 = u_xlat1 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat1 = fract(u_xlat1);
    u_xlat1 = u_xlat1 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat3 = abs(u_xlat1) * abs(u_xlat1);
    u_xlat1 = -abs(u_xlat1) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat1 = u_xlat3 * u_xlat1 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat1.z = dot(u_xlat1, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y);
#endif
    u_xlat3.xyz = (bool(u_xlatb0)) ? _WindDirection.xyz : _miHoYo_Wind.xyz;
    u_xlat3.w = (-u_xlat3.z);
    u_xlat1.xy = u_xlat3.zx * vec2(-1.0, 1.0);
    u_xlat0.x = dot(u_xlat3.wx, u_xlat1.xy);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat4.xyz = u_xlat0.xxx * u_xlat1.xzy;
    u_xlat5 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat5;
    u_xlat0.xyz = (-u_xlat7.xyz) + u_xlat5.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.w = sqrt(u_xlat0.x);
    u_xlat7.xyz = vec3(u_xlat1.z * u_xlat4.x, u_xlat1.w * u_xlat4.y, u_xlat1.z * u_xlat4.z);
    u_xlat1.xz = u_xlat1.ww;
    u_xlat1.y = _BendIntensity;
    u_xlat7.xyz = u_xlat7.xyz * u_xlat1.xyz;
    u_xlat7.xz = u_xlat7.xz * vec2(vec2(_BendIntensity, _BendIntensity));
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SideBend, _SideBend, _SideBend));
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3 = abs(u_xlat2) * abs(u_xlat2);
    u_xlat2 = -abs(u_xlat2) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat2 = u_xlat3 * u_xlat2 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat22 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat22 = _miHoYo_WindParams1.x * _Gust + u_xlat22;
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_BendIntensity, _BendIntensity, _BendIntensity));
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat5.xyz;
    u_xlat0.xyz = u_xlat7.xyz * vec3(0.00999999978, 0.0, 0.00999999978) + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat5.wwww + u_xlat0;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    u_xlat0.x = u_xlat5.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat0.x) + 2.0;
    u_xlat16_6 = u_xlat0.x * u_xlat16_6;
    u_xlat0.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat2.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = u_xlat5.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = sqrt(u_xlat22);
    u_xlat2.x = u_xlat22 + (-_HeigtFogRamp3.w);
    u_xlat2.x = u_xlat2.x * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat2.xxx * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.x = u_xlat22 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat8 = (-u_xlat1.x) + 2.0;
    u_xlat1.x = u_xlat8 * u_xlat1.x;
    u_xlat8 = u_xlat1.x * _HeigtFogColDelta3.w;
    u_xlat15 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat22>=u_xlat15);
#else
    u_xlatb15 = u_xlat22>=u_xlat15;
#endif
    u_xlat1.x = (u_xlatb15) ? u_xlat8 : u_xlat1.x;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Mihoyo_FogColor3.w;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = min(u_xlat1.x, _HeigtFogColBase3.w);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat8 = u_xlat2.y * _HeigtFogParams3.x;
    u_xlat2.x = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat9.x = u_xlat8 * -1.44269502;
    u_xlat9.x = exp2(u_xlat9.x);
    u_xlat9.x = (-u_xlat9.x) + 1.0;
    u_xlat9.x = u_xlat9.x / u_xlat8;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.00999999978<abs(u_xlat8));
#else
    u_xlatb8 = 0.00999999978<abs(u_xlat8);
#endif
    u_xlat16_6 = (u_xlatb8) ? u_xlat9.x : 1.0;
    u_xlat8 = u_xlat22 * _HeigtFogParams3.y;
    u_xlat16_6 = u_xlat8 * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat8 = u_xlat22 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat16_13 = (-u_xlat8) + 2.0;
    u_xlat16_13 = u_xlat8 * u_xlat16_13;
    u_xlat8 = u_xlat16_13 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat8 = u_xlat8 + 1.0;
    u_xlat16_6 = u_xlat8 * u_xlat16_6;
    u_xlat8 = min(u_xlat16_6, _HeigtFogColBase3.w);
    u_xlat9.x = (-u_xlat8) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat9.xxx;
    u_xlat3.w = u_xlat1.x * u_xlat9.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat8) + u_xlat0.xyz;
    u_xlat16_6 = (-u_xlat21) + 2.0;
    u_xlat16_6 = u_xlat21 * u_xlat16_6;
    u_xlat0.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat9.xyz = (-u_xlat0.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat21 = u_xlat22 + (-_HeigtFogRamp2.w);
    u_xlat21 = u_xlat21 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat9.xyz + u_xlat0.xyz;
    u_xlat21 = u_xlat22 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat1.x = (-u_xlat21) + 2.0;
    u_xlat21 = u_xlat21 * u_xlat1.x;
    u_xlat1.x = u_xlat21 * _HeigtFogColDelta2.w;
    u_xlat21 = (u_xlatb15) ? u_xlat1.x : u_xlat21;
    u_xlat21 = log2(u_xlat21);
    u_xlat21 = u_xlat21 * _Mihoyo_FogColor2.w;
    u_xlat21 = exp2(u_xlat21);
    u_xlat21 = min(u_xlat21, _HeigtFogColBase2.w);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat21 = (-u_xlat21) + 1.0;
    u_xlat1.x = u_xlat2.x * -1.44269502;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x / u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.00999999978<abs(u_xlat2.x));
#else
    u_xlatb8 = 0.00999999978<abs(u_xlat2.x);
#endif
    u_xlat16_6 = (u_xlatb8) ? u_xlat1.x : 1.0;
    u_xlat1.x = u_xlat22 * _HeigtFogParams2.y;
    u_xlat8 = u_xlat22 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat1.x * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat8) + 2.0;
    u_xlat16_13 = u_xlat8 * u_xlat16_13;
    u_xlat1.x = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat16_6 = u_xlat1.x * u_xlat16_6;
    u_xlat1.x = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat8 = (-u_xlat1.x) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat8);
    u_xlat2.w = u_xlat21 * u_xlat8;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat0 = (-u_xlat2) + u_xlat3;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    vs_COLOR1 = u_xlat0;
    vs_TEXCOORD1.xyz = in_TANGENT0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Cutoff;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
int u_xlati6;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = floor(u_xlat16_1.x);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlati6 = int(u_xlat16_1.x);
    if((u_xlati6)==0){discard;}
    u_xlat16_1.xyz = (-u_xlat10_0.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat10_0.xyz;
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
uniform 	vec4 _miHoYo_Wind;
uniform 	vec4 _miHoYo_WindParams1;
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _WindDirection;
uniform 	float _BendIntensity;
uniform 	float _BendSpeed;
uniform 	float _BendVariance;
uniform 	float _SideBend;
uniform 	float _Gust;
uniform 	float _GlobalSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TANGENT0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec4 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
float u_xlat8;
bool u_xlatb8;
vec3 u_xlat9;
mediump float u_xlat16_13;
float u_xlat15;
bool u_xlatb15;
float u_xlat21;
float u_xlat22;
void main()
{
    u_xlat0.x = _miHoYo_WindParams1.z + -1.0;
    u_xlat0.x = _GlobalSpeed * u_xlat0.x + 1.0;
    u_xlat7.x = _miHoYo_WindParams1.w * _GlobalSpeed;
    u_xlat0.x = _miHoYo_Wind.w * u_xlat0.x + u_xlat7.x;
    u_xlat7.xyz = in_TANGENT0.xyz * in_TEXCOORD1.yyy;
    u_xlat7.xyz = u_xlat7.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat7.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat7.xxx + u_xlat1.xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat7.zzz + u_xlat1.xyz;
    u_xlat7.xyz = u_xlat7.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.x = dot(u_xlat7.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat1.x = u_xlat1.x * _BendVariance;
    u_xlat0.x = u_xlat0.x * _BendSpeed + u_xlat1.x;
    u_xlat1.x = u_xlat0.x + -0.5;
    u_xlat2 = u_xlat0.xxxx * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat2 = fract(u_xlat2);
    u_xlat2 = u_xlat2 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat2 = fract(u_xlat2);
    u_xlat2 = u_xlat2 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = u_xlat1.xxxx * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat1 = fract(u_xlat1);
    u_xlat1 = u_xlat1 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat1 = fract(u_xlat1);
    u_xlat1 = u_xlat1 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat3 = abs(u_xlat1) * abs(u_xlat1);
    u_xlat1 = -abs(u_xlat1) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat1 = u_xlat3 * u_xlat1 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat1.z = dot(u_xlat1, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y);
#endif
    u_xlat3.xyz = (bool(u_xlatb0)) ? _WindDirection.xyz : _miHoYo_Wind.xyz;
    u_xlat3.w = (-u_xlat3.z);
    u_xlat1.xy = u_xlat3.zx * vec2(-1.0, 1.0);
    u_xlat0.x = dot(u_xlat3.wx, u_xlat1.xy);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat4.xyz = u_xlat0.xxx * u_xlat1.xzy;
    u_xlat5 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat5;
    u_xlat0.xyz = (-u_xlat7.xyz) + u_xlat5.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.w = sqrt(u_xlat0.x);
    u_xlat7.xyz = vec3(u_xlat1.z * u_xlat4.x, u_xlat1.w * u_xlat4.y, u_xlat1.z * u_xlat4.z);
    u_xlat1.xz = u_xlat1.ww;
    u_xlat1.y = _BendIntensity;
    u_xlat7.xyz = u_xlat7.xyz * u_xlat1.xyz;
    u_xlat7.xz = u_xlat7.xz * vec2(vec2(_BendIntensity, _BendIntensity));
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SideBend, _SideBend, _SideBend));
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3 = abs(u_xlat2) * abs(u_xlat2);
    u_xlat2 = -abs(u_xlat2) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat2 = u_xlat3 * u_xlat2 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat22 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat22 = _miHoYo_WindParams1.x * _Gust + u_xlat22;
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_BendIntensity, _BendIntensity, _BendIntensity));
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat5.xyz;
    u_xlat0.xyz = u_xlat7.xyz * vec3(0.00999999978, 0.0, 0.00999999978) + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat5.wwww + u_xlat0;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    u_xlat0.x = u_xlat5.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat0.x) + 2.0;
    u_xlat16_6 = u_xlat0.x * u_xlat16_6;
    u_xlat0.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat2.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = u_xlat5.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = sqrt(u_xlat22);
    u_xlat2.x = u_xlat22 + (-_HeigtFogRamp3.w);
    u_xlat2.x = u_xlat2.x * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat2.xxx * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.x = u_xlat22 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat8 = (-u_xlat1.x) + 2.0;
    u_xlat1.x = u_xlat8 * u_xlat1.x;
    u_xlat8 = u_xlat1.x * _HeigtFogColDelta3.w;
    u_xlat15 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat22>=u_xlat15);
#else
    u_xlatb15 = u_xlat22>=u_xlat15;
#endif
    u_xlat1.x = (u_xlatb15) ? u_xlat8 : u_xlat1.x;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Mihoyo_FogColor3.w;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = min(u_xlat1.x, _HeigtFogColBase3.w);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat8 = u_xlat2.y * _HeigtFogParams3.x;
    u_xlat2.x = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat9.x = u_xlat8 * -1.44269502;
    u_xlat9.x = exp2(u_xlat9.x);
    u_xlat9.x = (-u_xlat9.x) + 1.0;
    u_xlat9.x = u_xlat9.x / u_xlat8;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.00999999978<abs(u_xlat8));
#else
    u_xlatb8 = 0.00999999978<abs(u_xlat8);
#endif
    u_xlat16_6 = (u_xlatb8) ? u_xlat9.x : 1.0;
    u_xlat8 = u_xlat22 * _HeigtFogParams3.y;
    u_xlat16_6 = u_xlat8 * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat8 = u_xlat22 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat16_13 = (-u_xlat8) + 2.0;
    u_xlat16_13 = u_xlat8 * u_xlat16_13;
    u_xlat8 = u_xlat16_13 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat8 = u_xlat8 + 1.0;
    u_xlat16_6 = u_xlat8 * u_xlat16_6;
    u_xlat8 = min(u_xlat16_6, _HeigtFogColBase3.w);
    u_xlat9.x = (-u_xlat8) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat9.xxx;
    u_xlat3.w = u_xlat1.x * u_xlat9.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat8) + u_xlat0.xyz;
    u_xlat16_6 = (-u_xlat21) + 2.0;
    u_xlat16_6 = u_xlat21 * u_xlat16_6;
    u_xlat0.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat9.xyz = (-u_xlat0.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat21 = u_xlat22 + (-_HeigtFogRamp2.w);
    u_xlat21 = u_xlat21 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat9.xyz + u_xlat0.xyz;
    u_xlat21 = u_xlat22 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat1.x = (-u_xlat21) + 2.0;
    u_xlat21 = u_xlat21 * u_xlat1.x;
    u_xlat1.x = u_xlat21 * _HeigtFogColDelta2.w;
    u_xlat21 = (u_xlatb15) ? u_xlat1.x : u_xlat21;
    u_xlat21 = log2(u_xlat21);
    u_xlat21 = u_xlat21 * _Mihoyo_FogColor2.w;
    u_xlat21 = exp2(u_xlat21);
    u_xlat21 = min(u_xlat21, _HeigtFogColBase2.w);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat21 = (-u_xlat21) + 1.0;
    u_xlat1.x = u_xlat2.x * -1.44269502;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x / u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.00999999978<abs(u_xlat2.x));
#else
    u_xlatb8 = 0.00999999978<abs(u_xlat2.x);
#endif
    u_xlat16_6 = (u_xlatb8) ? u_xlat1.x : 1.0;
    u_xlat1.x = u_xlat22 * _HeigtFogParams2.y;
    u_xlat8 = u_xlat22 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat1.x * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat8) + 2.0;
    u_xlat16_13 = u_xlat8 * u_xlat16_13;
    u_xlat1.x = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat16_6 = u_xlat1.x * u_xlat16_6;
    u_xlat1.x = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat8 = (-u_xlat1.x) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat8);
    u_xlat2.w = u_xlat21 * u_xlat8;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat0 = (-u_xlat2) + u_xlat3;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    vs_COLOR1 = u_xlat0;
    vs_TEXCOORD1.xyz = in_TANGENT0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Cutoff;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
int u_xlati6;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = floor(u_xlat16_1.x);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlati6 = int(u_xlat16_1.x);
    if((u_xlati6)==0){discard;}
    u_xlat16_1.xyz = (-u_xlat10_0.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat10_0.xyz;
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
uniform 	vec4 _miHoYo_Wind;
uniform 	vec4 _miHoYo_WindParams1;
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _WindDirection;
uniform 	float _BendIntensity;
uniform 	float _BendSpeed;
uniform 	float _BendVariance;
uniform 	float _SideBend;
uniform 	float _Gust;
uniform 	float _GlobalSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TANGENT0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec4 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
float u_xlat8;
bool u_xlatb8;
vec3 u_xlat9;
mediump float u_xlat16_13;
float u_xlat15;
bool u_xlatb15;
float u_xlat21;
float u_xlat22;
void main()
{
    u_xlat0.x = _miHoYo_WindParams1.z + -1.0;
    u_xlat0.x = _GlobalSpeed * u_xlat0.x + 1.0;
    u_xlat7.x = _miHoYo_WindParams1.w * _GlobalSpeed;
    u_xlat0.x = _miHoYo_Wind.w * u_xlat0.x + u_xlat7.x;
    u_xlat7.xyz = in_TANGENT0.xyz * in_TEXCOORD1.yyy;
    u_xlat7.xyz = u_xlat7.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat7.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat7.xxx + u_xlat1.xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat7.zzz + u_xlat1.xyz;
    u_xlat7.xyz = u_xlat7.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.x = dot(u_xlat7.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat1.x = u_xlat1.x * _BendVariance;
    u_xlat0.x = u_xlat0.x * _BendSpeed + u_xlat1.x;
    u_xlat1.x = u_xlat0.x + -0.5;
    u_xlat2 = u_xlat0.xxxx * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat2 = fract(u_xlat2);
    u_xlat2 = u_xlat2 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat2 = fract(u_xlat2);
    u_xlat2 = u_xlat2 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = u_xlat1.xxxx * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat1 = fract(u_xlat1);
    u_xlat1 = u_xlat1 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat1 = fract(u_xlat1);
    u_xlat1 = u_xlat1 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat3 = abs(u_xlat1) * abs(u_xlat1);
    u_xlat1 = -abs(u_xlat1) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat1 = u_xlat3 * u_xlat1 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat1.z = dot(u_xlat1, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y);
#endif
    u_xlat3.xyz = (bool(u_xlatb0)) ? _WindDirection.xyz : _miHoYo_Wind.xyz;
    u_xlat3.w = (-u_xlat3.z);
    u_xlat1.xy = u_xlat3.zx * vec2(-1.0, 1.0);
    u_xlat0.x = dot(u_xlat3.wx, u_xlat1.xy);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat4.xyz = u_xlat0.xxx * u_xlat1.xzy;
    u_xlat5 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat5;
    u_xlat0.xyz = (-u_xlat7.xyz) + u_xlat5.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.w = sqrt(u_xlat0.x);
    u_xlat7.xyz = vec3(u_xlat1.z * u_xlat4.x, u_xlat1.w * u_xlat4.y, u_xlat1.z * u_xlat4.z);
    u_xlat1.xz = u_xlat1.ww;
    u_xlat1.y = _BendIntensity;
    u_xlat7.xyz = u_xlat7.xyz * u_xlat1.xyz;
    u_xlat7.xz = u_xlat7.xz * vec2(vec2(_BendIntensity, _BendIntensity));
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SideBend, _SideBend, _SideBend));
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3 = abs(u_xlat2) * abs(u_xlat2);
    u_xlat2 = -abs(u_xlat2) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat2 = u_xlat3 * u_xlat2 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat22 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat22 = _miHoYo_WindParams1.x * _Gust + u_xlat22;
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_BendIntensity, _BendIntensity, _BendIntensity));
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat5.xyz;
    u_xlat0.xyz = u_xlat7.xyz * vec3(0.00999999978, 0.0, 0.00999999978) + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat5.wwww + u_xlat0;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    u_xlat0.x = u_xlat5.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat0.x) + 2.0;
    u_xlat16_6 = u_xlat0.x * u_xlat16_6;
    u_xlat0.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat2.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = u_xlat5.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = sqrt(u_xlat22);
    u_xlat2.x = u_xlat22 + (-_HeigtFogRamp3.w);
    u_xlat2.x = u_xlat2.x * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat2.xxx * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.x = u_xlat22 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat8 = (-u_xlat1.x) + 2.0;
    u_xlat1.x = u_xlat8 * u_xlat1.x;
    u_xlat8 = u_xlat1.x * _HeigtFogColDelta3.w;
    u_xlat15 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat22>=u_xlat15);
#else
    u_xlatb15 = u_xlat22>=u_xlat15;
#endif
    u_xlat1.x = (u_xlatb15) ? u_xlat8 : u_xlat1.x;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Mihoyo_FogColor3.w;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = min(u_xlat1.x, _HeigtFogColBase3.w);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat8 = u_xlat2.y * _HeigtFogParams3.x;
    u_xlat2.x = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat9.x = u_xlat8 * -1.44269502;
    u_xlat9.x = exp2(u_xlat9.x);
    u_xlat9.x = (-u_xlat9.x) + 1.0;
    u_xlat9.x = u_xlat9.x / u_xlat8;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.00999999978<abs(u_xlat8));
#else
    u_xlatb8 = 0.00999999978<abs(u_xlat8);
#endif
    u_xlat16_6 = (u_xlatb8) ? u_xlat9.x : 1.0;
    u_xlat8 = u_xlat22 * _HeigtFogParams3.y;
    u_xlat16_6 = u_xlat8 * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat8 = u_xlat22 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat16_13 = (-u_xlat8) + 2.0;
    u_xlat16_13 = u_xlat8 * u_xlat16_13;
    u_xlat8 = u_xlat16_13 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat8 = u_xlat8 + 1.0;
    u_xlat16_6 = u_xlat8 * u_xlat16_6;
    u_xlat8 = min(u_xlat16_6, _HeigtFogColBase3.w);
    u_xlat9.x = (-u_xlat8) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat9.xxx;
    u_xlat3.w = u_xlat1.x * u_xlat9.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat8) + u_xlat0.xyz;
    u_xlat16_6 = (-u_xlat21) + 2.0;
    u_xlat16_6 = u_xlat21 * u_xlat16_6;
    u_xlat0.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat9.xyz = (-u_xlat0.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat21 = u_xlat22 + (-_HeigtFogRamp2.w);
    u_xlat21 = u_xlat21 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat9.xyz + u_xlat0.xyz;
    u_xlat21 = u_xlat22 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat1.x = (-u_xlat21) + 2.0;
    u_xlat21 = u_xlat21 * u_xlat1.x;
    u_xlat1.x = u_xlat21 * _HeigtFogColDelta2.w;
    u_xlat21 = (u_xlatb15) ? u_xlat1.x : u_xlat21;
    u_xlat21 = log2(u_xlat21);
    u_xlat21 = u_xlat21 * _Mihoyo_FogColor2.w;
    u_xlat21 = exp2(u_xlat21);
    u_xlat21 = min(u_xlat21, _HeigtFogColBase2.w);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat21 = (-u_xlat21) + 1.0;
    u_xlat1.x = u_xlat2.x * -1.44269502;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x / u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.00999999978<abs(u_xlat2.x));
#else
    u_xlatb8 = 0.00999999978<abs(u_xlat2.x);
#endif
    u_xlat16_6 = (u_xlatb8) ? u_xlat1.x : 1.0;
    u_xlat1.x = u_xlat22 * _HeigtFogParams2.y;
    u_xlat8 = u_xlat22 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat1.x * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat8) + 2.0;
    u_xlat16_13 = u_xlat8 * u_xlat16_13;
    u_xlat1.x = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat16_6 = u_xlat1.x * u_xlat16_6;
    u_xlat1.x = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat8 = (-u_xlat1.x) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat8);
    u_xlat2.w = u_xlat21 * u_xlat8;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat0 = (-u_xlat2) + u_xlat3;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    vs_COLOR1 = u_xlat0;
    vs_TEXCOORD1.xyz = in_TANGENT0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Cutoff;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
int u_xlati6;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = floor(u_xlat16_1.x);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlati6 = int(u_xlat16_1.x);
    if((u_xlati6)==0){discard;}
    u_xlat16_1.xyz = (-u_xlat10_0.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat10_0.xyz;
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
uniform 	vec4 _miHoYo_Wind;
uniform 	vec4 _miHoYo_WindParams1;
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _WindDirection;
uniform 	float _BendIntensity;
uniform 	float _BendSpeed;
uniform 	float _BendVariance;
uniform 	float _SideBend;
uniform 	float _Gust;
uniform 	float _GlobalSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TANGENT0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat6;
vec2 u_xlat12;
bool u_xlatb12;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.xyz = in_TANGENT0.xyz * in_TEXCOORD1.yyy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + in_POSITION0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y));
#else
    u_xlatb18 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y);
#endif
    u_xlat1.xyz = (bool(u_xlatb18)) ? _WindDirection.xyz : _miHoYo_Wind.xyz;
    u_xlat2 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat2;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat3.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat3.w = sqrt(u_xlat18);
    u_xlat0.x = dot(u_xlat0.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat0.x = u_xlat0.x * _BendVariance;
    u_xlat6.x = _miHoYo_WindParams1.z + -1.0;
    u_xlat6.x = _GlobalSpeed * u_xlat6.x + 1.0;
    u_xlat12.x = _miHoYo_WindParams1.w * _GlobalSpeed;
    u_xlat6.x = _miHoYo_Wind.w * u_xlat6.x + u_xlat12.x;
    u_xlat0.x = u_xlat6.x * _BendSpeed + u_xlat0.x;
    u_xlat4 = u_xlat0.xxxx * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat5 = abs(u_xlat4) * abs(u_xlat4);
    u_xlat4 = -abs(u_xlat4) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat4 = u_xlat5 * u_xlat4 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat6.x = dot(u_xlat4, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat6.x = _miHoYo_WindParams1.x * _Gust + u_xlat6.x;
    u_xlat12.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat4.xyz = u_xlat12.xxx * u_xlat1.xyz;
    u_xlat4.xyz = u_xlat6.xxx * u_xlat4.xyz;
    u_xlat6.xyz = vec3(u_xlat18) * u_xlat4.xyz;
    u_xlat6.xyz = u_xlat6.xyz * vec3(vec3(_BendIntensity, _BendIntensity, _BendIntensity));
    u_xlat6.xyz = u_xlat6.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat2.xyz;
    u_xlat0.x = u_xlat0.x + -0.5;
    u_xlat4 = u_xlat0.xxxx * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat5 = abs(u_xlat4) * abs(u_xlat4);
    u_xlat4 = -abs(u_xlat4) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat4 = u_xlat5 * u_xlat4 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat3.z = dot(u_xlat4, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat1.w = (-u_xlat1.z);
    u_xlat3.xy = u_xlat1.zx * vec2(-1.0, 1.0);
    u_xlat0.x = dot(u_xlat1.wx, u_xlat3.xy);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat3.xzy;
    u_xlat1.xyz = vec3(u_xlat3.z * u_xlat1.x, u_xlat3.w * u_xlat1.y, u_xlat3.z * u_xlat1.z);
    u_xlat2.xz = u_xlat3.ww;
    u_xlat2.y = _BendIntensity;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xz = u_xlat1.xz * vec2(vec2(_BendIntensity, _BendIntensity));
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_SideBend, _SideBend, _SideBend));
    u_xlat0.xyz = u_xlat1.xyz * vec3(0.00999999978, 0.0, 0.00999999978) + u_xlat6.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat12.x = sqrt(u_xlat12.x);
        u_xlat12.x = u_xlat12.x + (-_FogStartDistance);
        u_xlat12.x = max(u_xlat12.x, 0.0);
        u_xlat12.xy = u_xlat12.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat12.xy = u_xlat12.xy * (-u_xlat12.xy);
        u_xlat12.xy = u_xlat12.xy * vec2(1.44269502, 1.44269502);
        u_xlat12.xy = exp2(u_xlat12.xy);
        u_xlat12.x = (-u_xlat12.x) + 1.0;
        u_xlat12.x = u_xlat12.x * _FogEffectLimit;
        u_xlat12.x = max(u_xlat12.x, _FogEffectStart);
        u_xlat1.w = min(u_xlat12.x, _FogEffectLimit);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat12.yyy * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat12.x = sqrt(u_xlat12.x);
        u_xlat12.x = u_xlat12.x + (-_FogStartDistance);
        u_xlat12.x = max(u_xlat12.x, 0.0);
        u_xlat12.xy = u_xlat12.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat12.xy = u_xlat12.xy * vec2(500.0, 1000.0);
        u_xlat1.x = (-_FogStartDistance) + _FogEndDistance;
        u_xlat1.x = max(u_xlat1.x, 0.100000001);
        u_xlat12.xy = u_xlat12.yx / u_xlat1.xx;
        u_xlat18 = u_xlat12.y * _FogEffectLimit;
        u_xlat18 = max(u_xlat18, _FogEffectStart);
        u_xlat1.w = min(u_xlat18, _FogEffectLimit);
        u_xlat12.x = u_xlat12.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
        u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
        u_xlat12.x = (-u_xlat12.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat12.xxx * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    //ENDIF
    }
    vs_COLOR0.xyz = in_COLOR0.xyz;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD1.xyz = in_TANGENT0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Cutoff;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
int u_xlati6;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = floor(u_xlat16_1.x);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlati6 = int(u_xlat16_1.x);
    if((u_xlati6)==0){discard;}
    u_xlat16_1.xyz = (-u_xlat10_0.xyz) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat10_0.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xyz;
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
uniform 	vec4 _miHoYo_Wind;
uniform 	vec4 _miHoYo_WindParams1;
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _WindDirection;
uniform 	float _BendIntensity;
uniform 	float _BendSpeed;
uniform 	float _BendVariance;
uniform 	float _SideBend;
uniform 	float _Gust;
uniform 	float _GlobalSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TANGENT0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat6;
vec2 u_xlat12;
bool u_xlatb12;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.xyz = in_TANGENT0.xyz * in_TEXCOORD1.yyy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + in_POSITION0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y));
#else
    u_xlatb18 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y);
#endif
    u_xlat1.xyz = (bool(u_xlatb18)) ? _WindDirection.xyz : _miHoYo_Wind.xyz;
    u_xlat2 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat2;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat3.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat3.w = sqrt(u_xlat18);
    u_xlat0.x = dot(u_xlat0.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat0.x = u_xlat0.x * _BendVariance;
    u_xlat6.x = _miHoYo_WindParams1.z + -1.0;
    u_xlat6.x = _GlobalSpeed * u_xlat6.x + 1.0;
    u_xlat12.x = _miHoYo_WindParams1.w * _GlobalSpeed;
    u_xlat6.x = _miHoYo_Wind.w * u_xlat6.x + u_xlat12.x;
    u_xlat0.x = u_xlat6.x * _BendSpeed + u_xlat0.x;
    u_xlat4 = u_xlat0.xxxx * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat5 = abs(u_xlat4) * abs(u_xlat4);
    u_xlat4 = -abs(u_xlat4) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat4 = u_xlat5 * u_xlat4 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat6.x = dot(u_xlat4, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat6.x = _miHoYo_WindParams1.x * _Gust + u_xlat6.x;
    u_xlat12.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat4.xyz = u_xlat12.xxx * u_xlat1.xyz;
    u_xlat4.xyz = u_xlat6.xxx * u_xlat4.xyz;
    u_xlat6.xyz = vec3(u_xlat18) * u_xlat4.xyz;
    u_xlat6.xyz = u_xlat6.xyz * vec3(vec3(_BendIntensity, _BendIntensity, _BendIntensity));
    u_xlat6.xyz = u_xlat6.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat2.xyz;
    u_xlat0.x = u_xlat0.x + -0.5;
    u_xlat4 = u_xlat0.xxxx * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat5 = abs(u_xlat4) * abs(u_xlat4);
    u_xlat4 = -abs(u_xlat4) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat4 = u_xlat5 * u_xlat4 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat3.z = dot(u_xlat4, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat1.w = (-u_xlat1.z);
    u_xlat3.xy = u_xlat1.zx * vec2(-1.0, 1.0);
    u_xlat0.x = dot(u_xlat1.wx, u_xlat3.xy);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat3.xzy;
    u_xlat1.xyz = vec3(u_xlat3.z * u_xlat1.x, u_xlat3.w * u_xlat1.y, u_xlat3.z * u_xlat1.z);
    u_xlat2.xz = u_xlat3.ww;
    u_xlat2.y = _BendIntensity;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xz = u_xlat1.xz * vec2(vec2(_BendIntensity, _BendIntensity));
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_SideBend, _SideBend, _SideBend));
    u_xlat0.xyz = u_xlat1.xyz * vec3(0.00999999978, 0.0, 0.00999999978) + u_xlat6.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat12.x = sqrt(u_xlat12.x);
        u_xlat12.x = u_xlat12.x + (-_FogStartDistance);
        u_xlat12.x = max(u_xlat12.x, 0.0);
        u_xlat12.xy = u_xlat12.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat12.xy = u_xlat12.xy * (-u_xlat12.xy);
        u_xlat12.xy = u_xlat12.xy * vec2(1.44269502, 1.44269502);
        u_xlat12.xy = exp2(u_xlat12.xy);
        u_xlat12.x = (-u_xlat12.x) + 1.0;
        u_xlat12.x = u_xlat12.x * _FogEffectLimit;
        u_xlat12.x = max(u_xlat12.x, _FogEffectStart);
        u_xlat1.w = min(u_xlat12.x, _FogEffectLimit);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat12.yyy * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat12.x = sqrt(u_xlat12.x);
        u_xlat12.x = u_xlat12.x + (-_FogStartDistance);
        u_xlat12.x = max(u_xlat12.x, 0.0);
        u_xlat12.xy = u_xlat12.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat12.xy = u_xlat12.xy * vec2(500.0, 1000.0);
        u_xlat1.x = (-_FogStartDistance) + _FogEndDistance;
        u_xlat1.x = max(u_xlat1.x, 0.100000001);
        u_xlat12.xy = u_xlat12.yx / u_xlat1.xx;
        u_xlat18 = u_xlat12.y * _FogEffectLimit;
        u_xlat18 = max(u_xlat18, _FogEffectStart);
        u_xlat1.w = min(u_xlat18, _FogEffectLimit);
        u_xlat12.x = u_xlat12.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
        u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
        u_xlat12.x = (-u_xlat12.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat12.xxx * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    //ENDIF
    }
    vs_COLOR0.xyz = in_COLOR0.xyz;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD1.xyz = in_TANGENT0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Cutoff;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
int u_xlati6;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = floor(u_xlat16_1.x);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlati6 = int(u_xlat16_1.x);
    if((u_xlati6)==0){discard;}
    u_xlat16_1.xyz = (-u_xlat10_0.xyz) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat10_0.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xyz;
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
uniform 	vec4 _miHoYo_Wind;
uniform 	vec4 _miHoYo_WindParams1;
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _WindDirection;
uniform 	float _BendIntensity;
uniform 	float _BendSpeed;
uniform 	float _BendVariance;
uniform 	float _SideBend;
uniform 	float _Gust;
uniform 	float _GlobalSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TANGENT0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat6;
vec2 u_xlat12;
bool u_xlatb12;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.xyz = in_TANGENT0.xyz * in_TEXCOORD1.yyy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + in_POSITION0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y));
#else
    u_xlatb18 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y);
#endif
    u_xlat1.xyz = (bool(u_xlatb18)) ? _WindDirection.xyz : _miHoYo_Wind.xyz;
    u_xlat2 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat2;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat3.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat3.w = sqrt(u_xlat18);
    u_xlat0.x = dot(u_xlat0.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat0.x = u_xlat0.x * _BendVariance;
    u_xlat6.x = _miHoYo_WindParams1.z + -1.0;
    u_xlat6.x = _GlobalSpeed * u_xlat6.x + 1.0;
    u_xlat12.x = _miHoYo_WindParams1.w * _GlobalSpeed;
    u_xlat6.x = _miHoYo_Wind.w * u_xlat6.x + u_xlat12.x;
    u_xlat0.x = u_xlat6.x * _BendSpeed + u_xlat0.x;
    u_xlat4 = u_xlat0.xxxx * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat5 = abs(u_xlat4) * abs(u_xlat4);
    u_xlat4 = -abs(u_xlat4) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat4 = u_xlat5 * u_xlat4 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat6.x = dot(u_xlat4, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat6.x = _miHoYo_WindParams1.x * _Gust + u_xlat6.x;
    u_xlat12.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat4.xyz = u_xlat12.xxx * u_xlat1.xyz;
    u_xlat4.xyz = u_xlat6.xxx * u_xlat4.xyz;
    u_xlat6.xyz = vec3(u_xlat18) * u_xlat4.xyz;
    u_xlat6.xyz = u_xlat6.xyz * vec3(vec3(_BendIntensity, _BendIntensity, _BendIntensity));
    u_xlat6.xyz = u_xlat6.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat2.xyz;
    u_xlat0.x = u_xlat0.x + -0.5;
    u_xlat4 = u_xlat0.xxxx * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat5 = abs(u_xlat4) * abs(u_xlat4);
    u_xlat4 = -abs(u_xlat4) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat4 = u_xlat5 * u_xlat4 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat3.z = dot(u_xlat4, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat1.w = (-u_xlat1.z);
    u_xlat3.xy = u_xlat1.zx * vec2(-1.0, 1.0);
    u_xlat0.x = dot(u_xlat1.wx, u_xlat3.xy);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat3.xzy;
    u_xlat1.xyz = vec3(u_xlat3.z * u_xlat1.x, u_xlat3.w * u_xlat1.y, u_xlat3.z * u_xlat1.z);
    u_xlat2.xz = u_xlat3.ww;
    u_xlat2.y = _BendIntensity;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xz = u_xlat1.xz * vec2(vec2(_BendIntensity, _BendIntensity));
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_SideBend, _SideBend, _SideBend));
    u_xlat0.xyz = u_xlat1.xyz * vec3(0.00999999978, 0.0, 0.00999999978) + u_xlat6.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat12.x = sqrt(u_xlat12.x);
        u_xlat12.x = u_xlat12.x + (-_FogStartDistance);
        u_xlat12.x = max(u_xlat12.x, 0.0);
        u_xlat12.xy = u_xlat12.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat12.xy = u_xlat12.xy * (-u_xlat12.xy);
        u_xlat12.xy = u_xlat12.xy * vec2(1.44269502, 1.44269502);
        u_xlat12.xy = exp2(u_xlat12.xy);
        u_xlat12.x = (-u_xlat12.x) + 1.0;
        u_xlat12.x = u_xlat12.x * _FogEffectLimit;
        u_xlat12.x = max(u_xlat12.x, _FogEffectStart);
        u_xlat1.w = min(u_xlat12.x, _FogEffectLimit);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat12.yyy * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat12.x = sqrt(u_xlat12.x);
        u_xlat12.x = u_xlat12.x + (-_FogStartDistance);
        u_xlat12.x = max(u_xlat12.x, 0.0);
        u_xlat12.xy = u_xlat12.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat12.xy = u_xlat12.xy * vec2(500.0, 1000.0);
        u_xlat1.x = (-_FogStartDistance) + _FogEndDistance;
        u_xlat1.x = max(u_xlat1.x, 0.100000001);
        u_xlat12.xy = u_xlat12.yx / u_xlat1.xx;
        u_xlat18 = u_xlat12.y * _FogEffectLimit;
        u_xlat18 = max(u_xlat18, _FogEffectStart);
        u_xlat1.w = min(u_xlat18, _FogEffectLimit);
        u_xlat12.x = u_xlat12.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
        u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
        u_xlat12.x = (-u_xlat12.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat12.xxx * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    //ENDIF
    }
    vs_COLOR0.xyz = in_COLOR0.xyz;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD1.xyz = in_TANGENT0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Cutoff;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
int u_xlati6;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = floor(u_xlat16_1.x);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlati6 = int(u_xlat16_1.x);
    if((u_xlati6)==0){discard;}
    u_xlat16_1.xyz = (-u_xlat10_0.xyz) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat10_0.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
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
uniform 	vec4 _miHoYo_Wind;
uniform 	vec4 _miHoYo_WindParams1;
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _WindDirection;
uniform 	float _BendIntensity;
uniform 	float _BendSpeed;
uniform 	float _BendVariance;
uniform 	float _SideBend;
uniform 	float _Gust;
uniform 	float _GlobalSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TANGENT0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat6;
vec2 u_xlat12;
bool u_xlatb12;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.xyz = in_TANGENT0.xyz * in_TEXCOORD1.yyy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + in_POSITION0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y));
#else
    u_xlatb18 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y);
#endif
    u_xlat1.xyz = (bool(u_xlatb18)) ? _WindDirection.xyz : _miHoYo_Wind.xyz;
    u_xlat2 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat2;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat3.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat3.w = sqrt(u_xlat18);
    u_xlat0.x = dot(u_xlat0.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat0.x = u_xlat0.x * _BendVariance;
    u_xlat6.x = _miHoYo_WindParams1.z + -1.0;
    u_xlat6.x = _GlobalSpeed * u_xlat6.x + 1.0;
    u_xlat12.x = _miHoYo_WindParams1.w * _GlobalSpeed;
    u_xlat6.x = _miHoYo_Wind.w * u_xlat6.x + u_xlat12.x;
    u_xlat0.x = u_xlat6.x * _BendSpeed + u_xlat0.x;
    u_xlat4 = u_xlat0.xxxx * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat5 = abs(u_xlat4) * abs(u_xlat4);
    u_xlat4 = -abs(u_xlat4) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat4 = u_xlat5 * u_xlat4 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat6.x = dot(u_xlat4, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat6.x = _miHoYo_WindParams1.x * _Gust + u_xlat6.x;
    u_xlat12.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat4.xyz = u_xlat12.xxx * u_xlat1.xyz;
    u_xlat4.xyz = u_xlat6.xxx * u_xlat4.xyz;
    u_xlat6.xyz = vec3(u_xlat18) * u_xlat4.xyz;
    u_xlat6.xyz = u_xlat6.xyz * vec3(vec3(_BendIntensity, _BendIntensity, _BendIntensity));
    u_xlat6.xyz = u_xlat6.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat2.xyz;
    u_xlat0.x = u_xlat0.x + -0.5;
    u_xlat4 = u_xlat0.xxxx * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat5 = abs(u_xlat4) * abs(u_xlat4);
    u_xlat4 = -abs(u_xlat4) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat4 = u_xlat5 * u_xlat4 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat3.z = dot(u_xlat4, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat1.w = (-u_xlat1.z);
    u_xlat3.xy = u_xlat1.zx * vec2(-1.0, 1.0);
    u_xlat0.x = dot(u_xlat1.wx, u_xlat3.xy);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat3.xzy;
    u_xlat1.xyz = vec3(u_xlat3.z * u_xlat1.x, u_xlat3.w * u_xlat1.y, u_xlat3.z * u_xlat1.z);
    u_xlat2.xz = u_xlat3.ww;
    u_xlat2.y = _BendIntensity;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xz = u_xlat1.xz * vec2(vec2(_BendIntensity, _BendIntensity));
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_SideBend, _SideBend, _SideBend));
    u_xlat0.xyz = u_xlat1.xyz * vec3(0.00999999978, 0.0, 0.00999999978) + u_xlat6.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat12.x = sqrt(u_xlat12.x);
        u_xlat12.x = u_xlat12.x + (-_FogStartDistance);
        u_xlat12.x = max(u_xlat12.x, 0.0);
        u_xlat12.xy = u_xlat12.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat12.xy = u_xlat12.xy * (-u_xlat12.xy);
        u_xlat12.xy = u_xlat12.xy * vec2(1.44269502, 1.44269502);
        u_xlat12.xy = exp2(u_xlat12.xy);
        u_xlat12.x = (-u_xlat12.x) + 1.0;
        u_xlat12.x = u_xlat12.x * _FogEffectLimit;
        u_xlat12.x = max(u_xlat12.x, _FogEffectStart);
        u_xlat1.w = min(u_xlat12.x, _FogEffectLimit);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat12.yyy * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat12.x = sqrt(u_xlat12.x);
        u_xlat12.x = u_xlat12.x + (-_FogStartDistance);
        u_xlat12.x = max(u_xlat12.x, 0.0);
        u_xlat12.xy = u_xlat12.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat12.xy = u_xlat12.xy * vec2(500.0, 1000.0);
        u_xlat1.x = (-_FogStartDistance) + _FogEndDistance;
        u_xlat1.x = max(u_xlat1.x, 0.100000001);
        u_xlat12.xy = u_xlat12.yx / u_xlat1.xx;
        u_xlat18 = u_xlat12.y * _FogEffectLimit;
        u_xlat18 = max(u_xlat18, _FogEffectStart);
        u_xlat1.w = min(u_xlat18, _FogEffectLimit);
        u_xlat12.x = u_xlat12.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
        u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
        u_xlat12.x = (-u_xlat12.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat12.xxx * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    //ENDIF
    }
    vs_COLOR0.xyz = in_COLOR0.xyz;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD1.xyz = in_TANGENT0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Cutoff;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
int u_xlati6;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = floor(u_xlat16_1.x);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlati6 = int(u_xlat16_1.x);
    if((u_xlati6)==0){discard;}
    u_xlat16_1.xyz = (-u_xlat10_0.xyz) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat10_0.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xyz;
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
uniform 	vec4 _miHoYo_Wind;
uniform 	vec4 _miHoYo_WindParams1;
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _WindDirection;
uniform 	float _BendIntensity;
uniform 	float _BendSpeed;
uniform 	float _BendVariance;
uniform 	float _SideBend;
uniform 	float _Gust;
uniform 	float _GlobalSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TANGENT0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat6;
vec2 u_xlat12;
bool u_xlatb12;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.xyz = in_TANGENT0.xyz * in_TEXCOORD1.yyy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + in_POSITION0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y));
#else
    u_xlatb18 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y);
#endif
    u_xlat1.xyz = (bool(u_xlatb18)) ? _WindDirection.xyz : _miHoYo_Wind.xyz;
    u_xlat2 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat2;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat3.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat3.w = sqrt(u_xlat18);
    u_xlat0.x = dot(u_xlat0.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat0.x = u_xlat0.x * _BendVariance;
    u_xlat6.x = _miHoYo_WindParams1.z + -1.0;
    u_xlat6.x = _GlobalSpeed * u_xlat6.x + 1.0;
    u_xlat12.x = _miHoYo_WindParams1.w * _GlobalSpeed;
    u_xlat6.x = _miHoYo_Wind.w * u_xlat6.x + u_xlat12.x;
    u_xlat0.x = u_xlat6.x * _BendSpeed + u_xlat0.x;
    u_xlat4 = u_xlat0.xxxx * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat5 = abs(u_xlat4) * abs(u_xlat4);
    u_xlat4 = -abs(u_xlat4) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat4 = u_xlat5 * u_xlat4 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat6.x = dot(u_xlat4, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat6.x = _miHoYo_WindParams1.x * _Gust + u_xlat6.x;
    u_xlat12.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat4.xyz = u_xlat12.xxx * u_xlat1.xyz;
    u_xlat4.xyz = u_xlat6.xxx * u_xlat4.xyz;
    u_xlat6.xyz = vec3(u_xlat18) * u_xlat4.xyz;
    u_xlat6.xyz = u_xlat6.xyz * vec3(vec3(_BendIntensity, _BendIntensity, _BendIntensity));
    u_xlat6.xyz = u_xlat6.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat2.xyz;
    u_xlat0.x = u_xlat0.x + -0.5;
    u_xlat4 = u_xlat0.xxxx * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat5 = abs(u_xlat4) * abs(u_xlat4);
    u_xlat4 = -abs(u_xlat4) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat4 = u_xlat5 * u_xlat4 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat3.z = dot(u_xlat4, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat1.w = (-u_xlat1.z);
    u_xlat3.xy = u_xlat1.zx * vec2(-1.0, 1.0);
    u_xlat0.x = dot(u_xlat1.wx, u_xlat3.xy);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat3.xzy;
    u_xlat1.xyz = vec3(u_xlat3.z * u_xlat1.x, u_xlat3.w * u_xlat1.y, u_xlat3.z * u_xlat1.z);
    u_xlat2.xz = u_xlat3.ww;
    u_xlat2.y = _BendIntensity;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xz = u_xlat1.xz * vec2(vec2(_BendIntensity, _BendIntensity));
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_SideBend, _SideBend, _SideBend));
    u_xlat0.xyz = u_xlat1.xyz * vec3(0.00999999978, 0.0, 0.00999999978) + u_xlat6.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat12.x = sqrt(u_xlat12.x);
        u_xlat12.x = u_xlat12.x + (-_FogStartDistance);
        u_xlat12.x = max(u_xlat12.x, 0.0);
        u_xlat12.xy = u_xlat12.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat12.xy = u_xlat12.xy * (-u_xlat12.xy);
        u_xlat12.xy = u_xlat12.xy * vec2(1.44269502, 1.44269502);
        u_xlat12.xy = exp2(u_xlat12.xy);
        u_xlat12.x = (-u_xlat12.x) + 1.0;
        u_xlat12.x = u_xlat12.x * _FogEffectLimit;
        u_xlat12.x = max(u_xlat12.x, _FogEffectStart);
        u_xlat1.w = min(u_xlat12.x, _FogEffectLimit);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat12.yyy * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat12.x = sqrt(u_xlat12.x);
        u_xlat12.x = u_xlat12.x + (-_FogStartDistance);
        u_xlat12.x = max(u_xlat12.x, 0.0);
        u_xlat12.xy = u_xlat12.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat12.xy = u_xlat12.xy * vec2(500.0, 1000.0);
        u_xlat1.x = (-_FogStartDistance) + _FogEndDistance;
        u_xlat1.x = max(u_xlat1.x, 0.100000001);
        u_xlat12.xy = u_xlat12.yx / u_xlat1.xx;
        u_xlat18 = u_xlat12.y * _FogEffectLimit;
        u_xlat18 = max(u_xlat18, _FogEffectStart);
        u_xlat1.w = min(u_xlat18, _FogEffectLimit);
        u_xlat12.x = u_xlat12.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
        u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
        u_xlat12.x = (-u_xlat12.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat12.xxx * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    //ENDIF
    }
    vs_COLOR0.xyz = in_COLOR0.xyz;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD1.xyz = in_TANGENT0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Cutoff;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
int u_xlati6;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = floor(u_xlat16_1.x);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlati6 = int(u_xlat16_1.x);
    if((u_xlati6)==0){discard;}
    u_xlat16_1.xyz = (-u_xlat10_0.xyz) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat10_0.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xyz;
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
uniform 	vec4 _miHoYo_Wind;
uniform 	vec4 _miHoYo_WindParams1;
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _WindDirection;
uniform 	float _BendIntensity;
uniform 	float _BendSpeed;
uniform 	float _BendVariance;
uniform 	float _SideBend;
uniform 	float _Gust;
uniform 	float _GlobalSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TANGENT0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat6;
vec2 u_xlat12;
bool u_xlatb12;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.xyz = in_TANGENT0.xyz * in_TEXCOORD1.yyy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + in_POSITION0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y));
#else
    u_xlatb18 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y);
#endif
    u_xlat1.xyz = (bool(u_xlatb18)) ? _WindDirection.xyz : _miHoYo_Wind.xyz;
    u_xlat2 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat2;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat3.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat3.w = sqrt(u_xlat18);
    u_xlat0.x = dot(u_xlat0.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat0.x = u_xlat0.x * _BendVariance;
    u_xlat6.x = _miHoYo_WindParams1.z + -1.0;
    u_xlat6.x = _GlobalSpeed * u_xlat6.x + 1.0;
    u_xlat12.x = _miHoYo_WindParams1.w * _GlobalSpeed;
    u_xlat6.x = _miHoYo_Wind.w * u_xlat6.x + u_xlat12.x;
    u_xlat0.x = u_xlat6.x * _BendSpeed + u_xlat0.x;
    u_xlat4 = u_xlat0.xxxx * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat5 = abs(u_xlat4) * abs(u_xlat4);
    u_xlat4 = -abs(u_xlat4) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat4 = u_xlat5 * u_xlat4 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat6.x = dot(u_xlat4, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat6.x = _miHoYo_WindParams1.x * _Gust + u_xlat6.x;
    u_xlat12.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat4.xyz = u_xlat12.xxx * u_xlat1.xyz;
    u_xlat4.xyz = u_xlat6.xxx * u_xlat4.xyz;
    u_xlat6.xyz = vec3(u_xlat18) * u_xlat4.xyz;
    u_xlat6.xyz = u_xlat6.xyz * vec3(vec3(_BendIntensity, _BendIntensity, _BendIntensity));
    u_xlat6.xyz = u_xlat6.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat2.xyz;
    u_xlat0.x = u_xlat0.x + -0.5;
    u_xlat4 = u_xlat0.xxxx * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat4 = fract(u_xlat4);
    u_xlat4 = u_xlat4 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat5 = abs(u_xlat4) * abs(u_xlat4);
    u_xlat4 = -abs(u_xlat4) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat4 = u_xlat5 * u_xlat4 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat3.z = dot(u_xlat4, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat1.w = (-u_xlat1.z);
    u_xlat3.xy = u_xlat1.zx * vec2(-1.0, 1.0);
    u_xlat0.x = dot(u_xlat1.wx, u_xlat3.xy);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat3.xzy;
    u_xlat1.xyz = vec3(u_xlat3.z * u_xlat1.x, u_xlat3.w * u_xlat1.y, u_xlat3.z * u_xlat1.z);
    u_xlat2.xz = u_xlat3.ww;
    u_xlat2.y = _BendIntensity;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xz = u_xlat1.xz * vec2(vec2(_BendIntensity, _BendIntensity));
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_SideBend, _SideBend, _SideBend));
    u_xlat0.xyz = u_xlat1.xyz * vec3(0.00999999978, 0.0, 0.00999999978) + u_xlat6.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat12.x = sqrt(u_xlat12.x);
        u_xlat12.x = u_xlat12.x + (-_FogStartDistance);
        u_xlat12.x = max(u_xlat12.x, 0.0);
        u_xlat12.xy = u_xlat12.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat12.xy = u_xlat12.xy * (-u_xlat12.xy);
        u_xlat12.xy = u_xlat12.xy * vec2(1.44269502, 1.44269502);
        u_xlat12.xy = exp2(u_xlat12.xy);
        u_xlat12.x = (-u_xlat12.x) + 1.0;
        u_xlat12.x = u_xlat12.x * _FogEffectLimit;
        u_xlat12.x = max(u_xlat12.x, _FogEffectStart);
        u_xlat1.w = min(u_xlat12.x, _FogEffectLimit);
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat12.yyy * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat12.x = sqrt(u_xlat12.x);
        u_xlat12.x = u_xlat12.x + (-_FogStartDistance);
        u_xlat12.x = max(u_xlat12.x, 0.0);
        u_xlat12.xy = u_xlat12.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat12.xy = u_xlat12.xy * vec2(500.0, 1000.0);
        u_xlat1.x = (-_FogStartDistance) + _FogEndDistance;
        u_xlat1.x = max(u_xlat1.x, 0.100000001);
        u_xlat12.xy = u_xlat12.yx / u_xlat1.xx;
        u_xlat18 = u_xlat12.y * _FogEffectLimit;
        u_xlat18 = max(u_xlat18, _FogEffectStart);
        u_xlat1.w = min(u_xlat18, _FogEffectLimit);
        u_xlat12.x = u_xlat12.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
        u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
        u_xlat12.x = (-u_xlat12.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat12.xxx * u_xlat2.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat1;
    //ENDIF
    }
    vs_COLOR0.xyz = in_COLOR0.xyz;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD1.xyz = in_TANGENT0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Cutoff;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
int u_xlati6;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = floor(u_xlat16_1.x);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlati6 = int(u_xlat16_1.x);
    if((u_xlati6)==0){discard;}
    u_xlat16_1.xyz = (-u_xlat10_0.xyz) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat10_0.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
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
uniform 	vec4 _miHoYo_Wind;
uniform 	vec4 _miHoYo_WindParams1;
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _WindDirection;
uniform 	float _BendIntensity;
uniform 	float _BendSpeed;
uniform 	float _BendVariance;
uniform 	float _SideBend;
uniform 	float _Gust;
uniform 	float _GlobalSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TANGENT0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec4 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
bool u_xlatb7;
mediump float u_xlat16_13;
vec2 u_xlat14;
bool u_xlatb14;
float u_xlat21;
float u_xlat22;
void main()
{
    u_xlat0.x = _miHoYo_WindParams1.z + -1.0;
    u_xlat0.x = _GlobalSpeed * u_xlat0.x + 1.0;
    u_xlat7.x = _miHoYo_WindParams1.w * _GlobalSpeed;
    u_xlat0.x = _miHoYo_Wind.w * u_xlat0.x + u_xlat7.x;
    u_xlat7.xyz = in_TANGENT0.xyz * in_TEXCOORD1.yyy;
    u_xlat7.xyz = u_xlat7.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat7.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat7.xxx + u_xlat1.xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat7.zzz + u_xlat1.xyz;
    u_xlat7.xyz = u_xlat7.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.x = dot(u_xlat7.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat1.x = u_xlat1.x * _BendVariance;
    u_xlat0.x = u_xlat0.x * _BendSpeed + u_xlat1.x;
    u_xlat1.x = u_xlat0.x + -0.5;
    u_xlat2 = u_xlat0.xxxx * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat2 = fract(u_xlat2);
    u_xlat2 = u_xlat2 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat2 = fract(u_xlat2);
    u_xlat2 = u_xlat2 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = u_xlat1.xxxx * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat1 = fract(u_xlat1);
    u_xlat1 = u_xlat1 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat1 = fract(u_xlat1);
    u_xlat1 = u_xlat1 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat3 = abs(u_xlat1) * abs(u_xlat1);
    u_xlat1 = -abs(u_xlat1) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat1 = u_xlat3 * u_xlat1 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat1.z = dot(u_xlat1, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y);
#endif
    u_xlat3.xyz = (bool(u_xlatb0)) ? _WindDirection.xyz : _miHoYo_Wind.xyz;
    u_xlat3.w = (-u_xlat3.z);
    u_xlat1.xy = u_xlat3.zx * vec2(-1.0, 1.0);
    u_xlat0.x = dot(u_xlat3.wx, u_xlat1.xy);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat4.xyz = u_xlat0.xxx * u_xlat1.xzy;
    u_xlat5 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat5;
    u_xlat0.xyz = (-u_xlat7.xyz) + u_xlat5.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.w = sqrt(u_xlat0.x);
    u_xlat7.xyz = vec3(u_xlat1.z * u_xlat4.x, u_xlat1.w * u_xlat4.y, u_xlat1.z * u_xlat4.z);
    u_xlat1.xz = u_xlat1.ww;
    u_xlat1.y = _BendIntensity;
    u_xlat7.xyz = u_xlat7.xyz * u_xlat1.xyz;
    u_xlat7.xz = u_xlat7.xz * vec2(vec2(_BendIntensity, _BendIntensity));
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SideBend, _SideBend, _SideBend));
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3 = abs(u_xlat2) * abs(u_xlat2);
    u_xlat2 = -abs(u_xlat2) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat2 = u_xlat3 * u_xlat2 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat22 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat22 = _miHoYo_WindParams1.x * _Gust + u_xlat22;
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_BendIntensity, _BendIntensity, _BendIntensity));
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat5.xyz;
    u_xlat0.xyz = u_xlat7.xyz * vec3(0.00999999978, 0.0, 0.00999999978) + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat5.wwww + u_xlat0;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    u_xlat0.x = u_xlat5.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_6 = (-u_xlat0.x) + 2.0;
    u_xlat16_6 = u_xlat0.x * u_xlat16_6;
    u_xlat1.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat7.x = u_xlat7.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat14.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat14.x = u_xlat14.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat14.x = min(max(u_xlat14.x, 0.0), 1.0);
#else
    u_xlat14.x = clamp(u_xlat14.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat14.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat14.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(u_xlat0.x>=u_xlat14.x);
#else
    u_xlatb14 = u_xlat0.x>=u_xlat14.x;
#endif
    u_xlat21 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat22 = (-u_xlat21) + 2.0;
    u_xlat21 = u_xlat21 * u_xlat22;
    u_xlat22 = u_xlat21 * _HeigtFogColDelta.w;
    u_xlat14.x = (u_xlatb14) ? u_xlat22 : u_xlat21;
    u_xlat14.x = log2(u_xlat14.x);
    u_xlat14.x = u_xlat14.x * _Mihoyo_FogColor.w;
    u_xlat14.x = exp2(u_xlat14.x);
    u_xlat14.x = min(u_xlat14.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat14.xxx * u_xlat1.xyz;
    u_xlat21 = u_xlat7.x * -1.44269502;
    u_xlat14.y = exp2(u_xlat21);
    u_xlat14.xy = (-u_xlat14.xy) + vec2(1.0, 1.0);
    u_xlat21 = u_xlat14.y / u_xlat7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.00999999978<abs(u_xlat7.x));
#else
    u_xlatb7 = 0.00999999978<abs(u_xlat7.x);
#endif
    u_xlat16_6 = (u_xlatb7) ? u_xlat21 : 1.0;
    u_xlat7.x = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat7.x * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat0.x) + 2.0;
    u_xlat16_13 = u_xlat0.x * u_xlat16_13;
    u_xlat0.x = u_xlat16_13 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_6 = u_xlat0.x * u_xlat16_6;
    u_xlat0.x = min(u_xlat16_6, _HeigtFogColBase.w);
    u_xlat7.x = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat2.w = u_xlat7.x * u_xlat14.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    vs_TEXCOORD1.xyz = in_TANGENT0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Cutoff;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
int u_xlati6;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = floor(u_xlat16_1.x);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlati6 = int(u_xlat16_1.x);
    if((u_xlati6)==0){discard;}
    u_xlat16_1.xyz = (-u_xlat10_0.xyz) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat10_0.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xyz;
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
uniform 	vec4 _miHoYo_Wind;
uniform 	vec4 _miHoYo_WindParams1;
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _WindDirection;
uniform 	float _BendIntensity;
uniform 	float _BendSpeed;
uniform 	float _BendVariance;
uniform 	float _SideBend;
uniform 	float _Gust;
uniform 	float _GlobalSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TANGENT0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec4 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
bool u_xlatb7;
mediump float u_xlat16_13;
vec2 u_xlat14;
bool u_xlatb14;
float u_xlat21;
float u_xlat22;
void main()
{
    u_xlat0.x = _miHoYo_WindParams1.z + -1.0;
    u_xlat0.x = _GlobalSpeed * u_xlat0.x + 1.0;
    u_xlat7.x = _miHoYo_WindParams1.w * _GlobalSpeed;
    u_xlat0.x = _miHoYo_Wind.w * u_xlat0.x + u_xlat7.x;
    u_xlat7.xyz = in_TANGENT0.xyz * in_TEXCOORD1.yyy;
    u_xlat7.xyz = u_xlat7.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat7.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat7.xxx + u_xlat1.xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat7.zzz + u_xlat1.xyz;
    u_xlat7.xyz = u_xlat7.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.x = dot(u_xlat7.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat1.x = u_xlat1.x * _BendVariance;
    u_xlat0.x = u_xlat0.x * _BendSpeed + u_xlat1.x;
    u_xlat1.x = u_xlat0.x + -0.5;
    u_xlat2 = u_xlat0.xxxx * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat2 = fract(u_xlat2);
    u_xlat2 = u_xlat2 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat2 = fract(u_xlat2);
    u_xlat2 = u_xlat2 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = u_xlat1.xxxx * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat1 = fract(u_xlat1);
    u_xlat1 = u_xlat1 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat1 = fract(u_xlat1);
    u_xlat1 = u_xlat1 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat3 = abs(u_xlat1) * abs(u_xlat1);
    u_xlat1 = -abs(u_xlat1) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat1 = u_xlat3 * u_xlat1 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat1.z = dot(u_xlat1, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y);
#endif
    u_xlat3.xyz = (bool(u_xlatb0)) ? _WindDirection.xyz : _miHoYo_Wind.xyz;
    u_xlat3.w = (-u_xlat3.z);
    u_xlat1.xy = u_xlat3.zx * vec2(-1.0, 1.0);
    u_xlat0.x = dot(u_xlat3.wx, u_xlat1.xy);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat4.xyz = u_xlat0.xxx * u_xlat1.xzy;
    u_xlat5 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat5;
    u_xlat0.xyz = (-u_xlat7.xyz) + u_xlat5.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.w = sqrt(u_xlat0.x);
    u_xlat7.xyz = vec3(u_xlat1.z * u_xlat4.x, u_xlat1.w * u_xlat4.y, u_xlat1.z * u_xlat4.z);
    u_xlat1.xz = u_xlat1.ww;
    u_xlat1.y = _BendIntensity;
    u_xlat7.xyz = u_xlat7.xyz * u_xlat1.xyz;
    u_xlat7.xz = u_xlat7.xz * vec2(vec2(_BendIntensity, _BendIntensity));
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SideBend, _SideBend, _SideBend));
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3 = abs(u_xlat2) * abs(u_xlat2);
    u_xlat2 = -abs(u_xlat2) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat2 = u_xlat3 * u_xlat2 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat22 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat22 = _miHoYo_WindParams1.x * _Gust + u_xlat22;
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_BendIntensity, _BendIntensity, _BendIntensity));
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat5.xyz;
    u_xlat0.xyz = u_xlat7.xyz * vec3(0.00999999978, 0.0, 0.00999999978) + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat5.wwww + u_xlat0;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    u_xlat0.x = u_xlat5.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_6 = (-u_xlat0.x) + 2.0;
    u_xlat16_6 = u_xlat0.x * u_xlat16_6;
    u_xlat1.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat7.x = u_xlat7.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat14.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat14.x = u_xlat14.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat14.x = min(max(u_xlat14.x, 0.0), 1.0);
#else
    u_xlat14.x = clamp(u_xlat14.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat14.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat14.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(u_xlat0.x>=u_xlat14.x);
#else
    u_xlatb14 = u_xlat0.x>=u_xlat14.x;
#endif
    u_xlat21 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat22 = (-u_xlat21) + 2.0;
    u_xlat21 = u_xlat21 * u_xlat22;
    u_xlat22 = u_xlat21 * _HeigtFogColDelta.w;
    u_xlat14.x = (u_xlatb14) ? u_xlat22 : u_xlat21;
    u_xlat14.x = log2(u_xlat14.x);
    u_xlat14.x = u_xlat14.x * _Mihoyo_FogColor.w;
    u_xlat14.x = exp2(u_xlat14.x);
    u_xlat14.x = min(u_xlat14.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat14.xxx * u_xlat1.xyz;
    u_xlat21 = u_xlat7.x * -1.44269502;
    u_xlat14.y = exp2(u_xlat21);
    u_xlat14.xy = (-u_xlat14.xy) + vec2(1.0, 1.0);
    u_xlat21 = u_xlat14.y / u_xlat7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.00999999978<abs(u_xlat7.x));
#else
    u_xlatb7 = 0.00999999978<abs(u_xlat7.x);
#endif
    u_xlat16_6 = (u_xlatb7) ? u_xlat21 : 1.0;
    u_xlat7.x = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat7.x * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat0.x) + 2.0;
    u_xlat16_13 = u_xlat0.x * u_xlat16_13;
    u_xlat0.x = u_xlat16_13 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_6 = u_xlat0.x * u_xlat16_6;
    u_xlat0.x = min(u_xlat16_6, _HeigtFogColBase.w);
    u_xlat7.x = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat2.w = u_xlat7.x * u_xlat14.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    vs_TEXCOORD1.xyz = in_TANGENT0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Cutoff;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
int u_xlati6;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = floor(u_xlat16_1.x);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlati6 = int(u_xlat16_1.x);
    if((u_xlati6)==0){discard;}
    u_xlat16_1.xyz = (-u_xlat10_0.xyz) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat10_0.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xyz;
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
uniform 	vec4 _miHoYo_Wind;
uniform 	vec4 _miHoYo_WindParams1;
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _WindDirection;
uniform 	float _BendIntensity;
uniform 	float _BendSpeed;
uniform 	float _BendVariance;
uniform 	float _SideBend;
uniform 	float _Gust;
uniform 	float _GlobalSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TANGENT0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec4 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
bool u_xlatb7;
mediump float u_xlat16_13;
vec2 u_xlat14;
bool u_xlatb14;
float u_xlat21;
float u_xlat22;
void main()
{
    u_xlat0.x = _miHoYo_WindParams1.z + -1.0;
    u_xlat0.x = _GlobalSpeed * u_xlat0.x + 1.0;
    u_xlat7.x = _miHoYo_WindParams1.w * _GlobalSpeed;
    u_xlat0.x = _miHoYo_Wind.w * u_xlat0.x + u_xlat7.x;
    u_xlat7.xyz = in_TANGENT0.xyz * in_TEXCOORD1.yyy;
    u_xlat7.xyz = u_xlat7.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat7.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat7.xxx + u_xlat1.xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat7.zzz + u_xlat1.xyz;
    u_xlat7.xyz = u_xlat7.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.x = dot(u_xlat7.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat1.x = u_xlat1.x * _BendVariance;
    u_xlat0.x = u_xlat0.x * _BendSpeed + u_xlat1.x;
    u_xlat1.x = u_xlat0.x + -0.5;
    u_xlat2 = u_xlat0.xxxx * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat2 = fract(u_xlat2);
    u_xlat2 = u_xlat2 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat2 = fract(u_xlat2);
    u_xlat2 = u_xlat2 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = u_xlat1.xxxx * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat1 = fract(u_xlat1);
    u_xlat1 = u_xlat1 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat1 = fract(u_xlat1);
    u_xlat1 = u_xlat1 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat3 = abs(u_xlat1) * abs(u_xlat1);
    u_xlat1 = -abs(u_xlat1) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat1 = u_xlat3 * u_xlat1 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat1.z = dot(u_xlat1, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y);
#endif
    u_xlat3.xyz = (bool(u_xlatb0)) ? _WindDirection.xyz : _miHoYo_Wind.xyz;
    u_xlat3.w = (-u_xlat3.z);
    u_xlat1.xy = u_xlat3.zx * vec2(-1.0, 1.0);
    u_xlat0.x = dot(u_xlat3.wx, u_xlat1.xy);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat4.xyz = u_xlat0.xxx * u_xlat1.xzy;
    u_xlat5 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat5;
    u_xlat0.xyz = (-u_xlat7.xyz) + u_xlat5.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.w = sqrt(u_xlat0.x);
    u_xlat7.xyz = vec3(u_xlat1.z * u_xlat4.x, u_xlat1.w * u_xlat4.y, u_xlat1.z * u_xlat4.z);
    u_xlat1.xz = u_xlat1.ww;
    u_xlat1.y = _BendIntensity;
    u_xlat7.xyz = u_xlat7.xyz * u_xlat1.xyz;
    u_xlat7.xz = u_xlat7.xz * vec2(vec2(_BendIntensity, _BendIntensity));
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SideBend, _SideBend, _SideBend));
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3 = abs(u_xlat2) * abs(u_xlat2);
    u_xlat2 = -abs(u_xlat2) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat2 = u_xlat3 * u_xlat2 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat22 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat22 = _miHoYo_WindParams1.x * _Gust + u_xlat22;
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_BendIntensity, _BendIntensity, _BendIntensity));
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat5.xyz;
    u_xlat0.xyz = u_xlat7.xyz * vec3(0.00999999978, 0.0, 0.00999999978) + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat5.wwww + u_xlat0;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    u_xlat0.x = u_xlat5.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_6 = (-u_xlat0.x) + 2.0;
    u_xlat16_6 = u_xlat0.x * u_xlat16_6;
    u_xlat1.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat7.x = u_xlat7.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat14.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat14.x = u_xlat14.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat14.x = min(max(u_xlat14.x, 0.0), 1.0);
#else
    u_xlat14.x = clamp(u_xlat14.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat14.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat14.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(u_xlat0.x>=u_xlat14.x);
#else
    u_xlatb14 = u_xlat0.x>=u_xlat14.x;
#endif
    u_xlat21 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat22 = (-u_xlat21) + 2.0;
    u_xlat21 = u_xlat21 * u_xlat22;
    u_xlat22 = u_xlat21 * _HeigtFogColDelta.w;
    u_xlat14.x = (u_xlatb14) ? u_xlat22 : u_xlat21;
    u_xlat14.x = log2(u_xlat14.x);
    u_xlat14.x = u_xlat14.x * _Mihoyo_FogColor.w;
    u_xlat14.x = exp2(u_xlat14.x);
    u_xlat14.x = min(u_xlat14.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat14.xxx * u_xlat1.xyz;
    u_xlat21 = u_xlat7.x * -1.44269502;
    u_xlat14.y = exp2(u_xlat21);
    u_xlat14.xy = (-u_xlat14.xy) + vec2(1.0, 1.0);
    u_xlat21 = u_xlat14.y / u_xlat7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.00999999978<abs(u_xlat7.x));
#else
    u_xlatb7 = 0.00999999978<abs(u_xlat7.x);
#endif
    u_xlat16_6 = (u_xlatb7) ? u_xlat21 : 1.0;
    u_xlat7.x = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat7.x * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat0.x) + 2.0;
    u_xlat16_13 = u_xlat0.x * u_xlat16_13;
    u_xlat0.x = u_xlat16_13 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_6 = u_xlat0.x * u_xlat16_6;
    u_xlat0.x = min(u_xlat16_6, _HeigtFogColBase.w);
    u_xlat7.x = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat2.w = u_xlat7.x * u_xlat14.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    vs_TEXCOORD1.xyz = in_TANGENT0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Cutoff;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
int u_xlati6;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = floor(u_xlat16_1.x);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlati6 = int(u_xlat16_1.x);
    if((u_xlati6)==0){discard;}
    u_xlat16_1.xyz = (-u_xlat10_0.xyz) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat10_0.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
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
uniform 	vec4 _miHoYo_Wind;
uniform 	vec4 _miHoYo_WindParams1;
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _WindDirection;
uniform 	float _BendIntensity;
uniform 	float _BendSpeed;
uniform 	float _BendVariance;
uniform 	float _SideBend;
uniform 	float _Gust;
uniform 	float _GlobalSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TANGENT0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec4 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
float u_xlat8;
bool u_xlatb8;
vec3 u_xlat9;
mediump float u_xlat16_13;
float u_xlat15;
bool u_xlatb15;
float u_xlat21;
float u_xlat22;
void main()
{
    u_xlat0.x = _miHoYo_WindParams1.z + -1.0;
    u_xlat0.x = _GlobalSpeed * u_xlat0.x + 1.0;
    u_xlat7.x = _miHoYo_WindParams1.w * _GlobalSpeed;
    u_xlat0.x = _miHoYo_Wind.w * u_xlat0.x + u_xlat7.x;
    u_xlat7.xyz = in_TANGENT0.xyz * in_TEXCOORD1.yyy;
    u_xlat7.xyz = u_xlat7.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat7.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat7.xxx + u_xlat1.xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat7.zzz + u_xlat1.xyz;
    u_xlat7.xyz = u_xlat7.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.x = dot(u_xlat7.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat1.x = u_xlat1.x * _BendVariance;
    u_xlat0.x = u_xlat0.x * _BendSpeed + u_xlat1.x;
    u_xlat1.x = u_xlat0.x + -0.5;
    u_xlat2 = u_xlat0.xxxx * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat2 = fract(u_xlat2);
    u_xlat2 = u_xlat2 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat2 = fract(u_xlat2);
    u_xlat2 = u_xlat2 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = u_xlat1.xxxx * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat1 = fract(u_xlat1);
    u_xlat1 = u_xlat1 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat1 = fract(u_xlat1);
    u_xlat1 = u_xlat1 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat3 = abs(u_xlat1) * abs(u_xlat1);
    u_xlat1 = -abs(u_xlat1) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat1 = u_xlat3 * u_xlat1 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat1.z = dot(u_xlat1, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y);
#endif
    u_xlat3.xyz = (bool(u_xlatb0)) ? _WindDirection.xyz : _miHoYo_Wind.xyz;
    u_xlat3.w = (-u_xlat3.z);
    u_xlat1.xy = u_xlat3.zx * vec2(-1.0, 1.0);
    u_xlat0.x = dot(u_xlat3.wx, u_xlat1.xy);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat4.xyz = u_xlat0.xxx * u_xlat1.xzy;
    u_xlat5 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat5;
    u_xlat0.xyz = (-u_xlat7.xyz) + u_xlat5.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.w = sqrt(u_xlat0.x);
    u_xlat7.xyz = vec3(u_xlat1.z * u_xlat4.x, u_xlat1.w * u_xlat4.y, u_xlat1.z * u_xlat4.z);
    u_xlat1.xz = u_xlat1.ww;
    u_xlat1.y = _BendIntensity;
    u_xlat7.xyz = u_xlat7.xyz * u_xlat1.xyz;
    u_xlat7.xz = u_xlat7.xz * vec2(vec2(_BendIntensity, _BendIntensity));
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SideBend, _SideBend, _SideBend));
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3 = abs(u_xlat2) * abs(u_xlat2);
    u_xlat2 = -abs(u_xlat2) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat2 = u_xlat3 * u_xlat2 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat22 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat22 = _miHoYo_WindParams1.x * _Gust + u_xlat22;
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_BendIntensity, _BendIntensity, _BendIntensity));
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat5.xyz;
    u_xlat0.xyz = u_xlat7.xyz * vec3(0.00999999978, 0.0, 0.00999999978) + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat5.wwww + u_xlat0;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    u_xlat0.x = u_xlat5.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat0.x) + 2.0;
    u_xlat16_6 = u_xlat0.x * u_xlat16_6;
    u_xlat0.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat2.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = u_xlat5.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = sqrt(u_xlat22);
    u_xlat2.x = u_xlat22 + (-_HeigtFogRamp3.w);
    u_xlat2.x = u_xlat2.x * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat2.xxx * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.x = u_xlat22 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat8 = (-u_xlat1.x) + 2.0;
    u_xlat1.x = u_xlat8 * u_xlat1.x;
    u_xlat8 = u_xlat1.x * _HeigtFogColDelta3.w;
    u_xlat15 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat22>=u_xlat15);
#else
    u_xlatb15 = u_xlat22>=u_xlat15;
#endif
    u_xlat1.x = (u_xlatb15) ? u_xlat8 : u_xlat1.x;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Mihoyo_FogColor3.w;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = min(u_xlat1.x, _HeigtFogColBase3.w);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat8 = u_xlat2.y * _HeigtFogParams3.x;
    u_xlat2.x = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat9.x = u_xlat8 * -1.44269502;
    u_xlat9.x = exp2(u_xlat9.x);
    u_xlat9.x = (-u_xlat9.x) + 1.0;
    u_xlat9.x = u_xlat9.x / u_xlat8;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.00999999978<abs(u_xlat8));
#else
    u_xlatb8 = 0.00999999978<abs(u_xlat8);
#endif
    u_xlat16_6 = (u_xlatb8) ? u_xlat9.x : 1.0;
    u_xlat8 = u_xlat22 * _HeigtFogParams3.y;
    u_xlat16_6 = u_xlat8 * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat8 = u_xlat22 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat16_13 = (-u_xlat8) + 2.0;
    u_xlat16_13 = u_xlat8 * u_xlat16_13;
    u_xlat8 = u_xlat16_13 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat8 = u_xlat8 + 1.0;
    u_xlat16_6 = u_xlat8 * u_xlat16_6;
    u_xlat8 = min(u_xlat16_6, _HeigtFogColBase3.w);
    u_xlat9.x = (-u_xlat8) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat9.xxx;
    u_xlat3.w = u_xlat1.x * u_xlat9.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat8) + u_xlat0.xyz;
    u_xlat16_6 = (-u_xlat21) + 2.0;
    u_xlat16_6 = u_xlat21 * u_xlat16_6;
    u_xlat0.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat9.xyz = (-u_xlat0.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat21 = u_xlat22 + (-_HeigtFogRamp2.w);
    u_xlat21 = u_xlat21 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat9.xyz + u_xlat0.xyz;
    u_xlat21 = u_xlat22 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat1.x = (-u_xlat21) + 2.0;
    u_xlat21 = u_xlat21 * u_xlat1.x;
    u_xlat1.x = u_xlat21 * _HeigtFogColDelta2.w;
    u_xlat21 = (u_xlatb15) ? u_xlat1.x : u_xlat21;
    u_xlat21 = log2(u_xlat21);
    u_xlat21 = u_xlat21 * _Mihoyo_FogColor2.w;
    u_xlat21 = exp2(u_xlat21);
    u_xlat21 = min(u_xlat21, _HeigtFogColBase2.w);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat21 = (-u_xlat21) + 1.0;
    u_xlat1.x = u_xlat2.x * -1.44269502;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x / u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.00999999978<abs(u_xlat2.x));
#else
    u_xlatb8 = 0.00999999978<abs(u_xlat2.x);
#endif
    u_xlat16_6 = (u_xlatb8) ? u_xlat1.x : 1.0;
    u_xlat1.x = u_xlat22 * _HeigtFogParams2.y;
    u_xlat8 = u_xlat22 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat1.x * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat8) + 2.0;
    u_xlat16_13 = u_xlat8 * u_xlat16_13;
    u_xlat1.x = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat16_6 = u_xlat1.x * u_xlat16_6;
    u_xlat1.x = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat8 = (-u_xlat1.x) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat8);
    u_xlat2.w = u_xlat21 * u_xlat8;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat0 = (-u_xlat2) + u_xlat3;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    vs_COLOR1 = u_xlat0;
    vs_TEXCOORD1.xyz = in_TANGENT0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Cutoff;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
int u_xlati6;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = floor(u_xlat16_1.x);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlati6 = int(u_xlat16_1.x);
    if((u_xlati6)==0){discard;}
    u_xlat16_1.xyz = (-u_xlat10_0.xyz) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat10_0.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xyz;
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
uniform 	vec4 _miHoYo_Wind;
uniform 	vec4 _miHoYo_WindParams1;
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _WindDirection;
uniform 	float _BendIntensity;
uniform 	float _BendSpeed;
uniform 	float _BendVariance;
uniform 	float _SideBend;
uniform 	float _Gust;
uniform 	float _GlobalSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TANGENT0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec4 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
float u_xlat8;
bool u_xlatb8;
vec3 u_xlat9;
mediump float u_xlat16_13;
float u_xlat15;
bool u_xlatb15;
float u_xlat21;
float u_xlat22;
void main()
{
    u_xlat0.x = _miHoYo_WindParams1.z + -1.0;
    u_xlat0.x = _GlobalSpeed * u_xlat0.x + 1.0;
    u_xlat7.x = _miHoYo_WindParams1.w * _GlobalSpeed;
    u_xlat0.x = _miHoYo_Wind.w * u_xlat0.x + u_xlat7.x;
    u_xlat7.xyz = in_TANGENT0.xyz * in_TEXCOORD1.yyy;
    u_xlat7.xyz = u_xlat7.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat7.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat7.xxx + u_xlat1.xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat7.zzz + u_xlat1.xyz;
    u_xlat7.xyz = u_xlat7.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.x = dot(u_xlat7.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat1.x = u_xlat1.x * _BendVariance;
    u_xlat0.x = u_xlat0.x * _BendSpeed + u_xlat1.x;
    u_xlat1.x = u_xlat0.x + -0.5;
    u_xlat2 = u_xlat0.xxxx * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat2 = fract(u_xlat2);
    u_xlat2 = u_xlat2 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat2 = fract(u_xlat2);
    u_xlat2 = u_xlat2 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = u_xlat1.xxxx * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat1 = fract(u_xlat1);
    u_xlat1 = u_xlat1 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat1 = fract(u_xlat1);
    u_xlat1 = u_xlat1 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat3 = abs(u_xlat1) * abs(u_xlat1);
    u_xlat1 = -abs(u_xlat1) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat1 = u_xlat3 * u_xlat1 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat1.z = dot(u_xlat1, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y);
#endif
    u_xlat3.xyz = (bool(u_xlatb0)) ? _WindDirection.xyz : _miHoYo_Wind.xyz;
    u_xlat3.w = (-u_xlat3.z);
    u_xlat1.xy = u_xlat3.zx * vec2(-1.0, 1.0);
    u_xlat0.x = dot(u_xlat3.wx, u_xlat1.xy);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat4.xyz = u_xlat0.xxx * u_xlat1.xzy;
    u_xlat5 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat5;
    u_xlat0.xyz = (-u_xlat7.xyz) + u_xlat5.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.w = sqrt(u_xlat0.x);
    u_xlat7.xyz = vec3(u_xlat1.z * u_xlat4.x, u_xlat1.w * u_xlat4.y, u_xlat1.z * u_xlat4.z);
    u_xlat1.xz = u_xlat1.ww;
    u_xlat1.y = _BendIntensity;
    u_xlat7.xyz = u_xlat7.xyz * u_xlat1.xyz;
    u_xlat7.xz = u_xlat7.xz * vec2(vec2(_BendIntensity, _BendIntensity));
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SideBend, _SideBend, _SideBend));
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3 = abs(u_xlat2) * abs(u_xlat2);
    u_xlat2 = -abs(u_xlat2) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat2 = u_xlat3 * u_xlat2 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat22 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat22 = _miHoYo_WindParams1.x * _Gust + u_xlat22;
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_BendIntensity, _BendIntensity, _BendIntensity));
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat5.xyz;
    u_xlat0.xyz = u_xlat7.xyz * vec3(0.00999999978, 0.0, 0.00999999978) + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat5.wwww + u_xlat0;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    u_xlat0.x = u_xlat5.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat0.x) + 2.0;
    u_xlat16_6 = u_xlat0.x * u_xlat16_6;
    u_xlat0.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat2.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = u_xlat5.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = sqrt(u_xlat22);
    u_xlat2.x = u_xlat22 + (-_HeigtFogRamp3.w);
    u_xlat2.x = u_xlat2.x * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat2.xxx * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.x = u_xlat22 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat8 = (-u_xlat1.x) + 2.0;
    u_xlat1.x = u_xlat8 * u_xlat1.x;
    u_xlat8 = u_xlat1.x * _HeigtFogColDelta3.w;
    u_xlat15 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat22>=u_xlat15);
#else
    u_xlatb15 = u_xlat22>=u_xlat15;
#endif
    u_xlat1.x = (u_xlatb15) ? u_xlat8 : u_xlat1.x;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Mihoyo_FogColor3.w;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = min(u_xlat1.x, _HeigtFogColBase3.w);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat8 = u_xlat2.y * _HeigtFogParams3.x;
    u_xlat2.x = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat9.x = u_xlat8 * -1.44269502;
    u_xlat9.x = exp2(u_xlat9.x);
    u_xlat9.x = (-u_xlat9.x) + 1.0;
    u_xlat9.x = u_xlat9.x / u_xlat8;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.00999999978<abs(u_xlat8));
#else
    u_xlatb8 = 0.00999999978<abs(u_xlat8);
#endif
    u_xlat16_6 = (u_xlatb8) ? u_xlat9.x : 1.0;
    u_xlat8 = u_xlat22 * _HeigtFogParams3.y;
    u_xlat16_6 = u_xlat8 * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat8 = u_xlat22 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat16_13 = (-u_xlat8) + 2.0;
    u_xlat16_13 = u_xlat8 * u_xlat16_13;
    u_xlat8 = u_xlat16_13 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat8 = u_xlat8 + 1.0;
    u_xlat16_6 = u_xlat8 * u_xlat16_6;
    u_xlat8 = min(u_xlat16_6, _HeigtFogColBase3.w);
    u_xlat9.x = (-u_xlat8) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat9.xxx;
    u_xlat3.w = u_xlat1.x * u_xlat9.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat8) + u_xlat0.xyz;
    u_xlat16_6 = (-u_xlat21) + 2.0;
    u_xlat16_6 = u_xlat21 * u_xlat16_6;
    u_xlat0.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat9.xyz = (-u_xlat0.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat21 = u_xlat22 + (-_HeigtFogRamp2.w);
    u_xlat21 = u_xlat21 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat9.xyz + u_xlat0.xyz;
    u_xlat21 = u_xlat22 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat1.x = (-u_xlat21) + 2.0;
    u_xlat21 = u_xlat21 * u_xlat1.x;
    u_xlat1.x = u_xlat21 * _HeigtFogColDelta2.w;
    u_xlat21 = (u_xlatb15) ? u_xlat1.x : u_xlat21;
    u_xlat21 = log2(u_xlat21);
    u_xlat21 = u_xlat21 * _Mihoyo_FogColor2.w;
    u_xlat21 = exp2(u_xlat21);
    u_xlat21 = min(u_xlat21, _HeigtFogColBase2.w);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat21 = (-u_xlat21) + 1.0;
    u_xlat1.x = u_xlat2.x * -1.44269502;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x / u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.00999999978<abs(u_xlat2.x));
#else
    u_xlatb8 = 0.00999999978<abs(u_xlat2.x);
#endif
    u_xlat16_6 = (u_xlatb8) ? u_xlat1.x : 1.0;
    u_xlat1.x = u_xlat22 * _HeigtFogParams2.y;
    u_xlat8 = u_xlat22 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat1.x * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat8) + 2.0;
    u_xlat16_13 = u_xlat8 * u_xlat16_13;
    u_xlat1.x = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat16_6 = u_xlat1.x * u_xlat16_6;
    u_xlat1.x = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat8 = (-u_xlat1.x) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat8);
    u_xlat2.w = u_xlat21 * u_xlat8;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat0 = (-u_xlat2) + u_xlat3;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    vs_COLOR1 = u_xlat0;
    vs_TEXCOORD1.xyz = in_TANGENT0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Cutoff;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
int u_xlati6;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = floor(u_xlat16_1.x);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlati6 = int(u_xlat16_1.x);
    if((u_xlati6)==0){discard;}
    u_xlat16_1.xyz = (-u_xlat10_0.xyz) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat10_0.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xyz;
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
uniform 	vec4 _miHoYo_Wind;
uniform 	vec4 _miHoYo_WindParams1;
uniform 	vec4 _MainTex_ST;
uniform 	vec3 _WindDirection;
uniform 	float _BendIntensity;
uniform 	float _BendSpeed;
uniform 	float _BendVariance;
uniform 	float _SideBend;
uniform 	float _Gust;
uniform 	float _GlobalSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TANGENT0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec4 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
float u_xlat8;
bool u_xlatb8;
vec3 u_xlat9;
mediump float u_xlat16_13;
float u_xlat15;
bool u_xlatb15;
float u_xlat21;
float u_xlat22;
void main()
{
    u_xlat0.x = _miHoYo_WindParams1.z + -1.0;
    u_xlat0.x = _GlobalSpeed * u_xlat0.x + 1.0;
    u_xlat7.x = _miHoYo_WindParams1.w * _GlobalSpeed;
    u_xlat0.x = _miHoYo_Wind.w * u_xlat0.x + u_xlat7.x;
    u_xlat7.xyz = in_TANGENT0.xyz * in_TEXCOORD1.yyy;
    u_xlat7.xyz = u_xlat7.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat7.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat7.xxx + u_xlat1.xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat7.zzz + u_xlat1.xyz;
    u_xlat7.xyz = u_xlat7.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.x = dot(u_xlat7.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat1.x = u_xlat1.x * _BendVariance;
    u_xlat0.x = u_xlat0.x * _BendSpeed + u_xlat1.x;
    u_xlat1.x = u_xlat0.x + -0.5;
    u_xlat2 = u_xlat0.xxxx * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat2 = fract(u_xlat2);
    u_xlat2 = u_xlat2 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat2 = fract(u_xlat2);
    u_xlat2 = u_xlat2 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = u_xlat1.xxxx * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat1 = fract(u_xlat1);
    u_xlat1 = u_xlat1 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat1 = fract(u_xlat1);
    u_xlat1 = u_xlat1 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat3 = abs(u_xlat1) * abs(u_xlat1);
    u_xlat1 = -abs(u_xlat1) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat1 = u_xlat3 * u_xlat1 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat1.z = dot(u_xlat1, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_miHoYo_WindParams1.y);
#endif
    u_xlat3.xyz = (bool(u_xlatb0)) ? _WindDirection.xyz : _miHoYo_Wind.xyz;
    u_xlat3.w = (-u_xlat3.z);
    u_xlat1.xy = u_xlat3.zx * vec2(-1.0, 1.0);
    u_xlat0.x = dot(u_xlat3.wx, u_xlat1.xy);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat4.xyz = u_xlat0.xxx * u_xlat1.xzy;
    u_xlat5 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat5;
    u_xlat0.xyz = (-u_xlat7.xyz) + u_xlat5.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.w = sqrt(u_xlat0.x);
    u_xlat7.xyz = vec3(u_xlat1.z * u_xlat4.x, u_xlat1.w * u_xlat4.y, u_xlat1.z * u_xlat4.z);
    u_xlat1.xz = u_xlat1.ww;
    u_xlat1.y = _BendIntensity;
    u_xlat7.xyz = u_xlat7.xyz * u_xlat1.xyz;
    u_xlat7.xz = u_xlat7.xz * vec2(vec2(_BendIntensity, _BendIntensity));
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SideBend, _SideBend, _SideBend));
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3 = abs(u_xlat2) * abs(u_xlat2);
    u_xlat2 = -abs(u_xlat2) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat2 = u_xlat3 * u_xlat2 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat22 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat22 = _miHoYo_WindParams1.x * _Gust + u_xlat22;
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_BendIntensity, _BendIntensity, _BendIntensity));
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat5.xyz;
    u_xlat0.xyz = u_xlat7.xyz * vec3(0.00999999978, 0.0, 0.00999999978) + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat5.wwww + u_xlat0;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    u_xlat0.x = u_xlat5.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat0.x) + 2.0;
    u_xlat16_6 = u_xlat0.x * u_xlat16_6;
    u_xlat0.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat2.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = u_xlat5.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = sqrt(u_xlat22);
    u_xlat2.x = u_xlat22 + (-_HeigtFogRamp3.w);
    u_xlat2.x = u_xlat2.x * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat2.xxx * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.x = u_xlat22 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat8 = (-u_xlat1.x) + 2.0;
    u_xlat1.x = u_xlat8 * u_xlat1.x;
    u_xlat8 = u_xlat1.x * _HeigtFogColDelta3.w;
    u_xlat15 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat22>=u_xlat15);
#else
    u_xlatb15 = u_xlat22>=u_xlat15;
#endif
    u_xlat1.x = (u_xlatb15) ? u_xlat8 : u_xlat1.x;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Mihoyo_FogColor3.w;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = min(u_xlat1.x, _HeigtFogColBase3.w);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat8 = u_xlat2.y * _HeigtFogParams3.x;
    u_xlat2.x = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat9.x = u_xlat8 * -1.44269502;
    u_xlat9.x = exp2(u_xlat9.x);
    u_xlat9.x = (-u_xlat9.x) + 1.0;
    u_xlat9.x = u_xlat9.x / u_xlat8;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.00999999978<abs(u_xlat8));
#else
    u_xlatb8 = 0.00999999978<abs(u_xlat8);
#endif
    u_xlat16_6 = (u_xlatb8) ? u_xlat9.x : 1.0;
    u_xlat8 = u_xlat22 * _HeigtFogParams3.y;
    u_xlat16_6 = u_xlat8 * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat8 = u_xlat22 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat16_13 = (-u_xlat8) + 2.0;
    u_xlat16_13 = u_xlat8 * u_xlat16_13;
    u_xlat8 = u_xlat16_13 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat8 = u_xlat8 + 1.0;
    u_xlat16_6 = u_xlat8 * u_xlat16_6;
    u_xlat8 = min(u_xlat16_6, _HeigtFogColBase3.w);
    u_xlat9.x = (-u_xlat8) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat9.xxx;
    u_xlat3.w = u_xlat1.x * u_xlat9.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat8) + u_xlat0.xyz;
    u_xlat16_6 = (-u_xlat21) + 2.0;
    u_xlat16_6 = u_xlat21 * u_xlat16_6;
    u_xlat0.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat9.xyz = (-u_xlat0.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat21 = u_xlat22 + (-_HeigtFogRamp2.w);
    u_xlat21 = u_xlat21 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat9.xyz + u_xlat0.xyz;
    u_xlat21 = u_xlat22 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat1.x = (-u_xlat21) + 2.0;
    u_xlat21 = u_xlat21 * u_xlat1.x;
    u_xlat1.x = u_xlat21 * _HeigtFogColDelta2.w;
    u_xlat21 = (u_xlatb15) ? u_xlat1.x : u_xlat21;
    u_xlat21 = log2(u_xlat21);
    u_xlat21 = u_xlat21 * _Mihoyo_FogColor2.w;
    u_xlat21 = exp2(u_xlat21);
    u_xlat21 = min(u_xlat21, _HeigtFogColBase2.w);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat21 = (-u_xlat21) + 1.0;
    u_xlat1.x = u_xlat2.x * -1.44269502;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x / u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.00999999978<abs(u_xlat2.x));
#else
    u_xlatb8 = 0.00999999978<abs(u_xlat2.x);
#endif
    u_xlat16_6 = (u_xlatb8) ? u_xlat1.x : 1.0;
    u_xlat1.x = u_xlat22 * _HeigtFogParams2.y;
    u_xlat8 = u_xlat22 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat1.x * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat8) + 2.0;
    u_xlat16_13 = u_xlat8 * u_xlat16_13;
    u_xlat1.x = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat16_6 = u_xlat1.x * u_xlat16_6;
    u_xlat1.x = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat8 = (-u_xlat1.x) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat8);
    u_xlat2.w = u_xlat21 * u_xlat8;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat0 = (-u_xlat2) + u_xlat3;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    vs_COLOR1 = u_xlat0;
    vs_TEXCOORD1.xyz = in_TANGENT0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Cutoff;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
int u_xlati6;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = floor(u_xlat16_1.x);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlati6 = int(u_xlat16_1.x);
    if((u_xlati6)==0){discard;}
    u_xlat16_1.xyz = (-u_xlat10_0.xyz) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat10_0.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xyz;
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
}
}
}
}